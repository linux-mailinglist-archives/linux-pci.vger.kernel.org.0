Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774251EDD5
	for <lists+linux-pci@lfdr.de>; Sun,  8 May 2022 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiEHNkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 May 2022 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiEHNkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 May 2022 09:40:20 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D3B1FF
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 06:36:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id F1FD710315739;
        Sun,  8 May 2022 15:36:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B477C2A2F94; Sun,  8 May 2022 15:36:24 +0200 (CEST)
Date:   Sun, 8 May 2022 15:36:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Simplify Command Completion checking
Message-ID: <20220508133624.GB27352@wunner.de>
References: <20220210233806.663609-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210233806.663609-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:06PM -0600, Bjorn Helgaas wrote:
> If a device sets the No Command Completed Support bit in the Slot
> Capabilities register (PCIe r6.0, sec 7.5.3.9), it does not generate
> software notifications when a command is completed, and software can
> write all fields of the Slot Control register without any delays.
> 
> Since we only need to wait for command completion on devices that do *not*
> set the No Command Completed Support bit, there's no need to even set the
> ctrl->cmd_busy bit that tracks when the device is busy handling a command.
> 
> Set the ctrl->cmd_busy bit only when we need to wait for a command to
> complete.  This shouldn't make much functional difference, but does avoid
> an smp_mb() for controllers that set PCI_EXP_SLTCAP_NCCS.
[...]
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -114,13 +114,6 @@ static void pcie_wait_cmd(struct controller *ctrl)
>  	unsigned long now, timeout;
>  	int rc;
>  
> -	/*
> -	 * If the controller does not generate notifications for command
> -	 * completions, we never need to wait between writes.
> -	 */
> -	if (NO_CMD_CMPL(ctrl))
> -		return;
> -
>  	if (!ctrl->cmd_busy)
>  		return;
>  
> @@ -173,8 +166,17 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	slot_ctrl_orig = slot_ctrl;
>  	slot_ctrl &= ~mask;
>  	slot_ctrl |= (cmd & mask);
> -	ctrl->cmd_busy = 1;
> -	smp_mb();
> +
> +	/*
> +	 * If controller generates Command Completed events, we must wait
> +	 * for it to finish one command before sending another, so we need
> +	 * to keep track of when the controller is busy.
> +	 */
> +	if (!NO_CMD_CMPL(ctrl)) {
> +		ctrl->cmd_busy = 1;
> +		smp_mb();
> +	}
> +
>  	ctrl->slot_ctrl = slot_ctrl;
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>  	ctrl->cmd_started = jiffies;

Looks good in principle, however ctrl->cmd_busy is set to 1 in two
other places, namely pciehp_resume_noirq() and pciehp_runtime_resume()
in pciehp_core.c.  Those two need to be amended as well.

Note that a few lines after the hunk above, the ctrl->cmd_busy flag
is reverted back to 0 on certain controllers:

	if (pdev->broken_cmd_compl &&
	    (slot_ctrl_orig & CC_ERRATUM_MASK) == (slot_ctrl & CC_ERRATUM_MASK))
		ctrl->cmd_busy = 0;

That could be combined with your "if (!NO_CMD_CMPL(ctrl))" check:
Basically, "set cmd_busy to 1 if the controller supports Command
Completed events and it's not affected by this erratum".

Perhaps it makes sense to put that in a pciehp_has_command_completion()
helper (or whatever name you prefer), which could then also be called
from pciehp_resume_noirq() / pciehp_runtime_resume().

Thanks (and sorry for the delay),

Lukas

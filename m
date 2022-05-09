Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AC51F338
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiEIEML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 00:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiEIEFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 00:05:35 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9028233E81
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 21:01:41 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6A2A628004991;
        Mon,  9 May 2022 06:01:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5ACB711A86B; Mon,  9 May 2022 06:01:39 +0200 (CEST)
Date:   Mon, 9 May 2022 06:01:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 07/18] PCI: pciehp: Enable Command Completed Interrupt
 only if supported
Message-ID: <20220509040139.GB26780@wunner.de>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-8-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-8-kabel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:35PM +0100, Marek Behún wrote:
> The No Command Completed Support bit in the Slot Capabilities register
> indicates whether Command Completed Interrupt Enable is unsupported.
> 
> Enable this interrupt only in the case it is supported.
[...]
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -817,7 +817,9 @@ static void pcie_enable_notification(struct controller *ctrl)
>  	else
>  		cmd |= PCI_EXP_SLTCTL_PDCE;
>  	if (!pciehp_poll_mode)
> -		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> +		cmd |= PCI_EXP_SLTCTL_HPIE;
> +	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
> +		cmd |= PCI_EXP_SLTCTL_CCIE;

Looks okay to me in principle, I'm just wondering why this change is
necessary, i.e. what issue are you seeing without it?

Thanks,

Lukas

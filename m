Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B337695289
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 22:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBMVBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 16:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMVBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 16:01:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375243AB0;
        Mon, 13 Feb 2023 13:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 022B8B81911;
        Mon, 13 Feb 2023 21:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD40C433EF;
        Mon, 13 Feb 2023 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322073;
        bh=5MqS5RTEwW+4Qr5cCbquw4TijsrCu5qtPLMpuBa7Lw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SGJxfPSOGN1UlHCeyzER4fKGZYPmn+Af6MYtiQbNTgvLQTgycv57NddftX6lIEYRt
         /7/GS+XQahaPX+GvmfC4Vh1OEvq5uL7PC5JQwO0NExEMe00YDmhQgPwLlsQul/CKZU
         20/q0vKby3mqE0aAvlj+PHdY1Jx5Zaqcn2KZh1ECeXA4TewpVFw/x0/TmWinn7iFJI
         r9H67nn7x+Uz8+fOSASL5cL/g0/j4/WHs5QD4FAiQPVqe0Sts1ws3gGcWOKM8BNlhC
         20xQilgYua93tZbMgvIYHlyyFNFqZhkjyzUutXaAHg7VOK/C9tyumvre331NvcQHJU
         Qnin/4kJm6vJA==
Date:   Mon, 13 Feb 2023 15:01:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        steev@kali.org
Subject: Re: [PATCH] PCI: pciehp: Add Qualcomm quirk for Command Completed
 erratum
Message-ID: <20230213210112.GA2931136@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213144922.89982-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 13, 2023 at 08:19:22PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm PCI bridge device (Device ID 0x010e) found in chipsets such as
> SC8280XP used in Lenovo Thinkpad X13s, does not set the Command Completed
> bit unless writes to the Slot Command register change "Control" bits.
> 
> This results in timeouts like below during boot and resume from suspend:
> 
>     pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
>     ...
>     pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x13f1 (issued 107724 msec ago)
> 
> Add the device to the Command Completed quirk to mark commands "completed"
> immediately unless they change the "Control" bits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/hotplug for v6.3, thanks!

> ---
> 
> Bjorn, during the review of a similar patch adding the quirk for device id
> 0x0110, you asked me whether we should mark all Qcom bridge devices as
> quirky like Intel bridges. I tried asking this question to Qualcomm but
> found no answer yet. So I just went with adding one more entry.
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 10e9670eea0b..f8c70115b691 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1088,6 +1088,8 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x010e,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0110,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
> -- 
> 2.25.1
> 

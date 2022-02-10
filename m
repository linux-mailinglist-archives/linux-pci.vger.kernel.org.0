Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E94B18CC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 23:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiBJWte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 17:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiBJWte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 17:49:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD9B73;
        Thu, 10 Feb 2022 14:49:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4428B8278B;
        Thu, 10 Feb 2022 22:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D0FC004E1;
        Thu, 10 Feb 2022 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644533372;
        bh=GPGb2/FGNW/119aDp4VcMd34PF0JA9+vm/aklBbSvAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mUB2ocgwizYZKem4vP59/xlzbdO0oYSbU2MM2RHh38FZj2/xwx2XwF5/BXlqOmeOq
         OAlNrC+bUpyYjH2BoLbLr/ZDa1fEAKL2acht8VNkMEGK6PI/9SE0sHrs099tXlR1r8
         PvOhUIOkwuzam+Bg7YeqSO2YIShLJKC0YsfsjPYSFBPFroUsax0tep0mWoD6kUqo3P
         JUMSiXvH/5QuHvQ7DIsAg1u+A+wSqSA6qrwqs47082U1bXmpG0YRXrMKYd8hvm3HBm
         fU/tTVGIf3hC5IpxwK7VR8s4vmKiXtkr8xg1ozs9VJl+ZeGe1z2CnjArhafSfPabz0
         uxUeRZ+vqntXA==
Date:   Thu, 10 Feb 2022 16:49:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Add Qualcomm bridge (0x0110) to the command
 completed quirk
Message-ID: <20220210224930.GA660547@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210145003.135907-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 08:20:03PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm PCI bridge device (0x0110) found in chipsets such as SM8450
> does not set the command completed bit unless writes to the Slot Command
> register change "Control" bits.
> 
> This results in timeouts like below:
> 
> pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> 
> Hence, add the device to the command completed quirk to mark commands
> "completed" immediately unless they change the "Control" bits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/hotplug for v5.18, thanks!

Should we assume that this erratum will be fixed in future Qualcomm
devices?  Or should we apply the quirk for all Qualcomm hotplug
bridges, as we do for Intel?

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1c1ebf3dad43..4e4ccf3afbe3 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1084,6 +1084,8 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0110,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
> -- 
> 2.25.1
> 

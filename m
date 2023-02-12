Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0669394F
	for <lists+linux-pci@lfdr.de>; Sun, 12 Feb 2023 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBLSO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 13:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLSO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 13:14:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA663EC78;
        Sun, 12 Feb 2023 10:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E094B80CBF;
        Sun, 12 Feb 2023 18:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C849C433EF;
        Sun, 12 Feb 2023 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676225692;
        bh=g2hj6yVDD8uoblbDvFHhMRP5C7zplliupHqPWVTkdCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+9l5hbe3PASOutKXfe4W4Ebqp4xzZcnq+fyiLSwVRIioWl23shK+8cXMOfOZXuTV
         1AiiFNqjDFraCecBM0PcnSMjJ131dR53QWsTN/CjbGfiPztUcMkuWw6k0Q4VzVKyiE
         k8nDFVHz5g6Ffz+6w2Cers6gc6IVacZguUZ5fQEok9jQIqYmSG+t1vH0bck2Haid3J
         CYKX+ARNUqRXAwnBD2Qvs1thfpDRscr4Cpm1vYYhTGShkR/tks25tg4ZOFr/dRSoyR
         +8HL+K3Zyqfua+/IOq5z6D3MeALm6nZS0xmCUlo4QY/gJhKb1QNwWHlHJdiuGPxjwq
         ybQvOI1JKxDKw==
Date:   Sun, 12 Feb 2023 20:14:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+ksmNWJdWNkGAU9@unreal>
References: <20230208184321.867666-1-gankulkarni@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208184321.867666-1-gankulkarni@os.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> As per PCIe specification(section 10.5), If a VF implements an
> ATS capability, its associated PF must implement an ATS capability.
> The ATS Capabilities in VFs and their associated PFs are permitted to
> be enabled independently.
> Also, it states that the Smallest Translation Unit (STU) for VFs must be
> hardwired to Zero and the associated PF's value applies to VFs STU.
> 
> The current code allows to enable ATS on VFs only if it is already
> enabled on associated PF, which is not necessary as per the specification.
> 
> It is only required to have valid STU programmed on PF to enable
> ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> when PFs ATS is not enabled.

Can you please add here quotes from the spec and its version? I don't see
anything like this in my version of PCIe specification.

Thanks

> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  drivers/pci/ats.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..a97ec67201d1 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	if (ps < PCI_ATS_MIN_STU)
>  		return -EINVAL;
>  
> -	/*
> -	 * Note that enabling ATS on a VF fails unless it's already enabled
> -	 * with the same STU on the PF.
> -	 */
>  	ctrl = PCI_ATS_CTRL_ENABLE;
>  	if (dev->is_virtfn) {
>  		pdev = pci_physfn(dev);
> +
> +		if (!pdev->ats_enabled &&
> +				(pdev->ats_stu < PCI_ATS_MIN_STU)) {
> +			u16 ctrl2;
> +
> +			/* Associated PF's STU value applies to VFs. */
> +			pdev->ats_stu = ps;
> +			ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - PCI_ATS_MIN_STU);
> +			pci_write_config_word(pdev, pdev->ats_cap + PCI_ATS_CTRL, ctrl2);
> +		}
> +
>  		if (pdev->ats_stu != ps)
>  			return -EINVAL;
>  	} else {
> -- 
> 2.39.1
> 

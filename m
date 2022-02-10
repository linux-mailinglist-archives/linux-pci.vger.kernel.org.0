Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5544B18D8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 23:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbiBJWxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 17:53:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBJWxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 17:53:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7724273D;
        Thu, 10 Feb 2022 14:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99A88B827BB;
        Thu, 10 Feb 2022 22:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B51C004E1;
        Thu, 10 Feb 2022 22:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644533623;
        bh=UWJBiNM1e5s58iDH2kQaRabS4o2/BGSKcudejnGvHQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VDZo6yYpPCxmhgs6YUPFLdHvi098Th/D3Ymqa8EINDqYnQlW95gQ6SO/Q9thIFq5d
         SxvDEbxk5fyL2SZ83hYI7MbQjeVRQuwk6BnF54zBYjS7qnLWqZbxRUkj7jgSnosgiR
         2GwWUkT2kryjvw/RBswjYYewFbrCDFnyL4i3CC3TKDzTEKQ1Lp+nEmxhTQtc0Gsshx
         i7hPh9C7+6+7mcfaTL4qomDyvcX3ftk3koGthf7AwWShnTCKkoEUZgSfPpMbxhH83d
         mdO9oHdrhiCxWBsPhw2C161hWN/nYM7wraxNs7Bf7iI2htlbQVqOxrX2clWzFKQUZm
         GBAGyiN4t7tbw==
Date:   Thu, 10 Feb 2022 16:53:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc:     "okaya@kernel.org" <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Message-ID: <20220210225341.GA660963@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4a41788f0d4b1c8388ebfb4d5abea4@HXTBJIDCEMVIW01.hxtcorp.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 12:52:29AM +0000, Yang, Shunyong wrote:
> Hi, Bjorn,
> 
> Thank you for reminding me. I will check with our IC team for these
> design issues.
> Sorry for the delay as I was taking Chinese New Year holiday.

Hi, happened to apply a new similar quirk for Qualcomm today, so just
checking in to see whether there are any new HXT devices that also
require this quirk, or whether we should apply the quirk for *all* HXT
devices as we do for Intel.

Bjorn

> On 2019/2/2 7:19, Bjorn Helgaas wrote:
> > On Wed, Nov 07, 2018 at 03:24:12PM +0800, Shunyong Yang wrote:
> >> Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
> >> design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
> >> pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.
> >>
> >> cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> >> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> >> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > 
> > I applied both of these to pci/misc for v5.1, thanks!
> > 
> > As I'm sure you know, both the ACS and the pciehp issues are cases where
> > the part does not conform to the PCIe spec.  Hopefully future parts will
> > change the design so they *do* conform to the spec so we don't have to add
> > quirks for every new part.  Adding quirks works around the problem, but
> > it's a hassle for customers (and developers and distributors) because they
> > need kernel updates when they wouldn't otherwise.
> > 
> > Bjorn
> > 
> >> ---
> >> v2:
> >>   Add Reviewed-by: Sinan Kaya.
> >>
> >> v1:
> >>   Initial version.
> >> ---
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 4700d24e5d55..1e00ef6a88f4 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -4495,6 +4495,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
> >>  	/* QCOM QDF2xxx root ports */
> >>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
> >>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> >> +	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
> >> +	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
> >>  	/* Intel PCH root ports */
> >>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
> >>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
> >> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >> index 69f0abe1ba1a..e60a6bc38298 100644
> >> --- a/include/linux/pci_ids.h
> >> +++ b/include/linux/pci_ids.h
> >> @@ -2565,6 +2565,8 @@
> >>  
> >>  #define PCI_VENDOR_ID_HYGON		0x1d94
> >>  
> >> +#define PCI_VENDOR_ID_HXT		0x1dbf
> >> +
> >>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> >>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> >>  
> >> -- 
> >> 1.8.3.1
> >>
> > 
> 

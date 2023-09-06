Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E179438D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjIFTGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIFTGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:06:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F161B7
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 12:06:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA42BC433C7;
        Wed,  6 Sep 2023 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694027186;
        bh=sKV4K8jZ7ZZS/G3QzzJscICwzJXJtX/pQ1RQD+dXKh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jq2aXMExvjRMqe0vTlYY17RabqbUCTEBls2TVxzUKZAzv0ScO6KzspYr4d9rVyhx1
         HCS1PIXseeMrApqtMizZir/ugSqQsoROajcL/PEn/XAlAOYfjbJq9dSdHTiLUfD8W5
         MQAK4HScw2qaKIGxZ8gBdfyZHP7JxyBfgt/dT0uU5j7uHV2/lIbLWuaGtqEGOIwXHh
         gwKBMB0u0GuGoooV0jTpFVd5ouHw4ZcgazhKqzj7g8R1AJJvoYjLtLROwrl+w0d+jX
         M/pE+QubqdTAPT/lm1DLL68vpw6pkRGx/oE4DhTR0Uo8ZCgSLSA2lFC2hyCldX+A5t
         9//upU4rVbrMA==
Date:   Wed, 6 Sep 2023 14:06:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Sheena Mohan <sheenamo@google.com>,
        Aahil Awatramani <aahila@google.com>,
        Justin Tai <justai@google.com>, andriy.shevchenko@intel.com,
        joel.a.gibson@intel.com, emil.s.tantilov@intel.com,
        gaurav.s.emmanuel@intel.com, mike.conover@intel.com,
        shaopeng.he@intel.com, anthony.l.nguyen@intel.com,
        pavan.kumar.linga@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Message-ID: <20230906190623.GA234852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816172115.1375716-3-bartosz.pawlowski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
> There is a HW issue in A and B steppings of Intel IPU E2000 that it
> expects wrong endianness in ATS invalidation message body. This problem
> can lead to outdated translations being returned as valid and finally
> cause system instability.

Is there a published erratum for this?  Or at least a number to
identify it?

> In order to prevent such issues introduce quirk_intel_e2000_no_ats()
> function to disable ATS for vulnerable IPU E2000 devices.
> 
> Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/pci/quirks.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a900546d8d45..9aa1e0148ed2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5550,6 +5550,28 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
>  /* AMD Raven platform iGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
> +
> +/*
> + * Intel IPU E2000 revisions before C0 implement incorrect endianness
> + * in ATS Invalidate Request message body. Although there is existing software
> + * workaround for this issue, it is not functionally complete (no 5-lvl paging
> + * support) and it requires changes in all IOMMU implementations supporting
> + * ATS. Therefore, disabling ATS seems to be more reasonable.

Can we reference the commit that added the existing software
workaround?

It sounds like systems that (a) don't require 5-level paging and (b)
use an IOMMU implementation that include the appropriate changes might
still be able to use ATS?  Is there a way for them to do that?

> + */
> +static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
> +{
> +	if (pdev->revision < 0x20)
> +		quirk_no_ats(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> -- 
> 2.41.0
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 

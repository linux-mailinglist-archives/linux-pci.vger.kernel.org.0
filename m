Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2834839C1C6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFDVBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 17:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFDVBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 17:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F313A61404;
        Fri,  4 Jun 2021 20:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622840356;
        bh=JPQiVcD9/Kraxh6rc5CDsi67Y+HVF9LvHrvJzJd0Iik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NgM3ttWanxkOLy50ukqkCBrYueU6suFIpQSalB4z8oOEvhOuKDakzMy7Itrvyb99x
         HhWneehq80feCbKn6EVsd590AFvY1FHX6CBJy+nn+Orf7Q3zqdNou+UnxNa4CXncsc
         1ow6zRDHbJPy04YbHixbNfAAD9zUQFIUyHn19dMiGF6vTG1WoFNh9gJRqZqjfxTTWK
         lzLolcSdd/cawYNiJW8FZOR3JPoo5TIMPT8vhWVp4vxEJAElFQjizBNTkktIyYBTyH
         PAdHFER/3i5DTYNHIRRqJI82VvLbCUZwXgCwBQ0mNhKZ62yDjWwBGinJL0m8C1M2qP
         8Gs8bUbjLoReQ==
Date:   Fri, 4 Jun 2021 15:59:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Evan Quan <evan.quan@amd.com>
Cc:     linux-pci@vger.kernel.org, kw@linux.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS support
Message-ID: <20210604205914.GA2239197@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602021255.939090-1-evan.quan@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 10:12:55AM +0800, Evan Quan wrote:
> Unexpected GPU hang was observed during runpm stress test
> on 0x7341 rev 0x00. Further debugging shows broken ATS is
> related. Thus as a followup of commit 5e89cd303e3a ("PCI:
> Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable
> the ATS for the specific SKU also.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/virtualization for v5.14, thanks.

I updated the commit log like this:

    PCI: Mark AMD Navi14 GPU ATS as broken

    Observed unexpected GPU hang during runpm stress test on 0x7341 rev 0x00.
    Further debugging shows broken ATS is related.

    Disable ATS on this part.  Similar issues on other devices:

      a2da5d8cc0b0 ("PCI: Mark AMD Raven iGPU ATS as broken in some platforms")
      45beb31d3afb ("PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken")
      5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")

    Suggested-by: Alex Deucher <alexander.deucher@amd.com>
    Link: https://lore.kernel.org/r/20210602021255.939090-1-evan.quan@amd.com
    Signed-off-by: Evan Quan <evan.quan@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

> ---
> ChangeLog v2->v3:
> - further update for description part(suggested by Krzysztof)
> ChangeLog v1->v2:
> - cosmetic fix for description part(suggested by Krzysztof)
> ---
>  drivers/pci/quirks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b7e19bbb901a..70803ad6d2ac 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5176,7 +5176,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
>  	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> -	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
> +	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
> +	    (pdev->device == 0x7341 && pdev->revision != 0x00))
>  		return;
>  
>  	if (pdev->device == 0x15d8) {
> @@ -5203,6 +5204,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
>  /* AMD Raven platform iGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
> -- 
> 2.29.0
> 

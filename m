Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA541B571
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhI1R4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbhI1R4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 13:56:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CD4C06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so2264769pjv.5
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
        b=m9sdz73zrjMRDNHc22Gye23uo5ygGPs1cs0mwoNlJ8VUnRLj8voa2vDhgXj2bS9aj2
         aFhf//KoZX796AfWAxpvTXYans8OImGiqCnRmi3Sk6Ml+QvEusKyfBHiXH1VyjA/4sAj
         UeJfSWxx/AfUAAGtCDiw7qNfVTwlszxzNkutU2boB4mHGNl+IVnbL6EhEyS0Cbiztu0L
         JVqp+cBc6JyoHQsLuIcU0LZ6aCx3k+4ofEprD7f3HduGu0V2uJP+PxCitVTzo0PLQ7RZ
         AxHnDX37k0hreucdd5P9XUEzif8rbactBU8SMjoIo1axW/j7y7ez4LhcbOiIdS/8XM3N
         3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
        b=WrOgl82DXgAdRlbTPaXfYL0XYwmZdiSOTW0C3yG1ezQBf5g8KofTJUU7uhMj2YPxy4
         jXubiI0tx964//o2wlHfH3ejXtO5Di/HiHDRXxR6aD0MPNj/Oitc4NtO/hQ4OOQy6eKY
         vaupX2vemW6tSiiCyQNzL+USWqv7+Gr0ZPgTOQxN3abcVKnvlXB1kM/MOU+KcBqpnVH4
         h+SS8OUfX9H2LCd/J2orCEit23EIlQ3oUtVaiNdYBi3k0ILSdlrOX6zWKBVhQbSwyXm6
         Kfn7JS2WExUozLSZMuB1p545fmcyBxITMVPGTDJ5TWeqP8vWt7dLyHDZwsDu5MLYcDGG
         oOkA==
X-Gm-Message-State: AOAM531GLm5pHlikAzYe/aAo0Vv12TQ5+m/pMsrrX1Wha4f64TJpSUHK
        Znkh9VsMaqX4b8HTlHSzyIw5wT5QKdAIOMB1NlTymg==
X-Google-Smtp-Source: ABdhPJzAafw90qw6GNR9KOTGCaZVcRyonxJQDUdkiFkRD78TDB31Hda8XvnX+oGdm1yTApwMPKKhgoUwD7Dy3t2YpxQ=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1390645pju.8.1632851674343;
 Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-10-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 10:54:21 -0700
Message-ID: <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Reduce maintenance burden of DVSEC query implementation by using the
> centralized PCI core implementation.
>
> Cc: iommu@lists.linux-foundation.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..30c97181f0ae 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
>   */
>  static int siov_find_pci_dvsec(struct pci_dev *pdev)
>  {
> -       int pos;
> -       u16 vendor, id;
> -
> -       pos = pci_find_next_ext_capability(pdev, 0, 0x23);
> -       while (pos) {
> -               pci_read_config_word(pdev, pos + 4, &vendor);
> -               pci_read_config_word(pdev, pos + 8, &id);
> -               if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
> -                       return pos;
> -
> -               pos = pci_find_next_ext_capability(pdev, pos, 0x23);
> -       }
> -
> -       return 0;
> +       return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>  }

Same comments as the CXL patch, siov_find_pci_dvsec() doesn't seem to
have a reason to exist anymore. What is 5?

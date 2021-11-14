Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1A44F651
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 04:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhKNDej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 22:34:39 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37416 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKNDej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Nov 2021 22:34:39 -0500
Received: by mail-lf1-f46.google.com with SMTP id c32so33269384lfv.4;
        Sat, 13 Nov 2021 19:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f8o7a6n3lfLVz4OyMV6gXE3LzNCKasDYyHBhvEgO87Q=;
        b=Rq8CGECso45Zi+5/U9/62exliVGSkW7ZXHuZbongmOdVc4uI1f6MwAfvvjeMoKpJop
         IFzrjefNVAiX0iYumB/dinR4yjO0EbwLXdruuC2Zbzu2Qvz8yMj5yo5+VYDbD3n8uKlS
         yDxue/E8crGiBppGOKfz9NdOsy7rVOhTIKG7wRNkirLh1T1IMOdcG7qFvplQc6Oh2+pL
         3fDKw4yzYaN4IBlODkege82xDVKYO7g/RciAWmFFzibL64VGqimEiRIUaYY9IN6UYyw9
         DlNCulZeX0J9u/I1gPrig5IGkZv/0qrkBt3lrhlUjH4OpOSz5XP7Y3/pYDa+suBQ7/0W
         e26w==
X-Gm-Message-State: AOAM533LcKJ078v/Dz39XNjY9AcIeweMf2ao6MzZVR9lLq8f53dzRQ93
        hXLsDZ8x072rjYdjdhObPTUUisfPERDScQ==
X-Google-Smtp-Source: ABdhPJwEP2Vtxt+5AxKX35tbqV/8n5k/vbutXn1AT/I6VJXKuM4it9H4IQfcgzLNqO/H7ZlTeVNZCQ==
X-Received: by 2002:a19:c74a:: with SMTP id x71mr25629078lff.354.1636860704768;
        Sat, 13 Nov 2021 19:31:44 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f6sm1119049ljk.45.2021.11.13.19.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 19:31:44 -0800 (PST)
Date:   Sun, 14 Nov 2021 04:31:43 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <YZCDHxOwogxPpuWy@rocinante>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

Nice find!  There might one more driver that leverages the vendor-specific
capabilities that seems to be also open coding pci_find_vsec_capability(),
as per:

  139-static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
  140-{
  141-	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
  142-	int dfl_res_off, i, bars, voff = 0;
  143-	resource_size_t start, len;
  144-
  145-	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
  146-		vndr_hdr = 0;
  147:		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
  148-
  149:		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
  150-		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
  151-			break;
  152-	}
  153-
  154-	if (!voff) {
  155-		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
  156-		return -ENODEV;
  157-	}

Do you think that it would be worthwhile to also update this other driver
to use pci_find_vsec_capability() at the same time?  I might be nice to rid
of the other open coded implementation too.

> Currently the set_pcie_thunderbolt() opens code pci_find_vsec_capability().

I would write it as "open codes" in the above.

>  static void set_pcie_thunderbolt(struct pci_dev *dev)
>  {
> -	int vsec = 0;
> -	u32 header;
> +	u16 vsec;
>  
> -	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> -						    PCI_EXT_CAP_ID_VNDR))) {
> -		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> -
> -		/* Is the device part of a Thunderbolt controller? */
> -		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> -		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> -			dev->is_thunderbolt = 1;
> -			return;
> -		}
> -	}
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> +	if (vsec)
> +		dev->is_thunderbolt = 1;
>  }

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2F38D1FC
	for <lists+linux-pci@lfdr.de>; Sat, 22 May 2021 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEUXc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 19:32:28 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:40710 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEUXc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 19:32:27 -0400
Received: by mail-ej1-f45.google.com with SMTP id n2so32742877ejy.7;
        Fri, 21 May 2021 16:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axtOd7tLsrXtbfiwzaZghJQ3ag4GZSs8yl21ItFm8us=;
        b=tNtUCKSFob5JRNTf6q3XyGIznK4rrtouB3a9mQT+r15zHuwFotB8Sup0anlL0zGv7P
         YJ1b2Wt35wdYWyYvaonmmZ0/69ceTJQJyTbTN+keCIWLIjJX4rpz/jPWn99Y9GI08edm
         IcybGtEpPAtZPRdqTqCOY7ezuIDH9sp+Hkzob9DHPmjLkKoo4a05KQeelLgknSgg459f
         8Nap3Z2NmkHK8+lQRNm0Q+24/yOnk5zJ4XnwXT0Pe9bsO9ltZBoUukgvEzkwV05JDWbg
         PhVn5atpOf/q+7cr4FWSqBnhZ9i06Ds+BvZT9sKiPaBQGhql4XQDVQ4fMcnw8u5exWiI
         LbCw==
X-Gm-Message-State: AOAM532uriOTABtQ/EUsqzJbxCoTFYRQPatcQqyhz4kH657o4cSUuJ/Q
        0pEqAZTw06zDCSObrzoks30=
X-Google-Smtp-Source: ABdhPJyxprBu08U7okvjMzHSnFoUdWNH5xCjFp6RGHVDtM3YIEByVK5x16q6DY+vG8DABGHtvfjY6w==
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr12536110ejb.11.1621639861994;
        Fri, 21 May 2021 16:31:01 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k9sm5374156edv.69.2021.05.21.16.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 16:31:01 -0700 (PDT)
Date:   Sat, 22 May 2021 01:31:00 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com
Subject: Re: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
Message-ID: <20210521233100.GB79835@rocinante.localdomain>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796@epcas5p1.samsung.com>
 <20210518174618.42089-2-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518174618.42089-2-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shradha,

[...]
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +					PCI_EXT_CAP_ID_VNDR))) {
> +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);

A small question as I am curious: why not use pci_find_vsec_capability()
here?  The implementation looks very similar, which is why I am asking,
but it might be that I am missing something, and for that I apologise in
advance.

	Krzysztof

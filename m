Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56531392DC4
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhE0MP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:15:58 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35557 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhE0MP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:15:58 -0400
Received: by mail-pg1-f180.google.com with SMTP id m190so3560499pga.2;
        Thu, 27 May 2021 05:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3naLRjF0QNsEbH6gRn0iS8dipT5T+LNn3ZSjp0/dzak=;
        b=tbTyB9apfsTKltVPf1GtHP6mla5DB/vp+Pfnr7FBnxPLD1sQDCEbvVOLv+sI95laFo
         TE5GyCq1yrcbi9N56WMn2jplmLXftxFAKnZK7ShAha5jgyS0PWFQ5MGsmYIhKiqJO+11
         GImXSrKCKlSPdxJ1w007zkv3r+QjUUaiVT98pXiPlhzLgvEebMbXXM+sC6FNIXRHi/vi
         2VfxynEpiCmutU8TiYudexXKyjosHAkvWpNighfuI6RTGctC8sod+PuZGTcKRFQmNZ8q
         fND0ON3jIe+hRrthUhofdzVPrjm00b0gFYwcDJJ4d1gF1B07KF5slD+zMyHqHsy6XyHX
         0DTA==
X-Gm-Message-State: AOAM532iDEQeNpAhOs0ojU1ueOjrkxeCeTpjTmyL2bfuH+goTVOTI6Hm
        xmTn7/xCMZO1ePoGzIC0JQw=
X-Google-Smtp-Source: ABdhPJzGkkcJ385zHinpmjD/GnkLNAgY0qGIaMxo5B7cqM2xy8kKV2m0c5GSDuOTQMwJJIevRGatXw==
X-Received: by 2002:a62:e908:0:b029:2db:8791:c217 with SMTP id j8-20020a62e9080000b02902db8791c217mr3533012pfh.28.1622117663948;
        Thu, 27 May 2021 05:14:23 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q12sm1876345pfg.48.2021.05.27.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:14:23 -0700 (PDT)
Date:   Thu, 27 May 2021 14:14:12 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 2/5] PCI: tegra: Fix MSI-X programming
Message-ID: <20210527121412.GD213718@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527115246.20509-3-omp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527115246.20509-3-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prakash,

[...]
> @@ -1863,7 +1863,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>  	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
>  	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
> -	val = (lower_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
> +	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);

Oh!  Nice catch!

	Krzysztof

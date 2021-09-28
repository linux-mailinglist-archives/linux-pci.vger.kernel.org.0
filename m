Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29D41B556
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhI1RpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 13:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbhI1RpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 13:45:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293AC06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:43:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x191so15047230pgd.9
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imp5I7p53F2DZ1YVYnsTH+B34q59d+HgTV0CrYjuwxo=;
        b=FKSA5duzWRw87ND8p4lngfxsNUmCYFC44YeU70RM2fO3H/yHuH9M8QAsg6bBXTVGqG
         3FzsJWZner5fSvs4m//3O3KT4Er9dHUAKbxccSn9HST/Muq0BTHUTTxiAAVbsVwLn32F
         kMu5q37rLliYt0miOzAML2ekRzAjfDa2oIa9haIsSoVwsZQmx1vS1WDTYixCibF16NoD
         PysTgZlSI4xgn682PA88sYHTzF2Ripl8Xt/5ETc7WmqGsbfvX47bK9Mv0Tv6ZetpFN1f
         4iJKT3z+f1Hd5msRz+IxwpazFQn4bqCPJrKXdTaNL+9xpv6VObc7DAnRAvZcn6ijId1S
         hTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imp5I7p53F2DZ1YVYnsTH+B34q59d+HgTV0CrYjuwxo=;
        b=2mPeF7Ffv87JiLsAD3UOlZnKTlh92riKzecvQFu52//pQzQH0cO1GgbrPN88aDmVeW
         ynbQ+F3/v5a6AYghLAmyxaMyah7JXTzthN0HrCJ3YiE87gxC91HybTpLuG96G0IqeXVz
         oUFHvJTfZb2itkwLKIxBMHAlt+3o52Dd2FeQPEPZJKX7f/jTGULwEjkDQ/VjXRloVerP
         pSEiUG6SLkQ7tIl2y2W+jYaBuQrbHJ1WRuNuA1CkugE0Q84tpM+DOCexEX2tvsimAULM
         yu2cGZgmr+PKbde+9dVRYrIKVZ5gG2FILDCew5/AXwBrQfJEtXS0YlpGhSZXkRxT5OHx
         zCGg==
X-Gm-Message-State: AOAM530upn6EX7SyaLTCgFI2nGzA6hKIQc2c6N/gsPvHTQMDa/lEid7o
        bExiB3YTJECRY1uXR71HZhFvqqLH68CioNIk0cP/1g==
X-Google-Smtp-Source: ABdhPJzjFahY5zlVRdQpZP5HYQgI99KxcTCTyAuujDoILwq7WhTATCP0bUPpo4Bx1rVGm7VXzxNZyVmeIZH5CGfCiSk=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr6437884pfd.61.1632851011800; Tue, 28
 Sep 2021 10:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-8-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-8-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 10:43:19 -0700
Message-ID: <CAPcyv4jHnio-4vcJ5Y7yhcYKT+Gy73Rgfn5YuRn68_CKbbWnmw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] cxl/pci: Use pci core's DVSEC functionality
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
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
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5eaf2736f779..79d4d9b16d83 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -340,25 +340,7 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, struct cxl_register_map
>
>  static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)

cxl_pci_dvsec() has no reason to exist anymore. Let's just have the
caller use pci_find_dvsec_capability() directly.

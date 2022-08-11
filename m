Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4369059054A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiHKRAC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiHKQ7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 12:59:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0102B9FA4
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 09:31:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so5876632pjm.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CZxp61Ij3eVcYj+Pj2alcHlLbbNjMtX5z7xhY7nZJvU=;
        b=LmxLohGlq9QeKHmiCRcau9qRDndVnibIISZ9HJv50XNFRAvVMRyi9rcS0NnhvVqf5I
         V3lZoFTiojUl9WFrsQO44rUVpiaoPeCSO1puSKoq0o84s/zH5JAasGMv7pm3ZKl7yRiE
         aztp6z5ShOfelMDrW+ReU/xfyzxLwx/9j3ZsJlJFMUvorztL04UP3o/QRv3zgSdfk6JP
         f0FCF7EilYFnCQ1IoMZpe5aAVt8sW/0ORCTrtQBoZuJrLhFvP2ok4dTg884dRU+zzpK0
         5WardEU1nbUS0PvKymmrLQ6oJwsSribm2S1AhR4/IhlcHo7ge386ZpV4q594MluSu/Dd
         AZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CZxp61Ij3eVcYj+Pj2alcHlLbbNjMtX5z7xhY7nZJvU=;
        b=GJyWyQtn2ogecPlAJkGpwGZGX9+y84/DS+adHmQ8fJ0eM1guL2G7OsfoI7e4g58V5+
         Ma7r0OLqFrdWVZNge7fg9A3+sST7dm/a4STTaKPQqWmj+gpFnBwF09Fkhegh+yk/k9Im
         /3ryA2u6rk442DF4sn1so3qM24kHzIb7GgQZeq/64662GmXhm4sR29mgMErMyXgCT+xZ
         WTt6L9A5APf9OPj+kwkWoC2iYpyQb+mibWlCw5cXsm8tz3KQs/AzCWkQ07U6jVp8OnEt
         1NibO4wOb3yvP3/qV2iBQ4cMQvoKDPPYZFoN9ZQedmqLLR6AI6GkfAf/Kg4xEpHQU7tl
         y3ug==
X-Gm-Message-State: ACgBeo2IIVsAU8iTdvkMGtTzP6TFyPXkS+O3Ptd0UBqGAthrY9QI+KI5
        J2T8/2Y8nWHgFSBDfYrxTjvyrw==
X-Google-Smtp-Source: AA6agR7ZefBNNeLS2KyXhqZTPICccDvZzdCr1zuJ+J4f7bK2DeBuIoaZtnRpyRSSXKIjnEx18w8RBg==
X-Received: by 2002:a17:90a:9907:b0:1f5:2318:ea6d with SMTP id b7-20020a17090a990700b001f52318ea6dmr9688183pjp.163.1660235510232;
        Thu, 11 Aug 2022 09:31:50 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b0016d1f6d1b99sm15056325plw.49.2022.08.11.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:31:49 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:31:45 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <YvUu8exkECOD+ZR2@google.com>
References: <20220810231445.2242126-3-willmcvicker@google.com>
 <20220811160725.GA1526733@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811160725.GA1526733@bhelgaas>
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2022, Bjorn Helgaas wrote:
> No need to rush the versions (I see v1 on 8/9, v2 and v3 on 8/10).
> 
> But if/when you update this, capitalize the subject lines
> ("PCI: dwc: Add support ...") to match previous history.

Sorry for the quick updates. I'll be sure to update the subject on the next
iteration.

> 
> On Wed, Aug 10, 2022 at 11:14:44PM +0000, Will McVicker wrote:
> > Since not all devices require a 32-bit MSI address, add support to the
> > PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> > kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> > risking not being able to get a 32-bit address during DMA allocation.
> > Basically, in the slim chance that there are no 32-bit allocations
> > available, the current PCIe host driver will fail to allocate the
> > msi_msg page due to a DMA address overflow (seen in [1]).
> 
> > With this patch, the PCIe driver can advertise 64-bit support via
> > it's MSI capabilities to hint to the PCIe host driver to set the DMA
> > mask to 64-bits.
> 
> s/via it's/via its/

Thanks.

> 
> I'm not quite sure what this sentence is saying.  I think it's
> actually the *device* (not the PCIe driver) that advertises 64-bit
> support in its MSI capability.

You're right. The PCIe device is doing the advertising. I'll updae this
wording

> 
> > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> > +{
> > +	u8 offset;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_msi_capabilities);
> 
> Why does this need to be exported?  CONFIG_PCIE_DW and
> CONFIG_PCIE_DW_HOST are both bool, so I don't see any callers from
> modules.
> 
> I see there are some other functions in pcie-designware.c that are
> exported, but I'm a little dubious about those, too.  There are
> several DWC drivers that are tristate (PCI_DRA7XX, PCI_EXYNOS, etc),
> but they select PCIE_DW_HOST and PCIE_DW, which are bool.  I guess
> this means the DWC core code gets built-in while the dra7xx, exynos,
> etc code is a module.
> 
> If we want these to be modules, it would make more sense to me to have
> the module include both the DWC core code and the specific driver.
> I.e., the DWC core code would not be statically included at all, and
> the dra7xx module would contain DWC core and dra7xx, the exynos module
> would contain DWC core and exynos, etc.
> 
> Maybe Kconfig isn't expressive enough for that?  I don't know Kconfig
> well enough.

So you usually want to separate out the core driver from the device driver
and then add the core driver dependencies in the device driver Kconfig
definition. This allows you to statically include the core drivers
(commonly used code between multiple device drivers) into the kernel and
then build the device drivers as kernel modules. And just to note, it's
okay for PCIE_DW and PCIE_DW_HOST to be configured as a bool and selected
from a tristate config. If you take PCI_EXYNOS=m as an example, that will
result in:

  CONFIG_PCIE_DW=y
  CONFIG_PCIE_DW_HOST=y
  CONFIG_PCI_EXYNOS=m

With regards to exporting dw_pcie_msi_capabilities(), the idea is that this
function is a helper for the PCI DW device drivers. For those that want to
enable the 64-bit MSI flag, they can use this function to get the MSI
capabilities in order to update the MSI flags. I haven't added a use-case
to an existing driver yet.

> 
> Bjorn
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

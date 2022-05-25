Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB445346BC
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 00:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiEYWjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 18:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiEYWjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 18:39:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D956C55D
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 15:39:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gz24so216510pjb.2
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HOtARQ+jFJU+qgs9GJXl1TMRe/PYu1C785jtB+gn1kw=;
        b=M9d0HxRqQ/8BQYiDq0Fz4VWmqGg5/GTlro9pWgyhFRLSOIXyTqQ8nnErZ4ZqfqKicZ
         ro876K4Wa95Cxoyajl9K2Z6POJt2a+P0DX3LsGRUc7ZPCYJQ/mEug+L7neDSnjZreN2E
         R+Ud/D1K6WRoj759ZqUgkJ1eQBYnF4PjWi4e+H/BVzZAtSP7JsppUt6YdeStPc4myP+C
         70nDegspoJdK+2pkIWq9ICB9oTWARTj30vfMOvPn+Zo0YwbSOEekdsy9hJOon7oXd0Bx
         kZQy2RmtImJXtz9g8b2LBX7Y+nf5JDxW/s88SSIQaiJtNQY7zg62085KB9ZOAowj3JaD
         BE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HOtARQ+jFJU+qgs9GJXl1TMRe/PYu1C785jtB+gn1kw=;
        b=FlxxVlss4764iJY89qr+YV4lU7cnqyaQzVG3p7cAOLrVlnbfgdUbIdsuF82jKcPGBi
         XgUplFXKO5jlQD/oxA9Wkj7MAYamEtdDjRH40H/tMhpSxaTz1cC746pvdNCpC2Je4BbI
         KjDwTCzXhW/4aOaTikcXAExbRi7vaiYenBy2Xen12Vs9qLQ25a5I+ld1reCU0DJoEA0Q
         QSTOqgOxg/9Z/tHeJjFL9nWQ5JZoonL4zwZvSNe0CMmJzUdin3vo7rjjsptXl1fSw5aL
         lwTf6ojhY2iTcm0rIGBIdVti5BnXBXq7AJUxz0Rp62XJZy4ZY0ZDhBOOPTFlPN2lvUar
         AtQw==
X-Gm-Message-State: AOAM531aPTkAyU1P5EFLZb3v3oq//11NkQeWTk4RdkrrdBIQbInBzNpq
        6aBVk4lh2eqsKbBp8K/fsJvuNA==
X-Google-Smtp-Source: ABdhPJwj242Vp5H4uhMJ2UH//T0FRg/E+87r0kQZyC+UihevRWrl9JgAHDemffGsVlrbQol1p+Lygw==
X-Received: by 2002:a17:90b:3902:b0:1e0:50ef:3ff3 with SMTP id ob2-20020a17090b390200b001e050ef3ff3mr12656975pjb.137.1653518342753;
        Wed, 25 May 2022 15:39:02 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b001624cd63bbbsm3962047plk.133.2022.05.25.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:39:02 -0700 (PDT)
Date:   Wed, 25 May 2022 22:38:58 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: Bug when mapping designware PCIe MSI msg
Message-ID: <Yo6wAoKiNFRXwOj7@google.com>
References: <Yo0soniFborDl7+C@google.com>
 <CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/24/2022, Rob Herring wrote:
> On Tue, May 24, 2022 at 2:06 PM William McVicker
> <willmcvicker@google.com> wrote:
> >
> > Hi All,
> >
> > I've been debugging a PCIe dma mapping issue and I believe I have tracked the
> > bug down to how the designware PCIe host driver is mapping the MSI msg. In
> > commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume") [1],
> > the PCIe driver was re-worked to drop allocating a page for the MSI msg in
> > favor of using an address from the driver data. Then in commit 660c486590aa
> > ("PCI: dwc: Set 32-bit DMA mask for MSI target address allocation") [2],
> > a 32-bit DMA mask was enforced for this MSI msg address in order to support
> > both 32-bit and 64-bit MSI address capable hardware. Both of these changes
> > together expose a bug on hardware that supports an MSI address greather than
> > 32-bits. For example, the Pixel 6 supports a 36-bit MSI address and therefore
> > calls:
> >
> >   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> >
> > Before [2], this was fine because getting an address for the driver data that
> > was less than or equal to 36-bits was common enough to not hit this issue, but
> > after [2] I started hitting the below DMA buffer overflow when the driver data
> > address was greater than 32-bits:
> >
> >   exynos-pcie-rc 14520000.pcie: DMA addr 0x000000088536d908+2 overflow (mask ffffffff, bus limit 0).
> >           : WARNING: CPU: 3 PID: 8 at kernel/dma/direct.h:99 dma_map_page_attrs+0x254/0x278
> >   ...
> >   Hardware name: Oriole DVT (DT)
> >   Workqueue: events_unbound deferred_probe_work_func
> >   pstate  : 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc      : dma_map_page_attrs+0x254/0x278
> >   lr      : dma_map_page_attrs+0x250/0x278
> >   sp      : ffffffc0080938b0
> >   ...
> >   Call trace:
> >           : dma_map_page_attrs+0x254/0x278
> >           : dma_map_single_attrs+0xdc/0x10c
> >           : dw_pcie_host_init+0x4a0/0x78c
> >           : exynos_pcie_rc_add_port+0x7c/0x104 [pcie_exynos_gs]
> >           : exynos_pcie_rc_probe+0x4c8/0x6ec [pcie_exynos_gs]
> >           : platform_probe+0x80/0x200
> >           : really_probe+0x1cc/0x458
> >           : __driver_probe_device+0x204/0x260
> >           : driver_probe_device+0x44/0x4b0
> >           : __device_attach_driver+0x200/0x308
> >           : __device_attach+0x20c/0x330
> >
> >
> > The underlying issue is that using the driver data (which can be a 64-bit
> > address) for the MSI msg mapping causes a DMA_MAPPING_ERROR when the dma mask
> > is less than 64-bits. I'm not familiar enough with the dma mapping code to
> > suggest a full-proof solution to solve this; however, I don't think reverting
> > [1] is a great solution since it addresses a valid issue and reverting [2]
> > doesn't actually solve the bug since the driver data address isn't restricted
> > by the dma mask.
> >
> > I hope that helps explain the issue. Please let me know your thoughts on how we
> > should address this.
> 
> I think the alloc for the msi_msg just needs a GFP_DMA32 flag.
> Unfortunately that is done in each driver and would be kind of odd.
> 
> The thing is I'm pretty sure the actual address doesn't matter. The
> MSI never actually writes to memory but is terminated by the MSI
> controller. It just can't be an address you would want to DMA to (such
> as driver data allocations). And it needs to account for any bus
> translations, which the DMA API conveniently handles.
> 
> So maybe it needs to be its own alloc as before but avoiding the leak
> and also setting GFP_DMA32. Unless others have ideas.
> 
> Rob
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

Hi Rob,

Thanks for the response! I agree using a separate alloc sounds best. I went
ahead and verified this works on my end without any issues and pushed [1]. I
believe the memory leak should be fixed by allocating within
dw_pcie_host_init() since that should only be called in the PCIe probe path and
not suspend/resume.

Please take a look.

Thanks,
Will

[1] https://lore.kernel.org/all/20220525223316.388490-1-willmcvicker@google.com/

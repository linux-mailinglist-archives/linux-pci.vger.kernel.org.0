Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9253328A
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiEXUlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiEXUlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 16:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9E562E6;
        Tue, 24 May 2022 13:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2176174E;
        Tue, 24 May 2022 20:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFBC34100;
        Tue, 24 May 2022 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653424910;
        bh=vjQXFrW/4pQSmN/wiLeQFiNqCMCEP01hMakAH3EECAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OO9tuR72VqbQdiyCYRImCA9LPZjvDJNIoZhUr0Dz3Cs8GwVnBaahWQ5jmGzg+Z1Po
         D3XdOf6SHrwrHsSp4ETyYAs7IMNMnq+Pen2Lx7N42UAshqzwUcL1BYXpKSAheN5Em7
         3qTukxn3RgwNAaJBSF+LITfw1ojKeUsUKwjOvsea9jJpsjKpIT8XbPNiwyxboFG9Fq
         4yfu5gSYvNGjkW/MY7rovwRAVoMlzuSHOhODeak+grzO0YF2HYyW9Xxhmcb6rwvW9g
         2MGt3DjO+yu9yCfz5MIJ/+CSCcfYNlf38HV+U7BYO8Nw4sUEs228y1uaQOlT4QZo4M
         saCLRBeyS10+A==
Received: by mail-ed1-f51.google.com with SMTP id n23so24627980edy.0;
        Tue, 24 May 2022 13:41:49 -0700 (PDT)
X-Gm-Message-State: AOAM530SiB/+MPIeJ7H2Kz/SWGkHYXY1xKjcoSV+WzEOFzKiCirn/Jsx
        PWtThqnzkMeOqPoEknj4vWo28IJvSwZEGVpUnw==
X-Google-Smtp-Source: ABdhPJwPT/cnj3XH0pgU4BNxBBinFvHRkEXNoG/EB11zsFXL1H5/aPWtujbL6r7dDcTJlLXtuIu8Tqdy38eMwbZusQs=
X-Received: by 2002:a05:6402:4316:b0:42b:4d3d:c064 with SMTP id
 m22-20020a056402431600b0042b4d3dc064mr16930879edc.194.1653424908200; Tue, 24
 May 2022 13:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yo0soniFborDl7+C@google.com>
In-Reply-To: <Yo0soniFborDl7+C@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 May 2022 15:41:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com>
Message-ID: <CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com>
Subject: Re: Bug when mapping designware PCIe MSI msg
To:     William McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 2:06 PM William McVicker
<willmcvicker@google.com> wrote:
>
> Hi All,
>
> I've been debugging a PCIe dma mapping issue and I believe I have tracked the
> bug down to how the designware PCIe host driver is mapping the MSI msg. In
> commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume") [1],
> the PCIe driver was re-worked to drop allocating a page for the MSI msg in
> favor of using an address from the driver data. Then in commit 660c486590aa
> ("PCI: dwc: Set 32-bit DMA mask for MSI target address allocation") [2],
> a 32-bit DMA mask was enforced for this MSI msg address in order to support
> both 32-bit and 64-bit MSI address capable hardware. Both of these changes
> together expose a bug on hardware that supports an MSI address greather than
> 32-bits. For example, the Pixel 6 supports a 36-bit MSI address and therefore
> calls:
>
>   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
>
> Before [2], this was fine because getting an address for the driver data that
> was less than or equal to 36-bits was common enough to not hit this issue, but
> after [2] I started hitting the below DMA buffer overflow when the driver data
> address was greater than 32-bits:
>
>   exynos-pcie-rc 14520000.pcie: DMA addr 0x000000088536d908+2 overflow (mask ffffffff, bus limit 0).
>           : WARNING: CPU: 3 PID: 8 at kernel/dma/direct.h:99 dma_map_page_attrs+0x254/0x278
>   ...
>   Hardware name: Oriole DVT (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pstate  : 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc      : dma_map_page_attrs+0x254/0x278
>   lr      : dma_map_page_attrs+0x250/0x278
>   sp      : ffffffc0080938b0
>   ...
>   Call trace:
>           : dma_map_page_attrs+0x254/0x278
>           : dma_map_single_attrs+0xdc/0x10c
>           : dw_pcie_host_init+0x4a0/0x78c
>           : exynos_pcie_rc_add_port+0x7c/0x104 [pcie_exynos_gs]
>           : exynos_pcie_rc_probe+0x4c8/0x6ec [pcie_exynos_gs]
>           : platform_probe+0x80/0x200
>           : really_probe+0x1cc/0x458
>           : __driver_probe_device+0x204/0x260
>           : driver_probe_device+0x44/0x4b0
>           : __device_attach_driver+0x200/0x308
>           : __device_attach+0x20c/0x330
>
>
> The underlying issue is that using the driver data (which can be a 64-bit
> address) for the MSI msg mapping causes a DMA_MAPPING_ERROR when the dma mask
> is less than 64-bits. I'm not familiar enough with the dma mapping code to
> suggest a full-proof solution to solve this; however, I don't think reverting
> [1] is a great solution since it addresses a valid issue and reverting [2]
> doesn't actually solve the bug since the driver data address isn't restricted
> by the dma mask.
>
> I hope that helps explain the issue. Please let me know your thoughts on how we
> should address this.

I think the alloc for the msi_msg just needs a GFP_DMA32 flag.
Unfortunately that is done in each driver and would be kind of odd.

The thing is I'm pretty sure the actual address doesn't matter. The
MSI never actually writes to memory but is terminated by the MSI
controller. It just can't be an address you would want to DMA to (such
as driver data allocations). And it needs to account for any bus
translations, which the DMA API conveniently handles.

So maybe it needs to be its own alloc as before but avoiding the leak
and also setting GFP_DMA32. Unless others have ideas.

Rob

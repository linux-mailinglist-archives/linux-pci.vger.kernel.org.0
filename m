Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8842698EEA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBPInw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 03:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPInw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 03:43:52 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC337B41;
        Thu, 16 Feb 2023 00:43:50 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id be34so1008909oib.10;
        Thu, 16 Feb 2023 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EamPuDVvAthaFSPtPQTP6d/TW+jd6Xl4r6dyhl+tFN8=;
        b=IWOXGOyYGogASerkqpz52CjY9D9qF0P9Znq9/xS9hJT+r0JM+f3pkyuIgskE2q4oWI
         mGpJXDZusVDIiGz6zyOq1NBdCmE1Bd0qdlQjhKJXRzD7yH8ofWoutO+2LmEhlFOly/NB
         mjhUIqdex14hTJRd9Y9CXG/C7mwk2KguJqLfydzal5b+FuvNDHxOc8/Lm39EcpU9D6mb
         A4Xf0MNblMx/Aux1snV+NZq9ySusRx+mjnksjHHul3YbcxJHrCR1kpZ2z9/ViGhzukFj
         e7MUqlcHu2V95vrprCDYHmLYEFBRrGt2a9O73W0pJgdSdxo4d0nuLPOr3lMWR1zeeOsj
         +I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EamPuDVvAthaFSPtPQTP6d/TW+jd6Xl4r6dyhl+tFN8=;
        b=7acKSeGJqkVfSbV3hUE8gaUqOx6D8VekjM1W8RBfXytur5qaJaqvbMVm7KZETH/gsT
         mLhxzinfaDwD9xDoMZ6hSdOqmQ/vgFg1INbkRFWwWOYDaNUYRvXw9PtrXWfbDI2CjwXB
         HwwOxC5fXR+UJ7MKKOsLpMf+0uMmJX0bar1ih2TT22WdBzijTP8LkN20GD6hU1EFPTWq
         R2vnB98+RUYLzs3etk+BTaPvP9UvaEGWjEDZ1h/gff9x5hXYL9mKLu1wmEDvrqmKaWSh
         mKmEPk8TbZ03K2KaNE0FCsRKrRwZ7FYH2Zvr8ANibOZtTl7HkUbwlKSBSVYxicZvUp4o
         c08Q==
X-Gm-Message-State: AO0yUKXmVJ/qaluq4tdC2H93x+i1xg3OSyKDj/zRr7n4w3sTvMwd/yeb
        zCYExaKFaPgGOW4lv/3ZlzUQTZO44iYaU8jIsokhNzTi5XlW5g==
X-Google-Smtp-Source: AK7set+wR6OnNXRx2oggQTNNXpK9f8Mi7Lx4b124Os3jSjPJ+2ZRlfq2dK+VWr/ic8IulJBDOglJ2bh8q4/VpuuN6JU=
X-Received: by 2002:a05:6808:2117:b0:37f:7c14:5599 with SMTP id
 r23-20020a056808211700b0037f7c145599mr153855oiw.265.1676537029282; Thu, 16
 Feb 2023 00:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com> <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
 <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
 <559bdd8c-9cc8-d7ae-a937-ffee9cfbb8a6@opensource.wdc.com> <5c15e1d1-c7e9-0b7c-9b14-f95543c70383@opensource.wdc.com>
In-Reply-To: <5c15e1d1-c7e9-0b7c-9b14-f95543c70383@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 16 Feb 2023 09:43:13 +0100
Message-ID: <CAAEEuhoYjq9WythKJdLbXL3H_927wbJScWrdbU-tHHvysBg_tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 8:28 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/15/23 18:58, Damien Le Moal wrote:
> [...]
> > WRITE ( 131072 bytes):                OKAY
> > WRITE (1024000 bytes):                OKAY
> >
> > Then stops here doing the 1024001 B case. The host waits for a completion that
> > does not come. On the EP side, I see:
> >
> > [   94.307215] pci_epf_test pci_epf_test.0: READ src addr 0xffd00000, 1024001 B
> > [   94.307960] pci_epc fd000000.pcie-ep: Map region 1 phys addr 0xfa100000 to
> > pci addr 0xffd00000, 1024001 B
> > [   94.308924] rockchip-pcie-ep fd000000.pcie-ep: Set atu: region 1, cpu addr
> > 0xfa100000, pci addr 0xffd00000, 1024001 B
> > [  132.309645] dma-pl330 ff6e0000.dma-controller: Reset Channel-2
> > CS-20000e FTC-40000
> >
> >                                                   ^^^^^^^^^^^^^^^
> > The DMA engine does not like something at all. Back to where I was when I tried
> > your series initially, which is why I tried removing patch 1 to see what happens...
> >
> > [  132.370479] pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES,
> > Time: 38.059623935 s, Rate: 26 KB/s
> > [  132.372152] pci_epc fd000000.pcie-ep: Unmap region 1
> > [  132.372780] pci_epf_test pci_epf_test.0: RAISE MSI IRQ 1
> > [  132.373312] rockchip-pcie-ep fd000000.pcie-ep: Send MSI IRQ 1
> > [  132.373844] rockchip-pcie-ep fd000000.pcie-ep: MSI disabled
> > [  132.374388] pci_epf_test pci_epf_test.0: Raise IRQ failed -22
> >
> > And it looks like the PCI core crashed or something because MSI does not work
> > anymore as well (note that this is wheat I see with my nvme epf driver too, but
> > I do not have that DMA channel reset message...)
> >
> > If I run the tests without DMA (mmio only), everything seems fine:
> >
> > ## Read Tests (No DMA)
> > READ (      1 bytes):         OKAY
> > READ (   1024 bytes):         OKAY
> > READ (   1025 bytes):         OKAY
> > READ (1024000 bytes):         OKAY
> > READ (1024001 bytes):         OKAY
> >
> > ## Write Tests (No DMA)
> > WRITE (      1 bytes):                OKAY
> > WRITE (   1024 bytes):                OKAY
> > WRITE (   1025 bytes):                OKAY
> > WRITE (1024000 bytes):                OKAY
> > WRITE (1024001 bytes):                OKAY
> >
> > ## Copy Tests (No DMA)
> > COPY (      1 bytes):         OKAY
> > COPY (   1024 bytes):         OKAY
> > COPY (   1025 bytes):         OKAY
> > COPY (1024000 bytes):         OKAY
> > COPY (1024001 bytes):         OKAY
> >
> > So it looks like translation is working with your patch, but that the driver is
> > still missing something for DMA to work correctly...
>
> I kept testing this and realized that I was not getting a consistent behavior.
> Sometimes all tests passed, but would not repeat (running again would fail
> everything), sometimes NMIs from bad accesses, and other times "hang" (test not
> completing but no real machine hang/crash). So it started to hint at something
> randomly initialized...
>
> Re-reading the TRM, particularly section 17.5.5.1.1, I realized that the lower
> 16 bits of the desc2 register are used for the translation, but we never set
> them with the current code. Only desc0 and desc1... So I added a write(0) to
> desc2 and now it is finally working well. Running the tests in a loop, they all
> pass and no bad behavior is observed.
>
> My cleaned-up rockchip_pcie_prog_ep_ob_atu() function now looks like this:
>
> static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>                                          u32 r, u32 type, u64 phys_addr,
>                                          u64 pci_addr, size_t size)
> {
>         u64 sz = 1ULL << fls64(size - 1);
>         int num_pass_bits = ilog2(sz);
>         u32 addr0, addr1, desc0;
>
>         /* Sanity checks */
>         if (WARN_ON_ONCE(type == AXI_WRAPPER_NOR_MSG))
>                 return;
>         if (WARN_ON_ONCE(ALIGN_DOWN(phys_addr, SZ_1M) != phys_addr))
>                 return;
>         if (WARN_ON_ONCE(rockchip_ob_region(phys_addr + size - 1) != r))
>                 return;
>
>         /* We must pass at least 8 bits of PCI bus address */
>         if (num_pass_bits < 8)
>                 num_pass_bits = 8;
>
>         /* PCI bus address region */
>         addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
>                 (lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
>         addr1 = upper_32_bits(pci_addr);
>         desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;
>
>         rockchip_pcie_write(rockchip, addr0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
>         rockchip_pcie_write(rockchip, addr1,
>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
>         rockchip_pcie_write(rockchip, desc0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC2(r));
> }
>
> And the function rockchip_pcie_clear_ep_ob_atu() also clears desc2:
>
> static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
>                                           u32 region)
> {
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(region));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(region));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
>         rockchip_pcie_write(rockchip, 0,
>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC2(region));
> }
>
> Thoughts ?
>
> --
> Damien Le Moal
> Western Digital Research
>

desc2 dictates the bits [79-64] of the PCIe header descriptor.
These bits are for the PF TLP Processing hints.
I did not set them because I thought the default value (0) would be fine.
The TRM section 17.6.8.2.5 says that this register values are reset
to 0, therefore, the write here (0) to desc2 should not change anything unless
that register is written somewhere (I don't think it is).
Anyways, it's not a bad idea to set desc2 to 0 in those two functions.

Rick

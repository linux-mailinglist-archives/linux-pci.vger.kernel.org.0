Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8552261F
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiEJVLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiEJVLc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 17:11:32 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CD880D7;
        Tue, 10 May 2022 14:11:31 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i38so180456ybj.13;
        Tue, 10 May 2022 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufJz6aadSD6Cn7bOf+6vc8OgcxLYzosePvAp35V0Ho8=;
        b=gvEbdT5lvyZ/rgG0n844WSYG4+ic6WrpFIFnAbQYna20ynqnDf7dUKDaySq7BbXAan
         j7A6qX5KG5z6l13rt7MKCjKBNARdYGEFnBzKVSft6v63wrvYGdODY8N/SdrjHzBP3067
         S5exFJcDqhMeUMICNlu9bLtio1euV37oH7GPmI6WZjtfV7/USw+APrflF9q4Nzy07m20
         d5NmyXPFH4KE/4O9Y8AcRVe0LHdpk1jQcFXDtjnt/FG1y81475YkMZHkPOHUIKplzzo5
         krUutdnfhze9nZfYZ9gte/h20k7ytTUwFYau5z+jCjyK8tAUnheL4p75fXoBrEVgtr22
         x8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufJz6aadSD6Cn7bOf+6vc8OgcxLYzosePvAp35V0Ho8=;
        b=A/U5tiEx34NCQR7vRwc2gXgPjLRbstPuU3ruQix3nQq5TTRKrRu2tj3HdmLbOoGxdd
         442T/UfEDMq0LLjz/p9wH4btI33RQM8eXhUl0fUTjn+J2s6MFD4KAnbUpEqwnnSiXbY4
         wWvXE+gtRGEnK964DFRRZ8tcc7aDrilkX895T346qGnjlxIfPXN0slWaXzAQcoGjrP9j
         EHiU33EuVIxjz2+kvdEUocXz00KALufsyvH45Tkmo4zcVaQ/xMeQMRUwSTS2eGrC+Qp5
         wq/si3vjyw3ScnKfivo1e8bJwshg+2EMKXvD/SUIoCLer3MUwUzzIKabSLjvnIet2rMY
         mAjw==
X-Gm-Message-State: AOAM531pLMErRTIrMPBPjHvf4o+xXAwcJvt6b6WLhw01/wuezK2DgV71
        3ZqZHpxHMEqoiHm5fFh4+ku7e8YF8UcbDWcEKlug71oH
X-Google-Smtp-Source: ABdhPJzIvAovezZHnpVBEWWtPUXpgZsqqpyeKDzhMu/TUJPhbFbJizZF888IenlZeAIEtlG9TCW3MUh9VWyBqwDkreQ=
X-Received: by 2002:a5b:64c:0:b0:64a:684a:2369 with SMTP id
 o12-20020a5b064c000000b0064a684a2369mr20362900ybq.173.1652217090749; Tue, 10
 May 2022 14:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 10 May 2022 17:11:18 -0400
Message-ID: <CAMdYzYrzq5C61T2NYmHr0g_P7Mm25TUfaDV3iz2LkV8-jpV4kA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Enable rk356x PCIe controller
To:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <maz@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 8:38 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> This series enables the DesignWare based PCIe controller on the rk356x
> series of chips. We drop the fallback to the core driver due to
> compatibility issues. We reset the PCIe controller at driver probe to
> prevent issues in the future when firmware / kexec leaves the controller
> in an unknown state. We add support for legacy interrupts for cards that
> lack MSI support (which is partially broken currently). We then add the
> device tree nodes to enable PCIe on the Quartz64 Model A.

Good Evening,

Just a gentle ping to see if there's anything outstanding here.

Very Respectfully,
Peter Geis

>
> Patch 1 drops the snps,dw,pcie fallback from the dt-binding
> Patch 2 resets the PCIe controller to prevent configuration bugs
> Patch 3 adds legacy interrupt support to the driver
> Patch 4 adds the device tree binding to the rk356x.dtsi
> Patch 5 enables the PCIe controller on the Quartz64-A
>
> Changelog:
> v9:
> - move reset_control_assert out of rockchip_pcie_resource_get
> - fix various formatting mistakes
> - fix a checkpatch warning
>
> v8:
> - add core reset patch
> - simplify IRQ enable/disable functions
> - drop spinlock
> - only enable/disable IRQ requested
> - only pass the IRQ register bits used to irq functions
>
> v7:
> - drop assigned-clocks
>
> v6:
> - fix a ranges issue
> - point to GIC instead of ITS
>
> v5:
> - fix incorrect series (apologies for the v4 spam)
>
> v4:
> - drop the ITS modification, poor compatibility is better than
>   completely broken
>
> v3:
> - drop select node from dt-binding
> - convert to for_each_set_bit
> - convert to generic_handle_domain_irq
> - drop unncessary dev_err
> - reorder irq_chip items
> - change to level_irq
> - install the handler after initializing the domain
>
> v2:
> - Define PCIE_CLIENT_INTR_STATUS_LEGACY
> - Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
> - Add legacy interrupt enable/disable support
>
>
> Peter Geis (5):
>   dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
>   PCI: rockchip-dwc: Reset core at driver probe
>   PCI: rockchip-dwc: Add legacy interrupt support
>   arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
>   arm64: dts: rockchip: Enable PCIe controller on quartz64-a
>
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 +++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 119 +++++++++++++++---
>  4 files changed, 191 insertions(+), 26 deletions(-)
>
> --
> 2.25.1
>

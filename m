Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96C01E9C3
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfEOIFh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 May 2019 04:05:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39781 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2019 04:05:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id z128so931249qkb.6;
        Wed, 15 May 2019 01:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+ccq2l1YBXRacKh6NL0gv9RFQ3XL6hLCYeRFYOlzPA=;
        b=UkS/ONOvFGrWAFYD7mnzpauai+AHYBQQNKgOY6g1o8HWGrHG/GAxTmksYfT4sWpuCv
         iUn6l9lORkUYBNkn2uPo5Yq8LnHw+Mbm2Ynpi4SELKCj/YyTlAoVa3wWlg1vN2IBQ+29
         4zqKXtDQES5LnLIfV1k4eE4Siq50D7iXV7kDzG8CzGk95OwkQMlLPls6XT/zIJGjsM7w
         x46DkBZU8V7qXP/CqHrD5meO8RK1l+GWc6IjjDdjNTAwRre/AFg94GLbFM1Nflxf3+4Y
         CtmlCwpeZuzoXEoh+h8drBZTwvgwM7XjBMk9t0ITcf9cwNSMEHM6abpIdX7SXDysDFpp
         yr0w==
X-Gm-Message-State: APjAAAWoYwZlGzDI+cTHGvfiGrPDuYfYHZyEtDH2cF27ZfaBBmkReu0R
        9wUC+qJw+5U0T28iVvsHe5CRu9DXzeIstOagVCs=
X-Google-Smtp-Source: APXvYqyIH5XViMS1a+4nEhLjKpZlbMQT/F6wM51bbNHL491ybxO9CDxjXoTFt4avIv9Jz3PVxDBDwzIn6dZ25APRqtI=
X-Received: by 2002:a37:c441:: with SMTP id h1mr5276612qkm.291.1557907536423;
 Wed, 15 May 2019 01:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190515072747.39941-1-xiaowei.bao@nxp.com> <20190515072747.39941-2-xiaowei.bao@nxp.com>
In-Reply-To: <20190515072747.39941-2-xiaowei.bao@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 10:05:19 +0200
Message-ID: <CAK8P3a3AXRp_v_7hkoJA28tUCiSh1eYzbk4Q4h29OqL6y-KL8A@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Kishon <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 15, 2019 at 9:36 AM Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   52 ++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b045812..50b579b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -398,6 +398,58 @@
>                         status = "disabled";
>                 };
>
> +               pcie@3400000 {
> +                       compatible = "fsl,ls1028a-pcie";
> +                       reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +                              0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> +                       reg-names = "regs", "config";
> +                       interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +                       interrupt-names = "pme", "aer";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       num-lanes = <4>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                                 0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */

Are you sure there is no support for 64-bit BARs or prefetchable memory?

Is this a hardware bug, or something that can be fixed in firmware?

       Arnd

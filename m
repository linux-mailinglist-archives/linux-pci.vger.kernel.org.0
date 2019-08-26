Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18649D74C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfHZUOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 16:14:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45261 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbfHZUOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 16:14:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id v12so13133147oic.12;
        Mon, 26 Aug 2019 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONmOWKvBkqEH/6EhYi4M9WtYliZ0ZD+WEF16FDwCz2Y=;
        b=aElc5Gqu7IZBqMgUQlepAcFFQWhg3XUita3Eg48UrKP0LL0M4v2VpLgA0T0riCudaI
         C/AwEdZxwkUixjJ64yc8WmUom07VWuhXwSis05lPzZiJEQjao0kEClo/Ga3mseYQjgaM
         GBIs/NxcfrVxnaFmGB3juSONtjL8eNPmXr0LQ1EqdFEye9NqLG3FNslS/39pPNpb6Hxe
         Cb7xlSLkyd9W2VGPulQC5KERanyiTITn7n6xGZLAcYzZNk/o4b2on8xR5Q5AgydYi52A
         95ckrj+cWwVuA3H8l4F6K2f4d/O9ozcnAj/RfuZ8Qv5Mh6t0gJrjHxsD+CiZHRvoRBBV
         f4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONmOWKvBkqEH/6EhYi4M9WtYliZ0ZD+WEF16FDwCz2Y=;
        b=FaUqC75xx5Lvesm3PbYXcJEvIelZnRNcjVmusiyCUzLfTA4+3myUoN1fRTcLLghBzQ
         lrmtxEzfKOFG4QxuUVfvKuvmyX91FGop8undXj+6qXzp8Pqbgap8H4maK5Yihmjbb/na
         yTdI2HUf5oOM9TWsDKJmGih77/49cH41NK3fMUAfCI3tNf8N73Vsi9onibJeTptAaxL4
         F7Rm63socaZQyyA9Y/9sawVLocLQ0njF1Y/r60MdWY3+tYWCkmCb/hCvRrkIyr55Sose
         kR4ssyMkLn/SH17WFYyMq3L3v4IHl2Ap2MV6OHrVDjqyhVqLQWUsHbWw5kUtvO0W7ynk
         +JrQ==
X-Gm-Message-State: APjAAAXYjLlsBx0na7p5KsMHNdYdnvmldad0gpg8QHnpWSwCgtBGPIST
        bXH7W10FLYvjM7k1nbrvX38sQnv2LNMQJZoBPyg=
X-Google-Smtp-Source: APXvYqx+wsqBR7LhuXaoGevhgB1lph1QB9TxB004jttF4vjCHdjjEMk/vm+aspko9Z9DT+mYvMOr4vitH26F4N8l39M=
X-Received: by 2002:a05:6808:8e2:: with SMTP id d2mr14160818oic.47.1566850476997;
 Mon, 26 Aug 2019 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com> <f1cb5ba9-b57a-971a-5a2f-1f13e0cc9507@linux.intel.com>
In-Reply-To: <f1cb5ba9-b57a-971a-5a2f-1f13e0cc9507@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 26 Aug 2019 22:14:25 +0200
Message-ID: <CAFBinCDojCN0Gxpa0fyh7t8TdvTLc_dwgJgMxC4PoAszK==BKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        hch@infradead.org, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dilip,

On Mon, Aug 26, 2019 at 8:42 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
[...]
> intel_pcie_port structure is having "struct dw_pcie" as mentioned below:
>
> struct intel_pcie_port {
>         struct dw_pcie          *pci;
>         unsigned int            id; /* Physical RC Index */
>         void __iomem            *app_base;
>         struct gpio_desc        *reset_gpio;
> [...]
> };
>
> Almost all the drivers are following the same way. I don't see any issue in this way.
> Please help me with more description if you see an issue here.
>
> struct qcom_pcie {
> struct dw_pcie *pci;
> Ref: https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/pci/controller/dwc/pcie-qcom.c
>
> struct armada8k_pcie {
> struct dw_pcie *pci;
> Ref: https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/pci/controller/dwc/pcie-armada8k.c
>
> struct artpec6_pcie {
> struct dw_pcie *pci;
> Ref: https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/pci/controller/dwc/pcie-artpec6.c
>
> struct kirin_pcie {
> struct dw_pcie *pci;
> Ref: https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/pci/controller/dwc/pcie-kirin.c
>
> struct spear13xx_pcie {
> struct dw_pcie *pci;
> Ref: https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/pci/controller/dwc/pcie-spear13xx.c
thank you for this detailed list.
it seems that I picked the minority of drivers as "reference" where
it's implemented differently:

first example: pci-meson
  struct meson_pcie {
    struct dw_pcie pci;
    ...
  };

second example: pcie-tegra194 (only in -next, will be part of v5.4)
  struct tegra_pcie_dw {
    ...
    struct dw_pcie pci;
    ...
  };

so some drivers store a pointer pointer to the dw_pcie struct vs.
embedding the dw_pcie struct directly.
as far as I know the result will be equal, except that you don't have
to use a second devm_kzalloc for struct dw_pcie (and thus reducing
memory fragmentation).


Martin

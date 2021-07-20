Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205823CFF68
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGTPrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 11:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhGTPqN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 11:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D9761029;
        Tue, 20 Jul 2021 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626798411;
        bh=oQdXwNsnov3I71IUbI4ZalJPD3H1vclSOvDUrvDehgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BEDlTQJuCNmRb0S80L1HreKgM5vWdFUH4cWiZ8lcGEm31+R8K/+B4SgxU9uY3K1Ne
         LbWmBKlvczn8+JRc1QifwdZNDa37iS+EGa+gNCpLkUFJGx9q6xY64tgrHbauenB5B4
         5vJaK3F3kbbUSISyPa5XN8nah484lGaBnTiapH2gbhtIPVv1iYMHPOnONUIeOsJid2
         sd5EmaawZ0eIG2AE1/Gt9qoeEwYRVhM5R2OChA/f0qMfD1o4K7b9YW6WlqmI/GhxVT
         04fV0zs2soVWAc0/DYgxFNVd6wg9pDR1G2rvm8dO1a2ZNPc7h3fDIiND6RJJMNii+t
         5VcfZlZCQjpmA==
Received: by mail-ed1-f45.google.com with SMTP id h8so29224410eds.4;
        Tue, 20 Jul 2021 09:26:51 -0700 (PDT)
X-Gm-Message-State: AOAM532MR0zmwXSBBwHUd+WoE1MhwVF3UnWV+tVqyAB1NV6Tjsp0k7Zh
        NK+5/5XoIs2xAO2oPqUKyzF4LsqOMhDaSoI2yw==
X-Google-Smtp-Source: ABdhPJx0GdcRkiEP/Wr+vbI5/kjYFGNAHGXTDhqcSZ1dJavWwEGC3uFmRTPWxd/i8V27bJovNBzDreGIuAsGuq7iyRc=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr42328404edt.194.1626798409815;
 Tue, 20 Jul 2021 09:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
 <20210719073456.28666-2-chuanjia.liu@mediatek.com> <20210719224718.GA2766057@robh.at.kernel.org>
 <1626746843.2466.10.camel@mhfsdcap03>
In-Reply-To: <1626746843.2466.10.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Jul 2021 10:26:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXN1b5Tq7uAngXfDmpTJoPvDmSzMedK3kr6efvuCgQ=w@mail.gmail.com>
Message-ID: <CAL_JsqJXN1b5Tq7uAngXfDmpTJoPvDmSzMedK3kr6efvuCgQ=w@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: PCI: mediatek: Update the Device
 tree bindings
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 8:07 PM Chuanjia Liu <chuanjia.liu@mediatek.com> wrote:
>
> On Mon, 2021-07-19 at 16:47 -0600, Rob Herring wrote:
> > On Mon, 19 Jul 2021 15:34:53 +0800, Chuanjia Liu wrote:
> > > There are two independent PCIe controllers in MT2712 and MT7622
> > > platform. Each of them should contain an independent MSI domain.
> > >
> > > In old dts architecture, MSI domain will be inherited from the root
> > > bridge, and all of the devices will share the same MSI domain.
> > > Hence that, the PCIe devices will not work properly if the irq number
> > > which required is more than 32.
> > >
> > > Split the PCIe node for MT2712 and MT7622 platform to comply with
> > > the hardware design and fix MSI issue.
> > >
> > > Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> > > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > > ---
> > >  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++
> > >  .../devicetree/bindings/pci/mediatek-pcie.txt | 206 ++++++++++--------
> > >  2 files changed, 150 insertions(+), 95 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> > >
> >
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
> >
> Hi,Rob
> I have described in the cover letter:
> v11:Rebase for 5.14-rc1 and add "interrupt-names", "linux,pci-domain"
>     description in binding file. No code change.
> if you still ok for this, I will add R-b in next version.

Yes, it's fine.

In the future, put the changelog for a patch in the patch.

Rob

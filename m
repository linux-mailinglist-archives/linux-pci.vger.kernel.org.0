Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC902634F8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIIRvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 13:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIRvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 13:51:06 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF2B21D7F;
        Wed,  9 Sep 2020 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599673865;
        bh=pGHphgmWLyo/dufTuQiMNTxw/j6Mkqzz2RqYRRi2qIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UifUi1aR6vTY1YCFohz0MrsKIbjiUVfmrXU2POWfD05x3TzEfeUPlesFCVlJ6ghfj
         9vIKHIkvaeFpbqdu0l6Nr9FuDgfyQP+9Asr7rOvSE/4V1z1OUqkQV0RhMb5NGdIAUa
         Bu91FIcOSqIl/6c1IQ0N9sRnIsOWjX/dOz2z9lqM=
Received: by mail-ot1-f44.google.com with SMTP id e23so3041611otk.7;
        Wed, 09 Sep 2020 10:51:05 -0700 (PDT)
X-Gm-Message-State: AOAM5312kw1DuKn84gQM+jUMYzCOgSB91L4a38kiYeYVT4Pr16ryt3Ex
        TW8SmtFuErQSIUdbqotW9XfRDn7rDWrTKEpN+w==
X-Google-Smtp-Source: ABdhPJxkJmq457j4MdDwATy4hh9FtiZDSM5Hwf51HIx/0/Kwnq9MhZuGO4CNBKKY+8iKB00EhwOE4N/A7bj1yse07sE=
X-Received: by 2002:a9d:411:: with SMTP id 17mr1478163otc.192.1599673864818;
 Wed, 09 Sep 2020 10:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200907120852.12090-1-jianjun.wang@mediatek.com>
 <20200907120852.12090-2-jianjun.wang@mediatek.com> <20200908195050.GA795070@bogus>
 <1599620917.2521.9.camel@mhfsdcap03>
In-Reply-To: <1599620917.2521.9.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 11:50:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NrfiJ-DAwtYG2b_chfivXi-aazHH8kiApuHS1G8JF=Q@mail.gmail.com>
Message-ID: <CAL_Jsq+NrfiJ-DAwtYG2b_chfivXi-aazHH8kiApuHS1G8JF=Q@mail.gmail.com>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     David Miller <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 8, 2020 at 9:10 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> On Tue, 2020-09-08 at 13:50 -0600, Rob Herring wrote:
> > On Mon, 07 Sep 2020 20:08:50 +0800, Jianjun Wang wrote:
> > > Add YAML schemas documentation for Gen3 PCIe controller on
> > > MediaTek SoCs.
> > >
> > > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  .../bindings/pci/mediatek-pcie-gen3.yaml      | 158 ++++++++++++++++++
> > >  1 file changed, 158 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > >
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:55.56-59.19: Warning (pci_device_reg): /example-0/bus/pcie@11230000/legacy-interrupt-controller: missing PCI reg property
> >
> >
> > See https://patchwork.ozlabs.org/patch/1359119
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure dt-schema is up to date:
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> >
> > Please check and re-submit.
> >
>
> Yes, I have already found this warning message, but I'm confused with
> how to add this reg property, since the interrupt-controller has inherit
> the pci device type but does not have its own registers.
>
> Could you please tell me how to fix this error, or which docs can I
> refer to?

Actually, disregard this. We need to fix dtc for this case.

Rob

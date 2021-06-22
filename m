Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA893B0251
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFVLHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 07:07:39 -0400
Received: from foss.arm.com ([217.140.110.172]:47060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhFVLHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 07:07:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0069231B;
        Tue, 22 Jun 2021 04:05:21 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5302E3F694;
        Tue, 22 Jun 2021 04:05:19 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:05:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Randy Wu <Randy.Wu@mediatek.com>, youlin.pei@mediatek.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
Message-ID: <20210622110517.GB24565@lpieralisi>
References: <20210601024408.24485-1-jianjun.wang@mediatek.com>
 <20210601024408.24485-2-jianjun.wang@mediatek.com>
 <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
 <1622526594.9054.6.camel@mhfsdcap03>
 <CAGXv+5GMTbC5TTgURhPAvxBEY18S6-T-BZ9CpXsO91Trim7TXw@mail.gmail.com>
 <db62910b-febd-6cba-8a72-2bf718f7b110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db62910b-febd-6cba-8a72-2bf718f7b110@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 01:33:07PM +0200, Matthias Brugger wrote:
> 
> 
> On 01/06/2021 08:07, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Tue, Jun 1, 2021 at 1:50 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
> >>
> >> On Tue, 2021-06-01 at 11:53 +0800, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> On Tue, Jun 1, 2021 at 10:50 AM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
> >>>>
> >>>> MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.
> >>>
> >>> Based on what I'm seeing internally, there seems to be some inconsistency
> >>> across the MediaTek platform on whether new compatible strings should be
> >>> introduced for "fully compatible" IP blocks.
> >>>
> >>> If this hardware block in MT8195 is "the same" as the one in MT8192, do we
> >>> really need the new compatible string? Are there any concerns?
> >>
> >> Hi Chen-Yu,
> >>
> >> It's ok to reuse the compatible string with MT8192, but I think this
> >> will be easier to find which platforms this driver is compatible with,
> >> especially when we have more and more platforms in the future.
> > 
> > If it's just for informational purposes, then having the MT8192 compatible
> > as a fallback would work, and we wouldn't need to make changes to the driver.
> > This works better especially if we have to support multiple operating systems
> > that use device tree.
> > 
> > So we would want
> > 
> >     "mediatek,mt8195-pcie", "mediatek,mt8192-pcie"
> > 
> > and
> > 
> >     "mediatek,mt8192-pcie"
> > 
> > be the valid options.
> > 
> > Personally I'm not seeing enough value to justify adding the compatible string
> > just for informational purposes though. One could easily discern which hardware
> > is used by looking at the device tree.
> > 
> 
> I agree, if no differences between the two chips are known, adding a
> binding withe new compatible and a fallback is a good thing. If we
> later on realize that mt8195 PCI block has differences, we can add the
> matching to the driver.

So this series can be dropped, right ?

Thanks,
Lorenzo

> Regards,
> Matthias
> 
> > 
> > Regards
> > ChenYu
> > 
> > 
> >> Thanks.
> >>>
> >>>
> >>> Thanks
> >>> ChenYu
> >>>
> >>>
> >>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> >>>> index e7b1f9892da4..d5e4a3e63d97 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> >>>> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> >>>> @@ -48,7 +48,9 @@ allOf:
> >>>>
> >>>>  properties:
> >>>>    compatible:
> >>>> -    const: mediatek,mt8192-pcie
> >>>> +    oneOf:
> >>>> +      - const: mediatek,mt8192-pcie
> >>>> +      - const: mediatek,mt8195-pcie
> >>>>
> >>>>    reg:
> >>>>      maxItems: 1
> >>>> --
> >>>> 2.18.0
> >>>> _______________________________________________
> >>>> Linux-mediatek mailing list
> >>>> Linux-mediatek@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >>

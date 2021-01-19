Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512E42FBE0F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbhASPAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 10:00:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54108 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389453AbhASNQU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 08:16:20 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1qqa-0006zp-SK; Tue, 19 Jan 2021 14:15:00 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Tue, 19 Jan 2021 14:14:59 +0100
Message-ID: <2336601.uoxibFcf9D@diego>
In-Reply-To: <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com>
References: <20210118091739.247040-1-xxm@rock-chips.com> <20210118091739.247040-2-xxm@rock-chips.com> <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johan,

Am Dienstag, 19. Januar 2021, 14:07:41 CET schrieb Johan Jonker:
> Hi Simon,
> 
> Thank you for this patch for rk3568 pcie.
> 
> Include the Rockchip device tree maintainer and all other people/lists
> to the CC list.
> 
> ./scripts/checkpatch.pl --strict <patch1> <patch2>
> 
>  ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
> --nogit <patch1> <patch2>
> 
> git send-email --suppress-cc all --dry-run --annotate --to
> heiko@sntech.de --cc <..> <patch1> <patch2>
> 
> This SoC has no support in mainline linux kernel yet.
> In all the following yaml documents for rk3568 we need headers with
> defines for clocks and power domains, etc.
> 
> For example:
> #include <dt-bindings/clock/rk3568-cru.h>
> #include <dt-bindings/power/rk3568-power.h>
> 
> Could Rockchip submit first clocks and power drivers entries and a basic
> rk3568.dtsi + evb dts?
> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
> 
> A dtbs_check only works with a complete dtsi and evb dts.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> On 1/18/21 10:17 AM, Simon Xue wrote:
> > Signed-off-by: Simon Xue <xxm@rock-chips.com>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > new file mode 100644
> > index 000000000000..fa664cfffb29
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DesignWare based PCIe RC controller on Rockchip SoCs
> > +
> 
> > +maintainers:
> > +  - Shawn Lin <shawn.lin@rock-chips.com>
> > +  - Simon Xue <xxm@rock-chips.com>
> 
> maintainers:
>   - Heiko Stuebner <heiko@sntech.de>
> 
> Add only people with maintainer rights.

I'd disagree on this ;-)

The maintainer for individual drivers should be the persons who are
actually know the hardware. We have individual Rockchip developers
taking care of other drivers as well already.

And normally scripts/get_maintainer.pl should already include me
due to the wildcard for things having "rockchip" in the name.


Heiko




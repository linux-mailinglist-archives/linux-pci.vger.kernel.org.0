Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32911372F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 22:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDVno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Dec 2019 16:43:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38625 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfLDVno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2019 16:43:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id b8so719776oiy.5;
        Wed, 04 Dec 2019 13:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hABuLyLlW7TcxVWkvZf3nO3Hi6ZwFOub8qWuGq9BCbQ=;
        b=LBnCQDzvNHLTddQGRKQxsW2wwCNorRGty79TWa5SI/WHCpCOc3kxpWI1FD/OxjsiFV
         m8ubaNkWlfuq7RD/qqAMPp1WBQD7tnHO41a+3LMb6uCw0NFqknCcaoAr3OSuusxx2KDR
         +JDqwM4Xnv4Wl9rTNbkANKdnriJm1G17XX71jfi5fzT5qziLyItJm9kKl52IhP//olHs
         5aHO23BFNEtcUQnrATWkhWARm//4uCBNq3LjGCauLMDiR5PuVvJmDazUKMdHRlgJdBSB
         HbYr1BWAWk+WY+uic1/NHCBxJaafBep8MC9+bTN35MARvlIyIN+woLiXI2Q8/sjcKfEU
         nndw==
X-Gm-Message-State: APjAAAVoO0f1NDtFbr3XHJl28xgqMdwFQDpyfi4Q8D29s6ZReE4GkgKV
        BDaQlRLbnb/GfhJL8rfoow==
X-Google-Smtp-Source: APXvYqydpyiFhBHUk9G2NGy/lkyg3GJFVvBnB4xOjBz25Td/upZ30oDDP5FIdEIl+CLltXw19xjaOA==
X-Received: by 2002:aca:eb0f:: with SMTP id j15mr4311383oih.6.1575495822532;
        Wed, 04 Dec 2019 13:43:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm2670429otr.35.2019.12.04.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:43:41 -0800 (PST)
Date:   Wed, 4 Dec 2019 15:43:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com, andrew.murray@arm.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
Message-ID: <20191204214340.GA19088@bogus>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-3-vidyas@nvidia.com>
 <20191122131931.GB1315704@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122131931.GB1315704@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 02:19:31PM +0100, Thierry Reding wrote:
> On Fri, Nov 22, 2019 at 04:15:01PM +0530, Vidya Sagar wrote:
> > Add support for PCIe controllers that can operate in endpoint mode
> > in Tegra194.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >  .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
> 
> The vast majority of this is a duplication of the host mode device tree
> bindings. I think it'd be best to combine both and only highlight where
> both modes differ.

That will not work so well as a schema because all the common PCI bus 
related properties don't apply. Child nodes if any for an EP aren't PCI 
devices either. Though you could have 3 files with common properties, 
host binding and ep bindings. 

While we don't have anything in terms of common PCI EP bindings, I 
somewhat expect that to change. There's been something for how to define 
multiple EP functions for example.

> The designware-pcie.txt binding does something similar.
> 
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
> > new file mode 100644
> > index 000000000000..4676ccf7dfa5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
> > @@ -0,0 +1,138 @@
> > +NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Core based)
> > +
> > +Some of the PCIe controllers which are based on Synopsys DesignWare PCIe IP
> > +are dual mode i.e. they can work in root port mode or endpoint mode but one
> > + at a time. Since they are based on DesignWare IP, they inherit all the common
> > +properties defined in designware-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> 
> The device tree snippets that you added have "nvidia,tegra194-pcie-ep"
> for EP mode controllers. So either this is wrong or the DTS files are
> wrong.
> 
> This device tree binding describes the exact same hardware, so I don't
> think we necessarily need two different compatible strings. It's fairly
> easy to distinguish between which mode to run in by looking at which
> properties exist. EP mode for example is the only one that uses the
> "addr_space" reg entry.
> 
> Rob, do you know why a different compatible string was chosen for the EP
> mode? Looking at the driver, there are only a handful of differences in
> the programming, but most of the driver remains identical. An extra DT
> compatible string seems a bit exaggerated since it suggests that this is
> actually different hardware, where it clearly isn't.

Whether the driver shares a lot of code or not, it's fundamentally a 
different device and driver stack.

> > +  Tegra194: Only C0, C4 & C5 controllers are dual mode controllers.
> > +- power-domains: A phandle to the node that controls power to the respective
> > +  PCIe controller and a specifier name for the PCIe controller. Following are
> > +  the specifiers for the different PCIe controllers
> > +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
> > +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
> > +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> > +  these specifiers are defined in
> > +  "include/dt-bindings/power/tegra194-powergate.h" file.
> > +- reg: A list of physical base address and length pairs for each set of
> > +  controller registers. Must contain an entry for each entry in the reg-names
> > +  property.
> > +- reg-names: Must include the following entries:
> > +  "appl": Controller's application logic registers
> > +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
> > +             Translation Unit) registers of the PCIe core are made available
> > +             for SW access.
> > +  "dbi": The aperture where root port's own configuration registers are
> > +         available
> > +  "addr_space": Used to map remote RC address space
> > +- interrupts: A list of interrupt outputs of the controller. Must contain an
> > +  entry for each entry in the interrupt-names property.
> > +- interrupt-names: Must include the following entry:
> > +  "intr": The Tegra interrupt that is asserted for controller interrupts
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +  See ../clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries:
> > +  - core
> > +- resets: Must contain an entry for each entry in reset-names.
> > +  See ../reset/reset.txt for details.
> > +- reset-names: Must include the following entries:
> > +  - apb
> > +  - core
> > +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
> > +- phy-names: Must include an entry for each active lane.
> > +  "p2u-N": where N ranges from 0 to one less than the total number of lanes
> > +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
> > +  by controller-id. Following are the controller ids for each controller.
> > +    0: C0
> > +    4: C4
> > +    5: C5
> > +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> > +- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller followed by
> > +  GPIO that is being used as PERST signal
> 
> Why is this NVIDIA specific? Do other instantiations of the DW IP not
> also need a means to define which GPIO is the reset?

'reset-gpios' is used for PERST. Though in this case it's an input 
rather than output.

Rob

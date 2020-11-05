Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9FD2A840C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgKEQxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 11:53:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33930 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgKEQxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 11:53:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so2055335ots.1;
        Thu, 05 Nov 2020 08:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3AVzHZD6ysm61wCDKsw2GxAdZdrAdpsQuyAnywMmA8=;
        b=FloI7jFfnSBrfP9iin2/p9mvVpSKLvUcIBnSugNAjvhNKZsfnkhgQ7zH15wVPxHEww
         gr3ohOdcb+P98KkbcIThgn2slazQMVXBZSZAaII2VcQT+2Ef3lY25hTYHrO7oG4VEoGc
         3iyBQdz4yS1vhrCyl9/gGj219swuUDD5Cc+YMAixZGHuJFJYzp1T5DMKFsnFS0HPcdYA
         MlQaYD5eeq82pE4IO5F2lnbrmn687cpAm6C9TI8moxDTr7ybtxEN1/NEmXU/SJdSF6t1
         /oXkTO1XrORzV0y/CApzBeYz4AtrRUcGVBzAx/3v/52IpRZHhUAljlyG40VaB0QovcHN
         EE9A==
X-Gm-Message-State: AOAM530Wojvl9SLB1hV/wrQJpIV0bxYMFByXVyGItLfv/SJsApRLhq7t
        PFm+8eQ29P3YNElrl1g9/A==
X-Google-Smtp-Source: ABdhPJwpxMxK2RU2lCjMIf/3ykx8mnbbYfhduNQtLMOq/fp5KWzV7Yg5tOP0ObyyKC/tySATtQayMQ==
X-Received: by 2002:a05:6830:11a:: with SMTP id i26mr2170164otp.87.1604595212985;
        Thu, 05 Nov 2020 08:53:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c64sm476495oia.49.2020.11.05.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:53:32 -0800 (PST)
Received: (nullmailer pid 1470649 invoked by uid 1000);
        Thu, 05 Nov 2020 16:53:31 -0000
Date:   Thu, 5 Nov 2020 10:53:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum
 outbound regions
Message-ID: <20201105165331.GA55814@bogus>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-9-kishon@ti.com>
 <20201102164137.ntl3v6gu274ek2r2@gauze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102164137.ntl3v6gu274ek2r2@gauze>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 10:41:37AM -0600, Nishanth Menon wrote:
> On 15:41-20201102, Kishon Vijay Abraham I wrote:
> > PCIe controller in J721E supports a maximum of 32 outbound regions.
> > commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
> > nodes") incorrectly added maximum number of outbound regions to 16. Fix
> > it here.
> > 
> > Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > index e2a96b2c423c..61b533130ed1 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > @@ -652,7 +652,7 @@
> >  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&k3_clks 239 1>;
> >  		clock-names = "fck";
> > -		cdns,max-outbound-regions = <16>;
> > +		cdns,max-outbound-regions = <32>;

Can this be made detectable instead? Write to region registers and check 
the write sticks? I'm doing this for the DWC controller.

Or make the property optional with the default being the max (32).

Rob

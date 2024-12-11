Return-Path: <linux-pci+bounces-18171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEA9ED66A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44E516B2CC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61E92594B9;
	Wed, 11 Dec 2024 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8C2osmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACC259496;
	Wed, 11 Dec 2024 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944816; cv=none; b=ZZucYlnJIV+71gtOcIk87JoB2CMJm5vrqkKxGoY8jQzYmI8CDmXQC9VgNcZi2gVc2qG3SnuGMkz0Fr0noMclE1wtLnKaXVE9UIQ/Nfyao1O0kgXWMCK48vobsKiiPA2tveabK1BfK0QE51Bc+jtrBaZU2s5c6/55dgYp4cavxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944816; c=relaxed/simple;
	bh=tyykMSo0nPT52ILfZq5q6tJt70N2U4en4/fZrKCHmHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mVVURx3CIS6HIDUs3rCT692ffNK2C4y0LF/puyeehnbEFvtW0di4E2a6ozX+GMpLT/rOoZqmevSpwgK5cvd6keOhLKDGhufIpDXXW2FOILO5wWnT9zh+75SegOuSk1FG6sbH/htCVZgdEziMVtZ56CYx/Xr0JVpqBBHPjWIuuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8C2osmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D363DC4CED2;
	Wed, 11 Dec 2024 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944816;
	bh=tyykMSo0nPT52ILfZq5q6tJt70N2U4en4/fZrKCHmHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m8C2osmN6l2UocCn4/RRS7GssrXcQXio4fsafrI0AzKl3XrZ7qrfsAZgVMKmlnWYV
	 WyT4PeD9FPXKkD/XfMymM8l/iQsPTRVqgWv7Y/1jZNgLYbTDDXqAGf9iSTipIDvyJY
	 /j2Biba8AVySUHTICqKF0HNSSBEkQmAGGFIxzvuT9qk9zrOL4DqfFko6n2ZGESlnA5
	 7z4coFGh0YLmyTSDQGuKzad67JkhSU+NSJkHzzRivur9+b7kxeJ1Vxf/Hl5dpraxDR
	 NI5vSOEJj6pXPMpqy7PcYhkukWto9WOOT5njZHuxtZmXQcDBL9cp7erHDZm1J1zjWM
	 Itib4DC9ZCz/Q==
Date: Wed, 11 Dec 2024 13:20:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, guoren@kernel.org, inochiama@outlook.com,
	lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20241211192014.GA3302752@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB4515ECD36D8FC6ECB7D161C5FE3E2@BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM>

[cc->to: Rob, Krzysztof, Conor because I'm not a DT expert and I'd
like their thoughts on this idea of describing Root Ports as separate
children]

On Wed, Dec 11, 2024 at 05:00:44PM +0800, Chen Wang wrote:
> On 2024/12/11 1:33, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:

> > > +      The Cadence IP has two modes of operation, selected by a strap pin.
> > > +
> > > +      In the single-link mode, the Cadence PCIe core instance associated
> > > +      with Link0 is connected to all the lanes and the Cadence PCIe core
> > > +      instance associated with Link1 is inactive.
> > > +
> > > +      In the dual-link mode, the Cadence PCIe core instance associated
> > > +      with Link0 is connected to the lower half of the lanes and the
> > > +      Cadence PCIe core instance associated with Link1 is connected to
> > > +      the upper half of the lanes.

> > > +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
> > > +
> > > +                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
> > > +                     |                                |                 |
> > > +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
> > > +                     |                                |                 |
> > > +                     +-- Core(Link1) <---> disabled   +-----------------+
> > > +
> > > +                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
> > > +                     |                                |                 |
> > > +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> > > +                     |                                |                 |
> > > +                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
> > > +
> > > +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
> > > +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
> > > +
> > > +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
> > > +      RC(Link)s may share different bits of the same register. For example,
> > > +      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.

> > > +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
> > > +      this we can know what registers(bits) we should use.

> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - vendor-id
> > > +  - device-id
> > > +  - sophgo,syscon-pcie-ctrl
> > > +  - sophgo,pcie-port
> >
> > It looks like vendor-id and device-id apply to PCI devices, i.e.,
> > things that will show up in lspci, I assume Root Ports in this case.
> > Can we make this explicit in the DT, e.g., something like this?
> > 
> >    pcie@62000000 {
> >      compatible = "sophgo,sg2042-pcie-host";
> >      port0: pci@0,0 {
> >        vendor-id = <0x1f1c>;
> >        device-id = <0x2042>;
> >      };
> 
> Sorry, I don't understand your meaning very well.  Referring to the topology
> diagram I drew above, is it okay to write DTS as follows?
> 
> pcie@7060000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // other properties
>     pci@0,0 {
>       vendor-id = <0x1f1c>;
>       device-id = <0x2042>;
>     };
> }
> 
> pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // other properties
>     pci@0,0 {
>       vendor-id = <0x1f1c>;
>       device-id = <0x2042>;
>     };
> }
> 
> pcie@7062800000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // other properties
>     pci@1,0 {
>       vendor-id = <0x1f1c>;
>       device-id = <0x2042>;
>     };
> 
> }

Generally makes sense to me.  I'm suggesting that we should start
describing Root Ports as children of the host bridge node instead of 
mixing their properties into the host bridge itself.

Some properties apply to the host bridge, e.g., "bus-range" describes
the bus number aperture, and "ranges" describes the address
translation between the upstream CPU address space and the PCI address
space.

Others apply specifically to a Root Port, e.g., "num-lanes",
"max-link-speed", "phys", "vendor-id", "device-id".  I think it will
help if we can describe these in separate children, especially when
there are multiple Root Ports.

Documentation/devicetree/bindings/pci/pci.txt says a Root Port
should include a reg property that contains the bus/device/function
number of the RP, e.g.,
Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt has
this:

  pcie-controller@3000 {
     compatible = "nvidia,tegra30-pcie";
     pci@1,0 {
       reg = <0x000800 0 0 0 0>;
     };

where the "0x000800 0 0 0 0" means the "pci@1,0" Root Port is at
00:01.0 (bus 00, device 01, function 0).  I don't know what the "@1,0"
part means.

> And with this change, I can drop the “pcie-port”property and use the port
> name to figure out the port number, right?

Seems likely to me.

> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    pcie@62000000 {
> > > +      compatible = "sophgo,sg2042-pcie-host";
> > > +      device_type = "pci";
> > > +      reg = <0x62000000  0x00800000>,
> > > +            <0x48000000  0x00001000>;
> > > +      reg-names = "reg", "cfg";
> > > +      #address-cells = <3>;
> > > +      #size-cells = <2>;
> > > +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> > > +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> > > +      bus-range = <0x80 0xbf>;
> > > +      vendor-id = <0x1f1c>;
> > > +      device-id = <0x2042>;
> > > +      cdns,no-bar-match-nbits = <48>;
> > > +      sophgo,pcie-port = <0>;
> > > +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > > +      msi-parent = <&msi_pcie>;
> > > +      msi_pcie: msi {
> > > +        compatible = "sophgo,sg2042-pcie-msi";
> > > +        msi-controller;
> > > +        interrupt-parent = <&intc>;
> > > +        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
> > > +        interrupt-names = "msi";
> > > +      };
> > > +    };


Return-Path: <linux-pci+bounces-19364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FDA033DB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E2E1637E1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9CB2594A4;
	Tue,  7 Jan 2025 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf6pnJcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208A320F;
	Tue,  7 Jan 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209121; cv=none; b=ACTEPUilIaq/0fe23zcj234bhUiwjotxM4LIyC4zoFvgHCdULw2ueMnbLXkIaittvTWXdtdJFYt4xiiQrXblkQX2oHsdW9G3RZ/ztF6dQDkfEXLEuCBuMySi1MtS+ZPZ2kW+EwPNrZqaPOS9ZKcikEYh1PpA21iBGTDPPSpypGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209121; c=relaxed/simple;
	bh=f2O7fcinraOgnNYOGg+k9fdMgFU6GnIbFo2NzLI5ANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U3FFsTpMW5GRZB6shZH7PlIHRywyVUm+aMRum2aZ3VTE0Hfi+Lg2kuKjjZrvnxc7G60Ap++3/zArGqiQw8aRYS9n0Olyq64Tnht8dEORj/Bmm1WedMDDkE6FBXkaLsKDAZH11/mwNkzaDSatiiWKdBPBWcI6iMdp68bkVHZKeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf6pnJcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D371C4CED2;
	Tue,  7 Jan 2025 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736209121;
	bh=f2O7fcinraOgnNYOGg+k9fdMgFU6GnIbFo2NzLI5ANQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hf6pnJccTlg6cBltWa4BXy0UwdwghZqpex/+HjXF95Zr2WVVc46qmH0hBPfssQD1t
	 hROUbsJ2f07WjvNjOMxSP+sP34OlZSBG241J5orIzj9mFx+cnPlwKZbwKygxKdp7TW
	 eQXdgainN416F4s8qbzucazvLhj6Q7BtGBCmZ1qh/d3bD2IynYSDWxfyw7WIpkx4hp
	 PPoLS6Nlc9nJcD3cmW2NuKTCF9VGy+Lzf7lQec7yJhkkPIjVIArnfZadh7MKEtYKft
	 yym5Z4tKzhn8XadvbGDIEpVH8jimmXV7yGiISuzlbB8q5PzJH3qjTNBgC9Z4Qh5FYm
	 cO81aMHZtZ8zA==
Date: Mon, 6 Jan 2025 18:18:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250107001839.GA142126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>

On Thu, Dec 19, 2024 at 10:34:50AM +0800, Chen Wang wrote:
> hello ~
> 
> On 2024/12/11 1:33, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
> > > Add binding for Sophgo SG2042 PCIe host controller.
> > > +  sophgo,pcie-port:
> [......]
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
> > I assume this means there are two separate Root Ports, one for Link0
> > and a second for Link1?
> > 
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
> > An RC doesn't have a Link.  A Root Port does.
> > 
> > > +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
> > > +      this we can know what registers(bits) we should use.
> > > +
> > > +  sophgo,syscon-pcie-ctrl:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the PCIe System Controller DT node. It's required to
> > > +      access some MSI operation registers shared by PCIe RCs.
> > I think this probably means "shared by PCIe Root Ports", not RCs.
> > It's unlikely that this hardware has multiple Root Complexes.
> 
> I just double confirmed with sophgo engineers, they told me that the actual
> PCIe design is that there is only one root port under a host bridge. I am
> sorry that my original description and diagram may not make this clear, so
> please allow me to introduce this historical background in detail again.
> Please read it patiently :):
> 
> The IP provided by Cadence contains two independent cores (called "links"
> according to the terminology of their manual, the first one is called link0
> and the second one is called link1). Each core corresponds to a host bridge,
> and each host bridge has only one root port, and their configuration
> registers are completely independent. That is to say，one cadence IP
> encapsulates two independent host bridges. SG2042 integrates two Cadence
> IPs, so there can actually be up to four host bridges.
> 
> 
> Taking a Cadence IP as an example, the two host bridges can be connected to
> different lanes through configuration, which has been described in the
> original message. At present, the configuration of SG2042 is to let core0
> (link0) in the first ip occupy all lanes in the ip, and let core0 (link0)
> and core1 (link1) in the second ip each use half of the lanes in the ip. So
> in the end we only use 3 cores, that's why 3 host bridge nodes are
> configured in dts.

Host bridges are logically separate PCI hierarchies, so these three
host bridges could be in three separate PCI domains, and each one
could use buses 00-ff.  Each one contains a single Root Port, so
enumerating could look like this:

  0000:00:00.0 Root Port to [bus 01-ff]
  0001:00:00.0 Root Port to [bus 01-ff]
  0002:00:00.0 Root Port to [bus 01-ff]

Does that match with your understanding?


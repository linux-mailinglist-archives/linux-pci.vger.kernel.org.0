Return-Path: <linux-pci+bounces-21243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53EA31996
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FEB7A0843
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71681F8917;
	Tue, 11 Feb 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2ICWTO9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D327291F;
	Tue, 11 Feb 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316872; cv=none; b=a010MCHog9G7EruZzOtQgswm38m/aM3YtRPTUsVyr0iLsH8UZrOKQLpoBQVx6RFt0eKDGXdJZSm10kq0KH1ooF3mIJjgdS9/9ZsVRiIiPXBXQhUax/kSj4kXwVMDXx+pvy13TRqufl/mJadmPQuISK982qxSG8X4uczATOCs73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316872; c=relaxed/simple;
	bh=nDtnBAQ+E7kXVtn1qwbaoJMQmIELR47EumTe1bf8h8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nDae/q3xFZyflK4YdzjfQn4cxhzp6+s8KZpYUG4fHXMzAULNwKCMqsLvoXV4t2GtoqbeP5J1RgDGMxsvKqID/BckHOXnpSfLKPp0wUi48aHNsoor3GpXlgt+fK0zCn4+ZhFCizWu5LZUT6IqV3yDjvCPD2zdBRY0Y5e0JH8uFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2ICWTO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943EFC4CEDD;
	Tue, 11 Feb 2025 23:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316871;
	bh=nDtnBAQ+E7kXVtn1qwbaoJMQmIELR47EumTe1bf8h8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k2ICWTO9rwBqtNelUW9bhvvXeUcB0Q6JaiScS57tKkU2lEyzmcoidNcao1OWkKh7V
	 hXkF6OH/GjwOaQm8WD4nxLZqxVfUtwk1JfLc2v7DcdV++l8vK/o+LeFuw6YB1S3oo3
	 qPGAP5VDEsLuC/SkVipZrsMeCyPf+c/UMGB+pS/QcSBok5xl642Hgk3yHgTq/+hnhE
	 ilq101pYZaDwtMzO+XmFrGaCFIz8eqLOLUMI9DdsMpJnKhLiX+aYX865NEE+wruw3r
	 gwmqOeg7To+tJ1Z6fSLJgPfA0mj/C5s6QRFulxkOfiRFTrGdD+HfnIE4/MLB9iQkHJ
	 O+JpnRG7Z9MxA==
Date: Tue, 11 Feb 2025 17:34:30 -0600
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
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250211233430.GA55431@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0PR01MB6028C76DCC20B81498081CE1FEED2@PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Jan 26, 2025 at 10:27:27AM +0800, Chen Wang wrote:
> On 2025/1/23 6:21, Bjorn Helgaas wrote:
> > On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add binding for Sophgo SG2042 PCIe host controller.
> > > +  sophgo,link-id:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
> > > +      & link1 as Cadence's term). Each core corresponds to a host bridge,
> > > +      and each host bridge has only one root port. Their configuration
> > > +      registers are completely independent. SG2042 integrates two Cadence IPs,
> > > +      so there can actually be up to four host bridges. "sophgo,link-id" is
> > > +      used to identify which core/link the PCIe host bridge node corresponds to.
> > IIUC, the registers of Cadence IP 1 and IP 2 are completely
> > independent, and if you describe both of them, you would have separate
> > "pcie@62000000" stanzas with separate 'reg' and 'ranges' properties.
> 
> To be precise, for two cores of a cadence IP, each core has a separate set
> of configuration registers, that is, the configuration of each core is
> completely independent. This is also what I meant in the binding by "Each
> core corresponds to a host bridge, and each host bridge has only one root
> port. Their configuration registers are completely independent.". Maybe the
> "Their" here is a bit unclear. My original intention was to refer to the
> core. I can improve this description next time.
> 
> >  From the driver, it does not look like the registers for Link0 and
> > Link1 are independent, since the driver claims the
> > "sophgo,sg2042-pcie-host", which includes two Cores, and it tests
> > pcie->link_id to select the correct register address and bit mask.
> In the driver code, one "sophgo,sg2042-pcie-host" corresponds to one core,
> not two. So, you can see in patch 4 of this pathset [1], 3 pcie host-bridge
> nodes are defined, pcie_rc0 ~ pcie_rc2, each corresponding to one core.
> 
> [1]:https://lore.kernel.org/linux-riscv/4a1f23e5426bfb56cad9c07f90d4efaad5eab976.1736923025.git.unicorn_wang@outlook.com/
> 
> I also need to explain that link0 and link1 are actually completely
> independent in PCIE processing, but when sophgo implements the internal msi
> controller for PCIE, its design is not good enough, and the registers for
> processing msi are not made separately for link0 and link1, but mixed
> together, which is what I said cdns_pcie0_ctrl/cdns_pcie1_ctrl. In these two
> new register files added by sophgo (only involving MSI processing), take the
> second cadence IP as an example, some registers are used to control the msi
> controller of pcie_rc1 (corresponding to link0), and some registers are used
> to control the msi controller of pcie_rc2 (corresponding to link1). In a
> more complicated situation, some bits in a register are used to control
> pcie_rc1, and some bits are used to control pcie_rc2. This is why I have to
> add the link_id attribute to know whether the current PCIe host bridge
> corresponds to link0 or link1, so that when processing the msi controller
> related to this pcie host bridge, we can find the corresponding register or
> even the bit of a register in cdns_pcieX_ctrl.
> 
> > "sophgo,link-id" corresponds to Cadence documentation, but I think it
> > is somewhat misleading in the binding because a PCIe "Link" refers to
> > the downstream side of a Root Port.  If we use "link-id" to identify
> > either Core0 or Core1 of a Cadence IP, it sort of bakes in the
> > idea that there can never be more than one Root Port per Core.
>
> The fact is that for the cadence IP used by sg2042, only one root port is
> supported per core.

1) That's true today but may not be true forever.

2) Even if there's only one root port forever, "link" already means
something specific in PCIe, and this usage means something different,
so it's a little confusing.  Maybe a comment to say that this refers
to a "Core", not a PCIe link, is the best we can do.

> ...
> Based on the above analysis, I think the introduction of a three-layer
> structure (pcie-core-port) looks a bit too complicated for candence IP. In
> fact, the source of the discussion at the beginning of this issue was
> whether some attributes should be placed under the host bridge or the root
> port. I suggest that adding the root port layer on the basis of the existing
> patch may be enough. What do you think?
> 
> e.g.,
> 
> pcie_rc0: pcie@7060000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <4>;
>     }
> };
> 
> pcie_rc1: pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     };
> };
> 
> pcie_rc2: pcie@7062800000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     }
> };

Where does linux,pci-domain go?

Can you show how link-id 0 and link-id 1 would both be used?  I assume
they need to be connected somehow, since IIUC there's some register
shared between them?

Bjorn


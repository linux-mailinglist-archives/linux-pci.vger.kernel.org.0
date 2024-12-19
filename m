Return-Path: <linux-pci+bounces-18773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC89F7B04
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BF1189051B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9B1FCD02;
	Thu, 19 Dec 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwFd+lie"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009B1CA9C;
	Thu, 19 Dec 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610602; cv=none; b=k/5z0cmWcc0f4OJpWBgcVomVfbir+dVAqKPjVlC5NPwBkdWbR3iG/oZ86TNfY/nj59tmbUNUGBUoFf/muf5X65XQb2Jt50G9vbm3Xs6Wsai5RWPeC4cWGnKp8JmyEXqi0pkRUclW7M4KrKXByqIvlEU8J+F2ih5enIpgeXn80pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610602; c=relaxed/simple;
	bh=/rc6f/XyoswSnzbbgPHjpTqckIr5GVVzgBeklS57Qo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTIQJs7VYU0KbI1z1ySQygQpS7WyNKWLWN4f5rUEKTIf1NT4ucz+N74iZlnlsBU9l1ov2bjpV6pbMIH0d5H+BFfcbnRnbPOKvX+3v3gRUe/CfYBrdy0XXHmpL+RdO6+Ak6gMgfWf9yFPg+sVrDywOkJ2c7l9RABMtRp4k3xy6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwFd+lie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D38C4CECE;
	Thu, 19 Dec 2024 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734610601;
	bh=/rc6f/XyoswSnzbbgPHjpTqckIr5GVVzgBeklS57Qo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwFd+lieTdZ8hfsq7P/ml72xq1HSgxoiNzGMZt45JYbo5b9EOdEuEe98ULBJSIM8a
	 nAOf9sgSicIl5xEYFmyb/1y3Q99ft46zA/POMlPAjAMHQs10l9CRA2yUfshvDrYdTu
	 2IoeqegJeBpYWm5eKXTcQ764Duu+c9tJTIja6WVwBMccX0xrPHtR6apFLbHT4uS8Oh
	 gvL4SqNtCH7u2XnuSsxGNHSl/WpzF8KVGyhJKKUy0TUeAv903UdwxjlMkDw2Tjt28i
	 2s6BOv1KcChK75cxut/LJtkuL41IOCVEt15JpuIAWkml2bEMchDS1GL6exan77wyaU
	 dKyoJFQJ4x0CA==
Date: Thu, 19 Dec 2024 06:16:39 -0600
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>,
	kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20241219121639.GA3977968-robh@kernel.org>
References: <20241210173350.GA3222084@bhelgaas>
 <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
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
> hi, Bjorn,
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
> 
> 
> Because the configurations of these links are independent, the story ends
> here, but unfortunately, sophgo engineers defined some new register files to
> add support for their msi controller inside pcie. The problem is they did
> not separate these register files according to link0 and link1. These new
> register files are "cdns_pcie0_ctrl" / "cdns_pcie1_ctrl" in the original
> picture and dts, where the register of "cdns_pcie0_ctrl" is shared by link0
> and link1 of the first ip, and "cdns_pcie1_ctrl" is shared by link0 and
> link1 of the second ip. According to my new description, "cdns_pcieX_ctrl"
> is not shared by root ports, they are shared by host bridge/rc.
> 
> 
> Because the register design of "cdns_pcieX_ctrl" is not strictly segmented
> according to link0 and link1, in pcie host bridge driver coding we must know
> whether the host bridge corresponds to link0 or link1 in the ip, so the
> "sophgo,link-id" attribute is introduced.
> 
> 
> Now I think it is not appropriate to change it to "sophgo,pcie-port". The
> reason is that as mentioned above, there is only one root port under each
> host bridge in the cadence ip. Link0 and link1 are actually used to
> distinguish the two host bridges in one ip.
> 
> So I suggest to keep the original "sophgo,link-id" and with the prefix
> because the introduction of this attribute is indeed caused by the private
> design of sophgo.
> 
> Any other good idea please feel free let me know.
> 
> Thansk,
> 
> Chen
> 
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - vendor-id
> > > +  - device-id
> > > +  - sophgo,syscon-pcie-ctrl
> > > +  - sophgo,pcie-port
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
> As I mentioned above, there is actually only one root port under a host
> bridge, so I think it is unnecessary to introduce the port subnode.

It doesn't matter how many RPs there are. What matters is what are the 
properties associated with.

> In addition, I found that it is also allowed to directly add the vendor-id
> and device-id properties directly under the host bridge, see https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-host-bridge.yaml
> And refer to the dts for those products using cadence ip:
> arch/arm64/boot/dts/ti/k3-j721e-main.dtsi

It's allowed because we are stuck things with the wrong way. That 
doesn't mean we should continue to do so. 

> In this way, when executing lspci, the vendor id and device id will appear
> in the line corresponding to the pci brdge device.

That's the RP though, isn't it?

There is one difference in location though. If the properties are in the 
RP, then they should be handled by the PCI core and override what's read 
from the RP registers. If the properties are in the host bridge node, 
then the host bridge driver sets the values in some host bridge specific 
registers (or has a way to make read-only regs writeable) which get 
reflected in the RP registers. So perhaps in the host bridge is the 
correct place.

Rob


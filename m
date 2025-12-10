Return-Path: <linux-pci+bounces-42895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973ACB319B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7944A31E3DB1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B122836C;
	Wed, 10 Dec 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xlD3jQxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E82550AF;
	Wed, 10 Dec 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375231; cv=none; b=aXt4xk/DJ0xRvKAmAYwnoiFpiJn6zatB6Mq4eI2/pOSGW8otYX3cE0ssGyZbJ/+I+r5soJ1SaNmL9JGf+RL8H/dJm40tZcUK16kR0BVF+n+6Cw65cn6Lj0hun/8BI4VAamOJrfu7Xb22SmWMOjfpxHFp2vdcbI4nVq1QU3FMaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375231; c=relaxed/simple;
	bh=213xvvKw+KcMkbfNNx/xEz6/7azqwpoGlh82nFszIJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsw8JQmfijdYHOXpzjNmtASdFyhUjhhALa++y2AZjyu066duxHmpQVSC/UGkxNFd7AwColB2kYHAHGj8Snue0wOaycEGn+VgfczDXe57QNBckndbDsimR9SL39kZk3ZAiBqcmepNn75+Am3Tls9b234Howj92NouXJrv4O0YNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xlD3jQxI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D3C711A1FB4;
	Wed, 10 Dec 2025 14:00:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A53B660714;
	Wed, 10 Dec 2025 14:00:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD06B119316E1;
	Wed, 10 Dec 2025 15:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765375219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RfiDYueCPJeKqE/+ArtzyxcHtu3CTiq8m2cHHeiLofI=;
	b=xlD3jQxIwSSnAI17fK2hN5n2KBOFn/BJq/7XxQvD9qlWNaTp7F/o0c4kyi4Ts6kVRWvUoD
	/FAFOFrLVmHGk3u38OUd4MX+O89OGSlDHslNeQgYN7OjO68VplvSayMARB+LwCGoXeZoZ8
	84rQIdDOCm5kuuh4NkLqVlnzV0pfFoGSXfpzKIQIeqPnS5D9CKjiqL42Q/JMqs8gsNhOGu
	8sQ6VYnncde1/BlGfmr/S6W+wuR077E3aRHYMFZtQCxR1nje9B8NR3Wu7vfV/88pBIDoie
	yWHILcLeMoMGc5NS2jMKtwDXdVHPEVFmOrvgb7HUq5ptn3zLxcudNgXCgb02pA==
Date: Wed, 10 Dec 2025 15:00:08 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
 mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>, Phil Elwell
 <phil@raspberrypi.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix
 DTC warning
Message-ID: <20251210150008.2ef2f8c4@bootlin.com>
In-Reply-To: <aThp99OfgAfNFUX-@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
	<4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
	<aKc5nMT1xXpY03ip@apocalypse>
	<e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>
	<aLVePQRfU4IB1zK8@apocalypse>
	<CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com>
	<aThjYt3ux0U-9-3A@apocalypse>
	<aThp99OfgAfNFUX-@apocalypse>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrea,

On Tue, 9 Dec 2025 19:27:03 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> [+cc Herve]
> 
> On 18:58 Tue 09 Dec     , Andrea della Porta wrote:
> > Hi Rob,
> > 
> > On 11:09 Thu 04 Dec     , Rob Herring wrote:  
> > > On Mon, Sep 1, 2025 at 3:48 AM Andrea della Porta <andrea.porta@suse.com> wrote:  
> > > >
> > > > Hi Krzysztof,
> > > >
> > > > On 08:50 Fri 22 Aug     , Krzysztof Kozlowski wrote:  
> > > > > On 21/08/2025 17:22, Andrea della Porta wrote:  
> > > > > > Hi Krzysztof,
> > > > > >
> > > > > > On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:  
> > > > > >> On 12/08/2025 10:50, Andrea della Porta wrote:  
> > > > > >>> The devicetree compiler is complaining as follows:
> > > > > >>>
> > > > > >>> arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> > > > > >>> /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)  
> > > > > >>
> > > > > >> Please trim the paths.  
> > > > > >
> > > > > > Ack.
> > > > > >  
> > > > > >>  
> > > > > >>>
> > > > > >>> Add the optional node that fix this to the DT binding.
> > > > > >>>
> > > > > >>> Reported-by: kernel test robot <lkp@intel.com>
> > > > > >>> Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> > > > > >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > > >>> ---
> > > > > >>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> > > > > >>>  1 file changed, 9 insertions(+)
> > > > > >>>
> > > > > >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > >>> index 812ef5957cfc..7d8ba920b652 100644
> > > > > >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > >>> @@ -126,6 +126,15 @@ required:
> > > > > >>>  allOf:
> > > > > >>>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > >>>    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > > > > >>> +  - if:
> > > > > >>> +      properties:
> > > > > >>> +        compatible:
> > > > > >>> +          contains:
> > > > > >>> +            const: brcm,bcm2712-pcie
> > > > > >>> +    then:
> > > > > >>> +      properties:
> > > > > >>> +        rp1_nexus:  
> > > > > >>
> > > > > >> No, you cannot document post-factum... This does not follow DTS coding
> > > > > >> style.  
> > > > > >
> > > > > > I think I didn't catch what you mean here: would that mean that
> > > > > > we cannot resolve that warning since we cannot add anything to the
> > > > > > binding?  
> > > > >
> > > > > I meant, you cannot use a warning from the code you recently introduced
> > > > > as a reason to use incorrect style.
> > > > >
> > > > > Fixing warning is of course fine and correct, but for the code recently
> > > > > introduced and which bypassed ABI review it is basically like new review
> > > > > of new ABI.
> > > > >
> > > > > This needs standard review practice, so you need to document WHY you
> > > > > need such node. Warning is not the reason here why you are doing. If
> > > > > this was part of original patchset, like it should have been, you would
> > > > > not use some imaginary warning as reason, right?
> > > > >
> > > > > So provide reason why you need here this dedicated child, what is that
> > > > > child representing.  
> > > >
> > > > Ack.
> > > >  
> > > > >
> > > > > Otherwise I can suggest: drop the child and DTSO, this also solves the
> > > > > warning...  
> > > >
> > > > This would not fix the issue: it's the non overlay that needs the specific
> > > > node. But I got the point, and we have a solution for that (see below).
> > > >  
> > > > >  
> > > > > >
> > > > > > Regarding rp1_nexus, you're right I guess it should be
> > > > > > rp1-nexus as per DTS coding style.
> > > > > >  
> > > > > >>
> > > > > >> Also:
> > > > > >>
> > > > > >> Node names should be generic. See also an explanation and list of
> > > > > >> examples (not exhaustive) in DT specification:
> > > > > >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation  
> > > > > >
> > > > > > In this case it could be difficult: we need to search for a DT node  
> > > > >
> > > > > Search like in driver? That's wrong, you should be searching by compatible.  
> > > >
> > > > Thanks for the hint. Searching by compatble is the solution.  
> > > 
> > > No, it is not.  
> > 
> > This is partly true, indeed. On one side there's the need to avoid a
> > specific node name ('rp1_nexus'), so the only other unique identifier would
> > be the compatible string ('pci1de4,1' in this case, which identifies that specific
> > device). Unfortunately, the same compatible string is also assigned to the pci
> > endpoint node filled automatically by enabling CONFIG_PCI_DYNAMIC_OF_NODES.
> > We would end up with two nodes with the same compatible, which is not unique
> > anymore. 
> > This applies only when using 'full' dtb (bcm2712-rpi-5-b.dtb) *and* you enable
> > CONFIG_PCI_DYNAMIC_OF_NODES, the latter being not necessary since the overlay dtb
> > (...-ovl-rp1.dtb) is not in use here. To overcome this problem, the solutions
> > I can think of are the following:
> > 
> > 1- Just disable CONFIG_PCI_DYNAMIC_OF_NODES should work, but only when using the
> >    full dtb version. However, if the user enable that option for debug or to use
> >    the overlay dtb version, he better be sure not to use teh full dtb or it won't
> >    work.
> >    This solution seems really weak.
> > 
> > 2- Add another compatible string other than 'pci1de4,1', so it will be really
> >    unique.
> >   
> > >   
> > > > >  
> > > > > > starting from the DT root and using generic names like pci@0,0 or
> > > > > > dev@0,0 could possibly led to conflicts with other peripherals.
> > > > > > That's why I chose a specific name.  
> > > > >
> > > > > Dunno, depends what can be there, but you do not get a specific
> > > > > (non-generic) device node name for a generic PCI device or endpoint.  
> > > >
> > > > I would use 'port' instead of rp1-nexus. Would it work for you?  
> > > 
> > > Do you still plan to fix this? This is broken far worse than just the node name.  
> > 
> > Yes, if we want to get rid of that nasty warning and comply with DT guidelines,
> > I think I really need to fix that.
> >   
> > > 
> > > The 'rp1_nexus' node is applied to the PCI host bridge. That's wrong
> > > unless this is PCI rather than PCIe. There's the root port device in
> > > between.
> > > 
> > > The clue that things are wrong are start in the driver here:
> > > 
> > > rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
> > > if (!rp1_node) {
> > >   rp1_node = dev_of_node(dev);
> > >   skip_ovl = false;
> > > }

I don't fully understand what you want to do.

This piece of code is present in the drivers/misc/rp1/rp1_pci.c driver.
This driver is used when a specific PCI device is available on the system.
This device is PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0)

In order to work, the driver needs either CONFIG_PCI_DYNAMIC_OF_NODES or
having the full PCI hierarchy described in the DT leading to this device.
Indeed, it needs a DT node related to the PCI device.

I don't understand why rp1_nexus should be described at the PCI controller
root level.

Only PCI devices (or bridges as they are particular devices) at this level
as decribed in the pci-bus-common.yaml binding [1].

If the purpose of this 'rp1_nexus' node is to only avoid the application of
the overlay, even if I don't understand why, you should search for something
added by the overlay and not for the 'rp1_nexus' node in the whole DT.

Instead of:
  rp1_node = of_find_node_by_name(NULL, "rp1_nexus");

You should search for a sub-node added by the overlay. Something like the
following for instance:
--- 8< ---
int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
	struct device_node *np;

	np = dev_of_node(&pdev->dev);

	...
	if ( np && of_find_node_by_name(np, "pci-ep-bus@1");
        ...
}
--- 8< ---

If you really want to be sure that the "pci-ep-bus@1" comes from an overlay
you can check for the OF_OVERLAY flag.
--- 8< ---
  node = of_find_node_by_name(np, "pci-ep-bus@1");
  if (node && of_node_check_flag(node, OF_OVERLAY))
--- 8< ---

Also your overlay has to be applied on the DT node related to your PCI
device and not the rp1_nexus you search for in the whole DT. In other
word, in your driver, the following is not correct:

   err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id,
                                           rp1_node);

It should be:

   err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id,
                                           dev_of_node(&pdev->dev));
 
In your overlay, your have
	__overlay__ {
		compatible = "pci1de4,1";
		#address-cells = <3>;
		#size-cells = <2>;
		interrupt-controller;
		#interrupt-cells = <2>;

		#include "arm64/broadcom/rp1-common.dtsi"
       };

Only sub-nodes should be present (#address-cells = <3> and #size-cells = <2>)
can be there just to make DTC happy.

It is worth noting that any properties other than #address-cells and
#size-cells lead to memleaks. And so avoid them.

Memleaks are reported at runtime when the overlay is applied with this
kind of logs:
 OF: overlay: WARNING: memory leak will occur if overlay removed, property: ...

I am pretty sure that you have those kind of traces when you apply your
overlay.

compatible, interrupt-controller and #interrupt-cells should not be added by
the overlay. Either they are added by when PCI nodes are created by 
CONFIG_PCI_DYNAMIC_OF_NODES either they are already available in the base
DT if the PCI device is described in the base DT.

[1] https://github.com/devicetree-org/dt-schema/blob/aa859412ce8e38c63bb13fa55c5e1c6ba66a8e3b/dtschema/schemas/pci/pci-bus-common.yaml#L226

Best regards,
Hervé


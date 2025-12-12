Return-Path: <linux-pci+bounces-42994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F4CB8A6D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3E7304A7C2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90E3191CE;
	Fri, 12 Dec 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bbqFUS6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8E2C21C9
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536619; cv=none; b=rL0wEHtJnbqlzyKd7qi9YRqwkyZFnPYVNIUAJSzP81y1ZAUPV1QTbVLji2b7VJakAeYq5o/DMlEv+k67Ynz+ugyKFnChfqzfG/jtiwY2ZPltnocSVozSS1wLxWODG3mymoO15Jo+F+aLW/gyXg2jetOv244NydWttHR+ZcxzXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536619; c=relaxed/simple;
	bh=bHhkHahOZRRfzsqNDJSbsheb/JFACeIuxmaqOTjfSx4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjKGp7uSfLJXvF/WLrv5a8dAU3+Ey1Ivjre/aCCTWC8KPJer3c2m7e5DiZWi8+FzSx9NvYaQp67pxx22XXKCf2a8mz1FQK5Untt0sk/AqENB89P9nvTuBHqvG2F/lGFaxjWuEG5JLSfEewY7VXL46RzW9KyQ+ZQm221Zewmd47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bbqFUS6Z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6499159273dso1287745a12.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 02:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765536614; x=1766141414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oH5Dsb1naLnW7dWzGXhlOLJ/pnzetkUvxVuR5fJQEFg=;
        b=bbqFUS6ZTv7RSzfNGgdIhiGIPInpCmZgbNUi3OZmoOGknwqA7KZnfHHw0MfUJ10zL+
         MhF17O+xJSVpPJA8BcOgLdkoQtGBWXsEV42wzR1MMAhss95zIZK7+ne4hDtmVlUiyXnA
         gvioxLNsmkB0zV2chgj8fsAkxMhA6ATpGj9trw5glzoKes+N2XAxWe5OydnKnkyspMWB
         ksHmNWgCbEYb9lrZQoYPMHVa5O7bqO/2op3qa4EB0EKZ7HSHH9Rro0l5wJAtEd3Wnakb
         q1Brirmsnb9fpCyVSNN5179qlIpNfG8T6x9iI2t3NAsaBp45YTbmIB/fU07eoxYWZl0w
         kY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765536614; x=1766141414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH5Dsb1naLnW7dWzGXhlOLJ/pnzetkUvxVuR5fJQEFg=;
        b=FD45maKDID/lo/rWRt1dSv5pST5VpWRiLewOpJO1F8hl7KJ8l2/28uPP8Hc/jYtmP4
         WfQ7c6us3liOsuS7Wo3vATUSi8tONndN98z/xAiFTlK6E6KgDHFpskqtc8hQfbVJfKsX
         gXS0/0p/FUTy8JyqrJBcJnXwd4q65eoX5D6ppVoPuPP/n7vc1ktP3atibMuffAYL965J
         23o9na1T+ncTkaqXs+U+wVaSfeNbeBu+K0zl1our+aDv//SIlyUeTLgVnexpMUO+oIuR
         nZWNPSUUHq8n2N7O8AZMlg7pTkIJQLucDpB78CNOGVX33iShuQEasl58avowQo2zxOUW
         4Buw==
X-Forwarded-Encrypted: i=1; AJvYcCWSbPFfjT0TMvJeDYs/nkhOmg2tyc2ONW9yDFvfn3sm51egbGXLxoo3ibA+NU5eZk+IcpCsvOJlD58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EgAvrUJzD1iSGbDViU0PeboCRvWFfutm38IxWeRbbul50xdH
	mzjeGFmqYD/w3qf7BQKdf+SXpnKzjPXYLsXK37m7bLiZyoUJ38R0rWnBtnrYzuhePLw=
X-Gm-Gg: AY/fxX6F316qYv+3IucJ7RVWqhLuIQgAn8v9QBdxooEimjEp/SMbFmbVZhAODS1A+6g
	7JxQrrJ0AccV4q5qpg1sh+wwLqZz6KzZISIx8VWTjAmjtQt1sBrc0rPH2iNPbx7Nt121/mcQlpF
	hTG4Fr9f+4ukLPw0mfHfftBX8MJzBHnb33tsH1KsZGWLvIKA6D5VXEKRD9d+ljdMFtSyXJYEIWI
	K0PPUZG12tg4M+b7ag6q51JsPg+ZoAktkmALtgs8qgz0dKP9so6KA6Esd6AgHe7freisSMiId9Y
	xx1OxJazBCY1lBVgQWpIQxwaJYPseti06JYSZvrchUnMcwXO40S/yuo7IvfQFHNzhqlEEt5SAoQ
	PrIh8c/6FB/uEV2Zi4fm1qKQD50SNQHdOD8Zvd9MCPHJ1SQkoHFX33Qx8oOyXf+uTjaM8PgnmU+
	1Vp/Vf+1jwDNDVrpUt/Irvw814tu8EHjg5LIkOYdZqJ56scjGcJ2cHaA==
X-Google-Smtp-Source: AGHT+IGck4kKwwuc5UddoonnynVhYKwpmHQM5vRIV3zz1AKvip50OdgKpOlRUBUIDMMPxx61FIjoTg==
X-Received: by 2002:a05:6402:3551:b0:649:8378:994a with SMTP id 4fb4d7f45d1cf-6499b07e4b6mr1530658a12.0.1765536613938;
        Fri, 12 Dec 2025 02:50:13 -0800 (PST)
Received: from localhost (host-87-6-211-245.retail.telecomitalia.it. [87.6.211.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm4861010a12.29.2025.12.12.02.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:50:13 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 12 Dec 2025 11:52:44 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
	mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC
 warning
Message-ID: <aTvz_OeVnciiqATz@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
 <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
 <aKc5nMT1xXpY03ip@apocalypse>
 <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>
 <aLVePQRfU4IB1zK8@apocalypse>
 <CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com>
 <aThjYt3ux0U-9-3A@apocalypse>
 <aThp99OfgAfNFUX-@apocalypse>
 <20251210150008.2ef2f8c4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210150008.2ef2f8c4@bootlin.com>

Hi Herve, Rob,

On 15:00 Wed 10 Dec     , Herve Codina wrote:
> Hi Andrea,
> 
> On Tue, 9 Dec 2025 19:27:03 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > [+cc Herve]
> > 
> > On 18:58 Tue 09 Dec     , Andrea della Porta wrote:
> > > Hi Rob,
> > > 
> > > On 11:09 Thu 04 Dec     , Rob Herring wrote:  
> > > > On Mon, Sep 1, 2025 at 3:48 AM Andrea della Porta <andrea.porta@suse.com> wrote:  
> > > > >
> > > > > Hi Krzysztof,
> > > > >
> > > > > On 08:50 Fri 22 Aug     , Krzysztof Kozlowski wrote:  
> > > > > > On 21/08/2025 17:22, Andrea della Porta wrote:  
> > > > > > > Hi Krzysztof,
> > > > > > >
> > > > > > > On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:  
> > > > > > >> On 12/08/2025 10:50, Andrea della Porta wrote:  
> > > > > > >>> The devicetree compiler is complaining as follows:
> > > > > > >>>
> > > > > > >>> arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> > > > > > >>> /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)  
> > > > > > >>
> > > > > > >> Please trim the paths.  
> > > > > > >
> > > > > > > Ack.
> > > > > > >  
> > > > > > >>  
> > > > > > >>>
> > > > > > >>> Add the optional node that fix this to the DT binding.
> > > > > > >>>
> > > > > > >>> Reported-by: kernel test robot <lkp@intel.com>
> > > > > > >>> Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> > > > > > >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > > > >>> ---
> > > > > > >>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> > > > > > >>>  1 file changed, 9 insertions(+)
> > > > > > >>>
> > > > > > >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > >>> index 812ef5957cfc..7d8ba920b652 100644
> > > > > > >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > >>> @@ -126,6 +126,15 @@ required:
> > > > > > >>>  allOf:
> > > > > > >>>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > >>>    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > > > > > >>> +  - if:
> > > > > > >>> +      properties:
> > > > > > >>> +        compatible:
> > > > > > >>> +          contains:
> > > > > > >>> +            const: brcm,bcm2712-pcie
> > > > > > >>> +    then:
> > > > > > >>> +      properties:
> > > > > > >>> +        rp1_nexus:  
> > > > > > >>
> > > > > > >> No, you cannot document post-factum... This does not follow DTS coding
> > > > > > >> style.  
> > > > > > >
> > > > > > > I think I didn't catch what you mean here: would that mean that
> > > > > > > we cannot resolve that warning since we cannot add anything to the
> > > > > > > binding?  
> > > > > >
> > > > > > I meant, you cannot use a warning from the code you recently introduced
> > > > > > as a reason to use incorrect style.
> > > > > >
> > > > > > Fixing warning is of course fine and correct, but for the code recently
> > > > > > introduced and which bypassed ABI review it is basically like new review
> > > > > > of new ABI.
> > > > > >
> > > > > > This needs standard review practice, so you need to document WHY you
> > > > > > need such node. Warning is not the reason here why you are doing. If
> > > > > > this was part of original patchset, like it should have been, you would
> > > > > > not use some imaginary warning as reason, right?
> > > > > >
> > > > > > So provide reason why you need here this dedicated child, what is that
> > > > > > child representing.  
> > > > >
> > > > > Ack.
> > > > >  
> > > > > >
> > > > > > Otherwise I can suggest: drop the child and DTSO, this also solves the
> > > > > > warning...  
> > > > >
> > > > > This would not fix the issue: it's the non overlay that needs the specific
> > > > > node. But I got the point, and we have a solution for that (see below).
> > > > >  
> > > > > >  
> > > > > > >
> > > > > > > Regarding rp1_nexus, you're right I guess it should be
> > > > > > > rp1-nexus as per DTS coding style.
> > > > > > >  
> > > > > > >>
> > > > > > >> Also:
> > > > > > >>
> > > > > > >> Node names should be generic. See also an explanation and list of
> > > > > > >> examples (not exhaustive) in DT specification:
> > > > > > >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation  
> > > > > > >
> > > > > > > In this case it could be difficult: we need to search for a DT node  
> > > > > >
> > > > > > Search like in driver? That's wrong, you should be searching by compatible.  
> > > > >
> > > > > Thanks for the hint. Searching by compatble is the solution.  
> > > > 
> > > > No, it is not.  
> > > 
> > > This is partly true, indeed. On one side there's the need to avoid a
> > > specific node name ('rp1_nexus'), so the only other unique identifier would
> > > be the compatible string ('pci1de4,1' in this case, which identifies that specific
> > > device). Unfortunately, the same compatible string is also assigned to the pci
> > > endpoint node filled automatically by enabling CONFIG_PCI_DYNAMIC_OF_NODES.
> > > We would end up with two nodes with the same compatible, which is not unique
> > > anymore. 
> > > This applies only when using 'full' dtb (bcm2712-rpi-5-b.dtb) *and* you enable
> > > CONFIG_PCI_DYNAMIC_OF_NODES, the latter being not necessary since the overlay dtb
> > > (...-ovl-rp1.dtb) is not in use here. To overcome this problem, the solutions
> > > I can think of are the following:
> > > 
> > > 1- Just disable CONFIG_PCI_DYNAMIC_OF_NODES should work, but only when using the
> > >    full dtb version. However, if the user enable that option for debug or to use
> > >    the overlay dtb version, he better be sure not to use teh full dtb or it won't
> > >    work.
> > >    This solution seems really weak.
> > > 
> > > 2- Add another compatible string other than 'pci1de4,1', so it will be really
> > >    unique.
> > >   
> > > >   
> > > > > >  
> > > > > > > starting from the DT root and using generic names like pci@0,0 or
> > > > > > > dev@0,0 could possibly led to conflicts with other peripherals.
> > > > > > > That's why I chose a specific name.  
> > > > > >
> > > > > > Dunno, depends what can be there, but you do not get a specific
> > > > > > (non-generic) device node name for a generic PCI device or endpoint.  
> > > > >
> > > > > I would use 'port' instead of rp1-nexus. Would it work for you?  
> > > > 
> > > > Do you still plan to fix this? This is broken far worse than just the node name.  
> > > 
> > > Yes, if we want to get rid of that nasty warning and comply with DT guidelines,
> > > I think I really need to fix that.
> > >   
> > > > 
> > > > The 'rp1_nexus' node is applied to the PCI host bridge. That's wrong
> > > > unless this is PCI rather than PCIe. There's the root port device in
> > > > between.
> > > > 
> > > > The clue that things are wrong are start in the driver here:
> > > > 
> > > > rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
> > > > if (!rp1_node) {
> > > >   rp1_node = dev_of_node(dev);
> > > >   skip_ovl = false;
> > > > }
> 
> I don't fully understand what you want to do.
> 
> This piece of code is present in the drivers/misc/rp1/rp1_pci.c driver.
> This driver is used when a specific PCI device is available on the system.
> This device is PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0)
> 
> In order to work, the driver needs either CONFIG_PCI_DYNAMIC_OF_NODES or
> having the full PCI hierarchy described in the DT leading to this device.
> Indeed, it needs a DT node related to the PCI device.
> 
> I don't understand why rp1_nexus should be described at the PCI controller
> root level.
> 
> Only PCI devices (or bridges as they are particular devices) at this level
> as decribed in the pci-bus-common.yaml binding [1].

Ack. As you and Rob pointed out, I will amend the full DT hierarchy with the
PCI nodes in the way as they are dynamically created by CONFIG_PCI_DYNAMIC_OF_NODES.

> 
> If the purpose of this 'rp1_nexus' node is to only avoid the application of
> the overlay, even if I don't understand why, you should search for something
> added by the overlay and not for the 'rp1_nexus' node in the whole DT.

I cannot search for something added by the overlay if I need to choose whether
to apply the overlay or not in teh first place (iIOW the overlay is not yet loaded).
This is not of a concern however, since I'm planning to get rid of the overlay
for reasons already explained here [1]. This will not only solve all of this
problems but it will also address Rob's concern of not relying on 
CONFIG_PCI_DYNAMIC_OF_NODES.

> 
> Instead of:
>   rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
> 
> You should search for a sub-node added by the overlay. Something like the
> following for instance:
> --- 8< ---
> int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
> 	struct device_node *np;
> 
> 	np = dev_of_node(&pdev->dev);
> 
> 	...
> 	if ( np && of_find_node_by_name(np, "pci-ep-bus@1");
>         ...
> }
> --- 8< ---
> 
> If you really want to be sure that the "pci-ep-bus@1" comes from an overlay
> you can check for the OF_OVERLAY flag.
> --- 8< ---
>   node = of_find_node_by_name(np, "pci-ep-bus@1");
>   if (node && of_node_check_flag(node, OF_OVERLAY))
> --- 8< ---
> 
> Also your overlay has to be applied on the DT node related to your PCI
> device and not the rp1_nexus you search for in the whole DT. In other
> word, in your driver, the following is not correct:
> 
>    err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id,
>                                            rp1_node);
> 
> It should be:
> 
>    err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id,
>                                            dev_of_node(&pdev->dev));
>  
> In your overlay, your have
> 	__overlay__ {
> 		compatible = "pci1de4,1";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		interrupt-controller;
> 		#interrupt-cells = <2>;
> 
> 		#include "arm64/broadcom/rp1-common.dtsi"
>        };
> 
> Only sub-nodes should be present (#address-cells = <3> and #size-cells = <2>)
> can be there just to make DTC happy.
> 
> It is worth noting that any properties other than #address-cells and
> #size-cells lead to memleaks. And so avoid them.
> 
> Memleaks are reported at runtime when the overlay is applied with this
> kind of logs:
>  OF: overlay: WARNING: memory leak will occur if overlay removed, property: ...
> 
> I am pretty sure that you have those kind of traces when you apply your
> overlay.

Indeed.

Many thanks,
Andrea

[1] - https://lore.kernel.org/all/aTvtr5v4DjuqctdY@apocalypse/

> 
> compatible, interrupt-controller and #interrupt-cells should not be added by
> the overlay. Either they are added by when PCI nodes are created by 
> CONFIG_PCI_DYNAMIC_OF_NODES either they are already available in the base
> DT if the PCI device is described in the base DT.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/aa859412ce8e38c63bb13fa55c5e1c6ba66a8e3b/dtschema/schemas/pci/pci-bus-common.yaml#L226
> 
> Best regards,
> Hervé


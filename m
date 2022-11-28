Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA263B4E4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiK1WjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 17:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiK1WjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 17:39:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37827B0D;
        Mon, 28 Nov 2022 14:39:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669675161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+UGv7VC5HMGlrxxyoqmeanzHAHeNeTk4zGAjjF1eag=;
        b=QQdbDaUs4b/mblLU59gl1oxkKxGJ7BQGdOGRFGol7xy9OT40cc78djrAImuk70Yxf2QK+x
        HC24Pt1/5H1tiMuKSEmw580fSBnBHMMCliSWDbufvQeMySpDssf+Q2RBNkALk1wsOpdW8h
        SBFD7jC/PWnDMaaZOejsp96PDCtr5YOubbIGIzQ1xaZhxR3jXBlwvj0sdwnwcrFE4jKRmT
        GGfr+LQADVI7pFmEeCFGpSLlt3Dc60rkrJEe2S3dLGpy9fZbGrjyXmakJXPoguOmfgsK0G
        mijksubxgH07ygg6IXCvJwGqSEjbwpeZpOSHt1W3rDwHEkJcK5wvMu/F0yjE/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669675161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+UGv7VC5HMGlrxxyoqmeanzHAHeNeTk4zGAjjF1eag=;
        b=C3Q8q8XKZ9rSjpMwBKIGxAOcrST4QkuE4JYyB6ZVmjIOWr+rHEM/lpcTG7G3wYUrCiHBwU
        kSyNfBFKwK7LvJCQ==
To:     Frank Li <frank.li@nxp.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using
 platform MSI as doorbell
In-Reply-To: <HE1PR0401MB2331DA6C4A52272B08E1661D88139@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-3-Frank.Li@nxp.com> <87wn7evql7.ffs@tglx>
 <HE1PR0401MB2331DA6C4A52272B08E1661D88139@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Date:   Mon, 28 Nov 2022 23:39:20 +0100
Message-ID: <87r0xmvh47.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Frank!

On Mon, Nov 28 2022 at 21:25, Frank Li wrote:

Can you please fix your mail client to not copy the whole CC list into
the reply? It's just pointless noise. A simple:

On Mon, Nov 28 200 at 1:15 PM Thomas Gleixner wrote:

instead of:

>> -----Original Message-----
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, November 28, 2022 1:15 PM
>> To: Frank Li <frank.li@nxp.com>; lpieralisi@kernel.org
>> Cc: Frank Li <frank.li@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
>> bhelgaas@google.com; devicetree@vger.kernel.org; festevam@gmail.com;
>> imx@lists.linux.dev; jdmason@kudzu.us; kernel@pengutronix.de;
>> kishon@ti.com; krzysztof.kozlowski+dt@linaro.org; kw@linux.com; linux-
>> arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
>> kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>> lorenzo.pieralisi@arm.com; lznuaa@gmail.com;
>> manivannan.sadhasivam@linaro.org; maz@kernel.org; ntb@lists.linux.dev;
>> Peng Fan <peng.fan@nxp.com>; robh+dt@kernel.org;
>> s.hauer@pengutronix.de; shawnguo@kernel.org
>> Subject: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using platform
>> MSI as doorbell

is completely sufficient.

>> Caution: EXT Email

We are neither interested in the oddities of NXP's mail categorization system.

>> On Thu, Nov 24 2022 at 00:50, Frank Li wrote:
>> >
>> > Using platform MSI interrupt controller as endpoint(EP)'s doorbell.
>> 
>> Can you please explain what the MSI controller is in this picture? MSI
>> controller is not a term which is common in the interrupt handling
>> landscape despite the fact that it's pretty wide spread in device tree
>> bindings presumably through intensive copy & pasta cargo cult.
>
> I use irq-imx-mu-msi to do test. I supposed it should work for all kinds
> general msi controller.

Sure it works by some definition of "works" because obviously that
implementation does not care about where a particular message originates
from.

But that's still wrong at the conceptual level because it very much
matters where a message originates from. PCIe devices and general
platform devices have very distinct mechanisms to transport that
information.

Just because it "works" does not prove that it is correct.

How are you going to do proper shielding with that approach?

> Our test platform have not GIC ITS supported yet.

And therefore the originating device is irrelevant, right? Get to the
point where you have ITS and it all falls apart.

>> You're explaining what the code does, but fail to explain the underlying
>> mechanisms.
>> 
>> Platform MSI is definitely the wrong mechanism here. Why?
>
> This patch use Platform MSI.  I never said " Platform MSI is
> definitely the wrong mechanism here".

I did not claim that _you_ said that. _I_ said that this is wrong. See
above.

> Base logic is that, get msi controller's message address by irq API. 
> Map this physical address to DB BAR,  so PCI host write this DB bar, then
> EP generate irq.

Again, you are explaining what your implementation is doing, but you are
not describing the conceptual level.

>> This is about a PCIe endpoint, which is usually handled by a PCI/MSI
>> interrupt domain. Obviously this usage does not fit into the way how the
>> "global" PCI/MSI domains work.
>
> PCI endpoint have not standard PCI configure space to enable/disable MSI irq and
> MSI address (CAP 05).

I'm very well aware of the fact that a PCI endpoint does not have the
standard MSI configuration space mechanism.

>  That's reason why need "platform msi", or you called "global"

Again: platform MSI does not convey the PCIe device originator. It might
be irrelevant for your actual platform, but that does not make it more
correct. Once you have the need to track the origin of a MSI message
then the distinction between platform and MSI matters.

Sure you can argue that you don't care, but that does neither make it
correct nor future proof and there is no point to rework this whole
thing 6 month down the road when you actually have to support GIC-ITS.

>> There is upcoming work and at least the generic parts should show up in
>> 6.2 which addresses exactly the problem you are trying to solve:
>> 
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Fall%2F20221124225331.464480443%40linutronix.de&amp;data
>> =05%7C01%7CFrank.Li%40nxp.com%7C6a07e33e56af45ffc1ff08dad174d02d
>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6380525969049530
>> 06%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Q8jr
>> eVGGLa2M4yhjGO7Njqwdm59XDC0GyLEwkr0k6B0%3D&amp;reserved=0
>> 
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Fall%2F20221124230505.073418677%40linutronix.de&amp;data
>> =05%7C01%7CFrank.Li%40nxp.com%7C6a07e33e56af45ffc1ff08dad174d02d
>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6380525969049530
>> 06%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Tc9p
>> XNJ499ETFgNWQBNLViFk8D5GbvrrwYDlBW%2Bf2qg%3D&amp;reserved=0
>> 
>> plus the prove that the platform MSI mess can be replaced by this:
>> 
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Fall%2F20221121135653.208611233%40linutronix.de&amp;data
>> =05%7C01%7CFrank.Li%40nxp.com%7C6a07e33e56af45ffc1ff08dad174d02d
>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6380525969049530
>> 06%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=R5K
>> NVfcGqxoCam%2FYhY57ihsloWGhGLM3Kh9IkyME4lk%3D&amp;reserved=0

Those outlook artifacts are helpful to our conversation in which way?
 
>> NTB in it's current form should never have happened, but that's water
>> down the bridge.
>> 
>> What you really want is:
>> 
>>   1) Convert your platform to the new MSI parent model
>> 
>>   2) Utilize PCI/IMS which is giving you exactly what you need with
>>      proper PCI semantics
>
> Sorry, I still don't understand yet. This patch is just user of msi
> controller.

As I explained to you before: The concept of MSI controller does not
exist in the kernel. It might exist in your NXP nomenclature, but that's
irrelevant here.

> Your patches focus on the msi controller itself. 

No. They focus on changing the hierarchy model from "global" MSI domains
to per device MSI domains so that the weird constructs of platform MSI
can be replaced by something which actually matches the hardware and
provides a proper abstraction for PCIe/NTB at the right level.

> Interface platform_msi_domain_alloc_irqs still exist at your devmsi-v2-part3. 

Sure, but at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm

platform_msi_domain_alloc_irqs() does not exist anymore.

You replied to exactly that series which builds on top of devmsi-v2-part3, no?

So what are you trying to tell me?

Thanks,

        tglx


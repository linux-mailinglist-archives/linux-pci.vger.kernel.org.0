Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D96AB860
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCFIdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 03:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCFIdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 03:33:39 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940859C6;
        Mon,  6 Mar 2023 00:32:56 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B12A160013;
        Mon,  6 Mar 2023 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678091575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/ZPQjlzYg0JfaiO0/4oB8XiADSXmzvhBtxwDwEW0Bk=;
        b=R/RyhS1T/JMtUQQ5qjgPG819pt52mF8yH8I1JDcM+fXpzc91Sea+f6VqlbIbzVo29kNGp1
        hSa0kVC5KuUNJ6l+jjvatuKDkOUyU0bgh3NYxnlJaURSFkY+8QVc5f0H8cEHDTah4fIdNn
        C5YN1TXSj/C7XN4dzgMQ53LnPflrKHt5qHHitmYGj5fa0bE6k5lrWM42H7hP8b9qInV1lp
        qRHn7zAFGdVI8Da8th9ieg0QzSRcjBlJyvwIG5htIJSzyZpxNlmJIwFhRc/Y0SXXhD0ntQ
        jkWM3AgmQyRQ04TcKQTyRiNkHyhT9UfYbCwl5TNfWUdoad6f2p1a9E7DAqJv0Q==
Date:   Mon, 6 Mar 2023 09:35:36 +0100
From:   clement.leger@bootlin.com
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Message-ID: <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
In-Reply-To: <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
 <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023-03-04 00:42, Frank Rowand a =C3=A9crit=C2=A0:
> On 2/27/23 04:31, Cl=C3=A9ment L=C3=A9ger wrote:
>> Le Mon, 27 Feb 2023 00:51:29 -0600,
>> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
>>=20
>>> On 1/19/23 21:02, Lizhi Hou wrote:
>>>> This patch series introduces OF overlay support for PCI devices=20
>>>> which
>>>> primarily addresses two use cases. First, it provides a data driven=20
>>>> method
>>>> to describe hardware peripherals that are present in a PCI endpoint=20
>>>> and
>>>> hence can be accessed by the PCI host. Second, it allows reuse of a=20
>>>> OF
>>>> compatible driver -- often used in SoC platforms -- in a PCI host=20
>>>> based
>>>> system.
>>>>=20
>>>> There are 2 series devices rely on this patch:
>>>>=20
>>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>   2) Microchip LAN9662 Ethernet Controller
>>>>=20
>>>>      Please see:=20
>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@boo=
tlin.com/
>>>>=20
>>>=20
>>>=20
>>>> Normally, the PCI core discovers PCI devices and their BARs using=20
>>>> the
>>>> PCI enumeration process. However, the process does not provide a way=20
>>>> to
>>>> discover the hardware peripherals that are present in a PCI device,=20
>>>> and
>>>> which can be accessed through the PCI BARs. Also, the enumeration=20
>>>> process
>>>=20
>>> I'm confused.  The PCI Configuration Header Registers should describe=20
>>> the
>>> hardware on the PCI card.
>>>=20
>>> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
>>> themselves, so I would like to analyze that case separately), does=20
>>> the
>>> second device, "Microchip LAN9662 Ethernet Controller" properly=20
>>> implement
>>> the PCI Configuration Header Registers?  What additional information=20
>>> is
>>> needed that is not provided in those registers?
>>=20
>> Hi Frank,
>>=20
>> I guess Lizhi wanted to say that it does not provide a way to describe
>> all the "platform" devices that are exposed by this PCI device. Which
>> is of course the whole point of the work we are doing right now. But
>> all the BARs are correctly described by the LAN9662 PCI card.
>>=20
>> Cl=C3=A9ment
>=20
> I remain confused.
>=20
> [RFC 00/10] add support for fwnode in i2c mux system and sfp
> https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>=20
>   references a PCIe driver:
>   [2]
> https://github.com/clementleger/linux/blob/fwnode_support/drivers/mfd/lan=
966x_pci_mfd.c
>=20
> So there is a PCIe driver that works.
>=20
> However, the RFC patch series was proposing adding fwnode support to
> the driver.  My first
> surface reading (just part of that one email, not the entire series or
> the replies yet),
> notes:
>=20
>   ... However, when
>   plugged in a PCIe slot (on a x86), there is no device-tree support=20
> and
>   the peripherals that are present must be described in some other way.
>=20
> I am assuming that the peripherals are what you mentioned above as=20
> '"platform"
> devices'.  This is where my current confusion lies.  Are the "platform"
> devices accessed via the PCI bus or is there some other electrical=20
> connection
> between the host system and the PCIe card?

Hi Frank,

The platform devices exposed by this PCIe card are available via some=20
BAR using PCI memory mapped areas, so it's totally standard PCI stuff.

>=20
> If the "platform" devices are accessed via the PCI bus, then I would=20
> expect them
> to be described by PCI configuration header registers.  Are the PCI
> configuration
> registers to describe the "platform" devices not present?

I'm not sure to understand what you mean here. PCI configuration headers
only provides some basic registers allowing to identify the PCI device
(vendor/product) and some memory areas that are exposed (BAR). They do
not provides the "list" of peripherals that are exposed by the devices,
only some BARs that can be mapped and that allows to access.

In the case of the lan9662 cnetwork controller, BAR 0 and 1 exposes
multiples devices that are located at some subranges of this BAR. For
instance (not accurate), we have the I2C controller located at BAR 0
+ offset 0X1000, then the flexcom controller exposed in BAR 0 at offset
  0x20000, etc. This list of peripheral is not exposed at all by the PCI
configuration headers (since it is not the purpose of course). All of
these peripherals have already existing platform drivers which can then
be reused thanks to the PCI device-tree overlay series.

>=20
> I'll read through the fwnode RFC thread to add to see what happened to
> the proposal.

You can probably read the cover letter which described the use case in=20
details. However, don't spend too much time reading the patchset, we
discarded them for many good reason (way too much modifications in
subsystems, no standardization of software node bindings, etc).

Cl=C3=A9ment


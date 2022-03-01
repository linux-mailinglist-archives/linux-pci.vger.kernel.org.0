Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C014C8CEF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiCANsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 08:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiCANsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 08:48:38 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507B42EE4;
        Tue,  1 Mar 2022 05:47:55 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 713FE240005;
        Tue,  1 Mar 2022 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646142474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRrPp1uZB0kh5zWFtBwsfoTdVbfXLLpz/phEa0HKsbw=;
        b=Xm/2aZt8HvHdhHKirFWJGP25fHbxC0Him+eChWMsG+2ZkvXOZ0HclN3BnZcvKkM/gIJ8Vm
        SI2UTRPEh9h0FUC8D0QfTDZZEuqq3iXMN8pAUxKaQnsW6x8MUrxjFP9U7eTYzvNdaw9xtS
        ZDzRXkl7kxsX36P75QxBmY5r+o2dAwF9Ulgt9bgDDxzy3pXiz8VYYp7+n9580zWs+gIFOS
        IWU2CWWVdSssEGBVFRvkrKGvECDlc8KvVnzkmTfosUIasDbA+AoGigIZ6lAhshTpdTenjw
        1LOQau8ZyVa87VYi/X6+/PKv81PKd4xpyiRZFgAsbecCon1g8T9mc23+y6HQZg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
In-Reply-To: <CAL_JsqJBCyrFpys9xx+TkD4GpW7MvxWr8rXzLARBJ4iOqY_u_g@mail.gmail.com>
References: <20220222155030.988-1-pali@kernel.org>
 <164554589988.5595.5091384618177225445.b4-ty@arm.com>
 <20220222161143.6ryghgtfmhnmhpmz@pali> <20220222161539.GA20114@lpieralisi>
 <20220222161854.7oot5v6xlw2wzmsc@pali> <87h78j0y5m.fsf@BL-laptop>
 <CAL_JsqJBCyrFpys9xx+TkD4GpW7MvxWr8rXzLARBJ4iOqY_u_g@mail.gmail.com>
Date:   Tue, 01 Mar 2022 14:47:53 +0100
Message-ID: <87zgm9zsvq.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob,

> On Mon, Feb 28, 2022 at 10:11 AM Gregory CLEMENT
> <gregory.clement@bootlin.com> wrote:
>>
>> Hello,
>>
>> > + Gregory
>> >
>> > On Tuesday 22 February 2022 16:15:39 Lorenzo Pieralisi wrote:
>> >> On Tue, Feb 22, 2022 at 05:11:43PM +0100, Pali Roh=C3=A1r wrote:
>> >> > On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
>> >> > > On Tue, 22 Feb 2022 16:50:18 +0100, Pali Roh=C3=A1r wrote:
>> >> > > > This patch series extends pci-bridge-emul.c driver to emulate P=
CI Subsystem
>> >> > > > Vendor ID capability and PCIe extended capabilities. And then i=
mplement
>> >> > > > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCI=
e AER
>> >> > > > registers, support for legacy INTx interrupts, configuration fo=
r X1/X4
>> >> > > > mode and usage of new PCI child_ops API.
>> >> > > >
>> >> > > > Changes in v4:
>> >> > > > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
>> >> > > >
>> >> > > > [...]
>> >> > >
>> >> > > I can't apply dts changes, patch 12 should go via the arm-soc tre=
e.
>> >> >
>> >> > Gregory already wrote about this dts change:
>> >> > https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
>> >> > "So the easier is to let merge it through the PCI subsystem with the
>> >> > other patches from this series."
>> >> >
>> >> > Are there any issues with applying this dts change via pci tree?
>> >>
>> >> I don't usually take dts changes through the PCI tree since they
>> >> can conflict with arm-soc, that's the issue - dts changes should
>> >> be managed by platform maintainers.
>> >
>> > Gregory, could you please take patch 12/12?
>> > https://lore.kernel.org/linux-pci/20220222155030.988-13-pali@kernel.or=
g/
>> > You have already Acked-by (see above previous link)
>>
>>
>> Applied on mvebu/dt
>>
>> let's hope the PCI branch will be merged before the ARM branch.
>
> Why does that matter? AIUI, legacy interrupts didn't work before and
> you need both dt and kernel to enable. Or am I misled by the commit
> messages?

Indeed I went too fast, so all should be fine.

Gregory

>
> Rob

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C115A7E1F1F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjKFLCU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Nov 2023 06:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 06:02:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97ED8
        for <linux-pci@vger.kernel.org>; Mon,  6 Nov 2023 03:02:15 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-NNK0qxekP9KmzfnMHlHj9Q-1; Mon, 06 Nov 2023 11:02:13 +0000
X-MC-Unique: NNK0qxekP9KmzfnMHlHj9Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 Nov
 2023 11:02:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 Nov 2023 11:02:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Epping' <david.epping@missinglinkelectronics.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Thread-Topic: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Thread-Index: AQHaC+rcwX/RJWhaCEGpb3NmFV615LBrmEmQgAGENICAAApRcA==
Date:   Mon, 6 Nov 2023 11:02:12 +0000
Message-ID: <531d4fadcc694f9582af54f3998720b4@AcuMS.aculab.com>
References: <ZUDd04c7FXUeusxK@nucnuc.mle>
 <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
 <ZUi8v0GL/urin/Yj@nucnuc.mle>
In-Reply-To: <ZUi8v0GL/urin/Yj@nucnuc.mle>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: David Epping
> Sent: 06 November 2023 10:15
> 
> On Sun, Nov 05, 2023 at 11:20:03AM +0000, David Laight wrote:
...
> > If you are building the FPGA image then all the logic to convert the
> > memory mapped slave cycles (into the fpga logic) is supplied as
> > verilog source.
> 
> The CPU subsystem and the PCIe IP are hard IP in silicon and can not be altered.

If you look carefully you'll find that the 'hard IP' block stops
with a streaming interface that carries the data TLP.
All the logic to convert the TLP into Avalon memory cycles is verilog source.
So, at least in principle, it is modifiable.

With a bit of effort it is possible to trace the TLP into fpga memory.
(We had to modify the verilog to expose the TX TLP.)
Even allowing for development time it was probably cheaper than
buying a PCIe monitor!

> They are connected via the FPGA logic, though, and I agree one approach could be to intercept their
> communication with custom HDL.
> However, Linux uses the exact same PCIe hard IP registers required for IO TLPs to send Config TLPs.
> Every TLP requires multiple accesses to multiple registers, so locking between FPGA logic and Linux
> transactions would be required.
> I'm not saying that this is impossible, but I don't think it can be robust without a Linux software
> change.
> A software only solution has the benefit of being available to all users of such an FPGA, without
> access to that special logic.

I saw/checked you'd added a lock, didn't see it was the same one used
for config space accesses.

> > I thought that all recent endpoints were required [1] to work with
> > just memory BARs - even going back to the later PCI versions.
> > So I'm surprised a PCIe endpoint need an IO BAR.
> 
> The AX99100 implements a so called "Legacy Endpoint" and is thus allowed to
> rely on support for IO space.
> I guess this choice was made to stay driver-compatible to the PCI version,
> although I don't know the ancestry if this product.

A lot of PCI devices solved this by adding a memory BAR that
mapped exactly the same registers.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


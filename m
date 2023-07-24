Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC075EBDB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGXGmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGXGmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:42:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2310E3;
        Sun, 23 Jul 2023 23:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJBVN4UV2TR/UEHL1DNGKL43ojjgHpeKLXDnsYh2p04P6CUvc8uNCLm6PsTZbFB1TrDCtUiooGZTIqrwz77PB4h7SF+xie7FI4JEkw28Z9qVVxPhVO/qR2MeenS6Ylr/mzEnckPRwIGXzHXyJpnG67qzDYlM+i7Dnic9s61TR68/4bZeYPd6cACMcx7bh1GaVRGQ5ZqKehtttohkHCZYgaru0WeullbjaxjIKyaFOkcH4XikUfx5ohCF4Tz96WjPheFPWRcE7wuagWkB684WTwoyQTpoIQTMdcQ1uOOxKDHKIE3An3Xc60DSY4wvjwspNS4gXgPN/mxTL0L2DVJIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43UA7JlcpTA06hLyDIpMtL/pMqAKESi3SM854KBCjIs=;
 b=YhxXtO+gD7Wh04e2im8V1O9Tu+tLAdgWK8Ap9Usp4j6DtMXm1vXqfcFdYKRBFT+wNtoSrAWhCHmM16r+twOV25qOAG00/PeG8jQO0HYpTN/vYo9X57l04EZdYJAusrxoxUUQ7Bo6H/mh3hSLadaJ2bdHpvWQF4nZ1K3VTQRKe8XNDXajGXB880IjbWyMaryhcWqGagqQBYlSDpcie2/fKGBihC2eq9w+y+lDSbNAnqRlYMul5ybcEeLDtlGq6s4fGuN8/02IjwcBv5kydM9GFduHApO69K+fMYRohaXZIPC526pPEK2B7vUAJCVA1CyExxbmy+zqwtgO+HEZCbI6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43UA7JlcpTA06hLyDIpMtL/pMqAKESi3SM854KBCjIs=;
 b=WUXkIikM8K5QJhu9HoPXephQPm+Lrwjgq3tiGtbNP9L5NEtPrtmTtCyJOfiBAp1OORiZKliMkbkF/bZojfkSUV1xRR6paAFE5c4na2KLPclTzd6uRi5EPbhRT/gtj6rxQ9ts1nvWPmj3m1DDCMqT7XC18hAREL6CvhtFQO6cCBY=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 06:40:58 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6609.024; Mon, 24 Jul 2023
 06:40:58 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZqaL5jo83xIbcxUurUITknscIg6+j/xkAgB46QpCAAK/KgIAFqwsw
Date:   Mon, 24 Jul 2023 06:40:58 +0000
Message-ID: <SN7PR12MB72010CF07797580B0B8732EC8B02A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <SN7PR12MB7201A03526C04788709167A48B3EA@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20230720152401.GA523764@bhelgaas>
In-Reply-To: <20230720152401.GA523764@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH0PR12MB8551:EE_
x-ms-office365-filtering-correlation-id: 8fd18bf6-6515-4278-d121-08db8c10f085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HG8fF3BGRrzFqqEvzooer4U/XqAyjOslpP7CCYHvUuE4UKVEZVhwXiSVSWwHLJ6qNEqcS356n3aHILD1+z1fohG8otKDcsTeZXIRHh7CDKMRQ22jje3VXyCyKVXEBpivvWjyB0DAHqc/zA6I7GOcTfndUSXfpxsS0yrSTTUNYHL/9/ZwSBekWGh+vCqUe7uySBgkOhtBCRiWUdxjqVEqteSe7i9fZQ9+BJ0q8C0OUls4yJOtdCXPmdsPXhYWox7LJYsVJRKKvXknZFQ6Pax2v+xFS6UXgn0AaZVBEVencw3Zm7YJk9Jg2oqyyh9PNjDY0gEg8fzorknajdc0VDPqOJhA2feTMB/PAXoah0aJK7Y9OaNSZzMa0wzbeicrimiu0eskw3QdSyVIfJFRGNh16fX1S5KWqYSPnv+0sDfBP9/JEbrA0g20y3updXou7TH7T11F4jsXDG4jedzUnTDmEwl1qUa7jy91r3raszRjDcw5MP5kaC5Lt2+vDL4gYPpCvrOthsCQn/u296VfwctG57nLy6bLvrw1ONQTJi+p+IDWsdPlDL4Bwz8Kxf6EM6RimNqYS2G8y2LY4YC8tFdAvSoTJ1zWhc7tAdq+z7BvE7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(55016003)(966005)(9686003)(122000001)(38100700002)(83380400001)(53546011)(6506007)(186003)(26005)(7416002)(52536014)(33656002)(5660300002)(8676002)(8936002)(41300700001)(2906002)(7696005)(66556008)(71200400001)(38070700005)(66476007)(66446008)(64756008)(6916009)(4326008)(66946007)(76116006)(316002)(478600001)(54906003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPBfF5hFu4u6pGbgFGEDU30z3C1BQSfFa1mzgQJccgNcpTlVt/wE9qVmnjx4?=
 =?us-ascii?Q?zyKFEHaNsiRDjGt6CzT08BGN7X0827g9o8peqKoBpa+djmxR/5H8D8uTHy7g?=
 =?us-ascii?Q?lwc5hyxVLu2cX6uIRU8Dr8yVTt/NlueCwB/2ZbQyDatEHKwYGhWjEE+W2cfc?=
 =?us-ascii?Q?zHXMeV1U5UpIRGuYysMGDV1xIBvbQKUh4mJRW88NxFxZHLDOeO9DJx74uvsg?=
 =?us-ascii?Q?c2ZKgBsbKr/Esubq/X/RfIP+qhFFIywLC8mUjweCSxo+vJabxsdHRPwgk7z2?=
 =?us-ascii?Q?9uQoj0JsHWQdGHXkajZo5Zjlrt9NtS2ghyfuXTN0+rnCBxqgmwPjEYqj0RFK?=
 =?us-ascii?Q?spT0MnZ40wdQvtxufABtt1y8feRE3VFw13HloasDhx0Xi9Rv0SGsgYpAkxaP?=
 =?us-ascii?Q?kGTDxFU/dPSWzJfd6CXnTaljFfqI/pCEXgsOBxFaG00GSOWwhze7pxr9pQIY?=
 =?us-ascii?Q?qsUkuVFIj76Z2BSx9R3jI0S/W0/hAFGBRPUM4DBoPqMMpH8sx4OkSoIs8GDJ?=
 =?us-ascii?Q?SkpplgGwAjshBsqQEdaL4b68lmoibSCektWp33XTPzvDy7r+PpQgU+0pudHE?=
 =?us-ascii?Q?8kf+VNsI2r7rFbfRhcb7gXm3A3hFy29cnNzY7tK6eXGtCA72/faWbllTb8/o?=
 =?us-ascii?Q?JmCQA5n4c3y6Rdjy9/to+lQF0pAU0g+EkFw344rxNLVGNUNAEY4YOORf1RTB?=
 =?us-ascii?Q?IwBH77gdZUIHs1fqLgnT2rFPYO1Dmj8cd7zxuGIMzZvSkxTxArWEuDmFult0?=
 =?us-ascii?Q?yhbCy2dOpNLcGpxdb4ITG1rU2y0wClzSh7xKQpOIsdUQITABeS2s+xKQy02j?=
 =?us-ascii?Q?IxNIVKKAF2wvAExa3WqDTqp62ou1tIeLFreIzcPQ4J6hFIaGNqc6HCSOErHM?=
 =?us-ascii?Q?EHHqZv6cqQ/b6zvk8/WZFqYiYdW+iuj6G2ix3FZe8/Nv5yyLFiOeFis5umIP?=
 =?us-ascii?Q?d/99lUhaM68ZM8/26lsY/yyTgCda4A0t5XgrGOX8VUmyPjiEXGF0OZYDvSzr?=
 =?us-ascii?Q?Odva5npC5NbZXHkgMbrHV/5e35g5Gpr7FJOh3XncsJNdRKVIDliZI15pEkvq?=
 =?us-ascii?Q?p/LLNw5tl4qCA+3Rd5rvrDbOIOoXt8FnSam/Xh8TuHJcXkHp4jI5mcF+Egwl?=
 =?us-ascii?Q?GeqnG3fFqwyJQ/aDZDsiiXbwHXy72RvR/43hCkRYLupls3Q7Ne55ZUEVQWiz?=
 =?us-ascii?Q?YA8UtNtGNnGoeCDXMMkziM/5zklJgWEZp/NdAA+rk5juya4KK0CjqpHFjacz?=
 =?us-ascii?Q?0AmDQZLXyU9iwng7aDL3wgkLcTwV/yWk5lg6E/6FJ2OiDakH7IJAK35JpW42?=
 =?us-ascii?Q?DSurFOHFQEs6UiPElqu8OGlY/ExKZ/pTCqVSF56CIQmmmSWv7Lo1ZMXORrA+?=
 =?us-ascii?Q?N+YWjbuPfGe0TraWZtrqhPzyE+tbqK5lMz0BU+Ds8WD4zmc+lZjXGP28JSKw?=
 =?us-ascii?Q?kXhLC/YbQ6SCQsb96/GNvvsfhMhW8K8e6hoaXdCKUb80F2/fGMmDpq+o5GtQ?=
 =?us-ascii?Q?RxTQtRWxmQNO0bx6f3GHkhTdbMN6uu7dnqXxRv19bLJe014IW6nn3PluF/GS?=
 =?us-ascii?Q?DUwvJtt7/rqw6V74FpI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd18bf6-6515-4278-d121-08db8c10f085
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:40:58.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/v06sh3+Ol5B/s5jPmBoj9NRB7s7P4Fgfjl9yYdemfskGs4tXON9UUaqWCfjG/blvmWM5rh+tmKiTXyVeNBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 20, 2023 8:54 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: krzysztof.kozlowski@linaro.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-arm-
> kernel@lists.infradead.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> [+cc Thomas in case he wants to comment on chained interrupts]
>=20
> On Thu, Jul 20, 2023 at 06:37:03AM +0000, Havalige, Thippeswamy wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > > On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige wrote:
> > > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > > > ...
>=20
> > > > + * struct pl_dma_pcie - PCIe port information
> > > > + * @intx_domain: Legacy IRQ domain pointer
> > > > + * @pldma_domain: PL DMA IRQ domain pointer
> > > > + * @irq_misc: Legacy and error interrupt number
> > > > + * @intx_irq: legacy interrupt number
>=20
> > > "Legacy and error interrupt number" and "legacy interrupt number"
> > > sound like they overlap -- "legacy interrupt number" is part of both.
> > > Is that an error?
> >
> > - Agreed, I'll modify this comment to legacy interrupt number. (This
> > irq line is for both legacy interrupts and error interrupt bits)
>=20
> Does "legacy" mean "INTx" in this context?  If so, I'd use "INTx"
> because it's much more specific.  "Legacy" really doesn't contain any
> information other than "this is something retained for some kind of backw=
ard
> compatibility."
>=20
> If you have more detail about the "error interrupt," that would be useful=
 as
> well.  Does this refer to an AER interrupt, a "System Error", something e=
lse?
> I'm looking at the diagram in PCIe r6.0, Figure 6-3, wondering if this is=
 related
> to anything there.  I suppose likely it's some Xilinx-specific thing?


- Agreed, ll modify Legacy to INTx, and regarding error interrupts these ar=
e Xilinx controller specific interrupts which are used to notify the user a=
bout errors such as cfg timeout, slave unsupported requests,Fatal and non f=
atal error.

> > > > +	/* Plug the INTx chained handler */
> > > > +	irq_set_chained_handler_and_data(port->intx_irq,
> > > > +					 xilinx_pl_dma_pcie_intx_flow, port);
> > > > +
> > > > +	/* Plug the main event chained handler */
> > > > +	irq_set_chained_handler_and_data(port->irq,
> > > > +					 xilinx_pl_dma_pcie_event_flow,
> > > port);
> > >
> > > What's the reason for using chained IRQs?  Can this be done without
> > > them?  I don't claim to understand all the issues here, but it seems
> > > better to avoid chained IRQ handlers when possible:
> > > https://lore.kernel.org/all/877csohcll.ffs@tglx/
>=20
> > - As per the comments in this
> > https://lkml.kernel.org/lkml/alpine.DEB.2.20.1705232307330.2409@nanos/
> > T/ "It is fine to have chained interrupts when bootloader, device tree
> > and kernel under control. Only if BIOS/UEFI comes into play the user
> > is helpless against interrupt storm which will cause system to hangs."
> >
> > We are using ARM embedded platform with Bootloader, Devicetree flow.
>=20
> I read Thomas' comments as "in general it's better to use regular interru=
pts,
> but we can live with chained interrupts if we have control of bootloader,
> device tree, and kernel."
>=20
> I guess my questions are more like:
>=20
>   - Could this be done with either chained interrupts or regular
>     interrupts?
>  - If so, what is the advantage to using chained interrupts?
With regular interrupts, these interrupts are self-consumed interrupts (int=
errupt is handled within driver) but where as chained interrupts are not se=
lf consumed (interrupts are not handled within the driver, but forwarded to=
 different driver for which the actual interrupt is raised) but these inter=
rupts are demultiplexed and forwards interrupt to another subsystem by call=
ing generic_handle_irq().=20

As, MSI generic handlers are consumed by Endpoints and end point drivers, c=
hained handlers forward the interrupt to the specific EP driver (For exampl=
e NVME subsystem or any other subsystem).
>=20
>=20
>
> Across the entire kernel, irq_set_chained_handler_and_data() is relativel=
y
> unusual, which makes me think it may be better to use the more common
> path if it's possible.
>=20
> Bjorn

Regards,
Thippeswamy H

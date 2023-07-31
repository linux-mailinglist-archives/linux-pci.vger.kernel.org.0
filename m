Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09271768BD0
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGaGRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 02:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGaGRi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 02:17:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEC1711;
        Sun, 30 Jul 2023 23:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn2SHKm1wTMS0bpIIN4AnmT/3d2bWgvFfBp12iNhnVrIGQi4Lw4u7wju8ssfzEAR2X9ekFgvCfGXI+ir7idH8hTShY9TK6RFcGUpun2eHaGqbpqkS88r5QHfj65xQkcku/NFFIHytUu4CLXoD8TSkGT9Kcqs99oe78RCJwytheFeiYPcvFs6fHKDgWJNSB427pIe5c+FNS2AYCLqnINDuOw62g7mI+Yzw0v0U1GMpVR+7PudKtgnRa9LxD+J0A46dudCc5jVtlm13/AhIgnUG+qU6WvlTRbyvFlJ6Y/y2HgDwgvj/dxyTt6MkB3t59QH3JQS3H7l4oOmncprVJ8vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trIYJXZn0khOlaVrsqZJzfMXI3kDRRBBsAbuDtKN7Es=;
 b=CsHWFS5QWjxcT0XFSMgvz46POKPAaUuYqNOwppIyHDGKmiem+P5L4NXzDQ9PLSmkbYFFwp8T8AtjihKBBeZLvRC0okzdy0u5pKzVq93c+QjrdYle7ffVOFU37EgmKYIScFHgMUBK4mzgF5kNQ3CdGjVjrXtA2HN+HLkKNqqmvQpMSj3SVNofkuzZNgC4DIdZ9aI1l8hHVRog6zWIjaNMmww93mG2EEZppi+Abda3rW4eWkGlCKLTcsj4emxOIrV/m3m0U3yZGg4NAuwRI/FsmDczLWU6CmkiLQHtTQc7Z6wg7GiZNH6sh21W0vU9tRDZPr2XXMV5UvsLAqzfLSmm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trIYJXZn0khOlaVrsqZJzfMXI3kDRRBBsAbuDtKN7Es=;
 b=bHPQh7bxrUlq0qaBoWiJsXMAnb8tNU36kNET11t9rpHlHDXBJXmZK9LS5Si++hGQAXgsAUp+zrugWv+EzhEwiIYUvtXxL3/94iRTAehfEzUFObDGNQ5U6riMABc680Pu1sXjcndXOgq6MmZxIRZbD+uUEFCVAzwbaQ4OItKUjiE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 06:17:23 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 06:17:23 +0000
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
Thread-Index: AQHZqaL5jo83xIbcxUurUITknscIg6+j/xkAgB46QpCAAK/KgIAFqwswgAXcZgCABSh00A==
Date:   Mon, 31 Jul 2023 06:17:23 +0000
Message-ID: <SN7PR12MB72014A1E38A3D1FAE29C2E088B05A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <SN7PR12MB72010CF07797580B0B8732EC8B02A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20230727232738.GA786642@bhelgaas>
In-Reply-To: <20230727232738.GA786642@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB9127:EE_
x-ms-office365-filtering-correlation-id: 0a50dd3c-21fa-467a-76ea-08db918dce16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZM9nCFhxALY6w5o5V7ztLfuEKNeOjKiZ4EZkcfvnOZ0b9EWcD26k9EoR3hBoAdfEfb2D2DOHGtQnT1WDQK2wSClnpLSIAKEnb3LU0U6Q3YTD9y4/8IKeCeOD2YYphxR154lAuL1/rS6YUjBMfcRRMf33kin9xKMGIo92FJPTt38vidicDmXR+u6SuP9ADx3wE8J7THcip4CKixbN8PJsLITq4A4b5uLGlL8WY/LvpjB1soFxgnb1QhvpELS+h1g5EYmye4fYYTVsDLHNi2RPaTeMSpudVnTJe+qlK7nbQpxH6UPbL5yyDXikY4EuWehnD26uBAtrP/8AMShapo76Zf1w/Y2JsRzXlOKP3cHgXtVdB2Q+BU2HLS3vSeAwEb/o5bgFUPctRNBWzg2iayl/OjD2R4iQbyMM6hcWlADq564ND+tO1mJfEX5i7KYGGeMgBBHhQKYOpUg8dOdFXOAh4MFlw/F+Nym2QWcLzIE5p6RCuK9hAGldmozNRj3tz5OCcH6vfbUgrWvYslaLxjlZRGJl+b7htqfgyMXs0FgpVmRXZE7WlObD+8Jjokvf4Al+CvWU3RipmtZk+1do4ABsgolub9Hgb8QVG0ItDHGIkAE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(966005)(478600001)(71200400001)(7696005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(7416002)(52536014)(5660300002)(76116006)(4326008)(6916009)(64756008)(66446008)(2906002)(66476007)(66556008)(66946007)(54906003)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tr1GLJOEPQbplRy8NwXNJ/Ettz67hyfFaYVApWv2ukn01NbZwMBtYSRIyy2w?=
 =?us-ascii?Q?Mp86caEn0Syvk5h3YhXKeJA3qmes1GPWifK7De68jMylPmACnqix0UOmbHVR?=
 =?us-ascii?Q?GAW/x6RAHgFgBvAeDTFV05qp9PzJAg9NsbriWouVcOLFH0Z/PM4yevQb/p08?=
 =?us-ascii?Q?jzTN7xHeN4oxFVSvtryEqEUVbtglMoD+aElsAbtaxHlI4P4WCLWsf0YclxAC?=
 =?us-ascii?Q?C2UcmPZJ34EzU9Pzkb76nCUpYRrGRsHjUffLlXbC+oAr4cKKKbsiI+pzuG48?=
 =?us-ascii?Q?pE3uwJGfex9FLjfqoOZHQx87d94XhrO9Q7tjJaXl6LL17S/mY4T+/5DVu9P9?=
 =?us-ascii?Q?zoeLE5gEKjsd2rhgR6CBD3egwlimJQMpyXBQfav0Gpbnx9jn1CelCUOdJepO?=
 =?us-ascii?Q?2w3D0W2k35YM/4N2RzbaYC/3Zl9BI49DuhRY3AqOVsoRTJkM5/7hgSHamLKY?=
 =?us-ascii?Q?7hLMX/LdgLLrIJhe6zJAEuJj6r/foDOWBiJitLOLjoFSBIvNuEcKHjPC3vRN?=
 =?us-ascii?Q?Hl5Ohef5cwkgwgtGR6oM+VGw5Mxj7S6fQKZy1ELeya09J0HErY2W76nbq6Uc?=
 =?us-ascii?Q?FaNA37GbH42IKaHBnWHtUZCJ22FUjhu/cD0Sp6OVAw2Sm5Xtwl09B2nAba+U?=
 =?us-ascii?Q?r26Vp72cIyFGJnYm9Vk0Y//beLQdV1LUTFkdIPUkxJHBeHTKfm3MD2MdIXqr?=
 =?us-ascii?Q?lbLygUaEORuv12AWlg2rY49w2mP9yQ9438EYOY6V3O+SgWAZRudcFqenKFjE?=
 =?us-ascii?Q?3A2pSdbZVHjhlKUKBN3G7kKK6xOQbPRfJkb8fNPlyw/2czyVz27J3mtwj0CV?=
 =?us-ascii?Q?lf5TKD/1DeoDZqep1NuQiuVNkNAw12n86pnhbkcxDNzgwIcNNfmtyyYQ/oej?=
 =?us-ascii?Q?MVnr3ma0bUoLDSmPWkNOTJ9xCHxMPD9BIIeYXRZgiBaJhdprOIerIVZ5sjvf?=
 =?us-ascii?Q?13wGWY9gcS6YJTwCkIGMPsnN98dQba4oreg6S4cSzSDIxlAU+yEkCiNO/Mc7?=
 =?us-ascii?Q?LUp1GF6/WvAF7PvBBmLYtm3enPVYhTDf9+rgvoW9NRZr5TRrXrJJd1zE4g5A?=
 =?us-ascii?Q?FlL7jCBde98Gnbv8ETya+yjzhWsH/D2utotgNkUbu4LKaF4OFNfEK4/cr/dE?=
 =?us-ascii?Q?a6QzVOZQTCFPX2tsrPHHdU/AS59Sxf3gXWtgof8dN5AbQ2hx5vX3xhVGTGGA?=
 =?us-ascii?Q?41BmqDPr8cvKBRZJFeLeXgoEAt7hEpemX6FzdJflpz4vese2iLKvLPN76uVX?=
 =?us-ascii?Q?hNZDyEH9lFODGziire/9GShOhUFQ+wfGaZpzrXDwXn/XnxQ8kWfCSMZkHHcI?=
 =?us-ascii?Q?crQuTvdHaxYCS/ctO6B1VGm4pp6jXndW/wU9MY7H2KlQoLP17+XU5ZIxiKko?=
 =?us-ascii?Q?B2joM5PxV0Cw6WushMSCTzsdc+1VMg47/UMuGI1x2mWC0XBNDJT5eO41DZBb?=
 =?us-ascii?Q?Dbe7XqDfJE7tHVzNe0aAld6245dtymbK94QI2GCPodGmkE4CC/bCT5vLtOyN?=
 =?us-ascii?Q?+wJMuFcc49x6UKg//vIE8K0GKZxwn8QuW8Rs3gB1z3ahIAiVnk6KN4b8XfRP?=
 =?us-ascii?Q?ZnUeZmwCGO28ikeU2oA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a50dd3c-21fa-467a-76ea-08db918dce16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:17:23.6792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkFTsUDqMOKxEYVUPCzVE6Fspvu6ZJboUsOlnmYz/u3U6d5cTRnbBFAQRfo7K868kGHtZ/AjUzGSnGgn3eDHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, July 28, 2023 4:58 AM
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
> On Mon, Jul 24, 2023 at 06:40:58AM +0000, Havalige, Thippeswamy wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org> On Thu, Jul 20, 2023 at
> > > 06:37:03AM +0000, Havalige, Thippeswamy wrote:
> > > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > > > > On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige
> wrote:
> > > > > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > > > > > ...
>=20
> > > If you have more detail about the "error interrupt," that would be
> > > useful as well.  Does this refer to an AER interrupt, a "System
> > > Error", something else?  I'm looking at the diagram in PCIe r6.0,
> > > Figure 6-3, wondering if this is related to anything there.  I
> > > suppose likely it's some Xilinx-specific thing?

> > - Agreed, ll modify Legacy to INTx, and regarding error interrupts
> > these are Xilinx controller specific interrupts which are used to
> > notify the user about errors such as cfg timeout, slave unsupported
> > requests,Fatal and non fatal error.
>=20
> This would be great material for comments and/or a revised commit log.
- Agreed, I'll add this as a comment.
> > > > > > +	/* Plug the INTx chained handler */
> > > > > > +	irq_set_chained_handler_and_data(port->intx_irq,
> > > > > > +
> xilinx_pl_dma_pcie_intx_flow, port);
> > > > > > +
> > > > > > +	/* Plug the main event chained handler */
> > > > > > +	irq_set_chained_handler_and_data(port->irq,
> > > > > > +
> xilinx_pl_dma_pcie_event_flow,
> > > > > port);
> > > > >
> > > > > What's the reason for using chained IRQs?  Can this be done
> > > > > without them?  I don't claim to understand all the issues here,
> > > > > but it seems better to avoid chained IRQ handlers when possible:
> > > > > https://lore.kernel.org/all/877csohcll.ffs@tglx/
> > >
> > > > - As per the comments in this
> > > > https://lkml.kernel.org/lkml/alpine.DEB.2.20.1705232307330.2409@na
> > > > nos/ T/ "It is fine to have chained interrupts when bootloader,
> > > > device tree and kernel under control. Only if BIOS/UEFI comes into
> > > > play the user is helpless against interrupt storm which will cause
> > > > system to hangs."
> > > >
> > > > We are using ARM embedded platform with Bootloader, Devicetree
> flow.
> > >
> > > I read Thomas' comments as "in general it's better to use regular
> > > interrupts, but we can live with chained interrupts if we have
> > > control of bootloader, device tree, and kernel."
> > >
> > > I guess my questions are more like:
> > >
> > >   - Could this be done with either chained interrupts or regular
> > >     interrupts?
> > >  - If so, what is the advantage to using chained interrupts?
>=20
> > With regular interrupts, these interrupts are self-consumed interrupts
> > (interrupt is handled within driver) but where as chained interrupts
> > are not self consumed (interrupts are not handled within the driver,
> > but forwarded to different driver for which the actual interrupt is
> > raised) but these interrupts are demultiplexed and forwards interrupt
> > to another subsystem by calling generic_handle_irq().
> >
> > As, MSI generic handlers are consumed by Endpoints and end point
> > drivers, chained handlers forward the interrupt to the specific EP
> > driver (For example NVME subsystem or any other subsystem).
>=20
> This doesn't really explain it for me, probably because of my IRQ ignoran=
ce.
>=20
> I compared xilinx_pl_dma (which uses chained interrupts) with pci-aardvar=
k.c
> (which does not).
>=20
>   - xilinx_pl_dma_pcie_setup_irq() calls platform_get_irq(0) once and
>     sets up xilinx_pl_dma_pcie_event_flow() as the handler.
>=20
>   - advk_pcie_probe() calls platform_get_irq(0) once and sets up
>     advk_pcie_irq_handler() as the handler.
>=20
>   - xilinx_pl_dma_pcie_event_flow() reads XILINX_PCIE_DMA_REG_IDR to
>     learn which interrupts are pending and calls
>     generic_handle_domain_irq() for each.
>=20
>   - advk_pcie_irq_handler() calls advk_pcie_handle_int(), which reads
>     PCIE_ISR0_REG and PCIE_ISR1_REG to learn which interrupts are
>     pending and calls generic_handle_domain_irq() for each.
>=20
> It seems like both drivers do essentially the same thing, but
> xilinx_pl_dma_pcie_event_flow() is a chained handler and
> advk_pcie_irq_handler() is not.
>=20
> Is there some underlying difference in the way the hardware works that
> means xilinx_pl_dma needs a chained handler while aardvark does not?
- Hardware doesn't need to have only chained IRQ, we will try to implement=
=20
this feature with regular IRQ handlers and try to validate.
> Bjorn

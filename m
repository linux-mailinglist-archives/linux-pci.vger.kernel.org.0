Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725D78A888
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 11:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjH1JJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjH1JJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 05:09:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26EF3;
        Mon, 28 Aug 2023 02:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwREYNU1xgXWy13XrUAet9iINVCBwXLGBMg27hfbONH3QCHxPR8eQGF6zcDwjUOiwBD8aGkq2msOfVxuZAiLpA3pTF37qrABeLpet9019vQLW9DsFliOflkEyZbqeBb7ha5dtcBDjVuw5VHUsI9fOuG+NzCz01WJ0xjeoeWZstgPgsJA+6evs5qnrZaa51o669g38f/ey1J8qg2ZiiWDyoee5uMhKTX1LRdIum0nc1rdS13mIS/AeDkqVGcEeGQpsJ/BxsQ0oUw2/f7E4FdHnuh+ExDd2oWYn/JHZhhRZuy3WEmUIs2wtGJV8vzspj90jGmvlamSNII7hjYQrxLksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFIs7nA2DYh2xKmidD2YSYw8mg/zY7bHk7GgYLXRhx8=;
 b=JULE2/ONF6Tu6LuH6CwpiDWlEwaMI/GxNBRHfnBNm6KlyKauDPTp4yCTR/LTYsY79AoSY879dGzjC1hKLHUQTCiyFVVmj0JMbhlBdTXo32mUK4RiYDQHhLLuvlRMkyzE6gWmEtAnz8bDuoJM6qcgU7Gpfl8hNCSludU2o4AOjE1y68/hn1QHymVSTNKkVwu0rfwh1C7f/cEc9FUaBRVCw0MyG2Dz4fAGwC6sKwYseo3NdGirGyJ9FTOAPBMonIRZUj/2HlXZK8NGuY/T+vii+b88xkRafod6hYW3pWAuEyj+Dl91ELxvV6ayHSaxHmTlMw/eLDFlX8dUS2OOimG/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFIs7nA2DYh2xKmidD2YSYw8mg/zY7bHk7GgYLXRhx8=;
 b=DZF0dz55+zKTw5r1+Pj2kTj1/ePbdC4VDJzPy5hHUqbWKzl96o9mWkXf7hdoWR+As/dlT+P40+0IWTNwyn1QsAyvn8bVP7bn1yQ8CU6Y81FAKkdTZbKDb9K3h6eQdUIqFdPrWFpgHTppfrryrV0NpqEU1IdLCV4XhStA0D8D5hE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:09:05 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6699.027; Mon, 28 Aug 2023
 09:09:05 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZ0bd0UZnWQ2UfsUKGgBlWnmvLwK/1NJwAgAo9UBA=
Date:   Mon, 28 Aug 2023 09:09:04 +0000
Message-ID: <SN7PR12MB72019898876F049A932209038BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230818093507.24435-4-thippeswamy.havalige@amd.com>
 <20230821201400.GA367570@bhelgaas>
In-Reply-To: <20230821201400.GA367570@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: f5d7a6c0-9636-4e19-9e2c-08dba7a66d94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzjU+xygtHL2d2f0bNxRHK0klrqE1hzv/AiLiC2aiERTe5zua2Phc7xCHCA1vZAguE3f9ZS0UtagwcnPjLANr9dDyOIo++w7Hkjo6EzNWv9QcPCcDAtdibeLDUI35cuc+B3EAi6weNcKJosRreexgHlO3EegmNM0uBjW753WGtSOcHYVnLmn6OzBWbT7/xoms6QQ6P6rjfOhWRtyyO77MI0uUrH7a1vmchkG2Rv9rYR8CRe5HVYBSe/NZM5NfY3C1lGZsBYGs3jFUxtqnCydO79O1OrDi16MDMSEWSYv35TD6ryK42E8se2zdBqyr6lEd/JtYdHtbOaAGMHrby6m6bOjAVh/aluMfcoaanX9zTqdmhG3MlWzxHur2jvuikh0vfBTnGDrN9bFpDvW0wyhpAz2mHdUcHCmpT1U6nmg+L0XQoVOQ4LbKdbXzSzgp1TQ7iqQJ4Cg/zX/MCAUuijzEAjZ6LxjuXt/gI75aQQAPiWtJVrinKBs7/WWS6+vZ7Xsj6yhYQy2RNUfZhO50SAUFqypKbp8bLkWzzZMWSjOl8CtytR6XnCIeokyCJ5A6W1dUD35mYe0UsL3ktnB3QjYdFFNqvO2YeLausTsk18Wh/um2SPM1TUUJhQOARLtnNVE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(186009)(451199024)(1800799009)(7696005)(71200400001)(6506007)(86362001)(38100700002)(55016003)(38070700005)(33656002)(122000001)(83380400001)(2906002)(76116006)(26005)(53546011)(9686003)(478600001)(52536014)(8676002)(66946007)(4326008)(66446008)(8936002)(64756008)(5660300002)(66476007)(66556008)(7416002)(316002)(41300700001)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEe/dZi5oMm3WYxRdUjq9+qXB1jMHxMiTaDdPFeWVJS6G0bLJCFZWe6rW2zH?=
 =?us-ascii?Q?tRa8VVqnk+HKz74XE0mFn3f/gQin8h0sjhc1QSwbJaVTDIaYQECxfknUT4mG?=
 =?us-ascii?Q?/mZdt5cqVmT953oLprk9k1ZYK7W8BArhH68SNzUDJ2Maf6aR5bdfMCtJCsfu?=
 =?us-ascii?Q?yxTwC1BNJS2HZcV7aOiSmKFpZ/wGY9ujsfyVGqpsT8rIz9nH9tD3JKqBdUll?=
 =?us-ascii?Q?xKmDFMgYzVE6/6EsbKeBToZFwSytrNT+MozpDsIgGWO5bAD4f5ZHsC3nqw/X?=
 =?us-ascii?Q?EPjr48izzRrJsbwgbTVwp4Vg4ZNyhXhyfdu7fqlLMlO8kRC/OToBpIPZsSMk?=
 =?us-ascii?Q?ZOM3A5/aMNzAH8D3fAtbswzAXSzRUXCRnVDtpq2kivCO+xHhZ+KkbaqbqrUT?=
 =?us-ascii?Q?xkGjtQeU1lKunEF3gvbn8K3mFeLrGvmdAUHkl6sulr8feM4AWMxrJKuQbPJO?=
 =?us-ascii?Q?ebD4Mka4C5z0T6OYzp/eMjPsE9o4Pc6UBYQtKUqAxcdGRX8YKI+1o+rS3mHG?=
 =?us-ascii?Q?SYaDZ9AqtAmkCNyzQ3n5x8iV7uhKqMLB8JgnD6B28ts8Pbg07+WEEYjdrl1T?=
 =?us-ascii?Q?dOYtTQtP32rbS3DO6AWlxJtETAaFOQbBOyGWnziY+Ofnm85cudHdMuL5rD4K?=
 =?us-ascii?Q?4BQsCDVc9yywDS0XVbBxtjDlP2wAeH1u8qa0BCKpKnqGSlT7JUxgsgl4l6UQ?=
 =?us-ascii?Q?sdOSuWftT1erSDAp7WtTwMuc/bu/D9FDEmh0fUwTwKEu6E8X7uHcJipDqrih?=
 =?us-ascii?Q?qE5W4xWpX/QszseCyOZFlgUTFsl1yLtaCFBy9q/b4dnaaNj+VA0Nxkg/tL0L?=
 =?us-ascii?Q?XvFDPa/GbSemJvXtaNITb2Fadr4+KGoiSeP09gpCli/oy+d9MvFReXDKDUlZ?=
 =?us-ascii?Q?D+rJewpsfH9SvCn8M3P2F4WEdO82XjcSh9sOlMECwkSFOmYbp4vvTmsPDX3j?=
 =?us-ascii?Q?WcwwulaEAnffdXwUQmU9guqMcu48lL/HnCByQzt1DgIj7BHbdRKnkjnnKbqn?=
 =?us-ascii?Q?dTtHtBcO72fSoI2Ho41EHVJJ9BVIWj4Yfc3G4Q3y9AabSZszkaBYlIkMQEuw?=
 =?us-ascii?Q?noselQXLo8s9ppcPplBnjHudd9famtW32u+9Xgo/0p0DXa+VRqybpRkGYJRo?=
 =?us-ascii?Q?kx3WyH5fez5U7jp7BJ/9sf+w74iSCC0pWECrv9RdjmolGK71PhnKolfYPdnE?=
 =?us-ascii?Q?R3jW+8RD9D8taajqg0ioCwdSzHrxtPv5Oti2dVMjsHswbZJTQnhMf8Ks/SrQ?=
 =?us-ascii?Q?RtZwWq6mXZ3VkOUgxWmYWsXK81oYXI0dx7lNK9f/dPr38RfJIc1Js4WOsLdV?=
 =?us-ascii?Q?bpzwI5FEC37WM/dN6uJ/pryI63OG6pQ+eH4KmZQe01XJHjkytznrmFGXqi04?=
 =?us-ascii?Q?GhMC78k7JcwDq3EKiYNl8yuL21vZ17Q+9qjGTJAxjiQw/hVew8hwocL/lD0F?=
 =?us-ascii?Q?n+gjh70snaoCiZL/+GUIwurKmPAiziiD9jiJP2q4vjvIlvARlayQeElBbnxL?=
 =?us-ascii?Q?Gi6nBW4/rZifwzlYRpmcO0KUVLYTQq+XSOd8NttH4/Fj9TpJi3znPZKb66e5?=
 =?us-ascii?Q?y6ycdgsnpHLeAA1toX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d7a6c0-9636-4e19-9e2c-08dba7a66d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 09:09:04.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP3jYbRo57o2zAYYJp2EPa8rolSGmO+Qot5Z3tqYriBrgtq/xSeZUzMxCknAZudCl5QjaLBtaXy3ipax1R6NZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks, ll take all your comments and update them in next patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, August 22, 2023 1:44 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; bhelgaas@google.com;
> lpieralisi@kernel.org; robh@kernel.org; kw@linux.com; Simek, Michal
> <michal.simek@amd.com>; krzysztof.kozlowski+dt@linaro.org; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> > Add support for Xilinx XDMA Soft IP core as Root Port.
> >
> > The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> > programmable logic.
> >
> > The integrated XDMA soft IP block has integrated bridge function that
> > can act as PCIe Root Port.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > ---
> > changes in v6:
> > - Replaced chained irq's with regular interrupts.
>=20
> Thanks a million for working this out!
>=20
> Trivial comments below, wait a couple days before reposting in case there=
 are
> other comments.
>=20
> > +static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie
> > +*port) {
> > +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> > +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
>=20
> This function returns bool, so I think true/false would be more appropria=
te
> than 1/0.
>=20
> > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > +					    unsigned int devfn)
> > +{
> > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > +
> > +	/* Check if link is up when trying to access downstream ports */
> > +	if (!pci_is_root_bus(bus)) {
> > +		/*
> > +		 * Checking whether link is up here is a last line of defence,
> > +		 * if the link goes down after we check for link-up, we have a
> > +		 * problem: if a PIO request is initiated while link-down, the
> > +		 * whole controller hangs, and even after link comes up again,
> > +		 * previous PIO requests won't work, and a reset of the whole
> > +		 * PCIe controller is needed. Henceforth we need link-up
> check
> > +		 * here to avoid sending PIO request when link is down. This
> > +		 * check is racy by definition and does not make controller
> hang
> > +		 * if the link goes down after this check is performed.
>=20
> This comment doesn't make sense to me.  "If PIO request initiated while l=
ink-
> down, controller hangs ... This check is racy and does not make controlle=
r
> hang if link goes down."  Which is it?
>=20
> My *guess* is that this check narrows the window but doesn't close it, so=
 if
> xilinx_pl_dma_pcie_link_up() finds the link up, but the link goes down be=
fore
> pci_generic_config_read() initiates the PIO request, the controller hangs=
, and
> a reset is required.
>=20
> > +		 */
> > +		if (!xilinx_pl_dma_pcie_link_up(port))
> > +			return false;
> > +	} else if (devfn > 0)
> > +		/* Only one device down on each root port */
> > +		return false;
> > +
> > +	return true;
> > +}
>=20
> > +/* INTx error interrupts are Xilinx controller specific interrupt,
> > +used to
> > + * notify user about error's such as cfg timeout, slave unsupported
> > +requests,
>=20
> s/error's/errors/
>=20
> > + * fatal and non fatal error etc.
>=20
> > +		err =3D devm_request_irq(dev, irq,
> xilinx_pl_dma_pcie_intr_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> intr_cause[i].sym, port);
>=20
> Rewrap to fit in 80 columns.
>=20
> > +	/* Needed for MSI DECODE MODE */
> > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> > +XILINX_PCIE_DMA_REG_MSI_HI_MASK);
>=20
> Rewrap.
>=20
> Bjorn

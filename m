Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F478A921
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjH1Jo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjH1JoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 05:44:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852CAA;
        Mon, 28 Aug 2023 02:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTDS9J2R8vVCYpHHrWeLuU1zJdxRad+tdSVKC+XPhLmZA5BnbJmEmiftbVWjEyFa2JBOkFwm3JB2DyiE0Uy7u/CW7hxz/AYKQcXx+FlzQS+cAeEri0izx3dwpNWCP2hKrqawURtkKfvDijtK+j5BxtBa86WeOQIumMgHIch/8eKrL2wHviEeIfzCP47zcNbmgEjspcGwTkqzI/7CRLdRBxw21Sjmy8eo9alcMJH7N8YDHsGIkxLKt7uk0lE2/j0EY2qF5NHMY3YJvmnIIQp+9r6Kf9qNWq/w6mF9Ot/yriY1zPAWdh051yo3+e7CA0duyJDoSF7AiqclLeFo4TYY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPB+h6CFQFjwocuwxHuhQEG4I/6eCXYyCiulaRefuco=;
 b=TOBxJuefbrUBRudMQ33TCI819BpkLTIBPS+dmrYvfFroh8s2MZu99nZc0LLC6hiFTRZ82ISGNYzbIEQRVs8sMm73ld/c8u6HSmEiEHrRaHZlLvufsgeranURYYFfxXmj7qydjxWU/P4b7DZNWJGVadmCEIyXdwEN8sMQJTPEZkNXFjWtqPt/tcC4Zx7P+I+aByhgdUa8AihWudmh7E46YCymB7U/SHmVpI2F7rcvI2xFhz5QDXZNQvr0XdDhij31bhrYJ6SIg6ckrbWQGuTt4IdguQ4Xd0DoMTppkVEOncAJ/G4JC40e3paZlGh2RXRLRn5EaKBfYSDB+giT5hPJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPB+h6CFQFjwocuwxHuhQEG4I/6eCXYyCiulaRefuco=;
 b=jhWMb5zl9jY+pTmjwDADnDy30Tn/920owpoQcUu0CYsBQNDPkPLT/bssfKs6pdkuqxZvhLKcBQLQhOlINtUL9fpy6521wuhy3osqLNIDUDjF89TyCo3MFPhxdrKLZS2OKZIZiAYBE7h2oyPI03PgUlPEmMgSEnpYfaI2M8ts8Aw=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:44:00 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6699.027; Mon, 28 Aug 2023
 09:44:00 +0000
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
Thread-Index: AQHZ0bd0UZnWQ2UfsUKGgBlWnmvLwK/1NJwAgAo9UBCAAA/sYA==
Date:   Mon, 28 Aug 2023 09:44:00 +0000
Message-ID: <SN7PR12MB7201E6704624FA01C84481BA8BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230818093507.24435-4-thippeswamy.havalige@amd.com>
 <20230821201400.GA367570@bhelgaas>
 <SN7PR12MB72019898876F049A932209038BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB72019898876F049A932209038BE0A@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA1PR12MB6089:EE_
x-ms-office365-filtering-correlation-id: 658ef0d1-851b-48ae-e260-08dba7ab4e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ho2z3y3Jme/dd9uxgrlCwJiPNYTZD9gWr6uR4zvDNO2PuJDhxaUEfNPDLfSJf2KPMNWcicpKDywOuDeQtFtIB/VWbOvhbWimUNjnMiH+WPb1BlYm/cVX56jppU2aJzTZh2IGJeBGV/AH5LmLEuD+Nv3n1cXU0gvVUZ8Yop4T0+xX2xoqDZQSEP5hExpQMtHIbFAr4HQJgV3Vl6f64W/iF0HmASyNNIXQElfad7KYISp9xjnqM8J8qgFZEZZKLLnnh5kWya/hQQQqAByXPaBcSc097X3vkAkb0rhnj6KWsW/ohRkmHoikQbZRUYgFqJHrwQgcdqnOb605x9tQI3X+B7tWyh5eqKaSjDvVWakeuomh/4x44+GoZNhkWH3JW96DXlfimLmCtLSlc12NA++6eXZlWZubmreuAScVHwBOK0T1IlS35fX93LuEHbFUc+8t0APgl+tG2rs6LI+a7Q8WA884hv5v4sKrEeygz7BIOQc1Wo1FcHYlL0F5kBwFjjNH/Rbkp3B+neCfdiD1u3aO3Ute5pecymMG5QbKv9xjMCPqzjf9Hlq8p57wjN9Ex/Fv8VHsF2XsGSCkRsrwC8RlVOIMeiJtB5BECmQufR+5MMLmtHgBaqw3FW7gf3wroci1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(478600001)(122000001)(26005)(2940100002)(9686003)(53546011)(6506007)(71200400001)(7696005)(55016003)(86362001)(33656002)(2906002)(52536014)(7416002)(6916009)(316002)(5660300002)(76116006)(66946007)(8936002)(64756008)(66556008)(38070700005)(38100700002)(4326008)(66446008)(54906003)(41300700001)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QpcvZ3oLOfvrsKzCHjwMZLmZgRajldrTdBN85yGD/plGEpJ/ISA1IT4vJ0gU?=
 =?us-ascii?Q?dtD9fROE4YrF5OWhsE0yiF7EkIEBCvmEUaUgzmwuqRo6H7PIUOhd6jRfBBJv?=
 =?us-ascii?Q?fquHr/p8bhvsO7Nc8pcwL2apP9DtLX49G2xSViOt3kY5/dwHFfEO+bsHki5n?=
 =?us-ascii?Q?XNuWutbUZvT1Jr14julJuC/EK2Umh5c/NZB8zvjiCq42d+cGmmzDYjrKtxWu?=
 =?us-ascii?Q?zZkEPlBKNmaKqvd+8Fn8PkgRXMY2sSPvcNeHlB/HXXGhYkxP8PjnjIL4dRoZ?=
 =?us-ascii?Q?1N9rm1ND7FsEHLzS7RiBQtF1TLVrZbzkXoPzWLt6d323sgjW1KFGNDNAOSLo?=
 =?us-ascii?Q?G1QhOoojQk2Xd5rKhLNA8w4CXRAkruy6bNAvTnedl9JEHeSuk85NWaxthZsA?=
 =?us-ascii?Q?AHwa4BsrmqplTKzisRx0+h2a8kPQYTFtmrTfVFsntlrInwDPyuzQTF7DLCSd?=
 =?us-ascii?Q?lIKQQ/8UWsBvT3d/k6vv81HSE0tQnChtmHzmUSaTQHlDdt9RZVl/RlLH2nhV?=
 =?us-ascii?Q?wUbTgKPuDBBdnAJrkEBg4kjwO+9ZQ4rglSZLuelXTu5CK1qTlSYSMMefuMls?=
 =?us-ascii?Q?LE8jqN9LN2Y/jbbfRd/G0Ge9XuHSUirlaQs8/DU/PdZNvGiqcgjbPCqAXXB/?=
 =?us-ascii?Q?HBBjHxI1zcOocZfpzIH++h0KFqGCWGk3RUsDlW6tZWw1pGLRhMsfy7+vXzOY?=
 =?us-ascii?Q?k32Q7FyXnoJxj7lzjcoEHSjyAuJBNAZF/ZAI2N/TLyDobscmH63QE7svu8pN?=
 =?us-ascii?Q?94ui1R83sQfr6rcTdKDpyGGZs264mdcH4LRD1joLsh8pbZj0lSQGK+qMq5kc?=
 =?us-ascii?Q?FdRiF/ojJd+jLXMrQHspSqdi6udjNAMminbtKBksRu97tKZloO5Nq2tXGd0o?=
 =?us-ascii?Q?0MfAKgflYEPx5tXEXD9pc9KJxPi32SG0R2GFjULOIrqV0/EO+b3BzOc++El/?=
 =?us-ascii?Q?+wxt67ItU6YBwBykJDXAeL1shsvH7ani2KVDhmfLUsxLIM3VfQxAW8rREoaX?=
 =?us-ascii?Q?xp4u16IQIbAkfVZ/rhrjC2JNYTRLN+awjsqmBmhyeyEluoQe+F6R9iozE3/F?=
 =?us-ascii?Q?GwRoym+ce/tw9pVy3I5zEmKvdP51wBUwM4EidHxFPdR2feOUR5aP+QoumOyA?=
 =?us-ascii?Q?wJNj9+Jo0kdexD5jEVV5awb6gU6ER3rfn9fHpbzb8VxSMWMMBiMcS4U0VLXj?=
 =?us-ascii?Q?k8FpkOam9gJmmrvXCvKhVp/ktwRKTKY+tPkS6+77Gf8Di1z/rV8sNZpuMWhg?=
 =?us-ascii?Q?ig8UM664RLtmaNyhYsSRh3tkku2DSu0zcJjLB7+m3+9BW6t6jIgUGSkChwJd?=
 =?us-ascii?Q?bX2a3sBw1yBQMbL3Tlq9j788qUvSEbudnrzv+zsn626iUDRlqGaInNqNlX0A?=
 =?us-ascii?Q?N/Dv/Y8VPz3GwTU2TiWhu58zL0Y6beBOxEhgHASiSWa2pcM29nsdccm+pW0K?=
 =?us-ascii?Q?xIx4droTeNt8m3MNtgmMo3SwJp6mz70b6fulrDNCh2NYcgKjCYJ2PY2LkOd8?=
 =?us-ascii?Q?Lk8fKzpQl8XEPB4UuOaXIATdpaiEH5thBCugwwXG+tVlgT8x8uVxJb8/rMsg?=
 =?us-ascii?Q?zIbxkCwXqjOF2XbJW78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658ef0d1-851b-48ae-e260-08dba7ab4e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 09:44:00.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhC83Q+MVYa4ouw6BrIwtru1oQKuAWfUKXR8t4RjFalByvYb+G+og8Sx5OyP204Vjx+VzI7xXquECbdCcjfm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
> -----Original Message-----
> From: Havalige, Thippeswamy
> Sent: Monday, August 28, 2023 2:39 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; bhelgaas@google.com;
> lpieralisi@kernel.org; robh@kernel.org; kw@linux.com; Simek, Michal
> <michal.simek@amd.com>; krzysztof.kozlowski+dt@linaro.org; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: RE: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> Hi Bjorn,
>=20
> Thanks, ll take all your comments and update them in next patch.
>=20
> Regards,
> Thippeswamy H
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, August 22, 2023 1:44 AM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux- pci@vger.kernel.org;
> > devicetree@vger.kernel.org; bhelgaas@google.com;
> > lpieralisi@kernel.org; robh@kernel.org; kw@linux.com; Simek, Michal
> > <michal.simek@amd.com>; krzysztof.kozlowski+dt@linaro.org; Gogada,
> > Bharat Kumar <bharat.kumar.gogada@amd.com>
> > Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root
> > Port driver
> >
> > On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > >
> > > The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> > > programmable logic.
> > >
> > > The integrated XDMA soft IP block has integrated bridge function
> > > that can act as PCIe Root Port.
> > >
> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > > ---
> > > changes in v6:
> > > - Replaced chained irq's with regular interrupts.
> >
> > Thanks a million for working this out!
> >
> > Trivial comments below, wait a couple days before reposting in case
> > there are other comments.
> >
> > > +static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie
> > > +*port) {
> > > +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> > > +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
> >
> > This function returns bool, so I think true/false would be more
> > appropriate than 1/0.
> >
> > > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > > +					    unsigned int devfn)
> > > +{
> > > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > > +
> > > +	/* Check if link is up when trying to access downstream ports */
> > > +	if (!pci_is_root_bus(bus)) {
> > > +		/*
> > > +		 * Checking whether link is up here is a last line of defence,
> > > +		 * if the link goes down after we check for link-up, we have a
> > > +		 * problem: if a PIO request is initiated while link-down, the
> > > +		 * whole controller hangs, and even after link comes up again,
> > > +		 * previous PIO requests won't work, and a reset of the whole
> > > +		 * PCIe controller is needed. Henceforth we need link-up
> > check
> > > +		 * here to avoid sending PIO request when link is down. This
> > > +		 * check is racy by definition and does not make controller
> > hang
> > > +		 * if the link goes down after this check is performed.
> >
> > This comment doesn't make sense to me.  "If PIO request initiated
> > while link- down, controller hangs ... This check is racy and does not
> > make controller hang if link goes down."  Which is it?
In link down scenario, will treat current device as a invalid device.

> > My *guess* is that this check narrows the window but doesn't close it,
> > so if
> > xilinx_pl_dma_pcie_link_up() finds the link up, but the link goes down
> > before
> > pci_generic_config_read() initiates the PIO request, the controller
> > hangs, and a reset is required.
> >
> > > +		 */
> > > +		if (!xilinx_pl_dma_pcie_link_up(port))
> > > +			return false;
> > > +	} else if (devfn > 0)
> > > +		/* Only one device down on each root port */
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> >
> > > +/* INTx error interrupts are Xilinx controller specific interrupt,
> > > +used to
> > > + * notify user about error's such as cfg timeout, slave unsupported
> > > +requests,
> >
> > s/error's/errors/
> >
> > > + * fatal and non fatal error etc.
> >
> > > +		err =3D devm_request_irq(dev, irq,
> > xilinx_pl_dma_pcie_intr_handler,
> > > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > intr_cause[i].sym, port);
> >
> > Rewrap to fit in 80 columns.
> >
> > > +	/* Needed for MSI DECODE MODE */
> > > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> > XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> > > +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> > > +XILINX_PCIE_DMA_REG_MSI_HI_MASK);
> >
> > Rewrap.
> >
> > Bjorn

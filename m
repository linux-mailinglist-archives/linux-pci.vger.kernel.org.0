Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B475A6A3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 08:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGTGiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGTGhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 02:37:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9926A5;
        Wed, 19 Jul 2023 23:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhURs/R9nRSy7VNn74bCnYr/q42zwobtTL2rJW4Z0SNiQx12agVJ+odI98Q6/gGR4wRvLTDNIXmd8MrHXuxwsMNhdK4RaBLzPW7YWo/b/J67nWd3GQ1Fp3FgrvV2SdzmHW+KOtKeC5rkQrb0GlztrL1gYIbgxa0kNd722I1S+nfyw8ktKRmF+VAr/2VU2DCTwbmKoVkgwLFHjjHU7BAfEqqOt0mwsP5kmYipncWpWbq00jG1tLQFzVNRNk+ZwSndnSP04Hvh2BIn3QwtrxfPwu/kbG1OOX8INaN3HFeEQGWVz/Ne86E48ph3/fitGcAL5mku9PSre2LnwbZfXGNgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVWF5zbyWVg12xssMePudLgZn1Yg9tei5QOcmzcYHyc=;
 b=OXTg6nUX6+9oj1FkLWaaLhXH0BNfODKdZ7OvZZr6U7tcSso9LtQs8C3rOE/5XzHP4T9h9qJX+QKRdVQL3HXtWYpFazeH4C8ilKtDKdOTXMiZvCLdROm/4VIKL08dP+rnO9W3DXPgaPYVXj62zqP3t7C2Vt1dIzueyUUy5IXrBXD8kcqVKDKhvJcXYxgNVEcX7rhU1HgKjZ803Z96YaxTaq9+gWcUIBDFuGkwxjAbQ+yI0i6WjaDeiK3onRQfMGTGhx9fHOMcVJV37pfFc+wb+yqUvgVHSybU9BOcIx62asZFHHBhjOiNLdY79GHJfiKWsTOX2Nyg1bleQhxAlC9fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVWF5zbyWVg12xssMePudLgZn1Yg9tei5QOcmzcYHyc=;
 b=V5UtG/MP1tJdw0RyRFZhf3si12vItwlcIyhHcAl8V/Ajiy3cA/EKNj5/WqTV8LX4vQFItug62rE4+8/KF99NpcnGa1TSygtAp/W6bMj7lmUoDyQR3v5uf3TVMMTZBMMpNrjrLUurEkDJCFQRXgcqeaIcuInmP5hiMDGVw8oMmS4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 06:37:04 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 06:37:04 +0000
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
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZqaL5jo83xIbcxUurUITknscIg6+j/xkAgB46QpA=
Date:   Thu, 20 Jul 2023 06:37:03 +0000
Message-ID: <SN7PR12MB7201A03526C04788709167A48B3EA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230628092812.1592644-4-thippeswamy.havalige@amd.com>
 <20230630231832.GA496495@bhelgaas>
In-Reply-To: <20230630231832.GA496495@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8183:EE_
x-ms-office365-filtering-correlation-id: bdb00cb4-7e31-47d9-2aef-08db88ebbb0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYT40ZW2/i2+qFZIUA6pqnUF0QhHN8FzAPorTGJj9xAvt8P5KhpiPtLpbSVbhzbZ1y+ZIQYlpHQGCYTw2GcKnSjaoFpBJ1QO5h/jfs25QulFm6qwTBdsqDrWhN8p6Wni19WpuHETvTvPwOpfC4vygtQvxe9Sm8Cywc8Z88nrM9h9oN60WyxQ49yBYK51qGxueoB2A23x9i1xOKOaIjy2bRRFDNb6+Hkr2xReXNoMehhrPcd9PCrGfqO3zIqtA2ZDsk/Qfs7eQcugdu7kRpzTZCWQa883FNmCzn7hdnqdO0o04PwdUo3ZJ+JMNbhl2MP7i+ijRqvEEgkgHaGwxw0MhNOjwrVTz/XhzVtjZj5GIMjJ7/0RI2I8c5Afg7opgRM0U1AueFWGR71jKuA6DUu5ox0lHYzIkseGXhL+ANceqJ2vPTkEq+dwVNcdkRq5ODHCWsoeJADmVR705qhXU3GZctU61rkhH56vZgvspVTy6l6CaNiKB4WWALg4zL4f8aD7DsxC1dhgXAcM2MoR1ULIActLVfYRvvI4U/Y+X3DDF1oCTijAL0G6mNaYokFt25tUEwsI2yTHtr6rGk12lYnyrpfYevcjkgUrv3EIkVJVAr7u1ml8pPWmSvhnNA7t+NaRRXx6qpuOZlrWwafWV7CQyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(53546011)(6506007)(478600001)(54906003)(186003)(71200400001)(7696005)(66476007)(66556008)(6916009)(64756008)(66946007)(76116006)(4326008)(66446008)(83380400001)(9686003)(966005)(122000001)(38100700002)(5660300002)(52536014)(8676002)(33656002)(8936002)(38070700005)(316002)(2906002)(41300700001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vZfB7+u138dgoGtgADsL7IOkoH0XUuOlW+MLORHAK6pwxRR54Hv6dTNLyiqm?=
 =?us-ascii?Q?BuysLfZvSLAMVuA0Us+myw1dmJoKk+GS8Hj0p2OyzzbBsB/w0WnXyghLBqnE?=
 =?us-ascii?Q?WSJWDq3xx7gM79aHSjmDuI27LGW80H4eEeMLQOfK0HdrBEhYSacqZCtMtxVc?=
 =?us-ascii?Q?QAAeC+VP7cf62QkKfPuQ0TDNhDGmAvk7GqgYsdciOAR3EFe5Ehn9vLbvmP7g?=
 =?us-ascii?Q?cQPaFV1tT+zmi5Vc8UmcoevWFOrcg2FwrHbuG2biZAki7A+kZ336kvNy60fz?=
 =?us-ascii?Q?q8k9kPwdThuJnY7NBjaIMiX2xS2eLUlR58EtPvd0wbjmxkvZXIZTZE0w1yTi?=
 =?us-ascii?Q?PHTZ+sZkqev8u4BvTkR06yusaT8HbJHZMgpRQ5xeOn+0G35A6sztuZja8Ey2?=
 =?us-ascii?Q?UPWwGWSDOyAU0cDZ1G5pb9iTWrSoTGZJF+w1TzSCMDM/71TM72E7TGc726nl?=
 =?us-ascii?Q?nCLTXisNvIN5EPwpBF6IUCIEl2N+SghEYCOIreX5DIJH+OdVkhoIEXQCx73E?=
 =?us-ascii?Q?jEPNFzigW4+xUph+hgfv1Yc9FlZCif5TNaR4HuC1JdXgSvpAVK+k54wjr/v+?=
 =?us-ascii?Q?/kB/iXjlQS8axgU91R4JEsm3cvd4Y9iYMANhTJP+u6PIjoZLPpI/8mvR7Trk?=
 =?us-ascii?Q?gHR5iTV2efeRlgQcadJ9mks6uJqjj+T5YhJ7aXRCqEl+Qdbm90o9N0mFqNeW?=
 =?us-ascii?Q?PFqejVtePMhHEOdFrLhWcB7FUEVf5a8qytu0fTRFxoxZGKp+6BmaxWDYSwjj?=
 =?us-ascii?Q?DmusKchJCgnx4JRh45VJep/FneQkvNz7ezfd5wmaR7nySv05RlFLjvaIqg1V?=
 =?us-ascii?Q?+mH6UKqACJP8kdDyItvepiypVQiUhFesJ52gTzGDsMxYr9DYTImIpjYbvwsl?=
 =?us-ascii?Q?w7HfdMoKIpIe++EJ/BcdrlKmWYiERYLvJEf6/k9jLSvLGk58G1zYOOAQZHf4?=
 =?us-ascii?Q?5H22KxdFEMenqIVAB9dicqR1tu3t1pDV9x/sHJawF+6VA6vFCTny0YU81rjn?=
 =?us-ascii?Q?WLhzzz+CW6uemnUh51vOmfAnY5tzfkoUmWf81YZw7u6wS+P19pFQSZDuvxeW?=
 =?us-ascii?Q?qL5QGiRIfcyLwj/R43MwhPDFw7szDkQI+y4YQMf/ERQS3IWc3PQQr6lk1JQb?=
 =?us-ascii?Q?SwTWhFWUPk3ZGObAXoPQAei/nJkO1Ch9P5qxQYxJMWA7a4oPUoBSyw3P96Ho?=
 =?us-ascii?Q?pF7XGy6dEjur4pmR0y/ZCgoa8rTsTeUXeu/fCVICkbCA6A9LuZvt6/3ldETA?=
 =?us-ascii?Q?pk/RJgZ4lpuEFIMiuxlDB1woPzRYkkv/oKUC4iRU9y3aaJ+PPK9+tgZxBGM0?=
 =?us-ascii?Q?s5dcuyj+tPg0b9bbhpqx1BEqjpws2EnWcHO06DYK310dPzeEF9RQ5zGlZ5y/?=
 =?us-ascii?Q?mqFEIKBG/KOmMXl2eBmcWAftNOf1zwKsRxFsd0EX64NMuROh1oAT17JzHUfu?=
 =?us-ascii?Q?oYhWuffRTOLaz/pLPyHjtMPe9SDXbufkxNS/gTIcKaR02L2IxU4qhGEdXB2+?=
 =?us-ascii?Q?xAdZpbT5gMXnLlJG/dh7pVsGIwDAUHFFxIvlVofkOZG2k4h2ylDT06ZwOCf9?=
 =?us-ascii?Q?X2GH0VkFnhWjAddM+E+VFXRjxdfSZtS+MzV6gDyzPdlDN4YjX6KR+yd4Oo1V?=
 =?us-ascii?Q?sS8pXtTKAbbl9wvIaUwtCuY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb00cb4-7e31-47d9-2aef-08db88ebbb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 06:37:03.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFddcR/hyHcKTHs6gtp6kRXLeQJZ8Dw+jbkIIXl5NjGM0OlCQidQ219GDZ4qMJntG5b6/iAQFdeh7irzlSTBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> Sent: Saturday, July 1, 2023 4:49 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: krzysztof.kozlowski@linaro.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-arm-
> kernel@lists.infradead.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>
> Subject: Re: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige wrote:
> > Add support for Xilinx XDMA Soft IP core as Root Port.
> > ...
>=20
> > |Reported-by: kernel test robot <lkp@intel.com>
> > |Reported-by: Dan Carpenter <error27@gmail.com>
> > |Closes:
> > |https://lore.kernel.org/r/202305261250.2cs1phTS-lkp@intel.com/
>=20
> Remove these.  I mentioned this before:
> https://lore.kernel.org/r/ZHd/7AaLaGyr1jNA@bhelgaas
- Agreed, I'll remove this in next patch
> > + * struct pl_dma_pcie - PCIe port information
> > + * @dev: Device pointer
> > + * @reg_base: IO Mapped Register Base
> > + * @irq: Interrupt number
> > + * @cfg: Holds mappings of config space window
> > + * @phys_reg_base: Physical address of reg base
> > + * @intx_domain: Legacy IRQ domain pointer
> > + * @pldma_domain: PL DMA IRQ domain pointer
> > + * @resources: Bus Resources
> > + * @msi: MSI information
> > + * @irq_misc: Legacy and error interrupt number
> > + * @intx_irq: legacy interrupt number
> > + * @lock: lock protecting shared register access
>=20
> Capitalize the intx_irq and lock descriptions so they match the others.
- Agreed, I'll fix it in the next patch
> "Legacy and error interrupt number" and "legacy interrupt number"
> sound like they overlap -- "legacy interrupt number" is part of both.
> Is that an error?
- Agreed, I'll modify this comment to legacy interrupt number. (This irq li=
ne is for both legacy interrupts and error interrupt bits)
> > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > +unsigned int devfn) {
> > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > +
> > +	/* Check if link is up when trying to access downstream ports */
> > +	if (!pci_is_root_bus(bus)) {
> > +		/*
> > +		 * If the link goes down after we check for link-up, we have a
> problem:
> > +		 * if a PIO request is initiated while link-down, the whole
> controller
> > +		 * hangs, and even after link comes up again, previous PIO
> requests
> > +		 * won't work, and a reset of the whole PCIe controller is
> needed.
> > +		 * Henceforth we need link-up check here to avoid sending
> PIO request
> > +		 * when link is down.
>=20
> Wrap this comment so it fits in 80 columns like the rest of the file.
>=20
> I think the comment was added because I pointed out that this is racy.
> Obviously the comment doesn't *fix* the race, and it actually doesn't eve=
n
> describe the race.
- Agreed, I'll add comments regarding race condition.
> Even with the xilinx_pl_dma_pcie_link_up() check, this is racy because
> xilinx_pl_dma_pcie_link_up() may tell you the link is up, but the link ma=
y go
> down before the driver attempts the config transaction.  THAT is the race=
.
>=20
> If the controller hangs in that situation, that's a hardware defect, and =
from
> your comment, it sounds like it's unrecoverable.
>=20
> > +		 */
> > +		if (!xilinx_pl_dma_pcie_link_up(port))
> > +			return false;
>=20
> > +static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
> unsigned int irq,
> > +				       irq_hw_number_t hwirq)
>=20
> Wrap to fit in 80 columns like the rest of the file.
>=20
> > +static struct irq_chip xilinx_msi_irq_chip =3D {
> > +	.name =3D "pl_dma_pciepcie:msi",
>=20
> Why does this name have two copies of "pcie" in it?  This driver has four
> irq_chip structs; maybe the names could be more similar?
- Agreed, I'll modify all irq_chip names this in next patch=20
Example:=20
static struct irq_chip xilinx_msi_irq_chip =3D {
	.name =3D "pl_dma:PCIe MSI",

>   xilinx_leg_irq_chip			INTx
>   xilinx_msi_irq_chip		 	pl_dma_pciepcie:msi
>   xilinx_irq_chip			Xilinx MSI
>   xilinx_pl_dma_pcie_event_irq_chip	RC-Event
>=20
> > +	/* Plug the INTx chained handler */
> > +	irq_set_chained_handler_and_data(port->intx_irq,
> > +					 xilinx_pl_dma_pcie_intx_flow, port);
> > +
> > +	/* Plug the main event chained handler */
> > +	irq_set_chained_handler_and_data(port->irq,
> > +					 xilinx_pl_dma_pcie_event_flow,
> port);
>=20
> What's the reason for using chained IRQs?  Can this be done without them?=
  I
> don't claim to understand all the issues here, but it seems better to avo=
id
> chained IRQ handlers when possible:
- As per the comments in this https://lkml.kernel.org/lkml/alpine.DEB.2.20.=
1705232307330.2409@nanos/T/
"It is fine to have chained interrupts when bootloader, device tree and ker=
nel under control. Only if BIOS/UEFI comes into
play the user is helpless against interrupt storm which will cause system t=
o hangs."

We are using ARM embedded platform with Bootloader, Devicetree flow.

> https://lore.kernel.org/all/877csohcll.ffs@tglx/
>=20
> > +	/*set the Bridge enable bit */
- Agreed, I ll modify it in next patch.
> Space before "Set".  I mentioned this before at
> https://lore.kernel.org/r/ZHd/7AaLaGyr1jNA@bhelgaas
>=20
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "missing \"reg\" property\n");
>=20
> All your other error messages are capitalized.  Make this one match.
>=20
> > +	bridge->ops =3D (struct pci_ops *)&xilinx_pl_dma_pcie_ops.pci_ops;
>=20
> I don't think this cast is needed.
-Agreed, will modify it in next patch.
>=20
> Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E274CBA27
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 10:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiCCJ04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 04:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCCJ04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 04:26:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B81768CD;
        Thu,  3 Mar 2022 01:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGhDT+MU6nBV23GfbnnNL6EVBXF934aPZ4pdA2IBmS/OxgAOeC8ZcBfvfnI4uezaDZG0UoVNyDLODfBcBxmq1FGILnYLRvA8fjW/Llf9tZEWtZrNJp7Svw64VW2KlGZlaMgx4JljjIezTbv46WteZ6PClTermyESKAV6H8ApycaKTKAeDo/YWUXefOl03BzNg34wGz5ImhEHukvGLQgNySDfzX2A35Rj9SJihGhYpGU9vX+QyCKhrY65X2/zoaSYaK6038NwitE1GBJBMQrT+hIjKp/d4t4vV0ofvgcLrgxHWPZgn6V6H8loZXuUhqgYLs7KtMYyMUaoHIEqfCWIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J1lLUGI4p+AaItNgXjRHKWjul3kFgSsN5pNNjVmno4=;
 b=UrAGL2ST9Qyjtu2CWUBZkwU2d3temNW37J8JR9FfGEdad57D3DtQxcmYAGB3SaRZaEMg1sEAepfah8mpVxBLEe/k/8cxUQYGsVsemdQSXRLfTgn84Q2vrio69Wk12BAPvHUSwEUqlwj5AEuBxEUTjm2p65WxydL+BgIk3yQ5nnvDzrb2iXCY0ReZqPbiWwomWXcle5WPFBwzAmhtYk5skdYexd0ptwRWfZDCxszqoQLLUAiFl0Ukhlfw323u3p/Ti112Oq8s992/xkOZzKBp68Tvs4Jc5A9pluR11lT8tfZac1oR3guwtBOFnzRqpsFzgTswAo16BG8N6alOjVNEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J1lLUGI4p+AaItNgXjRHKWjul3kFgSsN5pNNjVmno4=;
 b=mrF8/L/TIjhHEI60VE3ca8iRF2BozxatuIroOP/gMk8ckAZlmF1YE26Qjq2Khu+XJi1BOTcSnGeEB+oTWknVi3YYLxSkGV9e3RYbmGnqy4vtGi/3a4LH5rKyU0GADlB7H/Yck0CDttRA9hW4CeFDuXt3sJYu4VLEBxNGp95T6fA=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by BY5PR02MB6948.namprd02.prod.outlook.com (2603:10b6:a03:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:26:07 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 09:25:49 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Topic: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Index: AQHYImoMDICxsHV+4UiuebIA65FIP6ysUPIAgAEkiuA=
Date:   Thu, 3 Mar 2022 09:25:49 +0000
Message-ID: <BY5PR02MB6947106331FBE73A7B04434DA5049@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
 <20220215124606.28627-3-bharat.kumar.gogada@xilinx.com>
 <Yh+OUvLi56/H4l2z@lpieralisi>
In-Reply-To: <Yh+OUvLi56/H4l2z@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aacc9e0e-6b9d-4a7a-13d1-08d9fcf7ce0c
x-ms-traffictypediagnostic: BY5PR02MB6948:EE_
x-microsoft-antispam-prvs: <BY5PR02MB6948A057B8AC1893A7F85FCDA5049@BY5PR02MB6948.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0InvXFHHsRBiwJxynztUtjQeeMbT7/Yztzet7yWHuD+uXnzuzS+1D5NBQI68m5aC89YP4/4YOcDDmVAsadeCI82MfETMOIcyD/148qf3bQsDgVNb28CrOJhiX8J+SuiYVc85lFFdymDCJpb7KWpnHLkth2T64/M1EdBH3q+ZQsIrMF2L0ihWtYwQv2+74cSowlMwmpsBPGTS7O4xpEepjxRkpaxg54T6ZXmGsPVpHrDGdUB56A9+PzsCFxerxLC7zEXI23cSafnQBtk21KkbnzD2YKeT/eY8yZ5F5wBn9nWLngX9jVXUrwHVMOEoFR8ins9ymqoOBUQ3I4TmZbEFC0g788+2yqwftsa0GUl4kyQ7Iq7SUuuVMNFaeSEGG37lNZ5k6s83tFl84mduq1746+3NtdzkqAqJYHpc6Zy8YLh9F9TSI/mPA5x1S1y7K8wgIRdETO9X8cVSyq9deqhlR7dwG3hKk9k8XRDLPSsIWV9qHOmXyFBjuw3TndKyvmPUUjXmVEh/lYyG+BsvyvEHhbdX4v8RWqNLnMZgiwIoSCLmlMcRoNpm3EafAo5C/MsRig1j5vNOAAb+3LdO6E2Bjp6EOeYtCkn4b2adSrm5/ISWZuLwi9NCfOoJyKq52ZcI18gNNsTuORRD/e+n9IkbkEZ/R38U9nD0AiS6QG9UbLevMPCeGPvQkgKZaw4r4sh43PtHQ0LoBM9pKt0cqvRGpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(55016003)(66476007)(122000001)(64756008)(66446008)(66556008)(83380400001)(76116006)(316002)(9686003)(66946007)(54906003)(8676002)(4326008)(508600001)(86362001)(6916009)(52536014)(26005)(38070700005)(107886003)(186003)(8936002)(5660300002)(33656002)(38100700002)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aTa+947eIHN8XHjJwnLm17MvpKzDJ0M6/I1mZDAnVrLxsxyTmOZPncbKHUx4?=
 =?us-ascii?Q?AXcqoWPO1jHLQn8EIvFaUzDeZQbHKQ+Wa2m6Csw7myJEfQFK2k64VJd1BRrT?=
 =?us-ascii?Q?bUamKHOTPEb7KJTMKblJ9zYu0UpsnlflpyxN5kAMm26uVkuaI4qVolz3S0+f?=
 =?us-ascii?Q?64h7KMOt6fDK1x/NdHJEbPgqo8IQrQETP0uQOv9nXpso1ul8VtUYTvQ/B0Ym?=
 =?us-ascii?Q?Zge5EbqG8C0Re6AFzR0oG0izTn99+JC3Pi77Ub79zR41GS3T8jjQJNfElhZf?=
 =?us-ascii?Q?RvazhPpmo64OIFzfyRwIofRZu6zFpLToc31hXQ1QZymDhzcdxjC4xnmkL4zT?=
 =?us-ascii?Q?04I7j5AKR5hl/9+Q1tvB30I1IVLk1jOt0vcZk98JbfwBa7zPVDIsbhrLD9AI?=
 =?us-ascii?Q?IYg3j4MdNsXPqBFZbPdV0UboHq6uQgujn3WZBpGFSio/447EBEikkloR6VH2?=
 =?us-ascii?Q?jBQ8sXZ8EDtdACArl9G14Kj5xZwhP94GpO2lmgJesJe4z78lJZKflfIU3Qrq?=
 =?us-ascii?Q?0jNAxDZxeTNufA1/6gQ3/wbV4aAebNsOQkW5Z85r7m695T+/gEt6MlovA049?=
 =?us-ascii?Q?nDsmGNY8CBDqIAZC2pyBsg+tNA5raMpYr4+s3Tf4jodxfVlEHHOcnbslwdmi?=
 =?us-ascii?Q?KifPMZ160uoyqKlDBbyzw7he1yq7ErIBsZ2ZBsoPM/SA2YEMhZaA/ntnwiHW?=
 =?us-ascii?Q?uB/KhlWE5gLK1dzG3nc3mg2cgh9O+aNQ0v3VzYsHCOh+Oek+ckXe9DA7+XZn?=
 =?us-ascii?Q?wLDLUktXY+7ZvJwxOmBddQgGhKOrfF0Bj1aw8P9Uu37DDYgYGJEG4Ctb2cgU?=
 =?us-ascii?Q?wr0uwculKSUVKZhmphC18Qn5b7i//2GHbuXmDmETeE+JNMg1BszFG3hlco0Q?=
 =?us-ascii?Q?SKVuKokhRDO5jc6gnGcD9mxMbHD/1kek/zE+/F6aJ1Un7O3/HqH9ARvSq1TE?=
 =?us-ascii?Q?DcGfrL3yPtcmuaS9VSZoJEU0yPW252VXSUIrCR546DAAyZ6snX7mzTuTCb0W?=
 =?us-ascii?Q?uvgHbhPpiGtwpiRw5igIeVa9/iSSBq3jq4ivWScyWDyKUG7UjMdMQ0avyxrm?=
 =?us-ascii?Q?K289jVgoppKZF25GmD6SvWWjIreGhN4tVn8RkGk58O5KgxYvEPlUCekUKQTC?=
 =?us-ascii?Q?kg8tLYpQwmTJwrami7czSw3euhQkspeyygBbdZaURjjPJqNt1N8JX0VarT8C?=
 =?us-ascii?Q?tZRR/efGArU4oSZVJrYtCPef1NyYqFftMK3KJrT/mjg/iqEYQe0nLodGRGD8?=
 =?us-ascii?Q?rP2pusKN1mNkqHFhL8Am8d1AkV+fUzkSafrAHjFFzUMPMYcI8iX+I54/wo4o?=
 =?us-ascii?Q?XYRyUoPmtUi9zEb93m7NMqYJaEFfc7NRw+InkLs/cXz9cYX1Mua6tPQawcgP?=
 =?us-ascii?Q?00Ryv4X6MC1klMJDeu8eOSV2I3bj0o94JlboNl9DnnRS+L/qNslIxknc8j8j?=
 =?us-ascii?Q?LKjGBQw49EfjtHLdZEhULr37vMpL+NRPuorFCnhvRIKSOEwbW8y0pcEqfTbM?=
 =?us-ascii?Q?jEvlM63QVoLdZHqCWUsw/CfC9JyxmLMkhMNE2njNN3E7PxAC3kk1v+IdaOVd?=
 =?us-ascii?Q?2FFTP/WBEkkLZWGTlNKN6UJqo//g3omAnaHHm5n1XDTz7aNxcbn6vxHCMDaQ?=
 =?us-ascii?Q?KTIsqURpmgrkAC18ndB+LxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc9e0e-6b9d-4a7a-13d1-08d9fcf7ce0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 09:25:49.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOqDiiGLnZK5/XpO1bAmsAAUoW2tMTLpRYExjcYUcUv+BKHbBkg02xsoZ0ECl6nB6Bj1clsE6z6IuECK1hfX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Tue, Feb 15, 2022 at 06:16:06PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additional register bit
> >   to enable and handle legacy interrupts.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 33
> > +++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> Only a couple of very minor suggestions below.
>=20
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> > b/drivers/pci/controller/pcie-xilinx-cpm.c
> > index c7cd44ed4dfc..eb69f494571a 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -35,6 +35,10 @@
> >  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> >  #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> >
> > +#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> > +#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> > +#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> > +
> >  /* Interrupt registers definitions */
> >  #define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> >  #define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> > @@ -109,6 +113,7 @@
> >   * @intx_irq: legacy interrupt number
> >   * @irq: Error interrupt number
> >   * @lock: lock protecting shared register access
> > + * @is_cpm5: value to check cpm version
> >   */
> >  struct xilinx_cpm_pcie {
> >  	struct device			*dev;
> > @@ -120,6 +125,7 @@ struct xilinx_cpm_pcie {
> >  	int				intx_irq;
> >  	int				irq;
> >  	raw_spinlock_t			lock;
> > +	bool                            is_cpm5;
> >  };
> >
> >  static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg) @@ -285,6
> > +291,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc=
)
> >  		generic_handle_domain_irq(port->cpm_domain, i);
> >  	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> >
> > +	if (port->is_cpm5) {
> > +		val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_IR_STATUS);
> > +		if (val)
> > +			writel_relaxed(val,
> > +				       port->cpm_base +
> > +				       XILINX_CPM_PCIE_IR_STATUS);
> > +	}
> > +
> >  	/*
> >  	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> >  	 * CPM SLCR block.
> > @@ -484,6 +498,12 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
> >  	 */
> >  	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> >  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > +
> > +	if (port->is_cpm5) {
> > +		writel(XILINX_CPM_PCIE_IR_LOCAL,
> > +		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> > +	}
> > +
> >  	/* Enable the Bridge enable bit */
> >  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> >  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> > @@ -504,6 +524,9 @@ static int xilinx_cpm_pcie_parse_dt(struct
> xilinx_cpm_pcie *port,
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct resource *res;
> >
> > +	if (of_device_is_compatible(dev->of_node, "xlnx,versal-cpm5-host-
> 1.00"))
> > +		port->is_cpm5 =3D true;
>=20
> port->is_cpm5 =3D of_device_is_compatible(dev->of_node,
> 					"xlnx,versal-cpm5-host-1.00");
>=20
> ?
>=20
> > +		port->is_cpm5 =3D true;
> > +
> >  	port->cpm_base =3D devm_platform_ioremap_resource_byname(pdev,
> >  							       "cpm_slcr");
> >  	if (IS_ERR(port->cpm_base))
> > @@ -518,7 +541,14 @@ static int xilinx_cpm_pcie_parse_dt(struct
> xilinx_cpm_pcie *port,
> >  	if (IS_ERR(port->cfg))
> >  		return PTR_ERR(port->cfg);
> >
> > -	port->reg_base =3D port->cfg->win;
> > +	if (!port->is_cpm5) {
>=20
> Nit: I'd keep the check as above for consistency but it is not really
> important:
Thanks Lorenzo, will fix these in next patch.

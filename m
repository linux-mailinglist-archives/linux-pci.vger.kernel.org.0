Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04F96F0088
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbjD0F4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbjD0F4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:56:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D85359E;
        Wed, 26 Apr 2023 22:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnp6XL2P4qMx0hGu3w7Dg/Msy5i+gNgjGK5Z8+T/MnJn1/3XVJn4EwdtTN8lwoTaf88D7xK0dh3UH3clANxw9LY226cySDcYDYPGhr1cTfjf/31//Xw8UiX+zos15dw3yCSVfJ/wvo4f6saZ4Bq6ASMhHHPqtmHHehMM0Mw5laxjkaJOuib9qA+JiZPyGI82J9635ZLWL1JMos8LrTiIiVdCdlzkvjWwsikMUZ0cpowjQgwZ3+fSa46pL2ywKFu0q9SH89xxs/c865QMYu6ayAoWvq8RsahqzkCSC451Cx+OSAogcmYeOCVZpJABRMvNkJMax9KTsWCLhLDojlL7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4BuBdFL3PIXCOkbNsxh1JvSkNUNXRY09XXdruPrrPA=;
 b=YzlPP/FvjZtB7FQp9jLvMnc5uGd7nOCLEAjXR+1I2g0EGa3kQipP/m3KKRn+SzYHyjZWWby4k/o1rqTGmrst2yMWUDfYB/sKfy8FDa/Zr9JrGBQkZXE8HdDD+1v0u9kZ/P44wDzXV+4IAFbbylwk29mjN5bYBsAs4ZdL42HFjDrXMo/aUbnHbJJ1Edn0jpi464wHS6/zUDFFRrea4ts6qD5rR7hz84WDeCfiuzmcwxaW3YiwyYFBA2lAGzepVFWJGWA5bQcblWxD762XwczToFwuU8AGFV0SFD0j9+T4c++YmXtdRfrp+gXINCam4tYLMEfqmA/x9eyzaeEIgtOn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4BuBdFL3PIXCOkbNsxh1JvSkNUNXRY09XXdruPrrPA=;
 b=wt2f5eOdz7hcQwmSPzEH+Iu860TMm9wFdyee/DySyE5DSgOW4L8PZjcEEq9VpLdi4M++NIPB8aDuknmsYbSVcHo68vgtCevynYemOeq/l+13TxAt+iTtlDBYJAX2zpdBamTL+5PoLxwQOzp3tE8BQyY/npbmOfdi8RV+073dZN0=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 05:56:00 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1%6]) with mapi id 15.20.6319.033; Thu, 27 Apr 2023
 05:55:59 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Index: AQHZcRgN8e4TUCjOm0i7jLpQKqxR7K8wCpaAgA0qSXA=
Date:   Thu, 27 Apr 2023 05:55:59 +0000
Message-ID: <SN7PR12MB720174840144F13B58F1385B8B6A9@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
 <20230417103226.334588-3-thippeswamy.havalige@amd.com>
 <20230417214847.GA3441806-robh@kernel.org>
In-Reply-To: <20230417214847.GA3441806-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 79d7268b-2be1-4483-e285-08db46e4138a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xc75oncU75nYyhR3hODh8K1cRsz6fD3vhpOd2pDeQK1XstTOoPzVIBeELO22zmGltInzGXjRMJl4LKgFkzPIklbr1YibXyRWPYTY9zl32Geaw0mgLmacNu99thWcRsYIvG9kof0Pli+OiI51Etwla8xoX9URnmd4x4YdOiarybipm9fmvzbQsmsoPcDhwj+DGQch2QIdcfwoQNEUedDaCiHMlDP44ps0N9/igNvaqv0R9dRr5V6OnO7IKwpzM8u0oK90fGtM5zFFRpgEEXSoceWMj8DmrueNptBYl2V8PObh8rtNutQ99a9V+OGoGhZrleZx6z6yYYQuavIRIkebKjvEvb7QnwYFFmuHmdCtowE4e7Uucevny4Ake0c8pRGZrTZcXzheroUKdSTKevYcTdHLYUv5R1mhWKmEvbKfDgwR7mH3925YH6e/jAcT2pH9dcOH7/o6JtsIotnxJTyVL+Vh4Ft4dFDvlHYMJ1h9YFJmr+utSecDFUNO6OpeYmclqU6HR8qEdZTqK2LQidUXb9gUrgTUiFjz3qMbZjrKT223xNsSemF0YlrIQW5MqjCNLWTrZ8DDJ4Z5wcuzrEUIpdKdRIZBcTqEH9fYsq3neJBzwWHbx8FhlIl+vzdHKj/s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(6506007)(9686003)(186003)(26005)(66446008)(52536014)(66556008)(66476007)(6916009)(4326008)(64756008)(55016003)(5660300002)(41300700001)(76116006)(316002)(66946007)(71200400001)(7696005)(83380400001)(38070700005)(54906003)(8676002)(2906002)(8936002)(478600001)(86362001)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XMBP5cJM9MZDYAS90/D5Ta3fgaYqpf7bT2LaaL4linnolTpg8gesY8SchShf?=
 =?us-ascii?Q?wd8eQjJFWTlooH3TF1c5uDHrfcgvyyWdVYtwJGa81sZIpGm3uRUBKvMJGDQB?=
 =?us-ascii?Q?HucR4eiDp4ghxBGeejy4+lC9jpl/FY5wHnwpKip7H4Qrx9TyGV98KuG5QU8f?=
 =?us-ascii?Q?+t/S2B3PxQkKS/uXoG7oONB/pqYWKHKvUk7JKhi3qSH2fBvs7o7iZtj6Gi2k?=
 =?us-ascii?Q?9OTr5kOC5l2Ex8r677tZfkejuiWvUYf69gWdJv2BFLa+GsspcHqBuntiiqEb?=
 =?us-ascii?Q?cA8+/5IwRNqiJfZKDuSYYYqGLdn62Tdr2hip+GCVx+G+7Kpe/jWSEPf+Um4z?=
 =?us-ascii?Q?9d0cqgvhC+7Do7Jq6004Uo40fYCowtnP8CXQ/UuKiTKhM+ALTwN17dVolt33?=
 =?us-ascii?Q?RPVx018qRBkqh9Rewu/MgHchSvkjTXID8lxF3u2IsG8wPHBUpa78l7J5WiMf?=
 =?us-ascii?Q?Mq9U+CR84MmvZwIv1vMXfMRyBLrlaEuISEngjCYs95nmSpS0wUHGAsp2zuuH?=
 =?us-ascii?Q?NcLIQ7d0MKOadAet0E5TGFO6fK/pw9xMOVdCi00s0ROS3uCm+9nCTFLKVVnC?=
 =?us-ascii?Q?1FAy+rs+hWquJNq19dEk25spkAlfgRhEyQd620lRAW+jkKEgnaeBRdCRE152?=
 =?us-ascii?Q?dICGEbCl+IbzkSv4ZvzaNTcHqnPVu43MoxUDKQCER3Whs8Bb1iP9UwS7qpet?=
 =?us-ascii?Q?qJa2vx1YWoLefSv+YBtNTVq75zh81FE6emErLVCEM8XIJ5H6oVz8MVcX3sw5?=
 =?us-ascii?Q?tp2IaDDNucEjI9lkcSWftrTYy5jVc7BcGqY3kcwCWidqC+0VviJJ2sqm/9qb?=
 =?us-ascii?Q?sbjP3SJXcT/ZsHbOuIVdawV1BWusSwSCtVlcaicGxJWSbQEO4wyk/5iU41kI?=
 =?us-ascii?Q?k2+EBIBF1UTQkHSX9yEPQoTiF38P5kWN8mizQlCTXETlVeSu9qFGsgkX74TH?=
 =?us-ascii?Q?Ixowmrtl0xyA6VLSQotGNmSqQ4ZGldGFDuQ6yXgcc1Gn3+1eB+ZU6gLRyG7M?=
 =?us-ascii?Q?K4prxycV8ePTEY/wXZ+m4mldZDP+97aeqVYbjucJuCcww+GI8hs5FZFoYbpO?=
 =?us-ascii?Q?wO1CzQ15cMjvXThCMNvuE8E3/SPmlEbTg/tlRysEezMJKhmSF5OXDSxj24dP?=
 =?us-ascii?Q?FLAqtKcg6b9rg3t6ck0QiafCyd7INM2c1LiSWYdTCWjSD59B2fdn5brxBFCU?=
 =?us-ascii?Q?uU4isDp9pjxffToKP31egVbHVzpL/RR0fqQ9IC5Mp6kGDMOXfV3Wgw/wY6ER?=
 =?us-ascii?Q?ExXH4lxBdh2cMt52FmlhIwB+XzACopXwgcplRtzFsf8YFrPY+7qPkgBApnlm?=
 =?us-ascii?Q?ngSKBFjnIMBhKluNBWCdsA02jDW+INTybNxnzjea/xEeHm7MSet9+dWFPtVd?=
 =?us-ascii?Q?d5jFOJ6Ixs8D9CWkCBRg8k9GGoI1x2Va67Tkkt6EG8wm9KxVCryrtPWKevwC?=
 =?us-ascii?Q?21rEdy3/rYDF8CO5or5UFIx29Xbb1HrAGdqfBNREF6qxb+zumk25HSPdTJpb?=
 =?us-ascii?Q?Ghesd/wL5wz6ndIrGdr+PTMQ8yEdUESl20h0tejsP6GVQPTkeLIj98U2XH4D?=
 =?us-ascii?Q?cM2tbKVoQW4YhbgBx7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d7268b-2be1-4483-e285-08db46e4138a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 05:55:59.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 789cW2Gqn23NKblfuEPbSZZyFOQwvoHi4Agqmd+6+Fl9Om6QZk91fcHL/NGLsrSy7C+P1SBKcEzJzTVPZFtfug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob Herring,

Thanks for reviewing, please find my inline response to your comments.

Regards,
Thippeswamy H=20

> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_pci.h>
>=20
> > +#include <linux/of_platform.h>
> > +#include <linux/of_irq.h>
>=20
> I don't think you need either of these.
- Agreed and will fix this in next patch.
>=20
> > +#define XILINX_PCIE_DMA_REG_MSI_LOW_MASK	0x00000178
> > +#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
> > +
> > +/* Interrupt registers definitions */
> > +#define XILINX_PCIE_DMA_INTR_LINK_DOWN		0
> > +#define XILINX_PCIE_DMA_INTR_HOT_RESET		3
> > +#define XILINX_PCIE_DMA_INTR_CFG_TIMEOUT	8
> > +#define XILINX_PCIE_DMA_INTR_CORRECTABLE	9
> > +#define XILINX_PCIE_DMA_INTR_NONFATAL		10
> > +#define XILINX_PCIE_DMA_INTR_FATAL		11
> > +#define XILINX_PCIE_DMA_INTR_INTX		16
> > +#define XILINX_PCIE_DMA_INTR_MSI		17
> > +#define XILINX_PCIE_DMA_INTR_SLV_UNSUPP		20
> > +#define XILINX_PCIE_DMA_INTR_SLV_UNEXP		21
> > +#define XILINX_PCIE_DMA_INTR_SLV_COMPL		22
> > +#define XILINX_PCIE_DMA_INTR_SLV_ERRP		23
> > +#define XILINX_PCIE_DMA_INTR_SLV_CMPABT		24
> > +#define XILINX_PCIE_DMA_INTR_SLV_ILLBUR		25
> > +#define XILINX_PCIE_DMA_INTR_MST_DECERR		26
> > +#define XILINX_PCIE_DMA_INTR_MST_SLVERR		27
>=20
> Looks like a superset of the pcie-xilinx-cpm.c registers. You can't share=
 some
> code here? Like all the interrupt handling code which does nothing more
> than print debug messages...
- Agreed, will add above macro's to common header file and fix it next patc=
h
>=20

> > + * struct xilinx_pcie_dma - PCIe port information
> > + * @reg_base: IO Mapped Register Base
> > + * @irq: Interrupt number
> > + * @cfg: Holds mappings of config space window
> > + * @root_busno: Root Bus number
> > + * @dev: Device pointer
> > + * @phys_reg_base: Physical address of reg base
> > + * @leg_domain: Legacy IRQ domain pointer
> > + * @pldma_domain: PL DMA IRQ domain pointer
> > + * @resources: Bus Resources
> > + * @msi: MSI information
> > + * @irq_misc: Legacy and error interrupt number
> > + * @intx_irq: legacy interrupt number
> > + * @lock: lock protecting shared register access  */ struct
> > +xilinx_pcie_dma {
> > +	void __iomem			*reg_base;
> > +	u32				irq;
> > +	struct pci_config_window	*cfg;
> > +	u8				root_busno;
>=20
> No need to store this. You can use pci_is_root_bus().
	- Agreed and fix it in next patch
> > +	struct device			*dev;
> > +	phys_addr_t			phys_reg_base;
> > +*port) {
> > +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> > +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0; }
> > +
> > +/**
> > + * xilinx_pcie_dma_clear_err_interrupts - Clear Error Interrupts
> > + * @port: PCIe port information
>=20
> You don't really need kerneldoc comments on private functions.
- Agreed, will fix it in next patch
> > + */
> > +static void xilinx_pcie_dma_clear_err_interrupts(struct
> > +xilinx_pcie_dma *port) {
> > +	unsigned long val =3D pcie_read(port, XILINX_PCIE_DMA_REG_RPEFR);
> > +
> > +	if (val & XILINX_PCIE_DMA_RPEFR_ERR_VALID) {
> > +		dev_dbg(port->dev, "Requester ID %lu\n",
> > +			val & XILINX_PCIE_DMA_RPEFR_REQ_ID);
> > +		pcie_write(port, XILINX_PCIE_DMA_RPEFR_ALL_MASK,
> > +			   XILINX_PCIE_DMA_REG_RPEFR);
> > +	}
> > +}
> > + *
> > + * Return: 'true' on success and 'false' if invalid device is found
> > +*/ static bool xilinx_pcie_dma_valid_device(struct pci_bus *bus,
> > +unsigned int devfn) {
> > +	struct xilinx_pcie_dma *port =3D bus->sysdata;
> > +
> > +	/* Check if link is up when trying to access downstream ports */
> > +	if (bus->number !=3D port->root_busno)
>=20
> Use pci_is_root_bus()
    - Agreed,fix it in next patch
> > +		if (!xilinx_pcie_dma_linkup(port))
> > +			return false;
>=20
> The link went down right here after you checked. What happens next?
    - for above mentioned case, for the transactions which are sent but not=
 completed, when link goes down, the bridge responds with SLVERR for these =
requests.
> > +
> > +	/* Only one device down on each root port */
> > +	if (bus->number =3D=3D port->root_busno && devfn > 0)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/**
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_pcie_dma_init_irq_domain(struct xilinx_pcie_dma *port) {
> > +	struct device *dev =3D port->dev;
> > +	struct device_node *node =3D dev->of_node;
> > +	struct device_node *pcie_intc_node;
> > +	int ret;
> > +
> > +	/* Setup INTx */
> > +	pcie_intc_node =3D of_get_next_child(node, NULL);
>=20
> This breaks if someone puts the PCI devices into DT (which is perfectly v=
alid
> to do on any PCI host bridge). It also assumes some order of child nodes
> which is undefined. Be specific about what child node you want.
	--> Agreed, fix it in next patch
> > +	if (!pcie_intc_node) {
> > +		dev_err(dev, "No PCIe Intc node found\n");
> > +		return PTR_ERR(pcie_intc_node);
> > +	}
> > +
> > +	port->pldma_domain =3D irq_domain_add_linear(pcie_intc_node, 32,
> > +						   &event_domain_ops, port);
> > +	if (!port->pldma_domain)
> > +		goto out;
> > +
> > +	irq_domain_update_bus_token(port->pldma_domain,
> DOMAIN_BUS_NEXUS);
> > +
> > +	port->leg_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> > +						 &intx_domain_ops,
> > +	struct resource regs;
> > +	int err;
> > +
> > +	err =3D of_address_to_resource(node, 0, &regs);
=20
Use platform_get_resource() instead.
--> Agreed, fix it in next patch=20
> > +	if (err) {
> > +		dev_err(dev, "missing \"reg\" property\n");
> > +		return err;
> &xilinx_pcie_dma_ops);
> > +	if (IS_ERR(port->cfg))
> > +		return -1;
>=20
> Return the original error value. -1 should never be used.
 --> Agreed, fix in next patch
> > +
> > +	port->reg_base =3D port->cfg->win;
> > +


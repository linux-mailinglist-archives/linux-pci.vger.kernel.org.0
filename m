Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2136F33AB7B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 07:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCOGNB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 02:13:01 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:14817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbhCOGMs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 02:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9MoIi3akecF1BHX4WveaE6NrR1yW7Jo5rT0QLMP/nMWkk2m5r6o8B3wbOkphak6EQVspkFkVhm1TIPQ3MqQ2bGoik/RDL9eSqagP7dfWwfzBPMSDM7xkqR2LLolZ6yKo2hZ/i1LywGtiUAbomUwREsMuCbv4JAhVsnEeiA7FZObzQjxsB7hxOQ4zF6b4mhnIqFM0lAin1YF+dwqENe7oA29LzRFRxxnj4IxuvAgabDRFhiXPekWKxiWoeqpe5bc3CqNjA+dk3UGntC663SadtVt81/78dp+Wad+uPX2Abu1EgLzJ7x+Y8A79RUKbEWhFerENUW/SdXupptjx2GwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCMJxokeKXVf1WEb2VzkmHzhA1rTvMFz5pi4gDMWk34=;
 b=Yk0IIMPBJ0Mox0vAaudvz+pkPL9iWA7qSMWAjbXfaAukJkAxmYqEbzeiwLDHgJSlw44fwZrAQvE0mv9IMrvgjlxfwIksjP7lxFu0dt9s6wt5spzPNUa06FjpcSEM8zI3MVwSEOQiYmjZhHOxJFIEFfhlUdLvydBttvpJhuEg75+IysfwaARceyRSKD9ZjnlIS/uIv3+HNu/sHozUW3kS0bG85XN2M3WJ5w3M0OpY/Usjxcb7azklJ5a7+xQUXLFEbqPdDHVSJZ6aML8WmEfnoj9HXXe67tT6yrOHWYwBrMTaoPC22G+eexoc3jWR212m5YvKP+piJn3RDIbVh+uQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCMJxokeKXVf1WEb2VzkmHzhA1rTvMFz5pi4gDMWk34=;
 b=goyuLeEIquRbFpz7TE9N2fTvlGLibiX/9bTwCGKU8EYE5R0khIa+GyFZDlUVqMyMj3LHpgXG1bmX1tG76Z+Ma23E+AsSNlUjtDMmj1xeZRSu2k0WHqjjVRJjZd517BR7nOFxfGdIVqx0Y3R+yuKdXbL7KF6jkeetv8JT06E2O7w=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5829.namprd02.prod.outlook.com (2603:10b6:a03:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Mon, 15 Mar
 2021 06:12:46 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 06:12:46 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Topic: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Index: AQHXCPdf8/XRKTi3FEaC06+ar6fH8aqEsnBA
Date:   Mon, 15 Mar 2021 06:12:45 +0000
Message-ID: <BYAPR02MB55590903AD09A045B8A345BFA56C9@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5993871d-010e-4d84-a871-08d8e7795a2b
x-ms-traffictypediagnostic: BYAPR02MB5829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB582999806AE98EBAFB742FDAA56C9@BYAPR02MB5829.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ktEyC60GYU7vFC6ZOvCZHh1VB+WvtOPwODbk7Dxs7jNZ3T6VWUMrSNeGb525gxFypqdLATsO7Vj7u1MPqbbMqdehNtITHvKBTT1wzzWgjhSjeZ1MHwd5dNc6BgpS8+FGOR7bjy2obARODkVXR2wF7u5N4XHwabXMBw8+/yJgQqg+Y8W6YD6mtmP+08URn9Jw6lrmfCsizMZCRsWNqG37nMuufR8ZfyI5TnUax48F76xKWgaHoeRpiytWtYwxsSOYSQm4Z7axzpGCqISuNvSNq+pyPS6+Anf7BMPm5ZfDt6lM6SqLLj1EQ2arRr+WFONk/DQ/O63/3JbshZdscbPC7Qb1UOH7hSJ/jDbK321kVXR2pUhoBp5cISBmOTCseumi5GMbzjF6g1YJv3HhCUEd6bRb5VFuRFWwHg5gMGdiEDk9UjbWpQhW3IEe4v96JWZ8QklZJA2YX5vCJU+/knUL6JnWc3532d5qpscKCpRG57+mddcQyE5Dc8hj2D3kSkaxJ1GM5rAEgdSEYmgaw0bYS5h/zK84McIwzhEL+IxXpR6kAQounthNgp5FkaGWmTOmqVZJi4uNhS9UwgFinrPKv6K70AbtizlOkA/HH3E4f0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(366004)(346002)(8676002)(6506007)(186003)(966005)(52536014)(86362001)(316002)(2906002)(110136005)(76116006)(55016002)(53546011)(66556008)(66446008)(7696005)(66946007)(5660300002)(8936002)(33656002)(26005)(64756008)(83380400001)(71200400001)(66476007)(9686003)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J4fc9mIqyhDZX2H2Qzhn6xR7TyrSU3dWeujOQ+wsKcJaiLEztxBypvDDdS79?=
 =?us-ascii?Q?VUVrlJ7yiu1s6HiEyBe3mq2qPJ60eoQ7YY4zjkBMOFEDic/yQVqpeG7i48dw?=
 =?us-ascii?Q?k/NNSiLrNGiImBUMrpaOo7UoyIX1J1n1C8CoSeh5kGApUyLsGhgQxeHJtqeO?=
 =?us-ascii?Q?iMvLbOKXr3+jA3QHaN03EnFxAJD9AhX8ApoLkgZU9CQsXJVnBRjksLihouad?=
 =?us-ascii?Q?sh4hr5Nnedd4KjgrGeu/rkg7gGt5DHln+/xZpels5LTiSYmaBpFuOweT9EEh?=
 =?us-ascii?Q?Lju0fSXIrqsrMsnJCpdAJNPxPRLEIyFYbkGLq1EuqMkEbq16kHUTWoayIAaH?=
 =?us-ascii?Q?ReQZPQkSyqPBhFTeqdS9H0cIOBIcx5Tvid1dBvGZzdQm+kAzj/l3gMfqTjae?=
 =?us-ascii?Q?N5ov2ep+dfIGUEomwvCTfDo0220JdkFvhppFdTMq5vNP+3I4pkC8X8nFi5Wu?=
 =?us-ascii?Q?t+p6HKO39gXLCwZDTKyfrfCUbyiwrPD4WLUJk0Z05K7bhL4uYvaa3J/V62jR?=
 =?us-ascii?Q?cxcTYKJEFdQjrQA/463oQJ31YyOkZ1oYesqCWC+mm9n8mhy37mWdfPj8Rv+z?=
 =?us-ascii?Q?t8fdOtx2/RKCsnkpTsLNyLFzWU2HSHRdvlvZDYTD1KXfMwUuZT74cSTHQcMU?=
 =?us-ascii?Q?pa7rb1Ty58lWBRoCQjhF5maOkoZIdicuEYBGdBXVe000qaK56TdXX1XxxhUm?=
 =?us-ascii?Q?KBBMtMGNQfnFDnT24CUzrVXyiJUArWCbPPko3mp+9JWevejPXCsGpzbmjz+f?=
 =?us-ascii?Q?cAMZMLQKjQTy4iCJZj416jvC52V5sslwDtalKm2TtXq86wXXAjpzq0fDE7DU?=
 =?us-ascii?Q?7/H6FE+3NesSisSYi/TCgHZo/jD+yItG0nyzas1PJkPOt77P0V/SP3MTb0pT?=
 =?us-ascii?Q?NFuJGcjtehUTye7YXwL3t2THQ78mIOHrss73PKm9aTcnK6rXKR2OueywbeBc?=
 =?us-ascii?Q?kwKthpzogJi93CrCL3i+VW2CqZ5pua3NpdH4Hi2T6WFj9i09n64/cFH529ap?=
 =?us-ascii?Q?yAj0mqOidpqkxv+dTZNOOZDQVTIyDIwJzLARGKuLRIGXcdrg03yJ32nYfJCl?=
 =?us-ascii?Q?Mapj0PiPKLicLv9pZ7hsLK4xOt4nBTZ84vxWMuZw7Ey5WXMbGDLR9fKI82rm?=
 =?us-ascii?Q?C55vJ9WpWW2UYWAcKiYMvMDxeTjEx589AQBHyj+NqECIpzkdRLXbgfiC4C4n?=
 =?us-ascii?Q?VtA2sHmWdZPXJZfAtz1iO5Pnx3dT7q5QtrF4SZ7p22DIxHwaUr/CeGhunJ7I?=
 =?us-ascii?Q?1dTBQhMHNf1JixIQqWs+I7HSKKAHxjMPtknhjcKhbVH605hTwLbFzP1T7ZVn?=
 =?us-ascii?Q?fzYkG7WVJt43q7C8bZf6RYXK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5993871d-010e-4d84-a871-08d8e7795a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 06:12:46.0546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDW/pVnMYnWgWTkfXczqWQ2NAGWAU7yo/jR5u9GTdQ7sPcZqlJvf034i36F5rWoJ2yJgSCxW+OEuEZ408oWI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5829
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping.

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Monday, February 22, 2021 2:18 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
> using CCI
>=20
> Add support for routing PCIe DMA traffic coherently when Cache Coherent
> Interconnect (CCI) is enabled in the system.
> The "dma-coherent" property is used to determine if CCI is enabled or not=
.
> Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> for the CCI specification.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 07e36661bbc2..8689311c5ef6 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -26,6 +26,7 @@
>=20
>  /* Bridge core config registers */
>  #define BRCFG_PCIE_RX0			0x00000000
> +#define BRCFG_PCIE_RX1			0x00000004
>  #define BRCFG_INTERRUPT			0x00000010
>  #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
>=20
> @@ -128,6 +129,7 @@
>  #define NWL_ECAM_VALUE_DEFAULT		12
>=20
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> +#define CFG_PCIE_CACHE			GENMASK(7, 0)
>=20
>  #define INT_PCI_MSI_NR			(2 * 32)
>=20
> @@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> *pcie)
>  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
>  			  BRCFG_PCIE_RX_MSG_FILTER);
>=20
> +	/* This routes the PCIe DMA traffic to go through CCI path */
> +	if (of_dma_is_coherent(dev->of_node))
> +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> BRCFG_PCIE_RX1) |
> +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> +
>  	err =3D nwl_wait_for_link(pcie);
>  	if (err)
>  		return err;
> --
> 2.17.1


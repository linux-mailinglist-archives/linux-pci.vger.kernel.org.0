Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98935266B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Apr 2021 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhDBFbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Apr 2021 01:31:19 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:62369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhDBFbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Apr 2021 01:31:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPceVd0w1LKy4uVInI61iJrp2bbKaTZsOpKe0QCn0y65/vt6r70RU6THpv0ZJW3oTT5BcDeLl/Aktw64H8r7dqWbhGCgjK8tKk4JiHmpVYEq+1PkDekZ8QzI2bzduaIE7L/uoNzFjCZNrNfhRXHPTYQp1e3HX0f+1IfJv2uAcI5FuejO5XWAvZHKM4aZrNFDkbwxue+ddzOxVJcqr5v8lH2VlAItboHkOTJDyV1WCcg63FcUPOlXL8auUI30O/EYZpXulRkqKZx5aLqAjrtegquzWKO5vqLec025q1fbpxtAOvQnjUmNK07Kkr5dv+1Dv1LOY6sprBtAZGVv6vKftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3saX1OoqW09TJDDV4K+DKdtdUm1YOme9R0UF9GBxU=;
 b=cscoNvQInp/SuFD6lkJvxrhHjxIamb8c01WUwvbaZmlIYECrtf2LHhajeE3b672+E38VqGt1/IdewmNxg2qmfl7rqpuq2tfdQ5sDvk6vOb1qdgGv/sM9XIhAv4T2bCt3rZ8rCaKI+wLqGQ9gWD7MgvcVYgd/AeEskCRAPlOSzzKik64YoypnkqLowiXXrRSrUd9NN1enSGF1lFHHVkUO6pqe6bk6JyfaRTlidewB2GL+eSrGTRmfbXpN6EWsuJNsgLNSjdAQ1jGWqWnCYhE0or/8drfz+Ml0fbqGDk+jvU4516Lrr4lksX1lKPn2li/VrpJFnlyansbLc78l3zgAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3saX1OoqW09TJDDV4K+DKdtdUm1YOme9R0UF9GBxU=;
 b=Kvd+7hgSvvjRSJ4HaMNDV5LorK5rc1HwDEVe2LVaPTiDLKsdkVIib3pi+9KcsxQbYVnppn3XOHZ65kOSI/zkEuCjQSCaN1qUAvJ5JtFYr7vxhYzg2jKP0Tiovxr+lzLulXiKVnFEVOhxb6Rq+CRZDb4lqIW0crhfYVsb6ATAirQ=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4406.namprd02.prod.outlook.com (2603:10b6:a03:58::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 05:31:14 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 05:31:14 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Topic: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Index: AQHXCPdf8/XRKTi3FEaC06+ar6fH8aqEsnBAgAzn4TCAD1UeUA==
Date:   Fri, 2 Apr 2021 05:31:14 +0000
Message-ID: <BYAPR02MB5559CD3C8721F770CF4D4885A57A9@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
 <BYAPR02MB55590903AD09A045B8A345BFA56C9@BYAPR02MB5559.namprd02.prod.outlook.com>
 <BYAPR02MB55599675DC55C6F7568B6FA6A5649@BYAPR02MB5559.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB55599675DC55C6F7568B6FA6A5649@BYAPR02MB5559.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 558479ee-e758-4401-8523-08d8f598888e
x-ms-traffictypediagnostic: BYAPR02MB4406:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4406B4131C58427526C3BD8FA57A9@BYAPR02MB4406.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zo7OP0YLysmeNpHlTvHATsfMFz7boWWlHbKbnDcdNmzft2/SgWALNhZ5SDp98EIhVprVgnQ9srQsnPdjwEA/aVA0zRwZkiylFEA6DjAUxPyO9f+aaU2qFF/SwH7twRclkOd2AQo/4xt8ifNi4GFusSRsUT0ctVmtPZIETFbTKmO3ZcKJOIYwttnTtTO7wppSKOrXERF47efNslaIWdFVElIIb5iIUI42aB9+CW/MNJhxAp5qBM6HgzLyG3GqyGrQ8DsyvX+X6Jkjc3Sj71Vngq4hiaYEc8VtWadhdXCuYe8QBoMaqI32Eb6UHu78yoWXCoZa9re5r/sovJBl0biWRhegTITVCQVWQldSmPXq1fsIP326R+5OyFKonDLhnbd9TsL/wg45V2iPj1+bMetrFfrXp66BQZOyB3z8z19H0EvU8++RmJEXhzLON5BLg1SeKUuXgrU/HcNKKthVrmUVTooyivktcynelm5sjrVvFk96S4POM5UnzsUcrpAMyALExK6WqtPBrj+mUqU+Hb1U9+qcEsZpAjxQiU6ZoeY14Y/RzN5nGOmm2JtJEuzw0aKxTsvrF0z77oTbuUOlawZ7lTo3JWOQcproJzVOxapxpjaZQ26Ki8+/F2ZPLzsmksLdfgkLI7YzvtwmSpTG3BhgPvTrP0Y+nppcvY+mQHJvV05tdqm8p/5np5qU4UTQtu1FZ/ZxIiNIONHoZcM5Ygx2ZfjKkfh7mQOtgdyL1TPDqVwEiHzL9n08QvULbPXbpY1K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(7696005)(66946007)(55016002)(54906003)(52536014)(2906002)(9686003)(5660300002)(33656002)(8936002)(53546011)(86362001)(83380400001)(110136005)(71200400001)(64756008)(66446008)(4326008)(186003)(66556008)(66476007)(26005)(38100700001)(478600001)(966005)(316002)(6506007)(8676002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jO3Ch0gAVvCRQ21h/SNUPX7kM2jCdwlVJDTSg3gYAWgDDnTGHBY+TWQFfOgp?=
 =?us-ascii?Q?XnQnJLsH5LmWsqcaNjVj52VSAhJLVTGot2PaRI70laxRIeDhjYkzb0epKU76?=
 =?us-ascii?Q?IyEQbx5bH1Mj5Hwf/8U/aFK33i9mQKMKhsXrU2fgZtqo7QEdJsJoiLsCQhoz?=
 =?us-ascii?Q?RFp4Af8Cfg/rAkqLdobPS7D40W9Ckf1o92rlGaZIo7mIgjlRpnDbp0uDgTUR?=
 =?us-ascii?Q?rVRhhkpt5r2sxelzKlgyUS0/DCdL5bVCVYIFRZ1X5pNRi+IvROSgOpodlsko?=
 =?us-ascii?Q?3iAcrLGOwj05yl0IWnli3uPPvfJsmfl0yfalM3dWaaxqaDDA/4KztMiQTtnS?=
 =?us-ascii?Q?L1AwxXX6jHXCHex8yIIOMIV8+hzHPE5X+QLKCMzNYLiqJdutvAMl0NK+pVN0?=
 =?us-ascii?Q?7D7C5CBnJG4XqbkP8Uqep/oR0DuMTOOB2F654xyU1iUHlnbEEDiq8iAyxgMi?=
 =?us-ascii?Q?GEFWX07d0ZShNqJHsEoul42Rav1h3rV21rwZjLbT/Py/aA7o4bT0b3hvf1Jg?=
 =?us-ascii?Q?umYKggKzutv9/TThIa4QKFVmLSnn28ApXADp8qHXluJGJAVUgoWNCS75Gt2g?=
 =?us-ascii?Q?t94Ai/gCpgoyErc2mb6jHnwvaYp9t+fs2FJi93l3MfBDQw/REvxyjsWrYmLA?=
 =?us-ascii?Q?tPBURWOIq1HBzotAItca3XK4vhBf+waLPcR9Wm5PCl9lfaU1oKlV/Bhwbe6s?=
 =?us-ascii?Q?WcWp4fbkyxi11KQrnoQvjx526bIEBPVufO3uWnwT8k7knLMqBMeNrGgwMkxi?=
 =?us-ascii?Q?Xq+Mc3cwqndED4ptrMU/PtktxWJ6Vcc4IgCTW5sVqVVJWCViR04vvs9LHdYi?=
 =?us-ascii?Q?YGHBXvxj6uKV2SWbsgzdkfqFQWZLaYP11A8zK07YS6Ih0SFeKyyFPHQyQzkJ?=
 =?us-ascii?Q?VfUUR786eyWIU0XtinC87cyvWBPLvqNjAPi9y+g8VB6xl+2NceoU2jI5WOM1?=
 =?us-ascii?Q?SSSGCDqO8UMdA5JlqwI+TvUbMjGAviSJzsQjxY/P6UKHMVxfAWeSZmAvuGtJ?=
 =?us-ascii?Q?VBTRhxA/Vx/UH6tyT1vhqDcJmqs7FIyh9DiTJGqacA8+7VLT/tsl6qdCcoJ5?=
 =?us-ascii?Q?ZUeDJfnsWKq6AHsVSc4svQbQmEeHQ4LOHoCx4ijQVgJ4F+KPUoPKcRfSs4G9?=
 =?us-ascii?Q?I4qye4pykmwhC5V+H9i876ekkYzplJYYr+iD9U3TQbrCgwktiq8s/WYz9rcR?=
 =?us-ascii?Q?6SKUhzsptHVRJpVWL8qIYUkoXHuXk9k6oyEn/pwi9gzYnSNoliXKP9K/0Hgi?=
 =?us-ascii?Q?KEelJwUjYnthyfgDvqKZnTRJF9/oRZw+k3UlTfqV08kyOeNZd55mpaVc7YO7?=
 =?us-ascii?Q?IbbJdpN1Tvzd8Tkx1xkM/BWG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558479ee-e758-4401-8523-08d8f598888e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 05:31:14.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UfmHjqcsBEhwurDKa4PTxFrI/2zV5tGH8JDLMqDH1HQmIwdv/YPF80VvDvNh+KNcA06pVkQsMZHaeWs0d7whw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4406
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Any inputs on this ?

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada
> Sent: Tuesday, March 23, 2021 4:48 PM
> To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA tra=
ffic
> using CCI
>=20
> Ping.
>=20
> > -----Original Message-----
> > From: Bharat Kumar Gogada
> > Sent: Monday, March 15, 2021 11:43 AM
> > To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>; linux-
> > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: bhelgaas@google.com
> > Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA
> > traffic using CCI
> >
> > Ping.
> >
> > > -----Original Message-----
> > > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > Sent: Monday, February 22, 2021 2:18 PM
> > > To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Cc: bhelgaas@google.com; Bharat Kumar Gogada <bharatku@xilinx.com>
> > > Subject: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA
> > > traffic using CCI
> > >
> > > Add support for routing PCIe DMA traffic coherently when Cache
> > > Coherent Interconnect (CCI) is enabled in the system.
> > > The "dma-coherent" property is used to determine if CCI is enabled or
> not.
> > > Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> > > for the CCI specification.
> > >
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ---
> > >  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > index 07e36661bbc2..8689311c5ef6 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > @@ -26,6 +26,7 @@
> > >
> > >  /* Bridge core config registers */
> > >  #define BRCFG_PCIE_RX0			0x00000000
> > > +#define BRCFG_PCIE_RX1			0x00000004
> > >  #define BRCFG_INTERRUPT			0x00000010
> > >  #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
> > >
> > > @@ -128,6 +129,7 @@
> > >  #define NWL_ECAM_VALUE_DEFAULT		12
> > >
> > >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> > > +#define CFG_PCIE_CACHE			GENMASK(7, 0)
> > >
> > >  #define INT_PCI_MSI_NR			(2 * 32)
> > >
> > > @@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> > > *pcie)
> > >  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> > >  			  BRCFG_PCIE_RX_MSG_FILTER);
> > >
> > > +	/* This routes the PCIe DMA traffic to go through CCI path */
> > > +	if (of_dma_is_coherent(dev->of_node))
> > > +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> > > BRCFG_PCIE_RX1) |
> > > +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> > > +
> > >  	err =3D nwl_wait_for_link(pcie);
> > >  	if (err)
> > >  		return err;
> > > --
> > > 2.17.1


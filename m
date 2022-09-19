Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2171D5BD35C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiISRJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiISRJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:09:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10075.outbound.protection.outlook.com [40.107.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D9B33E23;
        Mon, 19 Sep 2022 10:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0PboRH8/60syC8YaBcTvfQ8Y1CQDedlHdZJOqvh7pVFTtIlzExXbLI11rEHvuwpzsf7ESLCwi/l7FHvO0/xaGJqtGUejvQSOLTtfTJ0EeE4i815IP+CuYymFVX0NVoH8UUHAZX/nSk1aQqsjJvQuhs4+21OJHuW71nSdyCMXcg8KtCS8Ye5VWeCTnrfvXnvpNpJlwZxGMTFC6K3e1C8R3MVkvslnSUmNqdT3yqk4CGvKvGrODQNyX2qc9cyMpkwkTMVwAsyUwQ5JmgvNXaK/E8EBscnLlNGghXKVSAgZQKwoOMGpR+Qf8/MLAEVhOkfAAvCVfgwkLqRW4IPyplWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6axv+Qg44AHoMtqzhKah5cG9+QPhsCU5hgkWxITKglk=;
 b=LmlpmKKTkHOdq6fG/UoRxOibpPd5pQXf6fzxi2ehwsWCd71sa4V1BNhATOESZxp2pfTwxYOHarDSjH34D5mpxkt3KHdHV8rjtmvWOoRk/gpFM3N78wFI6JMPiuYShSseoNAQ5tLdhQjzOPPEe2MIOg/oA9oRN4vcjLg/j+g435XXHeV6dmYprsAiPKCKO7hdPfn6EM/DKrdjC9BB0SZaGBl19LTPgUXMlbIhVvk6u4QCH1X+jYbn/LQK4ha2IE6ALtOuwy+SwZ/c7gt2h3osbVBrXA8yIslANsE4WEEBukKYscPry5h6xixQukOGQckwOdD5wVNfI6pAwMtcg2/ioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6axv+Qg44AHoMtqzhKah5cG9+QPhsCU5hgkWxITKglk=;
 b=KBz2Rp0+YQ5XYN5C7ufkT5qFrs6T3X1B4Jul83H6MCgkWFefIMj/yR8u+xa5WtQAtntiRlXL+2S8lbxEkrCg7VUEvwZAS9gX09jAvXVPzzdv5FhbygrqV1/DMflDgIVmKlCNPJwkkfMu8akBOaeMsnt23Yl944a4wR+3E73UoCk=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 17:07:26 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 17:07:26 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] Re: [PATCH v11 5/6] PCI: endpoint: cleanup pci-epf-vntb.c
Thread-Topic: [EXT] Re: [PATCH v11 5/6] PCI: endpoint: cleanup pci-epf-vntb.c
Thread-Index: AQHYzD5I49XpqyS34k2wlhkG3fCe1K3m+tOAgAAAdNA=
Date:   Mon, 19 Sep 2022 17:07:26 +0000
Message-ID: <AM9PR04MB87937614E6564FDBD98D3D93884D9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220919154038.187168-6-Frank.Li@nxp.com>
 <20220919170253.GA1011825@bhelgaas>
In-Reply-To: <20220919170253.GA1011825@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|DU0PR04MB9658:EE_
x-ms-office365-filtering-correlation-id: 2826352e-9a4e-4880-eb55-08da9a616d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhYcstgHlUMWe9jSv3CUMDSCtpPiMl/a4TdqZ6w1jRsPe6CxdCPInGORIQP/QnPPrYHf7RgPtdpxja+WaCebkmu+3cLW1lIq/SWAyWJuViBNzimPA5F/YoBX7WGJp7NrFa+Ppy8Hk+luPN4wf48vEMMQBjX6Zk1g2IRT9lN6EiSxvD7XpzeRbeJsMz35q4Jyq9WQEf6VU2iDLw98EM+ToRGw9MZOHXqxMuLVw5YSIjEySqB8oOTO/sthjmNQc5dBgJbQlsWQnZ8szUf1vklxk+nala5N58YgawLv3QKI2mrm9S2fwvM+LdEIHz/B5+L3kXLvm4QW6UwBFEuKxJ/rZSZ5WR87IQ7mnyAPqKqkPFKlCELPkOseEPUjE/qxAjY1SaFZqjSkF7AEieyDGFvWOS4GNd6bMb8CEsi6pZpOA8uJAp/9GuT5hbQGP2kwP123xjHwobXbMdzk6zGInbmrv6ANu/Yi43J2xCwUAnwrvwOE13Er9eqTtSs9LjH5lHr72IPJOD/XU0cAosxtwzqA91JDzOwzOVw6m2HIquhdg5BMrtPBe9Ysaq0kTqa/kx+eiFaVPOhRnmDDSjmTANaEnXqU5MKM6bzoPo9GqmiEpqusUBpHiV96IswCuyfsKNN3cY0egYTBzu/uPJpoPdgGXx9RZBSfgsdKWDtabmPECAFxRHDQHLbdorJ2CbX77PhJLZsVf/22KdNKcQAn68yirFm4MvFFrC0FXk0FbVTpana0ObkwPO4bbTxVaYp5PDAF0sWZ7umYzUy6aAWADN2xgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(41300700001)(5660300002)(44832011)(7416002)(8936002)(52536014)(122000001)(38070700005)(8676002)(53546011)(4326008)(2906002)(55236004)(66946007)(64756008)(66446008)(66476007)(76116006)(66556008)(38100700002)(6916009)(316002)(33656002)(83380400001)(54906003)(71200400001)(7696005)(9686003)(6506007)(26005)(86362001)(55016003)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uPCmv5neIIK+TneJTLRSM82z3xt2KeN4QSnDiIqqcKKgELaLIAAVqi1kg8OL?=
 =?us-ascii?Q?4F7xxjYjGBMsIwXoqooVIj1h4qv4dm8iZnIelyuQHe0jO7MCHT4CpJXhgebG?=
 =?us-ascii?Q?JMPPSw1rsEKsfnxQ4UCarBkZUXUGvy95ZAGugVLCUFYDdb5YqyiQ9Z3d1pOQ?=
 =?us-ascii?Q?hvR7hqh9pvzQUyvn5C5myVVZPBZVNpfjn95FGQwVQRSGLiEqVZa6OpqIVBTw?=
 =?us-ascii?Q?k7mr/m2PHnnju9t4c3xvAhu2uQQuh70w2X7OzElKAj93CO3gY5HDm3EFHxuK?=
 =?us-ascii?Q?x+tg4ZU8ao6CMi0aOhtTTbEK+BYrrjtl9KuKE9JrfxTP7g7VAxvK2AQlol48?=
 =?us-ascii?Q?zTm20dUlgpEUThl5EgAkcCwm10aQRPouuu8fwwBQIfrFIgHYpS2r6rr3IBxG?=
 =?us-ascii?Q?y9shlLhEzdFuKqBys3762tXeZ2GRDQCG8TYg/5OQ4/TqVj6Xuxk2XyR/DLgd?=
 =?us-ascii?Q?iRO01UC9tv32sKr/z5+C4kLL5/pcapNhLdUFr2z/Ch8CbHGOst+XadauuqNm?=
 =?us-ascii?Q?4qKBGStTUsdnagUrb2dUX+2QO8GCUd1JVl+8CGlQ2NjK3RSR+vbQrBA7fYBf?=
 =?us-ascii?Q?84x9Z8flRcLXXT/UWI3NvU7ByeANj/ZM5I/x9Rzn5Fb70v73evpwAWC4hUzG?=
 =?us-ascii?Q?69sjMRSSG12Q0zjpAHsJ6GAzRGkAe33PcSesG1TXYioba5Z9plwoH3TM8HvX?=
 =?us-ascii?Q?RajUY4ZRBVWySseMnVgPrOWU6F60/JIjZEoxxYsax68iWL4Mj3wSJ5xMjuTv?=
 =?us-ascii?Q?acDzwAVYaIGdNy40zj6ddIu5+XwGwWC1RfNFH2Jvdk3mvjEvarwRsb8DwJRs?=
 =?us-ascii?Q?m/kUyuBhb+5zou9bvewebDd2ytbzQeAs7w07GWRqZZlF7t4BPMu8AlR4scEy?=
 =?us-ascii?Q?/HkF+1bXFNBeGGnRqtc9ht8SdoMib4HIbzMFMfPDBKfcSDnvHA9RUkYV4uHJ?=
 =?us-ascii?Q?m3edSY+zBVAIOMnhgx7PQk22YUkpdZlxs6NaApSAPOS/k3OY1WZhKpe31uTG?=
 =?us-ascii?Q?Gc615ChKMkyr4FY9q74TuqksXE+GlKJ/zzlQDmDsHVcI0BYUWnkEiy04a85G?=
 =?us-ascii?Q?vhi5QNOVsCpuKhJ5lxOx5plF7lB7dp/NgxRes3Fwl5j71Ch0+6k8RFjOXUXM?=
 =?us-ascii?Q?nx04gN9bBGXa7tHertS/8pDlH5P0nbAOa2XDJ/fhOomq/eLqKRsmIQBK8HQb?=
 =?us-ascii?Q?U4MmhvDVgH3XgT1+qqZKpE9z+kAmrujvKQ4m64d8gxIMltoxH8u1HCa+6CG1?=
 =?us-ascii?Q?LbD9xRanqxHW+7J3WOlzcSrYsqOWzcR5W2lMFvx1KOuBdtmsdXMUwvevigSu?=
 =?us-ascii?Q?P+wa04cxVsio6FnFJumPgT97tNGtWHh5hJ/rdGDL+bCt4C4sF51xsZ7Yz10+?=
 =?us-ascii?Q?UWW7NUyI3s7++L3DVOXvQHW3+/VKifqb0jgX4g9hchfZuzGs/59/3uGR03U4?=
 =?us-ascii?Q?k1Ize9KKFiMWzvxPnDqW5bB512itCM2R9g6f9zWkdtjslB1NrVyeoIAPmAjt?=
 =?us-ascii?Q?lVTgGMQdI6oqb5C0mVtVOBcc81l1YZeE1KWD5JGx5hcOg2o7EwTrQ8Jr0AaA?=
 =?us-ascii?Q?Ulb1YDuPeQb/3mZqKqYQDI/qWdbpZ2rJ6A+G2P5G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2826352e-9a4e-4880-eb55-08da9a616d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 17:07:26.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAWWJPFJ5Lil8T+9eNsNQEij8ty/Xg+76qM5EnZvTTC/57rKYe1cKKH2hMySjPb7JjfQnjKMdj4TXn8ieX6PuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, September 19, 2022 12:03 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: maz@kernel.org; tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com; imx@lists.linux.dev;
> manivannan.sadhasivam@linaro.org
> Subject: [EXT] Re: [PATCH v11 5/6] PCI: endpoint: cleanup pci-epf-vntb.c
>=20
> Caution: EXT Email
>=20
> In subject (I mentioned this last time, too):
>=20
>   PCI: endpoint: pci-epf-vntb: Clean up
>=20
> On Mon, Sep 19, 2022 at 10:40:37AM -0500, Frank Li wrote:
> > Remove unused field: epf_db_phy.
> > Remove __iomem before epf_db.
> > Change epf_db to u32* from void *
> > Remove dupicate check if (readl(ntb->epf_db + i * 4)).
>=20
> s/dupicate/duplicate/
>=20
> > Using sizeof(u32) instead of number 4 at all place.
> >
> > Clean up sparse build warning
> >   Using  epf_db[i] instead of readl() because epf_db is located in loca=
l
> memory
> >   and allocated by dma_alloc_coherent()
>=20
> Is "Using epf_db[i] ..." an sparse warning?  The indentation suggests
> that it is, but it doesn't seem related.

[Frank Li] sparse warning about __IOMEM.  Dma_alloc_conherece()
Return void *.  Not void __IOMEM *. =20

Readl() use void __IOMEM *.=20

Epf_db[i] is more simple and have not memory order risk here.   =20

>=20
> > Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error
> handle path
> > to match pci_epf_alloc_space().
> >
> > Cleanup warning found by scripts/kernel-doc
> > Fix indentation of the struct epf_ntb_ctrl
> > Consildate term
>=20
> s/Consildate/Consolidate/
>=20
> >   host, host1 to HOST
> >   vhost, vHost, Vhost, VHOST2 to VHOST

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091B6F9EB2
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEHEen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 00:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 00:34:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814FAD0E;
        Sun,  7 May 2023 21:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBvW/5uLfEIT7Gw1DvqTDaiyrqh7R4h/JRFMsK15qjJaK+eUh1ZQY1iOCCCsSXfZZCgWeF/6qcWUwXFHHT4XA3EPBcy5Ybq+VA9sNrTz427NxTrWCFjbe7njD+oMw4QJn1EyMXKtFT0S+OHy8YLF+huRK42wHJH5IKfG3B8/tpm4eNyelsw+qJ1rBwUkCzcTh6QKFieI14LBzV0MIIDD3ZR5SOqgM5mx/IOT0H/3VJZDdF9SKLJBegVRFDCTiqElgMo9HIs3V3OwVjn+G6U5phb4schq/sPHcILerLenEpVrvl+3qRlTJDeYQTfuD9GgplDdjNuPLJXRqFMQwlwgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5B8Te8YGKY+NyrT5KJTGwx30BkMDm6ImX8fzUduhfo=;
 b=cCIeqYfEkLeh5QJV/HF9tdxsHnhIYxfpiqbJolq7u0PvjPODZP8q4CveFPrjqCh+a2LH4+uHu/i1VqzNhEsEZ7HTdt+QZ7yUtRMCFiEV+iwKHdCycws8vRglKPRqAJWIdWaIbGqGabAwzgDDbB8cOAS9PqwizgjBliImxWpaqmgvrSF/B1FOJspmKe5fPCaHEBsxgYMogkE7B504+ZE1+aKy0Wplevt6T/sAfh4WgxJXuK3/b2GcBQM0dHwYi9RetcazVCK+YFSSt+5qIisQW5z7Qcd/HpDy8Qo/qh+iCUMyttLZHp87kBjPTpNUa0nPQrau8zXzUVsPU39q/hPdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5B8Te8YGKY+NyrT5KJTGwx30BkMDm6ImX8fzUduhfo=;
 b=Ym18O/eVGbjz84OugTbDja04SIZtVpHul5sCd3FiKgvoK9SQWUIvyZRgSBLmkatIIQ7/bPY0Ch4TsRsyKBSBOwiDG6z0hQq+v1wk7QkzNGyf1hbb7zHLYOFlTT6Nsqn3KAlImvzvX+ids7MDN8TnZ+OB7kBYcSeT4EZwfIKkAs4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11791.jpnprd01.prod.outlook.com
 (2603:1096:400:40a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 04:34:37 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 04:34:37 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 03/21] PCI: Add INTx Mechanism Messages macros
Thread-Topic: [PATCH v14 03/21] PCI: Add INTx Mechanism Messages macros
Thread-Index: AQHZd/tpaA4M8P0GFk2s58kOTEXnV69FtnUAgAolxOA=
Date:   Mon, 8 May 2023 04:34:36 +0000
Message-ID: <TYBPR01MB53416C8C4DE5E8BC6A8C84C5D8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-4-yoshihiro.shimoda.uh@renesas.com>
 <20230501173442.reje55nattksdpuk@mobilestation>
In-Reply-To: <20230501173442.reje55nattksdpuk@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11791:EE_
x-ms-office365-filtering-correlation-id: b695aec5-bd44-41ce-6294-08db4f7d87ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFtkKqhPVwlVCzEEhmfwlyrMasEwOILZEuvkVklvF0Z+veW7LIgTyA27IgyhcHI0Bc6GSHiiM5eo72CPJ8OAHlullbclruDGmfLmIxLFVmfmzYXUXfpSseIFX/REGylH/LMInpG/ARHB8f56RU4ZucUkl7n8uY+1UOENSu6iaEZGjOYFTAZgWYER0hODjQU6iBPpjbc7WO9TXGtIF7ymoy7aU7UgFsxPmH13ydFsDKmTD2pUOzr0LUNI9lENrZ1y+2x3gObs3xY4tWgAvEV81YtneGvy6sYMMEJLLXHkTVUC37HHK1vMe7bLNJ6qZ+k3IQDywzCPpT4jpO8XjHG9YsMtnk62ktzxf9SwEkKZxSqf2hyRXVjp1VbAIMnSq/0FMZnHjFtyLsuq2X46zSIr6JzjXPGyaF260cv94Ru1Jz2OvVDVoEjG7qZ4l9ywid/WJmrNfuSqWY6wQbHO9Uee5pcovXCnfSqZvI4ueq4lsj254+KLMYley7Aa4JnsWjJ9PP73C2sgRVsDJS8jBCTpqLl7NvC/3wUe6nnhET5ZCm0xYhTABuBXWINjQoDPAuA9vzPH8MQutbc6fzjL5g+m6g5W351PYxyW/LqFMh/DZoaMcBmuhQa+e136MOAAaNjN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(76116006)(7416002)(64756008)(6916009)(5660300002)(66446008)(4326008)(478600001)(8936002)(8676002)(66476007)(54906003)(66946007)(2906002)(66556008)(71200400001)(316002)(41300700001)(52536014)(15650500001)(7696005)(9686003)(6506007)(186003)(55016003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lJGt1bkZHHS5JumBANy5OSXdt01X9FLGnJ85vulQCCPFpmBYoXzDL20ORg1c?=
 =?us-ascii?Q?YA+lHPAk+0abJd/YYNwc6kaBZk1Ehx5hgco85BWDc4Xog08glhDTxf1YuJ3f?=
 =?us-ascii?Q?QteQVy+o/slNikjMXZfABqT7bgWz+4BZKI8fqSPzqkQyfUAyc7x+G+J1DFxw?=
 =?us-ascii?Q?ldID50jHMPmOJyfi2ocAs0726hkBICTR0vNrn7d89nueJN6Whb2CfxnbDDhI?=
 =?us-ascii?Q?2AZUoLBcUFrwOficPxs+1T6Embo+ySjgfR4PpJIyM2mc4esZ43ss95AC6JkS?=
 =?us-ascii?Q?6/fUgmX9fni0ikbfiZvaiWj5Otz3yjjPgqATaO+FWqh4DAKBZX0Q8SWFfGut?=
 =?us-ascii?Q?15o4hy5/iQfTzQBL1cMkS3VWHl3zJ+a0VJ6dHpn3Es3eh2Gc1x2TPDFP4GZh?=
 =?us-ascii?Q?BMEsGDxlK4unpVuLz5r6oAl3uI+QmHoow2iQiTcUoXgm5IUySooSF2QZFfoe?=
 =?us-ascii?Q?t1qMkbn86cgZjvE5wgTJYti52KNQ79C9w0jr4XEcwsIKJ9/K0MeRBsFqB/1G?=
 =?us-ascii?Q?bj5PK3HfTZaUNRboJhqASp4Wpr6lNn2PQGorOBaKsLbEwY8QMzX8Px5zA0It?=
 =?us-ascii?Q?dCAGWDckH+9EwAD+9/SGLuIKFgZkHrhgkbfX5s4QtlUKlgtuiklp7d/vgcwM?=
 =?us-ascii?Q?K6lGYsfp6L8DgBqJkX5DKf8YULUv376K6qZvE/SqJdLtckhibv3UpRPqOlTF?=
 =?us-ascii?Q?SHuBMXZrYziZXC0DQmrO9uvON9SYV/vx4z+EBtDkgRNimubGDs48hfNukRCY?=
 =?us-ascii?Q?84+vXcR88fQ3obfgyvi/ypLoid9bLpaEhR2kOsMG6KHjLUx5mccK685Cn08Q?=
 =?us-ascii?Q?CE3nca0jLggejSdyoZ3L9lRpJzACW5RvkJO6Du23o8Whz0HFZKqBYLZL/dkC?=
 =?us-ascii?Q?Wv8DpJRcqsTBV2XW3Cb9ir1wrkXO8yxUx8K6q+OWwwEKEGO3d1VPoOihggym?=
 =?us-ascii?Q?RtoKWH/xI94ryvlYeu0f0FGUXtdpiVSi7sJfxwg+VkAXwfcZailhoCf5HdIQ?=
 =?us-ascii?Q?mYAN+Ng0wRhcA1suhG3AHB1M9PVg/SAuHAQdxiNr+TdEnLmE7qs5YZl8QSNn?=
 =?us-ascii?Q?5XvbLsUoGMBbhAyJokCatGe0kCblpaL1PF8CcSmyyjvBJNKJGv25MbKd5SAm?=
 =?us-ascii?Q?2QH4g4fMrLPkdh2Lork8slDsZtgEiygD3sIIKBbhRMJltTXONbtfBUpHKDOQ?=
 =?us-ascii?Q?6cC1cpIa9bKKL6lC+vxYt0QA7ei7DqskmoGUHKwpZnTvYzoDwWvr40tMx60z?=
 =?us-ascii?Q?r+TbV5Jl3IKFnOGseksdpk7ZGosSC9IwW3myVOvxKXCsF6Jc7jLq+6XlcSkp?=
 =?us-ascii?Q?yGMSZ1l2ssNwON0Mb8UX0dkaDrEb4PeGWvztGUtobPqHmff9lCaMfr5snjyr?=
 =?us-ascii?Q?dQd7ffVhCBsmLImBja8/JzjMra4GiOc6ESJZatwv8brmwD07RasP4zICylai?=
 =?us-ascii?Q?SqPkaMffU7No/SMGDkO0m1swGKT81P2iUI7RWStkQTHac245NNymnvz+PzJp?=
 =?us-ascii?Q?G6OVEIF3qzpasNoZ5Cfv3oY58223OLrckuuzFfs0BiAI4HnksJC0WavoU9Gy?=
 =?us-ascii?Q?j7aXX8MBmMIp8s2yOUpwIvOMPj7WbxsBBomo9YHILLJj++gUaGKo/e8UMizQ?=
 =?us-ascii?Q?ZNmj8KD+X8v6CcQD0yZMCSBf/QQkOWFoG2JLz7wXoh2bG5wb/rAkZx3sh2k8?=
 =?us-ascii?Q?OFzxGA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b695aec5-bd44-41ce-6294-08db4f7d87ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 04:34:37.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wujez+qpFi1bnGeB3rilPF1l4i1oSVtXVP5DwZZnHJhTdwficpsCCVcEtDIsN0uLpGBILMCtMJNlAdPCmyC0gxUbHI7VQWp7LQ+pzcgVEAn1cOQRLZ0Iw+846Jqw28fr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 2:35 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:39PM +0900, Yoshihiro Shimoda wrote:
> > Add "Message Routing" and "INTx Mechanism Messages" macros to send
> > a message by a PCIe driver.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
> >  drivers/pci/pci.h                             | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index f9182f8d552f..205bbcc6af27 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >
>=20
> > +#include "../../pci.h"
>=20
> Unrelated change since the new macros are left unused in the framework
> of this patch. Please move it to the patch which implies using the new
> defines and where the included header file content is required.

I got it. I'll move this to the patch 8/21 on v15.

> >  #include "pcie-designware.h"
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2475098f6518..4be376c121a4 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -11,6 +11,25 @@
> >
> >  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> >
> > +/* Message Routing */
> > +#define PCI_MSG_ROUTING_RC	0
> > +#define PCI_MSG_ROUTING_ADDR	1
> > +#define PCI_MSG_ROUTING_ID	2
> > +#define PCI_MSG_ROUTING_BC	3
> > +#define PCI_MSG_ROUTING_LOCAL	4
> > +#define PCI_MSG_ROUTING_GATHER	5
> > +
> > +/* INTx Mechanism Messages */
> > +#define PCI_CODE_ASSERT_INTA	0x20
> > +#define PCI_CODE_ASSERT_INTB	0x21
> > +#define PCI_CODE_ASSERT_INTC	0x22
> > +#define PCI_CODE_ASSERT_INTD	0x23
> > +#define PCI_CODE_DEASSERT_INTA	0x24
> > +#define PCI_CODE_DEASSERT_INTB	0x25
> > +#define PCI_CODE_DEASSERT_INTC	0x26
> > +#define PCI_CODE_DEASSERT_INTD	0x27
> > +
>=20
> > +
>=20
> Excessive new line. Please drop it.

Oops. I'll drop it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> >
> > --
> > 2.25.1
> >

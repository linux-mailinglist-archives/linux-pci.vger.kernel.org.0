Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAE68A4DB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjBCVsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 16:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjBCVsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 16:48:09 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978210249;
        Fri,  3 Feb 2023 13:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU4Au2+zDQJMdwnGmS088vBqYW9e+63V//ToZL//1E5TP6xZLCaUkfmZTSXHuwFgTgURhPVcRLl3X9mSNix9UbSvSB5rDfWMMHRAoRssffYryT+e/Kxi7NS1xaaQtOsW4sWR++CGjTNL6Kj2WX35g0Qx+jeBrFHb2qTbC8Zw+q0QCLFtq3scWkdNRQo9z0Eq7w90aijZ/u3OIpUtBcSG57OyAipiSDAsPms01/BNMLcWjHhUP7DkNDLs6NFkgWDPE1fp5N84d0gKRdG1aSHMx+S/UGsm8yJp+mz+QMCs7fhwWFiS1+6C9arHD9b73eRrydxmWOoCOScddGTIfDu0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQaXg2wa/3is3BNDpPc0QUi4ANwoircwHIPgVfIYGRI=;
 b=ORaXFHzcLRDGWQ+YcAc4EDKmG2wiHIEub2kiXVpROOUi7uSXCNK3x8n49/4giyv7URECRAUexCuJyPCxw25KZFJGQmQWwahNb0jjCvIxqwh59zRLca9UUVgw9Kcn1sbl3kVUdHeIQxGRlmzsqpCnL/9YVNbxlDmGDEkviVjxauTEkbJcAuAiSJOp7E9kvPAOZv4x7FJ9lzVEhJh79uvFX/pVc+/rifkZ3Yr7sDhD0A+qqdr3W67yhsnXrYVgy4rx6qu20ymyprQcovlFz2Zt3SPYozc+EoGuU7Yz8r+2XBur3ooJYLAK020L4pFUlUQ68QBpQAuCpsQgLqeve0tcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQaXg2wa/3is3BNDpPc0QUi4ANwoircwHIPgVfIYGRI=;
 b=ibxcQM92yxA9bYAWcSQ0YOWxIV/gmH+UWOHXK3lqitOkIJeETFObCkLtyUzQqG+2bpC1crM2/5KpihfuPvWxQcX9/qkeAh2ywh89gYu+hC1KFi9FaIJWcTdoghENkv9jPqOv5vhpKsurGlELmnWNpUKerL2bkjnntm+07Fcdos4=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Fri, 3 Feb
 2023 21:48:01 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 21:48:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Topic: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Index: AQHZN7bpBm+5RmnRNEW5Iyx9WPW3za69wcMQ
Date:   Fri, 3 Feb 2023 21:48:00 +0000
Message-ID: <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8145:EE_
x-ms-office365-filtering-correlation-id: ec60e0a7-88ab-4c32-3137-08db06305230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zn0xBHRBK6/NMZ+r6ixpuRDpfl255gU/CZAB+UOoodoYKIQrQkEc/e9ltQWAJpW8jFRbwZS5mnuJEHh1xDoRMxHwWWofA/OGdRPnhR/8eI691WphnCDav+fOB6joueGwI+ICYufJhic5b0fGmE1hU9ODfiDKZNkucW4hhMU+Qt3nBuIq47bl/6V7dOn3Zau0R+LFa2jhRcocgPkpuTIsrjsw477sScR8wmkkdq52WNOfN7zc++QIG8lTdJCqFFfS3RJd63YpIi7ev8ycnWaLsgYYKRMJ9eQEuK3T+bZ8STvkX/FmpxQCZvKJAZA2ltQYmd0/Y53ZukBba45pTCsDfYwWUvZj21P+HCWFp1CtzAEQyXYl1VWHBeizybPZ5BNCn9vpEpv02e8OFEZ+4s8VUWaw9Hclk1EQ/XMEepjTzHkOIluWSRqn6eYJLN9IFUMcCpemhAFOugz9fgV+aZy1p5iL4mjVeF+k9XW+gU4Hw1bTuYNv35hxYxX8LcfWrfP8qVRu0li3do1B9Zi1agls5or4qebUUTjjj68w7gvQoEazg54g/nxklErdy+4KTbgqMCSuLGzUZJY4TRj7fviJx8vJPwV1ClVYPx9x6xcuNQPEeqZopN7iS0osoyBRnm1VGM8EXJ36r8G4lE+jchUc/o7ZOp3XZ1VODlEkREjdjRi6UXQExyU4fcjVm3UmZukbtiQU/kyvhJ6a67wRNWcBXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(41300700001)(316002)(66946007)(66556008)(54906003)(110136005)(8936002)(2906002)(5660300002)(38070700005)(52536014)(4744005)(7416002)(44832011)(55016003)(86362001)(33656002)(38100700002)(66476007)(64756008)(76116006)(122000001)(66446008)(83380400001)(8676002)(4326008)(478600001)(55236004)(71200400001)(7696005)(6506007)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?oBcscRNVoDUKtupF+cBDzmXqYSYvLHrEgDvQ9+6Mk+cs/uBV+GN6OtIH/q?=
 =?iso-8859-2?Q?95KOCMlGxZ0hmRjMkSOabKgHLGv9Chl2bZHgkaX0JAbLmAEjnwQZbZ5aI2?=
 =?iso-8859-2?Q?NgOMttTqeS4XBLtPIdZlPELvCNBXwj3901bZ8+uiEzrlcz9Hflui+P40wZ?=
 =?iso-8859-2?Q?cWg2CyDPMAd4KKkjRPHkYj/3KdDNskjL2u7Qq8PFxypMcWn0Od+SJUHd7Q?=
 =?iso-8859-2?Q?9IAhv7g6Sxs4o/BGOd/Zn9VlwszvkFQ3Soro2hTyPHPY7FOHlM1a3eAGIe?=
 =?iso-8859-2?Q?jm0jMkLE6YPcxg4LShoED+N+m0536YrTKgvQEXf1og3oT6yKaCrX/ec60b?=
 =?iso-8859-2?Q?cEG620t6OZLSD87SwBt4/+H8XL0asMWgNIqo4+iSRzU6lL6y9+m1hYJspG?=
 =?iso-8859-2?Q?uQ8utuY0lwdUbqJaPLYb5bbL4caOrToH77MQzjQ/XmaIo/8LtYfuFdTqEt?=
 =?iso-8859-2?Q?A+Pi7n2DDdWMg49eKm7t7IsJeq1ITGI+1rBcZiik0o0su1y0isDJX7hzM9?=
 =?iso-8859-2?Q?VelP0khdMApwmChUo5VCvunK1GCB3O6NmHF+RO4idmeAVC/vqY2Cp22n26?=
 =?iso-8859-2?Q?aN9QcSDBRe1T6vkZnvjtDqwEKPk8cN9HRrs3cTyCv5sPfUZHrH2PuWj0v5?=
 =?iso-8859-2?Q?QNQ1clldODbMoYTLMwVLjtYbTtiNXhFw/9Gx3+hbUWwfkr08ySoypXB3J7?=
 =?iso-8859-2?Q?3YxDl1iek/aL0iWUl+4ioKcSORntgTik5u54MRc5BnZBDxPoJBH+39DdO1?=
 =?iso-8859-2?Q?Qi6uLwCk6ZbQB0gZDd0uTcddFg6IAh3iYCChBS3/p0D9OQeOlTxvfeIm+2?=
 =?iso-8859-2?Q?2JQ+w1/taGjzYHjQsQibZCh8m5+x3wrI89lZ/SaO6dOC9L+XP/JdD1ekDD?=
 =?iso-8859-2?Q?3ZuIGWBu9lQIx9luxHfqFpz+douN6tEtAvFzUx9pIilYC5JOmdnLnBEMMr?=
 =?iso-8859-2?Q?JvFlmy2y6Prn70E8MinDxHuXMrBeUACWex//bk0tIdI6sedG/lkOKFq5Fs?=
 =?iso-8859-2?Q?ox1iRTc2Dn/CtWWE3cIh7lkjlPM1gFGgw2/SjCPawthWGEIRUXmcPL1sI+?=
 =?iso-8859-2?Q?7kpt5PhyVC2lZIweXe8gTaEWriAivZWQdNIQU8xxHdNvK+XikttVhevgKJ?=
 =?iso-8859-2?Q?ItwjXV+MkmNIovwV7gRPoxa5BARhRJZcFQ9ePUO323nCBEdMeh9IX8Gx0n?=
 =?iso-8859-2?Q?6B4RYNfoUOkP5Jgc8PFPC8RwqC1QWABKqgmkDDbnhxLFDZut4y7/jrT0f6?=
 =?iso-8859-2?Q?ESZ4WtXGP/qCWlogtJd4DKR9i4dg6QZAjcs5yx0VyLCVOK4pD7PfILNkQs?=
 =?iso-8859-2?Q?Jq0jmt6DD7Rbz/9SrPLAFdkFxKVXiGrOG0sn8FRddL/9i308KCqeV0zUq2?=
 =?iso-8859-2?Q?4OFMhcLvzYRASYVR7u5srxDLOfnfJhM82Bjz92a9uuFQHutB3Hy1gLqgNk?=
 =?iso-8859-2?Q?h/LpDcHDF6nyX45vsj8liLo1MQhGNx4deD5IwGf3HgyUji+ubH3XCTaKbd?=
 =?iso-8859-2?Q?rxTEEw+6ztFjPXo2FvOUoYz7XgHX7TyO+o8v2BZrO6hTtDqE7WOfyj5uno?=
 =?iso-8859-2?Q?eODUXNy4VDYSZ6YNAUYWJGT6fqRtJFgI37J+nMh14CCJm0wK26HmlHGB6e?=
 =?iso-8859-2?Q?0IfxybxS0eGIY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec60e0a7-88ab-4c32-3137-08db06305230
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 21:48:00.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pnAL2IUt0HrF+1S9Wsm3TA0S6AmyVJK8OYZBTRPMNeuwu1lRVxhQMSFdVr9GCGk/UiWb/7+OwJtHoEC7XOGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> foundation.org
> Subject: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
> function
>=20

The dependent EDMA patch can't be applied at last linux-next.
Can you provide a git link? So I can try directly.

Frank =20

>=20
> About this patchset has 4 patches. The first of two patch is little chang=
es
> to virtio. The third patch add APIs to easily access virtio data structur=
e
> on PCIe Host side memory. The last one introduce a virtio-net EP device
> function. Details are in commit respectively.
>=20


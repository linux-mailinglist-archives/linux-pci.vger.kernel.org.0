Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D469DD9F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjBUKPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 05:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBUKO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 05:14:59 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE41C5AE
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 02:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLBxUsTSa6dWQWmOpY2lk5NFvLZvRqXeb6mmalxY7I6AxiImILpIgbbRzJjZhcec1QYSPSpLEkQw/yupAqU2N2pkmdsa8fZA/myS+xs4Y7ldIwVnIMbz69yY5zgLyE9gjab7vWsmOqdOTGV2OhgrnA29Kwwewnz9+yDfaAW82ux++HkZMDb/XthGknTvsKA6kZoDENToR5wHoDFu4olYOnFjRPnFNu5H4l3PQoCW2tCrnZL1dVyaa2sSCLCkFdWcrWLWm6K2NVEQVq7AICHRe57TZ4cuTn0V8g/GPqSx/j51tq45h7UhZ9kRxfKpggYJu8Vi7cpnMLYXywzGvNQWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ1hu+o40fgjcDZxHbCZJB/knXWTr9xH+d180aOtUTA=;
 b=MPVngpA3AEGsBX43OpkaBkw0kPMsLLJl9o8jX5iqvPfWXQ9w2K6EGckQ72yNaUeFDzKvf+GcFy6f/uMAkP0D2aJkYus4vs6fiac9TAxeN/QWhpkCdeDYUoTk7v+BLo4Hn9+mCXryOxtEC52lkq220MHmF/KETwBYyBEI9Xc//JowXF9rPgpznBXlMNzmC8U9VjV14/HaP1WK25QhEarGSNVnCU5DOxZxq6EB3ly8Tw/7vsp4WqKyEENYs4iQKYGFPMblx/4v19W2pqNQAVVY++dProUcj0rT4ni292oef1U/q1W+pxJfCE2CfLq0n1iruGeI5jVDEYxwtt6whj9Fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ1hu+o40fgjcDZxHbCZJB/knXWTr9xH+d180aOtUTA=;
 b=iJc9PcGq54ZwsVrMEjl2sndksKUnnU/y5horVF3U++ebI88sV4gBDkRObSVOscZUBGxO1Epppn3mwDPoebNy+b9rE55u/SU4Ygg7wAPmEDkG+DCwYeykVXBMDObS1b3OaRFCiBk9oGFT3FqTJZy7x/CSEunlns8c9pkTu0GIE98=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8474.jpnprd01.prod.outlook.com
 (2603:1096:604:195::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 10:14:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 10:14:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: endpoint: functions/pci-epf-test: Fix dma_chan
 direction
Thread-Topic: [PATCH] PCI: endpoint: functions/pci-epf-test: Fix dma_chan
 direction
Thread-Index: AQHZRdytzxPTIa68KUOjfG7d64Qc867ZLpaQ
Date:   Tue, 21 Feb 2023 10:14:55 +0000
Message-ID: <TYBPR01MB534166213C9B013B4456AE9AD8A59@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8474:EE_
x-ms-office365-filtering-correlation-id: b021fca5-03d3-45f9-2a17-08db13f47af4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H54hKLR2CAOKySH0Mg666SsHnzT1IDzx+evAOOp4GzLdYmRjIrCK73uZUJQMeXdDCNVDhxPXN47NFRQ1QwSGxd5xJbTYQljtfHY7WWNDjhxBazVAoXxcVqAaJP3dLGYSbLE3dHcOwAip6hLhxIBJ/ZW5Mm2VK6YD1Q/TcxWrvtnafHrN6JhBwEqnJ5GkDzWL48qCL0aYOaJ/sHZ8V3kiQpedzMkCcjljprCsEqbBiq89K8WFou7s6DGlBTg0yYF/IanDgs3aefqwZkor5RCO3CY7+rHNuVLw3zX31RQtUR6Wkhe5FjvU5jpex5Nf7mZKI9Q5JTi6hgf6M/4IxnEW8W9/UC74yPd3zEKSyyVVpOYd6QRMouicvq3MTmhpZIjJN8g0TfVVMoDEylnavjlX1mjcQrBmdFHFX7syiPxuCy2ui85osC8XEhyihPceo5megEwQXKlLr4ZvGYm1TE0DUf7/ZTZpd4YWA02xXZRtkM9jPT9JEdpp5j5qiZg/fMyu3Hdg9sDe8WgQhSZU2N7RoiDZu4rVBFFj8FjOgdq15GE95q8AHv9Tr0q0LPmZTa0bPGYib72zSJKClUEmkbDT7sk+shVE5SwiOHdd94USdTZFGYpJATVeEEjS0yZynfwMmSaEcuqpprPRd/aS1mE+xIgq5Se0t09D4jSLoshvCIdHumbGfSUqKfp+Jzc+nI+9k9kWWeL+yd4N21p+Nw07mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(38100700002)(83380400001)(122000001)(33656002)(86362001)(38070700005)(2906002)(8936002)(52536014)(4744005)(41300700001)(5660300002)(55016003)(26005)(9686003)(186003)(6506007)(4326008)(316002)(76116006)(66556008)(7696005)(71200400001)(110136005)(64756008)(66946007)(66476007)(8676002)(478600001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XLK6Xvnb9BGQwt1/3AzZ7gYRs4IvZfA2xD3GFasCrgPU+bwL2yjcIh1RVUbB?=
 =?us-ascii?Q?RJY/piGlvDzeI0ha8M7ywrViQiLDY2ZQeQmlbUFiw3CqudBo3Xi/cD5jIC/O?=
 =?us-ascii?Q?de0UGNi2atd+T0Xc29Ho3l0Z9r2e98Kb6fGt5uSArmUYch1Ujjzj28c9SPlY?=
 =?us-ascii?Q?dBdCvJ2VsMZ0Bxj7r9NwSjT8A0uemoIlged0fG2rze3SE1VJq+z6PqsGfZeu?=
 =?us-ascii?Q?Qu9GfmzO9F3KkEH8qBV92jCmS3aLzYAc/9lbuYtQ/DQlQ2oMAlBTWeP3nIsW?=
 =?us-ascii?Q?m3X9udfMyhaj22kRd3PuHBszDoNRd7erPvBJKZy9KJAR4Gb0zTT/41yXtg7c?=
 =?us-ascii?Q?xwYdBPrgpy6xvdlTDSRC0w3+9gS0YnoP0NNfOGJcge+kbV25R73650VII2rk?=
 =?us-ascii?Q?S1jeOLkJZyvZs3V2Tw67jAMrJT18ggxcbD2YI31zkm6YPnoJ75r4p+ItbYKc?=
 =?us-ascii?Q?PZIkaVyzVd/cjPUfhbFK3crq61q68ZYGdo4V1z9Om4JDhkL7C1SVWMiD7NYB?=
 =?us-ascii?Q?ALG1Q05c0I6rL5/z9cfizV0hgJXgdfRUKFURYGGablCLOSQBu6YK2BJyucNa?=
 =?us-ascii?Q?KWfekXcQwhkINrYzxoGJNmyB2k1soMb6yyT4omDToG/IH7ktrzKP2vsnvLHM?=
 =?us-ascii?Q?/uYkJa1kx3atOAYnjtIX0f3b6NpbmY/uNJiJSKiGNSDNgO2God1ui5+8dn9j?=
 =?us-ascii?Q?50mn5HKWFT8ZhOkWjj87Wc/kiByvjlYBkYhEMwyThLBhoWv7b6jIVk+yw2hr?=
 =?us-ascii?Q?QySlwpi+6fLDQ+oj8RyX3FpApE823JzKd6bcJ82Aq9BRzCafFRwEo3KOUxWl?=
 =?us-ascii?Q?5vnCMqA2JBHxHStCMA0VjSkoToInC+Nhnu/u4G4fscRkLUEfhUiq55KJCqUg?=
 =?us-ascii?Q?n7L8lp37yERQwF2nOgRNHREP7ICop1K895HsiOHwELyQP7yImGfF+UIF6qOL?=
 =?us-ascii?Q?TYg0x/Vn6VMVvrGCtazk8uCQxvZ1jAmEcCVEE4tB8RJ+jslktWKfolIf386B?=
 =?us-ascii?Q?8OYxQrLQG19DStFk+X0FSy64XWtYKDrOkGtmR1lZfpAY8+v5dm8m7vxsKRp2?=
 =?us-ascii?Q?Mz+QaDa9uqaolqnHDRESZ8Rk49V/Roprx30bZbD7/nDQgp+3mqd/iHhTgYee?=
 =?us-ascii?Q?ZHImskv3xJ2S7dnV52+pt1bdf0SI5VcKisSUeQJ7nlnEgz3U4vuE8LhrTaUm?=
 =?us-ascii?Q?+Xc5AzIbmApcfU2xhYs8bR34lMYUxGO55QhgzsHJrEaat2Qrt3oI5+iNRQcR?=
 =?us-ascii?Q?vhEpAlSKy/9GecNM6ToLKkRNqyo6yoZDy23f7CBWGCvry80QyPlbUdMomT9R?=
 =?us-ascii?Q?eTbi+fM40ZecD1l359lHH9oM88MTBQ9Qy0C48Y2xcy0w7AbEk8iw3v9H64NV?=
 =?us-ascii?Q?65fJ18cKsIcAi+p84PGcF87vy2cM+qo6deNmXHKRMzuSvrFu5uGnBBOl6beF?=
 =?us-ascii?Q?NNSQGVrfhdKdC3ix9Mp9yrIH6XQ1I0RBtGe3AiJdMtSoXNIUjZyNVh47VmyZ?=
 =?us-ascii?Q?oRfOs0iiYZ78HDCmCEk781nftNx1dSsZfvIcej9jegQRP1if23B6rrQQyumi?=
 =?us-ascii?Q?7O0miHRGobXdItVcIKx9NiNkxDumBa9mjJApLxZRaoKxm0hiQ1VD3lFv+IWY?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b021fca5-03d3-45f9-2a17-08db13f47af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 10:14:55.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xo5OeTw8mDHUlYpTXk/0vIHqAEtAG8jrBLcXboZVX2VBS+ZKtd2JW8btXrks0FIRxxkSHCbzYYJTp9NRIV+RS8KAAwuemBdGXmJbOSgeRB/qzfopxWmtR0KJG1p3GNDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

> From: Yoshihiro Shimoda, Sent: Tuesday, February 21, 2023 7:10 PM
>=20
> In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> results of pcitest with enabled DMA will be NG on eDMA
> environment.
>=20
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with =
DMA capabilities")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I'm sorry. But, I will resend this patch with right email address.

Best regards,
Yoshihiro Shimoda


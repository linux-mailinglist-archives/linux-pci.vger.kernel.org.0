Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AE4B0602
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiBJGBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 01:01:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiBJGBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 01:01:12 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 22:01:14 PST
Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3A1C5;
        Wed,  9 Feb 2022 22:01:13 -0800 (PST)
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A5e4ul010998;
        Wed, 9 Feb 2022 21:54:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=O0BDLxl4a4fTgteDMripEbKNC5QNUif0JF9X4C2GIZY=;
 b=shMY5vjL+DXHormP0HjiKa7Z2aizC9Pw4Ac6mUZ90Sy76ZuHVXRwg1Y34OPY6vqFEZBP
 M0xqx1DF+ZuyYFmzD5ZMNYJKkPBzFXUeps587KXWbV0/lXWBGlrZBKBXJzI83OJDi+Sf
 BeN7c8PoGIo1j3/2VbVE7YgnPg3xf75eObKOzWsazQAs5/XbJx08L0IzKbe6mPjLwGlL
 uZbERs1YhNr0/lVQStEqqDrATRZimQd9gylz7noX6FwuNB/tGr2T6Cy67Wi5aOKBiIfe
 eDsAaFiIn8J0BRs0ZCZ68eWuAFTv1ohX1i5PEeHY9WDcf8GXwD7wugNtidGOCmjGgX7I Mg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3e3c5310cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 21:54:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABTv69Hq8KAmn/+IqufG6gbqFpPj0kf0wE0LFqNiMjjeAzMaQtTuSubEDdxTC+lIEi68dx6X9LhQmJeZnx5AnT+GL4NJydXpTdcD+BuTBremPQodHook1/q4hcCqnlMe9O51ce9mxbucGP6h2tOp9WtqE71t+7sVZ73sFp0PeXPHOIVpY2rraHzbwhn7zwnTl1V0Xr+dEiKnRUaK6/nUupfbIsbZV46OJoAIuKs/AQ7dbrhzm/GodVIty5Iv9h+aCnPSm7btdLKIFDbpsgFyaXn7QOdkHUKd+TWTdcHWmCnxLuEcM2/9L3meWIn/tbFswfiXX0oUgCno6uFBz1oQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Su3UJXH5jrpktXmuWvSdTBUGwp3J85Prk+/BXrPrsQ=;
 b=XxRRKSymulHi7GMYewXl+Nyx+30/dmXBphqufZQGkYSitu5rNsCpN/3KWzBBfxF7c8jlMuIyTvxZRAx5qAFWDM4rTGVYzcXdptm6wWq4oFbFYVfZFqclPVpVge5RPwLcc2HwUTs/iRVdsUcbDbcfYQzQoqLdTm4MXquersde6uU2cvF8PQ6cbuMZLjh8aQTnXkatXNCsSlwwScuvPuymChEGXskGgMEN3DUseXZUDwlh5Xhfs4oD6+7pcJKrZvItWoflyfwMZkVuHu0YwRlM7JlcVz+QP6Q6ps0E5LQ4ymDE70S2i/UXEXOLnNnOehcBehtWYBL9LGuCet5sFsMnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Su3UJXH5jrpktXmuWvSdTBUGwp3J85Prk+/BXrPrsQ=;
 b=nsu6MLdivBTwMeyk5nBniH6IV4+m5GWdbDlSXr9kFVA5z4iJ81GD7TSTn0IwMUlYlF4W/RMXxGOAkEF1z5wU0byt0Sgq2apgd6iOCUytBAHG3obSG548r8gWIhPCaF+EfoYUy6rkcKattdr2JBr9FbGc7q/zSx/adN4kDXTQH+eo4PYv32M+d3AOrlpgZchllxlVOeBRIcDVeW09AV8EbCZ4283Zs3JsWX2TO2WS6YIWDv//kUZADKzxWH/LojCg6ivR4Gt1PAXxCX8Yo+ccCFdMqNMyo3VdldvSwpLUb2ESNkXdbrODJJfinDoBF7bT0eOV8hiSnTzGlIYM9TlgHw==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by BLAPR19MB4210.namprd19.prod.outlook.com (2603:10b6:208:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 05:54:27 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 05:54:27 +0000
From:   Li Chen <lchen@ambarella.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling
 and driver update for R-Car PCIe EP to support DMAC
Thread-Topic: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
Thread-Index: AQHYEu4MYMvm5IZXhEWkJNuh/Cvz1ayKuTKwgABFs4CAAV9FkA==
Date:   Thu, 10 Feb 2022 05:54:26 +0000
Message-ID: <PH7PR19MB5562CE44BBDF09B2ECD30BEDA02F9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <PH7PR19MB5562AC3C5E7BBB7730086CC1A02E9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <CA+V-a8tEwOR-r=+KDe2DhpTMwhXPTgbZYgOWepST3mnhBL_Hag@mail.gmail.com>
In-Reply-To: <CA+V-a8tEwOR-r=+KDe2DhpTMwhXPTgbZYgOWepST3mnhBL_Hag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec504fe2-bacc-469b-6635-08d9ec59cc27
x-ms-traffictypediagnostic: BLAPR19MB4210:EE_
x-microsoft-antispam-prvs: <BLAPR19MB4210667C59867624B61A01C8A02F9@BLAPR19MB4210.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQBm47sIbisE7Z/Y6kujQLlgr0611vAgHokuQxvX2+k6nf8FwJTnDAXiv94JcJCJ6PAtuWaEkhyV0hUt5spPBSHzwVDWDKo846t5hyjuie3v3eXc1aXzumi1L8+RDLhpdE0mbHpe3FK+msU/naKFGwDrJ3EAeuz061c5RLdfMMoDB4yYSlTxW1RSVTWwYEX9vefercq9tXoz1b1Z8RdYr05PuTys1BeEX2DLsXZj63ENx8wzREae10TZBVpblJit9Q+ErJiuaNuuRDx33fdBQ6YzeNTiUL2UK7DSnXB6pSfHIDIYZweBWGLMJW+sVK5GUNZwPm9fqJq1FNP84sTSvfpkTHC1yAEsBVlvhmcgOl9DqZddb4V23JCcnDG3GATmirB3CmbL8l89FLi8eREM8FTCKF+ztfzl8bonoOPKJ45Sg9eTZYPYAgTTeXLPN+6OPpbBWLdMUUSrmzQR+2JP93+XtgS+q29ylko0ZuO9V6cOW/sfy5cG/QYPR9hShqgYodsri8fmGnkMQh8D3OKtf3kijOYPTVTRF9ynm2HrZH/tZp6I3hXyuF1KgMsPanew4MQA9UUj5m9T7w/s0LvyJeAmw1j81RsMt6SaOVWiYJcdD9gPHCgTi73G0WvRNuA4/n/wJ0u5VagrNKrKXwTsyCOQtnxurL4Tn61CznR5P6crOtI8tbXlg8ZoWudA5vV8WSr/aA2ZsIxyH7lwDOtNv8vwJ2RfCXdB/wVogMivPTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(966005)(9686003)(88996005)(33656002)(53546011)(122000001)(55016003)(52536014)(7696005)(6506007)(6916009)(54906003)(508600001)(316002)(86362001)(38100700002)(2906002)(66574015)(26005)(8936002)(83380400001)(4326008)(8676002)(186003)(66446008)(66476007)(64756008)(15650500001)(66556008)(66946007)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmpRZmFWYlNRZXVwTlhXNmVGVFpsYlYwMzlCUHdNWEorVWh1SnJ2SUJMdlNI?=
 =?utf-8?B?RGlsTEU3b0ZPRnBrUWl1bXlWeC9mNEkvSjgrTDBNbEpmUDUyU2FzbGU3bVZv?=
 =?utf-8?B?ejBMM3BrUEhhU0dFTUZNaDhTVTF3dkxzRnlPKzE3eC9XZ1hTVlo4R1Boc2cx?=
 =?utf-8?B?NlVNVmQySnVKcWp3ZEhxallyaFZSamMrKy9kOUl1OU4xZndNQUNwNkVGSXlW?=
 =?utf-8?B?MUFMbzl4blpqbXlIbnBZMXhvb2R4THQ3eHg2Zm1yYzV2WFBtay8vOE8rQld1?=
 =?utf-8?B?c1dYWjhJR052aXROaUNnSVIxLzdIWTJYWHZrdU1VL1dtQmdOSlZzQzVZalVM?=
 =?utf-8?B?VmRzbG1wbW5WNlB3d25nbTFYVGg3Mk9kaDVjNUUwR2RaMWdxSkNjWUxUYWpj?=
 =?utf-8?B?WUJ6Q2t0R1NSUFlZUmlQN0Y3UG9XV2NCbE42UHQrcS8rVmVhcWQvSGxzSUxG?=
 =?utf-8?B?OENWV000VjB3cDlQWVFDc3o1NS96T3dKVFBTNUxFWnF1VUMzUEk3amk5cDlw?=
 =?utf-8?B?WWlVOGNBdDZzem9xcDkzLytUbG9pRndZNUQwSVVqTkJvc0ZUaEk0R1pBMXJB?=
 =?utf-8?B?OXM0Y3p5bW5sczNsZUFTZFdhekV3d3BRWFhhMGVwdHdHcFVldUdSN09EME5U?=
 =?utf-8?B?SGZYcmp2RXh3MXlBK3p6SUNjc0c3OXRjNndud1ArTjFnWjlnaDczVDVvMExJ?=
 =?utf-8?B?SldoTW5hN1RVMlV6UVR1RXZFTVhmREo2cjllY0xRUXVZT20yTk51WGpGTlkz?=
 =?utf-8?B?VllLWVErZVlmcXVIbndlVHJnNTNJdnZlOG9tYUMzeHdPMFJPWVdmcStjL2xa?=
 =?utf-8?B?T0JiWjFmL3RSVDVSdFRGREdYMWJ2dWU0cXlJdWwySGowS0JmK0plWlhuT1Uv?=
 =?utf-8?B?MWR5Tk5RT09pQTB5QTRBS1FZNmFlQ3BPL2N0L21yVFFEVVVyQmt6U0lMOVpj?=
 =?utf-8?B?RnBDbUhsSGVUdjdJLzFFbmQrcjM4b1hIcXl0eFI4djNzM2JVRWtvcm1PN1VH?=
 =?utf-8?B?Q1JlalkvZldxNFRSQnEramxnTzl2U1ZqQkd2YzhWUmFVWVcxUVdnR1J3Wk90?=
 =?utf-8?B?VXVoNDEydm4xeVAxTUorSnhxWTc3WGt2ZzVDb0hQVUQzSEdXQ1RZM21UTzRZ?=
 =?utf-8?B?K29TQ2dZdFcxRlprWjNFWmEvaWEzeUlYdnQvWTdra29DYnd0V2pRMnU4QitT?=
 =?utf-8?B?U1orZjBBMStTVi9INTdrRU1sSEcySng5L1VQTVlZMW51VWtkMk82S0F5ZkQ4?=
 =?utf-8?B?TkJWWnF6NXg3SWtxZDdkRlRuK1BlVUtab2laL0VmR3l5Q3p1bkNuNGpNcUZF?=
 =?utf-8?B?eVQrSkxEQnh6QVNNZXZQWHRjWUx1SHUwVmR2NlNYcm1hTHo2QmNiK3JLSW56?=
 =?utf-8?B?NlQ0RWpWT1JJMWFBNThNeC9oeTZhblo1OE9DcnFRRDdIeC9ubzZEQWdkdHNn?=
 =?utf-8?B?ZTVKTEx0UjNJV1NEWkQrUC9PZmRTaWk2YksyTG14YWVlVjU1K1llcjJhM25n?=
 =?utf-8?B?RU9qQVpqeFRRdXZkWk15VDR5MEsxRWgva0NmNGhzMWdYaWZyYllDck5UWmtp?=
 =?utf-8?B?REdlYVJhbWVuTzI2TGJuR1RUWVlKdk1FT1BVTk9OUkFuaXV5ME9mb2FBejhS?=
 =?utf-8?B?eWJZUjFoRE96ZzVxRDVTTlRrVWQvc1pFdkN3WXJLVW5TWW5DSGJKNGxCOTQv?=
 =?utf-8?B?UzlIYWlzSkVxMmF5cnRNbkFiYTZQeFBQbWpZd2U2U2ZtVmJXaE1xU3Mya3JY?=
 =?utf-8?B?MXNiMTlGYkp0UXc4alhOcDJMN3ZWUHFEVHNzNG9pbUNXY3ZwMjVZZWxPSVNZ?=
 =?utf-8?B?NU1YRUQrSjVvZnJGUElhaVAxTTUxLzRrbmoxUmNLUEh2bUZtTWxKSnN3bndD?=
 =?utf-8?B?YmdaMzlib1pCV1RoeEgwaVdtNWc0cWNPdklOcFgzV1lCeXlXTVJpMXg5R252?=
 =?utf-8?B?WmNMN1ZTZWNHV2p3aUh4SmpnRm5vbENOdEJnS3RMQ1BSZHNjelgwYmlOc0E3?=
 =?utf-8?B?eVM2K014OG5hMWJSaHFxeDJ3Q21rTnF3Sk9qUUYvNC9qZmtKdWlBditPaEdJ?=
 =?utf-8?B?cHA4OTYxakJvRytnNVNSbWpGcE5uSzZVempoNlQzZ0k3UFlIUlNtaGROTnJ1?=
 =?utf-8?B?Z3NvMzE0TkJFaGVRcW5SOTlMbkd1MDFTQmtrS2dsbHhkQWhsMkI4VUVUQkkx?=
 =?utf-8?Q?I+DJk1+aZghJZ0O4Hbj2Hhs=3D?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec504fe2-bacc-469b-6635-08d9ec59cc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 05:54:26.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeLXacILQd03KSMCM8Xhpxf5CutxRvyTzKmm7mXrU5ShvS3JjtE+/rJ4X1NIqF+ZNtYBElOk9d62wndUmDcxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4210
X-Proofpoint-GUID: 0gycLDowjZxdJuOw3f4xMh31IBxw1asc
X-Proofpoint-ORIG-GUID: 0gycLDowjZxdJuOw3f4xMh31IBxw1asc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_01,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100031
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
ZCwgUHJhYmhha2FyIFttYWlsdG86cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb21dDQo+IFNlbnQ6
IFdlZG5lc2RheSwgRmVicnVhcnkgOSwgMjAyMiA0OjUzIFBNDQo+IFRvOiBMaSBDaGVuDQo+IENj
OiBMYWQgUHJhYmhha2FyOyBLaXNob24gVmlqYXkgQWJyYWhhbSBJOyBCam9ybiBIZWxnYWFzOyBM
b3JlbnpvIFBpZXJhbGlzaTsNCj4gS3J6eXN6dG9mIFdpbGN6ecWEc2tpOyBBcm5kIEJlcmdtYW5u
OyBHcmVnIEtyb2FoLUhhcnRtYW47IE1hcmVrIFZhc3V0Ow0KPiBZb3NoaWhpcm8gU2hpbW9kYTsg
Um9iIEhlcnJpbmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJlbmVzYXMtDQo+
IHNvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJpanUg
RGFzDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBbUkZDIFBBVENIIDAvNV0gUENJZSBFUEYgc3VwcG9y
dCBmb3IgaW50ZXJuYWwgRE1BQyBoYW5kbGluZw0KPiBhbmQgZHJpdmVyIHVwZGF0ZSBmb3IgUi1D
YXIgUENJZSBFUCB0byBzdXBwb3J0IERNQUMNCj4gDQo+IEhpIENoZW4tc2FuLA0KPiANCj4gT24g
V2VkLCBGZWIgOSwgMjAyMiBhdCA0OjQ4IEFNIExpIENoZW4gPGxjaGVuQGFtYmFyZWxsYS5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gSGkgUHJhYmhha2FyLA0KPiA+DQo+ID4gPiBbMF0gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LQ0K
PiA+ID4NCj4gcGNpL21zZzkyMzg1Lmh0bWxfXzshIVBlRXk3blpMVnYwIXlQMFdxWXMxNjVyaUNq
V1JoWnByamdNVlZMZlFMdGtrUGZ2Xw0KPiA+ID4gUjdYQ29xa3FnTXNPeW9yOTBFWnAwWUFkeHUw
JA0KPiA+DQo+ID4gQ2FuIHlvdXIgc3RyZWFtaW5nIERNQSB0ZXN0IGNhc2UoLWQpIHBhc3MgaWYg
eW91IHVzZSBFUCdzIGludGVybmFsIERNQUMNCj4gaW5zdGVhZCBvZiBleHRlcm5hbCBETUFDPw0K
PiA+DQo+IFNvcnJ5IEkgZG9uJ3QgcXVpdGUgZ2V0IHlvdSBoZXJlLg0KPiANCj4gVGhpcyBwYXRj
aCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBFUCB0byB0cmFuc2ZlciB1c2luZyBpbnRlcm5hbCBE
TUFDDQo+IGFzIG5vIGV4dGVybmFsIERNQUMgaXMgc3VwcG9ydGVkLCBzbyB3aGVuICItZCIgb3B0
aW9uIGlzIHBhc3NlZCBhbmQgaWYNCj4gRVAgaGFzIHJlZ2lzdGVyZWQgaXQgaGFzIGludGVybmFs
IGRtYWMgaXQgd2lsbCB1c2UgdGhlIHNhbWUgYW5kIHJ1bg0KPiB0aGUgcGNpdGVzdC4NCg0KT2ss
IGluIG15IGNhc2UsIHJlYWQvd3JpdGUgdmlhIGV4dGVybmFsIERNQUMgYWx3YXlzIGdldCBpbmNv
cnJlY3QgZGF0YSwgYnV0IHJlYWQgdmlhIGludGVybmFsIERNQUMgaXMgY29ycmVjdC4gTWF5YmUg
dGhpcyBpcyBvdXIgUlRMJ3MgaXNzdWUuDQoNClJlZ2FyZHMsDQpMaQ0KCioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioK
VGhpcyBlbWFpbCBhbmQgYXR0YWNobWVudHMgY29udGFpbiBBbWJhcmVsbGEgUHJvcHJpZXRhcnkg
YW5kL29yIENvbmZpZGVudGlhbCBJbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgc29sZWx5IGZv
ciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsKHMpIHRvIHdob20gaXQgaXMgYWRkcmVzc2VkLiBB
bnkgdW5hdXRob3JpemVkIHJldmlldywgdXNlLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRlLCBjb3B5
LCBvciBwcmludCBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNp
cGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYnkgcmVwbHkgZW1haWwgYW5kIGRlc3Ry
b3kgYWxsIGNvcGllcyBvZiB0aGUgb3JpZ2luYWwgbWVzc2FnZS4gVGhhbmsgeW91Lgo=

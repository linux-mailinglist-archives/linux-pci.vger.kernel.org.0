Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96B747B93
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 04:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGECdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 22:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGECdt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 22:33:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE710E2;
        Tue,  4 Jul 2023 19:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnbkLbssfX32iluek4wB1BnuEhLTFI7oH7DqpQXi38CiNEwtdFnFeiRDH0oF/aRrouyyPe5BjeY0Wz34s/Upw9fHPtUuSR3gOrsYCA/UUZ30vquAStSAhzzZDmpf0HuVLm8g6rUx1CxYJGc6s4z8ssIU1BtaAAdT3g0TiUDZdDQePXGAIQMjSQNCt2YcsFzQxt/fLQ54ANZc1Hm2zLjluEG2gY1foZ/c4d9r+NuCYBI54g/Ycw6ewAoYRfhEJOrxYdnJuM8KjX3WV8q/BbwJG16AZpY2oSITWYDCUIi6l8OXDFwQ/fdI/D7NEJNXTxzEd8OmqUC6W2i4GVnvVQ8Knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9SWHZdE2IlDqtl/lBYGqUJb3upY7oWvZVRey1s6HoA=;
 b=Fm8hN4u2rnCFeS5v2/AAwHx5MV+4XOwfoD7Ph/G5wVfHvRlCKL5NLh59XIopc+vgVcKjwbZRCCaRNYTDbYpmiYsfzhpXsT8q2wqGEJUnZgMbDExuU1xFUxCQIm4s5lpYcpq1buF/B0cio3iNRIzT+cZBUtJl5nt5L6DlK86N7k9QDH6ySa9A5tUCKrQbFb4+XeZrfSSoki8QZMyaO91IpRp0y00B5Il1VO0WJjYS1zN8F+TiqYQfYPcwbs1cZPyGZ/aTgusgHsp2P/TYpGC68n4FuBNprqB0ZtSmasy2tGdhkI6sSUAMbITOLMN88gCk7GZNypQt4/yAaKAJsL7CIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9SWHZdE2IlDqtl/lBYGqUJb3upY7oWvZVRey1s6HoA=;
 b=rJ9aWLTjFpRoiVqjPX7m9lyKHKdraa6oqcpFNr+l3NPjZ4Fev5wJ5x4K/PO1iVuGpiQmaj7GCKKCR6X/jToa9ttCqaOLVgLMnFILHpJYGVX/WVOMyxZ2W5soyeOBobhIEU91tHNT/lBzoS4/WDMq3Wun3pOwSQw33MkYKzykgSM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 02:33:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::217c:e9d6:8dc3:8f02]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::217c:e9d6:8dc3:8f02%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 02:33:43 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Add deinit for imx pci
Thread-Topic: [PATCH] PCI: imx6: Add deinit for imx pci
Thread-Index: AQHZrt0KjlifXj/F7UuxiycJKXj5Fa+qc+1A
Date:   Wed, 5 Jul 2023 02:33:42 +0000
Message-ID: <AS8PR04MB86761A36A9B48081D1D9F4638C2FA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20230705010624.3912934-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230705010624.3912934-1-xiaolei.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS4PR04MB9290:EE_
x-ms-office365-filtering-correlation-id: d6bd289a-ebde-4a76-f79a-08db7d003ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vuy4iMXQBFA6AQ8+P2hqt0XqBDO7cex8RQIG3Rck/RFO+nLrukd8LWiXqU/tpl88CzkA3sXCb4kCdzOy+5FrNqKcuVEqv5VrB8jYGD6/diAvhMnj0eN6kgfs1gyrxR5bkv9nGEYOWDgh8yDyDIziRBg+S7fHpyVvQTEnPwOd5oh3yowEgyjgdUNDhHmLGPYJrG8UzlmxZKmJ6Jsi+RDAJ+gtBp/eZkhnxbXNW+a4Wg52hV1oeqa1I4KF6GVZNvyt1wki+G4rmNa1oWJq5xUaizGMO+5Q4hOolqXpe5+Q0RmQVJ563klz9P49LYOrJttoYFBTaE+ZEbPjPbbTs6Pt1faVVUyh/lpESI2XxPxsEizqAyD31xt64dnDuw2MU9hjZ1GirzmQjChDwDurMbpyC8SpMPWsQVCJ2jfgIJHwN54+Y05Beqa6lruiB0FLnl5eNjfO/F/6hQOBGkfL83Bei2RFC2avhWECQPduNR23CizX+Pyd8EzAJ2orBa/DWDjqBsg7vqnCfnj6MlZTmLeQ7yunb5Zp6il0o8rFiknKzkALjgcMXr/8bctxg5NxnPT67CVYgPYH16OBRYiOIVSjS6O2ogMCIJKz2X898vlkm4k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(2906002)(52536014)(7416002)(44832011)(5660300002)(53546011)(86362001)(55016003)(8676002)(66556008)(8936002)(110136005)(6506007)(54906003)(26005)(7696005)(71200400001)(478600001)(186003)(33656002)(966005)(9686003)(45080400002)(38100700002)(122000001)(38070700005)(83380400001)(4326008)(6636002)(64756008)(66446008)(66476007)(66946007)(76116006)(316002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QWdZZUkzZzhQT09uZTAyQVlhWFRLVWdKQitEL1RJem51UG1mcVNYVjI0czRa?=
 =?gb2312?B?azQrY0s3S1dsNzMxQ3FETG1kc1hHS1NxTW1vOUw0YlQ3V0hPYjRNS1FPMXlH?=
 =?gb2312?B?aVNnUXd2ek1mK2lwYXQwOW1xRUsvNVA2a2hJdngxd2g3enJyNmpweFV1OUNZ?=
 =?gb2312?B?cFZYT3oySkpSZGYzNTNNQUNwSkFRL0M1blpPbHkxNjFxb0J6dVFyQXBFUVVa?=
 =?gb2312?B?WlBTa21FQ2VhM29Yd3V1NUpwaitnSFQxU1FIeUNRSFptSGt5REFlclN5WWl1?=
 =?gb2312?B?N2Y5WG1MZHdRdEs0NTZ0RXQ5MER5bnhKS1NKOXN1U1FHVVNVRGYvSkhleUQw?=
 =?gb2312?B?QnY4NGxmUFBxV3ZqV296RWt6SHB5RlBkejJ5ZzFCSlI1YjBnZ1c1dVZxTFhl?=
 =?gb2312?B?R3ZMNGZRblR4UmlpeDdkWVNCb29IV1ZvMHMzcFlLN0NXb1FiQ1lhMTBJY2lH?=
 =?gb2312?B?UE4yQTd1SklaaXNpcWNWajBJVWY3L2VZUWJjL09CU2VCMktrdHNpWlpaMHlL?=
 =?gb2312?B?MitiSjNZSUUwUm9wbmdZVDBTN0xYNkFqekFxaktRZC9oTHhxbzV5YW5WQ0s4?=
 =?gb2312?B?YWV5OC94R1QxQWk0a0EzQXRZc1kzK0FiOXUyK1lyYUZ4b1JORHArbXpFd2xF?=
 =?gb2312?B?MzU1T2FYU0xNbjVnSVFDeDNYWXI2VWpiZHBRUFI2SFBab0RpYmNpMVVuaE1N?=
 =?gb2312?B?NjI4YlhaWFhaeG9XRGZMK0wxRzRkd00rcVArblY4RGZHcFdhWHY0YUZZUkx4?=
 =?gb2312?B?TmZ3L3RxQU9uODdXWVUyU2JZdDg2QjlGN0Z4THdxNkhSSXFjbXViYURzQUhj?=
 =?gb2312?B?cHpLaGdIcUk3R3BjZkRYTnZLMGVId1laUGQrQjhweitMSkR4aTBIWGdlNi9L?=
 =?gb2312?B?TW4rUkxmMENoR3d1bFVqZGQyalBTVVUzazhqZlN4YkhHZzVHbVlIODF2dHM4?=
 =?gb2312?B?N2NBaXQwQ0lCdVl2em9tUW9hWU1oU25XOHNGSDYvcFhHNmR2cUg4ZzJBVEJJ?=
 =?gb2312?B?Y3UyRWxPbmdXeWpuS3lnN2N4L2xjdm5mcUxJODNMd1d1VHdWcld1YmxQM1Ez?=
 =?gb2312?B?UjRmTjJqWXZhdmdBd3NxYzh2SnhsQTBGQlBsT2ZGUEZ5ZWI4czFrYXJWWmdU?=
 =?gb2312?B?dFdXMzVTVWJIcWszemlsNDhnNXBDbGo1QkpmMkZjK3QvVFdsUENhMzdWbmg4?=
 =?gb2312?B?Q1ovSXM2SFQ5L1VNM2ZoR3hPZHpTSzFNZDRXTHRYL25wckYvWVc0UlF0aHRL?=
 =?gb2312?B?bDgwVmdrTm5LS3E4eXFneTc2ZW5UUFFIL21LbU1SWTgydVpwVER0YjlEUC91?=
 =?gb2312?B?S0lNVm4wdEhoR1lIZHcya2FoTHhGengzczBaWVNqQXFZUUx4SWFldGt3TXAv?=
 =?gb2312?B?Y1BXVDF2MkhJWWF2dFRscVE4QURpdG5UNlBjRUhkZTdxQnp2bnNLRUVYSmFk?=
 =?gb2312?B?Y0M0MlNDMmtZcXJTTEpmUHpMTFIzVXFPUjFLbWFxNHVzZklvckVnekFhbW52?=
 =?gb2312?B?OHEwb2pMZ2ZIQ3NSc3dJYlRYaXpqV3ZyenZwN1ZvUGttRnlXNTNOSlJwR1Ix?=
 =?gb2312?B?R2RHdVd1dEx6ZkV0SlFxVmhxMU80bW9zbG85ZEM5Y2VmSURqaWFGVzlySlJ3?=
 =?gb2312?B?S1pGZW0vc01WOFVMS1p3WUV6S1JqdCt3WU9FbWRTc3V0STNHeU5DSmxicEJW?=
 =?gb2312?B?U0Q5QkpQSGlCZGhQbGhpVGVlTkRiaVRmc3pUZHVkbGM4TzJVdldmZmhvN1JO?=
 =?gb2312?B?azVyQ0RRRlBNNjRLWWo4OHZkcGVpYURzYlVTMmtGbTluK3NTM0c3ZzVFY0ZD?=
 =?gb2312?B?SWVtVDVrRHpUV0U1ZEJOYXllL3R4QmE1VHZjZkVnN0RMcDBqYXNqcmdLMFA5?=
 =?gb2312?B?dnNJSFYvOVh6T3pXR3RpT3kwcXZBTVFvcGRGanFqcm1hcTdPcE1VQlM0NDlS?=
 =?gb2312?B?emxYWG01MjJlNEFHdnJIYnFpSGM2Y2hXOUlVRUtreVJITWQ0UWlSNzJiSG0y?=
 =?gb2312?B?SDJSMjFGYkJuakh0Y3lEdTlrL1BPZm1oc1F6TkRFTXZlZGlxQU93alhnUTFi?=
 =?gb2312?B?bmZxUEhTK0FEK01uRnVJOWVmcEFlSkFjMTF1VGpkVE1iTkgzU0x3cWN4RExN?=
 =?gb2312?Q?viVcyPeFcCMVpNEQoE8zlSELp?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bd289a-ebde-4a76-f79a-08db7d003ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 02:33:43.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flNfH+BHXJ0BIJpRNjFnhcAzdSyI78nzv7uN7apI4y+zwtkruyt8bdphZfWa76HWA1OaoBNYpl/5LJFWyBdATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgWGlhb2xlaToNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NClRoZSBzaW1pbGFyIGlzc3VlIGhh
ZCBiZWVuIGZpeGVkIGJ5IGFub3RoZXIgbWFpbC1sb29wLg0KSXNzdWVkIGJ5IE1hcmsgYW5kIEZh
YmlvLg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjMvNy8zLzgxNg0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9wYXRjaC8yMDIzMDcwNDEyMjYzNS4xMzYy
MTU2LTEtZmVzdGV2YW1AZ21haWwuY29tLw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGlhb2xlaSBXYW5nIDx4aWFv
bGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4gU2VudDogMjAyM8TqN9TCNcjVIDk6MDYNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOw0KPiBrd0BsaW51eC5jb207IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5l
bC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0K
PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtQQVRDSF0gUENJOiBpbXg2OiBBZGQgZGVpbml0IGZvciBpbXggcGNpDQo+IA0KPiBDb21taXQg
ZGE1NmExYmZiYWI1KCJQQ0k6IGR3YzogV2FpdCBmb3IgbGluayB1cCBvbmx5IGlmIGxpbmsgaXMg
c3RhcnRlZCIpIGFkZHMNCj4gdGhlIGp1ZGdtZW50IG9uIHRoZSByZXR1cm4gdmFsdWUgb2YgZHdf
cGNpZV93YWl0X2Zvcl9saW5rKCkuIFdoZW4gbm8gcGNpDQo+IGRldmljZSBpcyBjb25uZWN0ZWQg
YW5kIHBjaSBkb2VzIG5vdCBhcHBlYXIgbGluayB1cCwgdGhlIGxpbmsgd2lsbCBiZSBzdG9wcGVk
IGF0DQo+IHRoaXMgdGltZS4gUnVuIGhvc3RfZGVpbml0LCBzbyBhZGQgaG9zdF9kZWluaXQgY2Fs
bGJhY2sgZnVuY3Rpb24uDQo+IA0KPiAgIFdBUk5JTkc6IENQVTogMiBQSUQ6IDcwIGF0IGRyaXZl
cnMvcmVndWxhdG9yL2NvcmUuYzoyMzk4DQo+IF9yZWd1bGF0b3JfcHV0LnBhcnQuMCsweDE3Yy8w
eDE5NA0KPiAgIE1vZHVsZXMgbGlua2VkIGluOg0KPiAgIENQVTogMiBQSUQ6IDcwIENvbW06IGt3
b3JrZXIvdTg6NCBOb3QgdGFpbnRlZA0KPiA2LjQuMC1yYzEtMDAwMDEtZ2RhNTZhMWJmYmFiNS1k
aXJ0eSAjMjINCj4gICBIYXJkd2FyZSBuYW1lOiBOWFAgaS5NWDhNUSBFVksgKERUKQ0KPiAgICAg
Q2FsbCB0cmFjZToNCj4gICAgIF9yZWd1bGF0b3JfcHV0LnBhcnQuMCsweDE3Yy8weDE5NA0KPiAg
ICAgcmVndWxhdG9yX3B1dCsweDNjLzB4NTQNCj4gICAgIGRldm1fcmVndWxhdG9yX3JlbGVhc2Ur
MHgxNC8weDIwDQo+ICAgICByZWxlYXNlX25vZGVzKzB4OGMvMHgxM2MNCj4gICAgIGRldnJlc19y
ZWxlYXNlX2FsbCsweDhjLzB4MTA4DQo+ICAgICBkZXZpY2VfdW5iaW5kX2NsZWFudXArMHgxOC8w
eDY4DQo+ICAgICByZWFsbHlfcHJvYmUrMHhlNC8weDI3Yw0KPiAgICAgX19kcml2ZXJfcHJvYmVf
ZGV2aWNlKzB4NzgvMHgxMmMNCj4gICAgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgzYy8weDExOA0K
PiAgICAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweGI4LzB4ZjgNCj4gICAgIGJ1c19mb3JfZWFj
aF9kcnYrMHg4NC8weGU0DQo+ICAgICBfX2RldmljZV9hdHRhY2hfYXN5bmNfaGVscGVyKzB4YzAv
MHhlNA0KPiAgICAgYXN5bmNfcnVuX2VudHJ5X2ZuKzB4MzQvMHhlMA0KPiAgICAgcHJvY2Vzc19v
bmVfd29yaysweDI5MC8weDVjNA0KPiAgICAgd29ya2VyX3RocmVhZCsweDRjLzB4NDA4DQo+ICAg
ICBrdGhyZWFkKzB4MTI4LzB4MTM0DQo+ICAgICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogWGlhb2xlaSBXYW5nIDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMSAr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBpbmRleCA1MjkwNmY5OTlmMmIuLmU0OTQyYmQyNTk4
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC0xMDM5
LDYgKzEwMzksNyBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfaG9zdF9leGl0KHN0cnVjdCBkd19w
Y2llX3JwDQo+ICpwcCkNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfaG9zdF9v
cHMgaW14Nl9wY2llX2hvc3Rfb3BzID0gew0KPiAgCS5ob3N0X2luaXQgPSBpbXg2X3BjaWVfaG9z
dF9pbml0LA0KPiArCS5ob3N0X2RlaW5pdCA9IGlteDZfcGNpZV9ob3N0X2V4aXQsDQo+ICB9Ow0K
PiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9vcHMgZHdfcGNpZV9vcHMgPSB7DQo+
IC0tDQo+IDIuMjUuMQ0KDQo=

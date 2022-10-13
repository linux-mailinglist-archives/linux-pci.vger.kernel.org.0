Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0505FD3F7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 06:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJMEuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 00:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJMEuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 00:50:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC811F9C7
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 21:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDtWqiT9kZa/y3L1/cLr/F36iPJOOX5Of1u4b1WDIF/dLo9cDgIEeJ6ATKNwDpA501p1E8Lipkz/TnFVLXOx1QdH1wnlcPtOAAkrYf6GOrqk/vxk3RxkXA/2SWT9dbC/gy7jnhgVgIF1npFXrmXSEbVMqlBPstxHuQp5Inoe3I7WjyZZSd1e6wS1J2OMl7WhXmrImwr0MKhSO4hrWRYjgfwLqpFP1mJhQgJtQaE3vmDm7ooxcrmRD6eMx4UTWP+IAuCnqloZ+8Ht+El34OH2mkR5Vr0ZqxnO6KzAocbDY2M6Gxd0an0rU8xzg3hnqEasDkneFQLKcSJEdIx/WG41Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W0Y0WTEzeesjeDYnpaxzJZweTVDPdLRbz8LCRUQWcQ=;
 b=ABq+5OIjYDv6Wv5O4x8lI7sIONuQ3WfgXiO0IEzUrLK5XU91G5kTu70hK/wWDOi7V9xyVDWvzMzpdqzI9Hu0FlPSZh6lvjI7b3NTNFjuhNSKi69GV8qX4bKHjCt+oEtTX4hStxJMpuRxt+rbN34H1c07GAqdcAw21ZZfalUJQb7VqBHJ8Xb+aRFLgnAFo3ky4c+g0JxSwVT4PaIPBCj1Gvr3150/J/Vpf+3m5YJFmCRfNj2u65bDJzJZxx6tePCN2pqQrngDRDKaZlsMRrhUPViZ2BAjMaZ+C/3bTPOmafP2TU4Rzo5e9iLIUO+LRnf1WWgb5pDIcAnSkhnS+dnv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W0Y0WTEzeesjeDYnpaxzJZweTVDPdLRbz8LCRUQWcQ=;
 b=b9jZyclyBNoS6Nz4af8aLsLKC3JjE/LWcCTu+1XiVrNljl5RHfDJprO2Kq1vnUcMbM3wjMDlqgYMt1q/ak5ldHrF3TfUXLSVBn4OW+3qGB48Hh4DzfYCQmb+PLV/xUolQ7eBJvnpnnSJHGADmuQ+oj54LrIrGjztSpdy8xh/Omk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB8PR04MB6874.eurprd04.prod.outlook.com (2603:10a6:10:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 04:50:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63%4]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 04:50:01 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>
Subject: RE: [PATCH] PCI: imx6: Fix link initialisation when the phy is ref
 clk provider
Thread-Topic: [PATCH] PCI: imx6: Fix link initialisation when the phy is ref
 clk provider
Thread-Index: AQHY3j5JB52s3VPWpUO+6dr3cU2c0q4LoO0A
Date:   Thu, 13 Oct 2022 04:50:00 +0000
Message-ID: <AS8PR04MB86765269F412BB843B5BAC108C259@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20221012132634.267970-1-s.hauer@pengutronix.de>
In-Reply-To: <20221012132634.267970-1-s.hauer@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB8PR04MB6874:EE_
x-ms-office365-filtering-correlation-id: 944d42dc-1049-4731-fad4-08daacd662f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2cAHnaxIDtLCdVMcfwAOthi832fRIvuNlOayencxVwQgI3YzPmKEROnCPYxQq1VPe5wf67S/N0mAoyM0TVJzZjwrNr/nqn29sza0UywYgq8GBCPA1uGQs6R5+PkkuoytB2HDkCJUlaaxxd+94fv65GhnOzo9XXyEihu+K3GVdVKtHI6J9EH4vBoS9FQEbeJkS32zxf7MmEzWCz0m0LYSqgGVrv3KFB3Xm63zJDf0/2iOEQmSbM0e9+TXf/zIg4cL4j3G8px19dYXb7NYAWpzDRvfPskOLjH1UqtqVk1ukLS990zTcZdr7vK70bBTwpGqYT4IpszQf9lqfZqqSgxWPgMVEmNXbAc01vqTCAgiw2A/lecthPnqVJYj86VrlqtJCUNnHRQbD4ZfyN9OKSaq4ysw/BsGg9v7yDOZIH1wDWyQEAyVsbH8j3Qa9bI5Ol20DtB98E++sqcvqhgaDjQbvt3UwJXxIzcFGC+vkinnDhLBYHq3/buGpz4uxx+mUaQcxApEYuIw9AoRss98zAivrAK40Lwdbv/BQoUWkQxETRTCHJpCXDPdP/vwrMAugvakievlEZhAyRAeCVJfkn2GtFtHwc0VmOFThH4Nam4VSULI+9d2kd6uX3ykaAZVw7miYQ5EuNP0cmWkDYoK1nTH/TF6DVOFzlEmTwsK+Q7kIC9u0uuoPqOwsFYJrXuzvFWQLs4cgpySgmGOpiiX9TiXoCzrcWNHrbjaycjllz3TuhS6DTS+DlDCDsFXJmbzMEBKD9GoFxy7zk3ssUoKsn0RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(76116006)(66556008)(66946007)(2906002)(8936002)(66476007)(316002)(41300700001)(66446008)(64756008)(8676002)(4326008)(110136005)(54906003)(71200400001)(55016003)(122000001)(38100700002)(53546011)(26005)(9686003)(6506007)(7696005)(478600001)(5660300002)(52536014)(44832011)(38070700005)(86362001)(33656002)(186003)(83380400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SmhKOHJOSFZSMDZRMDBTZzRSeDhzM0R6TnJyRStFS21GcS9VdG9Wa0lINFo5?=
 =?gb2312?B?RHA2Tk14bm1JU1V2Snl6S21CTUU3eWtSbTZXSXhOK0VyS1FhYi81Q0U1Vlkv?=
 =?gb2312?B?V2RzTjhlQmUrQnZxcUxXT0VHQzdjTGVBOXN1U0hQeS9GOE01Mk9vMS9sK3E1?=
 =?gb2312?B?ZkRnNzZla1phQlUrTXVVVTlOTmY0VjJHeEYwQW5DZFBGWk1KY0trQ1IxRG1Y?=
 =?gb2312?B?RnFGeVh5WHphcW5sQXk3dWdTN0tNTmJKM1N0a0VVKzZnL1RjbkJhWkJzNHpC?=
 =?gb2312?B?T2hGbThicTZGcUVWVmM0b1FYN0VaWUI5ckZ1eXJMYU9QY2R2OVZXbUpUU09K?=
 =?gb2312?B?NENlaTRIcHAxTDlpTzVSWERSd0t3OGF4UlRZcHBFTHZ0WGhwbGczNkFMR1cx?=
 =?gb2312?B?SXJUUkk5ZUkvc1ZOaFJnNWJyS1haL0hLaGVKY2FwREoxeDBMNm9tNlVtalBw?=
 =?gb2312?B?MVc2czkwTUIzQlgxMEt1VHpwOFZQd25hT3hiSWRKRTFhMjZGNlpsMnhxMW9H?=
 =?gb2312?B?b3hpUVpES2djQVhjZzVTTXBKZk9LdE5QcFVpUnNQZU9jMjNxRGp1dnFrOHpQ?=
 =?gb2312?B?Tmw5MnZ6dVRhK2Q1c1YvUkZhOUFLc25id21JNUVyRlJ2dFc0ZWN5N3hvNjVu?=
 =?gb2312?B?S3l3WUp1VmdHU0NXdnpBL3JXckZoQlFvV0NUNm9XYzg4MnpQWWpzWGJwRjYr?=
 =?gb2312?B?QURoUFZjSUU1NWI5aktJejk3M24yRjJBbjl6M05WcTJVQ2I5bWN4ZEhJeE52?=
 =?gb2312?B?ZXlzWGVaUmNSeHkyakVmNUwxSVNLT3JBVFNYNmptNlR6dExLRlEyb0Y1ZEJs?=
 =?gb2312?B?OTYyRHMzZ0crTm9rVk9BWE5TQ0ZOaGxicFRqM05iUlEzbC9yMUxHamhiL1VU?=
 =?gb2312?B?RWtObzArQ2I2MlFoV2JPVmNBUElmOU9wbnBzbjBRalp3MmdtTEF1bVBqMDVs?=
 =?gb2312?B?UWJsbVp1ZUNmbldDTmhaREpsOUlwLzZMZHVFSEtkbTBWcDhvNkpNWWFnc2pj?=
 =?gb2312?B?YjVTTHo3ZUZ2N1IxdVdwRzNtZTYySjhpTko2SE5aSzBXOHMyTFEzS0FkTmto?=
 =?gb2312?B?SlJTQ3lrbEJ0ZkJaSE1odi9XYm5wZXd0aHNaTUM4SUh4VHpWMzFZR3Y2ZFR4?=
 =?gb2312?B?blQvMlV1L2t1RU9LUXk4TXZVWlF4M3ZWdS9zeVJ2UFZSRldXVjVxN0hscU80?=
 =?gb2312?B?ZmlPb1NnamVSTjBjNTl3UDUvckVBQkVXY1ZITUZnWGVIQzY0bVNGanlhdjRT?=
 =?gb2312?B?M2JWTk5hajJNL2x1ZTUzam5DemRhejM4ci9rdFU2NnU4aWNQVzk1ZDFGWjh2?=
 =?gb2312?B?RUpRMEFtWXpGTWRUQzZSS2l5ZVJWTnoxaUw2dzVsV0NvOUZsQTQxN2NXaW53?=
 =?gb2312?B?NUc4T0FLSENpek80U3JoRWF4cVRKSUpYUGJZdU9wT1pYbVR5VkFHdFdwOHdZ?=
 =?gb2312?B?NllXaitia0hEL2EvUG85bWluZGpwaGZ5dlJTSXpZcnRsd05DQW45NFVYaHZr?=
 =?gb2312?B?L053R1Q4WVc0K3JLbkFkdkpGbURxS01WN3drenA5Q2krS3luNFVkUjBxQkhC?=
 =?gb2312?B?VERBbXNFMUZFYkhBZU4yUVFMQlZSWXZ1bTRFanVhTldpV0dJL0dyL3JRQ1lE?=
 =?gb2312?B?VHJiQ0s3L2w2ZW1RdmxiZ1JrQUpLT3NiZjR0T29oR01ZZ0hEMTFDaEVZc3BV?=
 =?gb2312?B?RytmcnJJSEhJZTlReHMrMUdrVmw4RnJLeUxlVUYwUHZ1UU9DYkdFeENnaEJU?=
 =?gb2312?B?YXNISzlkQi9mUWlkeFViRUk2cUdYbDF0S1M3RW5lblNTNldYUEJTUzhNd0NG?=
 =?gb2312?B?akpVWTltMHQwNU9qMUUvM1pFL0pjVFl1K3hQbXBrNkx6enVWaEJNZUtzT3dS?=
 =?gb2312?B?T1hEMldkU21NNEVGbkdoMi9OemsrUjdic0UwUE9tWEZ2TkFBemlyakZYdFVt?=
 =?gb2312?B?alphY3krNFRFcWI1UFRxNVFGZitBUGFZMWpNSjhIeks0OEpUeUxVMlRYdS9o?=
 =?gb2312?B?Q0tZeDUwUWVDSlZnOUVON2Z4VFY3ZzdwQk1mWFhpaXMrYXpKeVk5bU1yN0Nl?=
 =?gb2312?B?UjJkOFJlU0ZKcnhsOVM1UU04RXdQNmk1cHFOUkJIbU53Tk42dHlOYUxaRmFG?=
 =?gb2312?Q?6ojdVNFLl1xQDKvaBsFkRoPFy?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944d42dc-1049-4731-fad4-08daacd662f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 04:50:00.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjMQ9GaYXV6HFMIwabBnnWhWo1WU/CSzQqV8wR5EsUpcp1d7ylr33LMvyfGoIArBttyyWJhVQ6MMvj3QYkWaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNhc2NoYSBIYXVlciA8cy5o
YXVlckBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMsTqMTDUwjEyyNUgMjE6MjcNCj4gVG86
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgSG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVAbnhwLmNvbT47IExv
cmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+Ow0KPiBQZW5ndXRyb25peCBL
ZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
V2lsY3p5qL1za2kNCj4gPGt3QGxpbnV4LmNvbT47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5n
dXRyb25peC5kZT4NCj4gU3ViamVjdDogW1BBVENIXSBQQ0k6IGlteDY6IEZpeCBsaW5rIGluaXRp
YWxpc2F0aW9uIHdoZW4gdGhlIHBoeSBpcyByZWYgY2xrDQo+IHByb3ZpZGVyDQo+IA0KPiBXaGVu
IHRoZSBwaHkgaXMgdGhlIHJlZmVyZW5jZSBjbG9jayBwcm92aWRlciB0aGVuIGl0IG11c3QgYmUg
aW5pdGlhbGlzZWQgYW5kDQo+IHBvd2VyZWQgb24gYmVmb3JlIHRoZSByZXNldCBvbiB0aGUgY2xp
ZW50IGlzIGRlYXNzZXJ0ZWQsIG90aGVyd2lzZSB0aGUgbGluayB3aWxsDQo+IG5ldmVyIGNvbWUg
dXAuIFRoZSBvcmRlciB3YXMgY2hhbmdlZCBpbiBjZjIzNmUwYzBkNTkuDQo+IFJlc3RvcmUgdGhl
IGNvcnJlY3Qgb3JkZXIgdG8gbWFrZSB0aGUgZHJpdmVyIHdvcmsgYWdhaW4gb24gYm9hcmRzIHdo
ZXJlIHRoZQ0KPiBwaHkgcHJvdmlkZXMgdGhlIHJlZmVyZW5jZSBjbG9jay4NCj4gDQo+IEZpeGVz
OiBjZjIzNmUwYzBkNTkgKCJQQ0k6IGlteDY6IERvIG5vdCBoaWRlIFBIWSBkcml2ZXIgY2FsbGJh
Y2tzIGFuZCByZWZpbmUNCj4gdGhlIGVycm9yIGhhbmRsaW5nIikNCj4gU2lnbmVkLW9mZi1ieTog
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KSGkgU2FzY2hhOg0KVGhhbmtz
IGZvciB5b3VyIHBhdGNoLg0KaW5pdGlhbGlzYXRpb24gL3MvIGluaXRpYWxpemF0aW9uDQpJbml0
aWFsaXNlZCAvcy8gaW5pdGlhbGl6ZWQNCg0KQXMgSSByZW1lbWJlciB0aGF0IHRoZSBzZXF1ZW5j
ZSBvZiB0aGUgaW5pdGlhbGl6YXRpb24gaXMgbm90IGNoYW5nZWQgaW4NCiBjZjIzNmUwYzBkNTkg
KCJQQ0k6IGlteDY6IERvIG5vdCBoaWRlIFBIWSBkcml2ZXIgY2FsbGJhY2tzIGFuZCByZWZpbmUg
dGhlIGVycm9yIGhhbmRsaW5nIikNClRoYXQgY29tbWl0IGp1c3QgcmVmYWN0b3JzIHRoZSBjb2Rl
cywgYW5kIGRvZXNuJ3QgY2hhbmdlIHRoZSBpbml0LXNlcXVlbmNlLg0KQW55d2F5LCBJIGhhZCB0
ZXN0ZWQgeW91ciBwYXRjaCBvbiBpLk1YOE1NIGFuZCBpLk1YOE1QIEVWSyBib2FyZHMuDQpCb3Ro
IG9mIHRoZXNlIHR3byBib2FyZHMgd29ya3MgZmluZSB3aGVuIHRoZSBOVk1FIGRldmljZSBpcyBp
bnNlcnRlZC4NCg0KVGVzdGVkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTMgKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBpbmRleCBiNWYwZGU0NTVhN2JkLi4yMTFlYjU1ZDZk
MzRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTk0
MiwxMiArOTQyLDYgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19w
Y2llX3JwDQo+ICpwcCkNCj4gIAkJfQ0KPiAgCX0NCj4gDQo+IC0JcmV0ID0gaW14Nl9wY2llX2Rl
YXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlk
ZXZfZXJyKGRldiwgInBjaWUgZGVhc3NlcnQgY29yZSByZXNldCBmYWlsZWQ6ICVkXG4iLCByZXQp
Ow0KPiAtCQlnb3RvIGVycl9waHlfb2ZmOw0KPiAtCX0NCj4gLQ0KPiAgCWlmIChpbXg2X3BjaWUt
PnBoeSkgew0KPiAgCQlyZXQgPSBwaHlfcG93ZXJfb24oaW14Nl9wY2llLT5waHkpOw0KPiAgCQlp
ZiAocmV0KSB7DQo+IEBAIC05NTUsNiArOTQ5LDEzIEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hv
c3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycA0KPiAqcHApDQo+ICAJCQlnb3RvIGVycl9waHlfb2Zm
Ow0KPiAgCQl9DQo+ICAJfQ0KPiArDQo+ICsJcmV0ID0gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVf
cmVzZXQoaW14Nl9wY2llKTsNCj4gKwlpZiAocmV0IDwgMCkgew0KPiArCQlkZXZfZXJyKGRldiwg
InBjaWUgZGVhc3NlcnQgY29yZSByZXNldCBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KPiArCQlnb3Rv
IGVycl9waHlfb2ZmOw0KPiArCX0NCj4gKw0KPiAgCWlteDZfc2V0dXBfcGh5X21wbGwoaW14Nl9w
Y2llKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IC0tDQo+IDIuMzAuMg0KDQo=

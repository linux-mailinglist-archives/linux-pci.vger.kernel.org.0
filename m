Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBF62913B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 05:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiKOEmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 23:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKOEmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 23:42:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2127640;
        Mon, 14 Nov 2022 20:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcx15Jvqb9pRMLkiRJpMssCosbZUZbburryvnnJyBTV660vYPHG/k6bibB705r/t6JuHJl9KY89VhmqrXvLRrvtYiEtu30s35E0soflVMrHKNKIJ4WvMSvtDNGaKuriDf5DmVnWVsNJONuWbjIdIPfmXFrlfZhNZSZ0l6EK54pHX2Dr0fwgycDFMchv5GCN+5KuHgbaSRIlW2m7+f5qAa0v66XBt1G8LhckcEotKzRRRV1YsVWrwhGsAO9yXRx2HeL0T+KwuJW8gbxoELt80VRBAderhWGUdS/fYKsWCYyswPehbg9t3p9SaAb7kWPdHcogNGuQ0TRNMmm0cx4b9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxhDWiNYNKnN2ao0X5v1YkX0vguZjMobcHQHXpiKVCg=;
 b=aQUGCj2R/LX8mlziWN+XjlC8ZJWGW/9dabd/jAmRFjpW1o3JnM7mXbfM1UZy5Gh/TI9XbDNhr0omb3VI0BQSAHVbuNS3+kjofiFQQOjIjWer9gbwpNCS6+KflmvUjq2sQkfO7zVlBiKsXKkIRk4oAZK5qRmEZODoW90iZqGr0oxu4gk405FzhzFmUhC+W5OXfZynme6LLbkQtm2em1PxPF9c02XAScOogv5byP7ej5uG31rrMNPqPY4G2dcsAegq1sViOzYbDqbNTxhcSrNBIhoGAXpx39zu3yAFBtJZABD9WbNaI4fD4jd+BdqwvMd9S4xDLK8GLb0ZyUbnDzheZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxhDWiNYNKnN2ao0X5v1YkX0vguZjMobcHQHXpiKVCg=;
 b=KsLWk21ZjrVOhzI5vF4IeRnMxtM0jVJvbDJwRPqn3J0GbHfeARWk1bFrW6fT8TN5mcTaH7b645fNQ5rJrFbrgJaKohp7jFWaZyIYphYe8pr1hZKhSRFQDdjgbTFz0OiReFG4WUpWsgKgwvu6gOS43nfjTf0Wih122w/nicX8x/8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 04:42:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 04:42:31 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Thread-Topic: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Thread-Index: AQHY54JopHT5ExQx9k2dh6kI/soZba4/iW4w
Date:   Tue, 15 Nov 2022 04:42:30 +0000
Message-ID: <AS8PR04MB86761655C5F12142BA183B998C049@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB8490:EE_
x-ms-office365-filtering-correlation-id: 26bdd874-71f3-4847-34ac-08dac6c3ce62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szVcPqgYo6znaP189cd1U8CFPggaM/T8xQNaNd/pLLuc9Rg6m5iriXhH/tpnB8yjDxl2FVz45kq1Amn3G4hAezKvvJ8O7cCIP6fI7r+5vvyu6xE8KMOZRXUdAj4mMKDi2TRKWX3xhN1hK5dhgqtGxUZwINYtUt0RgRJSiK2XoonuFsVHKMgM5f2W17iGCOeKCRBXjCq8zeJ7FxrxNYFC5G8YvCXnbloqu6ZgInoantrbCKJ14cxoUmp0wXlBUNxQHjar4zySBU7YcFpLzbPaH4p+X+5imQxKzF3ckCcd9VdUATHymy/wiq3mVeX4rLN3uBSOWOG5EFPZD/84GA9N2xtGd+rXy6fLLZNIw2YOFsiNM0whqldGfmyTTDFeRz5y4sLq5makU7dm6hUV0bUEIQzgkB9V5QX1bGwKnmkwnh4cAQnqp5paOp7mQafpx5X9c9p0skpjdaipbCnVKmgb2eXoK3DLsHm2xcsQnnUT4HPMo7xS5OmKGmy8TXa+JYqWW4tJRD13UlaEsi6ifiLo5rZZOG+0FxAGIE+wj5UkGHjQqQDVNUmdyXPAtP0wcqKDSKBpPXfvFeOhX7zWW5sGS33WP7/nFm+mSb75RCH/UqNuro7ZmNJ4FW0zEDYkPTa3wfg9YkXx9+hopj2ikFnagSZdRy5gwSmo6/W9qG63T5PazTXlLCmUuSTndubVMRU9lmyocMtYSB0hn6aWdLYlVZKsJVsfH3DBfp61o9pwr4P/gc91cfQaB0Kum0Y+8MB1zCo7ueTqVaBnaEBAG5RMbe1g2cUnQH1J/heoU3FjtHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(478600001)(71200400001)(966005)(38070700005)(5660300002)(7416002)(8936002)(122000001)(53546011)(83380400001)(38100700002)(86362001)(33656002)(186003)(9686003)(26005)(7696005)(6506007)(54906003)(6636002)(55016003)(316002)(45080400002)(110136005)(41300700001)(44832011)(2906002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aEF5VEF2QlZKYVVxWnF1UzdRRnV0dGhvSjc4L1pMRkpCcW1hWVd0M2szU2lS?=
 =?gb2312?B?amExSWsvSDhXdU1KQWQ2N3pJdDE4TG1TSkRiTTFET09od0hadHVGdkZZVTM5?=
 =?gb2312?B?UnhOM0lUSzczZzBreDlOR0d1RWZiNVdtdWFaZ0cvVEd2VmlHekVXRUdPdDVv?=
 =?gb2312?B?MU1JMUxmbFF0WWVFSmdqY255eVFFR29UOXp0VkZzZFQ3aWV2NFdLNDNzMzh1?=
 =?gb2312?B?aVF6ZVNBRVlmMTkzYldRYjhQVXNtYnNkTU5xcU9iK3ZHM0ZYbTgwakYrQWtW?=
 =?gb2312?B?Q2RDeXhaais4R2JudHZta1czcFBuQnRHekdBM0xBSm9LMVBGbmtCR0NkamJ3?=
 =?gb2312?B?dFZKQzYreXZyZmpMbVVRNWR4NGUwYUE0d2h4VlRlQ1NXUzFZYzIwV3VSeC93?=
 =?gb2312?B?dGZMcU9WTzJwUWFzQlBabndWM1B5YnhvWnVQZDJWTldPZmtiMjdoZlJCcW9r?=
 =?gb2312?B?VmYyZllVSFhhRzZKS2I5QXJ2Y2hvNThORVN0aFp2WFBEbGRGMHJUK1Y5T0JN?=
 =?gb2312?B?ZitXdVErcXFmL0hPN2xGRUJ1UXQ0Tjk3dnZzOW1JRWdVUkQwalpmbHJqbGln?=
 =?gb2312?B?VWZ4Y2phVzJ4Rkt0ei9WTWl3N3pEMUJQRjdGcVRWMlBvMWFmOVhNS285Q2pV?=
 =?gb2312?B?cVlYYTFZWkR0MGtGQmg5VkJQL0tLTFo4ZzdIblB2UGM5eU1IdE9sQ0Z5YzFh?=
 =?gb2312?B?MmRteDRkNFA4eGQyYU5xT2V2dDIrbkx4ZDc2OFJTOTdGcHNNTGo1bXYwVVZX?=
 =?gb2312?B?Q1hUZU1LM0plUGpoaEpBVkdoWEZNOVZwbFdYWHVCa1JScjVuUXFRYnV3NnBY?=
 =?gb2312?B?SXo3VVk2bk00TWw3MEZncjkwSGt1TE96cFhwSUpId1F3eVdaU0NabTA4bExW?=
 =?gb2312?B?VnRmYVdHS3duU0UvY1NFenZIOTlpSmRuR1Q5c244VUN0MnFkS2hnNXJsam9Z?=
 =?gb2312?B?UDJoYzgrWU5CY3BNYm1YbmdOMCtVc093d3R3VnpuUjNic0kvOTFuaHZoelJS?=
 =?gb2312?B?c1BWOGk1L2h4VFk0VjlnWXFkR2IxRW9jTjl5aThtaWNLaFA0L25rV2RSSjNI?=
 =?gb2312?B?U2F5VmNkb05oRlk2eHdnQzhiMTE4TGlQc3NWNSs3L0trZ0FuY2FwbkZNUmcz?=
 =?gb2312?B?aXNaTlJIUE92dmRPQW5CSlNnNDZmQ2djQksxZHJuU3MySFpGS0M3dDVQbC9K?=
 =?gb2312?B?ZDBlRTl1WE9aWW5rcGY1amxadkYzdDVDS2hYZGNmOHM0aGVPaE16MlZTYXpV?=
 =?gb2312?B?UUREbXlVSlhFbzZMMWtzOWxFZklDNWZCR2txa21oczZKL2hYOFRVeTF3cFV0?=
 =?gb2312?B?NEdCR2s5cm45Mnk1R2NsVGxtcDZWRzVYcGppeHZtY1ZNNzcwWVR6em1Kbkkr?=
 =?gb2312?B?anZPU1U0YUF2eFM5Y25GUEpGQmkxWXN4N1lHcThzRmI1NC9zdmlKVWhBM29u?=
 =?gb2312?B?UWEvVGw5MkpGalVMUHdrTkhwR2dTeXFqYWhqNTNnWmdQK2ZGWm11azNmTkhz?=
 =?gb2312?B?TWR4UGIxNWZZMG1MVUxtQTRxa2xZT25zN1k4Szkyc0FpbkZVaTFQWU1JRmJ1?=
 =?gb2312?B?RTRhNU9YMG9WOFVnVmdLUktZcFFVL2FlKzNvMHptdlFVVHpneWpKSGxLWmp0?=
 =?gb2312?B?RVlnY05rWGY1NWFxMjlHWW1MMjF6WlJxeWcvY3VaQXE5dHpoK1l0OTZvNDJz?=
 =?gb2312?B?MFE5QjdDRjAvQ29leldiQS84Vm55NE5ONGlNeVBhNWl4YXZoUHdJc1EyUVBW?=
 =?gb2312?B?WTBnanl2NXh2NVU0ME9NRVRmWFk0Sm80bVc0anZMTnk0clJ5cUVucW56aEtK?=
 =?gb2312?B?LzdSRnNRYURPNkRZcDFwMHp2aExhY2FQZDYzUDl5Vm1KaXQrVjlxZGRuNWFB?=
 =?gb2312?B?d0x0NXdRc2tIK2cwL2lQM2ttMzhNQ2hBSnRDVldJUWpDUG1uMEdJRHZMMlp1?=
 =?gb2312?B?MXU4aDdMendJVlBmdld1OXRCai9qSDhXSyt3ZlhFS3o0VXNQTWZuWnB6dmZ6?=
 =?gb2312?B?N0NGL2VNQm5aNWY5NUlvZzRwaGRRMnBUYUdzUjZ0Uk1pWkNDSWlvNXhwZUdT?=
 =?gb2312?B?eERZWjk5L3BNaDcxZ1lqL2JsZVVnUUhhYW5rdGxLQi8xamF6aEZCbjZCdTZD?=
 =?gb2312?Q?YU295A5AQ1LM40sDl0AC13I4A?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bdd874-71f3-4847-34ac-08dac6c3ce62
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:42:30.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOxKzi6/8coVhggjHdQrPU+PmhaMtCamgQl0rl0k2j5vxVBVWqgYkdxo13eYHPAfvWnq1Fge/L1EbJYO+pOE8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UGluZy4NCkFsbW9zdCBvbmUgbW9udGggcGFzcyBhd2F5IGFmdGVyIHRoaXMgcmUtc2VuZCBvZiB2
NCBzZXJpZXMuIA0KQW55IGNvbW1lbnRzPw0KDQpUaGFua3MuDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTZW50OiAyMDIyxOoxMNTCMjTI1SAxNjowNg0K
PiBUbzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtk
dEBrZXJuZWwub3JnOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBraXNob25AdGkuY29tOw0KPiBrd0BsaW51eC5jb207IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY0IDAvMTRdIEFkZCBpLk1YIFBDSWUg
RVAgbW9kZSBzdXBwb3J0DQo+IA0KPiBpLk1YIFBDSWUgY29udHJvbGxlciBpcyBvbmUgZHVhbCBt
b2RlIFBDSWUgY29udHJvbGxlciwgYW5kIGNhbiB3b3JrIGVpdGhlciBhcw0KPiBSQyBvciBFUC4N
Cj4gDQo+IFRoaXMgc2VyaWVzIGFkZCB0aGUgaS5NWCBQQ0llIEVQIG1vZGUgc3VwcG9ydC4gQW5k
IGhhZCBiZWVuIHZlcmlmaWVkIG9uDQo+IGkuTVg4TVEsIGkuTVg4TU0gRVZLIGFuZCBpLk1YOE1Q
IEVWSyBib2FyZHMuDQo+IA0KPiBJbiB0aGUgdmVyaWZpY2F0aW9uLCBvbmUgRVZLIGJvYXJkIHVz
ZWQgYXMgUkMsIHRoZSBvdGhlciBvbmUgdXNlZCBhcyBFUC4NCj4gVXNlIHRoZSBjcm9zcyBUWC9S
WCBkaWZmZXJlbnRpYWwgY2FibGUgY29ubmVjdCB0aGUgdHdvIFBDSWUgcG9ydHMgb2YgdGhlc2Ug
dHdvDQo+IEVWSyBib2FyZHMuDQo+IA0KPiArLS0tLS0tLS0tLS0rICAgICAgICAgICAgICAgICst
LS0tLS0tLS0tLS0rDQo+IHwgICBQQ0llIFRYIHw8LS0tLS0tLS0tLS0tLS0+fFBDSWUgUlggICAg
IHwNCj4gfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgfA0KPiB8RVZL
IEJvYXJkICB8ICAgICAgICAgICAgICAgIHxFVksgQm9hcmQgICB8DQo+IHwgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4gfCAgIFBDSWUgUlggfDwtLS0tLS0tLS0t
LS0tLT58UENJZSBUWCAgICAgfA0KPiArLS0tLS0tLS0tLS0rICAgICAgICAgICAgICAgICstLS0t
LS0tLS0tLS0rDQo+IA0KPiBOT1RFOg0KPiBSZS1iYXNlIHRvIDYuMS1yYzEsIGFuZCByZS1zZW5k
IHRoZSB2NCBzZXJpZXMuDQo+IEJUVywgdGhlIGZvbGxvd2luZyBQSFkgY2hhbmdlcyBbMV0gaXMg
cmVxdWlyZWQgd2hlbiBhcHBseSB0aGlzIHNlcmllcy4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZw
YXRjaHcNCj4gb3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGY292ZXIlMkYx
NjY1NjI1NjIyLTIwNTUxLTEtZ2l0LXMNCj4gZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5j
b20lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnoNCj4gaHUlNDBueHAuY29tJTdDODBi
NTBiMzc4OWY5NDMzZjYyZTAwOGRhYjU5OThhMDklN0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODAyMTk2ODI5ODI2NTA2NyU3Q1Vua25vd24lDQo+IDdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aQ0KPiBMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWo3ME9S
TktCdlRDald0SnpTMzc1DQo+IFR2dVFmQ0dyVlJRTmJ4UyUyQmhyR0kwWkElM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gDQo+IE1haW4gY2hhbmdlcyBmcm9tIHYzIC0+IHY0Og0KPiAtIEFkZCB0aGUgUm9i
J3MgQUNLIGluIHRoZSBkdC1iaW5kaW5nIHBhdGNoLg0KPiAtIFVzZSAiaS5NWCIgdG8ga2VlcCBz
cGVsbCBjb25zaXN0ZW50Lg0KPiAtIFNxdWFzaCBnZW5lcmljIGVuZHBvaW50IGluZnJhc3RydWN0
dXJlIGNoYW5nZXMgb2YNCj4gICAiWzEyLzE0XSBQQ0k6IGlteDY6IEFkZCBpTVg4TU0gUENJZSBF
UCBtb2RlIiBpbnRvIEtjb25maWcgY2hhbmdlcy4NCj4gDQo+IE1haW4gY2hhbmdlcyBmcm9tIHYy
IC0+IHYzOg0KPiAtIEFkZCB0aGUgaS5NWDhNUCBQQ0llIEVQIHN1cHBvcnQsIGFuZCB2ZXJpZmll
ZCBvbiBpLk1YOE1QIEVWSyBib2FyZC4NCj4gLSBSZWJhc2UgdG8gbGF0ZXN0IHBjaS9uZXh0IGJy
YW5jaCh0YWc6IHY2LjAtcmMxIHBsdXMgc29tZSBQQ0llIGNoYW5nZXMpLg0KPiANCj4gTWFpbiBj
aGFuZ2VzIGZyb20gdjEgLT4gdjI6DQo+IC0gQWRkIFJvYidzIEFDSyBpbnRvIGZpcnN0IHR3byBj
b21taXRzLg0KPiAtIFJlYmFzZSB0byB0aGUgdGFnOiBwY2ktdjUuMjAtY2hhbmdlcyBvZiB0aGUg
cGNpL25leHQgYnJhbmNoLg0KPiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgICAzICsrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaSAgICAgICAgICAgICB8ICAxNCArKysrKysNCj4gYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgICAgICAgICAgICAgICAgIHwg
IDIwDQo+ICsrKysrKysrKw0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAt
ZXZrLmR0cyAgICAgICAgICAgICAgfCAgMTMgKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpICAgICAgICAgICAgICAgICB8ICAxOQ0KPiArKysrKysrKw0K
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyAgICAgICAgICAg
ICAgfCAgMTIgKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5k
dHNpICAgICAgICAgICAgICAgICB8ICAyNw0KPiArKysrKysrKysrKysNCj4gZHJpdmVycy9taXNj
L3BjaV9lbmRwb2ludF90ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4g
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIzDQo+ICsrKysrKysrKy0NCj4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYyAgICAgICAgICAgICAgICAgICAgIHwgMjAwDQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gKysrKysrKysrKysrKysr
Ky0tLS0tLS0tDQo+IDEwIGZpbGVzIGNoYW5nZWQsIDMxNCBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkNCj4gDQo+IFtSRVNFTkQgdjQgMDEvMTRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2ll
OiBBZGQgaS5NWDhNTSBQQ0llIEVQIG1vZGUNCj4gW1JFU0VORCB2NCAwMi8xNF0gZHQtYmluZGlu
Z3M6IGlteDZxLXBjaWU6IEFkZCBpLk1YOE1RIFBDSWUgRVAgbW9kZQ0KPiBbUkVTRU5EIHY0IDAz
LzE0XSBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIGkuTVg4TVAgUENJZSBFUCBtb2RlDQo+
IFtSRVNFTkQgdjQgMDQvMTRdIGFybTY0OiBkdHM6IEFkZCBpLk1YOE1NIFBDSWUgRVAgc3VwcG9y
dCBbUkVTRU5EIHY0DQo+IDA1LzE0XSBhcm02NDogZHRzOiBBZGQgaS5NWDhNTSBQQ0llIEVQIHN1
cHBvcnQgb24gRVZLIFtSRVNFTkQgdjQgMDYvMTRdDQo+IGFybTY0OiBkdHM6IEFkZCBpLk1YOE1R
IFBDSWUgRVAgc3VwcG9ydCBbUkVTRU5EIHY0IDA3LzE0XSBhcm02NDogZHRzOg0KPiBBZGQgaS5N
WDhNUSBQQ0llIEVQIHN1cHBvcnQgb24gRVZLIFtSRVNFTkQgdjQgMDgvMTRdIGFybTY0OiBkdHM6
IEFkZA0KPiBpLk1YOE1QIFBDSWUgRVAgc3VwcG9ydCBbUkVTRU5EIHY0IDA5LzE0XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNUCBQQ0llDQo+IEVQIHN1cHBvcnQgb24gRVZLIFtSRVNFTkQgdjQgMTAv
MTRdIG1pc2M6IHBjaV9lbmRwb2ludF90ZXN0OiBBZGQgaS5NWDgNCj4gUENJZSBFUCBkZXZpY2Ug
W1JFU0VORCB2NCAxMS8xNF0gUENJOiBpbXg2OiBBZGQgaS5NWCBQQ0llIEVQIG1vZGUgc3VwcG9y
dA0KPiBbUkVTRU5EIHY0IDEyLzE0XSBQQ0k6IGlteDY6IEFkZCBpLk1YOE1RIFBDSWUgRVAgc3Vw
cG9ydCBbUkVTRU5EIHY0DQo+IDEzLzE0XSBQQ0k6IGlteDY6IEFkZCBpLk1YOE1NIFBDSWUgRVAg
c3VwcG9ydCBbUkVTRU5EIHY0IDE0LzE0XSBQQ0k6IGlteDY6DQo+IEFkZCBpLk1YOE1QIFBDSWUg
RVAgc3VwcG9ydA0K

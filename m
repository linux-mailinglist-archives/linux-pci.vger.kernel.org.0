Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D641D54D847
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 04:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356791AbiFPCYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 22:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358040AbiFPCX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 22:23:56 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF04C413;
        Wed, 15 Jun 2022 19:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbEAbol3UvExfyK25gI8/YZtWmdBMnB9UHtWFu/TUyTOGYWkq62ovomuGJaE+Ikhylk6Tmm7NE3vLLyUgWIKW1rILQ1j1xdqYH8MUw9eYY7ETdL1llEChZdraXmJlpfAyzKoaacUy6mlID9CpQFQ0iK0U9ZUb6A7P29CJQD8meeOYaMEMx9kVKLlzEQ3G2NOlNfIeQh8h6Pgmjs9I7yaRW2U4R9LrWtly+XnMwvOaCF2a2W1dsfoiAgRTZfHAqbeUMolARCrurGBAcVyRuntGh3AI5nb5D7t5kLnvhB4NlqMSjpIzmjJBGYKCgQA7FKu6LwiKzxTtFjvyLp3ge1Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noUTZf8oy0Mz3o6Uw7ODvSP5Hv2zL4/hNNnRKKUemFQ=;
 b=dDRIKGNGlp7+fQUaJTugUFL5YDpV3e/HYM/IQYscxK1Mr7ZUbCTVIY9ZJc6D6fhY9rjFJxX9N5k72E7LtBvSwhKI2VIQbcowkqh1bC2AF+XcE9521zRJh5xjOjyFrdObuPaWLe7eE7/NlIR+kCp7qFD0qs26CzsKZ744UHlqnF/zhU46+H1K5mufZHX+ryI1LdZzJAs1vWIvYrvxgYC/KD4mHPV98+qKuHrEpHmNRY0LT34idMztYEZa48TPhGm+Y2uY2VMZXbqlFPso4T7CKDYSqda6jJ2DkDa0QrsGjvs+AxMhAEgWZ7wYjtD6T9FfN0XXjG0PUn04mke5sHZs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noUTZf8oy0Mz3o6Uw7ODvSP5Hv2zL4/hNNnRKKUemFQ=;
 b=YnBVLkXdgJY9uFrZM8wY/MODzlNxhrpGQrKupQvJ/10QXn5Jo4FwfNNDYB/BL1pzB5V+hTiFRwFFOlLvvGH7bHFHVAubQfv9OszFZ09tv6LbSlRqOybb3pKmV7OcaEnM2k9S73XV1TsVxTkf5yfjpchPg0CA6i3fwCp1tOI8YZM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2474.eurprd04.prod.outlook.com (2603:10a6:3:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 02:23:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:23:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v12 05/13] PCI: imx6: Factor out ref clock disable to
 match enable
Thread-Topic: [PATCH v12 05/13] PCI: imx6: Factor out ref clock disable to
 match enable
Thread-Index: AQHYgQ3qNT6xfEk2KU+Z5vMufMo5wK1RRF/w
Date:   Thu, 16 Jun 2022 02:23:50 +0000
Message-ID: <AS8PR04MB86764A41C3C11A52DA064B618CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220615231551.1054753-1-helgaas@kernel.org>
 <20220615231551.1054753-6-helgaas@kernel.org>
In-Reply-To: <20220615231551.1054753-6-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e72d81-6b8e-4a90-4a2f-08da4f3f407d
x-ms-traffictypediagnostic: HE1PR0401MB2474:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB2474660613464D9A1C5C3E9E8CAC9@HE1PR0401MB2474.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dq6Lt/UaedOEuF3SZoM0Tn2xaunRz1Va7VyukhufceIkFfIR8pbKLQZosweyZuAVJNgG5IaTp9DrvmYUrW5xUVgcfCSPMJbRvepE6kXGDU9Zg5m3A+07133Pzmm4G+0QEyk5RAYY7Wtfm5hFY1laiYoNiM7b0beGoRxTELVeG2BIovAaFg22Fdit8AVyk/xcQUVKN/DUFnJ1mZqEQyVTt+Wme17h0IgEoF+Bm9hUwNOpUs3fvUzH9eouDLnHLYZ44KHAWuPkTflBizfzD/xurcyX0bKrlPmnqhLloWS84xsbqROM0KwLV4veHzx6j2YKNjzwldynbmDG1uBiW78ZiV9YrkydvDpoe3fsGhgDP8YH6MONWaSTo0oQTl59SLfUUYmJ+zvdYfisy/pSwO2hD3X9W967INW4LXCfC4Yvd9ybGFMLuw4OA/ZoFS0ShF4wI5aeAkvHgsINzfiTBhsLhyDEdrWyw4ZA0MfnPYsuBJhsaAsGARQb5bK8Ebtu49ZAaOsUdN0fjKBYkruQx/TKUetri6eIUvF6uxNsp0hW+rEueOwfgc26XjqVsjbjdnVHKErewgvpEfnLdepSkFU6rPv9yTaNKmDaxJM/4+NccnSogbRXARierZubBUz3X8ygVHrryQliVnsXS5f8QXV2eI9Rv99LZEN74cBjV9xz9PhX9sCxHIdUU31QcFzys7ckGGMtwwOLYAokhkHwRGchxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(26005)(6506007)(86362001)(52536014)(508600001)(8936002)(53546011)(33656002)(7696005)(9686003)(7416002)(5660300002)(44832011)(83380400001)(38070700005)(64756008)(66446008)(186003)(122000001)(55016003)(8676002)(66556008)(66476007)(4326008)(54906003)(66946007)(110136005)(316002)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z2RJSHlQN1BmSFNLekc0Y2EvbUY1UWJvc1FiYlZCN1Q1TDVKWE1JSjdyMzZu?=
 =?gb2312?B?QVNiNUc0RVdmcTFjdW0zcFE4TjFKRHBSWTAvNEJTTThmM1FWcFVvUDFMN0hL?=
 =?gb2312?B?R2NaL2ZuY1FiQTNZSThwcDVGQnVTVDRtakc1R3VpTlhRbUNoZjVoSjFjaUM0?=
 =?gb2312?B?YnNiM284UzhscDltVVR2dzhRNUQ0UXJ6UzFacHFZMUFvMk9icjNHb1J6eGgx?=
 =?gb2312?B?YmMxbG9zQ3ozTFMxaE8xYWNaUy8wbU0wZldOZkhqc05vWC9MZGp2aHZOTHp5?=
 =?gb2312?B?MWtoQk1KS3dVTXdLeW1aWFdUODhEbHF1V09JNUJRRlpnaGdLTVY3MWg3dFZE?=
 =?gb2312?B?eHA2WE1iYlRYRFVmZmppWjFtM0hsVEg2cTQ0MUp4bk51NnpGcUlJRHVWU3pK?=
 =?gb2312?B?NWtyQTlYcFNnVlZocHR6djRCTThJb2p3dmJjYzBGY0htV0daRXhOOFhFem1Y?=
 =?gb2312?B?eEtTL25BcEtmalA2Zlh6OVBkSHgyMWFKTU10TTV1MDY4RmxIaWo2aG1tNUdZ?=
 =?gb2312?B?cDB6T0RSclBsTjVSS25hQzB4NzFYR010SzNZZjhXdkdDbGNBRkFZVXc5WEZE?=
 =?gb2312?B?ZmlqRm9kZGlLYUhiRmoxTHl4MGpseldiRmMxSi9DZ0lzUXpNcnh6Sy9FWG9B?=
 =?gb2312?B?MWNZRXhZSitYZ2tTSERuSVlHUnhRVlpjWDhMc1I5YnorZmUvNXFuL2E0OHBV?=
 =?gb2312?B?YktXdU5YbjViZldiWDBBTVUyckhPejBwNlNFbnFJMkpDMUp0V3lRMEdmRkk0?=
 =?gb2312?B?dTcvaWN0UlNmT1I5dzFScjRYWU94TmhDTy83SkNLWUwwTWRXWnlDY29OVEJQ?=
 =?gb2312?B?ZUdlYXBFb0J4UmFSTXZIMVdyYTFFeXp4Q2NYdEphN0wvV3RmMUtQMlg0MVFr?=
 =?gb2312?B?NkJnMkJFbVRsSmJiVURTV1AvVmpkbE9jbEJLRmZENS9iRTFvOTdNU28rNnRs?=
 =?gb2312?B?ZmJTUzZOVXg1aXoyV0NJeU1DWmNkTTJlcERBNnBaUWxKcm0rTERORUNRZ2pT?=
 =?gb2312?B?T1oxSEJWQThQNXpoaHlUQzV1RlV2ZTc4RStXc2p3UzlYUTYzMWhCMDZZQjRw?=
 =?gb2312?B?Ulkwc3JUSzgwYmtvSWZUOVZpd2s1NFcyN2VKaytVeThOZlFNRmtaL1I2RHZv?=
 =?gb2312?B?Ym9aVTJiM3VxK3JuRnVwaFVMYjRNOHRFeTQxbk9aM2hrckNjYXBDdk52aG04?=
 =?gb2312?B?V0xxekFFbjZ2RzljeFR1dEtkSGJFbGZPVW1ZY0E1clF3b3luV3E1ZkVUNEdZ?=
 =?gb2312?B?UEJOQ0IwQUZmOSs5Y0JmWHdaTGNmYk9QUEE5L1JVWXFncUVMSmtwY1VicERS?=
 =?gb2312?B?dys2TlVBMVp2ZDZxQVdGUGlCa2t1dVNNenRnNGtqOU1oZFRmaGpWektETmp6?=
 =?gb2312?B?a1BtZGdQRGtkM3p4bTJJUjEvR0xiYUVzUFlJY255RC9uaUJhWC96TVRiWk5H?=
 =?gb2312?B?YkhKaWRPRzZCVXljT1hoQ21xSU9CM2p1ZmFmbFp3dFRoVGJzNmtHQi8wTlc0?=
 =?gb2312?B?ZmV6U21aaEtHbXJnOEhTeWxIaEFDMDBCUGZaNWhBMkh5VWdVcWlIVWdyRnBN?=
 =?gb2312?B?TzZ2Q2JxY2tTWUZpVmgxQUpMT3MxQzBQNFFzTVdEdnFEWER3RkJsR09yZVVn?=
 =?gb2312?B?dkprejlhM3B5aUh3N094cHBBTm9iaXhRRDB1Y1NuZ3BwVGFBcVZPeEdOVmNO?=
 =?gb2312?B?SUhZS3BiQ3NCelM4YitVZkxlZmlTUzVpL3Zhenl3b0paUFRZNWdNSG5sVytB?=
 =?gb2312?B?ekJDdk10YXFVaWJrWVkyM0d0ODUycUw3R1BLbnRCb1U4Zkc3aVFEcGtvWGZz?=
 =?gb2312?B?WVpGVUZtcTlLK1FiQ01tM0NQeWszbmtxK2VvRHFVeXU3K1BpV3ZmQUhXSWoy?=
 =?gb2312?B?SUVqVVJPVUNITlByekUwOXhVS2Q2czVkTSt1b3MycHlOTUlzQmFiaTFhOGhG?=
 =?gb2312?B?S1VNdFVuWjBUdmpINnIraHR1WHhGMVQ5bVVGZmcyNUJsQVV6WGpGUVoxK0dv?=
 =?gb2312?B?V01TKzYvNzZ6aU9GUHh1SC9YVE5KVEc0Sk5ROXR3bDNpR21hVWZWd2hhK0hr?=
 =?gb2312?B?dHhjQnpzbDJMOWs4TjdSN0xIQXY5cTl1WGs2MHNhZ3BrWE9RVDNuTnR4azNy?=
 =?gb2312?B?aDZSTXM5Q2xxVjVBQzY2NEF5NS9mUXYrejZ6ajM5WDFYaDQxSzdWLzJQbjBH?=
 =?gb2312?B?dG81VXA5aVZvb2FWUkpNUW5xaTQvQjdUaDhiY1JvNkRLcXE5ak91Rml4YUlo?=
 =?gb2312?B?VlF3M2RkckFxWnhHc3pUamM4RWVQd2JCT1Jia0tZcnpCN2x0Y0hSRGY5My9V?=
 =?gb2312?B?RU5hZDhCRExLSkR3Zzhaa0VXSjE0K3IxVlJpaExlaXpGQkFrd2ZWZz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e72d81-6b8e-4a90-4a2f-08da4f3f407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:23:50.9364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoKvlSMrY9vK1hXbwkMkiWKcAouSlxt2nLDyfdjtbfjI72s9hDTyMtw+YSmqecvYE0vAX3XZrIe9SdfAecfmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE2yNUgNzoxNg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgQnJv
d24NCj4gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
RnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjEyIDA1LzEzXSBQ
Q0k6IGlteDY6IEZhY3RvciBvdXQgcmVmIGNsb2NrIGRpc2FibGUgdG8gbWF0Y2gNCj4gZW5hYmxl
DQo+IA0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiANCj4g
VGhlIFBDSWUgcmVmIGNsb2NrcyBhcmUgc3BlY2lmaWMgdG8gZGlmZmVyZW50IHZhcmlhbnRzLiAg
VGhlIGVuYWJsZXMgYXJlIGFscmVhZHkNCj4gc3BsaXQgb3V0IGludG8gaW14Nl9wY2llX2VuYWJs
ZV9yZWZfY2xrKCksIGJ1dCB0aGUgZGlzYWJsZXMgd2VyZSBjb21iaW5lZCB3aXRoDQo+IHRoZSBt
b3JlIGdlbmVyaWMgYnVzL3BoeS9wY2llIGNsb2NrIGRpc2FibGVzIGluIGlteDZfcGNpZV9jbGtf
ZGlzYWJsZSgpLg0KPiANCj4gU3BsaXQgb3V0IHRoZSB2YXJpYW50LXNwZWNpZmljIGRpc2FibGVz
IGludG8gaW14Nl9wY2llX2Rpc2FibGVfcmVmX2NsaygpIHRvIG1hdGNoDQo+IGlteDZfcGNpZV9l
bmFibGVfcmVmX2NsaygpLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0K
QWNrZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMgfCAxNiArKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiBpbmRleCAzOGYyMDhlZWEyZDcuLmY0NTg0NjE4ODBkYyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC01ODAsMTIgKzU4MCw4
IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKHN0cnVjdCBpbXg2X3BjaWUN
Cj4gKmlteDZfcGNpZSkNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gLXN0YXRpYyB2b2lk
IGlteDZfcGNpZV9jbGtfZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ICtz
dGF0aWMgdm9pZCBpbXg2X3BjaWVfZGlzYWJsZV9yZWZfY2xrKHN0cnVjdCBpbXg2X3BjaWUgKmlt
eDZfcGNpZSkNCj4gIHsNCj4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2ll
KTsNCj4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX3BoeSk7DQo+IC0J
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiAtDQo+ICAJc3dp
dGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gIAljYXNlIElNWDZTWDoNCj4g
IAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9pbmJvdW5kX2F4aSk7DQo+
IEBAIC01OTUsOCArNTkxLDggQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Nsa19kaXNhYmxlKHN0
cnVjdCBpbXg2X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4gIAkJCQkgICBJTVg3RF9HUFIxMl9QQ0lF
X1BIWV9SRUZDTEtfU0VMLA0KPiAgCQkJCSAgIElNWDdEX0dQUjEyX1BDSUVfUEhZX1JFRkNMS19T
RUwpOw0KPiAgCQlicmVhazsNCj4gLQljYXNlIElNWDhNUToNCj4gIAljYXNlIElNWDhNTToNCj4g
KwljYXNlIElNWDhNUToNCj4gIAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNp
ZV9hdXgpOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiBAQCAtNjA0LDYgKzYwMCwxNCBA
QCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY2xrX2Rpc2FibGUoc3RydWN0IGlteDZfcGNpZQ0KPiAq
aW14Nl9wY2llKQ0KPiAgCX0NCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY2xr
X2Rpc2FibGUoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSB7DQo+ICsJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZSk7DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlt
eDZfcGNpZS0+cGNpZV9waHkpOw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUt
PnBjaWVfYnVzKTsNCj4gKwlpbXg2X3BjaWVfZGlzYWJsZV9yZWZfY2xrKGlteDZfcGNpZSk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1
Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpICB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gaW14
Nl9wY2llLT5wY2ktPmRldjsNCj4gLS0NCj4gMi4yNS4xDQoNCg==

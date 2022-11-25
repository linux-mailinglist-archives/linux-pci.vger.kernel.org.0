Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78663823B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 03:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKYCHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 21:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYCHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 21:07:23 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C5248FC;
        Thu, 24 Nov 2022 18:07:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhy5Of4YUwFO61kwy8DbhI8fxdn4P7F6BnKaBEKVpm1ntciSXmt3KEOW32UEqMydlR9j5E3rn4/ar0aWKAg5mopucvlWn5ZDDIhXBsxs9A1PYox4+VGQlTHWc6MCOoWXPh9WfqlNbGDoaYa6wXy/txhmhuuNVOUVWsCVEk/NA3cmQ15HcGO+OJYYLM/D/u2wjg2ZSRDXzPr8TceYo7Lbl/Pb50r71QxF77RCO7tjpvGybmQAFlEOQMQsEoR4Pud/fnxJfHpyAPiN7k8G2993oRHEUgqe+DeghAlterEGfan0oqkNLdZKmIQG/No4ZUZbmjI/kxbk2qmgFQdzc+H9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIc4y+SZnmNbwuIq+8WaXjfoDUgb1xRDe4ByXbsecYw=;
 b=OoWHXmGHxTZzvAWyYBmG8VhuXQKOU1fQeUt/BhTU3OpHHyWHHRSLpuK5BTKTdTWMM7IrVpzwLSRoPjlYRwUARZjXGdUkmQcNxI6cb3ugodISPoZBv7zL1TRNXjbwN+bFnxsngoDzJ3u4XAXKy0VKKqZof60qaW8OL6YRYxZ8jZt6aupDfERaH8kauFN3gpP+2uJLo8B6b/I6LjvXF0BV6TLajtQyQpbrgur0I3D29qjdkPqKuUg9Cy7s2SaM5lRWDhpxP5VKhmkOike0wQd75oGo9XWyiqa4c1wpIe2GA5fHccCMIPKtSPFQ+mk2D2L5DC4nYzEwIosf0NU+XkMRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIc4y+SZnmNbwuIq+8WaXjfoDUgb1xRDe4ByXbsecYw=;
 b=hPshWocZRGhwcHhTVqeVO5tCjvozgQIa8+QkO3LsKv7aymr3Ecy5lwNIDWYpeiB9Uxp+tAEORBORBhzeXb3266Uf72+61WXX3CkOzoF/It/rV84Z7+dHgeMFxUmTDDlgf5mLyUnV1lsSjqM/YA9z0rZCz+nXWvy9rgP60z8QoTQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 02:07:19 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 02:07:19 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Topic: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Index: AQHY7crVp6JPT10pBkes7VgrUc48l65PCPbw
Date:   Fri, 25 Nov 2022 02:07:19 +0000
Message-ID: <AS8PR04MB8676A61A8C554EB0F0162C998C0E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB9110:EE_
x-ms-office365-filtering-correlation-id: 1752f76f-5f32-412b-3daa-08dace89c838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /b7FcqavNzvd+dX55f3YNzM3c2fRrM6s8mgZTaB+DeaDXledKmmiY2NSRureUlDerqKaK0sOyhZXfzAcVv4YSq61Kaun+a+8DoqkgjSzo0xeaNvkmIEeaYQiRjvZUNEbtxO0uZPQbLkRsoAQE6URtEnfMCzFp+uEfNexXIMzRoko+pwZdlKjvPF8ficc/J/WJz/qLNBnaRlDLFOF0ZRN03aWLWeXNO3K8Vw6IiT7x7tNfoxVSYSEsfmo0FSTYfT9cE9ctHo5/0NDSgJRmeAzp03/VWNL3U8aSN4jL1CxkFauwtCmfGgp3kSwG2lWDRqfm6QmOp/U2qu4G9rOxnp8bFfgwtZliwIZigX1BXoifnF1p2rL+1KBDmzkHKl3258Mr+viG0o38j3CYJonWpe7g9hx0YU2cmzJ5G8OjxCCgOHn6Q/PTn+VRKealdUYtJneW9TP92SJOTPSWWWrlBRKvWW2JJeNWwFT3OsNUskV+QEZiqAGjnInH0fWAJlONRBWg/BMW4HZZN92wrj+nMGKrTYBwDrwYNPHZGcI7+jXU/jNZcO493VeL2gJqKF13z1ZjL3D6o05Ig/w999xqZVJ/gaxI7p0Vp+4l0B/7W1F22NcHOQiwXVMuHrgVRj6vq0u5PciQP0jE54CY12h22uR5BKDB+aQjugnFMLSEhs59o+8cfrUHeeykkJCJlPWEhWKKlCNIxLIwALtwqEdpMehIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(316002)(9686003)(26005)(33656002)(186003)(478600001)(54906003)(110136005)(71200400001)(7696005)(6506007)(53546011)(38100700002)(122000001)(55016003)(38070700005)(86362001)(83380400001)(66946007)(66556008)(66446008)(64756008)(76116006)(8676002)(4326008)(66476007)(44832011)(52536014)(8936002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M05FUEgrR2RMVFVzVUl1UVlERVNob1FqYUdvV1IxMElyL013VGd3VDlzZUdM?=
 =?gb2312?B?MHh4OWpSbm9aTjhGTHdqTXB3bzRFeGZRN2o2SklYY1pKWVVXM2I5akRUZ0ZP?=
 =?gb2312?B?QlBldzErZXEwN0lqQ2JDWElxZUh3WGFKcEphbVRZRlBIaG5vVFdWWEZzbGU3?=
 =?gb2312?B?dmNVT2w0c01WWWFGbW9nSWZ4YkJHY3dpYzZ6OGxOUTRuczI0cmVqcVBoQjB2?=
 =?gb2312?B?WTdUZlZNZGVoZzRzYmN6QmhET0NPZUU3RHdob3drNnRKUmg0ZGpORGxjWlB6?=
 =?gb2312?B?blEwQldHNG9TSEVGVkhkNHlmRWRZNkp3REVZK1VyaS9LVkgxNi9Fd05KM0N0?=
 =?gb2312?B?RkhSRDJRVFVUWjdtVUI1cHI0OUx1b3ZmZzdsNHdMVjd1bk9ESG5lQ00rNng1?=
 =?gb2312?B?VUtodmVvUlFibXArNS9paUU2Z3Y1bjVpVjh1NkxzK3paQlovZ3NROFlzTmNE?=
 =?gb2312?B?NVFLeGhVZCt0RDlmU3BVLzI2TldHVVd5aVgvekh6YjVsL2VYOGUwUmVKaFE2?=
 =?gb2312?B?Rm95bm5MNGQwZFVXREIvYlBSMnowR3FETWwxejVKeG56YytXS0l3SDB6UjBx?=
 =?gb2312?B?Kys0eFlBOUlmK0tZbXVhUDdKSDZEWGF3b0E3Sk5lTytUUFMwdi80ZUhhN1Ev?=
 =?gb2312?B?T0lndkczN1RLNEdOVjVtTFN2RSsvZ0IxZjdaM0hZbGFoVml6T2UxQWxjcncr?=
 =?gb2312?B?ZHhWY0xzOWt2MnVCY2hGQUpWdkJ0aS9nM1Q1ZndWNllTSnFhS3RLZDBacWtM?=
 =?gb2312?B?QmNjMVFSNkdkTGNNWi91dDdlTWVWbnFLZGZuYXJNdkFZbTlYYU40d3ZLNFRo?=
 =?gb2312?B?cHVZcU5LWXgxUm5ya3k2dFBuR1JaYjZoVkdvUWZNYUF3MHRMQzFsVUdVd3FO?=
 =?gb2312?B?YnJiY1pTd1NramtKdG5ST1g5TysvblptbDA4Tk1DRkk0RTVNUTUrU2ZjYmZI?=
 =?gb2312?B?UEpxTEtWd3JwVFNJWVd3VFFkMjJncGE0bEFTdDJCNnVSVnBUaVQ4Z1AvY1Bj?=
 =?gb2312?B?M1VUR2VWa0tQUm1ZUitmREtiVks0MmlacERKVU1hUnZiaFo1c08rS2VsY2Ro?=
 =?gb2312?B?L3pPK2p2UTFLSjlkSmJOOCtJY29pZG9qb1ZwOTZlYXFOdFA0emZDdm9KNVpP?=
 =?gb2312?B?TVgrQVFtNkx0VW5WelJLT1c3elV6eUdUUGNrRVRpR3gxYms0ekN1WDUyenZQ?=
 =?gb2312?B?WFJ2WjVzR1A1ZDl1WkRWUUNPRDc0cjhiNUdtRVBPTE5VanRaclFnS1pRNWE1?=
 =?gb2312?B?ckdvUVRuOHdLYkJJWVd5ZFhvZ0ZNdXpGWW8ySnhiR20vNkFZeUtUYTJ0NzhB?=
 =?gb2312?B?RnFtWmtzdGlXZ1VBRFgvSThrTTF3aCtvT2hYbFVTYjAwUnlhaDg2UE1uN2VR?=
 =?gb2312?B?MSsrck5idE1EMGdRZGNXL1lRN1MyQkhqVFhDYm9aa0hKbXpNZVIrWG1EMThY?=
 =?gb2312?B?cTZKc2xHaGxqRmdPT25EV0EzbVB2QVovZEQ1cE83WC9YWUY1Q1VNN1FlZUNY?=
 =?gb2312?B?bVp4NU84S1UyZ0pSemFkL0Vib1B6WTc5YzBHZ0diQU1ZblVtampvWExtc1Rv?=
 =?gb2312?B?Y2g0Ymx0WmtWYnlRMThnYjlGUTlIRXAzWWljNjMxWmdkemlvRDUzSC9HWUJx?=
 =?gb2312?B?dzM0YXBaeXF4ZTdDbGNzQUhBdXFucWEvQlR5ZzNhdVVNb2E4RmJISEFlL0xH?=
 =?gb2312?B?WmxzL3lFaU80b2NMUVRFOFZLZHVIVHg2ZDJuQlN2TDVqbVFHLzZPMmRDT0pZ?=
 =?gb2312?B?YmZZdGZqeDBRbkFSMmIvQXU5bHBWVzNrQkNsRmI5aWU3NUh0ZG5FdzlFZTZx?=
 =?gb2312?B?S1JjUFdRVElYQzVsa0lLWEk5b1Fubi9DRWlXTnpIMGtvK1ZCVTJoYWVlNk1t?=
 =?gb2312?B?MkRiZGtaYXFVS2ZRMGJ6bkErcnhPajBVQkNmVnJHQSs0R3JkSEZkUzJUOERX?=
 =?gb2312?B?TDZGYk1vanJobGFaNThMK0F2WXJ1UzhjMUorSnBlNnhEMmFmS3ppYXVKdzNB?=
 =?gb2312?B?dnVmUUszQ1pRbmFkOEZKZFlLV1FFZ3JIMEQwY1lkcDh0bHVKRWpycCt2VEp0?=
 =?gb2312?B?S2JTQzdIdktNWXJBT0V6SFNOL1p0a2NoT2FHSEFvM0IwNEgweitjY3pkTjZp?=
 =?gb2312?Q?owxZ1E1tBDURpkUsVJj3+V/b1?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752f76f-5f32-412b-3daa-08dace89c838
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 02:07:19.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDOK7Q4qJNwupro+k9/G9p3mhGpczxMW/7pLB7VuF3Fc4DIIhxfFuIgvIVweQIE+nM3gNhQ4mdczfgqtO2MVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJpZW5kbHkgcGluZy4NCkFueW1vcmUgY29tbWVudHMgYXJlIHZlcnkgYXBwcmVjaWF0ZWQuDQoN
CkJUVywgSSBoYWQgdmVyaWZpZWQgb24gaS5NWDdEL2kuTVg2UVAgcGxhdGZvcm1zIHRoYXQgTVNJ
IHdvdWxkbqGvdCBiZSBmdW5jdGlvbmFsDQogYWZ0ZXIgcmVzdW1lIHdpdGhvdXQgdGhpcyBwYXRj
aC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gU2Vu
dDogMjAyMsTqMTHUwjHI1SAxNjowMA0KPiBUbzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjFdIFBDSTogaW14NjogU2V0
IE1TSSBlbmFibGUgYml0IG9mIFJDIGluIHJlc3VtZQ0KPiANCj4gVGhlIE1TSSBFbmFibGUgYml0
IGNvbnRyb2xzIGRlbGl2ZXJ5IG9mIE1TSSBpbnRlcnJ1cHRzIGZyb20gY29tcG9uZW50cyBiZWxv
dw0KPiB0aGUgUm9vdCBQb3J0LiBUaGlzIGJpdCBtaWdodCBsb3N0IGR1cmluZyB0aGUgc3VzcGVu
ZCwgc2hvdWxkIGJlIHJlLWNvbmZpZ3VyZWQNCj4gZHVyaW5nIHJlc3VtZS4NCj4gDQo+IEVuY2Fw
c3VsYXRlIHRoZSBNU0kgZW5hYmxlIHNldCBpbnRvIGEgc3RhbmRhbG9uZSBmdW5jdGlvbiwgYW5k
IGludm9rZSBpdCBpbg0KPiBib3RoIHByb2JlIGFuZCByZXN1bWUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDI0ICsrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggMjYx
NjU4NWNhNWY4Li5kYmExNTU0NjA3NWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiBAQCAtMTA0MSw2ICsxMDQxLDIxIEBAIHN0YXRpYyB2b2lkIGlteDZfcGNp
ZV9wbV90dXJub2ZmKHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gIAl1c2xlZXBf
cmFuZ2UoMTAwMCwgMTAwMDApOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHBjaV9pbXhfc2V0
X21zaV9lbihzdHJ1Y3QgZHdfcGNpZSAqcGNpKSB7DQo+ICsJdTggb2Zmc2V0Ow0KPiArCXUxNiB2
YWw7DQo+ICsNCj4gKwlpZiAocGNpX21zaV9lbmFibGVkKCkpIHsNCj4gKwkJb2Zmc2V0ID0gZHdf
cGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX01TSSk7DQo+ICsJCWR3X3BjaWVf
ZGJpX3JvX3dyX2VuKHBjaSk7DQo+ICsJCXZhbCA9IGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgb2Zm
c2V0ICsgUENJX01TSV9GTEFHUyk7DQo+ICsJCXZhbCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsN
Cj4gKwkJZHdfcGNpZV93cml0ZXdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUywgdmFs
KTsNCj4gKwkJZHdfcGNpZV9kYmlfcm9fd3JfZGlzKHBjaSk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW50IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikg
IHsNCj4gIAlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsgQEAgLTEwNzMsNg0KPiArMTA4OCw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Jlc3VtZV9u
b2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJaWYgKGlteDZfcGNpZS0+bGlua19pc191cCkN
Cj4gIAkJaW14Nl9wY2llX3N0YXJ0X2xpbmsoaW14Nl9wY2llLT5wY2kpOw0KPiANCj4gKwlwY2lf
aW14X3NldF9tc2lfZW4oaW14Nl9wY2llLT5wY2kpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAN
Cj4gQEAgLTEwOTAsNyArMTEwNiw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJc3RydWN0IHJlc291cmNlICpkYmlfYmFz
ZTsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQo+ICAJaW50
IHJldDsNCj4gLQl1MTYgdmFsOw0KPiANCj4gIAlpbXg2X3BjaWUgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzaXplb2YoKmlteDZfcGNpZSksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghaW14Nl9wY2llKQ0K
PiBAQCAtMTI4MiwxMiArMTI5Nyw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVy
biByZXQ7DQo+IA0KPiAtCWlmIChwY2lfbXNpX2VuYWJsZWQoKSkgew0KPiAtCQl1OCBvZmZzZXQg
PSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURfTVNJKTsNCj4gLQkJdmFs
ID0gZHdfcGNpZV9yZWFkd19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTKTsNCj4gLQkJ
dmFsIHw9IFBDSV9NU0lfRkxBR1NfRU5BQkxFOw0KPiAtCQlkd19wY2llX3dyaXRld19kYmkocGNp
LCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTLCB2YWwpOw0KPiAtCX0NCj4gKwlwY2lfaW14X3NldF9t
c2lfZW4ocGNpKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC0tDQo+IDIuMjUuMQ0KDQo=

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF528343C48
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 10:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCVJHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 05:07:07 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:47877
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229912AbhCVJGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 05:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiMXV6anau7G6xHi3h7pxJtD+b9y+Ku5nRifcC1/NVeK41cchRm5aoDf+mcX0+XThqRbkJ2/Vtc/dDuzUZhTgQse2BOIAk8r1mFZgFR4TRB7ewtmcpSleJ+PqmvnWuqVO/YL1arlDsMzaX6A1Pid3EzfxKpIzdttAsBCasuNpXeIjCI81YweSL8scjVE73bLGcWDkOKFFv5HUz5FMKs6dLyjJs3PUXvA9i/ur6qPEIv6bfkB4Au2V77tDW/undM8HJ4tuwvugANPuyskK9WtsoYUSfyb7uHeuJNG/yYHwBOXHrXgQhBQbe6Xf/fTRePkFQj3/blJCS6++B+oxKZp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvgRJmF9rCN1sHOHZICRAJvNdjA1t476T6yuPDqXAAM=;
 b=K6WUFf/dbj8JXQwJZxXbk1UMCCz3+7gJUpNdszy6AInIJaIOOTNcyMv3doCZ+qWtg1D8vrfO2PXMKPY7AAcqHMHODd59Iyj83qHBY8IGFClWlFA6pocogjeb8XM1UmKiY0Ay/XBdxl1b7zPvF93yah3WwqMaK/Tph6J4ckSIhS7YOos6PRR2l+lmw2SUAJ2QO71D9mMkJ3p2lndWl1bnY6z/yUx+8GuP6cQzn0CLpVXUpPhfCQ7u6lod/p6pGEVcmPbD52kLq4Aelhq40d9Xd/ceihToEUzgOYAiWfMpvSGpOPc40ebjCilb9NW35MNpEsg3gpGm10/SONCmyA5J4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvgRJmF9rCN1sHOHZICRAJvNdjA1t476T6yuPDqXAAM=;
 b=TxWxpj+c5GigpqzLSHjJXfvLS6lprp843smWp0ZLBEMkBXmOURDIFu+uaeQNnjiazgzjxAZ0ZCmNQXyDFq0cQ2UQY+z7cJmmPMUab4l+8APbNW0dfSW4g5aaetvGfYJG1pANorNNjY0J/3NqV1YdiFgnic0X6FaDw7+mqIh8u5w=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 09:06:31 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 09:06:30 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: specify the imx8mq pcie
 phy voltage
Thread-Topic: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: specify the imx8mq pcie
 phy voltage
Thread-Index: Adce+pY+Mc9xWuxGRMWwLYe0hhD02w==
Date:   Mon, 22 Mar 2021 09:06:30 +0000
Message-ID: <VI1PR04MB585364FC420972C538281F2B8C659@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30e7112d-f1c0-4bf5-f79f-08d8ed11c8a9
x-ms-traffictypediagnostic: VE1PR04MB7327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7327D574F7F9F5B6C5F47E4F8C659@VE1PR04MB7327.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ln8ntVEK/hkhrLyLcKYt4iOhgr+s5sgsYtTzfZbnMZTRP8BS/vpgxuqeRCxDQ3mFF73BZhFTfA1SQgEOuvQU8G+3hFRdhrdVSSfKlXJNEhKQieHKLHDqSBNSUrYlGgeR49YFqr8xnYChAweKmVkpqd+TTDXdUNXZ+I90Tc2vGD0RDjuw4wb/vLPVYBgoNfY1SxDuFT9BvvM3t5hDfGs7JPD/06jlzXADCTtAJPsz86hAMvO8z1DPz70cd3Gfrz2GVsfcIJkeEfSsUi1w22/wyUC3wosMIoB54VL1tgbdbZqZfvWutvnpdN4/oKhh12cCkeTTkmMUYujuWM7VdiSO3QKHWWFiR/Hjra6ao74SemFSvOQXffCVoUQEECzNt6JW3BfT0TfA4ocVcPZtdPZ7q8oc1YKP2GpgEx/+mJS8HHHXEKWSG/MVm84Ry2yDys4ydAtJ58HzVbKyNwRwmeryuBvH4QUjRcLWze5i5cRxR8ORN0EVO7q+v8Rv74g2fi9DS4PYK4kBiUIuoBiFQVJfwKooVTxseDXMQ14EmLHIhVrecoB+RC66pWSkvPsznVmtWnMZRU67dFhkKA3suYO0bn4mgD40JbuLP9PIQlxi9GesHZd0JOxIK1iRAbZ852huR65gIh87VxFBHQoHN1mNvBIKOLhkxjdtcQPP4MCWHKvrGKs/LyuL2Hfh2IzSg1FW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(186003)(4326008)(52536014)(2906002)(26005)(66446008)(7416002)(66476007)(64756008)(66556008)(8676002)(316002)(86362001)(8936002)(5660300002)(66946007)(7696005)(9686003)(76116006)(54906003)(110136005)(478600001)(55016002)(6506007)(33656002)(83380400001)(38100700001)(71200400001)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wkp6cFI3ZGdicStEaW5xcWovS0FhRkZKdjVtOXFPUFlFam9TaVVTUXNyVWw4?=
 =?utf-8?B?MEhoaGxNck54MkRrUk5rczhONENaZkkwVzJ1WXJUekNhRUI3ZWNoNlM0RnRX?=
 =?utf-8?B?bE5mOXBuSlhMNHhFNU1JNmdDNlB0VUlHZ1ZacGZpV3lsWVM4eGVxYWRGaTZZ?=
 =?utf-8?B?TVladHNEWmtIc1cxRDF0aHpQYjN6aWFxRmE2aW1zOGwydmRTTWk3U0JSZVUz?=
 =?utf-8?B?WnJhajM3VXVidmpabG9hSUJQTVowcUJyTUQ0QXJWa3d1OEpWajAxN1k0RTRw?=
 =?utf-8?B?enMrOXQ3WkhWNzI5ZnpHYXRmV2JlTmFMV2xqMW5kQnppYlB3L1A1SW9wUXdK?=
 =?utf-8?B?elkzMjQ1SkszRjdXQkMyQ1pZTVdFOU5HQ0JIY1IzTTNZbEJhUkJpRlpGNk5W?=
 =?utf-8?B?dHJSeDI5NklVRkMzZFp2UXJrYlRjc2NQSnF4L3BsQ3hINzE3ZW5pSnZoa1lW?=
 =?utf-8?B?SkcxbnAzd3BaU3V0S3BoanVPTE14ZWZheVJQbnNCYmhucVFwcFdZb2tQd2VI?=
 =?utf-8?B?TzAwYjB2MTZ1bHc3WGhKNWNTNnZsZWtZaCt1M2wwcUg5eUFyZ1V6SmxVcFRF?=
 =?utf-8?B?ejVoTE1pZmR3UU9LcnZyY1Z1OExhazRIRThMbGxlUndSUFVkWDNrOUtFNFBK?=
 =?utf-8?B?V3hLN3VTaGVhVEZnTk5XMCs4L0lmT1NJQ3lYYkVEemxlam01eXQveDhEeGZn?=
 =?utf-8?B?Z1I3aEZLUGVLM2FWMldYclk4QlhZQXBOQ1U0aUZHSDAydnY0MkZ5aTZxeEM0?=
 =?utf-8?B?dkx3RVcvU2phMTRPYklid1V1RExUZjE4dGVMVG9NcGJEMHVseS9QQXExTUI0?=
 =?utf-8?B?dHY4bU00bVRjKzY4WFhPV1dFNWhGdURUMFkzTTVEM1dxZGJaT2YxWE9QTGZq?=
 =?utf-8?B?L3ZFcGFIMWI2UmxMVTBmR0pZYnpjRUo1czZ1Smd5WWJEeFd3c1ovckF3YTlZ?=
 =?utf-8?B?YnB0R3pJelZ2VFg0ZHNmaGkxRlpYV0t3WVBsMUVEZTZTbU5ZK2hCZHpaZjd6?=
 =?utf-8?B?cjRBUENOamxEMGNhcWZhV0hWQk9tR1ovWmdXWHQrTHhoT09Mb003cUc5Rklu?=
 =?utf-8?B?MXkySWlYOHZRUHN5UWNPUDBNbUhOZGhkcEtudHl5a0ZhclpFdVJJZnpuWW5E?=
 =?utf-8?B?WkJBQXJLRm8zQWtzY0txQVpYZExlUjVBYXJySnk0VFdxckExWVMwZjQvTlRz?=
 =?utf-8?B?cmRSOXdDVXlXeXIvL0xHUHJiOWJONWtGM0tOSVdsYVJQN2NjU1VtdEFOMFZZ?=
 =?utf-8?B?cVpycE1vNU9aaXJ6WS9lUldpc0ZaQU5XWnZRTXBOdjBZUjRuclo1aVU3QVNG?=
 =?utf-8?B?dCt5OTBPVklpWnY5cTFUdmR3TUtRM1BYV0ljZ2lqekNnaDVaenNUNy9jSXJs?=
 =?utf-8?B?U3Uvck13MjZsZmNsQkxEd3NDMVp1Vm5obGNSdEVaVnRmUmIrOXNtZ1AybWZH?=
 =?utf-8?B?ZU9uSDlFM1JyaTE2NytmaE1jM2o2d0ErWlFXWGgwVEZzOW5qNXNjaGg2bXIx?=
 =?utf-8?B?YXowQWNoKzJ1d0hIeHJUckNGcEZJUkFNaGN2WFdFQkpHU2k4dUJmbVNkWlA4?=
 =?utf-8?B?VzRxTk02N0Q5eFR2V21XR2hNaVZUZlErekMvODJrUzYxaUUyVm5LRFJiMlRH?=
 =?utf-8?B?VzVzWnVsQm5XYW83bmg5ZE9ibWt6VGEzdUVLd2JuM0tpQUFuekxZM0hBZkRZ?=
 =?utf-8?B?Y0FoYVp2cUE4TFBlc3VoTWdrZlF6MElHTEJiNEdPdnRuNElRQTVtYVc0MDZC?=
 =?utf-8?Q?/wEQwQgvtGXL06GgkZ+FwZd+3Ep+Jegq4Z/6UW0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7112d-f1c0-4bf5-f79f-08d8ed11c8a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 09:06:30.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw8dFbXYpzYbkOrWQrwFnuo1lUUkPtbPAosPPVdP4wxTmuRGYiXXC0Pom3UAipGL8oqIlHtvA8xZhqLuNhGWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAyMDIxIDU6NDkg
UE0NCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGFuZHJldy5zbWly
bm92QGdtYWlsLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsga3dAbGludXguY29tOyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOw0KPiBzdGVmYW5AYWduZXIuY2g7IGxvcmVuem8ucGllcmFsaXNpQGFy
bS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0K
PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6
IHNwZWNpZnkgdGhlIGlteDhtcQ0KPiBwY2llIHBoeSB2b2x0YWdlDQo+IEFtIEZyZWl0YWcsIGRl
bSAxOS4wMy4yMDIxIHVtIDE2OjI0ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQm90
aCAxLjh2IGFuZCAzLjN2IHBvd2VyIHN1cHBsaWVzIGNhbiBiZSBmZWVkZWQgdG8gaS5NWDhNUSBQ
Q0llIFBIWS4NCj4gPiBJbiBkZWZhdWx0LCB0aGUgUENJRV9WUEggdm9sdGFnZSBpcyBzdWdnZXN0
ZWQgdG8gYmUgMS44diByZWZlciB0byBkYXRhDQo+ID4gc2hlZXQuIFdoZW4gUENJRV9WUEggaXMg
c3VwcGxpZWQgYnkgMy4zdiBpbiB0aGUgSFcgc2NoZW1hdGljIGRlc2lnbiwNCj4gPiB0aGUgVlJF
R19CWVBBU1MgYml0cyBvZiBHUFIgcmVnaXN0ZXJzIHNob3VsZCBiZSBjbGVhcmVkIGZyb20gZGVm
YXVsdA0KPiA+IHZhbHVlIDFiJzEgdG8gMWInMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQgfCA0ICsrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUu
dHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2
cS1wY2llLnR4dA0KPiA+IGluZGV4IGRlNGIyYmFmOTFlOC4uMjNlZmJhZDllODA0IDEwMDY0NA0K
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9mc2wsaW14NnEtcGNpZS50eHQNCj4gPiBAQCAtNTksNiArNTksMTAgQEAgQWRkaXRpb25hbCBy
ZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBpbXg3ZC1wY2llIGFuZA0KPiBpbXg4bXEtcGNpZToNCj4g
PiAgQWRkaXRpb25hbCByZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBpbXg4bXEtcGNpZToNCj4gPiAg
LSBjbG9jay1uYW1lczogTXVzdCBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBlbnRy
aWVzOg0KPiA+ICAgICAgIC0gInBjaWVfYXV4Ig0KPiA+ICstIHBjaWUtdnBoLTN2MzogSWYgcHJl
c2VudCB0aGVuIFBDSUVfVlBIIGlzIGZlZWRlZCBieSAzLjN2IGluIHRoZSBIVw0KPiA+ICsgIHNj
aGVtYXRpYyBkZXNpZ24uIFRoZSBQQ0lFX1ZQSCBpcyBzdWdnZXN0ZWQgdG8gYmUgMS44diByZWZl
ciB0byB0aGUNCj4gPiArICBkYXRhIHNoZWV0LiBJZiB0aGUgUENJRV9WUEggaXMgc3VwcGxpZWQg
YnkgMy4zViwgdGhlIFZSRUdfQllQQVNTDQo+ID4gKyAgc2hvdWxkIGJlIGNsZWFyZWQgdG8gemVy
byBhY2NvcmRpbmdseS4NCj4gDQo+IFVobSwgbm8uIFBsZWFzZSBkb24ndCBhZGQgYm9vbGVhbiBE
VCBwcm9wZXJ0aWVzIGZvciByYW5kb20gcGFydHMgb2YgdGhlDQo+IGJvYXJkIGRlc2lnbi4NCj4g
DQo+IElmIHdlIG5lZWQgdG8ga25vdyB0aGUgdm9sdGFnZSBvZiBQQ0lFX1ZQSCwgd2Ugc2hvdWxk
IHJlYWxseSBhZGQgdGhlIFZQSA0KPiByZWd1bGF0b3IgYXMgYSBzdXBwbHkgdG8gdGhlIFBDSWUg
Y29udHJvbGxlciBub2RlLCB0aGVuIHdvcmsgb3V0IHRoZSB2b2x0YWdlDQo+IHRoZSB1c3VhbCB3
YXkgYnkgdXNpbmcgdGhlIExpbnV4IHJlZ3VsYXRvciBBUEkuDQo+IA0KW1JpY2hhcmQgWmh1XSBI
aSBMdWNhczoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4gU2luY2UgdGhlIHZnZW41X3JlZyBp
cyB1c2VkIHRvIHBvd2VyIHVwIFBDSWUgUEhZIG9uIGkuTVg4TVEgRVZLIGJvYXJkLA0KIGFuZCBp
dCdzIHNldCB0byBiZSAicmVndWxhdG9yLWFsd2F5cy1vbjsiLg0KRGlkIG9ubHkgdGhlIHJlZ3Vs
YXRvcl9nZXRfdm9sdGFnZSBvciBjb21iaW5lZCB3aXRoIHJlZ3VsYXRvcl9lbmFibGUvcmVndWxh
dG9yX2Rpc2FibGUgY2FuIGJlIHVzZWQgaW4gdGhlIGRyaXZlcj8NCg0KQmVzdCBSZWdhcmRzDQpS
aWNoYXJkIFpodQ0KDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQoNCg==

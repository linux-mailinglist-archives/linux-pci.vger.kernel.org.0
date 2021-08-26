Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800693F911B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 01:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbhHZXuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 19:50:23 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:57798 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbhHZXuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 19:50:22 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 17QNnAPH004983; Fri, 27 Aug 2021 08:49:10 +0900
X-Iguazu-Qid: 34tr8rsmqNZrjaMOjB
X-Iguazu-QSIG: v=2; s=0; t=1630021750; q=34tr8rsmqNZrjaMOjB; m=9FzLxpo4pELrRy6OKHx1mCY8VpNSyPrb28c6VJ1+vn8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 17QNn8R4005199
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Aug 2021 08:49:09 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id A9DDD100151;
        Fri, 27 Aug 2021 08:49:08 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 17QNn8OE012275;
        Fri, 27 Aug 2021 08:49:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfvSndZBltRMMMRIoZhu2SftT91HLDhlk37S9Iqi0nX+Ulm8UmrNTuIGAT4Zc4GyVW7cxr78xq5bJI6VvNGBBvuDnhUzLeS06bWtEOrNXd7SME/ouQDdt186NJ9RVaPL6zWcN+CQ3yjENWSYgmzORN9Ku4zo+Eu2gqOBH5iV0zp0nC3K/5ZBCeO/9ybz8pgM3tC3DQ6+vzVqpRjH1dookEb/fPaPOivZtiFPWdwv1x+Z9XZuSKxuQ3GLxcClnrN6e/VUEudRO/UehXV5KG64FZsI8MHfQsk3+X9Uu9g3/krUB9jtjWecIFeR8lr5NFp5EDjG7AKw2glJ+f47408ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtBz5SGiBdFW3G5V3pLx8pymLx8YpU/MwD++AkP/vbM=;
 b=MaiVO/8SZ9fh55n9zsw14hUu9FjZFnGaL6UbmZzIQVoKn6qCIYIM0EZklzOBu8cS9zgbHDihnFZL8I/Pjlcn0XUVauNUPi+dU4RI1NPbo+Lqx7WltlwsSre6i3b8xF0+WAM8UQdwfUWU1qsrhN9VFaRVFhnsHKVZFqNHemxqLjlr1dsLsNppjzpbSr8hDaDH7Eq9hyV+rMsldspPhWqfeN4xOGFe0coszKM+GgiqyImM+5FzvY93sbmGPBfg76BKefnOO3FUdYwpMXkFgnu3BT5erATXANEnWwk7RIbqkno9uY7sNcoq4/rSYLlS8pXu7TzWTEVn/NeeVthxP4P8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>
CC:     <kishon@ti.com>, <yuji2.ishikawa@toshiba.co.jp>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <kw@linux.com>,
        <punit1.agrawal@toshiba.co.jp>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
Thread-Topic: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
Thread-Index: AQHXjoxPS94cnMPoeEOD7WgANI6+jauF19OAgAC0JtA=
Date:   Thu, 26 Aug 2021 23:49:04 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252A29B56BBF8921822824F92C79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <162998285902.30814.11206633831020646086.b4-ty@arm.com>
In-Reply-To: <162998285902.30814.11206633831020646086.b4-ty@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a23eb9d-9ef7-47cc-6563-08d968ec1674
x-ms-traffictypediagnostic: TYAPR01MB4445:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB44458D7520C79CA85B0DA7A292C79@TYAPR01MB4445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRlFwQ5h9VepYVDL6fvafE69VWOEYeioBs8tsSi1h2ZZYlS8ANCmLEUaZ53X1jWQcuKy2cfuZShzHe09h6MK1+IA8TlPK59jCa9wa+R8OlFvU3DaNVVPElsTvn472qoNhrr0nNSLFDsW8czhrtfTu12oifvCj6Tfsa4n86fi5xDA5bxV83/ZstNn0x9Z15bIqFitPzxdDrxq4pyhIye6PxLt+GYiGA9A4BE0vxQkOzxykD1SFqEstiOeTWrBQwMErSHxiEGA8WSZhv5kYpSZQst9xhoSK0BifIPxvfevYBrRj58TnHEMaLFomcvhfdOeyVlPUVJIc6QGf9LHYpb9hbTgXKiXvfUGQxwAZ2n7jmt3LKqVjWJZRsXKDtD9FX5xZNdV7uWZ0fLw6i9S3M+ekdRicjxgkwCHf9qE0lGqCNK4TuFxHbeJ4HpQQCGbp2qxFaO5eToTtKgSLL/GUR0Z3p5v7jIcSeUv44qgbxq5Ng7DlsMLxhAWOYxjLI1vIiYZApyGHR4DQesrWX4cDpx24R1Ui7zbVPaPdrgIKU5TZ7ajcZqMqrWfgRuW3jpQm2vlMt/4+6DFo1MZ8c35AMNpCaC7em3Qk6QzqdHQq1/Wfvl2cLHip62JZIocKqEWoLaMkveZd7nC75SoWU9moKkWw27AHk8RE/cinX1Gt3/cs3OiXtZUiuP76HgoOOEkNGqSm5JYXP0XiChxL/HuYhfVGcRvkbE8S3kpp4CW26ASk0cUNSsC0e0Zdk6NzcWlCfow0CIDp8QIJilUQav5bRajsiVBR+Fc9KPj/kRnv6vmEZ9pG8RE7gjj7OEmpE8/0dffSVx27BrncTCk1hb/DukuZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(478600001)(86362001)(66946007)(26005)(54906003)(33656002)(2906002)(76116006)(8936002)(8676002)(9686003)(83380400001)(66574015)(966005)(7696005)(71200400001)(55016002)(53546011)(38070700005)(6506007)(52536014)(38100700002)(122000001)(186003)(110136005)(316002)(66446008)(64756008)(66556008)(66476007)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5GU2VOZFhmYWZySSsyT0VCeEZzVU9nVGN5T3F6cE82eEZFZXBwTkdLNitC?=
 =?utf-8?B?a1RLQmRnRnd4c3lsN3dSaXNCcXBWNXBWaGgwVldhYlA3SktuZ3duampDcmpu?=
 =?utf-8?B?M0Q3YXMvc2RJZWMxZ3JtYXBQWjdvVjJjVEJLZGgwOVBBcmpWVlhTNEc5Tm9E?=
 =?utf-8?B?MFFwQlVWSmY5eDFOWkhrWnZKQWlZQ3Vzc0lsTDluLzhTY1JSUnc5dndVR1FO?=
 =?utf-8?B?WWRuVHhlRDVXWklIdFIyOTFhTXpuK0Fxd2R0NjhaMGlZOVJNVTJPTWRzenhi?=
 =?utf-8?B?c0VLNm9UYmZsaDNlT053M0R0TVRUQ3NkQXlkczRiRldwdGdJQ2ZXaXc3WFI5?=
 =?utf-8?B?VHdCYVNWejlTNkozeUhUTkc1Z2VGaXV5eWZXTVpDdnNWclVBN3JMS09WOEJ2?=
 =?utf-8?B?TlRHTGxPeUFkZys3VVphTEMrN1JEN3ZGN0poVkZ0R2xib3B1d00rRzVObG5P?=
 =?utf-8?B?cjBqelpqWTVSUEVrcUd4MUpQTS9xd3I3d2pqMWVqSlZCbGE0SFRYV3o5S3ho?=
 =?utf-8?B?d29vaUJIQkMwVytCVVhtN01CTGFsMDhRUFdlUkZ3RkRlMUg4RDZtZlRxbTda?=
 =?utf-8?B?VnVsV0MvQk8wTnhsczEySXR6MGpQNG03Q0ZTSU1BdDZOTnVXYlRtM2xZM25p?=
 =?utf-8?B?N2o0SzVFWDZGRE92WlJ2ckhoSno4R2dteTBtb1FNZG1iZmUrTHBqNXVKakhq?=
 =?utf-8?B?NkJuTUdZUncyVzEyMStCSU1yM0J3M2p6eDRVUmFLVS9KZ0JCYllXL2l4YldW?=
 =?utf-8?B?dlpNVnVEamVkV0NBT2Z4OHpyZ05SV0lZQjVVblZ4Yll6Q1NtWFVJN01oMEZx?=
 =?utf-8?B?L1RTdUN2a2FvaWt3a2ZLcnhUc05KalZnaXF2bEFWMGEwR0pvcE5uV281RE5U?=
 =?utf-8?B?YXRjV2hPa05GR1ltLzlmRnRuVHp2SGlwRzJiOWJHSmJlY0FDTTgzTUlUNUpQ?=
 =?utf-8?B?MHJxVWZpckZqQm56SnFveGxhVU9PRkFPVHBqR0lHRzdvK24ydlBrZHVNNFVG?=
 =?utf-8?B?aDBSektVU3lPWGVYbXNCZmIzOXJwOGdFZFZQNklyNWVkK2Qyc1pDM01QSGVX?=
 =?utf-8?B?UWRuQVM4b0tZSmdiYzdpV1RVY1FKbVRYUmxpSWh0aGRyRzQrZzlydkxJR1dL?=
 =?utf-8?B?cVNNUE1UZjhOQ3kzNk84UFRiZTdUK1hGcGpuV216b1NzUU9JckFhRnJOMXBM?=
 =?utf-8?B?TnVwbmNMaUNXSFR0ZGg0UU5iYXZickZ0OTRBK2FpNVAxKzdLeElqT0d4bzhR?=
 =?utf-8?B?MEF2R21qS1NDWnB6bEVNOVV6ZEYwQ1dTOG1qTHM1WmV3c0FOQWxXS2h3enhk?=
 =?utf-8?B?aE9lcWpyMll3Mk4vc0lMaHZodmVhcmNzd3JSZHg5UWZqOTVIN2RsTXRDSm5p?=
 =?utf-8?B?a0V6VWgvUTBScHd0SGlnYmhVZDNoR0dGemhFUjhzNGM0cGRBOWlrTlVGZmFP?=
 =?utf-8?B?ZGRrZjh5clI0R3RnMFdxSzhEcWsxL2VZbzhVTVJlczRnVEtGdTVnZHlwaVVK?=
 =?utf-8?B?MTA4WTRJNW9Db2dObGEvRWtCOGJNcENuQ1dzeWdzNzVZZm5zU0lYS1dFWkY4?=
 =?utf-8?B?LzJWTHlUR1pPZ2FrT0NkMFRpZ1lpaGZGUVpxS2J6K1BGcUVDV0YwZXNBVk5U?=
 =?utf-8?B?Y1RRbngxWEROMmJYMmZocUZJYzR5SlpPV0V1SDFLdWQ2NVZMQTg0TE0vdXJ3?=
 =?utf-8?B?b0VBQ2NFT21jSGhQVU82Vks3TDRONy8yczh5blZIQjZQcnRabVlqL3dBVVNo?=
 =?utf-8?Q?qx/0kJJt5gem19FH0QQVHtGB+jvkY3npd4nhqDq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a23eb9d-9ef7-47cc-6563-08d968ec1674
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 23:49:04.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MASE/kdNV5VmgJ6qmY+UYE8hQX9d0V/zYGr8OBvOpU5jKvzQKPBus7zMrYJlrHUXf+KKorMU82+1ucVJAclzYWq8rS7pj6cpbrREDs4x1INNQOxMIVIs4C1diJb5ojdq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4445
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9yZW56byBQaWVy
YWxpc2kgW21haWx0bzpsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2Rh
eSwgQXVndXN0IDI2LCAyMDIxIDEwOjAxIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnm
nb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEJqb3Ju
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IENjOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hv
bkB0aS5jb20+OyBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gNCj4g4peL77yy77yk77yj4pah
77yh77yp77y077yj4peL77yl77yh6ZaLKSA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBhZ3Jhd2Fs
IHB1bml0KOOCouOCsOODqeODr+ODqyDjg5fjg4vjg4gg4pah77yz77y377yj4pev77yh77yj77y0
KQ0KPiA8cHVuaXQxLmFncmF3YWxAdG9zaGliYS5jby5qcD47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMC8zXSBWaXNjb250aTogQWRkIFRvc2hpYmEgVmlzY29udGkgUENJZSBob3N0IGNvbnRy
b2xsZXIgZHJpdmVyDQo+IA0KPiBPbiBXZWQsIDExIEF1ZyAyMDIxIDE3OjM4OjI3ICswOTAwLCBO
b2J1aGlybyBJd2FtYXRzdSB3cm90ZToNCj4gPiBUaGlzIHNlcmllcyBpcyB0aGUgUENJZSBkcml2
ZXIgZm9yIFRvc2hpYmEncyBBUk0gU29DLCBWaXNjb250aVswXS4NCj4gPiBUaGlzIHByb3ZpZGVz
IERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiwgZGV2aWNlIGRyaXZlciwgTUFJTlRBSU5FUiBmaWxl
cy4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiAgIE5vYnVoaXJvDQo+ID4NCj4gPiBbMF06
IGh0dHBzOi8vdG9zaGliYS5zZW1pY29uLXN0b3JhZ2UuY29tL2FwLWVuL3NlbWljb25kdWN0b3Iv
cHJvZHVjdC9pbWFnZS1yZWNvZ25pdGlvbi1wcm9jZXNzb3JzLXZpc2NvbnRpLmh0bWwNCj4gPg0K
PiA+IFsuLi5dDQo+IA0KPiBBcHBsaWVkIHRvIHBjaS9kd2MsIHRoYW5rcyENCg0KVGhhbmtzISBC
dXQuLi4NCj4gDQo+IFsxLzNdIGR0LWJpbmRpbmdzOiBwY2k6IEFkZCBEVCBiaW5kaW5nIGZvciBU
b3NoaWJhIFZpc2NvbnRpIFBDSWUgY29udHJvbGxlcg0KPiAgICAgICBodHRwczovL2dpdC5rZXJu
ZWwub3JnL2xwaWVyYWxpc2kvcGNpL2MvYTY1NWNlNDAwMA0KPiBbMi8zXSBQQ0k6IHZpc2NvbnRp
OiBBZGQgVG9zaGliYSBWaXNjb250aSBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXINCj4gICAg
ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9scGllcmFsaXNpL3BjaS9jLzA5NDM2ZjgxOWMNCg0K
T25seSBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSBpcyBhcHBsaWVkLiBDb3Vs
ZCB5b3UgY2hlY2sgdGhpcz8JDQoNCj4gWzMvM10gTUFJTlRBSU5FUlM6IEFkZCBlbnRyaWVzIGZv
ciBUb3NoaWJhIFZpc2NvbnRpIFBDSWUgY29udHJvbGxlcg0KPiAgICAgICBodHRwczovL2dpdC5r
ZXJuZWwub3JnL2xwaWVyYWxpc2kvcGNpL2MvMzRhZjdhYWNlMQ0KPiANCj4gVGhhbmtzLA0KPiBM
b3JlbnpvDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


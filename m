Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA792D85F3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 11:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438777AbgLLKkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 05:40:22 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23472 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438758AbgLLKkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2020 05:40:22 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BC6pfpk008713;
        Fri, 11 Dec 2020 23:07:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=xqUMd2AFnxUVFgbhS9ptH2KwZ2Pi1S9Qe/kmgeFPP3g=;
 b=kvxOBS0sU63ms+gGVkRg1kN4M0BNRTWkPHwZebEBdtWQeOQTVPscT0K8INDH+daVYkZG
 KczX38rXAoC86mxIMm7aWMsqZ58VVOFdX6aAY99TyHXMfAvv5c/qACKCojv1sF3LbMPe
 YB+Vr+ovdQvL/fFB2+vl/8q/qtANNEa0ZbumM0Kh7mIlNTEmm1Di5AAAwYH2ICmNXeUP
 25xFoWAaVYHUyCed9Q+NDODHfN4uozzfyq+2fF2APbkkjT9JN197xSxYep1gaF9W48pg
 7PAib1AotWabvlNsi6Up6a2BYYJsDzQWJKN1r2b712qRV9hNfnDXn5nI2n8LCMOoXLnS 6w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35cpvh88qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 23:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbRYy9CT/7i+xfhdwVQBxNISvizvT345oHjyn73GEVeGu/Z8M7EHfKDUpvMsrzXLlCZ+S5oZsH3nd0goSp9VYIpAumddzRGXmU3VjDnzQmKPA7/0dKnmLLeMGwX22DzXLJAluI/JxVKQm5dvP6O4tNVVs0QKNHXOhHooWNqZ1QRrh26au3n4WdPUBMXOHoS3XtSKkAERt4JOkP0EMDilgQHCc1A9BUOR3HS1pCnlZaQJnVspeaGhtaBiGWZhZVafNWUMi43B4j70uDf/J+HvPg5YqFR4eK6GljL9uU2pUV01LrRJfPoLT40NhoCr6NENfonTh4I4RtjFrh0i7f3N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqUMd2AFnxUVFgbhS9ptH2KwZ2Pi1S9Qe/kmgeFPP3g=;
 b=as8egpNThcz85wIoFhQDfGLuqzAoDdYsYNiCe6JFRvx75o+qXa0JUWh9fqOhbZlL4UlQ4FS9tp+pMwLherBtYnYZVLXou2YjrlHgCxigk5E/dq/eMRp6ErDtWp3C9dJTW+9UARcItpf7JLH8OersKdqT7Bs4vl7b/dxLrx2O8jhZbe1rShKoswL2rS3faBWgG8A6ZYkuraZRJ9KAoOTm7JbRjIFcmSLarbGI2Za/jcFyF/QTRh0WcsDO1s16/j4+b5DrJzJnPl93jI3fYXNyLNC+8P+/0IYNQ40wl4BXQdXh/yT1YbAuhcEP66F8Ng24ytdB+Z8ooLvv/Qy0nB5d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqUMd2AFnxUVFgbhS9ptH2KwZ2Pi1S9Qe/kmgeFPP3g=;
 b=2x5Zo654kIZLyt9tZsvHU+b1m2mfwNIFlx5+4rpFP/I7iAwsQa1+g35vttbA20G8qUxDY+W304Hvc4K8TkeqiPRlJgdu7RKj5JwWSKQJw34udx9Lx+TZCuvC/21DpwPtKTD62CLFGTBCD9YTsCye/PrZv7MzSZRaH7J8/N7wVzE=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SA0PR07MB7658.namprd07.prod.outlook.com (2603:10b6:806:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Sat, 12 Dec
 2020 07:07:43 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a%8]) with mapi id 15.20.3654.016; Sat, 12 Dec 2020
 07:07:42 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around Gen2
 training defect.
Thread-Topic: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around
 Gen2 training defect.
Thread-Index: AQHWz8vmdVN4Fb0wXUex4zRT/e/XyqnyHzUAgADqL+A=
Date:   Sat, 12 Dec 2020 07:07:42 +0000
Message-ID: <SN2PR07MB2557145EE4C4E9C50A16CF64D8C90@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20201211144236.3825-1-nadeem@cadence.com>
 <20201211144236.3825-2-nadeem@cadence.com>
 <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
In-Reply-To: <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: kishon@ti.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjdiNTFlMTYtM2M0OC0xMWViLWFlOTItZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XGI3YjUxZTE3LTNjNDgtMTFlYi1hZTkyLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMjQyOCIgdD0iMTMyNTIyMzA0NTkyODAzMjAzIiBoPSJIRlJtWUJuZEozZDBxQkpobXFDeGVvRmN1V289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af038a12-0b62-471d-50fd-08d89e6c9ec0
x-ms-traffictypediagnostic: SA0PR07MB7658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR07MB7658B42D4A35920CA34D2F45D8C90@SA0PR07MB7658.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUt1GFur7OvTUNNvxzL+KYf7rGiZ9i2OkVPZLTMAWbmJeBTH8xeY6YG+Nk3z3k3zLkqFpoTBnOK+cfg5OVNEerFOhC6TiUbNqv1/3jRfzx7Ij0twav49fGjMIrgoe98tgfrnrZG9dxbEpSKCon2X/TU1wlaGwtx1xCWdLtEmYR/hjuYqB5PhLyVlvzQZ/QV07FzctW+NBJVxmlwtgCAuRApOk9tqI7/I3PRr0u83oGHFj+RGb307klL/BXuJB3Hxjd1rh0ajH82uATHzm4TOG1dXa+M0YDyScO3bPe3Mmeo50r2IH+gmaLdd6vwaWiHF4IP0Z6GD9Zr1eLOfGSzFs6acEEQ2fZKUr2d79ql7NDqeAAkdd9EzmoS8dJysw31n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(36092001)(52536014)(6506007)(33656002)(508600001)(54906003)(64756008)(76116006)(71200400001)(66556008)(26005)(66446008)(53546011)(83380400001)(8936002)(8676002)(9686003)(2906002)(110136005)(66476007)(86362001)(66946007)(5660300002)(186003)(107886003)(4326008)(55016002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MDgwMnVwUFViM2ZYQU9hMnBSci9LTUc3akU5N2djN2RReTRXMjFJYTBndW1r?=
 =?utf-8?B?S1JrdEJYNHFPZXVrMk1tMitpNS9WeGdwRlJtS0ZNclVJa2phYXUvRW44Zlli?=
 =?utf-8?B?Qkw0RG5qMWNKVkhUdTFRSjhjck1wYk10c1dHaDdHU0dMSm5NZUxva29naVpF?=
 =?utf-8?B?aWVkWWpIRlNESnUwNmJQK3RoeHhISDFoZDRuenlzRjI2Z09SRGhhZnNuRmhP?=
 =?utf-8?B?Z0JFWVZsYlVrY2haaVQ0YUE4RFExcFA4aVpYc08rVU9KcnE0QktjcjZzTGhS?=
 =?utf-8?B?ZDNSb21CZ2YvTnVlWE1HbGg2SGd5TnEzeHpabEVPZ21ZZW52aSs0Z0owcEdx?=
 =?utf-8?B?OW9XdkgwQUR0em1zVFlXVERDbkc3a2Q5TlBORnd6S21MOERoSHZ6S3BtS1dL?=
 =?utf-8?B?RXhnVTgyZTlaME9kMHdrUWFzSlBrYm5oTG1KQW9aMldTbnhLZ2VrRzZSZ01D?=
 =?utf-8?B?Tm96UEFzNjZORUJZU1NiMXpON2tnMlp1YUxZZUdXTUFueWExQ2hwYTFzWm1J?=
 =?utf-8?B?QlRWNDFNSW9weURSZjNUSnJHUmdTZDZOWG5UaWJGWDY5Ykp6WWJBYjdJUzZw?=
 =?utf-8?B?U2VQbUppOGZQYkc1Q1podGR4MEV4WG0xcEtpZEZxOHArYmRCc3VOdEdIcXhk?=
 =?utf-8?B?TjBFemRzLzNlL1VvVVkvWE42R0FPNFFXUk5ncTBybC9ZbmJsc2FPUHpzMWNn?=
 =?utf-8?B?bzhBVHlwaFV5Y0JpZ3lSREhKU1dBbXloWDNNaXNvcjlLNldsajhPSjUxWVlM?=
 =?utf-8?B?SnF0ZjlVV1JOeFhtQzkvWEtlQ2RETUV0SHVEbDNib3RpTUQ4dndmRmNRc1hl?=
 =?utf-8?B?V0M1ekF6cHplYU5DR2tKK3AzUkR0aGc1dlc5ZTNJMVdJaU9aMFJ3UnlBTW1y?=
 =?utf-8?B?ajBkNnJ0RE5wTGh0QWJkUUVOdm5KeXp0RHNMQ1gyTEU4Q2FYbS9FUmVVbE1s?=
 =?utf-8?B?TkU4NDZqTG9iVGJMQXVQdFV0RTF2dXgwdXQ1N0MrYnJoNER1OTdFRG1JY2dM?=
 =?utf-8?B?WlpHY1VvTzQzM2tKYnF3ZlJSa0JSM0FBanQ4TWE1MDdMeCsxaVpGRkRjM0VL?=
 =?utf-8?B?RjgrS3VFK29neFdPNmMrRUZORjVEN1VoYnNBQ1Y1VENVaWZMTm1xUFJPRjMw?=
 =?utf-8?B?a0xLYWFLaE1YK0prSmN5dEZtUkZzRHNuQ3lnTG5WdjVZS0pnQldzVXVuNGMx?=
 =?utf-8?B?anBkZWpTVEJLM285TnA2VWxLamRhTmtHWHozc1RwSGVMQlIxZDRGS2ZoQ1Vt?=
 =?utf-8?B?MzJUQlJwcyt3c2lGVlJTRzhjUERuNmwxQTRmbHo3VEtoZGdvZ0JYV0wzSzFy?=
 =?utf-8?Q?iwaHxbUCOIOg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af038a12-0b62-471d-50fd-08d89e6c9ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 07:07:42.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSYaXyYkzk3RFq9jYHHQ3k+Zu6MOmrMu1yMkdFeiXcJJAaKw4TubFsw8kPhXfETYEtRcITyRqaVJRo0l4Tvdo6CuPiEKDHqKvxxYTmf38X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7658
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-12_02:2020-12-11,2020-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012120054
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iIC8gS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
MTEsIDIwMjAgMTA6MzIgUE0NCj4gVG86IEF0aGFuaSBOYWRlZW0gTGFka2hhbiA8bmFkZWVtQGNh
ZGVuY2UuY29tPg0KPiBDYzogVG9tIEpvc2VwaCA8dGpvc2VwaEBjYWRlbmNlLmNvbT47IExvcmVu
em8gUGllcmFsaXNpDQo+IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFBDSQ0KPiA8bGludXgtcGNpQHZnZXIua2VybmVsLm9y
Zz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEtpc2hvbiBWaWpheQ0KPiBBYnJhaGFt
IEkgPGtpc2hvbkB0aS5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgTWlsaW5kIFBh
cmFiDQo+IDxtcGFyYWJAY2FkZW5jZS5jb20+OyBTd2FwbmlsIEthc2hpbmF0aCBKYWtoYWRlDQo+
IDxzamFraGFkZUBjYWRlbmNlLmNvbT47IFBhcnNodXJhbSBSYWp1IFRob21iYXJlDQo+IDxwdGhv
bWJhckBjYWRlbmNlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGR0LWJpbmRp
bmdzOiBwY2k6IFJldHJhaW4gTGluayB0byB3b3JrIGFyb3VuZA0KPiBHZW4yIHRyYWluaW5nIGRl
ZmVjdC4NCj4gDQo+IEVYVEVSTkFMIE1BSUwNCj4gDQo+IA0KPiBPbiBGcmksIERlYyAxMSwgMjAy
MCBhdCA5OjAzIEFNIE5hZGVlbSBBdGhhbmkgPG5hZGVlbUBjYWRlbmNlLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPiBDYWRlbmNlIGNvbnRyb2xsZXIgd2lsbCBub3QgaW5pdGlhdGUgYXV0b25vbW91
cyBzcGVlZCBjaGFuZ2UgaWYNCj4gPiBzdHJhcHBlZCBhcyBHZW4yLiBUaGUgUmV0cmFpbiBMaW5r
IGJpdCBpcyBzZXQgYXMgcXVpcmsgdG8gZW5hYmxlIHRoaXMgc3BlZWQNCj4gY2hhbmdlLg0KPiA+
IEFkZGluZyBhIHF1aXJrIGZsYWcgYmFzZWQgb24gYSBuZXcgY29tcGF0aWJsZSBzdHJpbmcuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYWRlZW0gQXRoYW5pIDxuYWRlZW1AY2FkZW5jZS5jb20+
DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2Ru
cyxjZG5zLXBjaWUtaG9zdC55YW1sIHwgNA0KPiA+ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNpZS1o
b3N0LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2Ru
cyxjZG5zLXBjaWUtaG9zdC55YW1sDQo+ID4gaW5kZXggMjkzYjhlYzMxOGJjLi4yMDRkNzhmOWVm
ZTMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9jZG5zLGNkbnMtcGNpZS1ob3N0LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2llLWhvc3QueWFtbA0KPiA+IEBAIC0xNSw3
ICsxNSw5IEBAIGFsbE9mOg0KPiA+DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJs
ZToNCj4gPiAtICAgIGNvbnN0OiBjZG5zLGNkbnMtcGNpZS1ob3N0DQo+ID4gKyAgICBlbnVtOg0K
PiA+ICsgICAgICAgIC0gY2RucyxjZG5zLXBjaWUtaG9zdA0KPiA+ICsgICAgICAgIC0gY2Rucyxj
ZG5zLXBjaWUtaG9zdC1xdWlyay1yZXRyYWluDQo+IA0KPiBTbywgd2UnbGwganVzdCBrZWVwIGFk
ZGluZyBxdWlyayBzdHJpbmdzIG9uIHRvIHRoZSBjb21wYXRpYmxlPyBJIGRvbid0IHRoaW5rIHNv
Lg0KPiBDb21wYXRpYmxlIHN0cmluZ3Mgc2hvdWxkIG1hcCB0byBhIHNwZWNpZmljIGltcGxlbWVu
dGF0aW9uL3BsYXRmb3JtIGFuZA0KPiBxdWlya3MgY2FuIHRoZW4gYmUgaW1wbGllZCBmcm9tIHRo
ZW0uIFRoaXMgaXMgdGhlIG9ubHkgd2F5IHdlIGNhbiBpbXBsZW1lbnQNCj4gcXVpcmtzIGluIHRo
ZSBPUyB3aXRob3V0IGZpcm13YXJlDQo+IChEVCkgY2hhbmdlcy4NCk9rLCBJIHdpbGwgY2hhbmdl
IHRoZSBjb21wYXRpYmxlIHN0cmluZyB0byAiIHRpLGo3MjFlLXBjaWUtaG9zdCIgaW4gcGxhY2Ug
b2YgICIgY2RucyxjZG5zLXBjaWUtaG9zdC1xdWlyay1yZXRyYWluIiAuDQpAS2lzaG9uIFZpamF5
IEFicmFoYW0gSTogSXMgdGhpcyBmaW5lPyBPciB3aWxsIHlvdSBzdWdnZXN0IGFuIGFwcHJvcHJp
YXRlIG5hbWU/DQoNCk5hZGVlbQ0KPiANCj4gUm9iDQo=

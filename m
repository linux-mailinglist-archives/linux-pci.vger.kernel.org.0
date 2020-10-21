Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C3294979
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441070AbgJUIsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 04:48:03 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:36094
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441067AbgJUIsD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 04:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrsObQo+LFpL/0n5F7997a7uKSu8yQotvDXecI7vojXXw5KITKfuH5o1VjaHiCLDlMDAje0JYtOME12UgGHxmzLQQ9f71TA3LjLueDg8Pa0C9JCT2I2wc2YcPTn1xSFN1rWXmZAr7bui49znleGP2B1kbzOAUy1zvM/2jRTXQpavCPaYlpucZSLZYg/6eP2PbKpUO/09tqjSRCGCjU83w6xZdCW2gk9s7FS5JUqE13f7CaZVnZXHszyeWfPaNI9ThcsHVSo9lsm/JH9pvgsGp+bA6zb2esO1iTRFlsL4Rj8nEoMkMtoXgvszGwpTJyuDq9JYUCpOt1//dz7XWyNvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANJRa+nJjUVngmRQPhcg9xEEAw2+uxYnVpoTGlEpJno=;
 b=Rfh1IwvSRKabNvdD79XTKbdh1pIj+VfgMmQoc23CFLq+jhHeZP8/oE03aF0/cWp1gQwqxkfZu2RM+pL/bOUP9RbZZlcJxndbcrOB/qMkri/CbCr7qpiK774mMt2RU4nf4lhWrv2FJ/9xyuYYKBRw0wb/ec998JRx4121+Jc9Pn0vJfR0Q+bzT1bQsrJ1NGEtkoTsCW34c6+w3T/xGnX5k9oYxEvfgpPebyl5Wd48e1/Pvk0tGPTptzFRnGzpmyDPyubRCiUSQDHJ/eq6d+XG166+Ye5iIqNoNjVSs5oRTxkbqXg4b4Nn/PQiQKPsbpOs5x/z5tydhQ48k01qmxu+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANJRa+nJjUVngmRQPhcg9xEEAw2+uxYnVpoTGlEpJno=;
 b=fTIiJZ48Is/VRIMqso04HcDdBdo1ITTneQEw8lOAqP1gXJTHoKU0AnnGlrWyeAfDKdMOqdPA+O4z5mmSxGvlaqfOvQfrGG0V/LE4jsg7k2/+aUfn+LtNOAi9gBTEkQYm2Mb1UInsMYM663H/wWII649AIvLc/9OVN/LnCNm7Ba0=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 08:47:59 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:47:59 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Topic: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Index: AQHWi+0seUdQCD5Vd0CU4riR8OTpR6mZcoIAgAUfDCCAAAuOgIABVTAQgACEH4CAAXl4QA==
Date:   Wed, 21 Oct 2020 08:47:59 +0000
Message-ID: <HE1PR0402MB3371B927C5704F0C77E0EDB9841C0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <20201015224738.GA24466@bjorn-Precision-5520>
 <HE1PR0402MB3371CD54946A513C12A5ABC2841E0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <7778161f-b87c-5499-b4e6-de0550bc165c@ti.com>
 <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20201020095527.GA21814@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201020095527.GA21814@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04f67756-0b98-46b6-5802-08d8759e0363
x-ms-traffictypediagnostic: HE1PR0402MB2731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB27317136A28D80EF8BBBBC76841C0@HE1PR0402MB2731.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecvMAXhL5naIWRcpFj54RyqWCm4Le0UovN/9Ag7JrV1qQulSUngQBUuoS1HCTDp3GVEVENpgSPTByUZtIu5Hywnm3LwHlHITkYs0Yb2Dd/+Dsa2RI98XxfqQsEGYndDJPb3Q9K0cfFNVr777UwpUAIXOdZrQyI9ALkC8aOAEFJWNHxjBMutOgcjJYBzOp3Lbls1D9tAUOkN1+qRCiaHqyb8s87qnkPIZpzrFMdtSEdodpuKI5dI2/txHvjWX60PjFjHF//7RhmCVi1JpefhRolMjwvgsmWoSd5R3rV3PDQ/BKiA2Dn2Nczcvh2ZXcSS5o1fkIJvSt8XM1mZOsx3RpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(8676002)(33656002)(83380400001)(4326008)(9686003)(71200400001)(8936002)(86362001)(7696005)(316002)(76116006)(66476007)(55016002)(2906002)(66446008)(478600001)(5660300002)(53546011)(66946007)(6506007)(26005)(54906003)(186003)(52536014)(110136005)(6636002)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GcqBIK3qQE0VfZ/n5UJAWD/TWvZfDOLOZBZTI6eGHytz2iBRHI7zi8nvbyYUtHohUP0rrwCmVVBkcIIuZn1fo7OAeaEXtqAaEyBZdMxM7GGILlJPNfKIyzbQzyLV+TW4b7XkvnRFjH+yv8jagwv0dCTf6UAY8+nXl2msVeVXoU/Mho+ZKUvCRWhAPMS9imi+rBDiMqMcsuyYUgaXfWtc9yDvznhvzuXVy/Ac5usPkfcS621Q3KM6VRHpY1LqRrVQooChLGX43/YSkYtcgCcRDCrf5jvSCKfFzGLR7m6+SFwnkArcMbWo5g6h8ILIveVv0ECJyhOcJfvfrIigGdw5nBW6wSvqJpDL5vOb6/xYtlf7AuxtaWfYB+VSXhlB9j3nCXW6FdYUYYLQ6wrftUZK/u64k33xBYz9GGk1wNTOh0O1wKlI2+MBWI7DNIt8jwRufegz8RaR3cNNpCi84onwbsOfe6kjOHsJrOLNMUw65gMYLCNhw1SqtcWSyTbGoMyfcBOJvJfBqYpsaRC4NzmojDHPiUaw7E3ZsZeiBOQdpUiXc13AshGOlS1Z039+XY83KCWTdGOFJsUMF3c5pCpv53ywbHUuQ7B9e+9ep6b5r0UUC4FpZFA5Dk5rw/DcgmzwtSXamcftlrWYQrbdkCQiIw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f67756-0b98-46b6-5802-08d8759e0363
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 08:47:59.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6r1pzbqa+FxokdD402RxaCVFJwEBi+xGwfzYIgFKopC8DQL8tg5wBd6Hg8tw+E3PKYOMXlXA0aSzt/vwo+SGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56byBhbmQgUmljaGFyZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4g
U2VudDogMjAyMMTqMTDUwjIwyNUgMTc6NTUNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VA
bnhwLmNvbT4NCj4gQ2M6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+OyBC
am9ybiBIZWxnYWFzDQo+IDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogZHdjOiBBZGRlZCBsaW5rIHVwIGNoZWNrIGluIG1h
cF9idXMgb2YNCj4gZHdfY2hpbGRfcGNpZV9vcHMNCj4gDQo+IE9uIFR1ZSwgT2N0IDIwLCAyMDIw
IGF0IDAyOjEzOjEzQU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gPiA+IEZvciBOWFAgTGF5ZXJzY2FwZSBwbGF0Zm9ybXMgKHRoZSBsczEwMjhhIGFuZCBsczIw
ODhhIGFyZSBhbHNvIE5YUA0KPiA+ID4gTGF5ZXJzY2FwZSBwbGF0Zm9ybSksIGFzIHRoZSBlcnJv
ciByZXNwb25zZSB0byBBWEkvQUhCIHdhcyBlbmFibGVkLA0KPiA+ID4gaXQgd2lsbCBnZXQgVVIg
ZXJyb3IgYW5kIHRyaWdnZXIgU0Vycm9yIG9uIEFYSSBidXMgd2hlbiBpdCBhY2Nlc3Nlcw0KPiA+
ID4gYSBub24tZXhpc3RlbnQgQkRGIG9uIGEgbGluayBkb3duIGJ1cy4gSSdtIG5vdCBjbGVhciBh
Ym91dCBob3cgaXQNCj4gPiA+IGhhcHBlbnMgb24gZHJhN3h4eCBhbmQgaW14Niwgc2luY2UgdGhl
eSBkb2Vzbid0IGVuYWJsZSB0aGUgZXJyb3INCj4gcmVzcG9uc2UgdG8gQVhJL0FIQi4NCj4gPiA+
DQo+ID4gPiBUaGF0J3MgZXhhY3RseSB0aGUgY2FzZSB3aXRoIERSQTd4eCBhcyB0aGUgZXJyb3Ig
cmVzcG9uc2UgaXMgZW5hYmxlZA0KPiA+ID4gYnkgZGVmYXVsdCBpbiB0aGUgcGxhdGZvcm0gaW50
ZWdyYXRpb24uDQo+ID4NCj4gPiBHb3QgZmVlZGJhY2sgZnJvbSB0aGUgaW14NiBvd25lciB0aGF0
IGlteDYgbGlrZSB0aGUgZHJhN3h4IGhhcyB0aGUNCj4gPiBlcnJvciByZXNwb25zZSBlbmFibGVk
IGJ5IGRlZmF1bHQuICBOb3cgaXQncyBjbGVhciB0aGF0IHRoZSBwcm9ibGVtIG9uDQo+ID4gYWxs
IHRoZXNlIHBsYXRmb3JtcyBpcyB0aGUgc2FtZS4NCj4gDQo+IE9uIElNWDYsIGVuYWJsZWQgYnkg
ZGVmYXVsdCBhbmQgcmVhZC1vbmx5ID8gT3IgaXQgY2FuIGJlIGNoYW5nZWQgPyANCg0KVGhlIEFY
SS9BSEIgQnJpZGdlIFNsYXZlIEVycm9yIFJlc3BvbnNlIFJlZ2lzdGVyIGlzIGEgY29tbW9uIHJl
Z2lzdGVyIG9mIERXQyBJUCwgc28gSSB0aGluayBpdCBzaG91bGQgYmUgd3JpdGVhYmxlLiBSaWNo
YXJkLCBjYW4geW91IGhlbHAgdG8gY29uZmlybT8NCg0KPiBXaGF0J3MgdGhlIHBsYW4gZm9yIGxh
eWVyc2NhcGUgb24gdGhpcyBtYXR0ZXIgPw0KDQpJIHRyZW5kIHRvIGNoYW5nZSBpdCBiYWNrIHRv
IHRoZSBkZWZhdWx0IGVycm9yIHJlc3BvbnNlIGJlaGF2aW9yIHNvIHRoYXQgd29uJ3QgY2F1c2Ug
YW55IGVycm9yIG9uIENGRyBhY2Nlc3MsIGFuZCBoYXZlIHNlbnQgb3V0IHRoZSBwYXRjaC4NCkFu
ZCBmb3IgdGhlIGxpbmsgdXAgY2hlY2sgYmVmb3JlIENGRyBhY2Nlc3NlcywgaW4gdGhlIERXQyBk
YXRhYm9vdCAoNC40MGEpLCBpdCByZXF1aXJlcyBsaW5rIHVwIGNoZWNrIGJlZm9yZSBnZW5lcmF0
aW5nIENGRyByZXF1ZXN0cywgc28gbmVlZCBHdXN0YXZvIGhlbHAgdG8gbWFrZSBzdXJlIHRoZSBy
ZWFzb24gb2YgdGhpcyByZXF1aXJlbWVudCwgYW55IHBvdGVudGlhbCBpbXBhY3Qgd2l0aG91dCB0
aGUgbGluayB1cCBjaGVjay4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCj4gDQo+IExvcmVuem8NCg==

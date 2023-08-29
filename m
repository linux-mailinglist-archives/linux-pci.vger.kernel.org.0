Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AEB78C405
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjH2MO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjH2MOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:14:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C623E47;
        Tue, 29 Aug 2023 05:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2cpaEzJT0KYq9kGCRU+wxhmpoh51q05ZfPh2EyJWITxXui2oQSebyhuSUQvK8l6rscJO7dcS/5E2hEulcIMgpJbuUGez1s9Pji4CcTgH0MrX/+wdSz0jlZppQrRZ64TYbW5qKDVXBMb+ylUrkxw4uAxnmyyIABEkuRDGMa2Cte8n50SkAlAIA5X1uAqpQVN+3WOzwFA0F7mQiUEZr6IbewPATd8iwhz9Th156ve8hUKISX6XtBAHEsHLzya9R4PKrwO/d0k0fRsPxlEOIN98Du/FE7e5Pd19YtiYuJx6pHoHZIyhaKOEUnjoKKwACe5/0n1yvfmnGzaCiD33IiuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PooSQ1ktejLHxYUt85YnHjZvEtW//y964AsDWFpuefI=;
 b=jH0cbGEa/ihstXPCmtG/Ks3emPelixymjVHmPy9bBMCPSlHmf1HD1yesgp/lCmRapZrkB6rFsjsxjJsuQgZ9VPQ4Oz2HpExrYrMBtw0LhhrpTP8CX3RjOBI6R6QRp3roRYr+H3MfYRZnPqvVWYGf/bXTl/cgpmgIWf+vK0HtGQn9SOqQNW1bRXk4TJW8nzRJLo6e0lEsEddcDTjAe2xMEV+J07xqqR/xGPolMWL30Fsb0/f47MutFFimnTZ/RO3imAmTDBOKFcLjDVXh7i+iQYE9EOCrZf2a/uYxCR26UAEMLaI+ePW02/164yGZYo90oWkdr36H0OzYSm1hobtLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PooSQ1ktejLHxYUt85YnHjZvEtW//y964AsDWFpuefI=;
 b=EZSQqQIvo+1Z63i6mWPGCCAWznMbb3gBK/0fsbIqdk1dXT0ISNHMQ5AYBTkuUiaBL43Pz/XUiMAjSxwyMnpFjpTfkE0l3N7kbh31SOdgnKSbhR9eQC4PExKolQ/Q34poh1NA6TPRG8+BRnbaHngPqeKKCd2CtO5IB2dEHTw4tpI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6009.jpnprd01.prod.outlook.com
 (2603:1096:402:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 12:13:47 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 12:13:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZ1zcNtDThJaZvc02SH965eUO1lK/7VSoAgAJkVICAAS3c4IAA/aAAgAFPoAA=
Date:   Tue, 29 Aug 2023 12:13:47 +0000
Message-ID: <TYBPR01MB5341688733F76889463AD504D8E7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
 <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230828160712.GA2127814@rocinante>
In-Reply-To: <20230828160712.GA2127814@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6009:EE_
x-ms-office365-filtering-correlation-id: 7c64a5c5-e0f9-448e-c79e-08dba88965d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDLETmO4xzTrzlLJN4jkFHT1emqFWxM3rPG0bCRgLN3yetsuhS3JVgQuYe68KTEzGqqeGFOpLxonQBkiW/XsvrRvXobdXoclZ69sgDUcxHK1zL/HkipFfniRo1sKXtCzDA9U7NCeANYZ0L75RrtGjU4d+z/Ni48TbLfuW6g85QEW06TPuaE49PycWINpE7FM0GzAajltU9aM0zaUHyEuiC59PcQL/sgpcCEJRj9yMUFHyauxgwYA3w3Qmz/vHd+NfwOuFyhmcQnbVaccaDwD+Fvf0QmwCWoBI56ZDsxRQWrrjnSGA9tUL5G5Pgah86RjXfb2setX0o7xV49ZddDdo/6U/vnEc5FMoBFEavVx5GjO3CZEFDXKKzoV4D2dWDsBaJ9mUjJGcvWvzRUTSgHu906GGPMF6zHhfcN1/n1FzSF6rehim8Wn+XPQNRmsP2pxdpmcKdUDoXP1YRObB/wtl1j9uqK7SrHneKaezEffqUBMAJ/O5SqCFflWex8xxgLQi9HQLh6t64WtBscmBF2MVgm+KI8dA1aPWMCOTkAYCt86qjkuATM+dkQY8TQG+4jEqrp+FC5kRmG+zjxE8sBTCIZ6veJmWKLc0DstdqbDs3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(451199024)(186009)(9686003)(38100700002)(38070700005)(316002)(6916009)(41300700001)(4326008)(33656002)(7416002)(66574015)(2906002)(83380400001)(86362001)(52536014)(26005)(5660300002)(8676002)(55016003)(8936002)(71200400001)(6506007)(7696005)(966005)(66446008)(66476007)(66556008)(64756008)(54906003)(76116006)(122000001)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VoUXJ4aEtBRUlxVzlFQm5jRTRGeUZMa3hTaVZsc25IUHUyRTI4eUdFQ2Rx?=
 =?utf-8?B?d2UveGZ5YWlkMTBSMmdvT1YybE40OUZGWmp6L3VTMm5YcGhLWlBNYzRWUXRl?=
 =?utf-8?B?QWVNZURkRE1TUnI2dUNTSFdyTWNTanVsd0Uxc2tBRmJCbUx4Wi9XM3h6TG9a?=
 =?utf-8?B?eWluT2I4TVMxdVBxNzA2MytNeWE5R0dyVGtKNkxMZHVQWW9ZTjdELytieVdo?=
 =?utf-8?B?bEQ0V2FwVXI3ZEt3YndSaXNkQU9UZEpQcVQ3U3FySHEwekVnbjlkdjhvRXNn?=
 =?utf-8?B?YVFwWnE4aHVqV3lFU2dSRjVhY2c2d0NDYmhCNnNCMXg2ZGhReFhRWmJsbytm?=
 =?utf-8?B?K1h0cEl3VWRGbStGSGdsVXRJTVhJUXkvaWRWVGNXTW8rbmwrSlFYZEJBRElO?=
 =?utf-8?B?ckFRN3FNbXQvaXhWTGxmVkhQTEROMEZBdVFMQ0gyZGs0RUdIN1hVSU5XVUNR?=
 =?utf-8?B?ZUJwV1Y5YlA5MWQwMFY1UW5hTkY1anFoNU0rRmlPelhkQlp5aGRZV0gxeHhu?=
 =?utf-8?B?dzhmdHpoYzBnOXZac0VWZUZOL3hSdzBUWmVXRFJFaS9KSjdBeFIyZkFxbkEr?=
 =?utf-8?B?Z0w2aGV3OXRYZTRUSEs1bnVZcFJDbU92T3picDJEMXlkbTVyNXd5RDhWVFZC?=
 =?utf-8?B?QVhYTXVPZ1NvSHdXL1IvOG90dGlXb3diMG1nRUNKTUtZajFnMVB3OTVRWHE5?=
 =?utf-8?B?REY1aGNnL1FFek5UQ3RmNUI1cllSLysrcGh0MGpuSlAzbHlLeG9OL0h0cEN5?=
 =?utf-8?B?UWk1QzRJL1p2VEY0UEZ5K0lEaWF6NDRqOEZPTUc1a3d5VmRsaHVyVzk2bWZq?=
 =?utf-8?B?M1FJWEI1MytKZ3ZlNTdjdFBodkhZZ005U3dzMzJXQVprMDlUa0Z4K3gwVlJj?=
 =?utf-8?B?ZWdvU0RPTzhubnhkZ2pEQVZmWTNYSm1qY0RNL1hkc0UzRVFHVUZvbE15eDBI?=
 =?utf-8?B?QktXWHAwbXZISFJSSXBMU3BHNFVUSWIzVWRQbXVCWTdoQWhiTFl4OTV1bTdV?=
 =?utf-8?B?bmlhVXA2YlZzY3g1Szg2TmFoTEphUmltMjF0NUxwRWc1eVRhNzVXTUhiM2l2?=
 =?utf-8?B?Z1huZDhNUG1qV0MwdW5KZlh2bHJUYXpLUk5lS0NrS2lGNXB4NFh4TFZleFl6?=
 =?utf-8?B?SEp5ME11QUJQU3ZDOFhHeTlWbEdFTDc2SFpaS3ZYTVN5V3RnTEh5R2Fpeko4?=
 =?utf-8?B?dy83R1VEekpMOWx5RUlQL2ljc2E2OVc4Q1ZnNUdtSmNxb0hMOUN2Y2dOTnBh?=
 =?utf-8?B?YVM1OXFyeDNvSGhVSjFOcmNkOXlhUkFtV0dSdVJLam91Y0ErdXY3M0ZNdXQ4?=
 =?utf-8?B?ZWRud0Qwc0dLUUNJZEtKWnZvU1E4NE1tVFRhSjhXUjZZdnIwR2VycTZiY1h4?=
 =?utf-8?B?NVRNQWlKWGFUZ2FlTzFvOEYzUFFiWWJqZ09vY2lobWx0a2tXK0FFdGtQalhv?=
 =?utf-8?B?ekpRZ3lOeGJLWnNrYlcyTGlmeFBuSWZhYlVGTzVOUElTS3Q0dGlVYmhGYVRR?=
 =?utf-8?B?WW5RcHJZMmc0M25nLzJRR2pJUFF1cDJGNEZZaTM3V3pOYjBpdkhtRDJGSEZp?=
 =?utf-8?B?NjRNaUVpeDJHOW1hY2xTOXBQN2xsaDdZcis5STNYVFQwVmFtRzFMSHBNWGlm?=
 =?utf-8?B?OWUyRlpvMzNXK0h4RTUrMGd6M1hGdlhFZkJwb1o4bkxsTnJEUWRUY2MwbXIv?=
 =?utf-8?B?cnFSVDR5MGgxaHI1cFBKMmlqVk1tOS9YM0tpWDJSREloc21Nc0JyQVZzYnFE?=
 =?utf-8?B?MVpjN1pDVERKTTUrSklsZlppRktKR09MOFFocGNaTEthWm5Ybm1IcTd1Rnlp?=
 =?utf-8?B?UjNYbDd3YlFIek5LaFV4SENXQk5KcVg3SHFISEJ0YXRvTkNtSUlzbVdWUkNn?=
 =?utf-8?B?M1oxdzBpRlJsdzR6aUNWSjVjQ0NSRStFVEFndUx0Mi9XTVNPd3dZbWc0ajQw?=
 =?utf-8?B?QkM4MXk1eERob0dRSHZjNllUWU5NVW0vT0RrR08ySGluU2EyTWpIdGJHUHBh?=
 =?utf-8?B?OU5zaFpweFdQRzRuTnJQcTdyWERDQlVNR24zbzB0bWJhMUM0VFdsSEo3Ty9N?=
 =?utf-8?B?SnVHYUhubEZqZUpZUGg3S3FFYk1SRzZFVWtua2p3VDdiOFVWWW01UW5SRDFL?=
 =?utf-8?B?REtXL1lvSHl1VnJLVTFjSkFKUDRLMEFFNHpnK1lUcVhrTjF6VXlDNTNGYTdY?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c64a5c5-e0f9-448e-c79e-08dba88965d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 12:13:47.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+HO5R0qSm8D5O8hkUQl7PK6ca+CaVLJmB1rxlzY+P409oQv+h7/n9URxpa1J/Ptv2HYdqXFM36weSD6fAHLH5FHYkvTt11/yFA4t0aWy+1hotWPaPGfPuhV5J38yO/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IEZyb206IEtyenlzenRvZiBXaWxjennFhHNraSwgU2VudDog
VHVlc2RheSwgQXVndXN0IDI5LCAyMDIzIDE6MDcgQU0NCj4gDQo+IEhlbGxvLA0KPiANCj4gWy4u
Ll0NCj4gPiA+IFRoYXQgc2FpZCwgc29tZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMgZG8gbm90IGFw
cGx5IGNsZWFubHkgYWdhaW5zdCA2LjUtcmMxLA0KPiA+ID4gc28gSSBuZWVkIHRvIGhhdmUgYSBj
bG9zZXIgbG9vayBhIGxpdHRsZSBiaXQgbGF0ZXIsIGhvcGVmdWxseSBJIHdpbGwgYmUNCj4gPiA+
IGFibGUgdG8gZ2V0IGl0IGluIHRpbWUgYmVmb3JlIEJqb3JuIHNlbmRzIGhpcyBQdWxsIFJlcXVl
c3QuDQo+ID4NCj4gPiBJJ20gc29ycnkgZm9yIGJvdGhlcmluZyB5b3UgYWJvdXQgdGhlIGNvbmZs
aWN0IGJlY2F1c2UgbXkgcGF0Y2ggc2V0IGlzIGJhc2VkIG9uIHBjaS5naXQgLyBuZXh0LA0KPiA+
IG5vdCA2LjUtcmMxLi4uIEJ1dCwgYW55d2F5LCB0aGFuayB5b3UgZm9yIGFwcGx5aW5nIHRvIGNv
bnRyb2xsZXIvcmNhciENCj4gDQo+IE5vIHByb2JsZW0hDQo+IA0KPiBUaGF0IHNhaWQsIGl0J3Mg
YWx3YXlzIGEgZ29vZCBpZGVhIHRvIGNoZWNrIHRoZSBtYWluIGJyYW5jaCBmcm9tIHRoZQ0KPiBm
b2xsb3dpbmcgdGhlIHJlcG9zaXRvcnkgdG8gc2VlIHdoaWNoIHZlcnNpb24gdG8gd29yayBhZ2Fp
bnN0IGlmDQo+IHBvc3NpYmxlLiAgUENJIGRldmVsb3BtZW50IGxpdmVzIGF0Og0KPiANCj4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGNpL3BjaS5naXQN
Cg0KSSBjaGVja2VkIHRoYXQgdjYuNS1yYzEgKyBjb250cm9sbGVyL3JjYXIgKyB0aGUgZm9sbG93
aW5nIGR0c2kvZHRzIHBhdGNoZXMNCkkgaGF2ZSBzdWJtaXR0ZWQgWzFdIHdvcmtlZCBjb3JyZWN0
bHkuIFRoYW5rIHlvdSBmb3IgeW91ciBzdXBwb3J0IQ0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDIzMDgyODA0MTQzNC4yNzQ3Njk5LTEteW9zaGloaXJvLnNoaW1vZGEudWhA
cmVuZXNhcy5jb20vDQoNCj4gPiA+IOOCt+ODouODgOOBleOCk+OAgQ0KPiA+ID4NCj4gPiA+IOS4
gOmAo+OBruOCt+ODquODvOOCuuOBiueWsuOCjOanmOOBp+OBl+OBn++8gQ0KPiA+ID4g54m544Gr
44CB5L2c5qWt44GM5bCR44GX5YmN44Gr6ZaL5aeL44GV44KM44CB44Os44OT44Ol44O844GV44KM
44KL44G+44Gn44Gr5pmC6ZaT44GM44GL44GL44Gj44Gf54K544GK5omL5pWw44KS44GK44GL44GR
44GE44Gf44GX44G+44GX44GfDQo+ID4gPiDlhajjgabjga7opoHmsYLlpInmm7Tjga7ov73liqDj
gavjgZTljZTlipvjgYTjgZ/jgaDjgY3jgIHjgYLjgorjgYzjgajjgYbjgZTjgZbjgYTjgb7jgZnj
gIIg5YCL5Lq655qE44Gr44KC5pys5b2T44Gr5pyJ6Zuj44GE44Gn44GZ44CCDQo+ID4gPiDjgZTm
i4XlvZPjgYTjgZ/jgaDjgYTjgZ/ku5Xkuovjga/ntKDmmbTjgonjgZfjgYTjgoLjga7jgafjgZfj
gZ/jgIIg6YeN44Gt44Gm44Gr44Gv44Gq44KK44G+44GZ44GM44CB44Gp44GG44KC44GC44KK44GM
44Go44GG77yBDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudCBpbiBKYXBhbmVz
ZSENCj4gPiDjgZPjgaHjgonjgZPjgZ3jgIHjgYLjgorjgYzjgajjgYbjgZTjgZbjgYTjgb7jgZfj
gZ/vvIENCj4gDQo+IFN1cmUgdGhpbmchICBHcmVldGluZ3MgZnJvbSBZb2tvaGFtYS4gOikNCg0K
T2ghIFlva29oYW1hISBJdCdzIGEgbmljZSBjaXR5IDopDQoNCkJlc3QgcmVnYXJkcywNCllvc2hp
aGlybyBTaGltb2RhDQoNCj4gCUtyenlzenRvZg0K

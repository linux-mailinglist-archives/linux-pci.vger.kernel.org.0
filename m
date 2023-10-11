Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B357C4901
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 07:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjJKFGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 01:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 01:06:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC95B7;
        Tue, 10 Oct 2023 22:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtSepLtDxYUXLO3YGxtoNtxG++q7HJW6+lmw7hGZoGwJHXYUrgOUNrAJKzMDHvQxaO4wDNp5NIzjwoy6kWLaokKjDjORtCpngDYZ6r7s4cFyZBAS4DVr+P+Y3pW5sCY+yf3t3NraoRbhMmcYisNxDz80h7FlbCr0hkEDwSPrCRMNSOuEOfmM0qzrrKBdgoiZSs/uEG53jvli3pQpK3OqDC4ItDOl+UCVV3/EA4Cd0zp1lb+HAY+a8L5RJxbTwfGp6OGvYTtcSvOHW29tF0bfZNPgOpgSRD0j3BJ+qZnKI16lAQl3AIXLM84//QOYogQM+fptoWSVJsD2iQOCQxpFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjtFzHRZTT1X3yw9r55mO9TM8EFw45oGsUpXUqneRxY=;
 b=mpwv8XhJJUe15440gkcL8bZ0HNl/UasOESi88NNuCxfGqKIthpifzDsYW1lEVMxt7y12sXZNvsk95Hdw6enkk2oQqPVfSjUbqHCGxtkiSZe6ZBlVUKVgnerlmJ6/1jiof8wLsH5p560e4Sz3oiFFz/8qlKL7Ym3xodT9MDV8YlwCQ76vYgjO5SFmXbm4n3KLxaYVdHjO9+GgZUyPsxXYMnJeuSXjZ34R6Y6tu1tVWyOrbd2w0xVaDwWN9IFYukHCAu66r5kA0d5uUGczdpqNbnw2qRefPKF8xBBMYEOnu6Ra2Ym5Ott6eHi0Ycu8PdTb7Wpi8bAid7JSNzd8z5fIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjtFzHRZTT1X3yw9r55mO9TM8EFw45oGsUpXUqneRxY=;
 b=G3bGeDIG2BWMZZE/Wy21En04BzX3hQca8i2c+tPr3s2kmu3rrlytb3FZcaemCirI7z9kzMY9xmYTPfpngtV8ObX6ykwGBv1hr7lKUaRIa5L5791KQt8mYzBmWlnV1XTa4kbTAoPEswLroTZNBBdooSMTiDIHGwhaMbxrrAROmIM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11220.jpnprd01.prod.outlook.com
 (2603:1096:400:3d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 05:06:43 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 05:06:43 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: RE: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Topic: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Index: AQHZ7SGG731ZoKcWlUmOj881Ilc+nrBDCYuAgADXsZCAAD75AIAABixQ
Date:   Wed, 11 Oct 2023 05:06:43 +0000
Message-ID: <TYBPR01MB53410004963526A6FB68722BD8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-14-yoshihiro.shimoda.uh@renesas.com>
 <20231010120421.GG4884@thinkpad>
 <TYBPR01MB5341F9721774B5993EB4B912D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231011044144.GA3508@thinkpad>
In-Reply-To: <20231011044144.GA3508@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11220:EE_
x-ms-office365-filtering-correlation-id: 008a0884-7397-43aa-95fb-08dbca17dc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nw2sEG7VsdT750vM81mBhBCef3Atw5Bmb3FMSXPcc022sCecpRm1bdjQ1wt7aEfPHAE0gqNAeKIlucgtxpooDQkD8dIjjsNwnssi40OIcDiTjiuXWe83ufpLIm6X8sK06hxJb3dozs4Iw5ic2rVRg0dHxTlaKXt1npkslGGsWQaY/kvdOa6LnfFzA+t9FPJ+wK2YQMzui+nI73n9UU7ZY/dkyoWBNcmSS8qNfqZTVR4/ymSiwA+bBTPzynHlP4hkDYI3yb99An/vJNgUrboFDmHEruwYUFyDRiL85yd44kdHLApfUFida02WNpNl0UYqFuqDlZVOg8eBwUkRz/lT52G5bmZ+1qUHinKWGCPBNiUfwAtX9vDNPQ5J9KHhf8byeCIojVR94FLUYcK811NpvS98qKKi/oiSWDYS11jQyZgqE8sLROGkaU8oDmEo3s3Duc7d86LZIO3x0shwh6VBpbglh72xMTc9VHmwGg13SdSI9+TZEAVJSHjP8ORWEQevRHPH0ZxuKRjT5X8T4tkulZIDf4drQu96/Dk3W2EC3c0QuFa2+4q/wLlNA53wN60RQ15ld//Yvw0QFqDZ35rsILh+4NULTJwMbEmwZwfAvMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66899024)(2906002)(33656002)(86362001)(55016003)(38100700002)(38070700005)(122000001)(4326008)(8936002)(8676002)(66574015)(71200400001)(966005)(9686003)(6506007)(7696005)(6916009)(41300700001)(316002)(7416002)(66446008)(76116006)(66476007)(54906003)(66946007)(64756008)(5660300002)(83380400001)(478600001)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUJjV2RMa1ZFbGJOYllrUTM5NHRKVDhKWWpQS0NnRURoQjFkSnd4WWJVek1E?=
 =?utf-8?B?YVJHazRQOG9XZzVrVjlYZFVTYkNXdlNnZDVsU2tqYTh1b0pOamZLVXZuNzBu?=
 =?utf-8?B?L0xUNHNVYjI1WFdmMTdSMlRxN3pyRGxvei9hWStzUUxDOU94cEZsb1gxTXcw?=
 =?utf-8?B?bHM4MjJNVzhXNCt4Z2ZJREpuenJjeXA0Mmp3OXJmd2g5ZnpidGtzWW5YSHJN?=
 =?utf-8?B?b0JVSkg3UUNtODlLZGN3ZGcxakU2SVZpaWtCemZsOElFUVNzNVZBcEg4cVJK?=
 =?utf-8?B?UkhEOS95WkxCUWE2Ky92cGMzS1RDV05rTjNBbEZXMnBQVUg1c05kUU4xWkN4?=
 =?utf-8?B?VTFTK1k4RGloWmRBMWZ3ZkNTcExPaWVFUW5FUWxWbmQzNzlWRk1DalVFTlBW?=
 =?utf-8?B?ZWhqM3FRWDJkZExEYndMVHBDRU8yMmE3aVhGY1M5UlNWNmdMOFRrMGdyR1Iz?=
 =?utf-8?B?b0FXeHNXWklaSzdJYzZhaUhMTFA1TnlmWjAybi81ZmJhSzVodjlNUlV6U1d6?=
 =?utf-8?B?VjMrZ1FTZFFqSGUyb1Q2eFk3cnZYd0JnLzJub1dhbUg3dGMwaXNFMEh2VnMy?=
 =?utf-8?B?cUdOMkVSUGx5cEI5UmhmRHBsMUtXRUtEYktiMlY1TGVkK0VwOEZGaXpqZFhi?=
 =?utf-8?B?NUdRK3BzcmtUOFBaZGdLTmRCZ1J3dlk2cU9JU3ZSSXlmUlh2UEkvMkNmZDQ0?=
 =?utf-8?B?ckxsRlBwUkk3emxDQ0kvY3ByWXZKd1k0R1dBS1pnT0dpVFRUTVJhZ0JYM083?=
 =?utf-8?B?R0ZyQ2pnbTk3SkIwODBoZVg1UzVoSTgrK20wV05vK0N5REl3c3l2SFNHYnlH?=
 =?utf-8?B?WlZMOGZEUktVSnVsUlc3dGUrUzB3QjVqbEg1eDd0ZlNzRXloTVRvRUxZZ3Zz?=
 =?utf-8?B?UWxjTXRUT3QvWjdYUHhXaEZKekdCQlh4cGgwdlhEQmVZNElJRWZHMERIUmN6?=
 =?utf-8?B?SmRuSXNBeG0vZktDTU9nVnlwa0xSWG5EYW82V3JWQUJUOE5nd1RndUxkNldL?=
 =?utf-8?B?ZzM3amEvNmtoOGlPS0pVdGM0NnRYZnhwNDh4N2NWakRoNHYzMDBIUDc5WnNF?=
 =?utf-8?B?ZUVOQityMUE4U09tajAweHhXcmZ4ODgvUEswRTNESlJCd1F3WVRyOWtXbW0r?=
 =?utf-8?B?NDRPaXl1RkdoUmtCaEU5elA3b0c5TVpkNVYxUHdITjU4MXdNQzZNcnRJNksr?=
 =?utf-8?B?RXhXN1NVZk0rZmhKaTV1ZUF4aDFGVStTQ0xNZ2FhNVdIQTljR0IxMlBJcXdM?=
 =?utf-8?B?SlFpcWFuZFdRUGdFZVBuNFFtNHVFR3lZSmcySmFPYkh1d0l4WUtrWG1FR0cx?=
 =?utf-8?B?NXlnTGZpZGZ5bG1uT0oxOGtxVlhiZFZsR0JzSjRtQUgyenRLc3dWZTE5Mldl?=
 =?utf-8?B?ZmVCaTZ5d3FZNWZuaWRNemJFQjBZRnllUmJLVnRTcWdoZTJWdXlyaUJLdngz?=
 =?utf-8?B?QjVnVlRhTzJDZTZEZ3g1YVUvRjNSRmp3WWlXRjk4U21YVVcrZnVNNVdqdHJ2?=
 =?utf-8?B?RlRzSWMvTEZOR243cUkwYXdDcnFBMWtQaE5kdTMwMmhySStRZUpQNmJEdnlS?=
 =?utf-8?B?Ty9kaGtPVXlKTnNQdmdZK1Z4WTdMRE03amE0bHdSZmF1NXdIcUx2MVNBUUpQ?=
 =?utf-8?B?SnBiZHY4TlJEK0ptSVRDcE1ibm1EUDRTSEF1ZTB3V3kvQmdZMTU3NWMxbnlN?=
 =?utf-8?B?aU9qNGtWbG9PVGxSellOakRlUWV5N3hGT1JWalVvUXpKUlBLUlBTanFZZmtD?=
 =?utf-8?B?c2hidDI1b1VRZXJnZERpVjBpY21aR1NHVGNJVTJaNWtGTWlIbEh6WjA2NUl3?=
 =?utf-8?B?TGhrRFhzbmFyVGdTM2tTUUxqenI3RlkzWjFjOXJUK2RHZHdLWDBLZUpFWlZZ?=
 =?utf-8?B?S1FUK3pKOUdVM2s4K2YwanJCNGdDaGdFZ2E5TjRQK0JSSWRBTkpnd2dpbFpZ?=
 =?utf-8?B?UDM5bmg5YStjaTlpUVN6blAzQStuUlk5K3ZlYkVGRDlDTUtOSkEzaTNrTkVH?=
 =?utf-8?B?QWlLbUdKdXdxa2tMSGxKTHhLZXphVmtjaVRLOHM2Z3FHRjB6VjVDNDJNczJG?=
 =?utf-8?B?a3VuN3JnWG40VTN6WGpNNWYzajNYT1hOZGFQckJpUllRanlLWHltRkFJb0FV?=
 =?utf-8?B?R1FkSnd2SXZoS3BjQk1XcVRFbHd5bFBsQkEvcWI4M0tyZTZmMHFVaVE1YTZU?=
 =?utf-8?B?djZiWjZ4WDFlenBGOFNNcHJQcUJGRWJ2cFJjZzlvNkFwQStodUt0eWhlNjBX?=
 =?utf-8?B?SVlGY3NnRG8vREp5VlROeDhBcTFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008a0884-7397-43aa-95fb-08dbca17dc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 05:06:43.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFwwByjtwEuX4Zc/t3iLeaRaPdza/5halNz6c4PMlOi5J1UygAvgYAVeAe339/PGoacq2ypbcdE/lUJ5ImLGaA/T2LKnrsqyK6dlb5GUjQAFbx9R4nEeHwPS+us+CpCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAxMSwgMjAyMyAxOjQyIFBNDQo+IE9uIFdlZCwgT2N0IDExLCAy
MDIzIGF0IDAxOjE4OjExQU0gKzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhl
bGxvIE1hbml2YW5uYW4sDQo+ID4NCj4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSwg
U2VudDogVHVlc2RheSwgT2N0b2JlciAxMCwgMjAyMyA5OjA0IFBNDQo+ID4gPg0KPiA+ID4gT24g
RnJpLCBTZXAgMjIsIDIwMjMgYXQgMDM6NTM6MjhQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEg
d3JvdGU6DQo+ID4gPiA+IEFkZCBSLUNhciBHZW40IFBDSWUgY29udHJvbGxlciBzdXBwb3J0IGZv
ciBob3N0IG1vZGUuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgY29udHJvbGxlciBpcyBiYXNlZCBv
biBTeW5vcHN5cyBEZXNpZ25XYXJlIFBDSWUuIEhvd2V2ZXIsIHRoaXMNCj4gPiA+ID4gcGFydGlj
dWxhciBjb250cm9sbGVyIGhhcyBhIG51bWJlciBvZiB2ZW5kb3Itc3BlY2lmaWMgcmVnaXN0ZXJz
LCBhbmQgYXMNCj4gPiA+ID4gc3VjaCwgcmVxdWlyZXMgaW5pdGlhbGl6YXRpb24gY29kZSBsaWtl
IG1vZGUgc2V0dGluZyBhbmQgcmV0cmFpbmluZyBhbmQNCj4gPiA+ID4gc28gb24uDQo+ID4gPiA+
DQo+ID4gPiA+IFtrd2lsY3p5bnNraTogY29tbWl0IGxvZ10NCj4gPiA+ID4gTGluazoNCj4gPiA8
c25pcCBVUkw+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3J6
eXN6dG9mIFdpbGN6ecWEc2tpIDxrd2lsY3p5bnNraUBrZXJuZWwub3JnPg0KPiA+ID4gPiBSZXZp
ZXdlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcgICAgICAgICAg
fCAgMTQgKw0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUgICAg
ICAgICB8ICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJj
YXItZ2VuNC5jIHwgMzgwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDM5NSBpbnNlcnRpb25zKCspDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYw0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiA+ID4gaW5kZXggYWI5NmRhNDNlMGMy
Li5iYzY5ZmNhYjJlMmEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL0tjb25maWcNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
S2NvbmZpZw0KPiA+ID4gPiBAQCAtNDE1LDQgKzQxNSwxOCBAQCBjb25maWcgUENJRV9WSVNDT05U
SV9IT1NUDQo+ID4gPiA+ICAJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IFBDSWUgY29udHJvbGxl
ciBzdXBwb3J0IG9uIFRvc2hpYmEgVmlzY29udGkgU29DLg0KPiA+ID4gPiAgCSAgVGhpcyBkcml2
ZXIgc3VwcG9ydHMgVE1QVjc3MDggU29DLg0KPiA+ID4gPg0KPiA+ID4gPiArY29uZmlnIFBDSUVf
UkNBUl9HRU40DQo+ID4gPiA+ICsJdHJpc3RhdGUNCj4gPiA+ID4gKw0KPiA+ID4gPiArY29uZmln
IFBDSUVfUkNBUl9HRU40X0hPU1QNCj4gPiA+ID4gKwl0cmlzdGF0ZSAiUmVuZXNhcyBSLUNhciBH
ZW40IFBDSWUgY29udHJvbGxlciAoaG9zdCBtb2RlKSINCj4gPiA+ID4gKwlkZXBlbmRzIG9uIEFS
Q0hfUkVORVNBUyB8fCBDT01QSUxFX1RFU1QNCj4gPiA+ID4gKwlkZXBlbmRzIG9uIFBDSV9NU0kN
Cj4gPiA+ID4gKwlzZWxlY3QgUENJRV9EV19IT1NUDQo+ID4gPiA+ICsJc2VsZWN0IFBDSUVfUkNB
Ul9HRU40DQo+ID4gPiA+ICsJaGVscA0KPiA+ID4gPiArCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2Fu
dCBQQ0llIGNvbnRyb2xsZXIgKGhvc3QgbW9kZSkgb24gUi1DYXIgR2VuNCBTb0NzLg0KPiA+ID4g
PiArCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTog
dGhlIG1vZHVsZSB3aWxsIGJlDQo+ID4gPiA+ICsJICBjYWxsZWQgcGNpZS1yY2FyLWdlbjQua28u
IFRoaXMgdXNlcyB0aGUgRGVzaWduV2FyZSBjb3JlLg0KPiA+ID4gPiArDQo+ID4gPiA+ICBlbmRt
ZW51DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtl
ZmlsZSBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+ID4gPiA+IGluZGV4
IGJmNWMzMTE4NzVhMS4uYmFjMTAzZmFhNTIzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiA+ID4gPiBAQCAtMjYsNiArMjYsNyBAQCBvYmotJChD
T05GSUdfUENJRV9URUdSQTE5NCkgKz0gcGNpZS10ZWdyYTE5NC5vDQo+ID4gPiA+ICBvYmotJChD
T05GSUdfUENJRV9VTklQSElFUikgKz0gcGNpZS11bmlwaGllci5vDQo+ID4gPiA+ICBvYmotJChD
T05GSUdfUENJRV9VTklQSElFUl9FUCkgKz0gcGNpZS11bmlwaGllci1lcC5vDQo+ID4gPiA+ICBv
YmotJChDT05GSUdfUENJRV9WSVNDT05USV9IT1NUKSArPSBwY2llLXZpc2NvbnRpLm8NCj4gPiA+
ID4gK29iai0kKENPTkZJR19QQ0lFX1JDQVJfR0VONCkgKz0gcGNpZS1yY2FyLWdlbjQubw0KPiA+
ID4gPg0KPiA+ID4gPiAgIyBUaGUgZm9sbG93aW5nIGRyaXZlcnMgYXJlIGZvciBkZXZpY2VzIHRo
YXQgdXNlIHRoZSBnZW5lcmljIEFDUEkNCj4gPiA+ID4gICMgcGNpX3Jvb3QuYyBkcml2ZXIgYnV0
IGRvbid0IHN1cHBvcnQgc3RhbmRhcmQgRUNBTSBjb25maWcgYWNjZXNzLg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMNCj4gPiA+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5kZmZmNmJiMTg5MzIN
Cj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ID4gKy8qIEhv
c3QgbW9kZSAqLw0KPiA+ID4gPiArc3RhdGljIGludCByY2FyX2dlbjRfcGNpZV9ob3N0X2luaXQo
c3RydWN0IGR3X3BjaWVfcnAgKnBwKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBkd19w
Y2llICpkdyA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7DQo+ID4gPiA+ICsJc3RydWN0IHJjYXJf
Z2VuNF9wY2llICpyY2FyID0gdG9fcmNhcl9nZW40X3BjaWUoZHcpOw0KPiA+ID4gPiArCWludCBy
ZXQ7DQo+ID4gPiA+ICsJdTMyIHZhbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWdwaW9kX3NldF92
YWx1ZV9jYW5zbGVlcChkdy0+cGVfcnN0LCAxKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldCA9
IHJjYXJfZ2VuNF9wY2llX2NvbW1vbl9pbml0KHJjYXIpOw0KPiA+ID4gPiArCWlmIChyZXQpDQo+
ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiAr
CSAqIEFjY29yZGluZyB0byB0aGUgc2VjdGlvbiAzLjUuNy4yICJSQyBNb2RlIiBpbiBEV0MgUENJ
ZSBEdWFsIE1vZGUNCj4gPiA+ID4gKwkgKiBSZXYuNS4yMGEsIHdlIHNob3VsZCBkaXNhYmxlIHR3
byBCQVJzIHRvIGF2b2lkIHVubmVjZXNzYXJ5IG1lbW9yeQ0KPiA+ID4gPiArCSAqIGFzc2lnbm1l
bnQgZHVyaW5nIGRldmljZSBlbnVtZXJhdGlvbi4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlk
d19wY2llX3dyaXRlbF9kYmkyKGR3LCBQQ0lfQkFTRV9BRERSRVNTXzAsIDB4MCk7DQo+ID4gPiA+
ICsJZHdfcGNpZV93cml0ZWxfZGJpMihkdywgUENJX0JBU0VfQUREUkVTU18xLCAweDApOw0KPiA+
ID4NCj4gPiA+IElmIHRoaXMgaXMgRFdDIHNwZWNpZmljLCBjYW4gd2UgbW92ZSBpdCB0byB0aGUg
Y29tbW9uIGNvZGU/DQo+ID4NCj4gPiBIbW0sIGl0IHNlZW1zIHNvLiBIb3dldmVyLCBJIGRpZG4n
dCBmaW5kIGFueSBzaW1pbGFyIGNvZGUgb24gb3RoZXIgRFdDIGRyaXZlcnMuDQo+ID4gU28sIGZv
ciBub3csIG1vdmluZyBpdCB0byB0aGUgY29tbW9uIGNvZGUgaXMgbm90IG5lZWRlZCwgSSB0aGlu
ay4NCj4gPg0KPiANCj4gTm8uIElmIHRoaXMgaXMgYXMgcGVyIHRoZSBEV0Mgc3BlYywgdGhlbiBp
dCBzaG91bGQgYmUgcGFydCBvZiB0aGUgY29tbW9uIGNvZGUuDQoNCkkgZ290IGl0LiBJJ2xsIGFk
ZCBzdWNoIGEgY29kZSBieSBhIHNlcGFyYXRlIHBhdGNoLg0KDQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwkvKiBFbmFibGUgTVNJIGludGVycnVwdCBzaWduYWwgKi8NCj4gPiA+ID4gKwl2YWwgPSByZWFk
bChyY2FyLT5iYXNlICsgUENJRUlOVFNUUzBFTik7DQo+ID4gPiA+ICsJdmFsIHw9IE1TSV9DVFJM
X0lOVDsNCj4gPiA+ID4gKwl3cml0ZWwodmFsLCByY2FyLT5iYXNlICsgUENJRUlOVFNUUzBFTik7
DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBBYm92ZSBzaG91bGQgYmUgZ3VhcmRlZCB3aXRoOg0K
PiA+ID4NCj4gPiA+IAlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJX01TSSkpIHsNCj4gPiA+IAku
Li4NCj4gPiA+IAl9DQo+ID4NCj4gPiBTaW5jZSB0aGlzIGRyaXZlciBkZXBlbmRzIG9uIFBDSV9N
U0kgYnkgS2NvbmZpZywgc3VjaCBhIElTX0VOQUJMRUQgaXMgbm90DQo+ID4gbmVlZGVkLiBUaGlz
IGlzIGZyb20geW91ciBzdWdnZXN0aW9uIDspIFsyXQ0KPiA+DQo+ID4gWzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvMjAyMzA3MjQxMjI4MjAuR002MjkxQHRoaW5r
cGFkLw0KPiANCj4gaGVoLi4uIHRoYW5rcyBmb3IgcmVtaW5kaW5nIG1lIDspDQoNCllvdSdyZSB3
ZWxjb21lIDopDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHN1cHBvcnQhDQoNCkJlc3Qg
cmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7g
rqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

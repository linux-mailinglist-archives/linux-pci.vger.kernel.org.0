Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76B762901
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 05:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGZDCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZDCU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 23:02:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F72689;
        Tue, 25 Jul 2023 20:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIhrrRkHEQMHY1FBhsbMAsaw5fszkctQHlRIyxHi9Vg9jx+TJo3fm8Tey/ir//wkm3OEluWsOt8+Ws1Ue3ozykbUq1QxpP6Vr+LFCUvIjWElFoGun3uUB93gYClvLsIetH5VotuDf1mzTunaqtzSY/9eL7mGr182f4kTpY3mcxgV8yD5C26IjKEL9WcH/zgSrX8jKreRywimt1knwwS9UBlZpGFNoBW2uUVEvlUCOChIk3EUe2J6TMHaIP/rI7On9Z+gBYhJx226ZymSfUJ/vtyTrD4Eu4XxiDQ+qik2K+0kG31rEf520INU/6FOXvx1/h0hmV+BmDghmWJwpv81YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjgyJ3+xyfM+7JZXxBSXOBVw4wBC2n4F6UTYJXf95Vc=;
 b=bSyWVNgJhJvKa5qnxtP8BWSXiKnl2zvOytfH6xdLxQux+9DMWDpdBkN3w5QRmYHj1+4Rdn3M/+/j0koaY8DiPggtD+m/mILVaiYVyZtVdU/bPL2McAfGRWu4sQyP4TQzC/a/5I2CKTlCxSFn1mkaIHtXSl7RlLhvm2xZ5Jy+Exp+NZbKjC+AUKX8CmFrm0csVDmDFsC3+vUT4Fo/ewhAyQeDNpkrSfHsI7mPtXdAYFWZ2snp/PaCKnWE0B93a4iLAnRUcvOP8Dnsb1DXjd+soORrVCvXnyqS6eDPj3J6RtIwuqFFtAgVS5yAK6H+S7y6bXL0UonA0WHoH7MzvlHkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjgyJ3+xyfM+7JZXxBSXOBVw4wBC2n4F6UTYJXf95Vc=;
 b=PwCLeh21/xMHJsajcQ32q3qZGrgN+Gv0oMP9LxXUtavQN1AEHCV23niS+tix979Pk/508mCNkEkUSmlFy55KGBehw7pMxdXrRyfuxqwJ9zLtNgJUWbMUas6F8ByOQCYIbRgcOYR0OhDU8mEXYV4gnHYvo6zJwcwrXbvajYjbkPs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10453.jpnprd01.prod.outlook.com
 (2603:1096:400:311::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Wed, 26 Jul
 2023 03:02:13 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 03:02:13 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Topic: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Index: AQHZu6dDbPirdu9Cv0mYGgD3jy/19q/Iz9+AgAKTmIA=
Date:   Wed, 26 Jul 2023 03:02:13 +0000
Message-ID: <TYBPR01MB5341F4EF6F814E72ABD8FE5ED800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
 <20230724114005.GL6291@thinkpad>
In-Reply-To: <20230724114005.GL6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10453:EE_
x-ms-office365-filtering-correlation-id: be609bd5-c606-4dce-79e9-08db8d84b64a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AuiUxWq5N7k5fyv+652D1nxnsi1br2geHmhQxlQaUCajmloIeQF3dqH9oeLQdRxPXUzC1YUqW4bNfxRxuFiWcxwMVb67EXo7B/5O5w2dS/MCxcF+3VEzES9pOLivE5MSHXHDUpgGOaVynoY/u++tilZk1HM05eAGwVs5eKYbVkonbyNOIS4UV0cPj/dg8CZ6HUKdTHl3iLvaGArY0Us9nqPzxZT5BdYTDqyD3RUB9KcQUlTiLwdJFx51BaUBv1DM1BPhGj+IxAHWoKdmbjYWjjAEvgmpo06FtvFNn67TmJAziFgRTVMLkF2Amx2WikLFcyS3JZM9fBkddBpFrI399343c28njr1zYLOMrKN4xG2twQFEA3DhKeqAuSddQ7BoFciO/Zugh7cY6d/SjcP5v0T1/HhxWQCuF3J/0iqyFtQ0h1zKvaWbuNpC062qGscjIZAFKjWX4mORu1pD7lgJhs0kkDrBwv5VRLdTDbRrteBSmYT4XRcnqf7droAHCqWphOhxxLvLkK0aWYdwxjHaqXpLy5DAAgVTOLoDuJ75eg++cjpfWP+bvz7E9PI9cpCNhHurEWQHdyO/GpBsYgeAzFwGQQMgnIYtANK3yMZuxRxkza/9TiZ/VpyrMQfbylsiE5wuhw5xsh0s+pz9S/bBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(5660300002)(38100700002)(122000001)(55016003)(64756008)(66946007)(83380400001)(54906003)(9686003)(7416002)(8676002)(52536014)(66446008)(478600001)(6916009)(66476007)(8936002)(316002)(41300700001)(4326008)(66556008)(76116006)(6506007)(71200400001)(186003)(2906002)(7696005)(33656002)(86362001)(38070700005)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dElFZUM1bHRoNkk3UVJPc2NqTWJneUFJUVJmOU02dEVyaDZjYW4zZyt2RkZq?=
 =?utf-8?B?emN4NGVkSUNCYllUVnBIQjV2MGo0L1J6OXJvVmpmSWVtNDcwRVVFNndRL1V5?=
 =?utf-8?B?NVU0bUY1dnVldmV2dTNaYmRvSDZpdXh5U1IydnEyWHpJdjgrRXlEQnZLSGFw?=
 =?utf-8?B?OEN5U0xNeVFFODRNOS9UNnZCdThVWFZBUGhsUktaN2RWRHJnaU9tRS9wU2Jp?=
 =?utf-8?B?amZpQStNSStrL2F0blh0UDJvTlg2MkhwN2RNOVBKVXA4ZFUyZjhVcU9mSll6?=
 =?utf-8?B?aGltdEZRaFNTSHdaazA0cWxjSng1MzRtc0NNZFBCZzhadzdhdmk3V215TlI1?=
 =?utf-8?B?Rkl6MUdQK21ZaHhMTlZ2cUtnUWVSYVFrQ2xYQ2FJSDlINllXd3dOY1I5ajdD?=
 =?utf-8?B?TXdoYXY0dW1BUW9PMmJ4QTdTdnpyMWFqMkV1ZjRnWDZYSlNDbkt3cjZLRWkw?=
 =?utf-8?B?VTlIY3VtUC81T0JLZzJHMCsrSnJRS2xDcmZUaEdNZkNWakRiOXhKdUV6NVda?=
 =?utf-8?B?dEZvVm9raUdJMWVGQythaWl5dEdGVzgwbXhvcDNtSWJKVkhBUndqTWhubElz?=
 =?utf-8?B?c0lKODNJdVlKYTFSRmUrcVhCcUVyQUdzamdSbkwyTDBNNWttSDZmaHY4bGMr?=
 =?utf-8?B?QXE5OUF4MVZDc0g4MElWeUcrMnFxMDhyZmpsem80WEdYaHQva2lKU21aUDlP?=
 =?utf-8?B?OTdUS0ZIUVcvRTR0YzVmT1I5bDd2UnhpUXorS2pqREZkMHhYYmpvdnlycHI3?=
 =?utf-8?B?SGdibUNzeTdIcEN3YmpaaThEYllSdXZsb28xNFE5dit4cnMxRnkxS2xva0l6?=
 =?utf-8?B?WFdvbTM1K01LWThOait2dDRQUmFLVzFvTGJTNjU2bGF6Y3dlQzErNmxnYmdY?=
 =?utf-8?B?RytNNmluTTdMYk82YzdaaVBRMWZNZkZLRXFDT1YyZTIrbE1CKzNnSG5sYkZ2?=
 =?utf-8?B?YjVBZXFaKzJ0STlleHBybUhkMW9Qc3R6NmMzQjh0TXZvemNoeUFHMTByK0Rv?=
 =?utf-8?B?Z2M3T1JIRytwd0huRk0rVXlyZ2xPQ1NBUDlxaG45ZEVuVVMzNVZTM3lITUps?=
 =?utf-8?B?NWFjWU54MUhFbVpvbVpiUE1TVms3TDV5eWM3cXZieUJxNmwwT3E3TmVjVEND?=
 =?utf-8?B?T2JYZndCa0ZGU3J3S2lINllTN3kxTDFoZGhTYUxNUDV6Z1hkNWgvVkhNbXFk?=
 =?utf-8?B?OXFFc0VMOTRDdU9hS1lzV2U1VUVwQytVa0R6MWw0YXhqelpkN0JQYldhV0d4?=
 =?utf-8?B?N1dSUW1DRWdkc2grV0VhUEJ2elVJcWowNUptTzc1bFJvTnpIR1RPajhmRUNK?=
 =?utf-8?B?b3NEMHJNMGRsV3hSVUliL05kUHRBVGpscHJBVDF4cjhyTDg1bWdPc2RUdVB5?=
 =?utf-8?B?SVdHa25XUldLUFlGcE9UL0luR3RZN0krR0lpYnVxcm9IZFY4cjlJSzZtQjZI?=
 =?utf-8?B?STEwRVoxNG80SENyU1hveHYxVHA1c3ZoY1dMcDRFK3dadTVOSVh3ZTFNVWsz?=
 =?utf-8?B?a3I0cm1TMnRudFJzWkd3bE9mTXg5V2NZT3FVdnV0RTZvMVU1K25sYlQ1dzR4?=
 =?utf-8?B?dldOREFSa3N6R3ZBS3lLNTdwWXU2dDRETWdVN2JObXlxVm5sV3BQQkFBSVpX?=
 =?utf-8?B?S1RUU3p5MmorcXNKMStzZWFFSld4eEhocmUrL01mQW81NTIvWHJGM3RnV3Nt?=
 =?utf-8?B?QzFpajhsUjFjTStxdERSTjNURzJtQUQ5aTNhTlRBb2NoNEtMUERGSWRWa3hi?=
 =?utf-8?B?TjFBdEVmSlpnTzZTVkVHSGk5ZUJHOVpsTmlIaDJwSnl5TDhHY1VXb0tZRlAv?=
 =?utf-8?B?d0V3eDkyT1lidk5XaisrVUQ1ZWJvTUdkVmxEMzlpYUJkUGlXWWt3aC96d0ZL?=
 =?utf-8?B?bEpydjR6dy8vMVJFYm45ME9PNHNmQ3FMdzBOUjlQdXlNbU9wdFJDa0hrRmNs?=
 =?utf-8?B?WHI4dTE0cDc0KzlRQmJId0xibDg5T2pnbzFMYndzVUFPaDJLNGVlY3ZnWm1R?=
 =?utf-8?B?TzYwSWtDQzAxTDVYK1pDZHMrQmtpZFllYVprcDhwRS9ndEhBZCswZXFONEFj?=
 =?utf-8?B?d0hESSthc1h4RmlQSWVhMWtOanVaV2dHbmp6Wjh3ZHZHM2RLSlAxMXVpYnpi?=
 =?utf-8?B?aEtyRjVsSmp3eXRsVDl0azZORXVBM1VDSHIzUnJwdWpDM0ZzQTBWWFRnRml4?=
 =?utf-8?B?ZmJpWkJ1RFRtNkdCRWJDUCszZmVWSzVPMWhuSis0QTZUMWczaEtZQjR2STJT?=
 =?utf-8?B?clpWYzBWdnVYeEJnSHpmcGFLQVdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be609bd5-c606-4dce-79e9-08db8d84b64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:02:13.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2aHm6wP4Y9aH/lZoSJIdlWGC6BqUg43Z3DIjX3GurEgaXaKMEfsWPJl1pp9NzOaey+trU9R1K4R3dHHCY3NzxYR8U0TcmO1Mxw6krpAhHXCIVoDRyjJgbNycRPcikSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgSnVseSAyNCwgMjAyMyA4OjQwIFBNDQo+IA0KPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo0NDo0NVBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBSZW5lc2Fz
IFItQ2FyIEdlbjQgUENJZSBjb250cm9sbGVycyByZXF1aXJlIHZlbmRlci1zcGVjaWZpYw0KPiA+
IGluaXRpYWxpemF0aW9uIGJlZm9yZSAuZXBfaW5pdCgpLiBUbyB1c2UgZHctPmRiaSBhbmQgZHct
Pm51bS1sYW5lcw0KPiA+IGluIHRoZSBpbml0aWFsaXphdGlvbiBjb2RlLCBpbnRyb2R1Y2UgLmVw
X3ByZV9pbml0KCkgaW50byBzdHJ1Y3QNCj4gPiBkd19wY2llX2VwX29wcy4gQWxzbyBpbnRyb2R1
Y2UgLmVwX2RlaW5pdCgpIHRvIGRpc2FibGUgdGhlIGNvbnRyb2xsZXINCj4gPiBieSB1c2luZyB2
ZW5kZXItc3BlY2lmaWMgZGUtaW5pdGlhbGl6YXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1l
cC5jIHwgNiArKysrKysNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmggICAgfCAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWVwLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtZXAuYw0KPiA+IGluZGV4IDE0YzY0MTM5NWMzYi4uNTJiM2U3ZjY3NTEzIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMN
Cj4gPiBAQCAtNjg0LDYgKzY4NCw5IEBAIHZvaWQgZHdfcGNpZV9lcF9leGl0KHN0cnVjdCBkd19w
Y2llX2VwICplcCkNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21f
ZXAoZXApOw0KPiA+ICAJc3RydWN0IHBjaV9lcGMgKmVwYyA9IGVwLT5lcGM7DQo+ID4NCj4gPiAr
CWlmIChlcC0+b3BzLT5lcF9kZWluaXQpDQo+ID4gKwkJZXAtPm9wcy0+ZXBfZGVpbml0KGVwKTsN
Cj4gPiArDQo+ID4gIAlkd19wY2llX2VkbWFfcmVtb3ZlKHBjaSk7DQo+ID4NCj4gPiAgCWlmIChl
cC0+aW50eF9tZW0pDQo+ID4gQEAgLTc5Nyw2ICs4MDAsOSBAQCBpbnQgZHdfcGNpZV9lcF9pbml0
KHN0cnVjdCBkd19wY2llX2VwICplcCkNCj4gPiAgCWVwLT5waHlzX2Jhc2UgPSByZXMtPnN0YXJ0
Ow0KPiA+ICAJZXAtPmFkZHJfc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gPg0KPiA+ICsJ
aWYgKGVwLT5vcHMtPmVwX3ByZV9pbml0KQ0KPiA+ICsJCWVwLT5vcHMtPmVwX3ByZV9pbml0KGVw
KTsNCj4gPiArDQo+ID4gIAlkd19wY2llX3ZlcnNpb25fZGV0ZWN0KHBjaSk7DQo+ID4NCj4gPiAg
CWR3X3BjaWVfaWF0dV9kZXRlY3QocGNpKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IDY4MjE0NDZkN2M2Ni4uYzNhZWFmZDBm
NGM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmgNCj4gPiBAQCAtMzMyLDcgKzMzMiw5IEBAIHN0cnVjdCBkd19wY2llX3JwIHsNCj4g
PiAgfTsNCj4gPg0KPiA+ICBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMgew0KPiA+ICsJdm9pZAkoKmVw
X3ByZV9pbml0KShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApOw0KPiA+ICAJdm9pZAkoKmVwX2luaXQp
KHN0cnVjdCBkd19wY2llX2VwICplcCk7DQo+ID4gKwl2b2lkCSgqZXBfZGVpbml0KShzdHJ1Y3Qg
ZHdfcGNpZV9lcCAqZXApOw0KPiANCj4gU2luY2UgdGhlIHN0cnVjdCBuYW1lIGl0c2VsZiBoYXMg
ImVwIiwgdGhlcmUgaXMgbm8gbmVlZCB0byBhZGQgdGhlICJlcCIgc3VmZml4DQo+IHRvIGNhbGxi
YWNrcy4gWW91IHNob3VsZCBmaXggdGhlIGV4aXN0aW5nIGVwX2luaXQgY2FsbGJhY2sgdG9vIGlu
IGEgc2VwYXJhdGUNCj4gcGF0Y2guDQoNCkkgZ290IGl0LiBJJ2xsIG1ha2Ugc3VjaCBhIHNlcGFy
YXRlIHBhdGNoIGJlZm9yZSB0aGlzIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8g
U2hpbW9kYQ0KDQo+ICh0aGlzIHNlcmllcyBpcyBqdXN0IEdST1dJTkchISEpDQo+IA0KPiAtIE1h
bmkNCj4gDQo+ID4gIAlpbnQJKCpyYWlzZV9pcnEpKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTgg
ZnVuY19ubywNCj4gPiAgCQkJICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwgdTE2IGlu
dGVycnVwdF9udW0pOw0KPiA+ICAJY29uc3Qgc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMqICgqZ2V0
X2ZlYXR1cmVzKShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+
ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprg
rr/grrXgrq7gr40NCg==

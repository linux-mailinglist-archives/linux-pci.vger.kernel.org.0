Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE55EEAA2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 02:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiI2AvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 20:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2AvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 20:51:15 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20088.outbound.protection.outlook.com [40.107.2.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D815AEFA67;
        Wed, 28 Sep 2022 17:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2HgwDucB6XK1m0dPdorLdT4Bl15Pw2W8bEuXktZE+/qhY9LkR22fhwYtLLVlMguy0yyxINjrBE8RCFHG5tkPAzWsy0IfXHEp+nMiRvTwOsHvTN/IbNtCAgpnDG+9ZWGJ97jMii9s0sw7Fv8ak28Jt1tgM0+pvhzbtULfUBYTnvDMX2weB888IApXoLPMvh4KmqEngd3foYNPd0WCWiQ8e4iy3zKTv+XNot7RQlmaNM6b2E+mrZ/wosLne+5vzDu/qN0XrLEc0BKLIsSJStwk65mS93fip81SgDzEcN9rVVcgtuJdpZcUs3dW02sW7+qgDaOe5z8Qya6TrXiSEr+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwmkRLAMhZfW1FtD57TRl+ySd33ALaO14rYokqp3g5Q=;
 b=IIHYLgFaO0JfRH0VdCQ/blSIAeEZCU8yd+LGZs35U++jwW6TCoEi1zd1xae+RkieR7UyZT8UkU2/MeKfPozDxdlpL+be5MyNefcdLabWwtM3kAjuYzbVBOoeTyqImwNKfNIfWP9jrq+Y2MlWF6l1Ec1ahQZ3LKQ89mnRIXWziG7l+KqGKOfoAFCbJ072JjOZD1Vf2lhxVUMxA2/Vw0ieKyP+VYQFbek5J2Ni9Zgs6I2JTArVM0HpH62BykBhHDBDAX1yYyXHW8loq62gYTPmB/3k8FgUXH2jvAeP7QLa77K3u8dCg+bi1DtF3ro5uT3ewLOhAEHWdhZQE00FkgNaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwmkRLAMhZfW1FtD57TRl+ySd33ALaO14rYokqp3g5Q=;
 b=Ci5iGVpR3Zg+s/qXClhkVLnCrt4o3Tyw3wlcdvjN57YvG0cJaG6E3ZLc3VfL7GkWEShwsXCsx5T1gKUgoS1mlAsqImJu7S0crNZAuoWJ0jj6ZPvOfd4zJjhljM+HceHOEqLkfa2u646FziYxBRJYRkxyzuqVrmNqIIR9spnBsJU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 00:51:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63%3]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 00:51:10 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Topic: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Index: AQHYtisJvWRatmeqJkC37ps54LPbAa3FdjaAgAFfrrCAAD5dAIAABDdwgAB/GgCAAKZ+UIArEMMAgAJ9ysA=
Date:   Thu, 29 Sep 2022 00:51:10 +0000
Message-ID: <AS8PR04MB86761D170063FC15499D8D1E8C579@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB86763A2187AED57CFD55625E8C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220830150534.GA97821@bhelgaas>
 <AS8PR04MB867644D39C15DDEF5CE88E008C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YzLTJqzvv6BgraiL@lpieralisi>
In-Reply-To: <YzLTJqzvv6BgraiL@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8388:EE_
x-ms-office365-filtering-correlation-id: 0995754f-a5cf-4b91-b964-08daa1b4b3ae
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dF0u6P9ITc6NTP8yVL78NH4B2opSuBVLcmv2V8j4mjHDxRHq+G1SWOnUQPPyBTYenmLxwzm3SGQH8ZBN7SYHZia97J+B2ZHuzYdsiBnBTrEEqwqpi4LdYvEymh2VdjqNVNNVhVwlJY/WVSFulaKlXQdmDVo9oCipvkyMe3MtxwMI2Nm/P3ZnYI0Xb2p8HA3AMB6ap8wcBJBx3+GH+9q0Kat9YUFCkfP/3PMQJcazPh/nIRo/+Paf2x0250sWLKHAonR2uL8oArb3SABv30f4D9EAQuBerj1rD4IEnTXV0+5GuZqDVw4AIbzKFjJwrRUnrZCCONpCDWWA5S2C5Kmcz/AE8O7TajI9D52e7aBHipEWYsR6/x9O0ju9j1ImUyMSjuqWCfw0M1BMoLpfaO59Ql8Eqde/6M5b5sF+ciUu3Rl9DkNG2hzzsdd6bJ0+JdfD4N0eI7fS86CtRDmt2DTyn0FvFzYg93RUzeOVVrE+ogljVdcHveITfGQhoL6opfjEf5IJ0WqiQ+2kSZEaVgFmo4WVFe4khD1Ku0d1PIS3BvGMjBK5RTDhJS8nokkF/g0iov9ANlxqATL7+pzvIc5+PVam00/4Rxela26nF6nazHLcVQlshtRF2pIjqT4zr+7hrDSIkU9Mgp3qnZhJCqgPqGiabjLTlg2vii1gbICuxwqZ7PW1X5PQ0VREdQxVsrhXmQotWVRdkRl8l+HuvgLPDbPww2GCJtXmS+iNlvPa5hkuwGhu8eO9yFbl6nCPl8uumCm0L+W0b8WymrnfdQAjCj68JsDKrLHWEkTh8k+DfhxxqWS+GIWn0nl3unla173d5ZScuUomdrSiPVboxQCz1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(122000001)(38100700002)(33656002)(38070700005)(86362001)(4326008)(76116006)(26005)(66446008)(66476007)(8676002)(64756008)(52536014)(6506007)(66946007)(66556008)(9686003)(53546011)(41300700001)(71200400001)(55016003)(8936002)(7696005)(478600001)(45080400002)(316002)(6916009)(54906003)(966005)(186003)(7416002)(44832011)(83380400001)(5660300002)(2906002)(66899015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TnNOYXRFcTA2UEhEL1dxT2NzNXFkVGN4d1Zwb3NFS2xRSDQ1V3Zjd0NiaVhR?=
 =?gb2312?B?WVlKeHY3RmVqcno3TFF3ZjhoL3VHOHRvWDBTWkpUemxYSEpZRnlaZ2xOSC9y?=
 =?gb2312?B?bnZtdS9YTVlNaVhxdDdGSGNyc0ZienBRc2EweEthc0I0eDlXcXVEbjlkT2pt?=
 =?gb2312?B?ZHpTQVRCRHkvVmQwYlFBR3ZYa0liUlRrQW9mYmhqSEc4Yit2WXIwbzNGOW9w?=
 =?gb2312?B?REEyTkZkMnNMcWJPVzBrcHA0RFd2M05aanJWMDNaR1NoWVZVcllLS2hwUVhV?=
 =?gb2312?B?bXpnZTJkbTB3T3hpUFZZcjI2Mm1yRjRJTEFLZllnc1paTi9Wd3JNcUY3RTJu?=
 =?gb2312?B?TjI3QWpMNStkM2RTSGV6NHkwZVhETWJGTTcrcU1HeEUvTEpZaG5BUDZ3VGlv?=
 =?gb2312?B?Q3JPS2lmSWVHM2Q1Z3JsUjRvdGl5TmV6VVpMWWRyaW5YQUFtb1lTNU93bjR6?=
 =?gb2312?B?bFNOUW5mM1VxZjBBeXVZVjFsbERGZ2RUaXp1cENYaWhlMjJUYXpUQWJhN25l?=
 =?gb2312?B?OFA4bm1FUWxvLzhLY0xHUU5TemVlbzdmdlhUMCszbWlpYjVSUkQ0UmlBM3Mx?=
 =?gb2312?B?YWR6bHVndnNGWFlOeHY4akdqaGN1UnV0MkRCS3NnVjRCSHA4RWlPZUR6T2VE?=
 =?gb2312?B?bjFELytjWU9yTGJEUDhvaytWd2wxVGdFSXZKWXk3TlU3T1RTYVIveDVrNCtR?=
 =?gb2312?B?bGdVVnpQbWliemEyTExqa3hvZFBSN2l2RU9XTFFGVC9YL213K0h3YWF3NEhW?=
 =?gb2312?B?QkQ1YzdOdmpBbGRZNFFFODNxOFdpckdrdEczQ1RIS1AzWGllWkxuZlJNQTRG?=
 =?gb2312?B?RE1lOTJWUkpJZlNFSFpKaDJ0WHFKOU1JL1FURXZ2NE1tV1ozbUpaK096UC9L?=
 =?gb2312?B?WEF0VXg1ZUt3MHNDeXlKNTJ2dGw2OENoN0FVQkFBbWQvSGs5UytHaGlsRjFw?=
 =?gb2312?B?bkVIK0JENnFKMGJ6NGJ2Z2M2NExOUzg4eEgwTFpmQ1ZtdVcwUHdPT204VW5I?=
 =?gb2312?B?eVhKVWNXenpPTU5VMklwU0tXdmJMMHVoSndBMVdYUXp6SlRtc1lqdjVTendJ?=
 =?gb2312?B?ZDc4Z2pFNEdySXUzK29PeFc4ODZIa2VrVXBveDkxK0tRVldmb3Qza2gvUTFi?=
 =?gb2312?B?ZllNY24xTmhjRFowbDlpbjdMNDdHYnl5aVBhbS9tQmFySEZuOXJvWUpGRko5?=
 =?gb2312?B?bjFCdEROOUFhSnMrSWcvZE50S0krTThoZWNpWUVCcG5SRER6MXVXRGdaZU0r?=
 =?gb2312?B?akhCL081YWVtNVRtdHh3dlNxaXVhOWI3NTIzaDJkSXdRb28yOWNjT0R3MUQ3?=
 =?gb2312?B?c3ZhVjdCYTVpTHdJcHpJRDdzbjRGMVJCcmd6UEF4TE50QitvK2JXZ01zQldP?=
 =?gb2312?B?MUEyZVE0R1J0SmozL1c5ZWhIUmZ6ck40Mko1K2pHVHdETGlXVzhqODdiZlhj?=
 =?gb2312?B?R1BmeHVkMW5JSk1hcWFqdkxadFhLMkVQU2JxWkwrc2dOYUZLaU5VSS9YNTdT?=
 =?gb2312?B?RHN3TFlZZXhCSWtpcVZCTXR1R25WaU9HOVFVb1hBMnc0aXgwbDNsT01zZTlz?=
 =?gb2312?B?RXlTUjFNdXlKYnJEcFJLQUhzd0RnRkZJSnAyYU1YN2FMRkFNT1FuQUVheGl0?=
 =?gb2312?B?dkNRaXNLU1JDUkJ2cEFybVJGeWVXcFBaV3BhcXNUdkw5UTNrOEY0WlRCTVRx?=
 =?gb2312?B?M04xZzdLZS95U3VVZTlhUjE1WEY2dlRyRzRVNFZ1ZlEwTjQ0MTAzb1FreEQy?=
 =?gb2312?B?TE9KbGRjV240cVMzVFlId29xY0JxQmsxWTFtM3FNUWw3Vk1NK2VUR2RVNDVC?=
 =?gb2312?B?bXdNNGJhaUxiMmNkejFyVzgzbzFKT3dWTkhSSVZJWjh5WERUdkdhT3RDUjBJ?=
 =?gb2312?B?bmJLczMxc1BLcThza0xiWkgxZWcxdUZsMXp1eUtxQVN1Rk1XZDBJOU5KbjYw?=
 =?gb2312?B?Y2ZKMWdDbk9aZzZZOWVKOE1SRitjTnJDdzhoZ25WMEtIMEEvVk5OSnRWa0JH?=
 =?gb2312?B?d21MVHBkVWhaTStRZHU3ZDNqc0x5QlZiVzVvTTFoWHVEbGdnY1poQTI0N0ZO?=
 =?gb2312?B?KzlRRW1rL1B0Q3J2SWltODU5amMxbEtxNHJnRklBdm5qOG9LcnVOUEsxd3NE?=
 =?gb2312?Q?ScwC0/janBpNifD+MjJJBMoSe?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0995754f-a5cf-4b91-b964-08daa1b4b3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 00:51:10.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EA1dBLCCDL93U6k1EODsaNsdrVhOuc5s3qzDMegQC72s06TMnOoiw821gP5vx7uVH+2XlwWwMowO5tuUDHiO1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bHBpZXJhbGlzaUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo51MIyN8jVIDE4OjQxDQo+IFRv
OiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2Fh
cyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQWhtYWQgRmF0b3VtDQo+IDxhLmZhdG91bUBwZW5ndXRy
b25peC5kZT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHZrb3VsQGtlcm5lbC5vcmc7IE1hcmNlbCBaaXN3
aWxlcg0KPiA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPjsga2lzaG9uQHRpLmNvbTsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
ZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvMl0gRml4IHRoZSB3
cm9uZyBvcmRlciBvZiBwaHkgY2FsbGJhY2tzDQo+IA0KPiBPbiBXZWQsIEF1ZyAzMSwgMjAyMiBh
dCAwMTozNzowMkFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPg0KPiA+ID4gU2VudDogMjAyMsTqONTCMzDI1SAyMzowNg0KPiA+ID4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiBDYzogQWhtYWQgRmF0b3VtIDxh
LmZhdG91bUBwZW5ndXRyb25peC5kZT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyB2a291bEBrZXJu
ZWwub3JnOw0KPiA+ID4gTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5j
b20+OyBraXNob25AdGkuY29tOw0KPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBsaW51eC1waHlAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvMl0gRml4IHRoZSB3cm9uZyBvcmRlciBvZiBwaHkg
Y2FsbGJhY2tzDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDc6NTA6NTVB
TSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogQWhtYWQgRmF0b3VtIDxhLmZhdG91bUBwZW5ndXRy
b25peC5kZT4NCj4gPiA+ID4gPiBTZW50OiAyMDIyxOo41MIzMMjVIDE1OjE2DQo+ID4gPiA+ID4g
VG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOw0KPiA+ID4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207DQo+ID4gPiA+ID4gdmtvdWxAa2VybmVsLm9yZzsgTWFyY2VsIFppc3dpbGVyIDxt
YXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+Ow0KPiA+ID4gPiA+IGtpc2hvbkB0aS5jb20NCj4g
PiA+ID4gPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiA+ID4gPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMC8yXSBGaXggdGhlIHdyb25nIG9yZGVy
IG9mIHBoeSBjYWxsYmFja3MNCj4gPiA+DQo+ID4gPiBUaGUgYWJvdmUgcXVvdGluZyBzdHlsZSBt
YWtlcyBpdCBoYXJkZXIgdGhhbiBuZWNlc3NhcnkgdG8gZm9sbG93DQo+IGNvbnZlcnNhdGlvbi4N
Cj4gPiA+IFNlZSBoaW50cyBhdDoNCj4gPiA+DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZW4NCj4g
PiA+IC53aWtpJTJGJmFtcDtkYXRhPTA1JTdDMDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdD
OTgzZDViNg0KPiA3YzczNTQ0NA0KPiA+ID4NCj4gMGMyZmMwOGRhYTA3NGJkNzklN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTcNCj4gQzYzNzk5DQo+ID4gPg0KPiA4
NzIwNTA1MTgyMTc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFp
TEMNCj4gSlFJam9pVjINCj4gPiA+DQo+IGx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPQ0KPiBIQ0V6cg0KPiA+ID4NCj4gclNoc01R
SnAzeERqS3JDTzBZTnRsJTJCaGNpVGhBQyUyRjU4aW1CJTJGT1UlM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gPiA+DQo+IHBlZGlhLm9yZyUyRndpa2klMkZQb3N0aW5nX3N0eWxlJTIzSW50ZXJsZWF2ZWRf
c3R5bGUmYW1wO2RhdGE9MDUlN0MwDQo+ID4gPg0KPiAxICU3Q2hvbmd4aW5nLnpodSU0MG54cC5j
b20lN0M3MGYzODIxNGM4Zjk0YzU5MzJiNDA4ZGE4YTk5MTk5NiUNCj4gN0MNCj4gPiA+DQo+IDY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NzQ2ODc0MzM1ODky
MDkNCj4gPiA+ICU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16DQo+IElpTEMNCj4gPiA+DQo+IEpCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1jZVptRGQNCj4gPiA+IHNOZUM5blU2cW10MnFY
UjAzZlFuMzN2WSUyRnF2QklZemVXVzdtayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4NCj4gPiA+
DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRnBlb3BsZS4NCj4gPiA+DQo+IGtlcm5lbC5vcmclMkZ0Z2x4JTJGbm90ZXMt
YWJvdXQtbmV0aXF1ZXR0ZSZhbXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hpDQo+ID4gPg0KPiBuZy56
aHUlNDBueHAuY29tJTdDNzBmMzgyMTRjOGY5NGM1OTMyYjQwOGRhOGE5OTE5OTYlN0M2ODZlYTFk
M2INCj4gPiA+DQo+IGMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NzQ2ODc0
MzM1ODkyMDklN0NVbmtubw0KPiA+ID4NCj4gd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhDQo+ID4gPg0KPiBXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPVBraHBHR2Y3RmN2c1FUamMwDQo+ID4g
PiBoVU1wcjlRNEpWS2VGb0xSNGZvQTZ6dDZqZyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4NCj4g
PiA+IFRoZSBpZGVhbCB0aGluZyB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzLCB3aGVyZSB0
aGVyZSdzIGEgc2luZ2xlDQo+ID4gPiBsaW5lIGZvciBlYWNoIHNlbmRlcjoNCj4gPiA+DQo+ID4g
PiBPbiBUdWUsIEF1ZyAzMCwgMjAyMiBhdCAwNzo1MDo1NUFNICswMDAwLCBIb25neGluZyBaaHUg
d3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyLCBhdCAwMzoxNlBNLCBBaG1hZCBG
YXRvdW0gd3JvdGU6DQo+ID4gPiA+ID4gT24gMzAuMDguMjIgMDU6NDcsIEhvbmd4aW5nIFpodSB3
cm90ZToNCj4gPiA+ID4gPiA+IERvIHlvdSBtZWFuIHRvIHNxdWFzaCB0aGlzIGZpeCB0byB0aGUg
cHJldmlldyBzZXJpZXM/DQo+ID4gPiA+ID4gPiBJJ20gYWZyYWlkIHRoYXQgaXQncyBub3QgZWFz
eSB0byBkbyB0aGF0Lg0KPiA+ID4gPiA+ID4gQmVjYXVzZSB0aGVyZSBhcmUgYSBsb3Qgb2YgcGNp
LWlteDYgY29kZSBjaGFuZ2VzIGFmdGVyDQo+ID4gPiA+ID4gPiBjb21taXQ6IDFhYTk3YjAwMjI1
OCAoInBoeTogZnJlZXNjYWxlOiBwY2llOiBJbml0aWFsaXplIHRoZQ0KPiA+ID4gPiA+ID4gaW14
OCBwY2llIHN0YW5kYWxvbmUgcGh5IGRyaXZlciIpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhl
IHdheSBJIHVuZGVyc3RhbmQgaXQsIGlmIGEgYmlzZWN0IGVuZHMgdXAgYmV0d2VlbiB5b3VyIHR3
bw0KPiA+ID4gPiA+IHBhdGNoZXMsIGkuTVg4TSBQQ0llIHdpbGwgYmUgYnJva2VuLCB3aGVyZWFz
IGl0IHdvcmtlZCBiZWZvcmUuIEkNCj4gPiA+ID4gPiB0aHVzIHdvbmRlciBpZiB3ZSBzaG91bGRu
J3QgaW5zdGVhZCBzcXVhc2ggdGhpcyBzZXJpZXMgaGVyZSBpbnRvDQo+ID4gPiA+ID4gYSBzaW5n
bGUgcGF0Y2guDQo+ID4gPiA+DQo+ID4gPiA+IFllcywgaXQncyBhIHBvc3NpYmxlIGNhc2Ugd2hl
biBkbyB0aGUgYmlzZWN0Lg0KPiA+ID4gPiBTaW5jZSB0aGVzZSBjaGFuZ2VzIGFyZSBiZWxvbmcg
dG8gZGlmZmVyZW50IGdpdCByZXBvLg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0
aGUgcG9pbnQgYWJvdXQgZGlmZmVyZW50IGdpdCByZXBvcy4gIFBhdGNoIDEvMg0KPiA+ID4gdG91
Y2hlcyBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jLCBwYXRjaCAyLzIgdG91
Y2hlcw0KPiA+ID4gZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jLiAg
VGhleSdyZSBpbiBkaWZmZXJlbnQNCj4gPiA+IGRpcmVjdG9yaWVzLCBvZiBjb3Vyc2UsIGJ1dCBh
cmUgaW4gdGhlIHNhbWUgTGludXgga2VybmVsIHNvdXJjZSByZXBvLg0KPiA+ID4NCj4gPiA+IFRo
ZXkncmUgbWFpbnRhaW5lZCBieSBkaWZmZXJlbnQgcGVvcGxlLCBidXQgd2UgY2FuIGVhc2lseSBk
ZWFsIHdpdGgNCj4gPiA+IHRoYXQgYnkgZ2V0dGluZyBhbiBhY2sgZnJvbSBvbmUgYW5kIG1lcmdp
bmcgdmlhIHRoZSBvdGhlci4NCj4gPiA+DQo+ID4gPiA+IEl0IHdpbGwgYnJpbmcgbWFpbnRhaW4g
ZGlmZmljdWx0aWVzIGlmIHRoZXNlIHR3byBwYXRjaGVzIGFyZQ0KPiA+ID4gPiBzcXVhc2hlZCBp
bnRvIGEgIHNpbmdsZSBvbmUuDQo+ID4gPiA+IEl0J3MgZGlmZmljdWx0IHRvIG1ha2UgYSBjaG9p
Y2UuDQo+ID4gPg0KPiA+ID4gV2hhdCBtYWludGVuYW5jZSBkaWZmaWN1bHR5IGRvIHlvdSBzZWUg
aGVyZT8gIEkgdGhpbmsgaXQgbG9va3MNCj4gPiA+ICplYXNpZXIqIGlmIHRoZXNlIGFyZSBzcXVh
c2hlZCAtLSB0aGF0IHdvdWxkIGF2b2lkIHRoZSBwb3NzaWJpbGl0eQ0KPiA+ID4gb2YgYmFja3Bv
cnRpbmcgb25lIHdpdGhvdXQgdGhlIG90aGVyLCB3aGljaCB3b3VsZCBjZXJ0YWlubHkgYmUgYSBw
cm9ibGVtLg0KPiA+ID4NCj4gPiA+IElmIGEgYmlzZWN0IGxhbmRzIGFmdGVyIHBhdGNoIDEvMiBi
dXQgYmVmb3JlIDIvMiwgaXQgbG9va3MgbGlrZQ0KPiA+ID4gaS5NWDhNIHdpbGwgYnJlYWsgdW5u
ZWNlc3NhcmlseS4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIEFobWFkIGlzIHJpZ2h0IHRoYXQgcGF0
Y2hlcyAxLzIgYW5kIDIvMiBzaG91bGQgYmUgc3F1YXNoZWQNCj4gPiA+IGludG8gYSBzaW5nbGUg
cGF0Y2ggdG8gYXZvaWQgdGhpcyBiaXNlY3Rpb24gaG9sZS4NCj4gPiBIaSBCam9ybjoNCj4gPiBU
aGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQo+ID4gTXkgZGVzY3JpcHRpb25zIGFyZSBub3QgYWNj
dXJhdGUgZW5vdWdoLiBUaGVzZSB0d28gZmlsZXMgYXJlDQo+ID4gbWFpbnRhaW5lZCBieSAgZGlm
ZmVyZW50IHBlb3BsZSwgSSdtIGFmcmFpZCB0byBicmluZyB0cm91YmxlcyB0byB0aGUNCj4gPiBt
YWludGFpbmVycyBpZiBJIHNxdWFzaCB0aGVzZSB0d28gcGF0Y2ggaW50byBhIHNpbmdsZSBvbmUg
YmVmb3JlLg0KPiA+IE5vdywgSSB1bmRlcnN0b29kIHRoZSBzaXR1YXRpb24uDQo+ID4gSSdtIGds
YWQgdG8gc3F1YXNoIHRoZW0gdG8gYXZvaWQgdGhlIGJpc2V0aW9uIGhvbGUuDQo+IA0KPiBBcmUg
eW91IHNlbmRpbmcgYW4gdXBkYXRlZCBwYXRjaCA/DQo+IA0KSGkgTG9yZW56bzoNClRoZSB2MyBw
YXRjaCBoYWQgYmVlbiBzZW50Lg0KSGVyZSBpdCBpcy4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1wY2kvcGF0Y2gvMTY2MjM0NDU4My0xODg3NC0xLWdpdC1zZW5k
LWVtYWlsLWhvbmd4aW5nLnpodUBueHAuY29tLw0KVGhhbmtzLg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkIFpodQ0KDQo+IFRoYW5rcywNCj4gTG9yZW56bw0K

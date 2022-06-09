Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857CB5443A7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiFIGRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiFIGRu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:17:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9F1F37B1;
        Wed,  8 Jun 2022 23:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id8WxDcNASPfpoq7yCjvp4DzN/Oth3DThMa6fWBcBmUSBlp9DTs+3cDEPXEVMP3hQiveRXJ0aUS6xzYDY+SqNwib7PCl57RzSUnXUdTeYYj1HubUh9h8HsBpFFBxEON5xylmopyYUQqobMlkyGd3kU+NYvTEbBb3EXE0S22eqBQiqFgDDnKc82H1bgIHd7Umf3hrG+EwQkn0HBxPkbnvH2RVfTeKcvKyTe9diVnnOI72cZgf8T5aVIwHjRfCmrsz2A+cVfbclt48j6wEgBS+6jMk6l4fFilo2c8fSt8OZJ8Yl4tF3t1WZ6YEXluGLLZtSDwlkSQ900krMvmb1Id6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOajZ2s7gyM27uB07kjnRspGcuiMfSWp9LZ6ZUpedQw=;
 b=cujyXNEiIb36PvmrruGcvbfDpD8uPwTjqYH1/fB5O1AfZHXZBHCKi/33+SeVEbA+XP8NOr8KI6I0nqsWk15XC6tEynIUc4v4uiX/05JAZQxqMu9B6Yac5gUyvQspa7YKPIh9nS2SYjJTiV0tLOi8Wr9BW4nbW/t+ViYHq3IwC8Jzr+7eOk+dMG1vv5efX19/Y/60J8q7Z7OK6cH0i6DEpGx7YHBLX5o0Wp7AtzVkGHENq+2ML7o0uG+F+az1+8/Z5Gv3igMjNtbb9HBP0mvZxm4U7gIcvtAL/MreY1cHaKLide6GBs6HHHTTsTzoWGHF/0nXuYcucmJNTwM2WFGtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOajZ2s7gyM27uB07kjnRspGcuiMfSWp9LZ6ZUpedQw=;
 b=J9o6dIharx/VDEEvKAlJXJG8jyE0+tZ8Ds+6CxIisDvXZqquHCkodcFblFtzME5aSDnGx7b9h/iEhdmu0FPWL38tNwcL+etukAPdaHZr0wS5jJ8k6qmhsj3rOA+P+9NF75mcId17hLBFTTqLf/KeXHMu/M2spzH0bY1OcsAzauk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:17:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:17:46 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Topic: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Index: AQHYYOzgdcPKaCfHJE+sY2pPsqwsuK1FUrsAgAF0kuA=
Date:   Thu, 9 Jun 2022 06:17:46 +0000
Message-ID: <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
 <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
In-Reply-To: <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aca90ff0-eabc-4031-ce3a-08da49dfc551
x-ms-traffictypediagnostic: AS8PR04MB7702:EE_
x-microsoft-antispam-prvs: <AS8PR04MB770270F2187CD659F3001EFE8CA79@AS8PR04MB7702.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7YQcQCNJRC7kuXb6tzWpNycHhKEDLBIXJCUZRHlIDLZ0nY6hKck2RAmb0pM9Z9CZIh5fkcEbOI/lmZWrqrUW1I0iYl1by5YKRN2jyAvIZP/Qhd4CJGed0PKtsdtt2ZmUGTbB2gXi8Uu55nXtgC4ERO3V+6plS/uvIXeRUnw3x8Qo7MTcX0t0fZYdOp1YOmE1xflsfUGVtOGZMmaOexhorvmQ234Rx+gr5CMKl3TMQZztb+FIhURdeMTx9idCSqWceYfRXFz0DbUxbEGDtZuzTnC+dWW9y4SBqLlm4wvliGSfnew+ONA07sPFvp6jcP1D1/VGwKMo2JMvC/EsojHwhBxjwSxLnm2vQsTWR1bJSeduPadpzj3Zvv3Bv08M8JJIRFwj4iOx638bdhgrbH7fwDb4HLGTLtvV+neKOvebR+qtk13YxpHuoBbmQdYrnKF9e7iRLIBGNMARL60HyrDhHdrX9X/Cx+aGCR6XPMN5BDyVlJu7Dp9KpX0oscsxjUeBBS1NjhsRumaB1MS4WTixn4BGX3w6QG1LZNdLntpv/dcBxmHvnbhQdEmTA87NMRI9qPtM1LTXJGAljDJEx0uC/FB7Ba0yPW0WPe3339pAARNGkZoCZiVNIN+Hlb2jffK6yya60C28Gyd+aXSAktrpMT1SgjT8ui4jceHkyuWrjbXbUxKL2W+aSp3N4j+gqJVf/oCYdJKH9lHsqs+lc2stw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(86362001)(6506007)(26005)(33656002)(2906002)(44832011)(122000001)(53546011)(9686003)(7696005)(38070700005)(508600001)(83380400001)(55016003)(8936002)(76116006)(186003)(38100700002)(5660300002)(52536014)(8676002)(4326008)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(7416002)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVQYktwZ2hsQUJzWjc5Nko3THlIbFhFck9CbEl3Zm9ZTFRaT2FQVXdJSUE2?=
 =?utf-8?B?Zyt1OENwclR5cDlNWko4TTBkV1JvN2VRVmpmMlFaSFcrbFdabzloaE5ZZE1r?=
 =?utf-8?B?bFVYVXEzSTlsWXl2eTN5Z1ZWMWZzaFljUEdnbkdaM0xrMjRmb29RSGRqWnJr?=
 =?utf-8?B?MWoyd1FxTHNnWnZ5SDdyWStBQW0wWWdIZlBTV1IwYWRONTUyYmpDQlIxNUhQ?=
 =?utf-8?B?Tk9KR0U4SzhnZHRrRnJHcnNibE1Hait2T0Q5QlV6Q0FsSE9ield3VWJpdVdH?=
 =?utf-8?B?cHdGeVd2czBvQWRQY0EwSVI1ak9qUUJoZ2lSdFprLzFvQVVwZ2JId29kZVFL?=
 =?utf-8?B?cnhmMk1MR2tKeVczWEtZVEowU2NkaWZwWDZWSHhoc1QrT1psbW9ZbVgwQm1N?=
 =?utf-8?B?OHNwS1JDNjNuVTU5Z1FPQkZjci93QlgzVWdNNWpBektwZHBOK0h6cWlRNkt6?=
 =?utf-8?B?K1gra3VJMmhoNGRBNTNJK0RBZStSQ1FMR3FWcUMvY1dzQmNnU3k5andOV3Fq?=
 =?utf-8?B?QVFlakVMZ3d5ZmlneDF0MmV5VlQwdGNGdktoN2lmTXoxRGpVZDJUTFhRMFNp?=
 =?utf-8?B?Nm5oWXJaZnFmbHpMUXM0SnNydURkSVBrZ25UVjVXMjAvdkttWmM5SlQ0VVgx?=
 =?utf-8?B?RFdQTndnd2NnQVJYdUVoNFppd01SWC81WkQ3by8rbFdleDJXZlJNRUtkcHR2?=
 =?utf-8?B?TWVyeVdxUXJoM0E0djA4VWV1L2lsVDhjZFBGcDRCS2hCb0pCNjZMdVJtTVhF?=
 =?utf-8?B?MHUyaklSMkM1WmJpVHBTMDRWSm5iZ29xdmwwNy85c3pORVNzSkdlZHc1QXVr?=
 =?utf-8?B?Skh2UmRmZmRSRDBCSnA3cjl3anVNelhSdUZXVzIrV3BycHd2ZUwra0ExMHdW?=
 =?utf-8?B?ZUtkS1JhR0d2ejdNQm5GUUNvMjVuWVBGS0xlVDBUVm53Nm9iV0FDRTJORU1z?=
 =?utf-8?B?N1ladlhvLzk0aXppU1JyZlQvRzZPb2JnelJGckswWENzTDJKQ1YvMmhPWEs4?=
 =?utf-8?B?eEZmelJpYkJRQit1VTllOXRVQkNCUjVWWU1LM0pTaTBaYmRlRko4Vmswc3Q2?=
 =?utf-8?B?clFTTklPaFVyMGxYU0hOWURZNWNFbWN6U1VHclc2cld5SFo1VzNibkI5V2pH?=
 =?utf-8?B?UTJtTmF0RG5QRnRVeFdkZ28vV2FPdVZsYzR3WHZldjdlTVVZVWtNZEJoQXFs?=
 =?utf-8?B?Um5MZW9qdE0xbTJlYk9ZTFdqMXNaMHRlcWFjaFFMNUJNMHdVT2xJZFI5Q2Nk?=
 =?utf-8?B?OGFUZU9YaEl5ekFoaW02ajVnR3lOc3ZZazlTdEExWCtuTmRrQzFLaDY1MThi?=
 =?utf-8?B?L1k2cFNNMVp0RllLNFdRdCthd1paUmNmM0ZBS3lsbnE5ZG1nS0k2c2hKRGxn?=
 =?utf-8?B?UjZZNzh1S2Z2MmtNSXhPU3pQbWIrMldxQUgvdXBxd2lBeGNZY0J3K1Vob2o5?=
 =?utf-8?B?T0cyL2ljejI3eVRIaDNHV2Q1L040RVk0N3BaU0V5UXJna3dmT1lRTG1tTjlT?=
 =?utf-8?B?RXJ2U0NOajVUWnpBNTUwblpoRytoK3RIbW1MSkxyMFpMMDZyWS9Yd2lhVkdS?=
 =?utf-8?B?ekdXZmYzUjhXWEdLTVdnS3dSK083b2VFK2xUZjJHN2N5WlZ6dUxrdkdpb3kz?=
 =?utf-8?B?b2l4SkF5OC9lTmNaYWh6Ym9MS05vSG9ZMW5XUm83aHNlei9Qb0syMm1ON3dX?=
 =?utf-8?B?MCs1dnU2VE1WMGpRd2I5cFFwa0loV1dOZ0pRVEcxWmVUek1hbGkwcGhWR0cx?=
 =?utf-8?B?UzRDaUpwVDVEOXR3dW8yUTVyUnFITGNoQXpEVlZkbDR1NXMzSUJnbXdwUmdr?=
 =?utf-8?B?Ri93SzY4bGtZMi9CZTgwcHE2YmlhYVVMUEN3ZzdFNWJlR3h6VHZVU2o4VmN3?=
 =?utf-8?B?OXpUTHpHZVNaVG9waVpEakhtVDR1S1Zxa2pSbmpJZWhwcE9OZHh4MDZqUnd1?=
 =?utf-8?B?MlMwSWc0dzd5bVhLSk1JOE9DdmcwWEszNFB1N1J4N3hENGhPcndlS0JXMzNT?=
 =?utf-8?B?MjluVzFVekVEL1NVVFcvK2MrbmJmUDlNZzhRRWZQT2dabk4yWW5yU21CRUtt?=
 =?utf-8?B?K1ExRHpNMUx0YS8vbGlWem1WdFphdEV2MmZQcFlGRDd6a1RseEFROU5pNElH?=
 =?utf-8?B?QTRPa0lLaTh1NEZ0NGUvV1RueW8zTGRlc0hBUkppSVRTa2ZIWU9Sekt5bFNU?=
 =?utf-8?B?YVdrNStwUWsrZmI3cWRDaWhXWFluUUk5bjJ4V3c0MjVkdkdzOE1XbUVZWXlo?=
 =?utf-8?B?WnNGejZuSkdvTmVVL0YyRmxBVWk5TkFaL092d0lEOEl0aGNUTzE2SllObkpD?=
 =?utf-8?B?UGFsSUoxU1FCRVVIZG0yTFdibTZnSlpHWUt2endRbitBV1E1RHY4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca90ff0-eabc-4031-ce3a-08da49dfc551
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:17:46.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TgHmVBppJHns0zL/Feq8JkySLEMaX/wmqyhwGG86kWCgQExtiysA662nc7nSPW/X45+PMNCC6huhRRv6cwiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg45pelIDE1OjM1DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA2Lzhd
IFBDSTogaW14NjogRGlzYWJsZSBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMgYWZ0ZXIgbGluayBpcw0K
PiBkb3duDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW0gMDYuMDUuMjAyMiB1bSAwOTo0NyArMDgwMCBz
Y2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IFNpbmNlIGkuTVggUENJZSBkb2Vzbid0IHN1cHBvcnQg
aG90LXBsdWcsIHJlZHVjZSBwb3dlciBjb25zdW1wdGlvbiBhcw0KPiA+IG11Y2ggYXMgcG9zc2li
bGUgYnkgZGlzYWJsaW5nIGNsb2NrcyBhbmQgcmVndWxhdG9ycyBhbmQgcmV0dXJuaW5nDQo+ID4g
ZXJyb3Igd2hlbiB0aGUgbGluayBpcyBkb3duLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggM2Nl
Mzk5M2Q1Nzk3Li5kMTIyYzEyMTkzYTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtODQ1LDcgKzg0NSw5IEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgCS8qIFN0YXJ0IExUU1NN
LiAqLw0KPiA+ICAJaW14Nl9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+DQo+ID4gLQlkd19w
Y2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArCXJldCA9IGR3X3BjaWVfd2FpdF9mb3JfbGlu
ayhwY2kpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIGVycl9vdXQ7DQo+IA0KPiBUaGlz
IGFkZHMgYmFjayBlcnJvciBoYW5kbGluZyB0aGF0IGhhcyBiZWVuIGludGVudGlvbmFsbHkgcmVt
b3ZlZCBpbg0KPiBmODFmMDk1ZTg3NzEgKCJQQ0k6IGlteDY6IEFsbG93IHRvIHByb2JlIHdoZW4g
ZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgZmFpbHMiKS4NCj4gV2hpbGUgSSBhZ3JlZSB0aGF0IGRp
c2FibGluZyB0aGUgY2xvY2tzIGFuZCByZWd1bGF0b3JzIGlzIHRoZSByaWdodCB0aGluZyB0byBk
bw0KPiB3aGVuIHdlIGRvbid0IG1hbmFnZSB0byBnZXQgYSBsaW5rLCB3ZSBzaG91bGQgc3RpbGwg
YWxsb3cgdGhlIGRyaXZlciB0byBwcm9iZSwNCj4gc28gcGxlYXNlIGFkZCBhICJyZXQgPSAwIiB0
byB0aGlzIG5ld2x5IGFkZGVkIG5vbi1mYXRhbCBlcnJvciBwYXRocy4NCj4gDQpUaGFua3MgZm9y
IHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KVGhlcmUgd291bGQgYmUgYSBsb25nIGxhdGVuY3kgaWYg
dGhlIGxpbmsgaXMgZG93biBhbmQgcHJvYmUgaXMgZmluaXNoZWQNCiBzdWNjZXNzZnVsbHkuDQpT
aW5jZSB0aGUgZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgd291bGQgYmUgaW52b2tlZCB0d2ljZSBp
biBldmVyeSBkcml2ZXIgcHJvYmUNCiBhbmQgcmVzdW1lIG9wZXJhdGlvbiBsYXRlci4gRWFjaCBk
d19wY2llX3dhaXRfZm9yX2xpbmsoKSB3b3VsZCBjb25zdW1lIGFib3V0DQogOTAsMDAwKjEwIH4g
MTAwLDAwMCoxMCB1LXNlY29uZHMuIEknbSBhZnJhaWQgdGhhdCBzdWNoIGEgbG9uZyBsYXRlbmN5
IHdvdWxkDQogYnJpbmcgYmFkIHVzZXIgZXhwZXJpZW5jZS4NCg0KSGVyZSBhcmUgdGhlIGxvZ3Mg
d2hlbiBwcm9iZSBpcyBhbGxvd2VkIHdoZW4gUENJZSBsaW5rIGlzIGRvd246DQpbICAgNTUuMDQ1
OTU0XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUE06IGNhbGxpbmcgaW14Nl9w
Y2llX3Jlc3VtZV9ub2lycS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0OWM5MDVlYy5jZmlfanQr
MHgwLzB4OCBAIDE4MzUsIHBhcmVudDogYnVzQDVmMDAwMDAwDQouLi4NClsgICA1Ni4wNzQ1NjZd
WyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVw
DQpbICAgNTcuMDc0ODE2XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUGh5IGxp
bmsgbmV2ZXIgY2FtZSB1cA0KLi4uDQpbICAgNTcuMTgyMzAwXVsgVDE4MzVdIGlteDZxLXBjaWUg
NWYwMDAwMDAucGNpZTogUE06IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEuNzQyZGZhMDc0YjQwZGNh
N2NhOTI1ZjBjNDljOTA1ZWMuY2ZpX2p0KzB4MC8weDggcmV0dXJuZWQgMCBhZnRlciAyMTM2MzM0
IHVzZWNzDQoNClsgICA1Ny4xODIzNDddWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAxMDAwMC5wY2ll
OiBQTTogY2FsbGluZyBpbXg2X3BjaWVfcmVzdW1lX25vaXJxLjc0MmRmYTA3NGI0MGRjYTdjYTky
NWYwYzQ5YzkwNWVjLmNmaV9qdCsweDAvMHg4IEAgMTgzNSwgcGFyZW50OiBidXNANWYwMDAwMDAN
Ci4uLg0KWyAgIDU4LjIxMDU4NF1bIFQxODM1XSBpbXg2cS1wY2llIDVmMDEwMDAwLnBjaWU6IFBo
eSBsaW5rIG5ldmVyIGNhbWUgdXANClsgICA1OS4yMTA4MzFdWyBUMTgzNV0gaW14NnEtcGNpZSA1
ZjAxMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVwDQouLi4NClsgICA1OS4zMTgzMTNd
WyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAxMDAwMC5wY2llOiBQTTogaW14Nl9wY2llX3Jlc3VtZV9u
b2lycS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0OWM5MDVlYy5jZmlfanQrMHgwLzB4OCByZXR1
cm5lZCAwIGFmdGVyIDIxMzU5NDkgdXNlY3MNCg0KU28sIEknbSBwcmVmZXIgdGhhdCBpdCdzIGJl
dHRlciB0byBsZXQgdGhlIHByb2JlIGZhaWxlZCB3aGVuIGxpbmsgaXMgZG93bi4gDQpIb3cgZG8g
eW91IHRoaW5rIGFib3V0IHRoYXQ/DQoNCj4gPg0KPiA+ICAJaWYgKHBjaS0+bGlua19nZW4gPT0g
Mikgew0KPiA+ICAJCS8qIEFsbG93IEdlbjIgbW9kZSBhZnRlciB0aGUgbGluayBpcyB1cC4gKi8g
QEAgLTg3NiwxMiArODc4LDE0DQo+IEBADQo+ID4gc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRf
bGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCQlyZXQgPSBpbXg2X3BjaWVfd2FpdF9m
b3Jfc3BlZWRfY2hhbmdlKGlteDZfcGNpZSk7DQo+ID4gIAkJCWlmIChyZXQpIHsNCj4gPiAgCQkJ
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGJyaW5nIGxpbmsgdXAhXG4iKTsNCj4gPiAtCQkJCWdv
dG8gZXJyX3Jlc2V0X3BoeTsNCj4gPiArCQkJCWdvdG8gZXJyX291dDsNCj4gPiAgCQkJfQ0KPiA+
ICAJCX0NCj4gPg0KPiA+ICAJCS8qIE1ha2Ugc3VyZSBsaW5rIHRyYWluaW5nIGlzIGZpbmlzaGVk
IGFzIHdlbGwhICovDQo+ID4gLQkJZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+ID4gKwkJ
cmV0ID0gZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiAr
CQkJZ290byBlcnJfb3V0Ow0KPiA+ICAJfSBlbHNlIHsNCj4gPiAgCQlkZXZfaW5mbyhkZXYsICJM
aW5rOiBHZW4yIGRpc2FibGVkXG4iKTsNCj4gPiAgCX0NCj4gPiBAQCAtODkwLDExICs4OTQsMTgg
QEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZQ0KPiAqcGNp
KQ0KPiA+ICAJZGV2X2luZm8oZGV2LCAiTGluayB1cCwgR2VuJWlcbiIsIHRtcCAmIFBDSV9FWFBf
TE5LU1RBX0NMUyk7DQo+ID4gIAlyZXR1cm4gMDsNCj4gPg0KPiA+IC1lcnJfcmVzZXRfcGh5Og0K
PiA+ICtlcnJfb3V0Og0KPiA+ICAJZGV2X2RiZyhkZXYsICJQSFkgREVCVUdfUjA9MHglMDh4IERF
QlVHX1IxPTB4JTA4eFxuIiwNCj4gPiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9S
VF9ERUJVRzApLA0KPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RFQlVH
MSkpOw0KPiA+ICAJaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ICsJaW14Nl9w
Y2llX2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gKwlpZiAoaW14Nl9wY2llLT5waHkgIT0g
TlVMTCkgew0KPiANCj4gUGxlYXNlIHVzZSB0aGUgbW9yZSBjb21tb24gaWYgKGlteDZfcGNpZS0+
cGh5KSBoZXJlLg0KPiANCk9rYXkuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+ICsJCXBoeV9wb3dlcl9vZmYoaW14Nl9w
Y2llLT5waHkpOw0KPiA+ICsJCXBoeV9leGl0KGlteDZfcGNpZS0+cGh5KTsNCj4gPiArCX0NCj4g
PiArCWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZf
cGNpZS0+dnBjaWUpOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+IA0KDQo=

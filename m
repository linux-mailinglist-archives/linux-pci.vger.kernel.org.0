Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DD554082
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiFVC0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVC0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:26:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98533A17;
        Tue, 21 Jun 2022 19:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZiGvpyI2SM00TQb3EIC23j6VemZOb75TRaa0TvpST8DptIEuNvnNu5j0X8A0UFfvwToBy/bK8JO3A0BdLQEachYMRk5gt6BJ329XC7hN/jEgBFrdSUuIlLYSni1kMe8BM+rCvZz2KriB65MTeTsTN9IcgIE5Ll4SKBw64SH0gb8R4lw1kWrccvyBTdS+uJSLUR8JoCCwyQBlePseSyUUNhNxSvIbj4NfOTfb+yWqralDbnIH7ExuNb0k+LmifUBonVBodSxaoHYCc6oMcmjg8J0xCCpT2Hp+lqs4auSPNkz0tgxCR4vbsLu2LM6z9T12HgisqiB8wXafrOsNoFCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjeOswbFvXkMYcPWnKKeeaSycgKg9l7VpY1npPxi/RA=;
 b=R2nL51OjwU5MOrwii5mWSOQVt51NOQV0XYqAtUERwbN9/t4rLsDf6mvPeUoBD8PjRdaEoncp1L0b1wWUeLjsZPoylA3zdECzDPsoaXrpH+KArc7uuupUCRzFeX+tVyEDoVpvMXfmGbmgsfiJ9JIrKr3Zu/x+TtV2X9LCd6DS/dD2TKuul5Uxhh5Il0iKrk/6+Mytfst3Zi99FlZPbTRTRLBNRlw0McbTURenHvr1aZsl38q1lFJ06hvsuBvTyFnaiqv4u1h+ppv53RTCjEnHSRE9VlQ9qgkAra4ialgLFw4XnhUezoVRL3uWjJV9U2zw4K50DNH9IDRyvrijOYKq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjeOswbFvXkMYcPWnKKeeaSycgKg9l7VpY1npPxi/RA=;
 b=GDLJqbtIQgttwAp5sgWbt0zkaaaA/SL7nF/Ye1tKER5mZ6hCy3ov1s3HrMlrzSyeqsk6voSeHgVZb+JN0VGsYlhI4oPDw249BOgX7nW3JxyA6J6z58KODI3kfQk1nhCaPe8mV42y/wK268ksJMHqEOBZTf9TQTwPCzSBdnN3lUg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSBPR01MB3445.jpnprd01.prod.outlook.com
 (2603:1096:604:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 02:25:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 02:25:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Thread-Topic: [PATCH] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Thread-Index: AQHYhWgX4Smva1duY0qczLjoIo7V1q1Z6XAAgADCFkA=
Date:   Wed, 22 Jun 2022 02:25:55 +0000
Message-ID: <TYBPR01MB5341F52441D02FAFDB717277D8B29@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com>
 <20220621142058.GE17181@thinkpad>
In-Reply-To: <20220621142058.GE17181@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aadf0de5-4255-492e-790c-08da53f68963
x-ms-traffictypediagnostic: OSBPR01MB3445:EE_
x-microsoft-antispam-prvs: <OSBPR01MB344564112ECF2DDBCFD5E2E0D8B29@OSBPR01MB3445.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xvEbHgFcw92NbKHlGZcz/U29Rm3aHs1woPCLk9v5Z0LSNm4gINsim/TqIBwkXSjsZOa3YtxWb0wXq677IPkxcMV5GtFmLBo3sV8yI7RKOcchQk0J/J59duPesVDUzFY6bNcaZYn1QUVUQxnFncFKyM8mR9h4GlySrqHB+hoLIp8CjnKFdpuxYY+TPc6ZCL0ix59KInILnJxs6lmUCgNMfXvgWd+6MU1nf31dqTOLoD4pqb+KPf1+NEA0MvoMuR+OOBp57aqqv3W0sHN4MW5iZsv6lUWacpZwzq/lDYIXsqPuDaqQlkGIJpGqmROze6GU16Abc42q+mrbSfojGvViHHcTnc8h3M3t3fSeTmTq+lIAeZLagj2Kwo5To/bSSy6iXuXA3hKwJh20jqDaWmI7h866NlJ4GyubUEMu2yZNi4xsObQDxkWcVDSRyBWWqC4HyC5V4JECIJ8cR2JUWB/6pMWwAIrp2XwdlA+1PgCZW4taPe0HrYrOPjy/++C2kM5tEr/dDOVI17z84Fy0eZo+ypOZK9FkkFOYTcJojJaL7DQyrEs8ufdDOoDKKANWstZugRResPYjncCAzy3Yg7zjh2dotzvTXBPpLPKvNM03m9Rs7O7vmovff0+Lmu6li8hQ10HC5JIcRujSsQnvcrd+/Ziah+n6tCbeeRef8tqhYTopSB1QEI9l4+nJCFuKpMzsnvS0zKKwLX283wRPqaBDXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(6916009)(86362001)(54906003)(8676002)(4326008)(71200400001)(55016003)(41300700001)(38070700005)(9686003)(5660300002)(52536014)(478600001)(2906002)(8936002)(66476007)(66446008)(66556008)(38100700002)(186003)(83380400001)(122000001)(33656002)(66946007)(64756008)(7696005)(6506007)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enF0dUpiSmlpWlpNNTRibzFObll2MXpSY3JMTUlWRDROZHEzczRvMVNqeGUw?=
 =?utf-8?B?M0NCSnpKTEFhdUpQbmNxcnJiekZKUjZZdmVKMm54bXFubUdFRkpoMEtLVThu?=
 =?utf-8?B?SlVhSnJKWkF6Vkh5MUI4Q3MwTm5pY29mSERwdTlFYm5qUGZacDJlQy81eC9p?=
 =?utf-8?B?TG95VitVbDFvR2ZUS0hVRDVUOC9Wd0Q2ZWZhZ0ZjTEYybmRSbjJjM1poUVQ4?=
 =?utf-8?B?MW1NK0hhM3lmVzZDYXlPQWw0RTVPV3dvUzFpcXNNR05OZVFzQU8xVmVRYmtK?=
 =?utf-8?B?UCswNm1kUGNmaEE4MVdUZmNtd3ZVbWNvQkJXZUlaSm9SYVgwdFlJMFBaMmRk?=
 =?utf-8?B?T014VVM5dG5VQVgvazZKS1Z5YXRCektDb3htUVEyVVFOSk16ejlTNElaSnR3?=
 =?utf-8?B?TE4zVVlJR2pWUnRNRTQ3M1JZeUZjR0dHRnZ6eWZ1ZThxNG5hdks4cGpJMFZM?=
 =?utf-8?B?VXF6d08wSjhMSzJNM1ZEUXJoR0RHTGEyUG5mb01ad1VtMEliNEFYS0ljc055?=
 =?utf-8?B?anNlZml5ZFNBWWVxVTFLZkVhbkwwWWVMcU91TTJHTjJNam04S0REWGxQb2Mz?=
 =?utf-8?B?MWcxMWEwdS92TjhFTXNSLy83UHErcWM0SWREQjIzL1kyQXRudDdzMDVJcTFB?=
 =?utf-8?B?NTNXZmpseU4yYzRZN0dySjFnU0NZRzVkbVdxMDJhZ1pFZ0R2cERmK2w2YzNP?=
 =?utf-8?B?VFptakJaSXJwNUt0aDRqcFp3dTIwSDFnSVhQM2twcXFVaFRMR0xnUzhvM2JR?=
 =?utf-8?B?a0xTU0R6TURKMVNWMktHUVM0aFhVYmFacTRySFNFV2UwVG5NOUpvdzJjZStv?=
 =?utf-8?B?dmZsdXBlS09lUU1VUjdKb2xTZ0NlT0I3N1ZBNUhmN01TYThpMFdEZU5Ybzh0?=
 =?utf-8?B?NUVUK29hYldXaDgyY2FRVitpUGduRk5EQTQ0L3IvVnJZZDlZTmJGOE1QTHBF?=
 =?utf-8?B?eS9aZUZOMG14MWY1eFJmdDFpc1VzUTZ6eEdXWEVnWG5oNWVWUTZBSmQrd3g4?=
 =?utf-8?B?NGNhZEtHYUJtM01QdEloZXF0RW5CbVJISjViWXZDZmk3OGQxNXAxYTZZOGZZ?=
 =?utf-8?B?YXRXekVTdDhldDNLbk0rcXRYdHlSL2xVRFM4bFpzL2JscXZidHk0RmpnamY0?=
 =?utf-8?B?MXlkTjhhRHhoUENsVGNsTEYweVF1M1RMVHZ1Z29weTlIMWtna0NkL2hRcW1l?=
 =?utf-8?B?dEtRZGFsc3RES2ZMdXBWZUZTOXRrQVBSVGpRQ3g5M01yZkJ1SUFPTm1TK2I4?=
 =?utf-8?B?NTRsZjBJRWJnNWFuSkZOVjc4VW5PdlhIMnpucDhUV09Jd05kY1lyZi81NER1?=
 =?utf-8?B?cE5wRGs5WlpPWmdudFArKzdrUEFlbjZrRElIMlFYTVdwNTk0Q3Q2Z1J6cEdv?=
 =?utf-8?B?Yy9sbnFqOUc2R2taaThyOFJ5NGVtRnlkSVNRb24wOUcxNUN1d2Q2L1JkMmhB?=
 =?utf-8?B?Yno2VmtOVGR0aVlRVzdpSlBUTEFmRmtiN1ZwTC9sUDE5TS9DK1BvV1hFRXM1?=
 =?utf-8?B?THNub2ZyMm5rUWlyRjhkMUUzcFQ3Wm4ra3VNYnVsWVpjcnQyc0JpS3lEVlUy?=
 =?utf-8?B?NGVrS0k0QnpEcHd1RzB2OUxybFJOR0FpQU1mRmRaeDM2YXNDcTB0ZE5QcTQ5?=
 =?utf-8?B?NGVvV29TVEpDRTVSYjF2OG1BRzFPVVN5dEoyMG5sYTI1eUhXbTlQNGJMRHpL?=
 =?utf-8?B?T0laTHNzMVorM1lpNGU2MCs3NzZKMHFMYWoxdklodWpmc05lbFZsRXVScURT?=
 =?utf-8?B?cnJXK1hXNDVSYkxGajdvcW91MmFjYlNoUm56c2dwL25pSTMrQjBPRm9HcUtJ?=
 =?utf-8?B?SUJ2R1Y3TVNkZ2hlanpxZDVZZnpnQUQ0YklSV1NMMnVVazFsZmR0UzVQYkFQ?=
 =?utf-8?B?SDB4VlI0NW43VkwxM21VT1ZBR0pjUit4bUdIUktGV1pKTVBHaUZHd0ZBWTZ1?=
 =?utf-8?B?QlhYM3NGMEp6eWVkZjcyL2l1WHVpcGlQR1NXaGlOMnNLRkNDY2tpNStqSmh0?=
 =?utf-8?B?YmliR3RCSzBtdFpvOXVsNVI4WWpXSkJSK3cwM05DeDVsZWc5QkZSakFNZ2FD?=
 =?utf-8?B?TjhwektaZ1hJR1pHTG10S1pUNEpWK05qWnViUVBpcmJKN25xeUFNYWtXTEw1?=
 =?utf-8?B?cUppNHYrbW5Gb084TGxnUGZnZkRkamFaenZ4ZGRma2tEamx1NzlqbCtudE1z?=
 =?utf-8?B?Rmw2blc2NnlJQXNGNkhXcUUrZjlTYSthVm0wZmRXR0Q0RkEyR1MvaEkrR3B5?=
 =?utf-8?B?OERpYnE0bTI5d0o0N256WVBWZXcrNG9yODZ5VHNSdWQ3R3NTWjZ4V2ZuaTZG?=
 =?utf-8?B?Q1dSOTJrWGExb1BhRm42VSttUG5tRzZ0SENpajZuMDQ5NmQvc2NOSlRBd1lW?=
 =?utf-8?Q?GJPQkaD54oYubDfNw1cxu1/hyRzqoRl1Ch4KlR4T6Czeg?=
x-ms-exchange-antispam-messagedata-1: vW/t/18MXe1mE9Lm5HiIrnqm+iTkLdShpjw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadf0de5-4255-492e-790c-08da53f68963
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 02:25:55.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6y+hdQCjmGL6CeQ2gmouBURx/RcyaEjWDB0Or8tyg0f9KZvia10LU7hpVzk7maaiWX3frdmG82FSLxemNP0y5NEuOM8a9QUN0gQApPvJBHQ6xwjlqiV1h792BwL7vrGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFR1
ZXNkYXksIEp1bmUgMjEsIDIwMjIgMTE6MjEgUE0NCj4gDQo+IE9uIFR1ZSwgSnVuIDIxLCAyMDIy
IGF0IDA5OjExOjQ3UE0gKzA5MDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEFkZCBw
Y2lfZXBjX25vcF9yZWxlYXNlKCkgZm9yIGVwYy0+ZGV2LnJlbGVhc2UuIE90aGVyd2lzZSwNCj4g
PiBXQVJOKCkgaGFwcGVuZWQgd2hlbiBhIFBDSWUgZW5kcG9pbnQgZHJpdmVyIGlzIHJlbW92ZWQu
DQo+ID4NCj4gPiAgRGV2aWNlICdlNjVkMDAwMC5wY2llLWVwJyBkb2VzIG5vdCBoYXZlIGEgcmVs
ZWFzZSgpIGZ1bmN0aW9uLCBpdCBpcyBicm9rZW4gYW5kIG11c3QgYmUgZml4ZWQuIFNlZQ0KPiBE
b2N1bWVudGF0aW9uL2NvcmUtYXBpL2tvYmplY3QucnN0Lg0KPiA+ICBXQVJOSU5HOiBDUFU6IDAg
UElEOiAxMzkgYXQgZHJpdmVycy9iYXNlL2NvcmUuYzoyMjMyIGRldmljZV9yZWxlYXNlKzB4Nzgv
MHg4Yw0KPiA+DQo+IA0KPiBIbW0uLi4gU28gdGhlIGNvcmUgaXMgY29ycmVjdGx5IHRocm93aW5n
IHRoZSB3YXJuaW5nIGhlcmUgYnV0IGp1c3QgdXNpbmcgYSBOT1ANCj4gcmVsZWFzZSBmdW5jdGlv
biBpcyBub3QgdGhlIHJpZ2h0IHNvbHV0aW9uIElNTy4NCj4gDQo+IEN1cnJlbnRseSwgcGNpX2Vw
Y19kZXN0cm95KCkgaXMgaGFuZGxpbmcgYWxsIHJlc291cmNlIHJlbGVhc2UgaW5jbHVkaW5nIGZy
ZWVpbmcNCj4gdGhlIG1lbW9yeSBmb3IgZXBjLiBCdXQgSSB0aGluayB0aGUgImtmcmVlKGVwYyki
IHNob3VsZCBiZSBtb3ZlZCB0byB0aGlzDQo+IHJlbGVhc2UgY2FsbGJhY2suIFJlYXNvbiBpcyBx
dWl0ZSBvYnZpb3VzLiBVbnRpbCB0aGUgcmVsZWFzZSgpIGNhbGxiYWNrIGdldHMNCj4gY2FsbGVk
LCB0aGVyZSB3b3VsZCBiZSBhICJlcGMiIGRldmljZSBpbnN0YW5jZSBmbG9hdGluZyBhcm91bmQg
YW5kIHdlIHNob3VsZCBub3QNCj4gZnJlZSBpdCB1bnRpbCB0aGVuLg0KDQpJIHVuZGVyc3Rvb2Qg
aXQuIEVzcGVjaWFsbHksIHdlIGVuYWJsZSBDT05GSUdfREVCVUdfS09CSkVDVF9SRUxFQVNFPXks
IHRoZSByZWxlYXNlKCkNCmNhbGxiYWNrIHdpbGwgYmUgY2FsbGVkIGFmdGVyIHBjaV9lcGNfZGVz
dHJveSgpIGV4aXRlZC4gU28sIEknbGwgbW92ZSAia2ZyZWUoZXBjKSIgdG8NCnRoZSByZWxlYXNl
IGZ1bmN0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IFRoYW5r
cywNCj4gTWFuaQ0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9z
aGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNp
L2VuZHBvaW50L3BjaS1lcGMtY29yZS5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9p
bnQvcGNpLWVwYy1jb3JlLmMgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9wY2ktZXBjLWNvcmUuYw0K
PiA+IGluZGV4IDNiYzkyNzNkMGEwOC4uY2I1MzM4MjFiMDcyIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2VuZHBvaW50L3BjaS1lcGMtY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
ZW5kcG9pbnQvcGNpLWVwYy1jb3JlLmMNCj4gPiBAQCAtNzQ2LDYgKzc0NiwxMCBAQCB2b2lkIGRl
dm1fcGNpX2VwY19kZXN0cm95KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHBjaV9lcGMgKmVw
YykNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkZXZtX3BjaV9lcGNfZGVzdHJveSk7
DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgcGNpX2VwY19ub3BfcmVsZWFzZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gK3sNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIF9fcGNpX2Vw
Y19jcmVhdGUoKSAtIGNyZWF0ZSBhIG5ldyBlbmRwb2ludCBjb250cm9sbGVyIChFUEMpIGRldmlj
ZQ0KPiA+ICAgKiBAZGV2OiBkZXZpY2UgdGhhdCBpcyBjcmVhdGluZyB0aGUgbmV3IEVQQw0KPiA+
IEBAIC03NzksNiArNzgzLDcgQEAgX19wY2lfZXBjX2NyZWF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IGNvbnN0IHN0cnVjdCBwY2lfZXBjX29wcyAqb3BzLA0KPiA+ICAJZGV2aWNlX2luaXRpYWxpemUo
JmVwYy0+ZGV2KTsNCj4gPiAgCWVwYy0+ZGV2LmNsYXNzID0gcGNpX2VwY19jbGFzczsNCj4gPiAg
CWVwYy0+ZGV2LnBhcmVudCA9IGRldjsNCj4gPiArCWVwYy0+ZGV2LnJlbGVhc2UgPSBwY2lfZXBj
X25vcF9yZWxlYXNlOw0KPiA+ICAJZXBjLT5vcHMgPSBvcHM7DQo+ID4NCj4gPiAgCXJldCA9IGRl
dl9zZXRfbmFtZSgmZXBjLT5kZXYsICIlcyIsIGRldl9uYW1lKGRldikpOw0KPiA+IC0tDQo+ID4g
Mi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprg
rqTgrr7grprgrr/grrXgrq7gr40NCg==

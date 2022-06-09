Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809DF5443A8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiFIGSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiFIGSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:18:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE93203D3A;
        Wed,  8 Jun 2022 23:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuOoPS6k/94+xxR6DmQyUaJT+VqN/uGFEuJDjK719DFB/5UzBJuIkoKmACayBgxpCj2uJcMbo5wUWLmh/hlfXpyzHmouBd9rvPO1wfJnvh6KAcuXlfExfz+ewHOHIDm7zSwbkY+h1Jz0rAZ/ORCDQb6Fc/lLDLCJaJb7LqFjqZRRrS/efA5TfcGkoKhhvzNBGUCp2r84iENmIOVsbsVLpGjz6ZUIRxqnMHhnlRgyYi8jvGn6RPQPVO/ymj/guMuXE90RU6H3jqpt3WQTORxZ7S4+jLDMaxniQmKneAjb8IXa2QsotnaHou/umbFDsxQJ16r9T4gC/OPiP2t19qj/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRv8SYIm5OlU6Pw/tCnq/7Ub2+xTyTXJyfTySmvNl5E=;
 b=SLenQMS9maKyps/Yu/FWbzxLmX/6WGXHceDSW9vbmjGIq4X5Uz7okQp1O7mWDlFQcQCIY8s2GDPjgRYN9b7ZtMLtmlnqhT7/+F0/fU9Ydq0ADexjPvZ2iiYZZ70DTUj/Gyje3xtjQPybbDWFUKsW4PgZgky5qCYrymW3VOChvTHsFxUWkWp4uT8eaeG+i4pah5JYHObGmwkE7OC9dTmxCVpl+Jo/a+Z09utqx1xnmPHpARdwhwaoib4kAsx4zi57PArMjEik9Yd93H/S7bNI2LROSwsRUG2UD/8fIRoZzaxpcaj1cryWkI8VFacJkdec9oxbjv9E6Suiwd6Uqly+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRv8SYIm5OlU6Pw/tCnq/7Ub2+xTyTXJyfTySmvNl5E=;
 b=SQwRTHMIXWS/1PfCgbdb1MFLrsUmUjOCvuIqJRAOH6PU1lyAOT51rhFlcmsIGYVeGax9eJOw9NIGe47FLvEEQrgR7xh9uJVlUbI05FoBahQ+6W4qCw88KnqlsqHcmQvu2RqOvAgl0i+t6FIvkoqlQUNBjzo5pAk7w7hKaKqaIQQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7888.eurprd04.prod.outlook.com (2603:10a6:102:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:18:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:18:11 +0000
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
Subject: RE: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Topic: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Index: AQHYYOzlA5pwlzpYQUSX/QC6T/qeLK1FVV4AgAEo5RA=
Date:   Thu, 9 Jun 2022 06:18:11 +0000
Message-ID: <AS8PR04MB8676D6D6354457E523A4C2C98CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-8-git-send-email-hongxing.zhu@nxp.com>
 <323f9352fcf22c040417b16e57647695a48c1395.camel@pengutronix.de>
In-Reply-To: <323f9352fcf22c040417b16e57647695a48c1395.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3003e0a1-38d1-482e-3da2-08da49dfd430
x-ms-traffictypediagnostic: PA4PR04MB7888:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7888E76FC79CABBA1B62DDFB8CA79@PA4PR04MB7888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NeIKDE39H8NyzQ6SeqJH0+JJ+amFH/6hdMMrDhri6oCmXOjrPIFeZ0p+XE/X7tY8PeJvmnT/JqDK4TUOPdIUD9GUi+5f//1Pcgapt1229R2g1Vmqfu+B/Sp/KVP0CeDEIgjc12526dJBllR0e9cPugVfFNKlcB3nVclltO8m+ACGrfCA0gzumRPUlctMBSDuZc1rAsYFWNSBQHVHCLUwppqsowJzlHrkkijv/clNaEQEwe7RkDuZJmButMWKVi/lAFE8TZuVNql4Y5bc6ldxvrPksszj+UilRodUMtv4DZHVTspSyNWsO95PAWWPOrUXFP9mtUGI4O2c2LQ/9kLvhWZ31lAXvnCTbrwaOpNMo1MqroJ3Qcl7gFbzxFuPV/0FU6m9hvcUmS2HRZ2F6Noz8P4to3D+gh8G0ODj3G9ryBPnQd/0euz4ZqTirpNkVRnSz6QbArqOMlRR0fqJt7eUbQTYhYfey/2xN+g+GMtFZ0aBBXq8uJvqD0FIJ5PN6Fsi6OaJ2CMhm28tBemiWzeX/FQJyrya/S6AtpOlfgy3hkExrLQslZiQ3b4e7EmqBIygdzM3dknCuAQctwhJ0pjPrfTQJIOCYKIziO7TEvcjHnUem7RwJ4WXvKxXmt30D6cY8suZkHA7mAgfbbqlOeQQ81z7Cg1iOgvaOdFfXtTxDj3cadoVf+AXkjYaAAUXZ89UU+tRn7ytThyRgvysguOeJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(2906002)(6506007)(83380400001)(53546011)(8936002)(5660300002)(26005)(9686003)(508600001)(52536014)(55016003)(7416002)(316002)(110136005)(38100700002)(8676002)(4326008)(38070700005)(33656002)(122000001)(44832011)(71200400001)(186003)(86362001)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCtPbysyaEcvdXlOSkduQkl4RkNrUWtnT3BJMTJySGlpaTRnbS9oVDVBcDEx?=
 =?utf-8?B?SG9UWjFmVG5MbnpxU1JIZnlYSk5MVTVLWmpncEp4TkFObktETENqTXFRZjFp?=
 =?utf-8?B?dlRNNzIzR2ErV0E5RjVackIrQkUyMEpPTGwwL2RmLzlmcGV0dmE3YmJha2Rv?=
 =?utf-8?B?RnN1MDNvTTFUMlhNRHdIeW1kckxnc2IvdzFqQ3lscDRndUx6Tm0zODlrRGZ1?=
 =?utf-8?B?dG1ZZVVPNDdlaUM4RlFNblg2Vlo4U25sN09mT1o4VkRvbFB1UUU1VVBISm1F?=
 =?utf-8?B?SENIb0lYTmlWTHczaVFUenNFa2Y0L3B1Y2s5QmI5ZWl0Qi9XQVEramgwZ3Mw?=
 =?utf-8?B?b2d0Q25FUEZUQ3RKZ2MxTThuVTRtdTJSK3hsVVI1cGVXWVRZdTNPTlBqTU9Y?=
 =?utf-8?B?UGNTdHRWTkFDTkVNT0NNUWorWnBhSkEvZGxOL2w0eVlEa3dOakFwcDJnMDhO?=
 =?utf-8?B?bXZRc1AvZHpMZzVyam5yM2d5YWFPZkVWcE1nUUhNM3dRNWU4SG5JQ0piYTk2?=
 =?utf-8?B?TUYzUUtscGF0NUxWSGViYXcvYk5GcnIyUUExSHYyNGF2RUV0TURaVUVvZDZp?=
 =?utf-8?B?VE9pWWJERlM2bU1yOVZqNEVFSWEwRzB0SnlqUEhSOU1IUjdqbFBmTGVPeXl5?=
 =?utf-8?B?U1R6WlZTUVhTeDhKenNGNnNQWWpIUGJDeWdEVG81d1M5cU1PTi9RN2NURjdN?=
 =?utf-8?B?TGdmSmJFc0RLVSs0U09xLzhUN2t3NUt0dUlrRGFMTGo4SnpmRm16UUlEVko2?=
 =?utf-8?B?VW93SlB2dmRpTHVTVzRhaFZiWVpWc1c5K1l5UzFBSFp3dlI1V3l6SW52R3Zw?=
 =?utf-8?B?Wms0LzM1OUlGdFQ4MmxXVW93aktJeTdxeTRaYVd0UkFEMnRvcFUwajN6c2FR?=
 =?utf-8?B?cGpDd2hNd2l0a3lTN0RiZ1dIUUp5d3NoM2lLaWM0YUZMMEpURVZPWE5IcEhZ?=
 =?utf-8?B?ZXo5ZkM3ajBUVGFtUVlNUWprWXJFOGIxVGM3V2JXUVJMclZXdVZUaHI4UDBT?=
 =?utf-8?B?a3F1SFp5MXBDdGFxQ1QrQXZyV3FacmJJc1ZmZldLL1pFNFNvK1l1MTZQMWUw?=
 =?utf-8?B?OCs1NnhyOHZJSGFaUXZhVlY1dDNOaVN3cEhQeUFlQmx6djcyVUVROS9NenVQ?=
 =?utf-8?B?ajB6VDJlTGJGYXlRL245bXExZlpuRE04N2hKaTRxd1MveXJQdzE2ZDdqTVQr?=
 =?utf-8?B?Tkh3aUlsVzArMWpZQzNpZ0kwU3JncU5CVUVwN2dHajJnMHVFbmlkaWp2VkZz?=
 =?utf-8?B?MDlRUGpGcVVycDBwcWZRazMrSmllSzRxeXNsbjRtTkN3WktobVZsY3h3YWxs?=
 =?utf-8?B?RVJoN2ZJK3Z5cXRCQlBCeUZPT0N5TVptSkhjeUQ2cVRuV1h5Ykp2NCtPR2lI?=
 =?utf-8?B?Uytxdk1iL2dlV0tMVnlNUHUrdVJYQWdDUzBXR3NVVitPcWE3aEJNWjE4bC91?=
 =?utf-8?B?NCthVjBpOC9XYXZ1Y1FSYlpkZk4vdEhxL1FJelJuWlRDRzE4RW1OREJWbWQy?=
 =?utf-8?B?cFplaXY5T1dYWGlOUWhpYk5teW5TVk5RUHFlZGZCWGg4VWFXVlkyV3gwVlVG?=
 =?utf-8?B?aUdOMk9iUDN6b1pib0VGZHg2SnpRd1lRbHpWWXhHNU5TTkxtUEEzb080M0R6?=
 =?utf-8?B?WjNsaTVNVWtZSTkvUUg4QlpHOVZnV04xSEQwYkxtcVY3K29JMSt0MVFaQ0NB?=
 =?utf-8?B?bHphSTB0QyttdE5PakwwQlhSTHBMc1haQXZ6SHNVUUdiQWJ1dDRaMnZKQmpM?=
 =?utf-8?B?ZlF0MGU4ZDlUcGJRMk1PYVNva09FQkVEejFzbnByQ25JdXdDYlRucVZyeFIv?=
 =?utf-8?B?WkwyQVduN3d4VzNMNFYrTWJuZjJYN3pwUEVUWG9zUXcwUXBEOXNZRFN5TDNX?=
 =?utf-8?B?R2pMUytua0xmOGF2aS9qWVc5ZUhEdmJ2YlZZWW9aOUlVZ2ozcm1JeGo2ODVN?=
 =?utf-8?B?a2pDeVg4a1BGaHVvT0F6bW01MEFSc2cyRVdhQmg3TjBQVWM1dDNFWVJWeEpv?=
 =?utf-8?B?ZnBBaVFOY1h1U1VjYndJOTU3VisxWDF3Sjl0ZEI5NWJvbUdBN2F2QlBSVXhM?=
 =?utf-8?B?SmQ4QkVocVhaVzd4dkRDWU5oOTVFMy94blh1aUhZQUZOVFBGaGNMbUc1YTQx?=
 =?utf-8?B?VDRQWUNXbEErUTZIbXVSa01WdURVK3JKc3oxTG5QOERVOVBSSmRyb0pCT0Ji?=
 =?utf-8?B?UEk1NzFZeGUzWS9xWWl1UVRJYXUzRGdBSVpJYVZ4MU1pZjJZNWloZWI0SUFL?=
 =?utf-8?B?cmFqWHpkV0JYcVg1YTNXb2c2L2NNRi9wY2NBeXkyRnZCUUlrVlVGU05KSHpZ?=
 =?utf-8?B?bUVyYmhNY2ZaclFEMjdVQjNYbW8xblZFcUxGSU90M3dhajZ5L1JoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3003e0a1-38d1-482e-3da2-08da49dfd430
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:18:11.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDaMgXGniMtJ3efWLfFLsrBGFnxX7Q2tH4iB0jhC0qgWUS/tks/voYxHt4YSGh7EJQLFbjP0uHnAV3p89Pfjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7888
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg45pelIDE1OjQ1DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA3Lzhd
IFBDSTogaW14NjogTW92ZSB0aGUgcGh5IGRyaXZlciBjYWxsYmFja3MgdG8gdGhlDQo+IHByb3Bl
ciBwbGFjZXMNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbSAwNi4wNS4yMDIyIHVtIDA5OjQ3ICswODAw
IHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gVG8gbWFrZSBpdCBtb3JlIHJlYXNvbmFibGUsIG1v
dmUgdGhlIHBoeV9wb3dlcl9vbi9waHlfaW5pdCBjYWxsYmFja3MNCj4gPiB0byB0aGUgcHJvcGVy
IHBsYWNlcy4NCj4gPiAtIG1vdmUgdGhlIHBoeV9wb3dlcl9vbigpIG91dCBvZiBpbXg2X3BjaWVf
Y2xrX2VuYWJsZSgpLg0KPiA+IC0gbW92ZSB0aGUgcGh5X2luaXQoKSBvdXQgb2YgaW14Nl9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPg0KPiA+IEluIG9yZGVyIHRvIHNhdmUgcG93ZXIg
Y29uc3VtcHRpb24sIHR1cm4gb2ZmIHRoZSBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMNCj4gPiB3aGVu
IHRoZSBpbXg2X3BjaWVfaG9zdF9pbml0KCkgcmV0dXJuIGVycm9yLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNzcNCj4gPiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMo
KyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMNCj4gPiBpbmRleCBkMTIyYzEyMTkzYTYuLmYwZmZkOTAxMTk3NSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC00OTcsMTQg
KzQ5Nyw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2Nsa19lbmFibGUoc3RydWN0IGlteDZfcGNp
ZQ0KPiAqaW14Nl9wY2llKQ0KPiA+ICAJCWdvdG8gZXJyX3JlZl9jbGs7DQo+ID4gIAl9DQo+ID4N
Cj4gPiAtCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gLQljYXNl
IElNWDhNTToNCj4gPiAtCQlpZiAocGh5X3Bvd2VyX29uKGlteDZfcGNpZS0+cGh5KSkNCj4gPiAt
CQkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gcG93ZXIgb24gUEhZXG4iKTsNCj4gPiAtCQlicmVh
azsNCj4gPiAtCWRlZmF1bHQ6DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQl9DQo+ID4gIAkvKiBhbGxv
dyB0aGUgY2xvY2tzIHRvIHN0YWJpbGl6ZSAqLw0KPiA+ICAJdXNsZWVwX3JhbmdlKDIwMCwgNTAw
KTsNCj4gPiAgCXJldHVybiAwOw0KPiA+IEBAIC01OTcsMTAgKzU4OSw3IEBAIHN0YXRpYyBpbnQg
aW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9w
Y2llKQ0KPiA+ICAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAg
CWNhc2UgSU1YOE1ROg0KPiA+ICAJCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14Nl9wY2llLT5w
Y2llcGh5X3Jlc2V0KTsNCj4gPiAtCQlicmVhazsNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+IC0J
CWlmIChwaHlfaW5pdChpbXg2X3BjaWUtPnBoeSkpDQo+ID4gLQkJCWRldl9lcnIoZGV2LCAid2Fp
dGluZyBmb3IgcGh5IHJlYWR5IHRpbWVvdXQhXG4iKTsNCj4gDQo+IFRoaXMgbG9va3MgZmlzaHku
IFlvdSBub3cgZmFsbC10aHJvdWdoIGZyb20gdGhlIDhNUSBjYXNlIHRvIHRoZSA4TU0gY2FzZSwN
Cj4ganVzdCB0byBicmVhayB0aGVyZS4gUGxlYXNlIG1vdmUgdGhlIDhNTSBjYXNlIGRvd24gdG8g
dGhlIDZRUCBjYXNlIHRoYXQgYWxzbw0KPiBkb2Vzbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgaGVy
ZS4NCj4gDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpXb3VsZCBiZSBjaGFuZ2VkLg0KDQo+
ID4gIAkJYnJlYWs7DQo+ID4gIAljYXNlIElNWDdEOg0KPiA+ICAJCXJlc2V0X2NvbnRyb2xfZGVh
c3NlcnQoaW14Nl9wY2llLT5wY2llcGh5X3Jlc2V0KTsNCj4gPiBAQCAtOTE4LDE1ICs5MDcsMzgg
QEAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBwY2llX3BvcnQNCj4gPiAq
cHApDQo+ID4NCj4gPiAgCWlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0K
PiA+ICAJaW14Nl9wY2llX2luaXRfcGh5KGlteDZfcGNpZSk7DQo+ID4gKwlpZiAoaW14Nl9wY2ll
LT5waHkgIT0gTlVMTCkgew0KPiANCj4gU2FtZSBjb21tZW50IGFzIG9uIHRoZSBsYXN0IHBhdGNo
OiBkcm9wIHRoZSAiIT0gTlVMTCIuDQpPa2F5LCBnb3QgdGhhdCwgYWxsIG9mIHRoZW0gd291bGQg
YmUgY2hhbmdlZC4NClRoYW5rcy4NCg0KPiANCj4gPiArCQlyZXQgPSBwaHlfcG93ZXJfb24oaW14
Nl9wY2llLT5waHkpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJw
Y2llIHBoeSBwb3dlciB1cCBmYWlsZWQuXG4iKTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiAr
CQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0ID0gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVf
cmVzZXQoaW14Nl9wY2llKTsNCj4gPiAgCWlmIChyZXQgPCAwKSB7DQo+ID4gIAkJZGV2X2Vycihk
ZXYsICJwY2llIGhvc3QgaW5pdCBmYWlsZWQ6ICVkLlxuIiwgcmV0KTsNCj4gPiAtCQlyZXR1cm4g
cmV0Ow0KPiA+ICsJCWdvdG8gZXJyX2V4aXQwOw0KPiANCj4gVGhpcyBsYWJlbCBpcyBub3QgdmVy
eSBkZXNjcmlwdGl2ZS4gUGxlYXNlIHJlbmFtZSB0byBzb21ldGhpbmcgbGlrZSBlcnJfcGh5X29m
Zg0KPiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KT2theS4gVGhhbmtzLg0KDQo+IA0KPiA+ICsJ
fSBlbHNlIGlmIChpbXg2X3BjaWUtPnBoeSAhPSBOVUxMKSB7DQo+IA0KPiBUaGUgZWxzZSBwYXRo
IGlzbid0IG5lZWRlZCBoZXJlLiBJZiB0aGVyZSB3YXMgYW4gZXJyb3IgeW91IGFscmVhZHkgbW92
ZWQgdGhlDQo+IGNvbnRvbCBmbG93IHRvIHRoZSBlcnJvciBsYWJlbC4gU28gZHJvcCB0aGUgZWxz
ZSBhbmQgYWdhaW4gaGF2ZSB0aGlzIGJsb2NrIHVuZGVyDQo+IGEgc2ltcGxlICJpZiAoaW14Nl9w
Y2llLT5waHkpIiBzdGF0ZW1lbnQuDQpPa2F5LiBUaGFua3MuDQoNCj4gDQo+ID4gKwkJcmV0ID0g
cGh5X2luaXQoaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2
X2VycihkZXYsICJ3YWl0aW5nIGZvciBwaHkgcmVhZHkgdGltZW91dCFcbiIpOw0KPiA+ICsJCQln
b3RvIGVycl9leGl0MTsNCj4gDQo+IEFnYWluLCBwbGVhc2UgZ2l2ZSB0aG9zZSBsYWJlbHMgYSBt
b3JlIGRlc2NyaXB0aXZlIG5hbWUuDQo+IA0KPiBBbGwgb2YgdGhlIGFib3ZlIGNvbW1lbnRzIGFs
c28gYXBwbHkgdG8gdGhlIGNoYW5nZXMgaW4NCj4gaW14Nl9wY2llX3Jlc3VtZV9ub2lycS4NCk9r
YXksIHRoYW5rcy4gV291bGQgYmUgY2hhbmdlZCBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkIFpodQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiArCQl9DQo+ID4gIAl9
DQo+ID4NCj4gPiAgCWlteDZfc2V0dXBfcGh5X21wbGwoaW14Nl9wY2llKTsNCj4gPg0KPiA+ICAJ
cmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnJfZXhpdDE6DQo+ID4gKwlpbXg2X3BjaWVfY2xrX2Rp
c2FibGUoaW14Nl9wY2llKTsNCj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCXJl
Z3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ICtlcnJfZXhpdDA6DQo+ID4g
KwlpZiAoaW14Nl9wY2llLT5waHkgIT0gTlVMTCkNCj4gPiArCQlwaHlfcG93ZXJfb2ZmKGlteDZf
cGNpZS0+cGh5KTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IGR3X3BjaWVfaG9zdF9vcHMgaW14Nl9wY2llX2hvc3Rfb3BzID0geyBAQA0K
PiA+IC0xMDMxLDE0ICsxMDQzLDQ3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Jlc3VtZV9ub2ly
cShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4gIAkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9w
Y2llLT52cGNpZSk7DQo+ID4NCj4gPiAgCWlteDZfcGNpZV9pbml0X3BoeShpbXg2X3BjaWUpOw0K
PiA+IC0JaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiAtCWR3
X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+cGh5ICE9IE5VTEwpIHsN
Cj4gPiArCQlyZXQgPSBwaHlfcG93ZXJfb24oaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJCWlmIChy
ZXQpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJwY2llIHBoeSBwb3dlciB1cCBmYWlsZWQuXG4i
KTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiArCWlm
IChyZXQgPCAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJwY2llIGRlYXNzZXJ0IGNvcmUgcmVz
ZXQgZmFpbGVkOiAlZC5cbiIsIHJldCk7DQo+ID4gKwkJZ290byBlcnJfZXhpdDA7DQo+ID4gKwl9
IGVsc2UgaWYgKGlteDZfcGNpZS0+cGh5ICE9IE5VTEwpIHsNCj4gPiArCQlyZXQgPSBwaHlfaW5p
dChpbXg2X3BjaWUtPnBoeSk7DQo+ID4gKwkJaWYgKHJldCkgew0KPiA+ICsJCQlkZXZfZXJyKGRl
diwgInBjaWUgcGh5IGluaXQgZmFpbGVkLlxuIik7DQo+ID4gKwkJCWdvdG8gZXJyX2V4aXQxOw0K
PiA+ICsJCX0NCj4gPiArCX0NCj4gPg0KPiA+ICsJZHdfcGNpZV9zZXR1cF9yYyhwcCk7DQo+ID4g
IAlyZXQgPSBpbXg2X3BjaWVfc3RhcnRfbGluayhpbXg2X3BjaWUtPnBjaSk7DQo+ID4gLQlpZiAo
cmV0IDwgMCkNCj4gPiAtCQlkZXZfaW5mbyhkZXYsICJwY2llIGxpbmsgaXMgZG93biBhZnRlciBy
ZXN1bWUuXG4iKTsNCj4gPiArCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBS
ZXR1cm4gcmV0IGRpcmVjdGx5LCBzaW5jZSB0aGVyZSBhcmUgZXJyb3IgZXhpdA0KPiA+ICsJCSAq
IGhhbmRsZSBpbiBpbXg2X3BjaWVfc3RhcnRfbGluaygpDQo+ID4gKwkJICovDQo+ID4gKwkJZGV2
X2VycihkZXYsICJwY2llIGxpbmsgaXMgZG93biBhZnRlciByZXN1bWUuXG4iKTsNCj4gPiArCQly
ZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2Vy
cl9leGl0MToNCj4gPiArCWlteDZfcGNpZV9jbGtfZGlzYWJsZShpbXg2X3BjaWUpOw0KPiA+ICsJ
aWYgKGlteDZfcGNpZS0+dnBjaWUpDQo+ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2ll
LT52cGNpZSk7DQo+ID4gK2Vycl9leGl0MDoNCj4gPiArCWlmIChpbXg2X3BjaWUtPnBoeSAhPSBO
VUxMKQ0KPiA+ICsJCXBoeV9wb3dlcl9vZmYoaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiAgfQ0KPiA+ICAjZW5kaWYNCj4gPg0KPiANCg0K

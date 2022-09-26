Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A65E98C6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 07:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiIZFY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 01:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiIZFY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 01:24:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F03DE9A;
        Sun, 25 Sep 2022 22:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUyDibiUHVr566GO8j/TC0xrHvmNGxiTZY5TcPoGD/MSzMiuLQ+7MHcPA+A4X4V6nWzeWRkIckqCAJZUcVCL1cR6HF+wVgHQhXWd2YtxLF0zWdqKukGD81qA4JS+c4uxvCgyRgnomequU8gUgI1XoKl0Lf7aeLpthM5Xvz6eLVEG41nhyZxIXBYQa881DenZNFE5d4ekM4j5nAsxmhzjhS6tx083su5kT18u/dW8kMGKMI+VPEeSFD6vminQZoTAcPnBBHmmtB9sJy0ckJshdvSmhnAxFlm4QvcjGc79xFkAMZfv17He+Z1mIN6jH/PqofcWsnUqrw7bi0OMt/Ywrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVxTFAw7ZjddWIeQfbDPY5ibsSTfpcH1JG0RK2AnmfU=;
 b=bRJd+iHlIQKPTWRfCL4jqi6WtCH9S7KBaTbgM9V4FptT5yM7Y0SaszpDYwnFjWvfvf1IHalAcWrTKjspG7zEqTbKTgyxaTKgM8nVs7h0a+8RSINZMnJItNJvK6GA7gYbkBWQyxMXrxjHtizUoBAOCY8zySCUSYeTd1YIwAWaAgx0aLbFjRHqR9sFBadO4qGNRkJvgFbZoci84BLFtVAag2rbO+XVKPZcXwp5PhpL9BHZYoO2+Mu9w6Sx4SLhAi9+xpgv1jFeEyDa2+VkhnSa4UfgfU1dXttHHFKtArxFLs827FWq4dMrD/LdKREJZ935587/j9oLpg/VAtWEblVv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVxTFAw7ZjddWIeQfbDPY5ibsSTfpcH1JG0RK2AnmfU=;
 b=qLJ2Zyx6WZRirPAHQPbBMLT8/aIf6hDayTgZ69KSe4N8qS7e/R9ubo0v3AVAhWGxjGi7NrW75XnsyRRlCVFw7s2ZBTb7FNTCbCByR+QG1ku+JL3OGpBg26BgUnM4dLAaqooR8ejJ0y4QZ7H9VXKVWVDH4qnIHwxVa4gfuL60yQE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9305.eurprd04.prod.outlook.com (2603:10a6:10:36f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 05:24:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 05:24:52 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 04/14] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
Thread-Topic: [PATCH v3 04/14] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
Thread-Index: AQHYzxVX90EowaR4I06bKW9+ofSY1q3tD68AgAQg8zA=
Date:   Mon, 26 Sep 2022 05:24:52 +0000
Message-ID: <AS8PR04MB8676CFC9BD4B16A14B0DD67E8C529@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1663913220-9523-5-git-send-email-hongxing.zhu@nxp.com>
 <20220923141526.GA1388290@bhelgaas>
In-Reply-To: <20220923141526.GA1388290@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB9305:EE_
x-ms-office365-filtering-correlation-id: 8063be8b-81cb-47b6-42f1-08da9f7f7075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2ovz1eceLWPzya3j4UdWGTBF/m3kSjkFBq4adTIZeco/10XjYJ2NyomMWXQ837EINOTdiLDDicUs0JLWUecSIqY7amOzkBN+ipw7nuYXnvbsWBeBM5zUyHpKERvF2w1Dybcl2vt6PKkCFjw/IYl0a0H/DWlGz3krkEwYpu77bDTGwRsil5878vPggYq04alXYTnxeqgHKmqUE4Bi8S5rNO3Y/GKNCJ6Flz55AXkX1Zi7RGwXF5xN2KAGeKIhY4cVDoVtZdQnxtx86DQ4onzuE+OecvqwyPSOkZhna699fqLyMC6IcI6ornC+s6VtNwd4R+0JV7jiBUUgARc2j60ersn18lD59VDleRBD1LRMZZ7+L2fGfTsuZDE4w4bZ0a1WVgwq7102Cd9FV75xIdfIXose8RGH7SkxWcs9qn8XdU4KTyMdZHDAafUO/ZTD0vNlk8pm4SMRq0qIy9zLxMo6/EIxRmEV9qeCZ346WabExmsshwQ+yzWS/QVG5LYRiIAdCJXx0uxbZLJPaGjPhbZ+YLAIwE2iX0TwEAx3PJ6trINV9j0XyKhCQx3HrZ8GCLbJwAZkNXa1Ma0NN7RzdkaUVQzYmKxAzHmvK8syf+ltXRR9/o9cPZaYM8udty+gTj3jjfB7JBFwFcT4b4QV6qkZupFO2peXg1EnRJzA50xkbQEA/SFmvLfeBrIx4i6dNF+RyQIpOcPN9vgmNLnUcATwG+CkX03ebX5Ud1vl4f+S4gTrKDvV7I6oxvT2GNnFzTpAsv67244NJZiQ6veVheNEFDgr9h315AQMovmEpKvDvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(186003)(41300700001)(44832011)(5660300002)(8936002)(7416002)(4326008)(122000001)(38100700002)(33656002)(55016003)(86362001)(478600001)(53546011)(9686003)(7696005)(6506007)(83380400001)(38070700005)(45080400002)(316002)(2906002)(52536014)(6916009)(8676002)(966005)(54906003)(76116006)(66556008)(26005)(71200400001)(66476007)(64756008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WW1IWkoyU0gxNUdlOHprSzY0YlFEUTRZTE9taVBlL0ppSEtxbHhlUXZ6MU5H?=
 =?gb2312?B?WHpjSENqQTBsNUdVZ25NckN3TnkveERXajB0em4xYWVybGw4ekJLZS9BSldj?=
 =?gb2312?B?WFpxVTkrZ0hXb01RVjB6NTlBZUpWbFF1UFpjTlBPL3lXdjVxSSs4WFlSdjdP?=
 =?gb2312?B?Q1NEQ1RDa1JVbnI3NHd3YlNFTHlUenhtZDBQQ0xBWnBQYVJaV0ZnQVR0c3Az?=
 =?gb2312?B?M1V1RnRZK2JpQjZLQ0F0aUlPVENFenErRGE3aWJWQ2dOcG5QWTVxSE13OFUv?=
 =?gb2312?B?LzBWVEpWNDMzbWtpdVNNSktERkdORXpYUVFOVTF5VXg0WmFKV2p5SW9DUExV?=
 =?gb2312?B?UW95UW8rUGdGOGJFbUV3QVpVcldweEx0N3h6L0JiU05DTEJNTC9kclJ3Z3Jw?=
 =?gb2312?B?amp1RWExRlArQUNpMWxCWUtGVFhlQlFTcVhCSWVROENTZS9GMFhPOE1KckV4?=
 =?gb2312?B?Qmo4NWtSeExDV1FSWi9Mc1V3clhmU1VrUWt2TjJKSk5FU3M2QWQvM29jR2VE?=
 =?gb2312?B?dHpGbGgzL3ZWVmJhVkoxLyt0RmdqZFJKMjBBTXJpbzBtemppSlJKRmtneE13?=
 =?gb2312?B?UnEwMmE4ajRQaG1MQkFsZGd4K2R6ZUIydExFT2tIdi9MejdMbU5zMGF2TWw1?=
 =?gb2312?B?VjV6MDc5SCtxR0FNaVlVZFdhTkx1Q2NnRkhNNURRdFNML0lOcGh2TXozNll1?=
 =?gb2312?B?TndtR1h1T0ZHK2RwbFU3cncrVXphUGhtN2FrRzVPeWRyRGNtTmt0bzBTQWZl?=
 =?gb2312?B?bll5L2Q1V0UxY1VLR2pvanRVazVITkRsNGN0QWpTVEJZbUFNa28zRlNIaWJH?=
 =?gb2312?B?S2s5b1ErbUI1cmR3aWhHTXEwc01TblhaUjZmR2VEQ1Bka083ZjdWSFhBakJV?=
 =?gb2312?B?Ukx0UGRmTmJOeWhLclZEOHJ1RHQxNktYcW5KK1MvZTdoYXVPR0YxZFlGTXJE?=
 =?gb2312?B?RG5QaGxzSEVxckNJbXN6MEY3MzdpQXVMRDRnVkhmRXhHcVkxbWg4SzJiWElU?=
 =?gb2312?B?V1lSbzJrcHo1TmFpSkgzRDU2b3RiWm93YUh0ZHJvMVBYT2oyczh6QjZYMmFM?=
 =?gb2312?B?UHlnRVE2N25KakNOWEJ1S3RFLzFNL040ZjBPRTZvMFRPdjFVczF4TGFtTHE0?=
 =?gb2312?B?V0tXQ2M0cWxScVpsY3VlVXdGZW44anQvbVRGTklBb01sSHJxTWxEN01SK0dw?=
 =?gb2312?B?blBiSVM4d3ErWkJEaDBscWV0K2syVVBzMTVjVjFERjlZVHhISFJEZjArQldC?=
 =?gb2312?B?c0U2N3V2d1IwM0FKMTU2VmkyTVpBR0hzcFdHTnpueVpPcldyTWpsczA1UUR6?=
 =?gb2312?B?c29VSEdoczJKanRvTm5HWElOd1BreXRabFdyM0daRmRKRkNHN1VrZFdyek9Q?=
 =?gb2312?B?SUpZQ2ptdjhKWUVsbHdGRDd5MFd2d0I1NThWdWpZUFU4ZFBzNCtrcmlYaVVX?=
 =?gb2312?B?U3BHUXRGS2xnZDNnckNPRUkrKzA3ZXQzK0N4OStsZ0ZqS1MzOWJQV0N0M2Z0?=
 =?gb2312?B?SUJPWXZIVWNFODBzQ001dVFBdE11MzVMMDNBTU9SZHp6RFUrbHROemlZdE1W?=
 =?gb2312?B?cjdRRXBLbnhkU216U3pKMGNNQXdTdGpIQnJCUEFzUkVQTjE3U2J1bDcyWUVl?=
 =?gb2312?B?Smh5MDg3V1pYem52K0p1eDdoS2ZuRjU1RGNpYldVbnRSWlRHeGVOYmNKVkRG?=
 =?gb2312?B?czBCSUR0SkJQajlEY1V5Z3lNNGx2MGVnZGlMMlVOYUpESlhxYTR2R1dxZ2N1?=
 =?gb2312?B?SkJJL2lSNFc0aDB3ZVVsTG9kSzE2MHAxS2Njd0t1MWdPWndyVFBRamVpYlRB?=
 =?gb2312?B?WDFjTERLWEFlTmpYbEE4Y0c2emlhMkRqQ2xtMWQwekFpcVBXeW1wTjFXT2pZ?=
 =?gb2312?B?U3l5NHdMUUdmMnM3eDFzZXVTY1k3QnVUWjdOUVBDTUVGMGRTekh0WWI4VmpU?=
 =?gb2312?B?WkhSOTF3Nm16UzVoZTVnUFhrSWNHVHpWZnN2UFllZFRTWlNPclVPNUFmMnI3?=
 =?gb2312?B?UVVPQWN2NXF3T2VEV1RiMmhKaU9ISG5PcERKTnlsdVBoZklxUnBCZjJIdWtt?=
 =?gb2312?B?REtxODNzWXk1YzdXY3pGQTFCM0ZmM081OVByWTVnZTNYdnQ1MkdFdnowUndz?=
 =?gb2312?Q?sIZhZwCgIDslZgGU7FHZbsamu?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8063be8b-81cb-47b6-42f1-08da9f7f7075
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:24:52.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szV07xIz4GYZ2S77DTKrlHhOlCEOhUm3MyVdGHbZvS//BWjvxfeqyDpNXiaIuck4TKov1s20UF/WdR00bGQ3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjIzyNUgMjI6MTUNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxvcmVuem8u
cGllcmFsaXNpQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGtpc2hvbkB0aS5jb207DQo+
IGt3QGxpbnV4LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDQvMTRdIFBDSTogZHdjOiBLY29uZmlnOiBB
ZGQgaU1YIFBDSWUgRVAgbW9kZQ0KPiBzdXBwb3J0DQo+IA0KPiBPbiBGcmksIFNlcCAyMywgMjAy
MiBhdCAwMjowNjo1MFBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBTaW5jZSBpLk1Y
IFBDSWUgaXMgb25lIGR1YWwgbW9kZSBQQ0llIGNvbnRyb2xsZXIuDQo+IA0KPiBUaGlzIGlzIG5v
dCBhIHNlbnRlbmNlLg0KT2theSwgd291bGQgYmUgY2hhbmdlZC4NCg0KPiANCj4gPiBBZGQgaS5N
WCBQQ0llIEVQIG1vZGUgc3VwcG9ydCwgYW5kIHNwbGl0IHRoZSBQQ0llIG1vZGVzIHRvIHRoZSBS
b290DQo+ID4gQ29tcGxleCBtb2RlIGFuZCBFbmRwb2ludCBtb2RlLg0KPiANCj4gQWRkIGJsYW5r
IGxpbmVzIGJldHdlZW4gcGFyYWdyYXBocyBvciByZXdyYXAgaW50byBhIHNpbmdsZSBwYXJhZ3Jh
cGggdGhhdCBmaWxscw0KPiA3NSBjb2x1bW5zLg0KT2theSwgd291bGQgcmVmaW5lIHRoZSBjb21t
aXQgbG9nIGxhdGVyLg0KDQo+IA0KPiBJIHRoaW5rIHlvdSBzaG91bGQgc3BsaXQgIlsxMi8xNF0g
UENJOiBpbXg2OiBBZGQgaU1YOE1NIFBDSWUgRVAgbW9kZSINCj4gaW50bzoNCj4gDQo+ICAgLSBB
IHBhdGNoIHRoYXQgYWRkcyB0aGUgZ2VuZXJpYyBlbmRwb2ludCBpbmZyYXN0cnVjdHVyZSwgZS5n
LiwNCj4gICAgIGlteDZfcGNpZV9lcF9pbml0KCksIGlteDZfcGNpZV9lcF9yYWlzZV9pcnEoKSwg
aW14Nl9hZGRfcGNpZV9lcCgpLg0KPiANCj4gICAtIEEgc2Vjb25kIHBhdGNoIHRoYXQgYWRkcyB0
aGUgaS5NWDhNTSBpZGVudGlmaWVycy4NCj4gDQo+IFRoYXQgd2F5IHRoZSBpLk1YOE1NIHBhdGNo
IHdpbGwgYmUgYW5hbG9nb3VzIHRvIHRoZSBpLk1YOE1RIGFuZCBpLk1YOE1QDQo+IHBhdGNoZXMu
DQo+IA0KPiBUaGVuIHlvdSBjb3VsZCBzcXVhc2ggdGhpcyBLY29uZmlnIHBhdGNoIGludG8gdGhl
IGdlbmVyaWMgZW5kcG9pbnQNCj4gaW5mcmFzdHJ1Y3R1cmUgcGF0Y2ggYmVjYXVzZSB0aGlzIHBh
dGNoIGlzIHdoYXQgc2VsZWN0cyBQQ0lFX0RXX0VQLCB3aGljaCBpcw0KPiB3aGF0IGVuc3VyZXMg
dGhhdCBkd19wY2llX2VwX3Jlc2V0X2JhcigpLCBkd19wY2llX2VwX3JhaXNlX2xlZ2FjeV9pcnEo
KSwgZXRjLiwNCj4gYXJlIGF2YWlsYWJsZS4NCkdvb2Qgc3VnZ2VzdGlvbi4gVGhhbmtzIGEgbG90
Lg0KV291bGQgY2hhbmdlIGl0IGZvbGxvd2luZyB0aGlzIHdheS4NCg0KPiANCj4gPiAtLS0gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+IEBAIC05MiwxMCArOTIsMzMgQEAgY29uZmlnIFBD
SV9FWFlOT1MNCj4gPiAgCSAgZnVuY3Rpb25zIHRvIGltcGxlbWVudCB0aGUgZHJpdmVyLg0KPiA+
DQo+ID4gIGNvbmZpZyBQQ0lfSU1YNg0KPiA+IC0JYm9vbCAiRnJlZXNjYWxlIGkuTVg2LzcvOCBQ
Q0llIGNvbnRyb2xsZXIiDQo+ID4gKwlib29sDQo+ID4gKw0KPiA+ICtjb25maWcgUENJX0lNWDZf
SE9TVA0KPiA+ICsJYm9vbCAiRnJlZXNjYWxlIGkuTVg2LzcvOCBQQ0llIGNvbnRyb2xsZXIgaG9z
dCBtb2RlIg0KPiA+ICAJZGVwZW5kcyBvbiBBUkNIX01YQyB8fCBDT01QSUxFX1RFU1QNCj4gPiAg
CWRlcGVuZHMgb24gUENJX01TSV9JUlFfRE9NQUlODQo+ID4gIAlzZWxlY3QgUENJRV9EV19IT1NU
DQo+ID4gKwlzZWxlY3QgUENJX0lNWDYNCj4gPiArCWhlbHANCj4gPiArCSAgRW5hYmxlcyBzdXBw
b3J0IGZvciB0aGUgUENJZSBjb250cm9sbGVyIFJvb3QgQ29tcGxleCBtb2RlIGluIHRoZQ0KPiA+
ICsJICBpTVg2LzcvOCBTb0NzLg0KPiANCj4gPiArCSAgVGhpcyBjb250cm9sbGVyIGNhbiB3b3Jr
IGVpdGhlciBhcyBFUCBvciBSQy4gSW4gb3JkZXIgdG8gZW5hYmxlDQo+ID4gKwkgIGhvc3Qtc3Bl
Y2lmaWMgZmVhdHVyZXMgUENJRV9EV19IT1NUIG11c3QgYmUgc2VsZWN0ZWQgYW5kIGluIG9yZGVy
DQo+ID4gKwkgIHRvIGVuYWJsZSBkZXZpY2Utc3BlY2lmaWMgZmVhdHVyZXMgUENJRV9EV19FUCBt
dXN0IGJlIHNlbGVjdGVkLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGVzZSB0aHJlZSBsaW5lcyBh
cmUgdXNlZnVsIHRvIHRoZSB1c2VyLiAgVGhleSBvbmx5IGRlc2NyaWJlIHdoYXQNCj4gS2NvbmZp
ZyBkb2VzIHdoZW4gUENJX0lNWDZfSE9TVCBpcyBlbmFibGVkLCB3aGljaCBpcyByZWFsbHkgYW4g
aW50ZXJuYWwNCj4gaW1wbGVtZW50YXRpb24gZGV0YWlsLg0KT2theSwgd291bGQgcmVmaW5lIHRo
ZW0gbGF0ZXIuDQoNCj4gDQo+ID4gK2NvbmZpZyBQQ0lfSU1YNl9FUA0KPiA+ICsJYm9vbCAiRnJl
ZXNjYWxlIGkuTVg2LzcvOCBQQ0llIGNvbnRyb2xsZXIgZW5kcG9pbnQgbW9kZSINCj4gPiArCWRl
cGVuZHMgb24gQVJDSF9NWEMgfHwgQ09NUElMRV9URVNUDQo+ID4gKwlkZXBlbmRzIG9uIFBDSV9F
TkRQT0lOVA0KPiA+ICsJc2VsZWN0IFBDSUVfRFdfRVANCj4gPiArCXNlbGVjdCBQQ0lfSU1YNg0K
PiA+ICsJaGVscA0KPiA+ICsJICBFbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBQQ0llIGNvbnRyb2xs
ZXIgZW5kcG9pbnQgbW9kZSBpbiB0aGUNCj4gPiArCSAgaU1YNi83LzggU29Dcy4NCj4gPiArCSAg
VGhpcyBjb250cm9sbGVyIGNhbiB3b3JrIGVpdGhlciBhcyBFUCBvciBSQy4gSW4gb3JkZXIgdG8g
ZW5hYmxlDQo+ID4gKwkgIGhvc3Qtc3BlY2lmaWMgZmVhdHVyZXMgUENJRV9EV19IT1NUIG11c3Qg
YmUgc2VsZWN0ZWQgYW5kIGluIG9yZGVyDQo+ID4gKwkgIHRvIGVuYWJsZSBkZXZpY2Utc3BlY2lm
aWMgZmVhdHVyZXMgUENJRV9EV19FUCBtdXN0IGJlIHNlbGVjdGVkLg0KPiANCj4gRGl0dG8uDQpP
a2F5LCB3b3VsZCByZWZpbmUgdGhlbSBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KDQo+IA0KPiA+ICBjb25maWcgUENJRV9TUEVBUjEzWFgNCj4gPiAgCWJvb2wgIlNUTWljcm9l
bGVjdHJvbmljcyBTUEVBciBQQ0llIGNvbnRyb2xsZXIiDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4g
Pg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMNCj4gPiAuaW5mcmFkZWFk
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDUl
Nw0KPiBDMA0KPiA+DQo+IDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDYzliNGNkYjFmZTYw
NDhiY2JmMjgwOGRhOWQ2ZTEyNDUlNw0KPiBDNjg2ZWExDQo+ID4NCj4gZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzk5NTM5MzMyNzgyMjg5MSU3Q1Vuaw0KPiBub3duJTdD
VFcNCj4gPg0KPiBGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWDQo+IENJNg0KPiA+DQo+IE1uMCUzRCU3QzMwMDAlN0MlN0Ml
N0MmYW1wO3NkYXRhPW10T0ExVDN3U3ZyNElSZmJGOFdwTWx1JTJCDQo+IHBNaDZ2UURQS2FiDQo+
ID4gMTdZNHpkZUUlM0QmYW1wO3Jlc2VydmVkPTANCg==

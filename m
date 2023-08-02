Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA876CFB2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjHBOKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjHBOJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 10:09:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CA358B;
        Wed,  2 Aug 2023 07:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0KVZKoKQGbOjQYsDHomRjaR+8Fsd0qJBCFdZ91StMMpMFZgbN0Nbi8lnA/Ey8Uz2M+LXZ2IRunexiycFEtFXdxk7ddnB7VrjVpBNekYtRhwQjAddhDfoB+MCDTdVeKGvG8JHOfsyj90b22dCabmjxsRarVGp/N1r9gWqLEV6zu9hw4dKhATS6dOtIsaIQD6ClFRZD4SnlpGZzgP4aGh46YgqusDO5BxR68tL7UOD29qNiqX7icAQTxE3SicM72hAgqFMYC9FfhdERRulNrrzX9Rek7iAXv/6r/kb+tDUEmAaQ6OjK+gIEeTpkjpNqBtqn2R/qF2jP2Po9TshgLGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vINcIYv0JULnoIThWtimv3UsfviFuCOhAe8TQw290Dg=;
 b=eHFEhiTF6hoYubXP2/BRK0KdLPkg6yvytTc6zK7/QMbabhH4Fe0OYUMy/xvjavcCYfp3/inzQpg1i6XQoDH84pnjULXoNnsC+zD3FnJ2oDsF3yMSqrBCLDXaR1QW8GtFHxpP5ntHgoz1LGwQ5G4sPRsXB41N6HW0UEyfkisOT21i5ODZH3XRiPx5wYGcrhq2Ik4Y3e4DGHybNSTpCpijVPDroGb37U3rkJZut/G8CuMcKyp4x1iC4fDM5ANJ+/Le9+ONDw8mPszB4YFgbqQ0aLcLbb25rRRRKFSGGESEkISzkLqe7xuXTDGEdAglqw8wHZ4xbMNSJvZ+rKu82x+3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vINcIYv0JULnoIThWtimv3UsfviFuCOhAe8TQw290Dg=;
 b=n0Q5ceosV6+XEB/pSKP+f22TYenRh9+pkCXP5lwSIDxJzdL9FtqVZokz8yXiiyf9R5qrps/U7gEGNI48ciAEwVRUfTREjCSkKkLGm+6mcTzcvsJwsHMSVaKN2/RB4v+xnCVjWgpL5IQbWt+XUOgkrIDLoFoA+c3dTQmm6cZAY98=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:08:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:08:54 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/9] Add legacy i.MX PCIe EP mode supports
Thread-Topic: [PATCH 0/9] Add legacy i.MX PCIe EP mode supports
Thread-Index: AQHZxQxTOGSyEBhys0+xocNk/pLkD6/WkXeAgAB4aSA=
Date:   Wed, 2 Aug 2023 14:08:54 +0000
Message-ID: <AS8PR04MB86762F0D36E7BC41D79CEA2F8C0BA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
 <7f98d5f3-eb5b-d98b-a5ab-a7f54319c99a@pengutronix.de>
In-Reply-To: <7f98d5f3-eb5b-d98b-a5ab-a7f54319c99a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB7588:EE_
x-ms-office365-filtering-correlation-id: b99829f8-7df2-4fbe-7e85-08db9362015b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJAHhBc5UTgLjndV0qaJbeZpt34G4xhEkdEObtHl+LNeTb/Nqj5+B9gPqmnpul4gSH9J6Z8+93jqnOGZsO3M6LtLCiHHLWEW626gHJR8x65iHvPl2B/dO4VfbFnzHuoVlMkEVgFgw3l4DFQEMZeArziONnwzPGZx+FGiHaD39IP4ZhY4srfHmEbQ3uEt2CTNZcJ1/pP5tv2/h3BgBL91Q5TfAP5X38DTWAk/W+aOT0qwGXuUb+dTlPc5EjeCszWQRzvmcQrrxHN7rMuzyy2+nWGSw+C0A9ovmHpmmWtGvG0e67GPLn/76Ihuas5iPtJTV9KaWGXmHZ0iK5jsKajauDviSDatyiWbJMpof5IFE90Pi5lrQE2pLqzdfSOEnLELMk6j8BtkasOsLUFuSpOVJWXHtnolOu/VE55EWsGELTeS7favlIoXRr6Yx86SpZfRddYDUWIIzauqOveKMeJp3mmdlYMlEbXSE6wjZqZ9jeFb7JfYpETvIc/hH6NoByruxf5ONCOhiP7/w1g0vSOrJgk2Eku2B6BCHNqlLR2AJIyEaNwGe5Jt0CTogovzaWSiVkoMR2xCBPHRRpeEZGT62UHERt8k5CS9ATe6KZqtyEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(66446008)(64756008)(66476007)(4326008)(316002)(966005)(66946007)(9686003)(83380400001)(38070700005)(86362001)(2906002)(7416002)(44832011)(186003)(53546011)(5660300002)(52536014)(6506007)(26005)(33656002)(122000001)(38100700002)(55016003)(41300700001)(8676002)(8936002)(7696005)(45080400002)(71200400001)(478600001)(54906003)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dGxxSmtMYUtiMHE2VXNyMWFXb3dsbWEraElhY2x2QmREckJPSWxSR0QvZ3BT?=
 =?gb2312?B?aU9uMXNabUprbXBCUTZCbEMvSXorV0YvZVdpcU92U2NHUmJHQ3FTRG92Vzht?=
 =?gb2312?B?OERCV0ZjQndlQThSSGlQNUdKMGQvZDJGUU9TMjFGVFZxSTI0NnFpRkc3eUwr?=
 =?gb2312?B?UU9YTHRlbG96VVFNT09XOFNWcEg0LzZ0NW5qdUlHUUJmK3dpQWdUaSsrcWZr?=
 =?gb2312?B?eFlxOXc2RERHRUNQdXpNVG5KcDh5MGhsUTQwVVlZeUZDdzcxeisyRE1ISkhn?=
 =?gb2312?B?cm8vSHIrZHc0YnZ1U0daN0hnRWREM3lFU2tkVFRpc2lkbEFPRWFCUzlQeUNN?=
 =?gb2312?B?K01hQ0RhSkdIZTlsMSs2SGUyV2dtTjEwMFdhOTd1QUNSRGgxMjh0dVpMZk5s?=
 =?gb2312?B?R3ZFQ2ZtRUhEM3hyY0tlT1h3ejA0bWV1WG5iOGRMRkludnAvSXVVY2xhczhW?=
 =?gb2312?B?elp2L1VBWlFqZkZKcnA2bkxnMzRxMC9CcW9XbkJmQS9kbGp3QmxxdnhhMjJ4?=
 =?gb2312?B?ZVBLUnM1SG1GU1Vnc0JDOVBZK2NKejdaWlJDU3lSdnJpbng5VEtKN3FtdjBx?=
 =?gb2312?B?dloxZWtFVWVkZEtyNEYvREo4WjV5V3hjeThFVkpCR1U0UmFzT25ZcHBBV1Nz?=
 =?gb2312?B?MmxpTHN0eEltQzNoK2F3VzBNQXZMRHJabFZwWWhSRC9hMDlwSklZMzJIR05K?=
 =?gb2312?B?Rlk3K0ZCOTd3MXUrVDhaOUhmQzR6UXVYY0J3MjJhWTNvWHZtMEZaVXN2ZDZ5?=
 =?gb2312?B?ZHNYWEFITHh5Lzl2WUl2dTBwenBJb1d6VHhEd2FGVkp0ajJNYmdjWUsyK2pk?=
 =?gb2312?B?T3g3WXl1eXVKd1Jzb1lBejJrSTkrZ1lFdWx0ZkRXQnY1UTdkT3Y4MmlHV0Ru?=
 =?gb2312?B?V2JrN0NYbURwNkp4ZCtRNWwxWVh6Q0RBMG93ZUdLUXI3cGRXdmU0cEk5aUpV?=
 =?gb2312?B?bUh3bEVBSkgycTdwTlVaNzdSOThjK1Z1QjE5N1h5ZGdGVHNlME5UWDZRcHpW?=
 =?gb2312?B?anZoSFBLV1V0ckhrM0puRjNhQTVjNzVPN1llVUdENHBjOTNwWmJIalhSbEUx?=
 =?gb2312?B?cWI3N096aUI0cSsyOTZnN2VvbWRVQy9YUkkyTTRnNjZReWZHeG9lMnpoYWV3?=
 =?gb2312?B?b282bmxkblVmQXg3ajI2ZDIveHBJMmxzNjA2TmxwZnRzeHhqTFRwbTY1R2hj?=
 =?gb2312?B?ZHl5dzkzc3ZPeHNKY3llb3JRRm5tOEwvUzVVOTNVRTdPWEtlQXVRWUM0ZDBS?=
 =?gb2312?B?dmZyNWRQMng3enRsdW9pTUdvVVdIcXZxUVBPZ3NtaVlyS0FvTGlFZGg0K2U1?=
 =?gb2312?B?QUZuRUYyZjlQVmcvU0tJUzMyUzBYQTd5NDdidFlIVXBiTkY5Q05OSWRsVVFh?=
 =?gb2312?B?NmJPcmNyR0dOaXNycXQwUDgyM2lTR245YUtJdHl5VHQ2c0UxSkJKdjVHaHJ5?=
 =?gb2312?B?bVdWNG9ORzV2SGxzaXhmSHZpVCtsamg1N2d0dnBVb2JKemZCUVgyaThiMDZH?=
 =?gb2312?B?ZWRtSUtyWWZETXA2MXcxRjE2czIrdVcrejRTWW1maUpaVFJHaU5HWWhVVWda?=
 =?gb2312?B?elMyaVVMN2hmVVcweDJzL25pRFZjQTRXK2pqaW9ERm1LSEZHYlkvclVTaUdU?=
 =?gb2312?B?cHc2NHpyckx5WmI2UDNEalE0VTNMNFhKT0ZObUFwSWZGSFpMcHREcTZBM0Ny?=
 =?gb2312?B?Vk9tLy9UdDBqR1VoRmxZREhZRUt3d3hvVnBqdDY0VGsxS1pjelo1L1BGWEJC?=
 =?gb2312?B?VEMrZldBTVJTMXlBa1I1K21tUW84K3VremNZaWlPYkNMZzlZdnFycmJaRUFh?=
 =?gb2312?B?ZFYydHVVeVNYQmF4bzJ4MUxIaDh5UGVmUnpvdWxWY2xiSGFsdWpLRzAvVEUx?=
 =?gb2312?B?SWE4cC9scjZSRE9aMGFZT3V1UXRuTFZDd0ZxbHRTNVVpY2NORmZOUkxhRVd4?=
 =?gb2312?B?RWVWNCtvcjNWZkEwQUJaQXg5Znh4WlQ3bEVlMVozeUlnSjU0eUE1M3hXYVNp?=
 =?gb2312?B?dGM1NGpvMHl3MENkUXRZdzZxZFJUK2pVeEpHMnRnSWViMDJIMjY1dm5Mcm5M?=
 =?gb2312?B?cExFdW5ZeDFyS0tvdEE5MytwS281UHVJOGJvN2dlQm45REpwNHR2Zm1vRThx?=
 =?gb2312?Q?62k+eMF6dOUQDJtyH6iFLm5Z0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99829f8-7df2-4fbe-7e85-08db9362015b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 14:08:54.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aGfqiLRpPg6xZxIm6qrvc1JCVySUkj9R1u/Krm+7yShyBzUpbPfWfBrTE4EXUeVyYvJ/eiu9MBEqnZRK1pdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWhtYWQ6DQoNClRoYW5rcyBmb3IgeW91ciBjb25jZXJucy4NCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWhtYWQgRmF0b3VtIDxhLmZhdG91bUBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMjAyM8TqONTCMsjVIDE0OjUyDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZw0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDAvOV0gQWRkIGxlZ2FjeSBpLk1YIFBDSWUgRVAgbW9kZSBzdXBw
b3J0cw0KPg0KPiBIZWxsbyBSaWNoYXJkLA0KPg0KPiBPbiAwMi4wOC4yMyAwODowNiwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4gQWRkIGxlZ2FjeSAzMmJpdCBpLk1YIFBDSWUgRVAgbW9kZSBzdXBw
b3J0DQo+ID4NCj4gPiBUaGUgUENJIGNvbnRyb2xsZXIgY29udGFpbmVkIGluIGkuTVg2LzcgbGVn
YWN5IFNPQ3MgaXMgb25lIGR1YWwgbW9kZQ0KPiA+IFBDSWUgY29udHJvbGxlciwgYW5kIGNhbiB3
b3JrIGVpdGhlciBhcyBSQyBvciBFUC4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGFkZCBpLk1YNi83
IFBDSWUgRVAgbW9kZSBzdXBwb3J0cy4gQW5kIGhhZCBiZWVuIHZlcmlmaWVkDQo+ID4gb24gaS5N
WDYgc2FicmVzZCBhbmQgaS5NWDcgU0RCIGJvYXJkcy4NCj4gPg0KPiA+IEluIHRoZSB2ZXJpZmlj
YXRpb24sIG9uZSBib2FyZCBQQ0llIGlzIHVzZWQgYXMgUkMsIHRoZSBvdGhlciBvbmUgaXMNCj4g
PiB1c2VkIGFzIEVQLg0KPiA+IFVzZSB0aGUgY3Jvc3MgVFgvUlggZGlmZmVyZW50aWFsIGNhYmxl
IGNvbm5lY3QgdGhlIHR3byBQQ0llIHBvcnRzIG9mDQo+ID4gdGhlc2UgdHdvIGJvYXJkcy4NCj4g
Pg0KPiA+ICstLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLSsNCj4gPiB8
ICAgUENJZSBUWCB8PC0tLS0tLS0tLS0tLS0tPnxQQ0llIFJYICAgICB8DQo+ID4gfCAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgfA0KPiA+IHwgICAgQm9hcmQgIHwgICAg
ICAgICAgICAgICAgfCAgICBCb2FyZCAgIHwNCj4gPiB8ICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICB8DQo+ID4gfCAgIFBDSWUgUlggfDwtLS0tLS0tLS0tLS0tLT58UENJ
ZSBUWCAgICAgfA0KPiA+ICstLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0t
LSsNCj4NCj4gSSBhbSBjdXJpb3VzIHdoYXQgc29mdHdhcmUgeW91IGFyZSBydW5uaW5nIG9uIGJv
dGggc2lkZXMgdG8gdGVzdD8NCj4gRG8geW91IHVzZSBDT05GSUdfUENJX0VQRl9URVNUPyBXaGF0
IGRvIHlvdSBydW4gb24gUkMgc2lkZT8NClllcywgaXQgaXMuDQpCZXNpZGUgUENJX0VQRl9URVNU
LCB0aGUgQ09ORklHX1BDSV9FTkRQT0lOVF9URVNUIGlzIHVzZWQgdG9vLg0KQW5kIHRoZSBwY2l0
ZXN0IHByb2dyYW0gaXMgdXNlZCBvbiBSQyBzaWRlIHRvIHZlcmlmeSB0aGUgTVNJIGFuZCBkYXRh
IElPIHRlc3RzIGZlYXR1cmVzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+DQo+IFRo
YW5rcywNCj4gQWhtYWQNCj4NCj4gPg0KPiA+IFtQQVRDSCAxLzldIGR0LWJpbmRpbmdzOiBQQ0k6
IGZzbCxpbXg2cTogQWRkIGkuTVg2USBhbmQgaS5NWDZRUCBQQ0llDQo+ID4gW1BBVENIIDIvOV0g
ZHQtYmluZGluZ3M6IFBDSTogZnNsLGlteDZxOiBBZGQgaS5NWDZTWCBQQ0llIEVQIFtQQVRDSA0K
PiA+IDMvOV0gZHQtYmluZGluZ3M6IFBDSTogZnNsLGlteDZxOiBBZGQgaS5NWDdEIFBDSWUgRVAg
W1BBVENIIDQvOV0gYXJtOg0KPiA+IGR0czogbnhwOiBBZGQgaS5NWDZRREwgYW5kIGkuTVg2UVAg
UENJZSBFUCBzdXBwb3J0cyBbUEFUQ0ggNS85XSBhcm06DQo+ID4gZHRzOiBueHA6IEFkZCBpLk1Y
NlNYIFBDSWUgRVAgc3VwcG9ydCBbUEFUQ0ggNi85XSBhcm06IGR0czogbnhwOiBBZGQNCj4gPiBp
Lk1YN0QgUENJZSBFUCBzdXBwb3J0IFtQQVRDSCA3LzldIFBDSTogaW14NjogQWRkIGkuTVg2USBh
bmQgaS5NWDZRUA0KPiA+IFBDSWUgRVAgc3VwcG9ydHMgW1BBVENIIDgvOV0gUENJOiBpbXg2OiBB
ZGQgaS5NWDZTWCBQQ0llIEVQIHN1cHBvcnQNCj4gPiBbUEFUQ0ggOS85XSBQQ0k6IGlteDY6IEFk
ZCBpLk1YN0QgUENJZSBFUCBzdXBwb3J0DQo+ID4NCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWVwLnlhbWwgfCA1MA0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiBhcmNoL2FybS9ib290L2R0
cy9ueHAvaW14L2lteDZxZGwuZHRzaSAgICAgICAgICAgICAgICAgICAgICAgfCAxNA0KPiArKysr
KysrKysrKysrDQo+ID4gYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cXAuZHRzaSAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDQNCj4gKysrKw0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL254
cC9pbXgvaW14NnN4LmR0c2kgICAgICAgICAgICAgICAgICAgICAgICB8IDE3DQo+ICsrKysrKysr
KysrKysrKw0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14N2QuZHRzaSAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICAg
ICB8IDkzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+IDYgZmlsZXMgY2hh
bmdlZCwgMjAwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPg0KPiA+DQo+
DQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+
IHwNCj4gU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gaHR0
cDovL3d3dy5wZW4vDQo+IGd1dHJvbml4LmRlJTJGJmRhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpo
dSU0MG54cC5jb20lN0NjYzc4M2ZjMmIxDQo+IDAzNDA1MThlMDEwOGRiOTMyNGVjM2YlN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlNw0KPiBDMCU3QzYzODI2NTU1OTAxOTgw
OTMzOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHcNCj4gTGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyUNCj4g
N0MlN0Mmc2RhdGE9dEMzSkdjJTJCbzV6NTIxMXZDdHBiY25PNSUyRllDMmdoTTF0ZSUyRndHT2dD
OXVlOA0KPiAlM0QmcmVzZXJ2ZWQ9MCAgfA0KPiAzMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAg
ICAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTANCj4gfA0KPiBBbXRzZ2Vy
aWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ICs0OS01MTIxLTIw
NjkxNy01NTU1IHwNCg0K

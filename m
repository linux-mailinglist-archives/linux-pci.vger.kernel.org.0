Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D945734BF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiGMK4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiGMK4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 06:56:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477FFF5A5;
        Wed, 13 Jul 2022 03:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUQIhzqx8Owl99U3CPgju40gmcay0/mYzmjQtCKy4/fbu5MglGOZJm3P4c5ecvQhVM/o/DcBA+KjEHSYRPZUQ7uEuZdXdh91P8hUqCEv1rsGQTD/PyO2mVEzfgMuybf8pqTVu3KSsV6JKfU5khdbS8EbdeY4KUtWvd+tBXwbJqGtnSQAgpB/SdubFgAVg72N5TRow1FfLNQX3Tl4HmQqdpOxiosp7JveUl5zMsTqFW8RZgMh2lfhK52Qt9YaHMbay8yckEA9p/donFfz7NGWi8nlRPaY7Z6lWEVy7mEDQIRrYSwboQsvI4Ibm3gGTYkGDGmKwU2RuVVsL47/2EPZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dIXDXJrdGDlE9N5Gl2ojMnwGD65jfLbx79XNU+m4kQ=;
 b=HGgan/VWuyRlxbJ4nDvqq78oZCd3Hq5DOrJ0/tJ7D0ttiwsliCASLHpUtZc1sWgSQW9qq45Ex5xmbcWYqQZvFP3kgRa1Pz1iPfpFWgjRjaYI/U/4wGFk41SdOE4cajk9DJLgeMkM76ptHi3e4i6p1gurEdxFZit52SpnaXxF1l9ldSJsbR6T/mlVIInYp0xd7ExI/wtA7fXsQwEnhWTF5B9S1nJaDbpgHZuvfYNePh0mORh4wESyNjQiL9Qup+7AcNJAZ4Lqm9V61VTJlRmTxi/G5RbR7o6zU8VFv6ZHUk2H9n/2ZkoymUYnT065R58dSTJrhNIwi38Wq7jiqveApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dIXDXJrdGDlE9N5Gl2ojMnwGD65jfLbx79XNU+m4kQ=;
 b=ikKczyoC++3zEZ1mkCPDDti8BDORQk6KnVJYDld5FPcMVa2FM2EAJMEn08Cp6P5JlBlZ8Ku3GkysyaI35J9uMnWjB9iUWKS2LX/PRdJwCnEJeN3UhKzbs8zLxjETV5UXYY2Ea9WN/YL5JLVnAfaESkCD6oRITZTHKrehdcLzySE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 10:56:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 10:56:39 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 10/17] PCI: imx6: Turn off regulator when system is in
 suspend mode
Thread-Topic: [PATCH v14 10/17] PCI: imx6: Turn off regulator when system is
 in suspend mode
Thread-Index: AQHYjPxOJfW03qc+LUO9IW8deJoxCK18DLgAgAAQtCA=
Date:   Wed, 13 Jul 2022 10:56:39 +0000
Message-ID: <AS8PR04MB8676F0E41C38891B2C21F8D78C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-11-git-send-email-hongxing.zhu@nxp.com>
 <6f0cd4c69e0eba3e5da513cfbbe5f162e650a8f1.camel@pengutronix.de>
In-Reply-To: <6f0cd4c69e0eba3e5da513cfbbe5f162e650a8f1.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c44ce138-04c2-4d51-31ea-08da64be5d4f
x-ms-traffictypediagnostic: AM9PR04MB8522:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awKXggjuDMvj63STKZLbp+bXHC8ZHkJVztrIlSLD8HMQ1HfIQ/vr/IsoUDf5zCj50e/RfqKB0qigQGNwhfuAnDux7KtJLbRGWMIRoNQULPtgxyC9vaPCVC7ig5zPaCUIyEXzhcrrKR6SzUjoGclZPmmw4BGQLW5ykAg7Djm7wUR5HB6DpADVaUVb1pRtT8guc/2thyBN2Q2DVsNSUmqaDgL9eEAYofXbAILlzQmZ1WyIyTinkrWN58kJLCRaK86Zj19l2maw+H8IK9O1FQNHuzg+PMssQsCA/MQjxHJACmDZHJ4iZ7vVMl5GaTE6prU9uxuJ6JXbFTokpI6ZCBjNpMY/43tFlTMUvgAI1VpvUEFvImCi3CbH+PKPUlAl9qg/PJ89L3PDENnuGzgSoFigSUolnYv8/z19czsTxMJEIci/BN1kKS41nJCaGBeN7izgovuhOjN398JprfawUhCjnyBmLwJaNWsZ3aFuLuD7tCjL9KThUQTBIOa1QgyaKGOfwa/f3Fy+ObXeFt7ZBbRqj4T82GtoHWyjZfxsfNHrK4rHGA3FyGatPxTpa/EYbHn33OAhW1PvlYOv9fjxhg9P+4oE+w5Bi3SWxyqfnHDQB09rO14XTWBJBTMGCw90I7zSIAOVkpvSUr48pQRZUC59VH25lCijqQCc0M8gQG/cQvbjAeITUlJqhzi4gNeD+CHl/0aoHasNZC8A9aFU8YiGfpqF0S/PlDOwxypXU2JsHVH/y7bkIeZCCuzA2jr56bEdoAsbB0wLiF1Jir/o/lizdpIK4UZmJ8evBjRo326Oe9iJCp3cKN0z4DGV7/aoWxi/lQCTuwSyHAj7p84OCLtrDin6N4sifwZ61xFJ4v4Acy0tgxWcz25a+kuTEvJyzeKa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(966005)(45080400002)(2906002)(110136005)(41300700001)(54906003)(71200400001)(15650500001)(7696005)(53546011)(26005)(8936002)(52536014)(5660300002)(8676002)(316002)(64756008)(86362001)(33656002)(9686003)(4326008)(6506007)(7416002)(44832011)(66556008)(76116006)(186003)(83380400001)(66476007)(55016003)(66946007)(38100700002)(122000001)(38070700005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OXBBdHRDcXlpeG5vUVRrVXNiVm9tLzlwbWRJaEw1dWQxQ21JWDRZck1NVUQz?=
 =?gb2312?B?MGFpSWtQeDZzRnRxZUU5LzdGNEI2V2lHKzZ3cC9Da05FV0p6RTRLbXZaRDI2?=
 =?gb2312?B?ZzBmN0FFZzYvcGpGQUdLTjlGNDVrMFQwUWYvRWU3YkJ2aVEyb0QwYk5wR2hD?=
 =?gb2312?B?VXFsYURNem13KzhOOW1oSXQ3R0FJbm5pM0E0Q0pzR3hxdmZ6d0t4K284NzJ3?=
 =?gb2312?B?cFhzMjNTTkI4OGkzeHgzcllUU3VDei8zSUtiLzYweHYwTGozR3paR1Z0VnBB?=
 =?gb2312?B?eHJnYjFQdFdtWXh3Z3Y0dzZNZjliOEJieXhnblpFSjFtUTczdXNUQjhwNGZT?=
 =?gb2312?B?cUZDWkVDeU84V0p0OUlpV3BQRXNQUkdTdkVxN09abzNiOVp4dGdyd05PUFMr?=
 =?gb2312?B?MVZJUHNpZGpOcjkxS2ZkaDk4V1ByaVNTSVAwM2Q0SWpxeUlZU08yVC91MVha?=
 =?gb2312?B?TjNON3RWUlNUWTF1UnNlMXJNVVVRZmlocldBZzJjY0s2OW04ZEZqSG9kV1l3?=
 =?gb2312?B?VzZTUlBzcURkSGFTcXF6OE1SandJbXNLL2tFTHdPcnBsVkxub2xNNnQ1WVNT?=
 =?gb2312?B?eVNjOVpBYUtFMktFbzRyc1IreGVJY29RSGRKSjFQbFM3S2t3dUVJQm1aN1I3?=
 =?gb2312?B?V1VxTEtISW0rTXl1ckh1NU9ELzlHYW5NTGZxTFV5QWpGbngxVDFCZDhiQVZp?=
 =?gb2312?B?SXRXbmlNdFcvM244bTArV0pjaGNDcjdNckZyTXZjN3N0TmxWbDRrMTRZM2g4?=
 =?gb2312?B?Q0R0RlcyZnRzSytOVCtwUHdGRXBpeHFmTTFmQjV2ak5rcUlHV3dmRE1nM1Fo?=
 =?gb2312?B?Qkk4cEsyT3kvUFgxYVFrdWxTLzY4NjZDTzQwRUJRc3lIMWlDRHlIS2tHY1Y0?=
 =?gb2312?B?ajk4L3dMT2JyVURZTzZOMWNrNWVZdkdnQ2kvcStvVEYxdVRMNXIxUkRWNTBk?=
 =?gb2312?B?KysvckJoc2U5Y3d5VllESkROMWprMWR1b0N4TGlKNU9QWDlOazlyZEJmYndB?=
 =?gb2312?B?S3lKM1RjWWc0L1lWT3dOUXM1WDZlSWZuazJhQW82OHFBVnQ2REp6bW9hcDg2?=
 =?gb2312?B?QjE5UlBBd0taVE0vM1JwUXlSQ2JEbTFrMnZucnI1ZTVvWHRpTlY0UXh3TUdw?=
 =?gb2312?B?Sk5wOUJoclU0b25PWThHNkVlQ2Z4NmFMSmgzVVdrZzVaa2Y5SE1yYzRxNUFU?=
 =?gb2312?B?ZTJqaGhac0NBNWdZZ2J2bVBKK3lobStEUkN1N1AzUGdmWHV5WUJQUVBhZFpT?=
 =?gb2312?B?cFhRR1lnZk5iT2xtWks4NWNVWVJKdkVRWEZlb25HcHpMMWQ0UWxLb3poVk82?=
 =?gb2312?B?TWwvNkI3SUhCaXpmRVZEbDQxOUhEKzN1R1dnMmRXYndhL3JUVG1KN1RJTVNP?=
 =?gb2312?B?S2FSMkt5S1dCTjNUL2x4UXlJelJRWEg1eWE5YWFMSURwSlJSM2pmdXU1ckhZ?=
 =?gb2312?B?akJEVE5MSnIyd2ZpYWZ0TXA4bGU1ZGdBcTN6QzZaaG1jSGVNNVAyekZjL2Uv?=
 =?gb2312?B?K3dRMW5pdWJ2cjhKalhZTlF5djdXYmRpSG1iemx5UjdMWDNScTE0LzdqbUlS?=
 =?gb2312?B?Tzg4eHowQ3ZBQVRnbGNIbWhvZDZkZmFXN0J4RUtTZ21JRUlrdGFSV2M0V2Vj?=
 =?gb2312?B?bDk4NFl6RTVTSkRPUWU4cjhBS2srTHRwWWVyZDdhZEEvVTZHdkJWNkRBczFB?=
 =?gb2312?B?alJlaXZLL1Z2b1k2b0FnUVoxNUlpYkdtUDRrUmsrcEk2UVc0TlRINkx6RVUy?=
 =?gb2312?B?SjZtM0h6WXgxOGRnUjdsV01XNlRDOVUvWWQwQ3BOSUNvR0d6VVBhaWpNWWxU?=
 =?gb2312?B?MTVNaFByaTNMcWNIdGk5R3pnUDBpSllJeVl0QUs1RnVYQVpZbGRpV0dIZFVM?=
 =?gb2312?B?OUZScXA5Kyt5d2lvalppWHRzNVRIQnpPRkUzM01XaHlYUGJPb1g0Qi9FL1pB?=
 =?gb2312?B?MHZ4Z0JiejFab1hzSjc0OWlTTnIvbFk2SWNRbkJSbzhadlZPUmJOaDBnQkhk?=
 =?gb2312?B?c0RKZUMrWWhvV1QvbUVJZHEvQTdvSmVTVzdJUm9aMmFFbVh0WDEvL0FXMmd3?=
 =?gb2312?B?c1dibVpBbklJbXdTK1c5ZHExbzIzcUtmRGh4dVF3OTlzNk5LQnord0FsZCtS?=
 =?gb2312?Q?4set0W9gnNn3VreZHlewGO4v3?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ce138-04c2-4d51-31ea-08da64be5d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:56:39.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKR1Mib0GFG5GLgwM1LdbDdQ5JmJjf1QvzoxzhhPYbPXrMljqbZys8PnG92VKbqTDP+qUfCfHZhvcnUH+v2fzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIyxOo31MIxM8jVIDE2OjM0DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZnJhbmNlc2NvLmRvbGNpbmlAdG9y
YWRleC5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxNCAxMC8xN10gUENJOiBpbXg2OiBUdXJuIG9mZiBy
ZWd1bGF0b3Igd2hlbiBzeXN0ZW0gaXMgaW4NCj4gc3VzcGVuZCBtb2RlDQo+IA0KPiBBbSBGcmVp
dGFnLCBkZW0gMDEuMDcuMjAyMiB1bSAxMToyNSArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0K
PiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8gYW55IGVuYWJsZXMgaXQgZGlkIGl0c2VsZi4gVGhl
IHJlZ3VsYXRvcg0KPiA+IGRpc2FibGUgc2hvdWxkbid0IGJlIGJhc2luZyBkZWNpc2lvbnMgb24g
cmVndWxhdG9yX2lzX2VuYWJsZWQoKS4NCj4gPg0KPiA+IE1vdmUgdGhlIHJlZ3VsYXRvcl9kaXNh
YmxlIHRvIHRoZSBzdXNwZW5kIGZ1bmN0aW9uLCB0dXJuIG9mZiByZWd1bGF0b3INCj4gPiB3aGVu
IHRoZSBzeXN0ZW0gaXMgaW4gc3VzcGVuZCBtb2RlLg0KPiA+DQo+ID4gVG8ga2VlcCB0aGUgYmFs
YW5jZSBvZiB0aGUgcmVndWxhdG9yIHVzYWdlIGNvdW50ZXIsIGRpc2FibGUgdGhlDQo+ID4gcmVn
dWxhdG9yIGluIHNodXRkb3duLg0KPiA+DQo+ID4gTGluazoNCj4gPiBodHRwczovL2V1cjAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlDQo+
ID4gLmtlcm5lbC5vcmclMkZyJTJGMTY1NTE4OTk0Mi0xMjY3OC02LWdpdC1zZW5kLWVtYWlsLWhv
bmd4aW5nLnomYW1wO2QNCj4gYXQNCj4gPg0KPiBhPTA1JTdDMDElN0Nob25neGluZy56aHUlNDBu
eHAuY29tJTdDMzYxYzliZjM2NWI2NDg5NTQ4MjgwOGRhNg0KPiA0YWE3Y2NhJQ0KPiA+DQo+IDdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzkzMjk4MDYzODUz
NzMNCj4gMzklN0NVbmtuDQo+ID4NCj4gb3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazENCj4gaGFXd2kNCj4gPg0KPiBMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPUElMkZ3NkFGQ2RkQzBUJTJGQQ0KPiBv
Y0JUJTJGN09KWg0KPiA+IGRkQWVZUFRiZ2VBeHBIcFB1Ymt3JTNEJmFtcDtyZXNlcnZlZD0wDQo+
ID4gaHVAbnhwLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bn
b29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jIHwgMTkgKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggMmI0MmMzN2YxNjE3Li5mNzJlYjYwOTc2
OWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBA
QCAtNjcwLDggKzY3MCw2IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9jbGtfZGlzYWJsZShzdHJ1
Y3QgaW14Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBpbXg2
X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+
IHsNCj4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+ID4g
LQ0KPiA+ICAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAgCWNh
c2UgSU1YN0Q6DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiBAQCAtNzAyLDE0ICs3MDAsNiBAQCBz
dGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNp
ZSAqaW14Nl9wY2llKQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlpZiAoaW14
Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSA+
IDApIHsNCj4gPiAtCQlpbnQgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNp
ZSk7DQo+ID4gLQ0KPiA+IC0JCWlmIChyZXQpDQo+ID4gLQkJCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gPiAtCQkJCXJldCk7DQo+ID4g
LQl9DQo+ID4gLQ0KPiA+ICAJLyogU29tZSBib2FyZHMgZG9uJ3QgaGF2ZSBQQ0llIHJlc2V0IEdQ
SU8uICovDQo+ID4gIAlpZiAoZ3Bpb19pc192YWxpZChpbXg2X3BjaWUtPnJlc2V0X2dwaW8pKQ0K
PiA+ICAJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4g
PiBAQCAtNzIyLDcgKzcxMiw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVf
cmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJc3RydWN0IGRldmlj
ZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQlpZiAoaW14Nl9w
Y2llLT52cGNpZSAmJiAhcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9wY2llLT52cGNpZSkpIHsN
Cj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gIAkJcmV0ID0gcmVndWxhdG9yX2Vu
YWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KSB7DQo+ID4gIAkJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiANCj4g
VGhlIHJlZ3VsYXRvciByZWFsbHkgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUgY29yZSByZXNl
dC4gUGxlYXNlIG1vdmUgdGhpcw0KPiByZWd1bGF0b3IgZW5hYmxlIGludG8gaW14Nl9wY2llX2hv
c3RfaW5pdCgpLg0KSGkgTHVjYXM6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpHb3QgdGhh
dC4gSGFkIGRvbmUgaXQgaW4gdGhlIDExLzE3IGNvbW1pdC4NCg0KPiANCj4gPiBAQCAtNzk1LDcg
Kzc4NSw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0
DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZXJy
X2Nsa3M6DQo+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxl
ZChpbXg2X3BjaWUtPnZwY2llKSA+IDApIHsNCj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7
DQo+ID4gIAkJcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4g
IAkJaWYgKHJldCkNCj4gPiAgCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2cGNp
ZSByZWd1bGF0b3I6ICVkXG4iLCBAQA0KPiAtMTAyMiw2DQo+ID4gKzEwMTIsOSBAQCBzdGF0aWMg
aW50IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCQli
cmVhazsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpDQo+ID4gKwkJ
cmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gKw0KPiA+ICAJcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xMjY4LDYgKzEyNjEsOCBAQCBzdGF0aWMgdm9pZCBp
bXg2X3BjaWVfc2h1dGRvd24oc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
DQo+ID4gIAkvKiBicmluZyBkb3duIGxpbmssIHNvIGJvb3Rsb2FkZXIgZ2V0cyBjbGVhbiBzdGF0
ZSBpbiBjYXNlIG9mIHJlYm9vdCAqLw0KPiA+ICAJaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0
KGlteDZfcGNpZSk7DQo+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiArCQlyZWd1bGF0
b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIHNl
cGFyYXRlIGNoYW5nZSwgbm90IG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IEkn
bSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgZG8gdGhpcy4gU2h1dGRvd24gaXMgc3VwcG9zZWQgdG8g
anVzdCBzdG9wIHRoZSBkZXZpY2UsDQo+IHdoaWNoIGlzIGFscmVhZHkgYWNoaWV2ZWQgYnkgaW14
Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkuDQo+IA0KPiBJZiB3ZSB3b3VsZCB3YW50IHRvIGRv
IGEgZnVsbCBjbGVhbnVwIGhlcmUgd2Ugd291bGQgYWxzbyBuZWVkIHRvIGRpc2FibGUNCj4gY2xv
Y2tzIGFuZCBnZXQgdGhlIHJlc2V0IEdQSU8gaW50byBhc3NlcnRlZCBzdGF0ZS4gSSBkb24ndCB0
aGluayB3ZSB3YW50IHRvIGRvDQo+IGFsbCBvZiB0aGlzIGhlcmUuDQpUaGUgcmVndWxhdG9yX2Rp
c2FibGUoKSB3YXMgY29udGFpbmVkIGluIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpIGJl
Zm9yZS4NCldoZW4gcmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UsIHRoZSByZWd1bGF0b3JfZGlz
YWJsZSgpIGlzIG1vdmVkIG91dCBvZg0KIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpLg0K
QmFzZWQgb24gdGhlIGRpc2N1c3Npb24gWzFdIHdpdGggRnJhbmNlc2NvLg0KVG8ga2VlcCB0aGUg
c2FtZSBiZWhhdmlvciwgdGhlIHJlZ3VsYXRvcl9kaXNhYmxlKCkgaXMgcGxhY2VkIGJlaGluZCBv
Zg0KIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpIGluIGlteDZfcGNpZV9zaHV0ZG93bigp
IGhlcmUuDQpbMV1odHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNp
L3BhdGNoLzE2NDQyOTA3MzUtMzc5Ny02LWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBueHAu
Y29tLw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQNCg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMN
Cj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14Nl9wY2llX2RydmRhdGEg
ZHJ2ZGF0YVtdID0gew0KPiANCg0K

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939C60CE74
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiJYOKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiJYOJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:09:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5A6DAE4;
        Tue, 25 Oct 2022 07:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxky5mD5q+EOjWshuJMAz+sM3A/KBaYV0YVBtfl0dvrHdKsNTjaojSGKtcJimVHnBebcR0FJvEu7fEEN+JnBGfe+FhyFw8uFd40leAg0IlkaZRGeeLv4w8anRX4cCShGpqS4+BKCN+9ORF5Q8LnjUsI/v5wEpc20rPMbjykCBh6FNS6YKg7xeWh6swLyTGKJxPWwqSiOflInUzGF5GXvo/8CLYqyS19KC3aVd4riW+YBAPYN+vfM3tmhtZv2o9B0DPGFBHt9FgLDNOrzFW4m6Hv4AHul8q/Al2zHPENwWhgKzG0RDPgZ63lvp/A5h/ux7C/kI1MqgrpDpFHosd0ApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNJ3Ws8S2PtAop7cXlhTDPs/T2+vYhFSD8oycXANd7w=;
 b=oIHvHcWDX1GUCmWDuv+8TCGMG3zwPFzZCMERn9vCqjWs/k2hBkFkWAh2Q6WdCTKxLL05o9yp9lk7eaZU6PKqNRiNgQXoG6FSyiT/RT5970k5eGv+jPRBYidpRbgn5MqKGzVvtSOVvkOyCx0AUsPWCdCxFbxx+W7oxtwl7oiFBbAsBeM7H3hxSQgAl5b2ZF8iIqCfEJ0Glg6zBD/Kx4kqaTJJaUuMH+5uWTU1XAjap98sb4Sy/huWoHZ205eR39PfPFT2JCFrat3sDwPKUm2EIuNozvxUYn0TAEsa7z2XxYrJmdYkNIckhNmjIYDPr53/Ey3orxlOzXyi1XzMs0q0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNJ3Ws8S2PtAop7cXlhTDPs/T2+vYhFSD8oycXANd7w=;
 b=V1E5u09VkSDCuWXJ9ZxCX4AnCu1+1OM2PFA3TZ5Ngb02SaWMqGWkSfHpBRk8gpH0ByZaA2FLE8UN0Yct2E2tJWC9BcmZxicQNOYyXNVOsSRK8IqchelIGihUdXjbEuMhQ+roD4Ykua3goe2KZtirt+R7VSf6qtVNejy/gtM5oDU=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 14:07:45 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578%11]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 14:07:44 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Thread-Topic: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Thread-Index: AQHY6D5oC3eE/p73a0+tHEBmmYl2uq4etySAgAAO1SCAABA9gIAATyHw
Date:   Tue, 25 Oct 2022 14:07:44 +0000
Message-ID: <CY4PR1201MB01357CE5BC12556E8B92289F8B319@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
 <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
 <CY4PR1201MB0135792D5D8E7CBA417C2DBE8B319@CY4PR1201MB0135.namprd12.prod.outlook.com>
 <87f841bb-0182-23df-820b-9d250ab89463@amd.com>
In-Reply-To: <87f841bb-0182-23df-820b-9d250ab89463@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|BL3PR12MB6548:EE_
x-ms-office365-filtering-correlation-id: 6d0e6fc9-51e9-4949-8e9e-08dab69249f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5Asm/7HePx2NQNnrpsK+6cuF+fYE8tsOGeB6NHN7ZiBQOH3F5FH7GZ6LdusISM8b2lCSQtExiyK0/0qjWyg1OXwFPj/FE3vWXebwXEWGbpMDlqU8xzGONYH81fFFiMqA1fu3XjgKaBA+36D8EFIME03UznG+nqr4jzJVLktH8ma+fROIhssuOdHMZDy9NDubZNNZ3PnmjWS3HPlj5VSWMlCygzBgCRbZKdWMsIdNxrnPiOLKLzHgGYySi7SpThYVrZC1FRDT039WyQDqPrc23lMJKFGvpJMgy6nw7k/rrA3hRgx2hQGKLz7J0wVkBc8oEO/48Jca5xkqXbrw0nOmUbflGnlGuLRltH5OyUog6HiJZpJQYF7SINc58sSP5qP6hnlDC32CNzqUXK/3ID45f1vpS1RuV8rnM3dM03sWUCytPkuFPPhq1w2ZoewnEfhDm1MHCVRc5XfT6se0Wqfw/bsfU4BhX+MZIHv85ZhathcaigAfQFu27f9bQm2dLThigXFquGKc4eqLO71uL59ttfNqFy/aYVy8L1KF21pCABRyYkHkVqBzyoaShF4UvQAf82LVMbmh6U5CQe/DIdIVF5FTOmoulm97y9igRJUv0Kl83EPskH56w5gqpCGiUMwKtrsiWGfmVRXRo920sC3GwExUbVIJ+1WI7KHOrHdxfAloOukhMNcPmDXna34FIN6y+3WPtuqzdHQBKcPpEF1aI01LsjLF2hlKJjVc1M8+gaaWhzGBwrUMR8XXpITiAOxzFpoKgG4tXB4YSygEpfmkPqXQ2s0Kiln3milYDpLOlE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(110136005)(64756008)(316002)(66946007)(8676002)(54906003)(76116006)(41300700001)(53546011)(186003)(7696005)(6506007)(33656002)(52536014)(83380400001)(8936002)(5660300002)(2906002)(4326008)(66556008)(55016003)(66476007)(66446008)(9686003)(122000001)(38100700002)(86362001)(38070700005)(71200400001)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHpRSWtrYjN4aE5TVXN1czlIZEs4SG93dHlJV1l3L2NDakwxZGlUYU55aFFu?=
 =?utf-8?B?eEsvSGNQanBNUmJ2ektqMzFuMlN5WTRXWUtaalBxcGZUaHpGRnVHUTVDazRa?=
 =?utf-8?B?ZHdxRjYxbXQrWERVRnlnVldVeXhwQnk0dDZRNzcxTlk0cnJES1pjU29DL0xz?=
 =?utf-8?B?R01wMy9vOVBIMGNRUm5XS0NZOTJYenMzdWpUcjNhNmpvS2NFWllDWkZSQ3hH?=
 =?utf-8?B?MUVyVlJKUitCRWUwdHVIeXorN2RPbG9JSWdySzl5YUkxZllVYlhmUExSeEhu?=
 =?utf-8?B?cmNaWnVMTTM2TkE4czVtR3E0b1RvenBHREVaSUg3bFpWTGJJRkRCaXhPcjhQ?=
 =?utf-8?B?QTU1YmhQYklMTVNHc0dsZHFUK3FmQ3EyVnlrUjF2ZVBIOStyb3Y3dThEcDhu?=
 =?utf-8?B?SFJtaXM1bnR2QTBLRUwxWkJXMFpUK2dDNFpFNzU0aDJUNDFxd05YeHFXRXg3?=
 =?utf-8?B?UlFYQ0RwZTk2U3o1ZC9pVjhTeGhPUXlSOEpiRTNwUWxOZDdkYVp0dzVyZVQr?=
 =?utf-8?B?VlFNUnQrck5neDBUeHRFaVhVTk9IbDBPd1RrWDcwK083d0c4eDM1Q2ZLeE1h?=
 =?utf-8?B?Tzl0SXN2b2RVTFcvdEsxSVBDVm5qN1N5SThicTVxWGpmZTB6SlppUnFOY2hX?=
 =?utf-8?B?S01KRCs5ZDMwVWVzbDNBcnEzcm5SYUl4bWdIVVNxcm1IdzFTc3BVWVY1cE9k?=
 =?utf-8?B?U0JKOTlxVHdxWStXNlJjSEhqTmk3VURac3VsbWs2Q2pwY05FS2F5VUhjM3JY?=
 =?utf-8?B?SVEvalNoTmF5R01CS3BsV0R1QUdHTVUwTFZIdkpodHNQZmNSb2lYYzlRSkZB?=
 =?utf-8?B?RldLeUFxKzlScFUzbzUwdk9TQTdId1JvUGVlUHp5WnN6VjErSTVBM0JESzRz?=
 =?utf-8?B?ZnB0N2o2UzhVSDYxcjNTaUJrbkFUMmVWWnRJUFg5VGloY1JwaGlRb2pYODA3?=
 =?utf-8?B?VE9EVnE4TGpWUlk0UXoyalplRkRlZWdTUVlYVmhuaDlnU2xnRENFemFwT1Q2?=
 =?utf-8?B?QVlFQnAvSVJxQ2RYTHBXekQyWlcxMm1WZExQTGgvSnhyWmFmWDZ0eTJFeDNO?=
 =?utf-8?B?Zi9WT2RSUk02WTdvVkNleWo2d2EzNXlYL2xvaTlibmtsY1hHNm9sOGhXV25K?=
 =?utf-8?B?a0d5ZEJ6eWVwbUR0eGgxYzlZa0Y1VkhRREV2dWpoSzhWdk5UbHR4M2VEamtE?=
 =?utf-8?B?dkgwV255VVdabTN2TDhmKzd6ajVMV2gvVkMvK1RBODg2SGZkbzZkWWNrK3Rl?=
 =?utf-8?B?eXlVeU1vWE9iTjdtYVEraGZrdEtVYmJtc0UwNnJzMkZqQnpFaGE3SVIvSEdy?=
 =?utf-8?B?aDlibHlrV3NJaWJyNHdZTVNFRG0yTDYxK0pHRzVtMG9rWkZjaldJckhZMGtV?=
 =?utf-8?B?UmNQSzNEcWZlRGNRV011OE4xNHFDWEF3MjdzeDN5ZThqdUhRcnlHMmZScVQr?=
 =?utf-8?B?YStienJNcCtDM3Z0UmtDNDR5QmVZZGxiTkVvYUttWFpKbVlzL1FnSEkxZzdR?=
 =?utf-8?B?WUwwMG80RkNPNDFOaWZUQ24rMjJqZVgvK2U3cTQrcVZLQm9VeXV0V1hZZjRh?=
 =?utf-8?B?RFRyeStXSVREdk44cW8zY0paTWp3MUI5cWQ1TjRSREk3b3RYdmwyR0hzK1o3?=
 =?utf-8?B?NkVGS2I5d3ZVQks0dU5JSk1yK2VaRThza3JDd2E2bkRWZjIwbHUrZXI5SGEr?=
 =?utf-8?B?STBiQUQ5ZGh4TWQ3eldFa0dyd0l3enpFRTIxUllRdDFnemRBaEl3c1NMSFJQ?=
 =?utf-8?B?L3lxTXdkK3BXVVc4c2w2bHd6V3NTRjFKUEJyNU0zcE9tU1N6RjVEV3pRT1ox?=
 =?utf-8?B?MmJPZmF2disvdUR3d2ROK295dDhiRmhkOTdSdFJvQVJLMnNqZ1pWYURDNk52?=
 =?utf-8?B?aHJzQm9TeWI2aVlNM1VFUlVOM0w3MkFoSHVKemU0S2EvZkMzM2VwemxGd3lU?=
 =?utf-8?B?TlBOTnpoNThKTUZ2Sm5NbU5pWlpkVG5vRUJWbkpsc1EwN01OOHNPbGxSd3d1?=
 =?utf-8?B?WWZUWE1NQmpxMnUrdjlXL3JFLy9ud01mS1FBeVlpRmhCdkxMTzNtblVKMERT?=
 =?utf-8?B?WkQwQ1B4cmFwNHJGUnRrTEpDWmJ4c0hhbm9OWGFQL0lwdnN6ZER4S0g1eVVm?=
 =?utf-8?B?YmZMZWZlYkNXMGE1dldzcFA2aXJUcmswNDFKWUhBZXhHQWhzSCtDM0dacFlK?=
 =?utf-8?Q?1PDDuPJQin5+LAx9jgXgFSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0e6fc9-51e9-4949-8e9e-08dab69249f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 14:07:44.7834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7kHOMSx0GhGbBK5xO07MtLR2XHWI7TEbqOMMbd2237+umuuuVPb/LozA4bi2b7mngzuDl1VfNp8DOWUVMTY5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyNSwgMjAyMiAyOjUz
IFBNDQo+IFRvOiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFt
ZC5jb20+OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZw0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbWljaGFsc0B4aWxp
bnguY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
IEdvZ2FkYSwgQmhhcmF0IEt1bWFyDQo+IDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTNdIFJlbW92ZSB1bnVzZWQgbWljcm9ibGF6ZSBQQ0ll
IGJ1cyBhcmNoaXRlY3R1cmUNCj4gDQo+IA0KPiANCj4gT24gMTAvMjUvMjIgMTA6MjYsIEhhdmFs
aWdlLCBUaGlwcGVzd2FteSB3cm90ZToNCj4gPiBIaSwNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+
DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUsIDIwMjIgMTowMiBQTQ0KPiA+PiBUbzog
SGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPjsgbGlu
dXgtDQo+ID4+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmcNCj4gPj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IG1pY2hhbHNAeGlsaW54
LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+PiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
OyBHb2dhZGEsIEJoYXJhdCBLdW1hcg0KPiA+PiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29t
Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEzXSBSZW1vdmUgdW51c2VkIG1pY3JvYmxh
emUgUENJZSBidXMNCj4gPj4gYXJjaGl0ZWN0dXJlDQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+
PiBPbiAxMC8yNS8yMiAwODo1MiwgVGhpcHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+ID4+PiBU
aGUgY3VycmVudCBYaWxpbnggQVhJIFBDSWUgSG9zdCBCcmlkZ2UgZHJpdmVyIHVzZXMgZ2VuZXJp
YyBQQ0llDQo+ID4+PiBzdWJzeXN0ZW0gZnJhbWV3b3JrLiBUaGlzIGRyaXZlciB3b3JrcyBvbiBi
b3RoIE1pY3JvYmxhemUgYW5kIFp5bnENCj4gPj4+IGFyY2hpdGVjdHVyZSBiYXNlZCBwbGF0Zm9y
bXMuDQo+ID4+Pg0KPiA+Pj4gVGhlIG1pY3JvYmxhemUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNv
ZGUgaGFzIHVudXNlZCBQQ0llIGhvc3QNCj4gPj4+IGJyaWRnZSBzdXBwb3J0ZWQgQVBJJ3Mgd2hp
Y2ggYXJlIG5vIGxvbmdlciBuZWVkZWQuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBzZXJpZXMgb2YgcGF0
Y2ggcmVtb3ZlcyB1bnVzZWQgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIG1pY3JvYmxhemUNCj4gPj4+
IFBDSWUgY29kZS4NCj4gPj4+DQo+ID4+PiBUaGlwcGVzd2FteSBIYXZhbGlnZSAoMTMpOg0KPiA+
Pj4gICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUgdW51c2VkIGVhcmx5X3JlYWRfY29uZmlnX2J5
dGUoKSBldCBhbA0KPiA+Pj4gICAgICAgZGVjbGFyYXRpb25zDQo+ID4+PiAgICAgbWljcm9ibGF6
ZS9QQ0k6IFJlbW92ZSBOdWxsIFBDSSBjb25maWcgYWNjZXNzIHVudXNlZCBmdW5jdGlvbnMNCj4g
Pj4+ICAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNlZCBQQ0kgYnVzIHNjYW4gaWYgY29u
ZmlndXJlZCBhcyBhIGhvc3QNCj4gPj4+ICAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNl
ZCBQQ0kgbGVnYWN5IElPJ3MgYWNjZXNzIG9uIGEgYnVzDQo+ID4+PiAgICAgbWljcm9ibGF6ZS9Q
Q0k6IFJlbW92ZSB1bnVzZWQgZGV2aWNlIHRyZWUgcGFyc2luZyBmb3IgYSBob3N0IGJyaWRnZQ0K
PiA+Pj4gICAgICAgcmVzb3VyY2VzDQo+ID4+PiAgICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92ZSB1
bnVzZWQgYWxsb2NhdGlvbiAmIGZyZWUgb2YgUENJIGhvc3QgYnJpZGdlDQo+ID4+PiAgICAgICBz
dHJ1Y3R1cmUNCj4gPj4+ICAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNlZCBQQ0kgQklP
UyByZXNvdXJjZSBhbGxvY2F0aW9uDQo+ID4+PiAgICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92ZSB1
bnVzZWQgUENJIEluZGlyZWN0IG9wcw0KPiA+Pj4gICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUg
dW51c2VkIHBjaV9hZGRyZXNzX3RvX3BpbygpIGNvbnZlcnNpb24gb2YNCj4gQ1BVDQo+ID4+PiAg
ICAgICBhZGRyZXNzIHRvIEkvTyBwb3J0DQo+ID4+PiAgICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92
ZSB1bnVzZWQgc3lzX3BjaWNvbmZpZ19pb2Jhc2UoKSBhbmQgZXQgYWwNCj4gPj4+ICAgICAgIGRl
Y2xhcmF0aW9uDQo+ID4+PiAgICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92ZSB1bnVzZWQgcGNpX2lv
YmFyX3BmbigpIGFuZCBldCBhbCBkZWNsYXJhdGlvbnMNCj4gPj4+ICAgICBtaWNyb2JsYXplL1BD
STogUmVtb3ZlIHN1cHBvcnQgZm9yIFhpbGlueCBQQ0kgaG9zdCBicmlkZ2UNCj4gPj4+ICAgICBt
aWNyb2JsYXplL1BDSTogTW92aW5nIFBDSSBpb3VubWFwIGFuZCBkZXBlbmRlbnQgY29kZQ0KPiA+
Pj4NCj4gPj4+ICAgIGFyY2gvbWljcm9ibGF6ZS9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAg
ICA4IC0NCj4gPj4+ICAgIGFyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9wY2ktYnJpZGdlLmgg
fCAgIDkyIC0tLQ0KPiA+Pj4gICAgYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL3BjaS5oICAg
ICAgICB8ICAgMjkgLQ0KPiA+Pj4gICAgYXJjaC9taWNyb2JsYXplL3BjaS9NYWtlZmlsZSAgICAg
ICAgICAgICB8ICAgIDMgKy0NCj4gPj4+ICAgIGFyY2gvbWljcm9ibGF6ZS9wY2kvaW5kaXJlY3Rf
cGNpLmMgICAgICAgfCAgMTU4IC0tLS0tDQo+ID4+PiAgICBhcmNoL21pY3JvYmxhemUvcGNpL2lv
bWFwLmMgICAgICAgICAgICAgIHwgICAzNiArDQo+ID4+PiAgICBhcmNoL21pY3JvYmxhemUvcGNp
L3BjaS1jb21tb24uYyAgICAgICAgIHwgMTA2NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPj4+ICAgIGFyY2gvbWljcm9ibGF6ZS9wY2kveGlsaW54X3BjaS5jICAgICAgICAgfCAg
MTcwIC0tLS0tDQo+ID4+PiAgICA4IGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDE1
MjYgZGVsZXRpb25zKC0pDQo+ID4+PiAgICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9taWNyb2Js
YXplL3BjaS9pbmRpcmVjdF9wY2kuYw0KPiA+Pj4gICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gv
bWljcm9ibGF6ZS9wY2kvcGNpLWNvbW1vbi5jDQo+ID4+PiAgICBkZWxldGUgbW9kZSAxMDA2NDQg
YXJjaC9taWNyb2JsYXplL3BjaS94aWxpbnhfcGNpLmMNCj4gPj4+DQo+ID4+DQo+ID4+IFdoeSBh
cmUgeW91IHNlbmRpbmcgaXQgYWdhaW4/DQo+ID4+DQo+ID4+IE0NCj4gPg0KPiA+DQo+ID4gTGFz
dCB0aW1lIG1haWxzIHdlcmUgbm90IGRlbGl2ZXJlZCB0byBvcGVuc291cmNlIG1haW50YWluZXJz
IGR1ZSB0byBzb21lDQo+IGFjY2VzcyBwZXJtaXNzaW9ucy4NCj4gDQo+IEJ1dCBwZW9wbGUgaW4g
VE8vQ0MgZ290IGl0LiBJdCBtZWFucyB5b3Ugc2hvdWxkIHNlbmQgaXQgYXMgUkVTRU5EIG9yIHYy
IHRvDQo+IGF2b2lkIGNvbmZ1c2lvbi4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQpIaSBNaWNo
YWwsDQoNCkNoZWNrIHRoaXMgbGluaywgSSBjb3VsZCBvbmx5IHNlZSB0aGUgcGF0Y2hlcyB3ZXJl
IGxpc3RlZCB0aGF0IGFyZSBzZW50IHRvZGF5LCBpbml0aWFsbHkgSSBoYWQgc29tZSBpc3N1ZSBv
ciBwZXJtaXNzaW9uIGlzc3VlcyB0byBzZW5kIG1haWxzIG91dHNpZGUgQU1ELg0KaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9saXN0Lw0KDQpSZWdhcmRzLA0K
VGhpcHBlc3dhbXkgSCANCg==

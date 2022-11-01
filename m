Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAF4614ED6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKAQIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKAQII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:08:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05B1571D;
        Tue,  1 Nov 2022 09:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX6vfEd7zXp8ECsITdxm+novoqn5AiM5s/DwmuwPMqDUYR1O0SzQpAa61iNkLpaPnIg56WaAUAGV5deugaUaBbIplES1AVOA/ri2BcNwokXinbb5RyXF/8RZrLqG7NoZB3Z3QCPgXlRTRI+p+hueryOmdbC5RRfwjDmkxUQ2RYBVb3UqPQ8eOpmKchUGgx8EdvLKnGyYqVSDH0vEL6UOxAqMFTThoarCturGne3otg5ZJKAgS47eE5Y+aowGFQlXjOyCgxHf6JPQNyUJ20gcqu8c3sDQF5Ca35RTu9Z42XL1pLPL+SY7+VsVF8PeEnQLYsyv4tXlkjDfKoy+6Dm1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mewYtNWddQHeeYLduGwrgF3Vf1VEKULqxz+E5bUjxg=;
 b=GYd1wDs85A8kpI0u+sxKHp7/CVKiGircsDcvW3aecyf7JZ0U616nVfbj5RFkRaTwnT1NnVQo2p2Q1V59MiL6gMhFpXHC5dsFh+PBXiyNgmzW8j2I9qbDb7vjgRRoRdc7AsE2HhOrVZDaj6i4JOHv4hnsgRGYUY+Af9rFNYoTE0MzHX8sVofHlTgYZVMdJ+NamjpJT7/lzhd/saJbfTFW26U9xQvslT8exgjMTjVYH82RVkE2BhHYK41ZSXJw2HrasSQTamNFoL6/aOEX1OLLikdqn0TFxFn9coa9Q+alrNr2Mo4o7VbsHrprApSqy/AgcMLtTlAe3kjmSlcKkVYwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mewYtNWddQHeeYLduGwrgF3Vf1VEKULqxz+E5bUjxg=;
 b=KgjnZsk6/OP+TZy8KdoA+eytgqYTlLyR3xM3u0ZIY6exa84p2XyKE5tDIeAyKqH9aZS7pC9fJrddhaeCNOu/5QhkCV3N+lWSNBg/DtmvA7ZTxV4GN8ogE8NknoMMspGbyC5C/pGDdzNEbBZE9qZl47E2ZMzPckRu7XAcq8jiraA=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 16:08:01 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:08:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v14 2/7] PCI: endpoint: pci-epf-vntb: Fix
 indentation of the struct epf_ntb_ctrl
Thread-Topic: [EXT] Re: [PATCH v14 2/7] PCI: endpoint: pci-epf-vntb: Fix
 indentation of the struct epf_ntb_ctrl
Thread-Index: AQHY6uX+NR8TaW/PxU6w0p24A40Cma4p/B6AgABGHzA=
Date:   Tue, 1 Nov 2022 16:08:00 +0000
Message-ID: <HE1PR0401MB2331A8A3546988B5BBBE85B888369@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-3-Frank.Li@nxp.com> <20221101115621.GF54667@thinkpad>
In-Reply-To: <20221101115621.GF54667@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB7846:EE_
x-ms-office365-filtering-correlation-id: ba668c55-e61a-4207-9668-08dabc234006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGq1VNMqsj6jQf1UGeSgrzMijjfDy6gsZ1UXqFxRtC/p4KiWGK8SpLrroHoWbldQM0xQcd+1Fl/XxSJZ8ILt2x4F2Xruc5Rs6DgmC2UO8G9R4FJTIDLjrCDoQCn4kGR1wVEzU4Lhd0HsmLscYL8YfUTRPpeGQM29kM8EN5/fsBNkqx+/iRWAKuIh5B82uU+rQshiNaZORv9/yegmJMzl/jUGIDv5ubp4vWIryw/vBIX4GXdZu6GLBdzvCTNxG6k85NiUHyZeKuixWH/U3QE0/1jii6mRk36Dh1Jl+fGRqPuh6RDtPrt7b9Pc00XuFOqptoG/DslLiLIv3UvYwpbMlTmFY/dfcaErja2bBgMn2yF4Y34clZypn4or5BRsMCPvNGY4qkLwo29oun3hD2CUPTnkig9vmlAYPhjh2BM5hCbqAZcuCMPG/+VueZ++9z55JlxmEN5pL7tqbVgRYMP/LGnQSs0Jx0S8EsLO6W8hItRohs354LSxquz3aajk0qrCPcGYSz7ToW0nZpmUg1v82Ec6WH1IoNY/MF+aEhpr+KRlc1RAaUNQ3ZFjTUeYf2UwrS3QOKZAKcJSocxVmKv0ehaWV74/c6ZGpzHrR532T+oR0qxN9HfVFOH1LmSfV6WwVX51IPHWdJoGDhkFP/yBRQCmtwtxZq8AmYYW8JKQpuM8ilObMA+pbfw6F0edSCwSQrkARH8jl4ZPlujoeCvGseX/aR8cqof0ne+ks1uMSgBuBg4IxlX7otRpvcDeEtkJDglhy6HbM4jFyGeAunczKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(53546011)(6506007)(71200400001)(38100700002)(478600001)(7696005)(55236004)(55016003)(122000001)(33656002)(8676002)(4326008)(26005)(54906003)(76116006)(66946007)(66556008)(66446008)(66476007)(83380400001)(41300700001)(86362001)(2906002)(38070700005)(9686003)(8936002)(64756008)(52536014)(186003)(6916009)(316002)(5660300002)(7416002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d21paUlQcjNtOVM4U0F3QU8rcHo1SDlBQWxuNy9URUsrbjJxdFNKQ2V2Q1RR?=
 =?utf-8?B?dnNnQm40MUt6a0E3NXFyWkNhejhKMTlHcFZYY3RrMzViOEluVWRQWE4zYVlZ?=
 =?utf-8?B?NjRPcXl1aVZLVVh6RXpJMFYyaG9yU3VrUjZXK3AzdnI4bDUzeTN5dlBDVGtQ?=
 =?utf-8?B?RUpGT0MzbGRxSlpsZjcvUVhKUXU4U3ZwaVdnaW1XRWtVZDR1R3ZEUUdHYXQx?=
 =?utf-8?B?MmRIdTI2c2lqdEVLSTNjRmkrRHdBTFRSQ3BCSUltcW9iMnpmeitqZ2VtZGky?=
 =?utf-8?B?WXJZSXhHbm54R2M1aHltenRqT0hVOFFUZTBLa2VwOVFNN29lc2FLY093UW9u?=
 =?utf-8?B?bDhTelM2QndZcG5vYWoxbzRHdENUNlZEdUM5MkthQ005VXBScklHRndQakla?=
 =?utf-8?B?cXdMUSswZnVPVmluNjE2YmRPUGlWWEJER29URUcwZFBOSld5S3U4MFlmRVBU?=
 =?utf-8?B?KzZiY2Jhb3pJMmdIN2w3L3Z0SWs4UFcvUExpSkwxeXdxUmdlT1IwODNUMmgr?=
 =?utf-8?B?aXhyODF4RjFoM2JDQUR6QnhWM1hWMEFWaWV1VDNwS1Z2dDIwb2l0M21CbTRy?=
 =?utf-8?B?RFhjREc0ZG4yeDRFUlBoUFdRWFFqRlFsOVdFSmFDdEhJWkoxU2JUb3FKem8v?=
 =?utf-8?B?eEJXckZkM3ZRK2NHZFpYRit4SkJqcjczVTBpeEt4Nk5nYmVUODhvaVdNS3Zl?=
 =?utf-8?B?dXBieDZiZUx0Q0d4M25Lb1pUUXkxSjljVUN2aEdMRlJiekZZbGdXZThWMHdx?=
 =?utf-8?B?Mk5HQVVOc3V2alBPandaamRTZHQxN0FtR1ZnMUVLaG44VER6QzM1TFBlbXMz?=
 =?utf-8?B?ZnRtMEJmdkNyU1E4Z29MZ0tOMFlKMXkyV2pQY1h3S3dSZU9vbTU3VkJVVGVO?=
 =?utf-8?B?UFYrWTMybzdXQjYrY3oyYnF0VGg4dmkxOG1IbWlIYVhycDZoT3hGV0xJQmpO?=
 =?utf-8?B?UHVLN2NhOC9LTmRCdlZaU25LRE1jOUVCWjE2K2d1eFdvMWlyNWxDbXN5bWxz?=
 =?utf-8?B?ZnpUeXB6MURjVTQrQXR0VWI1aHFyVEprQTRGR1VYaWVNcjk5dFNIamJSdzdw?=
 =?utf-8?B?ajFCckxkUk5ic040REhVMjhUek1JWHNhenF2TXFyUktTWkFmcng0UFZMRktY?=
 =?utf-8?B?TFdCOU5nOWV0K0FSTURGbE01YlNJaG5PK2NrYU9wdkhmTTc3ZGk2ZnVZWG1C?=
 =?utf-8?B?N0VPd2g1Ykp4MnpPY1hVUENsLzRWWVhJSEJzOERlcW5sVnJ1QnhUd2pVYXNM?=
 =?utf-8?B?akZxZVBmbTZoN1VlUnFCR0p2eTZSeXNVampiT1ZKcUJtalZmaUpyUkNnbWNP?=
 =?utf-8?B?RHNJWXN0RytML2kwcEdZMUVjUkNmU0ltNzdUTXBaUWgzakxiNU50TzRrTHRE?=
 =?utf-8?B?L1ZMRkxuRytndFBob0FNbE0yanVlcUZRbW1iN1o1ejJYQ2FiemhIVldxQ0pW?=
 =?utf-8?B?NkdidFZzWnNSd3dWYVd4SFR0V3h2clFCTkhoMG1FK2pCc1kyRVVSU3ZBRmRV?=
 =?utf-8?B?bTUzcUxMdTMzZ0k3aUQ5eUN4cy92SzFOZ3lKS0pvSlBjeFB4Y3pEa2NFZXVy?=
 =?utf-8?B?eHgrTHl6TGp5RDB2dlZ4cklKamM4dXdKb2o5cUFsQ1pKbGdmdi94ZnJxbFQ0?=
 =?utf-8?B?VFVWeU5HcTlPdG4zajNTb0M3allDNkhjV2lNaXU5TDZSOGIyait5VnU0UE9x?=
 =?utf-8?B?VXRrRnBKbHY5b3E2bnlxbndCOElYSWREZ1VSMWhCN2FNYmVhR1h5Mno1OENj?=
 =?utf-8?B?aEE1bit6ekkwYVA2aS9hMXBYeURkWVU5WmIvditUeWEzTmRtdC9mU2dqZGFI?=
 =?utf-8?B?dHZlb2RYT2dvbzBrb1drRkdTdWlOYTFKTFozOGhtMHE5bTdHVm9JemNzMzRO?=
 =?utf-8?B?cUNpV1hVMHV3OUo1QzV2ZE0xakp0aVFoS2k3a0tSc3ZWbHFvamFHSlh2akg2?=
 =?utf-8?B?cWNrNnJhRS81MXlUdXhBNUtxOHFzcGJCN1k3VWc1RysxQnVUazJ4SWd0ODdu?=
 =?utf-8?B?Z21jRUkxVmtLRndDV3JjaWFnVTZMamZMSDVWUkhDZmV6SnczSGhDQkR4WDRI?=
 =?utf-8?B?eUxxWi9qY3grZW5sZVdYcU13eXBPc2Rmd0ljcWJoS2M5T3I2NVFjYm5vcy9n?=
 =?utf-8?Q?bfjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba668c55-e61a-4207-9668-08dabc234006
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 16:08:01.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPRs5Dwsv6g8PX83ydIP5+0mJa3CkdKbVNgl3EXbRsiHJjYW3hvnQqdqjW4R7zuCd0V09fLcr/D0k5xgPRC5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEsIDIw
MjIgNjo1NiBBTQ0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBhbGxl
bmJoQGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207
DQo+IGhlbGdhYXNAa2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgamRtYXNvbkBrdWR6
dS51czsNCj4ga3dAbGludXguY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IG50YkBsaXN0
cy5saW51eC5kZXYNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MTQgMi83XSBQQ0k6IGVu
ZHBvaW50OiBwY2ktZXBmLXZudGI6IEZpeA0KPiBpbmRlbnRhdGlvbiBvZiB0aGUgc3RydWN0IGVw
Zl9udGJfY3RybA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBGcmksIE9jdCAy
OCwgMjAyMiBhdCAxMTo1Njo1OEFNIC0wNDAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiBGcm9tOiBG
cmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gPg0KPiA+IEluZGVudGF0aW9uIG9mIHRoZSBz
dHJ1Y3QgZXBmX250Yl9jdHJsIGFsaWduIHdpdGggb3RoZXIgc3RydWN0DQo+ID4NCj4gDQo+ICJB
bGlnbiB0aGUgaW5kZW50YXRpb24gb2Ygc3RydWN0IGVwZl9udGJfY3RybCB3aXRoIG90aGVyIHN0
cnVjdHMgaW4gdGhlIGRyaXZlciINCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9wY2ktZXBmLXZudGIuYyB8IDI4ICsrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0K
PiBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+IGlu
ZGV4IGMwMTE1YmNiM2I1ZS4uMTg2MzAwNmNjMzZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+IEBAIC05OSwyMCArOTks
MjAgQEAgZW51bSBlcGZfbnRiX2JhciB7DQo+ID4gICAqICAgICAgIE5UQiBEcml2ZXIgICAgICAg
ICAgICAgICBOVEIgRHJpdmVyDQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgZXBmX250Yl9jdHJsIHsN
Cj4gPiAtICAgICB1MzIgICAgIGNvbW1hbmQ7DQo+ID4gLSAgICAgdTMyICAgICBhcmd1bWVudDsN
Cj4gPiAtICAgICB1MTYgICAgIGNvbW1hbmRfc3RhdHVzOw0KPiA+IC0gICAgIHUxNiAgICAgbGlu
a19zdGF0dXM7DQo+ID4gLSAgICAgdTMyICAgICB0b3BvbG9neTsNCj4gPiAtICAgICB1NjQgICAg
IGFkZHI7DQo+ID4gLSAgICAgdTY0ICAgICBzaXplOw0KPiA+IC0gICAgIHUzMiAgICAgbnVtX213
czsNCj4gPiAtICAgICB1MzIgICAgIHJlc2VydmVkOw0KPiA+IC0gICAgIHUzMiAgICAgc3BhZF9v
ZmZzZXQ7DQo+ID4gLSAgICAgdTMyICAgICBzcGFkX2NvdW50Ow0KPiA+IC0gICAgIHUzMiAgICAg
ZGJfZW50cnlfc2l6ZTsNCj4gPiAtICAgICB1MzIgICAgIGRiX2RhdGFbTUFYX0RCX0NPVU5UXTsN
Cj4gPiAtICAgICB1MzIgICAgIGRiX29mZnNldFtNQVhfREJfQ09VTlRdOw0KPiA+ICsgICAgIHUz
MiBjb21tYW5kOw0KPiA+ICsgICAgIHUzMiBhcmd1bWVudDsNCj4gPiArICAgICB1MTYgY29tbWFu
ZF9zdGF0dXM7DQo+ID4gKyAgICAgdTE2IGxpbmtfc3RhdHVzOw0KPiA+ICsgICAgIHUzMiB0b3Bv
bG9neTsNCj4gPiArICAgICB1NjQgYWRkcjsNCj4gPiArICAgICB1NjQgc2l6ZTsNCj4gPiArICAg
ICB1MzIgbnVtX213czsNCj4gPiArICAgICB1MzIgcmVzZXJ2ZWQ7DQo+ID4gKyAgICAgdTMyIHNw
YWRfb2Zmc2V0Ow0KPiA+ICsgICAgIHUzMiBzcGFkX2NvdW50Ow0KPiA+ICsgICAgIHUzMiBkYl9l
bnRyeV9zaXplOw0KPiA+ICsgICAgIHUzMiBkYl9kYXRhW01BWF9EQl9DT1VOVF07DQo+ID4gKyAg
ICAgdTMyIGRiX29mZnNldFtNQVhfREJfQ09VTlRdOw0KPiANCj4gR2VuZXJhbCBxdWVzdGlvbjog
RG9uJ3Qgd2UgbmVlZCB0byB0YWtlIGNhcmUgb2YgZW5kaWFuZXNzIGhlcmU/DQoNCltGcmFuayBM
aV0geW91IGFyZSByaWdodC4gQnV0IGl0IGlzIG91dCBvZiBzY29wZSBvZiB0aGlzIHBhdGNoLiAN
CldlIGNhbiBhZGQgaXQgbGF0ZXIuDQoNCj4gDQo+IFRoYW5rcywNCj4gTWFuaQ0KPiANCj4gPiAg
fSBfX3BhY2tlZDsNCj4gPg0KPiA+ICBzdHJ1Y3QgZXBmX250YiB7DQo+ID4gLS0NCj4gPiAyLjM0
LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCu
vuCumuCuv+CuteCuruCvjQ0K

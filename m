Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5C57A60D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiGSSFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 14:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSSFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 14:05:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036201901A;
        Tue, 19 Jul 2022 11:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuhkOs468QL1d6g7HuAn7TEHPnwgXrGkUQC7Jd+sjoufAnCm6MPsSEVwHICiYi/ctBG8/v8fZFrikNNukdYP102glANfdxoJYfDyq7QNPZkkX9g1LZy2TIeUOwEbMgL3p7XqroSBozk2eEFC4VvYDN9IA0eCeekNm2n+DN2xShT8EJOlPdHEUmIlKpQmN1KoYGxhvutxobpiwiZVj+7pKR81DPq1nCtD2UTxhCmXSIn2tjveUO2DtmSAaRYU7qzmhFHbXbOJgekPyZNgY6mUkvFExu6+gUZlnx8Qxs6/r5PB4gprdldnEv1/sBlfs/Fno9aEh8CdZ88oFculNRYVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y0I67hlxbiBcuQbJHh+9r1SifQOKoWUsdy3UipVMzI=;
 b=cuGLKbACfbDc6fFKneSEAXa884FYeVwNOQsi0lA33QC91qRZA5Us5BPRqm0dwk+qlAw07jADwyLmc18psaV7Etur36nqXvQ0FinLtLlBcahj3WHMOP/skwAuYk2+lQFSnx5vEOh6RK4Q2q0+kTax5jZJrxMykz6cqyYu6i1rtKOlhVDcRss9gOgX4AiRv3lgOEc3EopGzJUaJif5MRVkGi8iJk1NSFKRreVxSP4RRMkjD34/pTySyMOnjLgYVufRvloMwhuAhSbwnVYeeJeNlPGjd0YWkhmZD0AWyXrbgNDlDudIKfXiDzu7gOIaHM/kPK5v2Z+zTodLZNJosFtchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y0I67hlxbiBcuQbJHh+9r1SifQOKoWUsdy3UipVMzI=;
 b=kjJvLH++Zfkszs/9AxYB9bmqXkQZ3VzqgjUyTAlqmEVvPmM3F/H8br+ox59g7PiOWcnQvz8KLhtUE9xf/f9UgsfJG3O7RmcnNyX5tdWDORQtSuBhh7i9XYjAFrKXBJJYQUE0uR6+b8fax448GJOSWMkEtem+ASL4OkzrolyuTBY=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 18:05:29 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 18:05:29 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>
Subject: RE: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Thread-Topic: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Thread-Index: AQHYgtMikIqnNwLe1kep57k5GJqCGq1X3C8AgC5SYjA=
Date:   Tue, 19 Jul 2022 18:05:29 +0000
Message-ID: <MW3PR12MB44113F74C424DAC8B2194A60BA8F9@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
 <a095aae3-7143-e3cd-a73a-3db8a702d794@amd.com>
In-Reply-To: <a095aae3-7143-e3cd-a73a-3db8a702d794@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac28a329-ac6b-4792-ea0b-08da69b14406
x-ms-traffictypediagnostic: BYAPR12MB3064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QngQgzZ/ygD2hTfV/wk4WIyE+EjWw3dkiYODVOQb0zpfZTkLceZ8lPkJxZGleaXe2CMIP6tU9lP05kMbcMMN15sH52ga5Tk3BO2yG5WeZN0LbV6Xksn+yOX8+Brp3hViR2GHOGABFu3awmY4lr7dEvPwmKGn5V6XfvZWlBlDHIhS2fYTzyf5jDxM68ybz9xkcGAozAps2LfWwUycOUwvBNNuuy7/3tQlD+8WP04RsjTQ8x6yOijHtsAQIGukY7RzZYrV6YHHSCBXTTHTkgVi34jT0pFa1wBvFvfzyWXexnBDRJqKbkvkTtkn/Ogg8P1rRn856TVCjgIOmPabembnHDNO+kF4qN4gieDw/HB56LNDWMFUXVq2StNGnaSW9e7VSzc/1RZSE7mXGl8ZzeDe8Jzv5rSIqVFNr+/QU5QWYjabo/06FveTSGY87K0bgibpLE5RVMYWGjlTztyFd3zDTJagKRbhgrWuhAr116SDpH/wmNefQ6DBUjWc7kDKZuFdLQLEWh2excvovHytKkJJ2Vi6kJzmYnxSXcuJLWy2TMe3bIpy2SMgg1vIAoafnSQ3MtvM8Co6qhF6LsaajgDOccvEj8FPczMFVQLrCaQV7MCraOnwiKVoXv/wdMJs5KOY6S0nrhwadCRFi53GvXZa9YYoYSUaDbeFqDdRR1UDKHLKtUyQKH4EbqgZJBt4C3YVO2w7bywbDPLMpnMJ/hmdLEqa60xVUY+PhVLaE7TN9mD3Ob8HfOnMXcurVocLWxheE5YTohRQX5wwDa9sP7vH248kMz+mCZSvQ3sowiZp9AB3pFAKoMch4WIrupIS0yCf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(54906003)(66446008)(53546011)(110136005)(9686003)(55236004)(6506007)(478600001)(26005)(86362001)(64756008)(71200400001)(7696005)(41300700001)(2906002)(52536014)(66556008)(55016003)(8676002)(66946007)(4326008)(8936002)(5660300002)(316002)(66476007)(122000001)(186003)(33656002)(38100700002)(38070700005)(107886003)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2tGTGNmWDJ0ek8rTTljNXV5YzAyN29XWVpDTGZRMnFQem5ETk4rMkZHdmdw?=
 =?utf-8?B?cGtXM21BNXdrUG1RSjFZOElGNzJFRHNFd3k3ZzUyRkVLaEpMS1Q5djk4b2Ew?=
 =?utf-8?B?aXUwWGVPR1dzblBYTkZpWm94YkJFRkN0WEdINndrVkhHZzdKMCszZmdreEJP?=
 =?utf-8?B?WlFLMlpYRHhvem1hRkt1WGFOSWM4L0daNGorQ2VJVDk5dFFwZkZrY0lTeENm?=
 =?utf-8?B?NWM5aW00REpBTERKU0lHYTljZmlIRDJtam5vQ0w5N1lrbXVqVFE1VERGM2ps?=
 =?utf-8?B?N2h1Y0d1NS9XbnIrUzNqYVgxY1hLeGpDTk1TOVc0RmEyRDlzNit6NnpKaFpT?=
 =?utf-8?B?R3Nmd2FudUZxMTE3L2J3LzB6Tll3dnZIY0FHRzRKYWVkRnVsZEZKV0Z4OTZa?=
 =?utf-8?B?M3YvcjN6ZVVNWWtmODdKa0JIOXFUSWR6aFpidlVERERjQ3gwd2Q0YUlDdWto?=
 =?utf-8?B?Qkh4RTVScmpLNW5WRDhuMFczczg2TkZWdm5MdGxUY1hEdFU2T0I1T1FXYm0x?=
 =?utf-8?B?ZFRhVDhudnB5bnV2cGFLcmVyUnNwMjNTUElQRGRKUE5DemgyVzU4VTZkcFNu?=
 =?utf-8?B?QmdMZno1SmZSYVMxYURrY0NydmdrK01XMmhWc21xSzFMN2diMXZyODZiWW56?=
 =?utf-8?B?aGxvc2ovWXJYNm9BelgxSllmM1JYOFpacG1WSXRZU3lqelV1OXpET3VzZHdl?=
 =?utf-8?B?RWNuMEVEZGpKZWxEOVB3ZENYUkJLRlFJZ2pXWWJyQ1l1SUNScHUyd2d0S1hm?=
 =?utf-8?B?aHdBSEdxNUNtTVVLZGFyMXI3T2xVNjVkUUVGLzZ2VS9DZm4rY2paUndSUFc1?=
 =?utf-8?B?engrQmNuZHhkSktRZ2pIbHNWZ1BDcWVmdEpBQ29qL05SUnN4MllmNEhVZXRX?=
 =?utf-8?B?cHBPTUphS1I1T1U1dDdCMDgxVm5MeXBJMHViNFJ4cHluRXc0eXY3cEpSaTBI?=
 =?utf-8?B?QkN6RlRsWHUveTAwV1dYbS8wRVg1S0FoVzhMZHdrT3Y0NVdvMDVkTmpscjNk?=
 =?utf-8?B?QVpRQlJmbjBGekdCWTJwMkRMeCsyL043R01BMi9jdys2MjY5WGRRZ1JBMnhT?=
 =?utf-8?B?MDVSblB5Y3Y5ZXhacnM4SjVnK1ZvblMxSzd2Ynp0OThTemdXTXZvdWxodVkw?=
 =?utf-8?B?U2hMNEt0OGhRaGxWaTNRa3d5UGhNQmc4VDdIRGl2L3JSOTJnZ08raWdtMmpn?=
 =?utf-8?B?NTRCTFRhZVdnSGFQT0J3aFQvVm1nWU51VElaR1p6MjZ5aVV0K3ZlSUp5RXdB?=
 =?utf-8?B?dTluU3ZQU3hzQWQ0bTZxb3Evc01yOW5TZ2NDNFA1TitXQWhta1ZKWjcwQndQ?=
 =?utf-8?B?czdvbEtJejJLMDU3cHQwZjg5bVpISVRPNGhubG9rMlVkbnNOMDdIK3FscU1E?=
 =?utf-8?B?TjNEZmtWTGs5MHY4aGdib3FMYUNFZHpkVStkL0g5clltclNHRnBRSkcwMjFU?=
 =?utf-8?B?VEpIS1J1TW5lSktRaXp6Tk1mRlkweU1TcUZrUzRMZDY0VjBUcmd4cXhVcEJE?=
 =?utf-8?B?NDdENVliL1BET3I5ZU1ZeTFScWpTZUE0N1VhdldSaGFESEhpczdrd1h4QllJ?=
 =?utf-8?B?NTNyMldBNFVQam1QWmJDR25qSmtVY01JamJRQnZoWFVUWElBeUx2QTJiQzRa?=
 =?utf-8?B?aU1sQkNXYUJyMEtrV3E2UHVDcjJPVmQ4NVBnRW9sQURTK0FmOVUvbEFyVW03?=
 =?utf-8?B?TjBreGhKWldBalVHbkY5NzR4VDgraGwxZ1p4bkgyc3dYeGR3c1VrZGNtRmpM?=
 =?utf-8?B?QU9qWXV5V3FUYmZwR0xQVi9SNnhvTzRvenRwR2ZYUDgxVjNiY0ZBR0pEQU9u?=
 =?utf-8?B?a2xPL3dHK2JGSHdSd2FRcHg1WEd5aDkwZ3NuNUMwNGYyVjlWNkdPbDVwWExI?=
 =?utf-8?B?WXpZQlhqS0RmNTBGZzlxZzk4YzNCaVhCYk9wWXBteU1lZ3lSSmduWUNwSUg3?=
 =?utf-8?B?STlKNXBYc0JTeC8zTTJnTnVYeXduZHlxaG9zUEhYdXV1UW5xdUo3NXFtRjcx?=
 =?utf-8?B?MVE2aExjSW5HRitJNDh0TCsrTnJVN0plRDJMa3RUU1BjbVBBVG9BR21YWUVE?=
 =?utf-8?B?VzFaeDlxSStrYXNvcHZFQURIS1Y0b0ZYemttZjl3THBRMzNzZkZSd2p6d1lV?=
 =?utf-8?Q?WV6M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac28a329-ac6b-4792-ea0b-08da69b14406
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 18:05:29.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+FEirh6nJhIGCUDmY+iZAJ7yMORO/dde2mD4n9XUgIoRbX5xZS2+jRcmKBD2hMopupDp9C7gCA/rTDisDICqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UGluZyENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgU2lt
ZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjAsIDIwMjIg
MTI6MTMgUE0NCj4gVG86IEJoYXJhdCBLdW1hciBHb2dhZGEgPGJoYXJhdC5rdW1hci5nb2dhZGFA
eGlsaW54LmNvbT47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbWljaGFsc0B4aWxpbnguY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIE1BSU5UQUlORVJTOiBBZGQgWGlsaW54IFZlcnNhbCBDUE0gUm9vdCBQb3J0DQo+IG1haW50
YWluZXJzDQo+IA0KPiANCj4gDQo+IE9uIDYvMTgvMjIgMDc6MjAsIEJoYXJhdCBLdW1hciBHb2dh
ZGEgd3JvdGU6DQo+ID4gQWRkIG1haW50YWluZXIgZm9yIGRyaXZlciBhbmQgZG9jdW1lbnRhdGlv
biBvZiBYaWxpbnggVmVyc2FsIENQTSBSb290DQo+ID4gUG9ydCBkZXZpY2UuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBCaGFyYXQgS3VtYXIgR29nYWRhIDxiaGFyYXQua3VtYXIuZ29nYWRhQHhp
bGlueC5jb20+DQo+ID4gLS0tDQo+ID4gICBNQUlOVEFJTkVSUyB8IDggKysrKysrKysNCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTIGluZGV4DQo+ID4gZWEzZTZjOTE0Mzg0Li5hMDdmOTI2
ZDdlOTMgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVS
Uw0KPiA+IEBAIC0xNTA2Myw2ICsxNTA2MywxNCBAQCBMOglsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnDQo+ID4gICBTOglNYWludGFpbmVkDQo+ID4gICBGOglkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy8qc3BlYXIqDQo+ID4NCj4gPiArUENJIERSSVZFUiBGT1IgWElMSU5YIFZFUlNBTCBDUE0N
Cj4gPiArTToJQmhhcmF0IEt1bWFyIEdvZ2FkYSA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29t
Pg0KPiA+ICtNOglNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiA+ICtMOgls
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+ID4gK1M6CU1haW50YWluZWQNCj4gPiArRjoJRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1s
DQo+ID4gK0Y6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiAr
DQo+ID4gICBQQ01DSUEgU1VCU1lTVEVNDQo+ID4gICBNOglEb21pbmlrIEJyb2Rvd3NraSA8bGlu
dXhAZG9taW5pa2Jyb2Rvd3NraS5uZXQ+DQo+ID4gICBTOglPZGQgRml4ZXMNCj4gDQo+IEFja2Vk
LWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiANCj4gVGhhbmtzLA0K
PiBNaWNoYWwNCg==

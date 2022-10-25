Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7807160C661
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiJYI0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiJYI0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 04:26:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF699193D2;
        Tue, 25 Oct 2022 01:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgmzV5IfVmnHP6RrcFHEVWLbX/r0K43dNjF6RjNUbZE24qPOOZLu5FKtsf17vZFM0cjRKafpW1hnZZoM8xT9nhARjqCURE8aPeDBfNne2zJot0zWfxmYNDTnoXEGUQvqDKLzgUIAdPCK/KWP+FAdTlVG+frLxSaUtRsmQD9HhGA/yRbd6I+DTFgqNnLLtakcNJQJwlWOL5furs4WVZrHk47bsKXkKuwMn5qT1MYfhxmAD9FM7pHHu2cjVtyZ30NMM0Uj2e0K2RDZKgh2MpumDbAisrrwfMM0dC0Ze6Mq8ZPh8j5wxbsTOwUlULnklIWplko24naRcxNqfUZhkt2RKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gZmiwWXvw3/Ihd87OLrI7f8ERXgC2g3Msy0Ms2oS7g=;
 b=KLval1iMm/574kEzxP1lF5MbuXSgo4BBHiYyBp70kvNtb54gbtf+HyBq7LTHtcy+35+TOaT+qnpGzLDJMBGsxZcZXcIW2LY8yVXd6i2/1GcYCUUZFLS5hv0SXZGMZIChJXzw0tObqquo+bSSsySQAMfeXzY3pJIumBERNawP5S8map+AFOf5LdK/zKee9ODOsVQCnJl68jwqdEuEM7ZnlEiecFZ0Wn5SAGYO4g5fnlBs2VPViAYHDoF7rAPtD04pXhgoPpkzfPGFyo/QIswGzFxd0k1x3u30VEGxRNCkeVaCWQM8KkybAn9s46bkSJzqMJxLaCzazuAZVYj/QyW9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gZmiwWXvw3/Ihd87OLrI7f8ERXgC2g3Msy0Ms2oS7g=;
 b=m2Ap8xk6Ri2ttE54puMTC/RbF4CVXbHAYKAFE6lJtcuEXAomj1Qq0gmGgAxJc20C2fPDaLkBPrEsC/ENyShAHR0Hc/Wqdeb62SvG4ncaKPkBd54PU2YAyPr0H7rjAuUKiihOzEoR63qzSmQrjJQklF/yHBes4X2uSaIjuYFrXR4=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 08:26:03 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578%11]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 08:26:03 +0000
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
Thread-Index: AQHY6D5oC3eE/p73a0+tHEBmmYl2uq4etySAgAAO1SA=
Date:   Tue, 25 Oct 2022 08:26:03 +0000
Message-ID: <CY4PR1201MB0135792D5D8E7CBA417C2DBE8B319@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
 <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
In-Reply-To: <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|DM6PR12MB4513:EE_
x-ms-office365-filtering-correlation-id: 16ed8d0e-9af7-40b3-9b6e-08dab6628e21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTKuZ37Ay8oQ9tjm5mQ63nvnnn5u0fcOKCZB+6tgB5Lbe6GqIqnqpgwmua4cs0747u0GYadbxy5k2nbnGUuGL/yruuqLNHdh0BaqJ5mnBKmJoTd+BC+VNnsHue26/0/Xd+AOm5JmfBg141IXc9/H1JFxqUWFVxcBANbEglSSlhxvYE6Fa1maUeL4BT/4cbawpExGRdUYOx3JbXd+JYF9XGsFpp/vXvBkYyt4xpZStQQAtCLz1uLEGw3i2HKh1X+u2zhBRy1r1cFI2ahx68f0C+IHAkW7bAv5EWQ3NrvZccq5SzsPc93CAGq43dVRCFZD6YG2Ap48jX6cujdVZboLFDKNrgEaiWcZJc2aUsVcRRN0T5XJk1dbuV7DmygBryOF+uipd5dNj0UDMcpeVlLm2fchb5SAnj/+L++TEpR0Itd8bkdQ7aRJ6yU4no0ybcPN4yKTlFjvyLfj73uI+2jz/mN0CSXoFyabnw/pV3X27JNEx6DVtvfCscE3d0TmieHLDstXCeRN+J83qn5Kz6kJB+wn87smFpGhZY+/MMvnFXcb3SnuCpFgJa0R2aBZJXqmO6/FxMMgl4+ve6456strhwSTNFTAE7hDWTUBK4XSW4VSjW3V67lKqj7nZ7GfZXbZOIQ0+0Z5wF8D7lKWacN36Zt5DYmQ0iUTvQN1YkkeWl+rAjWH4GLgru6ew2s83k+VN5Rw6yu5Nw8hZzlhJo+5D/dtW6314i0NF5Ul7Px0ySc1zR3TBYFxRFsFstCS/Yf3DbipsUFn1bPN2Rc0g1Od6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(9686003)(5660300002)(52536014)(66946007)(76116006)(66476007)(8936002)(122000001)(38100700002)(66556008)(38070700005)(83380400001)(33656002)(86362001)(54906003)(110136005)(26005)(186003)(71200400001)(316002)(55016003)(478600001)(66446008)(8676002)(41300700001)(64756008)(4326008)(2906002)(6506007)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjdoK1VQK3dKdnhHenZYdGMrMldPUU5VcVc3WHVJekc1K2l4UTZtL3NFaWJE?=
 =?utf-8?B?V3Ayd1dnMzFlTm9nN2lib3VRbS9ERWJEbzU0NitRNzBuZFM5Y0lJSjExV2d1?=
 =?utf-8?B?S2pPVVJ0cmdjTGh0WHlEMVB6MlExakF3c0xsa2dDNnNzVnZZUWZXK2hsKzJ1?=
 =?utf-8?B?aFlpMUZNYnVobGREN3czT0R4MUU1TVBKZFpSZ0ZyeDZuMWNaZVJ1TlZZckNZ?=
 =?utf-8?B?RExDdkJuMmYyRC9vd3BzV1YwY3VyeEl2dzc1ZEtIY2N2VEdpczVtYk9KNXhi?=
 =?utf-8?B?Tm1XNEw3VDlqcHhqWjNKM3ZHYVNPY0llYzB1cHQ3R3FFdHo2RmMvdm1EYTVO?=
 =?utf-8?B?aVFWQmxoelFTcFEvd0tETm15QW1GWUtHQ2RJMHZra0xHeUg3dk9lemJVcUYy?=
 =?utf-8?B?ckp1WVFKc3IwYlVwc1l2cWptMHc3L290a0x6UWVRc1FDSFh3RXFSVHJFYUY1?=
 =?utf-8?B?UHlHS0NSMlRmc0JUZGkxQUxuK1RyanZmM00rZkszbkdYN2pLbFhreVVac1pS?=
 =?utf-8?B?UmFyWGlCL2xSdnMwUnNjNVhVSFRQd2l2VGVzYkdyaHMvS1BXeE1kSVR4ZC9v?=
 =?utf-8?B?UTNLWmhsdDdXSnVJeloxRHNxdDZSc3NOUGJDc2V3ckwrbGhjcm9ORXFIUEhw?=
 =?utf-8?B?Q2g5OEJYNWtxN3lCWU1mQUFUOUNwcGd3L2FIa0dFUEEvb21IMS9RemJGZlpN?=
 =?utf-8?B?QUdwT1BQVklZQ1U0bHQrekk5b1ZvaVhyK2pJNFdmUkR1aDlhNFA5RXlvam9z?=
 =?utf-8?B?bUhPL2p5eFM0S2E4NWVFL1cxcmV3d0FJdWQ1QnRUbzRaQ2dFS3lkUUM4d0tP?=
 =?utf-8?B?Y1pPK3c2RkMxRlFaYzh6M2I3dWRQZS9yZ083Mkk5ZE5DV3NTVzcyR3dHb1Ja?=
 =?utf-8?B?ZTNHd3I5RVYzR2FsN1ZNT1NnWkhLVU5SK0UzMEZpOHM1NllKVDZzcjVkbUJy?=
 =?utf-8?B?d2l6TUdVcWRLUFdNOU9ua2FDcDNmWUtEWUxlNVhwK1hIdWxRR1hHKzNWR0w1?=
 =?utf-8?B?eEE2ZXMzcGlocFFYL2huZmwvK2lBN1VnSkUybWdNa25zUjRCVlNnaWRLeWZT?=
 =?utf-8?B?UXlSNUY5bE00akM4bmdiMGtzRlR3Qko3eENwVFphaU1INmZ3bVdCdEhzNlpB?=
 =?utf-8?B?K1RqeXdrKzdNMTNnenhac29PTTJ6bXlyUHpMY1ZTcXJlRFEyWW40Z1FUT3Ba?=
 =?utf-8?B?NHZWcEJYWkVlWWRXRWtnSmhZMGs1UHhGcUdSd2c3YS9zTmNSRHZRbG5RVVNO?=
 =?utf-8?B?ZFlwVW5uMTJiRzVaOU9IcGlZS2hGRXRBYkNIWXByOFppa0Z5UnB3V1BLRHEw?=
 =?utf-8?B?ZllveERkdzMvRjZmVjZVd2JSd1BJVkFLcEFMMjJRNis0bGQxZFVYRnNjRXQz?=
 =?utf-8?B?RHcwdzJiMklWNlFLcHpUdm52U2Nyb3N0SjhzVW9nZlFMSERHSVp0L0tORUla?=
 =?utf-8?B?b01IWm5CblZ3bVU3MWhFVno5cURUbktkejJqL0sxSVppckFTcE5NZXowbGhv?=
 =?utf-8?B?WE90WkUrOXRLNGxPN2c1UUFoV3hvS2NlaUt0L3R4OXJWY3VvSGZQK1VjWlpa?=
 =?utf-8?B?Wi96d1JrbGp4eC9HKy9aSUlJbHQ5YlJNaFpoR0lCTWl5NFBDUHh1ZjNtUEoz?=
 =?utf-8?B?d1F0cXc1UmE5amI0cldJd1FqMmZBMzNNWFA3OGdLNlRsQ1VMSnRMc2ZhRWR4?=
 =?utf-8?B?dUx3bElqQy92UWtISlJVTHEvQWZKUVBtSEp6aFQwY3BVaTJ4M2pESzA4M3Y5?=
 =?utf-8?B?bTBSRlpYckZ6UnAxY2RZODNHZjNlb2t1eWxuS25EQXRqTnBGaHUyM1BFQmFW?=
 =?utf-8?B?UDV4aHMvNTU0WEdFZVExZkxQSkpRRFV4MnJpdHNFUCs1VUpJblY5SXNvRCs0?=
 =?utf-8?B?SHpkcGtRYnQrMStUeitweTBkeHBocDJ1cml4ZUxDaHNtbW1zU1J6Z1dtZHhy?=
 =?utf-8?B?S0I3c040dGJQeUw0UW9KdW4yRisvL3ZNM1p3VHFuZ1IxQStwSm9LM1p6RWdu?=
 =?utf-8?B?WWxmTERwbUNVNUhpUUlwZ2dWNXp3UHkwWDVmQ0d0Nnpaa09rKzN1NEVTYk5w?=
 =?utf-8?B?V1F3ZlErWXRucGJ4WU9mNGNERmFLbW1HVWNnVDQ4bkt5YnVMWkxmNWZaamJ0?=
 =?utf-8?Q?F3a8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ed8d0e-9af7-40b3-9b6e-08dab6628e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 08:26:03.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jna4VemJi/oAgimHb8HQ2sb1SFUfvi2jPpyilBcYL4qEduMbh44ecmn0cyLp7cf/uUgEOW4ZmYdVb2IrTE5bPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVrLCBNaWNoYWwg
PG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI1LCAyMDIy
IDE6MDIgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBlc3dhbXkuaGF2YWxp
Z2VAYW1kLmNvbT47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnDQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBtaWNoYWxz
QHhpbGlueC5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJt
LmNvbTsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xM10gUmVtb3ZlIHVudXNlZCBtaWNyb2JsYXpl
IFBDSWUgYnVzIGFyY2hpdGVjdHVyZQ0KPiANCj4gSGksDQo+IA0KPiBPbiAxMC8yNS8yMiAwODo1
MiwgVGhpcHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgWGlsaW54IEFY
SSBQQ0llIEhvc3QgQnJpZGdlIGRyaXZlciB1c2VzIGdlbmVyaWMgUENJZQ0KPiA+IHN1YnN5c3Rl
bSBmcmFtZXdvcmsuIFRoaXMgZHJpdmVyIHdvcmtzIG9uIGJvdGggTWljcm9ibGF6ZSBhbmQgWnlu
cQ0KPiA+IGFyY2hpdGVjdHVyZSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBUaGUgbWljcm9i
bGF6ZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgY29kZSBoYXMgdW51c2VkIFBDSWUgaG9zdCBicmlk
Z2UNCj4gPiBzdXBwb3J0ZWQgQVBJJ3Mgd2hpY2ggYXJlIG5vIGxvbmdlciBuZWVkZWQuDQo+ID4N
Cj4gPiBUaGlzIHNlcmllcyBvZiBwYXRjaCByZW1vdmVzIHVudXNlZCBhcmNoaXRlY3R1cmUgc3Bl
Y2lmaWMgbWljcm9ibGF6ZQ0KPiA+IFBDSWUgY29kZS4NCj4gPg0KPiA+IFRoaXBwZXN3YW15IEhh
dmFsaWdlICgxMyk6DQo+ID4gICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92ZSB1bnVzZWQgZWFybHlf
cmVhZF9jb25maWdfYnl0ZSgpIGV0IGFsDQo+ID4gICAgICBkZWNsYXJhdGlvbnMNCj4gPiAgICBt
aWNyb2JsYXplL1BDSTogUmVtb3ZlIE51bGwgUENJIGNvbmZpZyBhY2Nlc3MgdW51c2VkIGZ1bmN0
aW9ucw0KPiA+ICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUgdW51c2VkIFBDSSBidXMgc2NhbiBp
ZiBjb25maWd1cmVkIGFzIGEgaG9zdA0KPiA+ICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUgdW51
c2VkIFBDSSBsZWdhY3kgSU8ncyBhY2Nlc3Mgb24gYSBidXMNCj4gPiAgICBtaWNyb2JsYXplL1BD
STogUmVtb3ZlIHVudXNlZCBkZXZpY2UgdHJlZSBwYXJzaW5nIGZvciBhIGhvc3QgYnJpZGdlDQo+
ID4gICAgICByZXNvdXJjZXMNCj4gPiAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNlZCBh
bGxvY2F0aW9uICYgZnJlZSBvZiBQQ0kgaG9zdCBicmlkZ2UNCj4gPiAgICAgIHN0cnVjdHVyZQ0K
PiA+ICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUgdW51c2VkIFBDSSBCSU9TIHJlc291cmNlIGFs
bG9jYXRpb24NCj4gPiAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNlZCBQQ0kgSW5kaXJl
Y3Qgb3BzDQo+ID4gICAgbWljcm9ibGF6ZS9QQ0k6IFJlbW92ZSB1bnVzZWQgcGNpX2FkZHJlc3Nf
dG9fcGlvKCkgY29udmVyc2lvbiBvZiBDUFUNCj4gPiAgICAgIGFkZHJlc3MgdG8gSS9PIHBvcnQN
Cj4gPiAgICBtaWNyb2JsYXplL1BDSTogUmVtb3ZlIHVudXNlZCBzeXNfcGNpY29uZmlnX2lvYmFz
ZSgpIGFuZCBldCBhbA0KPiA+ICAgICAgZGVjbGFyYXRpb24NCj4gPiAgICBtaWNyb2JsYXplL1BD
STogUmVtb3ZlIHVudXNlZCBwY2lfaW9iYXJfcGZuKCkgYW5kIGV0IGFsIGRlY2xhcmF0aW9ucw0K
PiA+ICAgIG1pY3JvYmxhemUvUENJOiBSZW1vdmUgc3VwcG9ydCBmb3IgWGlsaW54IFBDSSBob3N0
IGJyaWRnZQ0KPiA+ICAgIG1pY3JvYmxhemUvUENJOiBNb3ZpbmcgUENJIGlvdW5tYXAgYW5kIGRl
cGVuZGVudCBjb2RlDQo+ID4NCj4gPiAgIGFyY2gvbWljcm9ibGF6ZS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgfCAgICA4IC0NCj4gPiAgIGFyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9wY2kt
YnJpZGdlLmggfCAgIDkyIC0tLQ0KPiA+ICAgYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL3Bj
aS5oICAgICAgICB8ICAgMjkgLQ0KPiA+ICAgYXJjaC9taWNyb2JsYXplL3BjaS9NYWtlZmlsZSAg
ICAgICAgICAgICB8ICAgIDMgKy0NCj4gPiAgIGFyY2gvbWljcm9ibGF6ZS9wY2kvaW5kaXJlY3Rf
cGNpLmMgICAgICAgfCAgMTU4IC0tLS0tDQo+ID4gICBhcmNoL21pY3JvYmxhemUvcGNpL2lvbWFw
LmMgICAgICAgICAgICAgIHwgICAzNiArDQo+ID4gICBhcmNoL21pY3JvYmxhemUvcGNpL3BjaS1j
b21tb24uYyAgICAgICAgIHwgMTA2NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiAgIGFyY2gvbWljcm9ibGF6ZS9wY2kveGlsaW54X3BjaS5jICAgICAgICAgfCAgMTcwIC0tLS0t
DQo+ID4gICA4IGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDE1MjYgZGVsZXRpb25z
KC0pDQo+ID4gICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9taWNyb2JsYXplL3BjaS9pbmRpcmVj
dF9wY2kuYw0KPiA+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvbWljcm9ibGF6ZS9wY2kvcGNp
LWNvbW1vbi5jDQo+ID4gICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9taWNyb2JsYXplL3BjaS94
aWxpbnhfcGNpLmMNCj4gPg0KPiANCj4gV2h5IGFyZSB5b3Ugc2VuZGluZyBpdCBhZ2Fpbj8NCj4g
DQo+IE0NCg0KDQpMYXN0IHRpbWUgbWFpbHMgd2VyZSBub3QgZGVsaXZlcmVkIHRvIG9wZW5zb3Vy
Y2UgbWFpbnRhaW5lcnMgZHVlIHRvIHNvbWUgYWNjZXNzIHBlcm1pc3Npb25zLg0KDQpSZWdhcmRz
LA0KVGhpcHBlc3dhbXkgSCANCg==

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9864FE86
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiLRLFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 06:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLRLFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 06:05:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E265B0;
        Sun, 18 Dec 2022 03:05:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OilK5enQkStl805UWBG5UJ83IjsAjpzXXx/Rtjuk79nZF/xqs2EW1Qk1GeSKUEwT4NwFzRuIklzq/H0H6PNsM/o9uLvbXe1KSfrjXRiDJ0JtzZOUMmNmN2BEEBeAWPE2nZckDfAI+HAttnz2/vmLmfagN4JDOdRVAcslQuNTJamLpPdj7Bq3ZGDMn7EC/4Tz/LwWaXpgFCkzvZbyZk5YNGbqdOysTATF/1Y2xIXqR7CrOFqlA22jeCFdotubWW6G3qgVvC8bO3nm0X/fZLP4JHsczdU/OalkbGgVWWACYIdhlQUk5rOchi862Qtaf1kv2MlwPV+oIa8FPxhw4otU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vRYuByfAr4SBRRK8Md3xB667hGdXCsjGB8hdvdPQIQ=;
 b=LXHrKvQH0oZACIdy05KGUt62NxqlymnkPfnJXYTwGYOtqwWwk8Atb6BD9ylOexJvwGUU1qfw7nzWA4v+KQ9i5d0nkcmycioRsQaadJvgUU+e/1cMp4oWsQez8ubiWiKYV9+5LC+Ianbrkui6u356CniFsM4+JPUA1l7fd9y69bTkg3WpaPYcPPz7Hwhlh8dSGFjmaxAq00/lzQmDDbxlK3++8fFCzojO4s7mPJ8DHz+F/z+NiuDv99HJ4UcfUfV2xG361GCUb0pr7X1a+tYUqPXLY2TfFupq9R3uOx9aKbp6Ezd1wJD8+mfOJ0dp4hUEytsXpBI/eVY8zBVOXsiUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vRYuByfAr4SBRRK8Md3xB667hGdXCsjGB8hdvdPQIQ=;
 b=sALnCDCpcMRe7HgCGkSA52maLyRxgQ1+HZfWREmqedD3XrLj90rio7ICKkdrqhqLJz+d+Le0rca8BmMrfsKD8m5LpxRLi/Ma2dEe7FpsNRwC3BN/Ia6FH74KrfmXMYnn3ALIE2H99yWcoJSQR1+huBdc7bpDvWLr9yDL/7trjLHP0L+FLrKg0P8FK+RjW+ll9Jnlogzl11vbTTwz+pcZU+VlQ6UzVZN+NSOc7X6B4xO/t12ZrYA8ihKVdMAzy1eOZoYQzo47SGG9+d/bXyxJUgDhturTfZA/ij9GdPWbxbmqGdiFmpfM+VS458bDugLDmcp7ZfOFnW7BwcEhYpBOcg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sun, 18 Dec
 2022 11:05:27 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5924.016; Sun, 18 Dec 2022
 11:05:27 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: dynamic MSIX submission plans
Thread-Topic: dynamic MSIX submission plans
Thread-Index: AdkSwhlrQ+m8PjHmS1ipW7AraIwGZAACysGAAADFP9A=
Date:   Sun, 18 Dec 2022 11:05:27 +0000
Message-ID: <DM8PR12MB5400298074AF71F5E8A60FFEABE49@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <DM8PR12MB5400783BA8E864AC3DA47BD0ABE49@DM8PR12MB5400.namprd12.prod.outlook.com>
 <Y57uUaSWXkSxZzHy@rocinante>
In-Reply-To: <Y57uUaSWXkSxZzHy@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|IA1PR12MB6308:EE_
x-ms-office365-filtering-correlation-id: 6585a8b0-bc52-426c-20f0-08dae0e7c51b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHHfs6lO3WPuCM9oBnLJQDKxZbG6LBPb4+eQ832IGyotEPGckPIqTWF21XlPU3BUHCxk4jS3JHz2Nus09xb7TvK5LTL9b9ttX/bE+qVjS9vqLlnATSPvWTLjrOnkTyYjDg0NqiBnsz+Xt+Quv9q/H7D2dDjCN8NEt5rXSqa7NQ0Z1aHW2HOstqLKtWw+gGXgfy5kRqfw8AxN+qcBe65v4Tiiko5M0gcLvukDTjycyMbq5prf6jM7fBOpsL4Z/lzYYCvMkBhld5+vZ3vZWxr8PotY8L8vio4bm9a/4ajABWqCbX6lWwFJYDHi7K+R+5Qco9qi9CJx4fakKMkye6U+/n0esRNRB8U9TfSEjVGvuXPaw18nq4e+H/dklSf80Z9coXzEv/VBmtmB8W5xMqMyVtXPReEs6z+gFELZu8wUmvrprso4Ko+yyA/TsBBHRjYx+0ni3qaHrwbD++s13y61TVTxCrtYw4ceUljisGLnzV0F2LBMdvxDrQ+1FvWI4P+SKGgpGnGE7TTnMCo7JkcQ1ChlHZpYrEVnTgPySxGkbl7NQSqPieRFndG6Ot6oLjQ7xW/RqWDWh2S1fqWMHlE7I404GvL0VLvazMi2vHl/AMf0MmhPBiueDHMfkeRZ6FSi9ZEPpsVWd2ThfqPIUALj7oaLf8JVDwf6L9se5pz1sXi/kuDBPBUwBsIlKFEWLcH/Zy5qx9a3YmiE5Pyu6KT16G8LEHpn82xdFLvEZUF5YD9aZUmoQxIq4UO0o3b1RNqMIvvrcJFaZNgerwkOoqk54ImtykcdZJplLUzFzwVHkAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(54906003)(66574015)(316002)(966005)(478600001)(71200400001)(6916009)(7696005)(66946007)(66476007)(66556008)(64756008)(66446008)(41300700001)(8936002)(8676002)(4326008)(76116006)(6506007)(53546011)(3480700007)(5660300002)(52536014)(4744005)(26005)(9686003)(186003)(33656002)(2906002)(86362001)(38070700005)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SURnVkQ2bDBMYTIrZ3JmMkxwVC83THBGWFlkdHhsYnR0WndENmlvTTlySm1o?=
 =?utf-8?B?MnFxYTlSNVhmNGxyandMWndSR3dMYWZObkFscklvcE5SalMzVjZUWFpxL0JO?=
 =?utf-8?B?SXAyRmVpZVhHYk1qRWkvTDJjQnpzNEVaL1B0YW9lVFB5Z1BmZ1h1V0gzTzBo?=
 =?utf-8?B?b21CUkFDZTU3ZWY0ZU1aV2ZORWRJRXZsUDVJU0dFc2ppU2N2NW55WUJqRHpt?=
 =?utf-8?B?M3FleDRRdDVwdHNJZ2JUYXZMSXpkdndMbHBEZ0g1ZTJhUEFJL2s0aUtXWWNB?=
 =?utf-8?B?OGUwc1hYU3I3LzZDZi8vSTByRTA5SGQyN3ViVks4SUhHV0J6VzVFeTlEOCtK?=
 =?utf-8?B?WWxjdGdtNjc3RWFuNW5ZVnRBRGZBSXJaS3U2V2VzYUxYK3J1VzJmVERuRG0y?=
 =?utf-8?B?a0MzMFFsakZ6Ti9oR3g0REhiK1h6Sit1dGxjcjVqM2dreGNTdDlLeW1yNWdE?=
 =?utf-8?B?bk5jTldiV0s5V21jRjk4VUVHV0duTzgva1ZNR3g4ZFdhVkJ2RXBxYk4wNzZw?=
 =?utf-8?B?eHZKNnExRDJqd1Q0WlNXaEExRWNaZUNpVXhXdnlYanFFYm8zZnNwQ0Y5OTM1?=
 =?utf-8?B?My9pUllMMVkwU2hkRE5QYVBUQTg0aVRTRTJZVUtOU0VxQWd3Zjl3TkpEdU5Z?=
 =?utf-8?B?TjB0NjQrZ2xwUjBhRUs3WWlYWktlak5QZUZJQmZPa1Bma0NQcHd4Rm5VMXdU?=
 =?utf-8?B?ektEZllWc2w2d1daVHlPOVFScTk4TDZHU29aaWZ6ZTNlUUJUQ1F2ZDNPS3FO?=
 =?utf-8?B?cld2ZVlLY0Q3VlNMWGw4aGl0YWlxZmNJdDQ1UFNqTzJITjU4Z3E3VkE3dkVX?=
 =?utf-8?B?VTlTU2R0OHBLLzVobUduMDd0bkFSWUtmNVZ0eFhrSklHQXAyUnJ3TmFIbWt3?=
 =?utf-8?B?djBoVFBydFFYQno4M1MvVzVXYmpQZVB0Nnh2RWJCRnkwcHJYSFdrZjRPZXRm?=
 =?utf-8?B?a2I5bVJVcW4vNjFGNlZFYWY4R0M1SUE0RnQvOTJtaVQycUY3UTRrUnc3KzQ5?=
 =?utf-8?B?NWp3dnN4QXo4M1dKL2ZhR3lEbUh6d1NCeTl1a3h5WHJYMFZnV3lRdTVFcVg1?=
 =?utf-8?B?dHA3SHB2WXAxQjRWa3lsb0M0N1BuUHVJRTRDZG1RRGt3N2dKcEgyOGNlL0xG?=
 =?utf-8?B?NG1CY09WaGdMalRmeEEwcm9hQ1pGd0F3SHJnRkN3TFRMdVN1T1hQdXhCODVH?=
 =?utf-8?B?em0xZHJrOFVCUmMwR05RUkkwbzkxUHFPTXNYUXIyVUxjOGJUaUJjM0Y4WWpO?=
 =?utf-8?B?K1pSVEM2MHc3TmJ3cEFBMGtWSUFwMXh5WjVmVmtuYkN0bWNwTDlCWHR1cHdM?=
 =?utf-8?B?dElmSDY3UmJFMjhRWW43QlNLRnNiNUxOSlJxeU5BRkdDK3pNYjA1YjdlZlNk?=
 =?utf-8?B?NzVYN2tyWkxXSFBQMnJKZitUR1MyVlYvWFkydVk5eExPVkRQRjJWYUU1cmhy?=
 =?utf-8?B?d1BXN0U1akRNUVdORWZRQlhzQTg3UEJ1NjQ3dnBoVU5PSkRGdHNFdktsalFN?=
 =?utf-8?B?bUY1Z3I0NG1jM0RjYUZTeGU5bFB6andQeHdWVEZzT3FCN2pPdzVaVzZ5NFIv?=
 =?utf-8?B?RjM3V3BGakdZcDI0aVptREpDTVR2WStBTGx1Z2RKRU9NTmVacHBGT3pvaCtv?=
 =?utf-8?B?VklhV1I3R1gzSTdFbzRjb082RTdXOVVKZ0ExN0hKbDY3S2hyZTF4bHJQL0pl?=
 =?utf-8?B?cEJHSHhsNmgrem9iK2RmS2FxajNEQXFhNGRBR3lzNTVoOFUyR0grcytRNXJ2?=
 =?utf-8?B?bmYxd29FYmIvTGw2UElzbXh1aUNZMEo0RU0ydDZXOEp3eUV5M1BxMzUyakNo?=
 =?utf-8?B?bmdPeG8zYnNoZHlrazFNb1pPZlB3SVE5VUM0bnVsNlpHaHhlVXMwbUplbXJy?=
 =?utf-8?B?WjdEcUtsSFRGZ0o3STJaMXFwWVV4TlI4U3RkVFY2ZXBzTDZFT2FhbUxvUGFY?=
 =?utf-8?B?YmFkc0dhVkpLS0wyUzlVYnBkcjV5d2g1WDI3Zkw3WEZTNHNrSlJqdzZQZ2RP?=
 =?utf-8?B?elBMa3JjOHIwR2w2aitZb293WHgxczZmWFNQWk11YlI3ZG1SekZlbWVFY0pO?=
 =?utf-8?B?KzNCYnJMZmNFQU9pT2FsRk9DK0hOd2Q4VU9NZHVrOEhNOWNmMEsyR1ZKYlhn?=
 =?utf-8?Q?I8dI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6585a8b0-bc52-426c-20f0-08dae0e7c51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2022 11:05:27.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBNAvzLPKadrPtkzzHfWTe9rKLF7AIU3Q85lMRBrFRPUo75eQunvggrNV65PVrLI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogU3Vu
ZGF5LCAxOCBEZWNlbWJlciAyMDIyIDEyOjQxDQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4NCj4gQ2M6IHRnbHhAbGludXRyb25peC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IGR5bmFt
aWMgTVNJWCBzdWJtaXNzaW9uIHBsYW5zDQo+IA0KPiBIaSBFbGksDQo+IA0KPiA+IFdpdGggcmVm
ZXJlbmNlIHRvIHRoaXMgd29yaw0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0DQo+ID4NCj4gPiBDYW4geW91IHNoYXJlIHlv
dXIgcGxhbnMgd2l0aCByZXNwZWN0IHRvIHN1Ym1pc3Npb24/DQo+ID4NCj4gPiBBcmUgeW91IGdv
aW5nIHRvIHNlbmQgdGhlbSBmb3IgdGhlIG5leHQga2VybmVsPw0KPiANCj4gSSBhc3N1bWUgdGhp
cyB3YXMgaW50ZW5kZWQgdG8gYmUgYSBwcml2YXRlIGNvbnZlcnNhdGlvbj8NCj4gDQoNCkhpIEty
enlzenRvZiwNCldlbGwsIG5vdC4gSSBhbSBqdXN0IGludGVyZXN0ZWQgdG8ga25vdyB3aGVuIHRo
aXMgaXMgZ29pbmcgdG8gc3VibWl0dGVkIHNpbmNlIEkgd2FudCB0byBtYWtlIHVzZSBvZiB0aGUg
bmV3IEFQSXMuDQo=

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72557716C2B
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjE3SWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjE3SWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 14:22:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBFA7
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 11:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9hGZO8AaZkUk1rPaozVAqjUpJYlOsK4NR6BVFWFK9fR2/0hLueXymVKrPrQe6j/Ka/q2wfhwoOoqWmjSDpmKKDH4PiIhgo+WEaYTIqgzjuIpJTSaf8tC6ZFtCngm8qqylYh+X/TT6DWYZdo8jzWC2zsz6jh1JFQSZMQDcyj+rQ7pUNFHlX1VBGs1cDoILj2i6OShNh3kxXAU69Y82q9N1Ze92KZhTwAc4/XOY1TE/wzJbZ+r6zYqa8DYp0cCP75aI+yPeTN4hXHd+88Q56LXdkTW/hRURpIEDZPv0avJIgi2YYE9PSRfqUYMVFYIC4B1whLHBZJjh+Tp/urx7PAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTBw9NeUl11tjdy9Xi0gP2FUk+JYlY68c/sO1Z8C4lU=;
 b=IhRsK2kHVEuoGaKyhVou+EEJN7AcNVfbcj/tponz+nScBQR3AXiQmrOS1kbn6uG7Mr7NPwQlg4kS3Zt2dvXSmKD7zYKVHLDfLS09vkqZUXtdaZvdU23bQnMPCwSTQ2vKx0DDU+7GxtG3yXFa8P+m8CE7oFHx4IUuF896dzLfoD73x8CHNzdHYns6iWDA+xhvrdk907JXdV9WshlhIKv1KBUhaE0z5x6FgiV+5JsNl6b5yRkfLLcK0e7GXYoiviWIdiLUP1VJVYC25L7ibiTl5qzwq5W7QP4GkRqYajzz6i1O4CeU2bQPGgFlkdjNMh3+orygCV3DE9vA+KG+mS5a7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTBw9NeUl11tjdy9Xi0gP2FUk+JYlY68c/sO1Z8C4lU=;
 b=x8522J8KWdCfTMPIw+OvCYFqcsSthmUqrbkFzuUroFRA33vUrdwUbglXnuXjxr5f4HMhC9JezagsvpPKzF1LblHHwcfSmFIaffX7UBgGdsDAlOIlE2h736o4ffHTJAGFeoroajsZlJWNwrsBpSaxeqas82AUC2SAMKWWq8vAnAw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 18:22:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 18:22:43 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Alex Deucher <alexdeucher@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Zhang, Morris" <Shiwu.Zhang@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Topic: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Index: AQHZjSt1vL33XREOB0eQ13Ys7/aLOq9nZ6QAgAB8dACAAt0igIAAuM6wgACppQCABwghAA==
Date:   Tue, 30 May 2023 18:22:43 +0000
Message-ID: <BL1PR12MB5144051B528AE6BB7F30B729F74B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
 <ZG8ud4JWpF7BXJ7c@infradead.org>
 <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
 <ZHBXzItiT1+OSsjX@infradead.org>
In-Reply-To: <ZHBXzItiT1+OSsjX@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a6010fac-cce1-476a-9412-0d717b5b55bf;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-30T18:18:18Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6444:EE_
x-ms-office365-filtering-correlation-id: ed85fd08-faa5-4ec3-c115-08db613adc7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBF7Nsk2s7r1Ke1DBeF4wg7RiLZ8b9EvJva5cjirocmSz/UutftyvTBrzvigaYOIBMSHwTRolMzywurIAe6Bgl69alWM9ZdMeYgshZHfRsL4DpIseuZKxD4zJAfvE/hgsAdVfH9pjk4yQyX5QbYBoBuB+UnOaDCzK/OQ+1QfiYs9+1bOq4hz/4pyK0D0kMJGb8zymp/ATcc+zIQMk3WX0z2RzYZPfBa/LoVeQXafzX74Va5uUcrZfLfd9OQY4IlkyTINNq+irz35oyGRGXnNdUET/Lt3TFxmgBN52Oi/btG/atxWJER/xnbvglm4l6lCbtRcOYvr9wPCEMDjfhWL+JWCCwjFKOaEjrfXpXaa6VGmdBBD+Q25FpdH8WWROWvbcKLYbXB4X0KyPxx5PaGoGkMBjTTmusrCxN6bcV+4dnFgtlcqb6BLt08pGI6NSPfZdgG7cUYeYTgneVSHLUPHKA4AkMy6Q/BaYHlvtXvhOgMt5fLy6/GEBnFuIV1xuBch2RKFC5iSyUBkk5l0ANunVNSIgZaAUXa1ismLDTFELJEhGmmvsMYXM+fodTQxkBu9xOVZkJYj7cAbNNRnYy1kLS2d1EIuzL9z7NBkqfDmMS3C77o43AgjvqKj9Ldp++5z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(186003)(53546011)(9686003)(6506007)(52536014)(5660300002)(478600001)(54906003)(8936002)(122000001)(26005)(83380400001)(38100700002)(86362001)(8676002)(38070700005)(41300700001)(7696005)(33656002)(71200400001)(316002)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(6916009)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGJ2NFlhM0xOWlNvY2tkM3dVSEVSdEdzc29Hek51NW9qOGZKRXFFRkZOcElE?=
 =?utf-8?B?dlI4WDNFbDFqOUQvWVBQV2JqL2hNQzdZeFp3ZysxK3NmeWZRL3g3UW5wTktP?=
 =?utf-8?B?emJNOGRMQnZGdkJ1eDllbnp4S3JRcVVWT2gzUENORnlRNnQzWXRMYlFNVHp5?=
 =?utf-8?B?Vm51N0pOSXg3MU9kQ0wwL2NCNXF1L2hlSWRLbUNkNjQ0WTVLUGRHd3k0bm1W?=
 =?utf-8?B?TkVhTjBJRlJqcHo4M29PdENBaGdxN2dPcWhzWkl3R2REalVncnNqUDZ2eW9R?=
 =?utf-8?B?L3o1bVhLMDg4anV5eU1adHNUYUlsRVNzT3JQMWwrcEUvUnVLNy9JL2dxY0N3?=
 =?utf-8?B?ajI3b0xTWTI1Sk5QNVBqMkZnUCtsNXY0VkRJOXdUUkVtMVh6ZVdQQWdYWWlo?=
 =?utf-8?B?R3FGZDRYSDBrc1lyWGZaZjgyelhuRVNGTThWL1pZM0NNOU1KR2ZSd0VRWjR1?=
 =?utf-8?B?VEdheDRDUmFvOVpaZk1KZUU5VHBUR0NpRHUwcUdUNHpaUGZtZTRYcnBpTXNV?=
 =?utf-8?B?WjZBOStGczJ0bmc3Yyt4NkIzdHpJRUFKZWRjZ0dwQWlRUmc5WEhpdnJFSGh4?=
 =?utf-8?B?U1R0TkdGZmUycVBiaWRaY3Q2SjlmZWhNckh1dWpxZjBOY0JPN2toVUhpaVlW?=
 =?utf-8?B?RWdWN3dDTktGRDlFdHZoSWNZM0NKUzZ3Y2RsUUxobnFsejQ2MENDekxwM2hm?=
 =?utf-8?B?SDdxeHg2MmhEeWlWTjl6UGs5bDRIcXZrYk1JWTBwanlkNGlZVUhsbVhFUFFV?=
 =?utf-8?B?T1J2Ulg1WU1kNVpnbWdWWDBIb2lqS3d0cHdibGxCdVVXYXhWSVZJOGNPSy9G?=
 =?utf-8?B?bzZ3RXU2Wmw5SVk0UUU3Rnh4dDQ2NEZKN2lSSjI4YjFBVW1vcUN0VXNERzho?=
 =?utf-8?B?VUpkS21MYStZSmJMZGV3ak5kWnNkMzg2cXQvM1NxN2J4bGxQRUZKT1pERm9w?=
 =?utf-8?B?TDIrMUhUUmZMU2dxU0hiUklTc2d0dnNNcVFUeUlRL3ZtankyWXhrYXUzcXdi?=
 =?utf-8?B?NHpwODdjM0swcDd2ZFhjTU9hUTFJSDE2eGFEeVVKV1BpaXRTamJqdytFeHUr?=
 =?utf-8?B?NHAxSTRER3k4anR3WFprLzdMNmtlWFUvaHVkdTYyY0w0WFpqTG9FbElDSkVM?=
 =?utf-8?B?TlhLVDkwTHgyNWxJYzNJNnNvZlp1Zi95SkdqdFFNWnJKdWwrbGlLYzRNaUVo?=
 =?utf-8?B?Ky9hT0N1OHVueWlFcTdQVjV3RnFrMjRpcmxhekxjQW1MR1NqQnlUbU94M2dZ?=
 =?utf-8?B?dXF1N01jWGU5S285eC82SE1GL3VWSHFjSDEvaEw2NnlnRGpnVlR3d1gyQ3dH?=
 =?utf-8?B?aWp3VVJ2eDEzWTUxWjJQWXJSbjJQWi9iOWZwbU9BTHZReHJVWnArdEdaMWJ5?=
 =?utf-8?B?LzQzT1A5Y3Y0b1VzZTl1UjZwOVBaOTE4Vml1akkxejA1RGdkT056bTJTdWlk?=
 =?utf-8?B?NEREL3hWdldkZWlvWDhsR2hZWG5VUmZUME1IVWtXUEpQMnlCMHhpUloyQkpi?=
 =?utf-8?B?VUd4OWJxTFVlQllHZ0ZiY1draEZUdUtDMTI3bFhiZllyWmV2U1VONHFrQ0Vh?=
 =?utf-8?B?Y3lTK2ltdmp5bFB4SW5ncTJ2Y3ZSWEh6clVvai8yZEhJREQrWldpSnNiWEpj?=
 =?utf-8?B?em1RZVZVL3QwaWg5RzNTTTBPYnNJMVl3bXMvQi9zYWFybHMxK0Z2MGppMDQ2?=
 =?utf-8?B?UFE1bGdrVmFxMFIvSkxqYm1uaEdLK1RiT1JZdmRXSG5KdXcwUlNJdUo3ZjQr?=
 =?utf-8?B?YndyU25TMkR5aktFKzlTblBRMllXTWphVmMzQmFtOXBmM3BXMzBBZnpNN0ph?=
 =?utf-8?B?S3FFSWZYZ1N2NXhkTUFtMDE1d2NralU3V3diMEV6dG5ZV0Y1MndWTUFQTy9j?=
 =?utf-8?B?cG9sSHZyRHpMWGZvTW5UQmpxU284RXhwZnVYcWZsZVhSdEt3eWFCRkJ1OTRp?=
 =?utf-8?B?YnVOSkh4SWU3YkpnWTN2ZmZKdHYyb1BiTXpRU0V5TUg2eEVuQzNlWm1GbUhB?=
 =?utf-8?B?Y3R6Z2dzVUlzYkpHZHNVc2dMSUUxTEtzK1hNUjllVVJlTTJmZHJIVFdkTWwr?=
 =?utf-8?B?TVVYcXVsYytQWHF6MlBGMjRUamhpYkFTbkpVNUFGc2FhN29TSGtQMXNEMkMy?=
 =?utf-8?Q?JJWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed85fd08-faa5-4ec3-c115-08db613adc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 18:22:43.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+vYJ3J9CPfjNqYCJCIlFeNvMOkq9EIs+a5QhTbBpOZPHcP2dzCPBPPPUNLWmvkUuhSX76QDv15tK4zetSP8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDI2LCAy
MDIzIDI6NTUgQU0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IEFs
ZXggRGV1Y2hlcg0KPiA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgTW9ycmlzIDxTaGl3
dS5aaGFuZ0BhbWQuY29tPjsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHRoZSBhY2NlbGVyYXRvciBwY2llIGNsYXNz
DQo+DQo+IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDA4OjUyOjA2UE0gKzAwMDAsIERldWNoZXIs
IEFsZXhhbmRlciB3cm90ZToNCj4gPiBXZSBhbHJlYWR5IGhhbmRsZSB0aGlzIHRvZGF5IGZvciBD
TEFTU19ESVNQTEFZIHZpYSBhIGRhdGEgdGFibGUgcHJvdmlkZWQgb24NCj4gb3VyIGhhcmR3YXJl
IHRoYXQgZGV0YWlscyB0aGUgY29tcG9uZW50cyBvbiB0aGUgYm9hcmQuICBUaGUgZHJpdmVyIGNh
biB0aGVuDQo+IGRldGVybWluZSB3aGV0aGVyIG9yIG5vdCB0aGF0IGNvbWJpbmF0aW9uIG9mIGNv
bXBvbmVudHMgaXMgc3VwcG9ydGVkLiAgSWYNCj4gdGhlIGRhdGEgdGFibGUgZG9lc24ndCBleGlz
dCBvciBpc27igJl0IHBhcnNlLWFibGUsIG9yIHRoZSBjb21wb25lbnRzDQo+IGVudW1lcmF0ZWQg
YXJlIG5vdCBzdXBwb3J0ZWQsIHRoZSBkcml2ZXIgZG9lc24ndCBsb2FkLg0KPg0KPiBCdXQgdGhp
bmdzIGxpa2UgbW9kdWxlIGxvYWRpbmcgYW5kIGluaXRyYW1mcyBnZW5lcmF0aW9uIHN0aWxsIHdv
cmsgb2ZmIHRoZSBJRA0KPiB0YWJsZSBhbmQgbm90IHlvdXIgaW50ZXJuYWwgdGFibGVzLg0KDQpT
dXJlLCBhbmQgZXZlcnl0aGluZyBzdGlsbCB3b3JrcyBmaW5lLiAgSWYgdGhlIGRldmljZSBpcyB0
b28gbmV3IGFuZCB0aGUgZHJpdmVyIGRvZXNuJ3QgaGF2ZSBzdXBwb3J0IGZvciBpdCwgaXQgZG9l
c24ndCBiaW5kIGFuZCByZXR1cm5zIC1FTk9ERVYgd2hlbiBpdCBwcm9iZXMgdGhlIGRldmljZS4N
Cg0KQWxleA0KDQo=

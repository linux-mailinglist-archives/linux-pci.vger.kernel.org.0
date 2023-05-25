Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37D710E32
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbjEYOVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjEYOVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 10:21:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2571189;
        Thu, 25 May 2023 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibS8Y8cb7vl/1gSMLqk5kAo60V6a5JmOkBGvWQrbH/bc3c4Ay+XlBBWGW09pAmez+C30tPVCWzR8q2IRsd4NEvir+tb67bGn1HYP/PCrtc3KLzIXQgBPEI7NQi9SwvWmP/9SGqI7knqmFjallR6kVB8u20KibKdFxAiJgdTEPy0xs5nGFa6akaQOpFQuUppRnwYZZbzI574bByVRR1yN7jOTE+ZBAPpx8U4sgm7HMuvH2I3UGiHCL12Lpdfix+E5EUqXrqObPQFyqI+lFOTlETzeRgEDehCPxN9XcZmXBvXydcnjpued7oXui+pCkzcbqoNHwktkQYRfzNDI7PM+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaBxUJVZN8WrAe5Mr6vED9DPq9DxZQt+uLE7JYzC+6c=;
 b=NdQ0gDLVKzyDiIwi6Hvl1u8vy+b7PXpygVB8njz01nrfYxOuuGH/UwbzoUpvPC4ll7heWqmuRrD/1Idoryy2XddUBQmr2KS1IjFW0zuzPHesC5D2YhWMdvaO+UXrB7XJ/HrERBvsDhvk4HbaUGK0uGWsdzDhVEH+loZanHhv7P7OvfMX79AATNLRawLLJ1LPSrsPfH2gLW2onn7bnigDhm5aSUCKBZErPkKOtToMeSzgUXbDBsuiE3+27ex4tR/fT6osgh4VBo3U3+cRVaeVxR7EFpF+o2/P3Q9xvO3Xpbqrf0DBq61ymeUEmlTgCMPlE4AQpzZsffkA1yx+l67Dxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaBxUJVZN8WrAe5Mr6vED9DPq9DxZQt+uLE7JYzC+6c=;
 b=4M9ve1vAL2vfJtsBLth2n2O4MQUoLfak05kJmGJTqE0YY81AksF4oY4Nk2f1Hyaj9PddhZ00JasRtABu5XqinguExulcDgrcZp9PoFXN6d5/PjQ5JmXUNEYmFE5bzRWW91LON0UnUM70qDO3N2PZA1VbQIA1EqW8q9r+1V1Gb3I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 14:21:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 14:21:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are power
 manageable
Thread-Topic: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are
 power manageable
Thread-Index: AQHZjnMJoz/w5LFCEk+qlsBNw2kP+a9rCdIAgAABiSA=
Date:   Thu, 25 May 2023 14:21:42 +0000
Message-ID: <MN0PR12MB610106604F8ACC3C4C4B9749E2469@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
 <20230524190726.17012-2-mario.limonciello@amd.com>
 <CAJZ5v0j8b78LWiO0UsiXvdf6jLqnQ6yLM4hRgCjyNrDncaZMZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j8b78LWiO0UsiXvdf6jLqnQ6yLM4hRgCjyNrDncaZMZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4ef46236-b0d8-4679-82e2-f53c49b59c05;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-25T14:20:59Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN2PR12MB4046:EE_
x-ms-office365-filtering-correlation-id: 621cf9f8-8df9-4503-e1e6-08db5d2b5cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoayYbcK0srkQ0gizN9pz+ghiFUkf1D1KSM/D6SDZu1qYjIuZ06IZ2bEL5G9VT1EAGQ1h0u1xwwqiAlO3ScqUo5jqTWpftqrfRsTosMde7xqivhLqPvyUUxNpQbMyHsZUIwXMuZyC2USReqz2pjfNoLgJjYq5L8JP6VOpjGmKowtD55xPqJWzwn1EIjLnaF4+/QzGjQNv4nCrDxck6hbo6ts4MkAtLAE1vq4AMNKJVsxMKBjhnQ4EkYkHevAMAiFfTONP9I74ysv4F2Ghq+pM93GPjOBIC1TecjvYsDGHgixGjMmGDsdbHo5DXt9t1fC+OGlJt5lfe6sgjcX4T0w4ikV4JJaaHeOrAF91ViUQOHHf3jJLqpvySKoA+/Rnxl3rjpOp0op61iZtqqCoRQDNRlYnTXqx2Vh65WsmoTHQv1CJ+TQEHpYWQWZu4Ezm62oE+iDz+rOJqPYj1y4BlINSa+YHJrggYtFg3B1m41PpdfOPIVO1hzDqJah9JFq6CJjNfi67Wm2fzot2Wa1YbTfvH2D0FP3mMeHvTDDvUm7vymWNP6rNN9+OgF+tqe25kbKUPkNPgyZxqa1f3tlpMKv3/adXEGMWtq71WPpd7efz94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(4326008)(33656002)(55016003)(53546011)(86362001)(8676002)(8936002)(41300700001)(6506007)(9686003)(186003)(26005)(52536014)(5660300002)(83380400001)(316002)(54906003)(76116006)(66556008)(6916009)(64756008)(966005)(66476007)(66946007)(38070700005)(66446008)(71200400001)(478600001)(122000001)(7696005)(38100700002)(66574015)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S25XbnlINlN6eldkMllObUhFZ01nREFCL3RxM0NrWXZ0VlFUNklkQnhXS1gy?=
 =?utf-8?B?NTJWU2FmT2NpVFJZVVRZdzBPZ3VtNkladkxJekxVU1ZwWHIzK1lIcEl1Y1Bm?=
 =?utf-8?B?UGVGM3FCS2Y2SFdhZm5LRlQrRkxET05DM1VpMWdjYmdIWkIrSjdZajg4QnhU?=
 =?utf-8?B?cytDNDF4MGlVUXFzbjBYcEpGaUtZQUVveDRON3pOMXVzVmVORlNZbnBNUU5Y?=
 =?utf-8?B?OVdXdUtPUHFnNnZONHJ6SHR6TVFaZkkwSVdmbEoxeUcra1pnNkNFa25vaTF3?=
 =?utf-8?B?aTE2eTk5NFJlU2daV01DVmZ5Vy9SMXVFTG9KYW5yNkNBTGtBNnRhTHhkMmZH?=
 =?utf-8?B?bnJncUJOMUxIa0RPbXEzOWpBekR4WFBKVCtEVzZiSWErTmdXMEVSVFFvcFZ2?=
 =?utf-8?B?OFloTmdKckExMExLdTlRNjhFVzRFQ2hPTlpYOERhS2paWmFXUGhpYzR1NDlQ?=
 =?utf-8?B?VDMxNGxjeDJ0cTAyM0Yzb2tzNWxMbis0Q2FpYXFQNnVPajJtVysvUDRXMlkv?=
 =?utf-8?B?Z2U2Q0NmRmEvclRpNHMwUXV3bXMrMHFNMXFncitxTDlIQzNGWFBVRHd2QnND?=
 =?utf-8?B?UEpTZ0lRK09Wb0tHcXF3VnpBditveXZjbnNVczZabUVudFUrdTEvdVBLTGx3?=
 =?utf-8?B?OHVVOGVKeVJ2NEdQeGpsdk9mc0ljeTVxTFRveG5rVzh0TXBsSnM0YmYyeG1z?=
 =?utf-8?B?OGkweWlUa05GcEVRS0FzZmhwRDBBQVgrU3l3bmU5cm1UdWcvRjQ2VWdTZjlI?=
 =?utf-8?B?TFJ0NldkOTZUa3Ixc3hhMy9IZ0lqd3d4MmgrYm5jR1M4a2h3WDgxSmJqbWdO?=
 =?utf-8?B?czZSMDhEQ1hHZHc2bi80ZU5KcCs5a1lxV3lmcDJGUnlPd2NkNThWWG5ZVThU?=
 =?utf-8?B?Z0IxZVpRdFVBd3V1ODFOSXo4V3pkcStXMjNRS2VVU0NNSGZqN3hsTm5pd244?=
 =?utf-8?B?eFlUZVBrTlIwb21HMmQ0SjdVSUllaXZOWkxMYlA0N0M3QjBjWFM0TUpTVkhC?=
 =?utf-8?B?VG9mSzlxVHB4a3dBNzJTVFQvRndjdmsxeUZlUTV3SXBsVW1jR0NsdWJ6ZWx2?=
 =?utf-8?B?Y2NQMEZVdHlVWGhIVW5yTUJVTXhxM3l2VnAxVE5zQWE2ZDJySEJEZGtkaTZv?=
 =?utf-8?B?SUJ4bFVxVDJ2TmVLMjhtWU14M25iMWY3Y2M4a24zM1lZSHpEaVZOejNIU2dG?=
 =?utf-8?B?eWFqTWZqa3ZweG0rQmQ0eVZzbm55d0FMMmppUk5HWTh2bXhNNVZGeU1oM0dt?=
 =?utf-8?B?b2plbk00NFM1Z01IdTQ5SEdEWWMwQTNwT1dhTXVVRHBjVmJnb0czY3RJa2VS?=
 =?utf-8?B?RVczNmFXQWdIa2JlcmJaOTJpRmNQKzlhWWM5VzErVjVFN1VOMTQ5NVNFeE41?=
 =?utf-8?B?amJUR2Y5Y01ITVZvdWpOdHV5bjVHZG5DRG91b3NrSDRvSXVwc21IOHoydmI5?=
 =?utf-8?B?aCtOS1ZScm1hc2RRdXBFYkNkMEFUZHVaREJWQ1BXMVgzUzU5dTF0SW1hendY?=
 =?utf-8?B?cnl2bGVyV3p4bVBCNVJDWGR6czZqUXlwRzlZcVgxc0JtMUYwNS8zSnRMaEQx?=
 =?utf-8?B?ZU51NE95V3hlRHRnQko5YnhFMWoxcTdxdnZFRGFlTFFvUW1hSEd2czgyMGFB?=
 =?utf-8?B?a0dzd1RBejQxVGlKYWxPN0daSktUcllXSGZYSzZQL3pPUjZpT3FTQmlhY1d6?=
 =?utf-8?B?dGUxVXlkNW9OcENTbThpY1VwZXVNTVpjMnpZeXViNTRsa3ZYNjZMczdpODY3?=
 =?utf-8?B?bUg5ek5xUjlJVUc2cUVwd1BueVRDd0RmQWpqU1dZOXJGZmw5RUxqdk1pUWhP?=
 =?utf-8?B?OCtzaURJUnZnc1NTQ2ZmMDlseFVBTTF3NmxNRFNXZ0lNMkJOQ3dFWUR4MUQ4?=
 =?utf-8?B?N0Q1OEhXRHR4ZmdyWFRpdnlKeStEYTN6WnpzcGpBc2g0THNnVi9POEVPN2RJ?=
 =?utf-8?B?eHFmQlhFMkYzdUZ5eVNOSDJwaVg0N3hUelJPd2VFK3ZIS0NUTlhaMEFjUGxs?=
 =?utf-8?B?YkRIZUkzQmlZZWFKNjRpNUJ5azFmd2REZ1UvWGh1S2dvZ3FpcHJOR0hIRHlN?=
 =?utf-8?B?TTM4eC9TdDBiVm81RGRuUG0wbmJiU1pUT1J2RXBJVUZ6eFIya1lmYVBuQVUz?=
 =?utf-8?Q?Xkdc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621cf9f8-8df9-4503-e1e6-08db5d2b5cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 14:21:42.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBt2vljEfvk/o3qwrEZygbb3lLjSYTemtCHG5+2aVKB9cIACJuUqAxy2fzdGffsDKZCx+K3Mipya2HZqxys4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgTWF5IDI1LCAyMDIzIDk6MTYgQU0NCj4gVG86IExpbW9uY2llbGxv
LCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMg
PGJoZWxnYWFzQGdvb2dsZS5jb20+OyBNaWthIFdlc3RlcmJlcmcNCj4gPG1pa2Eud2VzdGVyYmVy
Z0BsaW51eC5pbnRlbC5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3Jn
PjsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgUy1rLCBTaHlhbS1zdW5kYXINCj4gPFNoeWFtLXN1bmRhci5TLWtAYW1kLmNvbT47IE5h
dGlrYXIsIEJhc2F2YXJhag0KPiA8QmFzYXZhcmFqLk5hdGlrYXJAYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsgTHVrYXMgV3VubmVyDQo+IDxsdWthc0B3dW5uZXIuZGU+OyBJYWluIExhbmUg
PGlhaW5Ab3Jhbmdlc3F1YXNoLm9yZy51az4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzJd
IFBDSTogRG9uJ3QgYXNzdW1lIHJvb3QgcG9ydHMgZnJvbSA+IDIwMTUgYXJlDQo+IHBvd2VyIG1h
bmFnZWFibGUNCj4NCj4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgOTowN+KAr1BNIE1hcmlvIExp
bW9uY2llbGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+
IFVzaW5nIGEgVVNCIGtleWJvYXJkIG9yIG1vdXNlIHRvIHdha2V1cCB0aGUgc3lzdGVtIGZyb20g
czJpZGxlIGZhaWxzIHdoZW4NCj4gPiB0aGF0IFhIQ0kgZGV2aWNlIGlzIGNvbm5lY3RlZCB0byBh
IFVTQi1DIHBvcnQgZm9yIGFuIEFNRCBVU0I0IHJvdXRlci4NCj4gPg0KPiA+IER1ZSB0byBjb21t
aXQgOWQyNmQzYThmMWIwICgiUENJOiBQdXQgUENJZSBwb3J0cyBpbnRvIEQzIGR1cmluZw0KPiBz
dXNwZW5kIikNCj4gPiBhbGwgUENJZSBwb3J0cyBnbyBpbnRvIEQzIGR1cmluZyBzMmlkbGUuDQo+
ID4NCj4gPiBXaGVuIHNwZWNpZmljIHJvb3QgcG9ydHMgYXJlIHB1dCBpbnRvIEQzIG92ZXIgczJp
ZGxlIG9uIHNvbWUgQU1EIHBsYXRmb3Jtcw0KPiA+IGl0IGlzIG5vdCBwb3NzaWJsZSBmb3IgdGhl
IHBsYXRmb3JtIHRvIHByb3Blcmx5IGlkZW50aWZ5IHdha2V1cCBzb3VyY2VzLg0KPiA+IFRoaXMg
aGFwcGVucyB3aGV0aGVyIHRoZSByb290IHBvcnQgZ29lcyBpbnRvIEQzaG90IG9yIEQzY29sZC4N
Cj4gPg0KPiA+IENvbXBhcmluZyByZWdpc3RlcnMgYmV0d2VlbiBMaW51eCBhbmQgV2luZG93cyAx
MSB0aGlzIGJlaGF2aW9yIHRvIHB1dA0KPiA+IHRoZXNlIHNwZWNpZmljIHJvb3QgcG9ydHMgaW50
byBEMyBhdCBzdXNwZW5kIGlzIHVuaXF1ZSB0byBMaW51eC4gT24gYW4NCj4gPiBhZmZlY3RlZCBz
eXN0ZW0gV2luZG93cyBkb2VzIG5vdCBwdXQgdGhvc2Ugc3BlY2lmaWMgcm9vdCBwb3J0cyBpbnRv
IEQzDQo+ID4gb3ZlciBNb2Rlcm4gU3RhbmRieS4NCj4gPg0KPiA+IFdpbmRvd3MgZG9lc24ndCBw
dXQgdGhlIHJvb3QgcG9ydHMgaW50byBEMyBiZWNhdXNlIHJvb3QgcG9ydHMgYXJlIG5vdA0KPiA+
IHBvd2VyIG1hbmFnZWFibGUuDQo+ID4NCj4gPiBMaW51eCBzaG91bGRuJ3QgYXNzdW1lIHJvb3Qg
cG9ydHMgc3VwcG9ydCBEMyBqdXN0IGJlY2F1c2UgdGhleSdyZSBvbiBhDQo+ID4gbWFjaGluZSBu
ZXdlciB0aGFuIDIwMTUsIHRoZSBwb3J0cyBzaG91bGQgYWxzbyBiZSBkZWVtZWQgcG93ZXINCj4g
bWFuYWdlYWJsZS4NCj4gPiBBZGQgYW4gZXh0cmEgY2hlY2sgZXhwbGljaXRseSBmb3Igcm9vdCBw
b3J0cyB0byBlbnN1cmUgRDMgaXNuJ3Qgc2VsZWN0ZWQNCj4gPiBmb3IgdGhlc2UgcG9ydHMuDQo+
DQo+ICJEMyBpc24ndCBzZWxlY3RlZCBmb3IgdGhlbSBpZiB0aGV5IGFyZSBub3QgcG93ZXItbWFu
YWdlYWJsZSB0aHJvdWdoDQo+IHBsYXRmb3JtIGZpcm13YXJlLiIgIE9yIHNpbWlsYXIuDQo+DQo+
IFdpdGggdGhpcyBhZGRyZXNzZWQ6DQo+DQo+IEFja2VkLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQoNClRoYW5rcyENCg0KSWYgbm8gb3RoZXIgb3Bwb3NpdGlvbnMs
ICBCam9ybiwgbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gcmVzcGluIGZvcg0KdGhpcyBv
ciB5b3UgY2FuIG1hc3NhZ2UgY29tbWl0IG1lc3NhZ2UgeW91cnNlbGYuDQoNCj4NCj4gPg0KPiA+
IEZpeGVzOiA5ZDI2ZDNhOGYxYjAgKCJQQ0k6IFB1dCBQQ0llIHBvcnRzIGludG8gRDMgZHVyaW5n
IHN1c3BlbmQiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBJYWluIExhbmUgPGlhaW5Ab3Jhbmdlc3F1YXNo
Lm9yZy51az4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vZm9ydW1zLmxlbm92by5jb20vdDUvVWJ1bnR1
L1oxMy1jYW4tdC1yZXN1bWUtZnJvbS0NCj4gc3VzcGVuZC13aXRoLWV4dGVybmFsLVVTQi1rZXli
b2FyZC9tLXAvNTIxNzEyMQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IHYzLT52NDoNCj4gPiAgKiBN
b3ZlIGFmdGVyIHJlZmFjdG9yDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3BjaS5jIHwgOCAr
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiA+IGlu
ZGV4IGQxZmEwNDBiY2VhNy4uZDI5M2RiOTYzMzI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL3BjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiBAQCAtMzAxNSw2ICsz
MDE1LDE0IEBAIGJvb2wgcGNpX2JyaWRnZV9kM19wb3NzaWJsZShzdHJ1Y3QgcGNpX2Rldg0KPiAq
YnJpZGdlKQ0KPiA+ICAgICAgICAgaWYgKGRtaV9jaGVja19zeXN0ZW0oYnJpZGdlX2QzX2JsYWNr
bGlzdCkpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPg0KPiA+ICsgICAg
ICAgLyoNCj4gPiArICAgICAgICAqIEl0J3Mgbm90IHNhZmUgdG8gcHV0IHJvb3QgcG9ydHMgdGhh
dCBkb24ndCBzdXBwb3J0IHBvd2VyDQo+ID4gKyAgICAgICAgKiBtYW5hZ2VtZW50IGludG8gRDMu
DQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIGlmIChwY2lfcGNpZV90eXBlKGJyaWRnZSkg
PT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCAmJg0KPiA+ICsgICAgICAgICAgICFwbGF0Zm9ybV9w
Y2lfcG93ZXJfbWFuYWdlYWJsZShicmlkZ2UpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ID4gKw0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIEl0IHNob3VsZCBi
ZSBzYWZlIHRvIHB1dCBQQ0llIHBvcnRzIGZyb20gMjAxNSBvciBuZXdlcg0KPiA+ICAgICAgICAg
ICogdG8gRDMuDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K

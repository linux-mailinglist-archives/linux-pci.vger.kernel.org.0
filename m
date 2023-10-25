Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62C7D729B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJYRsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJYRsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:48:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2734CC
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 10:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdnZWYfvTFNcrJZnnisLrptrW5EdGHRSRgRhLJexaiIEZ1oA/Eer+GqQIWCJO93RklOIKs/tA7ViZA0AQ6Z+NgaG9D90A2W5exGVYV5y1Qa2Q2SnoI1CrxGMazLYrYwzeBCM5n+9HLr7+WNc3JiIg1zWpl5lI7IV6khv4lwNJ4D+HlYv7T+v4PhDPr4JEx53hawu1PjFASpWX0rAXKGRZ7ddVWPctXQ8EeblQorW5Y0VR53ChsT22r8ekgT2x3Q034YT5nEG8TVuGhYxBKz9bGffvjC/0b/MmEU6e6LX82L8vfRRs4XCCK5dCe3S/Ok6GbcpQxh3Gj+3jw/LQi72bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25GkRoQhCYy/dmydqoPGVxVBTVzxo/FIIUD9VlYRaiE=;
 b=mrwmiU6sIhUiGoWVIkqM/GNLvAYzIajJVgXOpl5XduXlN7Xz+OH7jJiK5IDqHQ4j7gnhKD0kuY7PKQi7dUBTOjZB9gWeR2NQA2b7dcEQCZain5+eMDPXnRhaqhtr5muldwVhI/Dqbdw+v99S6A+YhFbAuCunQ1nWzDPddIXHT9ZOjxituFnU5KPwtghoGzD464wqOwQkyvUCelEtkUdDLmF42Mh9wnd8BC94TjhJ1OyPcZZFNXmbdk3IXTS5VfkULBcwrcddx5bIuI0XXFWghbOFpqGElHdTpmFvLq82JuCYbS45G/BVmvW+OkoijWI0VFVuLBlrBCwn/GzsNEHTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25GkRoQhCYy/dmydqoPGVxVBTVzxo/FIIUD9VlYRaiE=;
 b=vWZCIdHTIBAajsg1p/MOdmcgkvSOuEtWU5adxrG91wC+zd6Es4HlXoSidW0f+2u2FeLTBpwz1MF+l4IHbeEEZf6ODN+Y3WFeTaiZ8JUxsvuHphA4Jv7AI9ZnTmDl/uxEG/FxNyw9rzTtFEyJEnmqUFJlyGbsquPHKkFlCnYpB9Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 25 Oct
 2023 17:47:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 17:47:57 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Simon Richter <sjr@debian.org>,
        "1015871@bugs.debian.org" <1015871@bugs.debian.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
Subject: RE: Enabling PCI_P2PDMA for distro kernels?
Thread-Topic: Enabling PCI_P2PDMA for distro kernels?
Thread-Index: AQHaBwtARTHS5In6uk+UhR87A9HuJLBasvGAgAASLtA=
Date:   Wed, 25 Oct 2023 17:47:57 +0000
Message-ID: <BL1PR12MB5144D678865044E974C769F7F7DEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
 <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
In-Reply-To: <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1c1784ab-cfb1-4810-9c4f-1fe0ab411e65;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-25T17:35:24Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB9060:EE_
x-ms-office365-filtering-correlation-id: 8e34be9e-7955-4998-1479-08dbd5828659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gu0IFbUvgqryw+bDq2jzyw4TojxVwgByc2BEXgdPqiurRD+1vXYPWDeDQpiPxLSuAvOIZi7lSvhXXp4VAHnQCkSMbE2HhpufBdvqAi3C98N65MM53hSRLryfXhXHSqb/frj9deUL6kIVIGhZpnwhlb2b8C2y3QOBcJZEGKojnBYOzeowqvbLrLmVumaU/TdlgC2JmHcoIpXpgjqJJwdm9iddufFNgwTP4oGCqMvsLcyL9qvBK+/VZWkSFtgbmMKvKmsUU7H7P3E+Y1oiGpFdIH79Wj+bgxVXF2noh7x2ZfF2iJHaUA9yFmPKNNXyZAmLKtwBsLfmoC+JlZvGN3qO3MMwq26mU/Fr9hmM5/jg/OlBQ4JRk7zC8d8YdCeEmQq7EuSJLwTN5kRhueEAxPa0yrunW+hnv7Tro4v1/JW2mDoXQ+V/XndksqXMhl7OZ4gnXuD5NZFKpg/IVMnlB0Nc9Y+eHwibnmsx9AUQWCGlsgDy+3VjyBSX990Zn3CjtblTWLleGhdgZOwWtD6sxDOoWMGnz/MwteK1YtD8qio8oKKS94pOOGeVel+4UTJqj2+/RxPVdl4rPRu6HxFi/3xCBZL27l7INWc2i9Bu5KNzDb0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(4001150100001)(2906002)(55016003)(5660300002)(8936002)(9686003)(4326008)(8676002)(64756008)(52536014)(316002)(41300700001)(66556008)(110136005)(66946007)(478600001)(54906003)(26005)(33656002)(6506007)(66446008)(7696005)(71200400001)(86362001)(76116006)(38100700002)(66476007)(53546011)(83380400001)(66574015)(966005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2V1a2MzdFptNVdtMnh0Ukc1dTlpaFFWUkE1ZDVIWFlGcGJES1dwRGU4a1JU?=
 =?utf-8?B?SWZuZlZjOS9QTHFRUERUbmlxYmpZbWwzZTUrUy9DdG16Rm1PU3pKVWxGWnVp?=
 =?utf-8?B?M1FLekpwL1J4T1lkR2ZaT0hYcnlyWjNWa2pBL1cxNm5TSi95TFNzZDFKLy9V?=
 =?utf-8?B?QU9LMkEyaVI1eWgwSi9UTDBkdEpSdzFyVlp6Y1FscXg4cnZPVUp3ek9tOVY3?=
 =?utf-8?B?Q2ZmWDRiNVVlOXFuUGJ2NHdqSVFrdjBGL2cyWjR2NW5lWEN0K1RPbXJuWnpx?=
 =?utf-8?B?OXVWOUVMNnpucXRaMHdpVC9TcGdZNnZQQmphVW5WbTdVcml1ekVqU1h5SEJR?=
 =?utf-8?B?OVdxSG5BSmZMSThNWEc1bkpPMDQxNkg0TmlaeS9OWTNXVkhRT29kWjA0b1Vl?=
 =?utf-8?B?Qi9GRjEzTFY4aDBnTmo3MkVmek5qRjJXbmFTNnBpWFYxN05zb2hsM0NyaDYv?=
 =?utf-8?B?SDkrN3lCWmFMdCtqZGNabzhheERzV2hqR1dON3NSNSsrUVBwbVJBbWU3T1ZF?=
 =?utf-8?B?RERyK08yREJjaFNVY3B3WFovaU4rd0JBZURrQlR5N29yeTdjams4V1Z5WCtB?=
 =?utf-8?B?RmtzQ2lCNHNLUkNVMzhaT3Jvc1JHZGVyRXA1SWJTMVVPdzZmS2hTb3lYK1gw?=
 =?utf-8?B?R05vRHkzUGxJOVpNbXh4dVdKQ0RhN1ZHQXRyaUZmUjNlMktNemJDeTRqcDJ1?=
 =?utf-8?B?SGQrS01pSU5wMmgxWk8zZmlaamZEVVFjYmtjbmYyd0ZxQ0dmcXpaOGE5allR?=
 =?utf-8?B?S3BGZXQ5RG11dXphTU1QeEN4UWYyQmhxM1FuOGltSTBXUXUzU1NRUC9pWTAx?=
 =?utf-8?B?YWdNbW9FZVBodmU0OVd5QlppeVlQeUM1dWwxL1R1ZnJnK3BkT2VYbHRRL2Zy?=
 =?utf-8?B?UDVkekk3R2pWaXFLNjBLd2lIWFV6RzhMZjdXRDVxY3VUQ0pPZ3dtbFluOEpQ?=
 =?utf-8?B?WmpIb2JqWmF5blhRYjBGWlZYdXFhUnFMVUppOUwxeXRmakhpRWUxVWRVc2h4?=
 =?utf-8?B?WS92REJrTzhIbVlKUzRPVHZpRlhjeTl2YzcvMUdsUkJwL3hvaTFkQjlZaHJp?=
 =?utf-8?B?aHVmaXIybE9lNkpZZjdjVHM4Nzh0WjB3d3NjaVR5NFBHQ0hYN1JsZDM5Y2pM?=
 =?utf-8?B?a0NocU9Dck5lU2Zoa0tWMzNOZ2tGOFh5a2Q0Y1RkN3loNzdtU2ZuTUZCcG1X?=
 =?utf-8?B?RE1VTExUWUxHT3QrUWZzSWNtb042YjJhUU9jbjRVM05yeXZZUjhYYmtpa3Q2?=
 =?utf-8?B?ekNuaFVIbTVpNkNTVXNRUXZNRlQ0QjJkVnVkMzhGU2h1VFF3WFpiai9GU0Rj?=
 =?utf-8?B?TGhyVE9kaUpwb3BET0J4Tm9rSmp5WDJMYXZHUm4xMm1PNGVzL2lZRHRQbzVX?=
 =?utf-8?B?dWliWUROdVZHb1lJK2UrMmpjeTNOK2lsZ0pXcFhudTg0YkpBZTAxKzBtOG5E?=
 =?utf-8?B?ejRZRVlubjFUM2dKOGNuSTI5SDhycFpaUm1IVkNMbFBPNEl2aGRmcVFCWC9W?=
 =?utf-8?B?ajhFdEF5WjZjNzU0VGQwOXZDUXRCNERJMUIvbGRIc1JYVFUyZFQ0WnRCdjlZ?=
 =?utf-8?B?NElGSTJtVFpmZUZCRkdRa3Y0U0hOQ0ZvMTVJNldJRWtGWmJqT0lqbkdRNDkw?=
 =?utf-8?B?Vzl6VGJZd0VidEkraEtNbGN0b2JwZHhZbXZCczJ1TVU1d05FVjdXYkRuRkM2?=
 =?utf-8?B?cTV1UE9jbTEvQ0huMEQyaVE1bVg5bnl6dHd6YjlESHFjZlFHWEVBVUNsUnUv?=
 =?utf-8?B?SDh6R2pxbXltbFJUVXdmRjBDYXVlTWtpTDFjTjArcGlaUXRPNFF5ai9Jd3pC?=
 =?utf-8?B?YjBoRmdkWHJpM3AxSEpNd2EyYkp4R2lEbktkUFBlZmExaXk0MGlDd2FTWlE2?=
 =?utf-8?B?WkpmMVc0OFljZFNhLzVvT2NIc0UvQlFGVUNrOVJ3RzgwOWpXK1lqTE0vU3Rr?=
 =?utf-8?B?UXVVdVJzWHZUK0hRUm1MRVZJQjZNWnI4eW5XNytCTVU3V0l5bUxocVRWNGpP?=
 =?utf-8?B?bVFkTlloVFlRNnFiUS9pODFSL2E4ZDNVRkFVVkRneW9TbVoyUHQxb1JUTU40?=
 =?utf-8?B?ckNiWC82ZGZkOWpiNksrZVppbkhWcDM5NkVjWUovc25CRjVVUUhXbU5nOGpu?=
 =?utf-8?Q?b6ic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e34be9e-7955-4998-1479-08dbd5828659
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 17:47:57.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynMigkCdWelI3cD+SyKOHsUOVYAkkl5fhCF5PiopvyFb8gcnNiD/6enYy9ig1r5M/zJ6yzunBqFpZYnPt++8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBH
dW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2Jl
ciAyNSwgMjAyMyAxMjozMCBQTQ0KPiBUbzogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtv
ZW5pZ0BwZW5ndXRyb25peC5kZT47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5j
b20+DQo+IENjOiBTaW1vbiBSaWNodGVyIDxzanJAZGViaWFuLm9yZz47IDEwMTU4NzFAYnVncy5k
ZWJpYW4ub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsNCj4gS3J6eXN6dG9mIFdpbGN6ecWEc2tp
IDxrd0BsaW51eC5jb20+OyBFbWFudWVsZSBSb2NjYSA8ZW1hQGRlYmlhbi5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBFbmFibGluZyBQQ0lfUDJQRE1BIGZvciBkaXN0cm8ga2VybmVscz8NCj4NCj4NCj4N
Cj4gT24gMjAyMy0xMC0yNSAwMDoxOSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+ID4gSGVs
bG8sDQo+ID4NCj4gPiBpbiBodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMDE1ODcxIHRoZSBEZWJp
YW4ga2VybmVsIHRlYW0gZ290IGENCj4gPiByZXF1ZXN0IHRvIGVuYWJsZSBQQ0lfUDJQRE1BLiBH
aXZlbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGZlYXR1cmUgYW5kDQo+ID4gYWxzbyB0aGUgIklm
IHVuc3VyZSwgc2F5IE4uIiBJIHdvbmRlciBpZiB5b3UgY29uc2lkZXIgaXQgc2FmZSB0bw0KPiA+
IGVuYWJsZSB0aGlzIG9wdGlvbi4NCj4NCj4gSSBkb24ndCBrbm93LiBOb3QgYmVpbmcgYSBzZWN1
cml0eSBleHBlcnQsIEknZCBzYXkgdGhlIGF0dGFjayBzdXJmYWNlIGV4cG9zZWQgaXMNCj4gZmFp
cmx5IG1pbmltYWwuIE1vc3Qgb2Ygd2hhdCBnb2VzIG9uIGlzIGludGVybmFsIHRvIHRoZSBrZXJu
ZWwuIFNvIHRoZSBtYWluIHJpc2sNCj4gaXMgdGhlIHNhbWUgcm91Z2ggcmlzayB0aGF0IGdvZXMg
d2l0aCBlbmFibGluZyBhbnkgZmVhdHVyZTogdGhlcmUgbWF5IGJlIGJ1Z3MuDQo+DQo+IE15IG9w
aW5pb24gaXMgdGhhdCAnTm8nIGlzIHJlY29tbWVuZGVkIGJlY2F1c2UgdGhlIGZlYXR1cmUgaXMg
c3RpbGwgdmVyeQ0KPiBuYXNjZW50IGFuZCBhZHZhbmNlZC4gUmlnaHQgbm93IGl0IGVuYWJsZXMg
dHdvIHVzZXIgdmlzaWJsZSBuaWNoZQ0KPiBmZWF0dXJlczogcDJwIHRyYW5zZmVycyBpbiBudm1l
LXRhcmdldCBiZXR3ZWVuIGFuIE5WTWUgZGV2aWNlIGFuZCBhbg0KPiBSRE1BIE5JQyBhbmQgdHJh
bnNmZXJyaW5nIGJ1ZmZlcnMgYmV0d2VlbiB0d28gTlZNZSBkZXZpY2VzIHRocm91Z2ggdGhlDQo+
IENNQiB2aWEgT19ESVJFQ1QuIEJvdGggdXNlcyByZXF1aXJlIGFuIE5WTWUgZGV2aWNlIHdpdGgg
Q01CIG1lbW9yeSwNCj4gd2hpY2ggaXMgcmFyZS4NCj4NCj4gQW55b25lIHVzaW5nIHRoaXMgb3B0
aW9uIHRvIGRvIEdQVSBQMlBETUEgdHJhbnNmZXJzIGFyZSBjZXJ0YWlubHkgdXNpbmcgb3V0DQo+
IG9mIHRyZWUgKGFuZCBsaWtlbHkgcHJvcHJpZXRhcnkpIG1vZHVsZXMgYXMgdGhlIHVwc3RyZWFt
IGtlcm5lbCBkb2VzIG5vdCB5ZXQNCj4gYXBwZWFyIHRvIHN1cHBvcnQgYW55dGhpbmcgbGlrZSB0
aGF0IGF0IHRoaXMgdGltZS4gVGh1cyBpdCdzIG5vdCBjbGVhciBob3cgc3VjaA0KPiBjb2RlIGlz
IHVzaW5nIHRoZSBQMlBETUEgc3Vic3lzdGVtIG9yIHdoYXQgaW1wbGljYXRpb25zIHRoZXJlIG1h
eSBiZS4NCj4NCg0KQU1EIEdQVXMgY2FuIHVzZSBQMlBETUEgZm9yIHJlc291cmNlIHNoYXJpbmcg
YmV0d2VlbiBHUFVzIHVzaW5nIHVwc3RyZWFtIGtlcm5lbHMgYW5kIG1lc2EgYW5kIGFsc28gUk9D
bS4gIEUuZy4sIGlmIHlvdSBoYXZlIG11bHRpcGxlIEdQVXMgaW4gYSBzeXN0ZW0geW91IGNhbiBy
ZW5kZXIgb24gb25lIGFuZCBkaXNwbGF5IG9uIHRoZSBvdGhlciB3aXRob3V0IGFuIGV4dHJhIHRy
aXAgdGhyb3VnaCBzeXN0ZW0gbWVtb3J5LiAgVGhpcyBpcyBjb21tb24gb24gbGFwdG9wcyBhbmQg
ZGVza3RvcHMgd2l0aCBtdWx0aXBsZSBHUFVzLiAgRW5hYmxpbmcgUDJQRE1BIHByb3ZpZGVzIGEg
bmljZSBwZXJmIGJvb3N0IG9uIHRoZXNlIHN5c3RlbXMgZHVlIHRvIHJlZHVjZWQgY29waWVzLiAg
T3Igd2l0aCBST0NtLCBHUFVzIGNhbiBkaXJlY3RseSBhY2Nlc3MgbG9jYWwgbWVtb3J5IG9uIG90
aGVyIEdQVXMuICBJdCdzIGFsc28gcG9zc2libGUgYmV0d2VlbiBhdCBsZWFzdCBBTUQgR1BVcyBh
bmQgc29tZSBSRE1BIE5JQ3MuICBUaGVyZSBhcmUgYWxzbyBhIGxvdCBvZiB1c2UgY2FzZXMgZm9y
IFAyUERNQSBiZXR3ZWVuIGRldmljZXMgYW5kIE5WTUUgZGV2aWNlcywgYnV0IGR1ZSB0byBkaWZm
ZXJlbmNlcyBpbiBtZW1vcnkgc2hhcmluZyBBUElzIHRoZXJlIGlzIG5vIHNpbXBsZSBwYXRoIHRv
IG1vdmUgZm9yd2FyZCBoZXJlLiAgSSB0aGluayBpdCdzIHNvbWV0aGluZyBpcyBhIGNoaWNrZW4g
YW5kIGFuIGVnZyBwcm9ibGVtIGZvciB3aWRlciBhZG9wdGlvbi4NCg0KDQo+IEl0J3Mgbm90IGNv
bW1vbmx5IHRoZSBjYXNlIHRoYXQgdXNpbmcgdGhlc2UgZmVhdHVyZXMgaW5jcmVhc2VzIHRocm91
Z2hwdXQgYXMNCj4gQ01CIG1lbW9yeSBpcyB1c3VhbGx5IG11Y2ggc2xvd2VyIHRoYW4gc3lzdGVt
IG1lbW9yeS4gSXQncyB1c2UgbWFrZXMNCj4gbW9yZSBzZW5zZSBpbiBzbWFsbGVyL2NoZWFwZXIg
Ym91dGlxdWUgc3lzdGVtcyB3aGVyZSB0aGUgc3lzdGVtIG1lbW9yeQ0KPiBvciBidXMgYmFuZHdp
ZHRoIHRvIHRoZSBDUFUgaXMgbGltaXRlZC4gVHlwaWNhbGx5IHdpdGggYSBQQ0llIHN3aXRjaCBp
bnZvbHZlZC4NCj4NCj4gSW4gYWRkaXRpb24gdG8gdGhlIGFib3ZlLCBQMlBETUEgdHJhbnNmZXJz
IGFyZSBvbmx5IGFsbG93ZWQgYnkgdGhlIGtlcm5lbCBmb3INCj4gdHJhZmZpYyB0aGF0IGZsb3dz
IHRocm91Z2ggY2VydGFpbiBob3N0IGJyaWRnZXMgdGhhdCBhcmUga25vd24gdG8gd29yay4gRm9y
DQo+IEFNRCwgYWxsIG1vZGVybiBDUFVzIGFyZSBvbiB0aGlzIGxpc3QsIGJ1dCBmb3IgSW50ZWws
IHRoZSBsaXN0IGlzIHZlcnkgcGF0Y2h5Lg0KPiBXaGVuIHVzaW5nIGEgUENJZSBzd2l0Y2ggKGFs
c28gdW5jb21tb24pIHRoaXMgcmVzdHJpY3Rpb24gaXMgbm90IHByZXNlbnQNCj4gc2VlaW5nIHRo
ZSB0cmFmZmljIGNhbiBhdm9pZCB0aGUgaG9zdCBicmlkZ2UuDQoNClRoZSBvbGRlciBwcmUtWmVu
IEFNRCBDUFVzIHN1cHBvcnQgaXQgdG9vLCBidXQgb25seSBmb3Igd3JpdGVzLg0KDQpBbGV4DQoN
Cj4NCj4gVGh1cywgbXkgY29udGVudGlvbiBpcyBhbnlvbmUgZXhwZXJpbWVudGluZyB3aXRoIHRo
aXMgc3R1ZmYgb3VnaHQgdG8gYmUNCj4gY2FwYWJsZSBvZiBpbnN0YWxsaW5nIGEgY3VzdG9tIGtl
cm5lbCB3aXRoIHRoZSBmZWF0dXJlIGVuYWJsZWQuDQo+DQo+IExvZ2FuDQo=

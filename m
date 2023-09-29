Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6562B7B3A5A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjI2TDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2TDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 15:03:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4BA1A4
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 12:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM3Yc/Smx2SvsTfljkn00KomzztVMYVGbmu5u1hoD3A4Hzlz1nfMJ+/SPV0Dg6g1qlqJUbMVvpuKyFWj9iLDZjUgWiNwKdzAs+IyGdR7zNF2HZXfdN1u7SzKCk8krRInPyYSKgrMNZCoWB1KQ7h1Lgr4s1ilr3E1JZ2UHP/qz314P1P8Zn4eqwKCGePg5foD5jREyTAGkVX4dOQy6W/pKzF8XncVw5IKqdKnVG1JJXyA3OkSMODuNVx3jbwTHPmGjgE7g+7WmuGWT7ht+BQ17S2aeIW1lxPvc8HqWn48wVhgn0h+vsvLKFlDhRT6M2+fWp9bJ/gkJvyWc102zbsftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hak3UMBjFDd630i5K8uJFrLAKhEAI38tXALP6QC0O3Q=;
 b=LUwvRz6zjlOw0xUNiN1EoTCLe1OosqAMuAN+hNIkrA65qN617wRsCaaTcQycnTzuV4Db4NeZBApp3M1DsybRfzLdYcXQTWR8JNgapbeA+c1rCHjb7wE6Ft1p/mwnIS/GC7UPsvRpSqT0bwLsk3J+WECYq5q569sUy3FHWmPOpxWR7kDQrveCPUzSwDH/BDZu3rmCbEgLQiiJyZ5pR1QKOeEoUMoezqkr6EhrEjp5/xGLyCzZnADUXqYEdFHfkA6M12NDnioiM82N5fZ4j6VqWuLCM0JId+BbHE/YbzXDlWBGry092hu5+RTix78Am+JY7KZwuRF7wArFmTSgPCJ9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hak3UMBjFDd630i5K8uJFrLAKhEAI38tXALP6QC0O3Q=;
 b=ead4rEWvw5ZQOlvn72xxyEQYqVILhdoEw6RvQ5QFahs5onbNDlaSEWn7iFxQrZ777KK2Cith470cgeZ6+yG5sw7ir87lGdL6TWtM0KePk6c645lBoIBxxK0hO0GOqwSr2nsgwqdvmzdIfRPiP7eenkQJYhtnyEfmuPbvqLyZ7Js=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 29 Sep
 2023 19:03:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 19:03:46 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Thread-Topic: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Thread-Index: AQHZ8lw5kXUD56kAMEKSBt9P8oQEx7AxOneAgADvwCA=
Date:   Fri, 29 Sep 2023 19:03:46 +0000
Message-ID: <MN0PR12MB61018199238425A68D885DCCE2C0A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230928223630.GA507660@bhelgaas>
 <20230929044413.GY3208943@black.fi.intel.com>
In-Reply-To: <20230929044413.GY3208943@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9e2bf6b8-add0-4a53-b573-3a222686d8b4;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-29T19:02:24Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: 42cb73f0-26e8-42c7-d196-08dbc11ece99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1GUzUXICrJXnKM7u0lnigDpx5LrtGc+JBXKkNpci4exOVUq2hZgpGzuQknTFPgABLJsGk0QAdJcdgd4k4rSp25kWwZJk4NrIQoLNzmGvbK63BiugsDSIyXhsBREftBZbr4llflFSwW6YY9XvbMP43LoGLftOrnhx0h/nCDleoyjix9yXAbf6UiMiUfAdoS7H8dLYSCxetf4iCDkY76FKJEcq8Wg6RVVvYNXXv+O1dR9gVi/hqyGkH74cp7uHeyrLm2v8fWyBCwO8bqFM2W+UwLiyP4Zx9gHyo72R8GZDPEVG5cfP8pIA4OrMuszky24fndHa6JjfHh29ILbEgLYwhPIda2n82W63VRg+sUKJGUg5pDXYG6NkRtSaTjJIfT8MsOxvusdTaQiMHjCzVWAVN1BBAnRFe+AvH9BcjNvxo65BdzG5mgwg2pHBsa5QjCH6v7L+tmL9kTVsMMEqHOVlCRwhp9urnxvkRoX61JXRW/n+5wgVuwGZ97r7mQkyiAaMw5XiJkWUjRJRWbjhsvIQfPe+KPlJZFouESgqXTkIXMpsdqicIBWtwHyfv+G0Md6I+v6ybycSoU8E0L6mSpIryVQmA/YXWLmKQlbep7NpETSEv0+Kv37w92NVqAbzGIyN2849PMLhQqgGamL8fa7EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(9686003)(83380400001)(7696005)(71200400001)(6506007)(478600001)(110136005)(8676002)(4326008)(66446008)(66946007)(76116006)(8936002)(316002)(66556008)(66476007)(54906003)(64756008)(41300700001)(52536014)(122000001)(38070700005)(38100700002)(2906002)(5660300002)(33656002)(55016003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmdXSURjNkg1WUpSb3JXTDI3bG5KSGxSd29Xa3hRY3RlQXhhemhxbEZmRVpI?=
 =?utf-8?B?T08yeEoxVE9TUG14bFlRRlR3VUJ4NG96S25yNUpTdUZZaWo4Wnh6RzB0UUNn?=
 =?utf-8?B?akFEWHJ0RTBETEVLNmhmb2F6SkFpeG1WaWI4cUptczNscUVSbFl0dHRQV1FX?=
 =?utf-8?B?R3ZocmJOc3Y2NlhTenA3QmNiSTFxMHRUdkZKZzI1ZW5aMTdLY1FzYWtBMXI4?=
 =?utf-8?B?LzNhQlFQS0lwZG5mOXBqVW0wN0NCc1RqMlI4OFdJblo3THhRUmxXZkxZUm4y?=
 =?utf-8?B?bm5NaGRyV3dZdHhSRUg1TlFtQXZxQ3hOUnM4V2dUM21TOEVOUlcrZ1ZNaW1w?=
 =?utf-8?B?emp2cGE0TFFaQ29ENldPc0Y2QmV6Si92OGd1bUVDUllPbG1ocDlQcVRhcG80?=
 =?utf-8?B?NTVTam53a0NRdVIySnRja2VvMDNwdnUwY1ZNdkxQNGs2aFZJMmxDRXNyRGh3?=
 =?utf-8?B?SnpDL3dFL0hpeVZxUFl1dG9wc1o2MjVRaW1ZZ3oxeFJLK3NsVU5uUy9QMk94?=
 =?utf-8?B?cVlCWiszazJoK0hBK0hGZ1JTdGVLcFFwOXVjK2xKZTRhaUw5d0VGdmNxN283?=
 =?utf-8?B?SVBTWE00YkcvaE5aNi90UXRTa1c5U21lRHlyeGs3Vko0anRXaFpQTnhCenI0?=
 =?utf-8?B?T0F6YnF2UkQyb1EwWWgwQkMvZ1E2bW8zeCtnVHBtb1FMcnArK0NKa2JYTmVt?=
 =?utf-8?B?V2lBNjk1Y0NCaUVLbTdjelBCNENBRXVSZFY3N2dyU0o3RnZEN3hSci9BTkww?=
 =?utf-8?B?K2k5eEs2VDlSNnVJQXpaeTJpQWh2a1RCOVFhVHY4Y3VjY3FGdFdON2J4RjNB?=
 =?utf-8?B?QnJKaXF0bjJPbUJLTmJTZVNCRm9uR3VGRGxRZFJnazFmQmtseXk2WCtaY3pQ?=
 =?utf-8?B?RkhNWWpNbVpFNmV2ZU5DeXd3TU9OR0J1cG9FWkFBZ01QOUZDUGtxWm4zbFVa?=
 =?utf-8?B?MTVPYU52SHJCRUdmaUNvM1JRa2JlQ1Q3bWhMNzF0OTBTVVZsL09XdTQ4MnhK?=
 =?utf-8?B?L2J4T3dQVnBsb3N1dUhHenhIOVA0QTJGTU1TbVViaXBBNDZpWGM3Q3BVK0V3?=
 =?utf-8?B?a0k2cUtTYVlZVVd6VTdsU0NlYnAzNlkvSHFiMFFwNkZHVFlxY3ZLMFBjRmhC?=
 =?utf-8?B?SWIvN3RUdGVEMGJucS9FS3BMYUp1RitVbCs0ZU0xc2VMMDRCWkVQVXRyd3Ix?=
 =?utf-8?B?dDZZMklVNm4xdE1qSkdtcGFiQU5pVFNrOGNueEJ4dVJURDJMNjc5cFhIVEcy?=
 =?utf-8?B?dFZ3dEVFK0NIcFhNNTB1NjR5ekhUWlVoYTBYQzJBbGl6VTRnVXFWM3IzaGVY?=
 =?utf-8?B?cWszbWwrNlFocWlSZjBqSkRPVEJ3Z1BSSkJ0OUNPUTFlVEN4MlFubXpITGhO?=
 =?utf-8?B?OUpKcDByRWtiT0tjLzBkZ2QvcnpIWU53Z2I4M2tMQ0RqM1RFOTJXSnFRRkxD?=
 =?utf-8?B?bHdPYU5GSDBxZFR4d3hFbWRBMTNwLzN0a3VNb0hHRHljWDhKdklKQzZuV2F0?=
 =?utf-8?B?L2JMTzZVamQveW1wSjd6cmVPczZsYmVUSlk0b25VYmU3U0psU0FUOGNqMlNH?=
 =?utf-8?B?a3BVVDVVancrZnBXMTJTYnNvYXA0dS9XZ0t1T0J0dTdBTTlsSVJjTXBWSTBO?=
 =?utf-8?B?Q2tXSnVlMzBRUDNWNjZvS0VxNlRrT2VpOWtJWnNSeFcrVmpnT0tvenhsbTBa?=
 =?utf-8?B?YzFLRWlvRW15T1RxWTBJZkNRSDEyanJGa0tHZ256UzFqVzRnM3JvYXlhc0pi?=
 =?utf-8?B?ZzFHRmJWeFRSVGdHazJhMUh2bnBNNFJ4ZE5CWjBNaWN1MVR4UDRuUUZVTnhM?=
 =?utf-8?B?NXJuZ1IxeXRXRG85ajBua3hVNThJQ1RaUjFISTRXdUtIWmJMRXF2VFFVa3B2?=
 =?utf-8?B?OGVkNmMwQTd2b0tSaDNBN1FVS2Myb2lybnorVWRuV3NLUElVZkxBVTE0N2xJ?=
 =?utf-8?B?ZGk0NUNzWFgzeUFGYlpHQVBJVGRpK2thb05nVUt1OE5sRU1xclFTVXNtSEpP?=
 =?utf-8?B?ZXZKU05qYktMc0p6VE1hVWhESGRPN2tpeS8wcmZuajk0M2E5SHlaN2JmK0V4?=
 =?utf-8?B?S0JIRU1pRDhkcnoxdGFVSWZSalczWVB5S3lwMkRxSThqZDdhZUZVcTFXZk1S?=
 =?utf-8?Q?FosU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cb73f0-26e8-42c7-d196-08dbc11ece99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 19:03:46.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URY5PaCCdMYRG1gCDVMCgi28KBmiq9FnBCU+T4s3JDIYWHEH9voWl2l0pbDSjmMBv1b0c9EhZI9Ca10hlTmilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiBUaHUsIFNlcCAyOCwgMjAyMyBhdCAwNTozNjozMFBNIC0wNTAwLCBC
am9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDAyOjQ4OjAx
UE0gKzAyMDAsIEx1a2FzIFd1bm5lciB3cm90ZToNCj4gPiA+IHN0cnVjdCBwY2lfZGV2IGNvbnRh
aW5zIHR3byBmbGFncyB3aGljaCBnb3Zlcm4gd2hldGhlciB0aGUgZGV2aWNlIG1heQ0KPiA+ID4g
c3VzcGVuZCB0byBEM2NvbGQ6DQo+ID4gPg0KPiA+ID4gKiBub19kM2NvbGQgcHJvdmlkZXMgYW4g
b3B0LW91dCBmb3IgZHJpdmVycyAoZS5nLiBpZiBhIGRldmljZSBpcyBrbm93bg0KPiA+ID4gICB0
byBub3Qgd2FrZSBmcm9tIEQzY29sZCkNCj4gPiA+DQo+ID4gPiAqIGQzY29sZF9hbGxvd2VkIHBy
b3ZpZGVzIGFuIG9wdC1vdXQgZm9yIHVzZXIgc3BhY2UgKGRlZmF1bHQgaXMgdHJ1ZSwNCj4gPiA+
ICAgdXNlciBzcGFjZSBtYXkgc2V0IHRvIGZhbHNlKQ0KPiA+ID4NCj4gPiA+IFNpbmNlIGNvbW1p
dCA5ZDI2ZDNhOGYxYjAgKCJQQ0k6IFB1dCBQQ0llIHBvcnRzIGludG8gRDMgZHVyaW5nDQo+IHN1
c3BlbmQiKSwNCj4gPiA+IHRoZSB1c2VyIHNwYWNlIHNldHRpbmcgb3ZlcndyaXRlcyB0aGUgZHJp
dmVyIHNldHRpbmcuICBFc3NlbnRpYWxseSB1c2VyDQo+ID4gPiBzcGFjZSBpcyB0cnVzdGVkIHRv
IGtub3cgYmV0dGVyIHRoYW4gdGhlIGRyaXZlciB3aGV0aGVyIEQzY29sZCBpcw0KPiA+ID4gd29y
a2luZy4NCj4gPiA+DQo+ID4gPiBUaGF0IGZlZWxzIHVuc2FmZSBhbmQgd3JvbmcuICBBc3N1bWUg
dGhhdCB0aGUgY2hhbmdlIHdhcyBpbnRyb2R1Y2VkDQo+ID4gPiBpbmFkdmVydGVudGx5IGFuZCBk
byBub3Qgb3ZlcndyaXRlIG5vX2QzY29sZCB3aGVuIGQzY29sZF9hbGxvd2VkIGlzDQo+ID4gPiBt
b2RpZmllZC4gIEluc3RlYWQsIGNvbnNpZGVyIGQzY29sZF9hbGxvd2VkIGluIGFkZGl0aW9uIHRv
IG5vX2QzY29sZA0KPiA+ID4gd2hlbiBjaG9vc2luZyBhIHN1c3BlbmQgc3RhdGUgZm9yIHRoZSBk
ZXZpY2UuDQo+ID4gPg0KPiA+ID4gVGhhdCB3YXksIHVzZXIgc3BhY2UgbWF5IG9wdCBvdXQgb2Yg
RDNjb2xkIGlmIHRoZSBkcml2ZXIgaGFzbid0LCBidXQgaXQNCj4gPiA+IG1heSBubyBsb25nZXIg
Zm9yY2UgYW4gb3B0IGluIGlmIHRoZSBkcml2ZXIgaGFzIG9wdGVkIG91dC4NCj4gPiA+DQo+ID4g
PiBGaXhlczogOWQyNmQzYThmMWIwICgiUENJOiBQdXQgUENJZSBwb3J0cyBpbnRvIEQzIGR1cmlu
ZyBzdXNwZW5kIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3Vu
bmVyLmRlPg0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NC44Kw0KPiA+ID4g
Q2M6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NCj4g
Pg0KPiA+IE1pa2EgYW5kIE1hcmlvLCB5b3UgYm90aCBjb21tZW50ZWQgb24gdGhpcywgYnV0IEkg
KnRoaW5rKiB5b3Ugd2VyZQ0KPiA+IGJvdGggT0sgd2l0aCBpdCBhcy1pcyBmb3Igbm93PyAgSWYg
c28sIGNhbiB5b3UgZ2l2ZSBhIFJldmlld2VkLWJ5Pw0KPiA+IEkgZG9uJ3Qgd2FudCB0byBnbyBh
aGVhZCBpZiB5b3UgaGF2ZSBhbnkgY29uY2VybnMuDQo+DQo+IE5vIGNvbmNlcm5zIGZyb20gbWUs
DQo+DQo+IFJldmlld2VkLWJ5OiBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51
eC5pbnRlbC5jb20+DQoNCkl0IGlzIGEgc3RlcCBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLiAgSSBk
byB0aGluayBhIGxhdGVyIGVuaGFuY2VtZW50IHRvDQpmYWlsIHRoZSB3cml0ZSBmcm9tIHN5c2Zz
ICh0byBiZSBBQkkgY29tcGF0aWJsZSBidXQgImRlcHJlY2F0ZSBpdCIpIGFuZA0KaW50ZXJuYWwg
b3B0aW1pemF0aW9uIGFzIGEgcmVzdWx0IGlzIGEgZ29vZCBpZGVhIHRob3VnaC4NCg0KUmV2aWV3
ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0K

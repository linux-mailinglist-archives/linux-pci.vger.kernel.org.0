Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1D4DDB95
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiCROYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbiCROYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:24:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B471B6944;
        Fri, 18 Mar 2022 07:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL7H8ebI+gJ2Dt1cD/+hvIFJdGKVWp8oHD+49x7Js3cflVyN214cBuvkorXYR2QwClgmIp+eFDw/EC6PnSytaTV8E2dsCugu8BgXqINsS/bkFyRJpofv3bQscDLkqhiz8M8Y0mmFA7ukGOBXg8Van6G/0HUWzFQ6kNdkd0sVlcRDHXNvULk83u3mw2i7W/6CAdMPorsAHJRTL6jHBPpltgvV3KRFuPbAna+9pl0ok4Ahr07rM1ZJm+PiZBxNahHFj/NhnsWkmX+nch1/7Usvki0fdeHvChFYeESzTMVVfsVDTVxxSBlCeQMb3SFgtLa5qwkYkmmH9/hBtsk1cKhYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/axPrQCzaT9Gz3pOreq4ZDwOeNj9Bc7ZmJuhi1Q2Zvg=;
 b=Byq+TLzXwBSjnLbHw+bq3HOKizGPz9kC33FIK0zw+2S22+L6ccDl/0FGHHrClHdokBOwCHoViAHNJlvoZZlzVHBaOI3R8gTYTHtEb2NFAFRikTu8Mw3tgF+WQ7ZZibRapGe3wFxRfJEw7tAjVn1QQWfH0m+cImWTVv9Ozg6xG1icS1q5dZ5Nv5YkUugxa9cv3SM7s8LpiAoBNITofvvxF30QqoM17Ix3gyYSmiNB6K8VqsZ3Mtqhmh26QCrW1R7LAGjrBVOmQrvVTcrHT6Y2S7B3R9iyRPxZY641/3Xly3+gnKqzd8KZdN2WEhAFzi1H7Xmbh4KHXyuTph1XcP1y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/axPrQCzaT9Gz3pOreq4ZDwOeNj9Bc7ZmJuhi1Q2Zvg=;
 b=WSIKTGvsmqip0K89Va7YW1Ge/41z6lIraE4oULlooSh0Ec8aoM+RM4N2b+vdFqBvYbD0AZoi/38krU43rWCubNPxETjw+U4NJGfmhVNmFSRWz1UkbyMSlF5qVDSRrURQStUYhD1Dkb3R0NurnWLwTJy77ZXiSyXNoUB3+rNqX/4=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 14:22:51 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 14:22:51 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Topic: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Index: AQHYOhp64mDBz0dixEuTVKpvZlnwUazDzQWAgAA7e0CAAPynAIAABoAAgAAXSwCAAAwSAIAAAsCQ
Date:   Fri, 18 Mar 2022 14:22:50 +0000
Message-ID: <BL1PR12MB5157ADF73BE48772C1F6C0E0E2139@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna> <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna> <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
In-Reply-To: <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-18T14:18:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=15d3eae3-9dcf-4778-8d0c-c51d28eb5282;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-18T14:22:48Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 97757c3a-2235-4b88-977c-015be33bcf39
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 186cde2e-698b-4e58-604c-08da08eac8d7
x-ms-traffictypediagnostic: CH2PR12MB4873:EE_
x-microsoft-antispam-prvs: <CH2PR12MB487383997621120921E8A348E2139@CH2PR12MB4873.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/5gr9ZFVDuIw5dI8gcShXSJDyeI8ty89NfVTSC9vMxha5rCCK+CfSR7R6WkmuzCSygfI33zbqF65OMvNS8G35L4wp5hFQXjODYCMKmMAxHqDc22KDnVEKHVjKQE4cjGqwggCeIOur/FpmgxG2WOZZQZ11p+2w2dTK7DyFC9e/N8MVI/b/SnCvUKg1F/Lm+UDfNq4J2F/ygb1qlkE8vzYKjLip6tVjpHqYCUGL0SFsyMnzfdtIpf7xsg/1ojIMt23sYzHTbO/xBCikdVwEMYXXGsievexY1P6wbfjyjgN1pZ+Yo3UvYO1RbxsmVyk2GvoaDR03wZ5gDimjiwAwv+iN/kuxzgSQAMaVnHDY0vPSUJzhjGpZOG4vw2cQqVBQe+PohgVtNlf5KzE8Mr2hHRk8lwkw3OYaIQkWcv7q2+GSuDU2mbdnfUxU2mrp0cmxncH1FRwigdloZWiTjZrgCAtJAfWQJ049lzADv2Nw2vokHUWAwF19tHdUN7x9/JkuL8q4X14fzlmAlZXjnhO+BWnDHO8I6qs8FTHyQ+PDM9hsGgOw5CUwB85ZPsu1uh6RiiBBBwhfMxx9NRg+10iiIiw6QAypOVbzsnOD+EeqCfB8chVja0YuRS+6bi935X4EqsDnxVYyr/FzghJP9WCaXp46QxEjnAtXF4puymj9/i91U11AmvlupuZI0fy/tlc5kK+w2u5oX/v9uCAHeIfqSPjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(71200400001)(55016003)(54906003)(45080400002)(33656002)(2906002)(508600001)(83380400001)(6506007)(4326008)(5660300002)(38070700005)(7696005)(53546011)(8676002)(64756008)(66446008)(66946007)(66556008)(66476007)(76116006)(122000001)(186003)(38100700002)(26005)(52536014)(9686003)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjNkc1pFSlVJY0U5K3ZLVXR2NlJMNWJZR0Y2WGQvUzNTbzNNcmViejFjdW9P?=
 =?utf-8?B?NGpIS3VBMmd4elZaT252TDdKWDlsaThZTFFxVHlyYjZsZ1YxbkIzZWs2VG9q?=
 =?utf-8?B?NnloUUFPWUxPa01SOGo3SWZBcm0xV25Pb09EQXF4Y3BUVXM2ZXJFVlBKQ01i?=
 =?utf-8?B?NG1IYTNTQ04xQUQ5UC8rV2ZSVDNLcGNWOUxzdDJacVBBSzRLV1k5Unh2ZVlE?=
 =?utf-8?B?eFZtMnV2M0xrQjFKR2ZUZ21ZSzBhcnZYTXZqS2kwMkVQRUI3dTQvelRKTS9z?=
 =?utf-8?B?dEt0SVJGL29pT2xqNFgrUVNlbkhlWnMrK3pjamFoRm9xTDh2N1VXQ3dJaGlG?=
 =?utf-8?B?cGxGWERDVmJXR2RmUnd6ejEwenl1TnJ0UEpKN0pDRHB5TURHQm90azRVeFFn?=
 =?utf-8?B?dXh3SWxEUzJkLzBVdEhZa0ptOUFzTkhldzJ2Vjg3U2s2Z1RUMG5qSitYSzdu?=
 =?utf-8?B?YTR1dmswRjdZWUxOa2ZQbldHWGVaekFUN1pYRUsxWGJXLzg3MWRxVmQrNjBr?=
 =?utf-8?B?cVVLTjlSYm94ZmEraHZDa0tjWnA0cjlvY3lDb1crcVJ3L2ZNdmhnUGM4KzlS?=
 =?utf-8?B?a1RZa0RucmdFZGhZdjVnUDNKcmN3blVWTW02OXFMcXNocldnZWJxTGVhcGxS?=
 =?utf-8?B?SUoyM1ZYL3ptUVp4UmtHU09YMEliQXp5aXNHbWVLLzI5MUZ2T1dzMEw3TFJX?=
 =?utf-8?B?Vmk5dXIrQXh4U2duOXVVUS9RSjBiclE4R0d1RGVEc3lKdmNQU1hScE5lSzlH?=
 =?utf-8?B?UVh2b09zY09JbmF1ZEZWYnlrMXF5c3NyaktrWm9RdVJwQ05KMEU3a3pmTzlY?=
 =?utf-8?B?ZEZEU0FBZnVnMHc3OFBoSzBNcGVFWGlzNjBxd0FoRUFHQ0JwNUJlZmMrU1Vm?=
 =?utf-8?B?TGlaREtlU3hFL2x6Ri9hOTJTaWpmTHAycjFxWklaZlF5MEE4bUx5YkxKbExR?=
 =?utf-8?B?aDVPVHcySWc0a28rKytsN01QV2pTaEJROU96UGxLb2JSZ1pNMnpYcUNyN3F5?=
 =?utf-8?B?VkdYRGJ5OTcrTFlqbmdRdjhrRmVsTGNkSXJQNTRsemozVG0yVGhwTVJsQ05J?=
 =?utf-8?B?YUUxWG13UnZpL2h1TDIraWV0bVIrMmhzR0J4bVhxUzQvSUxiWFVITG5sU014?=
 =?utf-8?B?Wk9DR0RidXcrQWxmSUJPMHNaR3F5ckFBbHRyaDJOTVlBeU1majJBTkpsNVFk?=
 =?utf-8?B?NW9vdGJsMTI3RU5LSDF6akFwaXF0ZDlib1FjV0kwanV6enQ2bExKOTFrT1Fj?=
 =?utf-8?B?TS9RdjkwV29SQ0xPU0UrZ3NCbDBXeTdXZWlpNDQzM3daWU85c2hqTmRESUNw?=
 =?utf-8?B?cVIzM1AwcWRuT0lRVklxdm1rN1JBUlorK0E4WnZyejhkckg2RVNjU3BYd1FX?=
 =?utf-8?B?ampVTWlTdXRoSyttbFlVOWNxbnIyR3RWNUNSVG9RYTRYNUREMS9BS3BzMXdr?=
 =?utf-8?B?cTNENkl2eGYveG1Nck1MR1p2NkRYYWpKRjBEM3B2RFdHTjgxR1JzRUdGd3Fh?=
 =?utf-8?B?akxpN1dOZ1RRVWs1V1BBRS9qWXErYVFGM2dHcnhpMm5YMjlDK0d1V2QrQVhG?=
 =?utf-8?B?WnpmVDVOYWhUT0Y4UGFTNTF1MTVtTFRwNU9JeHZadXVzcFhTZmM0SU02b2dP?=
 =?utf-8?B?NTluUG1yaUFwenBEU25OMURMMStsc1pJMGluL2tTMERVVGhrMFovd2pkaTRZ?=
 =?utf-8?B?NlRaUkpRNVRTK2hyZkF1SDlpd2QzaDMvdTV5djcwSnFMUGhEVEpFQytxOGJj?=
 =?utf-8?B?ck54OTFnSFNwZ2RPbm5yUnIrT1ZBTUkvZFVJYmZHRDFBdW1TNmYvQzFjdjd0?=
 =?utf-8?B?VzcyTXhCTjZnTHhoYk9jZGNuSjEyN2JhZlhxczhkc2xtbGJwNmtHR1EvZTdU?=
 =?utf-8?B?T2M5U0Z1U1RQVjF5RkcxYmhHZys1R3dqUUZ1aE5wOHpRY0ZPN0pwdk1wbFZh?=
 =?utf-8?Q?OmcrXZfhp8RJfVobwJksrzoCHT13O3nP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186cde2e-698b-4e58-604c-08da08eac8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 14:22:50.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o21v2QUq/xrT/YJXCxfavZFuuVcht5VbpnI03HK/Zvjiq9yH+AGAhE8SUKitWDBuIXr/zrVrE7WqrHi/qvc39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4LCAy
MDIyIDA5OjA4DQo+IFRvOiBtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tDQo+IENjOiBM
aW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+Ow0KPiBhbmRyZWFz
Lm5vZXZlckBnbWFpbC5jb207IG1pY2hhZWwuamFtZXRAaW50ZWwuY29tOw0KPiBZZWhlemtlbFNo
QkBnbWFpbC5jb207IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgt
DQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdGh1bmRlcmJv
bHQ6IE1ha2UgaW9tbXVfZG1hX3Byb3RlY3Rpb24gbW9yZQ0KPiBhY2N1cmF0ZQ0KPiANCj4gT24g
MjAyMi0wMy0xOCAxMzoyNSwgbWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbSB3cm90ZToN
Cj4gPiBIaSBSb2JpbiwNCj4gPg0KPiA+IE9uIEZyaSwgTWFyIDE4LCAyMDIyIGF0IDEyOjAxOjQy
UE0gKzAwMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gPj4+IFRoaXMgYWRkcyBxdWl0ZSBhIGxv
dCBjb2RlIGFuZCBjb21wbGV4aXR5LCBhbmQgaG9uZXN0bHkgSSB3b3VsZCBsaWtlIHRvDQo+ID4+
PiBrZWVwIGl0IGFzIHNpbXBsZSBhcyBwb3NzaWJsZSAoYW5kIHRoaXMgaXMgbm90IGVub3VnaCBi
ZWNhdXNlIHdlIG5lZWQgdG8NCj4gPj4+IG1ha2Ugc3VyZSB0aGUgRE1BUiBiaXQgaXMgdGhlcmUg
c28gdGhhdCBub25lIG9mIHRoZSBwb3NzaWJsZSBjb25uZWN0ZWQNCj4gPj4+IGRldmljZXMgd2Vy
ZSBhYmxlIHRvIG92ZXJ3cml0ZSBvdXIgbWVtb3J5IGFscmVhZHkpLg0KPiA+Pg0KPiA+PiBTaGFs
bCB3ZSBmb3JnZXQgdGhlIHN0YW5kYWxvbmUgc2libGluZyBjaGVjayBhbmQganVzdCBtYWtlIHRo
ZQ0KPiA+PiBwZGV2LT51bnRydXN0ZWQgY2hlY2sgZGlyZWN0bHkgaW4gdGJfYWNwaV9hZGRfbGlu
aygpIHRoZW4/DQo+ID4NCj4gPiBJIHRoaW5rIHdlIHNob3VsZCBsZWF2ZSB0Yl9hY3BpX2FkZF9s
aW5rKCkgdW50b3VjaGVkIGlmIHBvc3NpYmxlIDstKQ0KPiA+IFRoaXMgaXMgYmVjYXVzZSBpdCBp
cyB1c2VkIHRvIGFkZCB0aGUgZGV2aWNlIGxpbmtzIGZyb20gZmlybXdhcmUNCj4gPiBkZXNjcmlw
dGlvbiB0aGF0IHdlIG5lZWQgZm9yIHByb3BlciBwb3dlciBtYW5hZ2VtZW50IG9mIHRoZSB0dW5u
ZWxlZA0KPiA+IGRldmljZXMuIEl0IGhhcyBsaXR0bGUgdG8gZG8gd2l0aCB0aGUgaWRlbnRpZmlj
YXRpb24gb2YgdGhlIGV4dGVybmFsDQo+ID4gZmFjaW5nIERNQS1jYXBhYmxlIFBDSWUgcG9ydHMu
DQo+ID4NCj4gPiBGdXJ0aGVybW9yZSB0aGVzZSBsaW5rcyBvbmx5IGV4aXN0cyBpbiBVU0I0IHNv
ZnR3YXJlIGNvbm5lY3Rpb24gbWFuYWdlcg0KPiA+IHN5c3RlbXMgc28gd2UgZG8gbm90IGhhdmUg
dGhvc2UgaW4gdGhlIGV4aXN0aW5nIFRodW5kZXJib2x0IDMvNCBzeXN0ZW1zDQo+ID4gdGhhdCB1
c2UgZmlybXdhcmUgYmFzZWQgY29ubmVjdGlvbiBtYW5hZ2VyIChwcmV0dHkgbXVjaCBhbGwgb3V0
IHRoZXJlKS4NCj4gPg0KPiA+PiBPbiByZWZsZWN0aW9uIEkgZ3Vlc3MgdGhlIERNQVIgYml0IG1h
a2VzIGlvbW11X2RtYV9wcm90ZWN0aW9uDQo+ID4+IGZ1bmN0aW9uYWxseSBkZXBlbmRlbnQgb24g
QUNQSSBhbHJlYWR5LCBzbyB3ZSBkb24ndCBhY3R1YWxseSBsb3NlDQo+ID4+IGFueXRoaW5nIChh
bmQgYW55b25lIGNhbiBjb21lIGJhY2sgYW5kIHJldmlzaXQgZmlybXdhcmUtYWdub3N0aWMNCj4g
Pj4gbWV0aG9kcyBsYXRlciBpZiBhIG5lZWQgYXBwZWFycykuDQo+ID4NCj4gPiBJIGFncmVlLg0K
PiANCj4gT0ssIHNvIGRvIHdlIGhhdmUgYW55IHJlYWxpc3RpYyBvcHRpb25zIGZvciBpZGVudGlm
eWluZyB0aGUgY29ycmVjdCBQQ0kNCj4gZGV2aWNlcywgaWYgVVNCNCBQQ0llIGFkYXB0ZXJzIG1p
Z2h0IGJlIGFueXdoZXJlIHJlbGF0aXZlIHRvIHRoZWlyDQo+IGFzc29jaWF0ZWQgTkhJPyBTaG9y
dCBvZiBtYWludGFpbmluZyBhIGxpc3Qgb2Yga25vd24gSURzLCB0aGUgb25seQ0KPiB0aG91Z2h0
IEkgaGF2ZSBsZWZ0IGlzIHRoYXQgaWYgd2Ugd2FsayB0aGUgd2hvbGUgUENJIHNlZ21lbnQgbG9v
a2luZw0KPiBzcGVjaWZpY2FsbHkgZm9yIGhvdHBsdWctY2FwYWJsZSBHZW4xIHBvcnRzLCBhbnkg
c3lzdGVtIG1vZGVybiBlbm91Z2ggdG8NCj4gaGF2ZSBUaHVuZGVyYm9sdCBpcyAqcHJvYmFibHkq
IG5vdCBnb2luZyB0byBoYXZlIGFueSByZWFsIFBDSWUgR2VuMQ0KPiBob3RwbHVnIHNsb3RzLCBz
byBtYXliZSBmYWxzZSBuZWdhdGl2ZXMgbWlnaHQgYmUgdG9sZXJhYmxlLCBidXQgaXQgc3RpbGwN
Cj4gZmVlbHMgbGlrZSBhIGJpdCBvZiBhIHNrZXRjaHkgaGV1cmlzdGljLg0KPiANCj4gSSBzdXBw
b3NlIHdlIGNvdWxkIGp1c3QgbG9vayB0byBzZWUgaWYgYW55IGRldmljZSBhbnl3aGVyZSBpcyBt
YXJrZWQgYXMNCj4gZXh0ZXJuYWwtZmFjaW5nLCBhbmQgaG9wZSB0aGF0IGlmIGZpcm13YXJlJ3Mg
ZG9uZSB0aGF0IG11Y2ggdGhlbiBpdCdzDQo+IGRvbmUgZXZlcnl0aGluZyByaWdodC4gVGhhdCdz
IHN0aWxsIGF0IGxlYXN0IHNsaWdodGx5IGJldHRlciB0aGFuIHdoYXQNCj4gd2UgaGF2ZSB0b2Rh
eSwgYnV0IEFGQUlDUyBzdGlsbCBjYXJyaWVzIHNpZ25pZmljYW50IHJpc2sgb2YgYSBmYWxzZQ0K
PiBwb3NpdGl2ZSBmb3IgYW4gYWRkLWluIGNhcmQgdGhhdCBmaXJtd2FyZSBkaWRuJ3QgcmVjb2du
aXNlLg0KPiANCj4gSSdtIHNhdGlzZmllZCB0aGF0IHdlJ3ZlIGNvbWUgcm91bmQgdG8gdGhlIHJp
Z2h0IGNvbmNsdXNpb24gb24gdGhlIERNQVINCj4gb3B0LWluIC0gSSdtIGluIHRoZSBtaWRkbGUg
b3Igd3JpdGluZyB1cCBwYXRjaGVzIGZvciB0aGF0IG5vdyAtIGJ1dCBldmVuDQo+IE1pY3Jvc29m
dCdzIHNwZWMgZ2l2ZXMgdGhhdCBhcyBhIHNlcGFyYXRlIHJlcXVpcmVtZW50IGZyb20gdGhlIGZs
YWdnaW5nDQo+IG9mIGV4dGVybmFsIHBvcnRzLCB3aXRoIGJvdGggYmVpbmcgbmVjZXNzYXJ5IGZv
ciBLZXJuZWwgRE1BIFByb3RlY3Rpb24uDQo+IA0KPiBSb2Jpbi4NCg0KVGhlIHRodW5kZXJib2x0
IGRyaXZlciBhbHJlYWR5IGhhcyBhIGdvb2QgaWRlYSB3aGV0aGVyIGl0J3MgdXNpbmcgc29mdHdh
cmUNCkNNIG9yIGZpcm13YXJlIENNLiAgSG93IGFib3V0IGlmIHdlIHVzZSB0aGF0IHRvIG1ha2Ug
YSBkZWNpc2lvbj8NCg0KSWYgcnVubmluZyBmaXJtd2FyZSBDTSBwcmVzdW1hYmx5IHRoYXQgaXMg
YSBmaXhlZCBxdWFudGl0eSBvZiBtYWNoaW5lcyB0aGF0IHdpbGwNCmR3aW5kbGUgb3ZlciB0aW1l
IGFzIE9FTXMgcmVsZWFzZSBuZXcgSFcgd2l0aCBTVyBDTSBkZXNpZ25zLiBTbyBtYXliZQ0KbGVh
dmUgdGhpbmdzICJhcyBpcyIgZm9yIHRob3NlIC0gb3B0IGluIGJpdCBpcyBzdWZmaWNpZW50IGZv
ciB0aGlzIGNoZWNrLg0KDQpBbmQgdGhlbiBpZiBydW5uaW5nIHNvZnR3YXJlIENNIHRoZW4gbWFr
ZSBpdCBtYW5kYXRvcnkgdGhhdCBhbnkgY3JlYXRlZCBsaW5rcw0KYXJlIHNldCB1bnRydXN0ZWQg
QU5EIHNvbWUgcHJlLWJvb3QgYml0cyBhcmUgc2V0IHRvIGdldCBpb21tdSBkbWEgcHJvdGVjdGlv
bg0Kc2V0LiAgV2UgZWZmZWN0aXZlbHkgZW5kIHVwIHdpdGggdGhlIHNhbWUgcmVxdWlyZW1lbnRz
IGFzIE1pY3Jvc29mdCBoYXMgaW4NCnRoZWlyIHNwZWMgZm9yIG5ldyBoYXJkd2FyZSB0aGVuLCBh
bmQgZG9uJ3QgYnJlYWsgYW55IG9sZCBoYXJkd2FyZSB0aGF0DQpkb2Vzbid0IGhhdmUgdGhlIGxp
bmtzIG1hZGUgYW5kIHJlbGllcyBvbiBmaXJtd2FyZSBmb3IgdGhlIENNLg0K

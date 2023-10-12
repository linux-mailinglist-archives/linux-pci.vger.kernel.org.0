Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A67C6540
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 08:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbjJLGRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjJLGRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 02:17:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C31A9;
        Wed, 11 Oct 2023 23:17:38 -0700 (PDT)
X-UUID: 05c5c13a68c711ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1UXYnsKDhQp8jnLybOm8a4Hf2nsarJbnAdRXS2m6JZM=;
        b=X7xBsWLOiOM5k81PDSKpK3X5OTRiotjpt2pZL15AHH9zywGKjadcUpnSF3PKHIO5D2r9uo2Zfm0hge37lgMgS+ySw7c/0UR/HipF34VGLVnudDEHGnUAgellTp/kqDEghKVteTDCCVSRgwjMejPCb4O3nlx3da5AY7pMszG5T80=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:434c2027-71bb-43f5-b0d4-e5b2aad7a7ee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:052a08c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 05c5c13a68c711ee8051498923ad61e6-20231012
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1838533650; Thu, 12 Oct 2023 14:17:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 14:17:29 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 14:17:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbxdCL6UBN2ehrsAWIUSr5z5XCOLo9l/qWw5ALu+80kmH3gMstSTc1qwjlMGXEVqyMhR2Z06YubAzybcOAm2G4O6dtLgkbvFuNYUMhyzDHgXCSy5oViTKzNAf7PTvrDlDJ7U/AEiAgiNxugywXlnxGePh3PpLNCv/qxjwiBP2ieFFhfsi6PqeejHnQoX7/PwR2X1tpqPcdMzQo8V/6bPj2PBNz1f9kV1jiaMSVeZqo9IyQnT6NWsaOmrBXrX/nzDkcZ6NFHqL/kLidyo7i/4AENZiv+Pi5GEmtpw2j/P5vdp6eRF4SdU7btZ8jSNmyF6IuU1q6BQtlRa5FQw3B4ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UXYnsKDhQp8jnLybOm8a4Hf2nsarJbnAdRXS2m6JZM=;
 b=AJos4/wP0DrBx7s8L7a3PpLohBtGcg5/5IdqzhEG3zPM7x4ZWGosK1Aw6+CsXPcRt42YHH48fxwsgS8QTzy9tXSCadt9RrEAF5uWXKqCC7KkDztFx8q90K3IcdTzguSY1JjNe6i8bf6zHyTv+eusGSrylvFRKxltdpcFepu04NFQ7o14wIUAvPKy6Bg/NyRYGgQ9/wUDG/Rr31bQHSLzZYGdnsIuVRNU6nEvdUJMBSRQeXjIoqPLVx2Zw9fEok1+VtGlzKgVY1dZaq+rA27/rITXh5SWpmum9QCCedzqA4zvx5IvHvMnjZC7z9YYZngUSntqw2PYkA4kDOCPEiDV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UXYnsKDhQp8jnLybOm8a4Hf2nsarJbnAdRXS2m6JZM=;
 b=clnvF2rLxSHwOy8f8464AFKwZfP9d1gJ7/s+MCRGKQJmhx/yA/VPf51OEa5rMhTSbN+oeImqOYIFNhcwh0jOEvK1sRokgLB0VB1/xxQQaCAZxdUefKWK5Lqr2UODpL4hsfu90v4MGwx+Jp5yeVJwvHZaqTsqkyrED0n1hQfwkCk=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYZPR03MB7638.apcprd03.prod.outlook.com (2603:1096:400:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Thu, 12 Oct
 2023 06:17:25 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0%5]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 06:17:25 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
Thread-Topic: [PATCH] PCI: mediatek-gen3: Fix translation window
Thread-Index: AQHZ/D4+ALwyQsnSTEKf880/L3OgGrBEuWSAgAD1pwA=
Date:   Thu, 12 Oct 2023 06:17:25 +0000
Message-ID: <088559162e5ec4e2d6d38d8a5707c6e0e12f5ac6.camel@mediatek.com>
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
         <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
In-Reply-To: <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYZPR03MB7638:EE_
x-ms-office365-filtering-correlation-id: 7cc8f5b0-b726-420d-c72f-08dbcaeae72d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Z3urBescx8DaNqpPx+vZbrpjzO+h5REiZqzL9GAVRXz4O1URFYF7/G0Qzs23QMG3HmCcWgxWo7jsRzuvUBtlAYvb0CCCBayC005EaJ0rqlgnknTNN455cCD1ZBqGtKC7bnjYPxpBvyeAEw5rwk0tk3OD7aLVIQegYJRP6aNVTxcO4Fmj2ro3E72oCebS1GIGUUttBuBADNnpMcXXoEXKfJPFHnOSC3CVQ6iyhUan0dju40HdAdpwGLFmx1n4PnOWuKk8BOaiQrbIZmmMemKQ6VC2pHC7y/3lDQkOt0FYy8IhTMJckIheXXDqOB9BzHNP0CUIVhYcvwzbDNNkDQvBYTUlH8VxsREqm7EtPNlhWjPEHzt51xGEcrbJHhkZgVmf/AGQI/x9gGJGpPHEGlmBHCIOA1wbbLn8XGj+y3q7CT8Pd51DvuHUJ3e03hFTwPEnwwXYVzQdhGNUmuJwhJxziBXwljCB1qvmxQwXSuw7b3mn7OUVzLbjQK4+JDvR3q7WCTLF0VSNID8mG9ClPF/oJJkLZ4h/n/f/5Yblhm963siIM6X1/nGESN9Vh6RVQiTIDH03yhhX5yOiqpuzkx2ipFZJtzrJOxitvNcN7JAKEKqB+3e5vOOti0CJ0nBkMpMXVp4p4n/S+hAQPS6Iq2M7xbR27K0+S060Tgx9MMB/tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(107886003)(2616005)(6512007)(86362001)(85182001)(36756003)(38070700005)(122000001)(38100700002)(7416002)(66556008)(316002)(4001150100001)(2906002)(6506007)(478600001)(6486002)(83380400001)(71200400001)(110136005)(26005)(41300700001)(4326008)(8936002)(8676002)(66446008)(76116006)(64756008)(66946007)(91956017)(54906003)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjBBODZvaHYrbHptZWkySTNIUEh4dEtjVjBoUC9LeTFSbnpveHhZTG5vMUVl?=
 =?utf-8?B?Z1NMQm1iN25Ec1MvQ3BOYkErdUx1NGJxS0JDRW9VdEJCYUx2N3VxeTM4M0xr?=
 =?utf-8?B?WDNZaTJTYjRYV0wwakUyM044MzRnWlkyRFFEQ1BrOGJnaHhobXhUOWRkbkJ6?=
 =?utf-8?B?SjFieGNicS9TZnp4bUV0YjNzZ1FZa3d5dTFtQ1k4RGgxWHMzckdhZzlITkdO?=
 =?utf-8?B?c3ZUWE5sU3lIemtsKytNRWxTQ1YzcFN4Mjc3WUlmcFRWMHVXdUo4THc1VlZK?=
 =?utf-8?B?V3ZGRFBlbXMzRzNDdXd2SlBLVmpmVnJxQ3ZMaUtabVQ5VS8xcmlYTWZRRHJz?=
 =?utf-8?B?c3l1WG0wcDUya3p6MWlUWGlJUHFtWS90MWJocVpUS09vYTZUdEJ0bWYvL1Js?=
 =?utf-8?B?UGtUMXpaSW5TUWVPYTdnY1R1Z3BUR09Hem5YeFU0cnFZMEV0ZGF4bFlVNEpB?=
 =?utf-8?B?VnQrR3UyUU1hQng5NHF4V2FKWVhKcnVUZ2l2VldoR1c3Z0x0Q0xtTkZLRmlx?=
 =?utf-8?B?Qmo3aW9tUTNhVUc0L3RkeUt5Znkrd3c3M21XanM2bk1PcUdheklwTWFZYU1Z?=
 =?utf-8?B?dWNKWlRxRWJjcEZ1OHhFK1ZDYW9MSGZqbENHclBtbTg2Vm8ydjlvZ0xQQlg2?=
 =?utf-8?B?aFlENlJDYmY0MjdzSnYxczRhTXZFU1hVbnovNHY1Z1M2Yjk5a3l0S0orNmFz?=
 =?utf-8?B?S0pOMlh1SitXUGtPcFZiREhWZWxsTTQ3ZjBLVU5TUTBGcnpxMnRrM2wyVzFR?=
 =?utf-8?B?bzN5SG90a0tGeE9KMkIzTURlUDg0R29hamUrQ2JpUXZKcDQ0VkpzaWYwS09G?=
 =?utf-8?B?ck9XOVZSYmdqckJYVDVYVUUzRVZTQ2pqeVJ2Y1pQalFjaDIzUTBGTlBIa3dq?=
 =?utf-8?B?dXg5Zkt3bjcxZlNWSWpWeGZJb3ZJZlBvdjJHQm1YckplMGdpSmV2dVF0aVFO?=
 =?utf-8?B?Mk9lZWFRTzAwU3U0a1I4SzAyeXJGa2hiN0dzdnlNMXFBaFdDeDNPamNuSHNo?=
 =?utf-8?B?YS9iSnYvZ3poMXNiYVpsTk1iZ1AycWkvbm9VL3ZtNHpoZ0xtSXczZ2VLN29j?=
 =?utf-8?B?eUdicXBmNmdZa0t0U0MyNmpnOVFiMjRPakpJTU5EeDNSNXdOb1c2Yy9nN2JG?=
 =?utf-8?B?WlViRytCcFBDZXJHNXl3UE9SaW5DT1VGZFB5ZzFadFZ2TFdOOEZGL1FkemlD?=
 =?utf-8?B?UzR6SnZQb3hwVXJKWHRURk1WS2g4cXZZdWdtbHAxU3NqaHIveGUvN21HSldu?=
 =?utf-8?B?YXFXRllwZk5tNk9VSkhycUU3SXR0TFhaNjlRZ1JtdnZQTlJHdm1oNHFraUla?=
 =?utf-8?B?aHp2djRtcytGeTgrK3JKdFFxbUYrdkd0YW1PeStwNzIyMWFjQmFtcXc0dVZS?=
 =?utf-8?B?YkEvckFieUlGUkpCcWFQY3FRNXNvbGVLdklJK0pkYVh3UlpqMFJEbWxpZnVt?=
 =?utf-8?B?aFptVjhPU1JhOWZPYmFHUFFvOXhqRzhCS3VFZFJYeWRwNmJlUysvU0ZMVXhj?=
 =?utf-8?B?WmsvbkdMZkF1eXp6c2J1aTk2TU41QnU3emk0OHNEczhCQnVzWTBNRlhjVWE2?=
 =?utf-8?B?SWNtdTh2WkdQd05kWWd0aWdqa0dPZDlZOVhHOWpnMnBodndveFZVNTFseUZs?=
 =?utf-8?B?S1l4T1Y1MHdHQXNES0owdDdyc3ErSnlXazFzWERvRnpnK2FyMXJzd3IvTk1F?=
 =?utf-8?B?dHVyNmdIYkNUMTBlYnA0ekVrT29BQkxjYVk0R25mN0gzWEduci93SmJ5alAz?=
 =?utf-8?B?YVJDY0piN1VoOEFBZHRCRFl2dHJKYWhyek9GOE5ZMVo3WmpPNm8zcVRYSlln?=
 =?utf-8?B?V3hMQXJ0YzZweVAzdHQ3RHA1cVRsQUxRc1UrRWwzVVY0WUdQd1FrUUtoTVox?=
 =?utf-8?B?Y3BaWnhyY2VpL1RwZURpbnRmT0YyYTFtdE1uVkdhSTJmR1FKK2tnTU51U21z?=
 =?utf-8?B?c0pNYWhzLy93ZEp2Z3gvd0VyY3UrWkJ0N3VGakd5N3VoNUx2Qnp5UmRQTDE0?=
 =?utf-8?B?cTUvQnRlenhQaTIwMFdSeER1WldKS01RNm83aWk3aytZNXRtRDI4ajZIRi9N?=
 =?utf-8?B?MmVVUGJQYzA4TkozZ3EwYjErWC8yUlNDdStLZ1YvMS92R1J6eVRYVnE5eTVV?=
 =?utf-8?B?eG5kQUJKQXQvV0tRYVYrM2ZPTXFQWDFXV0JMeTN1aVdPUlY3OG15dUQ2S0Fp?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <145EC50B8AC26541B0ADEA1E85DE2601@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc8f5b0-b726-420d-c72f-08dbcaeae72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 06:17:25.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYThmg0ja43mHwuMRGauRv/KE41YKgrXaT9SDngQn/uO9aRFXSP0AkA8zxxctxWym8DjTyLtASc/CXXb0tGULmN0oIXPtHZraOsziTKBSHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7638
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDE3OjM4ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gDQo+IE9uIDExLzEwLzIwMjMgMTQ6MjYsIEppYW5qdW4g
V2FuZyB3cm90ZToNCj4gPiBUaGUgc2l6ZSBvZiB0cmFuc2xhdGlvbiB0YWJsZSBzaG91bGQgYmUg
YSBwb3dlciBvZiAyLCB1c2luZyBmbHMoKQ0KPiBjYW5ub3QgDQo+ID4gZ2V0IHRoZSBwcm9wZXIg
dmFsdWUgd2hlbiB0aGUgc2l6ZSBpcyBub3QgYSBwb3dlciBvZiAyLiBGb3INCj4gZXhhbXBsZSwg
DQo+ID4gZmxzKDB4M2UwMDAwMCkgLSAxID0gMjUsIGhlbmNlIHRoZSBQQ0llIHRyYW5zbGF0aW9u
IHdpbmRvdyBzaXplDQo+IHdpbGwgYmUgDQo+ID4gc2V0IHRvIDB4MjAwMDAwMCBpbnN0ZWFkIG9m
IHRoZSBleHBlY3RlZCBzaXplIDB4M2UwMDAwMC4gRml4DQo+IHRyYW5zbGF0aW9uIA0KPiA+IHdp
bmRvdyBieSBzcGxpdHRpbmcgdGhlIE1NSU8gc3BhY2UgdG8gbXVsdGlwbGUgdGFibGVzIGlmIGl0
cyBzaXplDQo+IGlzIG5vdCANCj4gPiBhIHBvd2VyIG9mIDIuDQo+IA0KPiBIaSBKaWFuanVuLA0K
PiANCj4gSSd2ZSBubyBrbm93bGVkZ2UgaW4gUENJRSwgc28gbWF5YmUgd2hhdCBteSBzdWdnZXN0
aW9uIGlzIHN0dXBpZDoNCj4gDQo+IElzIGl0IG1hbmRhdG9yeSB0byBmaXQgdGhlIHRyYW5zbGF0
aW9uIHRhYmxlIHNpemUgd2l0aCAweDNlMDAwMDAgKGluIA0KPiB0aGlzIGV4YW1wbGUpID8NCj4g
SSdtIGFza2luZyBiZWNhdXNlIHlvdSBjYW4gaGF2ZSBhbiBpc3N1ZSBieSByZWFjaGluZyB0aGUg
bWF4aW11bSANCj4gdHJhbnNsYXRpb24gdGFibGUgbnVtYmVyLg0KPiANCj4gSXMgaXQgcG9zc2li
bGUgdG8ganVzdCB1c2Ugb25seSBvbmUgdGFibGUgd2l0aCB0aGUgcG93ZXIgb2YgMiBzaXplDQo+
IGFib3ZlIA0KPiAweDNlMDAwMDAgPT4gMHg0MDAwMDAwICggZmxzKDB4M2UwMDAwMCkgPSAyNiA9
IDB4NDAwMDAwMCkuIFRoZQ0KPiBkb3duc2lkZSANCj4gb2YgdGhpcyBtZXRob2QgaXMgd2FzdGlu
ZyBhbGxvY2F0aW9uIHNwYWNlLiBBRkFJSyBJIGFscmVhZHkgc2VlIHRoaXMgDQo+IGtpbmQgb2Yg
bWV0aG9kIGZvciBtZW1vcnkgcHJvdGVjdGlvbi9hbGxvY2F0aW9uIGluIGVtYmVkZGVkIHN5c3Rl
bXMsDQo+IHNvIA0KPiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgbWV0aG9kIGlzIHNhZmVyIHRoYW4g
dXNpbmcgbXVsdGlwbGUgdGFibGUgZm9yDQo+IG9ubHkgDQo+IG9uZSBzaXplIHdoaWNoIGlzbid0
IGEgcG93ZXIgb2YgMi4NCg0KSGkgQWxleGFuZHJlLA0KDQpJdCdzIG5vdCBtYW5kYXRvcnkgdG8g
Zml0IHRoZSB0cmFuc2xhdGlvbiB0YWJsZSBzaXplIHdpdGggMHgzZTAwMDAwLA0KYW5kIHllcyB3
ZSBjYW4gdXNlIG9ubHkgb25lIHRhYmxlIHdpdGggdGhlIHBvd2VyIG9mIDIgc2l6ZSB0byBwcmV2
ZW50DQp0aGlzLg0KDQpGb3IgTWVkaWFUZWsncyBTb0NzLCB0aGUgTU1JTyBzcGFjZSByYW5nZSBm
b3IgZWFjaCBQQ0llIHBvcnQgaXMgZml4ZWQsDQphbmQgaXQgd2lsbCBhbHdheXMgYmUgYSBwb3dl
ciBvZiAyLCBtb3N0IG9mIHRoZW0gd2lsbCBiZSA2NE1CLiBUaGUNCnJlYXNvbiB3ZSBoYXZlIHRo
ZSBzaXplIHdoaWNoIGlzbid0IGEgcG93ZXIgb2YgMiBpcyB0aGF0IHdlIHJlc2VydmUgYW4NCklP
IHNwYWNlIGZvciBjb21wYXRpYmxlIHB1cnBvc2UsIHNvbWUgb2xkZXIgZGV2aWNlcyBtYXkgc3Rp
bGwgdXNlIElPDQpzcGFjZS4NCg0KVGFrZSBNVDgxOTUgYXMgYW4gZXhhbXBsZSwgaXRzIE1NSU8g
c2l6ZSBpcyA2NE1CLCBhbmQgdGhlIGRlY2xhcmF0aW9uDQppbiB0aGUgRFQgaXMgbGlrZToNCnJh
bmdlcyA9IDwweDgxMDAwMDAwIDAgMHgyMDAwMDAwMCAweDAgMHgyMDAwMDAwMCAwIDB4MjAwMDAw
PiwNCiAgICAgICAgIDwweDgyMDAwMDAwIDAgMHgyMDIwMDAwMCAweDAgMHgyMDIwMDAwMCAwIDB4
M2UwMDAwMD47DQoNClRoZSBNTUlPIHNwYWNlIGlzIHNwbGl0ZWQgdG8gMk1CIElPIHNwYWNlIGFu
ZCA2Mk1CIE1FTSBzcGFjZSwgdGhhdCdzDQpjYXVzZSB0aGUgY3VycmVudCByaXNrIG9mIHRoZSBN
RU0gc3BhY2UgcmFuZ2UsIGl0cyBhY3R1YWwgYXZhaWxhYmxlIE1FTQ0Kc3BhY2UgaXMgMzJNQi4g
QnV0IGl0IHN0aWxsIHdvcmtzIGZvciBub3cgYmVjYXVzZSBtb3N0IG9mIHRoZSBkZXZpY2VzDQpv
bmx5IHJlcXVpcmUgYSB2ZXJ5IHNtYWxsIGFtb3VudCBvZiBNRU0gc3BhY2UgYW5kIHdpbGwgbm90
IHJlYWNoIHJhbmdlcw0KaGlnaGVyIHRoYW4gMzJNQi4NCg0KU28gZm9yIHRoZSBjb25jZXJuIG9m
IHJlYWNoaW5nIHRoZSBtYXhpbXVtIHRyYW5zbGF0aW9uIHRhYmxlIG51bWJlciwgSQ0KdGhpbmsg
bWF5YmUgd2UgY2FuIGp1c3QgcHJpbnQgdGhlIHdhcm5pbmcgbWVzc2FnZSBpbnN0ZWFkIG9mIHJl
dHVybg0KZXJyb3IgY29kZSwgc2luY2UgaXQgc3RpbGwgd29ya3MgYnV0IGhhdmUgc29tZSBsaW1p
dGF0aW9ucyhNRU0gc3BhY2UNCm5vdCBzZXQgYXMgRFQgZXhwZWN0ZWQpLg0KDQpUaGFua3MuDQo+
IA0KPiANCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IEFsZXhhbmRyZQ0K

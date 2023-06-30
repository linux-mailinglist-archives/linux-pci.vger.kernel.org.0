Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0C74393E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF3KUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjF3KU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:20:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9773AB9
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688120419; x=1719656419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nXK122Bi0088FdlUNsj1k8aXwHQk5eNwR1r/5JEIaI4=;
  b=gQH++bjcs6aITELDBkTq08UqZ6daHlnPVNiF8Ls7/qydxwOpHbITbOpH
   I8Lzso+vfvAvdoVHmS5UxEQPCAXM3oN3t25C/Xcr13ehpAWMp1IYvVNw6
   Jz7EVHCbJwZBofxIrmobZaLTqJZse6xvEXP1gC+XXQq2R8hWk2m9K8rpP
   z3pDS/6EA8ipH0XXZYG9LedoNWCyWvZfyHWp26pWGs1mJHEIYiT9Ac51P
   A2zik88BXogs2WRv/NLy0snG7eaB4hKUAX/PUzGpCFogAu6Zy6ER9pg8q
   aJdS/hJOBcuBJSd6cCFHTdpIvkW8GnpF3QzlogsbBK+QRcyhlN8GgKWm5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="359842825"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="359842825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 03:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807725139"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="807725139"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2023 03:20:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 03:20:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 03:20:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 03:20:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 03:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRh3ddjLp734wJY8yrUwQIYi5XMPquEUmJow5GvX8XBJeSRpAGPLDiAdR0Qt1MCteOBoxPQpBNQ8rzFOyr7/bjkOEq/C3+agv0Ak+ytULwhA6FRJHz9FjwSAJPdIeL5U8tT01Sx3C/vXIb1HQATzVjGfcd0NOTEj6YsI3g2C81KSSg0IiNHzsR81W8adhFn6VqJKJ8KR23AyTeL+uwGs/e94vECwdpwYMgGI86Y7p9XvBHtmHx0SjTo5crU2/RKcZIzKvDpE73V5JySRZSqPO3APtzBiDqnMM+BH/8t7YN0hcC1KhLsI9ojjllXUkwuZsRXWiO71rIMDIsvHTOshdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXK122Bi0088FdlUNsj1k8aXwHQk5eNwR1r/5JEIaI4=;
 b=FrmRLYmpSG9UYiQmLBTb3LggTlbFWJggZkds1bfGdUP6DEoSV4Bk/DaZAHV9JIi4kduk3SiMZOJelpIJkmnS0mAlwn1K+2jfzFEIn2ka95QsfZC4M52cSRY5bCdzQ7Uo5HJXJoiu/yvSEVSJ8Ypgg50wBkGkn0fLfxv2YKtHRV/EujywAleusDakSu79j/NIhKP5tw135nBkxuc38jxcpuKwydsDUXqkprUtIZwq/0dElAWac+w2noTYK6Rq6JxZFy1gxCPH2RaGs5n1peb/rndnkKkTgLFtNVWYUYu9MrPKlH9H6KVcPFA+YGM5/7AV3RnblzUcruchbUDnIlUoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) by
 DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.15; Fri, 30 Jun 2023 10:20:15 +0000
Received: from DS7PR11MB6248.namprd11.prod.outlook.com
 ([fe80::f797:e52d:ce60:22d2]) by DS7PR11MB6248.namprd11.prod.outlook.com
 ([fe80::f797:e52d:ce60:22d2%4]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 10:20:15 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/3] PCI: keembay: Remove cast between incompatible
 function type
Thread-Topic: [PATCH 2/3] PCI: keembay: Remove cast between incompatible
 function type
Thread-Index: AQHZqqs3uKnRJlYARU6FWQZIxYonnq+izdhQ
Date:   Fri, 30 Jun 2023 10:20:14 +0000
Message-ID: <DS7PR11MB624839E55D5C39D45F75A503852AA@DS7PR11MB6248.namprd11.prod.outlook.com>
References: <20230629165956.237832-1-kwilczynski@kernel.org>
 <20230629165956.237832-2-kwilczynski@kernel.org>
In-Reply-To: <20230629165956.237832-2-kwilczynski@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6248:EE_|DS0PR11MB7579:EE_
x-ms-office365-filtering-correlation-id: 4deef841-a6f5-4f5c-4585-08db79539818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7TAOgfbFe39ikBJMAomv9Xa99OZX9Ni7U4z/ew1VpY8X3LdilsGL61+PApFnJWNICoWkWxB/f2LYytR3y2RFNvn7JriIVDvjg60Gd/J9bSzepaee8iUlwlnzk2f+LsgnFZIUIerMrw2qUp0qv+VJMtrj9eOtTSoa97VLPToeeAXJ72woWdKrJYGfkcRd92puvsRYiP29DSwtrH5TxafdxHeFu1wk9RjXeJVLyaS/2+S0FFKVOkYzRl8N2mISPfDnNDlmfmoIi1iRKhNJ1mJGjEIm/5a+bWjB0R3AHphESjWu5Wq//tJzK1HQbD+0A94xfnNRxIk+1d/NL7iiUIDS3t+pN6nmFU+e7lmoP04RobkiRtBRL1IOEr1Sj2zXTzPelzNwWjflxWu4Fw4dmjZe+skgdlXUTNHjd06/RAPuBL+pK1c7Rmq1NJMTQidxQNBgOPMks50Bv86ZWeT3ElUWZtvfVsKwZODW2DndER049HS13YMyKDhXdM9n8jeTlXFPk/JqJwEQyZLqxxj4en4KAryJLp9LC1t6qZJEx6+E6+LRSfXUSo0Nerb123AfwFP0YGt04XFdp3T5e/CyyUF0IVu66fuDi1rhjfGU9+jGtjyNQkb8/q1xvg3kmlSoXP/X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6248.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(38070700005)(82960400001)(38100700002)(122000001)(33656002)(86362001)(76116006)(55016003)(4326008)(8676002)(41300700001)(7416002)(6506007)(5660300002)(478600001)(53546011)(8936002)(26005)(9686003)(52536014)(186003)(83380400001)(66574015)(2906002)(54906003)(66446008)(66946007)(71200400001)(66476007)(66556008)(7696005)(110136005)(316002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1pmN2dyUmlqckNjK0U4akhSZEFVSk5FK2hFU1F1UWFRc1JLa0dnYkhDbjhn?=
 =?utf-8?B?S3NMUzZ0QXgybll3emlKNEJPdTE4UDJyWW1YckdPRFB3MzZXNTJ1WnZnbEVp?=
 =?utf-8?B?cElGV0ZjeU1rMGFLUXVVRGRRVG9QN204VWJKWlRvcE1maUNZYVlZbEExdVJ1?=
 =?utf-8?B?WUhlb1YyRjNUUGQxei9UcjJRNDYrNWp1MDNtZ0R1OTJzNzkrN0hEM1NMSnIr?=
 =?utf-8?B?QmdoZzZsenREaGpMZEJ5SHJOU1lwUzF4NEcvM2lMcUhBZURxZi9aMjJ0am1a?=
 =?utf-8?B?VXArNkV3SVFrM0NOT3RuWWlXK3A2ZGtzUnhyaHJ4dElmRUJUNFR0VFJyUSt2?=
 =?utf-8?B?em9yOUlxRk43MGhxek5UYkFSMmkvQmcwVmpPaUowOHl1Ym4rSnVMRjI2dFpK?=
 =?utf-8?B?Ukh4ZUZtZm00TktXY3pweGZ3NXJOWFRFbWRyRDY0T0lXQlRWY0NPdEdGUU9a?=
 =?utf-8?B?RllUb3J4VU94Y0MvNVNZcWRCMmIvTE9NR3dZdWorSDJsZTBEVTdBSXVVeXMz?=
 =?utf-8?B?dnQ0Q1h0SWg3cm9rQ01QNlp2REt4OHV4WjVhUU03cnhLMjZFa3lyOWpnL0Zm?=
 =?utf-8?B?SWVZWkJ2NjhlbldqcnUyRVZJYTJBUksrcnQ5RzVSYnpZSko3QkVZWCtpS0M2?=
 =?utf-8?B?aXJCM0IrSEEyVUhYZ0pCODB6YWJiMFp3NnB1UDdwSHYwNUN4NFhjTVNYSjM1?=
 =?utf-8?B?WE9WbkpLamFKKzBraUJPdXRqTlFyT2FoUmRqWXpDb2d2Sk52WlVCNitpTHZw?=
 =?utf-8?B?ekw4SUx4UEhvY2MrTHpOZjdKanE0cEJNa0hZTlR4aVY5ZmMvRFVENmhkUHlD?=
 =?utf-8?B?bGx6bXFnZ3VDejV0SFRMNHBmNTFMUnp3WjkzQVpnT1NvdmxXZ1dJRHZqeWxB?=
 =?utf-8?B?TVNPeW10UDBQQjRyVG1CWFlSQXB6UlhnT1o3MEtwTTd5YVEyRktlRWJuc3cv?=
 =?utf-8?B?R0NHbWlTb0V1QTYybjZvLzRyUFBOajdUVkY1Z1ZTVlhHMjFUbDBqRmFqT1lz?=
 =?utf-8?B?STZvWEdwUTlqMFRFVklLamwrb055N1RPTzZueEliSE5YN0dmSW5IaExsellP?=
 =?utf-8?B?RTlhUloyZWJLRjJObVpLZlpuLy9vWDlJYW9lbHBubkw2cGROUDZ3VnRDZTRJ?=
 =?utf-8?B?bGNRTDRDNHBNcWZ2VzFPKzZSaFFUSzkvT1ZhRFoyR21QRHdSbGEvNm5ZeUV2?=
 =?utf-8?B?VzdDMlBsNnBkTExNczVyNG53eDgzRmlZMVljTWk2T1A3ZDQ0R1ZBR3FmR2lG?=
 =?utf-8?B?YjMvMFFaaW5DUnhwOHhubGpmcG5BdHNLU29zQWdjMjBtWnNMU0g1ekJDdFBD?=
 =?utf-8?B?QjZkL0ZVeDEwYWlnZmZqK0s1UStyUkk2alhZUzJaT0FLNHRHMjg2SUVFbkgr?=
 =?utf-8?B?RVBuSC9wZWpOOUk1WmJ4RGVqbktzZnBKV3haTFVPaXpiRzdycmNzckVWSWtP?=
 =?utf-8?B?UkxmR1diUnI1bVppN1I2WEpEdkoreUcvSzJMTmdwWXREVEw3M2wxTE9JS3pw?=
 =?utf-8?B?RTlvWWYwdGU0MG1CM1pLT0xPaXdOZ2taU3FZYzFYVTB2NUptQ1hBT0FTRXBC?=
 =?utf-8?B?S1ZnZk8zZmQ2RmNlTDB3WTV0UzdIZ09yYWZlNW5TOTJHaDRiL2gySXVnNUU5?=
 =?utf-8?B?NmtIamNtQ3kyb3hVZWFWYUVCSVdZV3pCT2s0Skp0UWhuUWlQT0N5bXJsT3FP?=
 =?utf-8?B?UmNRK1UwTHdjU3Y3WXhIcllUY3RLd0lMY1BmUUlvWU9nM3h4bDdZOC9pY2pM?=
 =?utf-8?B?SDZZWWRzc0pzY3hqL0VWUlhUN3pGNVNQbE9ycVZydUVBaFo0L0hJYW9SZmlI?=
 =?utf-8?B?OS84K3UzcXVmRUc0S3FsZUFVZ0FyanVhWUQxN0ZQTDQ5dnJVYmEzMHE1Y0VM?=
 =?utf-8?B?dHpMa3lVOGZmZUYvVWtST0pLQXU0SmZoTllhM1dRRzBnaytneDY3UGZTVU15?=
 =?utf-8?B?UStUSDZhTnBta2l2UjRqMDRISFc0L3QwMlZ5NFdaaTV4R1ZCODdyT3VMbjlv?=
 =?utf-8?B?UU9sU0Jzb2lrbERJV2pCaHlyelhZYlpNOXNvemliZXBxQVFWWmJnN0k0Qy9s?=
 =?utf-8?B?RFV3NGFUOHdEMzRpVUtCakh3Z0t1SzYvMVA5bm5UL1pOd3ZmU3Z1Y1J6Z3h2?=
 =?utf-8?Q?hrOeel99XvCxgk1/75Tz5dLeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6248.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deef841-a6f5-4f5c-4585-08db79539818
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 10:20:14.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do95RiEtg3Jr8m0jpkUYYzrxJTsBHIv0/touC7j9unSg+qdkv6Yiw7xE2zhi5nbQmGeHRJjPbyBAa0Rs5qOW09oDdQnEi9Uf+MXqujgross=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI5LCAy
MDIzIDEwOjMwIFBNDQo+IFRvOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0K
PiBDYzogTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47IFJvYiBIZXJy
aW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBZdWUgV2FuZyA8eXVlLndhbmdAQW1sb2dpYy5jb20+
OyBOZWlsIEFybXN0cm9uZw0KPiA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz47IEtldmluIEhp
bG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+OyBKZXJvbWUNCj4gQnJ1bmV0IDxqYnJ1bmV0QGJh
eWxpYnJlLmNvbT47IE1hcnRpbiBCbHVtZW5zdGluZ2wNCj4gPG1hcnRpbi5ibHVtZW5zdGluZ2xA
Z29vZ2xlbWFpbC5jb20+OyBUaG9rYWxhLCBTcmlrYW50aA0KPiA8c3Jpa2FudGgudGhva2FsYUBp
bnRlbC5jb20+OyBEYWlyZSBNY05hbWFyYQ0KPiA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNv
bT47IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+Ow0KPiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LQ0KPiBhbWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDIvM10gUENJOiBrZWVtYmF5OiBSZW1v
dmUgY2FzdCBiZXR3ZWVuIGluY29tcGF0aWJsZQ0KPiBmdW5jdGlvbiB0eXBlDQo+IA0KPiBSYXRo
ZXIgdGhhbiBjYXN0aW5nIHZvaWQoKikoc3RydWN0IGNsayAqKSB0byB2b2lkICgqKSh2b2lkICop
LCB0aGF0DQo+IGZvcmNlcyBjb252ZXJzaW9uIHRvIGFuIGluY29tcGF0aWJsZSBmdW5jdGlvbiB0
eXBlLCByZXBsYWNlIHRoZSBjYXN0DQo+IHdpdGggYSBzbWFsbCBsb2NhbCBzdHViIGZ1bmN0aW9u
IHdpdGggYSBzaWduYXR1cmUgdGhhdCBtYXRjaGVzIHdoYXQNCj4gdGhlIGRldm1fYWRkX2FjdGlv
bl9vcl9yZXNldCgpIGZ1bmN0aW9uIGV4cGVjdHMuDQo+IA0KPiBUaGUgc3ViIGZ1bmN0aW9uIHRh
a2VzIGEgdm9pZCAqLCB0aGVuIHBhc3NlcyBpdCBkaXJlY3RseSB0bw0KPiBjbGtfZGlzYWJsZV91
bnByZXBhcmUoKSwgd2hpY2ggaGFuZGxlcyB0aGUgbW9yZSBzcGVjaWZpYyB0eXBlLg0KPiANCj4g
UmVwb3J0ZWQgYnkgY2xhbmcgd2hlbiBidWlsZGluZyB3aXRoIHdhcm5pbmdzIGVuYWJsZWQ6DQo+
IA0KPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5jOjE3MjoxMjog
d2FybmluZzogY2FzdCBmcm9tDQo+ICd2b2lkICgqKShzdHJ1Y3QgY2xrICopJyB0byAndm9pZCAo
Kikodm9pZCAqKScgY29udmVydHMgdG8gaW5jb21wYXRpYmxlDQo+IGZ1bmN0aW9uIHR5cGUgWy1X
Y2FzdC1mdW5jdGlvbi10eXBlLXN0cmljdF0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAodm9pZCgqKSh2b2lkDQo+ICopKWNsa19kaXNhYmxlX3VucHJlcGFyZSwN
Cj4gDQo+IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IE5vIGZ1bmN0
aW9uYWwgY2hhbmdlcyBhcmUgaW50ZW5kZWQuDQo+IA0KPiBGaXhlczogMGM4N2Y5MGI0YzEzICgi
UENJOiBrZWVtYmF5OiBBZGQgc3VwcG9ydCBmb3IgSW50ZWwgS2VlbSBCYXkiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1rZWVtYmF5LmMgfCAxMSAr
KysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWtlZW1iYXkuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5j
DQo+IGluZGV4IGY5MGYzNmJhYzAxOC4uMjg5YmZmOTlkNzYyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWtlZW1iYXkuYw0KPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWtlZW1iYXkuYw0KPiBAQCAtMTQ4LDYgKzE0OCwxMyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGtlZW1iYXlfcGNpZV9vcHMgPSB7DQo+ICAJ
LnN0b3BfbGluawk9IGtlZW1iYXlfcGNpZV9zdG9wX2xpbmssDQo+ICB9Ow0KPiANCj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBrZWVtYmF5X3BjaWVfZGlzYWJsZV9jbG9jayh2b2lkICpkYXRhKQ0KPiAr
ew0KPiArCXN0cnVjdCBjbGsgKmNsayA9IGRhdGE7DQo+ICsNCj4gKwljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoY2xrKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgY2xrICprZWVt
YmF5X3BjaWVfcHJvYmVfY2xvY2soc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJCQkJICAgY29u
c3QgY2hhciAqaWQsIHU2NCByYXRlKQ0KPiAgew0KPiBAQCAtMTY4LDkgKzE3NSw3IEBAIHN0YXRp
YyBpbmxpbmUgc3RydWN0IGNsaw0KPiAqa2VlbWJheV9wY2llX3Byb2JlX2Nsb2NrKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiAN
Cj4gLQlyZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LA0KPiAtCQkJCSAgICAgICAo
dm9pZCgqKSh2b2lkICopKWNsa19kaXNhYmxlX3VucHJlcGFyZSwNCj4gLQkJCQkgICAgICAgY2xr
KTsNCj4gKwlyZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBrZWVtYmF5X3BjaWVf
ZGlzYWJsZV9jbG9jaywNCj4gY2xrKTsNCg0KDQpBY2tlZC1ieTogU3Jpa2FudGggVGhva2FsYSA8
c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+DQoNClRoYW5rIHlvdS4NCg0KU3Jpa2FudGgNCg0K
PiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+IA0KPiAtLQ0KPiAyLjQx
LjANCg0K

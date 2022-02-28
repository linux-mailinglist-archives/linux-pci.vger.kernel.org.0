Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4124C77CB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 19:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiB1Sbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiB1Sb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 13:31:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624EECC51;
        Mon, 28 Feb 2022 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646072074; x=1677608074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DcZTiUUiBjHFJj2MZz+FYV8ZvD9vOmQ2JHAbxXu/5gc=;
  b=m4ZQ1hQsk179/NYScR9C0gm1RVerFchatjnKf+fSd/TtET6WhvWp7zZj
   JpavcPLkTNwaBKIKwE97Xnoo3vZ+4F7Kwgy2fHf/Oah6n58izZ411vO4m
   hXAIgZ5RdyYnwzKMpbqMqVwNpo+jCpc9uR7G2Y6Zf2Ul/xMyCYQXn15Wn
   qw67Vxzln2xsHt+kBdJQyUvkq0YDALI4HoE20dsyUM3l+Me44tg27LGJq
   M9FOZiXRh9Svj3mM1fUscWVpkLR3l3V5mtsMLhHQahXLSSSFHb3l8HTFl
   mIn9Z3VlXNZBGH0eFCYhZuQggKTwrE23VHpU0NQYju6/sfd15MuRO7C+T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253142562"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253142562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685427629"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 10:13:33 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 10:13:32 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 10:13:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 10:13:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 10:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwStoYi0usRMKI+UlX2ezP/9w6dnxzRqYPB8740xatdKjbd5IW034VBpa/VtPkL5rgJfBPT3GXF0iUDK6uTxuogsqp4vq03vpW/DhPUZ7aIqjcEQIWBw0Lk1RweyZkY+FSuuoDZayJqW7QioBdYj9MuXwEM7p8/9HC3jMcP1RCPYvWuA4/PkluAVbPfueiwJn0yd8ZAWnmBJ5zOCO1zTeRP8WjCfs0FeUEniv3HTWO6RhZSMoechzXRJI1AN9S/2PCpXGbvjaVKv+hwuhW7R0bS80l/k/36s7hLnF15y/HMRlaxSazZ/BW3Q+HiTfqTSYd10Hj7v40+9gM1FSghCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcZTiUUiBjHFJj2MZz+FYV8ZvD9vOmQ2JHAbxXu/5gc=;
 b=TTyJo7CFWnpDhw67dwHOrYCfpbwuWHzTO0f/WMC+UQZOxH9Nz8STwPn6tCG1IB05T6V17SaFqooPcLksszwJB3It7a0KXM+6vBKXXGz3DaAU5qo/Vf79XgIyCL/mCE0JJkMKFRsxNpmE0Y5ZU975bBtl/LqxFzHBL5pX2KWC58JqIngadO+CmQueowMupf8b6LVWsihUZCEwXlGzIkgl0FbscLNnGV8yDv/5WRJu9amXnoTK8VllOGslmAR361uHkgGqKhLwd5bsLj5TZF/PwzTxZOg+LWdjk3c7BBmplACQkiXiRnU+frpEGRZAVbnX2LsHUnRKiUKJRHFoqQLrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by BYAPR11MB2695.namprd11.prod.outlook.com (2603:10b6:a02:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 18:13:28 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::99c:4a8a:2144:6163]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::99c:4a8a:2144:6163%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 18:13:28 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "'david.e.box@linux.intel.com'" <david.e.box@linux.intel.com>
Subject: RE: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
Thread-Topic: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
Thread-Index: AQHYJROxOQESMLhOIki95Y7Gjw67BqypQq1g
Date:   Mon, 28 Feb 2022 18:13:27 +0000
Message-ID: <MW3PR11MB452200EBA0E813A1A4E8D8C4A1019@MW3PR11MB4522.namprd11.prod.outlook.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
 <20210804161839.3492053-3-Jonathan.Cameron@huawei.com>
 <CAPcyv4iiZMd6GmyRG+SMcYF_5JEqj8zrti_gjffTvOE27srbUw@mail.gmail.com>
In-Reply-To: <CAPcyv4iiZMd6GmyRG+SMcYF_5JEqj8zrti_gjffTvOE27srbUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a732ff3-8f72-40e4-9892-08d9fae604ea
x-ms-traffictypediagnostic: BYAPR11MB2695:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB2695B2615DD2FF87AF6B0F17A1019@BYAPR11MB2695.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NhKJ16+qZBmpk7y8ts98vOQ/36pnKd7RexERuFWxAoJRagzWGxBK7BnSCMYNT1QFUYW9xQY5K+o+YVphBjOdNV0SvzWmWqmoTof7bSypScEwtcVkAAbgd2H0587yRVtMuZKSXpcN1edN7OMluVg6V43Nc5bQJtc7rvy45R2uK890JVfswTT9ISPy8IK2JC1fChnJDlb71fgjgYR3AGvJyKCI0/5FiI7SzVyOZNqO9v8GrDJesU82NJr6JkUN3RB5BeaKsgK5k6N1ywHRwy5mz2Q5z34Fpe3MwJwGo2C7Tsa6XP+Eimb5+rZ39KpvZt2NpTvCyb9gcF6N0JvoCYR58j9h0Bd7aa1vlK4mKbN/1IW+/ClkC2SrYqxN91dPXQskgI60iWiLtZI1h+IhTOz1gyopamyxshn/knMdy1ukiDzTDWy7jVjBASYk9WGTKf4ElEvZmYRNQ2lRSnxR9ND11AMWAj8xTVovAlq0KFrG31hTM3QwoVMuGArYjmI3KHT4g6Z2/mx5oFWQnUzxJYTEQeAuHv9fxPgpOdxNd0U3wSykq5jt0ApzxWeGkMqOiJh3hKiL/c4cjbOQNFrCqo6bcQwBkJ2FsxCnLQ7kHCtcAl3sC8ZCO0OuOUvJs/McwTQOs6K6mvSgFxXI+Ke2puM8VCmWyeF9/ZynmWFTwwuxlkEcey7HcVE3Fd72m6bi57cofx0wNIkQTC66+W6b1Hzyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(52536014)(55016003)(86362001)(66446008)(8676002)(64756008)(33656002)(4326008)(186003)(26005)(66556008)(66476007)(66946007)(76116006)(38100700002)(6506007)(316002)(83380400001)(9686003)(82960400001)(122000001)(508600001)(53546011)(7696005)(8936002)(54906003)(71200400001)(38070700005)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmpIRkdQWmNxcEN6aktweVRVWWZXbDhnUGNHbFhpVXJBMDBSd25yZEloRlFN?=
 =?utf-8?B?ZEJpMjVCK3drOXVrYUgxclpXc0NDcVh5bDZ3NFRwM0s4SklxRzB6R05EakM3?=
 =?utf-8?B?QkNMcWlwWFpOclJqOW5zcWRiY2hqTzhRdGNiaEdoeG9aNnNQaTM4cStqL2Rx?=
 =?utf-8?B?dlRQalltTnFrclJYZGUvM0pDaCtqSm5tOFZvUmptWUNpVWNsZWFtVEFtTnZK?=
 =?utf-8?B?V0FaZ2VQZGplc1ZsTStjdEZ2cm5jNFovVnRoUTJpNE51WHBNUkJFb1l4UDM2?=
 =?utf-8?B?SkNXZ2w0UHg3dCt3L0x3MzNJNnFHTDRpN2VzRy83eHAyNzlld2tlVHVrZU1X?=
 =?utf-8?B?UmxCM2Z5aWhmSTdPdjREbkh0Q0JEeVJVMzcyMlJjd3YvV3NYMFZIYlBzb0Va?=
 =?utf-8?B?LzlOTVBxNlROanlIaXZ4R2l3bmdiK0M1ZzFQbnZyVGlCUUFzK3d4Qk9nTklF?=
 =?utf-8?B?YlRmaW50alc2ZnFwMWNWdEdIWnZRU0Z3WmJuRTB6aGFhL2xuRnNqS2tlVHVy?=
 =?utf-8?B?VkxKK2RLem93Nmh6dllHYzNubDY1RW02YzlIR0x2ZlFDUWRMZzhFZTY4RzZz?=
 =?utf-8?B?VnBSdTJuYmU5WFE1c2tEZjhtTzdNcXEwZTZtajNRY3k1SGhvbE9MMVMrbWVR?=
 =?utf-8?B?OWU2Q1F6YkJoQ3dOQ2tDbWhya013WlgrMkRFdXFsVHlTdmRzSG9pOW5vU3hN?=
 =?utf-8?B?Z21rbHp2VGdtWkt1eC8wUkwrc0pSUXBoSmhtbFVGQXZHQUxOWXl5RXBMRHhK?=
 =?utf-8?B?UHJIbmU3UWpXQ2NnQmZVamVxNzZVbU1JZEZkN3BBR2FDUXcvbkVRclluSisx?=
 =?utf-8?B?RlhhZWtFL296VFlscDNaajMxdUZWbWNJbW5wcGVXUGwyak5EUnB4N3Q5QnZH?=
 =?utf-8?B?WFMvQ0dGb3VHUUtxQnh4dWZFQkt6dGdFVXVKYkJDbitQNU9tUk5Rb05KZWZm?=
 =?utf-8?B?VUdDVEI4OFBlZytOQy9KNjhXMG4yeUlNazN2Z1JWdlJybmdVY1YzUndxU1kz?=
 =?utf-8?B?Umw3OE5yOWJtRkUvdDVLNy81Mk9FdG9zdzNYcTBFQUtOWGR6eVhEOWNnclc3?=
 =?utf-8?B?ckkrSnVMNU83TXhWbEd0cmdGK0tEZVczT1pRZEYxeURlT3Q1TEJUR2N1QnBw?=
 =?utf-8?B?VVE5a1U5a3c4VjZWODNZMWVuRVpXS2x2YVA1Tk1GQTE5eEdBQUYrcnRDSmdo?=
 =?utf-8?B?RXNUcnQ5SzVLSXJoQlo4bllYTjR1MHFxR3ExbXI4cVB6V0h0dExaRHlkYlFp?=
 =?utf-8?B?SzB1c1ZpWE5oN3ZKYWFEQmRVdjVkMjhYL0hqS0M1b2JjV3lNckNmSVdqWjRP?=
 =?utf-8?B?a0h4M0JYYkN1NlNYYlQrVmJ3VGhCYUJOQVVyNzJ0ZGQ1SnVQQStDQzdobEZV?=
 =?utf-8?B?Unl6OEc4eUZ3M0c5azZKckVPOG9aSGtjN3hxanVoNXdueG1LY1hQNUJqZlla?=
 =?utf-8?B?ZDhsZmVoN0hxVjBkUVUyM1ZmcGFiaWphaDBuVllWd2RiTWFlR1hCVHc4a3FY?=
 =?utf-8?B?ZEtTY0pwOE9GbnlZZlM1U2NXaW91cUwyUmJOZnNZRWlJc1R5TUVmanZ6ODI0?=
 =?utf-8?B?ZnZ2eWgrREIyTVlSdlY1THNONXdQN1YzODIzaFZGaVNxWFdKOThsaDRmU2My?=
 =?utf-8?B?NWY2cXZzb2RzTmlLTVh2ME03aU8zeFBhZUo3ajYwNjdTOTBjZk9CRGQwUEpj?=
 =?utf-8?B?Rk5hbm4rdkd5dTlFZDR3VHVINy9VUE9MbDJCdEtzRURmMWNKM2wwSk9DOTNK?=
 =?utf-8?B?UXVESFV3S2pqZkVYemxVK0dhUytmNUhobXZZRzYxWDU2K1FWRzZyTUxGQ2Zw?=
 =?utf-8?B?Sis1NUVaKzMxVUQwQnk2MkZHL2NYZEs1ZUFiUWdSUU43N2lFdWxxUTJJaU1E?=
 =?utf-8?B?UHAyaGhqQi82RW9KVnk5MERVRVFNWXp2elN6dEw2Q0VpY3kyTllyaC9ncjFD?=
 =?utf-8?B?NkVrM2c0SkQvbTAvUFRqOUNSbWUzYTV3V2lzem9pUkFWNUc5Q3M4dnhXY0NR?=
 =?utf-8?B?M3JSNHVWN1BSSXhTdUJoZ08rNFpYVlU4ZzNMM1hDNjJ0KzYrODF4SFJpZ295?=
 =?utf-8?B?bzBlblNSMXdFNVJNSlYvSmlqMTVVREd3eTFxV2YycjVIdG5KTFYrNFZ5Mmxn?=
 =?utf-8?B?dmYzMDUrcUNpT0MxZDRTMHZPZXo5eVhiUlZhNWJ0THZxem1ETzFkL0RKZkVo?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a732ff3-8f72-40e4-9892-08d9fae604ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 18:13:28.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxnBVkuLD0QR7Qsb41KyCFTn97hWyuuYeT+7jMzEd5OWH+JHw4rur0CQWkbmcWTfTysYEzDpUuH3Jjdwi2ACbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCkknZCBsaWtlIHRvIHRlc3QgdGhpcyBwYXRjaCB3aXRoIGEgY3VzdG9t
IHRyYW5zcG9ydCBidXQgdGhlcmUncyBhIHJlZmVyZW5jZSB0byBzcGRtLmggdGhhdCBpc24ndCBo
ZXJlLiBBbHNvLCBoYXZlIHlvdSBsb29rZWQgYXQgbWVhc3VyZW1lbnQgc3VwcG9ydCB5ZXQ/IFRo
YW5rcy4NCg0KRGF2aWQNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IEZlYnJ1YXJ5IDE4LCAyMDIyIDI6MDYgUE0NCj4gVG86IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0
aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7
IExpbnV4IFBDSSA8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47DQo+IG9wZW4gbGlzdDpLRVlT
LVRSVVNURUQgPGtleXJpbmdzQHZnZXIua2VybmVsLm9yZz47IENocmlzIEJyb3d5DQo+IDxjYnJv
d3lAYXZlcnktZGVzaWduLmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgTG9y
ZW56bw0KPiBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBCam9ybiBIZWxn
YWFzDQo+IDxiam9ybkBoZWxnYWFzLmNvbT47IEplcmVteSBLZXJyIDxqa0Bjb2RlY29uc3RydWN0
LmNvbS5hdT47IEJveCwgRGF2aWQNCj4gRSA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCAyLzRdIHNwZG06IEludHJvZHVjZSBhIGxpYnJhcnkgZm9yIERN
VEYgU1BETQ0KPiANCj4gT24gV2VkLCBBdWcgNCwgMjAyMSBhdCA5OjIzIEFNIEpvbmF0aGFuIENh
bWVyb24NCj4gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBU
aGUgU2VjdXJpdHkgUHJvdG9jb2wgYW5kIERhdGEgTW9kZWwgKFNQRE0pIGRlZmluZXMgbWVzc2Fn
ZXMsIGRhdGENCj4gPiBvYmplY3RzIGFuZCBzZXF1ZW5jZXMgZm9yIHBlcmZvcm1pbmcgbWVzc2Fn
ZSBleGNoYW5nZXMgYmV0d2Vlbg0KPiBkZXZpY2VzDQo+ID4gb3ZlciB2YXJpb3VzIHRyYW5zcG9y
dHMgYW5kIHBoeXNpY2FsIG1lZGlhLg0KPiA+DQo+ID4gQXMgdGhlIGtlcm5lbCBzdXBwb3J0cyBz
ZXZlcmFsIHBvc3NpYmxlIHRyYW5zcG9ydHMgKG1jdHAsIFBDSSBET0UpDQo+ID4gaW50cm9kdWNl
IGEgbGlicmFyeSB0aGFuIGNhbiBpbiB0dXJuIGJlIHVzZWQgd2l0aCBhbGwgdGhvc2UNCj4gdHJh
bnNwb3J0cy4NCj4gPg0KPiA+IFRoZXJlIGFyZSBhIGxhcmdlIG51bWJlciBvZiBvcGVuIHF1ZXN0
aW9ucyBhcm91bmQgaG93IHdlIGRvIHRoaXMgdGhhdA0KPiA+IG5lZWQgdG8gYmUgcmVzb2x2ZWQu
IFRoZXNlIGluY2x1ZGU6DQo+ID4gKiAgS2V5IGNoYWluIG1hbmFnZW1lbnQNCj4gPiAgICAtIEN1
cnJlbnQgYXBwcm9hY2ggaXMgdG8gdXNlIGEga2V5Y2hhaW4gcHJvdmlkZSBhcyBwYXJ0IG9mIHBl
cg0KPiB0cmFuc3BvcnQNCj4gPiAgICAgIGluaXRpYWxpemF0aW9uIGZvciB0aGUgcm9vdCBjZXJ0
aWZpY2F0ZXMgd2hpY2ggYXJlIGFzc3VtZWQgdG8gYmUNCj4gPiAgICAgIGxvYWRlZCBpbnRvIHRo
YXQga2V5Y2hhaW4sIHBlcmhhcHMgaW4gYW4gaW5pdHJkIHNjcmlwdC4NCj4gPiAgICAtIEVhY2gg
U1BETSBpbnN0YW5jZSB0aGVuIGhhcyBpdHMgb3duIGtleWNoYWluIHRvIG1hbmFnZSBpdHMNCj4g
PiAgICAgIGNlcnRpZmljYXRlcy4gSXQgbWF5IG1ha2Ugc2Vuc2UgdG8gZHJvcCB0aGlzLCBidXQg
dGhhdCBsb29rcw0KPiBsaWtlIGl0DQo+ID4gICAgICB3aWxsIG1ha2UgYSBsb3Qgb2YgdGhlIHN0
YW5kYXJkIGluZnJhc3RydWN0dXJlIGhhcmRlciB0byB1c2UuDQo+ID4gICogIEVDQyBhbGdvcml0
aG1zIG5lZWRpbmcgQVNOMSBlbmNvZGVkIHNpZ25hdHVyZXMuICBJJ20gc3RydWdnbGluZw0KPiB0
byBmaW5kDQo+ID4gICAgIGFueSBzcGVjaWZpY2F0aW9uIHRoYXQgYWN0dWFsICdyZXF1aXJlcycg
dGhhdCBjaG9pY2UgdnMgcmF3IGRhdGEsDQo+IHNvIG15DQo+ID4gICAgIGd1ZXNzIGlzIHRoYXQg
dGhpcyBpcyBhIHF1ZXN0aW9uIG9mIGV4aXN0aW5nIHVzZWNhc2VzICh4NTA5IGNlcnRzDQo+IHNl
ZW0NCj4gPiAgICAgdG8gdXNlIHRoaXMgZm9ybSwgYnV0IENIQUxMRU5HRV9BVVRIIFNQRE0gc2Vl
bXMgdG8gdXNlIHJhdyBkYXRhKS4NCj4gPiAgICAgSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2UgYXJl
IGJldHRlciBvZmYganVzdCBlbmNvZGluZyB0aGUNCj4gc2lnbmF0dXJlIGluDQo+ID4gICAgIEFT
TjEgYXMgY3VycmVudGx5IGRvbmUgaW4gdGhpcyBzZXJpZXMsIG9yIGlmIGl0IGlzIHdvcnRoIGEN
Cj4gdHdlYWtpbmcNCj4gPiAgICAgdGhpbmdzIGluIHRoZSBjcnlwdG8gbGF5ZXJzLg0KPiA+ICAq
ICBMb3RzIG9mIG9wdGlvbnMgaW4gYWN0dWFsIGltcGxlbWVudGF0aW9uIHRvIGxvb2sgYXQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9LY29uZmlnICB8ICAgIDMgKw0KPiA+ICBs
aWIvTWFrZWZpbGUgfCAgICAyICsNCj4gPiAgbGliL3NwZG0uYyAgIHwgMTE5Ng0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVz
IGNoYW5nZWQsIDEyMDEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9L
Y29uZmlnIGIvbGliL0tjb25maWcgaW5kZXgNCj4gPiBhYzNiMzA2OTdiMmIuLjBhYTJmZWY2YTU5
MiAxMDA2NDQNCj4gPiAtLS0gYS9saWIvS2NvbmZpZw0KPiA+ICsrKyBiL2xpYi9LY29uZmlnDQo+
ID4gQEAgLTcwNCwzICs3MDQsNiBAQCBjb25maWcgUExETUZXDQo+ID4NCj4gPiAgY29uZmlnIEFT
TjFfRU5DT0RFUg0KPiA+ICAgICAgICAgdHJpc3RhdGUNCj4gPiArDQo+ID4gK2NvbmZpZyBTUERN
DQo+ID4gKyAgICAgICB0cmlzdGF0ZQ0KPiA+IGRpZmYgLS1naXQgYS9saWIvTWFrZWZpbGUgYi9s
aWIvTWFrZWZpbGUgaW5kZXgNCj4gPiAyY2MzNTllYzFmZGQuLjU2NjE2NmQ2OTM2ZSAxMDA2NDQN
Cj4gPiAtLS0gYS9saWIvTWFrZWZpbGUNCj4gPiArKysgYi9saWIvTWFrZWZpbGUNCj4gPiBAQCAt
MjgyLDYgKzI4Miw4IEBAIG9iai0kKENPTkZJR19QRVJDUFVfVEVTVCkgKz0gcGVyY3B1X3Rlc3Qu
bw0KPiA+ICBvYmotJChDT05GSUdfQVNOMSkgKz0gYXNuMV9kZWNvZGVyLm8NCj4gPiAgb2JqLSQo
Q09ORklHX0FTTjFfRU5DT0RFUikgKz0gYXNuMV9lbmNvZGVyLm8NCj4gPg0KPiA+ICtvYmotJChD
T05GSUdfU1BETSkgKz0gc3BkbS5vDQo+ID4gKw0KPiA+ICBvYmotJChDT05GSUdfRk9OVF9TVVBQ
T1JUKSArPSBmb250cy8NCj4gPg0KPiA+ICBob3N0cHJvZ3MgICAgICA6PSBnZW5fY3JjMzJ0YWJs
ZQ0KPiA+IGRpZmYgLS1naXQgYS9saWIvc3BkbS5jIGIvbGliL3NwZG0uYw0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zY2UyMzQxNjQ3ZjgNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvbGliL3NwZG0uYw0KPiA+IEBAIC0wLDAgKzEsMTE5NiBA
QA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+
ICsgKiBETVRGIFNlY3VyaXR5IFByb3RvY29sIGFuZCBEYXRhIE1vZGVsDQo+ID4gKyAqDQo+ID4g
KyAqIENvcHlyaWdodCAoQykgMjAyMSBIdWF3ZWkNCj4gPiArICogICAgIEpvbmF0aGFuIENhbWVy
b24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsj
aW5jbHVkZSA8bGludXgvYXNuMV9lbmNvZGVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9hc24x
X2Jlcl9ieXRlY29kZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2NyZWQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Rldl9wcmludGsu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RpZ3NpZy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
aWRyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9zcGRtLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8Y3J5cHRvL2FrY2lwaGVyLmg+
DQo+ID4gKyNpbmNsdWRlIDxjcnlwdG8vaGFzaC5oPg0KPiA+ICsjaW5jbHVkZSA8Y3J5cHRvL3B1
YmxpY19rZXkuaD4NCj4gPiArI2luY2x1ZGUgPGtleXMvYXN5bW1ldHJpYy10eXBlLmg+DQo+ID4g
KyNpbmNsdWRlIDxrZXlzL3VzZXItdHlwZS5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL3VuYWxpZ25l
ZC5oPg0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogVG9kbw0KPiA+ICsgKiAtIFNlY3VyZSBjaGFu
bmVsIHNldHVwLg0KPiA+ICsgKiAtIE11bHRpcGxlIHNsb3Qgc3VwcG9ydC4NCj4gPiArICogLSBN
ZWFzdXJlbWVudCBzdXBwb3J0IChvdmVyIHNlY3VyZSBjaGFubmVsIG9yIHdpdGhpbg0KPiBDSEFM
TEVOR0VfQVVUSC4NCj4gPiArICogLSBTdXBwb3J0IG1vcmUgY29yZSBhbGdvcml0aG1zIChub3Qg
Q01BIGRvZXMgbm90IHJlcXVpcmUgdGhlbSwNCj4gYnV0IG1heSB1c2UNCj4gPiArICogICB0aGVt
IGlmIHByZXNlbnQuDQo+ID4gKyAqIC0gRXh0ZW5kZWQgYWxnb3JpdGhtLCBzdXBwb3J0Lg0KPiA+
ICsgKi8NCj4gPiArLyoNCj4gPiArICogRGlzY3Vzc2lvbnMgcG9pbnRzDQo+ID4gKyAqIDEuIFdv
cnRoIGFkZGluZyBhbiBTUERNIGxheWVyIGFyb3VuZCBhIHRyYW5zcG9ydCBsYXllcj8NCj4gDQo+
IEkgY2FtZSBoZXJlIHRvIHNheSB5ZXMgdG8gdGhpcyBxdWVzdGlvbi4gSSBhbSBzZWVpbmcgaW50
ZXJlc3QgaW4gU1BETQ0KPiBvdXRzaWRlIG9mIGEgRE9FIHRyYW5zcG9ydC4NCj4gDQo+IEhvcGUg
dG8gZmluZCBteSB3YXkgYmFjayB0byB0ZXN0aW5nIHRoZXNlIGJpdHMgb3V0IHNvb24uLi4NCg==

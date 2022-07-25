Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013145803A5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGYRtQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 13:49:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95063E8;
        Mon, 25 Jul 2022 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658771352; x=1690307352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A/3NJmvA3Qnp6czWjvtNeeY86OLURX29LAn6S1qE6B0=;
  b=iBMLA9RpcZpY8v//+NGeVCtM/5yFE7EaFoQEDMCMnMh0xycwqsDOAADR
   MonIIZ4L/r4TStdjm+aDzRlv70OwgeThFvFf+5X4re0WGsA/E1DB2fOuU
   iqn/nc7GCUSlPZO3STL9vbilhjNI7CsEuvbqWpLWJblExJU1VI7xQL84d
   3NJOnwIsjTD1Bgx1o4z1SOMHADGlSSW6U+D0B474WussRgXqSbitsAWRV
   AjOqivlLfuUReUwKXBrh4STZJSeZ0WC/R5dy7ypMgT/kH/XyVPc5uD5TS
   pfaitbtugYtdFZ5vVJ1gLZmlFZ0UIMGCIzK7KiTBrN4kMPo3QRH3pYir0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="106044841"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 10:49:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 10:49:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 25 Jul 2022 10:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNr7qt4+5JOhWhGJVAqS7xG9G0NUNlWTK/3XBsf2Nc0Q/UWptyzGHOoCd7kqaKomHYpU/CNzpiOIIX4X8vWbDKBsWn83YYyUdGTL8RULnAYu0CdE3T4d1aHSetGzvBNUcKRLONpBNXZgQXbbZGO1Di7PZcYpHMvrqYuqRjf4I9z2NyDLRo3QRu0UHfrwV4AplIdTDuelBdkr0G8U+WTaK9zNl0NR4nvCez6uvS3QaOm7TfFltiXywn6I/Hwz/DB1Ho0e05ph6XziLyhCtKg5/unJo/Z9Uj4IQN5bO3hgf5nwnGb8P0N/eZiwXCWhVGsCsEaHwo4pRgE66B4POnEo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/3NJmvA3Qnp6czWjvtNeeY86OLURX29LAn6S1qE6B0=;
 b=W5rMnfbFr0flizKugeBOQfELc5QbgfnPE23QMCy680eu1rR+Rp2BN4FsOgwZp2LjcnMe1p7xKJRw41XZthKDpufgw4wfNkKQmitZ4dHEBweSNRTRhPdPea8yeUZOtqH+JBO/ThrReL0l576TiTA7VgAb298TcD2ANRE6nK+wsbAF5+UHtuZ2/0MlIgeJo/GoVZhMytqC7VG+MRqObLR9s20skFa2aJLXUxaH34QIZSGYOzpVzPs3B5e5cYoRNa2LBqUJTv54DBZbl8m6TVUOoh5jn6+ykvRVooLsP1etkxrjFWV1S26CwGfzbZt9+ppUDwf9YZNRBx8fEl5YfpQ9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/3NJmvA3Qnp6czWjvtNeeY86OLURX29LAn6S1qE6B0=;
 b=Jni3P/dqaP+3OeMNmN+YukOq2BBw4v4pl4GtfclpmNX8iqYEGQbrSeGCrD8nUA7XFv/LChsx2GkSPFXqYTcsWDFecJSa64BEgyWsBi+jdVvn00ju+vWQwiYqhXgWHEI7wMMBJEqrOftz6OqWH4QSrR11IFrnq+adUZPI8V7Hgus=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1901.namprd11.prod.outlook.com (2603:10b6:300:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 17:49:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 17:49:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <maz@kernel.org>, <helgaas@kernel.org>
CC:     <pali@kernel.org>, <johan+linaro@kernel.org>, <kishon@ti.com>,
        <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
        <thierry.reding@gmail.com>, <ryder.lee@mediatek.com>,
        <jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
        <kw@linux.com>, <ley.foon.tan@intel.com>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Thread-Topic: Why set .suppress_bind_attrs even though .remove() implemented?
Thread-Index: AQHYoE7VTW9h5+qDakCXiZkd+IAwpw==
Date:   Mon, 25 Jul 2022 17:49:05 +0000
Message-ID: <e3fb313a-f634-3429-05ea-ebaa98809c71@microchip.com>
References: <20220721222122.GA1754784@bhelgaas>
 <20220722143905.GA1818909@bhelgaas> <87k085xekg.wl-maz@kernel.org>
In-Reply-To: <87k085xekg.wl-maz@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51fc5e3b-4f8d-4cc8-80a7-08da6e65f82a
x-ms-traffictypediagnostic: MWHPR11MB1901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wg0fvyfoFJSf0W4SM+UOuYQ6QUeKZTrmqHheor1ng5yL5SVQpjjKpRxWGXrjZPtPVm29LcG2aKQxRequ5gpq/yVNZl5R2NpbYzHekdV11O5stTTLdyfmCA62OKr6U7VwfNn/wGZ6IaeSgj8/89L4Biri5L1DN/kJVo7o6T6TzU4lhB5+QRc1dQAh8pHoizyrWtBMrQzXogiRaz72QSoW+mq5RwZXDZ2ZsOZ5WLIAV1dI8oznjEnIF7rznVQw+UsyBieAyzgX2KPkSiHpqU/kZJT7wj4d2cxB/DB82gathFxnZ1u09+B97srl4vSkXIkP95qre2bksBgqFtscqq8UfIYJJwVPN5eadgqpiuXyKI2T8yibitZXmEv/as0vE99RU+cBPuRGRzclPOw89Y3w9E+B2sURy3Q2fIBTBj3TE6De5611PqsH+t8TYCNxxbzedh9QmnNfXP+eYtDjGPB9idvKeU+b+tCDLMTDpQ7Yf42yeX19lHxlXt1FA4pixVBcTLUxNdeb/RiK/8WP0wUESmHdzhbRPZDoi1Ar7H8c0eOzlA2tJlIBiTjKUDjC4k4cFFoH/Jx0JJhLsM7frE0oUhm4tbbONtsUoPdPG1h4KXPuXZwQ4nud3I4Y15Vi26evMSX8YWu0Y1t/kwFFs2vrihyiKuXzB4WFmRYXbnczcnUWZ1WeG5t/rB7jhGO1EF5FTVVtjsRD3Ws2aC0V7RlmJBD7CmLi/CwY4CLhGTh0vv2oV/0W5mOBorto+VD/tM3ML+qz32aHuZoNCQy5kcX/fohtDyIc8Dj2sT6VI7MGYbW/Dc8AGYC5NZf7wIkYOmzgaTfNyZb9Tp0tJ2WPhjOZlcEoFYDOnwlKj+ldzYC7TNTxFHdH4Hme+WueMGg27lPgqKq/8bSYulXRvUta+5/6QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(346002)(39860400002)(83380400001)(86362001)(122000001)(31696002)(36756003)(6512007)(2616005)(53546011)(31686004)(38070700005)(26005)(186003)(8936002)(38100700002)(107886003)(6506007)(54906003)(478600001)(41300700001)(316002)(110136005)(71200400001)(6486002)(7416002)(91956017)(76116006)(4326008)(66446008)(64756008)(66946007)(8676002)(66556008)(66476007)(2906002)(5660300002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzRXYzIzeWdHc0ptK1NybXBvditOTzdGa2hnVFJWem1WSm5yaXBOZFNuTTl0?=
 =?utf-8?B?RUJGNGM3UEI2YkdLdFpMRDZqdWtXVUJaTXhDM2tzOS9qV0hkQ0lLRkczYU4v?=
 =?utf-8?B?czhlY3NodXlxK2JDWW1YZ01acFBodTNobUU3NEJWMmt1Z1BKVUVBdFJCOUtl?=
 =?utf-8?B?a2RyMU5NU3EybmFEZG11THI0Y3ltcGpFQ1Q4bzF1YnBHdW5LRk1Gc1UrOGJK?=
 =?utf-8?B?YlpVNkk1UnpPNDF2WnlYcTlDMDVGTE5GRkZkc0FuTmZGVW5pZklZb0ZJRVhv?=
 =?utf-8?B?NXBPUXZacFRRcVhNQUhIUWdtbDlUZzVFOW1uK002bERGOTV4d2pQc3Y2czBi?=
 =?utf-8?B?RHMyVmp6azZDajFQMi9OdWQzVGR5UTBRdXMvOW9VZmt4M084cVVmYXBlZURk?=
 =?utf-8?B?a093MDFyQ0hEQ1VxQ3ZhNE0rM3cxSzF5SkI1Q0RXWmYwL3E0UjYxVi9ZYWY5?=
 =?utf-8?B?ZC9ZMjZZakNTODNiaVAvRy81UnBIOXE1dzVJZUtyRTQvSXhmelN6VGJGZG9N?=
 =?utf-8?B?RWZSWXp6cTRmSWFBWWI5K1oxZ2R2S1VxMEgyUFBlbDRLYTZHTWFsRjR1ajdR?=
 =?utf-8?B?OXRXN1g5RGpBZ2d6TzJXVUswektySkcrcGxuVlU1OUVqM1oxaG8wbUNUbDNM?=
 =?utf-8?B?WXozMlYxeG5JZElvVHJPMTg0a1N5QzBVaWRSMnhlazBHcWdmdW13eis0anVL?=
 =?utf-8?B?cnRDR3cvZlZyd2FYTVdJMGt3UWNrU25ZaFcyOXNlRFExbi9Oa29lNnRaaG04?=
 =?utf-8?B?UXBvWXJXWGU2amhsZk9UY2h3cGg2czBiRXJJckEwelNTQ2lRVDNHdzFDbUFh?=
 =?utf-8?B?N3FHTVpJNVoxZTVqS0s2L2crUHBYMWlLWnhZcmhBR0JiUFNoOFR2TzIvRDNU?=
 =?utf-8?B?K3VjZDY3TFhYVktoVGZMT2lDMGk4Kzd6TkRWSjEyMGdlcFdabWNQZDdJaTYx?=
 =?utf-8?B?SVIvdzNkVUVoa2RLUTlyUVhSNTYrenc5d2lIdWl2b2hDNGVhblJGK3h0WjZF?=
 =?utf-8?B?cXlvQnZpU0ViV0pwZGlMT2JheURreXFFS0JkTWtWaGRlbGJ5UU9HVlh2c0Vz?=
 =?utf-8?B?SnZXZVd5M2FLZTN4NTMza0pjdGpuSjY3S09sNnpTNk9ZdlFuUjByaWpRTjFP?=
 =?utf-8?B?YVlkVFhXcjZ0TWM2YmVtU3c3QUZFNG45SExUVjZUZHBBcVhUMVMwNkNtTkU4?=
 =?utf-8?B?bENNZVc5YWR3WVlpdDRnbXFockpQRFNKL2hOdW8zckUzODhMZEdlZ01BUDRy?=
 =?utf-8?B?Rmd2WVdDU0hDU1VlcndGRGRjbmluTmVIV1dhNm1rNndoVXNyS21mUkp4Vitn?=
 =?utf-8?B?djNZVU5XakNwbWNtSld3clM0TGg1dFh5Z2wraDdHZitYWmVMQjFSaEUwRTNO?=
 =?utf-8?B?TmxvYWIxQjVUaVQxZWhMa3lnVGZSZ1VIdmlseTlVK2FYNlRHeEVpOWxjaVdN?=
 =?utf-8?B?Zm9pZGV6TEhzaGRJSG9PcjA4Q3Y4eVNzMndlRXBnaVFtK1BBWTIrV2h1WTNB?=
 =?utf-8?B?Z2NTTmJkcEVadk9oSHF2U3ZsR09RWTRidXl6WTRTeVhOV0ZiK2ZlRDQ1TkVR?=
 =?utf-8?B?S2NTNUoxOHRJbzdYQjdMTlVsRGZhUzFUckd4KzJub0RHT3ROT3crMnd3MzY3?=
 =?utf-8?B?czE5eEZSZzNNcUhGR2tUNk45RXBOdXY2eFpsWDE4RE9oS25GK0ZlemVMdWFI?=
 =?utf-8?B?NDRmZ01FNGRhU2FhU0E2MVdmQUlxekphRkRxcWZNdFRHNU9pc2FjSVJlY0lD?=
 =?utf-8?B?NHMrNklmdTd4enZpZVZxUXhjRXpPUHlKbE5DeGNxeXFlNG1BTzBCOTFwSXpB?=
 =?utf-8?B?aVFCTlk1dHNmM2JWM2FPaVBaYlFkQXd5QkdVOVhqOWdOYkxZR0NySk9uR1I4?=
 =?utf-8?B?YWZxa3h3K0s2UlFYVnVIejJuWVdHTTMvWlQvUVVpQm1SSWxxUFlQekhpTVhp?=
 =?utf-8?B?cU9xRDBMRWYxN1VabExia3dRb0FpSEdhVGRseWRUWVF4TkZrakdQdno0Wkox?=
 =?utf-8?B?eEU1dy9ISHZQUzVZenRQQ1hsMGFTWVRsb2VjUHUwTnd1WGt0a3lKNjNrOEdD?=
 =?utf-8?B?MHNzeE5YcmQ4dHU2Mm9kT3l3U2M3MDRhREdEcGJFRG9PUFpaMllhSElCZXVR?=
 =?utf-8?B?azlWdllpNTc2MmRCMU93NDJzRS9BSUJmWWNqM3VXME1pWHFPRTh0YnZCR2ph?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE4137F006811429C5D1AE6718800F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc5e3b-4f8d-4cc8-80a7-08da6e65f82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 17:49:06.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: so0YDJwR7VR4gdBPaPnwDROVQPLrsOo/j5gZ+moMNogzx1t8HNKZ/BG956GEnMEGPdQq5gE5uWnFMAi52spWPwFXt/BvKkrIJ0uFmWKlz/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1901
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjIvMDcvMjAyMiAxODowNiwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBIaSBCam9ybiwNCj4g
DQo+IE9uIEZyaSwgMjIgSnVsIDIwMjIgMTU6Mzk6MDUgKzAxMDAsDQo+IEJqb3JuIEhlbGdhYXMg
PGhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4gWytjYyBNYXJjLCBjYW4geW91IGNs
YXJpZnkgd2hlbiB3ZSBuZWVkIGlycV9kaXNwb3NlX21hcHBpbmcoKT9dDQo+IA0KPiBJbiBnZW5l
cmFsLCBpbnRlcnJ1cHQgY29udHJvbGxlcnMgc2hvdWxkIG5vdCBoYXZlIHRvIGRpc2NhcmQgbWFw
cGluZ3MNCj4gdGhlbXNlbHZlcywganVzdCBsaWtlIHRoZXkgcmFyZWx5IGNyZWF0ZSBtYXBwaW5n
cyB0aGVtc2VsdmVzLiBUaGF0J3MNCj4gdXN1YWxseSBhIGRpZmZlcmVudCBsYXllciB0aGF0IGhh
cyBjcmVhdGVkIGl0IChEVCwgZm9yIGV4YW1wbGUpLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhh
dCB0aGVzZSBtYXBwaW5ncyBwZXJzaXN0IGV2ZW4gaWYgdGhlIGludGVycnVwdCBoYXMNCj4gYmVl
biByZWxlYXNlZCBieSB0aGUgZHJpdmVyIChpdCBjYWxsZWQgZnJlZV9pcnEoKSksIGFuZCB0aGUg
SVJRIG51bWJlcg0KPiBjYW4gYmUgZnVydGhlciByZXVzZWQuIFRoZSBjbGllbnQgZHJpdmVyIGNv
dWxkIGRpc3Bvc2Ugb2YgdGhlIG1hcHBpbmcNCj4gYWZ0ZXIgaGF2aW5nIHJlbGVhc2VkIHRoZSBJ
UlEsIGJ1dCBub2JvZHkgZG9lcyB0aGF0IGluIHByYWN0aWNlLg0KPiANCj4gRnJvbSB0aGUgcG9p
bnQgb2YgdmlldyBvZiB0aGUgY29udHJvbGxlciwgdGhlcmUgaXMgbm8gc2ltcGxlIHdheSB0bw0K
PiB0ZWxsIHdoZW4gYW4gaW50ZXJydXB0IGlzICJ1bnVzZWQiLiBBbmQgZXZlbiBpZiBhIGRyaXZl
ciB3YXMNCj4gb3ZlcnplYWxvdXMgYW5kIGNhbGxlZCBpcnFfZGlzcG9zZV9tYXBwaW5nKCkgb24g
YWxsIHRoZSBwb3NzaWJsZQ0KPiBtYXBwaW5ncyAoYW5kIG1hZGUgc3VyZSBubyBtYXBwaW5nIGNv
dWxkIGJlIGNyZWF0ZWQgaW4gcGFyYWxsZWwpLCB0aGlzDQo+IGNvdWxkIHJlc3VsdCBpbiBhIGJ1
bmNoIG9mIGRhbmdsaW5nIHBvaW50ZXJzIHNob3VsZCBhIGNsaWVudCBkcml2ZXINCj4gc3RpbGwg
aGF2ZSB0aGUgaW50ZXJydXB0IHJlcXVlc3RlZC4NCj4gDQo+IEZpeGluZyB0aGlzIGlzIHByZXR0
eSBoYXJkLCBhcyBJUlEgZGVzY3JpcHRvcnMgYXJlIGxlYWt5ICh5b3UgY2FuDQo+IGVpdGhlciBo
YXZlIGEgcG9pbnRlciB0byBvbmUsIG9yIGp1c3QgYW4gSVJRIG51bWJlciAtLSB0aGV5IGFyZQ0K
PiBzdHJpY3RseSBlcXVpdmFsZW50KS4gU28gaW4gZ2VuZXJhbCwgYmVpbmcgYWJsZSB0byByZW1v
dmUgYW4gaW50ZXJydXB0DQo+IGNvbnRyb2xsZXIgZHJpdmVyIGlzIGF0IGJlc3QgZnJhZ2lsZSwg
YW5kIEknbSB0cnlpbmcgbm90IHRvIGdldCBtb3JlDQo+IG9mIHRoaXMgaW4gdGhlIHRyZWUuDQo+
IA0KDQpTb3JyeSB0byBidXR0IGJhY2sgaW4gaGVyZSAtIGJ1dCBJIGFtIHRha2luZyB0aGlzIHRv
IG1lYW4gdGhhdCByYXRoZXINCnRoYW4gYWRkIGEgcmVtb3ZlIGNhbGxiYWNrIGZvciB0aGUgbWlj
cm9jaGlwIHBjaSBjb250cm9sbGVyIGRyaXZlciB3aGVuDQptYWtpbmcgaXQgYnVpbGRhYmxlIGFz
IGEgbW9kdWxlIGl0IHdvdWxkIGluc3RlYWQgYmUgYmV0dGVyIHRvIGZvcmdvIHRoYXQNCmVudGly
ZWx5IGFuZCBwcmV2ZW50IHVubG9hZGluZyB0aGUgbW9kdWxlIChzaW5jZSBpdCBkb2VzIElOVFgg
JiBNU0kpLg0KDQpXb3VsZCB0aGF0IGJlIGFuIGFjY3VyYXRlIGFzc2Vzc21lbnQ/DQpUaGFua3Ms
DQpDb25vci4NCg==

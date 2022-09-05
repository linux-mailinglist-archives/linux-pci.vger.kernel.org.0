Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE465AD58C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIEOyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiIEOyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 10:54:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A554F1B7;
        Mon,  5 Sep 2022 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662389656; x=1693925656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k1Z/locOtpR9qCOt7ipvc1Rd3Ls/D7vrvbU2uXeqq1c=;
  b=iZmUj5TX8K3LQh2L4AUHdXiBl08Dez4Om1IeSZCruQ0IUjd7GEn/MUJU
   e/oWhs5Ika3hbpOY1g/yJb2/IQmHN1NElRFU8UybC6iUdwLmJRgaak6Of
   xx9u8OsLZG8WnLYg7vRWNdUupQa628WCV1sAWQ5j8pI0uoCD8Icrh+5e4
   Lq9VKB60A3ED97nXlVw/uSTNMOBZJ8mpTLVokbiYdzb7j32ILdU09Yvej
   NZAucua4CBQEUfp+F9AOb4MtgsPLQCGsU+Sq0vJ2VAThmESJ89DzLjbMA
   5E8gFlPquJtTZMoEA24xm3fqonU3gURyi6Seyc+CqWnFlelVwtfrfVeCk
   A==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="172439602"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 07:54:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 07:54:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 07:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP0jdKEWjOdOI8ZsRWcN15fEybGtPFpyF9B4pRdDzfd1JerxSL4fe3/LdfXogtFM5QR5CsQl5TWc+ZV/mzQ9nzkMwk+/dbi+kfKD8n+0X2JegUpysO6hdRTp0228N/BoEPYvSYlKliRsQq8nizVRi0o1a5vKEGLnjctjdwrlQsx4WUxNBNNEQNMrUZq+CbfwBsWpxJvMpFQsq86wxGd3HOOWop/+uG99VpMmKY7vErhhBsamL/xoK9s6PlT9wySp5D6tTEPCgUhV9ru4kcxsfBLfUxaSTfE2zIffOXXcq4HBs87aWOfkIl6dctIDjlNVEl+1wafZo5ICwqWkPp2PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1Z/locOtpR9qCOt7ipvc1Rd3Ls/D7vrvbU2uXeqq1c=;
 b=WHKTYd9iWIS/yusYmRhV9U6xFpYWMLiHKSejtm9lN5jEK/0UsTfC/HqxJQZYVzrCADbRfnZzHrDfmfX3DW8u/RvQpBLHidyP/kX6kBvr9DARVYNdSKpVxSWTHpmrkMgjog1AjzIEKBbZghVDh+BiGe51RmkFmKxGW1urSArLtFsxMhIRyx84WozDzshqrg5gIp2aOPG3YcVcBXNOKvnLInVJqdxhjkdYy3SBm+qaOdDCaPZgbOJQKuWHykSIMJUrLXz3J5dF6jbYVkz+uhLXYNGn5rORal+WwCd9ZR3tp7bYCGo9LEhwZJWkIXZz26tNLRhuDKXvyOUTy3g+QSdu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1Z/locOtpR9qCOt7ipvc1Rd3Ls/D7vrvbU2uXeqq1c=;
 b=tGtCnNgS/oEwgHSLNBvy6a0co7iQopauYmQiCZC8GGIBKx0hNJTxKx/VesjhxF+t6RDa82HMtE5aIEaHvlDtNHtEGf/f/54kkLwZAQSlIONm6diUt8ychzc7rm4bKHUHA7+ROFNCVrEFG7EAUABCci6dt5ex3QM6OT37ukSV3YM=
Received: from DM6PR11MB3258.namprd11.prod.outlook.com (2603:10b6:5:e::27) by
 DM6PR11MB3259.namprd11.prod.outlook.com (2603:10b6:5:5d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.16; Mon, 5 Sep 2022 14:54:07 +0000
Received: from DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::c8cf:c82e:e86e:2db6]) by DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::c8cf:c82e:e86e:2db6%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 14:54:07 +0000
From:   <Daire.McNamara@microchip.com>
To:     <robh+dt@kernel.org>
CC:     <Cyril.Jean@microchip.com>, <linux-riscv@lists.infradead.org>,
        <kw@linux.com>, <Conor.Dooley@microchip.com>,
        <david.abdurachmanov@gmail.com>, <devicetree@vger.kernel.org>,
        <lpieralisi@kernel.org>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <linux-pci@vger.kernel.org>, <Padmarao.Begari@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <bhelgaas@google.com>,
        <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: microchip: add fabric address
 translation properties
Thread-Topic: [PATCH v1 1/4] dt-bindings: PCI: microchip: add fabric address
 translation properties
Thread-Index: AQHYvtd/Zgatyqml9kOZM0lssTSnuq3MVEqAgAScuAA=
Date:   Mon, 5 Sep 2022 14:54:07 +0000
Message-ID: <173950d1b76e13c1476f196afc0e804e93d6e602.camel@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
         <20220902142202.2437658-2-daire.mcnamara@microchip.com>
         <CAL_Jsq+5pKyOL8eu5YhQy9pLATd_gG_D71sR8bUp1GA6kif=nA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+5pKyOL8eu5YhQy9pLATd_gG_D71sR8bUp1GA6kif=nA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f23453d-d075-46de-3ca4-08da8f4e7bdc
x-ms-traffictypediagnostic: DM6PR11MB3259:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jfm1n0fKms1PYpyol4tqwgukKslosw8GDkJ4rrfRXx4zRfxiJrIhdaWrY5AE3M2PMgZwb4lzVLCX6ZRR57dTNC/8U48T213BiLFJ22YLKKHLZQtfiDAQ9RHNRGkM1AhKO1lV655T21i+NlE7XjCPNv/5FqEoCC+vnEVmEAO53EtFyayWcaI05amrwtJf4x71p9N0tzWedBKlkL89f0Z73txertL/yPsPrnfgRwwti76lztPHcuZK8lfURtKNM+PKNiGD4snElHnYlVOf7PtrvJg0IO9idkm7TOdcHtx39SsMg7ehQliXzWjUVwVQ4/REwkUWeWIywa3UaEZkEm1Qu0I2A5YXV+vWpibWMLWt5xVtpeqy+Y7mTkT+8qsWmFTZ2h73HfvVxLeCBUwbAuUczq7g2wB3c6W3uc8USCyRkVZHb2XgPyFuFTj7iYAT06ONdLoo6IDV9eW9lsj3y81GuUzP9c33+AGTAm4QfPORc4uW17W2q4vYxzXw0v64ghCA4LlDlJTq6X9dRmuspvdBkZ5vAJ0Nn0GzLf+3kOjMnVLv1pbmBbOLIDePZFtCVRgyRk+z5uKwhszPmRbIM5dPXi9vuh1vUz8pFA1gDh0nNkte/Vdy9qqzVgeNM59+EId9n4B3rSxLN/R1L+dV7rzOroX4WTN2mkIT0gLl4mAf8PwrlT0Mt9Dhrg4GZugcQgBZCxdfXXUWu3nIa8JG96Fb4HzpDXE1iUbYtLKd8zDcpVnehaKZgAS9c8VmjLpozaUcx9PKq7XcMXuDYlva661bjrHi2WosF5QZdT92aqETE8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(136003)(346002)(2906002)(38070700005)(38100700002)(122000001)(91956017)(66476007)(66556008)(76116006)(66946007)(4326008)(8676002)(316002)(54906003)(64756008)(66446008)(5660300002)(7416002)(6486002)(83380400001)(8936002)(2616005)(26005)(186003)(53546011)(966005)(71200400001)(6506007)(6512007)(41300700001)(478600001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1FT3MzZEcvbTFPYU5Ma1ZJYTd3cW0yN21vSERLS0xaaDJjTkl1MzFIanRa?=
 =?utf-8?B?VlhnQ29HMnRNTkxTWDkxS05RbWJqQ2hTYXlXT0M0cjNpajh2QXJJRVhCMGJt?=
 =?utf-8?B?a3VGNHVmTTRGKzMrTk9GN0dRMStUK1VBTVVXNXNuaFk3emhOZk51bFpCQkZK?=
 =?utf-8?B?ZU5IVlRIb3h2VFdVbWhhdG1YdzA0M2kwd0h4WnE3YmdIL2dlV25VZUsvYXBZ?=
 =?utf-8?B?c2ZBVmc0amVEakRWQk0vSnJ1MGJ3RmRGakxJVHBZN2ZQbkFmbFNUN21JbkVP?=
 =?utf-8?B?WTl1TEFVS25XYkdiTUVCMjlFV1NUd2Q0Tm1jeitLRU9tVTd6SzRuaGpyV1o2?=
 =?utf-8?B?bkF3ZUErTlFDSi9iV2toSEhnbFNLQjkzOWRzb2pjSnBTbElFYVJndXpHd1N3?=
 =?utf-8?B?OEtrTXovdDZ1aUdEMWF3TmVLMmZaSEJkTHdxeFBmOFFnZTI0MDIycjBYbUEx?=
 =?utf-8?B?N2tSQk0rMnBFeXB3L2ExU2ROalMyQzZodWczTTZpeFA4c1hSN1dESllualht?=
 =?utf-8?B?RXdpN1FGMTdqaUVTRFlzdXNWeDQwU1FCTC9ScDE4MU1GMFdVRjNvWjBTeUhC?=
 =?utf-8?B?MWtSTWN3T0ZIUlFpOTdKR0lRdVk2QmhZTzN1SXNUWncyTzF3bDBJK1hvM3ZI?=
 =?utf-8?B?UmJZWVVYMDM0N1Z5SXlzYkhSbzFrTTJnZkFkWU5Pd3RNenhjQ2hLcXdSZXEz?=
 =?utf-8?B?ZTlWYTNlUW8yYUErS2RVYjBhUlUzbDh0cW4ySllKNEl6cHh3aTI0aUdacGdN?=
 =?utf-8?B?OFhCWHJWK2ZLazhQak13aFZBV1VNVnN2cm12ZVBwb2phbGpFNDl3d0ZNdGtF?=
 =?utf-8?B?L0hDd3c5ZW45MzFldDhNNVBWNEVFbXFUMFVOTzJhTEZzSlZ6M0dUU3YyR1kv?=
 =?utf-8?B?NktTcmNTTnRIazVkbVd2bzVGak4wMDZZaTRidWgvQzN5cFR6QURMVGNlNERI?=
 =?utf-8?B?NFFQWkhyWTRVcWVZWGpKbUhNZ0pRbHpaUzhpc3RFWTJhQjMzWmhlOG5KUWsv?=
 =?utf-8?B?NkV0UFFyV2JhbHFyK0ZuNS85NXFUb1hxQXBUbjJ1YklQL29taVJ3eGluOTBs?=
 =?utf-8?B?Y00yUDcra3ovUjFMVzRYSFhoOTZCRVl5WjZkcmc4VkdWRkExRmlZMjJjc0JE?=
 =?utf-8?B?azhtODdyRE53aFlnTmcwWENQWDJVeHRSQ1dvY3Z3YlQ4NmtQZndiSFE3VWxr?=
 =?utf-8?B?a0RhMWhlWjFXU0cxbTEreU81dkJKRnovakI0RGdWdE10dmZsTjlHa1RHNWVW?=
 =?utf-8?B?MzJSQkNVNS81WEtSRjR4UDltUjdCRU1vZ2daL09yQ0FLMjZLWmsvZWwzL2NG?=
 =?utf-8?B?T1JTY3dwNXQ0Vmw0ckpzbU1NdWZjbE9xVzIySGk3M05CdGtpTTIwU3ZhUTFi?=
 =?utf-8?B?NUlnWkE3dFZEVHJybHB5N0g2Tyt5aldWemJSc2hPUjN6QTBhNmtreHR1OEtk?=
 =?utf-8?B?cmZYYm9oVkZaTzFNZnRxUmZTQnNNV2ZKM0drdWZnbkpxeTY2VUZWd3JmdEYx?=
 =?utf-8?B?aTd4TFhId3M2NmtzWno4T3VldWtOdldUNHJHbGIwVmQ4ZU91REVQb2Z3YytS?=
 =?utf-8?B?cGo5R2xid05xWlAvelJ3cm5uMVMxN1BPZ0w3SU9PR3JweHJ6aEI1TnVHWWMr?=
 =?utf-8?B?ZE93TC9OcFRuZGV1cUdlSmt1Q2ZGa1RYYjlWSmhDWEpXcHM2Ti9jOGRBdTBn?=
 =?utf-8?B?RmNrb3lBT2gyVUd4T2ZLL0pHVml3S1RXdzRMdXVwY0lCMlA3alJCMk90TC9q?=
 =?utf-8?B?dVE0VnhPWSs1U2dtRkNVclYweXRyTE10VHBYZ1c1c3hHV3VidGR1WWUrelRC?=
 =?utf-8?B?MGtvVVdlcXJGTGVzdllaNzBIVDZFZ1ZTb2lkcjJRQVI2NERpaHF1M1E2STVU?=
 =?utf-8?B?K2duMWZseTM0SjNlU1l0ZVhlM0tYcEcxL2lSVkxnbXowc29uaG1ZeTQ2YzNY?=
 =?utf-8?B?NmRabE1aMVRSNnNTc1dSUGV3dWVxendadFBTays3SmxLOTFiT09hOUZrK3Ji?=
 =?utf-8?B?VzhFc0hGL2JOdTJEeExVQkdtaDdNYUV3ZXhlNkpOOVp6TEcySVJrZVBvam50?=
 =?utf-8?B?V2ZlRnBvVTZhTjdsWDFBQjJYMG9uWUxGNFVDcjd6OEJJazN5Zm51ZFVER1U1?=
 =?utf-8?B?TU0xOGxJQjBaTHN1SzV5SGdGak8xY3RrQUtJMWljNGREZkxBU0UyWEQ0RUlS?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB75C36974A7F4DB908FD5567BCA72F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f23453d-d075-46de-3ca4-08da8f4e7bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 14:54:07.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya9kDFpXJgjU5DowslcZ/y9CzYG8jXG1PxYE0ZA2iznjWxeWsSS2yQhapMngCzTjDn4aBGKXA87bTsNkZqtt1I5wruGgFvHgeFW80KShqdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3259
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDExOjI4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIFNlcCAyLCAy
MDIyIGF0IDk6MjIgQU0gPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPiA+
IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ID4gDQo+
ID4gT24gUG9sYXJGaXJlIFNvQyBib3RoIGluLSAmIG91dC1ib3VuZCBhZGRyZXNzIHRyYW5zbGF0
aW9ucyBvY2N1ciBpbiB0d28NCj4gPiBzdGFnZXMuIFRoZSBzcGVjaWZpYyB0cmFuc2xhdGlvbnMg
YXJlIHRpZ2h0bHkgY291cGxlZCB0byB0aGUgRlBHQQ0KPiA+IGRlc2lnbnMgYW5kIHN1cHBsZW1l
bnQgdGhlIHtkbWEtLH1yYW5nZXMgcHJvcGVydGllcy4gVGhlIGZpcnN0IHN0YWdlIG9mDQo+ID4g
dGhlIHRyYW5zbGF0aW9uIGlzIGRvbmUgYnkgdGhlIEZQR0EgZmFicmljICYgdGhlIHNlY29uZCBi
eSB0aGUgcm9vdA0KPiA+IHBvcnQuDQo+ID4gQWRkIHR3byBwcm9wZXJ0aWVzIHNvIHRoYXQgdGhl
IHRyYW5zbGF0aW9uIHRhYmxlcyBpbiB0aGUgcm9vdCBwb3J0J3MNCj4gPiBicmlkZ2UgbGF5ZXIg
Y2FuIGJlIGNvbmZpZ3VyZWQgdG8gYWNjb3VudCBmb3IgdGhlIHRyYW5zbGF0aW9uIGRvbmUgYnkN
Cj4gPiB0aGUgRlBHQSBmYWJyaWMuDQo+IA0KPiBJJ20gc2tlcHRpY2FsIHRoYXQgcmFuZ2VzL2Rt
YS1yYW5nZXMgY2FuJ3QgaGFuZGxlIHdoYXQgeW91IG5lZWQuDQo+IEFueXRoaW5nIGluIHRoaXMg
YXJlYSBpcyBnb2luZyB0byBuZWVkIGp1c3RpZmljYXRpb24gJ3JhbmdlcyBkb2Vzbid0DQo+IHdv
cmsgYmVjYXVzZSB4LCB5LCB6Li4uJy4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWly
ZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwgICAgIHwgMTA3ICsrKysr
KysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTA3IGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KPiA+IGluZGV4IDIzZDk1YzY1YWNm
Zi4uMjliYjFmZTk5YTJlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwN
Cj4gPiBAQCAtNzEsNiArNzEsMTEzIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBtaW5JdGVtczog
MQ0KPiA+ICAgICAgbWF4SXRlbXM6IDYNCj4gPiANCj4gPiArICBtaWNyb2NoaXAsb3V0Ym91bmQt
ZmFicmljLXRyYW5zbGF0aW9uLXJhbmdlczoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1tYXRyaXgNCj4gPiArICAgIG1pbkl0ZW1zOiAxDQo+
ID4gKyAgICBtYXhJdGVtczogMzINCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAg
IFRoZSBDUFUtdG8tUENJZSAob3V0Ym91bmQpIGFkZHJlc3MgdHJhbnNsYXRpb24gdGFrZXMgcGxh
Y2UgaW4gdHdvIHN0YWdlcy4NCj4gPiArICAgICAgRGVwZW5kaW5nIG9uIHRoZSBGUEdBIGJpdHN0
cmVhbSwgdGhlIG91dGJvdW5kIGFkZHJlc3MgdHJhbnNsYXRpb24gdGFibGVzDQo+ID4gKyAgICAg
IGluIHRoZSBQQ0llIHJvb3QgcG9ydCdzIGJyaWRnZSBsYXllciB3aWxsIG5lZWQgdG8gYmUgY29u
ZmlndXJlZCB0byBhY2NvdW50DQo+ID4gKyAgICAgIGZvciBvbmx5IGl0cyBwYXJ0IG9mIHRoZSBv
dmVyYWxsIG91dGJvdW5kIGFkZHJlc3MgdHJhbnNsYXRpb24uDQo+ID4gKw0KPiA+ICsgICAgICBU
aGUgZmlyc3Qgc3RhZ2Ugb2Ygb3V0Ym91bmQgYWRkcmVzcyB0cmFuc2xhdGlvbiBvY2N1cnMgYmV0
d2VlbiB0aGUgQ1BVIGFkZHJlc3MNCj4gPiArICAgICAgYW5kIGFuIGludGVybWVkaWF0ZSAiRlBH
QSBhZGRyZXNzIi4gVGhlIHNlY29uZCBzdGFnZSBvZiBvdXRib3VuZCBhZGRyZXNzDQo+ID4gKyAg
ICAgIHRyYW5zbGF0aW9uIG9jY3VycyBiZXR3ZWVuIHRoaXMgRlBHQSBhZGRyZXNzIGFuZCB0aGUg
UENJZSBhZGRyZXNzLiBVc2UgdGhpcw0KPiA+ICsgICAgICBwcm9wZXJ0eSwgaW4gY29uanVuY3Rp
b24gd2l0aCB0aGUgcmFuZ2VzIHByb3BlcnR5LCB0byBkaXZpZGUgdGhlIG92ZXJhbGwNCj4gPiAr
ICAgICAgYWRkcmVzcyB0cmFuc2xhdGlvbiBpbnRvIHRoZXNlIHR3byBzdGFnZXMgc28gdGhhdCB0
aGUgUENJZSBhZGRyZXNzDQo+ID4gKyAgICAgIHRyYW5zbGF0aW9uIHRhYmxlcyBjYW4gYmUgY29y
cmVjdGx5IGNvbmZpZ3VyZWQuDQo+IA0KPiBTb3VuZHMgbGlrZSB5b3UgbmVlZCAyIGxldmVscyBv
ZiByYW5nZXMvZG1hLXJhbmdlcy4NCj4gDQo+IC8gew0KPiAgICAgZnBnYS1idXMgew0KPiAgICAg
ICAgIHJhbmdlcyA9IC4uLg0KPiAgICAgICAgIGRtYS1yYW5nZXMgPSAuLi4NCj4gICAgICAgICBw
Y2llQC4uLiB7DQo+ICAgICAgICAgICAgIHJhbmdlcyA9IC4uLg0KPiAgICAgICAgICAgICBkbWEt
cmFuZ2VzID0gLi4uDQo+ICAgICAgICAgfTsNCj4gICAgIH07DQo+IH07DQpUaGFua3MgYSBtaWxs
aW9uIGZvciBsb29raW5nIGF0IHRoaXMhIFZlcnkgbXVjaCBhcHByZWNpYXRlZC4NCg0KU28sIHRo
aXMgaXMgd2hhdCBJIHRyaWVkLiAgSSd2ZSBjdXQgZG93biB0aGUgZHRzIEkgdXNlZCB0byB3aGF0
IEkgdGhpbmsgaXMgdGhlIG1pbmltdW0NCmZyYWdtZW50IHRvIGRpc2N1c3MgdGhlIGlzc3VlIEkn
bSBmYWNpbmcuDQoNClNvLCBJIHJlcGxhY2VkIHRoaXMgc3RhbnphOg0KDQpwY2llOiBwY2llQDMw
MDAwMDAwMDAgew0KICAgIC4uLg0KICAgIHJlZyA9IDwweDMwIDB4MCAweDAgMHg4MDAwMDAwPiwg
PDB4MCAweDQzMDAwMDAwIDB4MCAweDEwMDAwPjsNCiAgICByZWctbmFtZXMgPSAiY2ZnIiwgImFw
YiI7DQogICAgcmFuZ2VzID0gPDB4MDAwMDAwMCAweDAgMHgwMDAwMDAwIDB4MzAgMHgwMDAwMDAw
IDB4MCAweDgwMDAwMDA+LA0KICAgICAgICAgICAgIDwweDMwMDAwMDAgMHgwIDB4ODAwMDAwMCAw
eDMwIDB4ODAwMDAwMCAweDAgMHg4MDAwMDAwMD47DQogICAgLi4uDQp9Ow0KDQp3aXRoIHRoaXMg
dHdvLWxldmVsIHN0YW56YToNCg0KZnBnYV9idXM6IGZwZ2EtYnVzIHsNCiAgICAjYWRkcmVzcy1j
ZWxscyA9IDwyPjsNCiAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCiAgICByYW5nZXMgPSA8MCAwIDB4
MzAgMCAweDQwIDA+Ow0KICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQogICAgLi4uDQoN
CiAgICBwY2llOiBwY2llQDAgew0KICAgICAgICByZWcgPSA8MHgwIDB4MCAweDAgMHg4MDAwMDAw
PiwgPDB4MCAweDQzMDAwMDAwIDB4MCAweDEwMDAwPjsNCiAgICAgICAgcmVnLW5hbWVzID0gImNm
ZyIsICJhcGIiOw0KICAgICAgICByYW5nZXMgPSA8MHgwMDAwMDAwIDB4MCAweDAwMDAwMDAgMCAw
eDAwMDAwMDAgMHgwIDB4ODAwMDAwMD4sDQogICAgICAgICAgICAgICAgIDwweDMwMDAwMDAgMHgw
IDB4ODAwMDAwMCAwIDB4ODAwMDAwMCAweDAgMHg4MDAwMDAwMD47DQogICAgICAgIC4uLg0KICAg
IH07DQp9Ow0KDQphbmQgSSByYW4gaW50byB0d28gcHJvYmxlbXM6DQoxKSB0aGUgcmFuZ2VzIHBy
ZXNlbnRlZCB0byB0aGUgZHJpdmVyIHZpYSAgcmVzb3VyY2VfbGlzdF9mb3JfZWFjaF9lbnRyeShl
bnRyeSwgJmJyaWRnZS0+d2luZG93cykgDQogICB3ZXJlIHVuY2hhbmdlZC4gVGhlIHN0YXJ0IGFu
ZCBlbmQgb2YgYm90aCByZXNvdXJjZXMgd2VyZSBzdGlsbCBpbiAweDMwJzAwMDAnMDAwMCBzcGFj
ZSwgDQogICBub3QgMHgwMDAwJzAwMDAgYXMgSSdkIGhvcGVkLiBUaGUgdHdvIGxldmVscyBvZiBy
YW5nZSBoYWQgYmVlbiBhbWFsZ2FtYXRlZCBiZWZvcmUgDQogICBwcmVzZW50YXRpb24gdG8gdGhl
IHJvb3Rwb3J0IGRyaXZlciwgc28gbXkgaW5pdGlhbCBwcm9ibGVtIHdhcyB1bmNoYW5nZWQgLi4u
DQoNCjIpIGEgbmV3IGlzc3VlIGNyb3BwZWQgdXAuIFdoaWxlIHRoZSAnY2ZnJyByZWdpc3RlciBw
cm9wZXJ0eSBpcyBpbiAweDMwJzAwMDAnMDAwMCBzcGFjZSwgDQogICB0aGUgJ2FicCcgaW50ZXJm
YWNlIGlzIGFjdHVhbGx5IGRlbGl2ZXJlZCBvdmVyIGEgc2VwYXJhdGUgRklDIGFuZCBpcyBpbiBh
IDB4NDAwMCcwMDAwIA0KICAgbWVtb3J5IHNwYWNlLiBJbiB0aGUgdHdvLWxldmVsIHN0YW56YSwg
aXQgd2FzIG5vdyBiZWluZyBwcm92aWRlZCB0byB0aGUgcm9vdHBvcnQgDQogICBkcml2ZXIgYXQg
YSBiYXNlIG9mIDB4MzAnNDAwMCcwMDAwIHdoaWNoIGlzIGluY29ycmVjdC4gVGhpcyBpcyB2ZXJ5
IHR5cGljYWwgZm9yIA0KICAgZGVzaWduZXJzIHRvIHJvdXRlIGFicCBvdmVyIGEgZGlmZmVyZW50
IEZJQyB0byBheGkuIA0KDQpJIGhvcGUgSSdtIG1ha2luZyB0aGUgaXNzdWVzIGNsZWFyLg0KDQpB
bnkgc3VnZ2VzdGlvbnMgd2VsY29tZSENCg0KPiANCj4gPiArDQo+ID4gKyAgICAgIElmIHRoaXMg
cHJvcGVydHkgaXMgcHJlc2VudCwgb25lIGVudHJ5IGlzIHJlcXVpcmVkIHBlciByYW5nZS4gVGhp
cyBpcyBzbw0KPiA+ICsgICAgICBGUEdBIGRlc2lnbmVycyBjYW4gY2hvb3NlIHRvIHJvdXRlIGRp
ZmZlcmVudCBhZGRyZXNzIHJhbmdlcyB0aHJvdWdoIGRpZmZlcmVudA0KPiA+ICsgICAgICBGYWJy
aWMgSW50ZXJmYWNlIENvbnRyb2xsZXJzIGFuZCBvdGhlciBsb2dpYyBhcyB0aGV5IHNlZSBmaXQu
DQo+ID4gKw0KPiA+ICsgICAgICBJZiB0aGlzIHByb3BlcnR5IGlzIG5vdCBwcmVzZW50LCB0aGUg
ZW50aXJlIGFkZHJlc3MgdHJhbnNsYXRpb24NCj4gPiArICAgICAgaW4gYW55IHJhbmdlcyBwcm9w
ZXJ0eSBpcyBhdHRlbXB0ZWQgYnkgdGhlIHJvb3QgcG9ydCBkcml2ZXIgdmlhIGl0cyBvdXRib3Vu
ZA0KPiA+ICsgICAgICBhZGRyZXNzIHRyYW5zbGF0aW9uIHRhYmxlcy4NCj4gPiArDQo+ID4gKyAg
ICAgIEVhY2ggZWxlbWVudCBpbiB0aGlzIHByb3BlcnR5IGhhcyB0aHJlZSBjb21wb25lbnRzLiBU
aGUgZmlyc3QgaXMgYQ0KPiA+ICsgICAgICBQQ0llIGFkZHJlc3MsIHRoZSBzZWNvbmQgaXMgYW4g
RlBHQSBhZGRyZXNzLCBhbmQgdGhlIHRoaXJkIGlzIGEgc2l6ZS4NCj4gPiArICAgICAgVGhlc2Ug
cHJvcGVydGllcyBtYXkgYmUgMzIgb3IgNjQgYml0IHZhbHVlcy4NCj4gPiArDQo+ID4gKyAgICAg
IEluIG9wZXJhdGlvbiwgdGhlIGRyaXZlciB3aWxsIGV4cGVjdCBhIG9uZS10by1vbmUgY29ycmVz
cG9uZGFuY2UgYmV0d2Vlbg0KPiA+ICsgICAgICByYW5nZSBwcm9wZXJ0aWVzIGFuZCB0aGlzIHBy
b3BlcnR5LiAgRm9yIGVhY2ggcGFpciBvZiByYW5nZSBhbmQNCj4gPiArICAgICAgb3V0Ym91bmQt
ZmFicmljLXRyYW5zbGF0aW9uLXJhbmdlIHByb3BlcnRpZXMsIHRoZSByb290IHBvcnQgZHJpdmVy
IHdpbGwNCj4gPiArICAgICAgc3VidHJhY3QgdGhlIEZQR0EgYWRkcmVzcyBpbiB0aGlzIHByb3Bl
cnR5IGZyb20gdGhlIENQVSBhZGRyZXNzIGluIHRoZQ0KPiA+ICsgICAgICBjb3JyZXNwb25kaW5n
IHJhbmdlIHByb3BlcnR5IGFuZCB1c2UgdGhlIHJlbWFpbmRlciB0byBwcm9ncmFtIGl0cw0KPiA+
ICsgICAgICBvdXRib3VuZCBhZGRyZXNzIHRyYW5zbGF0aW9uIHRhYmxlcy4NCj4gPiArDQo+ID4g
KyAgICAgIEZvciBlYWNoIHJhbmdlLCB0YWtlIGl0cyBQQ0llIGFkZHJlc3MgYW5kIHNpemUgLSB0
aGVzZSBhcmUgdGhlIFBDSWUNCj4gPiArICAgICAgYWRkcmVzcyAmIHNpemUgZm9yIHRoZSBlbGVt
ZW50LiBUaGUgRlBHQSBhZGRyZXNzIGlzIGRlcml2ZWQgZnJvbSBhIGdpdmVuDQo+ID4gKyAgICAg
IEZQR0EgZmFicmljIGRlc2lnbiBhbmQgaXMgdGhlIGFkZHJlc3MgZGVsaXZlcmVkIGJ5IHRoYXQg
RlBHQSBmYWJyaWMNCj4gPiArICAgICAgZGVzaWduIHRvIHRoZSBDb3JlIENvbXBsZXguIEZvciBh
IHRyaXZpYWwgY29uZmlndXJhdGlvbiwgaXQgaXMgbGlrZWx5IHRvIGJlIHRoZQ0KPiA+ICsgICAg
ICBsb3dlciAzMiBiaXRzIG9mIHRoZSBQQ0llIGFkZHJlc3MgaW4gdGhlIHJhbmdlIHByb3BlcnR5
IGFuZCB0aGUgdXBwZXINCj4gPiArICAgICAgYml0cyBvZiB0aGUgYmFzZSBhZGRyZXNzIG9mIHRo
ZSBGYWJyaWMgSW50ZXJmYWNlIENvbnRyb2xsZXIgdGhlIGRlc2lnbiB1c2VzLg0KPiA+ICsgICAg
ICBPdGhlcndpc2UsIGl0IGlzIHRpZ2h0bHkgY291cGxlZCB3aXRoIHRoZSBkYXRhIHBhdGggY29u
ZmlndXJlZCBpbiB0aGUNCj4gPiArICAgICAgRlBHQSBmYWJyaWMgYmV0d2VlbiB0aGUgcm9vdCBw
b3J0IGFuZCB0aGUgQ29yZSBDb21wbGV4Lg0KPiA+ICsNCj4gPiArICAgICAgRm9yIG1vcmUgaW5m
b3JtYXRpb24gb24gdGhlIHRhYmxlcywgc2VlIFNlY3Rpb24gMS4zLjMsDQo+ID4gKyAgICAgICJQ
Q0llL0FYSTQgQWRkcmVzcyBUcmFuc2xhdGlvbiIgb2YgdGhlIFBvbGFyRmlyZSBTb0MgUENJZSBV
c2VyIEd1aWRlOg0KPiA+ICsgICAgICBodHRwczovL3d3dy5taWNyb3NlbWkuY29tL2RvY3VtZW50
LXBvcnRhbC9kb2NfZG93bmxvYWQvMTI0NTgxMi1wb2xhcmZpcmUtZnBnYS1hbmQtcG9sYXJmaXJl
LXNvYy1mcGdhLXBjaS1leHByZXNzLXVzZXItZ3VpZGUNCj4gPiArDQo+ID4gKyAgICBpdGVtczoN
Cj4gPiArICAgICAgbWluSXRlbXM6IDMNCj4gPiArICAgICAgbWF4SXRlbXM6IDYNCj4gPiArDQo+
ID4gKyAgbWljcm9jaGlwLGluYm91bmQtZmFicmljLXRyYW5zbGF0aW9uLXJhbmdlczoNCj4gPiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1tYXRyaXgN
Cj4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogMzINCj4gPiArICAgIGRl
c2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIFRoZSBQQ0llLXRvLUNQVSAoaW5ib3VuZCkgYWRkcmVz
cyB0cmFuc2xhdGlvbiB0YWtlcyBwbGFjZSBpbiB0d28gc3RhZ2VzLg0KPiA+ICsgICAgICBEZXBl
bmRpbmcgb24gdGhlIEZQR0EgYml0c3RyZWFtLCB0aGUgaW5ib3VuZCBhZGRyZXNzIHRyYW5zbGF0
aW9uIHRhYmxlcw0KPiA+ICsgICAgICBpbiB0aGUgUENJZSByb290IHBvcnQncyBicmlkZ2UgbGF5
ZXIgd2lsbCBuZWVkIHRvIGJlIGNvbmZpZ3VyZWQgdG8gYWNjb3VudA0KPiA+ICsgICAgICBmb3Ig
b25seSBpdHMgcGFydCBvZiB0aGUgb3ZlcmFsbCBpbmJvdW5kIGFkZHJlc3MgdHJhbnNsYXRpb24u
DQo+ID4gKw0KPiA+ICsgICAgICBUaGUgZmlyc3Qgc3RhZ2Ugb2YgYWRkcmVzcyB0cmFuc2xhdGlv
biBvY2N1cnMgYmV0d2VlbiB0aGUgUENJZSBhZGRyZXNzIGFuZA0KPiA+ICsgICAgICBhbiBpbnRl
cm1lZGlhdGUgRlBHQSBhZGRyZXNzLiBUaGUgc2Vjb25kIHN0YWdlIG9mIGFkZHJlc3MgdHJhbnNs
YXRpb24NCj4gPiArICAgICAgb2NjdXJzIGJldHdlZW4gdGhlIEZQR0EgYWRkcmVzcyBhbmQgdGhl
IENQVSBhZGRyZXNzLiBVc2UgdGhpcyBwcm9wZXJ0eQ0KPiA+ICsgICAgICBpbiBjb25qdW5jdGlv
biB3aXRoIHRoZSBkbWEtcmFuZ2VzIHByb3BlcnR5IHRvIGRpdmlkZSB0aGUgYWRkcmVzcw0KPiA+
ICsgICAgICB0cmFuc2xhdGlvbiBpbnRvIHRoZXNlIHR3byBzdGFnZXMuDQo+ID4gKw0KPiA+ICsg
ICAgICBJZiB0aGlzIHByb3BlcnR5IGlzIHByZXNlbnQsIG9uZSBlbnRyeSBpcyByZXF1aXJlZCBw
ZXIgZG1hLXJhbmdlLiBUaGlzIGlzIHNvDQo+ID4gKyAgICAgIEZQR0EgZGVzaWduZXJzIGNhbiBj
aG9vc2UgdG8gcm91dGUgZGlmZmVyZW50IGFkZHJlc3MgcmFuZ2VzIHRocm91Z2ggZGlmZmVyZW50
DQo+ID4gKyAgICAgIEZhYnJpYyBJbnRlcmZhY2UgQ29udHJvbGxlcnMgYW5kIG90aGVyIGxvZ2lj
IGFzIHRoZXkgc2VlIGZpdC4NCj4gPiArDQo+ID4gKyAgICAgIElmIHRoaXMgcHJvcGVydHkgaXMg
bm90IHByZXNlbnQsIHRoZSBlbnRpcmUgYWRkcmVzcyB0cmFuc2xhdGlvbg0KPiA+ICsgICAgICBp
biBhbnkgZG1hLXJhbmdlcyBwcm9wZXJ0eSBpcyBhdHRlbXB0ZWQgYnkgdGhlIHJvb3QgcG9ydCBk
cml2ZXIgdmlhIGl0cw0KPiA+ICsgICAgICBpbmJvdW5kIGFkZHJlc3MgdHJhbnNsYXRpb24gdGFi
bGVzLg0KPiA+ICsNCj4gPiArICAgICAgRWFjaCBlbGVtZW50IGluIHRoaXMgcHJvcGVydHkgaGFz
IHRocmVlIGNvbXBvbmVudHMuIFRoZSBmaXJzdCBpcyBhDQo+ID4gKyAgICAgIFBDSWUgYWRkcmVz
cywgdGhlIHNlY29uZCBpcyBhbiBGUEdBIGFkZHJlc3MsIGFuZCB0aGUgdGhpcmQgaXMgYSBzaXpl
Lg0KPiA+ICsgICAgICBUaGVzZSBwcm9wZXJ0aWVzIG1heSBiZSAzMiBvciA2NCBiaXQgdmFsdWVz
Lg0KPiA+ICsNCj4gPiArICAgICAgSW4gb3BlcmF0aW9uLCB0aGUgZHJpdmVyIHdpbGwgZXhwZWN0
IGEgb25lLXRvLW9uZSBjb3JyZXNwb25kYW5jZSBiZXR3ZWVuDQo+ID4gKyAgICAgIGRtYS1yYW5n
ZSBwcm9wZXJ0aWVzIGFuZCB0aGlzIHByb3BlcnR5LiAgRm9yIGVhY2ggcGFpciBvZiBkbWEtcmFu
Z2UgYW5kDQo+ID4gKyAgICAgIGluYm91bmQtZmFicmljLXRyYW5zbGF0aW9uLXJhbmdlIHByb3Bl
cnRpZXMsIHRoZSByb290IHBvcnQgZHJpdmVyIHdpbGwNCj4gPiArICAgICAgc3VidHJhY3QgdGhl
IEZQR0EgYWRkcmVzcyBpbiB0aGlzIHByb3BlcnR5IGZyb20gdGhlIENQVSBhZGRyZXNzIGluIHRo
ZQ0KPiA+ICsgICAgICBjb3JyZXNwb25kaW5nIGRtYS1yYW5nZSBwcm9wZXJ0eSBhbmQgdXNlIHRo
ZSByZW1haW5kZXIgdG8gcHJvZ3JhbSBpdHMNCj4gPiArICAgICAgaW5ib3VuZCBhZGRyZXNzIHRy
YW5zbGF0aW9uIHRhYmxlcy4NCj4gPiArDQo+ID4gKyAgICAgIEZyb20gZWFjaCBkbWEtcmFuZ2Us
IHRha2UgaXRzIFBDSWUgYWRkcmVzcyBhbmQgc2l6ZSAtIHRoZXNlIGFyZSB0aGUgUENJZQ0KPiA+
ICsgICAgICBhZGRyZXNzICYgc2l6ZSBmb3IgdGhlIGVsZW1lbnQuIFRoZSBGUEdBIGFkZHJlc3Mg
aXMgZGVyaXZlZCBmcm9tIGEgZ2l2ZW4NCj4gPiArICAgICAgRlBHQSBmYWJyaWMgZGVzaWduIGFu
ZCBpcyB0aGUgYWRkcmVzcyBkZWxpdmVyZWQgYnkgdGhhdCBGUEdBIGZhYnJpYw0KPiA+ICsgICAg
ICBkZXNpZ24gdG8gdGhlIENvcmUgQ29tcGxleC4gRm9yIGEgdHJpdmlhbCBjb25maWd1cmF0aW9u
LCB0aGlzIHByb3BlcnR5DQo+ID4gKyAgICAgIGlzIHVubGlrZWx5IHRvIGJlIHJlcXVpcmVkIChp
LmUuIG5vIGZhYnJpYyB0cmFuc2xhdGlvbiBvbiB0aGUgaW5ib3VuZA0KPiA+ICsgICAgICBpbnRl
cmZhY2UpLiAgT3RoZXJ3aXNlLCBpdCBpcyB0aWdodGx5IGNvdXBsZWQgd2l0aCB0aGUgaW5ib3Vu
ZCBkYXRhIHBhdGgNCj4gPiArICAgICAgY29uZmlndXJlZCBpbiB0aGUgRlBHQSBmYWJyaWMgYmV0
d2VlbiB0aGUgcm9vdCBwb3J0IGFuZCB0aGUgQ29yZSBDb21wbGV4Lg0KPiA+ICsgICAgICBJdCBp
cyBleHBlY3RlZCB0aGF0IG1vcmUgdGhhbiBvbmUgdHJhbnNsYXRpb24gcmFuZ2UgbWF5IGJlIGFk
ZGVkIHRvDQo+ID4gKyAgICAgIGFuIEZQR0EgZmFicmljIGRlc2lnbiwgZS5nLiB0byBkZWxpdmVy
IGRhdGEgdG8gY2FjaGVkIG9yIG5vbi1jYWNoZWQNCj4gPiArICAgICAgRERSLg0KPiA+ICsNCj4g
PiArICAgICAgRm9yIG1vcmUgaW5mb3JtYXRpb24gb24gdGhlIHRhYmxlcywgc2VlIFNlY3Rpb24g
MS4zLjMsDQo+ID4gKyAgICAgICJQQ0llL0FYSTQgQWRkcmVzcyBUcmFuc2xhdGlvbiIgb2YgdGhl
IFBvbGFyRmlyZSBTb0MgUENJZSBVc2VyIEd1aWRlOg0KPiA+ICsgICAgICBodHRwczovL3d3dy5t
aWNyb3NlbWkuY29tL2RvY3VtZW50LXBvcnRhbC9kb2NfZG93bmxvYWQvMTI0NTgxMi1wb2xhcmZp
cmUtZnBnYS1hbmQtcG9sYXJmaXJlLXNvYy1mcGdhLXBjaS1leHByZXNzLXVzZXItZ3VpZGUNCj4g
PiArDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgbWluSXRlbXM6IDQNCj4gPiArICAgICAg
bWF4SXRlbXM6IDcNCj4gPiArDQo+ID4gICAgbXNpLWNvbnRyb2xsZXI6DQo+ID4gICAgICBkZXNj
cmlwdGlvbjogSWRlbnRpZmllcyB0aGUgbm9kZSBhcyBhbiBNU0kgY29udHJvbGxlci4NCj4gPiAN
Cj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+IA0K

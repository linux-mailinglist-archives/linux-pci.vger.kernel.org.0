Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59895964A4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiHPVcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbiHPVcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 17:32:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D389CF6;
        Tue, 16 Aug 2022 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660685528; x=1692221528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R/RRK2KoiTAVtVATcrOoPZiEPDHSvb0Ow3PJAiyHZvY=;
  b=k2r8nK54lJ8oCpvA2jvc9p5AT9Q+sPOWQQX1HyUCp4JGd1OWt9wyVqGa
   QSisvhpCFVdzsdyk37kXS01RO1nwZ3JpL6bPzsORjLqbNr1esxHzqrLqT
   nK1+uuT1gKZ5pjeYOuKQH+JE7oK0eTSE47r3XsI14oaUESQUsUxyn6tbo
   jMyRLPj5VzGf6V7uQhV30uZLQb99GORKScIbLbrUnb8Kau0mlo76N4kod
   lqA82Hy4lhwGNVNBxSmviKCcwY+pRkdtp/m5bJNhRhdgr2wQort/XcfoS
   YXso9hpozlqn7ycYHtOtn1D+wrlcmkdIPTXPY2z4DCi2yjXIO6UvhLr9v
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="176663768"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 14:32:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 14:32:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 14:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTxcpNgm4VNRdNhUf2oiWAhikJDWnHGxYtzHDJ7a4B+03Ml4fCAnboTQdsG4iOtRoMYnbZahw1s2r5UTl2NcH1vk8DL2U0TSvsH1afsBCE8ZstOkhfxEPWiMlq1V5dpbyWDbrbKPVpBMVRerj1sTzBlL1877fW5NTv6A77LoI5YVltip0aUyJh7pzio0m9TTHdl/dm4Unyqc76L77cB9/cq8JbC+fTmEVmyXIT8XVncuhpQQ13ELAWPWThlLh6V2Pw/iuRzxFhoZYjdmtAMhXOUayG3aGRlA7HQcj8HuaP2JNuEmmz7NaejMVm10Idl+dlVAcCqqVCmHCk6QowBg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/RRK2KoiTAVtVATcrOoPZiEPDHSvb0Ow3PJAiyHZvY=;
 b=aKTHYntIZ5mHvKqaA7imoNBNkU/3b0qgnTU/DpTEkku6udvRX0frcsanc4/q+WcCWEJVixLQbcRrTX1gwpVUF5z4Xa+Z2GbZyw59cBo6+sLd6N5HsfM31cXuWdd7oDFkyS3kaJIEZf13E9EOZFM7nwB4gsjqNyclKzNI840RtwmjlwUm9g3MOV8+hZCwYQEGe6ehRGjeisXcVhB5W7aow/UDhKn1hReYqLZ2Zp8VHAK0TOpjekrTmttpe0bJ+Uyz5RpeuxyTHfA08uRSlf2+BcDtlbIygcyTcOsMpPT0NqacMOEzan/pNTo21bF/TZ0fwhO13zrqqLU6OKuN8S1ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/RRK2KoiTAVtVATcrOoPZiEPDHSvb0Ow3PJAiyHZvY=;
 b=U40zPpalNU+67zytKsXE636wYXojcaCQk6d4fHYoCTfSTbX+JVmCQ0vMzQV24X2yLiGHa6v+pFRfQTuEg8AyGShHIoi/eYjY0uO+QU5AXTWqdDnP51rhE8dVq+YRWJ9yHOrsSYp0C7cfd+aRU31COzeKd/wWkJOST4akxpSHclQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB4113.namprd11.prod.outlook.com (2603:10b6:405:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 21:32:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 21:32:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jrtc27@jrtc27.com>
CC:     <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <Conor.Dooley@microchip.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: fu740-pci: fix missing
 clock-names
Thread-Topic: [PATCH v2 1/6] dt-bindings: PCI: fu740-pci: fix missing
 clock-names
Thread-Index: AQHYsZ2zar9xBk9R2Emvvo80ZcAbma2yBLeAgAAHSgA=
Date:   Tue, 16 Aug 2022 21:32:01 +0000
Message-ID: <30a33c28-1c80-8d2d-29d1-1e5aa5476af9@microchip.com>
References: <20220816182547.3454843-1-mail@conchuod.ie>
 <20220816182547.3454843-2-mail@conchuod.ie>
 <F62BE8A7-2023-497B-9BBC-AE54E7C5B08A@jrtc27.com>
In-Reply-To: <F62BE8A7-2023-497B-9BBC-AE54E7C5B08A@jrtc27.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b9560aa-7fca-4de4-7d24-08da7fcec177
x-ms-traffictypediagnostic: BN6PR11MB4113:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46nqmI+Y6Wi0j0oE75gUT7JiX4u5yXlV3BrSn3hV0IRJNd9kCgNEl+OYfM9JIrS6VAsJ4DyMGwH1FLrY4u1uEjjjklI/cOzPzN+XRQ1ol91/0erZb+PI4KnQTz4bdikAWl2A4Q8t+bZVQSsMU9noQ+CcxhVcSTglVCw8T0riknzfCsuNI1KvsOld2THk6pU54g7ckeBDn1srVf/nXTBUTR4b4e7Sx9lv4A5bh/CQ2LdfBXseqcwbatvievw1QGegPLxsIry/6E7WzHV5yEhloVMM/nE8ATFAkYsneOZAnbr7wqVfp/2dS5okOeJtsOPo4UzOg1L9y4cQwov/xeIF99nW79bfyteDnp0FUtuA4rjmuQPmUBP9kDr8iQh9npYF0kZqIHWjfx+q2EZ3S9Yr6GOOht50qK1i5VlhM4Xl4NyV3BD8XCokCGATUU17eDKkfeDl6EBdwjJRYpmlqsxq7H1tsfwljTEeCEmaxRTsYFEhltDONr7VfTnnFds0xt3YpVIDrqzWsGOrq8OBZpsoXM0VvnVYLTrsTDAdff3mpq/Lsu6BbpsaHJYv0wJArb/Rrsp4SetDm2TJx+AD9k5oxHQrCnz8Ca8yjiMA7U16Tp0BSYqbam95ZqXUsqgPsuisTs/o429HKe8x8ulivVg6IvP3ABcYd8mwD6QZokO/RKI2mpWGlylC1UbIa5J6lqZOKKRxS08W/AC/vVhNOHDDXE2544m+H2R/YHhyT0TgMsGlqrraQ2kY1q/BUV8vIiEfB8abQYGcnpIf1soJSAx3y5dwAL3lHWG3LEeAjaLgQGjS8r7PjZehvGvhH0H9bn//bMHqjRj9ultKwrIH7G3x4fUX4jmV0hykvcv6JBm373V0pcLTJfyJ35qnCDrWZIbFH836eRoreWmNd2swq3xkLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(376002)(39860400002)(91956017)(76116006)(2906002)(36756003)(38100700002)(31686004)(7416002)(2616005)(186003)(4326008)(122000001)(83380400001)(54906003)(31696002)(26005)(86362001)(6512007)(8936002)(41300700001)(6916009)(5660300002)(6506007)(53546011)(478600001)(8676002)(66476007)(6486002)(966005)(66556008)(316002)(66446008)(66946007)(71200400001)(38070700005)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RBS1dxWUFiYUcvTHhPeWR3RnpSYXNNZEhRSUxsWG9LU28xTE5Sdk93T3VB?=
 =?utf-8?B?Y3lnM3FiWHBjUi9JSUNaclJOc3pRTS9RMlowZGk5NWQrcjE0dVhhNDJUdUVy?=
 =?utf-8?B?SE9UUi9wNkRaTjJyMFpwWHNMNDVnempya1M1bFI3U20yUXJmbFV0Y1gzQ0lX?=
 =?utf-8?B?ZUdBeDdHc3gyOUNMd2l6WEE3dUovMG9LZnZ5aHF4SXBRVVNiYlV3QXh2aU1L?=
 =?utf-8?B?UmI3Y2dRYzNXZzhVSVNPZXJCKzVielFBd3liZ1A4VXVaWGNQcEI4L0VqVkFD?=
 =?utf-8?B?RUpBdTUzb3lBdWhmaHYycU9najVpdUlHdk9rKzQ2RzZJRnFyTDFLelJiNGFU?=
 =?utf-8?B?RUJ2cFp5OTFiYkdQR1d5VldYR3p3dnZDQTNxZFpENEd1b3E0dUx5M29IQjF4?=
 =?utf-8?B?dzRxdGFGcTA1b1NsMlpVZjhvdHo0RUc4dktWUDAvZ24vV0pXWWJCNENJLy9E?=
 =?utf-8?B?VGFyYjRKTU1KcHpleFJnVnl3OVlwR2trcXJ3a3BYWTVPeEI0VGJ6ckVnQTM0?=
 =?utf-8?B?eDdWUEs3ckdOa1VydUJqYWdsdmFFb2VsOWgzSkZDOVEzc0hsUDk5MGozOTYr?=
 =?utf-8?B?WG5qa2NaeDlhbDZRcEhNZWpTOUpLZG9kM2IwRGZwdTdlcithTk8vMUp1ZUh3?=
 =?utf-8?B?ekJFeGs1TWc5RWJxSnloaktXcFNEcHhrbHdVRzlzVlBVR3RXeXZkdXF4bUNr?=
 =?utf-8?B?cTV5K1VXNDE3bGx4amg1UGpsNFRac1lsdGhnRm5Ob1dvSzFaNWJSSG1RTlIw?=
 =?utf-8?B?MUhVbStrUFZmaFNIVW90Y3I1WFpSMW9zSUdUYm5URnhUV00rcHplbitWcG1o?=
 =?utf-8?B?MXh5TlJTVm1sMUpuSG93bFNEb2JBK0xoZ3FHaUZ4QzdNOW83YzI1NUZCcU4r?=
 =?utf-8?B?NUk4QlhEbWNFRlJOWDJmTHJtVjJrb2V1S3RYKzNGYjNJUk1OZDkxS3gxY3BK?=
 =?utf-8?B?enRkRXErc0JTSkpCVVozQ3BJcmtGN2kyY00xb3JDdFQ5VGpWZkUrTm04WkVm?=
 =?utf-8?B?QjdiVkR1dEZhVk9idzR1VjkrTSt5bE9aZTV0MXNDeUNQVFJSK0U4RWxDSnN1?=
 =?utf-8?B?RGgxRWxMdjlrempWWkFDRjJud3Z3bzFsU1VkcDcyWHd2bTZGYnpmd3o2cm9C?=
 =?utf-8?B?TEFaa01XZkZLRWh1dUlLOWlmdkVWQUdwcStucTk5OEZZdExtWitQQUIxQVR2?=
 =?utf-8?B?cnBsUk5IM2Q2U0Noc3Yva3dGSTB6L21IdkVmZGJkUEMrUFQreDN3emt3Mjkz?=
 =?utf-8?B?aDh1SXE1cVEzakJMOWdHU2thMkt0MjZZRDIzZmZxcS95MllPeFdTRzZuTURW?=
 =?utf-8?B?OU1rVnl2QjV3YksvMldzWENkcFNNYjJxYkozOGZsb3d4WWgxNG9DcnRXUUVw?=
 =?utf-8?B?MmhJR2NZSE9ubkVHcjB2RWlKQ2dPcDluSWYvYUk2Y1lnUFhCbFVnZDdsZkMv?=
 =?utf-8?B?K08rWG9LU1dERjJrNG14cFY2NnNVWlVaMjY2NWdUcUxVUUhpSkRPbFN5WUMz?=
 =?utf-8?B?UGVDWHczYjYxWUhXRWNuVG5HaHVOQU1PeDV1ZkNhckZPVkd5K0poVkdkS2pm?=
 =?utf-8?B?bmdyM0o1S3VSTDBRR1RHemdjMTE5K3V1ZGNSenJVZWpZTkVHdll0SmRyMVhs?=
 =?utf-8?B?b1ZxSEhYNDgwNXpBaXVmZzcvNXdnUVRCeTNLQWU3V3BnVndwV1NUYmRhcEhZ?=
 =?utf-8?B?UnhrbEFjK05abkdJcnAwdkszV0lzVkJhUXhiLy96UW93ME9ZNHlIVTBBVkYz?=
 =?utf-8?B?cmJBK1M3cUhEaS9Oa2Vld3dyWVBmL2dJTGVmazJPemZtdzNib0U0QUJsb2k4?=
 =?utf-8?B?NjEyck5oNkFFN084Ri9oQTBCUzJUM251TnJOODBpWUlEZ3JEOVhjdzR5RDRR?=
 =?utf-8?B?eURpTU80czBqcVVidXlreTZPa0s1WFZJdDRHWldGd3I4dDdoaGR6RjVWZ1h2?=
 =?utf-8?B?d083b3VaT3V2N05GR0l1aDA0bkZsVFZMM2Jtc2ZxSy8xK1ZNL3lLbjVFZ1N4?=
 =?utf-8?B?N2IrQk5jUEk4cWhKOURoWU1pU2orbDFRWGxsWXJiM2JZSi9WTFNCbFI4TXRr?=
 =?utf-8?B?cG1adkdDY1VIZnZoQXdIV3JmTmhSRWNYZ2NQeWZGRHRyRHkwSWhWNjR5SlBv?=
 =?utf-8?Q?WqrYqf/dSo6k6spwr6gGmRiGH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43FD4AFD0340834BAE41A24BF224BD8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9560aa-7fca-4de4-7d24-08da7fcec177
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 21:32:01.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5kXll/Gf8SS6ZGGEM7CXGKYmZsyS40GYncgs3LtwxRL9pz1AdT1sWuaWYcdOkT3tRHIyUHXA0OP9wvWeRPeo93t/9/oJWTEuFAqVHyQo6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4113
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTYvMDgvMjAyMiAyMjowNSwgSmVzc2ljYSBDbGFya2Ugd3JvdGU6DQo+IE9uIDE2IEF1ZyAy
MDIyLCBhdCAxOToyNSwgQ29ub3IgRG9vbGV5IDxtYWlsQGNvbmNodW9kLmllPiB3cm90ZToNCj4+
DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4N
Cj4+IFRoZSBjb21taXQgYjkyMjI1YjAzNGMwICgiZHQtYmluZGluZ3M6IFBDSTogZGVzaWdud2Fy
ZTogRml4DQo+PiAndW5ldmFsdWF0ZWRQcm9wZXJ0aWVzJyB3YXJuaW5ncyIpIHJlbW92ZWQgdGhl
IGNsb2NrLW5hbWVzIHByb3BlcnR5IGFzDQo+PiBhIHJlcXVpcmVtZW50IGFuZCBmcm9tIHRoZSBl
eGFtcGxlIGFzIGl0IHRyaWdnZXJlZCB1bmV2YWx1YXRlZFByb3BlcnR5DQo+PiB3YXJuaW5ncy4g
ZHRic19jaGVjayB3YXMgbm90IGFibGUgdG8gcGljayB1cCBvbiB0aGlzIGF0IHRoZSB0aW1lLCBi
dXQNCj4+IG5vdyBjYW46DQo+Pg0KPj4gYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZl
LXVubWF0Y2hlZC1hMDAuZHRiOiBwY2llQGUwMDAwMDAwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGll
cyBhcmUgbm90IGFsbG93ZWQgKCdjbG9jay1uYW1lcycgd2FzIHVuZXhwZWN0ZWQpDQo+PiAgICAg
ICAgRnJvbSBzY2hlbWE6IGxpbnV4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvc2lmaXZlLGZ1NzQwLXBjaWUueWFtbA0KPj4NCj4+IFRoZSBwcm9wZXJ0eSB3YXMgYWxyZWFk
eSBpbiB1c2UgYnkgdGhlIEZVNzQwIERUUyBhbmQgdGhlIGNsb2NrIG11c3QgYmUNCj4+IGVuYWJs
ZWQuIFRoZSBMaW51eCBkcml2ZXIgZG9lcyBub3QgdXNlIHRoaXMgcHJvcGVydHksIGJ1dCBvdXRz
aWRlIG9mDQo+PiB0aGUga2VybmVsIHRoaXMgcHJvcGVydHkgbWF5IGhhdmUgdXNlcnMuIFJlLWFk
ZCB0aGUgcHJvcGVydHkgYW5kIGl0cw0KPj4gImNsb2NrcyIgZGVwZW5kZW5jeS4NCj4gDQo+IEFy
ZSB5b3Ugc3VyZSBhYm91dCB0aGlzPyBJIHNlZSBhIGRldm1fY2xrX2dldCgicGNpZV9hdXgiKSB0
aGF0IHN1cmVseQ0KPiB3b24ndCB3aXRob3V0IHRoZSBwcm9wZXJ0eS4gRnJlZUJTROKAmXMgc2lt
aWxhcmx5IHJlbGllcyBvbiB0aGUgbmFtZSwNCg0KSSdtIGhhdmluZyBhIGJpdCBvZiBhIGhvd2xl
ciB0aGlzIHdlZWsuIEkgcmVhZCB0aGF0IGxpbmUgb2YgY29kZSBhbmQNCmZvciBzb21lIHJlYXNv
biBjYW1lIHRvIHRoZSBjb25jbHVzaW9uIHRoYXQgaXQgZGlkbid0IG1hdGNoIHRoZSBvbmUNCmlu
IHRoZSBkdC4gSSBldmVuIGRpZCBpdCBtb3JlIHRoYW4gb25jZSBnaXZlbiBJIHJlLXdyb3RlIHRo
aXMgY29tbWl0DQptZXNzYWdlLiBBdCBsZWFzdCB5b3UncmUgcGF5aW5nIGF0dGVudGlvbiAmIG15
IGNoYW5nZSBpcyBpbmNvbXBsZXRlDQpyYXRoZXIgdGhhbiBicm9rZW4uLi4NCg0KU2luY2UgdGhl
cmUncyByZWxpYW5jZSBvbiB0aGUgcHJvcGVydHksIGl0IG5lZWRzIHRvIGJlY29tZSByZXF1aXJl
ZC4NCg0KPiB0aG91Z2ggaXQgYWxzbyBoYXMgYSBmYWxsYmFjayB0byB0aGUgVS1Cb290IHBjaWVh
dXggbmFtZSAoYmVjYXVzZSB0aGUNCj4gd29ybGQgaXMgdGVycmlibGUgYW5kIHBlb3BsZSBjYW7i
gJl0IGV2ZW4gYWdyZWUgb24gdGhhdCkgc28gaXQgd29ya3MNCj4gd2l0aCB0aGUgVS1Cb290LXBy
b3ZpZGVkIEZEVCAoaXQgd291bGQgYmUgbmljZSBpZiBMaW51eCBoYWQgdGhpcyBhcyBhDQo+IGdv
YWwsIGFuZCBwZW9wbGUgd29ya2VkIHdpdGggVS1Cb290IGRldnMgdG8gZ2V0IGV2ZXJ5dGhpbmcg
bmVlZGVkIGZvcg0KPiBuZXdseS1leHBvc2VkIGRldmljZXMgbWVyZ2VkIGJhY2sgdGhlcmUgc28g
SSBkb27igJl0IGhhdmUgdG8gYmUgdGhlIG9uZQ0KPiB0byBub3RpY2UgYW5kIGRvIGl0Li4uKS4N
Cg0KRm9yIHBvbGFyZmlyZSB3ZSBhcmUgYSBsaXR0bGUgb3V0IG9mIHN5bmMgJiBwbGFuIG9uIGZp
eGluZyB0aGF0IHNvb25UTS4NCg0KPiANCj4gSmVzcw0KPiANCj4+IEZpeGVzOiBiOTIyMjViMDM0
YzAgKCJkdC1iaW5kaW5nczogUENJOiBkZXNpZ253YXJlOiBGaXggJ3VuZXZhbHVhdGVkUHJvcGVy
dGllcycgd2FybmluZ3MiKQ0KPj4gRml4ZXM6IDQzY2VhMTE2YmUwYiAoImR0LWJpbmRpbmdzOiBQ
Q0k6IEFkZCBTaUZpdmUgRlU3NDAgUENJZSBob3N0IGNvbnRyb2xsZXIiKQ0KPj4gU2lnbmVkLW9m
Zi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gdjIwMjIuMDggb2YgZHQtc2NoZW1hIGlzIHJlcXVpcmVkLg0KPj4gLS0tDQo+PiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvc2lmaXZlLGZ1NzQwLXBjaWUueWFtbCAgICAgICAgICB8IDYg
KysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvc2lmaXZlLGZ1NzQw
LXBjaWUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvc2lmaXZl
LGZ1NzQwLXBjaWUueWFtbA0KPj4gaW5kZXggMTk1ZTZhZmViMTY5Li5jN2E5YTJkYzBmYTYgMTAw
NjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3NpZml2
ZSxmdTc0MC1wY2llLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvc2lmaXZlLGZ1NzQwLXBjaWUueWFtbA0KPj4gQEAgLTUxLDYgKzUxLDEyIEBAIHBy
b3BlcnRpZXM6DQo+PiAgICAgZGVzY3JpcHRpb246IEEgcGhhbmRsZSB0byB0aGUgUENJZSBwb3dl
ciB1cCByZXNldCBsaW5lLg0KPj4gICAgIG1heEl0ZW1zOiAxDQo+Pg0KPj4gKyAgY2xvY2tzOg0K
Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2stbmFtZXM6DQo+PiArICAgIGNv
bnN0OiBwY2llX2F1eA0KPj4gKw0KPj4gICBwd3Jlbi1ncGlvczoNCj4+ICAgICBkZXNjcmlwdGlv
bjogU2hvdWxkIHNwZWNpZnkgdGhlIEdQSU8gZm9yIGNvbnRyb2xsaW5nIHRoZSBQQ0kgYnVzIGRl
dmljZSBwb3dlciBvbi4NCj4+ICAgICBtYXhJdGVtczogMQ0KPj4gLS0gDQo+PiAyLjM3LjENCj4+
DQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1yaXNjdg0KPiANCg==

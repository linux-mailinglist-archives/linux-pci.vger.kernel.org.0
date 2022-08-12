Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9F590D0F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiHLH6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 03:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiHLH6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 03:58:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCEA74DE;
        Fri, 12 Aug 2022 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660291081; x=1691827081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zQPduV14rsd8V1MhWV9w2wUeAYTFJAQNyA1itKFZpO4=;
  b=jyGTdvOp8qwa2ZhTkuip9Js4umdO9VRx6e4VgKRDvs7oUa7VFdGJc9N/
   N15aNGv4Scd429NxzLLqWwH0UfdOXTCoxoAzsWfvB2G2vmfcqfcMgsY/d
   BCmGEnrU1qsdhfEnOjHdayorcXqKCTYaXZjGzcaGAIlaRuBZtiJK1kxnc
   g6LMih/3IkEzPVpnRfh2Q2RycRG8xzZ/qSIfhzo+Coc6J8sm47Jisr4Cl
   jS8gwuFdPOhPTQTFKngy1cLAduflwnnf/CJ4a/4pKeqlR3l1ef+CZIyi0
   gFdkc6ojfHg0JRklInODM1rOja8RF4R8x/hgOHbsDJeDSEYsb6n+2AU/2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="186187893"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 00:58:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 00:57:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 00:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHX+8/HUfVGZ+arrsBxSZprhGrilEZ11bG73f4rLy5ASW7RLjTNU+N76z3NCNJJrVhU7Z51x9A5WDP/7YUfOZa+MJkNgBZyXF0IKskJUuRZX73MrN0a1atAWNJYb+oS5jIDKOulbzg+Yu0U3wPiovFQtMTk430JTbRh6M1NtPs83tKmRG33VVgmTX12roLI+KLzfKydxXIkobW50rjnlOXSdrjfIgthr8Rqtb7ivESC8TnIAIXMyS9V9AOUlEqr4HrhJEVF4cAkV8YnP3mxLHNg3wKTfvHyZlYKe+XIAlj+HSidzw4vmFsvfOkZDDmmvOUdjPav737LN6haFLUWzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQPduV14rsd8V1MhWV9w2wUeAYTFJAQNyA1itKFZpO4=;
 b=aYMZ6OLnNJhzqsNIdUzLcKKPEr+HNdl1O7Q05Dmzs1mVsvKjEY54Vcw4ZBESPiDmTtpg0+qkR/w/yKpVGLgfSNIRUd7X9D6P6k4GhDqPB7+QFfPwQJMKK7Adit5K7qZki2+OF2r9iXFz+/NpUvMBOkt0HwqPxLzG2KaGW5RjLTJJCfQMj/fqpOghOzkKYKWEuer8b332GzsSOo9ABAQw1AJ4nWSqYW/dW1n5V9DGLJDc+cr8Q7scscyBzTo2DL2cJh9zWSJUU0y2yhO0WRnani7dO5DxmB6ctEPEYlXJKk/YBgB7ahdFAA4B0FyfXODcnBhLyjmwYvfqD+gVOzPCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQPduV14rsd8V1MhWV9w2wUeAYTFJAQNyA1itKFZpO4=;
 b=Dr+SYP1oaA/u9khnSQzDUdrKwjAtc4sBMBL8Bz1faysG/FNapgHXAoz9S1/jsU9TKeSmJ230kn6I+tKYZrkv9FLbcZ3JLsP8xDgDPLoWMSfYfyUNIe2LrE/Z9liI0hG7YVxNQr5myMsrjvawXwuw5h5iOBIEld+dsk/DYpzxyII=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:57:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:57:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: fu740-pci: fix missing clock-names
Thread-Topic: [PATCH 1/4] dt-bindings: PCI: fu740-pci: fix missing clock-names
Thread-Index: AQHYrcGlXfP4O+KmiU+P5lKvf6cyY62q4HMAgAAGagA=
Date:   Fri, 12 Aug 2022 07:57:53 +0000
Message-ID: <2e74b67d-eef3-8900-ead9-8be7b07b2585@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-2-mail@conchuod.ie>
 <f636ad9d-5e9c-f703-221a-3c09f31ed105@linaro.org>
In-Reply-To: <f636ad9d-5e9c-f703-221a-3c09f31ed105@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d89d5166-45dd-417a-e5e8-08da7c385c8b
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGBXTG7o/9uXQTXiY0gFSeKlaNhkfwqKt8901nPUM+p+YBqKDuutK1tvJkFkPDrXmTYzzDwkoblvZjQIJ9grPQ8YDnJxLuTnxvoBKQv90kSsG6LO++/1UrQOyRlmCGMPHklMVloGPlnVnBTLVwz4EEvUlqlvcM1kfvHkN0WYO+5mfGcrJVct5hN7Imse0Q0FrYdM2VUI0n08FTwLoqVgfqiER5oOpOI63yesljKSduH0fsYJFyIBGfP5vbZ5MLAs3ZmpmBtkK7ibLei3rSXm8H+OVYn1RV+Nhyd7xPwSs2IgFW7CodXDPpdKarIpRWBDRaZ/YR6PNAYfOXWIN0kkuOyB20FUO8fnKd5dfm32KB3D80OZ1CEZGDLKAeH5cOb8uW4ULrAVA9PXeawigIFwuEZOu39ua0k53h/JF/9EJDHT5KHXUxQ0w00hwx0gfrNO5CZEc6uUwM+Uy707BBch2HKH9T6GVuTimRG2g8R0rOd/laL1L/fYdA6A6EoPHo0pnlkfyn+fARxlo+OxIgNzGgcM65ExO7G3pN6Jyi4KeEMTxshrhjmEScPnkxHl4QKm/6P6JogOnM1JB8YO304DR9iQZuyz4ceLvQl5f37ThUoEoPM90aOaKLf1XpJy2DRmIGRbn3298qZYtumgClwAjPkUIk7j24QVRkELklxAhTNspYW4wl8foyZA1etI6633y81HADT35sBq2Y5dGvklLStBq9zkhZUPJ/vmxAw5AKYX4DPKotf4KovgYeryTCpuWXlYuGqWlAkQukyITCsSivRFTFfHnWvOTB1k8ltDu9gdEF4hwnTtIfiJcKiezynj/c4d2qb8D0B3+nIli1WcRT0GNKJP1uTxF4q4rI22gCxeceeNs/6UdXoZmbbrtmawy0joYoYbX+b+Z3jU9YimHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(366004)(39860400002)(136003)(6486002)(36756003)(6506007)(478600001)(31696002)(86362001)(186003)(41300700001)(38070700005)(6512007)(31686004)(2616005)(53546011)(71200400001)(26005)(83380400001)(64756008)(8676002)(66946007)(91956017)(54906003)(66446008)(66556008)(76116006)(4326008)(316002)(66476007)(122000001)(921005)(7416002)(5660300002)(8936002)(38100700002)(2906002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZueklYT1V3NjZPdzVjb1N0NkdCSFhleDRyRUxRUEpLb0FBZU5DRW1MVm9R?=
 =?utf-8?B?Sk01Ui9CVWtIcUhuZnJtZDFzWC80T0VVR0E0WUJuR1dEZ2JRRUc1dXV1eVRE?=
 =?utf-8?B?T09oL2ljUzNxM2F3S3JaUUkraytBM1E2QU5wZEdvNDlLNVVpTWtxVCsxRGxY?=
 =?utf-8?B?VVJFOVU2c3ZMc3B2RWUzbzRGZzQ1MDZ2V3JHeDFieTJVdTAyZWxZY05PUmZB?=
 =?utf-8?B?elcxUERhSk4zWE9FVjZQejBrZTAwL29Ia29EUERxY200S1VVSkhOQkkyY1N0?=
 =?utf-8?B?M09DUm9zbUU0NFBPTllQV2VvREtXd29lWnF5STZ2NFd2ck1Vb2lpbStWb21T?=
 =?utf-8?B?b0tVYm5JWklFMG9DSWNTRk1mZU01SlV2b29qYmtMSWJqRUlicVpZYUJhdHgz?=
 =?utf-8?B?MFVPTDVHSFJyWDdLc3dKNkxnZEZzN3J6ZVdwL3IwQlFvc212VDZaa04rSEI5?=
 =?utf-8?B?dGZWZmRhbHAxa2V6cjFKblhLSjFxTnZFUmNVZEVVbnJINXhMZFFYNjZHOC9U?=
 =?utf-8?B?VUVBb2kzVEFWdVRpVlZ3NFh3UmNGSFMwOW9BRHVVNWtKMUtTblUwR2pRaDZq?=
 =?utf-8?B?YXQvUFpxOVVkZ0FMMDZwTWNYcTN4T2hoaWlMam8xeUJlSjZXd1lZU2ZDSHhZ?=
 =?utf-8?B?d0VZdktQNkNrV3oyTVBRaG9pb1llbTA5RytGbVE5YlIwaHZoRXJjK2FDY3dQ?=
 =?utf-8?B?V3dKajA3NHlSUVY5aWVYSGNtcWcvN2pKS2oxeUtiRUgzVEF5dXRqZTlLTU1a?=
 =?utf-8?B?TXdIMVpLa0d3UzU1WHo0ZXZQMkpIRmdtTmM1RUtqRlc1RWhmZDV4VXRMZUxM?=
 =?utf-8?B?emdBNGVWeHJWQUdBUzB5Mm1OSnhadmFDSHNQMTZ6eTQ3eFRyU2JHZGNXL1lE?=
 =?utf-8?B?bDNiaEpWWWlEY2xjV2l6WXpVRHY4U2tSdW5LMjY5UVFDeG1PckNhOFVRMUJ1?=
 =?utf-8?B?SUFaSlVQTVJsREJONW5HUk0rbTZBbVA0LzFHZnByS0RBZUlCenUyTUJmZ0Vm?=
 =?utf-8?B?UTVSbzFsMTF5dmRxNEJRNHVOQ1l1V3d5ODgwY2hpZUI5K3J1dXpTVHJ2YUxy?=
 =?utf-8?B?RnNmcXJUdFZvMm9qQkJuQ1ZhbnIwRkNaak5EOHVOUkUzdkRwUFFVY3R4blF6?=
 =?utf-8?B?UnJYMkQ2dmJ3Rk5DemlQcytYNHhGR1lkMGF5cHI2ZW5tVHg4cTMzTkdBZ1d6?=
 =?utf-8?B?VzRpMHZ6VzFtZkRyaWtSTUJ1R1dLVHJBVXhnV2FXczdreUFudldROFRBNzVv?=
 =?utf-8?B?KzFPWExyMU1PeFNSTThFT3Q3cXJVWFVjeDZ6WXB5Uzljc1o1WlYyd2I1TE5Q?=
 =?utf-8?B?MHErYm5WRVFZL2pvME9MNWRVKzF6djhVaU5Bd2hBSDI0MHpBc2tmWlpEM3BI?=
 =?utf-8?B?VXUrYWRKcFNCR0RWWGZlSFZXMERwOEFpU0gxbFduNmFjb2UzbzI3M1N4UkFj?=
 =?utf-8?B?T1ROcnYwdVBMbWtrKytxUSs1a1l1a3V3Z05leUxJcDlISjJCMlI2a05BWUhq?=
 =?utf-8?B?NmYzR2VaZmlJajJNZURIRVVQUmI5emJVRG1qNlE5UEpmZTI4bXFSclpuQlJl?=
 =?utf-8?B?T0I3ZXZsK2dsVm5HKzZkQWRDR05TbWg0NHVHUVhYNENNSWo2Rk15TzdUb0Jm?=
 =?utf-8?B?QldYSFAyNkNscWRpeHQ0OUdKVHlGcDR5bTduS3FtbnpZU1FFcHQ4MUJPdVpG?=
 =?utf-8?B?cGZtR3pZNDJnN1hhd2U5SGtTZU9WbVdLYkF4V1BvZFJpWjJoQ09mV0RiQUc4?=
 =?utf-8?B?MUJmUFZNRmo5K3RuVXpyS0NTaFIzWHg5VmRPbmdYcEw5ZzNrbHp6VzNWRHNL?=
 =?utf-8?B?UDlHVHMwOUJqWC9qT0ZaTENabFY4TGtRamRHWVNMMXlvWWYvdS9idWQ3SjNT?=
 =?utf-8?B?aVZ6akk0alB4S09mUUJCS214YjFKVEJEdHUvTk9MQXNmMDU3cDhXSTNGeXdu?=
 =?utf-8?B?U2Q5dTc4ZnJ3T3BGSm5WM3ZKd3ZsZG1vZS9mem9yTVZYUHYxNG1sOTA2WEVt?=
 =?utf-8?B?MjhWV1diNER0SkxYMWV1bU9CdWZadVd2cUp6K0lQQWtpVWVQNTR0NmxJc1Ju?=
 =?utf-8?B?eXVkbHY5YWkxWXNPZU1NMko4cjVzZVkwMkQ3eVhkWm1laUM5eWJCL0R1Wlkr?=
 =?utf-8?Q?DaFJYrTeUDpfd9M2iolzae1Z6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A786E069F4CF0499B2D13C44AF8F85C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d5166-45dd-417a-e5e8-08da7c385c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 07:57:53.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4X3v8ITfJ7PYvFUJoL1JaTpGf4NsNdSG9Af01EERKjcaVo1o8kEKMtD/jNTeWeIUkfXONJNAanXy/j83k9GIg4k9+/1JieDk64mAIE3yv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTIvMDgvMjAyMiAwODozNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMS8wOC8yMDIyIDIzOjMzLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoZSBjb21taXQgaW4gdGhlIGZpeGVzIHRhZyByZW1vdmVk
IHRoZSBjbG9jay1uYW1lcyBwcm9wZXJ0eSBmcm9tIHRoZQ0KPiANCj4gSW5zdGVhZDoNCj4gVGhl
IGNvbW1pdCBiOTIyMjViMDM0YzAgKCJkdC1iaW5kaW5nczogUENJOiBkZXNpZ253YXJlOiBGaXgN
Cj4gJ3VuZXZhbHVhdGVkUHJvcGVydGllcycgd2FybmluZ3MiKS4uLi4NCj4gDQo+PiBTaUZpdmUg
RlU3NDAgUENJIENvbnRyb2xsZXIgZHQtYmluZGluZywNCj4gDQo+IE5vLCBpdCBkaWQgbm90IGRv
IGl0Li4uIEF0IGxlYXN0IEkgY2Fubm90IHNlZSBpdC4gV2hlcmUgaXMgdGhlIHJlbW92YWwNCj4g
ZXhhY3RseSBpbiB0aGF0IHBhdGNoPyBUaGUgY29tbWl0IHJlbW92ZWQgY2xvY2stbmFtZXMgZnJv
bSByZXF1aXJlZCwgbm90DQo+IGZyb20gcHJvcGVydGllcy4NCg0KSSByZXdyb3RlIHRoZSBjb21t
bWl0IG1lc3NhZ2UgMyB0aW1lcyBhcyBJIHdlbnQgYmFjayBhbmQgZm9ydGggb24gdGhlDQoicmln
aHQiIGNoYW5nZSB0byBtYWtlLCBwcm9iIGp1c3QgYWRkZWQgdGhlIHdyb25nIGZpeGVzIHRhZyB0
byBhIGNvcHkNCnBhc3RlIG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLg0KVGhhbmtzLA0KQ29ub3Iu
DQoNCj4gDQo+ICAgYnV0IGl0IHdhcyBhbHJlYWR5IGluIHRoZSBkdHMNCj4+IGZvciB0aGUgRlU3
NDAuIGR0YnNfY2hlY2sgd2FzIG5vdCBhYmxlIHRvIHBpY2sgdXAgb24gdGhpcyBhdCB0aGUgdGlt
ZQ0KPj4gYnV0IHYyMDIyLjA4IG9mIGR0LXNjaGVtYSBub3cgY2FuOg0KPj4NCj4+IGFyY2gvcmlz
Y3YvYm9vdC9kdHMvc2lmaXZlL2hpZml2ZS11bm1hdGNoZWQtYTAwLmR0YjogcGNpZUBlMDAwMDAw
MDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnY2xvY2stbmFtZXMn
IHdhcyB1bmV4cGVjdGVkKQ0KPj4gICAgICAgICAgRnJvbSBzY2hlbWE6IGxpbnV4L0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvc2lmaXZlLGZ1NzQwLXBjaWUueWFtbA0KPj4N
Cj4+IFRoZSBMaW51eCBkcml2ZXIgZG9lcyBub3QgdXNlIHRoaXMgcHJvcGVydHksIGJ1dCBvdXRz
aWRlIG9mIHRoZSBrZXJuZWwNCj4+IHRoaXMgcHJvcGVydHkgbWF5IGhhdmUgdXNlcnMuIFJlLWFk
ZCB0aGUgcHJvcGVydHkgYW5kIGl0cyAiY2xvY2tzIg0KPj4gZGVwZW5kZW5jeS4NCj4+DQo+IA0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

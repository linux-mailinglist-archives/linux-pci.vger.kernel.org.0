Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268359878C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiHRPeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245604AbiHRPeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:34:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797FA89CDD;
        Thu, 18 Aug 2022 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660836856; x=1692372856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R76gBw/NRO8GN66duIy3eg/p0pnJDgZDtgiiUcrJGAY=;
  b=eNH0AP1n+OFa7IyxpJyULtk8l6HN6NlXGZRNvGSBAjhh/TVxV/2NJEtv
   74tJ0pJzVhHFu0CgWB3K6Frh/3ZjLLkAxHOXYEeR6H/GRAGK+RtroCIjL
   ShtQekuPuB++uSWst1vnuZ54bFVg8VEkbXYRmuc2BaFE1Al5OuSAB95it
   lSMgZqFMm4jlYB4JWajQo7mzcswIKHsaxYku5jZ3CX9zDbjckhuK9tz2T
   8IWcg7wHvgeDsLMfrq/PO/NcacRi1bdB3BdsY4Z1RoDUDdSXPGymqxKWt
   Oq/oZwwBnwrIz2rIPeZ6/eGfPrwXfFp8fmWJ9z1ZKqn7cvWbs3RkvIywy
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="173062483"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2022 08:34:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 18 Aug 2022 08:34:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 18 Aug 2022 08:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8V02DA4eEE0AZ3XvWtMv3pEkLUI/jf8fccAbDO2H4/hxif53EQ/fgWyS1IumQIAeXGyPf6URVqSdvIyiqsPdJOhMaayJGA2P/veM/OB5oIunDfyvo/8RupNi3gwWTqf6FC2pcf9Q37kbUqZEiEerVBl7we9JkLFl/V3GjDHHJVzgkFxXLgbh7pZl5Bc+pZWZOm/CdE0k9t6EaIZBxqgU77r9u7ErNL+EGLHYqZ3DQpJWuJZF4SkIBsDJjWZeH/NEYLvOWYCssnIE5bbnsTwtS3f/iICktF24Oqm64pvIjCqLAhfd4VAUbsS2prgv9S2oNSXb9STbo56lmIeF94kXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R76gBw/NRO8GN66duIy3eg/p0pnJDgZDtgiiUcrJGAY=;
 b=f7jUapr9K+SjdvTu5+nWSEMhHQPz7fvZUcSlCouooV9EwPM4ZLU8uUbijrA/deEjkuTB5tvc6nSaTD30MgqlNngf0lU+bu/4FGASBLNIqFDTRJbrM8nnURcXoS0GQj0d8Ja6RBoSpKpIQdukmAmPmc2EuZJd53hlNGXHWi2cx6254ABjNqG05+qkQ2o6PsFVQ1lWn9dPwTYPI+9pq2F6MnBnrX+6w/j7ui11ej9mPZcy9IZao0rtLoC4jissz0nR9ekpll9dB/zjevTgO4p11H5Bl9syUxHhg78Fa07S9jY+vCsDUfprRpoyUPKofBROE9MZT84KVmQIm1T30dnrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R76gBw/NRO8GN66duIy3eg/p0pnJDgZDtgiiUcrJGAY=;
 b=QHOAw+IKYB3/CupDtQ/Cv78402fML4LFDO5OLdGPCkcs1slkfC4s0MdgFyJyDFfBhmZ8rhF5DdQzHW2TlVf9Oh93oNKtJQUbgNlv+Z7sVBONR3EyaBzOhyW0iAFUAdc+mlm1iqNiSgG66RZZ8iySdtjn/WKYwFP4DcuaXgcn714=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2950.namprd11.prod.outlook.com (2603:10b6:a03:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:34:08 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 15:34:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <mail@conchuod.ie>
CC:     <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <greentime.hu@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <lpieralisi@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Thread-Topic: [PATCH v2 2/6] dt-bindings: PCI: microchip,pcie-host: fix
 missing clocks properties
Thread-Index: AQHYsZ2w57x2k2JvRkWEsDy3wuHtc620xQYAgAAHp4A=
Date:   Thu, 18 Aug 2022 15:34:08 +0000
Message-ID: <006e078b-0e40-7e43-331c-97571fcc36f6@microchip.com>
References: <20220816182547.3454843-1-mail@conchuod.ie>
 <20220816182547.3454843-3-mail@conchuod.ie>
 <20220818150644.GJ1829017-robh@kernel.org>
In-Reply-To: <20220818150644.GJ1829017-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b01f544-81d7-4459-ef8d-08da812f1763
x-ms-traffictypediagnostic: BYAPR11MB2950:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkpghFERA1RgnUBV4DPUHKUxnDbi8TJR+OjXM48r3z370SSdi7NaFX/+aLvOSGKkgR++SwBt8r8Hpdxkq2LCaE7qpmP67cWpyaZLNKqfhe4aGNZpJ6jFw4cWz6QnhvfNwQJLK5T30LPbkePtfNvWqxMI3H1VXx2DBMxDnI9Wb9IejBAQ05ebwroUtuJ2h3BswjivLaxvJbBD2rPy/bSoe4WdawUFxbSF+FD4B3ELB1gg86Hj7guQLAus+5K2t91ZM6lBfaCpKAYdMUPLwQv+uTQy5Uca2+LfMUdCn4GaphhRQ+hxhbtDHA9/75aH+H9gBozOC+BcgPJQTfjwzjmwQclYGXsnl/2zP7NPdM41ZOnTuegB3EfzF4CblBVnA2NYKGQebB/Y2Utr2e0/igEJc/CjEzq4kvdsnphQQ0HrHG+pXUxfY7DUoonAPCPE+lpxjLjdbzIdIlzokM3zrBOM8Vn/izkz986DWQrdlF4TGwZDeDqUowZX2DwY1fBVRTikkTp9DgzTVV/pA/8fCNdVkUWs0GUZTxwm48draqKGm6EkcDMT5JYb50wCWf4k6HhyPTY5OEgcbcJDqZyzVvpHL8ftWeUaHZanyb7oLItnUWNjrOFvSFcRCDbVPsxfLknHU5eWx2BJgzE7ZT5iXj0ZOzp69tf5IXhG4DhEgqbCQKCc4fapUdNbTZJxJF13bHREzonr0F/a4h7rMUu4n3xo9c4IdaHd1BLvxX9MU0w8ImKu2VQe5Srbq3gIJGfJZaEjXxqbNmrlbW0h2Q8kRblsr0nievBpiAqfoWpo1O1Utz3908rRX94BKKaqVyjIhOlQ5hpsxoeYM9jAgVCL21Z6UkucVtW+cpC0Cy19mISJY5w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(346002)(396003)(366004)(966005)(6506007)(53546011)(66946007)(64756008)(66556008)(7416002)(66446008)(76116006)(2616005)(66476007)(4326008)(186003)(26005)(91956017)(6486002)(8676002)(5660300002)(41300700001)(8936002)(6512007)(83380400001)(38070700005)(478600001)(2906002)(31696002)(38100700002)(86362001)(316002)(36756003)(122000001)(110136005)(31686004)(54906003)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHEyY3ZVS0c1bGxIR21OR3c5d0ZYZHRMMUl3MEludElFWU93Y2cvWUhBQ3BH?=
 =?utf-8?B?Kys1WDltQ0tMTDBFYThPWGIzdmkrQU5iTm1zVURGRGY0TGE2aWFKUWxTdXBO?=
 =?utf-8?B?TXFiY3pTTjhTbVkyQm1TU0dqMHAvRlpHT3JUYWJZU1NoWFEwVUI3VkJrczhE?=
 =?utf-8?B?dzZiSEFVbHBVT0hMVDdtOW9HUVZMS0RsMUJEc0NrSWhaNnlhQldBUG5VVDdx?=
 =?utf-8?B?Q0w3aWwrSG9iSkRaQ3F3TzBIL2RBckNldlFWTGhOSnppc2hWeGRYckVINWNp?=
 =?utf-8?B?NVNvT0pDZXdVdDRlRlF0dVR5Ym1TZFo0c3lYZFFJZXplRHZXNUtKNWozaWM0?=
 =?utf-8?B?OHZOYmpwL3ZCWkIxei9NOGc5cEFZVkozc3JHeGlqTGRzWHNzOVJESStCeDVt?=
 =?utf-8?B?NlBBV3dZVXJrN2JNS21WcWhLbHR6RmFpSWIzRGhzTFI1azRxUWQwanpSZ0Ez?=
 =?utf-8?B?SXRDLzRUVlhySXBVTldQMTNnRjE0Nk5idkZGczF0eHFkOXU2bnZ1cWJZY2VB?=
 =?utf-8?B?d1NJU1c0R0R2T0t0cXYrN2NselNHR2VoSDNvdG9yRGk0QmxUU0tVeWtnbzRO?=
 =?utf-8?B?QUtPYmdBOHZ0azhhejZvTXY4SnEvdzYvR3o1OUVjREkvSk1WajNHK0g1RWRo?=
 =?utf-8?B?Y1lWUkcwYkhhblozUStMenRkUVNNRGJwSXFlRHJHOUsvdGh1OVp0Ui9teHM0?=
 =?utf-8?B?S0RhRUtBdWZYR1dKV3R4MWZpcmREeGdqeTI3ck1SbDhFcTcvTnpicWVzcXk0?=
 =?utf-8?B?YzNITjQ2Q1laam0vVTZQNS9HQ0trWmowR2ZaVG5CYklOaVNuaW40TEFuU3cw?=
 =?utf-8?B?b1lnSHVMbzNsbzRqYUwyZ282VFVNUkIzb1hScFFvcm9zaHJCcHNWWWNoYmN6?=
 =?utf-8?B?ZWdLRVJpMnFzL2NjWFBGc2ZGSE9XU29sZ20wTjdZbHpQZERybnlMZ1lqa0xh?=
 =?utf-8?B?NWZ6TVlEQy9OVWZqUE1wcGJYbU9NSGZ6UWtkYk1uUTBEYUxLbXFNRkg1dzJt?=
 =?utf-8?B?cVZjNG1HdEROMTg1S3ZpQkZWTk9Ra0s4T3JYR2VMcjc4S2MzcytaTjA5b1o3?=
 =?utf-8?B?bmVxTTNqVTE1UjQ3R21iR3o1WUdDOVlUZFdKeUpDRHhsZ21zcEtEQjI4RUVp?=
 =?utf-8?B?Q1ViVDNtR05VNEQwdFdkMC8wWU05MnI5V1dHQlF6K25LSElWMzhwekRPTjQ1?=
 =?utf-8?B?Vk91aGJuQ3pMZENiZ2hvcHRZYjhNK3ZiUElTUUM1QytnZ0dEQlVjTUxnR21t?=
 =?utf-8?B?WXdlZ1ZRYTlCRXNaOEZUdjg4SEVGNEpRVmxyN3dBTitVTXhPdnFmRkUxblZm?=
 =?utf-8?B?SzVDbE44TjhvZmxZSWJFUGg5eUhkMHJENTJjOExyYWdjZ1cyTy9mYzk2d3Fw?=
 =?utf-8?B?ZzM5NHNYMWtYTWpTMWV6a2dZdkNnSjMzNFluWkpOVTUzcC9Wb25LemlqRit6?=
 =?utf-8?B?RWZIa1QyUWt3WGdSR1l1VHJDRkZrTWJTK2RKRFNGbCtBYi9PdENPakJSKzVo?=
 =?utf-8?B?VVRtcEFKVE80bmw2eVVGTVc1YkhPcUNHbHdzYmVJMFUzZDlKZ1NybVFBUGdB?=
 =?utf-8?B?YU9KOHVpVG1LYUlzMkhncjlvcHV6cmJ0YmNxRzZjVTN3SFlHMGJ0RFF4YTBm?=
 =?utf-8?B?WHFybzhWaUoxaGtzTUlEYlNVbXVTYlBpTmNpcElaMUtuK0lXbVVJVmdOR2xB?=
 =?utf-8?B?aHhHbnBxUzV3eUptNlNPYVI5SXZLRWdhd2QyZ2xGU2ZwNlhKd1pFRTRoaU5I?=
 =?utf-8?B?VXdKT2hVUnoxYnNsWVVHTTNQMEs3LzAvYXZ0OSt6MWN3bEVMYXB5bnM0NDc3?=
 =?utf-8?B?QkpVVGhwRzdRQ3pxM2szcEZualVhenRKTVQvUnc4TlZwWnBZUGRFVkowc2tS?=
 =?utf-8?B?Ymh2eEtBdzNPOWsyM3l6a1puOFQxOFZpT2xJbDJrR0tBNnVGdE8vRjVQVXA0?=
 =?utf-8?B?dU9ad3h4V1NUZU9ZUTJMdSt1amJwU3l0MHMyQzRyR1g5ekR3MGhHd1Qrd0xU?=
 =?utf-8?B?MktscWNDVE5Qc3E0WVZhYWRMN3NSNWhWbCtXTFBmSnMrNm0rdURvRit1UlVJ?=
 =?utf-8?B?a2g3bDVTcFJ5Z3dWTW5kckYzTTBaRHZBUERaaVppY0htUlNSS0d2bFQ3eUhT?=
 =?utf-8?Q?FoEJ/pRNgVwbncX5cWaygsJwX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08C8CCF8BB4A494B8B796B99EFB85FFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b01f544-81d7-4459-ef8d-08da812f1763
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 15:34:08.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH9QbrYIGoI5xoImyxW55IJCMOcU4IcdmdIBe6Nl/+2jUA9+oUG4uLL3OHZUb0XwVlxwiQbfNaRXumO/bDiOUe631XpPOlftmizwjnvBTyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2950
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTgvMDgvMjAyMiAxNjowNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBBdWcgMTYsIDIwMjIgYXQgMDc6MjU6
NDRQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBSZWNlbnQgdmVyc2lvbnMgb2YgZHQt
c2NoZW1hIHdhcm4gYWJvdXQgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOg0KPj4gYXJjaC9yaXNjdi9i
b290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUta2l0LmR0YjogcGNpZUAyMDAwMDAwMDAwOiBV
bmV2YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJ2Nsb2NrLW5hbWVzJywgJ2Ns
b2NrcycsICdsZWdhY3ktaW50ZXJydXB0LWNvbnRyb2xsZXInLCAnbWljcm9jaGlwLGF4aS1tLWF0
cjAnIHdlcmUgdW5leHBlY3RlZCkNCj4+ICAgICAgICAgRnJvbSBzY2hlbWE6IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+Pg0K
Pj4gVGhlIGNsb2NrcyBhcmUgcmVxdWlyZWQgdG8gZW5hYmxlIGludGVyZmFjZXMgYmV0d2VlbiB0
aGUgRlBHQSBmYWJyaWMNCj4+IGFuZCB0aGUgY29yZSBjb21wbGV4LCBzbyBhZGQgdGhlbSB0byB0
aGUgYmluZGluZy4NCj4+DQo+PiBGaXhlczogNmVlNmM4OWFhYzM1ICgiZHQtYmluZGluZ3M6IFBD
STogbWljcm9jaGlwOiBBZGQgTWljcm9jaGlwIFBvbGFyRmlyZSBob3N0IGJpbmRpbmciKQ0KPj4g
U2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4N
Cj4+IC0tLQ0KPj4gZHQtc2NoZW1hIHYyMDIyLjA4IGlzIHJlcXVpcmVkIHRvIHJlcGxpY2F0ZQ0K
Pj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwgICAg
IHwgMjUgKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4+IGluZGV4IGVkYjRm
ODEyNTNjOC4uNmJiZGU4NjkzZWY4IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55
YW1sDQo+PiBAQCAtMjUsNiArMjUsMzEgQEAgcHJvcGVydGllczoNCj4+ICAgICAgICAtIGNvbnN0
OiBjZmcNCj4+ICAgICAgICAtIGNvbnN0OiBhcGINCj4+DQo+PiArICBjbG9ja3M6DQo+PiArICAg
IGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEZhYnJpYyBJbnRlcmZhY2UgQ29udHJvbGxlcnMsIEZJ
Q3MsIGFyZSB0aGUgaW50ZXJmYWNlIGJldHdlZW4gdGhlIEZQR0ENCj4+ICsgICAgICBmYWJyaWMg
YW5kIHRoZSBjb3JlIGNvbXBsZXggb24gUG9sYXJGaXJlIFNvQy4gVGhlIEZJQ3MgcmVxdWlyZSB0
d28gY2xvY2tzLA0KPj4gKyAgICAgIG9uZSBmcm9tIGVhY2ggc2lkZSBvZiB0aGUgaW50ZXJmYWNl
LiBUaGUgIkZJQyBjbG9ja3MiIGRlc2NyaWJlZCBieSB0aGlzDQo+PiArICAgICAgcHJvcGVydHkg
YXJlIG9uIHRoZSBjb3JlIGNvbXBsZXggc2lkZSAmIGNvbW11bmljYXRpb24gdGhyb3VnaCBhIEZJ
QyBpcyBub3QNCj4+ICsgICAgICBwb3NzaWJsZSB1bmxlc3MgaXQncyBjb3JyZXNwb25kaW5nIGNs
b2NrIGlzIGVuYWJsZWQuIEEgY2xvY2sgbXVzdCBiZQ0KPj4gKyAgICAgIGVuYWJsZWQgZm9yIGVh
Y2ggb2YgdGhlIGludGVyZmFjZXMgdGhlIHJvb3QgcG9ydCBpcyBjb25uZWN0ZWQgdGhyb3VnaC4N
Cj4+ICsgICAgICBUaGlzIGNvdWxkIGluIHRoZW9yeSBiZSBhbGwgNCBpbnRlcmZhY2VzLCBvbmUg
aW50ZXJmYWNlIG9yIGFueSBjb21iaW5hdGlvbg0KPj4gKyAgICAgIGluIGJldHdlZW4uDQo+PiAr
ICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0gZGVzY3JpcHRpb246
IEZJQzAncyBjbG9jaw0KPj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEZJQzEncyBjbG9jaw0KPj4g
KyAgICAgIC0gZGVzY3JpcHRpb246IEZJQzIncyBjbG9jaw0KPj4gKyAgICAgIC0gZGVzY3JpcHRp
b246IEZJQzMncyBjbG9jaw0KPj4gKw0KPj4gKyAgY2xvY2stbmFtZXM6DQo+PiArICAgIGRlc2Ny
aXB0aW9uOg0KPj4gKyAgICAgIEFzIGFueSBGSUMgY29ubmVjdGlvbiBjb21iaW5hdGlvbiBpcyBw
b3NzaWJsZSwgdGhlIG5hbWVzIHNob3VsZCBtYXRjaCB0aGUNCj4+ICsgICAgICBvcmRlciBpbiB0
aGUgY2xvY2tzIHByb3BlcnR5IGFuZCB0YWtlIHRoZSBmb3JtICJmaWNOIiB3aGVyZSBOIGlzIGEg
bnVtYmVyDQo+PiArICAgICAgMC0zDQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0
ZW1zOiA0DQo+IA0KPiBpdGVtczoNCj4gICBwYXR0ZXJuOiAnXmZpY1swLTNdJCcNCg0KSSdtIGds
YWQgeW91IHdyb3RlIHRoaXMgb25lIGZvciBtZSBSb2IhDQpJJ2xsIHNlbmQgYW5vdGhlciB2ZXJz
aW9uIG5leHQgd2Vlay4NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPj4gKw0KPj4gICAgaW50ZXJy
dXB0czoNCj4+ICAgICAgbWluSXRlbXM6IDENCj4+ICAgICAgaXRlbXM6DQo+PiAtLQ0KPj4gMi4z
Ny4xDQo+Pg0KPj4NCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+PiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4+IGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtcmlzY3YNCg0K

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B91458263
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 07:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhKUGna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 01:43:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64529 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKUGna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 01:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637476825; x=1669012825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a9YErk77f9GOR/MaQONypjUm8pAiyxbHJ5VusIvP4f4=;
  b=MWOIfOhDLwtQKraS3Cu+EmrE2PoZ9MIvSOnKTkLXne5sJ57OcsfNnjCG
   /Le/kjo0V9cfe8u8s3iSRKzzqGGCloXbEPH4a0lq/43xuUFTanMLmD5Hr
   ntSZGctzoSLOFXSte6wE64jm723WgIZYRRYrHxkz7JWOAC4flac13nlrT
   sA4C0Zph7LdBWkcigs1DcWOw+MGcQfU4/2h59E96r4OaG5UDcaST0cRcd
   +eCwrRhUjG/DYtGeZRLWtGk91DOfMk2g0PrxRZT0+QZJsPPF2qWrX28uZ
   qwzFMNZiUkDag5gq2zsI3eT9TcH20pWJzKEP3CXyl8foMludXFbE2gXix
   A==;
IronPort-SDR: egWfJnTEyOtwR8O2rT7zGXgqwYik8n7dPUmJrEWhW+wHifzwqobZeorGP5b3LH4itJB6CLQZsE
 rbJYTDvp5yAsFNUGYU0Z17IbktSvVVyZZvScuth6YwGSlnpILAO/YA+Zv2zi/YUwFRzyPeUs1W
 LUoUm2PdwB95KZWqrz09hSTlErxB/8Lo14WRY57SkMaHXxchOaFhsP1H8h2s6b9hDSX4N8eIkW
 m+w7Nm6Drg/UAlZAcCXL5eJ1yDOVuNpRLgxj5ePuoa057hPpPnP9PjkX1PXfSu36mi05c8c2Cm
 MqI6kLIkhGsn4y1C+H6BIGkq
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="144633345"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2021 23:40:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 20 Nov 2021 23:40:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Sat, 20 Nov 2021 23:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ3MmAU8LHT3Fp2WUuj67OEIJCnAyOHHCegJCikPiXxdG5ke5LH/lHEWnHvlQspVeGJ6sdtBkngYSIRF1cuCo5EPiFC1tbEJCRdAB2Enrriu4YJnhJdGVXLsPpUcNoD2Y/M2qHoaLpW4GFtTCiTV3GjSjz7AfnPc9CCN87/rRHVSs/77fr0Xmdfix3fZ0RBJ7OkFaZmrmiYsyJn/7j0ETtAx+UsAEdoIZ0mO9Yb8asQFJvgiXbr5W7frbDo+2dWURBg0bHbPvMZKhan3Q9uMr7D+xTGZ62KIc3wQVEQrKwTGmQJvv9/iXTjbrlub39v9nuQvjhJoWm+DATknJGJITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9YErk77f9GOR/MaQONypjUm8pAiyxbHJ5VusIvP4f4=;
 b=UWUxBBzjPRh1/VL+MsyYPIuPbGfuj6SFjEQ65LMnf+HiC0g/kI6de7OmY/tAnQu6wEsODCu9gCieICwzc5HkZuJ2CfEtZB/lcnrpBEjazBh+XlBGfAH77onU7v3fhlxjUNFZZCPNH1hhfy0Md6IXpIxeAYrpDvvZvy3FTQI9SvmnK6A97DlefGkazE53ZduUtsOP6VXCNTxM70eIVSaBnFQT+ZmEezn41/lVCWkHhWdtA6wJFDLQW/fimF2T5n9sZ0Et8P5UmyAFHDpmICfDJuJB4WsXaVvfcUk3sALXZW7rABjUXqFQyRa2A7MHzuofzVRUo5OerKywXdHIbBxkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9YErk77f9GOR/MaQONypjUm8pAiyxbHJ5VusIvP4f4=;
 b=EdfzlNrVpYYhTYnWayZbHGe5Bk6H7/UJGtJRTHW0GWNXngQe6UeQaNiVzr79dKQRtlgDFkwBRQTHA3KluyBx6F4QBO5FcP8C5NJi2Z/Fxs+HMtJwgIRxSF56HHBHGMs54C0ZzV3eDDKtgWLjkESlnPPI0HXvNWeWH0AJODuamf8=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sun, 21 Nov
 2021 06:40:20 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::c538:7e6d:9618:80e9]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::c538:7e6d:9618:80e9%4]) with mapi id 15.20.4669.022; Sun, 21 Nov 2021
 06:40:20 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kelvincao@outlook.com>, <kurt.schwemmer@microsemi.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>
Subject: Re: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Thread-Topic: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Thread-Index: AQHX3N3ohEj9wBWaD0693QUzFBaCw6wLKR4AgAJiHAA=
Date:   Sun, 21 Nov 2021 06:40:20 +0000
Message-ID: <09496f742c040426c30fa0583b9a1e2dfeb4c2fe.camel@microchip.com>
References: <20211119181526.GA1948335@bhelgaas>
In-Reply-To: <20211119181526.GA1948335@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ace03eef-8153-4282-6806-08d9acb9c9ea
x-ms-traffictypediagnostic: CO6PR11MB5618:
x-microsoft-antispam-prvs: <CO6PR11MB5618B3596B1F21BFDF2EFB3B8D9E9@CO6PR11MB5618.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spbHGEa5+JyMotHYOFRKbit5r4Sa16nOGAwNSjZSwn7R1wRL7hXe2Uj5GmRHk6NXa2DsAvlNEcJzDHnz2rg35Ag5MwCWOCDwce58CyCuhX2yHx3p+Ws2LXJ2D6y5hyGriU8MjaB1CsiXMhDMaYp/VW3hgzAw004wzgyUVruylhkYdtClpimlNbL1Q3chD8Ss2/lvxgOgyJcvIgCAfagWDCwOYapRi8gDbu991qafZKiuL9OvPj9wX+x/FOqyLi7JZp3EXjy2qtv8K+Pyx8xwZKLQnF4o3mZxFT1+HfmdZZK3+wc4CzNU/HTJjcG9K2+OiDzUMq6uHfwbkd8Y2EntofrTMe6vlenmAggfpZ/mhdko31cjWET6w6/+Kyrgc2y2jVmsN/F0uLfqUQg6s8Sb5aVMmQVHHe3gtPXmti9UTFdm13o+tHvAbERLat8F8786MXh8Yk/BpjHcfdUhFVMhbQlsb8ENGz5lJSZEms8QfEMbFLClZP7cKkg6zTKnoSg1MMjhDeEOLzGFMwkk/J+/VRQC1hzcC5r0L/OkT/SIiUeSejVj24gNea+pd7WZC1eypkci8KpBmoTKZl+rvLDfmgdoMmK6+oWvhCJdglMtitLjPIdubN8ewyxim2IL2nDoqhRgBPCnGZ5XRr1gHD9GLIQM/ZD67vRgcxv19lkFbstDNtPxqaiNnkrmyzqml/5hu0QiU1Ov4mCELMIO6l24N84r8boQaUmrzdJFgfQmdUq7m1Lq+y3boLJYUxKhjO5elweOtZIpEhinAt/CcCzfgUPywKstJUZtjSERuIqnuZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(83380400001)(4326008)(316002)(2906002)(6506007)(5660300002)(66556008)(36756003)(54906003)(38070700005)(4001150100001)(66476007)(26005)(8936002)(6512007)(38100700002)(508600001)(8676002)(66946007)(122000001)(2616005)(6916009)(76116006)(966005)(186003)(86362001)(66446008)(64756008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzY1YXBNelBOamxFSUdWVUdHR0JTUnpubTNXU0pxVy83RFl5endWSFM4TFk5?=
 =?utf-8?B?YXhIMXQyUkFZWnlsM2FWWVg4WWNiOE8xTmdxQmZacDJlcUViTk9aTmZCbnRB?=
 =?utf-8?B?TVp1NHFxSmpTSENUL0VwVjhCdXhBSmczMjQ2Tmx1ZmVYMDljNVgrdVBRc2hj?=
 =?utf-8?B?R0xkSTZnMmQ3T0grR29nbFRiN2ovQTZZZ2JPZmM1ZmhoZldwZWZKalRFNHNx?=
 =?utf-8?B?SGNaaEpwMmZKdUJYM0RaaSs1eUlhd1BUdXlkR0ZYcnVOK1E4aWMxSkYrdXE2?=
 =?utf-8?B?dEFneG15YkpiWHlEOGpEUlN6d2xUZS9XeDN5VVVmYnJCKzZWdk4vRC9ud2U3?=
 =?utf-8?B?OHVnNlJJQ25IQlAyVUx3VXVPQ2pJeTZsUEFxRXJ6bCt4Uitva0Fza1B5NFlL?=
 =?utf-8?B?TGRkUWMvZmIwVFNYLzdLcndPMnZNY3RHQWtjRGR6ZDR1Znk5MmdRejhNSm4w?=
 =?utf-8?B?cGNJWWhaSTJESENsMGZtV2N3NDMwRE8yS1ExZnQxQzdna0FHZWcyK0VqWG5P?=
 =?utf-8?B?cmg2TlJxQXkrZnNOaHp4NVltT1NIaHB2enBIMHNVSmlQU0EreXJoZWxyb0xl?=
 =?utf-8?B?REVEY2pXdy9Fa1UyaHRFT2phVFVBdlpGT0RhWGlpZktMeWhMUzlPRzVOcjVo?=
 =?utf-8?B?QlJ4K05ZZzNVMFQ2VVdwcUl4eEVMTDk4RDZxelg1dlo4Nm0xTDNrclRqZ0xB?=
 =?utf-8?B?RWI2R0EzTmFyMTZEU1ZuMjJ1aFFCenBTSnozNjBxTTZZN0tNNE5Tb1Vsam14?=
 =?utf-8?B?bVh2dWxVU1ZlY25qL3dhOWlvZmZHM1BTREpLWGwyRUhvVGFkVy9UOGpCa0ZJ?=
 =?utf-8?B?NjUza0RqNUlLZkJhNjRHQnlFcE4ya09Ga3FhVm5QbGtxTFNRSVpML3lLem9R?=
 =?utf-8?B?MlNTeFRDMStYUERkMWErU0pDajUxQU4vSXFtNlh2Wi9lVUdDUkUyc1Ryc1NU?=
 =?utf-8?B?c1lpS1M1WUpEMVJyeCsyajgzd1BFK2dlanFLSFdTNUNIeVhKaVNvZ3FVTmYz?=
 =?utf-8?B?RVNhbkcrMEc4WUxOd253SFA0amNuTkZ6RUdKL3d5ZEd6dTd0RnhqWHNzL0RY?=
 =?utf-8?B?Zlc1Q21OZTRaQ0VQdGxRcTJiV3FzLzVGQ1FjWWpGT09VVHNmaEowT044WVJ1?=
 =?utf-8?B?Zy9TcWk0SFhXQU04YUVaazFsNGsvTTBNMVdFcE92QUkwWXVxeTZsS2FzcjJu?=
 =?utf-8?B?b3dBQWYvKy9NMmpRd0JhUkNSQm9wVWdNZEFML0NQRkhrNEJQOFROZ2ViaUNB?=
 =?utf-8?B?aWVWaFNGZEdQKzdHZkZrd1R2MGcxSmU3MWZlWVE5WWFlTFhPVjBYNjIyS3Iv?=
 =?utf-8?B?cUszQUltN2svT2N6WXhmMXNZRUV6K0F6MWdmWks1RFp5Z2tuZ2xLTmZxQS9y?=
 =?utf-8?B?MUFRMVRqWjUzSHMyU1pNUU5LQnJITnUra2gwVU9sOTlGL2VOWGl0Zkt5OTRV?=
 =?utf-8?B?RmRlQWkyWTAwb3JoTFRuSWw1WFhJRm1NS0JZRnhGRTdkSldCRzgzay9Qam5h?=
 =?utf-8?B?dFdNenJ0YytUanpVc0RnVFhma3FCbEtpVVl6MEROdmlLVWR1cCthVDY2ZGtH?=
 =?utf-8?B?MG9MeEp1dzJrZzBiLzdwTDUvcWw0dXJtYUk4M1pwZnIrTEJ5UFFqRGY2REZC?=
 =?utf-8?B?ZHhDUk9vUUQybWU4eWdXZXUvQUF4eHNlcDBISUo2cmx1U2toczBEUm9MdW0x?=
 =?utf-8?B?eWptcmpSTTRyV2RRbzhpbXQwcmZ2aHQ2ZjdlVVhXSkN1RmFiMnFpTFVJY3lJ?=
 =?utf-8?B?Z1lqb0dMTlRaR292ek9zNS8wc2pJV2FvQ1FaTUkwejlLcXBpZUVpZ2pKRUx1?=
 =?utf-8?B?QVN1aGRCQzBNdGxrcjVZeWgwd21BeVBZWlJid3ZGM2FZQXNmc2JVM2pGOG5E?=
 =?utf-8?B?Sm10ZUJHc214ai9ydEtrQ0NWK0tLU1BJZU5IaWcwSER2TFptd2lkemhYV1pV?=
 =?utf-8?B?aUJVY0tReUhjL1BUU0l4Z3FzdXFhRVJpRXNmdThBdTJTbE1mOENUYndZYVdY?=
 =?utf-8?B?QkZPQ2w4UnJLWXNkTUNXVWVxM1R5bTZ0bllzbUdzV1FabjhTNGJNOWFndnYw?=
 =?utf-8?B?T0xtRFRFSjkvWGtYUDcwVEpqT0JzTEpCdVdveXF6alltWGZBNFdNNktib2Js?=
 =?utf-8?B?RUozQnY3TXk1SnhYNEVzSzRXNGF1UnJDRGxZTFh6SlR5S09KZVNxRUFRbXlM?=
 =?utf-8?B?dkhNQjQ2Smp3YkZoVGlGVUhkRndNblYrTS9veXRLUUpFRHFnd1hPZTdSYUZw?=
 =?utf-8?Q?3+LxmuW83dyPNTbAhVByHX17QIzsRmSZKrsG76UwyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D13B47056375E548AA58CF9D941FA4D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace03eef-8153-4282-6806-08d9acb9c9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 06:40:20.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UICBhzjHPrgYI6ds+c6ZvB/FdAhWaFVM9Kvi90gWTbEvTPtpuK9w55FqfBk/agymdMSUSMU/Zm8g4+Zh1krQQxpOSnrDkO2AaAM+M7mGrbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5618
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTE5IGF0IDEyOjE1IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgTm92
IDE4LCAyMDIxIGF0IDA0OjM4OjAxUE0gLTA4MDAsIEtlbHZpbiBDYW8gd3JvdGU6DQo+ID4gSGks
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRldmljZSBJRHMgZm9yIHRoZSBT
d2l0Y2h0ZWMgR2VuNA0KPiA+IGF1dG9tb3RpdmUNCj4gPiB2YXJpYW50cyBhbmQgYSBtaW5vciB0
d2VhayBmb3IgdGhlIE1SUEMgZXhlY3V0aW9uLg0KPiA+IA0KPiA+IFRoZSBmaXJzdCBwYXRjaCBh
ZGRzIHRoZSBkZXZpY2UgSURzLiBQYXRjaCAyIG1ha2VzIHRoZSB0d2VhayB0bw0KPiA+IGltcHJv
dmUNCj4gPiB0aGUgTVJQQyBleGVjdXRpb24gZWZmaWNpZW5jeSBbMV0uDQo+ID4gDQo+ID4gVGhp
cyBwYXRjaHNldCBpcyBiYXNlZCBvbiB2NS4xNi1yYzEuDQo+ID4gDQo+ID4gWzFdIA0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTEwMTQxNDE4NTkuMTE0NDQtMS1rZWx2aW4uY2Fv
QG1pY3JvY2hpcC5jb20vDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IEtlbHZpbg0KPiA+IA0KPiA+
IEtlbHZpbiBDYW8gKDIpOg0KPiA+ICAgQWRkIGRldmljZSBJRHMgZm9yIHRoZSBHZW40IGF1dG9t
b3RpdmUgdmFyaWFudHMNCj4gPiAgIERlY2xhcmUgbG9jYWwgYXJyYXkgc3RhdGVfbmFtZXMgYXMg
c3RhdGljDQo+ID4gDQo+ID4gIGRyaXZlcnMvcGNpL3F1aXJrcy5jICAgICAgICAgICB8ICA5ICsr
KysrKysrKw0KPiA+ICBkcml2ZXJzL3BjaS9zd2l0Y2gvc3dpdGNodGVjLmMgfCAxMSArKysrKysr
KysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IEFwcGxpZWQgdG8gcGNpL3N3aXRjaHRlYyBmb3IgdjUuMTcsIHRoYW5rcyENCj4g
DQo+IEkgdGlkaWVkIHVwIHRoZSBzdWJqZWN0cyBmb3IgeW91IHNvIHRoZXkgbWF0Y2ggdGhlIHN0
eWxlIG9mIHByZXZpb3VzDQo+IG9uZXMsIDdhMzBlYmI5ZjJhMiAoIlBDSS9zd2l0Y2h0ZWM6IEFk
ZCBHZW40IGRldmljZSBJRHMiKSBpbg0KPiBwYXJ0aWN1bGFyOg0KPiANCj4gICBiYjE3YjE1ODEz
ZWEgKCJQQ0kvc3dpdGNodGVjOiBBZGQgR2VuNCBhdXRvbW90aXZlIGRldmljZSBJRHMiKQ0KPiAg
IGI3NjUyMWY2NDgyZCAoIlBDSS9zd2l0Y2h0ZWM6IERlY2xhcmUgbG9jYWwgc3RhdGVfbmFtZXNb
XSBhcw0KPiBzdGF0aWMiKQ0KPiANCg0KVGhhbmsgeW91IEJqb3JuIQ0KDQpLZWx2aW4NCg==

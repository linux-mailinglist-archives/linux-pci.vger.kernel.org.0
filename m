Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119C741F871
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 02:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhJBAHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 20:07:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31339 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhJBAHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 20:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633133135; x=1664669135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=swLiND2NDD8SF7bEU1rzf3T6k5JvGHYWFpjge0OJZSQ=;
  b=nMjpNZPYtooTp6z+CyIvfX/lE32WzrD9kJQnXksxH3t/KwNbeQuOA6B0
   bHVe61nHqvxBOriPrAP+nXxuLJEkc0/UJqA7A3syBtcGu1fby46z6x76Q
   mIKiTu//zqhuEeOQK85X1CcJsVs3MKf9Gh50VR5CAYeK70IJKHd4yhTPi
   g7uiyx97m3MXEK3v1sHNqV0+TL84VUnwmnQ0ck+wnOCq9PuTuAr349+XF
   nF9yse1YFvgQrNxnL5shMGhc/fsShpKEh3aPkNXwBdTVUP4GjvAu2/Ev5
   2mWLdowdzJHxf3sGT8nijVPrBHAXQkeU20iX6z6gilcG08NVTmSbPO5QS
   A==;
IronPort-SDR: GGXgv/ImJpB6aWY5gYMT/xtiJ/aZFWwhBHuwBjGVU48ucAamQnVFjh+iOn2mB4ipyU3RM2GR3X
 XCrQISCUegQxL16UTNm5MZaSI6zdXESoPcOzaygzZUi1aUlNbari8bc+ghjPIKdkmolnjKKLhV
 SZEM4O4mHx310nhaKoD4s5jcga6PhTEF16zqtrCVuEgtuLoxlTbeUE5C1r5irCnpZu7Y57YYcO
 lpPj3dlPzOqYzkeZQ4nefyKGrXarp6fcmEdaO5C+aH1hVUwD0gWKOrCW2NfUc/ldUYl1aOWbnW
 E/MPlrdJh+OklQ7hKilYU+C1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="131466323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2021 17:05:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 1 Oct 2021 17:05:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 1 Oct 2021 17:05:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfPDUXbwXK1EWoocaSkRKGRLZJACygvEeSsbQAiJhrhXuI8frKIlySm8VE7deO8h6pPpcLh+Q/0c5oEPeFItLRFon09aGc02/RlhcKAbI65JcrvMBH9JM8C+M95BZ6EYAwh3/ePHaZbN3bPPu2Qz82kSZW0R8VfBmdssRH7rAyDPSldvrFSsgZ81ll1DqZoKyDnm3DDiPsrfhn1HksyJONt4JZHbjWyrz4mFjTF62zN7zeKNyHa598PeWo7t25EmUGGCp2op/puhj9LXCVGpVAlHM0C39Z1M5Qi3KhLDcGMENhlECqDH/BWpr1vkFqSyoFnJjAqaF1F5sZb3Ig+w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swLiND2NDD8SF7bEU1rzf3T6k5JvGHYWFpjge0OJZSQ=;
 b=ixT2CuCtm5+O1zbyAjSXQuvHU2Pq0wx+ogRwqY25M8941wwbb6hAxbVBkDHcHKdsCZtmX9QIfSmjPo3LbeV/zNOlWtJ6MW0X4jtCbvzE5Qn+fI2undsB4Am7xVKfmn0+rN4TyqowPJf0MJ7vKFJrQzpHw5rXhLq3n6Pezaed+xx/cBQsZNJjxa2iU+va9kHIC7xhHaEMjxSKIgKy/pjQCEQF/Wmf0J6+3tuXKsxYjPWpV23Ziy17uIbQHLx+z4vxVcbpCSx9HJ7xOJOUz1Rj9qYqcM7Y7C7BEiGgH1uA5HrwBah3KkU8L9NEljf4PK4YsEHIZeqMLo0nezCyYZUPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swLiND2NDD8SF7bEU1rzf3T6k5JvGHYWFpjge0OJZSQ=;
 b=FRDHOUUztjY+iHJicPappESBvn4wNIvHNa3nqpG+2Dp9ki3mBWPTXPCgaxmzD9WhgIDSYA/6Y1NT7/JUBp+BKyIwqDwt8aMLVdfaXo+RC/dUvR0QXhK+cq9qTXVw5ZLMbXu7/hR2T8yBvoG/FUBwEbRxL5ssu82Ve4ptkCTzJNg=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5588.namprd11.prod.outlook.com (2603:10b6:303:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Sat, 2 Oct
 2021 00:05:31 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4566.019; Sat, 2 Oct 2021
 00:05:31 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>, <logang@deltatee.com>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAAsYQCAAA+PgIAAA0gA
Date:   Sat, 2 Oct 2021 00:05:31 +0000
Message-ID: <92d64bde77c24048d5ffacdd7dcab4ef20ca1630.camel@microchip.com>
References: <20211001201822.GA962472@bhelgaas>
         <2f7b4e6debbf7156a4da26bad0373d9df9667e66.camel@microchip.com>
         <1dfe4c62-63d2-e2e0-c7c0-e5cd2922176a@deltatee.com>
In-Reply-To: <1dfe4c62-63d2-e2e0-c7c0-e5cd2922176a@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8f0424-56a7-4fb3-4cf0-08d98538593b
x-ms-traffictypediagnostic: CO6PR11MB5588:
x-microsoft-antispam-prvs: <CO6PR11MB5588967F209C9A29E31164368DAC9@CO6PR11MB5588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWxsVxV2l/670xmq4nM34YBIfB/zeksiU4oIXXcgdzvIwS6fD1RHOSYMzkd0ct7xyn26zNixsKPDNro3XHOsDv08UpD/i4lhHhhryqVl9PkQ/WZwAlJ7FpNvVWdEaraLmtfJXOvQGqV/oQgGWMvR5tCYDFaTqbbScca0i90dOBrjN/AomcLyKpO8sioM1H6R7nSUeiGBdXy3gQVHbFaGvrfezGFSiuwzg7uhkZwtVkFwz+7LlPZEGoBWsvdgCy8qp74iq/0Zee9BLXTzfXLsa2yElK5jFap2lc28oMtRIFaNzlvqX88VvTcGVRoxa8cFcq3Mbs1WmcJVinFhWrn/gGJ11iiSJE76ags9kQoKJHOyA4aVSfsVoMoDpbV/2FLmMTQv+XlA/PH/Uwq8VPzrI+RuULfyzfMiNR7AdKAmsdv4ioyfujyjKluX8sK+axt5Y4x+BQgvZarAdbSZsMhmg1TX1G8H15bRiAw1Nu0bl9266/fX7golzM34ebGHyxjXFEDVsyr0I8EL1NYbgmnm9K691IJXc5RhGao8gnuDbxlTzMk653PulH66bwv/RO74VdyGovtXrITOIabQ5LKgHTTaTddHwslPDXcnthKqJPOBcWocfIOdq2IgrL/cIXzfeF8o6jDIXgWcSMMxA5MLV3MSVUGbzhRLzX8EykIGI9qu8uxLlU54xn7gfvNVF4zH0IGdzEGuvwyrbQ4gSD8NZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66446008)(64756008)(76116006)(66556008)(66476007)(26005)(71200400001)(6512007)(8936002)(2616005)(6486002)(5660300002)(8676002)(4744005)(66946007)(36756003)(508600001)(6506007)(2906002)(4326008)(53546011)(83380400001)(86362001)(38070700005)(54906003)(110136005)(38100700002)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxnWktYK1ZacXk5UytJRVVMQkVtMnVTaXFMUmxjYjhCTlJjM0d4WUpZclJp?=
 =?utf-8?B?K2Z0MDczMGJ1UkFhaFZIMExDMW5xc2VnN1o4TlhGZjVGaVk5UUFaMEUvVDdS?=
 =?utf-8?B?bExDODlEaEhsWk0vNXdCYU5qb3RSSWd3Sktpb2lvWjFTWTVrMW5WcEVpUU1x?=
 =?utf-8?B?Y0JOZDJqUmRVSzJ1NGlNem9vakljSlN6QUt5TXN4SkFISzNUaVpJcGZmUWVU?=
 =?utf-8?B?Tm5zamF5TGF4eUhmZG90RVpBQU11TXUxVEFXQkcyL0VGaUtFVVhjanFBMXA3?=
 =?utf-8?B?LzJDQXNPOTNJZmpudmdpQUZRcEltU1pzOStTUURTQnFvWmpydmVWQ3FPUGc3?=
 =?utf-8?B?cS80ZE5FbkVRM0RnMmRId0IxQWo5eVo2QXUvNVlLOUhYZGNhaTNpVW8vSklu?=
 =?utf-8?B?SmZVQk1zRWFCOGkvelRXeEZDdWNZcWRCNjVxemltUERRMmZZYlNQRW5tMjlw?=
 =?utf-8?B?bkgxdmtQNUVkeTVPdVlFQWFnMFRycGc0UENvSTRrcjdoUWVaVTlEcnl5SGts?=
 =?utf-8?B?M0Y5TnRuU2ZjVktjaUFVWEx1YUUvSGQrWm9ONGJaVzF5L1lURXc1VENHZlRF?=
 =?utf-8?B?dkxTd29HT2RQYlZPUzRlRFhwby83QjhiK3c0b2tzYmpjbGc4SWZXUk1MNU1G?=
 =?utf-8?B?dGZHS1R1Q2ZXQ05TU0NXN21yQjU3b0hybXoxWXVjUFZPTHFoblMrVkVZWEx5?=
 =?utf-8?B?OVVwQUt2d00xQ3V2RlZUU3BaVlg2SG1udFkvTzFrdWpSWEJPaUh0V1pBVnFX?=
 =?utf-8?B?NC90YW40MjRVcHpiOWpRdjdYdTNiUk9lbmYrZ0tpellCcW55NExnTTZEcVFz?=
 =?utf-8?B?UnE1UU0yWlcxcWNmd2kvNWdsZzVGRjZTTDNHeG9zZ294bk9mMkpLSjB2ak9E?=
 =?utf-8?B?eGIvOVMxak1PYWlndHFUbXRoV3B4bzRLTWdHeml4c2RwSkp6cDRTQmFKd252?=
 =?utf-8?B?OGVpcVE1N0FUWUhjRmZOb0hRYloySi81Z1N3MUlGMWhuU2F0REV6Nnl2ODU5?=
 =?utf-8?B?UW9aeUVkNXlCd1VndWNpTlJKVWNhcmZJV1B5K0hiajVMWnV6T2tyVnFYczBm?=
 =?utf-8?B?bGJFbmZ2U29vaHdVSXlyR0w0bVNKTlA1cURwWnRrZm0xdFNvWHMwSVhieHlh?=
 =?utf-8?B?Nk5WdW9tMW9sRTRvZWhxQUdNL1lRNE8ybSsyS2FqQTdKYys5VjlJb1BDUTlI?=
 =?utf-8?B?dmNtRzgxT0UxNys3b1BVSGJUTXdpenlWOHhrRENYYnhVVFBodEFlZWlIY2pO?=
 =?utf-8?B?RGtlSklYaTA2M3ZJLzlVKytUMlI4TE11aW1HWlVla1NMa3N5SElsczJUNVdk?=
 =?utf-8?B?aU9Ca3liclZPTTRQUDZ0YmNDSWhKcUxVWFEyYVpEY3dQcytEdXlwell1VzBr?=
 =?utf-8?B?ZkJ4UlRGQWdrMTZ3OVhJUWlHbnJDbW4xZU5xNkEreS9Ray9oSVVYOGEvdEdt?=
 =?utf-8?B?MFdaU1lMUzNicTh4bDBWOHVYbmZwSmFPcmJXZU8zZ01ZNXI5K0xLUGJzVHUw?=
 =?utf-8?B?cENUMEhPVmdtSzQ3YmdMZURZb2NwTTRlWlorUlpHazFqTEFyNHAzVUQzcC81?=
 =?utf-8?B?QWJ0cWdrck5UcVZHQytyZHYzZmFoai8ya2EveDhaa3I5dm1mNVRZMDlkTWQ2?=
 =?utf-8?B?TUhzTWd1Z0t4ZG1lcHh6cTI0SnZ6bnhTcFRoeXpHVk5pYVBWMEgvTUZLTkxX?=
 =?utf-8?B?Y1FUOVd1TnR3R25VK1p0dk9RK1cxdldhZHdVVlo0N2Q2anI0Q0dMNk1KaFgx?=
 =?utf-8?B?M2RnWW9JU3VodEI3QUxHZ2lXWGhkWi96akREbXhudDJyMjRkVVlEK1NCTEtm?=
 =?utf-8?B?RWpDajA5TU9OeXZYR0pzQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54FE3CB2B23A4647BF4E35AA41AB351F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8f0424-56a7-4fb3-4cf0-08d98538593b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 00:05:31.0421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3CO6Tegs7pv70GMKdYnMK5+zkeWFmC5R4qOnVJHg10UwPNTBn74UDr8peyaAnWw0t0oh6R9Hsbqz42TLl075CDXRkZt+UtC1dhurcZ1Lus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5588
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTAxIGF0IDE3OjUyIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIDIwMjEtMTAtMDEgNDo1OCBwLm0uLCBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+ID4gT24gRnJpLCAyMDIxLTEwLTAxIGF0IDE1OjE4IC0wNTAwLCBCam9ybiBIZWxnYWFz
IHdyb3RlOg0KPiA+ID4gRGlkbid0IG5vdGljZSB0aGlzIGJlZm9yZSwgYnV0IHRoZSAiY2hlY2tf
YWNjZXNzKCkiIG5hbWUgaXMgbm90DQo+ID4gPiB2ZXJ5DQo+ID4gPiBoZWxwZnVsIGJlY2F1c2Ug
aXQgZG9lc24ndCBnaXZlIGEgY2x1ZSBhYm91dCB3aGF0IHRoZSByZXR1cm4NCj4gPiA+IHZhbHVl
DQo+ID4gPiBtZWFucy4gIERvZXMgMCBtZWFuIG5vIGVycm9yPyAgRG9lcyAxIG1lYW4gbm8gZXJy
b3I/ICBGcm9tDQo+ID4gPiByZWFkaW5nDQo+ID4gPiB0aGUNCj4gPiA+IGltcGxlbWVudGF0aW9u
LCBJIGNhbiBzZWUgdGhhdCAwIGlzIGFjdHVhbGx5IHRoZSBlcnJvciBjYXNlLCBidXQNCj4gPiA+
IEkNCj4gPiA+IGNhbid0IHRlbGwgZnJvbSB0aGUgbmFtZS4NCj4gPiANCj4gPiBZZXMsIHdpbGwg
aW1wcm92ZSB0aGUgbmFtaW5nLCBsaWtlIGNoYW5nZSBpdCB0byAiaGFzX2dhc19hY2Nlc3MoKSIN
Cj4gPiBpbg0KPiA+IHYyIGlmIGEgdjIgcGF0Y2hzZXQgaXMgcHJlZmVycmVkLg0KPiANCj4gSSdk
IGtlZXAgdGhlIEdBUyBuYW1lIG91dCBvZiB0aGUga2VybmVsLiBIb3cgYWJvdXQgc29tZXRoaW5n
IGFsb25nDQo+IHRoZQ0KPiBsaW5lcyBvZiBpc19maXJtd2FyZV9ydW5uaW5nKCk/IE1heWJlIGEg
Y29tbWVudCBmb3IgdGhlIGZ1bmN0aW9uDQo+IHdvdWxkDQo+IGJlIGdvb2QgYXMgd2VsbC4NCj4g
DQpZZXMsIHRoYXQnbGwgYmUgYW4gaW1wcm92ZW1lbnQuDQo+IExvZ2FuDQo=

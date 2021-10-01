Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8841F7EB
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJAXAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 19:00:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25998 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhJAXAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 19:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633129115; x=1664665115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4g9uU3XE9iUBujsQ30ABVXWOl5GhA7nTk8gHV72VxH8=;
  b=j8HQIYY8D8b45XO0lt3BuGRObNie8L8DLS3y4wfgNmZGx/XnDQmBtwb9
   5xbiJCnkF1JU4ZxTOLZtPp8wgUSpkv0vyBWJQVfWWk0zV6WxoHh/mAHei
   dy8xxiXXP1pPpA7a5HDxT6Rz4QSjII4urlPkzHk/v6kSZkbSlo5QDjG4w
   C3suWpp6NmXUE9f1njbxSgqX4YMJPSmNYwSVCvgB79HczKyS1dcKbjeJ0
   +9EjKRYNkiE13KED9vowRfXNVt/focMoJuIF6giEuRpWMlsEVtFg3Bnll
   0HP1RteyKBSeL02ubnpxHCw/oLR96Wv8Bq/QULkZj3NZzeD9a+5GAn4w5
   g==;
IronPort-SDR: 8T3Jv4jgZTBHZRSwFGHCNWgmKpnXZpalg1Wkv+YD+3kejlcoSKNJnwPhmfDDtHWfWbt/S5G4RK
 1+CLZa5l1rrsK6SDE47InsOygILEEbT3d/QpYIQ3Ume5fQcN9zrblKXqOsPaGxApXidit4Ckr3
 q5va7rd2+Oa+69x3BkgJwCNVMMkRBTmlEnfxjQvOKBArKXdnIDYLMCG/nzliAOPhXA4B7xxmDf
 pJqL6EzlbrScsLRtiuptEqmgwL4wuT+cHCRaCCgSiC3pxiESErfnmlyXNYCurNiwjBF3H07LsO
 3Ldh4/eyNOVMW/nbInz1O5Kh
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="138186833"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2021 15:58:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 1 Oct 2021 15:58:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 1 Oct 2021 15:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGYsCRymjYd2jeb7x2N9VmYI+y1/BlSbJKCU8msiKNH2tTCV/MF9/bH1+Wbkta/qkI94kjgDT2ePo/tpG1CY3ZsbspdblIPvizvhTkKq7CzjBMKy3Y7/obCnREtZYPzivLKCh4yvarKOprq9KhLg+rSeiX/Y5X2oL33b8RSveHu1u915uSaqOlUu/FUhG7wmkQU5MJB9FcUuBxva7EGYiDtFTSElY60IvEBGoA7V6Bx67pNkddyCe3yGscqBz0aXO2TqwzmdYq20lGksR7n4gZJLpB3EhOGqmkBZ46LW3BsmhUuh6ZB6aaHBbXO7vDL4YmgTFmZ5G/0L1rptxZB0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g9uU3XE9iUBujsQ30ABVXWOl5GhA7nTk8gHV72VxH8=;
 b=i3sk5Y/Y/H/wcfKlT/akFaplZvODO3c7EJpcrzIWWifBHrp8oXDf0ScgJcwRdwLIsJVReSMLUZ7vAZPjVnKGOAAaz5A8lW5aF/wwuU/kE/PWmBC92XTNEU+kyvvTEbDHyojIOS1rSuEFuU4fgDsv/EIUyfd50UQ3KU5YTACW1LrhgHQd39dLod3VPXa3s11BoutFYDCK2LQEeCCbRkJE6IxIAP4BwmvjykG9D9hMvjr4kpweXSu8+K7LpVLVlScsbJuTM6CCoyf+aOyD7LN5cz9YkExR8NZ1R8UFJqVN3bpwASy1x3xqPzEcJ/SCKTfBwTg6yxx1eRZaGz7vzWCahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g9uU3XE9iUBujsQ30ABVXWOl5GhA7nTk8gHV72VxH8=;
 b=XJG/kzzBIbhtbcluzTYpb2ygfQ5Axas+F4hixNcXFrKgZDfMdyTzsfD/eJ1cNGzb+AhM05PSuAEw/R0eboKmQqDsZ1Ba8+55p3kIfkoiv0Sb7qa/peRmFqNASF6w0VBLkTQozN9VvzDhYporZ99RFEmJXcFhtlnU70Ogug6vs/c=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 22:58:30 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 22:58:29 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAAsYQA=
Date:   Fri, 1 Oct 2021 22:58:29 +0000
Message-ID: <2f7b4e6debbf7156a4da26bad0373d9df9667e66.camel@microchip.com>
References: <20211001201822.GA962472@bhelgaas>
In-Reply-To: <20211001201822.GA962472@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63133af5-d9bf-4c38-1afc-08d9852efc6b
x-ms-traffictypediagnostic: CO6PR11MB5602:
x-microsoft-antispam-prvs: <CO6PR11MB5602B7A2811C08FC7D2589DC8DAB9@CO6PR11MB5602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jtm/WWRlAmQimD5Mcbse3U2J60sUgjBe81sdsx0F5LtW+jFF8DM+FQB3gBfa0ClZ4L/wvd4gLXWeknOXfwZ23xdpvG/5KvOUlBwDpCyKa/MBJ7LsjCQZJjnnOTQmRoI8lYaTpX3hkdxpwblcIgTUHLq7xR9lu8BnDLLsWyuj+TCFo7V7VncXSR89buG4kurC80hdM0obRVebvQHwgRfiwK90sEivinY72fIK5ieH18gsRas3pB0i7/fuOCUDEMt5c4U9YYbCdtsUKXmECupYB7+6Qm5IXjTM+CAYBXkOzkDU/lDHUj3/e3RXaj6OXy9AK4uQpYJAM54N2xE1sRtdRYt3Z0KcgbERE+3SgkYj0rX/fDo6jT02w72od2fMdvACzvARIJ9DbLsjNC9P0oZjvP7tPQyfdKP2utR8pdDfspEXpjHR3063q/1gnWBK+T8lNfgWqLqBuxlh+CQwtpmK3UYTK6D6B0U4iVgfblq0hNAQC6z/PYQoxLenqje+nGe7Evyq6pxFZ44zhRhdN2rnc5KcOElj+aPVR076ISxDGsf+VETLXi/JWQwMgyNr1gQi9mqRbvKeHeWbPMlIlid/n+oWNEpUWAeWjvfa4M86O3RXDNQM7tCp/OipXLOQyvysFd1afWMI3jYFywe4gvK9HMsLExZ9oBbpGB0O1sh/yqPgZMkEiWEfo5yaOLyzKhale6wV+jtUfsXStUGyYM6OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(38100700002)(26005)(5660300002)(6506007)(54906003)(122000001)(66476007)(76116006)(38070700005)(64756008)(66556008)(66446008)(6486002)(2616005)(6916009)(2906002)(186003)(66946007)(8936002)(86362001)(71200400001)(508600001)(4326008)(6512007)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Njc5V0MwWGppeklEN0xrTFlLL2ZMaXFCbC9EYWh2RzQrU25FVjdOWnpIdmZz?=
 =?utf-8?B?N3ZnUzR1S1dmZ2ZPTkt3NC9ESS9hZTJHNnh1K1FSUG5KYzhidENRR0I5Zytj?=
 =?utf-8?B?OVdFczlBUXQrYnNWeHhrSENZYTJTZFBPemVXVmZvTnJvdTRhY2wya0N0eDRK?=
 =?utf-8?B?MXMzeGJzR244YXVzNTc3ei9MWWhIQUhhTU1rUkFNb29zSS9hMFJwN2Q0Wi9o?=
 =?utf-8?B?U1VVWTJtbFA4Vk9JR1B3aEtocy92R05VMG5laWxvdUt6cWYwV2l6TUdJTWZM?=
 =?utf-8?B?L040dVQ4aTNoWERwQjJVMlNobENKZGh2d1pFWTcwemJyYTd0aE5keVBhd2NW?=
 =?utf-8?B?V2tNK1dnSG9nUjRXQXhOTllrVWtJMjQxbm84WDRVOXV4ZlRHT3VjYVBJS2F4?=
 =?utf-8?B?MmMxQytJa0NVY2xnaXJSN2tYN3JlL1FtbXB1RkUxRUErdUxIWjhqUUFkbERo?=
 =?utf-8?B?ZmpCTjE1c1o2T3RPUGFyanhncTNSemdIY2trbkV1eWtNdE1KaWptTERFTklj?=
 =?utf-8?B?OUR1RkU5MktsZFEyWkF1RDI5MHhQd0VrS2RtbU9QNngwaHdMSXJMaDUrR2pY?=
 =?utf-8?B?c2pCQ3czdktCcjY3Uy9HN3lqbFYxMU9xWk13cld6alpnWnVNanpsa0VsdElC?=
 =?utf-8?B?Ynpuc2FrcG83My9BbkxTNlhpb0F2RS81d0lMVC84U1JycXFkc0IrMmgvZkpE?=
 =?utf-8?B?WGZFUDcxN1pzSGV6dmJPQkU5N0xMQ0NXbEJERlIzM21sSWwwaXE0MDkyVnBF?=
 =?utf-8?B?VmI5TE40ZG9NMVZOSXcyZlZWaTRtYWlpQS96S3lJM2FvckNQRTJIcWp0REpl?=
 =?utf-8?B?WEM2WDN3UUVlU1dLcHdsTFA0THExUDZja1hXLzBWYUFnVkdaVWlUZzJla2Vu?=
 =?utf-8?B?cEI1NDlJUEtWWEpqbDNRcnExUnpISEg2cFZubVZ5Ym1vVCs4OHR0YjNERG1l?=
 =?utf-8?B?Qnd3ZlpDQjdEZG82MFdrV20rR1ovcWg5eFNybmV1SkNhTXZibWpwc1ArOHkz?=
 =?utf-8?B?b1JQTVpNYjZxQ2ZCWGRjemU0djE0SUo5aWtiK0lmblZtZEZqcHpTdXNqR0kz?=
 =?utf-8?B?Mjd2TXh3S2dzQnQyRDRSbEwwWWRuTVVpbmdtTjdoOUtNSURnejE5R3FMYzQr?=
 =?utf-8?B?czZMMy9KTzlTWWJwRVJMNSt4TzdLNHh0UFhKd04rVjV3YjlEOS84Mms2N1RW?=
 =?utf-8?B?WmV0VG1NdFREazdrdkJSbmVQTkhIOW9DaTVLaXllOUlVa3BDcmw5bG14U0U4?=
 =?utf-8?B?MWpNYzR0blpNVkpsdjdoOU5JbFJMRGtPR21ZOU91Z0ZIUHBrYTVkdVVRRzBs?=
 =?utf-8?B?eSs3bXIxajJ5ZDFzc0kyYUdpRkdJVWhnbXpIVGgvNXF2blI4eGNJZExQclYy?=
 =?utf-8?B?QzRCd29kTjc4bVVQOFlTcUdlNEl2UjdEQnlOZHRFRzIzRlJ1UnI2YVZLWnJt?=
 =?utf-8?B?R0RFOE81b0dZb2VtUTdZYkpxdTdxSEh5RVZZTWVUamdzR3ZxM1VoS3Vkb1dm?=
 =?utf-8?B?WWN0TFFNclBhbWdRR2tudVV3OU9rZUNpbXVsTERrZzlZd1dUb0lZbkg2VXZN?=
 =?utf-8?B?SldNaWZsUDZtOG9KcmdwM1crWWI4Nm1kRnY2STZmWXl1NTZkS291USsxMVly?=
 =?utf-8?B?YUJ6UDczdkpyODg5Tkw0M0dxWFpoVVlLVjJLRkV5TzA2VHhUTmxjOGZFSUZ2?=
 =?utf-8?B?Z3h0QWhRWHhBMmJwRWdTeDc4aThaeE8vY3c4dDY5c1NyaG0rT01ZS0REejE2?=
 =?utf-8?B?WTMxdWc2UkVIT0FOaGlsbHZZRW9CeEZ1dDBuUG5uRDV2SFAybldCQWtXakVw?=
 =?utf-8?B?aEU3TmFTZSs4RXJvZ3pQZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <043BC018C70456439C2240B7836B9109@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63133af5-d9bf-4c38-1afc-08d9852efc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 22:58:29.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO13b3wEVsIBOVQcfdIuXU9zdOpLV2wfWBmfWSEQTYD8yYlPbx6Gk5SchxUrdvwCsPLlOtoSLQ0byeubPC/T3E3dYjyyn3KiSeYVoGOokbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTAxIGF0IDE1OjE4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBGcmksIFNlcCAyNCwgMjAyMSBhdCAxMTowODozOEFNICswMDAwLCBrZWx2aW4uY2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gRnJvbTogS2VsdmluIENhbyA8a2VsdmluLmNhb0Bt
aWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+IEFmdGVyIGEgZmlybXdhcmUgaGFyZCByZXNldCwgTVJQ
QyBjb21tYW5kIGV4ZWN1dGlvbnMsIHdoaWNoIGFyZQ0KPiA+IGJhc2VkDQo+ID4gb24gdGhlIFBD
SSBCQVIgKHdoaWNoIE1pY3JvY2hpcCByZWZlcnMgdG8gYXMgR0FTKSByZWFkL3dyaXRlLCB3aWxs
DQo+ID4gaGFuZw0KPiA+IGluZGVmaW5pdGVseS4gVGhpcyBpcyBiZWNhdXNlIGFmdGVyIGEgcmVz
ZXQsIHRoZSBob3N0IHdpbGwgZmFpbCBhbGwNCj4gPiBHQVMNCj4gPiByZWFkcyAoZ2V0IGFsbCAx
cyksIGluIHdoaWNoIGNhc2UgdGhlIGRyaXZlciB3b24ndCBnZXQgYSB2YWxpZCBNUlBDDQo+ID4g
c3RhdHVzLg0KPiANCj4gVHJ5aW5nIHRvIHdyaXRlIGEgbWVyZ2UgY29tbWl0IGxvZyBmb3IgdGhp
cywgYnV0IGhhdmluZyBhIGhhcmQgdGltZQ0KPiBzdW1tYXJpemluZyBpdC4gIEl0IHNvdW5kcyBs
aWtlIGl0IGNvdmVycyBib3RoIFN3aXRjaHRlYy1zcGVjaWZpYw0KPiAoZmlybXdhcmUgYW5kIE1S
UEMgY29tbWFuZHMpIGFuZCBnZW5lcmljIFBDSWUgYmVoYXZpb3IgKE1NSU8gcmVhZA0KPiBmYWls
dXJlcykuDQo+IA0KPiBUaGlzIGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCBhIGZpcm13YXJlIGhh
cmQgcmVzZXQuICBXaGF0IGlzIHRoYXQ/DQo+IElzIHRoYXQgbGlrZSBhIGZpcm13YXJlIHJlYm9v
dD8gIEEgZGV2aWNlIHJlc2V0LCBlLmcuLCBGTFIgb3INCj4gc2Vjb25kYXJ5IGJ1cyByZXNldCwg
dGhhdCBjYXVzZXMgYSBmaXJtd2FyZSByZWJvb3Q/ICBBIGRldmljZSByZXNldA0KPiBpbml0aWF0
ZWQgYnkgZmlybXdhcmU/DQo+IA0KPiBBbnl3YXksIGFwcGFyZW50bHkgd2hlbiB0aGF0IGhhcHBl
bnMsIE1NSU8gcmVhZHMgdG8gdGhlIHN3aXRjaCBmYWlsDQo+ICh0aW1lb3V0IG9yIGVycm9yIGNv
bXBsZXRpb24gb24gUENJZSkgZm9yIGEgd2hpbGUuICBJZiBhIGRldmljZSByZXNldA0KPiBpcyBp
bnZvbHZlZCwgdGhhdCBtdWNoIGlzIHN0YW5kYXJkIFBDSWUgYmVoYXZpb3IuICBBbmQgdGhlIGRy
aXZlcg0KPiBzZWVzDQo+IH4wIGRhdGEgZnJvbSB0aG9zZSBmYWlsZWQgcmVhZHMuICBUaGF0J3Mg
bm90IHBhcnQgb2YgdGhlIFBDSWUgc3BlYywNCj4gYnV0IGlzIHR5cGljYWwgcm9vdCBjb21wbGV4
IGJlaGF2aW9yLg0KPiANCj4gQnV0IHlvdSBzYWlkIHRoZSBNUlBDIGNvbW1hbmRzIGhhbmcgaW5k
ZWZpbml0ZWx5LiAgUHJlc3VtYWJseSBNTUlPDQo+IHJlYWRzIHdvdWxkIHN0YXJ0IHN1Y2NlZWRp
bmcgZXZlbnR1YWxseSB3aGVuIHRoZSBkZXZpY2UgYmVjb21lcw0KPiByZWFkeSwNCj4gc28gSSBk
b24ndCBrbm93IGhvdyB0aGF0IHRyYW5zbGF0ZXMgdG8gImluZGVmaW5pdGVseS4iDQo+IA0KPiBX
ZWlyZCB0byByZWZlciB0byBhIFBDSSBCQVIgYXMgIkdBUyIuICBNYXliZSBleHBhbmRpbmcgdGhl
IGFjcm9ueW0NCj4gd291bGQgaGVscCBpdCBtYWtlIHNlbnNlLg0KPiANCj4gV2hhdCBkb2VzICJo
b3N0IiByZWZlciB0bz8gIEkgZ3Vlc3MgaXQncyB0aGUgc3dpdGNoICh0aGUNCj4gc3dpdGNodGVj
X2RldiksIHNpbmNlIHlvdSBzYXkgaXQgZmFpbHMgTU1JTyByZWFkcz8NCj4gDQo+IE5hbWluZyBj
b21tZW50IGJlbG93Lg0KPiANCj4gPiBBZGQgYSByZWFkIGNoZWNrIHRvIEdBUyBhY2Nlc3Mgd2hl
biBhIE1SUEMgY29tbWFuZCBleGVjdXRpb24NCj4gPiBkb2Vzbid0DQo+ID4gcmVzcG9uc2UgdGlt
ZWx5LCBlcnJvciBvdXQgaWYgdGhlIGNoZWNrIGZhaWxzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEtlbHZpbiBDYW8gPGtlbHZpbi5jYW9AbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9wY2kvc3dpdGNoL3N3aXRjaHRlYy5jIHwgNTkNCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9zd2l0
Y2gvc3dpdGNodGVjLmMNCj4gPiBiL2RyaXZlcnMvcGNpL3N3aXRjaC9zd2l0Y2h0ZWMuYw0KPiA+
IGluZGV4IDBiMzAxZjhiZTllZC4uMDkyNjUzNDg3MDIxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL3N3aXRjaC9zd2l0Y2h0ZWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3N3aXRjaC9z
d2l0Y2h0ZWMuYw0KPiA+IEBAIC00NSw2ICs0NSw3IEBAIGVudW0gbXJwY19zdGF0ZSB7DQo+ID4g
ICAgICAgTVJQQ19RVUVVRUQsDQo+ID4gICAgICAgTVJQQ19SVU5OSU5HLA0KPiA+ICAgICAgIE1S
UENfRE9ORSwNCj4gPiArICAgICBNUlBDX0lPX0VSUk9SLA0KPiA+ICB9Ow0KPiA+IA0KPiA+ICBz
dHJ1Y3Qgc3dpdGNodGVjX3VzZXIgew0KPiA+IEBAIC02Niw2ICs2NywxMyBAQCBzdHJ1Y3Qgc3dp
dGNodGVjX3VzZXIgew0KPiA+ICAgICAgIGludCBldmVudF9jbnQ7DQo+ID4gIH07DQo+ID4gDQo+
ID4gK3N0YXRpYyBpbnQgY2hlY2tfYWNjZXNzKHN0cnVjdCBzd2l0Y2h0ZWNfZGV2ICpzdGRldikN
Cj4gPiArew0KPiA+ICsgICAgIHUzMiBkZXZpY2UgPSBpb3JlYWQzMigmc3RkZXYtPm1taW9fc3lz
X2luZm8tPmRldmljZV9pZCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBzdGRldi0+cGRldi0+
ZGV2aWNlID09IGRldmljZTsNCj4gPiArfQ0KPiANCj4gRGlkbid0IG5vdGljZSB0aGlzIGJlZm9y
ZSwgYnV0IHRoZSAiY2hlY2tfYWNjZXNzKCkiIG5hbWUgaXMgbm90IHZlcnkNCj4gaGVscGZ1bCBi
ZWNhdXNlIGl0IGRvZXNuJ3QgZ2l2ZSBhIGNsdWUgYWJvdXQgd2hhdCB0aGUgcmV0dXJuIHZhbHVl
DQo+IG1lYW5zLiAgRG9lcyAwIG1lYW4gbm8gZXJyb3I/ICBEb2VzIDEgbWVhbiBubyBlcnJvcj8g
IEZyb20gcmVhZGluZw0KPiB0aGUNCj4gaW1wbGVtZW50YXRpb24sIEkgY2FuIHNlZSB0aGF0IDAg
aXMgYWN0dWFsbHkgdGhlIGVycm9yIGNhc2UsIGJ1dCBJDQo+IGNhbid0IHRlbGwgZnJvbSB0aGUg
bmFtZS4NCg0KWWVzLCB3aWxsIGltcHJvdmUgdGhlIG5hbWluZywgbGlrZSBjaGFuZ2UgaXQgdG8g
Imhhc19nYXNfYWNjZXNzKCkiIGluDQp2MiBpZiBhIHYyIHBhdGNoc2V0IGlzIHByZWZlcnJlZC4N
Cj4gDQo+ID4gIHN0YXRpYyBzdHJ1Y3Qgc3dpdGNodGVjX3VzZXIgKnN0dXNlcl9jcmVhdGUoc3Ry
dWN0IHN3aXRjaHRlY19kZXYNCj4gPiAqc3RkZXYpDQo+ID4gIHsNCj4gPiAgICAgICBzdHJ1Y3Qg
c3dpdGNodGVjX3VzZXIgKnN0dXNlcjsNCj4gPiBAQCAtMTEzLDYgKzEyMSw3IEBAIHN0YXRpYyB2
b2lkIHN0dXNlcl9zZXRfc3RhdGUoc3RydWN0DQo+ID4gc3dpdGNodGVjX3VzZXIgKnN0dXNlciwN
Cj4gPiAgICAgICAgICAgICAgIFtNUlBDX1FVRVVFRF0gPSAiUVVFVUVEIiwNCj4gPiAgICAgICAg
ICAgICAgIFtNUlBDX1JVTk5JTkddID0gIlJVTk5JTkciLA0KPiA+ICAgICAgICAgICAgICAgW01S
UENfRE9ORV0gPSAiRE9ORSIsDQo+ID4gKyAgICAgICAgICAgICBbTVJQQ19JT19FUlJPUl0gPSAi
SU9fRVJST1IiLA0KPiA+ICAgICAgIH07DQo+ID4gDQo+ID4gICAgICAgc3R1c2VyLT5zdGF0ZSA9
IHN0YXRlOw0KPiA+IEBAIC0xODQsNiArMTkzLDIxIEBAIHN0YXRpYyBpbnQgbXJwY19xdWV1ZV9j
bWQoc3RydWN0DQo+ID4gc3dpdGNodGVjX3VzZXIgKnN0dXNlcikNCj4gPiAgICAgICByZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdm9pZCBtcnBjX2NsZWFudXBfY21kKHN0cnVj
dCBzd2l0Y2h0ZWNfZGV2ICpzdGRldikNCj4gPiArew0KPiA+ICsgICAgIC8qIHJlcXVpcmVzIHRo
ZSBtcnBjX211dGV4IHRvIGFscmVhZHkgYmUgaGVsZCB3aGVuIGNhbGxlZCAqLw0KPiA+ICsgICAg
IHN0cnVjdCBzd2l0Y2h0ZWNfdXNlciAqc3R1c2VyID0gbGlzdF9lbnRyeShzdGRldi0NCj4gPiA+
bXJwY19xdWV1ZS5uZXh0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QNCj4gPiBzd2l0Y2h0ZWNfdXNlciwgbGlzdCk7DQo+ID4gKw0K
PiA+ICsgICAgIHN0dXNlci0+Y21kX2RvbmUgPSB0cnVlOw0KPiA+ICsgICAgIHdha2VfdXBfaW50
ZXJydXB0aWJsZSgmc3R1c2VyLT5jbWRfY29tcCk7DQo+ID4gKyAgICAgbGlzdF9kZWxfaW5pdCgm
c3R1c2VyLT5saXN0KTsNCj4gPiArICAgICBzdHVzZXJfcHV0KHN0dXNlcik7DQo+ID4gKyAgICAg
c3RkZXYtPm1ycGNfYnVzeSA9IDA7DQo+ID4gKw0KPiA+ICsgICAgIG1ycGNfY21kX3N1Ym1pdChz
dGRldik7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIG1ycGNfY29tcGxldGVfY21k
KHN0cnVjdCBzd2l0Y2h0ZWNfZGV2ICpzdGRldikNCj4gPiAgew0KPiA+ICAgICAgIC8qIHJlcXVp
cmVzIHRoZSBtcnBjX211dGV4IHRvIGFscmVhZHkgYmUgaGVsZCB3aGVuIGNhbGxlZCAqLw0KPiA+
IEBAIC0yMjMsMTMgKzI0Nyw3IEBAIHN0YXRpYyB2b2lkIG1ycGNfY29tcGxldGVfY21kKHN0cnVj
dA0KPiA+IHN3aXRjaHRlY19kZXYgKnN0ZGV2KQ0KPiA+ICAgICAgICAgICAgICAgbWVtY3B5X2Zy
b21pbyhzdHVzZXItPmRhdGEsICZzdGRldi0+bW1pb19tcnBjLQ0KPiA+ID5vdXRwdXRfZGF0YSwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3R1c2VyLT5yZWFkX2xlbik7DQo+ID4g
IG91dDoNCj4gPiAtICAgICBzdHVzZXItPmNtZF9kb25lID0gdHJ1ZTsNCj4gPiAtICAgICB3YWtl
X3VwX2ludGVycnVwdGlibGUoJnN0dXNlci0+Y21kX2NvbXApOw0KPiA+IC0gICAgIGxpc3RfZGVs
X2luaXQoJnN0dXNlci0+bGlzdCk7DQo+ID4gLSAgICAgc3R1c2VyX3B1dChzdHVzZXIpOw0KPiA+
IC0gICAgIHN0ZGV2LT5tcnBjX2J1c3kgPSAwOw0KPiA+IC0NCj4gPiAtICAgICBtcnBjX2NtZF9z
dWJtaXQoc3RkZXYpOw0KPiA+ICsgICAgIG1ycGNfY2xlYW51cF9jbWQoc3RkZXYpOw0KPiA+ICB9
DQo+ID4gDQo+ID4gIHN0YXRpYyB2b2lkIG1ycGNfZXZlbnRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspDQo+ID4gQEAgLTI0Niw2ICsyNjQsMjMgQEAgc3RhdGljIHZvaWQgbXJwY19ldmVu
dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdA0KPiA+ICp3b3JrKQ0KPiA+ICAgICAgIG11dGV4X3Vu
bG9jaygmc3RkZXYtPm1ycGNfbXV0ZXgpOw0KPiA+ICB9DQo+ID4gDQo+ID4gK3N0YXRpYyB2b2lk
IG1ycGNfZXJyb3JfY29tcGxldGVfY21kKHN0cnVjdCBzd2l0Y2h0ZWNfZGV2ICpzdGRldikNCj4g
PiArew0KPiA+ICsgICAgIC8qIHJlcXVpcmVzIHRoZSBtcnBjX211dGV4IHRvIGFscmVhZHkgYmUg
aGVsZCB3aGVuIGNhbGxlZCAqLw0KPiA+ICsNCj4gPiArICAgICBzdHJ1Y3Qgc3dpdGNodGVjX3Vz
ZXIgKnN0dXNlcjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGxpc3RfZW1wdHkoJnN0ZGV2LT5tcnBj
X3F1ZXVlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgc3R1
c2VyID0gbGlzdF9lbnRyeShzdGRldi0+bXJwY19xdWV1ZS5uZXh0LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHN3aXRjaHRlY191c2VyLCBsaXN0KTsNCj4gPiArDQo+ID4g
KyAgICAgc3R1c2VyX3NldF9zdGF0ZShzdHVzZXIsIE1SUENfSU9fRVJST1IpOw0KPiA+ICsNCj4g
PiArICAgICBtcnBjX2NsZWFudXBfY21kKHN0ZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3Rh
dGljIHZvaWQgbXJwY190aW1lb3V0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+
ICB7DQo+ID4gICAgICAgc3RydWN0IHN3aXRjaHRlY19kZXYgKnN0ZGV2Ow0KPiA+IEBAIC0yNTcs
NiArMjkyLDExIEBAIHN0YXRpYyB2b2lkIG1ycGNfdGltZW91dF93b3JrKHN0cnVjdA0KPiA+IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiA+IA0KPiA+ICAgICAgIG11dGV4X2xvY2soJnN0ZGV2LT5tcnBj
X211dGV4KTsNCj4gPiANCj4gPiArICAgICBpZiAoIWNoZWNrX2FjY2VzcyhzdGRldikpIHsNCj4g
PiArICAgICAgICAgICAgIG1ycGNfZXJyb3JfY29tcGxldGVfY21kKHN0ZGV2KTsNCj4gPiArICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gICAgICAgaWYgKHN0
ZGV2LT5kbWFfbXJwYykNCj4gPiAgICAgICAgICAgICAgIHN0YXR1cyA9IHN0ZGV2LT5kbWFfbXJw
Yy0+c3RhdHVzOw0KPiA+ICAgICAgIGVsc2UNCj4gPiBAQCAtNTQ0LDYgKzU4NCwxMSBAQCBzdGF0
aWMgc3NpemVfdCBzd2l0Y2h0ZWNfZGV2X3JlYWQoc3RydWN0IGZpbGUNCj4gPiAqZmlscCwgY2hh
ciBfX3VzZXIgKmRhdGEsDQo+ID4gICAgICAgaWYgKHJjKQ0KPiA+ICAgICAgICAgICAgICAgcmV0
dXJuIHJjOw0KPiA+IA0KPiA+ICsgICAgIGlmIChzdHVzZXItPnN0YXRlID09IE1SUENfSU9fRVJS
T1IpIHsNCj4gPiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygmc3RkZXYtPm1ycGNfbXV0ZXgp
Ow0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiAgICAgICBpZiAoc3R1c2VyLT5zdGF0ZSAhPSBNUlBDX0RPTkUpIHsNCj4gPiAgICAgICAgICAg
ICAgIG11dGV4X3VubG9jaygmc3RkZXYtPm1ycGNfbXV0ZXgpOw0KPiA+ICAgICAgICAgICAgICAg
cmV0dXJuIC1FQkFERTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+IA0K

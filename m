Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0D424668
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFTCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 15:02:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15234 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFTCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 15:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633546861; x=1665082861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7ynvUGg8P+x5Kbkzgg0jLOFNevf6gDP4yoyHABQeH2w=;
  b=XfhfOSxDsnPwLmcscszM0EBnepG60locL4MjJqZ3DRIChImcYtf2IpJh
   o1NTsNWgcw9tcZjI7cmhvNdS/R3reDGL8VZbyNdfQ34J5EGTOBb1qXRT5
   muzusaDGGqZzNdxiEc5u+ukOyon6fRzF6/+043DhMa2jR+KUMl94HeOWP
   R/qMguNW7SK3eXp5Dpr4g9LVsMTHYU/eeev35X3BrUQaG2KwExAMM1A+E
   qTo81XlUhghTlPSLMtRM7tK0KpE2bgIemKXsTiNp6JY2YQAou3ooDJx4n
   Xv/fru6HRLcIWtW5q7VBNodwLBq/hN5XLhAqANZTzWf+1ucFvxhehs0SA
   A==;
IronPort-SDR: BdQTn1KSV1v8LIA+JIdMBWQhytQ4FoXRDJEudn/x4VyqZWayzOY1QF74P823o9LFXBcVwzoQVX
 wLb03RDYC6LVQ56/aJO11PA0EHJx4C5xrA0by5zwNLQv9vvJWXqG/c7v3rWrqunoMV2W3GWAtv
 7qr/kKLQ24E0sF6ykVCkZ3ZLaYOQl6mKYI0ZFdKo78GgI2DQBI8Fi+XTZZsnkl8E5DhzzQopof
 iUfm++NQWK6rDvpXqCx3Vgyp5EPFUVW/4HgRtmB3zrl9cFWbHgL01R7D0gY0BfDYO9F9GakF+N
 lFYXL7xxjq4kcsNa3i+0Qyk+
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="138716337"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2021 12:01:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Oct 2021 12:00:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Wed, 6 Oct 2021 12:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5VIPa4I7efu4OKb7+oeDalGcKVj58XZOltJ8GlFdfWR/q42W+S97YiqNRKNVZV4PkwaQz1XWlM2L+Ss6tSoSes2OWI/YcxjFFtwQ6JsGPk+osHJz9uHSVE9sALGmIQZgRZZtakfizkgquh0gLkrgXwWcrjRGgZz3R3o9lj5q46aGaqdiKbtw7Tr03IEg6aUV08hzqedmy4JrwllUV4KYu6tRXpfBdP+AM1JfX9TiocSvry5NDUZ/NqUUnqmb5FAwjcxm2sO18+YvoOSpF3zhW4ojUnFDmOfFvCf0jODZ8aQHiZA8cJO2SsxMhPWb9nYNRyifOdb28VceJcHxQUs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ynvUGg8P+x5Kbkzgg0jLOFNevf6gDP4yoyHABQeH2w=;
 b=Y1fXEuZWWA1gm/BZbWnejVF/i6icfGhjaujP/pM/5uBwJoZCvqBT/f4Gdww18sQYhfdrk9eL90Od8nHIP/A38mgJvrasWrJQqQlidAApoH5SEbPfGC83DyLPgTjCYdp6e0V6LroRc3lU8BzQBNONX+xG/XgDROBA0K4F/zu67qwVpCdfUSkuWmTGw674tapAb/E2EABXXLBIAkNW/GGSFcl1zw3d2RPYQy+2qEVEF0zbq+7BZWl3ea/Gz0jnTjU9c6+OLx2wYzZY1hk2UDa73YfpDUL77YLKUym8EAc5sfsIbnaKKPDKKN41uny0XsLcGw79vZL/ITANpfH1ZAROSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ynvUGg8P+x5Kbkzgg0jLOFNevf6gDP4yoyHABQeH2w=;
 b=rFfnunkSTKDK2gGY5PKgChpSWsZMMB9v0xRE8qunei/8t2EjNIiXec5pxzSwHT2Y/Z1LYuffiTkaYVLSdgyrG34cadakrEUM0LTxvL4aIiYyJOyjpM+cZub3o/Wxi9o51VcTBKFTTkrmmJjc3G2n8Bilk9Q+uVKutSw2MVcmjlE=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 19:00:55 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:00:55 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <linux-pci@vger.kernel.org>,
        <logang@deltatee.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAADAgCAADeugIABAgSAgAODLoCAAYeKgIAASeuAgAAgtACAADaYAIAAjs8AgABOUIA=
Date:   Wed, 6 Oct 2021 19:00:55 +0000
Message-ID: <70abccd6144d8eac461866355e3a6963b3fb3fe7.camel@microchip.com>
References: <20211006141942.GA1152835@bhelgaas>
In-Reply-To: <20211006141942.GA1152835@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9276d20-eaa6-49f1-730e-08d988fba041
x-ms-traffictypediagnostic: CO6PR11MB5617:
x-microsoft-antispam-prvs: <CO6PR11MB5617DFB5C4FD9C6BE7E1E79F8DB09@CO6PR11MB5617.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /d74OeLcSfb+NYfSacRpJTV8kr4u/x7mvjzuxHT5oYhlhUIOJGE7h8yxFWf5WekP3UF4wtqQ8HGRNq8hU6FryTq1GdQteaqpvygsk43SXD5ciRAjiQh0dDZpGbNY06G1Y90e0m3nCueG4xlu2Z+MGAzLXdt2LBDiWbwGc/l1N49WerxZCfoeMg5BTiTfhEbTegj7X51Tsjz3d+hWBQ1ptRN6H/xVXgdECtUkUIK61GfhRyQ6aVRgDMSafYgqd56/pr4qiOhtMiyvX2cbcpcqVOAMAG2RNIlDVwqsjrcADcbXwGhQx+buBNb/Kwj+7I6Jbb9suLMT2bVI+HYlieiboQbmg+mRK5papcsIHi1rLRoaNM44CoN2c9AIvv/dDeLLCyBkLoeFmF+A1uViPYlvKoG+mafO4O3RelhcWTCOYokC8otBQOWIdSFdoEt1ALLAm3EQqZH1MNV3b2Cj+bK2qWrBu6gulJYpfKgsrMTWAHtPGcBaiQGb8Mq09b8msj5i+rIlZRdVpvQ9CzZNOJuteY63IpfiPKqhbuIRrwTEu3OzVWv284AmvV7n7uVuPclulPvWLCW1LGJO74wmpAHXlQjVFAw1sgRW0gwZPIsxUouuvCM9puSxchY2gUZ3BUzsZmyPZwes93bq+ewUHjcRbJkylIvImdtpPCVHJd5SWcmYYPW7kWrTFU34EMdL7P19gnvf4muvlolvz3cAiMoWhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(8936002)(86362001)(71200400001)(4326008)(5660300002)(122000001)(38100700002)(38070700005)(2906002)(6506007)(508600001)(6916009)(316002)(54906003)(6512007)(26005)(186003)(2616005)(36756003)(83380400001)(66446008)(76116006)(66946007)(66476007)(6486002)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZjbkpEcTZoSGd6dHk0N1I3ajI2UUxDUEFRaDVZZXNQcERsNjIvUzd0OGYv?=
 =?utf-8?B?M1RCR0lsbWk2MmF1SU50bGl5OTNib01HK3k1WkFCQUxxNGJTUVkwQlpJMjhB?=
 =?utf-8?B?OVg4RXV4WE12WUVPb2lmUFBsNGZIUXpPWjhZVWZhMVNvS2Q1UytnRTdFMXNZ?=
 =?utf-8?B?dHg5YlZkNE94MExUbGEvSjFYQnp5cmNiQmdLa0FQNWV3cm5RS0FrZnN6N2hu?=
 =?utf-8?B?MkFTSk1vc0ZSVE8vRUtIV2krK3ZycjBzajdDK1UwZnlFM1U4dmVKSk5VdUJv?=
 =?utf-8?B?Y3g2bllBZEpYd013VUxtL04wUnhLaFhzd24rK0dSdnZyUFBmaFI0UDhTdDBV?=
 =?utf-8?B?N2plWDRWejVEQWVXUTVQaklBTGlWa0dlQ3c3NCtWUTNRYk91VnRWd2o5QTBD?=
 =?utf-8?B?WHZyMFpHTUg1RDJZaGpqRXRzK1o2YUhCdWZTTys3UjZvOStSYlNxZWFBelV6?=
 =?utf-8?B?b0lpL0lXRlk2V1l3YUxQTHBiZlVVQnA0MURwV1VWSWRWTHBWaHdjTU0zR0Nn?=
 =?utf-8?B?YUovaGNYY1NVeUQwd2thdVQrZStFTksrV1hWa3EvcDd1Ylg5L2pwNTQxcDIr?=
 =?utf-8?B?WndBTDljUlhzY0lEc21BeFF1RUZiQ1N4dHAxQkRTTDdaZTFuQzlkTklCSWYr?=
 =?utf-8?B?WC9Ca0xzTThYL2FrTGpuN1Fzb0RHdTRKazkwN0R2NlIxdTlaeHRQY3JyaTkv?=
 =?utf-8?B?L3YyL2l2eElqWXVscmtLNjh0bmRidEdVQW5xUXlFODh2cllDTHRNTWtjUEsz?=
 =?utf-8?B?ZE9IVjA1K0t0QThLZ0ovK0NrMCs5QVdyRldCTzBJRXdQdXRxdzU3dysvQW5T?=
 =?utf-8?B?RjFrRFdNS0VxQVAyY04xUm95TmtQRnI0RTdSdkh0V28vYUwxYnhZbWZvYWNi?=
 =?utf-8?B?OVZ2Q0FaZkpCRzdnWFFsRUhOSUpuTWNTcXdNejNHMFhEUjBMNVdSR2ZuZmZ2?=
 =?utf-8?B?ZGFaYW1ieGIzcTF1bHI5ajFYYko1QXY1S2grOGkvNDIyZU4xbmJCZWJ3Y2tj?=
 =?utf-8?B?RzhDaXRITWh2TUxvSzNRYlFXQTBqZkNlak56T0h0VGE0aVdBaTA3QnF3NTY4?=
 =?utf-8?B?NHhFT2FHMXlpdGJUVHU1ZWEyZTdpeTh2RXlDYXVXOEQ1MitQZmtBUHRlUmwy?=
 =?utf-8?B?NGhaM1J2ZUZsaDZyNUt1M21UbVdWSTIrelJ4SmZWUHRNSllrblJ5RWkrUENB?=
 =?utf-8?B?MUk1N1dLS0dZQVNHT2tLTCtPakdnUGwvOWlEbFgxbVBydjZWSVFsZ2c3V2Y5?=
 =?utf-8?B?S3lmanpGN25SSVlkRHFwU3I5eUc4eHQ3Znl1TGp0U0dINDFNYTRFc2F4WVJM?=
 =?utf-8?B?ZGUzSlJzck9qbmt3MzdWVFJic2pPYkhxK2gxeFc2YVVPQlFRVFRDWm15NG1j?=
 =?utf-8?B?em1Na2JUdjYrOE4xaGNsZHBtektYVUVVTjkzZFBqZUl0VFBMamNheDkyR1cr?=
 =?utf-8?B?NWsxV0U2YjN4c0JvaEVCZVFLSnNTdDNqS0ZJTzlGbXcwVDZWTnR2dElybGwz?=
 =?utf-8?B?aThJd2dZY0RqbkdKZm1lY0lNYVlYVmdOTFVndXFUa0NGOENSbkVDT2IzZEdi?=
 =?utf-8?B?UXUxYWFRRDhUMU1XS0MzYnRtdXc5UXI2L2c2S3dPVmFjRlQySW1qbWluRkor?=
 =?utf-8?B?MVFiM0hySzlLbHFrbUkyaEFZOXQxY3l6MUZiRFhoNFNUSXY5dTcyQi9PZjBy?=
 =?utf-8?B?Tk1OWUNsNkJtT3I4Y21qVlBzemw5dHdHeVpSR3JTVFFINHJPSnlibzE0dThO?=
 =?utf-8?B?SUJ2cWJ6MXpTd3QrM1lGaFJTNzRCdHY4RTJaNXFScHAzZ1RFVDkyZHczcENG?=
 =?utf-8?B?b055VWloTXFoUGZqdW5uZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F99015DD3E27364D91A0C67BF1DBFABB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9276d20-eaa6-49f1-730e-08d988fba041
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 19:00:55.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crY/xtDdm+Cu9uIexcRV6muFF1RlH3uGPc4jNCSmcgLOtvU4Ke6XHA3K9+CXh7j1Bskz7WzcCk/XJsaw1zLNmtczskkcKOrKsUPPn8YJU7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5617
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIxLTEwLTA2IGF0IDA5OjE5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAwNiwgMjAyMSBhdCAwNTo0OToyOUFNICswMDAwLCBLZWx2aW4uQ2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIxLTEwLTA1IGF0IDIxOjMzIC0w
NTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBPY3QgMDYsIDIwMjEgYXQg
MTI6Mzc6MDJBTSArMDAwMCwgDQo+ID4gPiBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20NCj4gPiA+
IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjEtMTAtMDUgYXQgMTU6MTEgLTA1MDAsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBPY3QgMDQsIDIwMjEgYXQgMDg6NTE6
MDZQTSArMDAwMCwNCj4gPiA+ID4gPiBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20NCj4gPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFNhdCwgMjAyMS0xMC0wMiBhdCAxMDoxMSAtMDUwMCwg
Qmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSSAqdGhvdWdodCogdGhlIHByb2Js
ZW0gd2FzIHRoYXQgdGhlIFBDSWUgTWVtb3J5IFJlYWQNCj4gPiA+ID4gPiA+ID4gZmFpbGVkIGFu
ZCB0aGUgUm9vdCBDb21wbGV4IGZhYnJpY2F0ZWQgfjAgZGF0YSB0bw0KPiA+ID4gPiA+ID4gPiBj
b21wbGV0ZQ0KPiA+ID4gPiA+ID4gPiB0aGUgQ1BVIHJlYWQuICBCdXQgbm93IEknbSBub3Qgc3Vy
ZSwgYmVjYXVzZSBpdCBzb3VuZHMNCj4gPiA+ID4gPiA+ID4gbGlrZSBpdCBtaWdodCBiZSB0aGF0
IHRoZSBQQ0llIHRyYW5zYWN0aW9uIHN1Y2NlZWRzLCBidXQNCj4gPiA+ID4gPiA+ID4gaXQgcmVh
ZHMgZGF0YSB0aGF0IGhhc24ndCBiZWVuIHVwZGF0ZWQgYnkgdGhlIGZpcm13YXJlLA0KPiA+ID4g
PiA+ID4gPiBpLmUuLCBpdCByZWFkcyAnaW4gcHJvZ3Jlc3MnIGJlY2F1c2UgZmlybXdhcmUgaGFz
bid0DQo+ID4gPiA+ID4gPiA+IHVwZGF0ZWQgaXQgdG8gJ2RvbmUnLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBUaGUgb3JpZ2luYWwgbWVzc2FnZSB3YXMgc29ydCBvZiBtaXNsZWFkaW5nLiBB
ZnRlciBhDQo+ID4gPiA+ID4gPiBmaXJtd2FyZSByZXNldCwgQ1BVIGdldHRpbmcgfjAgZm9yIHRo
ZSBQQ0llIE1lbW9yeSBSZWFkDQo+ID4gPiA+ID4gPiBkb2Vzbid0IGV4cGxhaW4gdGhlIGhhbmcu
ICBJbiBhIE1SUEMgZXhlY3V0aW9uIChETUEgTVJQQw0KPiA+ID4gPiA+ID4gbW9kZSksIHRoZSBN
UlBDIHN0YXR1cyB3aGljaCBpcyBsb2NhdGVkIGluIHRoZSBob3N0IG1lbW9yeSwNCj4gPiA+ID4g
PiA+IGdldHMgaW5pdGlhbGl6ZWQgYnkgdGhlIENQVSBhbmQgdXBkYXRlZC9maW5hbGl6ZWQgYnkg
dGhlDQo+ID4gPiA+ID4gPiBmaXJtd2FyZS4gSW4gdGhlIHNpdHVhdGlvbiBvZiBhIGZpcm13YXJl
IHJlc2V0LCBhbnkgTVJQQw0KPiA+ID4gPiA+ID4gaW5pdGlhdGVkIGFmdGVyd2FyZHMgd2lsbCBu
b3QgZ2V0IHRoZSBzdGF0dXMgdXBkYXRlZCBieSB0aGUNCj4gPiA+ID4gPiA+IGZpcm13YXJlIHBl
ciB0aGUgcmVhc29uIHlvdSBwb2ludGVkIG91dCBhYm92ZSAob3Igc2ltaWxhciwNCj4gPiA+ID4g
PiA+IHRvIG15IHVuZGVyc3RhbmRpbmcsIGZpcm13YXJlIGNhbiBubyBsb25nZXIgRE1BIGRhdGEg
dG8NCj4gPiA+ID4gPiA+IGhvc3QNCj4gPiA+ID4gPiA+IG1lbW9yeSBpbiBzdWNoIGNhc2VzKSwg
dGhlcmVmb3JlIHRoZSBNUlBDIGV4ZWN1dGlvbiB3aWxsDQo+ID4gPiA+ID4gPiBuZXZlciBlbmQu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIGdsYWQgdGhpcyBtYWtlcyBzZW5zZSB0byB5b3Us
IGJlY2F1c2UgaXQgc3RpbGwgZG9lc24ndCB0bw0KPiA+ID4gPiA+IG1lLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IGNoZWNrX2FjY2VzcygpIGRvZXMgYW4gTU1JTyByZWFkIHRvIHNvbWV0aGluZyBp
biBCQVIwLiAgSWYNCj4gPiA+ID4gPiB0aGF0IHJlYWQgcmV0dXJucyB+MCwgaXQgbWVhbnMgZWl0
aGVyIHRoZSBQQ0llIE1lbW9yeSBSZWFkDQo+ID4gPiA+ID4gd2FzDQo+ID4gPiA+ID4gc3VjY2Vz
c2Z1bCBhbmQgdGhlIFN3aXRjaHRlYyBkZXZpY2Ugc3VwcGxpZWQgfjAgZGF0YSAobWF5YmUNCj4g
PiA+ID4gPiBiZWNhdXNlIGZpcm13YXJlIGhhcyBub3QgaW5pdGlhbGl6ZWQgdGhhdCBwYXJ0IG9m
IHRoZSBCQVIpIG9yDQo+ID4gPiA+ID4gdGhlIFBDSWUgTWVtb3J5IFJlYWQgZmFpbGVkIGFuZCB0
aGUgcm9vdCBjb21wbGV4IGZhYnJpY2F0ZWQNCj4gPiA+ID4gPiB0aGUgfjAgZGF0YS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBJJ2QgbGlrZSB0byBrbm93IHdoaWNoIG9uZSBpcyBoYXBwZW5pbmcg
c28gd2UgY2FuIGNsYXJpZnkgdGhlDQo+ID4gPiA+ID4gY29tbWl0IGxvZyB0ZXh0IGFib3V0ICJN
UlBDIGNvbW1hbmQgZXhlY3V0aW9ucyBoYW5nDQo+ID4gPiA+ID4gaW5kZWZpbml0ZWx5IiBhbmQg
Imhvc3Qgd2lsIGZhaWwgYWxsIEdBUyByZWFkcy4iICBJdCdzIG5vdA0KPiA+ID4gPiA+IGNsZWFy
IHdoZXRoZXIgdGhlc2UgYXJlIFBDSWUgcHJvdG9jb2wgaXNzdWVzIG9yDQo+ID4gPiA+ID4gZHJp
dmVyL2Zpcm13YXJlIGludGVyYWN0aW9uIGlzc3Vlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhp
bmsgaXQncyB0aGUgbGF0dGVyIGNhc2UsIHRoZSB+MCBkYXRhIHdhcyBmYWJyaWNhdGVkIGJ5IHRo
ZQ0KPiA+ID4gPiByb290IGNvbXBsZXgsIGFzIHRoZSBNTUlPIHJlYWQgaW4gY2hlY2tfYWNjZXNz
KCkgYWx3YXlzIHJldHVybnMNCj4gPiA+ID4gfjAgdW50aWwgYSByZWJvb3Qgb3IgYSByZXNjYW4g
aGFwcGVucy4NCj4gPiA+IA0KPiA+ID4gSWYgdGhlIHJvb3QgY29tcGxleCBmYWJyaWNhdGVzIH4w
LCB0aGF0IG1lYW5zIGEgUENJZSB0cmFuc2FjdGlvbg0KPiA+ID4gZmFpbGVkLCBpLmUuLCB0aGUg
ZGV2aWNlIGRpZG4ndCByZXNwb25kLiAgUmVzY2FuIG9ubHkgZG9lcyBjb25maWcNCj4gPiA+IHJl
YWRzIGFuZCB3cml0ZXMuICBXaHkgc2hvdWxkIHRoYXQgY2F1c2UgdGhlIFBDSWUgdHJhbnNhY3Rp
b25zIHRvDQo+ID4gPiBtYWdpY2FsbHkgc3RhcnQgd29ya2luZz8NCj4gPiANCj4gPiBJIHRvb2sg
YSBjbG9zZXIgbG9vay4gV2hhdCBJIG9ic2VydmVkIHdhcyBsaWtlIHRoaXMuIEEgZmlybXdhcmUN
Cj4gPiByZXNldCBjbGVhcmVkIHNvbWUgQ1NSIHNldHRpbmdzIGluY2x1ZGluZyB0aGUgTVNFIGFu
ZCBNQkUgYml0cyBhbmQNCj4gPiB0aGUgQmFzZSBBZGRyZXNzIFJlZ2lzdGVycy4gV2l0aCBhIHJl
c2NhbiAocmVtb3ZpbmcgdGhlIHN3aXRjaCB0bw0KPiA+IHdoaWNoIHRoZSBtYW5hZ2VtZW50IEVQ
IHdhcyBiaW5kZWQgZnJvbSByb290IHBvcnQgYW5kIHJlc2NhbiksIHRoZQ0KPiA+IG1hbmFnZW1l
bnQgRVAgd2FzIHJlLWVudW1lcmF0ZWQgYW5kIGRyaXZlciB3YXMgcmUtcHJvYmVkLCBzbyB0aGF0
DQo+ID4gdGhlIHNldHRpbmdzIGNsZWFyZWQgYnkgdGhlIGZpcm13YXJlIHJlc2V0IHdhcyBwcm9w
ZXJseSBzZXR1cA0KPiA+IGFnYWluLA0KPiA+IHRoZXJlZm9yZSBQQ0llIHRyYW5zYWN0aW9ucyBz
dGFydCB3b3JraW5nLg0KPiANCj4gSSB0aGluayB3aGF0IHlvdSBqdXN0IHNhaWQgaXMgdGhhdA0K
PiANCj4gICAtIHRoZSBkcml2ZXIgYXNrZWQgdGhlIGZpcm13YXJlIHRvIHJlc2V0IHRoZSBkZXZp
Y2UNCj4gDQo+ICAgLSB0aGUgZmlybXdhcmUgZGlkIHJlc2V0IHRoZSBkZXZpY2UsIHdoaWNoIGNs
ZWFyZWQgTWVtb3J5IFNwYWNlDQo+ICAgICBFbmFibGUNCj4gDQo+ICAgLSBub3RoaW5nIHJlc3Rv
cmVkIHRoZSBkZXZpY2UgY29uZmlnIGFmdGVyIHRoZSByZXNldCwgc28gTWVtb3J5DQo+ICAgICBT
cGFjZSBFbmFibGUgcmVtYWlucyBjbGVhcmVkDQo+IA0KPiAgIC0gdGhlIGRyaXZlciBkb2VzIE1N
SU8gcmVhZHMgdG8gZmlndXJlIG91dCB3aGVuIHRoZSByZXNldCBoYXMNCj4gICAgIGNvbXBsZXRl
ZA0KPiANCj4gICAtIHRoZSBkZXZpY2UgZG9lc24ndCByZXNwb25kIHRvIHRoZSBQQ0llIE1lbW9y
eSBSZWFkcyBiZWNhdXNlDQo+IE1lbW9yeQ0KPiAgICAgU3BhY2UgRW5hYmxlIGlzIGNsZWFyZWQN
Cj4gDQo+ICAgLSB0aGUgcm9vdCBjb21wbGV4IHNlZXMgYSB0aW1lb3V0IG9yIGVycm9yIGNvbXBs
ZXRpb24gYW5kDQo+IGZhYnJpY2F0ZXMNCj4gICAgIH4wIGRhdGEgZm9yIHRoZSBDUFUgcmVhZA0K
PiANCj4gICAtIHRoZSBkcml2ZXIgc2VlcyB+MCBkYXRhIGZyb20gdGhlIE1NSU8gcmVhZCBhbmQg
dGhpbmtzIHRoZSBkZXZpY2UNCj4gICAgIG9yIGZpcm13YXJlIGlzIGh1bmcNCj4gDQo+IElmIHRo
YXQncyBhbGwgdHJ1ZSwgSSB0aGluayB0aGUgcGF0Y2ggaXMgc29ydCBvZiBhIGJhbmQtYWlkIHRo
YXQNCj4gZG9lc24ndCBmaXggdGhlIHByb2JsZW0gYXQgYWxsIGJ1dCBvbmx5IG1ha2VzIHRoZSBk
cml2ZXIncyByZXNwb25zZQ0KPiB0bw0KPiBpdCBtYXJnaW5hbGx5IGJldHRlci4gIEJ1dCB0aGUg
ZGV2aWNlIGlzIHN0aWxsIHVudXNhYmxlIHVudGlsIGENCj4gcmVzY2FuDQo+IG9yIHJlYm9vdC4N
Cj4gDQo+IFNvIEkgdGhpbmsgd2Ugc2hvdWxkIGRyb3AgdGhpcyBwYXRjaCBhbmQgZG8gc29tZXRo
aW5nIHRvIHJlc3RvcmUgdGhlDQo+IGRldmljZSBzdGF0ZSBhZnRlciB0aGUgcmVzZXQuDQoNCkRv
IHlvdSBtZWFuIHdlIHNob3VsZCBkbyBzb21ldGhpbmcgYXQgdGhlIGRyaXZlciBsZXZlbCB0byBh
dXRvbWF0aWNhbGx5DQp0cnkgdG8gcmVzdG9yZSB0aGUgZGV2aWNlIHN0YXRlIGFmdGVyIHRoZSBy
ZXNldD8gSSB3YXMgdGhpbmtpbmcgaXQncyB1cA0KdG8gdGhlIHVzZXIgdG8gbWFrZSB0aGUgY2Fs
bCB0byByZXN0b3JlIHRoZSBkZXZpY2Ugc3RhdGUgb3IgdGFrZSBvdGhlcg0KYWN0aW9ucywgc28g
dGhhdCByZXR1cm5pbmcgYW4gZXJyb3IgY29kZSBmcm9tIE1SUEMgdG8gaW5kaWNhdGUgd2hhdA0K
aGFwcGVuZWQgd291bGQgYmUgZ29vZCBlbm91Z2ggZm9yIHRoZSBkcml2ZXIuIA0KDQpDYW4geW91
IHBvc3NpYmx5IHNoZWQgbGlnaHQgb24gd2hhdCBtaWdodCBiZSBhIHJlYXNvbmFibGUgd2F5IHRv
DQpyZXN0b3JlIHRoZSBkZXZpY2Ugc3RhdGUgaW4gdGhlIGRyaXZlciBpZiBhcHBsaWNhYmxlPyBJ
IHdhcyBqdXN0IGRvaW5nDQppdCBieSBsZXZlcmFnaW5nIHRoZSByZW1vdmUgYW5kIHJlc2NhbiBp
bnRlcmZhY2VzIGluIHRoZSBzeXNmcy4NCg0KPiANCj4gQmpvcm4NCg0KVGhhdCdzIGFsbCB0cnVl
LiBJIGxlYW4gdG93YXJkcyBrZWVwaW5nIHRoZSBwYXRjaCBhcyBJIHRoaW5rIG1ha2luZyB0aGUN
CnJlc3BvbnNlIGJldHRlciB1bmRlciB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbnMgbWlnaHQgbm90
IGJlIGJhZC4NCg0KICAtIFRoZSBmaXJtd2FyZSByZXNldCBjYXNlLCBhcyB3ZSBkaXNjdXNzZWQu
IEknZCB0aGluayBpdCdzIHN0aWxsDQp1c2VmdWwgZm9yIHVzZXJzIHRvIGdldCBhIGZhc3QgZXJy
b3IgcmV0dXJuIHdoaWNoIGluZGljYXRlcyBzb21ldGhpbmcNCmJhZCBoYXBwZW5lZCBhbmQgc29t
ZSBhY3Rpb25zIG5lZWQgdG8gYmUgdGFrZW4gZWl0aGVyIHRvIGFib3J0IG9yIHRyeQ0KdG8gcmVj
b3Zlci4gSW4gdGhpcyBjYXNlLCB3ZSBhcmUgYXNzdW1pbmcgdGhhdCBhIGZpcm13YXJlIHJlc2V0
IHdpbGwNCmJvb3QgdGhlIGZpcm13YXJlIHN1Y2Nlc3NmdWxseS4NCg0KICAtIFRoZSBmaXJ3bWFy
ZSBjcmFzaGVzIGFuZCBkb2Vzbid0IHJlc3BvbmQsIHdoaWNoIG5vcm1hbGx5IGlzIHRoZQ0KcmVh
c29uIGZvciB1c2VycyB0byBpc3N1ZSBhIGZpcm13YXJlIHJlc2V0IGNvbW1hbmQgdG8gdHJ5IHRv
IHJlY292ZXIgaXQNCnZpYSBlaXRoZXIgdGhlIGRyaXZlciBvciBhIHNpZGViYW5kIGludGVyZmFj
ZS4gVGhlIGZpcm13YXJlIG1heSBub3QgYmUNCmFibGUgdG8gcmVjb3ZlciBieSBhIHJlc2V0IGlu
IHNvbWUgZXh0cmVhbSBzaXR1YXRpb25zIGxpa2UgaGFyZHdhcmUNCmVycm9ycywgc28gdGhhdCBh
biBlcnJvciByZXR1cm4gaXMgcHJvYmFibHkgYWxsIHRoZSB1c2VycyBjYW4gZ2V0DQpiZWZvcmUg
YW5vdGhlciBsZXZlbCBvZiByZWNvdmVyeSBoYXBwZW5zLg0KDQpTbyBJJ2QgdGhpbmsgdGhpcyBw
YXRjaCBpcyBzdGlsbCBtYWtpbmcgdGhlIGRyaXZlciBiZXR0ZXIgaW4gc29tZSB3YXkuDQoNCktl
bHZpbg0KDQo=

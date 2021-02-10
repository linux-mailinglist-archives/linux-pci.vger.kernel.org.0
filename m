Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9F316F2E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 19:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhBJStN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 13:49:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48507 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhBJSrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 13:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612982842; x=1644518842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
  b=Tl428JEem/UR1ulPJaJ4OfSrlnH7fX+nEVBMb9on9XZqXRH3md+/kSPY
   du+4bxSZSbyGdN9y7ZwEX4Fnx7eKddAtbv0djxN0IYhQ6PofjMKyZPZrB
   Ju5V56QMIQbe8K1VMW3P+Jxe3sdbV88JmG6s7QfWB0rBS/zpSMvTiJ1dw
   xFnFutVa70tnm2WWtkLCEZKfzEhxnlGUA5X41PxX0OYcdyVGeAWR58kCV
   Enud4TqSk0eQWqPs6U/x59EX681BNN6zfS4JqWzIZufUskSBwNwAVHoOS
   YgS/9ip4U0J+vLNia84UmuSbUExYvb2mxsApur1nss079TzhdJaeXHrXm
   A==;
IronPort-SDR: VTy0UQK9ytXF+eiYwo02MZBFynCiYU0HtguTzQDW3EMC1nRkSSfitQfBcihpsy5Lc2h8msIAmT
 GZxeGqWzmHG5v9j4XlrJ8utrjMhQwqB2urtZ1uaNEiw7TN22L8CoFbJxPWbxsQqBsS19yTffVX
 WMQfqhf1Ub/ThjI2R/HG0MoAZn2TyC8JJ2bNM3GPoOco9dS71v0uIVf+ut51l5NAEB50jgz66I
 Ycj6mGcYOU0h34aGhk0EIPmyp3Uhbi9UURi4QcW6jEjaVituZUe7ix24xez+gsdz7CWSGlLPu7
 lnw=
X-IronPort-AV: E=Sophos;i="5.81,169,1610434800"; 
   d="scan'208";a="43670818"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 11:46:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 11:46:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 11:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cONziAq+VUv1n8zljF0VAkX3jt2R/GczrSd10h+EafoGsgl3h37JPEBjS1y7sKPOD4rxL+JhXN6TYwx5Qj4E08sUPMsb1rXQFcMqohUtPnATLoLuo2Ro2lxI4yVxA9Yvsw+48XGenZ6lXs1IccpP5EvDpv6I1DVoBA5xy1rbCQB1+DfxBaB3k7qkcV5pCrWVYv9z16kF/LoJ7/1CydM4l8h5bOHn1WsAy3wLYjNOj5Y5HszKoKCuZbVjHM/QzExXDZBl4aG2ONaOR5vrgGH100IRSmlRBIhFyKvSSVGQcod8of8mo/IWXyR0hOQTlOB0Ux2HWG6389JYO/Lw376XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
 b=KY6vwSCF2kpdxeMpVpGoKqac0VO//g3u/2cSveCLDu4wcAPC83Bob2G0bdvY0Gr4JA+UW9dKcIJ4cp6hMVcuR/Tk5e28GlHJZLPKJ9Yeq3kd0AZPVWZ0yweyng3y/CY/bGtqfU22UZf338JFemsCbcwafSWo1JQSeDfeDI0IxbwwsOFUr0K/e2y3+aF4UEfO9kfPz3/imeJeXn70MXa2/WqfM4IRDSbT+tDPsK5oMzKFawKTcAW+iwB9hVuWuHaaGxi/m/qmGF5dYvHaB0MzLdyxnSM++N6qKJ5JKzR08MxVdq2TE6Q5mUri6ZUK+3YvkmzMHpo8bmXu5R9poM7SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
 b=ugtD4DMnqJcP7QqU4HmtPrpw4jjeqqJRaHStYd+opN1SHOdCCXQOfMQkuRMjPMsiJmNcYsvNDaeoNU7ligO8ZYclaI0YVgKHVZkuOZBeLyGlG9IoRctdLoXillpPpeAF/2DD0V0Bf9nvFnt+xS69dl+cJoHcy8Hbsm4Ljoh4BME=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3968.namprd11.prod.outlook.com (2603:10b6:208:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 18:46:04 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:46:04 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <cbrowy@avery-design.com>, <hch@infradead.org>,
        <dan.j.williams@intel.com>, <david@redhat.com>,
        <rientjes@google.com>, <ira.weiny@intel.com>, <jcm@jonmasters.org>,
        <Jonathan.Cameron@huawei.com>, <rafael.j.wysocki@intel.com>,
        <rdunlap@infradead.org>, <vishal.l.verma@intel.com>,
        <jgroves@micron.com>, <sean.v.kelley@intel.com>,
        <Ahmad.Danesh@microchip.com>, <Varada.Dighe@microchip.com>,
        <Kirthi.Shenoy@microchip.com>, <Sanjay.Goyal@microchip.com>
Subject: RE: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Topic: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Index: AQHW/0AqZCOVul459UanKz+acVTCvapRfUwQgAAdewCAAAx2IIAACrSAgAAD9bA=
Date:   Wed, 10 Feb 2021 18:46:04 +0000
Message-ID: <MN2PR11MB364513777E713224B3BB7D74888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
 <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210164904.lfhtfvlyeypfpjhe@intel.com>
 <MN2PR11MB36450EFC1729D9A4CDB2FB27888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210181159.opwjsjovzsom7rky@intel.com>
In-Reply-To: <20210210181159.opwjsjovzsom7rky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [142.134.145.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efcc3bec-aa47-4507-6402-08d8cdf41ec2
x-ms-traffictypediagnostic: MN2PR11MB3968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB396835F90A48449061CBD858888D9@MN2PR11MB3968.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBlewjiUkBa9A2GES5n59KAEsrUyGYx7WdL49WReJyHNqqWT2Gb2H1hFA5KFtOKeL3hzCUmy+34lbcSkEIFGDmnTBzKnwDkHVlfe0/PsFzHuPyryz6NBCvLePuoZ3BtEEiY2Yv3805g66MZM6wd31iroDBE++IBHTiRf3w/Unbx7nYSBbuZbT/CpwYSGzMK2dUSb4CV5vGJZuY0VWpdoj2RM2YXisfCM18vVTbZZiilGg7nScdGqZJKojxHsH0hDRUxJZK8xaPfsR7a11SBHb8D2uz0osVzQErqWCJ/lT03rRcsVFsosAPRNHdMrAaI9rXn3xmZqV9odCowlS3y72NINOFheEOt39DaAwwZxMEdToruu8gq91JSTIhlwrk6wzydUp/KyY/1Gv2LQMUuA2R7Fecr5Zu8H5EyxZQLBO+dIAEhgDgmpHgUmA7CGUriTkr+eCP1Dypb7f2juLQ1m+vs0lsQEqHfKR6KWA2hZpV4O6B9En4ulTOMof/jDOy8hZY0tmlfCET2Z7McymudpIBMrvXBgM44IhRtmk6Y4bLWw+vup41sZq5ierWWKsXfC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(6506007)(7696005)(478600001)(54906003)(6916009)(186003)(26005)(4326008)(316002)(71200400001)(8676002)(107886003)(5660300002)(9686003)(7416002)(64756008)(66476007)(66556008)(66446008)(55016002)(52536014)(76116006)(66946007)(2906002)(86362001)(83380400001)(33656002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0plc1lMY3BpcW9SRFgxU3VVS0ZXZmNWd2hDMmd3NlNMb1hOK0V5aVUxNHpj?=
 =?utf-8?B?aDdxcTZibExnTTlDVklpY0JFZ0J5enVZYjR4d25VeDZsbjZNd1JlUjRaRE02?=
 =?utf-8?B?WnBqNVlIQ2c3L0pEQnllRWhjcU43YkRESTZMdW5DQnZ6TGhwTFE0VjhxSVhT?=
 =?utf-8?B?dk1ONUtsRVZmZkNIM0JFODlCTjZjVmJzbW5YeXNJL0ZqZi9KWkdjejUzbGdS?=
 =?utf-8?B?b0Zvdk9LUWowRDB6Z1JaeVR2Z3M3S0EzVkd4cjBaRGY5VDQ0T20zSUpFcDV4?=
 =?utf-8?B?SGFmaG9DLzNLNGJlQ29YSHVjbkduT3BTL21Gc3JlYjBTbWxoZDJlamdtNTln?=
 =?utf-8?B?MUJEd1AvdEhDY0Z5VUx6UGlPTjEzQXdlaFdYNEdmQjdIQ2Q5RmR0eEdTN3E0?=
 =?utf-8?B?SHEvV0lTTU9UMDRHNDlwWmdkVkEwV3VMMVg2QU5ud3NpNmJWN3JZWDFSeHpk?=
 =?utf-8?B?Q1RPWTc3cG0vRE5iLytMdUxjWGJ1Z0RNaWVFb3JlRG5sWkJhdWRQMUpmdTVR?=
 =?utf-8?B?NWdJTHRhTGQ4dmhBMUtCTjJRT09tVFpoaUNqNGVUc01XeUY2MGVRTlRyMGZK?=
 =?utf-8?B?eW5IdWVFR2FlY0ZJTkU5UHorbzl1dmQvMjI0SlIrKzFXYm1tR0FUK21CRkpl?=
 =?utf-8?B?N0FiVlAyTHpKZTI0d3QwcVZCN1h0eXhienl1blhUb2VWdDFaeEsrNndBUVoz?=
 =?utf-8?B?Y0FXd29rZE80VFo0aGRRNWlqd2IzZFIwRTREeCtHMkdWWmtWR3JtbzUvdWl4?=
 =?utf-8?B?Qk00bENIeWJYSXN6VXRWOEZ0NTRMWXJpQ0loYjhtZkZ6ek1FY0hvanBoaXl3?=
 =?utf-8?B?dW8wZSt4Y2g1YzFHUEVtRFprZVZpS1czRHNIeWIzM0ZCWFhDUWZ4TDhUQzl2?=
 =?utf-8?B?cWwzSUhNN3V5OFp0Y1g3WmRUVTlrVUdSSHlUN2hTME5lUDdZMnpVRW4zVFJN?=
 =?utf-8?B?VnFJSS93OENFK044T3hlZXJJYVE4U2wydEFoUWczTXZndGwxWm9Sd1lNd0ZZ?=
 =?utf-8?B?ODlyMDY3aXRvYkVhTHVsUGtrUXJiOW54a1hmRXordXBCQUQ1Y1EzUUYveUpL?=
 =?utf-8?B?OGpSa0ttbHJWYWRDTEUxOVFpZEkxS0N0c1BwM1RrZzM0cVFkYnVZMHQ2ZXor?=
 =?utf-8?B?d3hKRkV4WGpKYkg4Z0ZRS1E0T2dMQm5Ga3gzV2UrNUpMY0Q4enU3cE5WVWdN?=
 =?utf-8?B?VTZWdUdaMTh5V0VOekxtMkI5UWZ2NlRQR1dEMlpmUUhrUm50UTAyaG5vZ0tM?=
 =?utf-8?B?SmNoM2VneXUyR0pXWnEzTzg3cjl0d3YrNm11OE14Q0xVVXA5ZjVDTUxrZzdQ?=
 =?utf-8?B?T2g4Ky9NRXphczVKNnNpejVoUWNNQXF0NjJyM3A1WE9FdlhBUGc2NmdVWDEv?=
 =?utf-8?B?aUdRTVJTOWZHM2VrU0ZUR2JGb3NadXBvcVlVQlR4S3cwdDdBQU5YcmdCc3pD?=
 =?utf-8?B?LzBFYTdUMmxZVUVJaitVTmlTb1lnWlFTYytOSEJaajRMUGhUdFZnQWVvRzJs?=
 =?utf-8?B?VitZWEF6NVAvSHVpeldWLzBtVm0vZnNCTENtRGxzVmx5NGhjRVBCR0cwWFdU?=
 =?utf-8?B?UnhiaGxsUVZtSDJDUjNKUjkvRU1GUFRhSGRuRm0zUWU0Q2Q4TDZkZFg0WnRk?=
 =?utf-8?B?Y3g2ZVV2UFJtRTVHNE5kRFVUUzV6S09mV1diOEUzOGU1VkdSclNtNFkrMTl6?=
 =?utf-8?B?WEhhUVRuYjRYRHBVczRmUFlpU0xxUEpyR3RiNlRYVEpaM2Y0V3VwOGhESXQr?=
 =?utf-8?Q?RVII1Oty9MYgU+LmvrrdxrEmb4YH2Xy71JEBEBO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcc3bec-aa47-4507-6402-08d8cdf41ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:46:04.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuY4O9nYodlhY2jIco6YQd1srUxmMkZXvz11zb7LG+0wbTX7aRRHZVA1Nov+GJur2g5+FddpHPWne67/0+7UzeHQnncGXyHUeDg6x/aKi6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3968
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9LY29uZmlnIGIvZHJpdmVycy9jeGwv
S2NvbmZpZw0KPiA+ID4gPiA+IGluZGV4IGM0YmEzYWEwYTA1ZC4uMDhlYWE4ZTUyMDgzIDEwMDY0
NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY3hsL0tjb25maWcNCj4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL2N4bC9LY29uZmlnDQo+ID4gPiA+ID4gQEAgLTMzLDYgKzMzLDI0IEBAIGNvbmZpZyBD
WExfTUVNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAgICAgSWYgdW5zdXJlIHNheSAnbScu
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArY29uZmlnIENYTF9NRU1fUkFXX0NPTU1BTkRTDQo+ID4g
PiA+ID4gKyAgICAgICBib29sICJSQVcgQ29tbWFuZCBJbnRlcmZhY2UgZm9yIE1lbW9yeSBEZXZp
Y2VzIg0KPiA+ID4gPiA+ICsgICAgICAgZGVwZW5kcyBvbiBDWExfTUVNDQo+ID4gPiA+ID4gKyAg
ICAgICBoZWxwDQo+ID4gPiA+ID4gKyAgICAgICAgIEVuYWJsZSBDWEwgUkFXIGNvbW1hbmQgaW50
ZXJmYWNlLg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgVGhlIENYTCBkcml2ZXIg
aW9jdGwgaW50ZXJmYWNlIG1heSBhc3NpZ24gYSBrZXJuZWwgaW9jdGwgY29tbWFuZA0KPiA+ID4g
PiA+ICsgICAgICAgICBudW1iZXIgZm9yIGVhY2ggc3BlY2lmaWNhdGlvbiBkZWZpbmVkIG9wY29k
ZS4gQXQgYW55IGdpdmVuIHBvaW50IGluDQo+ID4gPiA+ID4gKyAgICAgICAgIHRpbWUgdGhlIG51
bWJlciBvZiBvcGNvZGVzIHRoYXQgdGhlIHNwZWNpZmljYXRpb24gZGVmaW5lcyBhbmQgYSBkZXZp
Y2UNCj4gPiA+ID4gPiArICAgICAgICAgbWF5IGltcGxlbWVudCBtYXkgZXhjZWVkIHRoZSBrZXJu
ZWwncyBzZXQgb2YgYXNzb2NpYXRlZCBpb2N0bCBmdW5jdGlvbg0KPiA+ID4gPiA+ICsgICAgICAg
ICBudW1iZXJzLiBUaGUgbWlzbWF0Y2ggaXMgZWl0aGVyIGJ5IG9taXNzaW9uLCBzcGVjaWZpY2F0
aW9uIGlzIHRvbyBuZXcsDQo+ID4gPiA+ID4gKyAgICAgICAgIG9yIGJ5IGRlc2lnbi4gV2hlbiBw
cm90b3R5cGluZyBuZXcgaGFyZHdhcmUsIG9yIGRldmVsb3BpbmcgLw0KPiA+ID4gPiA+IGRlYnVn
Z2luZw0KPiA+ID4gPiA+ICsgICAgICAgICB0aGUgZHJpdmVyIGl0IGlzIHVzZWZ1bCB0byBiZSBh
YmxlIHRvIHN1Ym1pdCBhbnkgcG9zc2libGUgY29tbWFuZCB0bw0KPiA+ID4gPiA+ICsgICAgICAg
ICB0aGUgaGFyZHdhcmUsIGV2ZW4gY29tbWFuZHMgdGhhdCBtYXkgY3Jhc2ggdGhlIGtlcm5lbCBk
dWUgdG8gdGhlaXINCj4gPiA+ID4gPiArICAgICAgICAgcG90ZW50aWFsIGltcGFjdCB0byBtZW1v
cnkgY3VycmVudGx5IGluIHVzZSBieSB0aGUga2VybmVsLg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArICAgICAgICAgSWYgZGV2ZWxvcGluZyBDWEwgaGFyZHdhcmUgb3IgdGhlIGRyaXZlciBzYXkg
WSwgb3RoZXJ3aXNlIHNheSBOLg0KPiA+ID4gPg0KPiA+ID4gPiBCbG9ja2luZyBSQVcgY29tbWFu
ZHMgYnkgZGVmYXVsdCB3aWxsIHByZXZlbnQgdmVuZG9ycyBmcm9tIGRldmVsb3BpbmcgdXNlcg0K
PiA+ID4gPiBzcGFjZSB0b29scyB0aGF0IHV0aWxpemUgdmVuZG9yIHNwZWNpZmljIGNvbW1hbmRz
LiBWZW5kb3JzIG9mIENYTC5tZW0gZGV2aWNlcw0KPiA+ID4gPiBzaG91bGQgdGFrZSBvd25lcnNo
aXAgb2YgZW5zdXJpbmcgYW55IHZlbmRvciBkZWZpbmVkIGNvbW1hbmRzIHRoYXQgY291bGQgY2F1
c2UNCj4gPiA+ID4gdXNlciBkYXRhIHRvIGJlIGV4cG9zZWQgb3IgY29ycnVwdGVkIGFyZSBkaXNh
YmxlZCBhdCB0aGUgZGV2aWNlIGxldmVsIGZvcg0KPiA+ID4gPiBzaGlwcGluZyBjb25maWd1cmF0
aW9ucy4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIGJyaW5pbmcgdGhpcyB1cCBBcmllbC4gSWYg
dGhlcmUgaXMgYSByZWNvbW1lbmRhdGlvbiBvbiBob3cgdG8gY29kaWZ5DQo+ID4gPiB0aGlzLCBJ
IHdvdWxkIGNlcnRhaW5seSBsaWtlIHRvIGtub3cgYmVjYXVzZSB0aGUgZXhwbGFuYXRpb24gd2ls
bCBiZSBsb25nLg0KPiA+ID4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IFRoZSBiYWNrZ3JvdW5k
Og0KPiA+ID4NCj4gPiA+IFRoZSBlbmFibGluZy9kaXNhYmxpbmcgb2YgdGhlIEtjb25maWcgb3B0
aW9uIGlzIGRyaXZlbiBieSB0aGUgZGlzdHJpYnV0aW9uDQo+ID4gPiBhbmQvb3Igc3lzdGVtIGlu
dGVncmF0b3IuIEV2ZW4gaWYgd2UgbWFkZSB0aGUgZGVmYXVsdCAneScsIG5vdGhpbmcgc3RvcHMg
dGhlbQ0KPiA+ID4gZnJvbSBjaGFuZ2luZyB0aGF0LiBpZiB5b3UgYXJlIHVzaW5nIHRoaXMgZHJp
dmVyIGluIHByb2R1Y3Rpb24gYW5kIGluc2lzdCBvbg0KPiA+ID4gdXNpbmcgUkFXIGNvbW1hbmRz
LCB5b3UgYXJlIGZyZWUgdG8gY2FycnkgYXJvdW5kIGEgc21hbGwgcGF0Y2ggdG8gZ2V0IHJpZCBv
ZiB0aGUNCj4gPiA+IFdBUk4gKGl0IGlzIGEgb25lLWxpbmVyKS4NCj4gPiA+DQo+ID4gPiBUbyBy
ZWNhcCB3aHkgdGhpcyBpcyBpbiBwbGFjZSAtIHRoZSBkcml2ZXIgb3ducyB0aGUgc2FuY3RpdHkg
b2YgdGhlIGRldmljZSBhbmQNCj4gPiA+IHRoZXJlZm9yZSBhIFtsYXJnZV0gcGFydCBvZiB0aGUg
d2hvbGUgc3lzdGVtLiBXaGF0IHdlIGNhbiBkbyBhcyBkcml2ZXIgd3JpdGVycw0KPiA+ID4gaXMg
ZmlndXJlIG91dCB0aGUgc2V0IG9mIGNvbW1hbmRzIHRoYXQgYXJlICJzYWZlIiBhbmQgYWxsb3cg
dGhvc2UuIEFzaWRlIGZyb20NCj4gPiA+IGJlaW5nIGFibGUgdG8gdmFsaWRhdGUgdGhlbSwgd2Un
cmUgYWJsZSB0byBtZWRpYXRlIHRoZW0gd2l0aCBvdGhlciBwYXJhbGxlbA0KPiA+ID4gb3BlcmF0
aW9ucyB0aGF0IG1pZ2h0IGNvbmZsaWN0LiBXZSBnYWluIHRoZSBhYmlsaXR5IHRvIHNxdWludCBl
eHRyYSBoYXJkIGF0IGJ1Zw0KPiA+ID4gcmVwb3J0cy4gV2UgcHJvdmlkZSBhIHJlYXNvbiB0byB0
cnkgdG8gdXNlIGEgd2VsbCBkZWZpbmVkIHBhcnQgb2YgdGhlIHNwZWMuDQo+ID4gPiBSZWFsaXpp
bmcgdGhhdCBvbmx5IGFsbG93aW5nIHRoYXQgc21hbGwgc2V0IG9mIGNvbW1hbmRzIGluIGEgcmFw
aWRseSBncm93aW5nDQo+ID4gPiBlY29zeXN0ZW0gaXMgbm90IGEgd2VsY29taW5nIEFQSTsgd2Ug
ZGVjaWRlZCBvbiBSQVcuDQo+ID4gPg0KPiA+ID4gVmVuZG9yIGNvbW1hbmRzIGNhbiBiZSBvbmUg
b2YgdHdvIHR5cGVzOg0KPiA+ID4gMS4gU29tZSBmdW5jdGlvbmFsaXR5IHByb2JhYmx5IG1vc3Qg
dmVuZG9ycyB3YW50Lg0KPiA+ID4gMi4gRnVuY3Rpb25hbGl0eSB0aGF0IGlzIHJlYWxseSBzaW5n
bGUgdmVuZG9yIHNwZWNpZmljLg0KPiA+ID4NCj4gPiA+IEhvcGVmdWxseSB3ZSBjYW4gYWdyZWUg
dGhhdCB0aGUgcGF0aCBmb3IgY2FzZSAjMSBpcyB0byB3b3JrIHdpdGggdGhlIGNvbnNvcnRpdW0N
Cj4gPiA+IHRvIHN0YW5kYXJkaXplIGEgY29tbWFuZCB0aGF0IGRvZXMgd2hhdCBpcyBuZWVkZWQg
YW5kIHRoYXQgY2FuIGV2ZW50dWFsbHkgYmVjb21lDQo+ID4gPiBwYXJ0IG9mIFVBUEkuIFRoZSBz
aXR1YXRpb24gaXMgdW5mb3J0dW5hdGUsIGJ1dCB0ZW1wb3JhcnkuIElmIHlvdSB3b24ndCBiZSBh
YmxlDQo+ID4gPiB0byB1cGdyYWRlIHlvdXIga2VybmVsLCBwYXRjaCBvdXQgdGhlIFdBUk4gYXMg
YWJvdmUuDQo+ID4gPg0KPiA+ID4gVGhlIHNlY29uZCBzaXR1YXRpb24gaXMgaW50ZXJlc3Rpbmcg
YW5kIGRvZXMgbmVlZCBzb21lIG1vcmUgdGhvdWdodCBhbmQNCj4gPiA+IGRpc2N1c3Npb24uDQo+
ID4gPg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gSSBzZWUgMyByZWFsaXN0aWMgb3B0aW9ucyBm
b3IgdHJ1bHkgdmVuZG9yIHNwZWNpZmljIGNvbW1hbmRzLg0KPiA+ID4gMS4gVG91Z2ggbm9vZ2ll
cy4gVmVuZG9ycyBhcmVuJ3Qgc3BlY2lhbCBhbmQgdGhleSBzaG91bGRuJ3QgZG8gdGhhdC4NCj4g
PiA+IDIuIG1vZHBhcmFtIHRvIGRpc2FibGUgdGhlIFdBUk4gZm9yIHNwZWNpZmljIGRldmljZXMg
KGxldCB0aGUgc3lzYWRtaW4gZGVjaWRlKQ0KPiA+ID4gMy4gVHJ5IHRvIG1ha2UgdGhlbSBwYXJ0
IG9mIFVBUEkuDQo+ID4gPg0KPiA+ID4gVGhlIHJpZ2h0IGFuc3dlciB0byBtZSBpcyAjMSwgYnV0
IEkgYWxzbyByZWFsaXplIEkgbGl2ZSBpbiB0aGUgcmVhbCB3b3JsZC4NCj4gPiA+DQo+ID4gPiAj
MiBwcm92aWRlcyB0b28gbXVjaCBmbGV4aWJpbGl0eS4gVmVuZG9ycyB3aWxsIGp1c3QgZG8gd2hh
dCB0aGV5IHBsZWFzZSBhbmQNCj4gPiA+IGRpc3Ryb3MgYW5kL29yIGludGVncmF0b3JzIHdpbGwg
YmUgc2VlbiBhcyBob3N0aWxlIGlmIHRoZXkgZG9uJ3QgYWNjb21tb2RhdGUuDQo+ID4gPg0KPiA+
ID4gSSBsaWtlICMzLCBidXQgSSBoYXZlIGEgZmVlbGluZyBub3QgZXZlcnlvbmUgd2lsbCBhZ3Jl
ZS4gTXkgcHJvcG9zYWwgZm9yIHZlbmRvcg0KPiA+ID4gc3BlY2lmaWMgY29tbWFuZHMgaXMsIGlm
IGl0J3MgY2xlYXIgaXQncyB0cnVseSBhIHVuaXF1ZSBjb21tYW5kLCBhbGxvdyBhZGRpbmcgaXQN
Cj4gPiA+IGFzIHBhcnQgb2YgVUFQSSAobW92aW5nIGl0IG91dCBvZiBSQVcpLiBJIGV4cGVjdCBs
aWtlIDUgb2YgdGhlc2UsIGV2ZXIuIElmIHdlDQo+ID4gPiBzdGFydCBnZXR0aW5nIG11bHRpcGxl
IHBlciB2ZW5kb3IsIHdlJ3ZlIGZhaWxlZC4gVGhlIGluZnJhc3RydWN0dXJlIGlzIGFscmVhZHkN
Cj4gPiA+IGluIHBsYWNlIHRvIGFsbG93IGRvaW5nIHRoaXMgcHJldHR5IGVhc2lseS4gSSB0aGlu
ayB3ZSdkIGhhdmUgdG8gZHJhdyB1cCBzb21lDQo+ID4gPiBndWlkZWxpbmVzIChsaWtlIGFkZGlu
ZyB0ZXN0IGNhc2VzIGZvciB0aGUgY29tbWFuZCkgdG8gYWxsb3cgdGhlc2UgdG8gY29tZSBpbi4N
Cj4gPiA+IEFueXRoaW5nIHdpdGggY29tbWFuZCBlZmZlY3RzIGlzIGdvaW5nIHRvIG5lZWQgZXh0
cmEgc2NydXRpbnkuDQo+ID4NCj4gPiBUaGlzIHdvdWxkIG5lY2Vzc2l0YXRlIGFkZGluZyBzcGVj
aWZpYyBvcGNvZGUgdmFsdWVzIGluIHRoZSByYW5nZSBDMDAwaC1GRkZGaA0KPiA+IHRvIFVBUEks
IGFuZCB0aG9zZSB3b3VsZCB0aGVuIGJlIGFsbG93ZWQgZm9yIGFsbCBDWEwubWVtIGRldmljZXMs
IGNvcnJlY3Q/ICBJZg0KPiA+IHNvLCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIHRoZSByaWdodCBh
cHByb2FjaCwgYXMgb3Bjb2RlcyBpbiB0aGlzIHJhbmdlIGFyZSBieQ0KPiA+IGRlZmluaXRpb24g
dmVuZG9yIGRlZmluZWQuICBBIGdpdmVuIG9wY29kZSB2YWx1ZSB3aWxsIGhhdmUgdG90YWxseSBk
aWZmZXJlbnQNCj4gPiBlZmZlY3RzIGRlcGVuZGluZyBvbiB0aGUgdmVuZG9yLg0KPiANCj4gUGVy
aGFwcyBJIGRpZG4ndCBleHBsYWluIHdlbGwgZW5vdWdoLiBUaGUgVUFQSSB3b3VsZCBkZWZpbmUg
dGhlIGNvbW1hbmQgSUQgdG8NCj4gb3Bjb2RlIG1hcHBpbmcsIGZvciBleGFtcGxlIDB4QzAwMC4g
VGhlcmUgd291bGQgYmUgYSB2YWxpZGF0aW9uIHN0ZXAgaW4gdGhlDQo+IGRyaXZlciB3aGVyZSBp
dCBkZXRlcm1pbmVzIGlmIGl0J3MgYWN0dWFsbHkgdGhlIGNvcnJlY3QgaGFyZHdhcmUgdG8gZXhl
Y3V0ZSBvbi4NCj4gU28gaXQgd291bGQgYmUgZW50aXJlbHkgcG9zc2libGUgdG8gaGF2ZSBtdWx0
aXBsZSB2ZW5kb3IgY29tbWFuZHMgd2l0aCB0aGUgc2FtZQ0KPiBvcGNvZGUuDQo+IA0KPiBTbyBV
QVBJIG1pZ2h0IGJlIHRoaXM6DQo+ICAgICAgICAgX19fQyhHRVRfSEVBTFRIX0lORk8sICJHZXQg
SGVhbHRoIEluZm8iKSwgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgIF9fX0Mo
R0VUX0xPRywgIkdldCBMb2ciKSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gICAgICAgICBfX19DKFZFTkRPUl9GT09fWFhYLCAiRk9PIiksICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgX19fQyhWRU5ET1JfQkFSX1hY
WCwgIkJBUiIpLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiANCj4g
VXNlciBzcGFjZSBqdXN0IHBpY2tzIHRoZSBjb21tYW5kIHRoZXkgd2FudCwgRk9PL0JBUi4gSWYg
dGhleSB1c2UgVkVORE9SX0JBUl9YWFgNCj4gb24gVkVORE9SX0ZPTydzIGhhcmR3YXJlLCB0aGV5
IHdpbGwgZ2V0IGFuIGVycm9yIHJldHVybiB2YWx1ZS4NCg0KV291bGQgdGhlIGRyaXZlciBiZSBk
b2luZyB0aGlzIGVuZm9yY2VtZW50IG9mIHZlbmRvciBJRCAvIG9wY29kZSBjb21wYXRpYmlsaXR5
LCBvciB3b3VsZCB0aGUgZXJyb3IgcmV0dXJuIHZhbHVlIG1lbnRpb25lZCBoZXJlIGJlIGZyb20g
dGhlIGRldmljZT8gIE15IGNvbmNlcm4gaXMgd2hlcmUgdGhlIHNhbWUgb3Bjb2RlIGhhcyB0d28g
bWVhbmluZ3MgZm9yIGRpZmZlcmVudCB2ZW5kb3JzLiAgRm9yIGV4YW1wbGUsIGZvciBWZW5kb3Ig
QSBvcGNvZGUgMHhDMDAwIG1pZ2h0IHJlcG9ydCBzb21lIGZvcm0gb2Ygc3RhdHVzIGluZm9ybWF0
aW9uLCBidXQgZm9yIFZlbmRvciBCIGl0IG1pZ2h0IGhhdmUgZGF0YSBzaWRlIGVmZmVjdHMuICBU
aGVyZSBtYXkgbm90IGhhdmUgYmVlbiBhbnkgVUFQSSBpbnRlbnRpb24gdG8gZXhwb3NlIDB4QzAw
MCBmb3IgVmVuZG9yIEIgZGV2aWNlcywgYnV0IHRoZSBleGlzdGVuY2Ugb2YgMHhDMDAwIGluIFVB
UEkgZm9yIFZlbmRvciBBIHJlc3VsdHMgaW4gdGhlIGRhdGEgY29ycnVwdGluZyB2ZXJzaW9uIG9m
IDB4QzAwMCBmb3IgVmVuZG9yIEIgYmVpbmcgYWxsb3dlZC4gIEl0IHdvdWxkIHNlZW0gdG8gbWUg
dGhhdCBldmVuIGlmIHRoZSBjb21tYW5kcyBhcmUgaW4gVUFQSSwgdGhlIGRyaXZlciB3b3VsZCBz
dGlsbCBuZWVkIHRvIHJlbHkgb24gdGhlIGNvbnRlbnRzIG9mIHRoZSBDRUwgdG8gZGV0ZXJtaW5l
IGlmIHRoZSBjb21tYW5kIHNob3VsZCBiZSBhbGxvd2VkLg0KIA0KPiA+IEkgdGhpbmsgeW91IG1h
eSBiZSBvbiB0byBzb21ldGhpbmcgd2l0aCB0aGUgY29tbWFuZCBlZmZlY3RzLiAgQnV0IHJhdGhl
ciB0aGFuDQo+ID4gImV4dHJhIHNjcnV0aW55IiBmb3Igb3Bjb2RlcyB0aGF0IGhhdmUgY29tbWFu
ZCBlZmZlY3RzLCB3b3VsZCBpdCBtYWtlIHNlbnNlIHRvDQo+ID4gYWxsb3cgdmVuZG9yIGRlZmlu
ZWQgb3Bjb2RlcyB0aGF0IGhhdmUgQml0WzU6MF0gaW4gdGhlIENvbW1hbmQgRWZmZWN0IGZpZWxk
IG9mDQo+ID4gdGhlIENFTCBFbnRyeSBTdHJ1Y3R1cmUgKFRhYmxlIDE3Mykgc2V0IHRvIDA/ICBJ
biBjb25qdW5jdGlvbiwgdGhvc2UgYml0cw0KPiA+IHJlcHJlc2VudCBhbnkgY2hhbmdlIHRvIHRo
ZSBjb25maWd1cmF0aW9uIG9yIGRhdGEgd2l0aGluIHRoZSBkZXZpY2UuICBGb3INCj4gPiBjb21t
YW5kcyB0aGF0IGhhdmUgbm8gc3VjaCBlZmZlY3RzLCBpcyB0aGVyZSBoYXJtIHRvIGFsbG93aW5n
IHRoZW0/ICBPZg0KPiA+IGNvdXJzZSwgdGhpcyBhcHByb2FjaCByZWxpZXMgb24gdGhlIHZlbmRv
ciB0byBub3QgbWlzcmVwcmVzZW50IHRoZSBjb21tYW5kDQo+ID4gZWZmZWN0cy4NCj4gPg0KPiAN
Cj4gVGhhdCBsYXN0IHNlbnRlbmNlIGlzIHdoYXQgd29ycmllcyBtZSA6LSkNCg0KT25lIG11c3Qg
YWxzbyByZWx5IG9uIHRoZSB2ZW5kb3IgdG8gbm90IHNpbXBseSBjb3JydXB0IGRhdGEgYXQgcmFu
ZG9tLiA6KSBJTU8gdGhlIGNvbnRlbnRzIG9mIHRoZSBDRUwgc2hvdWxkIGJlIGJlbGlldmVkIGJ5
IHRoZSBkcml2ZXIsIHJhdGhlciB0aGFuIHRoZSBkcml2ZXIgdHJlYXRpbmcgdGhlIGRldmljZSBh
cyBhIGhvc3RpbGUgYWN0b3IuDQoNCj4gDQo+IA0KPiA+ID4NCj4gPiA+IEluIG15IG9waW5pb24s
IGFzIG1haW50YWluZXJzIG9mIHRoZSBkcml2ZXIsIHdlIGRvIG93ZSB0aGUgY29tbXVuaXR5IGFu
IGFuc3dlcg0KPiA+ID4gYXMgdG8gb3VyIGRpcmVjdGlvbiBmb3IgdGhpcy4gRGFuLCB3aGF0IGlz
IHlvdXIgdGhvdWdodD8NCg==

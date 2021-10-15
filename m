Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C103042FDF0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhJOWPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 18:15:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33033 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhJOWPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 18:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634336023; x=1665872023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8+OQPIBnkjSH6zdtm/MjoRlVOu74jdexu0yxkS9leFA=;
  b=kzuREYMcSWNC+HbEjlFGFjwro+aS0SaJ/2V/e85Ou0hU81Id3hbcwMQ4
   pQP2letFx/l3jQ5+ULgFfzG7hfUsWi2jN4h5PPu2oRfaOu62l9uL59oAA
   68SRZLPg8XtAReb/mYCSON24zq3vDW3Z275IjlMr2UxSNtS2q2dMvOKz6
   m2Ndyqv8LQUVJhMMIm9RuFrAwGid+ZfKkd1ALd2MJtTWYnOhnxTk8Rxvl
   4y9+zLX70N8mStgKgfnTPGgqXpCNgIKlngKeZRp7hXtBHrXRnIgtNsyea
   UwrvxlV1+oyyAONyeIYV08i7nGB+Xn28h1dGDpkxAOykOmvZ9LXbVxwdu
   w==;
IronPort-SDR: MdTdej7fmeMAwpA7odJ5xfYpa3mXcVzWwy2Pu17YTajv+sAJAO/IBoJJhYYirPYN1tVRUQcofB
 6UKeQiHhWPWW8CM4f89igvOxIrcxPMsht/gtLfwYqvt1gKN7MzbuzaHxLvbTbwWOffrV8vM6rS
 rNOe4LlxAgXobH0qZHx8uxUrPjSIHtB8Rg4Nq8YaObvQ3E9kgqWrRUekntv28RSiMXGiRzrc4l
 qnboAHfayZuOTxb6AkHH4VUIyoq0cB+otyPiCJUM496C60meuE8IjlbCxwFYNnEi7JBBdi6Np8
 DzX8ggj9K28PlNbN9C8GhjF5
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="73139820"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 15:13:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 15:13:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 15:13:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDqk3QIKpnOnzaqz5k1sK7d+qPiMXQq7Gpf6ZH8i4d/caTOqdJZmDHEeEuD6jMCYQa0Imb1UHazAa076K6cDKK4KFsvlItd9wEoxhDorLveJLn6GbfO1vA610b/JFVaJyJ2lifJTNQDaXmNECkhPdeWKXo/eGyx7N2l4Dz4TWdEeRZiLr6SHFt8SydmFwv9INOvNQOEKH+2/AMK/073LcA6bdJtG0X+vFSoZEJVt6/LnvdqHvgCxV5xT3fJdBhHIhxd8bl+6tiiy7qvcmgVFJ1aaxx00eckLlU46hGPO7WzQwARHrZ806IIbRCI8cPN4Eqgm4avkucfgxr1tusYylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+OQPIBnkjSH6zdtm/MjoRlVOu74jdexu0yxkS9leFA=;
 b=HFaf9AHZ1P8vRcmtk4yxW1ePjLpfWCVpieDCtn2SH0Dl67J+DbP+hKtWA1X2UCS4qZhd/ycWC76CORWh8zhytOF5JolASQAUzIUZenZPeG1JAcfo6ujTXvnKEE3ToyysihAFq6NYzcVCNkh1CR/GDgGX/aC2wa7HPcoh69CxMIiL/LKrHpnbwYDQp3kplduFnN/3jKU7KXuYPCxu5NVxHwZxDO5Kqz2Jl19+LfoKZNM0UIsYae2KdTT6vwPp5TktxXKkEFcdhCeZYfPVAVon72gSoQnheWPdIQQ015vDbF8exgatEO3jhxQa96Z2bwxan6KaAAvmu3FgwZdVOK4CgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+OQPIBnkjSH6zdtm/MjoRlVOu74jdexu0yxkS9leFA=;
 b=ZcvhbnS0AVtqUvSuBLF5H413xUnBXsvNtQe1NwEOBTb/AOfcKqxiTFPmICSUi3uQ2FhOXx3/wiPTTX16555QFdiPjO8vQQEey2+mI8ZIu9KO6uYxKjRe7nR5nSO4aYP1fMEEByz80gB+oAvkG8pvYgqnC/57h4P6k0cisJo3HU0=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5666.namprd11.prod.outlook.com (2603:10b6:303:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:13:37 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 22:13:36 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <kw@linux.com>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] PCI/switchtec: Error out MRPC execution when MMIO
 reads fail
Thread-Topic: [PATCH v2 1/5] PCI/switchtec: Error out MRPC execution when MMIO
 reads fail
Thread-Index: AQHXwMzJuJig5BOPXUmFlBcz6/0STavTRHGAgAFddwA=
Date:   Fri, 15 Oct 2021 22:13:36 +0000
Message-ID: <5b554388b1e46a0d2f3f7082a4d4defe55707712.camel@microchip.com>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
         <20211014141859.11444-2-kelvin.cao@microchip.com>
         <YWjXq/NL6zex4oeR@rocinante>
In-Reply-To: <YWjXq/NL6zex4oeR@rocinante>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736ebb84-c99d-4f44-dac5-08d990290904
x-ms-traffictypediagnostic: CO6PR11MB5666:
x-microsoft-antispam-prvs: <CO6PR11MB5666DD33CF52E9CEC895F2F98DB99@CO6PR11MB5666.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Lx0RA/dGAc9QSxvgBDDtC2pYEGMla+xRleuA4HFLoNqb/CnF4hBTcbjEutPCfPJMoLosk0LpDTOWQI80AGH2JcuUUrW5F4y9mztOVZE4oThVe7sXbYgRESZh5edVxSrJkVFlC+OoN3klVb7lZ3jD9SdbcwlVgqQIfwPsIySuctgAcE7oYZsBA4pQ5GKgGYRDYt8nDmrqKN4FXCqLarZltt4kxV2hpKvcZUFfBdzHRO9SaLTa71W1Q+xEmjTqYk3XmlVDvTYqqaY1K5locPZwxWCvQ7xQD5gXslkXHHKbrYnKW+ou24hiKDRg5JxrMZUremcLNuyiibrSNC0ezH9AfWQOjTomAWR8vXCxm1fRGxhngwytW+xln68s32sTEkXwgPfEgkc/J8+lyLsFdQDK4uDjjAAzwq+Cdc7DyLpR2vmjKT7HkPBDqKz9OJQNNjPNJRlxd6UqfW4o9Jk2cKLGBWkcWgOL1P8o62nuoS4OoGr+zaGvMjLwb4JWGCpFRQgnlj0FKF4Gza+YfFfKq6C7F2tww/d2WN2an3W4T3WT5uMjuIQZyEdWGrblY+qIak0GFedm+KCffgC0KV/lUPJScAQCKT5cCWZeYi8ji3J5+ZXyIBd/w4I5Pn2/NVJEkCmulIchC0mgXT2XSoyE169ZR8O+p3IksPRZDq7WmqOUkczhSSSlGVgGX4QVqHYjM27z6ijKTAMLZf7nljyTJk/rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(122000001)(6486002)(38100700002)(316002)(508600001)(38070700005)(66556008)(86362001)(186003)(4001150100001)(64756008)(66446008)(66476007)(5660300002)(36756003)(83380400001)(26005)(76116006)(54906003)(2906002)(8936002)(8676002)(4326008)(6512007)(71200400001)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9TN1NKekVhYjNYbmhoNmxXd2hIemVOM1NBT1I2SThScTUrSHVxZW4rNnFT?=
 =?utf-8?B?dmh0NWVsRXFtc2h5eEg5b3RlRVoxRk9ZeEVXY0tZUkNQelJhV3ZBWlIvK1g3?=
 =?utf-8?B?WE1LSmlpUjRvSHZoalk1NzVYRmM4WEJlV3YrMTRySDNXUXdyZlJqQkw2T2pT?=
 =?utf-8?B?TFlqT1FSZWNXckVkUGR6SHFoSzdVeDNRQzcrY0EyanFEd2xFejlvbk05cStN?=
 =?utf-8?B?eVBpVm03cG1oU3NWWTcvbXRDOTkwSkphT0dzaURzaiswWDE3L1MxTjZ2d1JG?=
 =?utf-8?B?b2gyWmplUVhvajIzQklPL0w4NEFuT1pRMHFFL2VGcHpndFMwY01sNldOOHQ1?=
 =?utf-8?B?dVRTS2ZSUENEeExoYkdJcXlDQlFTTExDMlNWajZ1T24va1dVQ1hBbnJweklO?=
 =?utf-8?B?RzNHRkJGQmJOT2VKTzN6TXdMVjVmL1Z1SVgyS3ptclM0MTdSVXM1bHBNN004?=
 =?utf-8?B?b2UyUkhycWw3U092aXF2dENJTm9XU1pvOUtCWTJrVzRPTlk2K2diV3NKeHUx?=
 =?utf-8?B?ZHpKOHpCdEdma2xuc2dBamFDd0ZXWjF4TGxjSEFUekVLdjNLMjUyUWU0WGR0?=
 =?utf-8?B?VU5oN3Jtdy9VZHNFeW0vYXZmbktGcnUvNTdCbmdMQTZkU2NnUkxhUnMxekJV?=
 =?utf-8?B?ZDZTUjh4dXpEd3dzdklvZjlqSDN6S1ZFeHJLdVNId25pcHYvdTUvNFl3cFlE?=
 =?utf-8?B?UjIrM0x1UzVYU2xYc1lJVnBoNzRmSzgza1UwaGZtbnRBWGI1ZVd6dkFuVm1k?=
 =?utf-8?B?bFQ3UXEwQUUwZjAzQmlQZGJWQVhpR1BQVnlWTmR4bElheHZNcTcxUjRYQlJF?=
 =?utf-8?B?Qmg5cmRYVHRRaC81ZGVmdmlBeXhlSUJCbUdHWHN6NDk3Vzl0anR5SWE1Slpl?=
 =?utf-8?B?cGhqVEJFTFpUeG9NZUxSdG85djdlNW95Mk9IT2ZxT1ZMajg1UXlueTJPeU04?=
 =?utf-8?B?OEZYMmlYZ1R6NXBRbXVLRXA3cmtYam9TT3A0ek5WeFlhZTY1Qk9NWlg1cmFR?=
 =?utf-8?B?dk56cDhGUWE0NTh2dFBOVW9OLyt5MkRJQ3owL3p4djNCeWVRVlNzbkExTUN0?=
 =?utf-8?B?Vldvbmg1RmdWWjlwZVRkQy9wdHE3Z2VjQnY1cmNPRllrNENYbDFRM2FxalpT?=
 =?utf-8?B?NzQyTC8vTFpIUUVYOGVkbXJiNkJMb3FCUnl6TTlaUmRidDVDazROOGpFS3d4?=
 =?utf-8?B?WndXcFlGT1RDN2dEaTl3MUt3VEFqRm1aWG5SOWFFckJpMXM0RWc3eTcwVWxR?=
 =?utf-8?B?ZmFsNXg0Y1lBc0d4Yzg5UVRoaFZIbTRXZFIweEV4SEhicExUNmNBa1lxd2RD?=
 =?utf-8?B?b3VYSG9yVFJOOVdiWjNTOTlnQ2hxVGNrUVNzRjdJTGRQRlNRTDlaMWIwQWZl?=
 =?utf-8?B?TDFaZGNDNFBWcnBXZFNlMGYxOFZtV0EvMFVzZkQ5SFk3Uk9nRzJRWDlScVVT?=
 =?utf-8?B?dTNoNElXQU4reGxKMTFrSmNsRkhuaTE4RUZHMERhZ21jZklicHcyUFJVUnA3?=
 =?utf-8?B?WDdzZkdOMlM5UGZEQmxVOFJvRnpaa2p6TDg3V1B0cjUvYkVNd3pQZXdVSlE0?=
 =?utf-8?B?Q0pZVnV1eitlTElnZDVVcy9oQzc4QUQ0bGpuelZzTm92SGdiZWJScFVocW5l?=
 =?utf-8?B?TjcwMGFLRksyZDdJUHZnUi9XNDZ0ZUFHaDhOeGZVUGQ1TlhvOGFxam44Wjh3?=
 =?utf-8?B?ckFHYkk3NGJ3MmVOcW5DOHhXc2FLMHJXcHVRL05CcEZJN0IrWms3U3pIekx3?=
 =?utf-8?Q?c0R6w5jNgttQM6zizjfSojjYTAKDaJlc036xPeU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <74413693FCE5F34C93140E3F99F27091@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736ebb84-c99d-4f44-dac5-08d990290904
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 22:13:36.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFWA30AwEvg/xxoz8P4jdxZbdIAtZ9fIm4wN+gLpwq1k40fayKHVxCOXeLyRHlH/SYyczaeqaNIxmoZvq6gn0Yv5zIxLiEakwGqeUF3WkMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5666
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTE1IGF0IDAzOjIxICswMjAwLCBLcnp5c3p0b2YgV2lsY3p5xYRza2kg
d3JvdGU6DQo+IEhpIEtlbHZpbiwNCj4gDQo+IFRoYW5rIHlvdSBmb3Igc2VuZGluZyB0aGUgc2Vy
aWVzIG92ZXIhDQo+IA0KPiBJIGFtIHRlcnJpYmx5IHNvcnJ5IGZvciBhIHZlcnkgbGF0ZSBjb21t
ZW50LCBlc3BlY2lhbGx5IHNpbmNlIEJqb3JuDQo+IGFscmVhZHkNCj4gYWNjZXB0ZWQgdGhpcyBz
ZXJpZXMgdG8gYmUgaW5jbHVkZWQsIGJ1dCBhbGxvdyBtZSBmb3IgYSBzbWFsbA0KPiBxdWVzdGlv
bg0KPiBiZWxvdy4NCj4gDQo+IFsuLi5dDQo+ID4gQEAgLTExMyw2ICsxMjcsNyBAQCBzdGF0aWMg
dm9pZCBzdHVzZXJfc2V0X3N0YXRlKHN0cnVjdA0KPiA+IHN3aXRjaHRlY191c2VyICpzdHVzZXIs
DQo+ID4gICAgICAgICAgICAgICBbTVJQQ19RVUVVRURdID0gIlFVRVVFRCIsDQo+ID4gICAgICAg
ICAgICAgICBbTVJQQ19SVU5OSU5HXSA9ICJSVU5OSU5HIiwNCj4gPiAgICAgICAgICAgICAgIFtN
UlBDX0RPTkVdID0gIkRPTkUiLA0KPiA+ICsgICAgICAgICAgICAgW01SUENfSU9fRVJST1JdID0g
IklPX0VSUk9SIiwNCj4gDQo+IExvb2tpbmcgYXQgdGhlIGFib3ZlLCBhbmQgdGhlbiBsb29raW5n
IGF0IHN0dXNlcl9zZXRfc3RhdGUoKSwgd2hpY2gNCj4gY29udGFpbnMgdGhlIGZvbGxvd2luZyBs
b2NhbCBhcnJheSBkZWZpbml0aW9uOg0KPiANCj4gICAgICAgICBjb25zdCBjaGFyICogY29uc3Qg
c3RhdGVfbmFtZXNbXSA9IHsNCj4gICAgICAgICAgICAgICAgIFtNUlBDX0lETEVdID0gIklETEUi
LA0KPiAgICAgICAgICAgICAgICAgW01SUENfUVVFVUVEXSA9ICJRVUVVRUQiLA0KPiAgICAgICAg
ICAgICAgICAgW01SUENfUlVOTklOR10gPSAiUlVOTklORyIsDQo+ICAgICAgICAgICAgICAgICBb
TVJQQ19ET05FXSA9ICJET05FIiwNCj4gICAgICAgICB9Ow0KPiANCj4gSSB3YXMgd29uZGVyaW5n
IGlmIHRoZXJlIG1pZ2h0IGJlIGEgc21hbGwgYmVuZWZpdCBvZiBkZWNsYXJpbmcgdGhpcw0KPiBh
cnJheQ0KPiBzdGF0ZV9uYW1lc1tdLCBvciBsaXN0IG9mIHN0YXRlcyBpZiB5b3Ugd2lzaCwgYXMg
c3RhdGljIHNvIHRoYXQgd2UNCj4gYXZvaWQNCj4gaGF2aW5nIHRvIGFsbG9jYXRlIHNwYWNlIGFu
ZCBmaWxsIGl0IGluIHdpdGggdmFsdWVzIGV2ZXJ5IHRpbWUgdGhpcw0KPiBmdW5jdGlvbnMgcnVu
cz8NCj4gDQo+IFRoZSBmdW5jdGlvbiBpdHNlbGYgaWYgcmVmZXJlbmNlZCBpbiBmZXcgcGxhY2Vz
IGFzIHBlcjoNCj4gDQo+ICAgSW5kZXggRmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIExp
bmUgQ29udGVudA0KPiAgICAgICAxIGRyaXZlcnMvcGNpL3N3aXRjaC9zd2l0Y2h0ZWMuYyAgMTU5
IHN0dXNlcl9zZXRfc3RhdGUoc3R1c2VyLA0KPiBNUlBDX1JVTk5JTkcpOw0KPiAgICAgICAyIGRy
aXZlcnMvcGNpL3N3aXRjaC9zd2l0Y2h0ZWMuYyAgMTc4IHN0dXNlcl9zZXRfc3RhdGUoc3R1c2Vy
LA0KPiBNUlBDX1FVRVVFRCk7DQo+ICAgICAgIDMgZHJpdmVycy9wY2kvc3dpdGNoL3N3aXRjaHRl
Yy5jICAyMDYgc3R1c2VyX3NldF9zdGF0ZShzdHVzZXIsDQo+IE1SUENfRE9ORSk7DQo+ICAgICAg
IDQgZHJpdmVycy9wY2kvc3dpdGNoL3N3aXRjaHRlYy5jICA1Njcgc3R1c2VyX3NldF9zdGF0ZShz
dHVzZXIsDQo+IE1SUENfSURMRSk7DQo+IA0KPiBFdmVuIHRob3VnaCB0aGUgc3RyaW5nIHJlcHJl
c2VudGF0aW9uIG9mIHRoZSBzdGF0ZSBpcyBldmVyIG9ubHkNCj4gcHJpbnRlZCBpZg0KPiBhIGRl
YnVnIGxvZ2dpbmcgaXMgcmVxdWVzdGVkLCB3ZSB3b3VsZCBhbGxvY2F0ZSBhbmQgcG9wdWxhciB0
aGlzDQo+IGFycmF5DQo+IGV2ZXJ5IHRpbWUgYW55d2F5LCByZWdhcmRsZXNzIG9mIHdoZXRoZXIg
d2UgcHJpbnQgYW55IGRlYnVnDQo+IGluZm9ybWF0aW9uIG9yDQo+IG5vdC4NCj4gDQo+IFdoYXQg
ZG8geW91IHRoaW5rPw0KDQpUaGFuayB5b3UgS3J6eXN6dG9mLiBUaGF0IHdpbGwgYmUgYW4gaW1w
cm92ZW1lbnQuIEkgY2FuIHByb2JhYmx5IHR3ZWFrDQppdCBpbiB0aGUgbmV4dCBwYXRjaHNldCAo
Y29taW5nIHNvb24pLiANCg0KS2VsdmluDQo+IA0KPiAgICAgICAgIEtyenlzenRvZg0K

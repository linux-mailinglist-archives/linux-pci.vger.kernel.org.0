Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9680512B92
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiD1Gdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 02:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiD1Gdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 02:33:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5681CFE5
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651127428; x=1682663428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y5Ti5GCQSInxoALiSjBxBj57hoocej8G63ZLrgbG/GM=;
  b=YdeXQl1k0dTnq5p3s8tAkwT5XSJZIOlahobEhn2L+ZbyDIh6lswIaR+s
   kF3W7kkEK8s+Dy7BjTWBp0hwduvwWKdZoegpsWLJMUxf1HYr4Ae2Dl+61
   w/pfLNRQdYYaBPljzmqQc0dCPbrP553wbtEq3hXxHX/ttjKkyYkpR4rRT
   Aso8irBGWJ8MI7xvKDLmsMNX/OENNR4pn+S79nvwoa3B/i+7CWqwBJKC8
   i00dk3vYOY8kgwU5SwSYBBen0QCM5YO5/z0E/MrbC5aIoUqGB4RpvxOfr
   YAiJO5cR37iG9AnawEqvNvsP9hzo2+tvoMAu8TBW7P6oP/3WS5iUC5is0
   A==;
X-IronPort-AV: E=Sophos;i="5.90,295,1643698800"; 
   d="scan'208";a="154113785"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2022 23:30:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Apr 2022 23:30:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 27 Apr 2022 23:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq1bGjrRnA8lDN74ycU0a9S0b2DsNYAKsOKQdfT++4PNP2tplpiZ3FGVWcuoBrp3UqlpJ4QgUCarRmvD7KETW8J9GFuIr8YE4O84bLicCfr3I5PVfFmblsgG+p3H/J0Qdj+qaaHDsdHWByfi+evEmCQMcwa6FeCPl36HhhryGQbjvHqAPyANz27FcecoYPPZXIUuY30opF2NIyM0zboAHToxGkLvgWOdX1QQ98zX0Boc1qUv5XPOySvHRmSmvQua73lNudCKV+01N9olwCAKSlE+fICS0qq/vTtWxRiSvGajUmUw4s9+VEx+YA9bRTwVt+eRcei5dw+o159g1Jt4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5Ti5GCQSInxoALiSjBxBj57hoocej8G63ZLrgbG/GM=;
 b=g+y5fm+av5Kor10c+lMN/HXWhpZ7ThVtNDg6whI/AACFXP6O3jGzZaFWrx5oxdDXKeGuiV2nIf6167Dowt9S6Lhl0hKQqcwfmjOUuWKwSBuYqCdA2XJaa7LZPVz2tWXai2Ylp2XEzega4H9vZZ8BJRyRirAQB/wPMA66I299Akfr+W+vB6O2N/Br0xmR/Vw99dFAW9l5CLn2tnQYgRGEjHIZzNvzMqIPoPlWGQYU6YYxEpoUBBTeXmq/nyHQWs7Jk/C0ZNnPKtQT7ZDa68pDY2WtIwEGNnssld5gu/8Heyp7g5fn9YhXkXwM2EW2EyRgXmGgF8citOBdqAPDfbdFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5Ti5GCQSInxoALiSjBxBj57hoocej8G63ZLrgbG/GM=;
 b=rcqxHz8kEqxt983DemI04YyX4lCkhcSHr2aQ8oa6a5BDWwE6DUxiHLE7mFJi1OlBTWyROeP5X3BZhcamoYAPNzh/9RuS7W2ykja0CTIM/aYJvuRU7OYZJyNunl8FU8g2kD5DZg5oUGre0xLpFBJ4uN7pojrEv9aGAk845Ny3XPQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by DM6PR11MB3194.namprd11.prod.outlook.com (2603:10b6:5:5c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 06:30:12 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 06:30:12 +0000
From:   <Conor.Dooley@microchip.com>
To:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <Cyril.Jean@microchip.com>,
        <maz@kernel.org>, <david.abdurachmanov@gmail.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <Daire.McNamara@microchip.com>
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Thread-Topic: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Thread-Index: AQHYSN7WdGxuspPXV0KaH+H3O3rn2K0FAP4A
Date:   Thu, 28 Apr 2022 06:30:12 +0000
Message-ID: <3199781d-7581-4fec-02a8-80f254ac630a@microchip.com>
References: <20220405111751.166427-1-daire.mcnamara@microchip.com>
In-Reply-To: <20220405111751.166427-1-daire.mcnamara@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b0e92d-87f5-4a7b-a7e8-08da28e08cc5
x-ms-traffictypediagnostic: DM6PR11MB3194:EE_
x-microsoft-antispam-prvs: <DM6PR11MB31944C702AB166EC55B9109B98FD9@DM6PR11MB3194.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sn/KNsGR17dLpdas4DsIPsMCJ2mqXIj/Re54QdiCZWZfPlHOZmW5kIUEu1Vtraol5HyvR2gAfAtoEuGDciKahMNyttYiZ5GqfvAim+imXHLriGKPx2JFNuyVdr98AdfEUfCwCjnVyYc/BBM0ctWqatS2CUO4mWKvI8r4RlcW/glJGpgxwwGuzAkfNNXbIllRHkJ9i8WbSzVo5Chcbn40kje5hUMFeGku8eF3d6X2SwmIQqGotW0Cw2AvmVh7JHfCBfzLqIteyteYY0iYXVDMKSxUbPskJH1vMjmjgtru2MSdkIFXcsMwiiTIzT76/r4PBH5xTBmblndzLLZNXvaWisXK/LrzeHRxeSIOqzLNF44/FNZuFGB6XtBA4kip9xVV6ozRP9tO5P/J0R7KeaXEIV+d8Y5K0rG3PY1k2rfO16ALTOi+4H7i0Q31GxZCQ6Mb70iAEEw+veV+Jf5GNkqWx07Bl6k2JR2Rm7OPAFWgxS7oqq/3oGVj8SF4XnAkb4FMMrg9zrz5utDswQDnPcYXBfTkhibfxc8B1NRkF0xiPRQ4UhLiwrDj2AgcMHE8YOvSRkbaAmomMfwmKokK94cDQU5EZ8VShSfvoRtTJqxotiIiHuLdxbwhzB93piyKUbajebzUa+a3kSmRuBX87TdnN5Aw1aB4YenkhpJGPsJe5/koEQcTb3RM6YgtAEiaiarEqKEtkBGcZog+Af1/K9T97PJNCK0Rtxe7oWGsp8FZJqH7YjE1WOAYQ13rZ/006Gejio30qCw5R6QIpf0iLmrHHpD1w3locCTymi01SXaoe3zxVlOyvd9Bj9LeHUxF0yaFWtF8PGf4rjBJLOQVaiJ9N/I1Bs4xYuALy/0SdagfXUtiWArdyVRtJ3l6cozcbnuDl7j8cP/a9n7oGIql6eFHqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(186003)(508600001)(31686004)(36756003)(6486002)(83380400001)(316002)(2616005)(107886003)(122000001)(2906002)(38070700005)(66946007)(66556008)(66476007)(53546011)(38100700002)(64756008)(54906003)(31696002)(76116006)(91956017)(966005)(86362001)(26005)(66446008)(110136005)(71200400001)(6506007)(4326008)(8676002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9tbVB2ei92N3I2L3FvblZscWs5bTZYaFZjV0tIUldsb2tCYW1Qck8zb3Q3?=
 =?utf-8?B?ZDdZam9lSGxHTEVaTlJuaDhWVVJkZzNpMnRITys1Z2U0Tlp1anBzeHJxRlBZ?=
 =?utf-8?B?QmN3M3lXelpBTzN5aGZCREl5SG00d1g0dFlrazlocnEwMUdkVUlvL3dHUWFn?=
 =?utf-8?B?Vjc4eVJWb3dtaGpRTVZ6aU95cFc1R0RQZjAxYURCc3hIU0srcmU0QnZzVS9S?=
 =?utf-8?B?eTg1Tmc3M0ZMd3lhaHlvc1lZK0lBYkYxcDRkbnhxZ0dWVnJXV2JBb3M1QVU5?=
 =?utf-8?B?VkZhTEp0K1d0d0hFc1U5MjFrM2VEQXQwSlo1K1dvd05waWgvVFR2RFgwb2NE?=
 =?utf-8?B?S1c3dDdUSkhQa1lsMnBEdjgwRUNWNnlaTWg5VHJkZnVzOEVWQ3NGTXU5K2dj?=
 =?utf-8?B?R2FTU3NrQ1dzOENiakhKV2cwVi9ZcGxMandJQkFsOUwrcDBoMkhFSjNnNUVy?=
 =?utf-8?B?TFBPNWxHZ2hSMlVuaXdUUEs2T0RISElLOVNEVTFWajExMEQ0V2hhVkVtZi9V?=
 =?utf-8?B?dG42SlB5VUZMVStqVmVodkNFR0JLRVhiZ1NLWjRoNHQ1M0R3SlVWU1JlNlpD?=
 =?utf-8?B?ZGg2bnlDKzFVeVlOdnRQaFovaGd5RVVhRG4ycFlEUkJjWDZTMVpoYkdXbEdF?=
 =?utf-8?B?b2l6SFpYWFMyYVZYM2VsS25RSGRDYTdpUXBNMjhJaDlLc2VjRlRTRFBucWVL?=
 =?utf-8?B?YWRXN0Z4bmZpb3NnZnRBMk1CNDE1YTFpQzFKaFM1dFpMWExrcm0rRGJsY2Zn?=
 =?utf-8?B?MGZ0ZkNqMUt4VW9hRi9KL2dsNDNRazAySWV1eVpMb3gzaEVjZ0JxTGdhMFQv?=
 =?utf-8?B?cmZqSUNBMWRXaTUyZ0tMMS9yRVVYZFQrQUZHNitQYnN5N0NWbWt0K0dPVS91?=
 =?utf-8?B?Y05wV0MrbWEvT1lxRmV5TEhnUXd3QWlidWI3ZnBpbEVZNFJ3SUJHSXpnQ25H?=
 =?utf-8?B?T09Mei9iTk5mT0d5OTBpZ2xXNS9xMm1ocEl3alRuMWQrMCszbGN2T1ljQ2Vu?=
 =?utf-8?B?MFFYMjA5blpFYnoxTU9lem94T3JDeHZwTFIrVjNJK3IyTFMyQXBTZVNtSUp2?=
 =?utf-8?B?d0pnQmlLemt3UFh1SklwbGtPRll6K0I4S3BrTWRPNCtseVZNa3Q3K2NTUGxq?=
 =?utf-8?B?aGozRnBQSjlzMXVZMUMwLzhQeSs4VS9KQ3RuUVFYdEFlcGNFb2RVQ1Q2OU5j?=
 =?utf-8?B?TWhrUmZNbFhOTFpxOGdRR3VDRms3NElBWnNuQUJiTGNiS2pYWWgwaklSaWN0?=
 =?utf-8?B?Rk0rVGpPOHRSU3cvNklVY2N2VHJQMXREcnF2RHZvTGJJcWIxVHpvWU5SRzNv?=
 =?utf-8?B?SURkeVpLQTNhMzkrZEVWbnVRNnNQa0l4U3NjZk1peU5KSk9ZMnZaTVJkM1VC?=
 =?utf-8?B?ZXRJWGcva3VheUd0TWpKZTZPakFWNXFaQlUyb3NLNWltcEVkZ1pDTXl3c2M4?=
 =?utf-8?B?UW9SRWU5RnhCY1l0KzczTVBocURobnJsZGpvNnhwditVcFdxdUltVXhMbkh0?=
 =?utf-8?B?bVgzYlI1Wm00ZnFESzBvNkd6YnJqOThkbkNhZDRGWkhyZ3BCZlhCNm16Rjgx?=
 =?utf-8?B?NThvUi9yWWRkbTBTVmRGcUM5UWp5T2ppcDJsVy9vN25VdzJiNGhxTzlDU3R0?=
 =?utf-8?B?WnJwTU1VM0E4cTlkd1JSbGlDc2Z2Vmdkc2pueEJTVnd2ek5FQnZlWDROQXVa?=
 =?utf-8?B?ZmNMMUpPQXFUNitqL2NtYUVvclJFMHpBZUdUY3A5Y3JnLzJSbFFEdVN3WHNY?=
 =?utf-8?B?aklzS3dhSjUwNEhZUmM0R0J6WEdlUVNGUUJ3QnB1dXZtSTFuYnZJbnpjSkVS?=
 =?utf-8?B?dk0xZm5sRkRTeldHeUpiWUEzUjgyZmZmUkoxelFPQXNmcVpqQTFtNVBqUmhH?=
 =?utf-8?B?TGlVb1o4akJ6aTN0Vnd3bnlaelErTmhKRm1UdlUxVkNrdHdKRG1hU3d3MTJk?=
 =?utf-8?B?djQ5YXRtMVZiZ0dXTlZiVXpBZjBNbDZDUE8zMmJnNmVNeXJOdUtjbWZTaVhS?=
 =?utf-8?B?bXJ3UDVlUkt6aFJMRE03di9xTFhpdXZqU0JXVTFzREZtbmxuSjYzRTYvSWww?=
 =?utf-8?B?Mkh2KzNzaTIvcWQ2WmVZQzAzU2gwRFZWellyT2x4NWp6YnhaS3lMODNqckQw?=
 =?utf-8?B?QlQ5ZFNzeXI2Z1NiMkExSEpnWHhoZ2VESDBLUHBXTnI3L2srVXpiY3pFaDJs?=
 =?utf-8?B?R2w3VGcwVWVQamtkaENhdVRNTjhpNGV0alNzRlhYbCs5UWM4R002S2tJQjYw?=
 =?utf-8?B?YU1ZSDZLR1ZTWG1HQzRnM0wyTmw5alJiRTRlc3BmUzZjQnZnc21XMnZCWlln?=
 =?utf-8?B?dmEwWEg4bUtNY0lNTlEreVhUSUZkMGc1VlFTcC9TUXJMdlk5Z0pUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9E808B729C4B547ABFB297D8183C47E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b0e92d-87f5-4a7b-a7e8-08da28e08cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 06:30:12.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR7wOXXMlWbUpFwhvCJsWvAzrI2rGrH7iFRlltaT71oEs2glapWsYWFzMKmTofjU8dqLTl44WKs9TTb1lC3WAoJlfoZMaIzkBpXAUzRah24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3194
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGV5IGFsbCwNCklzIHRoZXJlIGFueXRoaW5nIHlvdSBuZWVkIGZyb20gdXMgb24gdGhpcyBwYXRj
aD8NClRoYW5rcywNCkNvbm9yDQoNCk9uIDA1LzA0LzIwMjIgMTI6MTcsIGRhaXJlLm1jbmFtYXJh
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IEZyb206IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25h
bWFyYUBtaWNyb2NoaXAuY29tPg0KPiANCj4gQ2xlYXIgTVNJIGJpdCBpbiBJU1RBVFVTIHJlZ2lz
dGVyIGFmdGVyIHJlYWRpbmcgaXQgYmVmb3JlDQo+IGhhbmRsaW5nIGluZGl2aWR1YWwgTVNJIGJp
dHMNCj4gDQo+IFRoaXMgZml4ZXMgYSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24gcG9pbnRlZCBv
dXQgYnkgQmpvcm4gSGVsZ2FhczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNp
LzIwMjIwMTI3MjAyMDAwLkdBMTI2MzM1QGJoZWxnYWFzLw0KPiANCj4gRml4ZXM6IDZmMTVhOWM5
Zjk0MSAoIlBDSTogbWljcm9jaGlwOiBBZGQgTWljcm9jaGlwIFBvbGFyRmlyZSBQQ0llIGNvbnRy
b2xsZXIgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1j
bmFtYXJhQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiBBZGRpbmcgbGludXgtcGNpIG1haWxpbmcg
bGlzdA0KPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jIHwg
NiArLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3Jv
Y2hpcC1ob3N0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3Qu
Yw0KPiBpbmRleCAyOWQ4ZTgxZTQxODEuLmRhOGUzZmRjOTdiMyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gQEAgLTQxNiw2ICs0MTYs
NyBAQCBzdGF0aWMgdm9pZCBtY19oYW5kbGVfbXNpKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4g
ICANCj4gICAJc3RhdHVzID0gcmVhZGxfcmVsYXhlZChicmlkZ2VfYmFzZV9hZGRyICsgSVNUQVRV
U19MT0NBTCk7DQo+ICAgCWlmIChzdGF0dXMgJiBQTV9NU0lfSU5UX01TSV9NQVNLKSB7DQo+ICsJ
CXdyaXRlbF9yZWxheGVkKHN0YXR1cyAmIFBNX01TSV9JTlRfTVNJX01BU0ssIGJyaWRnZV9iYXNl
X2FkZHIgKyBJU1RBVFVTX0xPQ0FMKTsNCj4gICAJCXN0YXR1cyA9IHJlYWRsX3JlbGF4ZWQoYnJp
ZGdlX2Jhc2VfYWRkciArIElTVEFUVVNfTVNJKTsNCj4gICAJCWZvcl9lYWNoX3NldF9iaXQoYml0
LCAmc3RhdHVzLCBtc2ktPm51bV92ZWN0b3JzKSB7DQo+ICAgCQkJcmV0ID0gZ2VuZXJpY19oYW5k
bGVfZG9tYWluX2lycShtc2ktPmRldl9kb21haW4sIGJpdCk7DQo+IEBAIC00MzIsMTMgKzQzMyw4
IEBAIHN0YXRpYyB2b2lkIG1jX21zaV9ib3R0b21faXJxX2FjayhzdHJ1Y3QgaXJxX2RhdGEgKmRh
dGEpDQo+ICAgCXZvaWQgX19pb21lbSAqYnJpZGdlX2Jhc2VfYWRkciA9DQo+ICAgCQlwb3J0LT5h
eGlfYmFzZV9hZGRyICsgTUNfUENJRV9CUklER0VfQUREUjsNCj4gICAJdTMyIGJpdHBvcyA9IGRh
dGEtPmh3aXJxOw0KPiAtCXVuc2lnbmVkIGxvbmcgc3RhdHVzOw0KPiAgIA0KPiAgIAl3cml0ZWxf
cmVsYXhlZChCSVQoYml0cG9zKSwgYnJpZGdlX2Jhc2VfYWRkciArIElTVEFUVVNfTVNJKTsNCj4g
LQlzdGF0dXMgPSByZWFkbF9yZWxheGVkKGJyaWRnZV9iYXNlX2FkZHIgKyBJU1RBVFVTX01TSSk7
DQo+IC0JaWYgKCFzdGF0dXMpDQo+IC0JCXdyaXRlbF9yZWxheGVkKEJJVChQTV9NU0lfSU5UX01T
SV9TSElGVCksDQo+IC0JCQkgICAgICAgYnJpZGdlX2Jhc2VfYWRkciArIElTVEFUVVNfTE9DQUwp
Ow0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBtY19jb21wb3NlX21zaV9tc2coc3RydWN0
IGlycV9kYXRhICpkYXRhLCBzdHJ1Y3QgbXNpX21zZyAqbXNnKQ0KDQo=

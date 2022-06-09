Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4355457AB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiFIWxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFIWxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 18:53:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917E12AB6;
        Thu,  9 Jun 2022 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654815193; x=1686351193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ctS/sQpYqBjynPNcgFFwpOoQJVRsp1odcWhGtxNO2GA=;
  b=umbpFMaWSMuPI7PtK+10IXTDU+PQyGgLjDrS0wTtDi1oRExB4GD1RK+m
   /o7/wlzVI/KGy1RbQ+Dm7CnSiLU+q/0d3V6xvs6n1MOBGZTcfhKzAncNF
   WfXz4ddwqib3ByukSvcC9dGP0JzDlXMWacx5KRvUCuyTuky9AMfqVemKd
   TVOkEH8DblkK3XVM/WI3pbgrS0z4E45pbQJkCdctthdSZ7/TNeWxlRg06
   zveY23J5nbz3Tp7J391sT/VWpWYz/n9PCW18l1ehek+H4BUfCYg06o18Y
   cWNNKshhMJzpzQV/wdTpPQ4CYfk68qYoET415TFX8W+zu21/mnT1f3/2X
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="177335022"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 15:53:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 15:53:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 15:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMxgYbgyTu/JI8PI+VUQJ4v9tZk192jV0aiA/iFXxfLwDBeJxyQPPvzlT2sVqhtAnFxyE7uqstgzuDwEQ2MGb+ajQHkCMF5WpO1JKlJ5xTNx41I/o4pY2M4a/gLqmxmQpzW+JcmcqbPao4ylRg7KAL4G/hioIaDgBeZIZ7U7VfQZ3Fgxv0Dyz6diGnDcudJpyAcvGRxnTBz0prgKbshyk2gkw82iWwRYEVX5mMoZ1xoXOKD1ysCJ0W3KB7tjRUsN71YS5PTCteQDR7oZVXzYEIfLmHVwfqH/PW6jpNHVV7luGpH0vjZS4m3xYBtkJdgG5AhLGypF+VxRBSDJBXHpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctS/sQpYqBjynPNcgFFwpOoQJVRsp1odcWhGtxNO2GA=;
 b=lQ2QPR4iSp/U8GVupnhUAAK6eIFnZrxsAkVuTFmoDow37T++HGBh3ER3g1n2rRiUOK101XYJ4RIuoOmLrwPDPT5gxPKR6DDKgrU0eSh45DqHI32XfyNdMuSegSYG1SgrlFOu/MGWh97Iof+oTSPxMLvWWoSMWf2utv2vcf+keIZFZY84snKYmXreWUreqjaq0aXSg7DpuPI24J3V+OvgqpIpAGnVhW1deDkZQVuqfJVdyJloXpiN0lB+N5JlAYgOZE9Tqh343aMu8mgoW0TJEivVpFsUICld9Ti6VFyRUCmxkc5XDVuULNDYDpYFIUicWjT2AnDOPmQMg0IFRPewyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctS/sQpYqBjynPNcgFFwpOoQJVRsp1odcWhGtxNO2GA=;
 b=n5OJoY3zrGdT7bZS5cmrZTgHhyyV4Z9Gcqm/fJQpkRCwu+c9Fjupnj6lbbV7cM+B0WxYNjXpoKh8JvqiwLyum/qCEm/HmLTmwtObBpC37rwJ4K1P5ar5qn8VUQxKDPixv4FNmFNzc5hj2xE5/rmiHnMcCmxWkBOMpNYrPI5+Qz8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3238.namprd11.prod.outlook.com (2603:10b6:a03:7e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Thu, 9 Jun
 2022 22:53:08 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 22:53:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sboyd@kernel.org>, <arnd@arndb.de>, <Conor.Dooley@microchip.com>,
        <gregkh@linuxfoundation.org>, <palmer@rivosinc.com>,
        <kw@linux.com>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mturquette@baylibre.com>, <robh@kernel.org>,
        <herbert@gondor.apana.org.au>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Daire.McNamara@microchip.com>, <Cyril.Jean@microchip.com>
Subject: Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Topic: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Index: AQHYYG7KcHM3Zb8ggE+yYwRhcaPSb60sczEAgACJPICAAAITAIAOiFsAgAxdB4CAAAKegA==
Date:   Thu, 9 Jun 2022 22:53:07 +0000
Message-ID: <bb401ee9-2c8e-d486-9663-b80ae9cc0974@microchip.com>
References: <mhng-5c57560e-a00b-4fd8-95ee-5e2fc0dcd34c@palmer-ri-x1c9>
 <20220609224347.1212EC34115@smtp.kernel.org>
In-Reply-To: <20220609224347.1212EC34115@smtp.kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 550287fe-8a0c-4735-315d-08da4a6ad21b
x-ms-traffictypediagnostic: BYAPR11MB3238:EE_
x-microsoft-antispam-prvs: <BYAPR11MB32382AE3A151F0E3C3CEBC0A98A79@BYAPR11MB3238.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMCWOCg3RymkwGtv5PSksqBCNwzpNs5FkGIWee+HyDERiDpQIkACi26ZYrRIMV/DYuP5gkdCVBbEWjnav6O43XvoUmrRi1Xom76pem0iefi0Yapeug0kpFBf1wsOQAImDuAPDQb9kAaV3WccczVSdHcaE+MERRQ/1VN2882JwT2yMK1NT6sCnOva7YYHJa2kzF84rHbUqfrviPfctI0Coh5d+tLlAuLhZKeNQ0wLUzjSA1gRx8pXuTCUvl8q/tmzZP3DPMJS1veEDTAWnf6YVH6/vIhY4VtlWZWaoq+C1bidmssaiz9kBUvGrtkeY77bC7vcVr7tVO2OnZrvv5MhN8d1eE7oI+N8gXjpqdlpEQolOF9ez3+WFnDG+MivNKoisltiLlS+yno9zT6LCL6TKzqEpeuS2y49SVYBFPdU6bVDgi28kB+DdTNOw59taa3BW5hn+X1l8Wx8/X/mmbJVOba+ZKysRbAnZNThUpZNBpRbMRHzXe5zl1HOCOFdWH3DnNhvFsR5U8/2jU4R1uohkRWAPeVvGHmCLhzSWeWZnSXAJsorM5KMGLAeXtwcDYS6iNDvpDiQJcOSUi8+OdXhrwJNakzQcrdRS+x+S75Rki1QdvDVcA/CJyL5Kcf61U0AJv3aghZH/tGtpLjeE9ibKC29Ilj+H/Ng6XSMr+wBYoODvJkAkRA2h3niEGIUoj/FEHa3zEM9RMMSu/9bUsmXKbvlq5n8qDI2Q6NQTz+IH+6E+rjQ0XBFhDhIS+yt8878qdjFBhZSXbZ1LiXZL1PJAqIeNOOGUTAc4txn9utNN38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(8936002)(2906002)(91956017)(31696002)(76116006)(66946007)(38100700002)(66476007)(66556008)(66446008)(53546011)(5660300002)(6506007)(7416002)(71200400001)(2616005)(6512007)(64756008)(86362001)(36756003)(122000001)(8676002)(921005)(4326008)(107886003)(186003)(83380400001)(38070700005)(316002)(26005)(110136005)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzgvTHBoc3lMNno3bGJWaFJrdEV0amhCNmNVUk9XMjl1R1o2OWtOekgrc01D?=
 =?utf-8?B?SWFCU2JYTkJmdytLczJyc3BEWjJqL1ZFZ21aYjNuRTlmVGRhdGNKUTEwYU5k?=
 =?utf-8?B?Z29xNEZkL2hMclh2djBmUmtjMXBWeFZtMUdUcXErTHJBMEVpb2VsN25YZlkv?=
 =?utf-8?B?dHNqNVpyVXlJVGJoeW1BaCtoOUV2MHU5bXh6M3JTVDFDMU1oVFJ2c1htVUVT?=
 =?utf-8?B?WEtxUDJIRUVMaVFXVnZMTU0vdEtSZVkxQTRDVlIxT0VQanl2SWErVnp4dlRT?=
 =?utf-8?B?RlF1dkNuMTAxbmx3YUxvZkVGZm5KVmcxVytHMC9PMkEvWnQreS9Va2wrcEZM?=
 =?utf-8?B?dkFsd2xXQStSRDF1TDc4SVlpd1lTTVRqWFUyaDczT1Q4TWJOKzRSRkpLc2d2?=
 =?utf-8?B?UzJtOEtBVmtGTm9GMXM1Q1BTUlU1Y0lDSnVySVA0M21kY0ZKeWkrbHNLaWN2?=
 =?utf-8?B?dWt0MWtxRDRURWNEdURTWFIrS0hYSkdkT1QwVEw2b3RhajM2ajd3aUl5U0E5?=
 =?utf-8?B?S2JMZ2lnMmlzSkNZOFBoR25JT2V2MlBTeUxmS082SkZEQVlVdjNSZWs4Tm03?=
 =?utf-8?B?eTQ3UVowQ0pjMXR5RWxKRUpGbGJNejAvT1JMMHVwbEg0SlRsQ0o2NVhkcGZq?=
 =?utf-8?B?Qy9CODA5Z2hCMEFGL2kybzJGcW9oMk1xRHE2bzRkSkpTdnM3N1M5K2dSRzU2?=
 =?utf-8?B?M3ZVRFdBTCtCT3poRkR5TWNnaFdQOXM4MzFLYnpsdTNzN3JkQ3JCRG5DbDl6?=
 =?utf-8?B?VzhmZ0hyT2thOEc2SHlCdVJ3QVBxcnBZcU5RQnEyRm1ZOGl3ZGNFZ1hGRVla?=
 =?utf-8?B?eEZVSDFUREFmQzdPRHJQZHZBalpJVmZKRDdES0dxM0wzdS9Tb0xOZDVuS20y?=
 =?utf-8?B?czVtN2ZUUjJsYzNVa2s5MHpycHB0aVJ4WmQvbkx1MG9rV01vQWRwendYbSt3?=
 =?utf-8?B?b2xRdElkUEdNUXA0Q2xpbmFYMkVMbzc4RVBaTXJ4MUJsSktSNi9Tb2toN2w1?=
 =?utf-8?B?YzZGVnFNZ0NpTmNkeGdJTHFYYmRsOVpZWGVHVmovenozVHY0bmZjaGhQWTNq?=
 =?utf-8?B?R1dZamRpdTViREFRS1poN01QNzgwWG1MYzN3L09hR2F6aUJuU1ExS0ZnN0Iv?=
 =?utf-8?B?UTUwblVvRi8rQkVPb3R1Zk1tZTM0MFRCeDlaZDc3cEtoM1h6bHZWTjczOGNy?=
 =?utf-8?B?Mi92U1pEUi9HeXNJMkRpQmloZ1NHd0t3NUJiMTJLTW8vbStaaitZaGVuNnhS?=
 =?utf-8?B?ZnFFc0VrazhmSThDNjhXd05FWDBWbzkrMzhlczhNc1JRMkFjb3NFOEhqT1Qv?=
 =?utf-8?B?eDZsQzI0Mi9QSnhuUkZaeWUxaExGZ3dyMXFJSWJrWExHVlQ1c3RISlRqYS9I?=
 =?utf-8?B?aVdiNFgwRjhUV3hEeDlVd0xqR2E4VU1qWlBwZDJWTWlacWJjREhDSU13Q1Iy?=
 =?utf-8?B?MjViSG80V2w4MkpNWURtS0NsN1F5dHlydC8yRkZsS0E1Nzl1NlE3MElFVWNn?=
 =?utf-8?B?dkxZUndsRm04eXVXbDc4eVczazVUN0lXN0FOM3hxY0lqMUxJYVBxdG5LWXVV?=
 =?utf-8?B?R0xwdTZrVnFZVmszSzdBWjJNN3EyL0xURk9sZEhQL1BBUTltdTF3eFQ2dXhX?=
 =?utf-8?B?d3BYWnFYUTlGdUExdXhTSERJZTNtRUdtaVZISDNKSUpuUXM3enBnV2l6QSsr?=
 =?utf-8?B?NkdhV1FVNjkreE5qbzVVdWVBeFk2a0luZDNEZTM1RFdzc2hHVStiT21CZUd2?=
 =?utf-8?B?cENYeW5iZHFHeHR3M3dScnZBU0R1V3Vib3FDQkpOeWNRNkRtMWNRSDF2VWkz?=
 =?utf-8?B?RlV5eHdoUDFaalY3MmYycmc4RkJ5YWdjK2dmMnVnd2NqMCsvUmx6a0tjZWpn?=
 =?utf-8?B?czdKZ28zVTVEOEVSOHhXMnVUZTNZSVpvWkV5UnJuQUtKZEl4RjErQ3NXNTVu?=
 =?utf-8?B?RVYyU3FvVjhJa2ZnV1A0T0tzbjFCM293RzkwREw5NDVQUWFBeUg0M1U3WjlZ?=
 =?utf-8?B?em1YaHpOVXBjTXRvM2l2c3VHemo5c1h5UXE4STZmczBjbjVLYVpLdnpRSTR5?=
 =?utf-8?B?dnVJaUpUNFZWL2hwNnFRUnhOL1dGYzR2UU1VV0RjU1JSa0o0aVhQTXZSQTdI?=
 =?utf-8?B?SWRNQkJkU2phSFU1aDVrUlpMc1dMZ1MyRmhqbWlBYS9JaldDQmRnZW5EMFEr?=
 =?utf-8?B?aElaZUI1eXhBQVNqM2F3NDhOQ2Jmc0UwbitQVTRPcURkQ1doZzJmeU9QMzBR?=
 =?utf-8?B?elc3ZEtDNFA5MysvN1kxcm55K1JWUjM1cmlnQjViT1FScFZlRUc0emNSak55?=
 =?utf-8?B?NUkrMW03RTlvZ0VoQVNGaG9KbmgzaVVaSUU5bnpNUjFHODM0N3BFU0ZEVDFl?=
 =?utf-8?Q?6Gq9SPzpdn23hRV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49DA1C5B64600442B024B1821764BA25@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550287fe-8a0c-4735-315d-08da4a6ad21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 22:53:07.8176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WftBDy/yiTXIgz0tB8VyGWmF3THkclCWsUxG1IeIElNdrbvuNNWue3FG0gXZ5q9nPDUtPqVQQDL+88vlch99VTYvJyNBYoDgVuKbSEXjMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3238
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCk9uIDA5LzA2LzIwMjIgMjM6NDMsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBQ
YWxtZXIgRGFiYmVsdCAoMjAyMi0wNi0wMSAxODo1NTo0MCkNCj4+IE9uIE1vbiwgMjMgTWF5IDIw
MjIgMTM6MDA6MDEgUERUICgtMDcwMCksIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+IE9uIDIzLzA1LzIwMjIgMjA6NTIsIFBhbG1lciBEYWJiZWx0IHdyb3RlOg0KPj4+PiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4gT24gTW9uLCAyMyBN
YXkgMjAyMiAwNDo0Mjo1MyBQRFQgKC0wNzAwKSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+Pj4+PiBPbiAwNS8wNS8yMDIyIDExOjU1LCBDb25vciBEb29sZXkgd3JvdGU6DQo+
Pj4+Pj4gSGFyZHdhcmUgcmFuZG9tLCBQQ0kgYW5kIGNsb2NrIGRyaXZlcnMgZm9yIHRoZSBQb2xh
ckZpcmUgU29DIGhhdmUgYmVlbg0KPj4+Pj4+IHVwc3RyZWFtZWQgYnV0IGFyZSBub3QgY292ZXJl
ZCBieSB0aGUgTUFJTlRBSU5FUlMgZW50cnksIHNvIGFkZCB0aGVtLg0KPj4+Pj4+IERhaXJlIGlz
IHRoZSBhdXRob3Igb2YgdGhlIGNsb2NrICYgUENJIGRyaXZlcnMsIHNvIGFkZCBoaW0gYXMgYQ0K
Pj4+Pj4+IG1haW50YWluZXIgaW4gcGxhY2Ugb2YgTGV3aXMuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4+
Pj4NCj4+Pj4+IEhleSBQYWxtZXIsDQo+Pj4+PiBJIGtub3cgeW91cmUgYnVzeSBldGMgYnV0IGp1
c3QgYSByZW1pbmRlciA6KQ0KPj4+Pg0KPj4+PiBTb3JyeSwgSSBkaWRuJ3QgcmVhbGl6ZSB0aGlz
IHdhcyBhaW1lZCBhdCB0aGUgUklTQy1WIHRyZWUu77+977+9IEknbSBmaW5lDQo+Pj4+IHRha2lu
ZyBpdCwgYnV0IGl0IHNlZW1zIGxpa2UgdGhlc2Ugc2hvdWxkIGhhdmUgZ29uZSBpbiBhbG9uZyB3
aXRoIHRoZQ0KPj4+PiBkcml2ZXJzLg0KPj4+DQo+Pj4gWWVhaCwgc29ycnkuIEluIGhpbmRzaWdo
dCBpdCBzaG91bGQndmUgYnV0IHRoYXQgc2hpcCBoYXMgc2FpbGVkLiBJIHNlbnQNCj4+PiB0aGUg
cm5nIGJ1bmRsZWQgdGhpcyB3YXkgYi9jIEkgZGlkbid0IHdhbnQgdG8gZW5kIHVwIGEgY29uZmxp
Y3QuDQo+Pj4gT2J2LiB0aGVyZSdzIG5vdCBhIHJ1c2ggc28gSSBjYW4gYWx3YXlzIHNwbGl0IGl0
IGJhY2sgb3V0IGlmIG5lZWRzIGJlLg0KPj4NCj4+IEknbSBhZGRpbmcgYSBidW5jaCBvZiBzdWJz
eXN0ZW0gbWFpbnRhaW5lcnMganVzdCB0byBjaGVjayBhZ2Fpbi4gIEkgDQo+PiBkb24ndCBoYXZl
IGFueSBwcm9ibGVtIHdpdGggaXQsIGp1c3Qgbm90IHJlYWxseSBhIFJJU0MtViB0aGluZyBhbmQg
ZG9uJ3QgDQo+PiB3YW4gdG8gbWFrZSBhIG1lc3MuICBJJ3ZlIHN0YXNoZWQgaXQgb3ZlciBhdCBw
YWxtZXIvcGNzb2MtbWFpbnRhaW5lcnMgDQo+PiBmb3Igbm93Lg0KPj4NCj4gDQo+IEFja2VkLWJ5
OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IA0KDQorQ0MgSGVyYmVydCBmb3Ig
dGhlIGxhc3Qgb25lLg0KDQpUaGlzIGlzIGxpa2VseSB0byBnZW5lcmF0ZSBhIGNvbmZsaWN0IGlu
IC1uZXh0IHRob3VnaCBiL2MNCm15IHNwaSBkcml2ZXIgdGhhdCB3YXMgYXBwbGllZCBmb3IgNS4y
MCBhbHNvIHRvdWNoZXMgdGhpcw0KZW50cnkuIEl0IHJlYWxseSBwaXNzZXMgbWUgb2ZmIHRoYXQg
SSBhbGxvd2VkIHRoaXMgdG8NCmhhcHBlbiAmIGJlY29tZSBhIGJ1cmRlbi4uDQoNCldoYXQgYW0g
SSAibWVhbnQiIHRvIGRvIGhlcmU/IERvIHRoZSBtZXJnZXMgbXlzZWxmICYgcHJvdmlkZQ0KdGhl
IGNvbmZsaWN0IHJlc29sdXRpb24/IE9yIGZvciBzb21ldGhpbmcgYXMgb2J2aW91cyBhcyB0aGlz
DQppcyBpdCBlbm91Z2ggdG8gbm90aWZ5IHRoYXQgdGhlcmUgd2lsbCBiZSBvbmU/DQoNClNvcnJ5
LA0KQ29ub3IuDQo=

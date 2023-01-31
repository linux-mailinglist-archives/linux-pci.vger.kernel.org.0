Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE6683342
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjAaRDK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjAaRDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 12:03:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE016AE4;
        Tue, 31 Jan 2023 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675184586; x=1706720586;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ZeknbBRE1uqcV/o/NXaXBgJXoK1/NLCGPzOcu79HunE=;
  b=Js4Jc0fMUrbZZgAj0W0cXPeM2GJ3YwpEntqJ3v233ACScgT4+d2n+LxZ
   mgcNoKfq/MDTUSb4jzVPq3CG6/dvMjrYwQABqutk1r6rwbucwL4JvakMc
   o2J8WxzyGEqLPEzKZaJXkPH648SA3gihbrtZ/0kWsAHOjn+/BNxaUEFo8
   4SBxCfjE5ipcxe9gmQB3eSSxeirBSPihhioH8E4IVJNvyVbvMzhhYGDPn
   SbV40XqEA5uvdKbg+o8VTL3D2q3pyhPRM6Rk5snknjvFLPUG+ci0p74EV
   k5WqFchNffvGtwZcXzs/13HkiXRRZgu9uT8WmiJEpTu1JOm2RWXsm4MUh
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669100400"; 
   d="scan'208";a="198767962"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2023 10:03:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 10:03:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 10:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuDiQc9oKGI2jZHcBPl4j3GZdgDnReWasV+DCq2elTInf1EKy/hm2BhEnUa9P18qpKRFq12bmYAPhotKbPe+lHAFgEAyBdHCfqdszRBsLw8zxVUORoc3oyC/tl6jhxA1hTC/8UjuMe71Ll//j54nXjkVux+CwFUexw6eW8a2ZyfOZJNaMgGU+y+s3Mf1CQKG7xDbdPOJuekjPeKzrcSR2zTfV6cu0El+2UiXxzefu6V8/GS4YVnX4sAo7NkmXCZI0H8yoEH53w4/W/FdrZ6mzpOFbTlH0p85s5dB/PFwCD82yjAgvGa7Ap/bbOBlO2OC0+0SOwtJh7+n96yue3CwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeknbBRE1uqcV/o/NXaXBgJXoK1/NLCGPzOcu79HunE=;
 b=kb0lkvo+RqrZpGLzoJbkVBuYeLgxesBxJ/u8eIlKEHPiJE7ZLLq8x0UzjIHq6pnVIgEpGTXZHW/+WHN5zI4ejDRXpSkLpFJutWoQ1ASdzq9bsxmkjMYgigAedpT8ImRORQE2NOxML3O/cutjJozndGVrZOrxJNQG2iwklTdSGoIBNotofSGG75BNXeuL8nU4hPlZpq+OsCEjHPnecjjP/oScPB9pkJFyrd1X4Rig/WYoxRRJr9VwDIj9KQUQ+AN4hp9uC7kDc191XdmOSTptEgee7UgQA2EhDZh9+MLol9N1E8b8uB/LA22iO67WfXpoXOSsF+EY6zdr3gkrlqAXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeknbBRE1uqcV/o/NXaXBgJXoK1/NLCGPzOcu79HunE=;
 b=vuSt04GxY8F/pMhrRC3kANhw6nmXtUcXbi/2a54yxNpibK7ulsrOsF0s8eeCu9FOo2L5Ambe+9v/PVynXkif5n4rJ94b6U3R9vkQoDUQnN8V/RGLOC5pbETxr18L5Wn/F9RxKHw4kt79x2G60Pv6iXUIoOs74uylY9nDfcj6RpA=
Received: from DM6PR11MB3258.namprd11.prod.outlook.com (2603:10b6:5:e::27) by
 PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Tue, 31 Jan 2023 17:03:01 +0000
Received: from DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::9605:fd18:6756:575a]) by DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::9605:fd18:6756:575a%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 17:03:00 +0000
From:   <Daire.McNamara@microchip.com>
To:     <linux-riscv@lists.infradead.org>, <kw@linux.com>,
        <Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <lpieralisi@kernel.org>,
        <linux-pci@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 00/11] PCI: microchip: Partition address translations
Thread-Topic: [PATCH v3 00/11] PCI: microchip: Partition address translations
Thread-Index: AQHZJbu1aZB9JEnRQE6u0tpWWxK2YK644EaA
Date:   Tue, 31 Jan 2023 17:03:00 +0000
Message-ID: <d5a5ba3b01953c9db435f2371adee6e2b61d26dd.camel@microchip.com>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
In-Reply-To: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3258:EE_|PH0PR11MB4792:EE_
x-ms-office365-filtering-correlation-id: 64aae0df-0278-4d2f-28ed-08db03ad025e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcSa8EUnENvFQqcP1ZRI3RHu1s9aAm4O0tJC2ndlvcKPqMo95wqThYTTm3R5uJcvjRra1dPXiwI2MQ0qvV+Zv6q7u55suMd9hyL04x+sCuSp5R45WkHBFLruVsJPWBk8/8w/mO9vRMpL3B3RohruwojSKbsDKZ16GZM9i7NK+8azLis56nS7smtp2MQfjD4wTThUxWmK55ANy6YBKvL26qWU9d0gesjJtniJNlsDqlY5K+nqk4yYMkTzqql78qSTFdcEzWgB7E25eLxy1OhtGbTm0ScjsFaiYbjCJhQ4JfjIHRo4YuyYIixl2TXGkky5w70LdvrJC+751OIDANOhutT7qATLQeDRUiq4GAqaWcNEHMEIgsoowb4O9DqAdZ17VZwmOqOisHwq9g/A6ZkbQ9KcXF5CMOq1wSwHSvhrzIMzRt0VFVjkEX+/b7XzDg35Pt0DpIWWoaSfGvp5RGQrVpV/mbr3Yt5MYttHLz0xGlSpgN9hvtumSfBaWr/0+Eb5FlZjmrQ7pxXijS+nDGIS13ZQxzFZrYIrksuKI1+O6Ipqv7xVQX/uJ/SRa+6DWHhDWMO9r05656qk71czQjX82Ij8A8MsqIAhl0QXMd596IC2iPYNK/0O/1CaXCi2Ue6zf4zk2CCQtIdt2HqyHVqu3nG58YcSDLtMmWl4eJsUPsNmkjgIjAR1IHVYWKHXU2cOZz6Nv85WX6pYSxrwRLA3ZlsXLoLIaUNVBF9NiOe9aHuYyeGadT9PmCp0NUbCu3PM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(110136005)(5660300002)(316002)(6506007)(7416002)(71200400001)(86362001)(38070700005)(921005)(41300700001)(66946007)(186003)(8676002)(26005)(6512007)(8936002)(478600001)(6486002)(966005)(64756008)(66446008)(66556008)(76116006)(66476007)(91956017)(2906002)(83380400001)(2616005)(122000001)(36756003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEIyWmtKUTM3ejdHcDVEU1AvSFNWZVoxbUN4b1hHZnJIUUtmb0ZaSXRZeWZM?=
 =?utf-8?B?bmI4UFg2T3VSVnU1QXY4Qlp0OGdhTGFTWFdvbW12cXZBYnovSzMzNGJ5cTBZ?=
 =?utf-8?B?bXNZT1ZrTEUrZ2lwY2Z1aXgrNXFJZDVyeDY2OWkxczV6VFJZdjlrR3F2ZkFH?=
 =?utf-8?B?amRad0o5RlNjRHFjdWx4ZGMraCtMbHYyeFUzZVJKZzZQQlBsZVhsYWx2Vi9U?=
 =?utf-8?B?SlRJcGNtbm40c1RrbGk3dkM5NGxyYlZjakZ1ZVpnUFR5NTZMRWttUk41cnhD?=
 =?utf-8?B?TmlOSy85K2dYV2tLNTFTTFp1VEY5aDJveW1sRUJJQkpLbW5zMHliM09ieVVK?=
 =?utf-8?B?eTVpYUtrRXovMnVsL1I4N3AySHVyU1gxTzJyQnFRUDY2ZDNteStDRXZ6Mmk1?=
 =?utf-8?B?RnA0SWZJUXJ2UVBlN1E1cUcyOVMrNGZhaGFkaDVoQmhBMUlLRVRWbkViRVBZ?=
 =?utf-8?B?WTFYL3NtbW1QWnhQcHlzSDNOeXI0WUd0aXFubGR5UDYycEh3U0pyUTBibHdr?=
 =?utf-8?B?TkkvNWZwTHVDVWVla1hjVzBaWjJ0eGo0VmdlQTY0cFcxcC8vVDYyS1N0Zm82?=
 =?utf-8?B?aHRUaFpYTWpsNkZqT1hnYjJsNHBoeHFuNEwzdFNrUGMxbTc2WStiSUpqVkxP?=
 =?utf-8?B?TngrMmU4cEkzTEpXMEJweU5oVzFWZzY4S3d2V2draEJxdXRIWmFMUmxYbFFa?=
 =?utf-8?B?TVJoaVRNQzNzZlpQUzRycllHaGxwYXlhbzEvaStCQktvRllzRXpqaDZiZ2sw?=
 =?utf-8?B?ZXk4cVNVWVQ4QlA0WHRkZDFGb1FCWkhOWWprbnhlaDRNY040K1NJSkZwbE0v?=
 =?utf-8?B?RlZxblFuaEJpalArU3hPbElKdU9GNDZGa3dnZ1JUaUUrZUlvNGIxMTVwRGhy?=
 =?utf-8?B?b090eW0xT1FwM3ZhcjFDYW1OU0ltQnVLcFBMVVhxbjB0eVJKbmsyTng0eThX?=
 =?utf-8?B?eFQxYXE0UnB3NjhGVWV0NWJMbU42MDVOQ3pEbXN2QU1nYkRheFBuR2NOK0tr?=
 =?utf-8?B?QXU0Yk9SRk5taVpmTUFhYWN2RWYwYW84V1dZdVkwWWMvN25UNU9JeWs2YmxM?=
 =?utf-8?B?N3JuaEZScnJPaU1aWjBHUE0rTkZ5YzZURE5CcFpZakx5dXFIVGtndDZPUU84?=
 =?utf-8?B?RTVYb0R5d2E5cmQrcGU2RCt0SWlGRWZSeUhTWktYWlNOMlYvRmduNGNnWHBq?=
 =?utf-8?B?RFJLc2VaZ3lhNjVXaVBXMFl4RFVTelJCSlhObzY4SEJBcHN4ekZhMzhOZHFt?=
 =?utf-8?B?WnMydE9TNG54ektnZFh6QlFNRkZUaEFvMFNoTnowb09JOW1YMm9ZWUR4Y2tz?=
 =?utf-8?B?a1BCWFVwc1R0SlZDeC9FTUlZaDFURjFUUHdlR0pPOFhMYzlScjlZNDI1L0NS?=
 =?utf-8?B?UVJUcFJYdWdpUE04WVp2dkR4em5VTHJuS2VHK09pTUdTV1JqeFR2bzBQVDI1?=
 =?utf-8?B?eVZWWFdzY1VuMnovb3EzcjFTb3dyYWlyRkY2QzdoWnpqTW9PdDVkNk1rN2JQ?=
 =?utf-8?B?eGFEV0RNMzJtZlU5VWt1TXI1d1VQdlZxak1OWW9kM0V0aFMydXBkUnpsR2dM?=
 =?utf-8?B?L3VsaExRRi9WVnNicTYxOFNLcFppT09tbmY1TWFxNkNiKzBHdXk1QzkwU2hK?=
 =?utf-8?B?NzVzQ09sYmJtT3JEZGdmamNEY3BaMytLdmhoWHM5UFZCc0pJekdWSTVJV3Zt?=
 =?utf-8?B?WmZ0ZFhXUFZvQ0hiQ21sWmw4ODRxbElGZU5vbzRSZ1h0a3BGNHV5RUx3NWNK?=
 =?utf-8?B?R3c0WFZ5OSszWFVLQm1CczhiODZyWnZwdnlpYk53Ni9YdzQ1ZUI0WXVOejBq?=
 =?utf-8?B?L1RzbGNiVjl2dXczZFlwMXBUS21KZ0twYnBHTHNIcjkrSlF2Z1RRbFNCcGhx?=
 =?utf-8?B?ZE40VnZQS0hWVWUzbFhQVWRoZk4zeThkZUdDZUNwdjBwRmwyby82TXpGd0ZK?=
 =?utf-8?B?dzJ2REJhVWowTVd1WnlrRCsyUmtCRzZVMGs0M1JtZWZRbkJkalpCbTFuL2No?=
 =?utf-8?B?OXdCalhiU1hHWmNQQ3JZei9BcVlnMWJhY01zQSt3ZWZNOW84WnhRNGx2alVO?=
 =?utf-8?B?RzZNczhoaHZ4cjBqUGhFOExUdkt2Nk9CMUlvbDFtVCtoRTFsZERVem5CSW02?=
 =?utf-8?B?bUNBb2VTdXRxVnpuaE5wK2FLSkR6YVlIMTFWMWZJTmR6bDJHWmlqVG5WZDFn?=
 =?utf-8?Q?5OW0aEIDWifO3Yt9LZDBVmM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8D0737C2A1884EB0CE72889C1713EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64aae0df-0278-4d2f-28ed-08db03ad025e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:03:00.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RCh0BeSy2k1OeUwdc2gFKrxV7Zi0U/pftmtqIiEN4vUSZ+q3wZff6d6/WSBZ5xrdKkfuW53oSZoOWnQVaL893kiILujH4xaeI3zDupGtnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgYWxsLA0KDQpKdXN0IHRvdWNoaW5nIGJhc2UgaGVyZS4gIENhbiBJIHRha2UgaXQgdGhhdCB0
aGluZ3MgYXJlIGluLWhhbmQsIGFuZA0KdGhpcyBwYXRjaHNldCBpcyBtb3ZpbmcgaW50byB0aGUg
a2VybmVsIG9yIGlzIHRoZXJlIHNvbWV0aGluZyBJIG5lZWQgdG8NCmRvIGF0IG15IGVuZD8NCg0K
YmVzdCByZWdhcmRzDQpkYWlyZQ0KDQpPbiBXZWQsIDIwMjMtMDEtMTEgYXQgMTI6NTMgKzAwMDAs
IGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IEZyb206IERhaXJlIE1jTmFt
YXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2
MjoNCj4gLSBSZXBsYWNlZCBHRU5NQVNLKDYzLDApIHdpdGggR0VOTUFTS19VTEwoNjMsMCkgdG8g
cmVtb3ZlIHdhcm5pbmcNCj4gLSBBZGRlZCBwYXRjaCB0byBhdm9pZCB3YXJuaW5nIG9uIGNhc3Qg
b2YgYXJndW1lbnQgdG8NCj4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkNCj4gLSBBZGRlZCBw
YXRjaCB0byBlbmFibGUgYnVpbGRpbmcgZHJpdmVyIGFzIGEgbW9kdWxlDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHYxOg0KPiAtIFJlbW92ZWQgdW51c2VkIHZhcmlhYmxlcyBjYXVzaW5nIGNvbXBpbGUg
d2FybmluZ3MNCj4gLSBSZW1vdmVkIGluY29ycmVjdCBTaWduZWQtb2ZmLWJ5OiB0YWdzDQo+IC0g
Q2FwaXRhbGlzZWQgbXNpIGFuZCBtc2kteA0KPiAtIENhcGl0YWxpc2VkIEZJQyBhbmQgcmVzcGVs
bGVkIGJ1c3NlcyB0byBidXNlcw0KPiAtIENhcGl0YWxpc2VkIGFsbCBjb21tZW50cw0KPiAtIFJl
bmFtZWQgZmFicmljIGludGVyIGNvbm5lY3QgdG8gRmFicmljIEludGVyZmFjZSBDb250cm9sbGVy
IGFzIHBlcg0KPiBQb2xhckZpcmUgU29DIFRSTQ0KPiANCj4gTWljcm9jaGlwIFBvbGFyRmlyZSBT
b0MgaXMgYSA2NC1iaXQgZGV2aWNlIGFuZCBoYXMgRERSIHN0YXJ0aW5nIGF0DQo+IDB4ODAwMDAw
MDAgYW5kIDB4MTAwMDAwMDAwMC4gSXRzIFBDSWUgcm9vdHBvcnQgaXMgY29ubmVjdGVkIHRvIHRo
ZQ0KPiBDUFUNCj4gQ29yZXBsZXggdmlhIGFuIEZQR0EgZmFicmljLiBUaGUgQVhJIGNvbm5lY3Rp
b25zIGJldHdlZW4gdGhlIENvcmVwbGV4DQo+IGFuZA0KPiB0aGUgZmFicmljIGFyZSA2NC1iaXQg
YW5kIHRoZSBBWEkgY29ubmVjdGlvbnMgYmV0d2VlbiB0aGUgZmFicmljIGFuZA0KPiB0aGUNCj4g
cm9vdHBvcnQgYXJlIDMyLWJpdC4gIEZvciB0aGUgQ1BVIENvcmVQbGV4IHRvIGFjdCBhcyBhbiBB
WEktTWFzdGVyIHRvDQo+IHRoZQ0KPiBQQ0llIGRldmljZXMgYW5kIGZvciB0aGUgUENJZSBkZXZp
Y2VzIHRvIGFjdCBhcyBidXMgbWFzdGVycyB0byBERFIgYXQNCj4gdGhlc2UNCj4gYmFzZSBhZGRy
ZXNzZXMsIHRoZSBmYWJyaWMgY2FuIGJlIGN1c3RvbWlzZWQgdG8gYWRkL3JlbW92ZSBvZmZzZXRz
DQo+IGZvciBiaXRzDQo+IDM4LTMyIGluIGVhY2ggZGlyZWN0aW9uLiBUaGVzZSBvZmZzZXRzLCBp
ZiBwcmVzZW50LCB2YXJ5IHdpdGggZWFjaA0KPiBjdXN0b21lcidzIGRlc2lnbi4NCj4gDQo+IFRv
IHN1cHBvcnQgdGhpcyB2YXJpZXR5LCB0aGUgcm9vdHBvcnQgZHJpdmVyIG11c3Qga25vdyBob3cg
bXVjaA0KPiBhZGRyZXNzDQo+IHRyYW5zbGF0aW9uIChib3RoIGluYm91bmQgYW5kIG91dGJvdW5k
KSBpcyBwZXJmb3JtZWQgYnkgYSBwYXJ0aWN1bGFyDQo+IGN1c3RvbWVyIGRlc2lnbiBhbmQgaG93
IG11Y2ggYWRkcmVzcyB0cmFuc2xhdGlvbiBtdXN0IGJlIHByb3ZpZGVkIGJ5DQo+IHRoZQ0KPiBy
b290cG9ydC4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgY29udGFpbnMgYSBwYXJlbnQvY2hpbGQgZG1h
LXJhbmdlcyBzY2hlbWUgc3VnZ2VzdGVkIGJ5DQo+IFJvYg0KPiBIZXJyaW5nLiBJdCBjcmVhdGVz
IGFuIEZQR0EgUENJZSBwYXJlbnQgYnVzIHdoaWNoIHdyYXBzIHRoZSBQQ0llDQo+IHJvb3Rwb3J0
DQo+IGFuZCBpbXBsZW1lbnRzIGEgcGFyc2luZyBzY2hlbWUgd2hlcmUgdGhlIHJvb3QgcG9ydCBp
ZGVudGlmaWVzIHdoYXQNCj4gYWRkcmVzcw0KPiB0cmFuc2xhdGlvbnMgYXJlIHBlcmZvcm1lZCBi
eSB0aGUgRlBHQSBmYWJyaWMgcGFyZW50IGJ1cywgYW5kIHdoYXQNCj4gYWRkcmVzcyB0cmFuc2xh
dGlvbnMgbXVzdCBiZSBkb25lIGJ5IHRoZSByb290cG9ydCBpdHNlbGYuDQo+IA0KPiBTZWUgDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIyMDkwMjE0MjIwMi4yNDM3NjU4
LTEtZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbS8NCj4gZm9yIHRoZSByZWxldmFudCBwcmV2
aW91cyBwYXRjaCBzdWJtaXNzaW9uIGRpc2N1c3Npb24uDQo+IA0KPiBJdCBhbHNvIHJlLXBhcnRp
dGlvbnMgdGhlIHByb2JlKCkgYW5kIGluaXQoKSBmdW5jdGlvbnMgYXMgc3VnZ2VzdGVkDQo+IGJ5
DQo+IEJqb3JuIEhlbGdhYXMgdG8gbWFrZSB0aGVtIG1vcmUgbWFpbnRhaW5hYmxlIGFzIHRoZSBp
bml0KCkgZnVuY3Rpb24NCj4gaGFkDQo+IGJlY29tZSB0b28gbGFyZ2UuDQo+IA0KPiBJdCBhbHNv
IGNvbnRhaW5zIHNvbWUgbWlub3IgZml4ZXMgYW5kIGNsZWFuLXVwcyB0aGF0IGFyZSBwcmUtDQo+
IHJlcXVpc2l0ZXM6DQo+IC0gdG8gYWxpZ24gcmVnaXN0ZXIsIG9mZnNldCwgYW5kIG1hc2sgbmFt
ZXMgd2l0aCB0aGUgaGFyZHdhcmUNCj4gZG9jdW1lbnRhdGlvbg0KPiAgIGFuZCB0byBoYXZlIHRo
ZSByZWdpc3RlciBkZWZpbml0aW9ucyBhcHBlYXIgaW4gdGhlIHNhbWUgb3JkZXIgYXMgaW4NCj4g
dGhlDQo+ICAgaGFyZHdhcmUgZG9jdW1lbnRhdGlvbjsNCj4gLSB0byBoYXJ2ZXN0IHRoZSBNU0kg
aW5mb3JtYXRpb24gZnJvbSB0aGUgaGFyZHdhcmUgY29uZmlndXJhdGlvbg0KPiByZWdpc3Rlcg0K
PiAgIGFzIHRoZXNlIGRlcGVuZCBvbiB0aGUgRlBHQSBmYWJyaWMgZGVzaWduIGFuZCBjYW4gdmFy
eSB3aXRoDQo+IGRpZmZlcmVudA0KPiAgIGN1c3RvbWVyIGRlc2lnbnM7DQo+IC0gdG8gY2xlYW4g
dXAgaW50ZXJydXB0IGluaXRpYWxpc2F0aW9uIHRvIG1ha2UgaXQgbW9yZSBtYWludGFpbmFibGU7
DQo+IC0gdG8gZml4IFNFQyBhbmQgREVEIGludGVycnVwdCBoYW5kbGluZy4NCj4gDQo+IEkgZXhw
ZWN0IENvbm9yIHdpbGwgdGFrZSB0aGUgZHRzIHBhdGNoIHZpYSB0aGUgc29jIHRyZWUgb25jZSB0
aGUgUENJZQ0KPiBwYXJ0cw0KPiBvZiB0aGUgc2VyaWVzIGFyZSBhY2NlcHRlZC4NCj4gDQo+IENv
bm9yIERvb2xleSAoMSk6DQo+ICAgcmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgcGFyZW50IHJh
bmdlcyBhbmQgZG1hLXJhbmdlcyBmb3IgSUtSRA0KPiAgICAgdjIwMjIuMDkNCj4gDQo+IERhaXJl
IE1jTmFtYXJhICgxMCk6DQo+ICAgUENJOiBtaWNyb2NoaXA6IENvcnJlY3QgdGhlIERFRCBhbmQg
U0VDIGludGVycnVwdCBiaXQgb2Zmc2V0cw0KPiAgIFBDSTogbWljcm9jaGlwOiBSZW1vdmUgY2Fz
dCB3YXJuaW5nIGZvciBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKQ0KPiBhcmcNCj4gICBQQ0k6
IG1pY3JvY2hpcDogZW5hYmxlIGJ1aWxkaW5nIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlDQo+ICAg
UENJOiBtaWNyb2NoaXA6IEFsaWduIHJlZ2lzdGVyLCBvZmZzZXQsIGFuZCBtYXNrIG5hbWVzIHdp
dGggaHcgZG9jcw0KPiAgIFBDSTogbWljcm9jaGlwOiBFbmFibGUgZXZlbnQgaGFuZGxlcnMgdG8g
YWNjZXNzIGJyaWRnZSBhbmQgY3RybA0KPiBwdHJzDQo+ICAgUENJOiBtaWNyb2NoaXA6IENsZWFu
IHVwIGluaXRpYWxpc2F0aW9uIG9mIGludGVycnVwdHMNCj4gICBQQ0k6IG1pY3JvY2hpcDogR2F0
aGVyIE1TSSBpbmZvcm1hdGlvbiBmcm9tIGhhcmR3YXJlIGNvbmZpZw0KPiByZWdpc3RlcnMNCj4g
ICBQQ0k6IG1pY3JvY2hpcDogUmUtcGFydGl0aW9uIGNvZGUgYmV0d2VlbiBwcm9iZSgpIGFuZCBp
bml0KCkNCj4gICBQQ0k6IG1pY3JvY2hpcDogUGFydGl0aW9uIG91dGJvdW5kIGFkZHJlc3MgdHJh
bnNsYXRpb24NCj4gICBQQ0k6IG1pY3JvY2hpcDogUGFydGl0aW9uIGluYm91bmQgYWRkcmVzcyB0
cmFuc2xhdGlvbg0KPiANCj4gIC4uLi9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC1mYWJy
aWMuZHRzaSB8ICA2MiArLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAg
ICAgICAgICAgIHwgICAyICstDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9j
aGlwLWhvc3QuYyAgfCA2ODggKysrKysrKysrKysrKy0tLQ0KPiAtLQ0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCA1MzMgaW5zZXJ0aW9ucygrKSwgMjE5IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2Ut
Y29tbWl0OiAzYzFmMjQxMDlkZmM0ZmIxYTM3MzBlZDIzN2U1MDE4M2M2YmIyNmIzDQo=

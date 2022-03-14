Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8424A4D79E7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 05:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiCNEdR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 00:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNEdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 00:33:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E13E5F2;
        Sun, 13 Mar 2022 21:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5fhKoHRtg10sDHE4akpoGpMZucFtgXmarY9MNyWbh05rP6OaHow17NEsUt9eSv7zo2Vhi8fRE4K3hJInOoREMNQUTpyUQI4xfHchCSvYeR8v+zkZ/dwlRBpTWhhOQhh9k14e0LbW7dfxSIFBps03We0wUW6D6xfag/Gm4hieZFfqbiHTWA3u0z7spghKMMaZOOJ+Ukjpx9FKf08CJEgGOY6kuZsUsZ0yU6BDrt9VGnr7uxNjCTDetQXrJ9yPClFwE075bhuJN/PhLT2lWUWBGLjvHmn3XgHdGi2BLOQCItquzYJfTUWEJO24e7lXc/TJMpd1I4JQFUYyYjFPrQx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO6ZrwEALgy7H9BdedBTCbI4vJ96f/OsN2KJt+asE5k=;
 b=TKN0C7K/CwJJtu6jas7NfY+tz0MJnK/uREPTyWVhJQvdeTsUa1BZ4BkJvpAcX65nbJB7gdO6WNALT4LlGIw5MPHujIil4Bl6ZihMvxW6wXSI/IUhXXYkbBDfJMyJx+G5OkTK3buxpn+UKhs43IUGZfiAxGpzOm+tJWy7YLE0pBOAQhgnK4h3xfPh0Iwm1KpJttVsCt6DiHXOqhr+BObMoHNiik94SZrNOox7FhYID+pRWiv5ByrFVcUM5UqlFUB4EB10ikf5xyC86S68pQLtKDuFp8DAys+SACdnahvg5jnD6p+KTTN5ksJrkMo6JzweU5YiSnzswMDLPaKXItgVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO6ZrwEALgy7H9BdedBTCbI4vJ96f/OsN2KJt+asE5k=;
 b=theu5AZSzA4NOJr5tZ/pYJ3aodl9GSAxmIEIb5XeGLSdxDugX5mDVSZL8fe3pSXBr2C7RcMlu+Gj3Wn6Rfr0peB5hJoGX0tb2jRMWeOGu+pd8J/J6aUO/aVnCjCUQdxhliKWJEkZceCrGN9ea6LbrL2tCwe1iPNL3S5oAed0ygY=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 14 Mar
 2022 04:32:05 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 04:32:05 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYM61KqaeivuUaoUKh1Qfh1rl+KKy4nQ+AgAW0NaA=
Date:   Mon, 14 Mar 2022 04:32:05 +0000
Message-ID: <BY5PR02MB69476C01D22DA6794C447171A50F9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
 <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
 <6f34f80e-da06-337d-167e-2410309e0f4d@canonical.com>
In-Reply-To: <6f34f80e-da06-337d-167e-2410309e0f4d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a7a8bc-e578-469f-fbfe-08da057397d3
x-ms-traffictypediagnostic: SJ0PR02MB8595:EE_
x-microsoft-antispam-prvs: <SJ0PR02MB8595074621BEE456DBC13647A50F9@SJ0PR02MB8595.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUFHsct9anfSn5c5/Mw3nv65UcPCLV/meROW8tdYaZsgRTqOAzftoi7IGuoDj/Ngc9KDa+qlV9I0f73fsKAKrlE8908HIP8/KLx8D8Pj0UnWT2XTvIgnvQ8pqcZwnNlfP1tyPGVM7cLQqxF5Ko2N8q4P2iFqC/BE+uk6ThbJRVdDVl0XRaWsnulPkrPBEFcgNqERV4gLzaqHITn9z9G700c5vVEVxv+BsS+1nGchuzIX4blHQnKOcZPkmBkZStMpBSxCY1JMEHCbO6hjXpr5ekEPVh17F6oDjM/nfajSiIn9MhcCYq/2rqh1T0cRt41wznEPjbElue5HC5RtR7C46t9RGngEJzK4V6mizZIVWWQF94jQ1qQYYUYSYJWVQrvj7afxjrVYgVE3gHPywdTfcGM9rOj+8DsKwgW8bxPphRu9L3L9TyaEsV+q5grxX941qAHBDeQq8ceFhAr7JwTsP/eEFEJZDBXdqaKYfpH4iRHEnMldrP109qTXih0RR2KUS/wanDHXe1Qesa/CYIQFu8RiLON4nDpQFYBVdde2GdU9+DkL1skgPH+EIoC6ckgGkxYUDgNxhqeE0Efx0ypbMBEJHHathHKtqF0iSyU1nYDiHycj7SpQ72Ij1GDRYti606EhUrgYyPxjyZBqBKaqCzU3Mtoe9SzcmuvwUn0C+LdrDokkoX7J0gNi/x3E1OSuGv4XPDI5AJUM1rJNxSKAT+iFHuQ9cwwR3b+tt/yh6RT7TfG7l4104J7S3HZ+3119Mo+vWxE+X+cJEFNe0MmaqEgPGmz1gpJzkC7Xtc1UTwQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(38100700002)(66946007)(66476007)(64756008)(5660300002)(4326008)(8676002)(66556008)(66446008)(7696005)(33656002)(6506007)(54906003)(110136005)(316002)(55016003)(2906002)(508600001)(9686003)(76116006)(26005)(122000001)(53546011)(966005)(71200400001)(86362001)(83380400001)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWJFcHlCK2M1QzFkTkxxZDNtN2NFSEVOZzdXdkhYNnhNaEZFanY2VHhMcEJQ?=
 =?utf-8?B?OGNkU1lxMjhzb0ttaTVjVjNTZEV4UkZnVnRKN1MwSGN1bi9pTkpqU05ObDdo?=
 =?utf-8?B?WFpXRW1BTlZ4eTlNMjR5K0JaTFZCS3U0VkpnTHFoSHFnb09WaVJ3QUorcEhK?=
 =?utf-8?B?ZkNzeVF6TnVaSkFEc1YxL2UwbnNyNm96Q0d5a0xuVm82em1GSndyUXNqeGVq?=
 =?utf-8?B?RVlJVloxL3RJanduc3NhV3ZKWUhMSDBMS3lWYkJuVHVHKzdCRHZYV3RsRTdE?=
 =?utf-8?B?Ky9ZNCtDeVk0a3piY2pQYUhyaUlUbk1LRXlyaEhqamNROWhvRTk4eForT2E4?=
 =?utf-8?B?ZjcrUjJsNDhVNXEzYUtuQ1J3MXFSVGl2N0pWRE1JckloejlydWxyMDcvU3hY?=
 =?utf-8?B?d1E1VVlVNnVlUGttaGdqY1ZrWmUvOXAxajZTbTNHOG5wMTFuRDg1Z1RxQURy?=
 =?utf-8?B?am11RlFNMzRNUEVQL0crSWVBMzkrNG5zaXFOQko5R2NvekhuandIUkptU2sz?=
 =?utf-8?B?RWVabXJnK00yYloxTzBUcy9nQzhxcHNHelNENmVOcExaQ3R1T2o5NWJzRDZU?=
 =?utf-8?B?SGk4VWo0NE5ra3BHQ09MRkpoK2lZdFJWMVNlbTl4U1V5M0g3YzRTNUYxREFY?=
 =?utf-8?B?NHk4UVdyeG42b0dLdEgzeU4vWnQxZ2h6Zm5NSDRPK2VsVFM1aXhmeTZPVVVO?=
 =?utf-8?B?azhqakpVL0MwcEdhcmcwanRLNjVWV2NDTFVXM0o5S2NleUZXeXlDQ2ZWd1Rs?=
 =?utf-8?B?UVVYRTJ0MUlWSjI3K2VZODh5Y0ZsbU5hc1NkME9VbGtIc0lsS3R3VGc3MUpk?=
 =?utf-8?B?cTJZalFDVC82YlBES09vOGh1ZlRzQVpvSjVidXpBRUd2SWU4WmFwUzVMK2FF?=
 =?utf-8?B?T3RPblpiOTludHNSYTFudXk3eS9XMHlTckU2S1hocWN4YkpTRFZsTkg2VUp5?=
 =?utf-8?B?U1NaUzN6dTN1ejBtb1dLeTNVWHJTRUJ4Z2djL05Jejk1d1QzNzRXVkFycVFz?=
 =?utf-8?B?Q2hKWUFFb1dzTUhVUVpBeks2S1hTUnY5V0FUWnoxb09SV3FDcHF6eElWbVRJ?=
 =?utf-8?B?aUhLNWJFcXdrUTRXcVhGNkh0cW8wWTU4dEtscm5HMHhsRnpCM3BOUDBjcDBv?=
 =?utf-8?B?cS9Gc1phdXZaa3cxanh2MHBXVUhsWW5LR1dqKzJMWWxONDdKQmJuQXN4WWdU?=
 =?utf-8?B?bFhiWUk1aS9oUUo5RDlSUEE0K0tIcEJpZFg3bzFzZmtoTnFjY2k5OGMwN1U0?=
 =?utf-8?B?NjBNeit4QjVHNWZKK0tnSFdMMFY4c3NpWlczYW5sdjNqdGkybUtKREN1cXhN?=
 =?utf-8?B?L20zd1dzTjdVdnRWd041aXRZaHBMa1c5TXNVbVUxc3lyOGtLQzZWNU5uZ0dW?=
 =?utf-8?B?dC8yK3N2ZnZTb245ZnZNU0M2QkpZVVpFMVM1UDJvWloySlpEZHVXekMrVHU5?=
 =?utf-8?B?RzdNSlAvR25rZkhuVFQvbFFZdDhYbjZINy9CbmowbEhiZUJITkx5TTNwMWVq?=
 =?utf-8?B?QkRLMGtvcENnQW9DblIyRUxkQWhyZzBkOElDUW1vZEFScm5udzJVbGdHUDAw?=
 =?utf-8?B?dlNReFpZQ2tuQllyYnVyZDNObTdkWTE4NWJUaGd3Q21GZUp5dGlJNUVoR3V3?=
 =?utf-8?B?M09qWGtuekxSQmdrQWxGR2YyYml5aVZtdnlWUU1LaTYzZzFQUVE5TmhtWHBa?=
 =?utf-8?B?aEh3ZHg5SUdKa08zTGpseEJJTCtzSkJYazRReVpocUdDMFVUMHFsdGZyQ0tz?=
 =?utf-8?B?REJSU1lITkZ4bjJPRVloRUloZk5LakdJK1JhM3hoa1VYYkFqTllLOWxDRmwv?=
 =?utf-8?B?dTQxL2xnaXVCZWdIUEQ1djZlS3cxRnFHSmF1KzJjYUI1V08yV3Qra2ZwSFhC?=
 =?utf-8?B?Yis2bEpCVXFpRXcyV2ZXaVYrbXVkRTlMd3FTZndadm1mZWlPc2owUUJMMWhm?=
 =?utf-8?B?a0RYMVhSY2tUdG9pamwwQVRnQXJWTnlHUnQ2Tmh2dkRkVklVVTU5dWZvckRK?=
 =?utf-8?B?VGpUd2dBWGViZEF2MmcrUmU1cDgrZXJsMXk0WDFMQllvaUhwZ2oxd1U2SmMy?=
 =?utf-8?B?b3N5NTNZbHZONkNrR1kycmk1VFZKSEN5b3J0V25UdkYwdUNLemRrTytSL2lh?=
 =?utf-8?B?RThaQkFCNGs2QUNKZkhkLzVIS1NtNFR1QnpNSE5VdWF0Zk5jbjVPbEZwSjhM?=
 =?utf-8?Q?YC5h28DbDvTvI0y8mtNOs8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a7a8bc-e578-469f-fbfe-08da057397d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 04:32:05.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8JQXcw1/bNqJTCztJkY8BR9Tgd/rKCRM2XikfSSgt7MV7nkS8inrhJva2Mlu/z6ZUW/SQqN/c6q8w8i382Bdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8595
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiAwOS8wMy8yMDIyIDEzOjAwLCBCaGFyYXQgS3VtYXIgR29nYWRhIHdyb3RlOg0KPiA+IFhp
bGlueCBWZXJzYWwgUHJlbWl1bSBzZXJpZXMgaGFzIENQTTUgYmxvY2sgd2hpY2ggc3VwcG9ydHMg
Um9vdCBQb3J0DQo+ID4gZnVuY3Rpb25pbmcgYXQgR2VuNSBzcGVlZC4NCj4gPg0KPiA+IEFkZCBz
dXBwb3J0IGZvciBZQU1MIHNjaGVtYXMgZG9jdW1lbnRhdGlvbiBmb3IgVmVyc2FsIENQTTUgUm9v
dCBQb3J0DQo+IGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBLdW1hciBH
b2dhZGEgPGJoYXJhdC5rdW1hci5nb2dhZGFAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4u
L2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sICAgICAgIHwgNDcgKysrKysrKysr
KysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4g
aW5kZXggMzJmNDY0MTA4NWJjLi45N2M3MjI5ZDdmOTEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVy
c2FsLWNwbS55YW1sDQo+ID4gQEAgLTE0LDE3ICsxNCwyMSBAQCBhbGxPZjoNCj4gPg0KPiA+ICBw
cm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBjb25zdDogeGxueCx2ZXJz
YWwtY3BtLWhvc3QtMS4wMA0KPiA+ICsgICAgY29udGFpbnM6DQo+ID4gKyAgICAgIGVudW06DQo+
ID4gKyAgICAgICAgLSB4bG54LHZlcnNhbC1jcG0taG9zdC0xLjAwDQo+ID4gKyAgICAgICAgLSB4
bG54LHZlcnNhbC1jcG01LWhvc3QtMS4wMA0KPiA+DQo+ID4gICAgcmVnOg0KPiA+IC0gICAgaXRl
bXM6DQo+ID4gLSAgICAgIC0gZGVzY3JpcHRpb246IENvbmZpZ3VyYXRpb24gc3BhY2UgcmVnaW9u
IGFuZCBicmlkZ2UgcmVnaXN0ZXJzLg0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gc3lz
dGVtIGxldmVsIGNvbnRyb2wgYW5kIHN0YXR1cyByZWdpc3RlcnMuDQo+ID4gKyAgICBkZXNjcmlw
dGlvbjogfA0KPiA+ICsgICAgICBTaG91bGQgY29udGFpbiBjcG1fc2xjciwgY2ZnIHJlZ2lzdGVy
cyBsb2NhdGlvbiBhbmQgbGVuZ3RoLg0KPiA+ICsgICAgICBGb3IgeGxueCx2ZXJzYWwtY3BtNS1o
b3N0LTEuMDAsIGl0IHNob3VsZCBhbHNvIGNvbnRhaW4gY3BtX2Nzci4NCj4gPiArICAgIG1pbkl0
ZW1zOiAyDQo+ID4gKyAgICBtYXhJdGVtczogMw0KPiANCj4gWW91IHJlbW92ZWQgaGVyZSBsaXN0
IG9mIGl0ZW1zLCB3aGljaCBzaG91bGQgc3RheS4gU2VlIGFsc28NCj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmkNCj4gbmRpbmdzL2V4YW1wbGUtc2NoZW1hLnlhbWwjTDkxDQo+IGhvdyB0byBkbyBpdC4NCj4g
DQo+ID4NCj4gPiAgICByZWctbmFtZXM6DQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBj
b25zdDogY2ZnDQo+ID4gLSAgICAgIC0gY29uc3Q6IGNwbV9zbGNyDQo+ID4gKyAgICBtaW5JdGVt
czogMg0KPiA+ICsgICAgbWF4SXRlbXM6IDMNCj4gDQo+IFRoZSBzYW1lLg0KPiANCj4gDQpUaGFu
a3MgS3J6eXN6dG9mLCB3aWxsIGZpeCB0aGlzIGluIG5leHQgcGF0Y2guDQo=

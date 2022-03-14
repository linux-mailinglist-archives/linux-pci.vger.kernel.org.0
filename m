Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1074D79EA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiCNEed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNEec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 00:34:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719B38DB2;
        Sun, 13 Mar 2022 21:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/vbbUVyHp93OpWgHjxOADKwSd/r2ZnIQFy5LTr/ytU3Q+tTTe0SgHKddCnhQBJqyMlnqdhVHCblkIeUwW/UvXyrzYuwhlEdFjIfevNdhv6qa7LNaagxyzWab7CHMM8NCbgHIqP0a8y60OQ4gsuPSMMoNjs2rPYDbcVmxJL0UmewLPN1QuQyB/Dx3Ezneg65JO0Y4P6efcwJB76CmGegycxSo57WhAo0Bu82D+QpvSFRZwZ3dsfDH6bMlvVoawWicGq5DVa7+swiXTncjmefbPna2GEeqbX6/BC6YxX8giyO1ibcPgb1PruFeUxrvhInvuogoduhoAR8Kg1v3rFAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98agbW+B+pEW/Kqx66/qKkw4EheGQVXlsyViteVdix0=;
 b=TiHJjquXulAE8a7tuNBHurR7NM/2cKh/PzQKrXF9DLg66EMQJnCVdQG5WZ97i9n+Ckt8Lzy2wf3+JRADtHz14WgNS2lNTz42Y7hpmfEPckW5QDg1KGALOMbrRPl9KlVtrceiww/3XycWmvRsnG8xChCIFys+3HKp5iszPAjuw1REz9yBUObAL66oYCAW+uGDcx/AfRdsVpZN//0RSEUGT94SUfFq+RaAYdpMLalKP0txwfTB3zuy3+C0nmETcOYaDwzsTiUkT9+noqJ5DoJ20fwvzMmwJARovuaRBXJe+ql2DOYGP7q4j5ufxN6D/+F5ena5fOFbZohPvGa/zZejVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98agbW+B+pEW/Kqx66/qKkw4EheGQVXlsyViteVdix0=;
 b=qfq2VndmxvTSHuqA5GHntt9miD+OTlvmTb29qy6aULvIKhQ9/zO0SgVEpIErxjee0+wKBAIOTAgbsmJnDL/629npDs96GSXjlqUWcicBIuGvd7SvAAj1flYez6Z5P8aVe10aX/3mfy50A5QdSUoeSApZpm+iagtOcFgEBvph7Ws=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by MN2PR02MB7072.namprd02.prod.outlook.com (2603:10b6:208:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 04:33:18 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 04:33:18 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYM61KqaeivuUaoUKh1Qfh1rl+KKy4/nIAgAVTO/A=
Date:   Mon, 14 Mar 2022 04:33:18 +0000
Message-ID: <BY5PR02MB694719773875D2A544EC6BD1A50F9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
 <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqL3CSERnTihfc_CKB96bbdN2xxkb78H383pMfC_bGg+Xw@mail.gmail.com>
In-Reply-To: <CAL_JsqL3CSERnTihfc_CKB96bbdN2xxkb78H383pMfC_bGg+Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13efbe49-8557-4283-629b-08da0573c348
x-ms-traffictypediagnostic: MN2PR02MB7072:EE_
x-microsoft-antispam-prvs: <MN2PR02MB70720420DB4A3F9DAFC95DF1A50F9@MN2PR02MB7072.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fp0C2a26leXVaXMQNjVLrP7+yGd9Aa34zMpsGPWy0y4M5fS2euyCkoVtgBpoFHsKo9U3Hat95YqlkuZ1Bcutf8mqShB0d/EbU51UEfU5hOvypryQLrF1FUlWwUO1YRU7SlhjNw4JLKKpttNp9uvLA8AP2IKLaxWMzQ+9pNV0zecivOe1g6yeAA/8OXjWjVbgEsVvir+A5/acR9JitTMaYa6G6YGLipZV5dl6Ejp5TItt3rDb1CHlCNtVIkYlu5lekBccFlBHPS34wmLwHj+9k2Yw8/F9xVBVpOH4uuJi5Yb6DAAQhao6POHgv6xYJb1lSt8LFm0aQsGDcwIoCCsC/f6z7rxhAsaWwDiIXxQJSOx2+YJ7EJ2Z4pZWIlMyo1tDpaEF2PGmNJ/j1QusDnPIIy6ERSs6JbKC/nlqyZE8h7hZPTVG8vOYFEbDWvU7PilJW43aMrRFjId5hJ1bu1T9oAHuV6BYrFb2MH1RYYwQlPScOvty4dmylk8VXwPYP3G1dvk98MTF/1o5XY5q9+DgRgkzBtn5z3UyuE2Cr8EiIaCfhXF28siDfJYokz8qGTsSOp7M79pChfzJkl8fotX0ga39qfJqRvNnlcfpfMH1GtM63a315U1yodJ4BKlPO+Ir52TMlB2TTUWdqPLnRmgPpMY81jxciENtmZP3ez//+/eoFN9G/LdYixzKnPP2Ag9SmXTcAHO0Ad5DICvFdxUAyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(83380400001)(6916009)(316002)(54906003)(107886003)(71200400001)(6506007)(9686003)(2906002)(7696005)(186003)(26005)(8676002)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(86362001)(52536014)(8936002)(4326008)(33656002)(38100700002)(38070700005)(508600001)(122000001)(55016003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STROcm9PbUNGekhTa2YyQkJWS0dxRHVPN1JxOGZhZ3JIc3dSeXk0ekNCREp6?=
 =?utf-8?B?VkFvL2poVnFEWGtwMVJRTStkeVZUL1BKTStQZDR3U2dhVlNvUEVBN29yZWNU?=
 =?utf-8?B?Qlp3VjlvT1ZHY29LMVA3Ym9Td0dHTHlNTUZQUHQzZTRTWEdBOGl4a1BsTzV5?=
 =?utf-8?B?Z0lwMjJBMzEzN2RSS3RZR2UwdEVoTzE0ckhJdElWYkhobVphejJOcDlOd1lx?=
 =?utf-8?B?ZlRUbE50ODNlTkpla2RKc1diWjNCSVVtRDhCRGgyUHpZN3NXc2p1c212d3lK?=
 =?utf-8?B?Ujhwcjdxd2ZyNG1vL2NzdkJTQjdPU2NVeEVSckFRTzRMN3JKWVZ1ZXpKRGVZ?=
 =?utf-8?B?WDlNQnZIYk16SjVyUGl1Z0cvTXFRR0ZlS01YRHY0TEphOThRV011VlFGMEU3?=
 =?utf-8?B?RjlvUVo4cjlKcVo2VXpISGd6T3Nhd0pFWjJrUzltZ3ZIaG9FZDJxdGRYdXJT?=
 =?utf-8?B?WXVISC9vOFl1cVVLSlo5REdJNkhydmdvTTlzV0N5TkU2UGxkYjgzZHIvTU9m?=
 =?utf-8?B?aVNvamRGM3RGMWd2U0JqdDNyZHVWNmxIUnR0YzR0dWhXYTJGSkVsdmsxYUhR?=
 =?utf-8?B?VENMaGROYWhlbk15b1BxWlBacHdwZVhLNzZpeFBjQitvWlBzL05tdzhROTlo?=
 =?utf-8?B?UVZBM2g0blh3MW1pZFFiemdVcENwYnI3QXp3b25uVVJRdmtCYUMycTJNTzZY?=
 =?utf-8?B?dFJrdHJkU0p6dDFUVmRyUHNaTTJiTHdsQk1mLy9CNzlQUzBxRWYwcEFHWHRV?=
 =?utf-8?B?Yk5HUUdZbGUzQ1ZxTjNHVllPM3QzWW9Ja00rRVNpYllhSlpzSzN1WE5nV3dT?=
 =?utf-8?B?M0tFaXU2Y1N0eWFOUXRpVGtaZi9TcGszZXJYME54WUVSY09VUS9IS2w4MFZz?=
 =?utf-8?B?Z1Z2OUppQU9wL0tOdzZ4MC9SRWVRSjgvcVpsb2I4YnVaOE1OYmdPMXBlbjVQ?=
 =?utf-8?B?N2tGdm95WTk4QmNwMHZZd1RCR1pYVk9ocXQwU1BXTlZqVDVpWHZOOW1SVXov?=
 =?utf-8?B?Kzd3RW1HQjRGcHZMTnN0NVdyTUZJZksreXZFak1pcERKaFo2MWJvcTVBN2lV?=
 =?utf-8?B?S3FOQ1hPSk1ncjM2QWQwdGdaWGRqWVY5SUFkYlk5Rmh4UGk4V1ZrNTQzZGxW?=
 =?utf-8?B?eVJsaVU2T1hHVVgwTWN3MVE3djNRbW9ZNXJIYU9lanVmdDJkdXA0dEpMVmhM?=
 =?utf-8?B?a1kzeWFWQmcyTEtwZGl6Nmw2U0J0Q0RNODRzRksyKzFUWFdkNm1SaUt4WTlo?=
 =?utf-8?B?UXVSZDZXZHhwNjkxbHArWkZzeS9CeFhaZEgxdDhqRlRLbHJSL1U1QVI0RDFl?=
 =?utf-8?B?dGRPRS9TdUt1MmJEZkJkK0gvK3JiTkRKcytoaXNjSUxON2tKZiszNnlrQm5K?=
 =?utf-8?B?aWs2VDZ5K21MUDhFUkZJVmxzUE1RdE51ME93NTBOTk11MGhRa0RBZHRzUHUr?=
 =?utf-8?B?THVqVktDdEd4WmFGM3h0cWdxdWZuaitaaGFkWGNQdDNwWHNTRm1CdGlxYnYw?=
 =?utf-8?B?b3JITmw3ZGQ5WXhMcDdpZStabXhFb0cwRE8zSmUrY01veVJlZG8ycVlqWno3?=
 =?utf-8?B?VExhRzNSQThhYVptSU1ZcTAwTjFqK3cwOEZTcGZxSit1U3pFdWZZOXBFSFJh?=
 =?utf-8?B?bHMyeXlWVGpXdVdXeWVYR0p5NEY5NTFQMjIyc1VVNkJKWm8zYm9NTldMWmJY?=
 =?utf-8?B?TGh5QWtGOGVodnNvNDZLKzU4VVZuTkZQenlZeGE3TnNyWk5tYkdVemRIRDcr?=
 =?utf-8?B?b2tIV0FlZGxWenlodjNnYVFIU3krZWJCaVNWVjI4Yi85MXNMZTBxU2tmdDdt?=
 =?utf-8?B?cEpWV2Nqc1VWREw0VFRPZStIY3dtM2QvQkZzSUF2aXhTTmtlNHIxR2JYYmVN?=
 =?utf-8?B?NG01V1JLRWcvT0p6V3pMdXNXcm1zUjJCUEhTVDdzdS82dmdaOElRczJRWHND?=
 =?utf-8?Q?UFnE79qQBihrE35KkcnMsWGX8pSlzdnx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13efbe49-8557-4283-629b-08da0573c348
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 04:33:18.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icaylF36mEQPJqUsJJrHQWWbEOOseGLF1hYWuNOf1zBQPAQaGMMTxYz6E7B0BdqSPLFAdLveQRtBfqh7xgUXfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7072
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiBXZWQsIE1hciA5LCAyMDIyIGF0IDY6MDAgQU0gQmhhcmF0IEt1bWFyIEdvZ2FkYQ0KPiA8
YmhhcmF0Lmt1bWFyLmdvZ2FkYUB4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+IFhpbGlueCBW
ZXJzYWwgUHJlbWl1bSBzZXJpZXMgaGFzIENQTTUgYmxvY2sgd2hpY2ggc3VwcG9ydHMgUm9vdCBQ
b3J0DQo+ID4gZnVuY3Rpb25pbmcgYXQgR2VuNSBzcGVlZC4NCj4gPg0KPiA+IEFkZCBzdXBwb3J0
IGZvciBZQU1MIHNjaGVtYXMgZG9jdW1lbnRhdGlvbiBmb3IgVmVyc2FsIENQTTUgUm9vdCBQb3J0
DQo+IGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBLdW1hciBHb2dhZGEg
PGJoYXJhdC5rdW1hci5nb2dhZGFAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRp
bmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sICAgICAgIHwgNDcgKysrKysrKysrKysrKysr
Ky0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4gaW5kZXgg
MzJmNDY0MTA4NWJjLi45N2M3MjI5ZDdmOTEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNw
bS55YW1sDQo+ID4gQEAgLTE0LDE3ICsxNCwyMSBAQCBhbGxPZjoNCj4gPg0KPiA+ICBwcm9wZXJ0
aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBjb25zdDogeGxueCx2ZXJzYWwtY3Bt
LWhvc3QtMS4wMA0KPiA+ICsgICAgY29udGFpbnM6DQo+IA0KPiBOb3BlLiBUaGF0IG1lYW5zICdj
b21wYXRpYmxlID0gImZvbyIsICJ4bG54LHZlcnNhbC1jcG0taG9zdC0xLjAwIiwgImJhciI7Jw0K
PiB3b3VsZCBiZSB2YWxpZC4NCj4gDQo+ID4gKyAgICAgIGVudW06DQo+ID4gKyAgICAgICAgLSB4
bG54LHZlcnNhbC1jcG0taG9zdC0xLjAwDQo+ID4gKyAgICAgICAgLSB4bG54LHZlcnNhbC1jcG01
LWhvc3QtMS4wMA0KPiANCj4gV2hlcmUgZG9lcyAxLjAwIGNvbWUgZnJvbT8gTXkgZ3Vlc3MgaXMg
eW91IG9yIHdob2V2ZXIgZGlkIHRoZSBvcmlnaW5hbA0KPiBiaW5kaW5nIGp1c3QgbWFkZSBpdCB1
cC4gVmVyc2lvbiBudW1iZXJzIGFyZSBvbmx5IHVzZWQgd2hlbiB0aGV5DQo+IGNvcnJlc3BvbmQg
dG8gc29tZXRoaW5nIGRvY3VtZW50ZWQgZm9yIHRoZSBoL3cuIEluIHRoZSBjYXNlIG9mIFhpbGlu
eCwgdGhhdA0KPiBzaG91bGQgYmUgc29mdCBJUCAod2hpY2ggSSBhc3N1bWUgaGFzIHZlcnNpb25l
ZCByZWxlYXNlcykgYW5kIG5vdGhpbmcgZWxzZS4gSWYNCj4gJ3ZlcnNhbCcgaXMgbm90IHNwZWNp
ZmljIGVub3VnaCB0byBpZGVudGlmeSBhIHNwZWNpZmljIFNvQywgdGhlbiBhZGQgdG8gaXQuDQo+
IA0KQWdyZWVkLCB3aWxsIHJlbW92ZSB2ZXJzaW9uIG51bWJlcnMuDQo+IA0KPiA+ICAgIHJlZzoN
Cj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBDb25maWd1cmF0aW9u
IHNwYWNlIHJlZ2lvbiBhbmQgYnJpZGdlIHJlZ2lzdGVycy4NCj4gPiAtICAgICAgLSBkZXNjcmlw
dGlvbjogQ1BNIHN5c3RlbSBsZXZlbCBjb250cm9sIGFuZCBzdGF0dXMgcmVnaXN0ZXJzLg0KPiA+
ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgU2hvdWxkIGNvbnRhaW4gY3BtX3NsY3Is
IGNmZyByZWdpc3RlcnMgbG9jYXRpb24gYW5kIGxlbmd0aC4NCj4gPiArICAgICAgRm9yIHhsbngs
dmVyc2FsLWNwbTUtaG9zdC0xLjAwLCBpdCBzaG91bGQgYWxzbyBjb250YWluIGNwbV9jc3IuDQo+
IA0KPiBOb3QgYW4gaW1wcm92ZW1lbnQgaW4gZGVmaW5pbmcgd2hhdCBlYWNoIGVudHJ5IGlzLg0K
QWdyZWVkLCB3aWxsIGZpeCB0aGlzIGluIG5leHQgcGF0Y2guDQoNCnJlZ2FyZHMsDQpCaGFyYXQN
Cg==

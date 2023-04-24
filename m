Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DA6EC4CD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDXFZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDXFZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:25:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F330D0;
        Sun, 23 Apr 2023 22:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy3JHhu6YquN27SKZxUwLTY5lZnNZGdHN67seisKXkEEMYMgda9A5nnRYwVgDEo9HZ74Xh0zFJlHiGq4amr4v3D14SgEHdO6DJ261kq9/yzlE9i5yKw1Y7TlbxNUuc5kz64ASvX6HIMT7hna3gQg8zSy1y7tdDewJjIpRNRJHeqLhdK1/s9fV7MY3fbcr2BKlFLQG0IXq6b8PAkJ4C08/4UDmnr9pvHu3hHPzdaoK6FZe/wG7aWIHnj3eX+eOPlyEQSMiOHMjjR+2leJnQGQFnOwO85frXk2cINflHZD2zYqg2t+SWMGsQExZlZtKXsxtyTVLZIgnbtRzoHlHZnzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH7IhRq66i2Dwwb8n5gUJltm2lhQk6gstPnY/penpek=;
 b=KjM6Zi09DVhaMdetwkGP3mOWFQrHzYuZg9NNsJh/jYOP7QQthhDJQAcpEOo2tsdkjavI2qzTkTowV6wYJI5wraUQYJZnwii3C8AMy8TrgHcn7YracF5kmUiTTsKGay9k8X4Ek6OSIRA9aOZdeD9mhiaaNz8D5SXHn3+vG7tIRVVUvIo5+7ce5qV8ZylxcogkyCneVGm60CmYRQRAuxf9g1PQnJCH8lBuhghD2iTmWBBAAi6hT9Xc02Oj/QayUtJfNSGy7wF/faIqfvY/pAERm7z9IqRFrpx8OjbdVEFWCZB4av42ilb09fp+mVpMDrQrF0q9ra1kMDKXMMM95IWAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH7IhRq66i2Dwwb8n5gUJltm2lhQk6gstPnY/penpek=;
 b=juVqehFDmsd1T8rxrkx4ohXMvSM9+2ubU1xEpUomNymZw01NfgH/M2rqoFsn79VuRtbmYpp3cOkbm8SP/XQxTfZRWdHdxHN6/+nhbE//h/bA9x/vBo7rgh4cVHb7Ydueo1UUJ+jAUq84Njd98qGVGmS5Zm2hLObaS2EMX5JlCjw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB11064.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:25:39 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:25:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 09/22] PCI: dwc: Add support for triggering INTx IRQs
Thread-Topic: [PATCH v13 09/22] PCI: dwc: Add support for triggering INTx IRQs
Thread-Index: AQHZcfCzeN5PS03N0USUahmGKDuhM683OjcAgAK76+A=
Date:   Mon, 24 Apr 2023 05:25:39 +0000
Message-ID: <TYBPR01MB534134762901DB9E507D9259D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-10-yoshihiro.shimoda.uh@renesas.com>
 <20230422113908.GF4769@thinkpad>
In-Reply-To: <20230422113908.GF4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB11064:EE_
x-ms-office365-filtering-correlation-id: 25557c07-7391-4f8b-0271-08db44845751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8QlJIhe8LBJIfoFR8O6ObMRilym9E23TEtsBz4oVzg4M93P0HkCdXRgr4YZ8GtmrEhGY6kq5D/Gc154VwwOQJ/eK3NVSCPxyCYjDFi6MBb7nLBbUS66x5iB9gNW1IBqEqtV/JJHt7TVUn/1LMZVKlnUr+5arf2r5EpWmLn+QstO7EsL8G+aHilfcH8k4BTLWU34pDaU8nMTqhXiUIUj+nM8UuNt1Mie/yp7OGhPGWydER/nSyNsTn4ncvJeqTUSSeUmrGfPFYYmTCXqEN4x4ebzM1rPy5P/9sbuQbL7lNUSDWIL3hOjqi+7ZnHU1H9n9mwZedxBjNZ8v8tm6wgM6HUQqqTjSISm3j2hMmO1/zAWGPf+h5otlfOlzw301+4LLN9BC1oyfWQc4tpz087rLWsTn+JtaH59pkcwTPRc0k3qQ3o69LHkQOwhVMe4MSk6ya2jRy88426CvWqJ1FLhziNw2DtRG6ynPxiP4PEpibiBqIv1P3nPGvWznrB6V1NjTNQ5eKVYcEfuIXUt3c2rjNKQrZEYrdnoWwgwNs9hKzW759fDNogyK5eKpre0lea3a92F6LhTsh2CfTRK6pzoXSW9IjQSO3ztfuleiDBQXRTmiJotXq8XMBlaf2GJdVGc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzFSMEdlOVBQM3pBYnZ4YzM2cnhBVTlWZWQ1cDU1WlBCdndJRVRqd0dIMTNQ?=
 =?utf-8?B?bmFpbDZqTXNiZC9RWU1ySmV0MU1NcjVMTFpxTCsvYURNd3ozdUVBOGtNTm1N?=
 =?utf-8?B?MkRVRlJ3U2ptR3ZZOG02MzJBRWhIZVAyYWVIUE1WcTFteDRXdGdlRTViWlF5?=
 =?utf-8?B?U1pMZFM4ZU1lQWNhVys2TDdrYm1UUnh3SG9TbTF2MWl0bGN6UFhHci9OU2lr?=
 =?utf-8?B?Umo1ZFRlbENmaTJqVGo0Mks5dnd2QWROZjJySnh3SUptcmx0UGtCRTZqUWNE?=
 =?utf-8?B?THlIcGpPV2pmY0JaZTA2MTJZb0ZFWUp5R0RrMDltNGFUNzl3NTRWLzNiMVlC?=
 =?utf-8?B?bUVnT0lBbW02R3lVbjVwK3NmNHY5S0tYRGxxOFVOWE9rUDEvM2cwZmtmY29s?=
 =?utf-8?B?d3lUU1lXalg2QlN2SkNoVmFZQ1J4a0srYUxoblRkaGxIdWVsZjRKRWRndDRF?=
 =?utf-8?B?cFZ5WW5uT05pZ29tY2pMc3FNUWVqWU9OeTZIVHpnZGpWaUxYKzVOQ0tyVTN0?=
 =?utf-8?B?UjFleDFkeU0xdjRFTHBtWFBZOWJjdVc0K1ZWZTNLTDZIN1ZldjRML1o5R0NP?=
 =?utf-8?B?VmRZbHNpYjhIa3J4Vk42SC9wRTlURXl5eFhhZDZvRkYyamlHUThoejRKTUND?=
 =?utf-8?B?N0VwQitXSXkwaFRVL3plL2JvazRBVWYvelJNVENLb2ZyUFB3dGU2MWxzSGRj?=
 =?utf-8?B?eFRlZktzRjBxM09jVThVWWhlUGZXR3NnVk9DZzlOV1Z0OThWV1pxRHpNTjFG?=
 =?utf-8?B?eHU2OGlEc205QXNaSVUvSzhyeTl0UHEzTEtDelFYanBIeU5LaUhTRkwxL1Vs?=
 =?utf-8?B?L2pZRENJZmRGUVZETE9Xdk52RzNXRDZUVUtNMlVFMnBxczRNdDJqeEZURWJo?=
 =?utf-8?B?UjdCempTVkY2N3JpbEtMTmFyZVJLNDRZb0hxNEpURk92Z0IzWWZMMEZ1eUpL?=
 =?utf-8?B?UHVrWnpPeVdyWVR0d3NtVTM3Rm1JUGltSVRJUExoVFJ4ZnJmQkR3U25SRVZp?=
 =?utf-8?B?d0VidFlCM3N3cGJQUjlGQWdPN1ZwbE9qeGpnK0pVNlpWa1FGeXBPZml3Wnh0?=
 =?utf-8?B?dGxueVBObTRMQ1VKbEplaGdsTHBodVNWaFAxN0xiK21QdDUzSVNmVHBnOGhl?=
 =?utf-8?B?QnFMdTJwclQzV25TcWdqTVh1R1B2TENTc3RPRVV0RmFRRWs4TDVvcWoxUXVX?=
 =?utf-8?B?Smg4bjNTZzNzZHdNdFpmT2tSbWh1eHRrNnZCYlNGK1FGalJSeVBZZzJFZGZM?=
 =?utf-8?B?djlpeFlNK1g2RTQ1bjljeHFZYWh2Z2ZZTVhlbWl4RDl3ZytTRy9NUUtBNnNv?=
 =?utf-8?B?alVPRzcyVzlZMlFwOEl6OFlnMCt3RWpPbm91bHNFWmwrYWtHdTBLK2pmRlcx?=
 =?utf-8?B?dnkvMmhqdkhGK2l0VEMydGJwMG5UbEpSQll2Ukg3QkdjTVVNNWFCUzU0Q25K?=
 =?utf-8?B?bm5EQ1ZYZmx6cUw2Q21VcGFLU0JwZjBqZC9vV240YlR6K3pEUitHejErUW1y?=
 =?utf-8?B?TE9wK1U2T3MyK0dVbXBocjVwRmpqMjMzQjQxcHd6ZnA3VVc2ZEpPWFJRTjIw?=
 =?utf-8?B?V1pjNU95ZU82QVpPU21Zc21LZGFOQi9iQkNaQXp5bUpCSEN2aTVPaWQvS1lh?=
 =?utf-8?B?cDB1Z0lURWhoSSttL2FRN0E3TFJmck1Va3FISUlISXYxNG5PSHpuSHFEdnBY?=
 =?utf-8?B?dVNLNTI2dUU1SGZFU1FSMG9SV1VydzhQSFdJZkVlTzBGdHJITFhlS1BlVmND?=
 =?utf-8?B?WFhEcmxlelpOek9YV0ZJSC9Ca0VLeWNQSEdoWUpjZWREM3l1MElrdEpJeXVC?=
 =?utf-8?B?UGZvMFN2eEQvTUpTb09FalJsSi9kT2swenVhK3A1WjVvakhzN0dVZ2J4UXda?=
 =?utf-8?B?WmM4MEtHSVpYYWVlZnd1VHphQnZZNGlOVVoxMzlQdHFYVWxTN1RNUXFnWTJQ?=
 =?utf-8?B?NTRiRXNTaW5rTm04YXozOU5RK1B0anFwZ3F2TXJtb1NnWUFQKzZtMFc2ZStX?=
 =?utf-8?B?ZkhrbGFXZkpNUk1Bc0ZNTVFWY2Y0aTNKa0ZScUh3bktlTlg2TENsMm9sRTlq?=
 =?utf-8?B?bjZ0OWNWc1VQN0ZpamNsOWtLWDU1amJjVlBTdUQ4TVVTbGwwTkJFcjQ2QS82?=
 =?utf-8?B?dGxUMnZWUDNwdmp0NENpQU1YTHAwSWs5RlRmM2Exa3hXdDhObUlxTVJHenNQ?=
 =?utf-8?B?RW15NTh6M3FlYVI4d2psbXVqL1dGMUFYblNTUlVDdWZjTGZabGJKTVV0anVJ?=
 =?utf-8?B?SVNnV3cxZUhUUktkaXhMODJoTFR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25557c07-7391-4f8b-0271-08db44845751
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:25:39.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXAnTLe9L1QdVCDqk8hvp2h0+NcaSsdP+yyYes7yggLWXHYAtQlChnc4hrYirgFHhzId52IhN16wh0Ysxz5gHc8NDdfNpWvuoK3BEzS/5mk46EewHDoDHh5vF7r497JD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA4OjM5IFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAy
MyBhdCAwOToyMzo1MFBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gDQo+IEl0
J3MgZ29vZCB0byBhZGQgImVuZHBvaW50IGRyaXZlcnMiIGluIHN1YmplY3QgYXMgYmVsb3c6DQo+
IA0KPiBQQ0k6IGR3YzogQWRkIHN1cHBvcnQgZm9yIHRyaWdnZXJpbmcgSU5UeCBJUlFzIGZyb20g
ZW5kcG9pbnQgZHJpdmVycw0KDQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uISBJJ2xsIGNo
YW5nZSB0aGUgc3ViamVjdC4NCg0KPiA+IEFkZCBzdXBwb3J0IGZvciB0cmlnZ2VyaW5nIElOVHgg
SVJRcyBieSB1c2luZyBvdXRib3VuZCBpQVRVLg0KPiA+IE91dGJvdW5kIGlBVFUgaXMgdXRpbGl6
ZWQgdG8gc2VuZCBhc3NlcnQgYW5kIGRlLWFzc2VydCBJTlR4IFRMUHMuDQo+ID4gVGhlIG1lc3Nh
Z2UgaXMgZ2VuZXJhdGVkIGJhc2VkIG9uIHRoZSBwYXlsb2FkbGVzcyBNc2cgVExQIHdpdGggdHlw
ZQ0KPiA+IDB4MTQsIHdoZXJlIDB4NCBpcyB0aGUgcm91dGluZyBjb2RlIGltcGx5aW5nIHRoZSBU
ZXJtaW5hdGUgYXQNCj4gPiBSZWNlaXZlciBtZXNzYWdlLiBUaGUgbWVzc2FnZSBjb2RlIGlzIHNw
ZWNpZmllZCBhcyBiMTAwMHh4IGZvcg0KPiA+IHRoZSBJTlR4IGFzc2VydGlvbiBhbmQgYjEwMDF4
eCBmb3IgdGhlIElOVHggZGUtYXNzZXJ0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9z
aGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+IC0t
LQ0KPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jICAgfCA3
MCArKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oICB8ICAyICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiBpbmRleCA5NjM3NWIwYWJhODIuLjMw
NGVkMDkzZjU1MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gQEAgLTYsNiArNiw3IEBADQo+ID4gICAqIEF1dGhv
cjogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gPiAgICovDQo+ID4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4NCj4gPiBAQCAt
NDg1LDE0ICs0ODYsNjIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX29wcyBlcGNfb3Bz
ID0gew0KPiA+ICAJLmdldF9mZWF0dXJlcwkJPSBkd19wY2llX2VwX2dldF9mZWF0dXJlcywNCj4g
PiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IGR3X3BjaWVfZXBfc2VuZF9tc2coc3RydWN0IGR3
X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLCB1OCBjb2RlLA0KPiA+ICsJCQkgICAgICAgdTggcm91
dGluZykNCj4gPiArew0KPiA+ICsJc3RydWN0IGR3X3BjaWVfb3V0Ym91bmRfYXR1IGF0dSA9IHsg
MCB9Ow0KPiA+ICsJc3RydWN0IHBjaV9lcGMgKmVwYyA9IGVwLT5lcGM7DQo+ID4gKwlpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArCWF0dS5mdW5jX25vID0gZnVuY19ubzsNCj4gPiArCWF0dS5jb2RlID0g
Y29kZTsNCj4gPiArCWF0dS5yb3V0aW5nID0gcm91dGluZzsNCj4gPiArCWF0dS50eXBlID0gUENJ
RV9BVFVfVFlQRV9NU0c7DQo+ID4gKwlhdHUuY3B1X2FkZHIgPSBlcC0+aW50eF9tZW1fcGh5czsN
Cj4gPiArCWF0dS5zaXplID0gZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemU7DQo+IA0KPiBOZXds
aW5lIGhlcmUuDQoNCkkgZ290IGl0Lg0KDQo+ID4gKwlyZXQgPSBkd19wY2llX2VwX291dGJvdW5k
X2F0dShlcCwgJmF0dSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4g
Kw0KPiA+ICsJd3JpdGVsKDAsIGVwLT5pbnR4X21lbSk7DQo+ID4gKw0KPiA+ICsJZHdfcGNpZV9l
cF91bm1hcF9hZGRyKGVwYywgZnVuY19ubywgMCwgZXAtPmludHhfbWVtX3BoeXMpOw0KPiA+ICsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9fZHdfcGNp
ZV9lcF9yYWlzZV9pbnR4X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+
ID4gKwkJCQkJIGludCBpbnR4KQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
CXJldCA9IGR3X3BjaWVfZXBfc2VuZF9tc2coZXAsIGZ1bmNfbm8sIFBDSV9DT0RFX0FTU0VSVF9J
TlRBICsgaW50eCwNCj4gPiArCQkJCSAgUENJX01TR19ST1VUSU5HX0xPQ0FMKTsNCj4gPiArCWlm
IChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogVGhl
IGRvY3VtZW50cyBvZiBQQ0llIGFuZCB0aGUgY29udHJvbGxlciBkb24ndCBtZW50aW9uIGhvdyBs
b25nDQo+ID4gKwkgKiB0aGUgSU5UeCBzaG91bGQgYmUgYXNzZXJ0ZWQuIElmIDEwIHVzZWMsIHNv
bWV0aW1lcyBpdCBmYWlsZWQuDQo+ID4gKwkgKiBTbywgYXNzZXJ0ZWQgZm9yIDUwIHVzZWMuDQo+
ID4gKwkgKi8NCj4gPiArCXVzbGVlcF9yYW5nZSg1MCwgMTAwKTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gZHdfcGNpZV9lcF9zZW5kX21zZyhlcCwgZnVuY19ubywgUENJX0NPREVfREVBU1NFUlRfSU5U
QSArIGludHgsDQo+ID4gKwkJCQkgICBQQ0lfTVNHX1JPVVRJTkdfTE9DQUwpOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICBpbnQgZHdfcGNpZV9lcF9yYWlzZV9pbnR4X2lycShzdHJ1Y3QgZHdfcGNpZV9l
cCAqZXAsIHU4IGZ1bmNfbm8pDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSB0
b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5k
ZXY7DQo+ID4NCj4gPiAtCWRldl9lcnIoZGV2LCAiRVAgY2Fubm90IHRyaWdnZXIgSU5UeCBJUlFz
XG4iKTsNCj4gPiArCWlmICghZXAtPmludHhfbWVtKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJF
UCBjYW5ub3QgdHJpZ2dlciBJTlR4IElSUXNcbiIpOw0KPiANCj4gSU5UeCBub3Qgc3VwcG9ydGVk
Lg0KDQpJIGdvdCBpdC4NCg0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gLUVOT1RTVVBQ
DQoNCkknbGwgZml4IGl0IG9uIHYxMy4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1v
ZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gKwl9DQo+ID4NCj4gPiAtCXJldHVybiAtRUlOVkFMOw0K
PiA+ICsJcmV0dXJuIF9fZHdfcGNpZV9lcF9yYWlzZV9pbnR4X2lycShlcCwgZnVuY19ubywgMCk7
DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoZHdfcGNpZV9lcF9yYWlzZV9pbnR4X2ly
cSk7DQo+ID4NCj4gPiBAQCAtNjIzLDYgKzY3MiwxMCBAQCB2b2lkIGR3X3BjaWVfZXBfZXhpdChz
dHJ1Y3QgZHdfcGNpZV9lcCAqZXApDQo+ID4NCj4gPiAgCWR3X3BjaWVfZWRtYV9yZW1vdmUocGNp
KTsNCj4gPg0KPiA+ICsJaWYgKGVwLT5pbnR4X21lbSkNCj4gPiArCQlwY2lfZXBjX21lbV9mcmVl
X2FkZHIoZXBjLCBlcC0+aW50eF9tZW1fcGh5cywgZXAtPmludHhfbWVtLA0KPiA+ICsJCQkJICAg
ICAgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemUpOw0KPiA+ICsNCj4gPiAgCXBjaV9lcGNfbWVt
X2ZyZWVfYWRkcihlcGMsIGVwLT5tc2lfbWVtX3BoeXMsIGVwLT5tc2lfbWVtLA0KPiA+ICAJCQkg
ICAgICBlcGMtPm1lbS0+d2luZG93LnBhZ2Vfc2l6ZSk7DQo+ID4NCj4gPiBAQCAtNzk0LDkgKzg0
NywxNCBAQCBpbnQgZHdfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkNCj4gPiAg
CQlnb3RvIGVycl9leGl0X2VwY19tZW07DQo+ID4gIAl9DQo+ID4NCj4gPiArCWVwLT5pbnR4X21l
bSA9IHBjaV9lcGNfbWVtX2FsbG9jX2FkZHIoZXBjLCAmZXAtPmludHhfbWVtX3BoeXMsDQo+ID4g
KwkJCQkJICAgICAgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemUpOw0KPiA+ICsJaWYgKCFlcC0+
aW50eF9tZW0pDQo+ID4gKwkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5
IGZvciBJTlR4XG4iKTsNCj4gPiArDQo+ID4gIAlyZXQgPSBkd19wY2llX2VkbWFfZGV0ZWN0KHBj
aSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gZXJyX2ZyZWVfZXBjX21lbTsNCj4gPiAr
CQlnb3RvIGVycl9mcmVlX2VwY19tZW1faW50eDsNCj4gPg0KPiA+ICAJaWYgKGVwLT5vcHMtPmdl
dF9mZWF0dXJlcykgew0KPiA+ICAJCWVwY19mZWF0dXJlcyA9IGVwLT5vcHMtPmdldF9mZWF0dXJl
cyhlcCk7DQo+ID4gQEAgLTgxMyw3ICs4NzEsMTEgQEAgaW50IGR3X3BjaWVfZXBfaW5pdChzdHJ1
Y3QgZHdfcGNpZV9lcCAqZXApDQo+ID4gIGVycl9yZW1vdmVfZWRtYToNCj4gPiAgCWR3X3BjaWVf
ZWRtYV9yZW1vdmUocGNpKTsNCj4gPg0KPiA+IC1lcnJfZnJlZV9lcGNfbWVtOg0KPiA+ICtlcnJf
ZnJlZV9lcGNfbWVtX2ludHg6DQo+ID4gKwlpZiAoZXAtPmludHhfbWVtKQ0KPiA+ICsJCXBjaV9l
cGNfbWVtX2ZyZWVfYWRkcihlcGMsIGVwLT5pbnR4X21lbV9waHlzLCBlcC0+aW50eF9tZW0sDQo+
ID4gKwkJCQkgICAgICBlcGMtPm1lbS0+d2luZG93LnBhZ2Vfc2l6ZSk7DQo+ID4gKw0KPiA+ICAJ
cGNpX2VwY19tZW1fZnJlZV9hZGRyKGVwYywgZXAtPm1zaV9tZW1fcGh5cywgZXAtPm1zaV9tZW0s
DQo+ID4gIAkJCSAgICAgIGVwYy0+bWVtLT53aW5kb3cucGFnZV9zaXplKTsNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXgg
OTU0ZDUwNDg5MGExLi44YzA4MTU5ZWEwOGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0zNjksNiArMzY5LDggQEAg
c3RydWN0IGR3X3BjaWVfZXAgew0KPiA+ICAJdW5zaWduZWQgbG9uZwkJKm9iX3dpbmRvd19tYXA7
DQo+ID4gIAl2b2lkIF9faW9tZW0JCSptc2lfbWVtOw0KPiA+ICAJcGh5c19hZGRyX3QJCW1zaV9t
ZW1fcGh5czsNCj4gPiArCXZvaWQgX19pb21lbQkJKmludHhfbWVtOw0KPiA+ICsJcGh5c19hZGRy
X3QJCWludHhfbWVtX3BoeXM7DQo+ID4gIAlzdHJ1Y3QgcGNpX2VwZl9iYXIJKmVwZl9iYXJbUENJ
X1NURF9OVU1fQkFSU107DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+
IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K61
4K6u4K+NDQo=

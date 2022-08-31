Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9628C5A7B33
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiHaKSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaKSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 06:18:18 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA822229A
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 03:18:16 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-Du0S-mfdO6ypx1Uk65GUZg-1; Wed, 31 Aug 2022 12:18:12 +0200
X-MC-Unique: Du0S-mfdO6ypx1Uk65GUZg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0291.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:31::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 31 Aug 2022 10:18:11 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f%2]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 10:18:10 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "marex@denx.de" <marex@denx.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Topic: [PATCH v5 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Index: AQHYvSL4YjVqGf2TjU+TFTiXgkQ/VQ==
Date:   Wed, 31 Aug 2022 10:18:10 +0000
Message-ID: <1218d5afbbf18f8b5ab9013e08fde84a787d8df3.camel@toradex.com>
References: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
         <1661845564-11373-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1661845564-11373-4-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f601cbbb-1505-4500-6cf1-08da8b3a1b48
x-ms-traffictypediagnostic: GV0P278MB0291:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: UpfhAoL5UxpvxWS7p0dz1gnu6/yPERm3WYukhAoEq+2YKJ7qdKpdjMGfLKawvKp4MZD2qaGOxGTDsVKc/Y+dko1K0W6kX/WFlnaJ5/szkgH6k9OzRDGnwRY6K3iNGt48mrCMnlj5BGVRJD7u2mI308bRrCMX8HQMOoR1wxwDxsN2boByW4r523NCsbbfVxF5FjeWZTcbUFr8Ja43VSfaLLsj9HrytHJ5MXIe/dNmM0klON0KbX5jZtdEyB54zUjHJefbTiV9tYzXLhZTuMljLZmQrzd9ryP3YAyWueImQIkR+5G/PAl9nXmqH6AtE3UScVaaUqyRNlNAHKZmoZ/FW6KgdEyTRUL6geFV/raz39rEaDsPDb1K9Tj3JK4v/gEMRLD1W002jPGlVcpRBx2z7cw1Q6fyzigZfVHnDlUCenHKJ5o0R327RE6TpOb9nVRJWrW8Lekh/pDJWKpZge55/NWkk0srwFtLgTL/MovgoSwob+27Jl9hCxczMvqQl7MyMEGRTzX8tfjzu/xZIf9/hT4c8zoVQO2v9pFVRU7hqeOTBs8SLtLVNe0hQv1zfjfSwGtRo5YGfioNERE2pD7+fYBgjGHl9xhexp/g46/QFSt7I8Nepn2pXGCcFDd5gHjvPOOLop0yRCgcKenKbcUfBn+56TlqIYymcxTX3ewM6L0svZWzgBsYTKadWBQ94eFi1wFphnb7KmDysm/JiIbIJ2cpJmaWsCiBLWf8SNDtjq0kxDNE+YmEUO2jvDwMdfX953RYzFnCQSCaZ6KONmvtt9EjGvyvLB/xnElwLwhQ0rHgrsEy7dQERpb0Og3A+vIg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39840400004)(71200400001)(6486002)(64756008)(8676002)(76116006)(478600001)(4326008)(38070700005)(316002)(66476007)(66946007)(66556008)(8936002)(66446008)(36756003)(5660300002)(41300700001)(7416002)(44832011)(110136005)(54906003)(6506007)(26005)(2906002)(86362001)(6512007)(186003)(38100700002)(122000001)(2616005)(921005)(83380400001)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWV2SDRUQ2tISzV4eVg1MXBVd1ZMelltSG5ZS042dDkvVFo2dTFQMmRsM2RV?=
 =?utf-8?B?a0ZMQU1ZSjNvUUt5YlBES3F5bVhUa3NHWjJFMWZkc1FyaU8xUHdwbVBrdGh1?=
 =?utf-8?B?WFo3dWZjY2Q0bTRJU0FSd3ZuOHhhODk1OHpVd3d1VURURUMxdE5HU0JqM08w?=
 =?utf-8?B?Z0RRUmcwcmNKbE8xMm4wbzh5ZVN2UVNDclRabkxIbmdyNnJrVUhmdTlNWHFt?=
 =?utf-8?B?S3d4Qks2bG80NXFqVjdtZmVRT3J1UEVoeElQZ1ZYcHQwQ2dlNEhxMHJTdE9I?=
 =?utf-8?B?elpWSHUvWDY2V2NtSjZEc2hnc3o5akVhS3BCMGxhK04wRGpwaGpQMFZJQ01s?=
 =?utf-8?B?WUNhQWRMdEYyNnAybkF0M0E5UERhOG1ockU3QTF3NzV1SHQ3MzJSU1Z5SXR0?=
 =?utf-8?B?T3ZaSnhxK3g3ZzdDMHkxR0ZudDIyUTVIWVM0dFpyNmJGOEpMUmdsRDFoSExV?=
 =?utf-8?B?L1RRQU9TSlhpRW1ic2VKdzQvSlErMXJzUHFJV2JHUDUrZlNsbVZwL25CVlpw?=
 =?utf-8?B?aHdSZHkyNmN5S28xQzNUdjZBNEtrZERYQ3VJd2REQWlpVDZCeTlMQkdQajZm?=
 =?utf-8?B?MnNFK1hjMkJKL2hCNjNFbEVyMzljTk5WSnFPc0t3WEVuZ2ZhSFdTQ0Z2QktR?=
 =?utf-8?B?SHFiUU0zSlVTc1FveFIxRWVRbmMyd1B1dVlBdCtaM0c1QzFOREw2ajN3Tm9o?=
 =?utf-8?B?Rk9oV2ZQd3R3b2xnaVJSTHRuZkQ2VGVVWG1vdStSWU1PdXJZMStMeVpEdnJD?=
 =?utf-8?B?WTZYZDFOc2hNbllTSEpjeDBWZG0xdGRMaVU0SGdnVE5UZkNxMG8xdkZEZ2t5?=
 =?utf-8?B?Q3dURmpkcGRESGxycE1zc2ZRWHl0UEpWQmt4TXA2TmVhZnNMSEg0MFhtaEVa?=
 =?utf-8?B?ckxyMTBOdzlTSUlMMko4ekZBcFpZM0FXdHZSVndHSHpsTGx5S0RxWTRRa2lh?=
 =?utf-8?B?SjliaUw1aE5za1BkMGhqdjRYSzd6Y1dpNFNwTkg3bUdsUzFQQ0lNM2x2ZEM1?=
 =?utf-8?B?SFdPYzZKRHMvNzc2ZTMzNi9DOTA3czlJd0l0S0lRU2NSR1oyYTJtS1BpM1hK?=
 =?utf-8?B?ekQ5MW9WYmhFK0hxb1pUKytjSC9nOVlKYnMya1JHL2dOQ3JER2ppSFcraVAy?=
 =?utf-8?B?M2g4SkcvMncwM0FiaFM1T2h0c2dIMnJoTlFVMWlBWEdGUmxxeG83M2g4b0RE?=
 =?utf-8?B?dkE0cEsxNWhQbzhlVk0xREpTcU5zMko3c25LZHd0RVZHbVhNU3Y3QVBRRE1J?=
 =?utf-8?B?RUQrWko3MDZ4M1FlSW9IU0pWbytOMHJ6NFk3VWpUMjE4MEpaWkZYNW9oZjR5?=
 =?utf-8?B?MXRuZ3Q2aUNVR3dZdTQ4VWlkWUtqUUlrbFpVcWNPZzJrS1ZDaDk1WWROY2hN?=
 =?utf-8?B?NlZ3bDFHYXZTTnpzalVPU1JHQ21XMmR3clRzSWdxTTI4aFlsVEJ5akYxRkN5?=
 =?utf-8?B?ZG02dm1rTWE3d0ZaQ3hpWG8zV3YxSURCMWFldVpCQVEyNUYvNEZMZEc2Q1Y2?=
 =?utf-8?B?V1ZLa2hLN3MySkt1WENiUmJhNmQ0cmtJaCtYSytEeUt5ek5abHZOeHp0bTNO?=
 =?utf-8?B?RHZUOUJKaXJPSzRZTW80Q29KOUJ5WmUwbFJ4cGxCczBlUlQ4TEZna0gzNWtT?=
 =?utf-8?B?TTFBRzJNazJ3NUZRK3c2UTAveGxDejhkSkozQzduUHhLcVQ2M05IU0RqWUxw?=
 =?utf-8?B?YTlSekF5WUxSajlFYyt0UFQ0V0htVk55QXBudUNHVEMvc0wzUHpkcTY5YmdR?=
 =?utf-8?B?bUlFdDBESW1oNTdsUmdIczg5S1RNRUJUTHBWWGtEdWd0KzdDbk5ITmt6dG1T?=
 =?utf-8?B?RWNMTlVrL0xSVGJuSkFHdjVrem9wbm1zSzJDT0F6SmFvMEhFYmQvQWRwQzBM?=
 =?utf-8?B?OFpvNGxYVjdUSnZ1YTVLMGh6YzJETkNHcUpyS0U5QUU3T1FhcWtpRWplR2tU?=
 =?utf-8?B?QkVPQ2czQUFqdk1BYUdidGlMa1huTkFzS3JZWEtPemN4NlpONGlybWx1Z25h?=
 =?utf-8?B?SGszUXJWYmxZWjVNdE1hTVE0WndTTDdlc0VpZXFkMGQ5Tlpxd2kzalhXeFJv?=
 =?utf-8?B?TVhBUjVIejB0UnVNcmhmcWk3UmpHNkJPc2FTWnFxaVllZjNUc21HYkJpYlBK?=
 =?utf-8?B?T3dOdFZtUkt4eWpnOGl5OUNwditmSnUrMHN6U0hlbmJtNEErclBocWpoSU56?=
 =?utf-8?Q?qNhI6Zn9NMRGlWpoEO9NqhM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f601cbbb-1505-4500-6cf1-08da8b3a1b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 10:18:10.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbHjwTi0PhOG1UW4ZfjDxAGURbBOXJHjMtYbD3Pl5kGH5F+ZSzAfPlQ5zalSP00+bH64XBm5z+GYKERTQnzy8xRhavNdyClxuIHjBkdX/+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0291
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <A6C7314099F9ED4A948DF60E0F0E7A84@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE1OjQ2ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToKPiBB
ZGQgUENJZSBzdXBwb3J0IG9uIGkuTVg4TVAgRVZLIGJvYXJkLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmVrIFZh
c3V0IDxtYXJleEBkZW54LmRlPgo+IFRlc3RlZC1ieTogUmljaGFyZCBMZWl0bmVyIDxyaWNoYXJk
LmxlaXRuZXJAc2tpZGF0YS5jb20+Cj4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhh
bmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cyB8IDUzICsrKysrKysrKysrKysrKysrKysrCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzCj4gaW5kZXggZjZiMDE3YWI1ZjUzLi5kZWZjOTJh
OGJiNjAgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LWV2ay5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZr
LmR0cwo+IEBAIC01LDYgKzUsNyBAQAo+IMKgCj4gwqAvZHRzLXYxLzsKPiDCoAo+ICsjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaD4KPiDCoCNpbmNsdWRlICJpbXg4bXAu
ZHRzaSIKPiDCoAo+IMKgLyB7Cj4gQEAgLTMzLDYgKzM0LDEyIEBAIG1lbW9yeUA0MDAwMDAwMCB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwweDEgMHgwMDAw
MDAwMCAwIDB4YzAwMDAwMDA+Owo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4gK8KgwqDCoMKg
wqDCoMKgcGNpZTBfcmVmY2xrOiBwY2llMC1yZWZjbGsgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNjbG9jay1jZWxscyA9IDwwPjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMDA+Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqByZWdfY2FuMV9zdGJ5OiByZWd1bGF0b3ItY2FuMS1zdGJ5IHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1uYW1lID0gImNhbjEtc3RieSI7Cj4g
QEAgLTU1LDYgKzYyLDE3IEBAIHJlZ19jYW4yX3N0Ynk6IHJlZ3VsYXRvci1jYW4yLXN0Ynkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5hYmxlLWFjdGl2ZS1oaWdoOwo+IMKg
wqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgcmVnX3BjaWUwOiByZWd1bGF0
b3ItcGNpZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAi
cmVndWxhdG9yLWZpeGVkIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGlu
Y3RybC0wID0gPCZwaW5jdHJsX3BjaWUwX3JlZz47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlZ3VsYXRvci1uYW1lID0gIk1QQ0lFXzNWMyI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Owo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAw
MDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3BpbyA9IDwmZ3BpbzIgNiBH
UElPX0FDVElWRV9ISUdIPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5hYmxl
LWFjdGl2ZS1oaWdoOwo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBy
ZWdfdXNkaGMyX3ZtbWM6IHJlZ3VsYXRvci11c2RoYzIgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiBAQCAtMzUw
LDYgKzM2OCwyOCBAQCAmaTJjNSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+IMKgfTsKPiDCoAo+
ICsmcGNpZV9waHkgewo+ICvCoMKgwqDCoMKgwqDCoGZzbCxyZWZjbGstcGFkLW1vZGUgPSA8SU1Y
OF9QQ0lFX1JFRkNMS19QQURfSU5QVVQ+Owo+ICvCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmcGNp
ZTBfcmVmY2xrPjsKPiArwqDCoMKgwqDCoMKgwqBjbG9jay1uYW1lcyA9ICJyZWYiOwo+ICvCoMKg
wqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsKPiArfTsKPiArCj4gKyZwY2llewoKTWlzc2luZyBz
cGFjZSBiZWZvcmUgdGhhdCBjdXJseSBicmFjZS4KCj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsKPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
cGNpZTA+Owo+ICvCoMKgwqDCoMKgwqDCoHJlc2V0LWdwaW8gPSA8JmdwaW8yIDcgR1BJT19BQ1RJ
VkVfTE9XPjsKPiArwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX0hTSU9f
Uk9PVD4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNsayBJTVg4TVBfQ0xL
X1BDSUVfUk9PVD4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNsayBJTVg4
TVBfQ0xLX0hTSU9fQVhJPjsKPiArwqDCoMKgwqDCoMKgwqBjbG9jay1uYW1lcyA9ICJwY2llIiwg
InBjaWVfYXV4IiwgInBjaWVfYnVzIjsKPiArwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1jbG9ja3Mg
PSA8JmNsayBJTVg4TVBfQ0xLX1BDSUVfQVVYPjsKPiArwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1j
bG9jay1yYXRlcyA9IDwxMDAwMDAwMD47Cj4gK8KgwqDCoMKgwqDCoMKgYXNzaWduZWQtY2xvY2st
cGFyZW50cyA9IDwmY2xrIElNWDhNUF9TWVNfUExMMl81ME0+Owo+ICvCoMKgwqDCoMKgwqDCoHZw
Y2llLXN1cHBseSA9IDwmcmVnX3BjaWUwPjsKPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAib2th
eSI7Cj4gK307Cj4gKwo+IMKgJnNudnNfcHdya2V5IHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RhdHVz
ID0gIm9rYXkiOwo+IMKgfTsKPiBAQCAtNTAyLDYgKzU0MiwxOSBAQCBNWDhNUF9JT01VWENfU1BE
SUZfVFhfX0kyQzVfU0NMwqDCoMKgwqDCoMKgwqDCoCAweDQwMDAwMWMyCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqA+Owo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4gK8KgwqDC
oMKgwqDCoMKgcGluY3RybF9wY2llMDogcGNpZTBncnAgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBmc2wscGlucyA9IDwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoE1YOE1QX0lPTVVYQ19JMkM0X1NDTF9fUENJRV9DTEtSRVFfQsKgwqDC
oMKgMHg2MSAvKiBvcGVuIGRyYWluLCBwdWxsIHVwICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhNUF9JT01VWENfU0QxX0RBVEE1X19HUElPMl9J
TzA3wqDCoMKgwqDCoMKgMHg0MQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Owo+
ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmxfcGNpZTBfcmVn
OiBwY2llMHJlZ2dycCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxwaW5z
ID0gPAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg4
TVBfSU9NVVhDX1NEMV9EQVRBNF9fR1BJTzJfSU8wNsKgwqDCoMKgwqDCoDB4NDEKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsKPiDCoMKg
wqDCoMKgwqDCoMKgcGluY3RybF9wbWljOiBwbWljZ3JwIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZzbCxwaW5zID0gPAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoE1YOE1QX0lPTVVYQ19HUElPMV9JTzAzX19HUElPMV9JTzAzwqDC
oMKgwqDCoDB4MDAwMDAxYzAK


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9211942379B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 07:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJFFv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 01:51:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18456 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 01:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633499376; x=1665035376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lzxvaRG8n6m6tcKKuCkuEvYI8Ym8HAdYcuuPN8+94IU=;
  b=Q6/a+0D4gaWwmSZ9pvqXKQ++5r+SzokO8Yr7m8HjUDJE242kV3PgnKbQ
   3hET9uiW3WtzlIRC7VQCuzFVYuvnkUpbgbiwLrh5T3cyLchkxR/zITgRi
   dFYViqG5dARjBIlW5+XRfhjyfen7LzctAFffKgx17t6dPyJqIXq8oa4FS
   yc12KFYk3DgfjxI+BQXByasKBh6htbBPTCp93p4l9u/KpcLEJRNLbUK45
   JJov8wKgGqlSoiWJNmwdnX9bsnV7rY4RDgHFSv40McjV77V2MIHItAjcL
   YgOODcihJmJaeJZgHP6P7LwWBAqCvbzO0wX7JTXDRuHaEhd4MwJu+xtgq
   Q==;
IronPort-SDR: eKwC5Yy+kvsNSOk4XkO8BkLjusRhc1Pso3lT+npi9JLhZ/pDuwMHDmmn//YWsggNqeJJ+QDyjK
 nsSGDQrWgw5VA0PfcV0lodRef41qEqgX0Qf+nM4f+uczil8pyuYdrYR6on38fe0gofttboQJpr
 V5cMUmJLnaaIEzcXyrUyGEotPvpxgvIbcUHx/BkC6av/IWBs7SRtbAHAJTHkyZ2NQNGW38uqGa
 qarwc5O/5Fp+NPWN8x2fAPRqpAEd3HI33Dj7FGnRcCwF8c43JUd6ZPDjPjJRgo+Hg6zTq05zmv
 vBLaf6fj4WLxZ3jWxyW2Bkqt
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="134415252"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 22:49:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 22:49:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 22:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4XgieEtez4RIpzFKtFIxCSaN9cJrgpVHUy6rRWqFhE/HyDo3sixCtq53foScEBkc/SlsVnlQlM1ZIc0rdtiIzGyz5mlrzNq4rtVCZMVvPnVukfu0x9om++u2IUJu9C1OrFsIZnjRIa8XNy0UWeZnMmMWa5Fo3iy7T6PUCo4anA5Ge5WhfHZzY9T60MbUVO4XeQ8Msf9GKZ0CNdwBVxRCxl17pFxNxQO5LHHCsRp22yLS5h7MwnV5W0AEsNEIHrd/4F26MdqQXQcjR03cIFIO8Se2Gb3/zK0Lb6W+vrADg7l3Uye6liyds64Xh9csFfWG2ZGj8tmekYzrqQbdd/UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzxvaRG8n6m6tcKKuCkuEvYI8Ym8HAdYcuuPN8+94IU=;
 b=MKdQnSzWTL795VD4Xr7LdE3LirbUIVBdIQrBNN9ALqltAjoAUmqdKPYU8TN+AOImuk1m3lPaslkK+dhiVURtOR+L8iGBXSjG+woOo7FL6v1dvM6RYWusenbFOlCVrT9q3e4PEADQmRqAjY4NqfqUn1O42FfwuAfbZlqZRhFW5NMVLe95IX+I0N1rAFdw969G+KdItKDxI56i6AogbCS2lVUe8J/g+C+ImbC4iGH+4YLkPUT1G8nhtVuGKzRci2JO1p9xbRx2DzntAjGjQBbtHu/EQ2cbq8vWP7b6HpNx6MBDEJIbKgsk5xxV1kTNJk46PXUN7nrvcBeiuBwJeE5JXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzxvaRG8n6m6tcKKuCkuEvYI8Ym8HAdYcuuPN8+94IU=;
 b=uWh5D09YpdGyws3KpPaC7a8xp0UWtdaWGkLUKPinmqPCkLSJ+vBgT0sUUPI91pJvBTQFqo5Y3WD4JP3DyjxSWYIZRQN+6fp5lPPqukDzr2CvUOYbwOqc6jqPQ4jOichKhl+zuFzFjCxlze1sNBSddGvTHxTPt1rs1tkmCfLxBtY=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 05:49:30 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 05:49:29 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <kelvincao@outlook.com>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAADAgCAADeugIABAgSAgAODLoCAAYeKgIAASeuAgAAgtACAADaYAA==
Date:   Wed, 6 Oct 2021 05:49:29 +0000
Message-ID: <14d694a3432de04ceb0dd8c4c5635194f44d269c.camel@microchip.com>
References: <20211006023310.GA1137022@bhelgaas>
In-Reply-To: <20211006023310.GA1137022@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a6af279-4777-4e12-535f-08d9888d1098
x-ms-traffictypediagnostic: CO6PR11MB5571:
x-microsoft-antispam-prvs: <CO6PR11MB557129BADB78DCB32791029B8DB09@CO6PR11MB5571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CvIu9VWkWvw47to2IKS3nLoEk+Ib1VuXiaOwwzGpfc+SjGDREDdFRX9bDZpZborjHL48GruCH86VD2qazE8AMI+WSXHgR3O5XcxY+CteVCJUjgN931HY9k9EBQ4G+XdmqVBT1kX7wbQY6UX57kVrrjR9h7kvkfeG8/PeoFB1/C+7ygo2k5sTpEmTfpEEZwP9kNX7dalItfsdJXqavpor/0gxwIGYW5+VBkhu8kRsUlcih3Irbjwh5VUIKppfocuhMU87IgIDBtSHmMBx7tdl/Fn+aR5LaBJSFihIfPXZvKPmE4DC9aKVWzrT3zpMEnS7VZ4qr5lc1ivIjseubMjIhniIE8jTVhMqRPqqup88RweHdkVS+PRl/HLUe98Kt46SPfu7TQ3yaqS8kGtnwy44mu3RmFAed/XqPi7zsEwDJ6Z3YuNIsE6gDcLgw61McLCQuxkXDOcpFL1WW4NQGT0NbGIfW9I8oE0u5wg4BpFxabRRziieRkQuL7YNTFmQn2BkAlis4JDz3Ld7jr7bTAUaCjCDN8CQtpBca6awJZeEZCCIFGz9wiruBx1tsGT4hPxGqzt1bQh05nM30+a+VP052HLfvjsWQ/CcWt6UCVeoV8OIN4cxPKUGmOyo5L9gQFq1ZZVH9fm05kU/JGulBX4XyHuUqGdYw/DlqkiIRT/nyNdW+wrBbxogVqQZJUUsdSsTYNNb7PbVpfG60OxGbRuCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(122000001)(71200400001)(83380400001)(66446008)(5660300002)(2616005)(6486002)(54906003)(6916009)(86362001)(4326008)(64756008)(26005)(6512007)(2906002)(76116006)(316002)(8676002)(38070700005)(8936002)(38100700002)(66556008)(36756003)(186003)(66946007)(6506007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZklqT21ZdVgrdkZvL0poRTJPamF2LzBHZ0JaUXBpbFN0aWRnb3dGNVdjNnIv?=
 =?utf-8?B?R09VbHYzYkdQYm93RUNHdUVuZ3BMRzZ6eldFRmRtaW1tbkpnUVVSVXJLOW5r?=
 =?utf-8?B?Zk5HeFVBZEV5L2ExdHI1QitmMi82dCtKMXN4TUpZVHlaMyszaERUYVhSMGlt?=
 =?utf-8?B?V21UbjdoMlJoY2EzQ2w0OVdpSTVGcXBKMkpOZFdyN1BHNGxxQkhNZDhEWm94?=
 =?utf-8?B?WFNodW1SZ0lUZmdKVTVNblpvR3djdGFFemU0OGFhUkJvSWNteGtrdjFjM00w?=
 =?utf-8?B?aHMzdjlmYmJSTjc0Mjlua3dwdXk4eEZnSGRxUDVHbENhbEJNSGdPeUdxWW53?=
 =?utf-8?B?VXlvWVlmc2tBS2ZVdXJrZ0hlS1FhMnJvZldSNDBtNFUwTkZUaUQvcUloYTQw?=
 =?utf-8?B?cTRqNFZKOWwwdHE3Mk1LN1ZlenBsQTJZVlJELzZ5TXBPQVRLQ3hvM3NORWYy?=
 =?utf-8?B?TXp5d3ZOMVIrcEQ3eGp1OVBXd1RydEtGQjFZTTNUdEdycWNrM1VkMkkwZ3Jv?=
 =?utf-8?B?QVlqTjhFTkkyRDAzZFUrVDl0ckNMVFh0TVYycWdwdzllSktHcmpETVliaDFv?=
 =?utf-8?B?enN6a09yV29TR2xHN2xZQk9mZ3gyTXJsSkpCQ3kvV1dVTnd5TldoREtUSzMv?=
 =?utf-8?B?ei9ZLzJXUSt4dmlzK05SQmFSc1ZDa3pLbkJkbUtvdExyckRBR2Y1Q240WE1w?=
 =?utf-8?B?MGNqNThLOVI1QjFJUGlDRWdDMDc5MGMrRERmdTBLaU94TWNOUWVBQmIrVm8y?=
 =?utf-8?B?V2pkTnNwaUozdWNOUFdNQ1Q2bDlRMWs1bUZQa2ZxOG9XQzA0WGN5aDZxMVQ3?=
 =?utf-8?B?VzNBWG9mbHVudFRva1pSUmNBUTVnWjNWWnNkNG1aeDI0eXJzOExyTlNlTjVi?=
 =?utf-8?B?YUY2SllpdmNUTXZoVDNPRE1jSEgzdXRrdVRGelp2STVLYmtZT0M1MForSWJW?=
 =?utf-8?B?dmRoaGZsdTBIWThhbmZwTFdtcVJkSmVqWWVnNnNTdzFvS2FNZEJMVVdIS0Zl?=
 =?utf-8?B?dTdpOFpteW5BOGJISnY2YXpoaWh1UER6M240c0F6RUsyek9zVDAzWFdUZWMz?=
 =?utf-8?B?dEJCVCtwMVltWFlvMnRNSGxXL05LQWNlMWpoL1E2Njh4enB4NGM4a29QYnNv?=
 =?utf-8?B?MjZFTEczK3h5ZXFoTUFZam1Pakt1MlcvRVJHd09JTXJtZElmUCtsWUJMTUpq?=
 =?utf-8?B?c2JDUGFHNytxcFhKNDllVURHTDNkNFY4REdrZFhUNmczQ1ZrSzlZb254VFFr?=
 =?utf-8?B?dmVBU1VxRW0rckcyU0F5TFJiWURzbW5jNnZtVkRMWTVmL3NpY2pRT0J0TXpC?=
 =?utf-8?B?ODZsdjF4YmlheXE3aERpZnBveDhmbTU4N0ZwMm40dk1DUVpkanMxeTVORGdq?=
 =?utf-8?B?YmVWSHFLTmNWTnhLT1Z4dGdNZ1RnWkE0MlVXUjZhOTRTaGk1NzluV0pOY2dp?=
 =?utf-8?B?S2lSTzhmaFF1WElteFNWQ2t2UE5RZ1pyanlmMjFVNUFDd1R0TEUwRzdmNkJB?=
 =?utf-8?B?MXdtcXN1bWVUK0NzSWxnQWIrVGVzQWh1WXlwRXMxVlMxNGQ1VXVqV1JTYWww?=
 =?utf-8?B?SEptbnVyWDBZeDUyOUVOekptNzRkZHhYUjdPZGZDNTAvc2FYZUZvMzR1SURu?=
 =?utf-8?B?L3F3YlFSOVlrQm01NmVobUkyR1QwMk9KRll2YWtxcVhkdmlRdTIwOXFBWlhI?=
 =?utf-8?B?VXdPZVJpN0NYSmpjV0RFNWVWVVpBZlROTVNpMVBqZ1cxdC93VkpjYnVKb2Zl?=
 =?utf-8?B?Um50anUrbERMcWplaDJuQU04bFNja2w4TUZ3dy85aWRaMGNDWTQyamhQMlF6?=
 =?utf-8?B?Zm1ZOU1OaFAzTzZEajhNUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCCC2B72A9D7FA4DB479C6606A7E41AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6af279-4777-4e12-535f-08d9888d1098
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 05:49:29.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeL7wF8UAhUylE+YLmR4kbEW5hn2uLu3ldJShiNt/KpqzSHD+P05g6Kvx4b8niZ475sG2x1NsYtutHMhNSJPxBesUNcEbKk3raXP/I3a1ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTA1IGF0IDIxOjMzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAwNiwgMjAyMSBhdCAxMjozNzowMkFNICswMDAwLCBLZWx2aW4uQ2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIxLTEwLTA1IGF0IDE1OjExIC0w
NTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBPY3QgMDQsIDIwMjEgYXQg
MDg6NTE6MDZQTSArMDAwMCwgDQo+ID4gPiBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20NCj4gPiA+
IHdyb3RlOg0KPiA+ID4gPiBPbiBTYXQsIDIwMjEtMTAtMDIgYXQgMTA6MTEgLTA1MDAsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+ID4gSSAqdGhvdWdodCogdGhlIHByb2JsZW0gd2FzIHRo
YXQgdGhlIFBDSWUgTWVtb3J5IFJlYWQgZmFpbGVkDQo+ID4gPiA+ID4gYW5kIHRoZSBSb290IENv
bXBsZXggZmFicmljYXRlZCB+MCBkYXRhIHRvIGNvbXBsZXRlIHRoZSBDUFUNCj4gPiA+ID4gPiBy
ZWFkLiAgQnV0IG5vdyBJJ20gbm90IHN1cmUsIGJlY2F1c2UgaXQgc291bmRzIGxpa2UgaXQgbWln
aHQNCj4gPiA+ID4gPiBiZSB0aGF0IHRoZSBQQ0llIHRyYW5zYWN0aW9uIHN1Y2NlZWRzLCBidXQg
aXQgcmVhZHMgZGF0YSB0aGF0DQo+ID4gPiA+ID4gaGFzbid0IGJlZW4gdXBkYXRlZCBieSB0aGUg
ZmlybXdhcmUsIGkuZS4sIGl0IHJlYWRzICdpbg0KPiA+ID4gPiA+IHByb2dyZXNzJyBiZWNhdXNl
IGZpcm13YXJlIGhhc24ndCB1cGRhdGVkIGl0IHRvICdkb25lJy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBvcmlnaW5hbCBtZXNzYWdlIHdhcyBzb3J0IG9mIG1pc2xlYWRpbmcuIEFmdGVyIGEgZmly
bXdhcmUNCj4gPiA+ID4gcmVzZXQsIENQVSBnZXR0aW5nIH4wIGZvciB0aGUgUENJZSBNZW1vcnkg
UmVhZCBkb2Vzbid0IGV4cGxhaW4NCj4gPiA+ID4gdGhlIGhhbmcuICBJbiBhIE1SUEMgZXhlY3V0
aW9uIChETUEgTVJQQyBtb2RlKSwgdGhlIE1SUEMgc3RhdHVzDQo+ID4gPiA+IHdoaWNoIGlzIGxv
Y2F0ZWQgaW4gdGhlIGhvc3QgbWVtb3J5LCBnZXRzIGluaXRpYWxpemVkIGJ5IHRoZQ0KPiA+ID4g
PiBDUFUNCj4gPiA+ID4gYW5kIHVwZGF0ZWQvZmluYWxpemVkIGJ5IHRoZSBmaXJtd2FyZS4gSW4g
dGhlIHNpdHVhdGlvbiBvZiBhDQo+ID4gPiA+IGZpcm13YXJlIHJlc2V0LCBhbnkgTVJQQyBpbml0
aWF0ZWQgYWZ0ZXJ3YXJkcyB3aWxsIG5vdCBnZXQgdGhlDQo+ID4gPiA+IHN0YXR1cyB1cGRhdGVk
IGJ5IHRoZSBmaXJtd2FyZSBwZXIgdGhlIHJlYXNvbiB5b3UgcG9pbnRlZCBvdXQNCj4gPiA+ID4g
YWJvdmUgKG9yIHNpbWlsYXIsIHRvIG15IHVuZGVyc3RhbmRpbmcsIGZpcm13YXJlIGNhbiBubyBs
b25nZXINCj4gPiA+ID4gRE1BIGRhdGEgdG8gaG9zdCBtZW1vcnkgaW4gc3VjaCBjYXNlcyksIHRo
ZXJlZm9yZSB0aGUgTVJQQw0KPiA+ID4gPiBleGVjdXRpb24gd2lsbCBuZXZlciBlbmQuDQo+ID4g
PiANCj4gPiA+IEknbSBnbGFkIHRoaXMgbWFrZXMgc2Vuc2UgdG8geW91LCBiZWNhdXNlIGl0IHN0
aWxsIGRvZXNuJ3QgdG8gbWUuDQo+ID4gPiANCj4gPiA+IGNoZWNrX2FjY2VzcygpIGRvZXMgYW4g
TU1JTyByZWFkIHRvIHNvbWV0aGluZyBpbiBCQVIwLiAgSWYgdGhhdA0KPiA+ID4gcmVhZCByZXR1
cm5zIH4wLCBpdCBtZWFucyBlaXRoZXIgdGhlIFBDSWUgTWVtb3J5IFJlYWQgd2FzDQo+ID4gPiBz
dWNjZXNzZnVsIGFuZCB0aGUgU3dpdGNodGVjIGRldmljZSBzdXBwbGllZCB+MCBkYXRhIChtYXli
ZQ0KPiA+ID4gYmVjYXVzZSBmaXJtd2FyZSBoYXMgbm90IGluaXRpYWxpemVkIHRoYXQgcGFydCBv
ZiB0aGUgQkFSKSBvciB0aGUNCj4gPiA+IFBDSWUgTWVtb3J5IFJlYWQgZmFpbGVkIGFuZCB0aGUg
cm9vdCBjb21wbGV4IGZhYnJpY2F0ZWQgdGhlIH4wDQo+ID4gPiBkYXRhLg0KPiA+ID4gDQo+ID4g
PiBJJ2QgbGlrZSB0byBrbm93IHdoaWNoIG9uZSBpcyBoYXBwZW5pbmcgc28gd2UgY2FuIGNsYXJp
ZnkgdGhlDQo+ID4gPiBjb21taXQgbG9nIHRleHQgYWJvdXQgIk1SUEMgY29tbWFuZCBleGVjdXRp
b25zIGhhbmcgaW5kZWZpbml0ZWx5Ig0KPiA+ID4gYW5kICJob3N0IHdpbCBmYWlsIGFsbCBHQVMg
cmVhZHMuIiAgSXQncyBub3QgY2xlYXIgd2hldGhlciB0aGVzZQ0KPiA+ID4gYXJlIFBDSWUgcHJv
dG9jb2wgaXNzdWVzIG9yIGRyaXZlci9maXJtd2FyZSBpbnRlcmFjdGlvbiBpc3N1ZXMuDQo+ID4g
DQo+ID4gSSB0aGluayBpdCdzIHRoZSBsYXR0ZXIgY2FzZSwgdGhlIH4wIGRhdGEgd2FzIGZhYnJp
Y2F0ZWQgYnkgdGhlDQo+ID4gcm9vdA0KPiA+IGNvbXBsZXgsIGFzIHRoZSBNTUlPIHJlYWQgaW4g
Y2hlY2tfYWNjZXNzKCkgYWx3YXlzIHJldHVybnMgfjAgdW50aWwNCj4gPiBhIHJlYm9vdCBvciBh
IHJlc2NhbiBoYXBwZW5zLg0KPiANCj4gSWYgdGhlIHJvb3QgY29tcGxleCBmYWJyaWNhdGVzIH4w
LCB0aGF0IG1lYW5zIGEgUENJZSB0cmFuc2FjdGlvbg0KPiBmYWlsZWQsIGkuZS4sIHRoZSBkZXZp
Y2UgZGlkbid0IHJlc3BvbmQuICBSZXNjYW4gb25seSBkb2VzIGNvbmZpZw0KPiByZWFkcyBhbmQg
d3JpdGVzLiAgV2h5IHNob3VsZCB0aGF0IGNhdXNlIHRoZSBQQ0llIHRyYW5zYWN0aW9ucyB0bw0K
PiBtYWdpY2FsbHkgc3RhcnQgd29ya2luZz8NCg0KSSB0b29rIGEgY2xvc2VyIGxvb2suIFdoYXQg
SSBvYnNlcnZlZCB3YXMgbGlrZSB0aGlzLiBBIGZpcm13YXJlIHJlc2V0DQpjbGVhcmVkIHNvbWUg
Q1NSIHNldHRpbmdzIGluY2x1ZGluZyB0aGUgTVNFIGFuZCBNQkUgYml0cyBhbmQgdGhlIEJhc2UN
CkFkZHJlc3MgUmVnaXN0ZXJzLiBXaXRoIGEgcmVzY2FuIChyZW1vdmluZyB0aGUgc3dpdGNoIHRv
IHdoaWNoIHRoZQ0KbWFuYWdlbWVudCBFUCB3YXMgYmluZGVkIGZyb20gcm9vdCBwb3J0IGFuZCBy
ZXNjYW4pLCB0aGUgbWFuYWdlbWVudCBFUA0Kd2FzIHJlLWVudW1lcmF0ZWQgYW5kIGRyaXZlciB3
YXMgcmUtcHJvYmVkLCBzbyB0aGF0IHRoZSBzZXR0aW5ncw0KY2xlYXJlZCBieSB0aGUgZmlybXdh
cmUgcmVzZXQgd2FzIHByb3Blcmx5IHNldHVwIGFnYWluLCB0aGVyZWZvcmUgUENJZQ0KdHJhbnNh
Y3Rpb25zIHN0YXJ0IHdvcmtpbmcuDQoNCktlbHZpbg0K

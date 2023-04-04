Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770A6D56DC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjDDCoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 22:44:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C21723;
        Mon,  3 Apr 2023 19:43:51 -0700 (PDT)
X-UUID: 868774bad29211eda9a90f0bb45854f4-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vuYJ9+Dhv2WypHmvGc5UX8VJbGOSnaLw8HWiB511qvU=;
        b=Zz3zAp2y/PIHNLsYftnocZ5zqI8507I7WA39jaIB9l/bINcXcAC0ApQOT5TOTr6pqc8plhjHWPJZE6Q6YsRlPqbcMKRh5x7n7aFWMWMmSlLVdK9vNgA0Yd0hcQJABBER1kPsp8EjSvDyeqdng3KPdOKOeu3yccH/zQ7Hs7whrO0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:5c8bd37e-d4dd-456f-a6d1-5503dbe369fb,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:5c8bd37e-d4dd-456f-a6d1-5503dbe369fb,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:3aff4f2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230404104348YNKTEMH5,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 868774bad29211eda9a90f0bb45854f4-20230404
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1869631324; Tue, 04 Apr 2023 10:43:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 10:43:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 10:43:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2k2zk/4ezalLT/F/0cZR5twu2PY8R4pB+GUvzXwzTnEovhnY3XKjnpK7OYe7NMAHL4PpLLoJuoUgyTNiRyjw4shZ6uIqPc7TvfZuQR84/RXj5t54K0JLaF71pYpbXDB2BU48X2c8vbNJ5Uf6CD4eCE6yiraLLmoc+zlz+LnxcbC7DExRIJeJ88ak7AEEvKwbVjrLhoy2UsduXTowQKNqSCZtLF/TdWi+DuJgf91ZnqMvmxPCPAXy6SvCHYAcz/8doz5E/FGKklOTL7Qvh2eS5ZLwccjXZruz37ejiIotxrovPnDhZ8W9KXLdsgZ07FpMEVnPu499kKW8uoResmSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuYJ9+Dhv2WypHmvGc5UX8VJbGOSnaLw8HWiB511qvU=;
 b=cvOAZn72ky2uSVYkjFeoIEhvGHXPAZzn/Th8UZ3PyPjbZl8r9eY985fmef84DG9AQXSZ2wl3Go/ARWnMQ31rtaNQ9r4WBV877k7FCigUxRiPukUmmKZOoiHxAP2tF7lbf0mOMlqPwgdV7qL+ruvcY9RsyqgGMLJmS90vbS0yFqc5bi5zIUoec6OLxhxi0b2nM1J6SSjvDlAtsxzw47491QPePeWy+FcQWdKp1fkyYTTVrWoywgt2gLvDMny+ttG+yfJq/mkyTMgfCRbOuaL8XaxBeHmWuAhOw0JyY4fXd+ik96lsBioQ2xNPUj8KSasDbOZ89D2+jQXV/Gw19jCWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuYJ9+Dhv2WypHmvGc5UX8VJbGOSnaLw8HWiB511qvU=;
 b=qXLzg9AQaooMzAu0uJfCjmXPTSY4yyKbcTFSle/lsH3P2CQZdAQvNQzR90Ik+NCZI5n+piGWElTjyIdSK7Es9ER2rvUeblixvyoF6hQ4U+9f/PlJlhoUixI0oyhcqKF62vlzRup9mRBxi94XpOhOM0TwWCkX5yratnQ3iytAD9A=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by SI2PR03MB5195.apcprd03.prod.outlook.com (2603:1096:4:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 02:43:44 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::38c1:e1ce:1cb4:fe7b]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::38c1:e1ce:1cb4:fe7b%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 02:43:43 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Topic: [PATCH v2 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Index: AQHZT/a0tqRa1NimPUGjd8UpfFnzI68FjKKAgBUR+QA=
Date:   Tue, 4 Apr 2023 02:43:43 +0000
Message-ID: <db5a5035d1bb08cb501443ac1326dfd8737f65f8.camel@mediatek.com>
References: <20230306064059.7239-1-jian.yang@mediatek.com>
         <20230306064059.7239-3-jian.yang@mediatek.com>
         <20230321165755.GA942823-robh@kernel.org>
In-Reply-To: <20230321165755.GA942823-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|SI2PR03MB5195:EE_
x-ms-office365-filtering-correlation-id: 8e03f7b9-7f5b-471d-6b2f-08db34b6681b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yOjTR+Lp2kloL8HaM3LfkFrxtO3UwUrzVeoOS9MCulaKlWQpovjeAFEpiWJGSx9xB+HWUkKLrS9ukL2JGT7aYcWkWLfjT7+6ijQywsn0gYvSgUfbkfuvR9oiCmGVu9SwhhQeiUAYXBNWiRecGzHjwtYGdiPg/i3Jm7bftxGeDaWE+dkAXyU7VzP2O140vNFcJdbzdCf8LhZxKQk8m8r4aKUavOg4YEEpb2IKTJ1gOwLyVN/vX2zgkf3U6OUzvt5cQdt+gaxW95g5wFUcslffO+3ZwCtVlEEhsWhGhOR06Ilnw5aeT0YfRM4co1m8wwOwuGnjo9wuZ2Y4StVeHnLgO36+Ycm+5WUYFAfC3BfeZ8mkiuX7CjZ/8JCnE/VDwTp6nxCT8pY1G0PHfdlXr0Qkdr7C8xedLRaZr7Anskfa+oc87W/dOP9c06URZt4+xDDbpJGgumHegGLrSbyC1tIKHWip99CeHKLyC2cHiBJubTDvCB5OFObKMeg1y+xT9ksQVdO3lLYDYAwndmqtEHZX87AXK4iCXe2tTFw9PyHX3n9zhgvd5ZxS4z96CKwDeOwB5t2YsaCZFWcCuxEGmRMgar52ncIYrnpERmvenQwoFOuCsj+pqBJ5de9Zs5BkP11+mE1KuGUbeWmyIjfwF27N5p+pkLiw4u6SHwX+9YqzXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(66946007)(26005)(6506007)(6512007)(83380400001)(2616005)(6486002)(122000001)(66556008)(38100700002)(41300700001)(71200400001)(66476007)(186003)(66446008)(54906003)(316002)(478600001)(7416002)(2906002)(91956017)(64756008)(76116006)(86362001)(8676002)(6916009)(4326008)(5660300002)(85182001)(38070700005)(36756003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUdmYWdDQ1RhWTJVcXB3UjZQalY5cVRaWlZpTVlFK3hUcVR2akNwTGRENzhn?=
 =?utf-8?B?RVhmc2xrL3k4UVF5R3gybDU0ei95b0FQVHB2S3hrM3hwd2ZFVWZGMytEaDVk?=
 =?utf-8?B?c3JjK1oveGFVM3ZBTzdrOHFWUnJMTEVkQlhwaERIbllFa2ZFYjJqcS9nenla?=
 =?utf-8?B?UFV4K1hQdzN2VEhiY1pBcS9CUkJZTEFEdElZTk1Va3BTVWVaczk4WnUvd3VV?=
 =?utf-8?B?b2l6cXdQV1VEOE1sSWlvdGJaby81YUQza3RPTVJpZjViVHpEU3lBa3c0emdQ?=
 =?utf-8?B?REdMbUFDN1dKWENkS2RqQzZsKytVVjU5QnhFNHpjQ1d6ZGQ1eEY2TW1NWGIy?=
 =?utf-8?B?V2VmWFRBT3dLK3V0UEdPSnAxNHBYQXdSNC9UblcyKzB6MzJ4cUxIZnhQeUdx?=
 =?utf-8?B?SFpDQXdaZzVvdnc3RDBaM2xxalBPRXhCZGJCMG5ML1BDTFV1Umw5RzJLTFRF?=
 =?utf-8?B?Y001bk1GMmg3SUxoSjFBUW1vMVkrNEU5YmhDWW9mamRRVEU3ZHBmY2lidGRh?=
 =?utf-8?B?dHZNOGF5Ylg2M1ZNU3pFT2dTd3loRVdLMi9iWEY2eUNWUmdQYUxNTGtWMnRB?=
 =?utf-8?B?akVCWHc5R3U5MHYreGFMWTlSd05NVXlIMjdROXNxelJpK3ZMY2pFajMxemRy?=
 =?utf-8?B?c0xEcTRIb0lzYzZGVHRTYmxLeisySDVuMDgwM3loQjUzaDVrSEZvdUJ3eVdq?=
 =?utf-8?B?a3c4ZDA2dDJaNll3Zi9Oc3pBVTZZV0dBWlI4MHM4b2Y2ZXora3lmRFE1Rm5E?=
 =?utf-8?B?RDZncEswNS9DMEpYRkExbFQ3ekV2QzFIZDRnV3RncGRPazZjZFltZ25IMkZv?=
 =?utf-8?B?d0U4VFhjNURvakZRcmVIa2UveWtQTGxwRWM3ZjhvRjBIVEJIYXJOWWFOdElT?=
 =?utf-8?B?a3dBMmYvdVdYY1BBUWV4QThMaW9SamZTaGFQSXQydHl0MmYveFlqdUtGVTdU?=
 =?utf-8?B?RWNJOENYamdNbzhqVTE3Y01XTk1hYldYMmRPR29uYXhmSkdPTXFCaWdVK2xp?=
 =?utf-8?B?T01GNEk4Y0dVa2dGWGxiVnZqL2hDUUYrcUxWZW9MYWZISm5STzBxREFIeHNP?=
 =?utf-8?B?cUd6dTVvYVowN0cwVllEWWYwd0xJTUxuOUF3YS9NU1V3NTBFT3NTZ3dmOFV2?=
 =?utf-8?B?TG43SzVXQ3FmY0hCc3haenp0M2k5VkZmRER1NkNFTDd5ZWtObWlEc1Vlek82?=
 =?utf-8?B?MC9pa0taZ21WTDBVK1JqczJUWHZEWGxCZEpyRkJ0SnVHMXAyVGFub2hzNHV4?=
 =?utf-8?B?d1RiTlpTUXFqUVFhUks1a05SbFpVTzY0Vm9RQzJkaE1PR1BQcHhLT1A5b1c1?=
 =?utf-8?B?SnhONjRXUlp5UmM1eVJRT2NsWnhvMTlvdDlXNWl3TDNjMGovL245MGNDVzl1?=
 =?utf-8?B?RzlBUTFrN1BSbzRjL01uTTVLTkhQLzJ0TVphZEJwaThIUnpITjdBa0pDbStj?=
 =?utf-8?B?dFB6em5QdFlDR0NJQnBPZmJaR0c1RzYvWGtieTJMcDAyckRvZ0s3Z2V4OXIw?=
 =?utf-8?B?dElIbGRCNzlFYUJiRlhyQkQxNGoxWnR5d3ZGMzd6TnFFVWt4MHoxWjBXbEpi?=
 =?utf-8?B?MGwyOWEvN1RvQ0NkNVF2WFZab3BleUF1NTNWbVBiYXN1QkFTSVlIUUtBU3gr?=
 =?utf-8?B?T25xSlpsK2ovM3czMFFPQnBaN2FFZFZKT0hSZXJTWENYdDdEWmFsd3hydzYw?=
 =?utf-8?B?aEl1K3RCTHdkdTUxV2FsVUtST3lyYkl6elR5aHEyOE1oZzB0R2xLcjFSL2Jv?=
 =?utf-8?B?Qy82YWl3WERRY0twRk9JSHREdUczdncydjZzMWwvNU9GWkpaR3RCTEpaVy9P?=
 =?utf-8?B?eDVtWVZrbUorT2U1cFVtbXl4SUxaeDZCTVUvRFZNaGFTTC8xZFA4cFdxYUl3?=
 =?utf-8?B?SC9Ha29XU3M1TWNsblFCcFdRVUc4K3FPMTdWVlVDNkZSaU5Fb2ttSzFvd052?=
 =?utf-8?B?UXAyTmVreUxLTERFUEEwU0VFNUtobjZVWi9xTTRjclRxZEFud1VUS3ZiYmox?=
 =?utf-8?B?dnVWS1NYRTNHaWk2UjNDTlQ5SFVJZGt3MHBZRXZrM1VNV1R6QmJNSFphdGh0?=
 =?utf-8?B?RlFnMnppVmV5anROcHYvWjZIN2kweUIyNndoQkhaK1FrTWh1bDVuZk9FQ2Vp?=
 =?utf-8?B?RGQySVhnVmEzWmRtMTBYZlVkSStRUnpYS1ZtVVF3N2F3Z3EvWGgvRXFkeEJz?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DFFDED0C854EB4B9A8C5C0E921E93D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e03f7b9-7f5b-471d-6b2f-08db34b6681b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 02:43:43.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2mJ2e85MecDL/pFEFYK9PlHm4l0uGsf/1DXIxgb8Uk2gOyQhqmj85bOQqrf2yBlowvAItfuc0dWr71GGZj8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5195
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBSb2IsDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZSBhbmQgdGhhbmtzIGZvciB5
b3VyIGNvbW1lbnQuDQoNCk9uIFR1ZSwgMjAyMy0wMy0yMSBhdCAxMTo1NyAtMDUwMCwgUm9iIEhl
cnJpbmcgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gTW9uLCBNYXIgMDYsIDIwMjMgYXQgMDI6
NDA6NTlQTSArMDgwMCwgSmlhbiBZYW5nIHdyb3RlOg0KPiA+IEZyb206ICJqaWFuLnlhbmciIDxq
aWFuLnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IE1ha2UgTWVkaWFUZWsncyBjb250cm9s
bGVyIGRyaXZlciBjYXBhYmxlIG9mIGNvbnRyb2xsaW5nIHBvd2VyDQo+ID4gc3VwcGxpZXMgYW5k
IHJlc2V0IHBpbiBvZiBhIGRvd25zdHJlYW0gY29tcG9uZW50IGluIHBvd2VyLW9uIGFuZA0KPiA+
IHBvd2VyLW9mZiBmbG93Lg0KPiA+IA0KPiA+IFNvbWUgZG93bnN0cmVhbSBjb21wb25lbnRzIChl
LmcuLCBhIFdJRkkgY2hpcCkgbWF5IG5lZWQgYW4gZXh0cmENCj4gPiByZXNldCBvdGhlciB0aGFu
IFBFUlNUIyBhbmQgdGhlaXIgcG93ZXIgc3VwcGxpZXMsIGRlcGVuZGluZyBvbg0KPiA+IHRoZSBy
ZXF1aXJlbWVudHMgb2YgcGxhdGZvcm0sIG1heSBuZWVkIHRvIGNvbnRyb2xsZWQgYnkgdGhlaXIN
Cj4gPiBwYXJlbnQncyBkcml2ZXIuIFRvIG1lZXQgdGhlIHJlcXVpcmVtZW50cyBkZXNjcmliZWQg
YWJvdmUsIEkgYWRkDQo+ID4gdGhpcw0KPiA+IGZlYXR1cmUgdG8gTWVkaWFUZWsncyBQQ0llIGNv
bnRyb2xsZXIgZHJpdmVyIGFzIGEgb3B0aW9uYWwgZmVhdHVyZS4NCj4gDQo+IElmIHlvdSBoYXZl
IFBDSSBkZXZpY2VzIHdpdGggZXh0cmEgc3R1ZmYgdGhhdCdzIG5vdCBzdGFuZGFyZCBQQ0kNCj4g
c3R1ZmYNCj4gKGkuZS4gd2hhdCdzIG9uIGEgc3RhbmRhcmQgY29ubmVjdG9yKSwgdGhlbiB5b3Ug
c2hvdWxkIGJlIGRlc2NyaWJpbmcNCj4gdGhlIFBDSSBkZXZpY2UgaW4gdGhlIERULg0KPiANCj4g
VGhlIHN0YW5kYXJkIHN0dWZmIHNob3VsZCByZWFsbHkgYmUgaW4gdGhlIHJvb3QgcG9ydCBub2Rl
IHJhdGhlciB0aGFuDQo+IHRoZSBob3N0IGJyaWRnZSBub2RlLiBUaGF0J3Mgb2Z0ZW4gb21pdHRl
ZCB0b28gYmVjYXVzZSBtYW55IGhvc3QNCj4gYnJpZGdlcw0KPiBvbmx5IGhhdmUgYSBzaW5nbGUg
cm9vdCBwb3J0Lg0KDQpJIHdpbGwgYWRkIGEgZGVzY3JpcHRpb24gaW4gRFQgYmluZGluZyBvZiB0
aGlzIGRyaXZlciBsYXRlci4NCg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGppYW4ueWFuZyA8
amlhbi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDg2DQo+ID4gKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay1nZW4zLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4z
LmMNCj4gPiBpbmRleCBiODYxMmNlNWY0ZDAuLjQ1ZTM2OGIwM2VkMiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+IEBAIC04LDYg
KzgsOCBAQA0KPiA+IA0KPiA+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW9wb2xs
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pcnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2ly
cWNoaXAvY2hhaW5lZF9pcnEuaD4NCj4gPiBAQCAtMTUsMTEgKzE3LDE0IEBADQo+ID4gICNpbmNs
dWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvbXNpLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9ncGlvLmg+
DQo+IA0KPiBUaGlzIGhlYWRlciBpcyBnZXR0aW5nIHJlbW92ZWQuIFlvdSBzaG91bGRuJ3QgZGVw
ZW5kIG9uIGl0Lg0KDQpJIHdpbGwgcmVtb3ZlIGl0IGluIFYzIHBhdGNoLCB0aGFua3MgYSBsb3Qu
DQoNCkJlc3QgcmVnYXJkcywNCkppYW4gWWFuZw0K

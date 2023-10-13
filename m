Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874947C81FC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjJMJ0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJMJ0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 05:26:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE93C0;
        Fri, 13 Oct 2023 02:26:20 -0700 (PDT)
X-UUID: 8ef2652e69aa11ee8051498923ad61e6-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SiKztumixHPNP3r2ID54Dly1NdOPxTlAFImCTigEmPA=;
        b=BcR2C1ukaHwOPGgTFAUZA+hCumsF3MPmukFu/yT6KCSkwTCSZtrWETkRKY/JZbVsyFXpirxOxsvGE3kRWKbIyTEERuN35joA+AwCTWZ7PSFPQgaLudY2Di8wEs5u/+qhmbmcMTA3muJ+v+7VtXHSZI9XrG2qMgQE7Jegwg8gtN4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8987361f-719d-4902-ac25-195d25ffd40d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:3126e5bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ef2652e69aa11ee8051498923ad61e6-20231013
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 230687313; Fri, 13 Oct 2023 17:26:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 17:26:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 17:26:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9RmsyfyFfxlTFBZrmli6dJXsxe60dZFiJqnNJVcwvm0NkgZaXnBt7hPp8N7SjIwhLKY5hJtVtdh56VhbpVk596aeWaYzGtKY3xUJZ6AqLG3sxBdyi8t1aHwkT+1CNb/eoI2F0Ukcm6l4pSLMDRu0yPC7g4V2ank75GDvT11861bpFelHUf911Z7xhX5I20ti7Md1OYl7Wyr8/vPaEK/L6eNGJXcofOxS6ngKDdJBxekNain/g3Xpe0hn+t9tx3ZEdLyxW+lHlBNdfPuFRIdVlf3tlv3kZBtzdyHt/oxXPMVpWcvnQAT9NFcBUvfFXyLuCUHPhsdacyQAtCjrlg4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiKztumixHPNP3r2ID54Dly1NdOPxTlAFImCTigEmPA=;
 b=clL26Lr4yX5PN+nMKxvq6M7xOLql7cDrtQDq5+Uk0jquUB7XdmUVJ6v3VvBz5fgcg5oG6bDYPc9D2CscjoEjFnCY7dZYkljmUqqZKcn6TRZXFDZXm4Y/ofvejh88uZFtWhRLnBotAFAb2T7PBLT3dzZQb0U6Ut1CZtHTpzwslwTUVIzJKpJ1GYDITg8pjAJoDZq6Tz0qCWqWmNpC1vUrXVwQT76iwtdLakB02wSFE6yuYIlW9F7x2CNKvPxF1hAZW24XKXatNtuzcKmmqPvAsu5a+fw7PFwmhAdZbouJQ2DacIEGa62N3oir6bgz9p26nWg326X9PUzT4V8xaFLq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiKztumixHPNP3r2ID54Dly1NdOPxTlAFImCTigEmPA=;
 b=M4jIR9bnSt4tnzNX/xii1RbCFJ28dR58f4YQiKCaPy6QInJgv/iIM9gRSoc1r8DE1l0Bbrt6noGFyGsAM1FECnR2eHC86GocBBv5lpSSyMqe2TvgEZc8AyXLlA8z5Dncr7Z3Deeo7KXuZhSAjedYWEUiVeFyz2azeulwRqo+Mk8=
Received: from SI2PR03MB6026.apcprd03.prod.outlook.com (2603:1096:4:14a::10)
 by SI2PR03MB6685.apcprd03.prod.outlook.com (2603:1096:4:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:25:42 +0000
Received: from SI2PR03MB6026.apcprd03.prod.outlook.com
 ([fe80::a2b9:109e:5c84:c061]) by SI2PR03MB6026.apcprd03.prod.outlook.com
 ([fe80::a2b9:109e:5c84:c061%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:25:41 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Index: AQHZ+o3GttWZVka2VEmjNKXZkLQaFbBCyASAgASxVwA=
Date:   Fri, 13 Oct 2023 09:25:41 +0000
Message-ID: <8566967beec62f50c2425551b49bb29bbd3f8405.camel@mediatek.com>
References: <20231009084957.18536-1-jian.yang@mediatek.com>
         <20231009084957.18536-2-jian.yang@mediatek.com>
         <50bb99ee-8ef3-343e-7359-526662f511cb@collabora.com>
In-Reply-To: <50bb99ee-8ef3-343e-7359-526662f511cb@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6026:EE_|SI2PR03MB6685:EE_
x-ms-office365-filtering-correlation-id: acdfd1a6-91f0-47e1-c556-08dbcbce5eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oi27V691GZH6iUsLVfeoapMzrtzpbM5uzv5BZpUezS9dbP5z9Pz8/dtyynw1gnE9xVPngi8s7nMh/rjS3VWjA01pW5VPVCTPJjEVZR8Y3eeUlG+mRKw/4AjmftGtKXYTLqDq+bAh7M0jsDANY1Q4fMwHfncfjmgwLLxa+yiz6OEoJQGr3Rw5iXXKN5aJirwlScRKB/fWoKLqCu20CGqVBnXXAnC4aqE+aJwPfr5d5UeiKjDp4DP9uc/LT70MdyHwgPPmZ/Vs1qci3j6yDOVvyJ0SvDTink3YrJDqkNMyuodbiRID+EnxE12T73lE+QqiVsSgKVg8vHENTuwR3220rZzYtMTw9xSXGDTZultInDwuNasanOBqbgVfKAPw4P203zrxz0vtvCLeIBkct44aVmxbr1bzHTITdaesnWO0IZMEQ4D4ooxAE60HDpNdFldcUzIst6oNHB7YbmCPcFyiKckOgeog01t89Cl0pHXk5/Ybcr51xjzziWwV3aSMrDLbTw8EY4TVJ6RQjrejud0o9jlMUgPOCcqz8qJYfdtTLHdmzydXxH8ZS3GaBTGEcqR7ukcfDKcD6jjhJkKXDhhS6p30jsf8g74BmEJtZ/YZwZZwcDdVgqLro1M3LDWfnl/qwjjfGIAyWC5nqvwG16i2piU1de72xM8yYt3VjKvZcZE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6026.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(8676002)(8936002)(4326008)(41300700001)(5660300002)(76116006)(64756008)(66476007)(54906003)(66446008)(66556008)(66946007)(110136005)(91956017)(26005)(6512007)(6636002)(38100700002)(71200400001)(6506007)(316002)(38070700005)(86362001)(122000001)(36756003)(7416002)(85182001)(2616005)(4001150100001)(478600001)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FybjZaSkFXT2lIMGFTWjRLT1BmWFI3aGp4LzM4MnMzZUk0bWZDOTFKTTB3?=
 =?utf-8?B?cnJoNFdNV2FiVFY5Zlp1ZmlSQWxTKzVpYjh2aWc4UEgvaWU4NmdabVAzZVZP?=
 =?utf-8?B?OTdLdzdYMm5Pei9WWVYrZ25uNFlKR0R4Smd6NGh6empOOXIvV3lyUUNsb1VH?=
 =?utf-8?B?cXV1ZDU3ck11RUZhYVVWZmZ1MTNqTEZkKzYxSU5zSnpEU1ZHdXNRZnJJZVV0?=
 =?utf-8?B?Y2F2VEpQWjlqTjNiNWdpbEUvY3Y3dUppc3FWb0dvVUpoalR1Z0w2UWVyTENO?=
 =?utf-8?B?U2VEalZDS1o0U0c1VW4xOWwxcHJXaHQ4dHZMMEVRVGU0MEJZRkVkbCtHa0o2?=
 =?utf-8?B?bTRXY1BQM293Ky9CakJqZjV0aGhiS0VWWHpXUU0yblhQSm9WNytqWHBOWFVx?=
 =?utf-8?B?U2d5RGowUHJQVGV5ZkVRa2ZNb2dubjVURy9GOUtWeGxNblJyb2VSeTlBWVlK?=
 =?utf-8?B?cUlvZTRjN0N3Nkx6eE5hSnRydGVPem5lajY1TWlxMWlNYTN5bWlLZFdqNk9k?=
 =?utf-8?B?dmtSWlA4SWpQd1UxYlhEUlRHckxMb3p5MXkya3dOM245b3lUNm4vVTcyaU9I?=
 =?utf-8?B?YW5KdmduejFMMVhkTlFRdE5ESy9iQmk3TWNRcm9iMWVmc3NVNUZiYUxRSGtC?=
 =?utf-8?B?bm9LVnMwT1hrUWdjSzIrYitoTjJ6WjlnSVhQQk5mbHQvN2ZEWlBaZy9ZSkJp?=
 =?utf-8?B?d3pqcXdiU1dJbm1OcDR5cXQ5TEpzdUVhNW9tWVNmU0ZDS0xpbjIwem9Ldllp?=
 =?utf-8?B?ZlExblBWa2pUWmNwallGQU9KaDl0UFVSWE1VOTVXNTZrekczRmZTZ0xDYWdQ?=
 =?utf-8?B?U0Z6TkpXUGhibkdXbHJ4SkszbEFFSVF5Y2szYmFUUEc5RVBLeW9xVW1kZUtX?=
 =?utf-8?B?Zkg1dmVtQ21HdXBYaENERVFLZEdkRzhiTFlHWFNkTTFOZlVUVzNpc1hITDVi?=
 =?utf-8?B?U2NWTFA1VHNmakxsdzR2SHk1S24xYVZlVWFUVjhoS3AyQUM2enF5bWk4S1Vo?=
 =?utf-8?B?ak5vSnN0ZEp5aVU1TmE4cGJvQmpnYXVUKzFWQUp6RmRLS0ZIckdHZnZSbTdR?=
 =?utf-8?B?bVBldDB2ZG9jZ0JNeExKTTkxVSt1bW9lQVZEb2FmWWViLy9oZStydkYxemxT?=
 =?utf-8?B?TlBQaDVNbC9lWUE3Y3RIYzV5S1FlRVpBUEtCa1F1aVdlRlp5eWxVdFltYVVl?=
 =?utf-8?B?VmsweXVGN0ZJL1dKTmp3MmJzQ2FUQ3JSQlRSSDBtZ09zUHdqc1VIZUc3TkJq?=
 =?utf-8?B?MHRRdmFZRHJrL2RvWFd2K1FQdWthblZRbGhTNFR0QmJzZ3dLUHBHK0JScm9H?=
 =?utf-8?B?MTlnVVJ1aTAxd1Q5cFR1U1RrdUViTjk3VGJsY2FHOHlVcDRxb21xdytMUmM4?=
 =?utf-8?B?M21IcU1neTMwZDFtQnBNWE9hSmsrWVA4R1BmcURmZHArQS84R1JlNFYzMTk5?=
 =?utf-8?B?eEt4aFE3dndzVXlaSWVQSnhHTWRkWDh1NFRoaGlPTld6czRaRFVoQ1pmTmk5?=
 =?utf-8?B?OUo1SG1LZW9mMGpXRnVHYkN3djZXRVdXbklnS3ZMdXR4V2RkYnZ4ZWJlMm9m?=
 =?utf-8?B?bXhoNkd0NnBnLzBLdStRcDFVb1RXbVd1YVZWSmsxc1dCTFRYQlFLc3gzQ2U2?=
 =?utf-8?B?TnBvbGpxeHloVHpyMjVyeVVrakloT2F3N08xakZ1RGpVb1VhV2NlYndxbWgy?=
 =?utf-8?B?MGNidTNPRnhMZDltU0Z6d0NveG5yRGYrcHFDa1hEeU9HaXVMa1NDVzdLSGxC?=
 =?utf-8?B?Sk4vejJiaVp1a3d2QnBvVHRrWEVNK2xoT2hhQzQzRXc4VzRQWW5ROWxZVEUr?=
 =?utf-8?B?SWVLVjFpaURxRnlpd3paQmdkR3lzc0kwR3phTW5YeGY4ZGgrTlpsNUdmYis3?=
 =?utf-8?B?dE4xN1F5d0FGZUNJQXR4MHZjWkYzTFFVbzJzNUVqYXZSdmN0MDdqSmxKVjBO?=
 =?utf-8?B?bnJHTVA0V2lQeEUrcGdXWWN1UEpQWDRwQmxvSHV4VENnUmRtVjlMbnZKZVBx?=
 =?utf-8?B?YU1DYUZDa2xVaHgvSy9tUkJ5cHNRTktFWWNsbnJzMU9oQ3g2OVgyL0ZLa3pI?=
 =?utf-8?B?VVh5OWJwaU5ldWlyeUJuYUxQWC91U24yckVKbzRtTFFVeTB4WHRJRDdFNU5G?=
 =?utf-8?B?enZlRTJoT2EwcjZET2tYUWx1QzYrTnNIUmN2U0s1TDErckcxandaaFBwVXlY?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E9D49E85D720049812DD0C8F586F44B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6026.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdfd1a6-91f0-47e1-c556-08dbcbce5eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:25:41.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjDjsbk3YrXlHv7IooTNJrY+5wtpj6PA2GDbVxFZaWX7htkrqjVCmxSx5+JSG9bknB8EZp2X9TVGyPdEtLLOMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCg0KT24gVHVlLCAyMDIzLTEw
LTEwIGF0IDExOjQ1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4g
SWwgMDkvMTAvMjMgMTA6NDksIEppYW4gWWFuZyBoYSBzY3JpdHRvOg0KPiA+IEZyb206ICJqaWFu
LnlhbmciIDxqaWFuLnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBuZXcgcHJvcGVy
dGllcyB0byBzdXBwb3J0IGNvbnRyb2wgcG93ZXIgc3VwcGxpZXMgYW5kIHJlc2V0IHBpbg0KPiA+
IG9mDQo+ID4gYSBkb3duc3RyZWFtIGNvbXBvbmVudC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBqaWFuLnlhbmcgPGppYW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4v
YmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sICAgICAgfCAzMA0KPiA+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvbWVkaWF0ZWstcGNpZS0NCj4gPiBnZW4zLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtDQo+ID4gZ2VuMy55YW1sDQo+ID4gaW5kZXgg
N2U4YzdhMmE1ZjliLi5lYjRhZDk4NTQ5ZDEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1n
ZW4zLnlhbWwNCj4gPiBAQCAtODQsNiArODQsMjYgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICBp
dGVtczoNCj4gPiAgICAgICAgIGVudW06IFsgcGh5LCBtYWMgXQ0KPiA+ICAgDQo+ID4gKyAgcGNp
ZTF2OC1zdXBwbHk6DQo+IA0KPiBUaGVyZSBhcmUgYW5vdGhlciB0d28gY29udHJvbGxlcnMgaGF2
aW5nIHN1Y2ggcmVndWxhdG9ycyBhbmQgdGhleSBhbGwNCj4gaGF2ZSB0aGUNCj4gc2FtZSBuYW1l
IGZvciB0aG9zZSBzdXBwbGllczsgQ2FuIHlvdSBwbGVhc2UgY2hhbmdlIHRoZSBuYW1lcyB0byBi
ZQ0KPiBjb25zaXN0ZW50DQo+IHdpdGggdGhlIG90aGVyIGNvbnRyb2xsZXJzPw0KPiANCj4gdnBj
aWUxdjgNCj4gdnBjaWUzdjMNCj4gdnBjaWUxMnYNCj4gDQpJIHdpbGwgcmVuYW1lIHRoZW0gaW4g
bmV4dCBwYXRjaCB2ZXJzaW9uLg0KDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gDQpCZXN0
IHJlZ2FyZHMsDQpKaWFuIFlhbmcNCg==

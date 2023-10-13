Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A97C7BBB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 04:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJMCxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 22:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 22:53:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DB83;
        Thu, 12 Oct 2023 19:53:15 -0700 (PDT)
X-UUID: a5385424697311eea33bb35ae8d461a2-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0dP/3MXwSgRw53KAZqk1eoubhqIdFcS9C6B0zaODaH4=;
        b=QAqshuruj3oPMXRVyoFZgTPD9S7qO8NAxWrPsB4ZAE7bal6pc+2w1Ef3Zq4i9g1k/d0E8PA0W/+lW+HDh9w/Kr60Dm6MzyRzlJ29v+doSu7IwZPUMHzk9qhJyCdwabOmumA/1mOHFYNjh6hTgJB6HXOy3Xn5OQa1J19Oe91UL+A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:a479a88f-83ff-4a80-be1b-76facca6a19c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:01ebbcf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a5385424697311eea33bb35ae8d461a2-20231013
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2054167516; Fri, 13 Oct 2023 10:53:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 10:53:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 10:53:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTprnMcO4jcZswZpYgS46hPwtDoM9+lc2eC9kLNdry443FWRcfW272T1FhRroRurubpCLJKbRYtsRjgK8rxVRWjgqrTGywbygQIbdwWd8R2Ea9Cip36CL1qQScgEnTkFgk0QZyeSG/kOBCow5W/PXSH8b+3mVW/Ojq6hIzaCXCYBs3szDbQUdvJt6O3iBU037etNhaZneRJJE825c63AZ9oWD+fsIdXlm1HfuwbDNb14F0iLHUh+DSqta2bqoQXz7B48G3Z8MV8Am7DziOQXw8I+daYf0tKYC9gk4ht4bR5eV8v0uvo5RKBlrW5fmA7TGRBgiqWd6of3FHuSPo1l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dP/3MXwSgRw53KAZqk1eoubhqIdFcS9C6B0zaODaH4=;
 b=mp1sQIoN+/cZzyPqIAtu/Gf556UI0jegMorGDl8Nq1krHEGYABdfSVzXQRql/C2hyHkiYghEgBbB0lQ16a6Fv1z2Y3QhHgWFp+w1Rn4cRXOfjFiExft4oqs6TeA+s7x8eDNsq1zhTlempaFSAVVx8b8PYjLOXanNkgA2AutM7xPYStFbjDCuz9PIH/571pmCvcgHeUu+tMPf7K3TuNYQZUKAFfd8agF75zpkEFwR36tIQN/AvW2/WOGkaOjCof+O5e94DaQhLrd9Vf483dtfxzrtRqnKrWk49IndCyaVM5DoHUXxzwChI3h7nc9gy/ggekTQhPhf17WBd/QPCV8fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dP/3MXwSgRw53KAZqk1eoubhqIdFcS9C6B0zaODaH4=;
 b=aLk0Cc55x8hTrwtwXwZeetESdQxY4CDBm9qUP1f39DRf9p+slJz4gS5qPEUeEo6HaIz/k3rYrXQ3zxMMZOI58Qraah8czMDEnFaP3XEj9wLg0yQlnJFGbUy6xioLt8R967yNBhBje8TGG7m15C6ObbDZfhCa1wzOmDysODzGHXg=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYZPR03MB5487.apcprd03.prod.outlook.com (2603:1096:400:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 02:52:24 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0%5]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 02:52:24 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
Thread-Topic: [PATCH] PCI: mediatek-gen3: Fix translation window
Thread-Index: AQHZ/D4+ALwyQsnSTEKf880/L3OgGrBEuWSAgAD1pwCAAEXeAIAAKHUAgAAKmQCAAOAgAA==
Date:   Fri, 13 Oct 2023 02:52:24 +0000
Message-ID: <3dd20c59969a312607cb4bdb58643c8d2ffa9f86.camel@mediatek.com>
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
         <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
         <088559162e5ec4e2d6d38d8a5707c6e0e12f5ac6.camel@mediatek.com>
         <54ed1269-8699-4531-abc6-09b602adece9@baylibre.com>
         <930f6df4-3267-59df-ad75-244f5b9cee84@collabora.com>
         <2e9766db-da12-42e6-80a8-b9ef6f2de724@baylibre.com>
In-Reply-To: <2e9766db-da12-42e6-80a8-b9ef6f2de724@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYZPR03MB5487:EE_
x-ms-office365-filtering-correlation-id: 9b4d739a-91d6-42be-07b9-08dbcb976d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qfszGP/+nlRl0qwhjRNbaqZ31TvWfKcDid4xbmZTJfRTjz4/IPKZFZW/b7i36Ts0xEvjMCHEw8Via2ak3uChdOGnVpKnaYGtqMURE2uhSCfxZVTFZXMX/2JF298ItHYzbyN31je6oiLnN05HZbnGE2nqBmQIhamWdxRP/u8AqI/uyN6dzkP+RhQt42whkP7ibTPUtnPr9Bir6wpX1ay9AvcYAw4k/dJJwLrU2WHAYHHQ/VChK3OG6ypPDkmzltKIJ0KuN9tzp70ukulaSo7ekmLU/cy4f15AANnJDK99tWvVIYGNg5wJSfqkQYgyNaK3hbqjnxjaNwupreLuHl7a9U7BYE28dNarxjx2krdZXRjtOmmlTwqos0sbH1Xr8ddzrAQGs0/52u0V2j4eb4eViZm6CPeG5EhA5MDxb8qsZpOdGCH14q1tyKa7j8U5tKiOUK830vFPQzgn8KVShd7zB8P8UqnQ/ZUPSleF47cqK0bydPN773kw3+wFKhp6D3spCbsIyU686CEj0xPPjYcKQ/I37XuLNzuT6l/O5//UJRVsPG0aGJQTnrHuRlFByaKJqqo6xLWfpx5XPeS73xgdnoFoZalMRIjbYk3KcporXFY0rM5p9s4T2+0ZDEoYTeFK4rfzlplQkhWjlgCuM79+mgNvlmhhCMW5hvEMUjOjCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(91956017)(6486002)(38070700005)(38100700002)(316002)(53546011)(107886003)(66946007)(2616005)(41300700001)(110136005)(66476007)(66446008)(66556008)(54906003)(64756008)(76116006)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6512007)(71200400001)(6506007)(478600001)(7416002)(2906002)(4001150100001)(122000001)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NKU2Fna3Ixc09KNFhvM21TcTJ6eXRRVnltUjExNnRWODB1SUxIUGFGalJx?=
 =?utf-8?B?SEdacExPTHpFQ0k5UUExeCtNblhCQkhjNGZSTjBuS1BNT0huR2JCTmdWdWh1?=
 =?utf-8?B?VzRVUWdlQTBwR3NyWGJBazRaVW5NSjR6MXV0ZWROaW96Q3RmeDRYOEZ3OE5l?=
 =?utf-8?B?U2RYam8zQkFsK2pnVXlBS0M5SHFIWVZVdnRSZkxFOXVUK2ZteWpabTQ3N203?=
 =?utf-8?B?Si81NU5XWGRjWG1ZTGhSQ1d4Q01td3Uxd3NwRklzMk1hKzZzb0NCSFlHellv?=
 =?utf-8?B?UDdaaStnOXJybEpZaWwvVytCQ1FXcG16L1NQOUlQSVRGN1lJWFlpalRObk94?=
 =?utf-8?B?SWR1bDV3bGQrZi96em12TXFma1pVMjFVdUFaeG92V3dFTHdoV0hDckUrVHUr?=
 =?utf-8?B?cHJYUXpMUWpObytsRXhyaWhBbFA4S25QSXJYbUtTaEtwL3pncHVONW51RjJl?=
 =?utf-8?B?OXE4YSt6ZTBsbFA2YVpQQjJIQ3JYOWRSdW92amZBV1JnMDlpMzZJNjE3QUln?=
 =?utf-8?B?TGE3UkFaUTNtS1laU084eEV1NE1za0hrVWlZNUJObDN0aXRJWi9mdThrYWZq?=
 =?utf-8?B?QXRtYWk3THhPNjFDTkVRd2MwTkRnY28yUTFsam55Q0MwSmlMeEV1RGp6MVps?=
 =?utf-8?B?S0JEcHNLbUM3NGdCaUN0YjhxRWhoVEZpYkJkcWdJb3ZEejRRQkNlQWxYTmtZ?=
 =?utf-8?B?Nkw2c1NxY2RJRnY5T0dwbGNXUXlvaEtONU5XMmxCYmRpY1VuSUhnSmxrM09R?=
 =?utf-8?B?eUpWdHk5WVhzTFhMS0RwbTYvYXRQY2I4b3Badlc2d3EwNVE1MGI5MmVrdFkr?=
 =?utf-8?B?SkJ0aC9GVDV3cGYxd0FVQzFCL01aYU9NTXdNZTBkN2VnTElQOERwTjNwRFVI?=
 =?utf-8?B?ZVFMTzdsS2R2OHVuM2F4ZUQwd3VRbjFUTHkwblFabS8vUlIvNnJCcDB3cEhJ?=
 =?utf-8?B?QnYwcGVhVzMyTFQ4aWlCaVc0d3YxY1lFSWdOb01pUGYyVlRvaUVxYU5jaEIz?=
 =?utf-8?B?Tmk5VFh5MWxJc09KdHJKN1NtV2pydDF4QUtEZm5PeUtxdGZTakJpYmlTZkVV?=
 =?utf-8?B?QUR4N21JZUVlcVhYTlpPVTJ0a2pESVNaNTRoZXRIUU5aajhzdDZzN0hTUEh0?=
 =?utf-8?B?ay9iVjl3bjg1anhJc2M2QS9LU0t2MDF1OUprVXpXVnFtaE9kbjdqdTRjNlRD?=
 =?utf-8?B?QTNiMnowZDJxTjZUaWowOHkyRG1VRmxndFpGSm11Tm5XcEZORTlaMndhd1Z0?=
 =?utf-8?B?elVhKzVZd3FHTERkYXpjUXhkN1RhdHlwT3RrMDVyT0V2Z3ZreE5vSGt5VWw1?=
 =?utf-8?B?dVJwcnNIS2t2NFRMeWNRU3RqN2Q2WXNJZDZwZXBVSnJ5bklTM1VRUjNOUi9p?=
 =?utf-8?B?VTc5clVSeW91WHgrdE0zYTV5U0FUVW95M3hQeko3U1lUT1BseWJvdVR0bEU1?=
 =?utf-8?B?bkZhTStKL3JKUXJ5SmlwTytMS3N4S1BRS3pLWm1RVmd5V1VaODlFeGlNY1lw?=
 =?utf-8?B?cVFlV1NwN3YxaUFWUDRmaWc5Ylk3T1pYOHZsL0IxWmlDblZWWUxMWVRsRUc3?=
 =?utf-8?B?empvTWZVd2xiZnR3S1MwT3pTUGZGR09MUXpqUW9JdmhGMUFwNDFnUGVkZWx1?=
 =?utf-8?B?LzA0bUlYRkZpbW9aZVc4cUExb1M0SWxmRWl2cHRSWXhQK3JJa0NNa3hDQzlF?=
 =?utf-8?B?UytVdjBsRnpxWWpNNmNPSkR0bXk4aEM3NjdRejgrTldSRENIYkNjekZOR3Iz?=
 =?utf-8?B?QXlUUzdOalo2N2h3RThmR2JmMVJYUlJYeiswN0owTWtBK2pJalhJaHhZMXhn?=
 =?utf-8?B?dWo3aDRFT21pV2hTdFJQa0QxZkc3cUxrZVA2c1pDSVlFOFpnOW0yRnhsamla?=
 =?utf-8?B?aGF2dzArS3NKNXlBUTlQQnYxQXNZSnhTTG9OaUFPOFZRdmNGVUlKTlFjY1or?=
 =?utf-8?B?b0d1amhLdmhYcDFhdUFBaEZLb253VENMR0xtYm5TNlM2Nkh2K1JmaHJHUUk2?=
 =?utf-8?B?Z3pHNWJNY1o0OW13MHlBa1RsRDAzNlBtR2xQL2x0bmdLRkFGcExuVUF5WUZ5?=
 =?utf-8?B?ZnBPVVBnRTdUZWJqUU1xWnZ3ZjRTTHNtbUhWaEl2L1h5Ri9iZFB0Qm01ME9S?=
 =?utf-8?B?NWxzQmNWNDNKcWZwcnZVY3ZMbnI4d3JNUUhpd2t4c21yZm1RZGpoNXRCUGlB?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BF6059B2BA7A94EADF907EB3E1992B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4d739a-91d6-42be-07b9-08dbcb976d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 02:52:24.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Hk/kUyX7qea9BY/zat5KXDvjoLgA6OyZPg7+w8+Bo3b+l0WTnX93xfjVgBbJqdeki4iVkQyK82G+c0A//9wYkqLOJNvs7M29c5VR/iFR+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5487
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--32.207800-8.000000
X-TMASE-MatchedRID: /nPNxfnsEhPUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCg20q/tyc1edmlaAItiONP0Bzqq5Jq+Zrhd2FPQEB0XO/Py
        9qOi5zpcYQOIvxOoGr1pOmH7y6GJ5+uobhwVz9gBMuD5yIqBt5EKzuF0egUUDu/jTz8Y/keoDpL
        lZJCSlu1QrQWfNw93SQT/cYTPIcDMWk4/JZEVmwME+XuSw48kCPNzEhPDkO0nsrmnnmubT87YVC
        x+TiDpcVEoxNJNO5ICO5YdW+oDHnkER5ddgnEDesK+WWVTsOXXEoDEGChh7CUK7eJQWtfQOIZjb
        V4eojrMPMqeQCj/RU2Hinbdww8hDhLhWu/Ds229PuMJi/ZAk8XN3sLsG0mhuqPm/sjj9KBgzBHK
        sDHLon/I3bFPEY05/6nLRUawip3wOjYUmQmZB6kNTnAhL0/m3Xs5nqGvDCfMG2HMvWEJenpuEzu
        9BsYf+4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.207800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9EEAC4E67C34722AB99C504BE85C1BFECE243BA89E9A3618BA10E1EACE3468D12000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDE1OjMwICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gDQo+IE9uIDEyLzEwLzIwMjMgMTQ6NTIsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+IElsIDEyLzEwLzIzIDEyOjI3LCBBbGV4YW5k
cmUgTWVyZ25hdCBoYSBzY3JpdHRvOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAxMi8xMC8yMDIzIDA4
OjE3LCBKaWFuanVuIFdhbmcgKOeOi+W7uuWGmykgd3JvdGU6DQo+ID4+PiBPbiBXZWQsIDIwMjMt
MTAtMTEgYXQgMTc6MzggKzAyMDAsIEFsZXhhbmRyZSBNZXJnbmF0IHdyb3RlOg0KPiA+Pj4+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzDQo+IHVudGlsDQo+ID4+Pj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMTEvMTAvMjAyMyAxNDoyNiwgSmlh
bmp1biBXYW5nIHdyb3RlOg0KPiA+Pj4+ID4gVGhlIHNpemUgb2YgdHJhbnNsYXRpb24gdGFibGUg
c2hvdWxkIGJlIGEgcG93ZXIgb2YgMiwgdXNpbmcNCj4gZmxzKCkNCj4gPj4+PiBjYW5ub3QgPiBn
ZXQgdGhlIHByb3BlciB2YWx1ZSB3aGVuIHRoZSBzaXplIGlzIG5vdCBhIHBvd2VyIG9mIDIuDQo+
IEZvcg0KPiA+Pj4+IGV4YW1wbGUsID4gZmxzKDB4M2UwMDAwMCkgLSAxID0gMjUsIGhlbmNlIHRo
ZSBQQ0llIHRyYW5zbGF0aW9uIA0KPiA+Pj4+IHdpbmRvdyBzaXplDQo+ID4+Pj4gd2lsbCBiZSA+
IHNldCB0byAweDIwMDAwMDAgaW5zdGVhZCBvZiB0aGUgZXhwZWN0ZWQgc2l6ZQ0KPiAweDNlMDAw
MDAuIEZpeA0KPiA+Pj4+IHRyYW5zbGF0aW9uID4gd2luZG93IGJ5IHNwbGl0dGluZyB0aGUgTU1J
TyBzcGFjZSB0byBtdWx0aXBsZQ0KPiB0YWJsZXMgDQo+ID4+Pj4gaWYgaXRzIHNpemUNCj4gPj4+
PiBpcyBub3QgPiBhIHBvd2VyIG9mIDIuDQo+ID4+Pj4NCj4gPj4+PiBIaSBKaWFuanVuLA0KPiA+
Pj4+DQo+ID4+Pj4gSSd2ZSBubyBrbm93bGVkZ2UgaW4gUENJRSwgc28gbWF5YmUgd2hhdCBteSBz
dWdnZXN0aW9uIGlzDQo+IHN0dXBpZDoNCj4gPj4+Pg0KPiA+Pj4+IElzIGl0IG1hbmRhdG9yeSB0
byBmaXQgdGhlIHRyYW5zbGF0aW9uIHRhYmxlIHNpemUgd2l0aCAweDNlMDAwMDANCj4gKGluIA0K
PiA+Pj4+IHRoaXMgZXhhbXBsZSkgPw0KPiA+Pj4+IEknbSBhc2tpbmcgYmVjYXVzZSB5b3UgY2Fu
IGhhdmUgYW4gaXNzdWUgYnkgcmVhY2hpbmcgdGhlDQo+IG1heGltdW0gDQo+ID4+Pj4gdHJhbnNs
YXRpb24gdGFibGUgbnVtYmVyLg0KPiA+Pj4+DQo+ID4+Pj4gSXMgaXQgcG9zc2libGUgdG8ganVz
dCB1c2Ugb25seSBvbmUgdGFibGUgd2l0aCB0aGUgcG93ZXIgb2YgMg0KPiBzaXplDQo+ID4+Pj4g
YWJvdmUgMHgzZTAwMDAwID0+IDB4NDAwMDAwMCAoIGZscygweDNlMDAwMDApID0gMjYgPSAweDQw
MDAwMDApLg0KPiBUaGUNCj4gPj4+PiBkb3duc2lkZSBvZiB0aGlzIG1ldGhvZCBpcyB3YXN0aW5n
IGFsbG9jYXRpb24gc3BhY2UuIEFGQUlLIEkNCj4gYWxyZWFkeSANCj4gPj4+PiBzZWUgdGhpcyBr
aW5kIG9mIG1ldGhvZCBmb3IgbWVtb3J5IHByb3RlY3Rpb24vYWxsb2NhdGlvbiBpbg0KPiBlbWJl
ZGRlZCANCj4gPj4+PiBzeXN0ZW1zLA0KPiA+Pj4+IHNvIEknbSB3b25kZXJpbmcgaWYgdGhpcyBt
ZXRob2QgaXMgc2FmZXIgdGhhbiB1c2luZyBtdWx0aXBsZQ0KPiB0YWJsZSBmb3INCj4gPj4+PiBv
bmx5IG9uZSBzaXplIHdoaWNoIGlzbid0IGEgcG93ZXIgb2YgMi4NCj4gPj4+DQo+ID4+PiBIaSBB
bGV4YW5kcmUsDQo+ID4+Pg0KPiA+Pj4gSXQncyBub3QgbWFuZGF0b3J5IHRvIGZpdCB0aGUgdHJh
bnNsYXRpb24gdGFibGUgc2l6ZSB3aXRoDQo+IDB4M2UwMDAwMCwNCj4gPj4+IGFuZCB5ZXMgd2Ug
Y2FuIHVzZSBvbmx5IG9uZSB0YWJsZSB3aXRoIHRoZSBwb3dlciBvZiAyIHNpemUgdG8NCj4gcHJl
dmVudA0KPiA+Pj4gdGhpcy4NCj4gPj4+DQo+ID4+PiBGb3IgTWVkaWFUZWsncyBTb0NzLCB0aGUg
TU1JTyBzcGFjZSByYW5nZSBmb3IgZWFjaCBQQ0llIHBvcnQgaXMNCj4gZml4ZWQsDQo+ID4+PiBh
bmQgaXQgd2lsbCBhbHdheXMgYmUgYSBwb3dlciBvZiAyLCBtb3N0IG9mIHRoZW0gd2lsbCBiZSA2
NE1CLg0KPiBUaGUNCj4gPj4+IHJlYXNvbiB3ZSBoYXZlIHRoZSBzaXplIHdoaWNoIGlzbid0IGEg
cG93ZXIgb2YgMiBpcyB0aGF0IHdlDQo+IHJlc2VydmUgYW4NCj4gPj4+IElPIHNwYWNlIGZvciBj
b21wYXRpYmxlIHB1cnBvc2UsIHNvbWUgb2xkZXIgZGV2aWNlcyBtYXkgc3RpbGwgdXNlDQo+IElP
DQo+ID4+PiBzcGFjZS4NCj4gPj4+DQo+ID4+PiBUYWtlIE1UODE5NSBhcyBhbiBleGFtcGxlLCBp
dHMgTU1JTyBzaXplIGlzIDY0TUIsIGFuZCB0aGUNCj4gZGVjbGFyYXRpb24NCj4gPj4+IGluIHRo
ZSBEVCBpcyBsaWtlOg0KPiA+Pj4gcmFuZ2VzID0gPDB4ODEwMDAwMDAgMCAweDIwMDAwMDAwIDB4
MCAweDIwMDAwMDAwIDAgMHgyMDAwMDA+LA0KPiA+Pj4gICAgICAgICAgIDwweDgyMDAwMDAwIDAg
MHgyMDIwMDAwMCAweDAgMHgyMDIwMDAwMCAwIDB4M2UwMDAwMD47DQo+ID4+Pg0KPiA+Pj4gVGhl
IE1NSU8gc3BhY2UgaXMgc3BsaXRlZCB0byAyTUIgSU8gc3BhY2UgYW5kIDYyTUIgTUVNIHNwYWNl
LA0KPiB0aGF0J3MNCj4gPj4+IGNhdXNlIHRoZSBjdXJyZW50IHJpc2sgb2YgdGhlIE1FTSBzcGFj
ZSByYW5nZSwgaXRzIGFjdHVhbA0KPiBhdmFpbGFibGUgTUVNDQo+ID4+PiBzcGFjZSBpcyAzMk1C
LiBCdXQgaXQgc3RpbGwgd29ya3MgZm9yIG5vdyBiZWNhdXNlIG1vc3Qgb2YgdGhlDQo+IGRldmlj
ZXMNCj4gPj4+IG9ubHkgcmVxdWlyZSBhIHZlcnkgc21hbGwgYW1vdW50IG9mIE1FTSBzcGFjZSBh
bmQgd2lsbCBub3QgcmVhY2gNCj4gcmFuZ2VzDQo+ID4+PiBoaWdoZXIgdGhhbiAzMk1CLg0KPiA+
Pj4NCj4gPj4+IFNvIGZvciB0aGUgY29uY2VybiBvZiByZWFjaGluZyB0aGUgbWF4aW11bSB0cmFu
c2xhdGlvbiB0YWJsZQ0KPiBudW1iZXIsIEkNCj4gPj4+IHRoaW5rIG1heWJlIHdlIGNhbiBqdXN0
IHByaW50IHRoZSB3YXJuaW5nIG1lc3NhZ2UgaW5zdGVhZCBvZg0KPiByZXR1cm4NCj4gPj4+IGVy
cm9yIGNvZGUsIHNpbmNlIGl0IHN0aWxsIHdvcmtzIGJ1dCBoYXZlIHNvbWUgbGltaXRhdGlvbnMo
TUVNDQo+IHNwYWNlDQo+ID4+PiBub3Qgc2V0IGFzIERUIGV4cGVjdGVkKS4NCj4gPj4+DQo+ID4+
DQo+ID4+IE9rIHVuZGVyc3Rvb2QsIHRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi4NCj4gPj4g
VGhlbiwgSU1ITywgeW91IHNob3VsZCB1c2Ugb25seSBvbmUgdGFibGUgd2l0aCB0aGUgcG93ZXIg
b2YgMg0KPiBzaXplIA0KPiA+PiBhYm92ZSB0byBtYWtlIHRoZSBjb2RlIHNpbXBsZXIsIGVmZmlj
aWVudCwgcm9idXN0LCBtb3JlIHJlYWRhYmxlDQo+IGFuZCANCj4gPj4gYXZvaWQgY29uZnVzaW9u
IGFib3V0IHRoZSB3YXJuaW5nLg0KPiA+Pg0KPiA+PiBUaGlzIGlzIHdoYXQgaXMgZG9uZSBmb3Ig
cGNpLW12ZWJ1LmMgQUZBSUkuDQo+ID4+DQo+ID4+IElmIHlvdSBwcmVmZXIgd2FpdGluZyBhbm90
aGVyIHJldmlld2VyIHdpdGggYSBiZXR0ZXIgUENJRQ0KPiBleHBlcnRpc2UgDQo+ID4+IHRoYW4g
bWUsIGl0J3Mgb2sgZm9yIG1lLiBXaXRoIHRoZSBpbmZvcm1hdGlvbiBJIGhhdmUgY3VycmVudGx5
LCBJIA0KPiA+PiBwcmVmZXIgdG8gbm90IGFwcHJvdmUgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gYmVjYXVzZSwgZnJvbSBteQ0KPiBQb1YsIA0KPiA+PiBpdCBpbnRyb2R1Y2UgdW5uZWNlc3Nh
cnkgY29tcGxleGl0eS4NCj4gPj4NCj4gPiANCj4gPiAgRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCwg
dXNpbmcgb25seSBvbmUgdGFibGUgd2l0aCBhIHNpemUgdGhhdCBpcw0KPiBhIA0KPiA+IHBvd2Vy
IG9mIHR3bw0KPiA+IHdvbid0IGxldCB1cyB1c2UgdGhlIGVudGlyZSBNTUlPIHNwYWNlLCBoZW5j
ZSB0aGUgb25seSBzb2x1dGlvbiB0bw0KPiBhbGxvdyANCj4gPiB1c2luZw0KPiA+IHRoZSBlbnRp
cmUgcmFuZ2UgaXMgdG8gc3BsaXQgdG8gbW9yZSB0aGFuIG9uZSB0YWJsZS4NCj4gDQo+IFlvdSBj
YW4gdGFrZSB0aGUgcG93ZXIgb2YgMiBhYm92ZSwgd2hpY2ggaXMgZGlyZWN0bHkgcmV0dXJuZWQg
YnkNCj4gZmxzKCkuDQo+IFRoYXQgbGV0IHVzIHVzZSB0aGUgZW50aXJlIE1NSU8gc3BhY2UuDQo+
IEluIHRoaXMgZXhhbXBsZSwgaWYgeW91ciBzaXplIGlzIDB4M2UwMDAwMCwgdGhlIHlvdSB3aWxs
IGFsbG93DQo+IDB4NDAwMDAwMC4NCg0KVGFrZSB0aGUgcG93ZXIgb2YgMiBhYm92ZSBzaXplIGlz
IGEgc29sdXRpb24sIGJ1dCBhbm90aGVyIGNvbmNlcm4gd2lsbA0KYmUgdGhlIGZsZXhpYmlsaXR5
LiBXaXRoIHRoaXMgcGF0Y2gsIHdlIGNhbiBzcGxpdCB0aGUgTU1JTyBzcGFjZSB0bw0KbXVsdGlw
bGUgcmFuZ2VzIGxpa2U6DQpyYW5nZXMgPSA8MHg4MjAwMDAwMCAwIDB4MjAwMDAwMDAgMHgwIDB4
MjAwMDAwMDAgMCAweDEwMDAwMD4sDQogICAgICAgICA8MHg4MTAwMDAwMCAwIDB4MjAxMDAwMDAg
MHgwIDB4MjAxMDAwMDAgMCAweDMwMDAwMD4sDQogICAgICAgICA8MHg4MjAwMDAwMCAwIDB4MjAz
MDAwMDAgMHgwIDB4MjAzMDAwMDAgMCAweDNjMDAwMDA+Ow0KTm90IHN1cmUgaWYgdGhhdCBjYW4g
cmVhbGx5IGhhcHBlbiwgYnV0IGl0IHdpbGwgaGF2ZSBvdmVybGFwIHJhbmdlcw0Kd2hlbiB0YWtl
IHRoZSBwb3dlciBvZiAyIGFib3ZlLg0KDQpUaGFua3MuDQo+IA0KPiANCj4gLS0gDQo+IFJlZ2Fy
ZHMsDQo+IEFsZXhhbmRyZQ0K

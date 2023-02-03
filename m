Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F9689414
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjBCJjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjBCJjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:39:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE311F;
        Fri,  3 Feb 2023 01:38:45 -0800 (PST)
X-UUID: 8a60442ea3a611eda06fc9ecc4dadd91-20230203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1V/fPr+af8v4j8d4nGxE7cAM/mVzYztoeL6p6UxpA90=;
        b=mME3Hyr6wyKz7rdac1LbXnBACYGNftQJ3DoglWsXP9z7JmFHIk1qKAl7C8PAj+gXcOTIYBRZFR2NyeGKPU+nv6ftiEV72ij7IaqFQgifj2jAUgvaqLJaYk8OLWYBVgw/pUGLDEWW2m1M/yE2qh6L8SX95Ks5gOEGFEU5ouKt5Vs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:124d53a1-08f3-40c8-8189-f15fdc10cace,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:9e675ef7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 8a60442ea3a611eda06fc9ecc4dadd91-20230203
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 685061473; Fri, 03 Feb 2023 17:38:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 3 Feb 2023 17:38:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 3 Feb 2023 17:38:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTsfo9GpmFxkhfhyEAi/ApiMIjTWo8bUCXlyc1OFc/RuE271fNURkuEVCu1Q8sQduHgdW0W35XJC9q9KqYu/LwsZ9RV0/cjex1mJVicV4DpNOlnSSz+X7Do1mhPA82CzEJN3jlz+jFKWCRg/bHOAHhk8/IhtHm24GDXNGac+7KCT6a7Fk+gcVR//saRX5Xc8K225mOjE14/LDkB6k97vQVXm0EJVpqdQivcsB2rAIit/sF3qAOv4G0eGW43js7IbpNuGAWMTwfOe0LDUqkLDHs+UrOTYLqMu7fgzv+cs2+KVWxZOzTHg82mIjgFPJ+aoqc4mlhy+xswfjgUY16/bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V/fPr+af8v4j8d4nGxE7cAM/mVzYztoeL6p6UxpA90=;
 b=X4R4R7dDl4yP3+JPa3Rotr8+1QLXig4SicVneraz5lip9iq61bXrW+fWlhGhWOjkpQrbRFFANMfrRlMLn7ql0NcsnZOEpCNLqtiw4GFISqpQNOfMNoPrRxedjPwsqEQfupVScEPScNALhkACfFxy/b1rUJipL6NBhA/pUmnFK8+aMN1HThOEJvi/UFqOziMEqNdmN4j7CpZx1hSIjeMauNyXJBIWG5tGE7pTEOMvBVJ1TtXc0jOpPnY8J0jNamtUxzEsCNf0HnMejTsgsp9ty9XbJyfzP29L+d6/xyzgPvY6Q0hW6vwf8Fzsr5cZMaQS+lI8/CwLQBzIog5LLuku7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V/fPr+af8v4j8d4nGxE7cAM/mVzYztoeL6p6UxpA90=;
 b=V0On2uORNrPja5jWXVytTZ5vPUwuBa5KR8u2pV1YsVkzHIGh11+QXkWpiB+S2gG6re3KpYYB21KsurkP7gy2SMVwzhhh5YsTJSOl6ZhqG9N0/Tp0sMBvqP/d4SwN7xZJCJS+58hYye0v2AXmsDvTaAEoy28b1DeIGYpXgscM/DQ=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by PSAPR03MB5431.apcprd03.prod.outlook.com (2603:1096:301:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Fri, 3 Feb
 2023 09:38:37 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943%6]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 09:38:37 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "kw@linux.com" <kw@linux.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
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
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        =?utf-8?B?RGF2aWQtWUggQ2hpdSAo6YKx6Yi657+UKQ==?= 
        <David-YH.Chiu@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Topic: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Index: AQHZJW08mAoVUkodH0Stwnt7OwVpoa6Y88CAgCQn+QA=
Date:   Fri, 3 Feb 2023 09:38:37 +0000
Message-ID: <8d954de7f9507099bd9bea6801f446f80bd832aa.camel@mediatek.com>
References: <20230111032830.20447-1-jian.yang@mediatek.com>
         <20230111032830.20447-3-jian.yang@mediatek.com>
         <dccfa004-1d40-acc0-6220-9232193b648f@kernel.org>
In-Reply-To: <dccfa004-1d40-acc0-6220-9232193b648f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|PSAPR03MB5431:EE_
x-ms-office365-filtering-correlation-id: e4559f0d-a039-48ee-9715-08db05ca6d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQdtMVSEZ20tJzgZ6ZciS/EbfrfH+YISFvx1OP5qxmb7E39JCcQeQHeUDB/IWXlR0S09wrjyUi7D913d61J/hX3I70hV1brW06cEOzLwrEEfs/Idxq92ZpGuBk8TlfHhaw+zl0vZiYnWxEQni45yR2HPkWEDLzhkPZyLNjXMMkN3+Y4sytnstwyd31ef2udFKw37jQ84N+k5bBDp7uPMB6OG2K6qcgCn4EFrFQHCkgNrldtA45eBcqEA1tz1f0CeAWa9y4mc/A3gqBcP4Fyx8aBIO/2UeZuuRWEDOKKV8/YHUqui20q1tG43lCDNSd/O47EHLoWos9dCb262ywMXO7KX6f5exIk2O5YwZ0HEIMri6jq21K8G7hXC8h1C90kEeNfizFthLdWpWR5/lH+T2Pl2wwFBeTLha/y5j5xgBRFJ1ttjoyJU7N5GwiP7vEfIN6l6ghetwmJIER7COKabExGR//JKqwjoTDvTkr2glza+1hI2LaAOeDhi2Ob5xN0DmG1R1+DKkd3+2RrSdnwpft0kBDsC9CWo3x40uOFqnaHBliCG1eEgneVZ+VeGoaji2nL56geBzW9iSA/Vrp3xwviwfJZjc4Ww/xlg2YhnmuulRby58be9W52/3BpA4bJZ5EoRds6BDUgP8roO2FDAfJJGUcPgbSd3GGZor8WAZI9A3bOHZ3atSzp/4LeUlE0dOtTFXaKKK8UM49eg4W/FYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(316002)(6636002)(54906003)(110136005)(122000001)(38100700002)(85182001)(36756003)(41300700001)(2906002)(8936002)(83380400001)(7416002)(5660300002)(4326008)(66946007)(66556008)(64756008)(91956017)(66476007)(66446008)(8676002)(76116006)(478600001)(6486002)(2616005)(107886003)(86362001)(53546011)(186003)(26005)(6506007)(71200400001)(6512007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0R2c0t4dTRtNHM0TlV6K2lsclJBZHVxZTBoQjdGSHBJTnNlU1VoZXlxVVlS?=
 =?utf-8?B?R3MrcjJ0QjNqdTdCQk5sQUR1WnFTR1JiUmQ1S1NJSk5hS0ZjYnptM3JxZGdj?=
 =?utf-8?B?ZFl2eXhvSjBxWU9Ed1o2VGJwWTdnYWpOYWMwb2dKYkZOckZGUUxKZVNLb1JM?=
 =?utf-8?B?cDE4TnhDVDNBdjV0ZHRnT0pQNHYza25VRmx6OHRuOXhYK0prZTcvYnlFcm5C?=
 =?utf-8?B?MkhuRWZWRy91ZGhWK1ZVOXo4aC9lNC9ncHdXbjh6Mzl1ZjJ4SWYxTytsQVJH?=
 =?utf-8?B?MVJRWU16eVZzSXV2OUJoSkZzb1VkUnQ1Y0prZEcxaU1RaXg5L00xdWNObkdW?=
 =?utf-8?B?KytuOTJ3bzBlTVFQRThPbitUQjBqQVJhTHZCa0dESTZDZk9YUjZVUHpKZ3ZP?=
 =?utf-8?B?UFh4VVorc2N3Qlh1L1F4THl6ZzlnNjZRQlR3dHNIVWhuNjR1NEhYeVpvV2dx?=
 =?utf-8?B?Zkd1VnFlVURPWklLbnJUcVhFditYTTBFbklrUUdkQUlDWHFpSForak9EdFhQ?=
 =?utf-8?B?TnZVSDIyV1NNeXlqc09XWFdiTy80TTJXWUlsdGNQbFdVV1A5Y0gwREUxZG85?=
 =?utf-8?B?QW1DR0UwVVl0ejRaOW5nUDBJdENZVFoxY0NYVjhoR2NzUjNuSmdmV0lRbUc0?=
 =?utf-8?B?bmsyN1BUZDhWWDVCbk5wNmFsbEJpZnllTjA3YlVUR1FZZ1dzY3VrdC9GRjBu?=
 =?utf-8?B?SHlxcWFUVHJtSnJuWjZ4RW4wdTluZVJ1TXI5djNLNmZhaUU1NGw3bjF3dkJ0?=
 =?utf-8?B?OTNyVzAxcG4xNXQrL0RrWUtOQWp1YlVZZ1dUMnY4UWx3cTB0YjV3WXc3NWZP?=
 =?utf-8?B?S1R5emg1eWpRNFEyWjF4VXBHTzVHNkpFQ0NzR3pEelFBdlB0Wm5hU1daTzZs?=
 =?utf-8?B?elZLS2dUZlROdkFIZmVtMWo0Ym9RNlRaSE1QTENNSXlQRnVMWEhsYUpKaUl0?=
 =?utf-8?B?QXFkR2J1Q3ZWZm9ScWJVTE1uLzdleEg2MXdUZGJhOUdaS0JNc24ycFRTUUlp?=
 =?utf-8?B?emNyZVg2NkswRDl6bmx6bWZDbTNyaDJzNmQyK3FGRG8rWGlTcXUzNjBidWx6?=
 =?utf-8?B?VCsrbFI5bjlabDRpVkdnVEVueDlGdVk1R25rTW9MNFNENGZPeitVM3YrQUZY?=
 =?utf-8?B?Z0NRSTVCQTNYREtqcG52MDAxMkFHTFRUZWxrN09kbStnZGJHQjhPd0tueENY?=
 =?utf-8?B?Q1dBa1F6Rm03VzdBT1d3a3NQK0I3N3E4VTRKQWhlQkRzMEtrNit5cC9jc1Jl?=
 =?utf-8?B?eERKMDJvY2c2Smd3L1k4WmhYa3ZhVm5aUDFRM1NPeEtlQWNlSi9GZjNBWnFo?=
 =?utf-8?B?WldvMmNWSjEvZU1CbWZOZnZkKzB2a3Z1UFdINWpCQmNrYTRNdGtFOUl4TW12?=
 =?utf-8?B?WWhEbFdTNnlDdm1JTHloa0lKZEZPYXViM0FkYXZwcEIyZkVZb1ZLUlhuclFN?=
 =?utf-8?B?dFNYa1F6WmRYbDVSSVRTcHE4eG5qNEFneEF0ZDh4bndwNS9HMUxtTTBKK1dJ?=
 =?utf-8?B?Mkd3cnhPanY5cGVITVVGdERkc2tNQ283aWZLbjJBSUxIdU1venBaNDQxQ0NE?=
 =?utf-8?B?Q3VvNFlUVXJIOVRaelllQU13U0xiUXVHckhCa2k5cHBDaUJjTUFKbUU3T291?=
 =?utf-8?B?Szk4QVYrVkt4NFQ5c2NieUtlQ2NTZnVQNHlYNm5XL1puamVoUk14Yy95VkRi?=
 =?utf-8?B?Q3FESzdyZGtIK1JyS2c2dzVYckV6eGhETGZhK3JQMmdBY1I2TEdpaFFzdlJz?=
 =?utf-8?B?OGFRZW5rNTIzMm1abGF1TEJCWmtxV2RlOUt0eEVZVXJ0YkV1N2JZZHdXMXhN?=
 =?utf-8?B?NmVBMEI1VlZGWDBSL3FRb00yeEFRczdhUEpPTUxJUnVJMVNoS2RGWkdqRytV?=
 =?utf-8?B?UUFNZjNBRVBWKzlLQU5Sanp0VExjUmlveVB6T1FOekM3TzBIK2hDTFRpdHBW?=
 =?utf-8?B?L0M0a3RHNjJsODZ3ZUxiYktLVmxZeTJNVDlJQUhuNGlpZWcvMmhOWGdoY3B2?=
 =?utf-8?B?NnhPVDZ1NFdYMDlsOEVpRDdZSWVKbWoxckxOMkxaZDJpeS91L0ZDUi85Ujkx?=
 =?utf-8?B?d3NUemxXVlJLcFE2dk1lN3FTd3Q5L3dvVnIwWVpoUnBtQktkbXVsVkV0Z0o4?=
 =?utf-8?B?YkZsQjRJMDk2cmNLT01mVWJuUjVJSkNPY0d2NVZxSWlmTGdRd1dpNkVWNkRQ?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C677B63B824A694C8AEE482062F36875@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4559f0d-a039-48ee-9715-08db05ca6d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 09:38:37.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2tm+ENNCpP/DOfuU5VKyx+QZNiEsds6Xk94NpFXqOx9dBMV7PsACfFB8mQ72ydOx+T6o3DSeKJmuCUpYk3Xww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBLcnp5c3p0b2YsDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZSBhbmQgdGhhbmtz
IGZvciB5b3VyIGNvbW1lbnQuDQoNCk9uIFdlZCwgMjAyMy0wMS0xMSBhdCAxMDozMCArMDEwMCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTEvMDEvMjAyMyAwNDoyOCwgSmlhbiBZ
YW5nIHdyb3RlOg0KPiA+IEZyb206ICJqaWFuLnlhbmciIDxqaWFuLnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IA0KPiA+IEFkZCBuZXcgcHJvcGVydGllcyB0byBzdXBwb3J0IGNvbnRyb2wgcG93ZXIg
c3VwcGxpZXMgYW5kIHJlc2V0IHBpbg0KPiA+IG9mDQo+ID4gYSBkb3duc3RyZWFtIGNvbXBvbmVu
dC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqaWFuLnlhbmcgPGppYW4ueWFuZ0BtZWRpYXRl
ay5jb20+DQo+IA0KPiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdl
dCBhIGxpc3Qgb2YgbmVjZXNzYXJ5DQo+IHBlb3BsZQ0KPiBhbmQgbGlzdHMgdG8gQ0MuICBJdCBt
aWdodCBoYXBwZW4sIHRoYXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWws
IGdpdmVzIHlvdSBvdXRkYXRlZCBlbnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlv
dQ0KPiBiYXNlDQo+IHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KPiANCj4g
PiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCAgICAg
IHwgMjMNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS0NCj4gPiBnZW4zLnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtDQo+ID4gZ2VuMy55
YW1sDQo+ID4gaW5kZXggN2U4YzdhMmE1ZjliLi40NjE0OWNjNjM5ODkgMTAwNjQ0DQo+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdl
bjMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4gPiBAQCAtODQsNiArODQsMjkgQEAgcHJvcGVydGll
czoNCj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICBlbnVtOiBbIHBoeSwgbWFjIF0NCj4gPiAg
DQo+ID4gKyAgcGNpZTF2OC1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAg
ICAgVGhlIHJlZ3VsYXRvciBwaGFuZGxlIHRoYXQgcHJvdmlkZXMgMS44ViBwb3dlciB0byBkb3du
c3RyZWFtDQo+ID4gY29tcG9uZW50Lg0KPiA+ICsNCj4gPiArICBwY2llM3YzLXN1cHBseToNCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGUgcmVndWxhdG9yIHBoYW5kbGUgdGhh
dCBwcm92aWRlcyAzLjNWIHBvd2VyIHRvIGRvd25zdHJlYW0NCj4gPiBjb21wb25lbnQuDQo+ID4g
Kw0KPiA+ICsgIHBjaWUxMnYtc3VwcGx5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAg
ICAgIFRoZSByZWd1bGF0b3IgcGhhbmRsZSB0aGF0IHByb3ZpZGVzIDEyViBwb3dlciB0byBkb3du
c3RyZWFtDQo+ID4gY29tcG9uZW50Lg0KPiA+ICsNCj4gPiArICBkc2MtcmVzZXQtZ3Bpb3M6DQo+
ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIHJlc2V0IEdQSU8gb2YgYSBkb3du
c3RyZWFtIGNvbXBvbmVudC4NCj4gDQo+IFdoeSB5b3UgY2Fubm90IHVzZSBzdGFuZGFyZCByZXNl
dC1ncGlvcyBwcm9wZXJ0eT8NCg0KVGhlICJkc2MtcmVzZXQtZ3Bpb3MiIHJlcHJlc2VudHMgYW4g
ZXh0cmEgcmVzZXQgcGluIG90aGVyIHRoYW4gUEVSU1QjDQpyZXF1aXJlZCBieSBhIFBDSWUgZG93
bnN0cmVhbSBkZXZpY2UuIEJ1dCB0aGUgInJlc2V0LWdwaW9zIiwgZGVzY3JpYmVkDQppbiAicGNp
LnR4dCIsIHJlcHJlc2VudHMgdGhlIFBFUlNUIy4gU28gSSB0ZW5kIHRvIGFkZCBhIG5ldyBwcm9w
ZXJ0eSB0bw0KbWVldCB0aGlzIHJlcXVpcmVtZW50Lg0KDQo+IA0KPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiArDQo+ID4gKyAgZHNjLXJlc2V0LW1zbGVlcDoNCj4gDQo+IFdyb25nIHByb3BlcnR5
IHVuaXQvc3VmZml4Lg0KDQpUaGFua3MgZm9yIHRoZSBjb3JyZWN0aW9uLiBJIHdpbGwgbW9kaWZ5
IGl0IGluIHYyIHBhdGNoLg0KDQo+IA0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAg
IFRoZSBkZWxheSB0aW1lIGJldHdlZW4gYXNzZXJ0aW9uIGFuZCBkZS1hc3NlcnRpb24gb2YgYQ0K
PiA+IGRvd25zdHJlYW0NCj4gPiArICAgICAgY29tcG9uZW50J3MgcmVzZXQgR1BJTy4NCj4gDQo+
IFdoeSB0aGlzIHNob3VsZCBiZSBhIHByb3BlcnR5IG9mIERUPw0KDQpTYW1lIGFzIHRoZSByZWFz
b24gSSBkZXNjcmliZWQgYWJvdmUuIEkgc3VwcG9zZSB3ZSBuZWVkIHRvIGFkZCBhDQpwcm9wZXJ0
eSB0byBsZXQgdXNlciBkZXRlcm1pbmUgdGhlIGRlbGF5IHRpbWUgZHVlIHRvIGRpZmZlcmVuY2Vz
DQppbiByZXF1aXJlbWVudHMgYmV0d2VlbiB2YXJpb3VzIGRldmljZXMuDQoNCj4gDQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiANCj4gbWF4SXRlbXMgb2Ygd2hhdD8NCg0KU2VlbXMgdW5uZWNlc3Nh
cnkgdG8gYWRkIGEgIm1heEl0ZW1zIiBoZXJlLiBBbHNvIEkgd2lsbCByZW1vdmUgaXQgaW4gdjIN
CnBhdGNoLiBUaGFua3MgYSBsb3QuDQoNCkJlc3QgcmVnYXJkcywNCkppYW4gWWFuZw0K

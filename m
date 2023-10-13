Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3767C8266
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjJMJnc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJMJnb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 05:43:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD6B7;
        Fri, 13 Oct 2023 02:43:28 -0700 (PDT)
X-UUID: f329099269ac11ee8051498923ad61e6-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O9tybTAp2ChKtfZuhR8JrG7IZmcR+Rqo/NhlFqf1/EA=;
        b=t8wTSK/XvkX7G6mBGoXVw3wRVQYX2nCIk+YGDRPkas9c+60Lnvjd9nY5CYD7et03cnOhZQWpEq3JaXPVxOmHSFMSYAe5KXjJNj5qPnWzsQJ2h5r4Kb7VCMTXscsa36qr2US0IQXCAqirWfXlflk7aSh4iURQr65CTiiBcVA2Un8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9be6691e-efdc-4e6c-87a6-51f275f50a49,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:516c16c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f329099269ac11ee8051498923ad61e6-20231013
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 409517575; Fri, 13 Oct 2023 17:43:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 17:43:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 17:43:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxojRfXnMCMz86XdXx80vldGPxRLKyB9eRAOLrER4IfYj7gKpswWSIM+rjBjWn8RdpzldXvCZt9rNlV0pXroI6PHAY8MztIjyKgS5iXUbEv7FaTkM3M0P5X7I3PWMh6LBKdYTnU9BdamZKDy2trUAEygWxxA8rHu712o3hleXl0Et/zqODrpK15tBWEUm3Gy1fD7Q6Xf9OfWKqG15f/nRW5YZfiNQj5N9zAOOI8AilkwZUBbjC9+3mmP4FSZtD5nsd+0AHfAEVJWu1msFITeVgXqUtMOLtihiGFliugXBbJO7BAzIoI07xazS/N4IVvGC1pdrXVOa6/fgcPOi+qzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9tybTAp2ChKtfZuhR8JrG7IZmcR+Rqo/NhlFqf1/EA=;
 b=RE9dugLNTruLMepYOYetle3o9/I/Wva3bNcBIBLKFVCtSaFpihOqwcsTS/5WPKax7hE6wzr8t3sa/TMh4vSpdJQTkpAWxuInQDHgsEU72B7v9HpsSe5NuKIzMTpaLsg/PuXveZ00w3tqd2fs/cs2LDM761axY28XMIDy2PAQFKfK6J7N0i3m06P5/b2hzOzDHk7WRNlEsRmuBnlqk0mR0oF8AvFsC6eroElvkQyD693j3hdTEi3BWRuIJHt5ntsIP/BGrjXB5RCJUntE9meV/1UUR+4HOSSZs7l0+PK7wue07eWXWqHxO7WSfA5mBwpivvj9Q1a3NyR8mnlzPlB6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9tybTAp2ChKtfZuhR8JrG7IZmcR+Rqo/NhlFqf1/EA=;
 b=JW3OJYrg0SkgdMx33MxVSEgo85dzE5PATfhZ5LV8uCXtyG4Nwgj79GJEjXQ2SKW59SujWnZsMxzT1NO1Oo/8zVnseoJqC26Dhasw8XGoch9lLJvrMxiqF/jP80qiSLu77h5HZKezsuv15k+NdNkcKVvWY9prN8ewsi4Evn277I0=
Received: from SI2PR03MB6026.apcprd03.prod.outlook.com (2603:1096:4:14a::10)
 by SI2PR03MB5944.apcprd03.prod.outlook.com (2603:1096:4:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:43:19 +0000
Received: from SI2PR03MB6026.apcprd03.prod.outlook.com
 ([fe80::a2b9:109e:5c84:c061]) by SI2PR03MB6026.apcprd03.prod.outlook.com
 ([fe80::a2b9:109e:5c84:c061%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:43:19 +0000
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
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Topic: [PATCH v3 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Index: AQHZ+o3Gi3Fqs4iB8E+13sins4LeuLBCyXAAgAS02AA=
Date:   Fri, 13 Oct 2023 09:43:19 +0000
Message-ID: <fe67afdb034750b9f428f4155cc614bf7ace7f78.camel@mediatek.com>
References: <20231009084957.18536-1-jian.yang@mediatek.com>
         <20231009084957.18536-3-jian.yang@mediatek.com>
         <b90c6bf7-d604-ec88-c7da-84726bba3af4@collabora.com>
In-Reply-To: <b90c6bf7-d604-ec88-c7da-84726bba3af4@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6026:EE_|SI2PR03MB5944:EE_
x-ms-office365-filtering-correlation-id: c52a8593-f89c-4a5e-fe81-08dbcbd0d50c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hXr3cLz97ljiDjZNXXmLwwy/ur24x8ewiifKmnEKAQbDjiTCwtYc2dwQ2Flkb//64YSA5dELDEEkGgAoRQVtZQBW1Ji/w6rVHZVLeKDg81DA8nQnvoE9Hc8B/4cFos5ktlvLui7ofq1IsGYEe8bKjef7beRhO6bbZqdL1e8FYelrMvlStBJkHg/ZtgdCCejfg/XyKUU66a2sAHmUH4PZQiRl9nzNOhM9GXWRBmxHc/poExoz70eApT+RlLR55sO9gqQsGAqk/92957Mpy0VK3MzQU44lGwRBZlTppqxMrmb9NHviiPEEM3lZJozcxQvSJ/NKvFaqvoY+Q8kfd+Pz+dynaF+tlPJ+pgzqnrqdUIGPY8iUKlC+s464trssgKs94/g7d29Ra85ZgJDDV5yWGeAnPQfQgriwL757PBgVWsa7ruLBKQ1G+02FLlQqPRH7X51cxA6RJIbRQVfHf2v0HWynmBNslWNoxMB2HHiqXIo6duZRrOKdEfuF+6csbjZfyrGwjk64dazIqrNeKUXk/TPmyS6vZcpdJa/USLZ34BDDppCxcDGB0t99zbVY8ZtY3SSgNOApzqSEPqiulRUoQ9Z+qN0HeKv//LlLmaifdLfJuyc+XoQIk+aehlCyq/dXu9yif00pN8oT3EpkMudPzWAicApaAA4ibvM1zJoOyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6026.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(6486002)(2616005)(38100700002)(6636002)(38070700005)(316002)(64756008)(66446008)(76116006)(110136005)(54906003)(41300700001)(66476007)(66556008)(66946007)(83380400001)(5660300002)(8676002)(8936002)(4326008)(6506007)(71200400001)(6512007)(478600001)(2906002)(4001150100001)(7416002)(122000001)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlGbjljWW94YUtFSGJ3LzhUQ1AwM3liZjdma09hTWthb0I1VnhFTkpBV3Bp?=
 =?utf-8?B?WHRBRkVtYjh0blZjQ0JzQTljZzFPa3lRU215UXZGWVV2dThwSjBHQ2xNOG42?=
 =?utf-8?B?dUZoMHJGSEh5V2d1WFdkTElYSE9mbnBjckVJU3U1R1Nwc1dRK0JndUhiNGdC?=
 =?utf-8?B?bEFpdTEzZHJZVGk1YW5NM3ZrY1daZ0RUbUQyamI2SUlsQ0dBcjc0KzlyZHFx?=
 =?utf-8?B?aDJ1b3FVMFJZOXNUalJJZXNCck9rNFVHNGZyR0xTdmdvVHJZaldrVzhCZjRn?=
 =?utf-8?B?SFNzVXdxbkhNZDU0cW94WDhCUVR4T09QVi9tcDFtSXFOMUdxb2RNaDd2dW1L?=
 =?utf-8?B?SExoV2V4MDJFK0k1TldiMk9PMlVtV2dCRzVGSUtSalRZS2hQK2FxUDkxMkRS?=
 =?utf-8?B?TEdWMXBvQ0RKclBIRGlRaCtvN2l1c3V0ckpJNVYrb1V2a1lNbXloZ1NpNWJO?=
 =?utf-8?B?bURCcGZkY3VodWRic2tRejEzVzZNLzJyemxIMXd6UTBlbXd4cnRMMTZPMDZJ?=
 =?utf-8?B?eUEzazZLVkJlcWJ1WlNNUk5aazY2V2Fia0trTXRxeVdFZmRpbXdyUlM3a3lY?=
 =?utf-8?B?aE80SEVocGZjcy9KWlBxN3d2eFhTYTNWSG11UXo3SzA1WjFmU0luMEtZVkN2?=
 =?utf-8?B?enEyNmMwVVpyZnViZTc1ek1sUFMrV2xubUI4eEFvY1YxbXhKME5Ob2s1Q2ZO?=
 =?utf-8?B?VVBOYTM5SVhjMnBHdnlEdUxzWjlzdWhzZWxjRDZLVU95emRGZTY4MHF4azM1?=
 =?utf-8?B?ZVkwUTZBK2VYYkNQVEowWGFxZng5SzAvdHBXVy9yQUtOclVHaG9YcjVhNWNX?=
 =?utf-8?B?OE4rcE15aVBMalltSmU4Q2s4YnQydjdIall5OElMQ0lxeXk2ZXJ0dm84YjRl?=
 =?utf-8?B?ZjBYQldqellpRG10MVVLRy9wOE9WMmpnMm1YSEY1MENqRUVwdkFyWXFQNlRo?=
 =?utf-8?B?V3lhNkU4WHBwM2FuL2NIdTAvUjZUaThLbStONFhlZkR6c1ZkR1NkelRnME96?=
 =?utf-8?B?Z1JkN1RzRWZPTk5FdFhXZ1haMFk2RFVUL2dwYThlVkxncGFhNTV5cmtZcmdY?=
 =?utf-8?B?Z09ERzZPWW41S0xJT3hHUXJHVUN1ZHdnVy9nejZCdXovMXNkWDhHNEhOVDRR?=
 =?utf-8?B?cWFWSzNPRHUxTVQ0NUE3MllVTkhNMElnSHVBdmhtbU5tVGRiak1YR3NQS2U0?=
 =?utf-8?B?bmlVNlBDQVFXQkZKMHRDV3gvQktDZnI1dHhuNGFzeFRtaGRnaWxNS09HVHpD?=
 =?utf-8?B?VEwwZ0lMU2p0aGtoZWtQbWUxZXJDaXlkZUhDVVNaZHo0V2I5bS9uSm1DMHlZ?=
 =?utf-8?B?a29Ha3lvTWllZ2c2Z2JqN2JIdFc4U1FORnVwRlpaWW1TeGRYY0RHLytORkFu?=
 =?utf-8?B?YUQ2YVQ2a2JkTURrQzRjZElTY0hTMkhJRmh0cFpvMzhCWVE1RHFyYWNxYm9i?=
 =?utf-8?B?Tkllb0xrd3VydHhNNFA3Mk9aZmlvbEVPc1RtNEM4aEt0Q1JRNC8rK0pPNW9o?=
 =?utf-8?B?czZnZjlGRWlnYi9SNHA5Z3RoZnBTNGs3bWxhT0w2QngvWUxMOHIwRkxVbmV6?=
 =?utf-8?B?V0JhQjY2c0lJZHFlb0dYYVZLWVZFZ0I5a0V3RE1Tb2ZscEt1SUtWQW9SaE1r?=
 =?utf-8?B?TGluTFZMN3l5MmNnS2VEQThXUjVNTVFQWk42OHVKUUE2akVTemprY2FkckpY?=
 =?utf-8?B?UDBBQW4yWHg5K05peFA4RFZ3RE0rUzZCQjNHZ09QRDNNWlAybzRYdVNMRzdn?=
 =?utf-8?B?MmF1WG9uempEbW40ckxGbUdldGVGWG5JNkUzNlpBVS9Ia0htbVVDSFR1WHJs?=
 =?utf-8?B?dzNSS2tFZk1NdEV6VzBBMFlPbkdUejNUOUo1dWhXckZ2dmNlTCt5aWpXQTFY?=
 =?utf-8?B?dlg5b1pwYk9PWGg2bXVEdGorNklQS1FMenpnb1JpSk1wOEVwSFZFYVdnaCt4?=
 =?utf-8?B?NytSNThud3hxS0ZlM0NFM3BFc25lVGNmNG9VRDRwUmYrM0w5MkhOcGpzVGVI?=
 =?utf-8?B?TWExaUkva295dDBCT3d0WDlvVG0zV1hPNWMzNmpIMkMrdFlRWE56M3ZOTzNh?=
 =?utf-8?B?b2M1bjJyWThOUUV4SXdnSnRuU3FvRHJvTmVqUXdMWUYxS2RpY2dEbUMvU1U2?=
 =?utf-8?B?TWVoK0NYSUFpQTRySmhoaFVTbjFXOEp6NTJ1c3BUTlREQStnZTBLbFgvS3pN?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42B0B9063F38146AD430CEA989842A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6026.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52a8593-f89c-4a5e-fe81-08dbcbd0d50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:43:19.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zy7eWkJtC/t0USg/fyZD1Vq1nrjqjF3615GRoLMbYaK6ywNKidU9Qt6U9WO+sJThdlg/eQSzyERPMVZDPGLRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5944
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.190100-8.000000
X-TMASE-MatchedRID: xcONGPdDH5oNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDzndSXz
        MJpoDyqTBu2tArAeqerSaNl8gtRE4XMODEom7uu6E0Q83A2vD+ux/h/gLHG55F+aJfM1BJF8n1J
        EEv0fxQ+KN8FKvOKOkm807XIPlYcocSMuJiCnm+ED2WXLXdz+AbLiLKO9VZOifmHrLgoJIlx39+
        AaChc3BwPfsqPc5PdlYfZIYcagyVl5F2Bxez3bF0g5Iem1vm3H8/hTakhR/NAOkJQR4QWbsJDFc
        NImePgDbO06arcmONh8T/TWUlMbtwSyFAt8hmvKdXu122+iJtq4hAMe708bDkVMrA9p2wTsmKbh
        u5KaCkcIngveyuDaSnbbTtWpu2f+jSvwhwgrLVPmAId+2bAQwkhnmcEe4ensYz65TQfoDKvlaZK
        TfMdLuU/vIztt9VZYkZOl7WKIImrS77Co4bNJXVZ0V5tYhzdWxEHRux+uk8jpP8tMOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.190100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E5E515176092A0CE6B4A8FA27AF1654E36AF65703E963A36D9EF9C3678F24F942000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjMtMTAtMTAgYXQgMTE6NTEgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwOS8xMC8yMyAxMDo0OSwgSmlhbiBZYW5n
IGhhIHNjcml0dG86DQo+ID4gRnJvbTogImppYW4ueWFuZyIgPGppYW4ueWFuZ0BtZWRpYXRlay5j
b20+DQo+ID4gDQo+ID4gTWFrZSBNZWRpYVRlaydzIGNvbnRyb2xsZXIgZHJpdmVyIGNhcGFibGUg
b2YgY29udHJvbGxpbmcgcG93ZXINCj4gPiBzdXBwbGllcyBhbmQgcmVzZXQgcGluIG9mIGEgZG93
bnN0cmVhbSBjb21wb25lbnQgaW4gcG93ZXItb24gYW5kDQo+ID4gcG93ZXItb2ZmIGZsb3cuDQo+
ID4gDQo+ID4gU29tZSBkb3duc3RyZWFtIGNvbXBvbmVudHMgKGUuZy4sIGEgV0lGSSBjaGlwKSBt
YXkgbmVlZCBhbiBleHRyYQ0KPiA+IHJlc2V0IG90aGVyIHRoYW4gUEVSU1QjIGFuZCB0aGVpciBw
b3dlciBzdXBwbGllcywgZGVwZW5kaW5nIG9uDQo+ID4gdGhlIHJlcXVpcmVtZW50cyBvZiBwbGF0
Zm9ybSwgbWF5IG5lZWQgdG8gY29udHJvbGxlZCBieSB0aGVpcg0KPiA+IHBhcmVudCdzIGRyaXZl
ci4gVG8gbWVldCB0aGUgcmVxdWlyZW1lbnRzIGRlc2NyaWJlZCBhYm92ZSwgSSBhZGQNCj4gPiB0
aGlzDQo+ID4gZmVhdHVyZSB0byBNZWRpYVRlaydzIFBDSWUgY29udHJvbGxlciBkcml2ZXIgYXMg
YSBvcHRpb25hbCBmZWF0dXJlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGppYW4ueWFuZyA8
amlhbi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCA5Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysr
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlh
dGVrLWdlbjMuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdl
bjMuYw0KPiA+IGluZGV4IGUwZTI3NjQ1ZmRmNC4uYWQ0YjI1YzM0ZjVkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gQEAgLTgs
NiArOCw3IEBADQo+ID4gICANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgICNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1l
ci5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxp
bnV4L2lycS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaD4N
Cj4gPiBAQCAtMjAsNiArMjEsOCBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rl
dmljZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BtX2RvbWFpbi5oPg0KPiA+ICAgI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3dha2V1cC5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQo+ID4gICAjaW5j
bHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiAgIA0KPiA+ICAgI2luY2x1ZGUgIi4uL3BjaS5oIg0K
PiA+IEBAIC0xMDAsNiArMTAzLDEzIEBADQo+ID4gICAjZGVmaW5lIFBDSUVfQVRSX1RMUF9UWVBF
X01FTQkJUENJRV9BVFJfVExQX1RZUEUoMCkNCj4gPiAgICNkZWZpbmUgUENJRV9BVFJfVExQX1RZ
UEVfSU8JCVBDSUVfQVRSX1RMUF9UWVBFKDIpDQo+ID4gICANCj4gPiArLyogRG93bnN0cmVhbSBD
b21wb25lbnQgcG93ZXIgc3VwcGxpZXMgdXNlZCBieSBNZWRpYVRlayBQQ0llICovDQo+ID4gK3N0
YXRpYyBjb25zdCBjaGFyICpjb25zdCBkc2NfcG93ZXJfc3VwcGxpZXNbXSA9IHsNCj4gPiArCSJw
Y2llMXY4IiwNCj4gPiArCSJwY2llM3YzIiwNCj4gPiArCSJwY2llMTJ2IiwNCj4gPiArfTsNCj4g
DQo+IFBsZWFzZS4uLi4NCj4gDQo+IHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBkc2NfcG93ZXJf
c3VwcGxpZXNbXSA9IHsNCj4gCSJ2cGNpZTF2OCIsDQo+IAkidnBjaWUzdjMiLA0KPiAJInZwY2ll
MTJ2IiwNCj4gfTsNCj4gDQoNCk9LLg0KDQo+ID4gKw0KPiA+ICAgLyoqDQo+ID4gICAgKiBzdHJ1
Y3QgbXRrX21zaV9zZXQgLSBNU0kgaW5mb3JtYXRpb24gZm9yIGVhY2ggc2V0DQo+ID4gICAgKiBA
YmFzZTogSU8gbWFwcGVkIHJlZ2lzdGVyIGJhc2UNCj4gPiBAQCAtMTIyLDYgKzEzMiw5IEBAIHN0
cnVjdCBtdGtfbXNpX3NldCB7DQo+ID4gICAgKiBAcGh5OiBQSFkgY29udHJvbGxlciBibG9jaw0K
PiA+ICAgICogQGNsa3M6IFBDSWUgY2xvY2tzDQo+ID4gICAgKiBAbnVtX2Nsa3M6IFBDSWUgY2xv
Y2tzIGNvdW50IGZvciB0aGlzIHBvcnQNCj4gPiArICogQHN1cHBsaWVzOiBEb3duc3RyZWFtIENv
bXBvbmVudCBwb3dlciBzdXBwbGllcw0KPiA+ICsgKiBAbnVtX3N1cHBsaWVzOiBEb3duc3RyZWFt
IENvbXBvbmVudCBwb3dlciBzdXBwbGllcyBjb3VudA0KPiA+ICsgKiBAZHNjX3Jlc2V0OiBUaGUg
R1BJTyBwaW4gdG8gcmVzZXQgRG93bnN0cmVhbSBjb21wb25lbnQNCj4gPiAgICAqIEBpcnE6IFBD
SWUgY29udHJvbGxlciBpbnRlcnJ1cHQgbnVtYmVyDQo+ID4gICAgKiBAc2F2ZWRfaXJxX3N0YXRl
OiBJUlEgZW5hYmxlIHN0YXRlIHNhdmVkIGF0IHN1c3BlbmQgdGltZQ0KPiA+ICAgICogQGlycV9s
b2NrOiBsb2NrIHByb3RlY3RpbmcgSVJRIHJlZ2lzdGVyIGFjY2Vzcw0KPiA+IEBAIC0xNDEsNiAr
MTU0LDkgQEAgc3RydWN0IG10a19nZW4zX3BjaWUgew0KPiA+ICAgCXN0cnVjdCBwaHkgKnBoeTsN
Cj4gPiAgIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSAqY2xrczsNCj4gPiAgIAlpbnQgbnVtX2Nsa3M7
DQo+ID4gKwlzdHJ1Y3QgcmVndWxhdG9yX2J1bGtfZGF0YSAqc3VwcGxpZXM7DQo+ID4gKwlpbnQg
bnVtX3N1cHBsaWVzOw0KPiA+ICsJc3RydWN0IGdwaW9fZGVzYyAqZHNjX3Jlc2V0Ow0KPiA+ICAg
DQo+ID4gICAJaW50IGlycTsNCj4gPiAgIAl1MzIgc2F2ZWRfaXJxX3N0YXRlOw0KPiA+IEBAIC03
NjMsNyArNzc5LDcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9wYXJzZV9wb3J0KHN0cnVjdA0KPiA+
IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ID4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpZS0+
ZGV2Ow0KPiA+ICAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9k
ZXZpY2UoZGV2KTsNCj4gPiAgIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlZ3M7DQo+ID4gLQlpbnQgcmV0
Ow0KPiA+ICsJaW50IHJldCwgaTsNCj4gDQo+IFNpbmNlIHlvdSBhbnl3YXkgaGF2ZSB0byBzZW5k
IGEgdjQsIGNhbiB5b3UgcGxlYXNlIGFsc28gb3JkZXIgdGhlc2UNCj4gYnkgbmFtZT8NCj4gDQo+
IGludCBpLCByZXQ7DQo+IA0KDQpJIHdpbGwgcmUtb3JkZXIgdGhlbSBpbiBuZXh0IHZlcnNpb24u
DQoNCj4gPiAgIA0KPiA+ICAgCXJlZ3MgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBk
ZXYsIElPUkVTT1VSQ0VfTUVNLA0KPiA+ICJwY2llLW1hYyIpOw0KPiA+ICAgCWlmICghcmVncykN
Cj4gPiBAQCAtODA5LDE0ICs4MjUsODYgQEAgc3RhdGljIGludCBtdGtfcGNpZV9wYXJzZV9wb3J0
KHN0cnVjdA0KPiA+IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ID4gICAJCXJldHVybiBwY2llLT5u
dW1fY2xrczsNCj4gPiAgIAl9DQo+ID4gICANCj4gPiArCXBjaWUtPm51bV9zdXBwbGllcyA9IEFS
UkFZX1NJWkUoZHNjX3Bvd2VyX3N1cHBsaWVzKTsNCj4gPiArCXBjaWUtPnN1cHBsaWVzID0gZGV2
bV9rY2FsbG9jKGRldiwgcGNpZS0+bnVtX3N1cHBsaWVzLA0KPiA+ICsJCQkJICAgICAgc2l6ZW9m
KCpwY2llLT5zdXBwbGllcyksDQo+ID4gKwkJCQkgICAgICBHRlBfS0VSTkVMKTsNCj4gPiArCWlm
ICghcGNpZS0+c3VwcGxpZXMpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJ
Zm9yIChpID0gMDsgaSA8IHBjaWUtPm51bV9zdXBwbGllczsgaSsrKQ0KPiA+ICsJCXBjaWUtPnN1
cHBsaWVzW2ldLnN1cHBseSA9IGRzY19wb3dlcl9zdXBwbGllc1tpXTsNCj4gPiArDQo+ID4gKwly
ZXQgPSBkZXZtX3JlZ3VsYXRvcl9idWxrX2dldChkZXYsIHBjaWUtPm51bV9zdXBwbGllcywgcGNp
ZS0NCj4gPiA+c3VwcGxpZXMpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+ICsNCj4gPiArCXBjaWUtPmRzY19yZXNldCA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRl
diwgImRzYy1yZXNldCIsDQo+ID4gKwkJCQkJCSAgR1BJT0RfT1VUX0xPVyk7DQo+ID4gKwlpZiAo
SVNfRVJSKHBjaWUtPmRzY19yZXNldCkpIHsNCj4gPiArCQlyZXQgPSBQVFJfRVJSKHBjaWUtPmRz
Y19yZXNldCk7DQo+ID4gKwkJaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlkZXZf
ZXJyKGRldiwgImZhaWxlZCB0byByZXF1ZXN0IERTQyByZXNldA0KPiA+IGdwaW9cbiIpOw0KPiAN
Cj4gZGV2X2Vycl9wcm9iZSgpIGRvZXMgZXhhY3RseSB3aGF0IHlvdSdyZSBkb2luZyBoZXJlLCBi
dXQgaXQncyBzaG9ydGVyDQo+IDotKQ0KPiANCg0KR290IGl0DQoNCj4gPiArDQo+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4g
ICANCj4gPiArc3RhdGljIGludCBtdGtfcGNpZV9kc2NfcG93ZXJfdXAoc3RydWN0IG10a19nZW4z
X3BjaWUgKnBjaWUpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRl
djsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIFNraXAgZG93bnN0
cmVhbSBjb21wb25lbnQncyBwb3dlci11cCBmbG93IGlmIGl0IHdhcyBrZXB0DQo+ID4gcG93ZXIt
b24NCj4gDQo+ICogU2tpcCBwb3dlcmluZyB1cCB0aGUgZG93bnN0cmVhbSBjb21wb25lbnQgaWYg
aXQgd2FzIGtlcHQgcG93ZXJlZCBvbg0KPiANCg0KVGhhbmtzIGZvciBjb3JyZWN0aW5nIHRoYXQu
DQoNCj4gDQo+ID4gKwkgKiB3aGlsZSBzeXN0ZW0gZW50ZXJlZCBzdXNwZW5kIHN0YXRlDQo+ID4g
KwkgKi8NCj4gPiArCWlmIChkZXZpY2Vfd2FrZXVwX3BhdGgoZGV2KSkNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArDQo+ID4gKwkvKiBBc3NlcnQgRG93bnN0cmVhbSBDb21wb25lbnQgcmVzZXQgKi8N
Cj4gPiArCWlmIChwY2llLT5kc2NfcmVzZXQpDQo+ID4gKwkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNs
ZWVwKHBjaWUtPmRzY19yZXNldCwgMSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVndWxhdG9yX2J1
bGtfZW5hYmxlKHBjaWUtPm51bV9zdXBwbGllcywgcGNpZS0NCj4gPiA+c3VwcGxpZXMpOw0KPiA+
ICsJaWYgKHJldCkNCj4gPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUgRFNDIHBv
d2VyIHN1cHBsaWVzOg0KPiA+ICVkXG4iLCByZXQpOw0KPiA+ICsNCj4gPiArCS8qIERlLWFzc2Vy
dCBEb3duc3RyZWFtIENvbXBvbmVudCByZXNldCAqLw0KPiA+ICsJaWYgKHBjaWUtPmRzY19yZXNl
dCkNCj4gPiArCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGNpZS0+ZHNjX3Jlc2V0LCAwKTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBtdGtfcGNpZV9kc2NfcG93ZXJfZG93bihzdHJ1Y3QgbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4g
PiArew0KPiA+ICsJLyoNCj4gPiArCSAqIEtlZXAgZG93bnN0cmVhbSBjb21wb25lbnQgcG93ZXIt
b24gaWYgaXQgbmVlZCB0byB3YWtlIHVwIHRoZQ0KPiANCj4gKiBLZWVwIGRvd25zdHJlYW0gY29t
cG9uZW50IHBvd2VyZWQgb24gaWYgaXQgaXMgY2FwYWJsZSBvZiB3YWtpbmcgdXANCj4gKiB0aGUg
c3lzdGVtIGZyb20gc3VzcGVuZA0KPiANCg0KVGhhbmtzIGZvciBjb3JyZWN0aW5nIGFuZCBzb3Jy
eSBmb3IgbXkgRW5nbGlzaCA6KQ0KDQo+ID4gKwkgKiBzeXN0ZW0gaW4gc3VzcGVuZCBzdGF0ZQ0K
PiA+ICsJICovDQo+ID4gKwlpZiAoZGV2aWNlX3dha2V1cF9wYXRoKHBjaWUtPmRldikpDQo+ID4g
KwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCS8qIEFzc2VydCBEb3duc3RyZWFtIENvbXBvbmVudCBy
ZXNldCAqLw0KPiA+ICsJaWYgKHBjaWUtPmRzY19yZXNldCkNCj4gPiArCQlncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAocGNpZS0+ZHNjX3Jlc2V0LCAxKTsNCj4gPiArDQo+ID4gKwlyZWd1bGF0b3Jf
YnVsa19kaXNhYmxlKHBjaWUtPm51bV9zdXBwbGllcywgcGNpZS0+c3VwcGxpZXMpOw0KPiA+ICt9
DQo+ID4gKw0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQpK
aWFuIFlhbmcNCg==

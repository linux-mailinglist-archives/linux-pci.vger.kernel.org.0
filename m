Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223147C8076
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 10:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJMIhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJMIhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 04:37:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5491;
        Fri, 13 Oct 2023 01:37:30 -0700 (PDT)
X-UUID: b9546df069a311ee8051498923ad61e6-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Twi8ugDaR/f+J4vz5IagMZD2ImbKtSuqYPk/yGEP71c=;
        b=fVkzcznv3K4k9ZhuNFhAsY2diX2YDjTEqaIlU1XKi2p7He4VLalkuhsrZ97/izC28MIjehQgV6WOVIhYitQPN7rbZ9g0uf0elAhVsku0lbJknS+IfPYN4zmtooPJJA3ZPz6hcpSFBoqvmsqViSxJc2K0j/76Ra7OkVufM1DMG0s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:7e85ea5d-b6ed-4545-bbda-c2b6a20c24c6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:83a215c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b9546df069a311ee8051498923ad61e6-20231013
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 585870577; Fri, 13 Oct 2023 16:37:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 16:37:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 16:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYN+DROVNItI2DJacSIChg2R52HtQLChNiGLMi+TREo3Tlah7SVgVV3N0aOFNENPouvetc439YZbE4IZ5PS4/R98n+uK0GmQgCyVbycZw8RS4gRab8NPhAD0KLdbhV0Wl/8sEhNRkdkYdLV8zqwAjK+syWqV7q3kiJ6X2XVzKsCN5+zxUWXfQwO65kepcTLUfzbatCX5HOUb6nJU6T6hAmX9gtxptINkX9Jc7DiZ6Bfls03HY8Gwwfr9DQKM8iKGlx9134KgDa2okSrcu1asar2MjNQnQtC9IKrGiHm/v9VeLnIArUHZjsjgIVoctfNhdvqII1WzZdBL1uh1aGtlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Twi8ugDaR/f+J4vz5IagMZD2ImbKtSuqYPk/yGEP71c=;
 b=es1hQeCHhrBzFDDr5etIOSIsL8dIJgfI1GT1BVG+hK9z8McY6hEKtnEO0sql+rolpQdUbBNX2NbjzHp3a+eCzmJxvHJ8yKxSMip4kqbFPD7XGA7Y/YzyXEPseBEVoFg9Rwu6FoBU6GNQIpDlqr8Lo1JLF9Plfdws5uzCp/EwXEZjq/YVP1SbtFV/Wn5l01yIPpu4GlzL/s/DoQ4Ut1+LWIZ/r78e/YVZ3xBamYTxHhYmnsPvqc2f9bMW+CMklhRvMKG94vxts+pa24z6l+OhKPwfqLFCjzeNbu+hAsbUsIqK8oVjEjwzQGrwoqlabtpD4b59CgKKzLUIMcGClXD8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Twi8ugDaR/f+J4vz5IagMZD2ImbKtSuqYPk/yGEP71c=;
 b=pvF9of7ZcegtVVjkfpodFvkht2cvmVgaAAtcuT78z+5zcst4PHj0xiLP96uGurKz1PC7w2aEpmdx64T+h4g6OOaE98s06U8WqGWSuuIuM+qTfsf4r/aoRSWvXIRySvDZ9ll5HFNmbxL3PS0y5ehqWWfpstNZ2PhS4H2EFzCt8+I=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB7390.apcprd03.prod.outlook.com (2603:1096:820:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:37:17 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0%5]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 08:37:17 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
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
Thread-Index: AQHZ/D4+ALwyQsnSTEKf880/L3OgGrBEuWSAgADwVgA=
Date:   Fri, 13 Oct 2023 08:37:17 +0000
Message-ID: <cfadcaf435f36e08e1a9dd30eff99a5f1890752a.camel@mediatek.com>
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
         <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
In-Reply-To: <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB7390:EE_
x-ms-office365-filtering-correlation-id: 3ec47173-c53a-489b-80e4-08dbcbc79bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5TMSZPs3Wfqnel+PRfITPDPUaNIos3BnELBFedTYByNJQsCo0EX6haRBD/HoQiegO1sYy/hUD5et76/jziV1/WLjQiZClGeyj2se2tJ8ryOyYdiJSM+T/D4Mz64lBYITzG5ES+hvA0VqYVxfdvJEIIM/cmZotLdGTpfG9SvIu+/pTZS6oQMICzKUMmDkkauqHi76K2xgS2F0e9A0NRdDTno25/FPU5KMP8MZFzUkVAKunnoMmJjP62ggXl7McGFsKE0V3EMrJ480k94w+/wCY59au4o8/kclws2LE4pTJmyODgS1OHKEFDYHibrMtMMO4ETrxs1sZ6yJnmPTnPcV1/FBwjKAbA6tzdWCSLTZSyhtmyF39XrKPmgIbMrQfxCOSQMaZlRbAYCUoJiFVpc8Rcafk41dHEt6g+3XxdHclC4Ke9JdQCZeCVMbb7k3xwZYw951jV7G/szglDeCVDfOloOXpvNvzHsxsBJ4KvMwqyFAH4pXfBqJxPFEAt3j7X9XMJPYrmpbzW/ZtRM1zVyAroXGQ9q1BdDZpREKzHJYvMnZxXzXxIzZxvVV7lSgdEoA1e+7pjnISJKqYzgWGkqHeZpJ/V/4s6nEGga7KbBBp/+Asg2FfKHgb9yBYRZZ+dzkAkhgmto2wo9yAWZd+9DT8Ezaj/jelzgc8RKzydu7o8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66476007)(71200400001)(66556008)(7416002)(66946007)(66446008)(54906003)(110136005)(64756008)(478600001)(76116006)(316002)(2906002)(4001150100001)(6486002)(122000001)(86362001)(38100700002)(107886003)(8676002)(38070700005)(4326008)(6512007)(26005)(41300700001)(8936002)(2616005)(6506007)(5660300002)(36756003)(83380400001)(85182001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODNqNEdqOTNCeUt1aHhqN2dxbWZJeE5TVjFWR1RQYUQvYzhpbUZvSFhiR3Vl?=
 =?utf-8?B?ZnNvWVg3MTJtMk5lWERnWlk0SFdqMzVQN1ZGNFN3UDZnY1U0ZFA4RVlqRll6?=
 =?utf-8?B?T0NIRjlDRjVVRXd5L0kxR2MxNVAvWHVuRUVJc0Nqb0dyM0ZiZUVpcVVyUTJQ?=
 =?utf-8?B?VVd4RGRXQUJpRGN3K1BpaEpPa1RHbUxBUGgva0UzMVJURklpRmdHcEVrcWJN?=
 =?utf-8?B?TTRYT2NnalVGc2s2anRDYXI1S3B6N04zQ2lhMGp2UGtmdDFrc0pVNGFxbmNU?=
 =?utf-8?B?M0NrK1hlU1FPbFIvV1o1ZGExNDdwaFRGRDNwTm1meXB4WEQ1S2ozZHdpbWgw?=
 =?utf-8?B?Sm9XZ2hibzZ2d21pakN3UFA5WTdlWGtPWlZmdFhqaVM3NnhEOVl4eFhVQldM?=
 =?utf-8?B?UDVCMXRIdzYzRXlUYTNCMFpZU0FrL1VmdUZnREZaYlpEMncwQUpWb3B3K3R5?=
 =?utf-8?B?Y0ZveS8zS0c4Z3o2aXZML3graE5ZeXh0dUdCT01wRUhiRS9YS3Y3UzNUNVEx?=
 =?utf-8?B?MFVXd3BaUzZjWVVGNUhVVnB4cW9ndElyQ1JIWFdnRGF3VFlzamlmWG8wN0ZZ?=
 =?utf-8?B?b3B3RW5SSnQ4NmhBQnNSYUtjQjE3T0pabE01YkNKNytkVHhkQUgxd3JBVXV2?=
 =?utf-8?B?ZzhUNEt5Q0p1STA3Skt1eURVM3g2S21TSTBIR1dsNHJvOUNIRWtvNEdoN3ly?=
 =?utf-8?B?ZDRxdDBjNmtOcWcxS0tVMlIrb2tCcmp6S1Nob3lzbUNMNHkyRnhFUFNYNzFa?=
 =?utf-8?B?Y2k3Z2Q2UFdvc2Z5cEx1ZG1HamVRdi8wUDRwRUd3NU9ZN21KZTNxUkVLVXZD?=
 =?utf-8?B?V00zY05aVDRoRDlnM3BzWjA2NmE2cDVBS0xUc2V1aDJHSWF6TzRVNGNxRFdr?=
 =?utf-8?B?MU96aDJqQm5Nb3B3NjFSZ1h0YldaVm9Malo0SldvSUUzMTlRbVNjbTRsaUdZ?=
 =?utf-8?B?MTlscE9nT3RQRkxXdW9USzBaSGtMR0FoSmtuQWtOOWJVTDFUM2Vob0p4S2JW?=
 =?utf-8?B?MktRUVltSnYvbE5MRmRLMHNXMHFFY0VHVFVjd29KSHJtZVRGOXJiZ3RjMlg3?=
 =?utf-8?B?eS9BQ1RPS2dNc1Aya2dpZGh5REZWcC81Qmh2VUhJRERXVG10L3F4MEc2OFps?=
 =?utf-8?B?SmQxdDh5WnFsN0k2L2QvUlVET3BVQ0lybjR1ekJPcHZJSG9HbFIzenhuZ2hs?=
 =?utf-8?B?TEp4bHlTU1pHWE16TUtUMnJWakp6RmhwWmdsNlNxNXN0QkdkYzFNNTdTQllq?=
 =?utf-8?B?QXZKWmY0U0VlQ3ljOG11UjVSbm9uRUt0VU1NTWZqQVlncjFGakVGb3VTQncx?=
 =?utf-8?B?azd5eTM0TlFwY0tsaGdYSnlTVGxabXpWNWptcUcxZ3hhTTJWQ1JMMC9HSUNa?=
 =?utf-8?B?ZjVHOHFuaWwwWGVBNGFibzg4Y05Gd1ExU3R5NHlVSmE0bzlzQU1WcGxVNHVr?=
 =?utf-8?B?NU1LNHRvN0RmbDl0aU5PTmR1SUZzTUlDWVRFZkt3dUJ1YU1HdkU2RDVURjhl?=
 =?utf-8?B?aHdjWHk2V0xIV2VaUDFYNG9oM3MrNTd5L3VWejh1MG1MRGU2NGRJMGpGWW9y?=
 =?utf-8?B?K2ZqMndmTkNpdngrckRWUnBlR1hIajBUV243blFpb2hnTS9Gc2gzSFVUN2l4?=
 =?utf-8?B?KzFvdWRqeXRKNDhpOStCWVd1aGFUZENub0dnSXJ4elgwOWFaNkgvemk0KzZl?=
 =?utf-8?B?dkQ1NDJPUTJ2RDZITnJHbFl3dGZ3OW5hQzVCSk5abmZ0N3FXY0NGZVAzMHRz?=
 =?utf-8?B?RUU0VDY1dG0wYmhjYlJGQkVjM2ZlRTNVOFpSaHNxUlc4T2JYekZZemtET3JW?=
 =?utf-8?B?YTc0MmRIOVJaRkFxTFhVUytpWWNwUVAySlpRZDNQeWhoOHpGdkNHSnFPbzB4?=
 =?utf-8?B?L1R0S3ViN2ZTSHpqVmkxNmNQT2hIZmZGMG1KblluR2UzTWxLNDJHUjBIaVdn?=
 =?utf-8?B?S3B5aW9SbUVVY2x1ajBEb0dRNjAvdlNzaUJuL2w3WUdkM3hqYXN1UWZYSExJ?=
 =?utf-8?B?NE5qTDhpREhEdlRLZ2FBcVp3QmljY2kwZWlFYzdCbjdWNWJpSVVLNFArWUwr?=
 =?utf-8?B?dFlhVmRRQ3VHaFZpeU81b3VaSUY2Q3dlNVZHdHVZOUdic3FrUjhZZWN0cmxY?=
 =?utf-8?B?SmxsdWRSdEl4eks1NHZ1bnV3TDA4VTF5RjJiejR4WG40eDJhMjl5dDNRTmNE?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B30D9D50317614DAFA9CF48D3239A76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec47173-c53a-489b-80e4-08dbcbc79bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:37:17.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSW1xPIxWURIlCgVXdJLlaH22YdJU2p7ZfFbRbhZKfkL1+XiiTswJ4qT6U20sHnTyst7C18lcUXNjwTGF3j4vYbqr0zbFmxjPyk4JJLlEFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7390
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.969000-8.000000
X-TMASE-MatchedRID: xIhOSkOSohXUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCkF8Z0jCZWN8mlaAItiONP2H7D1bP/FcOoKwF4K/wIz9Wi/
        8MrDIELyevjt7p70JfEpvOa2tJ0Dwyu8WoQee6RWM29hkek7Xd6X1XMd/Sqvu+Cckfm+bb6AcaY
        As8/F613H9rc2KKXILoltNX55JozXcBvWbOnUS6IHL770UjjjigGa+oYp5i6oT7lsB95pa6o91l
        VhtDA+HLp51PS0pmeQfCRX96rrUhCcKtSGJxlSHphvn2pPa92pReWnUUdhI9baHz+Hncozb8Wyv
        NcmePID5uBkal+n5Lh4YIi83R+XRQjr0vbZGNcueAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZxE
        AlFPo846HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.969000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 60F299E58DC47923B362BADC03E4160CFD194AF5124C3172184A76FDD0A2DE162000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDE3OjM4ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICANCj4gDQo+IE9uIDExLzEwLzIwMjMgMTQ6MjYsIEppYW5qdW4g
V2FuZyB3cm90ZToNCj4gPiBUaGUgc2l6ZSBvZiB0cmFuc2xhdGlvbiB0YWJsZSBzaG91bGQgYmUg
YSBwb3dlciBvZiAyLCB1c2luZyBmbHMoKQ0KPiBjYW5ub3QgDQo+ID4gZ2V0IHRoZSBwcm9wZXIg
dmFsdWUgd2hlbiB0aGUgc2l6ZSBpcyBub3QgYSBwb3dlciBvZiAyLiBGb3INCj4gZXhhbXBsZSwg
DQo+ID4gZmxzKDB4M2UwMDAwMCkgLSAxID0gMjUsIGhlbmNlIHRoZSBQQ0llIHRyYW5zbGF0aW9u
IHdpbmRvdyBzaXplDQo+IHdpbGwgYmUgDQo+ID4gc2V0IHRvIDB4MjAwMDAwMCBpbnN0ZWFkIG9m
IHRoZSBleHBlY3RlZCBzaXplIDB4M2UwMDAwMC4gRml4DQo+IHRyYW5zbGF0aW9uIA0KPiA+IHdp
bmRvdyBieSBzcGxpdHRpbmcgdGhlIE1NSU8gc3BhY2UgdG8gbXVsdGlwbGUgdGFibGVzIGlmIGl0
cyBzaXplDQo+IGlzIG5vdCANCj4gPiBhIHBvd2VyIG9mIDIuDQo+IA0KPiBIaSBKaWFuanVuLA0K
PiANCj4gSSd2ZSBubyBrbm93bGVkZ2UgaW4gUENJRSwgc28gbWF5YmUgd2hhdCBteSBzdWdnZXN0
aW9uIGlzIHN0dXBpZDoNCj4gDQo+IElzIGl0IG1hbmRhdG9yeSB0byBmaXQgdGhlIHRyYW5zbGF0
aW9uIHRhYmxlIHNpemUgd2l0aCAweDNlMDAwMDAgKGluIA0KPiB0aGlzIGV4YW1wbGUpID8NCj4g
SSdtIGFza2luZyBiZWNhdXNlIHlvdSBjYW4gaGF2ZSBhbiBpc3N1ZSBieSByZWFjaGluZyB0aGUg
bWF4aW11bSANCj4gdHJhbnNsYXRpb24gdGFibGUgbnVtYmVyLg0KPiANCj4gSXMgaXQgcG9zc2li
bGUgdG8ganVzdCB1c2Ugb25seSBvbmUgdGFibGUgd2l0aCB0aGUgcG93ZXIgb2YgMiBzaXplDQo+
IGFib3ZlIA0KPiAweDNlMDAwMDAgPT4gMHg0MDAwMDAwICggZmxzKDB4M2UwMDAwMCkgPSAyNiA9
IDB4NDAwMDAwMCkuIFRoZQ0KPiBkb3duc2lkZSANCj4gb2YgdGhpcyBtZXRob2QgaXMgd2FzdGlu
ZyBhbGxvY2F0aW9uIHNwYWNlLiBBRkFJSyBJIGFscmVhZHkgc2VlIHRoaXMgDQo+IGtpbmQgb2Yg
bWV0aG9kIGZvciBtZW1vcnkgcHJvdGVjdGlvbi9hbGxvY2F0aW9uIGluIGVtYmVkZGVkIHN5c3Rl
bXMsDQo+IHNvIA0KPiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgbWV0aG9kIGlzIHNhZmVyIHRoYW4g
dXNpbmcgbXVsdGlwbGUgdGFibGUgZm9yDQo+IG9ubHkgDQo+IG9uZSBzaXplIHdoaWNoIGlzbid0
IGEgcG93ZXIgb2YgMi4NCkhpIEFsZXhhbmRyZSwNCg0KSXQncyBub3QgbWFuZGF0b3J5IHRvIGZp
dCB0aGUgdHJhbnNsYXRpb24gdGFibGUgc2l6ZSB3aXRoIDB4M2UwMDAwMCwNCmFuZCB5ZXMgd2Ug
Y2FuIHVzZSBvbmx5IG9uZSB0YWJsZSB3aXRoIHRoZSBwb3dlciBvZiAyIHNpemUgdG8gcHJldmVu
dA0KdGhpcy4NCg0KRm9yIE1lZGlhVGVrJ3MgU29DcywgdGhlIE1NSU8gc3BhY2UgcmFuZ2UgZm9y
IGVhY2ggUENJZSBwb3J0IGlzIGZpeGVkLA0KYW5kIGl0IHdpbGwgYWx3YXlzIGJlIGEgcG93ZXIg
b2YgMiwgbW9zdCBvZiB0aGVtIHdpbGwgYmUgNjRNQi4NCg0KVGhlIHJlYXNvbiB3ZSBoYXZlIHRo
ZSBzaXplIHdoaWNoIGlzbid0IGEgcG93ZXIgb2YgMiBpcyB0aGF0IHdlIHJlc2VydmUNCmFuIElP
IHNwYWNlIGZvciBjb21wYXRpYmxlIHB1cnBvc2VzLCBzb21lIG9sZGVyIGRldmljZXMgbWF5IHN0
aWxsIHVzZQ0KSU8gc3BhY2UuDQoNClRha2UgTVQ4MTk1IGFzIGFuIGV4YW1wbGUsIGl0cyBNTUlP
IHNpemUgaXMgNjRNQiwgYW5kIHRoZSBkZWNsYXJhdGlvbg0KaW4gdGhlIERUIGlzIGxpa2U6DQpy
YW5nZXMgPSA8MHg4MTAwMDAwMCAwIDB4MjAwMDAwMDAgMHgwIDB4MjAwMDAwMDAgMCAweDIwMDAw
MD4sDQogICAgICAgICA8MHg4MjAwMDAwMCAwIDB4MjAyMDAwMDAgMHgwIDB4MjAyMDAwMDAgMCAw
eDNlMDAwMDA+Ow0KDQpUaGUgTU1JTyBzcGFjZSBpcyBzcGxpdGVkIHRvIDJNQiBJTyBzcGFjZSBh
bmQgNjJNQiBNRU0gc3BhY2UsIHRoYXQncw0KY2F1c2UgdGhlIGN1cnJlbnQgcmlzayBvZiB1c2lu
ZyB0aGUgTUVNIHNwYWNlLCBzaW5jZSBpdHMgYWN0dWFsDQphdmFpbGFibGUgTUVNIHNwYWNlIGlz
IDMyTUIuIEJ1dCBpdCBzdGlsbCB3b3JrcyBmb3Igbm93IGJlY2F1c2UgbW9zdCBvZg0KdGhlIGRl
dmljZXMgb25seSByZXF1aXJlIGEgdmVyeSBzbWFsbCBhbW91bnQgb2YgTUVNIHNwYWNlIGFuZCB3
aWxsIG5vdA0KcmVhY2ggcmFuZ2VzIGhpZ2hlciB0aGFuIDMyTUIuDQoNClNvIGZvciB0aGUgY29u
Y2VybiBvZiByZWFjaGluZyB0aGUgbWF4aW11bSB0cmFuc2xhdGlvbiBudW1iZXIsIEkgdGhpbmsN
Cm1heWJlIHdlIGNhbiBqdXN0IHByaW50IHRoZSB3YXJuaW5nIG1lc3NhZ2UgaW5zdGVhZCBvZiBy
ZXR1cm4gZXJyb3INCmNvZGUsIHNpbmNlIGl0IHN0aWxsIHdvcmtzIGJ1dCBoYXZlIHNvbWUgbGlt
aXRhdGlvbnMoTUVNIHNwYWNlIG5vdCBzZXQNCmFzIERUIGV4cGVjdGVkKS4NCg0KVGhhbmtzLg0K
PiANCj4gDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBBbGV4YW5kcmUNCg==

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1E688DEE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 04:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBCD1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 22:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBCD1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 22:27:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074EB66033;
        Thu,  2 Feb 2023 19:27:35 -0800 (PST)
X-UUID: b27d350ea37211eda06fc9ecc4dadd91-20230203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Jk8IynAdWUJxh3lugzXgEEeoFifSdjyRkWMBaUoSdWE=;
        b=aBZI66QtFPgb7oiQebPhQZ+HyZ+zh+L+vIWIeQhsxg6YyJhHoJcoP3RqWeVIh6dk2sDiKBbAlLfBLM4IX0VxXbJaSwT1foFk+C85GEj9DRFRgjkl0F5kEHNmGnSmZ0Ew3APhFnNwPYlZ5dJdALXc6CJA2ikMXxlTO9pUA33c4+I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:7e0b37eb-2ce0-43cc-8b6a-39741e34cdd6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:ea872956-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b27d350ea37211eda06fc9ecc4dadd91-20230203
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 961247613; Fri, 03 Feb 2023 11:27:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 3 Feb 2023 11:27:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 3 Feb 2023 11:27:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH5Ds4RD9w/qWRCrcFbyKqqgw+vwkXyTJtc2WwNznpB4/OLjxhj4NOcng94PrJ66ODGGpt8PnXyDhXxnUmZJ0NG9fe6VgzKskkfezzyQFLTlKvmJYE+yiWPhogTgdkRLOe4oeR7aVyUnt05RZ9eHcUvikf9Y/w+42EEh3MC2AX1tx22eNZaHE46/whdQqlJPP4cZrobpTmWVCSWvK95AyuNMpwf/N6goInD65+Ccta4q0P4ptLfYdxOG1o5QbYoP9pY+oFUnCLJ7IpmKOh03vdW+bznYdDMlBVXPuKOoLT4IygECsTkuP0RLzGX1bmEb92VMvwDOWcMyD+lS/r/jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk8IynAdWUJxh3lugzXgEEeoFifSdjyRkWMBaUoSdWE=;
 b=ndkdM7MQb0c1NI2Rhx4Z+KGRMV27odke5uYBjMpwHz7NBK8mTV0IJ4BZ6snjg+UAe5JafU0ulSZm7kSkHA19UvZRqaqz769ikOVSi4MvAIGPgE0EwsIIQYcxPO6xOxn/c+hWBzbVpe5RyPUJd0iQIfO1F/4WXe4kEkZG4eYZmHVHG81bTcXkdqZdwXqYHvuFVJZZUlarY1VkB8j3/Nwg6buLwgo1trYYynJf5XEJnPh193giy3Xq5JO5r2hDlhuIcEfEwRN11kL19hYw2v0hBCLmcB/OEauMDPF62kcm/3cLCe/zTPJ+z5+o1vk1W0KdrtpNcFHJD8jybj04g9nlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk8IynAdWUJxh3lugzXgEEeoFifSdjyRkWMBaUoSdWE=;
 b=E+RkAOgPRGucbVFicqvPnos39yQen3NLnN8ibPa3G/Lp+rP3ndlWf+UvW0agy6rVJ9+PXidPDZjbBEacwHVTMpbH/+QWx/xckvFd/DaR14PIMZVC6Xhq5u2+h4TBKBR+ktq4lHPdyVTNQd5dnvsca5aRoIQB9t5NPVs3vNq3tc4=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by KL1PR03MB5889.apcprd03.prod.outlook.com (2603:1096:820:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 03:27:30 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943%6]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 03:27:29 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
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
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?RGF2aWQtWUggQ2hpdSAo6YKx6Yi657+UKQ==?= 
        <David-YH.Chiu@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Topic: [PATCH 1/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Thread-Index: AQHZJWynh9pQotR/nESPofZxg5t/dq6ZyUCAgCLqyYA=
Date:   Fri, 3 Feb 2023 03:27:29 +0000
Message-ID: <dc2665257dc29b28822706bbbd06b81524ec2e86.camel@mediatek.com>
References: <20230111221419.GA1710905@bhelgaas>
In-Reply-To: <20230111221419.GA1710905@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|KL1PR03MB5889:EE_
x-ms-office365-filtering-correlation-id: 055698a4-a67d-4e6d-ab62-08db05969491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvxjpuVaEHfNqeSFimxlemWIOHhSMd+nR22rMv2wtlfxOr9jweWVcwkVbf4Ll7l672+R/lVyZ3oAfPmE7xkMEl2m+cJ3pEm5m+fbeEDUW1ET5PFcRy/YWP5AJVJGWgq6kGcWIRdj/YCGUmfI/Fmjufg/+8nbQUNbA/p1koLexj4UNDxI8jFcmOqsfCvXb/4UztsdZrlPbXkq2okA33UIDkisr+7SpWhm/tdBhQDJuCLS2GSO3HbVYqpGojwIsp4zH7e1p8dCNieHq6bcQkWEmSjd26nK4iotZdMFVE5uuDiOls0WBsQbd+u2rO5gg8xqcIBrcRCMlZ4Run0sK8lARDstnsl2lcsQ4He2Qkh+FN+/em7A9Ar4C8ku9dZ9VYZy9NljL5a3rMWpO5fiUZKrTjFs8ersAJBtXHw752Kafx/uoo14YmSewsQtpuRSdoJiZAnVAiEOM1X/SUJUAF7ER8bgXee3b9hcAwVcGgOhckH3Xs314J87AD6IaR3bbN+h35mknZk7Xan+NIcR7/Ki8sPkcsUADxB/QqcAzQGTGZlaMfgE+nrduyjbs/EAtt5qkU8znbMeDJHujfD+lDJuy8SvEpG6nmtZv64cZtCNmvOuptV2R1WJaZ5W02FTlJEUuzbyDUPG/OFElIpvcMTk4EuhuQbj1XLixsUePoI/BFwz/27Vm7NfaO8Lzj0MSM9cqkO//gwyz8WCe6eEJ3uBBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199018)(316002)(83380400001)(71200400001)(54906003)(107886003)(2616005)(36756003)(85182001)(2906002)(38100700002)(122000001)(6506007)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(26005)(6486002)(186003)(6512007)(4326008)(478600001)(6916009)(41300700001)(8936002)(86362001)(8676002)(38070700005)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0k5dm14L2d2MzgycHZrSEZRcUQ1S21zQkg4Sm94cndQN0NUTjArVnlpUGNR?=
 =?utf-8?B?ckFRY3h6cFRyRHBlZWFsSU5jcklUZU1HV3hKcktuOURmSWdWUGJlWjRoRjMv?=
 =?utf-8?B?aW42VHhQb2ZBbjRpaHVOMXZYUWdnNzUrczVOVWJjNTB2Nm4wYjZhaURTcisw?=
 =?utf-8?B?VDFYd3FTbzJIUFhadml3UzJzaDNPenBqNStYRWFWVTJMYysxTTFkOGREQlJN?=
 =?utf-8?B?dzAzVnJWaVNCeGpwRDlpRnAvbGdjTXJwQnlJRWQ5NGJjb1JxVllLWlZMMjBt?=
 =?utf-8?B?bDgzV1MrZTVUUi9vNEkrYVBHNERidW1oNnRhSHkvcHdTTlVyNURBc21ESXpr?=
 =?utf-8?B?NEthY1BGZEFmMkt4NURZMkhCMERsM1BMTUxjSnFDN2dHRHFmNzJTU2dlb2o5?=
 =?utf-8?B?eGhKakprUHFxaVVNUzNpMy9MRURDc09jMFNyb1JyS1NzM0RQVWQ1WkplRDNx?=
 =?utf-8?B?QjExSVE2cGlYSXJhZjBuMktsNVZqanR3eFVkV1l4bDVhNHFDM3dUY2czS1Bl?=
 =?utf-8?B?SjJwWTd0ditmNFFqQWVHVEtIQndrU09NdGsvTU5XQWEvd1lnM2E0bldqZjRw?=
 =?utf-8?B?eWRtK0poSjAwaEUvcmNIVTJFcFo2bTA1c0RUeVZsWUw0U2VoejdIcGhBeHY4?=
 =?utf-8?B?M05Yd00wczUyT2tSWkJTNGZYYXlzcGRwOElVS3V0RFF6MTRBY1hhT2FYOHNL?=
 =?utf-8?B?WnNLTUQ1RDZGc3B5d2Q3Rm9KK1NrdVMveFMxamxmMTc3N0NUU2tGbXlUVHI2?=
 =?utf-8?B?azBBS3RScW5VdktsSzZmaEt5dzQxblN4VHdDYkZGTzZNbjZ3cDRvMDNDUlNO?=
 =?utf-8?B?ZEs4U1liZWREU2pMbEZ0b2JSOWVqNExHb1AwOGRxSXRVSmc2WUJaK3BUa1Rz?=
 =?utf-8?B?N2hGbS9ZcXU2Wk9FS2JGZ0xXMlo4TUNzL2dYbmhIYnk5Zy9QcmpidHJlQTRq?=
 =?utf-8?B?RnBidFNpN1VPM2ZSUkpYOEs3L0xndWNXOXR1SjU2L1ZkZ2NrTnZENXBhUlJj?=
 =?utf-8?B?VC9QUjczbUoyaHhmNEVxMjlod25TNVZBY2hVTm03cnRYdVhreU41RVlUYTUr?=
 =?utf-8?B?VFJVM0pGNE1EWVo3YlVYWW0xUjZvTmV2V0tnbGhHdXFxaEN5MjlrQ3dnZ1ps?=
 =?utf-8?B?ZHlvZ0d0cFlqKzRLcGN5STN0V1R3eEhNMmREM0ZFck1BT1JZemxkRE5ZSzJx?=
 =?utf-8?B?RmphWHBSZUJJci9jZTVRQStHblo3aFkveENQL2dSOHp0eVVvUlVTYkowVmIy?=
 =?utf-8?B?OWZZK3RDZWx2ejdLK1BlTTdkMDhTYndFU2lVM1lUaUhTclRFUmUreE1rbVZa?=
 =?utf-8?B?ZFVVa2hoZ3pUZFV4Z1hmcmFPZ3FNYlpqYWR0QlVUOWJZYXo4ME9vOE92T2l1?=
 =?utf-8?B?TzY4WmZCdkZkWG01cTFqRHFyVGY2U2FVMm0yTy81Sk5wbDZtUGZEWDdoTFlx?=
 =?utf-8?B?YXpwMGNCR0VtSFEyWkxwd2VFM3ZsSkxGZG9Lam11NkVHVHdIK3E4OGZPUHYz?=
 =?utf-8?B?Z3BKc2ZoTTlublB1WlV5MmY5TXFseVBYczcyV3hncEhBRkJTZDFHdzNUN3Q1?=
 =?utf-8?B?TERuUCtZS1hNcTAwTTcvbGFRRDU3YU9jSzdRMEYxRGVnSVlPUVdRV2lqMTZu?=
 =?utf-8?B?cmVWRXltNFZ6bWp2ckQ4aTVkQjhOaEx4NmE2ZXlHNmEzNGQ1dzRIeE9PNTg3?=
 =?utf-8?B?YlhWNHI3b2ludTdNc3RPQVdGZ1JIVlpnYnBXeTJJb0lyOW1QOUNJZUtGM2N0?=
 =?utf-8?B?ck9YSnNrT0xkcVEvVWlWVzdIZHlocjhIQTJHYlNFd3ZjbGREOWFTb2tmRkIx?=
 =?utf-8?B?S0g3OGFLNnJrLzNwTURDclY0Rkw5SkQwUEdSNnM5YXQ2dzFoMTBhdzI0VHh5?=
 =?utf-8?B?emxTNHgxZ2l1aXJwbFpJUXNBYWJqNUdoZ1RwYlN3YnZ2VVRDNnoxcFNaVjRP?=
 =?utf-8?B?MTZDeGhKT1hUZnNVbWJCdzllZzlrTFdrb21LK2U1NnpTTzU4b1VPTXc1ZWQr?=
 =?utf-8?B?QnZXNjhlUXUvRlRoYzYxSTBzSXZYTUMzUlB5cGcxY3dNaWZQMjZMbEhJL0No?=
 =?utf-8?B?VDBrOUY5MGUwT0NFR0g5SzBDZHQzZ3AxRzE5SjRRMGtJUHFSdHp5Q21SMzZ2?=
 =?utf-8?B?dkpzakVYQmpKQ00vYmtFV2tUUzZsRGwrazNZcG1zRndaK3ozMmJlNmRkYTVI?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D80A8FDE82BE4492B19AB51AE64143@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055698a4-a67d-4e6d-ab62-08db05969491
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 03:27:29.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqPr1APVTHP6h7ErCADPsgiClVZM652jx5uhdJwjjeBFNsQKytX5No/IGuVt9bRtiwodR0vuc7XXXYMEIe1N0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBCam9ybiwNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlIGFuZCB0aGFua3MgZm9y
IHlvdXIgY29tbWVudC4NCg0KT24gV2VkLCAyMDIzLTAxLTExIGF0IDE2OjE0IC0wNjAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgSmFuIDExLCAyMDIzIGF0IDEx
OjI1OjQxQU0gKzA4MDAsIEppYW4gWWFuZyB3cm90ZToNCj4gPiBGcm9tOiAiamlhbi55YW5nIiA8
amlhbi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBNYWtlIE1lZGlhVGVrJ3MgY29udHJv
bGxlciBkcml2ZXIgY2FwYWJsZSBvZiBjb250cm9sbGluZyBwb3dlcg0KPiA+IHN1cHBsaWVzIGFu
ZCByZXNldCBwaW4gb2YgYSBkb3duc3RyZWFtIGNvbXBvbmVudCBpbiBwb3dlci1vbiBhbmQNCj4g
PiBwb3dlci1vZmYgZmxvdy4NCj4gPiANCj4gPiBTb21lIGRvd25zdHJlYW0gY29tcG9uZW50cyAo
ZS5nLiwgYSBXSUZJIGNoaXApIG1heSBuZWVkIGFuIGV4dHJhDQo+ID4gcmVzZXQgb3RoZXIgdGhh
biBvZiBQRVJTVCMgYW5kIHRoZWlyIHBvd2VyIHN1cHBsaWVzLCBkZXBlbmRpbmcgb24NCj4gPiB0
aGUgcmVxdWlyZW1lbnRzIG9mIHBsYXRmb3JtLCBtYXkgbmVlZCB0byBjb250cm9sbGVkIGJ5IHRo
ZWlyDQo+ID4gcGFyZW50J3MgZHJpdmVyLiBUbyBtZWV0IHRoZSByZXF1aXJlbWVudHMgZGVzY3Jp
YmVkIGFib3ZlLCBJIGFkZA0KPiA+IHRoaXMNCj4gPiBmZWF0dXJlIHRvIE1lZGlhVGVrJ3MgUENJ
ZSBjb250cm9sbGVyIGRyaXZlciBhcyBhIG9wdGlvbmFsIGZlYXR1cmUuDQo+IA0KPiBJcyB0aGlz
IGRlbGF5IChkc2MtcmVzZXQtbXNsZWVwKSBzcGVjaWZpYyB0byBhIGRldmljZSBkb3duc3RyZWFt
IGZyb20NCj4gdGhlIE1lZGlhVGVrIGNvbnRyb2xsZXIsIG5vdCB0byB0aGUgTWVkaWFUZWsgY29u
dHJvbGxlciBpdHNlbGY/ICBJZg0KPiBzbywgaXQgc291bmRzIGxpa2UgaXQgc2hvdWxkIGJlIGEg
Z2VuZXJpYyB2YWx1ZSB0aGF0IGNvdWxkIGJlIHVzZWQgYnkNCj4gb3RoZXIgZHJpdmVycywgdG9v
Lg0KPiANCj4gSG93IGRvIHlvdSBkZXRlcm1pbmUgdGhlIHZhbHVlPyAgSWYgdGhlcmUncyBzb21l
IFBDSWUgc3BlYyB0aGF0DQo+IGRldGVybWluZXMgdGhpcywgcGxlYXNlIGluY2x1ZGUgYSBjaXRh
dGlvbiB0byBpdC4gIA0KDQpZZXMuIFRoaXMgZGVsYXkgd2FzIGRlZmluZWQgZm9yIGEgZG93bnN0
cmVhbSBkZXZpY2UgKGUuZy4sIGEgUENJZSBFUCkNCndoaWNoIG5lZWQgYW4gZXh0cmEgcmVzZXQg
cGluLCBub3QgZm9yIE1lZGlhdGVrJ3MgUENJZSBjb250cm9sbGVyDQppdHNlbGYuIEkgc3VwcG9z
ZSB3ZSBuZWVkIHRvIGFkZCBhIHByb3BlcnR5IGluIGRldmljZXRyZWUgdG8gbGV0IHVzZXINCmRl
dGVybWluZSB0aGUgZGVsYXkgdGltZSBkdWUgdG8gZGlmZmVyZW5jZXMgaW4gcmVxdWlyZW1lbnRz
IGJldHdlZW4NCnZhcmlvdXMgZGV2aWNlcy4NCg0KQmVzdCByZWdhcmRzLA0KSmlhbiBZYW5nDQo=

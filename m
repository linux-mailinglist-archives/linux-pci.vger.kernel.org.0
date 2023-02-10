Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01F691811
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 06:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBJFpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 00:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBJFpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 00:45:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E16643F1;
        Thu,  9 Feb 2023 21:45:44 -0800 (PST)
X-UUID: 264202a6a90611ed945fc101203acc17-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PceXd1PLBWASz27+AMla5Pacs1nrypOt0jGzGlEED18=;
        b=D4U689rTd+g8hmhzWvNdbqlSi8QSsBa6EWjzy+I062apyOSf8o9rICttgxM6WWAd8LNLj9je8mjfwzf6mpVZy7B4m/8PM0fL5y4xowHItW5qBSUCRC9ol+1jurp5+NBUH/D4YGnp4UmIXVYVsIILrnNyq/AjDkjUwAoBuER2YZc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:1e040b44-d914-4960-b1eb-441c63894df3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:75f9798e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 264202a6a90611ed945fc101203acc17-20230210
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 597099491; Fri, 10 Feb 2023 13:45:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 13:45:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 10 Feb 2023 13:45:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz9kj7n2cjABPpaYSlLA8K8QyvhXBDCH2teSxK33zIX9oPWjGadQAVGLCtUkPQTCiiGAYbw24R+QjvEMOsfo6dRIir9BU916jc+rKYI0+A/OOf5wXFauWrRIalnmQYsZMRgcupy8lp5XyuPW7T4DDhHA4B0KdpesbBxoG7hHjZZ//eIls23ichyT9ve7Y5Sy76350xaJ6GglZiOuZRGbnQeiNY9lSpJO8IVuKYCJvjskP6DwI9DWsHoMGRY5OZJOGYsM2Uuoo2izbLJvTHSFzwWgZ0LmIc5CRYdtRQvd+odtHy1hTmTWUL91Ah6RBXFcuYmiQ0vgtK85T1OJ26sXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PceXd1PLBWASz27+AMla5Pacs1nrypOt0jGzGlEED18=;
 b=dVbjLd2tXl083iMfGgTxaHJWDAzGpKTEoqOrBvW5P8lmhxo9SNsFG/tLTvlXSFEc+YHRNSTFPNPeqFXsSWiafpnM2Fb+F2JisH0kUJqT5JYG7bAjhIm6kGcZvG4eiYuuA3Ga0+/8zh9kO77yEkMoz1DqKg+lRhC8zj6ZBrRnb+xCsN4i9+Hox//ePqMLOti75M0aB6vX6fZKqRuUto3bHwUBLAslXti0yr5rnikddixq00yLN7biHVO+3l+LSgNqlI6drk8nkdeMON6mGO7uLIBXd/s+qv3TL/ofbsp5JCVi/4uOvjHRuPiy8L938X1DVKYWleJxqskRubC9GEu1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PceXd1PLBWASz27+AMla5Pacs1nrypOt0jGzGlEED18=;
 b=gvQjxrgFzBsr9h0GCDVIi4e5AAClYhIwt8y36XaIuXWJ5y8WTJUDxqMSr3CUnzeb97CTPin9YhejD/Jr3nVd8csVFa04gGL1rXGSXU6uE8XgE2MYjB9n/nNfgv2ElEreHtBz+hQrNd1Attcjfrff832A/OY2EKMYMsrB2uSJaZU=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by SI2PR03MB5305.apcprd03.prod.outlook.com (2603:1096:4:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 05:45:36 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943%5]) with mapi id 15.20.6064.036; Fri, 10 Feb 2023
 05:45:36 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
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
Thread-Index: AQHZJW08mAoVUkodH0Stwnt7OwVpoa6Y88CAgCQn+QCAADCLgIAKjqoA
Date:   Fri, 10 Feb 2023 05:45:35 +0000
Message-ID: <ff147ac913c8aa32a64aeeb2244c11fd04955c3c.camel@mediatek.com>
References: <20230111032830.20447-1-jian.yang@mediatek.com>
         <20230111032830.20447-3-jian.yang@mediatek.com>
         <dccfa004-1d40-acc0-6220-9232193b648f@kernel.org>
         <8d954de7f9507099bd9bea6801f446f80bd832aa.camel@mediatek.com>
         <9c2c0e88-41d8-f9ec-d934-2d1752696b1a@kernel.org>
In-Reply-To: <9c2c0e88-41d8-f9ec-d934-2d1752696b1a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|SI2PR03MB5305:EE_
x-ms-office365-filtering-correlation-id: bdfe72fa-9533-4d59-9d95-08db0b2a084b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b63Foiex4hc92pi0+Je4EsUbcGgeBMQu5PLoZuqupk6koCxUyBOAi+z8mmZcoQzhIpbxz9M7X8dGtGr3xNIQ7CddNl/RW0ccwN9156dRB8gIWCvei8/K+BiSNnYryWXnOWkWl0fZrpyIax7WNu3E1KGA5c/TF91AbytCkHiIyoEJRwCNhmjrPOpNWhi4IyTd9WHoOPpgm0llBsKwi/jPn6dcErokPZOSwJSYCRiHC45TDwLVI06+Ag9D2lvxGD0ArAkzZUQfgt1stdFuViaSV0TM3QxGU0N0mzJEXbpj/6KO+5PCSt7QuVeSPxCc5BAma/N/XypYAbsTGLRKcVsXQTxqDNEpAqdpYJfiPVkjqTcB4VSFfZh10dl72nM089jzcsxNBeRlh/p5Fx8QWW5XcPvBcgUF1W/DaxaaIuKY94cYh3fDnqsnQeUcl1pPLqWvqBoKJPK9NcjdQiHJBNR19pTp5L++BkTVMf1/x3SwqBhUkLGNWZi2wchMxHPDbTFQAccly9zmWHQjugtfYECk5QlcIwKzC9HOnrQnxCcD9Lrrz5NGykscTRM3xQHiu39v3kMfSuLztqro7mRR0vbf89QVy+X/1HcznNuoE45PMlzXvAPeYBnIx5/JeR7qZ8ZMg+Xk4cV9LZZnWCAId23liNZ49BAw2HRzLB4ynEvfVW99i6knMz+033X+m26yP6RaXOOn2GYUZSw3SXj1TGspBkgHprCoU4MOekacywUPNP8FIe7SbQm4/LoFt1hDq60qabsG9tlgksh9LNyxDaWPC3f1ZEom7t6ZA77LYamjotA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199018)(38100700002)(107886003)(122000001)(41300700001)(7416002)(8936002)(5660300002)(91956017)(76116006)(8676002)(64756008)(4326008)(66556008)(66446008)(66476007)(66946007)(2616005)(86362001)(71200400001)(478600001)(110136005)(2906002)(53546011)(26005)(6506007)(186003)(6512007)(316002)(54906003)(6636002)(6486002)(38070700005)(966005)(36756003)(83380400001)(85182001)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkd2dm9GdWx2dTFXOS85MEMwTkRzc1E3V2lCaWNYc0t2dGdPRzhKMGlXMXBF?=
 =?utf-8?B?cnJlS2oya21xeE1iV0FWMFhqMWErN25LVW9kVTZPM21Fem9PVTEwam80OElG?=
 =?utf-8?B?RkFtWDdGQmMxbUN1QjIvNHZPd3VrR202YW9lTHo5eVZVVUFMbjY2YmllZW1n?=
 =?utf-8?B?SjArUFFQVGRYVXVhanMvdkM2QjViWFdnZ2dPQVUvaXo3NUs3QzY5QnJkTWVa?=
 =?utf-8?B?NVVTN1FvSFpqRExjTHVHYk1IeE4xWTdPM0hEWW9WSVBxR0JaaXp1eVY1SFNV?=
 =?utf-8?B?Mld4MVl1OWd5d1U3NEFTT3J0Yml4V0xXNVVOV25CZlgyMzM4MW00UjZUR2pH?=
 =?utf-8?B?d2h4N2pxTjNQbXFKTjc4NVVMaS90MFNSckJQVW84M20zblNpOXBOWDRzUmtF?=
 =?utf-8?B?YlU5Y0YrQ1dmOTFPY0tQT2FuNkNFS1Y0VVlWVnJFMlhNNi8ra1ZvOGlUa2ha?=
 =?utf-8?B?YkhHTFhmRWxBZnZERTdUWjA1a0VMbXNBdzB1Vno5cC9UMmVHaDB5bHZZNjVI?=
 =?utf-8?B?bHJISit2U1RSUjNocWx0NWtGWXhFVnJYSFZLQUhxclhFMThEa3dGSGlYekxa?=
 =?utf-8?B?TFFxRjNPb21CU0s1WEM3dFpvMEx1ZmYrSzUzU2ViNkNlTG43WUtiTVI5NXFI?=
 =?utf-8?B?TkgwSFk0K09RTW55b3hEU0s3YlBndSsxdHp6OG5YY1JmMmpROGl3QklNT3pG?=
 =?utf-8?B?UEEvNWN1bHdDM3RXTVAraERkcE5ESXJmT08rYncycFl0U3BHdy9PSUIwUExr?=
 =?utf-8?B?dWRxSmF4T3lHUkozNEpDYm55RVY1Ukwvb3lmYTlHYUcySGtMOGQwWnUvcWlQ?=
 =?utf-8?B?Tmx3TE9relR4WFVkOTBPeVNWMGhFOGVydkx3UnlaQnZ6bWQyVkc4R1k4a3o5?=
 =?utf-8?B?QTZ5eUlyTnpsWmpmZDlvMll0a3RYY01mVG5qbGtrSUczOXBRWUNaWkhnNlds?=
 =?utf-8?B?bWh0ZnVENGpBR2ZaVTk0Q1l1SU5YV1ZCYkZDV0xMNmVPTUlld2R1eE95ZzJV?=
 =?utf-8?B?U3Bndm9INnE1akRLemljWitnQVdpUHAwT3J5b1dVZExQSGc3Y1VnNE9pSlZ6?=
 =?utf-8?B?MWw4YnpGSnY0RlNyL2NFU0RVRjBVZjYvSklGeU1BVEhhTTRqNHZkMjZkV2ZW?=
 =?utf-8?B?N3FuR1dSY2FuMFJodVFpRUxDZWhCenFvRjREaXhpc0tWRk5NZFlTUExEeVBY?=
 =?utf-8?B?UDI4b1M2bG5yMW5rRjgvSy9uTDc2NjhQQktBK3Zxem9Yc3hJaVpnV3ZORCtI?=
 =?utf-8?B?TnBicjRhSXlCbUtDU04vbWlzenNTQStCQ255czJPTnQ0RVNyZXlzVEFoWXpp?=
 =?utf-8?B?Nk1oMEtJcmtUc2hJK1lsaU5MdHFaWElnOWQwUkhRckptY3JkSWdLcENCZFlN?=
 =?utf-8?B?NEFUTHRpZW55TzBnSkMwSFB0Ni9rRitHZE9hY2tYbHFsREZFM0tjci9mdHZX?=
 =?utf-8?B?dklRTjFsUFBibXR2VnVIWGs2R3prd0tOeWtaOGl2bWd4YWJMbjJxTHhMVjNR?=
 =?utf-8?B?bkRpYXgwTFpVS2s5cThpMWpuamFjWGJZbS9ETTFodGNKOEdYMmFtNjNBamFI?=
 =?utf-8?B?MDNnNnB1MkdwelZMV3ppSkxTYTlyc0pOdkFtekhwMnRJSVBnQ1hwOU41TzNN?=
 =?utf-8?B?dXJPZ0pqZ0N3RURaankzejgzU3hLT1dQODAzMDRFdWFxR2tFbXVBR0xsNlFa?=
 =?utf-8?B?ejgyUFIzU0tqaFMzQzA4b0lOajUxTERkTFlPcGcyV0ZuZThZSzlGZE5QWUVk?=
 =?utf-8?B?Vnp1U292M0k0VlZFVDMxVkI5U243bDFXdkNwQ1I3UXJUQnZIcS9EcG1VeWxK?=
 =?utf-8?B?WHFrY0lkR29wRlFveW0xTWhydXcycXZ1U1c4RjArZHorMTNxRnFBV0ZFcThx?=
 =?utf-8?B?cURiMjlQSEgwZHdsbmVhSnhMUTNxUlpRN2srMW4yd1E1SGtDUkRxM21PRU5N?=
 =?utf-8?B?M0Z0Njd1T2hsL3hpRThrQW4xZkJnNEtIcHVuMXdkUzhmN2lTRHRoWFB2N1p0?=
 =?utf-8?B?bmxqTndZYTA2MXNoUmwvRWhIRTgwdlVIeEFLdlFvU1Zjek5qN3F4STEyK0VR?=
 =?utf-8?B?bUozZW9YZ1cwMXNIemtoS0ZJa3Vid0ZVbmIyeG5BQ1JKS0JwVnJVaTU0dkZp?=
 =?utf-8?B?V2FQZ05HTUJrNmJXRVF4ZVFtSmwvWmhnNmtMaVdtcjlVNHJ4SWFQWDhoTjd0?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC5220B595F9C745984921D95A5A394E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfe72fa-9533-4d59-9d95-08db0b2a084b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 05:45:35.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnaA2g7wCIBzwgG7s2PF/Lnx9z79wWs0tOJj8zBrjx0ZS/9GUmJ4M8sO/HLK4hjUfkh1E9Q2phT4SOKmElCiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBLcnp5c3p0b2YsDQoNCk9uIEZyaSwgMjAyMy0wMi0wMyBhdCAxMzozMiArMDEwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDMvMDIvMjAyMyAxMDozOCwgSmlhbiBZYW5n
ICjmnajmiKwpIHdyb3RlOg0KPiA+ID4gPiArICBwY2llMTJ2LXN1cHBseToNCj4gPiA+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiA+ID4gKyAgICAgIFRoZSByZWd1bGF0b3IgcGhhbmRsZSB0aGF0
IHByb3ZpZGVzIDEyViBwb3dlciB0bw0KPiA+ID4gPiBkb3duc3RyZWFtDQo+ID4gPiA+IGNvbXBv
bmVudC4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICBkc2MtcmVzZXQtZ3Bpb3M6DQo+ID4gPiA+ICsg
ICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICsgICAgICBUaGUgcmVzZXQgR1BJTyBvZiBhIGRvd25z
dHJlYW0gY29tcG9uZW50Lg0KPiA+ID4gDQo+ID4gPiBXaHkgeW91IGNhbm5vdCB1c2Ugc3RhbmRh
cmQgcmVzZXQtZ3Bpb3MgcHJvcGVydHk/DQo+ID4gDQo+ID4gVGhlICJkc2MtcmVzZXQtZ3Bpb3Mi
IHJlcHJlc2VudHMgYW4gZXh0cmEgcmVzZXQgcGluIG90aGVyIHRoYW4NCj4gPiBQRVJTVCMNCj4g
PiByZXF1aXJlZCBieSBhIFBDSWUgZG93bnN0cmVhbSBkZXZpY2UuIEJ1dCB0aGUgInJlc2V0LWdw
aW9zIiwNCj4gPiBkZXNjcmliZWQNCj4gPiBpbiAicGNpLnR4dCIsIHJlcHJlc2VudHMgdGhlIFBF
UlNUIy4gU28gSSB0ZW5kIHRvIGFkZCBhIG5ldw0KPiA+IHByb3BlcnR5IHRvDQo+ID4gbWVldCB0
aGlzIHJlcXVpcmVtZW50Lg0KPiANCj4gT0sNCj4gDQo+ID4gPiANCj4gPiA+ID4gKyAgICBkZXNj
cmlwdGlvbjoNCj4gPiA+ID4gKyAgICAgIFRoZSBkZWxheSB0aW1lIGJldHdlZW4gYXNzZXJ0aW9u
IGFuZCBkZS1hc3NlcnRpb24gb2YgYQ0KPiA+ID4gPiBkb3duc3RyZWFtDQo+ID4gPiA+ICsgICAg
ICBjb21wb25lbnQncyByZXNldCBHUElPLg0KPiA+ID4gDQo+ID4gPiBXaHkgdGhpcyBzaG91bGQg
YmUgYSBwcm9wZXJ0eSBvZiBEVD8NCj4gPiANCj4gPiBTYW1lIGFzIHRoZSByZWFzb24gSSBkZXNj
cmliZWQgYWJvdmUuIEkgc3VwcG9zZSB3ZSBuZWVkIHRvIGFkZCBhDQo+ID4gcHJvcGVydHkgdG8g
bGV0IHVzZXIgZGV0ZXJtaW5lIHRoZSBkZWxheSB0aW1lIGR1ZSB0byBkaWZmZXJlbmNlcw0KPiA+
IGluIHJlcXVpcmVtZW50cyBiZXR3ZWVuIHZhcmlvdXMgZGV2aWNlcy4NCj4gDQo+IE5vLCBJIGRv
bid0IHRoaW5rIHdlIHdhbnQgaW5kaXZpZHVhbCBwcm9wZXJ0aWVzIGxpa2UgdGhhdC4gVGhlcmUg
aXMNCj4gb25nb2luZyBkaXNjdXNzaW9uIGFib3V0IHRoaXM6DQo+IA0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjIxMjE0MDk1MzQyLjkzNzMwMy0xLWFsZXhhbmRlci5zdGVpbkBldy50
cS1ncm91cC5jb20vDQo+IA0KPiBGZWVkYmFjayBpcyB3ZWxjb21lZCAtIHRoZXJlLiBEb24ndCBj
cmVhdGUgeW91ciBvd24gaGFsZi1iYWtlZCBkZWxheXMNCj4gZm9yIGRpZmZlcmVudCBoYXJkd2Fy
ZSBkZXNpZ25zLg0KDQpUaGFua3MgZm9yIHlvdXIgaGVscGZ1bCBzdWdnZXN0aW9uLiBJIHdpbGwg
cmVtb3ZlIHRoYXQgcHJvcGVydHkgb2YNCmRlbGF5LXRpbWUgaW4gVjIgcGF0Y2ggYW5kIGxldCB0
aGUgd29yay1pbi1wcm9ncmVzcyAiR1BJTyBkZWxheSIgZHJpdmVyDQp0byBoYW5kbGUgdGhpcyBy
ZXF1aXJlbWVudC4NCg0KQmVzdCByZWdhcmRzLA0KSmlhbiBZYW5nDQo=

Return-Path: <linux-pci+bounces-143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6C7F55DF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A50CB20D5D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2615A2;
	Thu, 23 Nov 2023 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aq747MFe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ULeEy31C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35AC92;
	Wed, 22 Nov 2023 17:27:20 -0800 (PST)
X-UUID: 6d5e0f52899f11ee8051498923ad61e6-20231123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RuE1OIGl7HeuG81qxmfc5/SyEf/cNR7lLvQ7yhP/4Zg=;
	b=aq747MFeM0qn1hXAzPFoiswMeZpBsaQxuGXqKJ8+YzqZcKZH5DQCMxQOhBwqNU30Dr1T3KDfZ9O2gVSO5WgBykZVwhy8fD4FiuvZopVXAgSCQy0LdvCb2CVkp8JO0THS88l8tTDQzIUlXkrDcLBLd8aRkVagdxgm0MTTR3rGQdw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:dfebdbea-a7c8-434e-9ea6-43454ad7557e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:38,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:33
X-CID-META: VersionHash:364b77b,CLOUDID:35c0b495-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6d5e0f52899f11ee8051498923ad61e6-20231123
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 92285817; Thu, 23 Nov 2023 09:27:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 Nov 2023 09:27:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 23 Nov 2023 09:27:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jueq6qMFq3QxhTucXUoVOTwf5sSkzur6Tx17QJUarYqOp/rqMC08Ph/DxRYuN3kkUG4tifndEDopWpTIHt4bwPjkX995CXmOHFaUUP4JVqRR7onR/xXQYxNxEYUul6U6av6AmNBytxELzi4Uj8CbQGQMqI5XKK9BLmU8c1RyhNz8OQbbv59Fg+UBqPaL5jzY8u4g4c5fyaUkMSC5TzlMFy3lUIKJgwffFZZWVVrEenuJXQSMBCxIlUhcvyudzAEBYEVreZWwNWdTvguDc9UF3mdAok6KzThdJzGsIv651sJotlJLkedoSDDuwr0PEIvC5zXaf99J5+oTrfSPQB6kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuE1OIGl7HeuG81qxmfc5/SyEf/cNR7lLvQ7yhP/4Zg=;
 b=LvTz7Kfir6zHYDSqUpLu4FdVPno585KchFFkIB3SsYXCVSkO/Dgo946KAoqwd0vDYb6+zCi75AbnWL8hswY8gRmIyOTz5RVIc5SFfGeagUL0Iqf4NwsiTMeKn4uCqkRD3NUaezS/eYbEttQlPzyLRM0h7q6T/aUZ55VEMw2sQ7B8OelwZHWTmDSrhffOTPMsPtrEZ6VyFlm+PtjHzqON9HG0LSklYfRsojHnbH+K3tkSA6g4GaAUXNHuVBqf54Bh8qiQOupHAK1SU2XxQ9B5q9KKZ8exIq7nptmScQVjuJ0MwTjw9N3nZ/CLWor5IR3ECm2PuMEugACpSO6wQK2J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuE1OIGl7HeuG81qxmfc5/SyEf/cNR7lLvQ7yhP/4Zg=;
 b=ULeEy31C0BA/SxuOfHxntSrhrDihZ6N7NFwIgJRBqlz1K3tXP9myc1qV0phb/WedIRDgJUmzTQ9ix0zEqns61MPBuzrLwqC7gn9NLNL45CKoa6NDxUCwHMtWo6OJzV5G9t2IN6JwPQGL2yk1mlweXEQ3NyLCav2gvTUC6pXbJ4o=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEYPR03MB7416.apcprd03.prod.outlook.com (2603:1096:101:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 01:27:08 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 01:27:07 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "kw@linux.com" <kw@linux.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
	=?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <Chuanjia.Liu@mediatek.com>,
	=?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
	=?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?=
	<Qizhong.Cheng@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Thread-Index: AQHaBYj34jUTwwci5EyGDD9GhMp2WbCHTUQA
Date: Thu, 23 Nov 2023 01:27:07 +0000
Message-ID: <80fc850062017a2ef2091a43759e19f3fcf2666f.camel@mediatek.com>
References: <20231023081423.18559-1-jianjun.wang@mediatek.com>
In-Reply-To: <20231023081423.18559-1-jianjun.wang@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEYPR03MB7416:EE_
x-ms-office365-filtering-correlation-id: 9ac190ed-1e1c-4f45-b9b9-08dbebc34edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KoZoGiqkZ67WT29gpGyIwii2igxBOUfQAhl/m3E4GBFRCEdBweqzolddjd/ramlMoGsARNdiu4g7I3HsYU+/tPXeUs7kYnP66MGHEDob2cF13714evK5YecjU8lPsFSaqTbU0879u+1+FSrvab3rkwGb49iFC3sKLAtFhOBYcGxwmrV7sOnAZ47d/Zumier4cAOyO3JogDCZz9dNo0/5gh7hJ4N7eADihUQAnwxW63zJopveYiT1MhfhjEJBeOZ9GFTWShaITAoeWMN21ZoI9AUVg8h0zWneIULllpCtxtAswBHB67Ik+28O+8VVoVOJuI6Be2T/1eo0asQcXv7qx5XBNBB0e+8FhHekn6x1QcR8wlaf4MzaXCKwrCfTIiIFVaWJTN+4ZvNxLmxUzihv9vZj/to+KP/Eo0Yj8PnPrUI/EILjaGZ/7FkkgsmTgvuAZ2tdhKC7cY8q7vQyKP7S7eModlMJSXRr7oWudhFZ0KtiEiwtrTU/tgRoQalt/DVy/7c0mf6vlIpJgX7n3IfDOzhrd+EHHHGmScXJxpBsOQ+IP/3yHZpGClDM3Nm6/IddVMP/iyGTR0K7O9kK67rLeqPw7erPa83phl4j/tWrM3QCds54WnqgFLDFg7hdXdAiS8H5eYf9r6lr1bXoSr5T6ZeWu5Gdirp2107C5/zX7I8aam704okS7kxanv5Pna9houP/3mQxl/h0j0H0s6/vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(7416002)(41300700001)(4001150100001)(2906002)(8676002)(8936002)(316002)(5660300002)(4326008)(86362001)(38070700009)(36756003)(85182001)(6486002)(478600001)(2616005)(107886003)(76116006)(26005)(122000001)(6506007)(71200400001)(83380400001)(6512007)(38100700002)(54906003)(66556008)(66446008)(66476007)(66946007)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZaVlRVMXplUkhEbW9WT0tlNUx3VDRwekFKeG9VSEZCR1Yvb0NkTWN3dnA5?=
 =?utf-8?B?U0RFdTg0TVFLanBBRGVhQWJkbmdsVU4yT3hKQno2cnpocndjMVRQRE9SUVUr?=
 =?utf-8?B?U1l1Y3dxQlJPLzU3MDNqT0RFZFdpRGVDKzJMNUlKRVFHN1haWkpqSWE5Skpp?=
 =?utf-8?B?cmY4SHpteFc2SE5TS2t1eG02MnhIK3VNQUQydFRuYkN5eENOV3ZQbm02cUhh?=
 =?utf-8?B?T0JYVnMxbFlod1U5L1hkVnVsWjltTlZ6OGNrellPTXkrNXJZKy9Dc2FMMFBE?=
 =?utf-8?B?dDZRZ0dHbmtTTXRUNU4yTFhEcVlVMzFXVnJrUkp5UDZKcVVyby9lS3hWZUxO?=
 =?utf-8?B?K1g2WEJZVHpwMmx5eFFKazZVM3NYMmFKK3krMkVBeHljTUg4Zi9sTjJyM3BM?=
 =?utf-8?B?KzdXQ0NsbzBsZFVnekhZRjk3ZkM0NHErYlFHaUVYZE5Yc014U05QSzVTTmdJ?=
 =?utf-8?B?N1pYUkxXS0ZkKzNzKzRqeUk0SG9vVW1GNEFQbHJmaGVQbkluT1pyMHU5YnhX?=
 =?utf-8?B?c1YzV1RSWFFSeFVXRWtkRzkrNzMrekFNMmpTYVNqOXU5ZHk3ODNUbTZyb0J0?=
 =?utf-8?B?QVp3RTVqaFlzNFVBd2RjN0hrT2FDQXNhVkNBMTFFcjRHc2dxZ1FEN05vMkNt?=
 =?utf-8?B?eE55MVcxVC9pL1RmbjYzbXUzTWFFTElUbjg1eW10bDVzRjZkMGJJSFdZSXlL?=
 =?utf-8?B?TWhqeDZlLzkxYkMrRGpFcW5tSE16QTlub2VZMVBLaGpNeHpUeGxGQk5aYTVl?=
 =?utf-8?B?V0NLOWoxRmlZUjdWbTZibkYyNDMzbnk0dVMvZVJQN2Z1MVVPYkpBUW96RURW?=
 =?utf-8?B?czEzQXpBa3gvQ2xVRVVJdFBSSWZqa2pCb1dDZ1ZwT1ZRemRzTmF6dFdMelRi?=
 =?utf-8?B?RkRER0pJOXVPRVBPci9YTkFhbVIzMCs2SmJVckNrQldhQ0JFUzhkUERlOHA4?=
 =?utf-8?B?TFE0QWpUTjBZLzIwdXBqTUIrY1lYd3NlWkxNT1FQd2x2alczOGd4Z1JWUnFZ?=
 =?utf-8?B?SEEvQ05yVUpYTmIyRUhKSjhReGNVRGIxZ2JnRW9aQ1VGenFEYUZpV1dDYXAy?=
 =?utf-8?B?aXRpVjNKOUQ2OWZ0WVJ5ZXkxZlZBVFp5WUczK3ZQa2R3cVZDVGVwVUNyYURx?=
 =?utf-8?B?aUFZeW5WejBoeFY4Tlo0eFJoS2hNK2EyZzZGVEZBOVpneEtQemNHTEZYWGpH?=
 =?utf-8?B?Z2x3YmxHZFNuV2RaT1Y2VytqaS9rOWREbHZob2RsWS9sOHNxMVR6bGhWN1Zy?=
 =?utf-8?B?QVd4STNVbTMyUTcwZEJwWHZnanEwRjNsQVdGbWp0UzZkd3NSL01lYTVMeHlM?=
 =?utf-8?B?UFNnRGJhM3dWejBCN2NFL1BTT2RLNUFUeENGVmYvOG82UnF0d1RBWFhNZU0y?=
 =?utf-8?B?a1J4eThGQ1VDYnZGaWwvcnFDOHlRK2wvb1g1dFI4UE14bTNtYUJpejROditY?=
 =?utf-8?B?SFgzU0VBY015WnF6VDRTUDFNVWpDVnRuSzc3M3BobndEYUNSeDV1TjRMZnZS?=
 =?utf-8?B?NGlBOC8zQ3crOThRS0llWlVzNXNGMGxzbkFjaVNKa3JYOWdCSWhORHJ3dWFo?=
 =?utf-8?B?YTdsd1hjWkxYTGRuWkVieDJvWnlTMER1cVJyTk8wdDMzMXNSQUFFMmxCZm1n?=
 =?utf-8?B?TlludHZKdFlDaFV3UEVoSXdDajRiQnVYTW5TZnVPbGNjKzdyM2I3bjZWSGNi?=
 =?utf-8?B?ZVNoMjlEOGV5Rk1GQ0VVSmkxb2JmRWZ2SEhqVEpQUVhSMHJIcG5vR3NleitR?=
 =?utf-8?B?S1pIWjNKSjkzTTdlTVg3NDUrZXUvZDZjNlFFZS9vbXFVSm9TbXZES0tKK1Ja?=
 =?utf-8?B?RlZ0YURod3dOeXdyUmR6SjVKdncwYzA4VWZyWXlJd2N1Y3hKU2owaVVWU3Jr?=
 =?utf-8?B?K0xuVUcrSEppNkxucjFQamF0L3lCanRRM3I3NWE1RE9aRHVLYVVmdVdJc0VW?=
 =?utf-8?B?ZytOQXlkYTZKNnRXZ0JxUGhTUmhXNmpiUFMxQkJJVUdjUks3Rk1MQkxTejd0?=
 =?utf-8?B?REVGMm1tM3BwZFJKY1ptOFEydm03b1habnRDamFneUhLTUMrbmxxWHpjQVc4?=
 =?utf-8?B?d0dkakYxVktXVU42ako0QktnUHk2eTlnUURCVjMvRmZJakc0L0pVVFFDTDc5?=
 =?utf-8?B?bHVxN0o4Tk55MmN2RktaUTRRZ1pTcTFabmh3dXgyemVnMlptdGI5T0N0VnM0?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22FDD0A001F6154093FB3797F405AA81@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac190ed-1e1c-4f45-b9b9-08dbebc34edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 01:27:07.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbKNMKeJkXHdGxUaR0sRoj6+87vz+NMslDlAvgW7BoZuRzZKK4SpaETA3RTvccb+KZO4yoEHhbEfPxW+W4b08H1uR5CMWb2sLTum5qY7Mps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7416

SGkgTWFpbnRhaW5lcnMsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoLCBpZiB0aGVyZSBp
cyBhbnl0aGluZyBJIG5lZWQgdG8gZG8sIHBsZWFzZQ0KbGV0IG1lIGtub3cuDQoNClRoYW5rcy4N
Cg0KT24gTW9uLCAyMDIzLTEwLTIzIGF0IDE2OjE0ICswODAwLCBKaWFuanVuIFdhbmcgd3JvdGU6
DQo+IFRoZSBzaXplIG9mIHRyYW5zbGF0aW9uIHRhYmxlIHNob3VsZCBiZSBhIHBvd2VyIG9mIDIs
IHVzaW5nIGZscygpDQo+IGNhbm5vdCBnZXQgdGhlIHByb3BlciB2YWx1ZSB3aGVuIHRoZSBzaXpl
IGlzIG5vdCBhIHBvd2VyIG9mIDIuIEZvcg0KPiBleGFtcGxlLCBmbHMoMHgzZTAwMDAwKSAtIDEg
PSAyNSwgaGVuY2UgdGhlIFBDSWUgdHJhbnNsYXRpb24gd2luZG93DQo+IHNpemUgd2lsbCBiZSBz
ZXQgdG8gMHgyMDAwMDAwIGluc3RlYWQgb2YgdGhlIGV4cGVjdGVkIHNpemUgMHgzZTAwMDAwLg0K
PiANCj4gRml4IHRyYW5zbGF0aW9uIHdpbmRvdyBieSBzcGxpdHRpbmcgdGhlIE1NSU8gc3BhY2Ug
dG8gbXVsdGlwbGUgdGFibGVzDQo+IGlmDQo+IGl0cyBzaXplIGlzIG5vdCBhIHBvd2VyIG9mIDIu
DQo+IA0KPiBGaXhlczogZDNiZjc1YjU3OWI5ICgiUENJOiBtZWRpYXRlay1nZW4zOiBBZGQgTWVk
aWFUZWsgR2VuMyBkcml2ZXINCj4gZm9yIE1UODE5MiIpDQo+IFNpZ25lZC1vZmYtYnk6IEppYW5q
dW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC0tLQ0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiBPbmx5IHByaW50IHdhcm5pbmcgbWVzc2FnZSB3aGVuIHJlYWNoIHRoZSBtYXhp
bXVtIHRyYW5zbGF0aW9uIHRhYmxlDQo+IG51bWJlciwgdGhlIE1FTSBzcGFjZSBzdGlsbCB3b3Jr
cyBidXQgd2lsbCBiZSBzbWFsbGVyIHRoYW4gZXhwZWN0ZWQuDQo+IA0KPiBCb290dXAgbG9ncyBv
biBNVDgxOTUgUGxhdGZvcm06DQo+IA0KPiA+IEJlZm9yZSB0aGlzIHBhdGNoOg0KPiANCj4gbXRr
LXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2llOiBQYXJzaW5nIHJhbmdlcyBwcm9wZXJ0eS4uLg0KPiBt
dGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6ICAgICAgIElPIDB4MDAyMDAwMDAwMC4uMHgwMDIw
MWZmZmZmIC0+DQo+IDB4MDAyMDAwMDAwMA0KPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6
ICAgICAgTUVNIDB4MDAyMDIwMDAwMC4uMHgwMDIzZmZmZmZmIC0+DQo+IDB4MDAyMDIwMDAwMA0K
PiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6IHNldCBJTyB0cmFucyB3aW5kb3dbMF06IGNw
dV9hZGRyID0NCj4gMHgyMDAwMDAwMCwgcGNpX2FkZHIgPSAweDIwMDAwMDAwLCBzaXplID0gMHgy
MDAwMDANCj4gbXRrLXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2llOiBzZXQgTUVNIHRyYW5zIHdpbmRv
d1sxXTogY3B1X2FkZHIgPQ0KPiAweDIwMjAwMDAwLCBwY2lfYWRkciA9IDB4MjAyMDAwMDAsIHNp
emUgPSAweDNlMDAwMDANCj4gDQo+ID4gV2UgZXhwZWN0IHRoZSBNRU0gdHJhbnMgd2luZG93IHNp
emUgdG8gYmUgMHgzZTAwMDAwLCBidXQgaXRzIGFjdHVhbA0KPiA+IGF2YWlsYWJsZSBzaXplIGlz
IDB4MjAwMDAwMC4NCj4gPiBBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoOg0KPiANCj4gbXRrLXBj
aWUtZ2VuMyAxMTJmMDAwMC5wY2llOiBQYXJzaW5nIHJhbmdlcyBwcm9wZXJ0eS4uLg0KPiBtdGst
cGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6ICAgICAgIElPIDB4MDAyMDAwMDAwMC4uMHgwMDIwMWZm
ZmZmIC0+DQo+IDB4MDAyMDAwMDAwMA0KPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6ICAg
ICAgTUVNIDB4MDAyMDIwMDAwMC4uMHgwMDIzZmZmZmZmIC0+DQo+IDB4MDAyMDIwMDAwMA0KPiBt
dGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6IHNldCBJTyB0cmFucyB3aW5kb3dbMF06IGNwdV9h
ZGRyID0NCj4gMHgyMDAwMDAwMCwgcGNpX2FkZHIgPSAweDIwMDAwMDAwLCBzaXplID0gMHgyMDAw
MDANCj4gbXRrLXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2llOiBzZXQgTUVNIHRyYW5zIHdpbmRvd1sx
XTogY3B1X2FkZHIgPQ0KPiAweDIwMjAwMDAwLCBwY2lfYWRkciA9IDB4MjAyMDAwMDAsIHNpemUg
PSAweDIwMDAwMA0KPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6IHNldCBNRU0gdHJhbnMg
d2luZG93WzJdOiBjcHVfYWRkciA9DQo+IDB4MjA0MDAwMDAsIHBjaV9hZGRyID0gMHgyMDQwMDAw
MCwgc2l6ZSA9IDB4NDAwMDAwDQo+IG10ay1wY2llLWdlbjMgMTEyZjAwMDAucGNpZTogc2V0IE1F
TSB0cmFucyB3aW5kb3dbM106IGNwdV9hZGRyID0NCj4gMHgyMDgwMDAwMCwgcGNpX2FkZHIgPSAw
eDIwODAwMDAwLCBzaXplID0gMHg4MDAwMDANCj4gbXRrLXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2ll
OiBzZXQgTUVNIHRyYW5zIHdpbmRvd1s0XTogY3B1X2FkZHIgPQ0KPiAweDIxMDAwMDAwLCBwY2lf
YWRkciA9IDB4MjEwMDAwMDAsIHNpemUgPSAweDEwMDAwMDANCj4gbXRrLXBjaWUtZ2VuMyAxMTJm
MDAwMC5wY2llOiBzZXQgTUVNIHRyYW5zIHdpbmRvd1s1XTogY3B1X2FkZHIgPQ0KPiAweDIyMDAw
MDAwLCBwY2lfYWRkciA9IDB4MjIwMDAwMDAsIHNpemUgPSAweDIwMDAwMDANCj4gDQo+ID4gVG90
YWwgYXZhaWxhYmxlIHNpemUgZm9yIE1FTSB0cmFucyB3aW5kb3cgaXMgMHgzZTAwMDAwLg0KPiAN
Cj4gLS0tDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdl
bjMuYyB8IDg1ICsrKysrKysrKysrKy0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1
MCBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBpbmRleCBlMGUyNzY0NWZkZjQuLjk3
NWIzMDI0ZmIwOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLWdlbjMuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0
ZWstZ2VuMy5jDQo+IEBAIC0yNDUsMzUgKzI0NSw2MCBAQCBzdGF0aWMgaW50IG10a19wY2llX3Nl
dF90cmFuc190YWJsZShzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNpZSAqcGNpZSwNCj4gIAkJCQkgICAg
cmVzb3VyY2Vfc2l6ZV90IGNwdV9hZGRyLA0KPiAgCQkJCSAgICByZXNvdXJjZV9zaXplX3QgcGNp
X2FkZHIsDQo+ICAJCQkJICAgIHJlc291cmNlX3NpemVfdCBzaXplLA0KPiAtCQkJCSAgICB1bnNp
Z25lZCBsb25nIHR5cGUsIGludCBudW0pDQo+ICsJCQkJICAgIHVuc2lnbmVkIGxvbmcgdHlwZSwg
aW50ICpudW0pDQo+ICB7DQo+ICsJcmVzb3VyY2Vfc2l6ZV90IHJlbWFpbmluZyA9IHNpemU7DQo+
ICsJcmVzb3VyY2Vfc2l6ZV90IHRhYmxlX3NpemU7DQo+ICsJcmVzb3VyY2Vfc2l6ZV90IGFkZHJf
YWxpZ247DQo+ICsJY29uc3QgY2hhciAqcmFuZ2VfdHlwZTsNCj4gIAl2b2lkIF9faW9tZW0gKnRh
YmxlOw0KPiAgCXUzMiB2YWw7DQo+ICANCj4gLQlpZiAobnVtID49IFBDSUVfTUFYX1RSQU5TX1RB
QkxFUykgew0KPiAtCQlkZXZfZXJyKHBjaWUtPmRldiwgIm5vdCBlbm91Z2ggdHJhbnNsYXRlIHRh
YmxlIGZvcg0KPiBhZGRyOiAlI2xseCwgbGltaXRlZCB0byBbJWRdXG4iLA0KPiAtCQkJKHVuc2ln
bmVkIGxvbmcgbG9uZyljcHVfYWRkciwNCj4gUENJRV9NQVhfVFJBTlNfVEFCTEVTKTsNCj4gLQkJ
cmV0dXJuIC1FTk9ERVY7DQo+IC0JfQ0KPiArCXdoaWxlIChyZW1haW5pbmcgJiYgKCpudW0gPCBQ
Q0lFX01BWF9UUkFOU19UQUJMRVMpKSB7DQo+ICsJCS8qIFRhYmxlIHNpemUgbmVlZHMgdG8gYmUg
YSBwb3dlciBvZiAyICovDQo+ICsJCXRhYmxlX3NpemUgPSBCSVQoZmxzKHJlbWFpbmluZykgLSAx
KTsNCj4gKw0KPiArCQlpZiAoY3B1X2FkZHIgPiAwKSB7DQo+ICsJCQlhZGRyX2FsaWduID0gQklU
KGZmcyhjcHVfYWRkcikgLSAxKTsNCj4gKwkJCXRhYmxlX3NpemUgPSBtaW4odGFibGVfc2l6ZSwg
YWRkcl9hbGlnbik7DQo+ICsJCX0NCj4gKw0KPiArCQkvKiBNaW5pbXVtIHNpemUgb2YgdHJhbnNs
YXRlIHRhYmxlIGlzIDRLaUIgKi8NCj4gKwkJaWYgKHRhYmxlX3NpemUgPCAweDEwMDApIHsNCj4g
KwkJCWRldl9lcnIocGNpZS0+ZGV2LCAiaWxsZWdhbCB0YWJsZSBzaXplDQo+ICUjbGx4XG4iLA0K
PiArCQkJCSh1bnNpZ25lZCBsb25nIGxvbmcpdGFibGVfc2l6ZSk7DQo+ICsJCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKwkJfQ0KPiAgDQo+IC0JdGFibGUgPSBwY2llLT5iYXNlICsgUENJRV9UUkFOU19U
QUJMRV9CQVNFX1JFRyArDQo+IC0JCW51bSAqIFBDSUVfQVRSX1RMQl9TRVRfT0ZGU0VUOw0KPiAr
CQl0YWJsZSA9IHBjaWUtPmJhc2UgKyBQQ0lFX1RSQU5TX1RBQkxFX0JBU0VfUkVHICsgKm51bSAq
DQo+IFBDSUVfQVRSX1RMQl9TRVRfT0ZGU0VUOw0KPiArCQl3cml0ZWxfcmVsYXhlZChsb3dlcl8z
Ml9iaXRzKGNwdV9hZGRyKSB8DQo+IFBDSUVfQVRSX1NJWkUoZmxzKHRhYmxlX3NpemUpIC0gMSks
IHRhYmxlKTsNCj4gKwkJd3JpdGVsX3JlbGF4ZWQodXBwZXJfMzJfYml0cyhjcHVfYWRkciksIHRh
YmxlICsNCj4gUENJRV9BVFJfU1JDX0FERFJfTVNCX09GRlNFVCk7DQo+ICsJCXdyaXRlbF9yZWxh
eGVkKGxvd2VyXzMyX2JpdHMocGNpX2FkZHIpLCB0YWJsZSArDQo+IFBDSUVfQVRSX1RSU0xfQURE
Ul9MU0JfT0ZGU0VUKTsNCj4gKwkJd3JpdGVsX3JlbGF4ZWQodXBwZXJfMzJfYml0cyhwY2lfYWRk
ciksIHRhYmxlICsNCj4gUENJRV9BVFJfVFJTTF9BRERSX01TQl9PRkZTRVQpOw0KPiAgDQo+IC0J
d3JpdGVsX3JlbGF4ZWQobG93ZXJfMzJfYml0cyhjcHVfYWRkcikgfA0KPiBQQ0lFX0FUUl9TSVpF
KGZscyhzaXplKSAtIDEpLA0KPiAtCQkgICAgICAgdGFibGUpOw0KPiAtCXdyaXRlbF9yZWxheGVk
KHVwcGVyXzMyX2JpdHMoY3B1X2FkZHIpLA0KPiAtCQkgICAgICAgdGFibGUgKyBQQ0lFX0FUUl9T
UkNfQUREUl9NU0JfT0ZGU0VUKTsNCj4gLQl3cml0ZWxfcmVsYXhlZChsb3dlcl8zMl9iaXRzKHBj
aV9hZGRyKSwNCj4gLQkJICAgICAgIHRhYmxlICsgUENJRV9BVFJfVFJTTF9BRERSX0xTQl9PRkZT
RVQpOw0KPiAtCXdyaXRlbF9yZWxheGVkKHVwcGVyXzMyX2JpdHMocGNpX2FkZHIpLA0KPiAtCQkg
ICAgICAgdGFibGUgKyBQQ0lFX0FUUl9UUlNMX0FERFJfTVNCX09GRlNFVCk7DQo+ICsJCWlmICh0
eXBlID09IElPUkVTT1VSQ0VfSU8pIHsNCj4gKwkJCXZhbCA9IFBDSUVfQVRSX1RZUEVfSU8gfCBQ
Q0lFX0FUUl9UTFBfVFlQRV9JTzsNCj4gKwkJCXJhbmdlX3R5cGUgPSAiSU8iOw0KPiArCQl9IGVs
c2Ugew0KPiArCQkJdmFsID0gUENJRV9BVFJfVFlQRV9NRU0gfA0KPiBQQ0lFX0FUUl9UTFBfVFlQ
RV9NRU07DQo+ICsJCQlyYW5nZV90eXBlID0gIk1FTSI7DQo+ICsJCX0NCj4gIA0KPiAtCWlmICh0
eXBlID09IElPUkVTT1VSQ0VfSU8pDQo+IC0JCXZhbCA9IFBDSUVfQVRSX1RZUEVfSU8gfCBQQ0lF
X0FUUl9UTFBfVFlQRV9JTzsNCj4gLQllbHNlDQo+IC0JCXZhbCA9IFBDSUVfQVRSX1RZUEVfTUVN
IHwgUENJRV9BVFJfVExQX1RZUEVfTUVNOw0KPiArCQl3cml0ZWxfcmVsYXhlZCh2YWwsIHRhYmxl
ICsNCj4gUENJRV9BVFJfVFJTTF9QQVJBTV9PRkZTRVQpOw0KPiAgDQo+IC0Jd3JpdGVsX3JlbGF4
ZWQodmFsLCB0YWJsZSArIFBDSUVfQVRSX1RSU0xfUEFSQU1fT0ZGU0VUKTsNCj4gKwkJZGV2X2Ri
ZyhwY2llLT5kZXYsICJzZXQgJXMgdHJhbnMgd2luZG93WyVkXTogY3B1X2FkZHIgPQ0KPiAlI2xs
eCwgcGNpX2FkZHIgPSAlI2xseCwgc2l6ZSA9ICUjbGx4XG4iLA0KPiArCQkJcmFuZ2VfdHlwZSwg
Km51bSwgKHVuc2lnbmVkIGxvbmcgbG9uZyljcHVfYWRkciwNCj4gKwkJCSh1bnNpZ25lZCBsb25n
IGxvbmcpcGNpX2FkZHIsICh1bnNpZ25lZCBsb25nDQo+IGxvbmcpdGFibGVfc2l6ZSk7DQo+ICsN
Cj4gKwkJY3B1X2FkZHIgKz0gdGFibGVfc2l6ZTsNCj4gKwkJcGNpX2FkZHIgKz0gdGFibGVfc2l6
ZTsNCj4gKwkJcmVtYWluaW5nIC09IHRhYmxlX3NpemU7DQo+ICsJCSgqbnVtKSsrOw0KPiArCX0N
Cj4gKw0KPiArCWlmIChyZW1haW5pbmcpDQo+ICsJCWRldl93YXJuKHBjaWUtPmRldiwgIm5vdCBl
bm91Z2ggdHJhbnNsYXRlIHRhYmxlIGZvcg0KPiBhZGRyOiAlI2xseCwgbGltaXRlZCB0byBbJWRd
XG4iLA0KPiArCQkJICh1bnNpZ25lZCBsb25nIGxvbmcpY3B1X2FkZHIsDQo+IFBDSUVfTUFYX1RS
QU5TX1RBQkxFUyk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTM4MCwzMCArNDA1
LDIwIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVjdA0KPiBtdGtfZ2Vu
M19wY2llICpwY2llKQ0KPiAgCQlyZXNvdXJjZV9zaXplX3QgY3B1X2FkZHI7DQo+ICAJCXJlc291
cmNlX3NpemVfdCBwY2lfYWRkcjsNCj4gIAkJcmVzb3VyY2Vfc2l6ZV90IHNpemU7DQo+IC0JCWNv
bnN0IGNoYXIgKnJhbmdlX3R5cGU7DQo+ICANCj4gLQkJaWYgKHR5cGUgPT0gSU9SRVNPVVJDRV9J
Tykgew0KPiArCQlpZiAodHlwZSA9PSBJT1JFU09VUkNFX0lPKQ0KPiAgCQkJY3B1X2FkZHIgPSBw
Y2lfcGlvX3RvX2FkZHJlc3MocmVzLT5zdGFydCk7DQo+IC0JCQlyYW5nZV90eXBlID0gIklPIjsN
Cj4gLQkJfSBlbHNlIGlmICh0eXBlID09IElPUkVTT1VSQ0VfTUVNKSB7DQo+ICsJCWVsc2UgaWYg
KHR5cGUgPT0gSU9SRVNPVVJDRV9NRU0pDQo+ICAJCQljcHVfYWRkciA9IHJlcy0+c3RhcnQ7DQo+
IC0JCQlyYW5nZV90eXBlID0gIk1FTSI7DQo+IC0JCX0gZWxzZSB7DQo+ICsJCWVsc2UNCj4gIAkJ
CWNvbnRpbnVlOw0KPiAtCQl9DQo+ICANCj4gIAkJcGNpX2FkZHIgPSByZXMtPnN0YXJ0IC0gZW50
cnktPm9mZnNldDsNCj4gIAkJc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gIAkJZXJyID0g
bXRrX3BjaWVfc2V0X3RyYW5zX3RhYmxlKHBjaWUsIGNwdV9hZGRyLA0KPiBwY2lfYWRkciwgc2l6
ZSwNCj4gLQkJCQkJICAgICAgIHR5cGUsIHRhYmxlX2luZGV4KTsNCj4gKwkJCQkJICAgICAgIHR5
cGUsICZ0YWJsZV9pbmRleCk7DQo+ICAJCWlmIChlcnIpDQo+ICAJCQlyZXR1cm4gZXJyOw0KPiAt
DQo+IC0JCWRldl9kYmcocGNpZS0+ZGV2LCAic2V0ICVzIHRyYW5zIHdpbmRvd1slZF06IGNwdV9h
ZGRyID0NCj4gJSNsbHgsIHBjaV9hZGRyID0gJSNsbHgsIHNpemUgPSAlI2xseFxuIiwNCj4gLQkJ
CXJhbmdlX3R5cGUsIHRhYmxlX2luZGV4LCAodW5zaWduZWQgbG9uZw0KPiBsb25nKWNwdV9hZGRy
LA0KPiAtCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylwY2lfYWRkciwgKHVuc2lnbmVkIGxvbmcNCj4g
bG9uZylzaXplKTsNCj4gLQ0KPiAtCQl0YWJsZV9pbmRleCsrOw0KPiAgCX0NCj4gIA0KPiAgCXJl
dHVybiAwOw0K


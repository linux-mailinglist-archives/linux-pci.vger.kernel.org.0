Return-Path: <linux-pci+bounces-82-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0117F3CB0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9F9B210AB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 04:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842B2BAFD;
	Wed, 22 Nov 2023 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FauqbHqe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="USNUG7nD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10210C;
	Tue, 21 Nov 2023 20:16:09 -0800 (PST)
X-UUID: d9d3f20888ed11ee8051498923ad61e6-20231122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MYCxEtyKV8YAitv6kgGbBkDe1UKnPEWQPdc5Y0VPrtY=;
	b=FauqbHqe1BDC8PH7FNyXUDugVrwdNhfv73LL+uX7sMvdfRvJ8Gb/bxtnPnbwF6ZHuUZb6W1hjiKgfj5wtrnvVpvA7/vPN7DDZ9XkaMcPAz5botYGi+WxJuiU5TMSqLUvD8MECbG9LQru4oElsrlN2zK7K1RKH3+XmmUqx4UFzB0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ee8418f8-47f3-478f-b6d1-34f0017a656f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:8a775660-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: d9d3f20888ed11ee8051498923ad61e6-20231122
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 528959331; Wed, 22 Nov 2023 12:16:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Nov 2023 12:16:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 22 Nov 2023 12:16:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmZKIPq4acxiIoCYepHoRZJHNhAchi7VOANRqLBoe6RQ1m8N40U9qxj8kJGZzLailLUfD4LKegluOVUIlTaj7SuJ1EIeRLN5ZCrsSS6gHkmaPUJ8zKRgaGZavfoqCQYGh3r73y1Ny+PU+p+szuujcEzvHG/xDutymgPn3rUL6fvT7OhQUJNJaaFEOXAnfpBvY+oIzurP0+ZJWR+HEWfi+zqwy6CoEBN25xSwRUU6ww2CbeBJAovIO02b4dIlry5qA8Oqv/19DqQbpXKXwz/t/2igiXgOtR1kDea0ihNOwTXzfCqMeBcl7+H/LbjuLs0hwk8/YeyMA0YJC38EVNe/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYCxEtyKV8YAitv6kgGbBkDe1UKnPEWQPdc5Y0VPrtY=;
 b=N870805KxbhIYKdSItGc3I5kyRN62hdHh8qZVq2QRR9f1qqavi7Vnk1T2svwtihu5Pwokm1eCLqtSwhdPJQdBAsnIQPwyKmCQwXbXicXYha+w51eYjTAaDwRu6IB2xhHucAylk2fG2Wb254KjPBl0eGSICLwqi/RsA3VwSBkLDip2Lxahs4s3aWSPNmDeNgS2Dt1exG7fJ41lSd+EMAmb/nds3UuCRPPqX4GR94WEy8xH0EbW5x1bjgoYbdAE+Jf8VNAGNlMiIu63Frdr0fQSzBFRc10Qtoz5NJ+ZYUYYzTvbonmKuT6MBDUbwLIHHXnCVvmmYbxqTdzmV+Ioe/jXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYCxEtyKV8YAitv6kgGbBkDe1UKnPEWQPdc5Y0VPrtY=;
 b=USNUG7nDZ9x0sYnpQQ2ov0rEgG4NY6zfEvsaw9JpQt6/4+3M+hRWonBflafab5CMiI92i+P5stBQqFJuFKMsZYcUapNdWtGjgcC5nUGBbHR/wFtp5zoFoVp23Gchzf8hv32jzZcZE8WGVKMwuHq+ov/z9p4mMfvQbUSbR2Iul8U=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEYPR03MB8202.apcprd03.prod.outlook.com (2603:1096:101:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 04:15:59 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 04:15:59 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@gmail.com" <skinsburskii@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Thread-Topic: [PATCH] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Thread-Index: AQHaHAr95uYvd7q87U2/EzC5eIJsV7CFTeOAgAAH1ACAAATigIAAAwEAgABfYoA=
Date: Wed, 22 Nov 2023 04:15:59 +0000
Message-ID: <9a774508cc54914bd50b649218a3a17b632f31d2.camel@mediatek.com>
References: <20231121220556.GA21969@skinsburskii.>
	 <20231121222325.GA260057@bhelgaas> <20231121223410.GA23977@skinsburskii.>
In-Reply-To: <20231121223410.GA23977@skinsburskii.>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEYPR03MB8202:EE_
x-ms-office365-filtering-correlation-id: ac5547ab-e7b6-444a-de39-08dbeb11bb87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcPs5vdZ0SQRfl5ET/SMcXqngexDY3lpEgkt8hrt124muohNv8JqgCUZ3fBX8d7i2immZT8vsDtDTU1E/cGe/IhWe9Slm6ERhKsUh3kAZIOT1CcpWF1aj6uE1bCIZf/XVh9IKlqaPo1EXgIsQLMXFVcptuNd16Ibf9u1ATF1wmWhyLmxzBs+j1WYXb46eFVIyL4zmGleD/ytdN2lYCNK8iN0kf2T2IZSLI35jnNLsk6ta/T+3MYxcLL5bfxbbjGJheViDl996nCkHvGVx8wd3UTOhoGuzkMAo7xgfAP8cCqsjZ5KgZFZZjnvGbQ8ly0hUtUCFLG6OJmYzOJpJVPg++bO3bP3lMmj7lw9qII2eJYy0N1vxIsVPKT43ooolM01o/B933pXStyc6FVFlHuzjpNyUe6g9J/xSvWFu3FW1vWvf1xh2ShwgxSAj2GKWee3KOdbalX2/IhKJz9MjMT8RIuuBdoETsU++4vNKRMW6EknzkfqoM7EkUUDoTYmW+Zcduzaql57opQau2DgNBkBtSSBOcYma63JJ1RIxZvAZUOZN71N+HNcjV3Hjo42DAEgldDUsDKw0BXQ/SW+o7P4XqCPiCiVuXPcNmBxOb1mQUFd1cj0Llhvig5fHe7FIop9faJvAtKNhFnaVcAhQkvNpbfSx75dB17oJR4mwIs4f6cWYN2ttWk7UtLQ2gRHzQJh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(76116006)(66446008)(66556008)(66476007)(66946007)(91956017)(316002)(110136005)(54906003)(64756008)(36756003)(6506007)(6512007)(2616005)(6486002)(122000001)(26005)(38070700009)(38100700002)(966005)(85182001)(478600001)(83380400001)(86362001)(7416002)(5660300002)(4001150100001)(2906002)(41300700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdqcWtJaTNCM0RXN2VySGNraVdKRjNzcWFMM2VYMFRKclJqRVBUV3FZS0lw?=
 =?utf-8?B?Mjh0dmsweEMyeUZnOWJudVVaRDAzVU5Ba0gvaFBER0t1eWVHNVB4T01sMUxt?=
 =?utf-8?B?cDdzZTdpakRBN2N4S1FlcGUrSXVmd0ZENTVqcDJ4ejZkcXNmZERJSnh3bTEy?=
 =?utf-8?B?OFhydklCTm5lVTBxMlNsTWhLVFVKY21CSzhkcW4vYzAyTU5sRU91Q3V4MFNV?=
 =?utf-8?B?MFdHR0ZkaXJkZGpyQzcwVTB1V2hoc0x2ZTVuL3NvL2xpL21IdVhtZG5Xbkt2?=
 =?utf-8?B?VVFCZ2dzL0RwSWJSZTZnTUpMeG5UdWp2SlZacFB0ZnhiWk5NT0hhQ2xTNVVH?=
 =?utf-8?B?ZDR1VFozK2lrVHNOWDhLcFduRkpUZWpyekl6Nk5nKzFURGMrRnprbEJOdSs5?=
 =?utf-8?B?OUFSTHZqYjNEaVNMWTAxSlcxZS9ZOFVONmpDR2RhNTZDbElvZG5TekJzZ05o?=
 =?utf-8?B?SElUS2J3SmpwQjloMWVaK1EwZ2g0K21QTXVJUmpqTGFyUGQrTU1OZExxZDJM?=
 =?utf-8?B?VVdhUE1OU0g1VGlhcm0rM1JiRlJqV2ZBTEdPZy9DRFcxd01vVVI5cHgzK2ha?=
 =?utf-8?B?U2JJMVVWVUVPd2VpRHFBK3gxankrUHZ3STdtRGJYZ2xxQWJHUVdWOVVXdS9E?=
 =?utf-8?B?RHZXMUdnOFFjU3F4N1FNa3g0MUdVbytEUXAxOVpFN08yRzNTb0JqYjlCYVV3?=
 =?utf-8?B?ejh5VVl5MUUvVk1XNkxtbk9LSXBLTVlmd0RCdkwxa3BlYU93RTlpQ2o4QnU1?=
 =?utf-8?B?WXNPcjFsVE9Jc1E1b2QrTmNjZzExV29hV1BiaHdiR00wUU9VWEZqK0V3Tklo?=
 =?utf-8?B?UTlMRE5pQXFsRVJGZ3FnVDRtTnczY01taTRaTC9TcVpXbGFic2ZGREY0Y1BQ?=
 =?utf-8?B?M0hldVYyY0JUMFJBZGVHRTZQRk9NelNKOUw1MWRYbUFWdWsxZERXa3dya2Qr?=
 =?utf-8?B?ODZSenZXNTBkSEJMc2xKbGdzQk5JdDE2V3NjSkRSRzI3QWVWSjY2ZlBTVU9O?=
 =?utf-8?B?RVhTSk9vWWxVeWJ2ZW1FdGR1cUhyT0g4cEFpbFNUWGFoRHdVZzA3NjFYWVpj?=
 =?utf-8?B?TnlhQXNabElKZkxUdW1ZVkdEblN3bURtOUtZa1FrdGxZL1ZxOHJFTzJHeVdK?=
 =?utf-8?B?d2hvaTl5MWVhQ2NoS3FhNkZMWlF3RG1aNzhjbUhaSHZhN253b2xoR00vYXZF?=
 =?utf-8?B?N0VBVzNoTnlqOTdCaGRVRThLdzJmMEo3MFFwU1A3L2Nmb2Rleit2bit1LytC?=
 =?utf-8?B?QS8vR1c3RzI2U2ZEamFlckU2WlVhSTZNSDQ1WWt2dUU1eDBZWjdVdEJaWkRl?=
 =?utf-8?B?eXhidUZhUDdJWkdreEF1SUNzQmtEeEp6NVJKZHRDNzJsazhKYm9aSWFpOEc1?=
 =?utf-8?B?dHQxbEF4dW9xSTdBRVpBZDBXTDlPVW1VUHBLaGs4Y3lZZ0FiTmovVmM1SGJs?=
 =?utf-8?B?R1dORkF0eS9XYTdTMGRDeVVxSWZISlR2TXAzRzVqWWJFR3R1cHpFK0tkSC81?=
 =?utf-8?B?M0xkWUw2ZkRqSDdWYnhLd05xYzVNRGR3TDRDdS93Q0J5cnUzY094Z3YyQTVD?=
 =?utf-8?B?NHZ1LzNEdzFXNXkwZms0Ynh4S005bkxNeXpkYUNNalFJY1pMcW9qRFQyVG11?=
 =?utf-8?B?NS94bXYvd0E4UkdETTY3MTJwamZrVThybnlnbkFFQkM5czc3OVF6NlVzc0Rx?=
 =?utf-8?B?T3NVTXk3ZFFDd1F1c2xORGJaa1BETjc5Sys3aS9UWmVSSDhBcEpIUmR5bG1L?=
 =?utf-8?B?VVZjWXdvMFB4VkFFY2NvYVFMRGhtSk9sY1N6Q0dDMFFqOEpQTWg1WEphZXBN?=
 =?utf-8?B?MEFWN2hwZkYxNVhnSENvMXRtTGFJV2ZGQ2ZMNktjQUZaZmY2VGNsRzkvc01u?=
 =?utf-8?B?ekNoQ2ZIMDM0WThHQnpzUHVoci9mQW1GQkp5T3JQek5hbXJMRFVyS21LNFE3?=
 =?utf-8?B?WkdTL2RnaStKUDJnV2RoMjJjVjR4TllkQktlREg1UWZvMGcxMHVLbys0TVNv?=
 =?utf-8?B?dzgrVE5SN0hoTWtiUVBxQ2NtdGpRa0tYWDkxTkRwbmpNZkF4YzBKZEtPUnh1?=
 =?utf-8?B?ODBEOTN1RG1CT0R1TFFTS0F2SWpCUjgvVmoyRmQzbGQwekZOVjlzQ3ZSRmI2?=
 =?utf-8?B?Z28yQUZxdkwreStKOVpGclVmQ2hlL0VKRkVNZ2l0WlBFNjd1T1hCNytzK0hl?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19C61E1312C5D54783AB3661C936FCCE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5547ab-e7b6-444a-de39-08dbeb11bb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 04:15:59.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrP0HmcPziWRqq8cyhe+f55arx2h4noOWLy6zpTnsSjvxTKJU0/rrFfrNg+PL869PmeaWkov78Dd7+uVcXz0Q2HA4s1zP9vMZ3jHxBDe7nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8202

SGksDQoNCk9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAxNDozNCAtMDgwMCwgU3RhbmlzbGF2IEtpbnNi
dXJza2lpIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIFR1ZSwgTm92IDIxLCAyMDIzIGF0IDA0
OjIzOjI1UE0gLTA2MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gT24gVHVlLCBOb3YgMjEs
IDIwMjMgYXQgMDI6MDU6NTZQTSAtMDgwMCwgU3RhbmlzbGF2IEtpbnNidXJza2lpDQo+IHdyb3Rl
Og0KPiA+ID4gT24gVHVlLCBOb3YgMjEsIDIwMjMgYXQgMDM6Mzc6NTVQTSAtMDYwMCwgQmpvcm4g
SGVsZ2FhcyB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBOb3YgMjAsIDIwMjMgYXQgMDM6NDA6MzNQ
TSAtMDgwMCwgU3RhbmlzbGF2IEtpbnNidXJza2lpDQo+IHdyb3RlOg0KPiA+ID4gPiA+IEV4cGxp
Y2l0bHkgY2FzdCBfX2lvbWVtIHBvaW50ZXIgdG8gY29uc3Qgdm9pZCogd2l0aCBfX2ZvcmNlDQo+
IHRvIGZpeCB0aGUNCj4gPiA+ID4gPiBmb2xsb3dpbmcgd2FybmluZzoNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiAgIHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIGFyZ3VtZW50IDEgKGRpZmZlcmVu
dCBhZGRyZXNzDQo+IHNwYWNlcykNCj4gPiA+ID4gPiAgICAgIGV4cGVjdGVkIHZvaWQgY29uc3Qg
dm9sYXRpbGUgKmFkZHJlc3MNCj4gPiA+ID4gPiAgICAgIGdvdCB2b2lkIFtub2RlcmVmXSBfX2lv
bWVtICoNCj4gPiA+ID4gDQo+ID4gPiA+IEkgaGF2ZSB0d28gcXVlc3Rpb25zIGFib3V0IHRoaXM6
DQo+ID4gPiA+IA0KPiA+ID4gPiAgIDEpIFRoZXJlJ3Mgbm8gb3RoZXIgdXNlIG9mIF9fZm9yY2Ug
aW4gZHJpdmVycy9wY2ksIHNvIEkgZG9uJ3QNCj4ga25vdw0KPiA+ID4gPiAgIHdoYXQncyBzcGVj
aWFsIGFib3V0IHBjaWUtbWVkaWF0ZWsuYy4gIFRoZXJlIHNob3VsZCBiZSBhIHdheQ0KPiB0byBm
aXgNCj4gPiA+ID4gICB0aGUgdHlwZXMgc28gaXQncyBub3QgbmVlZGVkLg0KPiA+ID4gDQo+ID4g
PiBfX2ZvcmNlIHN1cHByZXNlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOg0KPiA+ID4g
DQo+ID4gPiAgICAgd2FybmluZzogY2FzdCByZW1vdmVzIGFkZHJlc3Mgc3BhY2UgJ19faW9tZW0n
IG9mIGV4cHJlc3Npb24NCj4gPiANCj4gPiBJJ20gc3VnZ2VzdGluZyB0aGF0IHRoZSBjYXN0IGlz
IGEgYmFuZC1haWQgdGhhdCBjb3ZlcnMgdXAgYSB0eXBlDQo+ID4gbWlzbWF0Y2gsIGFuZCB0aGVy
ZSBzaG91bGRuJ3QgYmUgYSBtaXNtYXRjaCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4gDQo+ID4g
PiA+ICAgMikgdmlydF90b19waHlzKCkgaXMgbm90IHF1aXRlIHJpZ2h0IHRvIGJlZ2luIHdpdGgg
YmVjYXVzZQ0KPiB3aGF0IHdlDQo+ID4gPiA+ICAgd2FudCBpcyBhICpidXMqIGFkZHJlc3MsIG5v
dCB0aGUgQ1BVIHBoeXNpY2FsIGFkZHJlc3Mgd2UgZ2V0DQo+IGZyb20NCj4gPiA+ID4gICB2aXJ0
X3RvX3BoeXMoKS4gIE9idmlvdXNseSB0aGUgY3VycmVudCBwbGF0Zm9ybXMgdGhhdCB1c2UNCj4g
dGhpcyBtdXN0DQo+ID4gPiA+ICAgbm90IGFwcGx5IGFueSBvZmZzZXQgYmV0d2VlbiBidXMgYW5k
IENQVSBwaHlzaWNhbCBhZGRyZXNzZXMsDQo+IGJ1dA0KPiA+ID4gPiAgIGl0J3Mgbm90IHNvbWV0
aGluZyB3ZSBzaG91bGQgcmVseSBvbi4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgVGhlcmUgYXJlIG9u
bHkgdGhyZWUgZHJpdmVycyAocGNpLWFhcmR2YXJrLmMsIHBjaWUteGlsaW54LmMsDQo+IGFuZA0K
PiA+ID4gPiAgIHRoaXMgb25lKSB0aGF0IHVzZSB2aXJ0X3RvX3BoeXMoKSwgYW5kIHRoZXkncmUg
YWxsIHNsaWdodGx5DQo+IHdyb25nDQo+ID4gPiA+ICAgaGVyZS4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSAqX2NvbXBvc2VfbXNpX21zZygpIG1ldGhvZHMgY291bGQgdXNlIGEgbGl0dGxlIG1vcmUN
Cj4gY29uc2lzdGVuY3kNCj4gPiA+ID4gYWNyb3NzIHRoZSBib2FyZC4NCj4gPiA+IA0KPiA+ID4g
Q291bGQgeW91IGVsYWJvcmF0ZSBvbiB3aGF0IGRvIHlvdSBzdWdnZXN0Pw0KPiA+ID4gU2hvdWxk
IHZpcnRfdG9fcGh5cygpIGJlIHNpbXBseSByZW1vdmVkPw0KPiA+IA0KPiA+IFRoZSBETUEgQVBJ
IChEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2RtYS1hcGkucnN0KSBpcyB0aGUgdXN1YWwgd2F5DQo+
IHRvDQo+ID4gZ2V0IGJ1cyBhZGRyZXNzZXMsIHNpbmNlIGFuIE1TSSBpcyBiYXNpY2FsbHkgYSBE
TUEgb24gdGhlIFBDSSBidXMuDQo+ID4gDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtcGNpLzIwMjMwOTE0MjAzMTQ2LkdBNzc4NzBAYmhlbGdhYXMvDQo+ID4gDQo+ID4gTm9ib2R5
IGlzIHZlcnkgbW90aXZhdGVkIHRvIGZpeCB0aGVzZSwgSSBndWVzcyA7KSAgSSBzb3J0IG9mIGhh
dGUNCj4gdG8NCj4gPiBqdXN0IHRocm93IGluIGEgY2FzdCB0byBzaHV0IHVwIHRoZSB3YXJuaW5n
IGJlY2F1c2UgaXQgZG9lc24ndA0KPiByZWFsbHkNCj4gPiBzb2x2ZSB0aGUgcHJvYmxlbS4NCj4g
PiANCj4gDQo+IFRoaXMgaXMgZmFpci4NCj4gSG93ZXZlciBJIGhhdmUgbmVpdGhlciBleHBlcnRp
emUgdG8gYXNzZXNzLCBubyBoYXJkd2FyZSB0byB0ZXN0IHN1Y2gNCj4gaW50cnVzaXZlDQo+IGNo
YW5nZXMuDQo+IEkgZ3Vlc3MgaXQncyBhIG5vLW9wIHRoZW4sIGlzIGl0Pw0KDQpJIHRoaW5rIEkg
Y2FuIHRyeSBhbmQgdGVzdCAnZG1hbV9hbGxvY19jb2hlcmVudCgpJyBvciBvdGhlciBwcm9wZXIg
QVBJcw0Kb24gdGhlIE1lZGlhVGVrIHBsYXRmb3JtLCBhbmQgaWYgaXQgd29ya3MgYXMgZXhwZWN0
ZWQsIEkgY2FuIHNlbmQgdGhlDQpwYXRjaCB0byBmaXggdGhpcy4NCg0KVGhhbmtzLg0KDQo+IA0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSA8DQo+IHNraW5z
YnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYyB8ICAgIDQgKystLQ0KPiA+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWsuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5j
DQo+ID4gPiA+ID4gaW5kZXggNjZhOGY3MzI5NmZjLi4yN2YwZjc5ODEwYTEgMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+ID4g
PiA+IEBAIC0zOTcsNyArMzk3LDcgQEAgc3RhdGljIHZvaWQgbXRrX2NvbXBvc2VfbXNpX21zZyhz
dHJ1Y3QNCj4gaXJxX2RhdGEgKmRhdGEsIHN0cnVjdCBtc2lfbXNnICptc2cpDQo+ID4gPiA+ID4g
IHBoeXNfYWRkcl90IGFkZHI7DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAvKiBNVDI3MTIvTVQ3
NjIyIG9ubHkgc3VwcG9ydCAzMi1iaXQgTVNJIGFkZHJlc3NlcyAqLw0KPiA+ID4gPiA+IC1hZGRy
ID0gdmlydF90b19waHlzKHBvcnQtPmJhc2UgKyBQQ0lFX01TSV9WRUNUT1IpOw0KPiA+ID4gPiA+
ICthZGRyID0gdmlydF90b19waHlzKChfX2ZvcmNlIGNvbnN0IHZvaWQgKilwb3J0LT5iYXNlICsN
Cj4gUENJRV9NU0lfVkVDVE9SKTsNCj4gPiA+ID4gPiAgbXNnLT5hZGRyZXNzX2hpID0gMDsNCj4g
PiA+ID4gPiAgbXNnLT5hZGRyZXNzX2xvID0gbG93ZXJfMzJfYml0cyhhZGRyKTsNCj4gPiA+ID4g
PiAgDQo+ID4gPiA+ID4gQEAgLTUyMCw3ICs1MjAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcGNpZV9l
bmFibGVfbXNpKHN0cnVjdA0KPiBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ID4gPiA+ICB1MzIg
dmFsOw0KPiA+ID4gPiA+ICBwaHlzX2FkZHJfdCBtc2dfYWRkcjsNCj4gPiA+ID4gPiAgDQo+ID4g
PiA+ID4gLW1zZ19hZGRyID0gdmlydF90b19waHlzKHBvcnQtPmJhc2UgKyBQQ0lFX01TSV9WRUNU
T1IpOw0KPiA+ID4gPiA+ICttc2dfYWRkciA9IHZpcnRfdG9fcGh5cygoX19mb3JjZSBjb25zdCB2
b2lkICopcG9ydC0+YmFzZSArDQo+IFBDSUVfTVNJX1ZFQ1RPUik7DQo+ID4gPiA+ID4gIHZhbCA9
IGxvd2VyXzMyX2JpdHMobXNnX2FkZHIpOw0KPiA+ID4gPiA+ICB3cml0ZWwodmFsLCBwb3J0LT5i
YXNlICsgUENJRV9JTVNJX0FERFIpOw0K


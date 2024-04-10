Return-Path: <linux-pci+bounces-5999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414389EBCA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64DF1F21C02
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922113CF81;
	Wed, 10 Apr 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KCK8/5dG"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E213CF91;
	Wed, 10 Apr 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733843; cv=fail; b=s/6odHF3MpopdyE7RKOgbFgaRccUuaUKPYMi+t20GvdFzo8kRO+WTSoalAe8o1SD1/0ySnQcP4MpU2eUVkSGLkBTgjoKT2WDh/8tEvHqxsSzU7MOVNp2Yo9y5MjB1FjQykAdhKwrf68NxRURLnpuD9OQWWY7KVneWh51XMpHXF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733843; c=relaxed/simple;
	bh=waqwME4aEwXu2BoTaRYOTQ2gh0DUOtXCxk2/LKbj+oI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dz+WtKiD7M7L/H7Y4NShcHq7gUHtxjAIxXRNRsTyjz1ydCZRr+90nda8DvAnpoIDzGm8MUtCOIVSXzVinWdUrA8yxB6Yb/6NVQGFv3Za7j9CYPhBhvlA+3Jnwwy8RvqJJrcYM2HgbvebGulUw6TqVnjvk2UkQAb1W/MIBDpnqF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KCK8/5dG; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712733839; x=1744269839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=waqwME4aEwXu2BoTaRYOTQ2gh0DUOtXCxk2/LKbj+oI=;
  b=KCK8/5dGU43pA2UVFQi3jUjImlxJqf76+TyWiLuxFABSPM8ituSocuPZ
   dDhKtR0D0212+LjlLJUmCy9UVYRsH4rM3F+CsvKxlEVQQp7OiuW2CDYf2
   2bBCVUQWFPCpTarHfkuFBCuhmyCRq3X45RwQUxET2MudMy3HPYoMLKjc0
   9Dav/oBaoW3zc1IjkhR3T/hzO+nad7okYXumErbllRTUO5cBj+Ui8HLlD
   7DNqmLli0AoD2J6LPrqbqC+7ZdS7AfLuix1aabG41GEobVBnPn8v2IRao
   SFG+Bi9MpWx0Ht2rUQtRyqy8qCXg7ZdIExu8iyYQ3HH3/Z/kW9CrhOzJ6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="116771552"
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; 
   d="scan'208";a="116771552"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:22:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pity5e0XBWnbERWGl+RIq0RPIVuxDHD3+zVv5GaBfglZUaU+dFGAoxQ5xcmzdAHbtgsBnsA0Zo/F++IEuSA9QXRuxpumPmioGc0w7TRHwV/YmMq0PpmtQhg3L5y+4sihUMuktOG+9IE8KK/AfC5TCwa14voIBTh4bwo0FR/a9/Hm/dtYPM5hlXkLU0V0ZISQ4DN6IpMCj+vElYDEWaWrjW2efJ1LqL79jE5icc53EVIdIHp9ihxwAHvkUFb6g1JxGhiI8IsEbKUAiBX3pmfZEe3hEe0Iu0Hfwj+tGLYTh0My8IkyFPrRpIdzyJH0MyuNAvBGya+rVA/vO2u1zERgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+P5DPcd04woa6lu4iJhdkE0YjnwXCw5t+SA5iVb/sE=;
 b=bLjMmGpHuReyz4/I8TnB4anLT/JL0S4Y4skre917PElJXVsV85pKCk8evVCu7+dt7MoXb3GBrWVHFX12JhQ0DzuVuhSfGwx+5FIAnCBBLdk+QtYvWCZ2rdcTRnqRHf6EVJQarYbRsSz4Clo+vt94MRpz6bMDRONan2sOo/NDRuYwWJeOzyU0N7iUbeolmhmAMtcVIedPJlURCQyeVvsbKc9nf/tOwTcj+T4eUzOP/W8BT4XZMcQujIxba8lGlGtBLfZlWC+QDAm4iO8s+kIVRYTqKPB2Q+CrDE8bdm5snklN12TowBlc9h013C6LerOPNzOmomMRsK3vBMX3CAtovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYVPR01MB10798.jpnprd01.prod.outlook.com (2603:1096:400:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:22:44 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:22:44 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Topic: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Index: AQHailA4SClC4VBxrEOcikYP+rGxhbFgdnkAgAAD6ICAAJw8oA==
Date: Wed, 10 Apr 2024 07:22:44 +0000
Message-ID:
 <OSAPR01MB71822AAC19661B7BC652B05ABA062@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
 <6615b424e055f_2583ad2945c@dwillia2-xfh.jf.intel.com.notmuch>
 <6615b76b16371_2583ad2945a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6615b76b16371_2583ad2945a@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d7a56efe-7640-45c1-a42b-a41dc4aab32c;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-10T07:07:19Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYVPR01MB10798:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xSHJlTEvpbVFAxjFwN1qiuLp4Fc9QuokbJDd31Y72+Xs4dEsoM4uduO+TYuxQdK4X2ClwUj/zcpqJb8aI4q+4H7w5EzAIhMTeJv4wfoN/BsLxLCL8YsRO+QBZlMWFsYytFGKdzoJrkk06Tv47hZLEy+VJGSHuWhnjphxuPy717/w4vU01xPzZZVNa6tkkUSPQbA3xpbMHB5XUBfZYAyhEzeLqr9OZ3ncf2hE/3jS+gfRXEs1XNGr1ipU2OnQJzBY0l1mUSJ5KTYjWR7dsDdFwtD3r+uiZJELim/VdjvqeS/xE8WHor91AUmzCx+p8CtHrvysz1TsHouhzbbdi/cqkvy8BNeOJ4SZ8pb+ZoEHw4fRKPuIlUTj8ZMlqVNgJ+v81/HypdYz+GJ/fBHCHz4/NjXHdPTxxgLJPYcvaOWoDx2b795ow0bdfrtHTQt4FBe9tnRBQ6C2ubuIYpVBTxWPjdiQnPEOSMIv/PNBoTztnORQr1fEbGGVdjv1KkoMD/mw/fwgvaYKqetMxtSSIvmi01F1Qd2ZHvA0zAwXSzCquZPcxWZ5luSjZvdNbigMOBjWJOj5CRKqmLU6TrDFooyifMhqjPF0e8oR0tWrgBZNuE+9gLDm32zM59cLoXx/zQtw/vb6JsAHeRhEo9UBDhuMR6q88zOqVbis7xAQdkKtZGVKVM6PZu1FVFC04aqWzMAuJeEWvDAC4p7RjxX1sxbT8A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WldjNXFycjVRU2Mwc0hRekptb3I1V1hXWU13ZGh6S2pJVUpzRWxYd25V?=
 =?iso-2022-jp?B?aWtSRGl0cDUvQTNFSGorTzg4ZHBZOEtTRExrck5XVThNTmdOVDNmTE53?=
 =?iso-2022-jp?B?c0JlbmFoekVPaUthNVB2aWRvWng4RitsUDBVUnUrcjhQREtZUGN4SzNN?=
 =?iso-2022-jp?B?ZVFPZ09XQitPS3kveDd3TXV2cWV3amdVa01tOGFLcHhkRW5LUEpoYzh4?=
 =?iso-2022-jp?B?Q0tucHRybEpFOVJoRU50M29QdlpRN3ZRY2gyZjFlWmxxWXpFLy96OXhI?=
 =?iso-2022-jp?B?TnQzR3pTdGI3MVBRQ0E2SjZ5YlBURnRJM2JwOFZVbDRxYitITFRSdTMx?=
 =?iso-2022-jp?B?bEdUUTk3MHdFYnFMcU5JMWhybVJwMFR2Qm1ZNWtJSkJ6WlhSZkVUZzZW?=
 =?iso-2022-jp?B?V1hxdmJ5NVVQdVY0OWQzTnJ4N3luRXpHTzNnQ3BHcVFmMmhXczFLRWJW?=
 =?iso-2022-jp?B?bDNJUk1MWG5DUk1Qdk5OZU9FT2ZQKzVuQUhHV1JDbHdjV2NxdE5uZTJ0?=
 =?iso-2022-jp?B?MWFncU9YRHU1bTdUWEpZdmIrSFg2bnJjRFFhdkdUMnBVWVFBamxEV0I3?=
 =?iso-2022-jp?B?eGw2MThJM0tuaDAzaUpScitXVWlPT0xWeDVna3BNT2FJclkra1R2Zitn?=
 =?iso-2022-jp?B?dmIveWdtS0VXU2RqQURqMmJETHpEUHFld01LbVhEMUNpekVhcGpZNDZU?=
 =?iso-2022-jp?B?dE5FaXdhdzFSckx0d3BmdnM2Y2VjSFYxRkV0aEtiMVJIRzJBRktkKzJl?=
 =?iso-2022-jp?B?RmNvSHBSb0pOOG81Q0x6ZmtMQ1JJa0N4QXRLZUphR0ZjWGFQaWlTMlRU?=
 =?iso-2022-jp?B?dUlvaGN2bGFrVnc2djA4cXA2SDBXWXdUSXc3MFRzN1FGdVdXbWZBYmlu?=
 =?iso-2022-jp?B?S2J4NHhWY3RBSWNRdWIzdnVhZGlXWHNVM0pKUFFrMlNmZlBHTTl0RlA2?=
 =?iso-2022-jp?B?blQvQndtU2FmbkxzV0VsaUpacVpURktrZkFNbmg0WjhwcVZ1dHBlM3h4?=
 =?iso-2022-jp?B?L25OcXhhZE5UbG9hTkNoT0ZUcllkRzkzVnVZOHEyTC8wbkN5YXhsb3Vw?=
 =?iso-2022-jp?B?Zk1wSHRpN3MzaVh6b2JjbEdMMittZnhOSjJYV1diOTRQTEVPaFBKRXJ0?=
 =?iso-2022-jp?B?RDhqZXFPeXNnZFdKWXFYQWZPYjJqZ2tjVlllWUpPRk1hQ0EzTjlVbCtj?=
 =?iso-2022-jp?B?VEJXNnpzK3BHeWI2dVZ1NnlWMkxYdEI4azlJK1JQcCt2N3kzaVNRaC9S?=
 =?iso-2022-jp?B?aW9oZCsxZ2R4S1hmRFNWYnFjQk1xR1R0STBDVktySVZtdW9wajNkUHZK?=
 =?iso-2022-jp?B?UVpmWERhOVY3RmpZRUVPYzcvTDB1SHc1OUJCaTJHV1ZBbnlGL0pDSWtZ?=
 =?iso-2022-jp?B?L082Q1g5bHRIMkVnQUY0cDZhcEgvVU1mTHZoRGV3TXVnN0ZHVnFOSmVV?=
 =?iso-2022-jp?B?WjRpUkN4NHBwTGxWamhVbjUyaGkrS3N5bWhwVk1ZalhXZk9wNVVKOEZj?=
 =?iso-2022-jp?B?ZFpHZXArZlpSY0kvbU9tZ0IxUGhwLytoUytoT1dubkdaUG81V1BKU0py?=
 =?iso-2022-jp?B?TCs0anhGd1I3bWl1aVRJazJTa0xrcnpySktuQjl5Z1M5dzRVUVV6RFY4?=
 =?iso-2022-jp?B?cE5oRm42YkJvZmVHYXcvbU02T3I0eVJiRm8yYnQzSEMrTkp2WU4remtK?=
 =?iso-2022-jp?B?RTVmNUp4WUdjSDRKZFNjMm1jSUdGbFN3N0ZkbVRFNVMxdXdLeEZkMHc2?=
 =?iso-2022-jp?B?NU9sb0JLWHNjdEJWRFlGeGxuNjBJaTlUTTk4b2JobjRwb2s2U29nV1Na?=
 =?iso-2022-jp?B?MmtsSHdqS25jd3psZnR2VUo5UFJnTy95cEErTFA5ZG5RNUlWRHd2akRa?=
 =?iso-2022-jp?B?MHJ0V3AwOUk5bUx6ejh2SDNhUUNHWDhKdzJOZXdCTk1JZlFPcFNGajFC?=
 =?iso-2022-jp?B?eWhhOVc3R2Z3NkpxL2JiV24yQitnbElSUUIyVjZTZzViSS9VT1ErQndP?=
 =?iso-2022-jp?B?VjV4V2JnMW01ek5qZEdLKzFaZURTclRjZU9udFBWUzB3b2xiNmFwN1c0?=
 =?iso-2022-jp?B?UWNLKzVQR0laWE1TZ2JXYVBSM1FYb0lHRnV1ZGEzNjlKWGl6L3VOUTdx?=
 =?iso-2022-jp?B?cXh3TDMvTEgwQ3U1OGltYjlIZ3VkVVNhTU05WGs2TkZzeFluWkVveENV?=
 =?iso-2022-jp?B?VFBiVUR2M0d1bVNjenJwYytaNW1OUm9xUGJUMStEVmRHUHovZWtZeEVv?=
 =?iso-2022-jp?B?bUNVeVc4MW5hU3Q4b3RReGZPc0xQL3QyMG9pV2FXZUs4TzlDQTM2cTBt?=
 =?iso-2022-jp?B?cFNLQXhYZUpzdFYwZ055eFdXcVc2aldmWkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sATw3QBWArkm99zG6K/7O1itNdMM/vbTtuqV+TOTyVapo7DmULwmODGQ5rSYoYbBZbzwH0fwsRG7rWSCt7MTMs1C2b14EU9mhDJ+GYPpAOqAUba3tZAGwzQrdYiBsAiWUP+FZIfsU/+xnB7Kvd21js0WRvyhwKNqsSnr+xtHSR0FJWVS/rvNLBoShzI9/ICH0fjiPQJS8C4Qut8+zDgLJfxaWLsrs3+Zy74fHIcy2nIQX7XqUtwcsa3A4PrDMgA63VuCrrWcmzzzOnsSlttBqlWrGPsPk+/8rmJcZbrmArEYTQvJE8+/7dIyJZoBJZOYCG0YktPkumo+WlyEiTfdvHR/w7o3xuQHF2Qs9vZYlMmaBR3tKdYdzEacpiBpBWuzPjcAzsLSmm/5ZypZcvCIDxE7ShK5MaHUYUN8UXELhNUBWAUK/Iw0JWwFHVjqlGcjuDHq6DKx4AcnuXoU0Npe0+YAH2NIGHSa+q1rQOElK1EV0yVUbajLIZ3cxy+T6haYsa24mZVrivk3nvK9Bn6aXU8wAGKxZwph2VgB+7qKHZkaxLBLKGBUvSRrp1rdoUBx5tnlAli9sZN66Qbzohaef1v2OmIkLn8BkVNTrpv1e2kNcVz1Ogzg27XjTzHvtIZC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6aae32-8a40-4cc0-dcee-08dc592f03ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:22:44.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdzXjQrf50qqIDYnx16jeudePnPtqjJwHSV+wz79TA8t/RuGcxA2i0z+HZjxYPe3ZImoJShTYDw1b8DUTua0e1j2yUqvhVcZ9Cijd9mKAfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10798



> Dan Williams wrote:
> > Kobayashi,Daisuke wrote:
> > > Add sysfs attribute for CXL 1.1 device link status to the cxl pci dev=
ice.
> > >
> > > In CXL1.1, the link status of the device is included in the RCRB mapp=
ed to
> > > the memory mapped register area. Critically, that arrangement makes t=
he
> link
> > > status and control registers invisible to existing PCI user tooling.
> > >
> > > Export those registers via sysfs with the expectation that PCI user
> > > tooling will alternatively look for these sysfs files when attempting=
 to
> > > access to these CXL 1.1 endpoints registers.
> > >
> > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > > ---
> > >  drivers/cxl/pci.c | 74
> +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 74 insertions(+)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 2ff361e756d6..0ff15738b1ba 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> [..]
> > 3/ The port corresponding to a memdev can disappear at any time so you
> > need to do the same validation the cxl_mem_probe() does to keep the por=
t
> > active during the register access:
> >
> > 	guard(device)(&port->dev);
> > 	if (!port->dev.driver)
> > 		return -ENXIO;
>=20
> Apologies, I made a mistake here. Copy how cxl_mem_probe() accesses the
> dport.
>=20
> 	endpoint_parent =3D port->uport_dev;
> 	guard(device)(&endpoint_parent->dev);
> 	if (!endpoint_parent->driver)
> 		return -ENXIO;

Thank you for your feedback.
I could not find the exact same code as the suggestion from cxl_mem_probe()=
,=20
but would your suggestion be correct with the following modification:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..0ff15738b1ba 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -786,6 +786,79 @@ static int cxl_event_config(struct pci_host_bridge *ho=
st_bridge,
 	return 0;
 }
=20
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
+	struct device *endpoint_parent;
+
+	port =3D cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return -EINVAL;
+
+	endpoint_parent =3D port->uport_dev;
+	guard(device)(&endpoint_parent);
+	if (!endpoint_parent->driver)
+		return -ENXIO;
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
[..]
--

From reading the guard macro, my understanding is that this is a macro whic=
h
calls the constructor here, and calls the destructor when the scope is exit=
ed.=20
Will this prevent the port from disappearing?


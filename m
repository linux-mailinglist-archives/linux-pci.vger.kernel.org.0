Return-Path: <linux-pci+bounces-11346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEF94897C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 08:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F8AB2384B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642D1BBBEB;
	Tue,  6 Aug 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sk7lh4wg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jZ130hwg"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95E1BBBE7;
	Tue,  6 Aug 2024 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926205; cv=fail; b=dBOE5G0sjn1X7CSg+Ngz2Q9f8GR3Ev47H+BV1X7rZfSppYx+1DbqFot2JA3QaRo8akGt/C9bV3R2v6BFlReEj0S5A70qIXNfqf0wEqUksO62+x88+A2U03mZtneBAh0tTADVrIYnwe3jbX2hEQ/auzTG7F9raqfdSvkJHpF/AVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926205; c=relaxed/simple;
	bh=Mzsm67HAdBdaKj3dvrYG2wD7/AuV/fFjzzTXyalUTJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/DJwDHyJeeK0/KtmTJ9AcHo0CsesgvRiClf7OZ58fQRN002oziDKUs7CY7Zusj1gJy6xfXW8UfXzNYr3Aw4xp3s42ocDvhklHHQ15R3UZUbZIz813k3GtcfOk6EdrQWRjhoSMA17MO/CRmbj99TfVMl8JfDL25VpF1v2qRUOv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sk7lh4wg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jZ130hwg; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722926203; x=1754462203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mzsm67HAdBdaKj3dvrYG2wD7/AuV/fFjzzTXyalUTJs=;
  b=Sk7lh4wg2sjN3APSFcVTW/lOcw23uortjktfMl/1rjn21Z30LZ37lTg8
   ibNJLPSkPc5JheixRO0BtwItrM0JHA9HFnbb3ZrXPSxvchFemzZ4qwlKW
   UBiDZP6IQw/CzlzB4AuZob4hdRIAQt/S04A5RyEc9aS4WC7IsWi+Qkgrf
   /otpEm1vJRUbIM2tn0hICAWOIxwKrB4EYsjPReieDjf/Op1vsa5TuVhq4
   drc2FFfT38moEqG5IFItllLn2O7lpCk5DHm2ndhMYEFXQs4LLmfONtLeJ
   2E4fTm3iyzOU80gRSh8abEcjIGrj5lPMEaAYNV6jsOn6AO2zMtx7ugC1F
   g==;
X-CSE-ConnectionGUID: WiWGxwNhRZKJZLsXYugLNQ==
X-CSE-MsgGUID: S1SfQ1XiSly4dtkDn0ZNKw==
X-IronPort-AV: E=Sophos;i="6.09,267,1716220800"; 
   d="scan'208";a="22936264"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2024 14:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxr9W1TLjSguqjbMEdsyWTslxUnXIahA/Z8BI1VOBPRKtXTaL1q8yN5RoQpRnXSPEDTXUt7NLAxWae6zV/a7KHsrWtMEPZcvHMfVYS2mhx5Gfn4LC8awBvJBeo+nEcICf1QpfRfA6Shz6P9nFPouqE/iV6uEqUDKM6AbuSSARcQlHwy6gjWMU+l/hlO9YpfXBKSP4pXF2BNHoa+It1eVziuXvr7D7bKzS0K5ffu2PrcBbKTRoyJEwmjFw3q9l0qEeHYaOMWkFRuFb0SZeGpi7eU3MWBX8r5cALaAkIcMbBG3rvm9Ze8e1PPPMX2nbOmIqxM63v/cbnPKdtZdkL2OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzsm67HAdBdaKj3dvrYG2wD7/AuV/fFjzzTXyalUTJs=;
 b=uEwymbR//jNr7qzU7mmVD+UgtnI0Y+TNDXeTSQP7Kt/MWlpWGFGgyMTv7GX79qvcKF6wSQHxDcu2vK+jraibMRhafXyo3DoxNqp1Vz1OChhgUp1isc68xPrU49Mf810cwVrXBUOK9sf2nWkghhuikRj3eRTCu2mTy+zvENVnjdHe/m6kg0V3VXlPi9w5hZa5g2t45XuNeY1SO1CjWQJF/PSwmVbKxuaYuA7c7Jmftnb2M8vxqafOHOvOpOs973CryFr6EddKshbh/MwtKTKiCNYTbHPCG0KFlJFAhrw9QxchyRJpdA5ZscWFuqCFeTuKd5xIVrd4OF5RPTIjvny+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzsm67HAdBdaKj3dvrYG2wD7/AuV/fFjzzTXyalUTJs=;
 b=jZ130hwgtSXAQmkk54mO7yqm2lRW2sbmZohuHEGgirLtLvYNCYL8N4W5+25Z7+91AclkqxcGbIE17clDH90C1VxToTRq/DQprze/pAktb+K0xqqRE7Z+go1t726KI1bS7x9MEGMOJry4cGUd5O57t00ZO2/U2LJGeYorezfBJP8=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by SA0PR04MB7466.namprd04.prod.outlook.com (2603:10b6:806:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 06:36:32 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:36:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lukas@wunner.de" <lukas@wunner.de>, "alistair23@gmail.com"
	<alistair23@gmail.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kch@nvidia.com" <kch@nvidia.com>,
	"logang@deltatee.com" <logang@deltatee.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Topic: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Index: AQHave+vEMTooi8t4ki3F8wRrv+sFbHIzYSAgFFMjoA=
Date: Tue, 6 Aug 2024 06:36:32 +0000
Message-ID: <06a795fdb2ad92bbbeb659872759158e25e9c7d8.camel@wdc.com>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
	 <20240614001244.925401-3-alistair.francis@wdc.com>
	 <Zm2RmWnSWEEX8WtV@wunner.de>
In-Reply-To: <Zm2RmWnSWEEX8WtV@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|SA0PR04MB7466:EE_
x-ms-office365-filtering-correlation-id: 120c9e76-55b5-41f2-5bd3-08dcb5e21c9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eCs5Ui8wSGtsNGZSNkZGZS8xOGE2dG9SU1dhZXBWOFFSc1VJd1ByTk81ZW9x?=
 =?utf-8?B?REFtMHhRYVdLUVJmUHByOGlxV0I5ZG94UVdBY3J4OFJ3MGhQc3JiMkZMVlQ2?=
 =?utf-8?B?U3RZanhPbmRzRjZYRWxHUHlDTkxtOUZianIxZWRLazM1Z29IZ1BhNk1rYkcr?=
 =?utf-8?B?eHY5Nkt5S3pKVHhxakxZZUNaODdJeTZWQUg4dU4rTDQwQW1GMi9ZVnVyWm9O?=
 =?utf-8?B?R2VMOXNFQ1JEZEl3TlMxTi9scWhYaElveVEyVHBXN0p4VlVmWFY5bEJFc1FN?=
 =?utf-8?B?VWhZVnJsTlQvZHAyTVd1U1JPUWFud0lOc2FnZG5JbmZpRnhaNkRHMi9CS0RT?=
 =?utf-8?B?UTZEMXRFaFllamYwRHIwQ0tNUG1EUmdUcnVEUHU3ZFgybGN0YkZwNWN0R0ZR?=
 =?utf-8?B?VmwxRmZaN01acEdkejFIMnkvdFl6MUthRUs5NitjdGNEZXVxMVNpcjNYTFFq?=
 =?utf-8?B?ZTI2VExuZGo4ZGRDT3pkN1E5NVV4RlIxamR6eFFxYi90L2gxNitQVTZmYzk4?=
 =?utf-8?B?anpPRXBpSFl0TnJ0TVlDL1dkTHJuMGRhbUtOMldpUmpsSlFjREw0bmQwNDgr?=
 =?utf-8?B?TDRUUmRacDVSa3gyVzRYbUVNVS82ZFpvb3N2aXdManNGNjFKS3U4WTNsbXNF?=
 =?utf-8?B?emduVng1U0RMMm4vSS9YS2NudEJyakdoYm0zZWVncXNQSkd5NE9KWks0Yzh4?=
 =?utf-8?B?NENveUpDVGd4UGlwemFCZWVJYmVXN0dnYjZmMHI2U0pjSk9NVllUNnh3WXVt?=
 =?utf-8?B?ZVRGU2lQWEM0dXlYbkJRZy83MjBIeHNqTU81UzFiTWlaT01KK1BWUVQzY2ds?=
 =?utf-8?B?cjh0MmhOQ01rRHZpZUhpaTEwN3JBRFk4QXhZRjFEeFJId296eGswQmYzbUh6?=
 =?utf-8?B?eHR0MnRCbWg5MVpNcGxJQnh1RFAzaXUzeXZ3RlZXWmgwbTN3WUo1RlJvT0hE?=
 =?utf-8?B?UjJVZGxhb3pVeE1jVDB2TjF3SU5Qa0ZHWjFndGNtb3AxQWttNzNoVkJJWXg4?=
 =?utf-8?B?UHR3VHQ2Z3RqSDRkTXRKUFJVbGFLeUNQcFVFdElxMWNUNlRXRUt6RHFVZnF1?=
 =?utf-8?B?QnEvNVlmMDI1ODFOYjRwaStsQ1cxaS9Va2JkUnNmYUxjOVZxbExPTUpBNE0w?=
 =?utf-8?B?WjFCZkZ3RXdlMXVoYS9hWkQ1TWlaak0xeXU2dElHZGVEQXJoSkl6bmkvUmJR?=
 =?utf-8?B?cm1ROWpXWFN0ekRwVHRDTDUvRzNnd2Q5azJsOWZESDZuQVBBZDcwdXJyTlRQ?=
 =?utf-8?B?RTlUMWtaOUZxS0dJOW5oWGljSlBHOWxSTW9iUTB2bXBEUUJuM2E0MnpSMnZ6?=
 =?utf-8?B?SjJ5UXpKamF5dmtLWGdiUjNqcmFTUFYzSVB6S0laUEpyYzVxT3B5cGlxQTNZ?=
 =?utf-8?B?cjIyRGhjcVY1SFBOeUlLRExCNm5CZlViWWRDVW52TUlaZ3Q2VFZNS1JYWTJ5?=
 =?utf-8?B?TW90WCt1eFU3TnZJTVdUTnpmb3BwcHZzeU5rc09JYTZCSDhuSmx5OE1yQUVH?=
 =?utf-8?B?c1NHSjJSM1N3cnRSTHBDTEl0TW42Qng3Um1zbXpVeDQ3L1VSL0pSam1iMzlj?=
 =?utf-8?B?MkdwWW5FeUQ4T0dVcUtXNXM1VjlJRVpyRGdXdlVJNVNNdkRvRUVvS2VJQ2dF?=
 =?utf-8?B?VEhwaFBoUmVWN3luL3Jac3VGb05yWGYvOXlWaGtVSzNUcDJuOFNwaUZ6eHdt?=
 =?utf-8?B?dkdiSzlzMi9tZTQ3K1JBR25GU0gxcUN2VG5XOVYwOXB2bjVrUndZOEJDWEN2?=
 =?utf-8?B?T1ZQSzNyY3NqMTZYTG8vNnBubnQxKzY5TnNmanAyVHZ2ZGRFcXVmZEZRWHNo?=
 =?utf-8?B?Ri9hMlphbmhSQnM3SW5pcFJZcHRkc1ZyVUI5Ly9KV0JCU0dreTN1WFF4V0Vn?=
 =?utf-8?B?WnJMZFNvYXhCK3BHciswaGQyR1lBYjVrQlVSMnNNN3pGTmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDRBcGxZRVdqbVM2djhFMlVkTTdpa0Rtbm1RRHByckR4RUNWaVVvVlYxOVdx?=
 =?utf-8?B?cFpjek5QRlF1TFhyclA0M1B4bFd6dHpLL29DSi83YzNnVDVLVElGYkEvT0g5?=
 =?utf-8?B?UkVRUnhyZ2RrVzNpT1ZYT1BBZXZTU0twS0I4M2FNRVNNdHZEYS9BVDRxb1Zo?=
 =?utf-8?B?MmtYb3E0azdFcFVhTFJOaW1xY3k5WEMwRGxUK0lweDlnYVBiZU9GYUkydHlB?=
 =?utf-8?B?Q0NuN293QkR0TE9VckpBWS9XRkZQTk9vZFlCU2ZUNUNnOFBncFZjTWdCVk03?=
 =?utf-8?B?Szl2ZWQ3RHl3SGhqc0pjcXpMeXpmWmVXMWdUQVFwTzZVQnZKVU1wZXYxNlpW?=
 =?utf-8?B?eDVmKytlb2VLQTFLVHBBM3JsZmg3dFBPV2V1Qk5YVEVKR2tMWlRjU1NPdE0w?=
 =?utf-8?B?TUtLS1hFelFaWEptMTNrV3BkbUtGc1I5Mjk5OCt0eTFhMnBZcDFtRGo0eXp3?=
 =?utf-8?B?ZDVwczArUnlGNzJQSERkS2loYlAwb3Z3bXp4MVI4OW1qU0lVaWpncWRrUUY0?=
 =?utf-8?B?LzJIMGNGcjV3eUxTRnE1V0R0QkxrcDVHVDAxT0V6WWZUVEF0OXdaV29nTEFF?=
 =?utf-8?B?UUhFVWZ0L1Z0YnQ5a2xoQy80TXhyVkZld1RBUlNVRUJwN0tlRElyeTB4RTVi?=
 =?utf-8?B?V21qWmRQZ1ByQVl6MUhZVkVHb0NFM2I4QklGWU1SMm40ZTdJTFQ3TDByT3lv?=
 =?utf-8?B?NEs4bHN2ZVNLbFJIVUdjanRoSDNaaUFBSHFFUE51N3RNYjFuVUpxYUJ4Y2Mv?=
 =?utf-8?B?MEViazdIRlZlVkR5K210Ukw4czUybkY2ZjhOVGZRNDE4dDBDa1JYTlFrSjl1?=
 =?utf-8?B?enpReUJBR1VzWGx2VWZvM01jTWRpQXVaaGhGUGV4eTNkVW9uWVovamRORDFM?=
 =?utf-8?B?dFZyS0tZWTd5UFZKS0RSclhacmVVTy94b1BINkhWQVVBNmJibjZ2N3RTbkNx?=
 =?utf-8?B?MWpoVWxWTlcvZk9rS2pUMTEwdkFPRXU0K3ZSaklXRWdrMlRJa2haa2g4T1VJ?=
 =?utf-8?B?dGhjWjREdVFKVU11cTFnL3pkUnIwRTRlREQ2ZUNDVjBvWjNEbGxtcGpFa0ti?=
 =?utf-8?B?eVE0blRzKzFWaEhMUmhPeElmTkJlSUtPUnZVSGMwaE1WK29wdEhBRkFveDVI?=
 =?utf-8?B?eUlxcGdRVzJwL2xmclp4aFEyMHB4U3hhSThnYnUvd0I3Nm5yb09jZUsrRVZR?=
 =?utf-8?B?cWx2WTVCQUozTUVZNzZoVGp0OUpzZW9aUXhTU3hlVU1CN3hiWUlLbUZrYlkz?=
 =?utf-8?B?WGVhWlA0a1BBc1NzU1pCQmh0Tk03azc1Q2wwZWFTMzJnT25mRmRQWVJkUzF1?=
 =?utf-8?B?d2lIOFBzQWdpck9MOEo1OHFaaE5DdnFkMzBpWGZTUVg3RmYyRS93VG91Rmcr?=
 =?utf-8?B?WHFTVVRTWW5BUktIY2VGU2NOYmlyYXhDeksyeStoZk1adGtiMG80dzBQWGxM?=
 =?utf-8?B?cUlLWVpFai90OHVIZS9wRG9FRFJOdzVpYVgrcWl0OS9qYThuUWJqdkpLRE9Z?=
 =?utf-8?B?aE9EblNESXhkTVRlRjczTzNqaEswekloOEhRcVhWK2JPTEFISkpwd2hwQkpK?=
 =?utf-8?B?dUpyc0g5SmRDeWpoemtVc2tocVpkWGd2K2xDY3hBV1dWTkd0NUh3UXdGR2Ft?=
 =?utf-8?B?d2xpQmNMYXhycStSTGpSSnRnOVRaRHhWSk44WFlIZlRXQUNjNkpMR00xWFly?=
 =?utf-8?B?V2Q3N3Vnb3ZyM0duUnZnNFlKNFZCNlVkY1NTdDF0YzVNZzVWeGV1Q09OWFJT?=
 =?utf-8?B?cW5TVmczSm82aEdCVWI4RWJydFJTNFhkZGhHenhrb2RSa2tQMTJiVnVhOHVq?=
 =?utf-8?B?aU9qVGV6aTJFdzJ1WDZLV2Mvb0Y1NWNoeHZqb2JaNytacXQ3QnZwbG85a0Jq?=
 =?utf-8?B?WnFGN2d1N0dLTmZxNHZHZjI5cURwUDRNN0tCSUFxdHdaYlRDNXBubmdaS085?=
 =?utf-8?B?Vzc4b096Z3hORzVveUIrY2NtbnpvUzZkNDBONnJqNmgxUi85UFNnc0loUzJ4?=
 =?utf-8?B?L0JIdXVkK0RFL3cvSDczQjVSa3BOcnJOZENNMHB6Zm9DNjkraTN1THhHRysx?=
 =?utf-8?B?S1JDcDhrNXN6UXprQ0ZEd0J2ay9WQnUvRGlhNmVTNGJ5NlNIQmttb2t1ajFw?=
 =?utf-8?B?bTQ5Nkdpa1R0N09mSjFEeXZhVUV5RVF4cTV0UWpXRXE0YW9GUGxRUkVUMTlx?=
 =?utf-8?B?aDhrcFZmUnJKMGtJUEE2R2l0SkhLMEdXV0ZjbjE3ZVJZbUJaNW1nN01JOFo5?=
 =?utf-8?B?UTFTSnlBT1lmdjJweUlNakpnNDFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913828F192C2A547AC0C19F5758C33F1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CJUX4Do29Byp8t2xeXjbMV9HwtcULfTRnQHeKYWDzOBM9qicU+YBAtiSudkNtPJLPuP/dYss/aLwl4Y04sbzu8QhMMi9BKvcu53CL6pQvL/i7E/0mR3wFKPtGT7HlssBjuPgIcwun5cP96N8znDJh+EZRy2mA3NFc9cxEHDVWq5+DOXJGjTRC/b2FSu+RGM0Ut1J5tBKKhZUqWBPv7FHeFxh+h96gK2SORLcMRLHvOg2ccFN6azB3P+dIfHR21sO7EJ/0WvzntTU/qShZ4BH6WhL4IngS7S4M4eSkiotikn8Bo0X/suqKjHeUIOSKZzrUH2J18Fj8Pi0jofunCkLRU3zNH9bFOHcm9MxudoucOd0ig4fttUoZGm0m2pJ7TDSX4M/HtWTFciwKnw2faDH9qGBbdpSS5FykIVP8i7BP8ZZ3COp1/JBAmv9kpRk2bqvsJtZLMiLI5FPEehzZuaZLS9zW6HBbCG2ah1PIwiENWiBdtYn4mRYEkziM8YIGpg+epL7YqWYQfSIoUtoaAYJT74g2OEMhuep0/Jrm7gc0WGhdTVC7C8RlyXcKIjiVeGoDAWFgXGmda0ubaeeaKTOghrcDmGaMCALFyCHm8BmznyQgGGeu0P1KTlyoKrHJ//z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120c9e76-55b5-41f2-5bd3-08dcb5e21c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:36:32.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQIUP1gTZHiNODAoyBKW44hqhZgwYmqgLPFzZ7LP2gtOUfrezkREcsM5kEwXCwYjjkA8WwlyemImNSzahuTwt55x+Ftd8eCX1HpyJ670uyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7466

T24gU2F0LCAyMDI0LTA2LTE1IGF0IDE1OjA1ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IE9uIEZyaSwgSnVuIDE0LCAyMDI0IGF0IDEwOjEyOjQzQU0gKzEwMDAsIEFsaXN0YWlyIEZyYW5j
aXMgd3JvdGU6DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZG9lLmMNCj4gPiArKysgYi9kcml2ZXJz
L3BjaS9kb2UuYw0KPiBbLi4uXQ0KPiA+ICsjaWZkZWYgQ09ORklHX1NZU0ZTDQo+ID4gK3N0YXRp
YyBzc2l6ZV90IGRvZV9kaXNjb3Zlcnlfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJ
CQnCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiArCQkJCcKgIGNoYXIgKmJ1
ZikNCj4gPiArew0KPiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiMDAwMTowMFxuIik7DQo+
ID4gK30NCj4gPiArREVWSUNFX0FUVFJfUk8oZG9lX2Rpc2NvdmVyeSk7DQo+IA0KPiBJZiB5b3Ug
d2FudCB0byB1c2UgIjAwMDE6MDAiIGFzIGZpbGVuYW1lIGJ1dCBjYW4ndCBiZWNhdXNlDQo+ICIw
MDAxOjAwX3Nob3coKSIgd291bGQgbm90IGJlIGEgdmFsaWQgZnVuY3Rpb24gbmFtZSBpbiBDLA0K
PiBJIHRoaW5rIHRoZXJlJ3Mgbm8gaGFybSBpbiBtYW51YWxseSBleHBhbmRpbmcgdGhlIG1hY3Jv
IHRvOg0KPiANCj4gc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgZGV2X2F0dHJfZG9lX2Rpc2NvdmVy
eSA9IFwNCj4gCV9fQVRUUigwMDAxOjAwLCAwNDQ0LCBwY2lfZG9lX3N5c2ZzX2ZlYXR1cmVfc2hv
dywgTlVMTCk7DQo+IA0KPiBUaGF0IGFsc28gYXZvaWRzIHRoZSBuZWVkIHRvIGhhdmUgYW4gZXh0
cmEgZG9lX2Rpc2NvdmVyeV9zaG93KCkNCj4gZnVuY3Rpb24uDQo+IA0KPiBJbnR1aXRpdmVseSwg
d2hlbiBJIHNhdyB0aGVyZSdzIGEgImRvZV9kaXNjb3ZlcnkiIGF0dHJpYnV0ZSwNCj4gbXkgZmly
c3QgdGhvdWdodCB3YXM6ICJPaCBtYXliZSBJIG5lZWQgdG8gd3JpdGUgc29tZXRoaW5nIHRoZXJl
DQo+IHRvIChyZS0paW5pdGlhdGUgRE9FIGRpc2NvdmVyeT8iDQoNCkkgcHJlZmVyIHRoZSBgZG9l
X2Rpc2NvdmVyeWAgYXMgaXQncyBjbGVhciB3aGF0IHRoZSBwcm90b2NvbCBpcywgYnV0IGlmDQpp
dCdzIHByZWZlcnJlZCBJIGNhbiBjaGFuZ2UgaXQgdG8gYDAwMDE6MDBgDQoNCkFsaXN0YWlyDQoN
Cj4gDQo+IA0KPiA+ICtzdGF0aWMgdW1vZGVfdCBwY2lfZG9lX2ZlYXR1cmVzX3N5c2ZzX2F0dHJf
dmlzaWJsZShzdHJ1Y3Qga29iamVjdA0KPiA+ICprb2JqLA0KPiA+ICsJCQkJCQnCoMKgIHN0cnVj
dA0KPiA+IGF0dHJpYnV0ZSAqYSwgaW50IG4pDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwY2lfZGV2
ICpwZGV2ID0gdG9fcGNpX2Rldihrb2JqX3RvX2Rldihrb2JqKSk7DQo+ID4gKwlzdHJ1Y3QgcGNp
X2RvZV9tYiAqZG9lX21iOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBpbmRleCwgajsNCj4gPiArCXVu
c2lnbmVkIGxvbmcgdmlkLCB0eXBlOw0KPiA+ICsJdm9pZCAqZW50cnk7DQo+ID4gKw0KPiA+ICsJ
eGFfZm9yX2VhY2goJnBkZXYtPmRvZV9tYnMsIGluZGV4LCBkb2VfbWIpIHsNCj4gPiArCQl4YV9m
b3JfZWFjaCgmZG9lX21iLT5mZWF0cywgaiwgZW50cnkpIHsNCj4gPiArCQkJdmlkID0geGFfdG9f
dmFsdWUoZW50cnkpID4+IDg7DQo+ID4gKwkJCXR5cGUgPSB4YV90b192YWx1ZShlbnRyeSkgJiAw
eEZGOw0KPiA+ICsNCj4gPiArCQkJaWYgKHZpZCA9PSAweDAxICYmIHR5cGUgPT0gMHgwMCkgew0K
PiANCj4gV2hlcmV2ZXIgcG9zc2libGUsIFBDSV9WRU5ET1JfSURfUENJX1NJRyBhbmQNCj4gUENJ
X0RPRV9QUk9UT0NPTF9ESVNDT1ZFUlkNCj4gbWFjcm9zIHNob3VsZCBiZSB1c2VkIGluIGxpZXUg
b2YgMHgwMDAxIGFuZCAweDAwLg0KPiANCj4gPiArCQkJCS8qDQo+ID4gKwkJCQkgKiBUaGlzIGlz
IHRoZSBET0UgZGlzY292ZXJ5DQo+ID4gcHJvdG9jb2wNCj4gPiArCQkJCSAqIEV2ZXJ5IERPRSBp
bnN0YW5jZSBtdXN0IHN1cHBvcnQNCj4gPiB0aGlzLCBzbyB3ZQ0KPiA+ICsJCQkJICogZ2l2ZSBp
dCBhIHVzZWZ1bCBuYW1lLg0KPiA+ICsJCQkJICovDQo+ID4gKwkJCQlyZXR1cm4gYS0+bW9kZTsN
Cj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiANCj4gSSBhZ3JlZSB3aXRoIEpvbmF0aGFuIHRoYXQgYXQgZmlyc3QgZ2xhbmNlIG9u
ZSB3b3VsZCBhc3N1bWUgdGhhdA0KPiB0aGlzIGZ1bmN0aW9uIGp1c3QgYWx3YXlzIHJldHVybnMg
YS0+bW9kZS4NCj4gDQo+IA0KPiA+ICtzdGF0aWMgYm9vbCBwY2lfZG9lX2ZlYXR1cmVzX3N5c2Zz
X2dyb3VwX3Zpc2libGUoc3RydWN0IGtvYmplY3QNCj4gPiAqa29iaikNCj4gPiArew0KPiA+ICsJ
c3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGtvYmpfdG9fZGV2KGtvYmopKTsNCj4g
PiArCXN0cnVjdCBwY2lfZG9lX21iICpkb2VfbWI7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGluZGV4
Ow0KPiA+ICsNCj4gPiArCXhhX2Zvcl9lYWNoKCZwZGV2LT5kb2VfbWJzLCBpbmRleCwgZG9lX21i
KSB7DQo+ID4gKwkJaWYgKCF4YV9lbXB0eSgmZG9lX21iLT5mZWF0cykpDQo+ID4gKwkJCXJldHVy
biB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBmYWxzZTsNCj4gDQo+IFNvIGlu
IHByaW5jaXBsZSwgZG9lX21iLT5mZWF0cyBzaG91bGQgbmV2ZXIgYmUgZW1wdHkgYmVjYXVzZSB0
aGUNCj4gZGlzY292ZXJ5IHByb3RvY29sIGlzIGFsd2F5cyBzdXBwb3J0ZWQsIHJpZ2h0P8KgIFdv
dWxkbid0IGl0IHRoZW4NCj4gc3VmZmljZSB0byBqdXN0IGNoZWNrIGZvcjoNCj4gDQo+ICsJaWYg
KCF4YV9lbXB0eSgmcGRldi0+ZG9lX21icykpDQo+ICsJCXJldHVybiB0cnVlOw0KPiANCj4gT3Ig
YWx0ZXJuYXRpdmVseToNCj4gDQo+ICsJcmV0dXJuICF4YV9lbXB0eSgmcGRldi0+ZG9lX21icyk7
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBMdWthcw0KDQo=


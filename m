Return-Path: <linux-pci+bounces-20733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA2A289BC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 12:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EEC3A7B2B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A83821CA0B;
	Wed,  5 Feb 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjlf68gO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EED151985;
	Wed,  5 Feb 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756438; cv=fail; b=r9MdJdWmY6TmpIkyFQ3So+rtwEdwIJZrPd0JSoK0ieNN9hTnKHM/0zyMQ810fkAnVaWdDwKahMV+KNLg0Y16F3uu47N5R5ZFW9jR7xfEBmiojOzWQch0xOLVNlZOUK8KnYL1b7FWq3QFsTzxi2e2FfxGyFrxErDzBLM8NgdWJJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756438; c=relaxed/simple;
	bh=OGVYIs1fKH0jsmemCenPZk1XevC7hhx5IN8n9QHx/OU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g9XlHOx0wpaI44r/BUi/M816Bx0tK9Ab8FC6bzLiqbjTfcqI8F16+CM1AFfRDI8VHOltIcaUKydbpATmRgOkpoVnvrqScM1J40K30nusvWZqRentx1bKaVci9fNFSZqbu7MpS29BZQaXVK8RwOw+aL5ZPcU1KLzZT4ArAynu+DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjlf68gO; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHzFTut8jWav4zyl5B8kUUYmSboKV+0t7XJGPW5BrlZFgwL/eyk4dFpgKCeYH0k1rw57hF2mwODF3ebCrPklyrN0UTinJSF99shwWbVfqP8B5IB0kqDSWQDlsB1V3C9LGKdX2cds8T+PuOYYaHUEYQ8WT6Wzdx9TxpqYLbKQTdntPBAZ717kSnyi1aPEHnj4P5/qiZdGhQa14fgjiAQYAvUcuOVwn4TWpBvkHoAIcNhDuKVstMgXDnvQmkHPFupt44Hf4Rg1FY/88W7KicSdB/mpzP+nI/mT3KLAVej6jpZ0cDF0Spz1mx2Zm9bFFNysKzYEOuXGz+y38GVGx5zGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T56C8xtVQWd00gL5s88pw0KNFSX7pNTbNrt12XVNJOU=;
 b=ksPJDVx27K6VPV5YCpRAynnYYYQw0f8zMShxBqM/57Uk3CPt+29XmatkSXe5hyY0aqnqRqTY8xxR6Gr44kp9h66F5AF92G+udTuUHNlP/MGBwhbbsGl86ukjZBkEEQ0ltw3ezy0+CSGgNBggqpOYxZXcytretTolfGNwYwBcp2v1yxdXzdRj8ArXma7cBEcnisBkPFTFhRWlOyLQiQp9petZuf5z7ODQ6lVKHlb+94rY3RTCAA7OD7l059KFwdXKw257GHTT9PHTmHIeRZhwBA4igTcxYmr0Jw/SSxBKAbkN++3eTAzK5RKgy6TOAn+fQxoOEgHloBmyFRx2+Nfqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T56C8xtVQWd00gL5s88pw0KNFSX7pNTbNrt12XVNJOU=;
 b=vjlf68gOCdlpMyWHXI2egz89Z+rbYMGweyVVs8nYbh4egdsd/+LgmHGm+b6WXu81yuByADQkV5cG1q55WBtnTBp1DalvX/xs+NBDurJrYToheiMcGVvXB4fVyJGLdb2/7Ukr8mnC9ZqOT1K069xOgDfMCWYNpmU5T0/K4j9Jyhc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 11:53:54 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 11:53:54 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbckFGnEXox34FgUW7RyRWX+Tmz7M17kwAgAD2/bCAANnSgIAA4JSwgAAEO5A=
Date: Wed, 5 Feb 2025 11:53:53 +0000
Message-ID:
 <SN7PR12MB720115611148E80D555A1A1E8BF72@SN7PR12MB7201.namprd12.prod.outlook.com>
References:
 <SN7PR12MB7201EAC37631E10EBA5A299B8BF42@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20250204221159.GA863758@bhelgaas>
 <SN7PR12MB7201964B87531066CCAA22668BF72@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To:
 <SN7PR12MB7201964B87531066CCAA22668BF72@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA1PR12MB6725:EE_
x-ms-office365-filtering-correlation-id: 552ba0a5-47c8-4c77-e111-08dd45dbc3af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RgGuNJzmxrB8NT/kB7QpMsFkm661WsrnxIXIXM/6EXi8XK3pIOKQzmlpkI+T?=
 =?us-ascii?Q?o/V+yKjQwWqPzvhKAY4QMI4EymoWXrqte1x4J0qBm0WdrB5ZcRJl2VApsVVI?=
 =?us-ascii?Q?AXm5GzfrAX5e3LJPw7YwQU+B7udfo4pvv8SLP3xtZP3FBxZ71EH69D+7D1CX?=
 =?us-ascii?Q?+JXJx0GejENE4ixo+LxX/Xm/beZFLPYXRI/33N+kUNszrN3AgedfBomu61tY?=
 =?us-ascii?Q?0+7yEsnpS+eetHMQEyuqAtyLr8MHw50YwaqpPAKMm2/jx2fC0tNKqw6rmGjh?=
 =?us-ascii?Q?aPAJtMAgvXFkCYhBuRI9r2m567LJDwEB9pDkni2s24/E2Ypg0g4v/01qhzB/?=
 =?us-ascii?Q?3x7odNWss5/mym7ZxLXYh12S+wjERBQAdCQxLJLfWsOeT2D87LujoZoAaf/i?=
 =?us-ascii?Q?9iPSram/8ECjL8lvjs3c1Oq2Y5yHwH5riMiHQscuTe6shMUh//FhAhOyx9RC?=
 =?us-ascii?Q?oVOjvtswy3sOqAtWNNpzoJPs8QXWw7F8C3Kxj++fYpAydQ2CI1Z3WpnrHGU0?=
 =?us-ascii?Q?E442FtA+HdCWBpYx2qg/BrBKNCMt7VAaxyqUcptss4LQPIrQ2868mw5ImVg3?=
 =?us-ascii?Q?MNMDxAHX0BBO5yf9+cUCK3UASxfOV7dJg6aMkP+gngb+TKIrs+YIYMkYbaAV?=
 =?us-ascii?Q?pMGZkoRvRn7hzev+9cTgizNoGj5y4XqAdHMV56sNanKoXq7darUGgwXti6gX?=
 =?us-ascii?Q?CWGSz4f8Dkubkln101atJUPSmMgb82zy/G23IuVEXkrCKyIdNxFOLPP/a9M6?=
 =?us-ascii?Q?K6v5rjeHTCmHxEp7/q7Y9xGup0jGMvkUObjMtxK+cvEkiZ2AeqN9HspiqOQl?=
 =?us-ascii?Q?yL6m//YoBlIe5PRCxRuygRHovrTpzDX1r9j8Njo2txtQPLLuevu3zxuxPIsw?=
 =?us-ascii?Q?ELQQhEBJjFSJ3UQhlm0J7/MN9ptJ9/+9MSVVl/yg/DUBuZMVpLE4DYz26zDd?=
 =?us-ascii?Q?eq9dAntCEMhwWZB+yGXaueeO2J8Bx3/jc+l0Cd1gZOCpHeAIVOOqXnNmwvH+?=
 =?us-ascii?Q?HCejdz5e5xiAoyU5RNilEy5FXu755KDU/GF11B4TtipLG7VdTybVkWf2Evv9?=
 =?us-ascii?Q?ThLylxvQoC+3pKXnH9NJqaYqzCTUNXWZnGKgbtdt0Qbql7GlfjH+gLTJNLr4?=
 =?us-ascii?Q?TJU6HYXYnGM7Dz3fsqBaFLFnYSSh1IypmtgcMktYuhVgHhTAtEFRcm9Kc1Yq?=
 =?us-ascii?Q?hgJUXiFWDkT0TGrDinJRapA7NqlQ2Oofwb+m/RSq65M9dTbK8Urt0d3S/gAh?=
 =?us-ascii?Q?H2lYN8uNdswK6mK1yWmThjIRZOz/b1mMwNjPnwl1DyaGTvagYnr6y2UrGkf4?=
 =?us-ascii?Q?NCCeor6tfVo0ucB30ZTO6CC2NVRUT/daghDxzYX5dF2Y4Wk6tBS4wHXk50Yx?=
 =?us-ascii?Q?qe+SNQTV1hhv46nYGGYuUj16srARgmLdOmGGKhQ44B41lj40yIHasVwHxeLT?=
 =?us-ascii?Q?jJb0oi27IiLC/QpJaCOayFTtZEd3uGdV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LFS6u7rjv8qRUGYR3XJGR1UCvMGap6KTRmLuZrdlQZeDAAYPaH8kBF0Lg6hY?=
 =?us-ascii?Q?ct+f111p9ncFi8kk8gOC6jeGyXrZp6zP4/x2QRITTw+nmjr+tGEUGUjmFCnJ?=
 =?us-ascii?Q?SCLl00EyZ0YRvkxjW9bkJF4Afb3BgRAsT7cckieGEPQ/vSCKVRYV8hX174HO?=
 =?us-ascii?Q?UxMHh24njq9rQ+ZLwBAwrDcy1mvBph9QH+V7taftwEMP+nr323ame3rKKEK1?=
 =?us-ascii?Q?eNNsr51rHa/xbnCilTiW5sxlT9n18meRa4ZXVPsOupuFu5lK8x8uCtdHQ9y6?=
 =?us-ascii?Q?Kqu0HzbvmFL32eLAnHleo5ItMyAFDeMipYyGDBvub2trCHEw5+b6SpkdJIAB?=
 =?us-ascii?Q?5Y4DZCOFg0WJmXKgfuRbiwcydmA9aI1A+TaIjHsSc4SDpg20YAVHASIDH6nw?=
 =?us-ascii?Q?EuWlj1I7kZVMLxoqy5JJaUrriIDmqxghw6Bp9QSct64v60KKbu3+QmAauh+q?=
 =?us-ascii?Q?EKgNDi7CxZtzSAPp0JIxPkJh4f0OHlDrbLFdkWbvf0eyd22lEhJDC5c/mQvC?=
 =?us-ascii?Q?ksExfAyBVD7XmL35Ktdc2mudbPEHRWANv0m/a0gHfryvGfIEk6CnIsXbQGOB?=
 =?us-ascii?Q?j4plZPCWPTKRORmXXRHwy+jXJLbcNp33SiDMxJkWMQqRdB6oqt1fTZceKvI5?=
 =?us-ascii?Q?xYL4Qme/w/VN3vSTM15+UZFMznHpK/vqeJdnV7wKN4dQ6a2kf7cFR6sn07Yp?=
 =?us-ascii?Q?xlnnaH/Ktn60jtVcO2Vtar2m3fv9ZDzGQby62yKxAQgMHBMMylmZ2A6bO/4B?=
 =?us-ascii?Q?2Htkr3xLCvpJsg6RxYYDVKNJuvyMf3vVrUK8GS7fUbr1tjKiXEnXjoDkAUup?=
 =?us-ascii?Q?gqqzvvwjT4DV7RtdQMv5A7LkOni6EVs9hc5N5uC1nXzLwryLy2BAlY2ppD7M?=
 =?us-ascii?Q?t1r9736vNVbXEkqhchTTMjiirnMU7TAKuZn9XisoQLIJIP9TLZJKlNezLnmj?=
 =?us-ascii?Q?/gMTRJf50xfYSpqMXQzq+3zfljwicCBqV6+ZzeZHQQMEwEd34CruTEoX+hab?=
 =?us-ascii?Q?QHROQtbvzBWbXL3rOIHuPRjAF16jKeWbyGEiW9c+spjC344Dd8o4RrGH8tzn?=
 =?us-ascii?Q?yhSe2byy9AF+o7EhsKU00G03+F1JdZL3+TJpFwURXMMqzODLfnHkz3hcDmnR?=
 =?us-ascii?Q?3IHY9vXYUv7+sryztH/41uStdObnMoaRZaKCaryfYnllcDkiLCYXBqiQYLJe?=
 =?us-ascii?Q?CGLdo4okA/YZT02YJDzo18RDLYuwKF+a0Ng5nRXVVM/uF5GRrkZi7WradPpT?=
 =?us-ascii?Q?YM4kyeAZvIvUFRkzoZUuM7F8QuioJ8kob33ltxnWyosEiULadxb1hYzad1Jj?=
 =?us-ascii?Q?KBJYOTfEXlW38tno5xXOJ6M87qvGzRu0r1dj4U5dd5rppFDcke6rmJGa4GKO?=
 =?us-ascii?Q?H5Xf4ZNVFikiW7nyLnU5PeBDuPpaEDJNyaUT8AeKMZfWx0S7BESJDQhPg0rq?=
 =?us-ascii?Q?9PqpAIpnFSwsuFw4rf6LxUIa8pWobhoXjl6S8dDalRWUDycynbUR64sSsR6j?=
 =?us-ascii?Q?fMoG4o/uv61IMzn/otOGk3Ay7XBrw/H314ozPGPwsM+D5SDCeMxEI0LEsUsW?=
 =?us-ascii?Q?AdZvGS/j3+LLrpAAztQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552ba0a5-47c8-4c77-e111-08dd45dbc3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 11:53:53.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuLGugCK6Re/sYXNXKvti3bTDhZhq8bb6A57WDGoSyb/y7GpKgRFk3MMzY30vePrXYA5gNOgUQ84ahu6UZaTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725

Hi Bjorn,

> -----Original Message-----
> From: Havalige, Thippeswamy
> Sent: Wednesday, February 5, 2025 5:08 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
> Hi Bjorn,
> > > > It's kind of weird that these skip the odd-numbered bits, since
> > > > dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> > > > amd_mdb_unmask_intx_irq() only use bits 19:16.  Something seems
> > > > wrong and needs either a fix or a comment about why this is the way=
 it
> is.
> > >
> > > ... the odd bits are meant for deasserting inta, intb intc & intd I
> > > ll include this in my next patch
> >
> > > > > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > > > > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > > > > +	(						\
> > > > > +		IMR(CMPL_TIMEOUT)	|		\
> > > > > +		IMR(INTA_ASSERT)	|		\
> > > > > +		IMR(INTB_ASSERT)	|		\
> > > > > +		IMR(INTC_ASSERT)	|		\
> > > > > +		IMR(INTD_ASSERT)	|		\
> > > > > +		IMR(PM_PME_RCVD)	|		\
> > > > > +		IMR(PME_TO_ACK_RCVD)	|		\
> > > > > +		IMR(MISC_CORRECTABLE)	|		\
> > > > > +		IMR(NONFATAL)		|		\
> > > > > +		IMR(FATAL)				\
> > > > > +	)
> > > > > +
> > > > > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > > >
> > > > I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just use
> > > > AMD_MDB_TLP_PCIE_INTX_MASK in the
> > AMD_MDB_PCIE_IMR_ALL_MASK
> > > > definition.
> > > >
> > > > If there are really eight bits of INTx-related things here for the
> > > > four INTx interrupts, I think you should make two #defines to
> > > > separate them out.
> >
> > > Yes, there are 8 intx related bits I ll define them in my next patch.
> > > I was in confusion here regarding "PCI_NUM_INTX " since this macro
> > > indicates INTA INTB INTC INTD bits so I discarded deassert bits here.
> >
> > It seems like what you have is a single 8-bit field that contains both
> > assert and deassert info, interspersed.  GENMASK()/FIELD_GET() isn't
> > enough to really separate them.  Maybe you can do something like this:
> >
> >   #define AMD_MDB_TLP_PCIE_INTX_MASK          GENMASK(23, 16)
> >
> >   #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(1 << x)
> >
> > If you don't need the deassert bits, a comment would be useful, but
> > there's no point in adding a #define for them.  If you do need them, ma=
ybe
> this:
> >
> >   #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((1 << x) + 1)
> >
> > > > > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args) {
> > > > > +	struct amd_mdb_pcie *pcie =3D args;
> > > > > +	unsigned long val;
> > > > > +	int i;
> > > > > +
> > > > > +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > > > +			pcie_read(pcie,
> AMD_MDB_TLP_IR_STATUS_MISC));
> > > > > +
> > > > > +	for_each_set_bit(i, &val, 4)
> > > >
> > > >   for_each_set_bit(..., PCI_NUM_INTX)
> >
> > > In next patch I will update value to 8 here.
> >
> > And here you could do:
> >
> >   val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> >                   pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> >
> >   for (i =3D 0; i < PCI_NUM_INTX; i++) {
> >     if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> - Thanks for reviewing, This condition never met observing zero here.
To satisfy this condition need to modify macros as following.
#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x)
#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)    BIT(x+1)

> >       generic_handle_domain_irq(pcie->intx_domain, i);
> >
> > > > > +		generic_handle_domain_irq(pcie->intx_domain, i);
> >
> > > > > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > > > > +	if (intr_cause[d->hwirq].str)
> > > > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > > > > +	else
> > > > > +		dev_warn_once(dev, "Unknown IRQ %ld\n", d-
> >hwirq);
> > > >
> > > > What's the point of an interrupt handler that only logs it?
> > >
> > > At this stage, our objective is to notify the user of the occurrence
> > > of an event. While we intend to integrate these events with the AER
> > > subsystem in the future, for the time being, we will limit the
> > > functionality to notifying the user.
> >
> > OK, just add a comment to that effect here.
> - Thanks for reviewing, will add this in next patch.
> >
> > Bjorn


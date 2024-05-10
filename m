Return-Path: <linux-pci+bounces-7337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC218C21CC
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCC81C20BB2
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7B16C43E;
	Fri, 10 May 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JJQplDlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C8165FA9;
	Fri, 10 May 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336036; cv=fail; b=Ligx3zMgD72d/g7zAFjxrLKh6nt07ZTZRnSB6lwxGPEZdhl+5YMxSopr2CJnIzM8NtTuf/b5rHxMn34nY4vH9xOne3DCWyMDJ+TOQRwGuMuBQLQfSdh6SQG+ATPDFya94DNDzRlLMjt5xAostozlXTNYbhwFSO7/zBUsknBRU24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336036; c=relaxed/simple;
	bh=fE1xWl7iYKuUfNNEOxMllWLYvD3ACCLq5DbAXgM4d+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVOSmoG8ebtkUiEfny2y6hIfZplWtjVFDjR0NQ87CRYBMEsAD7lgNaTRwrAZ51gWSSP3XNyV4QrQD19ZyMloLQeopvB3XdkAFkhUoi97CTcMvac+QZm/j5iMJ9OFfmEcbifs7tUxk0KHMuq8+fquO2b4AZNRMQb/8hx51LP4KM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JJQplDlx; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWnSJgCYVW65VrBuxTED7HnZOEdGgnvU7RmLEjpiBvIsDqOXix1Sgx3gUlfUHWQKIdDKlUfLrdWa5GuvvzyBPa+v12RceFE7uTxzv5REkS0IRdNy5qQk6u1XH1MCyMRq/rszg5xL9gWkOTqdcH8iVWSgL6cZJWR91yXgNbsLNeDLjP+Z5iTP+0mIwCoORaEBdw6GBdwwgrTws+XFhO97Hvd1jHwyfZmgo7fTFvofBm145c7p8UKT4rboQFx/rVb+oFy09KJq78wvIQPPz3yZ20bWSzkQkTXeZOtxUHIhlqk80IbEQxRHtTCL1GDwfRFyRWsRT161JZ/VaAHXp9XNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE1xWl7iYKuUfNNEOxMllWLYvD3ACCLq5DbAXgM4d+I=;
 b=lwPMk7g4shJq9CPQiwPkK1dE6WE2vbshSZt+37w1UkJ2W/7qdDIBifkQ1Phrb7FFi2Ks0r9w1Wh34y5kKFXVp1regreM/Uqig/vyFBW5reS8U1CCrQV46z5/3kH0JOsrQMktKctfQk40R0nLeSUXeMnyAtCEw9tuD+oUiL8P7StZtV8c+aj9nWrQOXr4vQEdFEHKW11EcI2WGshzDuhhayFOuFy6qO6U0y/jk7UBXtSSUvMLfj4ZT3YWiFroGhhoGA0vqO8CteEFW4npIHhqX7oDiVW4u6F0MVoUDXKVLtMInfDsriDpahWNZm/dxYlWdsuA31Bnr3hz52kgHpJbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE1xWl7iYKuUfNNEOxMllWLYvD3ACCLq5DbAXgM4d+I=;
 b=JJQplDlxl4HJwgip2oV0P1hxgboYf9S2Al4MMx8Seo1f5uefDjfbz2ixoKMjVK+5l2UTrvxSE7S18L3R4Xv1Zx4TijDp21BoE59l7D4L7rVMnbQDTtG6+Gt8lNfOxqiXGsI8O69kI5BEGCP4I0VBEy2hMWmaUgmgLc24lgZyLuc=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 10:13:50 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 10:13:50 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
Thread-Topic: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get
 gsi from irq
Thread-Index: AQHakgrPZQMiHHEzE0Gs/TUOGsHh17GQJ2yAgACnAgD//41hgIAAiXAA
Date: Fri, 10 May 2024 10:13:50 +0000
Message-ID:
 <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
In-Reply-To: <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA0PR12MB7579.namprd12.prod.outlook.com
 (15.20.7587.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB6392:EE_
x-ms-office365-filtering-correlation-id: eb5a51df-e362-4be3-b4c9-08dc70d9e382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlRVTCtCRi9tYk5zSm9OU3dGNnNqSUl0NzRGOVF3Q0s2b1pBZkhoZUNuMWxZ?=
 =?utf-8?B?bkYxeHRNQ0lpNUpNa2JGUS9VQkZySWNkbDk0Rk8xQm5URUs0dUFrd1NzamNK?=
 =?utf-8?B?d3JZUlFCbVZHOU1zbmZCeGtMZ1Yyck5BVDljcmVKaGJRVmFqTWxUenJYRmtm?=
 =?utf-8?B?bGdnaFZ4NmVjODM5NlFiYnVaMm1tWXRkQVJObXljeUp1WnVTREwxZVdYRzl2?=
 =?utf-8?B?TGZtNk9xeGJBeWFSQTFHSXdWSE82TnJJM1NIelFXS3pucnBtdVd5R3U5L0tG?=
 =?utf-8?B?QVdQZ1FFelA1QStOdVIwY0U4aGt3Y1p0cGg2Q2V2NUNFRit2N2dJTXhDSzE4?=
 =?utf-8?B?TWdhemUwdkRZekI1SmJxVG1EbDBySkxtWVhnajd3U0toTDVHc1hYaEZ5L1NZ?=
 =?utf-8?B?emxyWWlOTHEwTmxJdEJ2b2REWkptQWhucG9Rd0VHMDd3aUVWTG5VRXE1WXdJ?=
 =?utf-8?B?MGZUdUdjTnFsOHh1akx4QWNLQ3ROemMvN0RZNFVwcjNkRzZiL0RGNmlmZ2w3?=
 =?utf-8?B?UVIwUWRWbnRpUGk5My94V0p6WUFEM1kvUllsUHUvYTRyZzZQenlTY1pzQ05s?=
 =?utf-8?B?bk1GZWJicDR5bjV4NCtlZmNmNEdCLzltYm5MRXV0VmhBcUFPQ1pEU1hKS2FZ?=
 =?utf-8?B?eCs2RnN6MEFzcjlZRlF4bzd1WUpkcmZtTThCNlUwYUtMNlVqRDNkQUVvOGVo?=
 =?utf-8?B?cUYzTVEwa2p5eG1zcjBLOGozdHVqazBlcnZJNUh6R0FpZ2taR25xUktFYUJG?=
 =?utf-8?B?TnpIbFIvL0lOeEQydkJZTDlZblZuTko5UE1oZ3l4RnFuWkFVQnZaSW1Wa1Ba?=
 =?utf-8?B?Q2pWVlVkMlNycExxNTRybklGUkNqZnp3SVBuVjlaV3c1S2hlU0RYR05nZCtt?=
 =?utf-8?B?UktxakhYOWRnWG4wQmxmc2pSTXJFQktURVQ1dmhsOEhDdU5hQlhFWHRNdEsx?=
 =?utf-8?B?RWFYOStycS9jaTlYQnNmUEpkMGtOa2tBME5TOGtrREZTMFNxZUx0c25nelhY?=
 =?utf-8?B?Y0NRN2lCNk14UnNJWjc0Q0xCbTV3SngxRHBrR0trVmM1R05xNHpmMHJLZFFt?=
 =?utf-8?B?bDhwNGJnSCtPcDMxeFcxaVJTZnhXLzJwbGQvZURhQ1BuY21mbzRoSU9IQUVT?=
 =?utf-8?B?K2lhV2hoemV5b3dkR2RQV2lrd2UvRHI0L3ZVaGhhbnplWWlZWjNGMnMwNnRn?=
 =?utf-8?B?WGp3Vm0wV2x6bzViMUsyNXZwQTZ5NXZvN0pybXh1TnpPUXpmNERSMkUrbWpO?=
 =?utf-8?B?NUE2TDhoa3V4QzBHTXF2UFdGeXdWSndBWU1EZkdXWkxkQThOaEI5cHdCUm9V?=
 =?utf-8?B?WXI5THZ0UHRUd0RrVHVMV2RyelgrVk5HMUJIclQ0MzlXMUQ1NDdmTTdLZkNF?=
 =?utf-8?B?ditraTlRejQrellEVnd2QmVOUzFGTzgxajBQSndqYk5FTnFxa2tOYXh1N3Zr?=
 =?utf-8?B?NG1oUG11SmVhWkp4WTNEUTN3b3B0OWpBQ0JJSE5aQ2Q3dHU5Y2szTy9MZmJB?=
 =?utf-8?B?VExsNVRhSEx3b3JqdmprWUk0Zitqa21ScEorMmNsOWxOemhMcFFqbzRiRjdT?=
 =?utf-8?B?RHN1OXhVejh4VXNqWjdPcFdUQlhsbnczUzMyMEw2SjFtQUovTXFSUWpEVndB?=
 =?utf-8?B?amFoaUJWMk9tV3ViQVpEUGRJTVo2OVU0ZmxmVWFWSHdQeUhsWnFzZm83L050?=
 =?utf-8?B?YlQ2ZUJvQmtjWXlhVnFKUWpIVFB6Yy9RbThSUG9QeGhZOW9LN2t2OTNWUmFN?=
 =?utf-8?B?NVlhcFRrcUpaN1ErMWhZQW9yRUg3M1JyQitGdUJkckt6SkZveW1jRjRSU2ZF?=
 =?utf-8?B?OXk1c2FHeGkzeVJETlJwdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2hUMHdOZDlqeThONkpRN0ZucXVJcXBLZ1BVM1BZeXA0RU4xbWJOMElOZXQ0?=
 =?utf-8?B?MVhGMkJIVTQzSDBJcnlxK3lDeHpoMXhPd3lJdU1remRlcHB3ZWhhVlF4QnBY?=
 =?utf-8?B?ODFsV290ZUtTblFjQ1M3eEJFeDROYk1kUE9WVkZTaWJCYUJKMXpXZk9DbVVY?=
 =?utf-8?B?a2FTN3hrSG8zQWlnS3ZlVDlrN3haRVM0ZC9rcDhnbkNZTTEwMGdZNmtjRGh5?=
 =?utf-8?B?cElWbkxmdFBIK05PMEZPcFBCK3pORFIvTTc2cndRZTZ3Q3RQelVxbE9ZbUdP?=
 =?utf-8?B?OGZQTkpTbTZwZkFzc3VVZm0xeGNSeXJQY0hmd3RWTXZvemJRNFVJamtLMkN2?=
 =?utf-8?B?YjdwMWFuTGY4cE1NeHZTbTY2Y1hZbjZiQ3NTMm1LZklWZ3pJcHJ0V0FzSk1B?=
 =?utf-8?B?dk9HRW1CakNVK2VPaDZQMkJTbkkyQW1WMThZL01JR3pZZHZQdmxsNTIvbDV5?=
 =?utf-8?B?N0xsc3BwdW1HdkRsaXREOHYrbWRwakZGSFNZbXowTHptQnhQeXFnOGJVTERT?=
 =?utf-8?B?OTVIYThWd1pVMTR2clI0c2FoaThCdUIxSFRjOXlRQUlNc3VlQ0thVXQvYXFL?=
 =?utf-8?B?RWRGUmV0dWY0bUNOaFNCUlJueGU5TTRaNmJIY0QwM1J5QnN4bDhYSTF3NlZW?=
 =?utf-8?B?UEc1WVlYRVNxZVhKVWJZdis1aDhBUjJ6R255T2dxUDZzanFWTDl6MHpZSTlI?=
 =?utf-8?B?RWhKc00xb1E5cDBqNEtXdEVqYm0ySWdXemdYU2dXZ0ZxT1cxbCtBTW0rTWJi?=
 =?utf-8?B?dXFZZHFhbnpDcmwrejM0Z2x4OVVzRlo5WWZmbUxTQzhxRGZOMFVkSWYzQ3Z2?=
 =?utf-8?B?L2xiMGd6VWRNZlhUUEtKd1dIQzZGeGpwOWVNVnhkNXZ5dnRvQXVzcjZuYUNB?=
 =?utf-8?B?bTJvVUlaU0pLOTlpdUNReHlZVjN6NDVYcUl2dTVXV0l1OEpUcWRMZ0lmMzF4?=
 =?utf-8?B?VmtHQTBXbVVvVTlRV25pclhjeDl6aHc4MVo4bEpmb0dFSnFtMXQxb0VsTmFu?=
 =?utf-8?B?M25VbEdKdGNRcUE1TkQyZm11QXlzM3FCQkNRSXNldUxCNXQweW1oTFpFQkZW?=
 =?utf-8?B?Nk54R25tRDFGYkxmdDFNVDlmeitiVGdKVFlSUkl3d1JPdUpDKzI4SEtkWGdQ?=
 =?utf-8?B?elJTbXcvTWErUC9JNHM3VFAwaW1aQWxFcE1Zd3M0Q2FrWUEzVTM2MGZMVjdT?=
 =?utf-8?B?dnNHaEFWcnZuc0NZTm1mRjNVZTVScUJ5eC9WMTNjZ2VTdkJ4dGEwTkFOTmNz?=
 =?utf-8?B?L2pzaXdHSnozYWZCTXZ3QmFBYXRYUmRXbU02aklyczVOZGtod3ZmNTB0amZn?=
 =?utf-8?B?UjVtbHdKTkJxRVpuaXNmYWd4VXpNQllPWXJYSzVRUXlzNXlvSjFZampsdDBI?=
 =?utf-8?B?d1ZXUjlnaWkvUS9iclk2OGkwVjRBaCtMVWhpelZmc1RYQXVsRjNnQXJFek50?=
 =?utf-8?B?VEJKZldnbW1NWU9PYTFLNW5LUGZhVGF5T1VqYThGV1N0SS84Q2ZUcEoxNWRt?=
 =?utf-8?B?djFMd0R1ZDh1c1BLN01MTnI3Wno4ZTJ6WUdwSlE0WEpydEhjeWw1QjJrdXJk?=
 =?utf-8?B?Um5sYUtqNTV5eHpsQkJwZW94cDJQTERYenBDZ0QvdFdCOHB5NDdETjFvWTQv?=
 =?utf-8?B?UTJtYm01cmkwNm1qczJleUxOM1loR3VEQmFWTVRiMXlOdmpObWlZaGthd1Zx?=
 =?utf-8?B?MFd3RmY2L1JNYXE2U1d6RVUzWUptQ21LQVpRMjdLQll1aUEyS2g3VjV3allk?=
 =?utf-8?B?SUkwaEhIa0IxT2ZldmlWS2xzdlY0MGJOa3ZKbmdUUFBpd0tlaTNncnZDOTA4?=
 =?utf-8?B?S2tqc1RNOVhBOVhBbjFuVXFoUmJLSHRhbVBwZlM1SVdxWEFzendCNjlpWU9n?=
 =?utf-8?B?WERETXNnbjlRbzEyK3kyRnNQd2Q1MkgzYlVhWEptMlpiWUhqRCt0S1N0TDFN?=
 =?utf-8?B?Nks2VnFyT3k5NzBkbG16ZkJhZTEzeXlVam5xck14TDFxTWtIMXJIN3oxeE40?=
 =?utf-8?B?S2p5RVBDZ01RUnFaTkNVZk1vV3JvT3Jqdk1pRmFmdk1nZ0lPU1Q2bSt2amMx?=
 =?utf-8?B?OG16WmFqTGRHbDh4WjV0VVByV3FMTElKcGxDa1hpOUNQbGdMMSsxYTExckFy?=
 =?utf-8?Q?3RzY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C27481B130639B41BBF51FF7DFAF3F19@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a51df-e362-4be3-b4c9-08dc70d9e382
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 10:13:50.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXAkf5tAeRZ8Z3Vw+wUSJl9wUDmqgCndMNtFq0tI3UbzpZyftp0tDuN8DS+I0frQcmFixGOl4qtK7oHek4R6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

T24gMjAyNC81LzEwIDE3OjUzLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPiBPbiAxMC4wNS4yNCAx
MTowNiwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gT24gMjAyNC81LzEwIDE0
OjQ2LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4+IE9uIDE5LjA0LjI0IDA1OjM2LCBKaXFpYW4g
Q2hlbiB3cm90ZToNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIGluZm8tPnR5cGUgPSBJUlFUX1BJUlE7
DQo+PiBJIGFtIGNvbnNpZGVyaW5nIHdoZXRoZXIgSSBuZWVkIHRvIHVzZSBhIG5ldyB0eXBlKGxp
a2UgSVJRVF9HU0kpIGhlcmUgdG8gZGlzdGluZ3Vpc2ggd2l0aCBJUlFUX1BJUlEsIGJlY2F1c2Ug
ZnVuY3Rpb24gcmVzdG9yZV9waXJxcyB3aWxsIHByb2Nlc3MgYWxsIElSUVRfUElSUS4NCj4gDQo+
IHJlc3RvcmVfcGlycXMoKSBhbHJlYWR5IGNvbnNpZGVycyBnc2kgPT0gMCB0byBiZSBub3QgR1NJ
IHJlbGF0ZWQuIElzbid0IHRoaXMNCj4gZW5vdWdoPw0KTm8sIGl0IGlzIG5vdCBlbm91Z2guDQp4
ZW5fcHZoX2FkZF9nc2lfaXJxX21hcCBhZGRzIHRoZSBtYXBwaW5nIG9mIGdzaSBhbmQgaXJxLCBi
dXQgdGhlIHZhbHVlIG9mIGdzaSBpcyBub3QgMCwNCm9uY2UgcmVzdG9yZV9waXJxcyBpcyBjYWxs
ZWQsIGl0IHdpbGwgZG8gUEhZU0RFVk9QX21hcF9waXJxIGZvciB0aGF0IGdzaSwgYnV0IGluIHB2
aCBkb20wLCB3ZSBzaG91bGRuJ3QgZG8gUEhZU0RFVk9QX21hcF9waXJxLg0KDQo+IA0KPiANCj4g
SnVlcmdlbg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K


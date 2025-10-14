Return-Path: <linux-pci+bounces-38049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2EBD944B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BFF42494D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0500312828;
	Tue, 14 Oct 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XpwSAhri";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Jgu0mXdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF2312837;
	Tue, 14 Oct 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443868; cv=fail; b=S6559sTs+m4tFmr265f5L6p4nNp012t8EqUjC6jQG7o5qGZxvQSIdhwA0xOLKwkf5ez/9BlF6VDQLXjBt1GAOy9fOYCcRLhxraZKsM+sVHcGiKcqrSdEVKea0gAeQqUE/HCRQTUHUQIDsaISmf+n1rLYkbH3Zn6VwQEsyhWXlRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443868; c=relaxed/simple;
	bh=6Si9+GMfIoFcnx3arh+R0VKf3Fap+mDlrlFzwZZNDBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8EqmAUv/Qy9/26LOqMeD91xSeP0IFz8uYyJTRrQ4g+MBvciE/duAT3+I3MdZxVSP4h5HS6QKTywOe0icfZQv/CnaI5HJpCpws2ul5z0q2qkkqO2Jt4MRy92MzRCZ0GOjlegdKQbOWl9w2hdot/c3qHVZybl1qrugFG2RzQEzlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=XpwSAhri; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Jgu0mXdL; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E4o1OR032661;
	Tue, 14 Oct 2025 05:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=6Si9+GMfIoFcnx3arh+R0VKf3Fap+mDlrlFzwZZND
	Bk=; b=XpwSAhri6OpvbVyOJ7rFNIawWaLK3CD7b37Hir+whLF3LHoGJNCqiOaQF
	9fadY1JJCavvQ+lEA6QZzG5wNqBD3ZQtWaBtVKIzKSSaK8vYMDhMG3yiNWkMQrI7
	PMZeLnLCYp0fAvaGqFxLsXUn492Er5ge3hoy8lwmlGg4DoTXlJ/YEdaAk2Q9RVaG
	/97FrADDhxW0fN2Su02JkOotCqBasxKKsqjCowMYLRJsdl0JO/4sOTO0pkcJmnju
	UpNCyYS0PQ61qO7JeTrBb0nGBrozOgu7a/C16LxiNwvSKUCYm6kZWq+fTKI6j/zJ
	bUsp68I3N0sXdZyqN8ERBJecmxn6Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020103.outbound.protection.outlook.com [52.101.193.103])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49sfucrx36-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 05:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2OnJHV8YJOBUIIQT4gxM2NwKFfEbxpp82uKASfT4ZNt+kxgpPeiyoGz7erVmcRO5wh144YK9TmecEa3IEKcjZmu66oBuSmM/gtHSl6koG4MJtdXLZgOOnsPoAAABX/zCqZy4u3xTnqpTkXxiWZk4+PZFUpUPiF+ZPbMT4PtbvRzN7JJaGS6UrUKhR1pw0FqvE764fWPfsfegy11UsCKtDZlWx2mZ3oWmkqYvk0XSzduOh6Zr1yAlbjwDXthhNvdgdMFmgt28QqegbgUw/JjV8TQMXtL+Z6Std62WlWF+GJT07I3n/acWZU10bvTNJUwcFG6UvqaYT9UyfUBi8RNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Si9+GMfIoFcnx3arh+R0VKf3Fap+mDlrlFzwZZNDBk=;
 b=hYEbeMlzQ8NvWmmX9m7qCyV96mOBIDiKUU1WOa5h0VtIWiI8xdY0ekcvx02L5k/kPQx8ZNH7Bd9BFt/sg/hVFxhHwDv37QNfCLOjBdZULvne7/RMSRywK5y+cI/TsvfOANm6BZRqHnRumVdb3cwOiTijkgLbto+Z3u+GZT/skpZxRnFLZstb3jEpc/JsesGcxbn7eYexBH62OGMCHlqBBNg+B5BECVBWkDBgSoupPugFzlLRZhZInnRlmHtpxBqAJ/HbnYCpnXuv9PN+spvaCXxZ9j+boKqTixH2r4pY+kabmkoNEcmc3Jhnc69xYhAZsmqJ4+2XWCfro61YIFEFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Si9+GMfIoFcnx3arh+R0VKf3Fap+mDlrlFzwZZNDBk=;
 b=Jgu0mXdL0jauhpQwADpdy4MIoiNbig0MKk6uYSsdmo93cUDdnEHFjr52X1slH62+IibvIDuA9mUOU0/wp9h0qWRqhUwi2Wdmig3GO/DfyWgbnDjVDLCkxGSIU5SwV8M2e7c5K+2xmUhxHJTEU3nM++P+igJkDOtuT663prfKh9t3A/f5NdNcqPMfnUbB0sOmiS2IxFqjxFXj3cIB1U61Mf56ZGPh/RovdOyvEl8qApoD/s9sPAibYiQQ+9FTkRTm5Qs4ju7BwFxzbEDXGq822AfaMVnZryIQq0pTON4jc8yWxQt4i++ARsZAol62ulK7m1CuCXV8/qoD+F9eY8YLFA==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by BY1PR02MB10529.namprd02.prod.outlook.com (2603:10b6:a03:5a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 12:10:34 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:10:33 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Topic: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Index: AQHcPG1tSNyf7ChLs0Krp+ls3jbtF7TBGfiAgAB0NYA=
Date: Tue, 14 Oct 2025 12:10:33 +0000
Message-ID: <8B3127BD-2892-46D5-8EE9-C75D812466DB@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <20251013181459.517736-1-vincent.liu@nutanix.com>
 <2025101452-legacy-gizzard-5bd0@gregkh>
In-Reply-To: <2025101452-legacy-gizzard-5bd0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5016:EE_|BY1PR02MB10529:EE_
x-ms-office365-filtering-correlation-id: bd1b7f51-e50f-4565-b87d-08de0b1aad53
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkVRZEVTV1BtR0dRbldCNk16SFZRdC9nZXhMMXY3Yy81T3pyT0huTHM5K0hB?=
 =?utf-8?B?dldBYmxuWERCZ3ZoaVRtcW43cFQ5RmtBQWlYRzcxNUkyUVcwM2g4RDVmZ2cw?=
 =?utf-8?B?SlQwZ29qait0WlhUVDl1L0YxZFZvZEJBYmhNSTVSMmp0VDZONkErRkpVZFlE?=
 =?utf-8?B?K0loaWJIT0VFNW81TStjbWJQNXdwQ3NXK2VkRTZadGIwTEFSMHBHaWFJOVJv?=
 =?utf-8?B?bjFOaW15V29sWktPQkZaR1dxdW9wRkNVRGZoM0V4NGVZNGJNa0hicDBPcGtq?=
 =?utf-8?B?WHJCeVN0YVIycVBzSzY1aWQxRSsrYjdOZi9wMmpXdFpWL2psQ3NTeW1lVjhJ?=
 =?utf-8?B?YmRqOENNUi9jUHdjbEZpVllhOERLSU9MWkxLaEF1d0tDTld3L05ZWG1wcW1D?=
 =?utf-8?B?SUZCY0RSaVk1UDhQanc4WDBkOXBreXE2bEovUGtOY0xPZ3VkRVNVU1BPWnRS?=
 =?utf-8?B?RTQ5MzVHRzBPNVdKMkRCNUxlbjVibVc0NDg5Yi9WQVBJNTRNVXk2dHFTTjFR?=
 =?utf-8?B?T3JXTk5wOGlNTUVsNE50VEJhdUErNlZ1WVZjUGNCT0NrOG10dG5aelpQMk1W?=
 =?utf-8?B?eGJYSzlIVVJaRC9hWk9Vc3FwbWVJS01BcllvZDBvalJRbEFUdlRsU0Z5Qlp5?=
 =?utf-8?B?aDhmZUJrd3JLNGpxQ3JaWkFld2tidk1WY05BQ2NBdXdhSFpZeDBFNENaTUFu?=
 =?utf-8?B?WUVtbFJPNXkreDY4cXlDSDZtb05ORHJZSjNsSW9yUWd3TFllTm9zck81K1BC?=
 =?utf-8?B?N0h0V3pHdGYrN2swR2trdjRQVDU4QnpiQnZVdTZwK0NqNFQrblo5S1pqaGhE?=
 =?utf-8?B?aDVxckhhcXJ6NUFMUGpHSGU5MlN0NVIrTXRIYW8wM2E5N05lYmtYTVMwME9P?=
 =?utf-8?B?RWxSWGhObTBLS2xoSzgyRkxqRzE1Q0tlTmMxZEJJOHhZUHFmd2dLUmRiSkdm?=
 =?utf-8?B?R3RRMGU5SFU5TjJkQmlCU0dEM24xNXQ0RXg2TElwa1FlSGZuWUZWeDhGVi9u?=
 =?utf-8?B?TWsyU0ZuU240c2FLaXFSNGt4a1lvaGVDUFYyMFB2eVk2bVVpZDJyRmVwRU82?=
 =?utf-8?B?S0pScjFXWmpYa0Jqc25ueHJucmY5RHcrK200bGhjYjNNNnJZUnN3U0lnK1Rx?=
 =?utf-8?B?L0tXZWJ2OE42OENONktZRlJ5UW9PaXgvOFhldFlYcGsreXlaclNJK0RMZmNM?=
 =?utf-8?B?UUZHaURXd3NiZUNkMUN1by82cDgvRnFRNktVUEdmTjhpSzlWUnA0RDV0eDBl?=
 =?utf-8?B?TlJ2dGsvMGZjLytPQWZnY2o0emZXOW1Sc1ZHRGRqMXJ4Wm1vYmxOMmo4Q3E4?=
 =?utf-8?B?UGd2RDI5NDhMNDJOaWsrNHV1T2xEMjJTWnpKRDgzRyt2Vjg5b09mWGtXcnBq?=
 =?utf-8?B?anJmTG1CcVgxWXI0aTRIQnZFWTNUNHJ5NnFLbnJRNExOU0Y5WHpPclJiaERO?=
 =?utf-8?B?alFraW45bnc3ZWFkK0dhVGZWaktNamx6VENIYlROdVgraUdIWWRyWTM0YUlC?=
 =?utf-8?B?NHpIRFdaSTNxT3NEZnY5dkhBVWdnTC9GWEdtUGVhWnhlc3VkOTl0b1puT3Ba?=
 =?utf-8?B?ZXlrU2ZBcDFEY1p5b1JvREZ1eFZ5eDRSUDFiMkhkQjBERmFiaUgxZm5jOXdD?=
 =?utf-8?B?RXpxL1lUc0FJazZOY2NWdVFnUmpMWnZOWVhoUDRLSmdWWHhvM1JyWU1ES0o1?=
 =?utf-8?B?M1dmbWVZMVRoSXd0TXNtOW14NW0wU3ViZDIvMEx0L0J6SU1oT2UrYWtabVFk?=
 =?utf-8?B?K0c2cU1wTHRwTDBjVUd5c0dNMWtsNENyVmZvMkZFWno4d2xHYVBURllQWFRY?=
 =?utf-8?B?OW9Ebkg3bVJrcGV5dWlxcDVhZUU1TUZLbGVHZURzRWpCcGZHZ1FjSGFBeDlN?=
 =?utf-8?B?YkV1QTYvemI1c3NpcUJjWE0wYmJIYzNVa3Y2NGJNb2htL1JPcWxXY0Q2czZO?=
 =?utf-8?B?ZllJT0NDbk9DV3UycVZQZDFrRzUzbHNYWUd1L1UyaHhqTlF5bEpGVTBVODE2?=
 =?utf-8?B?MDVNbWlRY0xLaXlYek82UGFDWitvRGZKczg2UTd1eXpvOGU5MGNFZFZLQzJP?=
 =?utf-8?Q?x0TNQf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWxHZTErRUN0QlZrZXVoK3FwYW5wT1pyMVV2US92ckYyUUVhUVBpN092MGRL?=
 =?utf-8?B?T1R3Vmh1aUs2NnYva3FuTisrSENwWXNyVXdJUVRBd0c0cmZQaWNCUWV6QjFv?=
 =?utf-8?B?M3kwZnY0em54MU94bTNqSENSaXpSZkkxWE51ek5BcFg1ZjRDdDNhVE8xS2M4?=
 =?utf-8?B?cGQ0QkdwRDg5c01OT0pzRkcvZFh5czEvZkt0ZmVjeUt2d21sbzI4aVNhSnFS?=
 =?utf-8?B?MUs3MUxPdFFKU09tZHUvT0tBUUFXY04rL0V4VDNEeWUwSTJRWEhIK2EzZHNB?=
 =?utf-8?B?L3ZQd3QrYzFXYU1IL2dyMFJ6T3draS9TMzFHNjdGSG03V0NjNS9YajJjcG5a?=
 =?utf-8?B?cmFQWWRMYStRQkJVVnBVdExLTCtrcDVQTzBSTFNYS2JCU1ZQRjd2WnNMMUVa?=
 =?utf-8?B?REJPOGxZWDhLSWpnZXlyRXdvWTZBVm9WT1BIbE01Rk9xZGtsUGZQTlI4OXRJ?=
 =?utf-8?B?Y2YxTm82cUZuZTdmOUNuekJXVVlDV3Rac0o4dFVIY3E0dmtmbVplWm9DUjhH?=
 =?utf-8?B?c1hrRy9na0IxUGNBTUJpanJaK0g5T1FVOENhem1Jc1ZVU1NWdVROd3JUQloz?=
 =?utf-8?B?WEhBOFBrL2h1dUFZS2FMY2pLZENNQks3Z0V3ZndPb2FiVHNvMzZ4V1VNMlBY?=
 =?utf-8?B?Yjh4UlI4R0lEbWowV1RLMXpCSERFd2g1V2NlNHpKZUJ3OEFLMVFjSVN0SjAr?=
 =?utf-8?B?VDhDZnNzK0lxb29yWHFjU1NJN2MzWmd1cVNEcHlFWk5XVjRSNS9QL1RINERJ?=
 =?utf-8?B?cjJNd1VnK2NvUEh0WEFjNittQWdBK1M2RWRMT1ZpN0JEamc1eDFPWXFSbG05?=
 =?utf-8?B?VHQ2Z01QOWJKQklJelg0V0J5YjlIK0lwQzNXdWdiKzAzRGNjOHFNTFZrZGVt?=
 =?utf-8?B?YnpKWjh1clhOT3FWN3M5NEkzdmFDUTYxV2t5N1NJRTdnSFo1ajVJNE1FdVRZ?=
 =?utf-8?B?ZWxlNFJFdFRtS1lraHYrTExLOHB0K1gvKzd6Um9xd1ZUckoxdXFpbS9xL1Mv?=
 =?utf-8?B?aDZKelh2aG5weWhyZTY0dFY5cVRjN3BVdGhCZlplY2V0dWpxNFZhS2YvV3dK?=
 =?utf-8?B?YXBxd2F5TWttL2xoT3Fabi83VlZpVXoxc05NQjV3bnV5MUZOWFNxN3ZMeU1I?=
 =?utf-8?B?Q3oxM25ZZ3l2ZVVFRWU4d1dncXpNTCtqSFAzT2Y3MHFRN3l5Ukp6VHlpbWlw?=
 =?utf-8?B?V0N4OXB2Zjc0Vzc3V1hLYUpRMCtrMmZySjFoTVArZFNTNHdBT21TanFjNXk0?=
 =?utf-8?B?cHpKZmRnREdxbTlFMWJHMktRSnAyNzR6Q1VhWnozRHkwN2lFNnpJUENIUml4?=
 =?utf-8?B?cFQ1UXpIMU9FT0QxVFRlcW1qdzVqQnIwaEpYN0lqbUIramlzMHNoa2hzRm1h?=
 =?utf-8?B?R3ZvRFd5Q0w2SUJ5NGd1b3BFNXo3eFNYaTNkSjVxWnEwMFlMMnNaMVVoRXRT?=
 =?utf-8?B?eXdXZXg4WkkzVzg2YmNiSnNER3hiVmRkUUd5c1JZRURYcXFsUGlkUG54TjYv?=
 =?utf-8?B?NjB1ZTFYdVA1TUE0eGVGMmZtakNUMms5UW9lMFMxU1M2RGJYUFZWVTlYbGJR?=
 =?utf-8?B?R0JBNmZJRXlJK0t3bW9zTnpzWkxuc2V6cDhOTUVYTTJ3RUpzMGNVdGtVbHps?=
 =?utf-8?B?Tkx0Qm53cURFYlNZbldFZHRGS0dpdHUrYTdLazRpNjJqZG9LeUs4dFVwSGFH?=
 =?utf-8?B?dE1oeTFEdnRXMnl5YUJDSytVN29IMkN1UzV1b1NRYWVJNGU2TEd6TUNFY3Vz?=
 =?utf-8?B?RGViZGozTEtwVldrNmk3SURVQUhWQmZmT051VU05cEZiRTBac1RvNTZFaXpU?=
 =?utf-8?B?c1dmUVJ6TDhnekZjRTgzZkdmQ1hMWkUrWGFJSFI4VVRWUWtRRVY2TFQ3cERP?=
 =?utf-8?B?MjJlajR0ck9QMndoUmZpck1ybHgyTmRVa0xMM1VFSTQ2YTJWK2dwTjBsK1JP?=
 =?utf-8?B?OVJ0eERMSnVQbG51a0RCSUJrVGRFWDdLUHdLbGNYWFYwVGVSeXRIR2IyaGp1?=
 =?utf-8?B?cVdzVVU5SzFhRVpOTnF4VTJtVDN3TjZFckpJRFRjL3VKbFcyTnArbVdueUxx?=
 =?utf-8?B?clF2Sk51ODZwMU5NcHZwUXNlK2V0NHYyY043U0RlTGtwTW5KZktJZW0yYXl4?=
 =?utf-8?B?VGQ2RjYrZ28xTHZMMERQeVFoY3Y1YU0rdTU4K3ZKTEd5VTdjU1IrMU8yckZq?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48DB4C92E9067B4F9B766980E1E9DB3B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1b7f51-e50f-4565-b87d-08de0b1aad53
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 12:10:33.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O92EGpT/RB2RE8yAdc0gKqhV04WHIOLXKiUOzmei/U2LCevaL3oNnK3wY2MCKUevb2PmmFphGnLcGG4YQtv9AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10529
X-Proofpoint-GUID: tCOygsCBWRRQjKOxo2zU1ByGqjAVOZuc
X-Authority-Analysis: v=2.4 cv=KtdAGGWN c=1 sm=1 tr=0 ts=68ee3dbc cx=c_pps
 a=Zp4+jYQMTYkjuDMG4rCdsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ag1SF4gXAAAA:8 a=GdZjZEyPee1WywaIJdQA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: tCOygsCBWRRQjKOxo2zU1ByGqjAVOZuc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX3RtRLnzuyYTj
 kdDF87cifDTrdSKJtCJmyxvC6HXKDPM39S4KguPKzA2nsVXgpq61vPE/TELRYhjYEZ5gXnMWvv/
 VyLRztwGWEDUW0D6n2GtyxxQmwjiXW3cCnD6gZ/26Ez8zoe//1pT27pwReAxxPiciju8i9ygoha
 OHBTs+sUe6td4+0c8SruHNCYcnpaasPfQb4abIxKnRo7xZQHeeAZvZslHrJ3R9J4cMBve82q63H
 xQU33wE2Ku2xQS8TEfYvefQrxcKsFKPsayPvcqQOonSIPsakPRZiTF/OzkjVD6Ci+RwoIRrxOhi
 yJudcZXM2HbZ+9KDzydryHRSUkW8jxqMDtOVojPHFKogkSGD5MXdvyvafDfV5dE+3E59xFwNTCf
 wohGp608bAZWr4uNdDStCKX55Vj+Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

T24gMTQgT2N0IDIwMjUsIGF0IDA2OjE0LCBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6DQoNCj4gV2hhdCBjb21taXQgaWQgZG9lcyB0aGlzIGZpeD8gDQoNCkkgYW0g
bm90IGVudGlyZWx5IHN1cmUgaWYgdGhlcmUgaXMgYSBwYXJ0aWN1bGFyIGNvbW1pdCB0aGF0IGNh
dXNlcyB0aGlzIGlzc3VlLA0KdGhlIGRldmljZV9hdHRhY2ggY2FsbCB3YXMgYWRkZWQgaW4gcGNp
L2J1cy5jIDU4ZDlhMzhmNmZhYywgYW5kIHRoZW4gdGhlDQpkZXZpY2VfYWRkIHdhcyByZW1vdmVk
IGluIDRmNTM1MDkzY2Y4ZjYuIEF0IHRoaXMgcG9pbnQgSSB0aGluayB0aGUNCmRyaXZlcnNfYXV0
b3Byb2JlIHN0b3BwZWQgd29ya2luZyBiZWNhdXNlIGRyaXZlcl9hdHRhY2ggdGhhdOKAmXMgbGVm
dCBpbg0KcGNpX2J1c19hZGRfZGV2aWNlIGRvZXMgbm90IGNoZWNrIGZvciB0aGF0Lg0KDQpUaGUg
ZHJpdmVyc19hdXRvcHJvYmUgY2hlY2sgaW4gYmFzZS9idXMuYyBoYXMgYmVlbiB0aGVyZSBhIGxv
bmcgdGltZSANCnNpbmNlIGI4YzVjZWMyM2Q1Yy4NCg0KPiBXaGF0IGRldmljZXMgY2F1c2UgdGhp
cyB0byBoYXBwZW4gdG9kYXkgdGhhdCBhcmUgc2VlaW5nIHRoaXMgaXNzdWU/DQoNCkkgYW0gb2Jz
ZXJ2aW5nIHRoaXMgZm9yIGhvdC1wbHVnZ2VkIFBDSWUgZGV2aWNlcyBhbmQgVkZzLg0KDQo+IFNo
b3VsZCB0aGlzIGJlIGJhY2twb3J0ZWQgdG8gb2xkZXIga2VybmVscz8NCg0KSSBzdXBwb3NlIG5v
dCBzaW5jZSB0aGlzIHdhcyBub3Qgd29ya2luZyBmb3IgYSBsb25nIHRpbWU/DQoNClRoYW5rcywN
ClZpbmNlbnQNCg0K


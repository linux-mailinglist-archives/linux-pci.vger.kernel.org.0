Return-Path: <linux-pci+bounces-16517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06379C5203
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC10B2AF22
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337820DD57;
	Tue, 12 Nov 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WFqPj8Xv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76520D518;
	Tue, 12 Nov 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403565; cv=fail; b=eKg4J+3//N6AAJRXaXypZGs0Sr2aX/LkL/06R+IEe6/vwr+vUuYCy3IySR1bw7gjfz4LjKd8YW5WpICrarbOgpvvhEEPx3yqiGSkGCoUR9HaLkc+eJtgig06QBNiAhEPm3FS+XVN/tD9VF6gzFfH3ff2aY3u3VYzDM7GVhR8m6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403565; c=relaxed/simple;
	bh=lXIPf/kOVcUpmMM0D0hIbL9wb9Pxh3pWhEiVjKOWxy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PWNVHXi+kwQRLwKmJmTRk62RgbnHVbuxZGvfJRQmG/xATn7G6ZNa3BQ04lnHgB9c66PHS9lAdOpIWD30BTPDkMm7fDLZ/cidabmeYCCiEsPKW7eVynOG91VQQrrOKTdfkVcfFAOfNE6liMH+74KEhFWNUpINZo5aqqKpmI8FOBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WFqPj8Xv; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC4u8ui032429;
	Tue, 12 Nov 2024 01:25:49 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uxa40kch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 01:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdxygNfzlGq/TtZOXGejaZJRUwRknE6l8OxzMlf+FTnfwcSw7y4IjcaEObZe55G9LXMz3+0BqeWwWlY2/rvzZ1xAIQc1xuHPONHlzgbUnxY/Vw3X83FfyYUReAkyz2bsnmeT0bI5di3GNsGJW1+pXbmTnq3+nzfFf6Gs2jUzAZ91l5rS3TvZfgj8VZvxz6eK+gaUTuXpaUcXqeltX4vV/HzlT9fidopAzrDZtrMAgFyZsLiwgRxRya0RbWJygKtjLxCwdl6BsZDklW8d/7CfujmsBsv/qO7a2g4z1fqa6FYTrAovGmbnwdcOy9G77LtX8nLYLGMnAoxSSK/NFqHWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXIPf/kOVcUpmMM0D0hIbL9wb9Pxh3pWhEiVjKOWxy8=;
 b=vUS0l3ksSNC0uAwZiBkJv3+xuLDHh0EuOx6i2MycWr+crjpazQ9lnRVKus/ib0ct4NNuS5EmZ/Dq9L9dSW3D5cUfIwzVjU+IajurpJhnqB+rdfLXQ0KkwWcADY6PkfUhERLO0jqVAhG6lRtnGyqPIl7S6f/LE0Z4C3GjigjDf5ezEO0dctlQl21lBuwN2HV/1zULtEFuszgA0CsHJj4aMFkYs0sG7lWAvfbT4ho2GKNObcNtTyjc1LqPPU7Y8QmulDfECmRAVRsVQce+YkwK0YJXCWXh11BUNL+u5ObKO3bU0fYn3ylAuvlLv89cpm5dQjxizDPEvyXheeeMbMGOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXIPf/kOVcUpmMM0D0hIbL9wb9Pxh3pWhEiVjKOWxy8=;
 b=WFqPj8Xv1LD8WaFtmpxbIi3+TreouRfVaIczESa5XJ1mmXmgntahZ35Zrej+Sp6br93iwcSE5iF4seWeMHwxPM1GAz1+ZBVMbVy7QdaN8wARWTDuLGJC1g/bRmxNobUcloRExvb7ATCMDlE0cWb/6uP0Z2r3suFyzh3gywSKnAs=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by PH0PR18MB3846.namprd18.prod.outlook.com (2603:10b6:510:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:25:47 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:25:47 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHbNOTbDCvPpkNISU6LbVFVsUVb5Q==
Date: Tue, 12 Nov 2024 09:25:46 +0000
Message-ID:
 <PH0PR18MB4425F2F17BA6CC582638F9D7D9592@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241111134523.2796699-1-sthotton@marvell.com>
 <20241111201448.GA1814761@bhelgaas>
In-Reply-To: <20241111201448.GA1814761@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|PH0PR18MB3846:EE_
x-ms-office365-filtering-correlation-id: 42ea7407-63a2-4068-d968-08dd02fbfd8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjB6NTFCZXZ1N3Bqc0hRNWlEclpraHRHSjhMQkxsRm5ucEFkem9STlRvaWtw?=
 =?utf-8?B?cGtPN1QzVnB3eFI1NnpoMld0RUQ4T0g1MUo5QmhlanRnWDM3WEZpRTJEYmdV?=
 =?utf-8?B?cjlYcitmbjFWZldEUVcvRkdCTi9zQnQ1dDM1MzBuT05WbEh4MmxsT2hrc3px?=
 =?utf-8?B?NUNxVDNncnBYbW5RMXgweTZpc1p0MnlwL0lCS2xVSmhLU21kUUdyWnowb1gv?=
 =?utf-8?B?SUc4dUdKUVpUVTNmTlYzVStWckx5djVTcjdBUkVUYUhUNU5haExKVVU2VDBa?=
 =?utf-8?B?ZHQvNlRzUEpENGEralRTdWViWTRWekNNY0RLbVNkQWdMYVlJN3BidHpVNWFS?=
 =?utf-8?B?djg4MnA1cjgrNGNJL1I4Ukx5V2l2RnMrYStMdFNPbm53aEZzcTQrYTN6b3hl?=
 =?utf-8?B?K1JpMTd1NGJaRlF6MWVGSnA5T3BkNS9IUmRKWnRxZUhtcXlGTWZrVEZyTExL?=
 =?utf-8?B?M2dhc0VWMC9rZmNxMGs5YkJrbVRGQUY5ZXlxU1luYlU4LzJaMkI1N1k3ckhX?=
 =?utf-8?B?czRIc0JWSE1aN2t2Z3FlYWJZVzJTbzNYRjZXN1A4YSs5UHJ0R3pPeHowS2d4?=
 =?utf-8?B?SGpkc1YzV3FGb0h0UVBSamZieW42eE44QXc3bS9KcHY2alVlSS9hNFVxcms3?=
 =?utf-8?B?eS9obmRLVGVJK0QzOGZOOG9OOEpIdDlxY0dETHZaYkh0WUJsNnl1VUs1a0VB?=
 =?utf-8?B?R1RobDJCZEhBb2ZkUUpjOWlYZzFtdm9NZGQ4a0ZyQ2RQMFNyL1hycHRFblJE?=
 =?utf-8?B?UnF6VVMwNU5sb0IxNXhmUGw5SGRiSnVaNzVZd2hacE5NSHA1T3laSWZRMEFV?=
 =?utf-8?B?MERLR0hGamhZZURmVnpOV2NQUCtXd3hyRGZMODZweTV4MjdoWUdUQncyejJU?=
 =?utf-8?B?NktrcU00b3YxSGpFYmFRRHZ5bFZlRi9pZkU5aSt4VitrUDVTbTh3djA2cXdM?=
 =?utf-8?B?bUV5QW1yTy9ZczZ4UXdtNGtYSlA5U0JKTFBjY0ZnYWgvR2RyMHRMOEZicnh6?=
 =?utf-8?B?Y3hVM0duV1JCaEUwSmhXSzhWTm9scG84eXNmdHJkaVorMy9PL2xndGJma21Z?=
 =?utf-8?B?eitTcW5aZmFCWDFrYy9vZWJraEUxKzBwWlloakhFaDBwRmdjSmY2YmlPT2lW?=
 =?utf-8?B?cTlJT3NUdGRWMWR1WGtkL3VuMGM2eGxMdExJMk5URGtJNU90ci9GVWVlN3VX?=
 =?utf-8?B?czhJN1pkRm9iTzE2UDZiYjBYamo1R09NWUJ5c0NSU2NYZWxaUnBrVTM4TUNP?=
 =?utf-8?B?cjJGemlSalJJWE1OaUw4TTdRWDRlMWpmSWhVUlF2SjVPdmZSZTJTUlhyaUdC?=
 =?utf-8?B?OVpDWHZ0VDhBME5YUVZtWlFaWEJGT2h6aHB1Y3g5RG5MOEZBUytKSGk5K3Rv?=
 =?utf-8?B?cFk3MnRwOXNRenV4SFMwUnB1WUt2UnZNaEdpcitSeGp6ME9idFcxMzF4SHhv?=
 =?utf-8?B?TVpXL3ZmSFZiNW02eHZ3eWdhWDhsWkdZdnlDY3VQVi92bG4vek1TYVN6ZnNR?=
 =?utf-8?B?M3grcUh0K0h3WXBDU1BFUXpyaTdWQ1RJOHBkMHJNeWFJQXdHbnNWVmhpVi9R?=
 =?utf-8?B?UGxSeld2OVlFQWlsUFkvRjVBRjV5d2VPSStHMUVNZjBodk9nWmN5RXpudzF1?=
 =?utf-8?B?MCtMdXhRam9TRDB6N2dkNVlmcVVITW14djhLc3A5YVdMZUtsWXdDSWVZSnhP?=
 =?utf-8?B?VnQ5SHQvNWxpUStTVjVqOXdpeFB0RFpqRHlOd25rVUE4QzlCNGJlbmNJd3V1?=
 =?utf-8?B?T05WZ1UxZ0tIalRSQkltREN5WnNuaWRnc29OZllubEtKd1R3WXlySHRhMzFt?=
 =?utf-8?Q?IFxlI1mwiC/f0Kotd/i0fCC7nik5XgH4ckY2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blhBdkQvUzkxbmk5OUlXeW1YNFBvcVNKRHBiaFkxMHZXVW5XZUN1SGhkUE5P?=
 =?utf-8?B?VUdKRlhyOExaNlpKQ3VHdDF0T1ZKb05jMmxNZk9pVitmODE1eE5jdk5UZTB0?=
 =?utf-8?B?NFQwOGMvWW1OcXFRWTdWY05JUCtzWklvRlROUHlmcHFsc3JaTHIxb1FMeUJ3?=
 =?utf-8?B?d01lMW1MM0JobDVFZEpEOWo4amZ6dVB0ZlZvVzh3THdhZ0d6cHIzQ1JScWVD?=
 =?utf-8?B?ZSt5UXhqYUthbGQxZFF5MzhpelhmQ3JnWklwOXlpRG84SC9tRVFQbWtJNVBj?=
 =?utf-8?B?YzlBU3kxdVp6dkZuTHk4REpOVEI5SEpjTGh6ZktNRzdUZk50elhvaVlDYU9F?=
 =?utf-8?B?bGhXWjNSdUx3a0dsUU5lQVhjZ0lVNW9udW9QMXUvZi9kTmdyUUFTelZvYnJF?=
 =?utf-8?B?QVhlRm40TkM4ZEFOMlRiUmpVMnZRSmV4ellLdTdpQ2liSUF1RlVsM094MjRt?=
 =?utf-8?B?U3l0MWhJT1FZa3ovSkY3YXR4c0paTWwvK0NaL2NzbCsydndpcEgxZ2NGcS9Y?=
 =?utf-8?B?aEV4czNsWnVRY3hXc0VpZzFpZys0MmRWSDBQSHd3T003eWFTMWIyVVF3bXAx?=
 =?utf-8?B?QkUyY3ZtY2pqZFZQb2c1UUJNVGIvN21iUENadkE4Y1ZtYlNxeitaNHZQdkNJ?=
 =?utf-8?B?aDNQcHZzSlZWQmg2QWhrUmxTVlpzdXExOXRQdlUzVGY3TWJGVzJEZVNYakl2?=
 =?utf-8?B?eUtIVFVrRlc1QjhMVDNSN284WUJmSVBadlgzbWVRdkw1aXNNNXFvSnIyOTlK?=
 =?utf-8?B?NWJFYTllc1pHTC9nV0dpUTBnU3g4KzB0WlkzMlRpdVdmYitZWjFoU3JDWDNY?=
 =?utf-8?B?QzY5bHFHb3plbHVjSmNXeTJHK0pCa3A0cDFWbDdhNG9LT3NRVUhRbE9IVWVj?=
 =?utf-8?B?cHozcEtVY2U4OXQyU080cGJJT2NNcG82ZGtCNHMzbWYrdmVhWmtKTnNySzZn?=
 =?utf-8?B?VGZFaVFmTlA0QnNpOHBRWHJDV29qbjJyOEFTV2RvZit5MWduVGpBVjNNemxQ?=
 =?utf-8?B?TVp0WHd5M2lzNHVyTHIvaE01L1B6Q0Robmw4Q2Qxa2hEUEdMQVgwNDVTM1Nu?=
 =?utf-8?B?VUxGbklFZU5zTytxeFdjTjZYR2Y0L3BBbFdvbTUzY1Jkc3NvWXRwVjB3VFk3?=
 =?utf-8?B?VGRJZEdSbDVwNE41NmNvWUs1Qk9sQ3FqZjdKQ3dLZzRmQ3RWR2J6cVBSdWsv?=
 =?utf-8?B?dXdsckFSeFRJdWdTbytuMjdHU2Y4dlNDMWNsYUJyVzM3UXI0RllvdXlhckJ3?=
 =?utf-8?B?ZFE2SExzVU80S1E4NTlndHEzcW5MWXFyRkFCZW5Wc2ZLTzl6TEM4alk5RFl1?=
 =?utf-8?B?OU1yVlJPdExXU25JUWxMRUR6VmVXdXA3alRXZUpvV1h3eG51V3dDK0hjeUpn?=
 =?utf-8?B?M2MzQzR5Sk9pSDNBYkVaL093SXZIOWlFUmx5TzhybzBBUWxQdUdJVUpZSjVr?=
 =?utf-8?B?UXZ4cjI5TC91NlUwTndNRTJsTXJIUExLVlJud3BlNUJHQjgxN0ovMzVKR2Mx?=
 =?utf-8?B?OFd0NVJCaUkxcEhQaGl4a1NwWlpVK0VINnBNMUZlbUxUNVRNOW9Rd3pBeTBt?=
 =?utf-8?B?QmppYmFHOENEd3RBWCtsRi91WWN3NTM3QjdLVDkraVhLeDY2S3I3KzNiWEFC?=
 =?utf-8?B?Rk4xRkJZaFZzNUdxa2dGRUF1Q3E1U3E0YjgyaW1rMXBMazNGa01vQzVXeXRG?=
 =?utf-8?B?KzNSeGRWZ0VlVS9WSDNEYUpQcS9YSUNoMEpjMEF6ekJHYXlKVDVWd1Q1VnRH?=
 =?utf-8?B?aGMvdzJDTUJxVThYNDFPcDFNK2VjRC95NmExaFU0ZnVEd3FobzQ0YXgrZEdF?=
 =?utf-8?B?bmRrN2xsVnIrbUkxR1pZNVBsNnA0VWFnUENsT1ZWLzJab0krbTRhc0JVSENM?=
 =?utf-8?B?eTk2bE83c1dNRW1vcWZyRzZZU2ZZZklCL1FrakQvaHVyL3lQRzJTN01iTXQ0?=
 =?utf-8?B?WU5ocHlabUZ5WHVIWCs4ZlpRU240SDM4TXNTSjR0UjFKeTRRVWNqVjJFQXl0?=
 =?utf-8?B?KzJQUitRa3BCRm5yVGZnR1BhVXRtL1hSeXdDV3BNTEVhd011MHgzVTlheUJn?=
 =?utf-8?B?S0RxdE9wdkx5bUhKcGlDdWFqUklRU0UvVGVsUllWZjlIMHN4NHorRjNxMkN5?=
 =?utf-8?Q?Zj24qqFT7X+hYvHVY6hRHdGNW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea7407-63a2-4068-d968-08dd02fbfd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:25:47.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7MxuX+grY9ufKH6Ex9gsYHXwzh8v2ntXDEBCgS6d536VYn0BJuINO2+3OjGtGnpAZ9NukO84k+wyN4tGQdMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3846
X-Proofpoint-GUID: jdNATbZPuSZNbA1K-rXKSyi3IzOUtPBf
X-Proofpoint-ORIG-GUID: jdNATbZPuSZNbA1K-rXKSyi3IzOUtPBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUENJIGhvdHBsdWcgY29udHJvbGxlciBkcml2ZXIg
Zm9yIHRoZSBPQ1RFT04NCj4+IFBDSWUgZGV2aWNlLiBUaGUgT0NURU9OIFBDSWUgZGV2aWNlIGlz
IGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdoZXJlIHRoZQ0KPj4gZmlyc3QgZnVuY3Rpb24gc2Vy
dmVzIGFzIHRoZSBQQ0kgaG90cGx1ZyBjb250cm9sbGVyLg0KPj4NCj4+ICAgICAgICAgICAgICAg
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgIFJvb3QgUG9ydCAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAgICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0llDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+IHwgICAgICAgICAg
ICAgIE9DVEVPTiBQQ0llIE11bHRpZnVuY3Rpb24gRGV2aWNlICAgICAgICAgICAgICAgICB8DQo+
PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKw0KPj4gICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgIHwgICAgICAgICAgICB8DQo+PiAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0rICArLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0tLS0tKw0KPj4g
fCAgICAgIEZ1bmN0aW9uIDAgICAgIHwgIHwgICBGdW5jdGlvbiAxICAgfCAgfCAuLi4gfCAgfCAg
IEZ1bmN0aW9uIDcgICB8DQo+PiB8IChIb3RwbHVnIGNvbnRyb2xsZXIpfCAgfCAoSG90cGx1ZyBz
bG90KSB8ICB8ICAgICB8ICB8IChIb3RwbHVnIHNsb3QpIHwNCj4+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0rICArLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0tLS0tKw0K
Pj4gICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICB8DQo+PiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsNCj4+IHwgICBDb250cm9sbGVyIEZpcm13YXJlICAgfA0KPj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQo+Pg0KPj4gVGhlIGhvdHBsdWcgY29udHJvbGxlciBkcml2ZXIg
ZW5hYmxlcyBob3RwbHVnZ2luZyBvZiBub24tY29udHJvbGxlcg0KPj4gZnVuY3Rpb25zIHdpdGhp
biB0aGUgc2FtZSBkZXZpY2UuIER1cmluZyBwcm9iaW5nLCB0aGUgZHJpdmVyIHJlbW92ZXMNCj4+
IHRoZSBub24tY29udHJvbGxlciBmdW5jdGlvbnMgYW5kIHJlZ2lzdGVycyB0aGVtIGFzIFBDSSBo
b3RwbHVnIHNsb3RzLg0KPj4gVGhlc2Ugc2xvdHMgYXJlIGFkZGVkIGJhY2sgYnkgdGhlIGRyaXZl
ciwgb25seSB1cG9uIHJlcXVlc3QgZnJvbSB0aGUNCj4+IGRldmljZSBmaXJtd2FyZS4NCj4+DQo+
PiBUaGUgY29udHJvbGxlciB1c2VzIE1TSS1YIGludGVycnVwdHMgdG8gbm90aWZ5IHRoZSBob3N0
IG9mIGhvdHBsdWcNCj4+IGV2ZW50cyBpbml0aWF0ZWQgYnkgdGhlIE9DVEVPTiBmaXJtd2FyZS4g
QWRkaXRpb25hbGx5LCB0aGUgZHJpdmVyDQo+PiBhbGxvd3MgdXNlcnMgdG8gZW5hYmxlIG9yIGRp
c2FibGUgaW5kaXZpZHVhbCBmdW5jdGlvbnMgdmlhIHN5c2ZzIHNsb3QNCj4+IGVudHJpZXMsIGFz
IHByb3ZpZGVkIGJ5IHRoZSBQQ0kgaG90cGx1ZyBmcmFtZXdvcmsuDQo+DQo+Q2FuIHdlIHNheSBz
b21ldGhpbmcgaGVyZSBhYm91dCB3aGF0IHRoZSBiZW5lZml0IG9mIHRoaXMgZHJpdmVyIGlzPw0K
PkZvciBleGFtcGxlLCBkb2VzIGl0IHNhdmUgcG93ZXI/DQoNClRoZSBkcml2ZXIgZW5hYmxlcyBo
b3RwbHVnZ2luZyBvZiBub24tY29udHJvbGxlciBmdW5jdGlvbnMgd2l0aGluIHRoZSBkZXZpY2UN
CndpdGhvdXQgcmVxdWlyaW5nIGEgZnVsbHkgaW1wbGVtZW50ZWQgc3dpdGNoLCByZWR1Y2luZyBi
b3RoIHBvd2VyIGNvbnN1bXB0aW9uDQphbmQgcHJvZHVjdCBjb3N0Lg0KDQo+V2hhdCBjYXVzZXMg
dGhlIGZ1bmN0aW9uIDAgZmlybXdhcmUgdG8gcmVxdWVzdCBhIGhvdC1hZGQgb3INCj5ob3QtcmVt
b3ZhbCBvZiBhbm90aGVyIGZ1bmN0aW9uPw0KDQpUaGUgZmlybXdhcmUgd2lsbCBlbmFibGUgdGhl
IHJlcXVpcmVkIG51bWJlciBvZiBub24tY29udHJvbGxlciBmdW5jdGlvbnMgYmFzZWQNCm9uIHJ1
bnRpbWUgZGVtYW5kLCBhbGxvd2luZyBjb250cm9sIG92ZXIgdGhlc2UgZnVuY3Rpb25zLiBGb3Ig
ZXhhbXBsZSwgaW4gYQ0KdkRQQSBzY2VuYXJpbywgZWFjaCBmdW5jdGlvbiBjb3VsZCBhY3QgYXMg
YSBkaWZmZXJlbnQgdHlwZSBvZiBkZXZpY2UgKHN1Y2ggYXMNCm5ldCwgY3J5cHRvLCBvciBzdG9y
YWdlKSBkZXBlbmRpbmcgb24gdGhlIGZpcm13YXJlIGNvbmZpZ3VyYXRpb24uDQoNCkhvdCByZW1v
dmFsIGlzIHVzZWZ1bCBpbiBjYXNlcyBvZiBsaXZlIGZpcm13YXJlIHVwZGF0ZXMuDQoNCkkgd2ls
bCB1cGRhdGUgdGhlIGNvbW1pdCBsb2cgd2l0aCBhYm92ZSBkZXRhaWxzLg0KDQpUaGFua3MsDQpT
aGlqaXRoDQo=


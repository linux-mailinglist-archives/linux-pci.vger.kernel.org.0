Return-Path: <linux-pci+bounces-45186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2693D3AFA1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 553B730028AC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A13596F5;
	Mon, 19 Jan 2026 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mWst53kw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V4Wmtdii"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AA1A285;
	Mon, 19 Jan 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837937; cv=fail; b=T2WTRnhuzzsot4M9Cgp2WX6gNvk9DP6TzgdDBP1TvuRgWN2NcC9z2pMWUIsKUC1O+vbFhLeo1d9Q2pG1yjkUdw1cdPjc0seq4zvH/vz39W9Z99w5jTwVlw3G0SLs/4gZXMoSO/AIgqY5u3L2yI1eChlgcg9qextLO14jiLwU7S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837937; c=relaxed/simple;
	bh=Au25l8QVliKvHVAT4iI8GVmpI8I3Og5ARgZY72Ki8BE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l47CGAzen6hNjZ3mv+oM/g+lUF/z+f97WUqW2/IHrh/N9VJSZeZ757yJ1oi0O+21pni9BJdLK9sXh4r3WPfwmB9UeLESw5d51/0Dnuy2R2FEO5JM3eGmtY1OrOvrDcx9U0gymW9r2pBDHk55hpJHwjRcpot9yTXx+nXoOsYQwbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mWst53kw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V4Wmtdii; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDaTx2083874;
	Mon, 19 Jan 2026 15:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Au25l8QVliKvHVAT4iI8GVmpI8I3Og5ARgZY72Ki8BE=; b=
	mWst53kwLBCh6ZB+3/pS+lBAWSX5948mtRQQLmL224XFcnHoFccBW0kY3PJHzf38
	WDVerrEdyMRZ/44eKCdMohqJYKl/xDejyDixB8LNI0kVgjjh69gnXOV9Dp3L5m7L
	B5orcUmjsfw7WO+cKcWsGpQl3V7c2AsP+H6cT/Zwh7YAneRzr4CFIoLZNVp7Su9D
	1vfnBHjAvLBKBZwvh3dqARIwO7YUgVEojw9iQolmPFXKG76g1DSlj80IJAkXE1LG
	Vkpd+IPQIoNZDSo3mHflNY+GKkNZJyu4VpJ0lif5igkKGWvFzbslRv2vQ69YR9Ip
	vY34ViQP6TGD/N30OIxmJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2fsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 15:52:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEr1Sd007621;
	Mon, 19 Jan 2026 15:52:04 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8hpsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 15:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAaAc4tG62kh4vcKHuyzE1tle2x4iyfjFnM7BKkfS/BBncscyZ7HQx7DUhoZQ1uqHPx9bmyEf23hHzEz5DP5AsVZqYCTQzOWZJ/U2caJljfMJfGvLfu72U4rFoIw3sOFFFBMJq5o6EqAQ7oX0BJHvQLzxRXRjhte55Tw+RIB3lnrC6AgTjtc9Bi/xGD16GsvlImq2HrVvEYzrGwQlIlOK1nuhaKOmRwftOW+q472nEq/uft/Z2Qp7ZoRfVt809kwRkB96j1zfQTEXyqskvYEYAG9DWFEiJWRJ8lt9PJll6VMKOnZPfu+HfRLvj+Anvgq3IwndX7U3tnl6rXpYuo8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au25l8QVliKvHVAT4iI8GVmpI8I3Og5ARgZY72Ki8BE=;
 b=ii3ZZCF1tAvzQR0i26MldTqECKsy2chCuIkFWqw4Abi79jOJmQ77Zkstt3xXZqLJt29nF8O2uqQG4nyNotjTBnqG/Ub/af1peF7sgzEyUuTbhonIR13QH3UKsnGgI9DwwM/N7RyQabdGovjB6UcqIEx5rBcieXHf3x0Z7WPmbEiyhVgJVzcwijCud+WrfQppw5Aof5o4v7Vq+Xg+Ifg4IceXiu7lT4CTm73OUWdM+KujE5c+b1/foiSHU7Yht9Z8nf9x/zgl1Q+kyc/o0JnebZFmLzo8yutvkmYy01TCZYxE+gYptu+u7VnKyzTlWg46vKWR6+MOWwTDmKfax5v+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au25l8QVliKvHVAT4iI8GVmpI8I3Og5ARgZY72Ki8BE=;
 b=V4WmtdiiahsvVXddS6LL1w3qPQEphcCc3n1Pzm2bNVoRYHo9m4osYWHasMwJKxHIvlVwunMs805YL9DbB9a8xcURlxeKnU7yltIIOyNLu5+iI/nm6tL4tm2Em6/ZY3OE8aaQ5KuFw3y/nErvoQz4lVygOM3RuY9tu0VVOQDGlZ0=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:52:02 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 15:52:02 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Johannes Thumshirn <morbidrsa@gmail.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Kenji Kaneshige
	<kaneshige.kenji@jp.fujitsu.com>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Myron
 Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Topic: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Index:
 AQHchLA3J+2ji9rVEUKT1oas/t+7tLVQyAGAgAKYzoCAACNhAIABEyKAgAC4sYCABBvVAIAAQdWA
Date: Mon, 19 Jan 2026 15:52:01 +0000
Message-ID: <D575500A-F203-46A3-A7AE-B9F45B396115@oracle.com>
References: <20260116211135.GA959225@bhelgaas>
 <a3e23d6c-8cbf-42be-8ca9-3fd68dca6998@gmail.com>
In-Reply-To: <a3e23d6c-8cbf-42be-8ca9-3fd68dca6998@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CH2PR10MB4215:EE_
x-ms-office365-filtering-correlation-id: 83249b58-0025-416a-c74a-08de5772afc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEpHeWpMa3BYeVR3WjFNb1h2VlNBbFJEM3VnelUveWNmOTZhZXdWd2RkU0Vw?=
 =?utf-8?B?VW1DaFZaMXN1b1IzYlNaZ3ZxSE9NVGNDZDNKT0pTZHZ5Y2puVkE0cmRpY1hY?=
 =?utf-8?B?VS8vYmx0RVE5eDh2dkZLK1FBam9RakVDQURZWUZ3eVpTUEdlb2xXTUJOVDVJ?=
 =?utf-8?B?M1Q5Z1ZpOWhuRk1EaHA5YURVdzNyTnJZTWEreVYyYjUzS0R2K0VCL2Vjc0Nz?=
 =?utf-8?B?b3JQTjhPZ1JGNVpWbmk0Tjl5Rk5RMzM0bjhDVEVkN2haem9EaE5NRy9VZW1j?=
 =?utf-8?B?UjZ6N2JIYzl2MXZrVnRnTFFOZVFwSExVVDNqRXBLVEdyZm5BZWlzY1UxRTlD?=
 =?utf-8?B?Z1ZuTVlYM3BpRW1ST2pBd3ZoeFVlT3gwNEVWaHM2MXJJQzA5WEV3VFpyUU1V?=
 =?utf-8?B?ck5FbVpxOGhEZC9qdnhJUGQ1bEJGR3BqeDRDS0FZNExuN1E0TlhRWWxkT1R5?=
 =?utf-8?B?VkEzT3VlcUgrS04zbG5tZHlKbHV1QXRKdXdPaHNoT2lCSjBqUW5kMGJvV1dn?=
 =?utf-8?B?TmpLbEJqLzhTUWp3Uk94Rno5WW92RlVYSDc0Nis2MXhOb05jckJadnBJNnIv?=
 =?utf-8?B?cGozbjY1M1RZWnJXRWpQUDRON1owRW5pSEhkOS9vUCt1QTJUYndlbU83UWhT?=
 =?utf-8?B?QmNmOUtPUGxmaWg0T0JlNllPQVdWVTJCRnZxYkxwTWl4emFkc3NGaEZUbE5r?=
 =?utf-8?B?KzFsWi8yNUxBbXRLaVF6ZzR5blU4ZXVxak1icDh5eXpHL0hrTWpOQ0IrZUYy?=
 =?utf-8?B?TmRxUU1zZW5NR05GTE5nZlpOSTl6Y0ZZUTJpY0pGaE1xd2h4TDhHdExXMEVq?=
 =?utf-8?B?MEJmOHBBTnROY1pINVE3THF6Vm1uaFgzdjFqTC9RbTF0NiszZ2tIaHBJVVdy?=
 =?utf-8?B?N2RwZVE4UC9MbDc3WlhodVJsK1J5UWhMdkdNY3NpdVZ2Z01iTGRDRVZYY3V6?=
 =?utf-8?B?SUlkVVNvRERLQmhLdENhNmN6eGFWMzE3Mk9sWE9XdlFkM2RUdk4zb3RlamRU?=
 =?utf-8?B?UjMyQWk5dmpWN3FueE1TaFpNSDZFczBUU1RtbVBOQ0NKOW0zMExQR0JnV3M5?=
 =?utf-8?B?a2FWdEUxWHFoNUVxVFNjRlp5aXpjVEFGcm1NcG56TnQ4YTA3enJsaktVRmRV?=
 =?utf-8?B?ZU0vZWVLRjhRV2dobWdVa1hTZ29XaThIZ3c0YXBmMlhGSTBhK0VyWEhEZGN3?=
 =?utf-8?B?a0pITEpmNnFQRFJhd1NZTExIWVN0Tjh4dm94eGg0WUlWM2VkTzU1Ti96Q1pk?=
 =?utf-8?B?eENJYys0c1V1RjE5MmEybUYxSWtDNVNkME43dnhuSHdvTjV3TEJUcU15NTdh?=
 =?utf-8?B?TjBBcmVkelNubW5kL3kwK3phSDBNOWp5Rm1tQUJBVGNyS3VhR3Y5cVlPSXdN?=
 =?utf-8?B?elh2UU5oNnRlVzBySjdvVVF4ZXV3NVd0Q1A4ZFZiSXE4MzBOa3JXemgxYnNi?=
 =?utf-8?B?V1cwd1doL3BrZHkyNjNiVUp0Q2tKa3BadVpHSkZtWlh1N1Y0OHRRdUs5MXBV?=
 =?utf-8?B?RnpwOGFZYmwxQXJxbWtnR3IwdjhjTm5JS2JwNlpaTjFuWDNONXdYd1QyNDZ1?=
 =?utf-8?B?a3IvdFFjRW1JOHE1UjJsUU5SWEwwZ3IvUlAybHhEK05vZXJSYmlObmhVK1BS?=
 =?utf-8?B?TUI1cTVUNkJUWWlnazQzU2lMT0JyYWpVZFJwY3RqOGVaYjZYbHVuT0QvV0c3?=
 =?utf-8?B?dE1scXdsU2lOdXNsQzJoaEo4N1pWNUxJdzZneHQrbklNRHNrUm5ISzNUS0VG?=
 =?utf-8?B?UFI2NVlUdVhaSE55MTBmQUpONkpta3ZmWHJVWWFMTDFkRVgya2NsN2hOcytx?=
 =?utf-8?B?TnpIT1hmbUFQY2x6Rjc3Tys3YXRtK1Zpd2dBaHozQVAwQ2Fxa3Q3bGZLa1h2?=
 =?utf-8?B?bHo0aFhKaktvTHlKakVIM3JkaFl2YTQ0MzdoK0ltamUrUlN5YXgzRWJ5VkRD?=
 =?utf-8?B?eTZRa0tiUFVES2ZCWFpoRU03Qk81ZklDV0EyRDlOMExCcmMzbVJEQmdsY29t?=
 =?utf-8?B?amJrdHpCVmFjUXY1RXR3ejhmZ3phaUdhaW9POHNlSGZSaytuaWRmVHBwbFph?=
 =?utf-8?B?WEhvVy85U1BOd0dHM3dZSVIvaU1JblRYNTRrV1Y3a1RDckszU2VPc1VGVUVC?=
 =?utf-8?B?aEFpUlF6VWpXQ3ROVitZSDJzaXpuRElnZDJuRSt6STlQeGZrVGdYSEQ5K3M2?=
 =?utf-8?Q?En5YGIkYUmRvNLJMxOl0YVs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXpJS2toR3N3MVdJZGwyWjdWZ2gxNUluZm5OdEJ3WE8zbE1qZkxUL3B4Wk1v?=
 =?utf-8?B?eWYzRG9RdTBhTndMUkMvc0FsR21xQzdSd2NBVlZONTlFVnhTWEM4MXZpOXVN?=
 =?utf-8?B?Ry96M2dDZU9KOEpVNkJ2WGVyaXFWZHg1T1plUEtUUEtqOHdUOTlYZndLRnhX?=
 =?utf-8?B?Qm1hYVVNSWQ1WGxld1J6Y2tRdVhxSkp3MFVaQ3ZxMUlKWnoxRW0weGFZSGZH?=
 =?utf-8?B?azVOdUt4c1BaRnpWa2Q4VlFJeGxCVXNOeDdTOGNKRFhQSnNxQ0t6KzNQM0JS?=
 =?utf-8?B?N1g1K3hBTnBmYXZHN3hpdzNyNjFHc2NyRFdCSllGd0tJVnZWd2pLajhONFNo?=
 =?utf-8?B?aEdGNEcyZndGZ1hyVDBUbFdlVzZjT0VqWWh2cGlyMS9OWEo2dWJiZ0xGYi9q?=
 =?utf-8?B?QnBKREI1UFQwc0tPd0doN3p2UmE3UkpYYmt6blo4b2Q1L1QwRVpsWkE5MEFx?=
 =?utf-8?B?QlMyYzlpYmlnYTlteDBUS2JTTC9YWTBybUNFLzM5eFZKQ045Z2ZhRUdUZjVW?=
 =?utf-8?B?SVhKd0U0VGpkTTRKaDZOQzllNHFSY01sbXl1QlVzaGJ6WE5JTVNEcG55MVpD?=
 =?utf-8?B?bXI5a3pZcW01czhVUERlbHUwbDVSVU11ZHpyY0pyZGNoaHNudTJKK2dvblBX?=
 =?utf-8?B?OUxiMXNOWmhHdXlyd00ra2JYREpHcmVNcW0xSi82c0FCV0x6NC9OaCtFZmJP?=
 =?utf-8?B?Y2hwenFzYzdab2lDZGk3b21qZ0hRYlh6L25pMCthNDdHakY2Y1ZNL0xwTmV5?=
 =?utf-8?B?SHNhM0VHeGR3emNRdmlkNjkvWEJEVGZ5MHFxL09ING5QTGV0cys2UjNvbzAv?=
 =?utf-8?B?cDF6dVBRWmtNamoxV2dLR3NzZGhsTm8xTzhNYnY3QXZ4UVo0bEdQNDJDZVU4?=
 =?utf-8?B?ZUhjNm1HRzZ6SXJYaEw0aG43V0tGM2FPZ2h4NDBzUVpieFh6a2NCT1E4dzRH?=
 =?utf-8?B?V3NvUm0vdmQyZVFjVHFUbEY2a1B6dlB3N3JJMkY1cmVKeXRNN2JJWGN6LzlD?=
 =?utf-8?B?b0Y3N2pVMGhVSm5OaFoySi9FcTRMUGdKVDhPZHJSbldmNGlFelBKdUdmTlg4?=
 =?utf-8?B?L2FWZy84cDFSRVBqNWZvQzJWN3dGTHRJRGZYM2xoWHV1c0tSckJaajF1SDEy?=
 =?utf-8?B?d1hLNWZtWG11VFhCMjBBekJ6MnJybVh1VHAxcUpCZVpyT3J4bXF2MnJLNEdr?=
 =?utf-8?B?TjMrbEVteE1LcFBUckdFTlNqSHl2aUVIaVV5UVBoc1IxWmwyeW5uU3k1WVk3?=
 =?utf-8?B?RzdHUVJLSFBqUUU3eFBseTc2MVZJdEs1VytpLzlaZ2hoWER5ZXBOYysvOExx?=
 =?utf-8?B?SndtM1p1L1dCaWQ2eFVwL3pkTlIxZUEzYkMyRG9WU0t5czhTckNYMHFyVkIy?=
 =?utf-8?B?TGd4SGhPeFk5Q0c5Q3dpRjZiTlBWZCtQYWU1T3MvRlBIWVBMalpXZzI5cTg3?=
 =?utf-8?B?NXV4ZHExSG5vaVd4b0R1V0syMzJHc0FGTjl1cGdzVElESDVFTS9rZUE0NnJr?=
 =?utf-8?B?b0RaWHpSbW9MNldzd1UxbGRNQWJkdmVnZTdSaHVCZmpxcDdJUGI3eDZ1QWlV?=
 =?utf-8?B?MXYvRHlCbFJaY21oYXR2NU52eFdHQy8wZ1lWbzhHeGF4SEZkNm9lK3B3VlZP?=
 =?utf-8?B?YS9mWDh6ak4rQlZYaGxkME54Nm1zc3MxMHZidFdnaEtSN3Y4YllxYlZseElr?=
 =?utf-8?B?S0d3ZEZoRHl6dUpFVnhCMVhCTzkyQ3F1RVVRYWlTa2g5S2QvYm1iSU14bDlt?=
 =?utf-8?B?SWdVT2tKYlc2MjZLK0ZHU1A2TTI2VllhVUwvMmJkS0lweTRFS0YrSmtvZGJr?=
 =?utf-8?B?U24xUnBQb0dNbGErbHZiQW1YSHVUTUh0VHl6bGwxTUZ1dnRYOGk1K0dDOTZq?=
 =?utf-8?B?VXBncmZkNzZvRlN5VnJOOWFndEFIR3hkMHhhNHlnSzZuNWt3RUJISnRiVjFP?=
 =?utf-8?B?QWNUYzdtTmFYZUZiWmV5TmJqMXJFMW4wb3pWUkZHRytZMUg1UFF6RVNZVU5E?=
 =?utf-8?B?Yzg0U1B4aXV6MUJ6ZlZLbUlIQ2t3bGxMVU1MbUlPSDFRUi8vS3R0Ukp6V05v?=
 =?utf-8?B?TmJHSnB3WFpqdGdrTUo1emRlVEY0NWFDZ1FSRW9QVGczMHV0UlFGcnhuNUR5?=
 =?utf-8?B?Wk01blQ3a2oyWXBNVnBYT2tqN3QwV3VHZENnaVhwcWRhckNzMm9aUnlUTDVQ?=
 =?utf-8?B?bUN6OGZkUWlibE1KVCt0OW9iL3dFQnMxTU9JYmJzNUkwZTBDcTB6WERkTHF1?=
 =?utf-8?B?cmhMem8wZTgvTkx5eFlybk5yUmV3TlBUd3FNQWNuelVwL0M1a3EzRFN2Vk1S?=
 =?utf-8?B?a1BCUEFhbzhZMmhjMmtXTkd4a0VSclM4Mi9jRkF4Y1BWV1NsUmVlaXBrYlUz?=
 =?utf-8?Q?8CqdhYffmEg3APJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <111C292E1370164F951F0E94D10CD2B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iffHH1E+iIveCS8gAlJLn60xddiZjHwqBonvvG4sFM695NsoGd/sY0z7a9YP3U6Vif75SCVXNrLYZq7AkljnYPLUow9fA/vWrQHsyXY7G8H+Zx7QAWCjMfzHMOsJK9TfeSNKseghVw40ZJY6KHk6qsjQGWg3qN6rA5qHzWQNWL4OGyV1KRpOMiTRmV37lMue/DEX5Q8Oyh7gb3988BHBbD8XZpNfTeMUH65HpqODIc608AOciO7hNMEws8pCXJUcuwEu7l9lzs7WFmR8pG4UIE/W0+5DDgXPC/WlW+zunXVKDhiy48istJ2KmsvVrrnroM4PY0LC7uCAhi8eH8qCs8pN7vHSR/x37g0QRhwKp1CCFeOq1WbpIElG+63OI6xzWKVlbEQtYWjf7QEM/odhgfVJ8P0eBq68Ez//ODJ6W/xJP6IgrtDuxxdS+2ezZZwEZDvJI/zL+Uo49pGw4j3vhxK0U9ZUq5Li9C6AIkfd8ah8GcPOxTHYEqp1mdwG6vJgH5cCsdMBkovjbcJpfOv6MKBmEwNp4G1Q8nHQNRE/vlbbb+n1gIFwJBovGHOwc4dnEIvGxUe322gSA5ps0foZ7n7bCjRgIgJWgoW/hQtdSDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83249b58-0025-416a-c74a-08de5772afc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 15:52:01.9870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIhMDTnqmZJSMUVJ1B/9Z4mPgLJYhuZZt0/qVC5E9KjTox9Shl4oswUyfe8fjVQoK6FJmHpm8PCGw/OMWaVuUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEzMiBTYWx0ZWRfX18MqqmYufUrQ
 h5HyxG2qXiJenctIK0xcShEJhmZ8MbWr0fjY+ywAicbEjNNbsAM6NEBdVcnzx90I+DQUDCh+wqf
 lvM39QuaFWASP9Poj9BkNYd6laG8DUGOFkKN/O9ihb3xPDgVx+UQQ3REMDrbcxfEij7kZYe+UZD
 cv91Uv08V+a9iNV/DshhDMfPVGxhjc5hyflz/yovsFGVSNN9GPVeDNeOHu7ueSz6ZzcC/XiQcto
 FQOqrD54h9TWo7KARUX+Lu78U8qEcUiUw/iE3FQ2z9B82/Hroy+qHbMV3OW74ECt3ns07Vl98jZ
 8VaTt1yi4L60DsC7qbB70LikuSyWW+4AfCcH1p/s9v2UGZUAZkQc083Il3gl9TBtkEqCUrfuFnc
 VpSYUp97PTUtkIb4jLBXnKBd4tMTXDYA0iTDWNxjuwV21q8lmwq1auXK87Ah4xPEw11Z800rMKo
 92K3/JJ2YDqSCdNTVTg==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e5325 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=ynaPe9QSr-J_ydelOZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d7dYEwRS55ZOJcPtWzPP1PcFo-3MJ0mp
X-Proofpoint-GUID: d7dYEwRS55ZOJcPtWzPP1PcFo-3MJ0mp

DQoNCj4gT24gMTkgSmFuIDIwMjYsIGF0IDEyOjU2LCBKb2hhbm5lcyBUaHVtc2hpcm4gPG1vcmJp
ZHJzYUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMS8xNi8yNiAxMDoxMSBQTSwgQmpvcm4g
SGVsZ2FhcyB3cm90ZToNCj4+IFsrY2MgSm9oYW5uZXMgKGF1dGhvciBvZiBlNDIwMTBkODIwN2Yg
KCJQQ0k6IFNldCBSZWFkIENvbXBsZXRpb24NCj4+IEJvdW5kYXJ5IHRvIDEyOCBpZmYgUm9vdCBQ
b3J0IHN1cHBvcnRzIGl0IChfSFBYKSIpLCBNeXJvbjsgc3RhcnQgb2YNCj4+IHRocmVhZDoNCj4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjAxMTMxNzE1MjIuMzQ0NjQwNy0xLWhhYWtv
bi5idWdnZUBvcmFjbGUuY29tXQ0KPj4gDQo+PiBPbiBGcmksIEphbiAxNiwgMjAyNiBhdCAxMDox
MDo0M0FNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+Pj4+IE9uIFRodSwgSmFuIDE1LCAy
MDI2IGF0IDAzOjM5OjIxUE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+Pj4+IFRoYW5r
cyBmb3IgdGhlIHJldmlldywgQmrDuHJuIQ0KPj4+Pj4gLi4uDQo+PiBJIHNob3VsZCBoYXZlIG1l
bnRpb25lZCB0aGlzIGVhcmxpZXIsIGJ1dCBJIHRoaW5rIHRoZSBjb21taXQgbG9nDQo+PiBzaG91
bGQgaW5jbHVkZSBzb21ldGhpbmcgYWJvdXQgdGhlIHByb2JsZW0gdGhpcyBjaGFuZ2UgZml4ZXMu
ICBJDQo+PiBhc3N1bWUgdGhhdCB0aGUgY3VycmVudCBjb2RlIGNoYW5nZXMgRXh0VGFnIGFuZC9v
ciBSTywgYW5kIHRoYXQgY2F1c2VzDQo+PiBzb21ldGhpbmcgYmFkLiAgVGhhdCdzIHdoYXQgaXMg
bW90aXZhdGluZyB0aGlzIGNoYW5nZS4NCg0KSW5kZWVkLCB0aGUgY29tbWl0IGxvZyBjb250YWlu
czoNCg0KICAgIFNvLCBpbiBvcmRlciB0byBwcmVzZXJ2ZSB0aGUgbm9uLUFFUiBiaXRzIGluIFBD
SWUgRGV2aWNlIENvbnRyb2wsIGluDQogICAgcGFydGljdWxhciB0aGUgcGVyZm9ybWFuY2Ugc2Vu
c2l0aXZlIEV4dFRhZyBhbmQgUk8sIHdlIG1ha2Ugc3VyZQ0KICAgIHByb2dyYW1faHB4X3R5cGUy
KCkgaWYgY2FsbGVkLCBkb2Vzbid0IG1vZGlmeSBhbnkgbm9uLUFFUiBiaXRzLg0KDQoNClNob3Vs
ZCBJIGJlIG1vcmUgc3BlY2lmaWM/DQoNCkkgb2JzZXJ2ZWQgfjE1JSBoaWdoZXIgSS9PIHJhdGVz
IHdoZW4gRXh0VGFnIGFuZCBSTyB3ZXJlIG5vdCByZXNldCBvbiB0aGUgc3lzdGVtIHRoYXQgaGFk
IHRoZSAiYnJva2VuIiB0eXBlIDIgcmVjb3JkLg0KDQoNCj4+Pj4+Pj4gaWYgKHBjaWVfY2FwX2hh
c19sbmtjdGwoZGV2KSkgew0KPj4+Pj4+PiArIHUxNiBsbmtjdGw7DQo+Pj4+Pj4+IA0KPj4+Pj4+
PiAtIC8qDQo+Pj4+Pj4+IC0gICogSWYgdGhlIFJvb3QgUG9ydCBzdXBwb3J0cyBSZWFkIENvbXBs
ZXRpb24gQm91bmRhcnkgb2YNCj4+Pj4+Pj4gLSAgKiAxMjgsIHNldCBSQ0IgdG8gMTI4LiAgT3Ro
ZXJ3aXNlLCBjbGVhciBpdC4NCj4+Pj4+Pj4gLSAgKi8NCj4+Pj4+Pj4gLSBocHgtPnBjaV9leHBf
bG5rY3RsX2FuZCB8PSBQQ0lfRVhQX0xOS0NUTF9SQ0I7DQo+Pj4+Pj4+IC0gaHB4LT5wY2lfZXhw
X2xua2N0bF9vciAmPSB+UENJX0VYUF9MTktDVExfUkNCOw0KPj4+Pj4+PiAtIGlmIChwY2llX3Jv
b3RfcmNiX3NldChkZXYpKQ0KPj4+Pj4+PiAtIGhweC0+cGNpX2V4cF9sbmtjdGxfb3IgfD0gUENJ
X0VYUF9MTktDVExfUkNCOw0KPj4+Pj4+PiAtDQo+Pj4+Pj4+IC0gcGNpZV9jYXBhYmlsaXR5X2Ns
ZWFyX2FuZF9zZXRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLA0KPj4+Pj4+PiAtIH5ocHgtPnBj
aV9leHBfbG5rY3RsX2FuZCwgaHB4LT5wY2lfZXhwX2xua2N0bF9vcik7DQo+Pj4+Pj4+ICsgcGNp
ZV9jYXBhYmlsaXR5X3JlYWRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4+
Pj4+Pj4gKyBpZiAobG5rY3RsKQ0KPj4+Pj4+PiArIHBjaV93YXJuKGRldiwgIlNvbWUgYml0cyBp
biBQQ0llIExpbmsgQ29udHJvbCBhcmUgc2V0OiAweCUwNHhcbiIsDQo+Pj4+Pj4+ICsgIGxua2N0
bCk7DQo+Pj4+Pj4+IA0KPj4+Pj4+IFNvcnJ5LCBJIHdhc24ndCBjbGVhciBhYm91dCB0aGlzLiAg
SSBtZWFudCB0aGF0IHdlIGNvdWxkIGxvZyB0aGUNCj4+Pj4+PiBMTktDVEwgQU5EL09SIHZhbHVl
cyBmcm9tIF9IUFgsIG5vdCB0aGUgdmFsdWVzIGZyb20NCj4+Pj4+PiBQQ0lfRVhQX0xOS0NUTCBp
dHNlbGYuICBUaGVyZSB3aWxsIGRlZmluaXRlbHkgYmUgYml0cyBzZXQgaW4NCj4+Pj4+PiBQQ0lf
RVhQX0xOS0NUTCBpbiBub3JtYWwgb3BlcmF0aW9uLCB3aGljaCBpcyBwZXJmZWN0bHkgZmluZS4N
Cj4+Pj4+PiANCj4+Pj4+PiBCdXQgaWYgcGNpX2V4cF9sbmtjdGxfYW5kIG9yIHBjaV9leHBfbG5r
Y3RsX29yIGFyZSBub24temVybywgdGhlDQo+Pj4+Pj4gcGxhdGZvcm0gaXMgdGVsbGluZyB1cyB0
byBkbyBzb21ldGhpbmcsIGFuZCB3ZSdyZSBpZ25vcmluZyBpdC4NCj4+Pj4+PiAqVGhhdCdzKiB3
aGF0IEkgdGhpbmsgd2UgbWlnaHQgd2FudCB0byBrbm93IGFib3V0LiAgcGNpX2luZm8oKQ0KPj4+
Pj4+IGlzIHByb2JhYmx5IHN1ZmZpY2llbnQ7IHRoZSB1c2VyIGRvZXNuJ3QgbmVlZCB0byAqZG8q
IGFueXRoaW5nDQo+Pj4+Pj4gd2l0aCBpdCwgSSBqdXN0IHdhbnQgaXQgaW4gY2FzZSB3ZSBuZWVk
IHRvIGRlYnVnIGFuIGlzc3VlLg0KPj4+Pj4gTXkgYmFkLCBZZXMsIHRoYXQgbWFrZXMgbW9yZSBz
ZW5zZSB0byBtZS4gQW5kLCB5b3UncmUgT0sgd2l0aA0KPj4+Pj4gcmVtb3ZpbmcgdGhlIFJDQiB0
d2Vha2luZyBhcyB3ZWxsPw0KPj4+PiBHb29kIHF1ZXN0aW9uLiAgTXkgaG9wZSBpcyB0aGF0IHRo
ZSBjb2RlIGhlcmUgaXMganVzdCB0byBtYWtlIHN1cmUNCj4+Pj4gdGhhdCB3ZSBkb24ndCAqY2xl
YXIqIFBDSV9FWFBfTE5LQ1RMX1JDQiB3aGVuIHdlIHdhbnQgaXQgc2V0IGJ1dCBhDQo+Pj4+IHR5
cGUgMiByZWNvcmQgbWlnaHQgY2xlYXIgaXQgYnkgbWlzdGFrZS4NCj4+PiBDb21taXQgZTQyMDEw
ZDgyMDdmICgiUENJOiBTZXQgUmVhZCBDb21wbGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYNCj4+
PiBSb290IFBvcnQgc3VwcG9ydHMgaXQgKF9IUFgpIikgZml4ZXMgdGhlICJvcHBvc2l0ZSIgY2Fz
ZSwgd2hlcmUgX0hQWA0KPj4+IHNldHMgdGhlIFJDQiBldmVuIHRob3VnaCB0aGUgUkMgZG9lcyBu
b3Qgc3VwcG9ydCBpdC4gVGhhdCBjb21taXQNCj4+PiByZW1vdmVzIGFueSBSQ0Igc2V0dGluZyBm
cm9tIHRoZSB0eXBlIDIgcmVjb3JkIGZyb20gdGhlIGVxdWF0aW9uLA0KPj4+IGFuZCBzZXRzIFJD
QiBpZiB0aGUgUkMgaGFzIHRoZSBiaXQgc2V0LiBBbmQgdG8gbWUsIHRoYXQgc2VlbXMgdG8gYmUN
Cj4+PiB0aGUgY29ycmVjdCBiZWhhdmlvdXIuDQo+PiBUaGFua3MgZm9yIGRpZ2dpbmcgaW50byB0
aGF0LiAgWW91J3JlIHJpZ2h0IHRoYXQgaXQgbG9va3MgbGlrZQ0KPj4gZTQyMDEwZDgyMDdmICgi
UENJOiBTZXQgUmVhZCBDb21wbGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYgUm9vdCBQb3J0DQo+
PiBzdXBwb3J0cyBpdCAoX0hQWCkiKSB3YXMgbW90aXZhdGVkIGJ5IGEgbWFjaGluZSB3aXRoIGEg
Um9vdCBQb3J0IHdpdGgNCj4+IFBDSV9FWFBfTE5LQ1RMX1JDQiBjbGVhcmVkLCBidXQgYW4gX0hQ
WCByZWNvcmQgdGVsbGluZyB1cyB0byBzZXQNCj4+IFBDSV9FWFBfTE5LQ1RMX1JDQi4NCj4gDQo+
IElJUkMgKHRoaXMgaXMgbmVhcmx5IDEwIHllYXJzIG9sZCkgdGhhdCdzIGJlZW4gdGhlIGNhc2Uu
IEJ1dCBiYWNrIHRoZW4gaXQgY2xlYXJseSB3YXMgYSBiaW9zIGlzc3VlLCBidXQgd2UgZGVjaWRl
ZCB0byBmaXggaXQgaW4gdGhlIGtlcm5lbCBpZiBteSBtZW1vcnkgc2VydmVzIG1lIHdlbGwuDQoN
ClllcywgbG9va3MgbGlrZSB3ZSBhcmUgYWxpZ25lZC4gV2lsbCBzZW5kIGEgdjIsIHdoaWNoIHdp
bGwgYmUgYSB0d28gY29tbWl0IHNlcmllcywgYW5kIHdlIHRha2UgaXQgZnJvbSB0aGVyZS4NCg0K
DQpUaHhzLCBIw6Vrb24NCg0KPiANCg0K


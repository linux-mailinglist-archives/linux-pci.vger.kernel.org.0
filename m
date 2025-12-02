Return-Path: <linux-pci+bounces-42480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99DC9BABD
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143DB3A295C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2431AF36;
	Tue,  2 Dec 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZqDuEpxS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1rTrOoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31713115BD;
	Tue,  2 Dec 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683436; cv=fail; b=U2zjwqHhxsTfYqJaes8R5pFoZmAsYQvpSYtFHGRP0gEbXj8Hfv4vKk4XFj8gxwlbrUbetUAb0elq5x9Z1/S8T/XmClQ5gBwHlu9RjD4Xuq6NGvjqFs/5x5MSePpDelGLK/8CdSejTE3aeesdhFpalII9eZ3qBL7/rLiT6d4lIwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683436; c=relaxed/simple;
	bh=C4omT11XnPpwYP+mG7uYmc/i8D9ZURQv2qU+RN7HNQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejI1Xhruiv1RxhyDq9dUh6dgaqnYgfQQakuVXhmPwTr3gMXFcOM134GRXvZgeQdn5NgE8Vry1/fBk6GM9CEWyVdXHXC1JhQx3fNJJ5KoYelhI1f19TqaHghYkdlYBnm+TDRYT5doWlELYd7BgSPBV0XEt5CQVQaaCWVhurAS3HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZqDuEpxS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1rTrOoW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2Bvc3Z187940;
	Tue, 2 Dec 2025 13:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cVasI6ZhNfP96HxwheS1xSfh6ApOh9B7jXD5C5JgT6E=; b=
	ZqDuEpxS07lArescLX/Qvv3hEgQeD4MXWQ4EsVJTvuFubEyEbE+hFUAKG1PhGhk1
	TIIUoU3lN4xYghxv3aqg8H2PKx6/l4aOknrLyMx0vnO8THCy72Yt8VbF8c5N4U84
	PCJgCT4XXj1ititjuCFE/dUiN+Fn4hPSK/ptqmdNioUOXh3VQ/aN+z3R3eoHpXUh
	Z++4RXM5CwBssY/NTBvVVnji90rdGU32khAX5zZOz9C7viL5Ps/rGPbjFBQCXcgD
	QDrsX6QUH/T8QCPYVHtOvIlXpiiQlWO4eU7XG3K2T8Tm+Tw3C/QdouU8qBi+p8z0
	m2kkfd+lbkAXGhzjQbkoXg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as845twdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 13:50:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2DRSBt016600;
	Tue, 2 Dec 2025 13:50:03 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq994cv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 13:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/j6XcEJINtAdopuIOAA4/7FALQm2FeEPnr/P8cXUokWvS0rHjNI5TsAgvEsZRccdYhVwOlsKICRVg/ZYA2AMyQnVVLlExdOG8EERX/qYdLoEEYq0WayKzeW5cNdPkgzycXhquzEarDWYyK0ozrgLMqN93Ps2WO/VZ+0m/YNqvVB7wZPWMEw7FT0+d9p0PSaDx+Bw/MPLgFpjSQ/U5STld2s47lcGaq/d5RadDTaW7byZsxLuoJg8Qw36X+7XotU2+I9v0MoElVxF5FkvLvq8CcmnkZpJK6utrB1lmkuJZ6Y8v+BaiuiG1fiGdSTm/HA+w9lCpxhv2ExgpMqLUdslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVasI6ZhNfP96HxwheS1xSfh6ApOh9B7jXD5C5JgT6E=;
 b=EHmlXWUOyS3d57JIwaf6vxRWZZTPF4J/e0LK/Gc1pkuqYbJ5tMdX4P/80mSe1v8MwGtxBPcIXevgr6fwMgyexVzUfazEzv9gYngnZGv3k8OHiE8PbqL166iM3uHHphpjjqCSzGXBYSJ65IFTi1AefZn7HB03D8Ednf0/jpmCDpzWSUUtU/oxX4i9JPjRhZbP0iacQkyu0Cx1wB2qkNQUXXU765+ENUNmFBq3IjtiWNS6ad9eghs+3L5CwobDaJ7i5pWneDFRu2sKOrddj0d7Ma7Z0a6bF/2XgHgQJ0lTbdscucaYwrIeDlOdBiTbRtVdKVOX2gvOzUoM6k2MGM9vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVasI6ZhNfP96HxwheS1xSfh6ApOh9B7jXD5C5JgT6E=;
 b=i1rTrOoWn7+d/ZXUwlnv2ir7YRbIfz2H54Ha850xdjDdIfCXQvnYhs/xLWlA5lYt/XnK94yvN3m8r8vaPxybz5exS26L0nk2bZpSOiPqMID9g1aIjd+Z0rSd7oRLvH4mwojdwY8wvM4lKE6x4q5RPvl3vwP06IzrJEjpi1XctGA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:49:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 13:49:57 +0000
Message-ID: <3be03057-2a83-46e5-b120-bb041208c694@oracle.com>
Date: Tue, 2 Dec 2025 19:19:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ashishk@purestorage.com, bamstadt@purestorage.com, msaggi@purestorage.com,
        sconnor@purestorage.com, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: d6645cae-c48f-4236-f83c-08de31a9ae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THRLSGJoUTZhcXRGZnZiZ2h4MjJqSHcxamtjMzhoWmord1htMmpZc1pnR0pi?=
 =?utf-8?B?QklMNW9RMUtMS1ZWajJDTnNwS3ltNXE5Nzl3ZWdxemUyRWhlMy9Vczg1RU84?=
 =?utf-8?B?NmpmMFk2ZW1reUJ2cU81VE9XUzZWLzlqT08vVkQ3TUpXVlIxUEtnR2h0cnhx?=
 =?utf-8?B?ZE8vN1NzOW9mU25nVDJRRmRaMk9hNmE4aEJNWXNnWlY4a0xuYkFkSDI0ZHVa?=
 =?utf-8?B?eEJ0TGNJOHlHNUlEemNzSzhSR1BWS3RMbVc2b0V2alNrZkpSL1lyUEYyUXNX?=
 =?utf-8?B?TlBJMnppTFVrVXhiT3RnMnZhdG1pVVFCYm1Rbmc2SXZ4bUtIYTU3eXRxTVdk?=
 =?utf-8?B?YWQzZ2puVzZGZ3VMNDI1cDNUZFF3UlA5aHE5b2t4b2pOTnJ4cDB6Y1pySTRK?=
 =?utf-8?B?RC8rQUxJNFFYd0d0UHJjbjVzcVE5cXRLY3ppY2lxcGNPZUZOT1VSS0ZkWkEy?=
 =?utf-8?B?Nk9zVWh1UWN2M2NWVXUvbGdLaERsbmF2VlpaYUZCNXl4c0hINm5IU1pZOGdU?=
 =?utf-8?B?NmZjNy9ObEZ6aHExY05HbU5yUzFjb3hNenJnQXNwc1Zkc3p3aGtoaHNUWVJa?=
 =?utf-8?B?YU0wWDd3QUVpNmZ2bGZSb05KRUsrT1YzK2owL1A4eHRQTk9CNm84Q2tZaDFZ?=
 =?utf-8?B?dXM4UU9vbEdlbnY3ZWJRQ0I1Wjh6Y2JLUWpjZ0pUNlZxWklKVlorc3laOFlG?=
 =?utf-8?B?VjVBN1B6MFZDRmlVQzRnRzNXUHZjaVE5aExVUko5TVhoN04reGZ1dFgvbU5C?=
 =?utf-8?B?dENSNlhHdFNFb3JDdW41TGZOSGpHdzFkZnZvTWtQRjFVa3B5NnRhTDR2U0Iy?=
 =?utf-8?B?K2t1a3JTalIzWHJ1cnhNb3BMelRzcXl6NFluNkJnK1E1WXRWRXFCQ1hhcTVj?=
 =?utf-8?B?Mlh6ZkNTOVZ1UjVXY2R2emc1VVJGeHpQK0dRUjJZSEVpeW1ldFo0bUI0bnU1?=
 =?utf-8?B?ZGN1QVNheWNwbFUxbk1WT29nNUxrbXQzUUdLWlhnc3BNTlVpeGlkaXV0OFNW?=
 =?utf-8?B?ZXNrYXJ4bDhnREtUMUFKMTlnNHBwNzhnMVB0dEd2MTdCcFNxZFhubWZIYzhX?=
 =?utf-8?B?L29ldzlWQ09reklDS1l0a3FKQmw3ZmF0UEFMV2tuTGk2VXcxN3VHVlY4RjNC?=
 =?utf-8?B?NExuV0VISThIM2lmMTVUMjJDbEVQdGw2MGRnSng4TU8xVlFwQnh6anlNditX?=
 =?utf-8?B?by9jb1cxL3VUT29IOG5LL25nU0EyRExYdnFBZkt6OGo0Y0NtdkJtS1hVTFpV?=
 =?utf-8?B?NkFSak5mZ2ZHQkU3b2EvclRGZE12dXRrVG51cFJ0YlNGU3hNU0dPS0dYbWJL?=
 =?utf-8?B?NUVRSHRhZ0VwQnE0YmF5VjRRUVNRRHBudzRGTUFqTFFEdnprOXpnN1c2b1ha?=
 =?utf-8?B?Q1ZrcE9kd3VQVVdUUlNaeEhGZW1Bb3Z1VVgralkzTDg0MXJjNWptSUczNU9v?=
 =?utf-8?B?TFNhdGNWNHVXUkVaeUdFdzZ3S0kxbVpGdWsvdGMxaFNoaHI1UUNrVnNiOU9X?=
 =?utf-8?B?Z0tnRUJoTUtkb0x6Z3RrTDk0d1hYZ3crNHpJd3ZNUWg2QzJnMkxQVzFoYzI0?=
 =?utf-8?B?R09MbmlKamsxeEdVemNXSm1Sd3ZSQlBKdXVMZnJCbUk4MzBCcCtBWGdPb0V3?=
 =?utf-8?B?RUJsczJLdWtLcWQrS29RUmEyRkNJQlE4cHBvQ3ROUjJENVY2cVdnUlRSVVY1?=
 =?utf-8?B?UWpzQmJVRDJES1ZZNWxJTVZPWVNsaENicldXWXFkUzQ5VzRFMFNoRkVhRmpv?=
 =?utf-8?B?MWdmdENuYVFGdWtKQmQ1bGFUeHdRNmRHVXV5YXVtbG9OdCtxZ1prWlkyeHRJ?=
 =?utf-8?B?RHlleWdIYlZ0c1ZXMjhZcGdmbjdPWDJPekdEUUg3SVNtbTFrU2Vlbi9JT1d2?=
 =?utf-8?B?WmVRWE5EMURSTXJYUHlpOGhOYUJVK3F0dmFsTE8xMnRzRnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2dQeCtiTmlsMEkwa1N6YUZ1WWtJSlBTaHhXR0hYUXB4dnJDdDB2czhQV1ZS?=
 =?utf-8?B?VG43Zk5XMjFsbFE1NEpuVEsxbWpNakhzUGVhc0xVSTYvOGQ5bEdWaklVYzBV?=
 =?utf-8?B?aUFPa1VBcmdLOXkxUmlDODZWcXpWN3BrMU0wMlJVdEJyODY2Nmg0dHJ0ODlM?=
 =?utf-8?B?N0dFSXB3VStlZXYrQlBUSzIvNmJiVEszVkNTTGpwcGthUUdHd1VHU01HMjBx?=
 =?utf-8?B?eHM1ZEdLaUhuUkIwd3BtQmFvS1JWNVlZK3laTGJtRzZGNGFhRmZXRmY0amRG?=
 =?utf-8?B?T0pWUGtNSGpLRmJtK05IZEovZEpaOWNyTHdBNGNlcGlabDBrbSthNDR3VDIy?=
 =?utf-8?B?ZzNiNkRoRXJrTEVWRzl6TTRScWlaQ3dBUGVkN3NDWXBCbEJqRFNkd1lwLzAw?=
 =?utf-8?B?ZitLS2locm05c0hMUExSUlpDYVVaOFpucjZNc0pqbVEzRmhoLzNLb1daWFQv?=
 =?utf-8?B?N3dTVkxyODhrV012M2cvNDFyNFRvZVdZdTBPb3NOS25mU0R5YWVWYW5sQ0l3?=
 =?utf-8?B?YnVPOFgvMDhSZHlZME1GZ2ZMT0ZGUmc0YjBhVXE3K3VnLzdWK3d6djM1RGs5?=
 =?utf-8?B?em5pTVQxL3hVak5DUmxnanBYa3o4RW4wc2hZUGRUSXpnSWZPRFdLeG5DcDlt?=
 =?utf-8?B?VUFxcEtCcFdWdU5RR1FrUW1lRnJRR3VvZkoxZHZBT241OHZOZmVsYTMrMVll?=
 =?utf-8?B?cmpRSUQ2dnV4ZEtRZFVWSk5TYWxhVEswaDY5UDM2bWJWQ3lMRkZiU283K1lj?=
 =?utf-8?B?djYrZmg1YTBqTEF0S2hvNFdXbHppV0l3SlE5dXpKUi9EaHEydDdsUU5qL1dh?=
 =?utf-8?B?eS9ScnRTZXZ5WVZkNS9wM0duN3k5RzdLTjBFMVhqakNjTGR6UktkbGlRbk5s?=
 =?utf-8?B?WUdhMDJSczJXUXRHTFNZZXNCSXRReDJwYkNyYzIwUVhYTm1lOFRrcE9YY21B?=
 =?utf-8?B?bUNqU3pMdkZiVklhWDUybzVsSnBsRHVyNXJNVnB5TkVVTWpveEpVNVVpUVZN?=
 =?utf-8?B?MEVTZkVUUE95Q2RCdmVBRlExQWtsbHE5TVJaNlBZN3RvWEwrSWVtY0RSU2Yv?=
 =?utf-8?B?bmp6NzZRYllKek04WG1VOGpnNEkrZlArZ09LM0FIN0ROVHhUM2kweldrcTZx?=
 =?utf-8?B?TTVOOXZWOWVEZWZQK09NNGJOZDBZMG9TRzBIbGxVL215TVJkQ1pqdG8zSmFx?=
 =?utf-8?B?UVFxbnJMcU45L0ZJRFBsUTI5UUlaWnUweUozUmtyRDdSMXFZYmZnYURsNmdw?=
 =?utf-8?B?dURUSkVDMnZQaklLVFNLYUhQUjhWVFRtT29ubW5qSGlLK2FDY2xUdzJZcVhY?=
 =?utf-8?B?V3d0dkNScldENHVkTFJDankrOFIzOUgxa2xCc1lVMndFR3lNdDNuT2V0UnQv?=
 =?utf-8?B?VExsK1l5K29IMWxYTlpXdTZsQVhUTFVhb21lK3dOZUxoQjJFTW8yOXJNcUNC?=
 =?utf-8?B?UUJUR29BeUlaYWJlVlFGUmkwVGo4RXRvQVJvQjEzcHlVVkJYcHVzRXFHa1Vu?=
 =?utf-8?B?TVRsYVlRRERZMlNNMlljWWdHQWlTT1ZxU0pBWC95clVLUHFLa1E3b3lrcnZi?=
 =?utf-8?B?ZEtpclY5V0s4ampzUmI2aHdTTXAvOGZZcWNJRUlpQW1kM0k0cmZ0WExyVTlu?=
 =?utf-8?B?Z3Bvb1NvUW9oK3Q2NzRSMFRqejR0c0hFM01zYTR0VmlneDRtU0ZwRG4xMStx?=
 =?utf-8?B?TGtadUxDc3VVaW9FelZ0VUtHM3E2Q3pHMU43NlV3a1RKNW53b0xIa0k2bzNL?=
 =?utf-8?B?bVM4dnB0TWRaYXNjKzZjRTZBa2thd3h4N3RMT2FPYk5yUUp1M3dTdllTdEcx?=
 =?utf-8?B?aWFYUktQU01laFJzVWpqUUdXa3QxOCs2T0lKV3JXems0d1Y2dGRqZExtQjRV?=
 =?utf-8?B?OG1lNVRXQWlmT3VpT1pYWHVNOUh3K3VnbG5PdTdVTnpQWGw3amdsenZXTk9V?=
 =?utf-8?B?NStPdUd2Q1Fsamo2V3JZYmNzMzhta0FYODIvV0tEaTA2STBrMlJnTDVUbFBU?=
 =?utf-8?B?MjE3OXpsWGFSWmg2ellMdkQ0cFpkaVMzT3E1cU1BeklUMzFyZWlMZis2Q2RH?=
 =?utf-8?B?ZEdFSFpYR1BjTGI3a0JNTHhaa012MmdYcWlzY1FCaWNEVmNjWDg1aDNGeFJm?=
 =?utf-8?B?eTltQ0R5NzVmVUdUR051ZXJNZGNGdTkrYnJvcG9YMHYzdXUwbXlDQlN6QTZC?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oO9XyOgSEueDU4Y1ATZWi7M75byF5OHwtsvwQzm+nM4SY2dYC1GlXiAdgQ4inB+0B2hOe1EHzvsOT9TVw7Qib1Uxx5fVdVKeK8S8XeUyMzBq8CiobR7p3EMK1i3hOWjicR9+b1VWIxWuXaPpKsotvZQbubIer+8n+8GhQ8uQjB5qjU8qzfbPmNHDbRW67NDfMyWgGcLJW6sbB3olI8fMltw/nNC3BC0Y6agQ4Ro4u9hCLyxKruM4tDVbK4QNkJ+VEsA3am8PHgEWvT3f8CVJGzNhcHXAxlZ+2Pxks213rmHO0NsfZde8YY8MqxCReoxsF8ctTYqXq4rFY5xLuRsC1q+e130fom09hEweNHV+lOy2f6rVSdpi6n82fpu8EqtERAy93WQ6PgiV0WVVb1WD3zdPKVtJhZXeChc762XqaBG4biW7p6LnZ5HXB3TOZRkHTDZd+oVqPBo8gCP4CoY8keAjaBfSvdg6V1zLX/+BLsmUGbvuoEmoWrGpj/UAg21vXQfIczROQVxvfqhnFXhoqcDk+ETeyixArlh8wAizLkF29Ie0yPKnHYXZroR4D6PuAq7WGtNECYaHGw3rriPiElGBLYmKmFzSiSwXe4/GShA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6645cae-c48f-4236-f83c-08de31a9ae48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 13:49:57.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqBhszKfKTAFcJo6i94hd/ARVFH5MR1eSKnc702V2/pkI+Ae7Qusf5LBaP0nd9sLvyq1Mq/Fa68SsNpnN2KQdAMxCB+1o+DxDTOPVjK2rwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020111
X-Proofpoint-ORIG-GUID: 0WbgNeRAN_H-M-WOyh8lhBkDoUtIVoC3
X-Proofpoint-GUID: 0WbgNeRAN_H-M-WOyh8lhBkDoUtIVoC3
X-Authority-Analysis: v=2.4 cv=W8w1lBWk c=1 sm=1 tr=0 ts=692eee8b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BcPKCTjPAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZZqp3ZWnn2DKEqsU45kA:9
 a=QEXdDO2ut3YA:10 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExMCBTYWx0ZWRfX6MAGYa4ZjUuT
 J6XKIaO/k98IbLDRYuRBqRvwZMUgdpOaiux1833gcoZJ4pXBhZQQJ4B6hHGA2YLlzv19kqbYuYb
 gKPJj0FPvTELnvnl6ub+q5HVXVlj2DqxIpPSSSdOL9PMliMnC/YxF85QHtU4L9DHmlfGnya6NVM
 DKA35qUQKW7ODmeaony/rX+Wu3lcAaluU3s2rtzgHUaJcpU96WXaAznYqSA3SFXRJ9OcHPO3N35
 J0imrH66X1BNojN1Q/3DnnhdX0hRm2kCUDcwLuqbGFy/KDbf5Sg/9+jtuNOtfibHJMwUFcpaNIy
 nXqHZJWiBHLjEBp5B62Q5j5CIG5wquMKowspEQxodiNI/hIG/gbgXjEHjkzs/md0BzjEnEdGosK
 X7rhO1cpnPY/yjdZx1J62EqbAGMjNw==



On 12/1/2025 9:22 AM, Maciej W. Rozycki wrote:
> Discard Vendor:Device ID matching in the PCIe failed link retraining
> quirk and ignore the link status for the removal of the 2.5GT/s speed
> clamp, whether applied by the quirk itself or the firmware earlier on.
> Revert to the original target link speed if this final link retraining
> has failed.
> 
> This is so that link training noise in hot-plug scenarios does not make
> a link remain clamped to the 2.5GT/s speed where an event race has led
> the quirk to apply the speed clamp for one device, only to leave it in
> place for a subsequent device to be plugged in.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Signed-off-by: Maciej W. Rozycki<macro@orcam.me.uk>
> Cc:<stable@vger.kernel.org> # v6.5+
> ---
>   drivers/pci/quirks.c |   50 ++++++++++++++++++--------------------------------
>   1 file changed, 18 insertions(+), 32 deletions(-)
> 
> linux-pcie-failed-link-retrain-unclamp-always.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c

Thanks a lot for your patch.
The patch works, and the issue has been resolved in our testing.

However, this patch does not cleanly apply to the 6.12 LTS kernel.
To apply the fix cleanly, a series of patches is required.

PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
2389d8dc38fee PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag
15b8968dcb90f PCI/bwctrl: Fix NULL pointer deref on unbind and bind
e3f30d563a388 PCI: Make pci_destroy_dev() concurrent safe
667f053b05f00 PCI/bwctrl: Fix NULL pointer dereference on bus number 
exhaustion
e93d9fcfd7dc6 PCI: Refactor pcie_update_link_speed()
9989e0ca7462c PCI: Fix link speed calculation on retrain failure
b85af48de3ece PCI: Adjust the position of reading the Link Control 2 
register
026e4bffb0af9 PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type
d278b098282d1 thermal: Add PCIe cooling driver
de9a6c8d5dbfe PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed
665745f274870 PCI/bwctrl: Re-add BW notification portdrv as PCIe BW 
controller
3491f50966686 PCI: Abstract LBMS seen check into pcie_lbms_seen()

Could you please provide a version of this patch that can be
cleanly cherry-picked for the 6.12 LTS (6.12.y) branch?

Alternatively, is it okay to back-port the above patch series to 6.12.y?


Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok


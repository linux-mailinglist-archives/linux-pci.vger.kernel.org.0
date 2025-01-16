Return-Path: <linux-pci+bounces-19951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A80A137C7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B42E164283
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933DD1DA2E5;
	Thu, 16 Jan 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YIQd5wN7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VUT92fUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FD19006B
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023201; cv=fail; b=Sll/v9Q6uLeaLO2vOk1VPzEHbMI3+Er31CjT0NkniMYBhBjy48ZRtNMLkeh4yO93i1DLtMGOCHpjEtVQh38niM0P2ZGoE8JR/uAg0pHW6UmnEwDlsDbDDBToy0vaI89DECvq6z7QOhFdGP77lP6pwRJ1iDmWq4o5wWpUHnDT1GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023201; c=relaxed/simple;
	bh=fWlwmybwbvtcs+sQT8uLOsSMupNl8SgjRANRtsw7cJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMJE8c8L0i96oU1bo6c00B49TLYTtD5gTCJmBcZ6PJMIrRlugNOd82WBnpIKxzGHOVV6ivEMW+GhNOSHIBFKVXiQlOh41OfzlWtKYt68tTtWcZBy0sQudpopsih0cuw4rR645+Y/cRkzLLNpYYKQG19rBbuB3zSyYK1gavoVdMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YIQd5wN7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VUT92fUM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9NLYI021814;
	Thu, 16 Jan 2025 10:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2YQhmwqSgk1XXwcKeKoRdDhioBKBTwwO1Bh/a14rrhw=; b=
	YIQd5wN7i+p8izZ+JPvrtQO5L/7V5M/KFqG5lXWFR/LaHKmVyRO3gzXCmDBtuoz8
	Bu+oFIcenEreMVF7tAsnHqYvs+2VSHIGvLSPnEVqNAuRYF1cwK3jjvSFUj0oalA+
	olE7uFd001OuCe8b1pAc8Effh+00czenjcn37AbFAjKkHSrlA/Q/CDJe8V7ESesv
	+0Ot3WdCwoPIiTzVYHRrp+PUL1oPPNPKChnwmg1ZW2tGMhiGFM9RyAueXTU8HUX9
	VAul6993qcDTuuLV3mGtaBDmzw0fwTh3n+/+0hnyU6Hg4OMOy5nrXPUfNuwf/a1k
	hL/UIgVGoNj6MXuq3fT5Uw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y9xy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 10:26:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50G8lCAf020430;
	Thu, 16 Jan 2025 10:26:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3gyn67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 10:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDSIKkCnsVOxZH5sEDMB2I4u9Xm0yB8oWGeSgW93fCPtVN75EMl4/Xo8wYy8Os/Duk3BV/r8i0+lHLaGpIzgn94K5woUHbDL+TGlA6LXAULJmzf35y7RD8N+MR2KquY7NzCZcNR7H2SjBDreeGeROWtoZHyUy5kRakJg9LKfgnMLFWn44ypAKhAb0jKxJf1N+erhBltaGOZgCnJPUmF6L7YgRyPGvVNepfvb7ksDkIG6H7bjdmfWZhzAmZPW+Fh4rPnJmgZ4XQbkKSrJpqMYA90t5c9Ud6OUiFO+Qg4EOfBiJSru+yuVuBaSIu8ywimNtC0jtYfaeEcrYQgsTHb5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YQhmwqSgk1XXwcKeKoRdDhioBKBTwwO1Bh/a14rrhw=;
 b=sANsmO4xsiLN8UVSJxGSDmy+E+QhyXPH4FmfBcAJ06xzgqvtjHAgvuMOTCMOu0m3CY/zCtrDPQzbctYi/7NyAm+KFfIi9Z1pf2hy4qE8zGZ1nigcqEbAOrDNYHb4YRn4IWf4j1rE085X/kEXf+8Qx4mnUpK4iwifatfacSg8pUi+VtdioaGryfAzTNe3SgGFtM3SjfAeQHhQeO4y+RkLwushw0o4K+qWUuNYJ8R5U38h9MPjpyLOJDGOMX3t+2TblXuD2DgXScyLkUqem/EGVJ8P/OTPGPWXehtfPRR9+pAHjW/0aWN55Jy/DFX16PtHZEAEye7giwr5xRddTqB4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YQhmwqSgk1XXwcKeKoRdDhioBKBTwwO1Bh/a14rrhw=;
 b=VUT92fUMY5YDSVtQjEjLmER8Om9WjMqeqaMY7Cjw1RWyjWOiO6PCYVNOupBN3CaB0FHvJp9zdSBF7dUFHxrrNJK4C3BzwWL813cEZ6Zpw/lXl8ZLajI5wdfeS9dK+ipO697y1E/WcIX8mavLafWHkjrO+O9mRXhoCfOMugB0RJE=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 10:26:31 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 10:26:30 +0000
Message-ID: <620bbbde-35a9-4232-9cf9-a1fa1e899f8a@oracle.com>
Date: Thu, 16 Jan 2025 11:26:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI/AER: Move AER sysfs attributes into separate
 directory
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-9-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-9-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SJ0PR10MB5407.namprd10.prod.outlook.com
 (2603:10b6:a03:302::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|PH0PR10MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7accafd0-61dc-46ea-5486-08dd36183bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFdNUXZJbThVOFlSbW9sR2grcjZSTW1ISVBhRUo2MjZ1VjB2eWVSQnpwd1ds?=
 =?utf-8?B?L0lrbGF6MkVkS1Y1SFlHcVBaZ0VhSURkdS9JcE9IY3MxWXVFUkJFQXBvTit5?=
 =?utf-8?B?V2FXZmpkNE5TbnJCaGJDalNDeHF4b0VkR21oTnJxM05kbGJZOFA0dnFsQjAw?=
 =?utf-8?B?Sm9DcVNTVndHMHRYek80ZUxQWWxkZTNtZ2RsSEFvaUxEd2FqUGVtc21YeTFw?=
 =?utf-8?B?aThSVURqK2U4czB6VHlkTFUydGtZQmlaTUthUEgwbzF6OG1PZHlpcVRjWWhZ?=
 =?utf-8?B?eTk3Ylp3ZXJXVDBZTm9UUFFkSVQ5U0VqbVRJNGQyQnhBVXg2ZEJ1MC94ZUYv?=
 =?utf-8?B?OC9reUNVY1BpelY4UVNFSEFSa1RFWHNOMnd2M3hMcE1hM01EdFJvMjVnRjVJ?=
 =?utf-8?B?dDZMZXZIcFJQWmZreTVzUkdMUTk3SmtQT0ZYUkg1bHhlWjdUNW9hQWhQWVZz?=
 =?utf-8?B?Q1h4WEpicyt5UDFITWYreVdLKzl0YTNoMzhJd00yU1FHY0NRNks1RWIyZ3RN?=
 =?utf-8?B?TEFpUXF2RmRCV3FhbjdCWWJqTDA4Ni9BenlYWjZ4THU0ZEtRNU81SUtmdVZ4?=
 =?utf-8?B?M0Y5TnUxL2FrajZOQW05OXhUZyt5U1YvWU0zY0l4WVZjLzdWTm5YUzF3OVVi?=
 =?utf-8?B?U09ObW93OHFNTVlNSUVMZnJxTFgzcWdmaVBaYVhTZHNPZ2tyRVdsU3FRUG9z?=
 =?utf-8?B?dzhOTUZOZEZRa3JQZ212UGF0RklZUUNDeE9TeU9RM29xM2poYy9XdmtOd3VL?=
 =?utf-8?B?bkpleFRmZkVJTXMvekllK0YxNDdmMVdic2wxL3lZN1pUODFLTHcyb1h6cFA4?=
 =?utf-8?B?bGFkQmNqTERQT3NzV0V2QTd2ZVl0RUFhcFRMWnAzZmR5M3hHRi9ZaXdwNXF3?=
 =?utf-8?B?SzROQzE2MENwcXVmeWdWbXB0VmNicXZuTDVwRnNEaUFQSnJKVzRpcmJPTFJw?=
 =?utf-8?B?OHJHd3A1UVhzZDdscDRYSjFCdDJrbnBjUmwzMS8zaFQ5ZEgxbWFGVi9ROC9S?=
 =?utf-8?B?ekExay94SXZPWWJ4eHdneldVak41SnI1czFZcGttM1kvUHRoc0Y1SktoWG9m?=
 =?utf-8?B?MFJ5MzIwaDBKN3lZRGVWQ0ovL3lPakVuVnFHSFRxVC9hSFJXMEFKNFFaUGV1?=
 =?utf-8?B?eGFlS05kV0ZZaXpteUJ1Ymw1SSs2Rnl1bFUyU2NET2FkSFhmZS85eVlvS3ZY?=
 =?utf-8?B?TTk3dS90bE5RbzFOMVdwZG94VWtxMWNRVzJaV1E4Nk1kdGl0eitiYnl6cURM?=
 =?utf-8?B?REtlZkVlU1IyZW9ONTRkYlRJZHd0TTQ5aGgyUXhhMnc2RWx0cjJmdmdQa0ZT?=
 =?utf-8?B?WjRLUTl1Y21iOTRUWmFqMk5qVkVoSE91UFJmMzBaN1NpOUdUWSt0VkNtU2ll?=
 =?utf-8?B?OWlCK0hIQzRxYUphdy9YUVdGZ1IxcTBWNXlJbWVHeUdDc2R6THFPT0ZZOWRh?=
 =?utf-8?B?Z1BKbmJudHc5ZWx4bElxNkpER2pEZ0h4djZHN2VrdkJCSjN6ODFTL2xZV1Jj?=
 =?utf-8?B?aGU2SFVrRVFrbm1yY0ZsbW5JUjl0RTNrYWI3aWJ5Ti9JTUp2bUpkWmZwZ2hs?=
 =?utf-8?B?bUtiZnQ3dCtFZXpnbjc3QjM3Ui9TbWlsbU5tZzlRVXlLZmJYbjF4NXZKQWhs?=
 =?utf-8?B?ajc2bE0rMzV4R1hxN0t5cVNxREVWYjA2SmxaU1BnOWw2NkVRWEhJUGtEYnpz?=
 =?utf-8?B?elhYQWsyMnlKWUN6NG5yb2xFZU5TdGtEWnc4R3VCUDZQc21hN1gyeVE1ZjdB?=
 =?utf-8?B?OHBmTDJTZEpLd1pCaDhJdWRodGU4TkExa3ZjWGpCY3Y0UHJsd1RGMG4yL1l0?=
 =?utf-8?B?SEpLamVkODBOWWpCNXEra0tUKzZUTUd2Ri9ZbldWMFM5bzEyN0t3d1FLVFB1?=
 =?utf-8?Q?HItNl7vSIZd/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm1GRUR0WjNMcDlSMUhmdGlzM2lBM2FqV2QxOFlRSnR5dFg1ZG1iZkFjcThM?=
 =?utf-8?B?MmVNQ1dBN3hJaS9uMGRNd1dpWkhzUWZBRlhQRWxMY2U2SXpIczdJMldpcHo1?=
 =?utf-8?B?TTN3RTlzeHVYdmlsUnA2bWVaRDdwbE13di94RW1iOXdjOXhRRzRPU0VGaWRh?=
 =?utf-8?B?UDZzY2dXdkprZ1VLeHVJRnhITzNKbmxWUEc2WGRHelB4MnFMUHFhZUYvWmZu?=
 =?utf-8?B?OXNlVUY2b0JqemtPb2lYMG5ITzlpYXRoZlhIb0VQTmRUOUJPR1FHcnFOUjl5?=
 =?utf-8?B?KzdiWEJYbkhBZ3JibEFNRlBDV05DaUVxMUIxdU4vY3JpS3RpSWZqbjlCTDJj?=
 =?utf-8?B?cFFENEdYZXYxWnZEYVFqZEtXU0VaaDN4VFlQdkpxY1dmeVlITjA1ZUV2RGRV?=
 =?utf-8?B?V1VkM1dXeXFjOUw3SEJrSG5QTlhKZnNHNllBN1JmbXFCOUNjL3VIaTFzQnRZ?=
 =?utf-8?B?NU5SU09VMkdUdjlhNzI5bm0zTmVVU3BKUVJPdnBuSnBQMmJrYk9SYVVnaGVt?=
 =?utf-8?B?NmM1Nk1XN3hiazF5M0phdTlRc3hRM08xK2EvTFdRS2JDcmxGd2tZaWk0TEdJ?=
 =?utf-8?B?L0taZTBJRWZwTXlUeFZoL2Rob2hlVFFFeU1RRWFhbWdNeEJmUUpLdURKdk9v?=
 =?utf-8?B?bWRXN2gxSFpSN24yTWltTTdFWDh4aG5tMndOQ2JOQVMxVVJOWFVyYitnbTFP?=
 =?utf-8?B?eHFhZWtJRGtBd0hMM1VKMldudzVSRDBsVXlyTGNTNkMweXlJSDNDRXdWSm9p?=
 =?utf-8?B?T3k1NzRSZUFYWUVueUgycTlaZ1JYVWVVeVFFbFVQcVRrTkJIaCtTWXd6OFJi?=
 =?utf-8?B?SjlScTM3Z2JEK2hXcktVNFd6dFZRTzMvMjNVZkUza0dReTdVSUYrek1YejRJ?=
 =?utf-8?B?R1diVWNXcHlDb3hOZVNUUXViYXhRT3FTSUVMWWtqellORC9YRTNPL2daNjZo?=
 =?utf-8?B?aEhlTGh2SUx3cTc4NmNnVmYwYm5KV1ljUnlkZ1k0MDRYYmk4VFdoZHZIQWk2?=
 =?utf-8?B?UnJ1aTF2aGw0blFXaHhQa0xSamQrRzByT0gyditpUmUxSG10THRBekxIdEs1?=
 =?utf-8?B?Sm5sZm1iNVA1cHBLM2RmK2xCN2piYUxkakFVZlJPMGhJcjQrcnEyWGZEY3E4?=
 =?utf-8?B?ekx1MHF5dUV0Sm9xWCtTdU92b3hEckVSWVEzYU50ZHhINFRNK2ppQm5NMDZC?=
 =?utf-8?B?ZFBWLzNUR0NkWGVXamN3RmY2dTkrZkFoVGc4emxqNlpPV3lvUHhtSCtWTkRm?=
 =?utf-8?B?WjY4SWx1SWN6d1F3Yzh4bzc2MExzWkZKUHQwZ0Q0dFMvbHBoZlN1N2NUTHo2?=
 =?utf-8?B?R1JoT2E4WDZYT3JnMlJXaWdDc2xjVXp6ajhtWnpXNVZrazZkSDh6eVFuL2xY?=
 =?utf-8?B?R3dYUDluY2pvZndIRFhoUThWQTRwWkwzQjRabGJJMDhDV1dZVXIycVF5bFdU?=
 =?utf-8?B?bE5HRW8wM3RPa1hKTTBhclp4WStJeEV0VEdmVXRkNVg3RCt4L0xodElhd1dV?=
 =?utf-8?B?NW1nVGE5OHZLdXJVSWpPcmNnR1UyRHdlOWR2U0E0RHdGc1QxVlRiU3lSVXQ1?=
 =?utf-8?B?d0kxL0RJR2poUXdTR3kvRG16d1h0aWVDL2MxSVd1RTdZZ2NuMmdPQzZxcWl0?=
 =?utf-8?B?ckZjamtGbmtvYmgvZ1NZRzV2V3ZBYms0bjFqVXhZb2VXU3BEWnlORE1NVzVt?=
 =?utf-8?B?cDkxbjdjY2JsNHZ4bGkySjViN1RHN0VublcvQTBqMURGMUc2MmRKS2lUZklY?=
 =?utf-8?B?RmowZVR2UFBzOXhhbHRscmxGbXFxM3RTdXI2MENPcW11Sk1iVjJLM2l4SEZy?=
 =?utf-8?B?TENMZzJ2enRHMHBWdnYrUGhCWVdhcTJ0T0JSRm1HNFNsaVlNTlBUWXN1Y0Ju?=
 =?utf-8?B?NGFqRkJzN2c2aExpN2Zlbm5nZ2NxbzJCNTFpaXYweUV1aWIrdmNRVjF6Tm5K?=
 =?utf-8?B?NGpmcCtJVk45eXd4M3BkY1o0TithaEhFTForUGJ1Mk9CdWFJaVMxUVZHY2Fa?=
 =?utf-8?B?bDR1c2NWbFBBZE13SUlPVmFZK3YybFNMT29MVWpXK2src3g0SWUzMUpyQjVw?=
 =?utf-8?B?cENocEFkOTNnTFJ2aktSaDNWOVpmUDdiK1FiVkQ0YVI4Vkd6cklKSldkeTlK?=
 =?utf-8?B?V1BFcXl6Vk90NEFZR0w5U3AwOFlIUjdDN2E4UU1LaUdYREpCT21ERzhuSUhj?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3L7d6uOLykibXIx94scv8UFMiYqpbG3JFw/yIQhwnBrY5F9lAB2kqKvq+a0FzSNs/V5xmTM9xUP+SznnlVy3M3usMAGyK7/S3DnGwInAIxGCdB2+/Q/FXIiiGry5Bri7FATWq3xVxQaIEWeDWll9ieJ860SXPok2ECpICSVJMKUyf6B7Ycz63BeqH+ghJOXMT2BKjIm0C9s7fUTvSs2xQQQbwFxDCROTzPZN06MlsZYn8hGXC8ouy/kUbhnlPEeECFhvKZWXxs8dQ81HwmbtlklI5zqCmjDAO5eyTiuJXoN9c8NFfD4nQDnuUd/qpzMccm9MpzUeNhU/jZP7LVflcd9lRh94Sukqh7XEYmufwAdufPNPq4LC/+zpn8kDLkZiAoS5C/hUxEvKPLpXKll6IaPAZmliUTTR9dMLgL2AhXAojqrn5U8lPgKHAlznYeMzCbHxCYsaQglAxDnhChE+YMejFV2qxehwSeUIS/6UwoHlnwUWjACzq7ChGMNVGTkZcHBuUdH1fdT0aNe+SMHw9yuhDU+LMfbiF7jcC4Mmlmb8Ugo2qqyrDpB/pyV+/3/XgYCtHEjhJgd3zMqGprvQsb0ZrQ0Qe8xVT7tt3NKcjos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7accafd0-61dc-46ea-5486-08dd36183bf5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5407.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:26:30.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmHYYF1/1jmcQ65JA/tg4BiKABaU31sjBzk/VB+P4yQORO5B1f1xN+nkVUvH2TLfYwL31A32cm6gRoiJ95RnRhSPRN5uEWTYanS0oMng+KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160077
X-Proofpoint-ORIG-GUID: EEMMU1l63DcplHEatDAzKEZa6ET_YlJt
X-Proofpoint-GUID: EEMMU1l63DcplHEatDAzKEZa6ET_YlJt

On 15/01/2025 08:43, Jon Pan-Doh wrote:
> Prepare for the addition of new AER sysfs attributes (e.g. ratelimits)
> by moving them into their own directory. Update naming to reflect
> broader definition and for consistency.
> 
> /sys/bus/pci/devices/<dev>/aer_dev_correctable
> /sys/bus/pci/devices/<dev>/aer_dev_fatal
> /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> /sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
> /sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
> /sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
> ->
> /sys/bus/pci/devices/<dev>/aer/err_cor
> /sys/bus/pci/devices/<dev>/aer/err_fatal
> /sys/bus/pci/devices/<dev>/aer/err_nonfatal
> /sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
> /sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
> /sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal
> 
> Tested using aer-inject[1] tool. Sent 1 AER error. Observed AER stats
> correctedly logged (cat /sys/bus/pci/devices/<dev>/aer/dev_err_cor).

I'm not a sysfs expert but my understanding is that we shouldn't do 
major changes in the existing hierarchies.

On one hand, I think it would be nice to extract out AER-specific info 
and knobs into a subdirectory (e.g., using attribute_group with name 
"aer"), but on the other this would be disruptive to the userspace. I 
can imagine that there are tools that watch these values that would 
break after this change.

All the best,
Karolina

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   .../ABI/testing/sysfs-bus-pci-devices-aer     | 18 +++---
>   drivers/pci/pci-sysfs.c                       |  1 -
>   drivers/pci/pci.h                             |  1 -
>   drivers/pci/pcie/aer.c                        | 64 +++++++------------
>   4 files changed, 32 insertions(+), 52 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index c680a53af0f4..e1472583207b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
>   problematic endpoint itself (which may report all counters as 0 as it never
>   saw any problems).
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
> +What:		/sys/bus/pci/devices/<dev>/aer/err_cor
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> @@ -19,7 +19,7 @@ Description:	List of correctable errors seen and reported by this
>   		TOTAL_ERR_COR at the end of the file may not match the actual
>   		total of all the errors in the file. Sample output::
>   
> -		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
> +		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_cor
>   		    Receiver Error 2
>   		    Bad TLP 0
>   		    Bad DLLP 0
> @@ -30,7 +30,7 @@ Description:	List of correctable errors seen and reported by this
>   		    Header Log Overflow 0
>   		    TOTAL_ERR_COR 2
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
> +What:		/sys/bus/pci/devices/<dev>/aer/err_fatal
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> @@ -40,7 +40,7 @@ Description:	List of uncorrectable fatal errors seen and reported by this
>   		TOTAL_ERR_FATAL at the end of the file may not match the actual
>   		total of all the errors in the file. Sample output::
>   
> -		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
> +		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_fatal
>   		    Undefined 0
>   		    Data Link Protocol 0
>   		    Surprise Down Error 0
> @@ -60,7 +60,7 @@ Description:	List of uncorrectable fatal errors seen and reported by this
>   		    TLP Prefix Blocked Error 0
>   		    TOTAL_ERR_FATAL 0
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> +What:		/sys/bus/pci/devices/<dev>/aer/err_nonfatal
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> @@ -70,7 +70,7 @@ Description:	List of uncorrectable nonfatal errors seen and reported by this
>   		TOTAL_ERR_NONFATAL at the end of the file may not match the
>   		actual total of all the errors in the file. Sample output::
>   
> -		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
> +		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_nonfatal
>   		    Undefined 0
>   		    Data Link Protocol 0
>   		    Surprise Down Error 0
> @@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate the number of error messages as
>   device, so these counters include them and are thus cumulative of all the error
>   messages on the PCI hierarchy originating at that root port.
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
> +What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>   Description:	Total number of ERR_COR messages reported to rootport.
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
> +What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>   Description:	Total number of ERR_FATAL messages reported to rootport.
>   
> -What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
> +What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal
>   Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 41acb6713e2d..e16b92edf3bd 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1692,7 +1692,6 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   	&pci_bridge_attr_group,
>   	&pcie_dev_attr_group,
>   #ifdef CONFIG_PCIEAER
> -	&aer_stats_attr_group,
>   	&aer_attr_group,
>   #endif
>   #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9d0272a890ef..a80cfc08f634 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -880,7 +880,6 @@ static inline void of_pci_remove_node(struct pci_dev *pdev) { }
>   void pci_no_aer(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
> -extern const struct attribute_group aer_stats_attr_group;
>   extern const struct attribute_group aer_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e48e2951baae..68850525cc8d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -569,13 +569,13 @@ static const char *aer_agent_string[] = {
>   }									\
>   static DEVICE_ATTR_RO(name)
>   
> -aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
> +aer_stats_dev_attr(err_cor, dev_cor_errs,
>   		   aer_correctable_error_string, "ERR_COR",
>   		   dev_total_cor_errs);
> -aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
> +aer_stats_dev_attr(err_fatal, dev_fatal_errs,
>   		   aer_uncorrectable_error_string, "ERR_FATAL",
>   		   dev_total_fatal_errs);
> -aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
> +aer_stats_dev_attr(err_nonfatal, dev_nonfatal_errs,
>   		   aer_uncorrectable_error_string, "ERR_NONFATAL",
>   		   dev_total_nonfatal_errs);
>   
> @@ -589,47 +589,13 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
>   }									\
>   static DEVICE_ATTR_RO(name)
>   
> -aer_stats_rootport_attr(aer_rootport_total_err_cor,
> +aer_stats_rootport_attr(rootport_total_err_cor,
>   			 rootport_total_cor_errs);
> -aer_stats_rootport_attr(aer_rootport_total_err_fatal,
> +aer_stats_rootport_attr(rootport_total_err_fatal,
>   			 rootport_total_fatal_errs);
> -aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
> +aer_stats_rootport_attr(rootport_total_err_nonfatal,
>   			 rootport_total_nonfatal_errs);
>   
> -static struct attribute *aer_stats_attrs[] __ro_after_init = {
> -	&dev_attr_aer_dev_correctable.attr,
> -	&dev_attr_aer_dev_fatal.attr,
> -	&dev_attr_aer_dev_nonfatal.attr,
> -	&dev_attr_aer_rootport_total_err_cor.attr,
> -	&dev_attr_aer_rootport_total_err_fatal.attr,
> -	&dev_attr_aer_rootport_total_err_nonfatal.attr,
> -	NULL
> -};
> -
> -static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
> -					   struct attribute *a, int n)
> -{
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	if (!pdev->aer_info)
> -		return 0;
> -
> -	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
> -	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
> -	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> -	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> -	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
> -		return 0;
> -
> -	return a->mode;
> -}
> -
> -const struct attribute_group aer_stats_attr_group = {
> -	.attrs  = aer_stats_attrs,
> -	.is_visible = aer_stats_attrs_are_visible,
> -};
> -
>   #define aer_ratelimit_attr(name, ratelimit)				\
>   	static ssize_t							\
>   	name##_show(struct device *dev, struct device_attribute *attr,	\
> @@ -662,6 +628,14 @@ aer_ratelimit_attr(ratelimit_cor_log, cor_log_ratelimit);
>   aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
>   
>   static struct attribute *aer_attrs[] __ro_after_init = {
> +	/* Stats */
> +	&dev_attr_err_cor.attr,
> +	&dev_attr_err_fatal.attr,
> +	&dev_attr_err_nonfatal.attr,
> +	&dev_attr_rootport_total_err_cor.attr,
> +	&dev_attr_rootport_total_err_fatal.attr,
> +	&dev_attr_rootport_total_err_nonfatal.attr,
> +	/* Ratelimits */
>   	&dev_attr_ratelimit_cor_irq.attr,
>   	&dev_attr_ratelimit_uncor_irq.attr,
>   	&dev_attr_ratelimit_cor_log.attr,
> @@ -670,13 +644,21 @@ static struct attribute *aer_attrs[] __ro_after_init = {
>   };
>   
>   static umode_t aer_attrs_are_visible(struct kobject *kobj,
> -				     struct attribute *a, int n)
> +					   struct attribute *a, int n)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
>   	if (!pdev->aer_info)
>   		return 0;
> +
> +	if ((a == &dev_attr_rootport_total_err_cor.attr ||
> +	     a == &dev_attr_rootport_total_err_fatal.attr ||
> +	     a == &dev_attr_rootport_total_err_nonfatal.attr) &&
> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
> +		return 0;
> +
>   	return a->mode;
>   }
>   



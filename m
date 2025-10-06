Return-Path: <linux-pci+bounces-37628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054FBBF099
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7034E1C9F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB91D5CD1;
	Mon,  6 Oct 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OrMdWL34";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aIdq0CUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F52D29C8;
	Mon,  6 Oct 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776994; cv=fail; b=GRZimZZAYj7IPrdz98ogq4H1+JCSnLt8EDo2Y1+QeppyKtiumVwfqLvudrx5nq79VfMzcAOvhTOre3s7m3gC1YJp2c2YNyIvYjxzxXNrALoUypf87gp0OrZCZhNtAP64MmO1FquZcedLUIQiUHnYkbvI8HN1XEk9MRGQrze3jss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776994; c=relaxed/simple;
	bh=YEDZBDgikut18apYER8NiQg4SdYacd9Hvj8kEh+cOxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7j2/HevdMw971mhisvUgzWYpeRk4ZXTfr+h914vE+AkZSiKehgL6Eu+3WkOzEAkJDRJi+ZF+fuonNWKpvA6jjfvEeq8V6PkZJIqg8PCe1P8n2rjfyY/9Zo0UMYzSt3TLhZptMycfGP1R50FNSCOvtOG30ZOoqT0VpXcvren4vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OrMdWL34; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aIdq0CUT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596IQrM3027566;
	Mon, 6 Oct 2025 18:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZsIGVxJOqwq7SEFvj5sppPXA/r+Xc/KDjkYPQmNz8Ps=; b=
	OrMdWL3413iWeIfZaz0H+pZL8MLUPZvGrv6CJDAl02xubgI4YE52rLPK8IZI8NFj
	gRK/uiIoa239srU7ewEftPEZn145yDNWHyhY3vwgIPDJ2z4Z+lh0ePD8hFN3jaxS
	WFTLqwotiDzO22RtqourFCLAhwh1bLBlTexDnmfrcjQlVt/DCRWhrbIugcqQABlS
	s07HkyxTeCnPoWyh8W7QfBsW1Brymv53ei+0ntRtAOY43smp2s5cgTq4ImGwvomQ
	4I/is8MhiOm01wURv/VxOf0eNufCT6id/+ur7F0aZtia9Fd3525pmdu6/nQ4oByh
	GPAUxj+DPBSZjvT4WWDigg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mhem09b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 18:56:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 596I5sJb029876;
	Mon, 6 Oct 2025 18:56:14 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt177ww3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 18:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj52UTAWUgej9M1tJN2A7+YZw8NPy/HEq/Eb67sjmcK+WFTRrv7FcjSfyKl5ISR0ZokjrLu3hqZ+WL2Upw8NqA319B8dVzN7hhGpqpKxAEsPl143jDpkT/TvNS/oLUzXXB3xBRD2Zg3HVGbtqlzz2AS3C1v7x80m6bje9z6zzwSVzeEnKyqSa0a9GAvVM5qVqHVJux6YlKgOOX5AGkAzcaGJh/0BWx2QjjaTE/zUFGiyCLIMfMr97VA/EKxMtvsdhcyfgTEtxcat0apB+uPCtw2yxtuEUIXNoqi6X/8RvaIY6bBHRsaos54x9UDFY8MwhBtzUv2Da5H1p7sGNABvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsIGVxJOqwq7SEFvj5sppPXA/r+Xc/KDjkYPQmNz8Ps=;
 b=ImvquGDEX2nUlxwZ2xVKb5HlAdvsUHnIMK7uNqwrZbAydmNAo2EvFA6KZkT3wRTqx/SRCDHNjgZiRvcANwAKWRJosCi5UtP7hQrMI85VdY5WSQao5dxsgY8sJCVzQELBLK9+wcANTGTQ8ANbDmDIzl+O/8vXss5qm0YZndw/pvuqO861nkw+w5Z/FwjQVZiDsQRMPfwNE1GmlylmapVyo38ZuySpQKzF9Fv/g5gIbS/W/XEaMUc7dBBhok3h5AXZdOnU5M5O/7bFWw6Fz6XsX0OVS/thRnKpNv1ibWOsUG73rNNtVFjOrpUWvQDHp1teTnR2Wse/8eGkP0udnE7DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsIGVxJOqwq7SEFvj5sppPXA/r+Xc/KDjkYPQmNz8Ps=;
 b=aIdq0CUTh0Clp7T4hd/vulUmMuyqNGuZcFT1j6e0IN6wg6a6r556cF+9HdRWqMsl1J0IthR9GBtCiTIZZUz/qmtat/HseGwu1goQ2Gnw4lxNjq92ExAHRaKb5Q3Are2nTNgFS1iaKfw8tHV20UMUeQUd0XZ6x+3yjbjgBHFef0Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 18:56:06 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 18:56:06 +0000
Message-ID: <c9efa64c-20d7-4aa6-815e-2be040480ff9@oracle.com>
Date: Tue, 7 Oct 2025 00:25:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v4 2/3] PCI: endpoint: Add API
 pci_epf_assign_bar_space()
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, imx@lists.linux.dev
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
 <20250930-vntb_msi_doorbell-v4-2-ea2c94c6ff2e@nxp.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250930-vntb_msi_doorbell-v4-2-ea2c94c6ff2e@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ca28bc-05a9-4ada-2bf1-08de050a016a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVBDYkJkQS93bWpiOHhrRTdFa3ZCZU5tY1grcDNOT2liRDliYXNRMkZub1RZ?=
 =?utf-8?B?RlNQTDhyVDVGWk5VcG9FTjVJNkFmd0RQV1RjRnR2Nm9jMHpBUy9HdEpBbTZa?=
 =?utf-8?B?cnNMOWRZcnB1U0s1VVcrSFBiNkgzTit0Y0xNYVh3YVpkU2p2MDgwampRemxW?=
 =?utf-8?B?ZFlNT0xnVjlGeGtMdWxYSzVTOFU5NDNBcEpTV0ZPUmtlZjhrY05KWDYzSFZ4?=
 =?utf-8?B?LzZISEVSRFhTYlErczhJNXVMd0ErM0Y4QTQ5M0JOUktWZ0c3TExsa0lyZlpv?=
 =?utf-8?B?QlJ5OU1NQWNnWFlNWENIa3QwTmtIcDVlYlJXMTRMTWVYNDlxT0ExdzJ6dmYr?=
 =?utf-8?B?S29IWXJGMkNpeGMzeDlaa0ZZNDhBRkFXMFozOGhpTkdpN2ZWZG1lVmdTZ1ll?=
 =?utf-8?B?NUQ0TkViWXFOYzFzQXg0bkNmUDhLSEs3elJJR25jeTRDN0dwOXo5L3JpKzBG?=
 =?utf-8?B?SUtYV1poOG80TnREL21oZUdmVzVoek1DMkVXMTJhdUxOcWJhOUNrdGg3Z1lQ?=
 =?utf-8?B?WllqdnRTMVBhTUEwdzBTTFpxb280clpvMkJRNVhuQlM4MFREMnZ1b3Z3UDdk?=
 =?utf-8?B?aUdBeUxkVXFwWFZqUzgvWXd5QVZBMGo5bzBXT2JRTnBFUWJxRmsyazZCY3pD?=
 =?utf-8?B?bmtHZVBWSHF2clRSQy9jMTZRYVJDWTE4bWJUd1kyZlFEWUtWRlJvZTd6Vnd2?=
 =?utf-8?B?Rmdibk1qUjVwTFRSNWJvZjdqc3ZvdUhOb0sxVHpGNTgxRVNIdjVaVGdQVDVo?=
 =?utf-8?B?dE5vdFFvU242czBoaWhjNUVZSlhTcEdvcVFld2ptdVM2QW9QVHAxK2dhOW93?=
 =?utf-8?B?eDBNYmdRVzhQVkVidkxuNC9kYWgrSFF4S2VtSzB6NU9GRjJoMXNFOC9VaU4y?=
 =?utf-8?B?SnpnY3hJN3BYT3llVVFVSUJtVTVxemMwaFkrdVJJa21aclQzWGczUWJiSEZa?=
 =?utf-8?B?SEdRemVjU3hDc0t2SVd0bHVicHp4dEl5Ny8wSktRdUJmZmhVQ1NNVDR2U1Bw?=
 =?utf-8?B?TTZXS2hLQXpSa05rbW8rSGJvQkNmeDNiRkU4VktJVVpBS3VGdHNSR1hyNmRo?=
 =?utf-8?B?UCtKOHFoakRaZmR6QWhpQVhnMS9jd2RFMU4wekNBYk12S2ttUllWTWZ1TFNw?=
 =?utf-8?B?Y0RHOSt6T3VsaEk1SXZzMzdVYi80UUtRWTQ1WmozWUF0cm5hQ1dQamVwS3lH?=
 =?utf-8?B?L2VhK3dTanM1Z0p1SUQ3Z2d6aWlic0Fmak5weWMzZ3VLYVV1WnNmUTRLaGFJ?=
 =?utf-8?B?OFVIOXRiTVFKbDQrNldmekl0VExaWWYxOTU0dWttS0NhY0dWZUFFNXdDT1ZB?=
 =?utf-8?B?b2F4UDVxQnFCajMzU21TYlB1czZlSVZtQVBza0lOZVlDSFZsM3o1NkxybFNm?=
 =?utf-8?B?UGhiUmdJSjZQTEQva0NhUmdCTXZkdUtaZ1FNbWhRMTh1eHRXYWNLUld0Zkpt?=
 =?utf-8?B?TTRXU2RWRUlqaHhMaTF5RzFPQXBQeXZXaHpTa3dQdmZFTU5CbE1zN2RudnRW?=
 =?utf-8?B?VURSR3JudzlBdFRoYWFReWNGSUZhdHRXVTAxcjhueEIxbVRReDZ0Z2NudzI3?=
 =?utf-8?B?N0g2N3ZGRmRYRElUNFRWcGRNem5UMkNLSE1TaGxFS1M1cDBwTW9CWFl1dGp6?=
 =?utf-8?B?bDc2dUV3eUVHQjBiM2RqYUF0a0FldjRGVWxLOUdqbWFURW14L1lpbFJ1VVpB?=
 =?utf-8?B?YmExanlydUcycEU3NW5sTFZOb0w4S3ViVUFjRFVid2ZrbEhBUW4xZXhiOU5E?=
 =?utf-8?B?S2Z1bjNKaWNyRU01aGcxVGlYSU5HYzNvOUx6YVNzTU80bXRmTkd5d1dXL2NM?=
 =?utf-8?B?NWovbk0wc25ueUtqU0h2MlNscVY3REVoRWNqNjEzU3AyaEgvQzlndHNUd1Mr?=
 =?utf-8?B?SXRUTGJNVUN1bkVEb3NhZUgwblFOY2pMdk5MMzBVWW4zOFh0TU5xelQyZ21s?=
 =?utf-8?Q?s77RsslxRnUyvWnPkuOo6lYUy3sP+ew4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZDcUJtNFM2R0VIQmcrdnJjSWp5dVdMekhQeUtSVDg0RmlzNjRvVG5ieEFE?=
 =?utf-8?B?MTY1T2R2SWtoenZyTTljYmpLRy9pNW9WUVBxTlo1c09LVGJVOGwzYzMwUU84?=
 =?utf-8?B?b1FseE1HcHA0bk1HeXJ3Njd3bS92UVdLWG5ITGpkbUxPaEs5TnFDdVFKTTJC?=
 =?utf-8?B?WnoxUlZGNW9HK1dYTDl6QXZPWmRBVS9QYnpjaFlSelo1YjBvWDFNTjV4SGE1?=
 =?utf-8?B?aGh1a1hua0M1M1BGYnNpck1SWnVXZ3g4QUUwTzhqNjR0d0tWVm9QaUQ3ZE9U?=
 =?utf-8?B?L1JBdlNaN25mTUlORUFuRmhndkpGdjlEajE5em9ObzNDR0Y3UXRKTFlRcXF1?=
 =?utf-8?B?UXhFcHZDWDZpMmNFQWRpMWYrL1RpZ2pTcjNvNTRMeEd1RWpjdXVRVGFsU0lB?=
 =?utf-8?B?UEc4ZEYzb2h2eUpSNk8yMW52MllxekcwWmxZNURadkt4d1hQU2FaTlVPN3R1?=
 =?utf-8?B?cE1wWk9LRU8zV1lUN1pnWlFnamJFZjY1M2VzR2JlLzZHd1IwS1JlUjFCNHVn?=
 =?utf-8?B?Y0ZKVmZGUnZTMlNQWUxsbVZVZFhObXNERHQ1TXhSaUtwQzNtWTJ2ZHE5MTJT?=
 =?utf-8?B?WmlSZUNwQzVmZC96akcxMXdhR2w1bmN5ZkxkMHBxaDhMaWpiT0R5WG44Ynhu?=
 =?utf-8?B?OGdnZGV2bjBjbVhqNVFLV2V3VEQwYnNFTjNFbzhDekQ3Zm1GeWwrTDF5cERx?=
 =?utf-8?B?UGpjQVFPQVdzVkVJcm9PNjdpSUN6UXFGdjNhYmNpOFFwck0zSnJaQUtGSnJ5?=
 =?utf-8?B?U3dUVU12ejNFbDYwSkV5c3dUQUx0VHE4YkF1NlNaUG5PSFlSbnN6VVJoTEUx?=
 =?utf-8?B?bjhkcEJRUTFIOVJxSkNnNDRKa01GVksydkIzOWhBaW1DcG1vWkdnWGU0d1lF?=
 =?utf-8?B?QnRsRmxxNE1OUFNmLzY4NGYxUXJTQlFqeTZlN25kaHFDN2VsMDhxK1F2OVZ2?=
 =?utf-8?B?YzJPUjhuSnVuSHR1TnVzajJMVWtqUXZ6V3R1OFpxR3g2WVlyalpTVWczOE5X?=
 =?utf-8?B?WEtKUEgzTFVURC9DT1FwODl4YlZoUHZWclJiWWRYYytDc0I4eWVJNTJQVSs4?=
 =?utf-8?B?YlBJbnJyY3lFRDJQOE9uZWN5QTdVMnhaNVVJYmRYVkx1YS9POXR5dFpMaTBG?=
 =?utf-8?B?VmxKcnI5WFNTaFRJME1Nc0VwbDNDUWN5TXRQampwY011Y05FbmpLZVBORTlT?=
 =?utf-8?B?dmxEOVUrY0R5NnhtWXlVOGxESU9EeGJsM1RyaEtNSktpTDBxajJ2bFZuWndI?=
 =?utf-8?B?aU9YUjlFUkZDY3IzNjhHYVEzME1iOEJIbXVyZEtnSVU2b1lqUThLb3VydFFP?=
 =?utf-8?B?bTRtVlF3U0pyK2RybjkyZW5YcjByUHc0TnBmWlpnMkt4UG9weVJLKzRJOXpB?=
 =?utf-8?B?aGI2NTJIbjlJTEdVaHlGQzdTTkRsUVFwQXRrVEUvM080K2dOQUtSM3AzemZJ?=
 =?utf-8?B?SVFYbFBJRTJ3RThPQTdaNFhxeTFoM3RhZVZTdEdKaFpCSTZhc1BucjlmVXh1?=
 =?utf-8?B?aEpaOTMyYm1aZXZLN2ZDdnJ5WTBFQ2xKSko0YWtOVXVrNzZwbnFKZFlkRkxB?=
 =?utf-8?B?bzRjRG5tQTM1cGFBU2ZVNFRhNkhSUFR3OEhBc3A1YS9oQTVnc3RBcEFUYjdM?=
 =?utf-8?B?TWRrM2Z4MlhWTTdBRFAxK0FGTFVObkNoMys5MVZhMHhBTzBVb0hUNW92RkF2?=
 =?utf-8?B?UkFkRHdvS3lMaHpPSmRzSlJQYlBFQ3EwbWxQTGpmOXltSkd1bUJqeTI3eVdw?=
 =?utf-8?B?UTZwejJJaXYveVYzNnltb3J0LzVmaXdtSXg0RDBoK1dBdDBHOXhPaUVzZVF1?=
 =?utf-8?B?Vjd1c1NacS9KWEhqcTU0dElacm9DbW01aGZvQlFONDdJZ3ZXOEMyUDhoVUl2?=
 =?utf-8?B?RDgxcGRXZTJHZmwvMkE2eDhRaTVZa3d0RzE4UnNkeGVjOEllSmF5VXhpaUNW?=
 =?utf-8?B?Tmp0TEs3L2dIU21rOVhhOUwxT0V0Wkw3M3NuNTJGUTdqS28zR2ZyNXZXVHlL?=
 =?utf-8?B?WEJmcVJiVGcxQnlUM1A3QkZHdXMzU2JuMDBoS29BbTdSdlEwZ012ZEkwZGo5?=
 =?utf-8?B?L3I5cEJsbXd5R214cFgxdGVzaDg3MENuYUE3WkY1bFhqZFpkNHFHblovTFhE?=
 =?utf-8?B?SDIyZ0pmUUl5RkxMWnl6b1FOSmpTU3BjWENvLy9PUGZudUpkQUtHaFo0d2Fz?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0u0zgMKTRntwR+ELIYE2grIxphCulJT55dGpIj5mfSoba+orVk/nDgDBT0wu/Gr/7Ql3IJhgycM8XJ7biiUHJQ+yOjQntZd8ks+R7htizfhTKpxM/y4G1sM2tioDjhKYgb7vYRDvvmwh13bUgu875hJckCqyp1x1QxozSyaBIm8H7OaRbc1+O3ewKsIPHwiPFYxP7ZUFVx5kc8u0ayabSR1CXsWtbE5F2dS4axV5XLG1oeb9ccsY7zJ4JT3g4JVjgGhMQwdIwTeRbL84S5Uerr8mFi/qJkckRrnHYeKLPwSnH0+pabhzAPnGnTx45dpDjQogyBcvURNuj29x1PiQuYZLdOyvVE2L65UXc0qc5IrMM7HU+BBlPCFIKBRM6iowK0XA3WfnGy/OAN6tHQxv62Qi0vXWr7KPEfF6meE9Y/8vyw2zNEQERjoCQuns7leKwlAB5swLxPHIhANzUxm8zOuVy9jCBBpMAiEtniSXQxB7epiSPzgHCE2Mmy09hVbl0bIRrIYkIOZGjFzTyiSBbyOjb3C0Y4agluynlgao6JkfKZ4RwPEdT4kc0/Vc0avWrszuiHQEajNDMblS446MDKIpgB0WepEhzaucZUJ7Evc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ca28bc-05a9-4ada-2bf1-08de050a016a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:56:06.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u9MLkbKjz/7664mKv7WKG3itm6gL6kS3LxndGLfAAaM+xTpG0n3VwxBgF4ANHDdBgJlVQvWnLhgUJEQmtjB6YDaemB4gXBKYcKxJKj0gF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510060148
X-Authority-Analysis: v=2.4 cv=Jsr8bc4C c=1 sm=1 tr=0 ts=68e410cf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=ubd3vq4MkeKbj6LAuGMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625
X-Proofpoint-GUID: YW0e7tmnDdOy62PaF2ar5ih4dScpAH_7
X-Proofpoint-ORIG-GUID: YW0e7tmnDdOy62PaF2ar5ih4dScpAH_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEzMSBTYWx0ZWRfXywspD1gQWTGx
 uO5XI048hmoJ/5RSlGSkaVnEybB80NQJz+k2WA0B5+3BnT2whkWxJmChH3RMwRdfU+/MQUo20Wq
 HOgDbinjFh2bByBd4j9ig0p5GLRuv2Yolw8bfPd+FM7ynXZ+7i90nmHgHqVR9c13fdpwAg2eXS6
 6JU91d7ZdSXlC1qELDp6/nGM2z0w+dMz+Q5qbZE9G+mEpf2T2FaB5v8tMOFfppkGir7oTLbgr9r
 dYO6V42j6+oy3bmCEpJQH7aJbCnwWDrFJipwdurGPv0mXAYVDTEIwTkaHuE5ZcbBB0V+Ed0Ggwr
 +t/mIve1pPFV0LMwGqk0syGWteFBGZdLuMsRimCndi0SK/VewojdwWb2jCme7KxZumvgOX/YVjo
 qGGf/NHLl0re5LNPuMtLIR9ay2F/LT2ZA6vT+du2Q7wsV3Qommw=



On 10/1/2025 2:09 AM, Frank Li wrote:
> +int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
> +			     enum pci_barno bar,
> +			     const struct pci_epc_features *epc_features,
> +			     enum pci_epc_interface_type type,
> +			     dma_addr_t inbound_addr);

nit: Any particular reason for using inbound_addr instead of bar_addr ?

> +
>   int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
>   			       u64 addr, dma_addr_t *base, size_t *off);
>   int pci_epf_bind(struct pci_epf *epf);


Thanks,
Alok


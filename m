Return-Path: <linux-pci+bounces-26741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F5A9C594
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731163B7939
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669A20102B;
	Fri, 25 Apr 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MSW+ufHh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDczzP0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4D18D;
	Fri, 25 Apr 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577178; cv=fail; b=HID0y9tbEi00yaJGC8yp9ZAk+vNJUi3/f3n5IFZOJHg/MbjrY8aWZyoV6HvNHyTXiq8RdULSg5hfd9lIl41ZZ/NsUrCKoGBgNNbkGX7phVigXJ7WpLNmvmHSa/b0mhp5Kp0xXbTy2Lh8VBD/s98R3Zg/sqEIqsqVyV11JGRiRdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577178; c=relaxed/simple;
	bh=nSiIsx0zX07NVByUnjZ0fBhJNY66zLzeWI2sc+hGLY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4ot7+0ueWs++Rg++gJVXDYAbe5+bIGwZ3YT06eQR97XZqVxj8bH6aJylvH2I/luLRR+3tUac2h4WbbJwx8u0dKJWTx+XX9YEDWYwIGqkfgXl5WTMxXi88czK2EF/j28/BQiDzpzPxEVrpAUMasfqFYlGDhdAp22M8zow3TSLB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MSW+ufHh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDczzP0f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PALXWL012425;
	Fri, 25 Apr 2025 10:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J7DCuYQEpaBQOyuQJfkYJdgOiZpVoONcZ78bP0U/vwE=; b=
	MSW+ufHh21+IU5o6A/H1ep5Iq4r3e5PEpFoD9EDwvPxqZtQN5VacfHop/OOZnzVH
	kOMvfRF+F+OXzndWmdASSSFQV99Ay9y0/CAHwocZjorONTGN+s9tyNoDCJ/MrvOc
	wcS/AK7UiBBsUcFohfHpFPHglQNmVwPWqS3JyMU7fuDZoAyyJhSa8L3Cn/CUW3jH
	lMeLSc1V/+dLMgYnFpBXGhxzUSshJcXsDAOxoHPHzolS9hgbOuU62LjRY50J+v3p
	RGC/w680DGgt9VZYOGFJtIzILwQNAyH08YKibU79PvTfBudRDA5WFQmAzInhjEUD
	o8+lY2KFLy6vZl0yS3hCZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46888k01bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:32:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA9Q64024870;
	Fri, 25 Apr 2025 10:32:25 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467puckrcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7g46tICmYwI2TOYedxE31N2h7iTsr9rKJFsqHZAMY+rWYCJB/77vbcfGBZ4u69SeSdzE1xgLo9zd72bI4eEcYA8BfpKSNDYbPno09m4lESjreZEUXCU0EDpq8Va7GqkJTTTOLnnMv1nNj1/QCOA5tNYjMYWg9fLYr4hn6rk3hz04Pu/1pzNtvu/dsTphjJanUwJxtbD5NQFRWrgk95yYh9TZREM8oBeVe9QbbRpobEq65HXuAEHaJJaqODmnccrklGC9FmzHvNYXlRVr0alOyC/uxY7xp9PS5mm7UC1B2tWYw3LPC36OjGF9W991PxfwJJ9CluuSOx9WFzhoC33Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7DCuYQEpaBQOyuQJfkYJdgOiZpVoONcZ78bP0U/vwE=;
 b=Tn/b6WEZ3wryrM90YsngmwdvXaKoC4ymATyJ+1JrNGo0tjb8cBAAFzqMQRq5tymLTcKP/r0QQah7u7kD3tcWVmCQ7qOlue3/aQkY9A4ZvyLVVM2/UcICth92GAJtNyD8rMi/QnZh4EZtzaU8xQLRfB5ncq4HNE0VwPyNTxSHfGW+Qy1g4R78+pYdPaS/E3rhiPBwj11HPdhc5ET/79M4KVDOYkVJJ1NoqCzal/0maOv2LRggwWVgiNJmXOSl/hAP891CnHTdhEZFyDPEFuGxYo8O47QK8WtZ/xg6agAvPboYmY+JK15e0g+ME8dvzDnExXQgMPXaPKWC0eh/oG+T4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7DCuYQEpaBQOyuQJfkYJdgOiZpVoONcZ78bP0U/vwE=;
 b=CDczzP0fJEZzx2wUFvtG/78DfwpJAjk87pQQQkfgytqKyHQoxy79AvuYWhwvkkMHIUR5RUUdexrtlkAzuLdOYRBiICrOU4+QyycaOCm5ST6sRrNodSI251AG6uEtlspRIK9QrnOKFbVje90hNu4/+bu4jaEUWIup8l2noxGzjXw=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by IA1PR10MB6099.namprd10.prod.outlook.com (2603:10b6:208:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Fri, 25 Apr
 2025 10:32:23 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:32:23 +0000
Message-ID: <61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
Date: Fri, 25 Apr 2025 12:32:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Shen, Yijun" <Yijun.Shen@dell.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424172809.GA492728@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250424172809.GA492728@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|IA1PR10MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: a6775810-a341-43de-c974-08dd83e476b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3dYMzAzMEhzWktQZS9FMHlzbUdWTDBOeEk1ZnBrY0ZJT05Sd0VOUzNNeFh2?=
 =?utf-8?B?RWlFZmRkWW52cm52ckFWeUE3WHByOTBWZ29sNHNKa0ZhckMzYzU0NVBLcnBl?=
 =?utf-8?B?YUZUK2JBWDJBeUNFQnMzSkYvVEZVRHBOSkp6ZjNVN3ViOE5QYVpZMDQvN0tj?=
 =?utf-8?B?OHRkUk9jckJtZGVXamFJbDFTL2wva3ErOVAxZE5SMjl2eFJESmFwb2JEYnRi?=
 =?utf-8?B?NEt3N05FeTd2bE1MM0lKNXVuK0pjM0xXT2pBWktNQTNYSDBDM3d1TUJ0YVU5?=
 =?utf-8?B?d1ZjSnJkcWtCSHlMdnBHYUFaNFhjNzBmNm1Jak9QK3F5c2U5SktsMVFiRldw?=
 =?utf-8?B?WGZ6eUNQaVFNNTRQYU1GQU1QR05nTmphUjEwOW5zdzcyZzhNa3paS0FSajMy?=
 =?utf-8?B?OUk0NXpFeFZ4Rms4SU5zSGVTMjRqOG11TGlXVisxc0RBYzE1UjYyVXMzaWNM?=
 =?utf-8?B?VldQV1J5WDFaaC9HOXlpOGVIYTlrbi85d0lIMnFnZVBhM0tiRzA5UkpzYzIz?=
 =?utf-8?B?dVFiWlJncmRLbDZKSmFUV0lMZk83UkJvU3hQMVVwWnd6QVUvS1R2NmlTUVpP?=
 =?utf-8?B?TGJFdTNKOW1RYml6M1QxYU5KbzRqTXVtZzhBMUJ2WW9iSTEzR0VqeWswSWNr?=
 =?utf-8?B?NkExR2xaYmVTa3B4UzU5V1lBdWRsbFl4cXkwWldLcHZDRWpRc015ajdic0Rx?=
 =?utf-8?B?em00N3NmbFF5OHk2bFlDM01FT29FREdnaWpxRWlTOTUrajU0c3dObmtWcUta?=
 =?utf-8?B?cUdVbUNPdzdCYzBMRVF6VGNJRUpCOHpyUUtYaDFCUVQyK2xERFgwYjd5WGla?=
 =?utf-8?B?MDN2QVJnSTUydnYvR2tWMmxWK0dQdGdKU0dnMlpPS1gxSFlmUmsvTnpaM0Ft?=
 =?utf-8?B?YWwxdGhzaWpheUhNSzBidVJndGM2NUFGUWdRWE9kZXBZMzZFdE5jLzRsenEv?=
 =?utf-8?B?Y1dMOWdpUkU0bXpRVk1xaTlJUVdlVWdiMTg4aG1FWmlMVVhMclZubTcvY1g1?=
 =?utf-8?B?WWpnakZUd28xWFBidUlUaWExTW1QdkZOL2lIZXdHajVFWis3VVpGaEVNYTVF?=
 =?utf-8?B?ajRMRUcxYkhHS2kwUitNb0VPSzVCOEc1MnZMRW5FVHZuMGx5cVk1cG9aVVdI?=
 =?utf-8?B?SkxpQ09IeVphUStLcmR4b0FGUUVXc2p3cVA5QmV0M09FR0lIYU4xOEdNaHZQ?=
 =?utf-8?B?V1pDU28wYXpaTkVKdW5iRFYxdlk4TkcyWTZ0TjBCMzJ6cW1YVVYxWmpLRzU1?=
 =?utf-8?B?SVYzc05YZ01Xd20vZmVWWmVGVmtUK2tYb21PSXZhUVNSNFZnNDlPdXlLWGFs?=
 =?utf-8?B?WTZuQ2JwTkl3YVM1RFdKY3Aydjh4THBRQWY5K2VVZDJuMk5JSXFZRU0rNUtU?=
 =?utf-8?B?cjZ3dC9vMjBvbUk2YnA5RGpjeTlvalAxakhhR01IeTVrMUpseTZXVWRSaVFh?=
 =?utf-8?B?dkdmTmdNNkJ2bzVoK0hQOHlzYU9jcm0zcUxacXBNcmdycEtzWWgrNk15L0FH?=
 =?utf-8?B?dklNSlNLWlpBYzFXNVNqVkdNVXR1bE5yZnhUMGpVMFh1bkFuY1RtbmNKUlh0?=
 =?utf-8?B?bUd2TEhlb3VSNWZScDl0UHMrNGpHN3RjcFAxNVdaL1ZYQlduK3k1YmpBOXRp?=
 =?utf-8?B?TkNMK05WMExyM3VhQ1IwT2haN25XTUtTc3FPRnF2R2E3dXVPMStiRVg5Q2tu?=
 =?utf-8?B?SXprNEExejZKTUZRZ0NLc0Jxby9lcGVoTFoxMnZmQkVIbkdUVitIRldRbWMv?=
 =?utf-8?B?Zm5OWW5vLzJ3WCt4RkNmL3BBYzR6UThtNGRiSVcxejhUY0NLVEF1ZHJmcmNW?=
 =?utf-8?B?dExic3RPaXdjMzMzRGEwU09OMWloTVprS1NKa0dZMUdWVEhTa0YyNTJpUkJo?=
 =?utf-8?B?TU5OUURtd0ZXM3dsTC9iUnJUSWM5UFZMeU9KcWlUb1RRRmQwbkMyN3d4WVpH?=
 =?utf-8?Q?nphVmQUYHBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajkweWNkZ2toWUVzYkR1UHlLWEt0SkNPUHRkVjJoSTVGQ3dSSVlTTEpBOURL?=
 =?utf-8?B?V1ZZTTRBK1VnRTRPY0Q2MFhHOU95dG00d0p1N2hvVTJvSVl5c05PMjJaU1hF?=
 =?utf-8?B?SG54SHFlbWJTdkZFMk5PMUtQUWErOWxybi9LczJhU09SdExnUGJqVCtZeDFj?=
 =?utf-8?B?Q2I1NnFMTHAwaHFmQ0ZTdmlFUEtQRE50SGJxbkFjV0xtVmxTbWNqRGJwazJV?=
 =?utf-8?B?OWlIbGhhZ0dpU3paM3RKL3lyRkRXRTdGQXZPWk85SWNQbVFSYTVjMlRKajRG?=
 =?utf-8?B?WjBMRzJCNVh0MGFJNllKVlpRVjZlTEVOU2UvNmU1YThuYWI1TFE0WVhaQjhZ?=
 =?utf-8?B?UkFZZjh0WFN1MWZ5TXFyM093RWpCRDVRRnQ2TXBxK2Q2YWVmZ0tJdXROUytT?=
 =?utf-8?B?ZjlHTjc5S1l5emhyditqU1FGK241NHNJd3pFcTBVbEl1U01uby9UUVk4Zy9S?=
 =?utf-8?B?SXZaZXlUR3BsUGtBSmxrckovVlZSVzJzWWVibGx6N0hlZlRqVXVCRU1oaUho?=
 =?utf-8?B?aE1aRjBWbXNScXpndStYc3BMY04zMGdyYjgwaS9jWnRYVjVwSHJSNWlvb3Fz?=
 =?utf-8?B?c1dYdjRzdDBCY0h6RXpQN0ozcFBSdnRGU2c0VGk2aWVqODJUN2thNG5ER255?=
 =?utf-8?B?c1lXZ3o5UXAxOWZ4VzZQSUgzODA0YmlvMVY3TTN4QWtDR3BhVEZIOFFFbzht?=
 =?utf-8?B?MHdnb21OUm90SDZBYkF3WCtpbXdXTkFMOVRyeUR0UitTWFg5RWkrenZabUYz?=
 =?utf-8?B?aDUvYlNmMFU3d1JiSVVSYVBDZS9jMDBvcG1ybVNkNzcwVEE3bnJSdmtKMEpn?=
 =?utf-8?B?cldOT1B3dDhnNm9YMW9KRGkvYjNTWW9Xa0JkRHN4L2tMS0ZrQW5uQ2swTUd5?=
 =?utf-8?B?WFVLYTNaNEw3THlKWUU0alNMRys5U3FoemgxUWhZWWxOUVFhdXF5a2ZudGJw?=
 =?utf-8?B?WUd3N1ZBZlRFNXBrVVI3OXF4ZWJNc2p6MmdxODJDanpiRmt2dlpPU1p1Y0lH?=
 =?utf-8?B?Mk1hS3J4aEFSNWZwdUVZTTJOUGszUGduRXZ2SHZWdjZYZk5sVzAyenJYdjRi?=
 =?utf-8?B?OXdrclg3UmdTSC9iOWtvc3hrOWF0V0dnbDFGb2lwRDJEaHJWRjg1SUpMSTYw?=
 =?utf-8?B?S2x1cDE1OEp1SFV3cEF4Q3lyTnVwRXJYMnJSTURGZ2l5SlhxK3BXM1NXa1Fv?=
 =?utf-8?B?ZlZTM0NTcjZqRHJLOGxncENhdGw2U3pGejRmMVhBY09rVGszeXNkdk9ZU3px?=
 =?utf-8?B?L1dMNXo2d20yOWJva2VxVkIxelcxQ2ttckJJZXlCb1NDd3JpaHJZUVVZbDdE?=
 =?utf-8?B?YkpLTkQ1R3VkZkNLUk9BTjdxQmc1clNwOTRmN1FGQ2tNbnJDSURld2dHTm10?=
 =?utf-8?B?cDltLzNsbldZcElINmY5b0gwNFFIczVzM2hhcmZ0SUl6dDBWK2FrYnhwZU5i?=
 =?utf-8?B?R2pXcUZ0SlJBdXFERVd2ay93c0xIOGFCTnpoUmwvTjJZWllyaU1zNWlqOGxX?=
 =?utf-8?B?WHFIeDN6U0hkNmdHbWlLTFIzWE1sekJURFVFSmNLTHdteGRWczRaQjR2V3lP?=
 =?utf-8?B?K2xTb21Zd05RNGJqMytsdjlNb3p2QTRuS0xrOTBGck5JZCtrMzhpQjVXc1R2?=
 =?utf-8?B?end5SmorNnp5NFhZKzhNNW1heFpnWjAzck81QjRjSjB3TUwyQTh5WHl1N1BS?=
 =?utf-8?B?cVowWUhLNzJVWkRQaEREVHF1QXFZTzM5NTd6R0tIN2VKelppQlYySEwyd1BU?=
 =?utf-8?B?bkhmR2VkU2dwaVo0N2hWai81Zm1GYlB0L1JzQWlsZW5HNkdXcFpXNUJWankx?=
 =?utf-8?B?em12dm5JNFJycjFoMmxQTFk5UzRWa2YzeXYvZjAyUEJLR2RyNHdKZW1PTGVR?=
 =?utf-8?B?TWxjdm5XblVWcFE1aFJ4ai83b3ljVkluWTNCcEdvT1BRbGpINkJKbEpGNTBv?=
 =?utf-8?B?cTN3aEtoSTgyQVlpUFgvTGY4UnQwOS96cXdJNzgrMEQ4dUF2M2xMMzNtRUha?=
 =?utf-8?B?RlB3UkZIZ0pNaUkwZmpCUUpweUZ3SEZZUDJzN1BLUnlqZkgzanFiU1c5elhZ?=
 =?utf-8?B?MjRZNGlVZmZvMEpVcm9SUStNaTN0SVdvekRsYmdpRnJUTkhXcWs4M2svbG1x?=
 =?utf-8?B?blNGbFVJTmhrcHpkWmxEV0VJVjNDSCt5ZFF0RTVWUHpNVnRmYWM1ZVBrcVNJ?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2SsT2PRXxSqDybsgIXnpDAaXjHHP0YXhTbrG4YYYtt7/ET3U24oprprkPm1u0Vcorx62qZ6Gcc2f9+HX6Iib0DkXGGReX2wUvFj+WIUa4RxV+sl0/9UTM/PqbXM8TWypdImUrsEPJNFQR5Fcagv+HH+Yddsqt2o5CfY6w5NSPaA0DB5ezG5tOo/7sg3JIQnHoM4hbD/osjyVZ+pNRMUKmipNtKl0lFLo9iQuFB9NWi8fLQ5V5e7+Fx8NZ+Fnya3uePQKTxrOzLc8za2QRyrYaewqMaa1QdwexK4BdUI/Abkk94HtBRM0nJ8+7dMJL4M35CUslcxKbiSywAOXuYIXl13DBnR0pyH780zaHLkII054H/gPXWLh9oO7Xttf35IOKZuNHsvPlP25oT7jKtf7E8YasWGghrql3AWB3yAp+VZp6llV3c0KMsgDplJukrUzBsMZg6VDqK5htBq0HRiluwPJ0x9cv1Jv/HBxMPxMvzd6Z2tK9b+F3BXkkIk9G9PE+eo9LBTF8jQOX7wEniFvQgE4yNNGw4GYPpsbBsYrrNqb85jGMHWzO4Qrv/eAaaZpmURrSsuUXLIAVhiafBH1MKEtPap+qrDfbXbAufpJC70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6775810-a341-43de-c974-08dd83e476b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:32:22.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbL8AjnwprXGMLF8DehZ6aIwTI1HqoUREBlrXoKh5Y80QvAFZ7isb+lHS+EjVd2L+VcXCaXWQFBDpnEl2Lxt9qZ7hwAkHWKF72PEPNQmdDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250076
X-Proofpoint-GUID: Vi6TyKkk2VO226NXZbgWXC-3S9-eviop
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NiBTYWx0ZWRfXxxqqYnojJVIa uVIdOGP7/C0UzPVGc3yFxkrIJMmcOrQi1Bxu7jlcE7qPhxP7si2rh2nqzEsW2BQ9p1nCFOsOZns Yf1ChXwe4h6VUh7/0hvw7JSMffT5Ot0x/MCvhrJDQ9dG/GJnmW4N0sohsqiQF02iaIgFnmoG8dU
 KItAbYcKxiH2GCRIp54hQX7AERcbj1gaDF5Ltiq0IKUK+kjL0pdcY/HsDSq3zv+IWkIbzi8YgL3 Ki+OHfAJwhM/3sz6yQSr2+H12Mj4+NhDPupXN2h+azet6DvJFy6Jt9Pq9l+37rdyuFh2RkRuYer gg3I9GWR3oz/llUYazOwrpJqXC7dcr+ZUYiVdPT3O/EISzjDJIV8P2TCW3FZFJ9r/u3Mk16CsCl rKWlOU6g
X-Proofpoint-ORIG-GUID: Vi6TyKkk2VO226NXZbgWXC-3S9-eviop

On 24/04/2025 19:28, Bjorn Helgaas wrote:
> [+to Yijun @Dell in case there's some testing opportunity, thread at
> https://lore.kernel.org/r/81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com]
> 
> On Thu, Apr 24, 2025 at 11:01:11AM +0200, Karolina Stolarek wrote:
 >>
>> The only way to inject GHES errors I'm aware of is Mauro's patch for
>> qemu[1], so I went down the virtualization path. As for working with the
>> actual hardware, I'd need to ask around and learn more about the platform.
> 
> I'd be surprised if the qemu firmware supports firmware-first
> handling, so I wouldn't expect to be able to exercise this path that
> way.  I think there are some bits in HEST and similar tables that tell
> us about this, e.g., ACPI r6.5, sec 18.3.2.4.

It's possible that some of the nuances of this escaped me. I decided to 
pick up the series, as I saw "PCI Express bus error injection via GHES" 
script and thought it might be useful.

> Unfortunately there are some typos in the spec (FIRMWARE_FIRST,
> FIRMWAREFIRST in 18.4), so it's a little hard to find all the
> references.

Thanks for the pointers, I'll take a look.

> It's a long shot, but I added Yijun as a Dell contact that who might
> have a pointer to someone who could possibly test GHES logging on a
> Dell box with and without your patch so we could have a concrete
> comparison of the dmesg log differences.

Thank you very much. Let's see, maybe we'll get lucky :)

All the best,
Karolina

> 
>>> If you can't produce actual logs for comparison, I think we can take
>>> info from a sample log somebody has posted and synthesize what the
>>> changes would be after this patch.
>>
>> I also found some logs at some point, mostly from 2021 and 2023, but I felt
>> bad about mocking up the messages and tried to produce actual logs. If I
>> can't find a way to get this working in two weeks, I'll revisit this idea.
>>
>> All the best,
>> Karolina
>>
>> -------------------------------------------------------------
>> [1] - https://lore.kernel.org/lkml/76824dfc6bb5dd23a9f04607a907ac4ccf7cb147.1740653898.git.mchehab+huawei@kernel.org/



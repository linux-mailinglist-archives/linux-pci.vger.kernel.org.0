Return-Path: <linux-pci+bounces-42845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FECB0216
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBBC83015ACE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35A227B8E;
	Tue,  9 Dec 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xgz+yWAo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BGNs/nRB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CA15B0EC;
	Tue,  9 Dec 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288809; cv=fail; b=lDQTNYjct2TSwYeVxKXIJT0Xr+yoXqlbMskZ5IMYB0EjRZsPl3FoAz1PzVA/I1Yq6EBphk0AfEUGPFwD4BhZv16ExmGm7CoDnWJlyj0npBDfh6QIVrI+JxPPfpIZeSiF06tmsfnL5m3QICUB8A/ea7g08sdRhorEEZjabeiqnL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288809; c=relaxed/simple;
	bh=XRhcTlLxo5fdua7SPGw7Pjdr25USedh3x0bD/MCCtaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HH0kZ6MhYcpu2wPlLXH/5O2f31zme933X+yK9/BRa+hYtcCFb+SAgZBwFlJlJ4Oq+kBbkCjbhJFQltFhZTDnhCroUvX4SJ62UXuzLteOd+gok4ENkSajvll3iTtm+l2/wDI1c8aBCS9sNKIAltvzUf4x9JRITQZN/0ofbKeNo+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xgz+yWAo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BGNs/nRB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9CDN5U705841;
	Tue, 9 Dec 2025 13:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sPXRIOnJ/NPllSe38d+fcUyC4kbdt334FpJtJAnPquo=; b=
	Xgz+yWAoq2Ia4WPhpMhetnj57r+MeKQGMpbwh8XcAJv01xYEjXQuUP7e1BDXzHo0
	iWg3whDBdfYrKhcECC9bQgh0EI7HVmDoYg9u3ZDTnZxXKKu2RwnJu9R6nk0jXKe9
	FqAQlgDzFVtD3Hpzn7az+zmMkTjC5x2XQrT2xHWbpeFxAirMRsI/eXlTDIGJy5TQ
	dgogmVizfvTzR+v+0HXr276KgXHgGp4AIVrK9wOxGVTJNmKXGlTJWl3M3Pj3/cGi
	pOZiBbYyAv3pHUtztuKYlM0tGKHf3GJXj4fp11ZQz3SBszG7sF+ODNTnK0HbKRuY
	NdZARynopNVs7GBKDZgd5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4axhmv8cmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 13:59:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9DwUVn020889;
	Tue, 9 Dec 2025 13:59:17 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avax94nab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 13:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvbwRUG2nJqlyLYxQXSZP0pSvqeqxTPOZYJs/oLMBRhFRZubC6WpY/NwrJLdWTto/szoMBc+qeSCfVa+mPVTpAua7QE0aTyDsWXEBo9JCZXPcNT/5rFYXKGtM7ew7uLXg74HrvmynNfrwim23i+PHndmTtk+T5Ji3pWFkbnbnuf9iaKzHYCMr3rglgshJlMW4ZaC1D17uJEgyNaKeUzfmg9W77pzBoIHOZahcW+f5QyAm9fvSW3B86UuGttl7EMQvPbVBo1SeqLUDTG2DyMqDgJtBnJ1uTiTk8s2gGOgHG+9EzZlpz6gKfKclKZzv9HJeovFyqCyAm/pT3W9u47zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPXRIOnJ/NPllSe38d+fcUyC4kbdt334FpJtJAnPquo=;
 b=gei8oKvq6qhMUoHQ3SMWsVkOxutfDc3/vo5qwLNPUVbmpdHD1mo7nWR5oGoaP7AG1o6lB8T/Eyu/yQeoGKg7wpXgZxgN+GEim25+AQ/ehE8kJH1ZW/ykKxX/giIjwTt4k78PgzEQ66Jj6MbA2o+UvvoS9/aGQNRIoXxlNowpycK9vKA63T3qfjn7FeeEurW5TvIk+imRjLOJd/HMXpYEcBvpCJPUXg0SOl/d26mIoihEFKBTQu7NTuWc30ubShp77mipAe7EqRnPigJRs6qk83d/ixFaCfZDQVV6L6Up3lP2CNp1gws8M+nUDwdtrFji8PZAfnfOsfSVqoZ0dcI+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPXRIOnJ/NPllSe38d+fcUyC4kbdt334FpJtJAnPquo=;
 b=BGNs/nRBjoUHhNYx6YFmJL80wquMYsq7iP+qC/UMnx0sZAW+FuKertRyzvGlrCn83f3HpFLB4FIUYG1ulpLOt8DVhjmnLd+WPR07CJjhL/QPuqlbnde/ZvzBIhciWd5zVyHsC/6PpqWebIiD6HWRdmxSbc35jQd3WLVN6RPsbC8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM3PPF0275307EB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 13:59:15 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 13:59:15 +0000
Message-ID: <1ad20492-f342-4a4b-8a2f-228db7c5673a@oracle.com>
Date: Tue, 9 Dec 2025 19:29:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v13 3/3] Documentation: tracing: Add
 documentation about PCI tracepoints
To: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
        lukas@wunner.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
        ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
        Jonathan.Cameron@huawei.com
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
        naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        mark.rutland@arm.com, peterz@infradead.org,
        tianruidong@linux.alibaba.com
References: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
 <20251025114158.71714-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251025114158.71714-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM3PPF0275307EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 279ab232-5e16-4e79-e956-08de372b233d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUJsSThjeUdRckVHL09TWkI5VEoyblJvem0vRU5weFpxZWtPc3VWVGN1RmRK?=
 =?utf-8?B?L0x3RFN2OXI1d2doVmdGVXhzMGJ3YU1iOCs3T01qcmpqaktxcDdoSUdkVGJo?=
 =?utf-8?B?OFRmWmRtS2d6QUpsZXVtdFd6VlQwSDhtRFF6NkZPMWo1c3pKekNwcEM3THZS?=
 =?utf-8?B?eTRQc3pYWk9nVmtpamVnVEV6c0hTV2ZVUFEvTUpEMm96TWV6U2dvT0dIYVZw?=
 =?utf-8?B?Qm9rZXk5V2dlSDFIaHlyM1FFSWtDWVJSUnZEOGhMcVExTlJPREY1L0ZmZzhi?=
 =?utf-8?B?THQ2MW44MzAvcHR0VlRnWGFlQys3M0F3L1lZS0dmWm1kbTNUUSt1c2NsTnpy?=
 =?utf-8?B?S3M0MThKdmxXMm9JU3g1U3ZsQU5wMzlpRm8wV2NGalAzTGRYMFJrMGZLaldO?=
 =?utf-8?B?aFAwWjhTU1VPMk1NSTBBdnRCaVZRZ1BNcU9mbDd5enlIVHl0VU41TldjbDMx?=
 =?utf-8?B?ejBoR0w2MDVWNytJYXBNek90ZG9MckZPWFhDOGNiaGRzLzdnWjNEUDREUDJq?=
 =?utf-8?B?VWh2NnI0NXBYT3BuUUtuTXZJbklHOVZMMURvRU9HMnhwTDVMZ0l6a0U2bzQ4?=
 =?utf-8?B?MWx2ZzFlMGRlbmlkQlVaNU1oVDlub3EyTmgrZW5CcHN2c3p4VHBjTEpzQVYv?=
 =?utf-8?B?UWhoRTQ5MzRhUitjUGdlSjJaMC83Y0xMcG5XRUNMbVRTQzk1WXgydzA4UzR2?=
 =?utf-8?B?S09mejJhMllwUHc0UEZ5cE1LNzhJUlcvSnd6N2xPSFM1MXVFK29nOVIyR01W?=
 =?utf-8?B?ZlEyUm83aU1EU25FeWpybE5lUzFERGQ2bHFYUWFEV1BHcWY0RUh1WDI1RXQz?=
 =?utf-8?B?VHpZdGI0VHNrMXU5c1FEbURrcHZmTEVNc1NZM2sxZUVqT0hyL1RwNWVPOTg5?=
 =?utf-8?B?czJmMWtVejBWTWJBT282dFhxdW5xVk0rbFBEVlN6OTZyNEJpOUh6aE85ZTBz?=
 =?utf-8?B?Z2orYWJnSlN4MmRtWUw5VnY4bHRlaTVNTFZ6RHN1cmR1ZUlXWi9aOUU2R2Va?=
 =?utf-8?B?VXNhZmZiY0c5aVN6eVdLSUU1OXJqeG9uL1J6YlI3MTVSQjUwTGgyendERkIx?=
 =?utf-8?B?enFxbVEzYVVoa2dWcWpwVjY4MGxBTDlZVU9VZkVYUjVIWWtRZkJQdnRiZkVz?=
 =?utf-8?B?SWgyYmdYWVNFeTlOd2lyby8zQTFHNlNnb05SclpDcHlyT1YzUy9jeUtqemsz?=
 =?utf-8?B?alFjRm40aEI3WXN4QnhSWEtYSjdpcVV5azhCR1B3NVU1dFhuaVhyQmZtNDYz?=
 =?utf-8?B?UE5BNnJCVkthaGR0YmJnVEY4emI4NE1GYVF5Y2grOSs2a0k3c2tENFFWUnJx?=
 =?utf-8?B?d0RYSEo4SlVGbklRWmlHdTl1dWZrRy80Z1BxZjdlTEM4WWxtMnRNdCtCZWl4?=
 =?utf-8?B?UUZJU0FWTGFtQUhIeDc0WnlSVkNUU3VueDZOblVIdHhyL1VHaERiWW5HL1dX?=
 =?utf-8?B?YmpDa01WeDg0eDQzMU55TmhzajdrWnJOVXZFYXVCcFc2Y0tvL2FYVFNxdDlO?=
 =?utf-8?B?cDJPMm9FeGY5UGVZQ2dIMkkyeG1HTHh1akI5YnVaSFpYNEFDR3UvOVg3V1d5?=
 =?utf-8?B?OSs3M2NFb0RtSTE4K2FEdW9DQ0IzUXJjSHIzME5LVHNTYkZWV2YyWmx3blRn?=
 =?utf-8?B?NzExK01WaXVXbitrMGhGRWMzNUJWcHU5bU42bGdzaEw4aFdyVGpUSHR1WWU0?=
 =?utf-8?B?cEx5Njk0cHpTOEVsajRGVjYvVDFHSkdFOVdhVnp0b1doa2Z0SDlXZFlqTG9B?=
 =?utf-8?B?ZTQrd0VoSS9zNkYxZU1XTm9qU3A4MG1JMW1KQVlka2tzdWlRQXdWUUFVenIz?=
 =?utf-8?B?ZGlPQlo1UCt1R0laOWFWYktsSEx5cFA5aHNFQmpDMU5CdThKTEwzbmJsUHRj?=
 =?utf-8?B?czJBcXVibXZQcWFRR2pZeDU1WXlzMWluNjFvZ2FUdE5pclhJU3R4TmZTUFN4?=
 =?utf-8?B?K1VrMFNialRjazhmNTdEaUNDOWtYQjBrUXcyNU5nTzJ1cGhZN3ZsbFJFN3pz?=
 =?utf-8?Q?dLihaw6RC+oiZAc24p1mwOeSFhfNns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlpRUFZJWU9MRytIMTVHTmlVcCszcnExY3dUdXF3N1VXSnVFU0tNbmFocU9v?=
 =?utf-8?B?ai9PTHlzTFNCM1BuZE1PWHY0WUFwZGltWGtER1lKeUlRcVYwbFdjSmlQdm1q?=
 =?utf-8?B?NUFOVXJWOHVEZDltTTE5a3RzNklTdnE0VTdKTUJMclV2cWprYkVMbWE3aTJO?=
 =?utf-8?B?S2JsWWpheC82V2dXVHg5RktXUXRCVlozWGVLRHRrNmVsd3hwWU1iWXRrWHIx?=
 =?utf-8?B?MGFQbUF2NjNpL3NXbmtIR21iOXdHWlFTQldGdjhLT3lONGIyM2RYaExFUUlI?=
 =?utf-8?B?UmpxMkhuVDF4S3JmNEVYa05xMjhzaUVxdmUzMDNucDhsaXhBSkdOdTkwQStE?=
 =?utf-8?B?cWxPNnEwQll6Z1BCc0FvWEhNclJXWHZOU2pmMy9oNE9sU3BIdFI1UXg2ZGlD?=
 =?utf-8?B?ZUFUY0xnais1TXIvZmwvODBHSGRUR0FOLy9IcENUWTVFY3JpbVZVM1lxRG0z?=
 =?utf-8?B?emNreTQvT3BlZW9QQkE2M3FzTzlqL3BvSHk5amIxeTUzQTBNblNhNWVEWmFY?=
 =?utf-8?B?UnE0OXhDQ25RZTdUemp0cXE3SWcyY0N4TEJmb2srVWNsOXFxMThLNTEvUkxC?=
 =?utf-8?B?NlJ1QnJsK1JBQjMxZ05hOUtVdGFLMk94eCtiUlhodkdldUN4T1ozekMvcjBn?=
 =?utf-8?B?V09ySjRUaGhJVmZuOEx6eFJjeS9vSmtXRS8ybWMrTExLR2padHpCb2s1enVE?=
 =?utf-8?B?Uk1DM2RyWDA0UGZrM3RoSHBVNWJHMCswbCtVOTlHemlndjU2ZWFGZWVxZ3FB?=
 =?utf-8?B?VDlpU2h4WHR1VlRmTzFUMTBybVdIR05kUWxiTDR1czRWMlNPd3I2K29IYmV5?=
 =?utf-8?B?bUtjTVc2YUQ0bFp5Y3FXOC9xamN2TzVKYUFYcmJrZTZQei9BRGFMNFZURGxu?=
 =?utf-8?B?aUhMTEdLaGpLdS9uK2UxdEdRVTR4czFxeHRFbEpwd3kvdTgrdE42VkFqSlIw?=
 =?utf-8?B?Nko4VjI5d3JPN3YzdGR0MjdCSmYrM0F0R0JWWU4zNkJCMlBkbUkxTFRPSFNX?=
 =?utf-8?B?QUgrbFFHbXBMRDdUMjNIS3JaYVNPbTVqUEVzYSt5SEtxUGo0SXM5OXRwZERO?=
 =?utf-8?B?TGpMVW1rc3oyUzEzRkRlTHZ2a3dmeGw0NEx3dEgvY1JlbUhxdVYyRGRXUkZN?=
 =?utf-8?B?UVg0M3F4VktkcjM1WnA4bU10K3oxdGRjcmgzd0dXK3RIQ25JRnpnZXR1Mlpk?=
 =?utf-8?B?THAyU0FGR0FaVHJ4OS82eC9UZVFyTzlWVmx2WHFuUDlmZTNRZFA5YktFakpw?=
 =?utf-8?B?cFZWMU9vMjB4eVZuMHllM2p3UnhuYXZvUW4wY291MmIxeVdKZ1EzMnp6REU4?=
 =?utf-8?B?VTlLYmpsU1FaTVRCN1YyUERxR1I2dFZpNGgvVWNpRkN3bHhXT0RWUkxIUXFP?=
 =?utf-8?B?aDJBUXMyOGx1WWxiZEs2VGNucU9aWmc3MGQ3dzJQYy9rTXRISlYvWm1OZWR6?=
 =?utf-8?B?YnBFZGNIUGc1SVVHcXFTRHBQZFBHeEVzbU0xbVVsamhScWpoUEtSbEpBRyto?=
 =?utf-8?B?TFBpMEJ6QU9BTFBONVhid1UvakZJS1RzVFpQMTdaSWoxKzM5UUtqbER6ZmdE?=
 =?utf-8?B?TVhYZnd4czVBQjVld1YvU215bFIxUWtINWd6THZUc2IyMGVPTmlYVThtNkF3?=
 =?utf-8?B?WmxWc2FYNGlodUZGMWpuSHNjQUNUY2hSRDZiK0pCUlJXQWtKMEE3MDM2UzhF?=
 =?utf-8?B?RXRJU3R3VzlQVlNadmcydWdvV3pvYUZTNlM2WDJDLzV3UE5seEs0eGNDQnpD?=
 =?utf-8?B?U3piMjBIQm5BYmthcjVJaUhZWTU0TmlIbFpaTllpSFNRbGhLRFVjNTFiQ0l4?=
 =?utf-8?B?bWdsaCtJWmRRMm9qcmxpZkJxTTI1V2xXQ1d2ckc1S0F3Yy9sZm1UVWNzNXda?=
 =?utf-8?B?RDlFZE0zZk5qa1ZpM2dZOU1EZE50c241WFRKc2REdkFGNzlQSGNyRmhWWW5L?=
 =?utf-8?B?SnBGUS81S25RMCs5My9IaGZSY0E4WmxXTGRQMWhNNElSdlYxVmIwajBrKzAy?=
 =?utf-8?B?UlhmNFdGRGNqZHpoRFRKRTd2MzF0QXBXMDJLTE5jblN0Q1JZRkxsNlIzUG1j?=
 =?utf-8?B?VG1YYzg3ZjNmWVNBR2orbnUvaW1EUTNQbkptbUpVNGpKSFNGYXh6MG9DeHVa?=
 =?utf-8?B?elN4NFJqWlBpMUpwNXJRUlB3a2p6dEtiSW1jbWQ1eUFSK0lHWm82U0N5a01p?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a3kUMVaanXvQgBMGkbFHqTNtqM8gwu9rLw8iGcv4aV+DPjBKC/97YBBT0x6AEfPNksmh5jzZNBe0BZAdL+ZMu/41lLUTDdBb4h5dv7c/uLbEswnrPsbMWl0pWF0efKNx4UyeSJc+ld186iYt7GYubqGmA2FXh1XPbBBiZsIeGvAUWIsj5oyg0DM7z3Ct0UiMxPl60P8AHCtkiJnzr/MpA/pWqPVFyxffAHakCIcucqxoUuD5DB1z6k5kXirnN/cfiRjBntU5HylJFR9LXi8joDmi88knR7jQWegVDedIyApSgoCAb6SCeO8zORW8pUo9JG7U97UhiNK91w8maow2VPwT7vlAM9RFrC1QoN6SuBEwB2oEs/94y/0oU5Skr5QbDjAFW5vqmqbyqJm+UcoB9w/LE+v1+npl0NAQsPlo2TmR0IANUVeuvi0DkRXwEk5+LTYKVnd1mnVznSne5OmusEYZbr9ihaolDaSypAgiQy0JaCvuWIaV4oR8l8A4xz6R2l+T62yqHfphlylw6yoehOxUOwm98Y0nVCMmNelX+ms5e8SfE7fXZS5m88zNPSr3ggzje3Gndi3hoylow2aWPROQmOpteOXASAgyeCU7lMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ab232-5e16-4e79-e956-08de372b233d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 13:59:14.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5ledOx09yiYf0c9CwPTPshB9hAeTDGD8CZslagrX4zuyqNe7HB1kl9ZhqUcYXqDwDcPNmt+2bHz1KSNDsGugpzAm1pKgpyWGeFU7cfUruQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0275307EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512090103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEwMyBTYWx0ZWRfX/XN/f3FkDdJ/
 /pGYxs4022t6JMx5DKHYraVFGmXx7GGXC3ODDUszOlljOCR1fo7Cm1tyHSd5wJNcW9VVAoCKzQ9
 dGKtDBE8g8juMoQPa0hIxlL/Q1GY8NHpUCCsF26pnmfuDiodcVZAEyEXY+lg2nQS88Pu6AcJEPO
 O8exAAtlOwj78f1G5+fuGuH7jE0XJ3rhIbXJg+hglVPuAd3cfMyFHxg2g3PEcYDYd739lJcfSPI
 Fh3Wl5oibZ3P9qRDgk3Ld3cIlSaaR2EyV8bvA7ijZjfp0DAshgly0xbRGfr9E3eDDPFnjMa0O2c
 T8Xd8LSxQzGNdU0ct5lTMhJUYLcmxH7xdRKMlEkSqcQLpj6dUpKwl5ez+Jdz8ItR+Z3yvQNgVvw
 ssG0bur8/owujwlUq3qbi/y/v1VkUQ==
X-Authority-Analysis: v=2.4 cv=PbLyRyhd c=1 sm=1 tr=0 ts=69382b36 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=SRrdq9N9AAAA:8 a=4M91okgt4Z9isxz8_4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2nyewWJIHn3AqfF7HEh9Jz9jdJyxg5gY
X-Proofpoint-ORIG-GUID: 2nyewWJIHn3AqfF7HEh9Jz9jdJyxg5gY



On 10/25/2025 5:11 PM, Shuai Xue wrote:
> The PCI tracing system provides tracepoints to monitor critical hardware
> events that can impact system performance and reliability. Add
> documentation about it.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   Documentation/trace/events-pci.rst | 74 ++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>   create mode 100644 Documentation/trace/events-pci.rst
> 
> diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
> new file mode 100644
> index 000000000000..88bd38fcc184
> --- /dev/null
> +++ b/Documentation/trace/events-pci.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +Subsystem Trace Points: PCI
> +===========================
> +
> +Overview
> +========
> +The PCI tracing system provides tracepoints to monitor critical hardware events
> +that can impact system performance and reliability. These events normally show
> +up here:
> +
> +	/sys/kernel/tracing/events/pci
> +
> +Cf. include/trace/events/pci.h for the events definitions.
> +
> +Available Tracepoints
> +=====================
> +
> +pci_hp_event
> +------------
> +
> +Monitors PCI hotplug events including card insertion/removal and link
> +state changes.
> +::
> +
> +    pci_hp_event  "%s slot:%s, event:%s\n"
> +
> +**Event Types**:
> +
> +* ``LINK_UP`` - PCIe link established
> +* ``LINK_DOWN`` - PCIe link lost
> +* ``CARD_PRESENT`` - Card detected in slot
> +* ``CARD_NOT_PRESENT`` - Card removed from slot
> +
> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo 1> /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable

missing space echo 1 >"

> +
> +    # Monitor events (the following output is generated when a device is hotplugged)
> +    cat /sys/kernel/debug/tracing/trace_pipe
> +       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
> +
> +       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
> +
> +pcie_link_event
> +---------------
> +
> +Monitors PCIe link speed changes and provides detailed link status information.
> +::
> +
> +    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n"

%s -> %d mismatch for cur_bus_speed and max_bus_speed

TP_printk("%s type:%d, reason:%d, cur_bus_speed:%d, max_bus_speed:%d, 
width:%u, flit_mode:%u, status:%s\n",

> +
> +**Parameters**:
> +
> +* ``type`` - PCIe device type (4=Root Port, etc.)
> +* ``reason`` - Reason for link change:
> +
> +  - ``0`` - Link retrain
> +  - ``1`` - Bus enumeration
> +  - ``2`` - Bandwidth notification enable
> +  - ``3`` - Bandwidth notification IRQ
> +  - ``4`` - Hotplug event
> +
> +
> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
> +
> +    # Monitor events (the following output is generated when a device is hotplugged)
> +    cat /sys/kernel/debug/tracing/trace_pipe
> +       irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:00:02.0 type:4, reason:4, cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, status:DLLLA


Thanks,
Alok



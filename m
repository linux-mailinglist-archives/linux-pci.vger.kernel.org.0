Return-Path: <linux-pci+bounces-26690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A1A9B0E7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2011B84590
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6843280A5A;
	Thu, 24 Apr 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcGoESCz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3727FD70;
	Thu, 24 Apr 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504730; cv=fail; b=ad0ZzO5JpQA8aYzy3uyyPLovUM+VzQTjw9UqB49Z84RyKK6BIwkSmT/gEb2vxEsppi5s2UTZ6xesBzPpCGM6h0FkOxU6MCpirkaQeNzr3PfyXeFhPqxFkZLr289LqgIpA9UGyasYoJz0yGAGOKRgFqajrF2GMRXs7jwx1Asebr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504730; c=relaxed/simple;
	bh=f5cqnNlYUN9tbtOaN/ZKG7nBEFd7z0dti6ZNNr8kpZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRlhV15+wjyq0okzDA+BSPaQeZQU+25jE/NH6twP7pAFmSyuK1khmAXnMSrsXYNHw253VzYdMaU9dnOFkg2/uApoz2DqzCtL/CS3NTqZNnacmOSbfS63ytsvXHBei2uf4aIrLJCPg/217Scb+5yDCKFq+ue0biLSw20KgHiKMkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcGoESCz; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgNmElkPjjqMj4WcH6Mkr2prIdXqZXGkbupx2ItPVrCqMy1oAG4+RHOAWmy6I5nx8ITHy51/6UhjNEFRix8R0/ATru22acVv1crarSOwo7uqo89PvaBFVODr4TWNq+e58TS1vyRqKddp2lJUBZ0Nwc10juaLML5MgwFyKkXqmyq25b9IpRqB4xIDvP/XWMysklFYQN/XQFd26DNpN76qMgpd3cqkt5fqyfgdxslix7bSDDMDNilAX/IhshV7xjp50+/qdgzFTxtzLlr3XgAny4Bdiop2I1ZyF6s4t2JPzd9MIOOmc1I/yhzeDKmJb2nXouDmSA3mbI9HP090v9s9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg0P1f0mgfkS3I+WugHHDNlFNNcdJDtNxGiEpAZ64WE=;
 b=uEzYCyaEHRB69e3BRqW2dh55E2CsrRQhwcMzzqqOGUX139bS/gdKTlw1acmnf86wLy2AXahcX+j6DIKE/iqdwWMAjCAIVIJsd8rzbyZRfQVBodTP4Ds9uW57gN2QPeFQWD5essksMZ/sVDqesHlAJzfZ+NuOq/GGoKtguz+O37+Y6oIblQb5IcM5Z8EnbMSlZirl24sPnh302H9P2apmHC7zt69kPyoHF4sSh1Ggh5an12X5vI6QisETEe5hXdKiFVsg0zdTCmGUqji0YE4VP5C86Wl36bPOtIy3Ki60Ty3/b/nqWymQjLj1xP3DpuXDouoFnTynGiqhHyElXvijEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg0P1f0mgfkS3I+WugHHDNlFNNcdJDtNxGiEpAZ64WE=;
 b=XcGoESCzBUE+mAlTn8LQcr344VUBtJBOTivOb1w4BHPl5/k+YscVIaQUo5klrsuOGEnKFR0dyQ2VSm/2aAELJW85iSMsCSUZ8s9ebM1v6nzz4qIbhJ8Uy/I0roFDeiTDoS7MM2CyQ0ABkTOUgQ9a2vWYvUlWDZXNl986CsCB1Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 14:25:24 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 14:25:24 +0000
Message-ID: <1dabbc51-d3be-4b10-891a-3cab5e7a58bb@amd.com>
Date: Thu, 24 Apr 2025 09:25:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/16] cxl/pci: Move existing CXL RAS initialization to
 CXL's cxl_port driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-8-terry.bowman@amd.com>
 <20250417111857.0000224c@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250417111857.0000224c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7a4485-6181-4d56-b9fd-08dd833bda50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2VZSkxaSVVnWkZaQjVkaGw0Z0UvanQ3WWc2MHl5WnBlMURyQ213bDFwTjF2?=
 =?utf-8?B?YXBFSkdPTkw2bVgvUi96ck5zUDdTTXN1LzdGVFhDRnZNaUwxTGNlMGdnSisv?=
 =?utf-8?B?Tk5wSmxxVE53M2wvQ25KR3lpT0xsc0RGTUp3cVVPSE9FSXQrUVEzRFBoU2My?=
 =?utf-8?B?Sjh6R0xFdzUwYXJ0WVhDOTVBTGhkYWhqZ3ZyaVRpWjA1N3JDS2lBWGR2Yk5a?=
 =?utf-8?B?bEhVVTBsdkRCeGN0aEw5QkJiYUZqMHFvWDQrdFpWOExYa1hLOWxvTGVRc0dw?=
 =?utf-8?B?a2t1TUlZUU5OQWsrNHhib3M3VVFnT0xPeU0vVSs5SU4vYldGWFliQ2FydFJr?=
 =?utf-8?B?WkhhUUFGd2RrTGJSajNieXRzVUxTbFZTTGFZRFdDNGtIYlRRMnNiN1JOTEZL?=
 =?utf-8?B?Y1BqN3RaR0psZC9pNm9Zc3hSbEZUYkpFd09mWVFpT2JMeTlsWWJIdFpXbFhD?=
 =?utf-8?B?Z2dzc0pBY1Q5TnJud0ZCd0lPNXgxSk5Eb1pacHFudzNsNk0yNkZISERoeElI?=
 =?utf-8?B?YzJZcVYwQVJHMkVuZmMwQlo5R0Zxbk5GaHZYVnU2ZFBCbmd6N0FRMTZaUEdU?=
 =?utf-8?B?dWlpNzBSdTk5aEJFWERXb1B0angzMldteEtMak9MaGFBU1VsN1RqRVNZOUtJ?=
 =?utf-8?B?REs1aXA3eVpoYitFNVB1Z1h3THE3NWF6MWdidVFpM1lNc1U2TEQwSzQ2TzZK?=
 =?utf-8?B?aXRnaklmSEtRTW5HaHBKNTV4VXlYczk3SUNPNERaRTJQSUUyTmNvU3hmZ1ZU?=
 =?utf-8?B?a0JnRVZoSy9hcDhkSjNkYVI5TktIL2Jhc2dPVkpDa0lyL2xGcWJ2cnlLQVZi?=
 =?utf-8?B?bktyUmRlS2FDeFk1MHoxS3FvVGFnTUZUaHRWMkxTaTFKQ1JQWEJKOCt5dzRj?=
 =?utf-8?B?REVsemt2WkpLaWhnRTlYR0pQb0phQ0R2UUd4RVhuMXVvRTlnYVBiVU93SFcv?=
 =?utf-8?B?cFJsS2xybUpRbWFPMDgxWGorT1YrN3pRRlpkYnRUdHo4Nkp6eUZNOFd0NDVn?=
 =?utf-8?B?ZC8vWmZKV3JSWUFmaVRVbDcyTGpMMURWUkZjSEdFNTl1L05ma3krWlBkY3Fx?=
 =?utf-8?B?S1M0QkJHd3dGRjdIVGsvTGFMcDZRM1FFTlV1MXh5YWs4QW5xZ0kwNGYrWFBX?=
 =?utf-8?B?ZHhEM1FHM0c5QnE1SElaZXlmREZIT05EaVZoZTdCaS9JenNRMTJLTWo2RDFm?=
 =?utf-8?B?ampaWEFHQXl5ZUQycS9hbGQ3STFxN0tlRlZlR2d6aHZpbWwrd3ByQ09Zdnlp?=
 =?utf-8?B?ZFJidVJaSHdpMjZxYzNNUlpGNnd1R2RGMHY3OGpRN0RnUVFFTXRocUZmR0w3?=
 =?utf-8?B?a29jOVBnNnlsTUpwV2d0ejlyTVQvblJzb2tYUHRpekwvejJpT0dNNWIxWElT?=
 =?utf-8?B?T3dueHZtd3ltVm5zWVdYQXdremdSbjY3dll2aW01bG9FTE5KZXFBcWp6M2NE?=
 =?utf-8?B?eW1OdG9LMitVL242aitleDI1SERmREN3UVhVa2lKdWVzRXdrT0kydlFpMHBL?=
 =?utf-8?B?aTZBOU9nUEtaMThPa2kzMFY5WTZxV3BQT3hwZU9lY2RSR1gwbzR3a1NqSDZH?=
 =?utf-8?B?eU4xeDJMK0RMTm9WQjB5MGhPd2F4OVJxc2s5UDZ5SU5CeWhxK0pZbnRVL3JZ?=
 =?utf-8?B?RWVpUjhnTE1pc1FxNHJITUIxbE1SNnNNMHk0cEdmeDRkSStPYnI0bzV2aUJZ?=
 =?utf-8?B?NlViZUo4dStPTG1BQk9WOUJjMEw2RFUramdqVFhERXpzQUpOQ0tZZkEwam54?=
 =?utf-8?B?Uzd0ckpIUW54eFh1NkgzZjNSenFJZHVmZGlLWmZ2akZMeVJLOFZFRHV6b1RE?=
 =?utf-8?B?bndhQWFlM3c0RGxURzcrdVVnQXB0dGNqSXIwNnlJblVWdE5zWHB2VU16Tkhz?=
 =?utf-8?B?ZWtVWG5GMjRiTCt5UHhUZHViY2FCam85L2g0S2VUdUdHdHE3WDNxWmxNc3Fa?=
 =?utf-8?Q?UFiKXxsX4cs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1meEl3K1lwUDFvWWZyV3g1MHgyeFlTaHdPdElHaUhsVFFuRzRlN0RTQzZa?=
 =?utf-8?B?M0xXUmhRb20yMEhzR1RhekRBWDc3ZURGcGlEU3Q1UURQL09VNkp2TUhPazhZ?=
 =?utf-8?B?cHM2b1daaU5ySkRHMHRTY1VHNW4rSmY3OWZlZmdwOFNoNlpYTm9rMklMVGs3?=
 =?utf-8?B?YWxhMTJvMUlHbnRVZ0dGTFZsaFUxL0t2czlQSXNSMGRBaEtqS2xlZkhRZENW?=
 =?utf-8?B?SVB5alBNYmFzZ2dQZlBzekNMVkNKbzZqTVVSU00wT0o4a28wYzBCbit5ZUQr?=
 =?utf-8?B?eU1jMDZEVVUwYlhmM1grUU9mbkQyZk5xVkNRVHdlcElJSGZaR2pPOWt6cnpX?=
 =?utf-8?B?QmVjcU9paDRlTGZ4TmdWeUdOMS80QXRXejNBTjh4WHYzbHJ2YzJCVysxeU0x?=
 =?utf-8?B?ek1ETUl4TkJ1SUxmRVVOSkhEL3VGZTl4Z2N6dGViQlhpemRHNURleVNHQ3VU?=
 =?utf-8?B?OE1GSklBQUZScFVER0MrV243dmNZREJsNEFXNmdwaXZteXVFSG1pbE9jUEw0?=
 =?utf-8?B?QVcxeW5GaXB2RFJ4ZHBUSXF5MHVRNkpjRUR2ZGx2SXcvdSt3K2JVY1dBWmE1?=
 =?utf-8?B?R0FRTmFQdjRkQXBiYnM4bDl3VkVxcEptcldxSDV0NFBGMUI1RGpHNTlBSjJZ?=
 =?utf-8?B?L2dNVzBNSTV5cTh4V0NpSFZqZy9EUzV0RGwycUJrWjVNNnR0RzROeFo2Ni9x?=
 =?utf-8?B?QTQreHA2VzJydFU4cXNCdkErMmxNV2liUDR4cGpXbGkyWXNGaUFPMzRLYUZZ?=
 =?utf-8?B?bGgvVi9TTkZsMWFqK0owL2xXbktHMngwcnZHaCttWWMrYkY4bDhwVlVNeW9v?=
 =?utf-8?B?V0F2SndVbTVLYVZuTXZXYjZIWDY4L0szWURmSHZEcXVLemJwRjRLeis2aFBj?=
 =?utf-8?B?UGtvNCtNN0orQmNXT3BiTGoxNXo5eTB3ZGtpZUxON1RURjZRV2FFTXl0ZWFU?=
 =?utf-8?B?UVFEelFyNVNsZHRLZXJUL1pUTWlqQWUzVklUcTJIV3dZQytvYUc1eWpqTkw4?=
 =?utf-8?B?bExlMmpIcFpYN2ptbWl1YzkxdHhQbDljRDd2OG5PcUNoVVZEaHpVd2tXQ2F1?=
 =?utf-8?B?c1JMYlg1NHZnZDMxdG1nY1ZLOENiVzhZOHJzVTF6UE9OelpWdkN3UkxVUjk3?=
 =?utf-8?B?c3gxcDlwa3F4K21MZWZXVTVLMUpxbjdxTW9aVXZuak81VTlVZGxSWDVBenBQ?=
 =?utf-8?B?N3pRNW05YXgzT05jcFRqQWtLL1hDSWY0SkRlZWJzREdNNWRpNUhib2NZU1pu?=
 =?utf-8?B?WkRReDlWT1pyRVFERzR1N1JacHY4czNmcThKQTk1OFVxc0xOaHIzaUJnZHZ2?=
 =?utf-8?B?RjF0WEpKSkFlSHJuS05EVW91SzFkTkp1RmNCUW5XTTBOS2NtdDJyKzQwSFd6?=
 =?utf-8?B?RktlOVh3RHlZOU93SUxEbExMQVF6eUZUNkE3WnRpTFc2MTNmQWI4RUxLK20y?=
 =?utf-8?B?c1VuTHB5ZGFGdmZ0R2lnTU9OZ1VZMFY2Qk04U0ZjYlpkK0xjZW1XNzdERUNB?=
 =?utf-8?B?WldUZzRCZFczanJ0d3FWQldIWEhoMUUyKzFlUWgyMWhLZGJFMDdzTjEwR29j?=
 =?utf-8?B?Z1l1L0VhUEVOdlRQNExhSmJOYkQ4VjZ4K1AvVFNtN2ZnWEs1ekJsdC91ZFk3?=
 =?utf-8?B?cW94NEJvbGZNMkNXL0hpSTRFeVRDNUVjaVBrL2Z4NmlUQjV3TzVoVGdYZWpu?=
 =?utf-8?B?UU12WFVyeEpLUDNXTWZ6NnJQalEwWU9rVWkrdG9mNUs1bW1oUWhFSG45cUlP?=
 =?utf-8?B?THh4Rk0rcFRMaEJaV210eHZtK3dQcEVYWFNNZHJPaTZZTUhCYlVOQm0rSkFS?=
 =?utf-8?B?QVVPK2grbTVoKzRpZDd2MzhNODV6V3Q0dGUzM1dFUU0yRVZXRGw0SjdLNk5k?=
 =?utf-8?B?VUJ0ejhmUW1ybVdVUy8venc3SWt3SmhwRU9rRHMzeWNVVEpCUXpQTVdxZ0wv?=
 =?utf-8?B?TXhJaWxmT2xwUitITlQ3eUpnYVI0aGNGeGlNaTljRERFbUwrSk03UkYwWDVF?=
 =?utf-8?B?OGpnS2NCQWJ3V21PVTFJOVRYODdyWWNHczgyc0N3YWxhQXpIZlYzbGpLR3o5?=
 =?utf-8?B?VGtBZkN6WnIxOWNuaXdqaVVSUEQrY0dXZ29qeWlKZ28rOWx3T0xOMjlaZDM2?=
 =?utf-8?Q?bigoZYKKZiiVyBis5q9OnMEPX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7a4485-6181-4d56-b9fd-08dd833bda50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:25:24.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDXDoNZcUbmIQeY1IaLr5ZAQKZrppih5YJak3DG3hI0qvUD6bSCaiUKVEkmQnI2EBgGxjTZTNaLipieBgpfNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716



On 4/17/2025 5:18 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:08 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
>> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
>> with CXL port management.
>>
>> Additional CXL Port RAS initialization will be added in future patches to
>> support CXL Port devices' CXL errors.
>>
>> Move existing RAS initialization to the cxl_port driver. The cxl_port
>> driver is intended to manage CXL Endpoint and CXL Switch Ports.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
>
> Sorry for the interrupt nature of reviews on this. Crazy week.
>
> Anyhow getting back to this series...
>
> I'm not a fan of ifdefs in a c file.  Maybe we should consider
> a port_aer.c and stubbing in the header as needed?
>
> I think it ends up cleaner both in this patch and even more so later
> in the series.
>
> Jonathan
>
> p.s. And now I need to run again.  I'll be back!
Hi Jonathan,

Sorry, I missed this email earlier. I understand your point. I'll keep that in
mind for new changes and revisit the series to remove those where possible.

-Terry


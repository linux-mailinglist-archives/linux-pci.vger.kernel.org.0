Return-Path: <linux-pci+bounces-22395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5DA45230
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F8C3B14CA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C018C33B;
	Wed, 26 Feb 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="tXsfftl/";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="a5WxW4ow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F918A92D;
	Wed, 26 Feb 2025 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533504; cv=fail; b=TWgzKmrofJ9iXnb5pymmoAYDWaLVW44LPW5Cb8+5513aiE9zSsPdpbMP0DCLr5hYU/+rdYukFwO2F3wtDZnD6tX4TTlQzpvO+M/wuCa1O7tS1b11AGeVP52Nxvl6c0RLYnbyQCeqI2hVzzoq/L+qo9iTIB2ucnEJr3T+viL64CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533504; c=relaxed/simple;
	bh=HDnVwrIjHPUSuSjsVOtXJcK2aUV4NEY0qEO2Xs6wNpw=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=ejxugIyGlFB1eLY7M1i2HDZtsWbznUx0I0yFRIVJrSWDusqR70taI/sXurV02tGmNvN7O4PH9r1Ge22v/y6qBR7UB9PU78bllbUY3XsZHX0BymkwqrWO5+MVQYdKu7D65ijUFId6rYmZeaYGUyBJJ/Xjvye484h8CLI3ycUXLiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=tXsfftl/; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=a5WxW4ow; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMaFnG000608;
	Tue, 25 Feb 2025 17:13:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=tXsfftl/RIv76jMPImNG5Nqjosy85HCFzn0T/vs8UoNHorPLjIQLYr9eJzGyk+MmGVOw
 6fMyR+OCMzZ4+2a+z/xPhzT0pgiJg/wQvPNsQPow5heTocjSrfnRojtBpHd7ZV6Ry549
 xKldIrJWxsQwxbNovo2k1qADnjB+u7wkIwkREM760igyA02npXVRdcOcPKlEijy4SWCK
 Nb1AcNsG1FjJU+xsb5V1aACghXc1sr7IsHBAYUGP8EQho4LC2JIxGf1tLGPEWaf5IQwx
 LjNpjMtEWA1INXorkbDB1K/4sZDd8uFu8vbpdYWFA6tr1PPm32xK+IJ0Mb6WPD5MEHwm OA== 
Received: from by5pr09cu001.outbound.protection.outlook.com (mail-westusazlp17011008.outbound.protection.outlook.com [40.93.1.8])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 451psy09n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 17:13:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCwvNQt0t1L/XbznrlXW4+x8mx54imNJsfEU4aapnHG9qPygl0Q1JIffGzUf36ExKRPfPTCIqyUXJZGft8n6fBJWBhPeZMufwz+5YRa2eFr6Qqf1lVK/fsD+cNxA6siFXVaNcVYuHYns3gl2RBMH+K/2+qucno2BXDPeiq97zeUWP/qEODeg8VzujizIdwToOxSfDZn6ug8+VyQOu9e0yLcUuvAjVNjbTQGHbg0YaRkZenxrmqoq5X4fjZHyyABCz9fyvVXNn+Fg2MXZEnyOKNCNHlVd6GtI1Y1E05XIYD29FmLrlCOfRrpO4VNSgK0Corbp5PlB6+4Q6Yomba7VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=Yj4g7YJ+vM7F/gHNR/4hU4pKW9gMyW609/A7tGWNAfc/XwXDoPTvqCAWaQsOTCsBRw/vZ2f+JZ0lBMKaYHbLwmrnmIXoNckwBaTt4Dju8BC+kICycVfKcvcBhWEIPLWvbpVEMaRBmJ4TkEzs1LU1LfqVRgEoMfoPGxqTx84OsinDDzH390ZGP4IXK0FSM1rmVqU0jGdfjW//WyMWqOyeyP05kASARVYSgCatzGAKM2XR5wG9RthMZrf+hwnkCJAmn4Sg7ETvYNK2JpJJWjxUQAO/y+cY9DK/VXz0kine966Oe9DpJGiWYT002Y8P1+cmdGDZUCAHqTbm/AWkI8xBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=a5WxW4owW9f8SldfEeaRh23onJcLIjvqtU/TS2L2GfbPA7nNK71/G7rhB+ZldOQYR/uy0iNgSBolv950tJj7ZfyzUE5+aOIyWTCiGTOoddsL492NnpKLP1vNokSgvB/jRnAwJoKA7LHA0ss1w9PJMFSNJbFSXm/3Gals3rH7+7U=
Received: from PH0PR09MB8844.namprd09.prod.outlook.com (2603:10b6:510:2f::13)
 by MW4PR09MB10168.namprd09.prod.outlook.com (2603:10b6:303:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 01:13:55 +0000
Received: from PH0PR09MB8844.namprd09.prod.outlook.com
 ([fe80::df94:6f59:a4b4:3320]) by PH0PR09MB8844.namprd09.prod.outlook.com
 ([fe80::df94:6f59:a4b4:3320%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 01:13:55 +0000
Message-ID: <2e31f750-5ff1-45e9-bf68-47530a957596@llnl.gov>
Date: Tue, 25 Feb 2025 17:13:53 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v3] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED driver
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To PH0PR09MB8844.namprd09.prod.outlook.com
 (2603:10b6:510:2f::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR09MB8844:EE_|MW4PR09MB10168:EE_
X-MS-Office365-Filtering-Correlation-Id: db83df7a-355f-4b44-be2f-08dd5602d6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmRDOUUzb01kdkFsdExUdUpVemRjRHRwMWg5SlN5RmJuREF1cnArRHZLRGtr?=
 =?utf-8?B?OHhHRmxMYzJNdU5oRkRqWDc0dWlqalM1Tm5qQjNvK1R4OXBpQjBncEd4bHRU?=
 =?utf-8?B?bHBjMWFkdWpkZWhHa01LTEVwTFFhNDlmMmUyV0ppVmk3a0I1VkR4bGdDekh4?=
 =?utf-8?B?WDlUSTFYSElyMWFSTGlQN0ZycVUxZThxQ040S3llbEhicTVEYjY4UVlrOTBp?=
 =?utf-8?B?MmZvdTRibWsrdmpjUXp4ZStUbjBXV3hjbERvUVhaNFphYmFTaFdiVSsxaFhP?=
 =?utf-8?B?WmZqMWFnNHdXcW54V3AyZDUxcm5URCtsNHhwOXIyZXZYNzJaR0pocy9aTmZ5?=
 =?utf-8?B?SGRMdjFuaXNyWkl4MlllQjBmQktVdVF4UjJtVGV5ckp6YWtTaU05czNyVGMv?=
 =?utf-8?B?TzVnQW1uZ0ZQQUN2TnhaMlZqSTBrVXZOVmNJNExSTUU5NkdoOW5SVitrTXR2?=
 =?utf-8?B?UCtickkzU2dzcWozQVJZQzlUeG1jc2R3VmR6Z3NHQ3VBaWIwNXF2SmFKREpo?=
 =?utf-8?B?N04yWDlQS1E4eEJvUVVBTGhiYTRGOGU5VDVSckdGR2w1K3o4Q0lOVUZxMkc4?=
 =?utf-8?B?L3VBbk5hYStqNk9HRTFLMU1OazVoMVFla0RXcFJkQUJJZG50Q1hVKzVTTVcx?=
 =?utf-8?B?bndCV203QmNjWDdScFJqdlJ3NjI1OENmRkY3ajgwaWtmdm1CcmM4R1dhK0Fu?=
 =?utf-8?B?MndKSGp1WHBGcjQ4MDMrdVNPaElncUdwbWVYZmJ4WTRwVXkrcDBLU0FSQXEw?=
 =?utf-8?B?YVFPSEttN2tGbXJoQTI2WDk3dHNhRkxGL2psQk02TFl6OVhGRjNQbDc0QXpJ?=
 =?utf-8?B?dmV2S2txS3VuQllQZHdIRHlpeEdYQ1lxZ0ZxdU5vU0xxaWEvdWFYaTJUZEpN?=
 =?utf-8?B?b2NrZmxKM3NUcVoyYTR6eHBnK1BlVDFhWHdyY1VDNHMyeW5CZnhkRVJIL21a?=
 =?utf-8?B?eU80WXF4MkVCL1d4cXQ1TWU3NndEcTFsZmhmRktnTE1BV0FnSlp5VVhKRENW?=
 =?utf-8?B?N2VaTlN0RUppZ3BjR1FkTk0yTVZYWXZEREliR3p0ZnB0bGF1QkN2eVNUWG5Y?=
 =?utf-8?B?bGxNbitwd3hnc3JMeUdTQ1BaZlN5TWpjaEpoekpPL3dYRVhDUkNNanB3WjBt?=
 =?utf-8?B?Y1VTRk9QSFF6Uno2TjZ6dE5RQkJsVTFldXJBTDJSeGxxcUpidTNsL2lqNkU3?=
 =?utf-8?B?eURTNHVtNHRadlBPRU5PeGFjdGtySjRUOHYveTE1d2VUcEt1MWVaUFY5UkVj?=
 =?utf-8?B?akk0ZTk2K25qeW9vdEllSzdweTFSWGJ1Vk9DaEQ0UGUyVzY5azRnZlBhNjY4?=
 =?utf-8?B?WDhCcExsYnpiNWhXTmZPUVdXZEtWR2k3Um9SbzJGQTdXQldlUHB6YUkzUmV6?=
 =?utf-8?B?aVhMM0dzd0w1LzBHUVJSSTRRZGxwa2h6SHdKaEpwUSthREc4T0Y2c1ROWmcw?=
 =?utf-8?B?dU9mdUtCZ0VvOUYvWGptc0lKRGlNNE5maGdFU0hVb01yUUNURy9OMEg4VEpm?=
 =?utf-8?B?bzBYSTMyU214aGpUODI1YlhFSVBXN2tBVUhrTjM3MWRTRUE4L1UzSkUzRkxT?=
 =?utf-8?B?NkhTNnl6bXNjVnozcE1rNGFITHVyaXdwM1FnL3VhUEdGN1Z6bXcwY1JCdzRG?=
 =?utf-8?B?ZHpGSWg1TTB0eGg2d1pZQlNuVzIyclRJbzhKa2graWFZeThoMzgzbktQOVp2?=
 =?utf-8?B?QUNBaWJ1S2VIT3d1RmErWHNPTnVQamZJZVFSdjJOT2VzLzBUQkRTTDdQTUhF?=
 =?utf-8?B?V1hxYVMycUc0MEdObU52NDcvYmdoMzNLNmVyVUlzc0VpUG1FNTJMT29qMk1o?=
 =?utf-8?B?dUVCNGtuWUREMGRUVUhlUHM0cVRqbXM3OEpKZ29UcWtWeDVmdmNPNy92b01Y?=
 =?utf-8?Q?2Y1/WzIvrpaJW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB8844.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFY0NUdtNjcvK09hbEVwa1ByckVxTWlRNkkvUERGWmdPRVRnRjZIOHNYT1R0?=
 =?utf-8?B?a2tnYUIwU1h1cXA3eG8rbjRQMXhvMGVUYXUzamdOVHZhTTl6d0dFZFJGL0Zz?=
 =?utf-8?B?V3JjT0l2bXNIOW1tZDF6Mnc5c2YvN0RBbm1nQjBpVUJFTzZ4MGMrenBqeEFE?=
 =?utf-8?B?MHBGcnVKc2kzL1FDdnBzMHZCYmMvZkthRnd3WHFGdXg3blM1YTNxbktNaHBa?=
 =?utf-8?B?RGRVVVljRXYxcFJVSTBJUDRqeGQ5WW1IVHh4ekx1TDR6VGVxRjVnQXk2d3lk?=
 =?utf-8?B?UVFEbGRYTmcvWXNkdGsrYVh1SzJ3MlNlcGpBNmt0MzJCL3dQRDgyekt5ZVVS?=
 =?utf-8?B?aDFuK3A3b25wdTVQMVIwVmpUbTRqTWlKNDUxYkdYU1JZc0laVFpKZm1uSllJ?=
 =?utf-8?B?MVVxNzFUUVZHV2NwbHFzN3BMZjYybUFHNVl3NnBjRVR4QXJ2MWVkNU5TRGJZ?=
 =?utf-8?B?WTdyS1BhTDFKaGdLWEtCSi85TnhkNjI1MHdydk1YbXpMY1liWEdGR1pWbE9U?=
 =?utf-8?B?Wnc1NkZ2azBTd2FJSHR4M1dad2tJTjJUZWRZdmhCQVlUL2lvQlhzYTlyTW16?=
 =?utf-8?B?YXA3bmNtcmJGK3NYZ21JZEp5NjZwTTVaQWJnRWtVVGpKMW45R0VHUmxhMElt?=
 =?utf-8?B?ZG5qbCt4UWVlZmE1L2YvQUdOZmlWbjBMcFRMK3FnaXRja3ZZb09SMURIdjQ4?=
 =?utf-8?B?T052clllZjc3WWEyZ3hEWlJLaURnZGg1eUtBZTR4aFpLMWJiQkJBd1N5YW8x?=
 =?utf-8?B?cTRSVlQvRTNtTWRWQm0zRWVLcVBBRjFNNGNKUVFuY1BIaXNMSHZIZmRKYU8z?=
 =?utf-8?B?bkpEejF4THUrUkZvSHBUeFdGRjlTRXRxWUZHOVlES3oyQ1FGY1FvT2xiL3c1?=
 =?utf-8?B?QjlUcUhjY2NYM2ZqY0MyNFN5ejh0SXMzclJOR21uSFlmdElLUUkraFZkZHNQ?=
 =?utf-8?B?eTFDbXFla2tPNVdYaWRsTVhiY2NiMEY2QzlwSGhCZTJJeW5sckxScjkvL3FI?=
 =?utf-8?B?RXdmcVBMTk4zNFNUWldaRTl2bHgrcll6QW9oUHA0bmxTanBEVzA0NmgxejlZ?=
 =?utf-8?B?ZHllcnJRZHYwajJrYzFTTzc1bnlsd1RQZ05rajExSHZPcW5IVkdjZ2RXRlJ3?=
 =?utf-8?B?YXVpeXdUYW5senJXdVg1ZUFNMEhkU0RWdnFRRmxtc0pranFHNXh3SHVZRE0w?=
 =?utf-8?B?Y1NwOUVpV0hSY01DQUcyWVBIOEx1Uzk0U09JeUI0eDlYWTNmU0ZQRmpyZ3ZU?=
 =?utf-8?B?QnVCZjZVd01Zdnc5RWFIazc1d3pMWk4vWlZ2cms2QkRMbkZOUTdOd3RybmVF?=
 =?utf-8?B?cXhTL3I1Y2ZQT3dDQkFLQlRJQlV5T21hd00vSklpSWhYcHRYMDNQby9vdWp0?=
 =?utf-8?B?OCtNNVFrdXpEaGs0ZFZtbEx0dVJvdEhoUDZlaXhTaXNyemQrdXArNHdTU0pM?=
 =?utf-8?B?VHR6STdRZXBoQlU5elQrSndrYjJUMVRnNk5VWEhEbGxZQURoWmVXUDlFMEpI?=
 =?utf-8?B?bXJRMmdxT2ZhdVAzeUtJZ3NobUs5VlRwMDd6TzNNY2JwME51VDRvRUNrT1Iv?=
 =?utf-8?B?dmNXTTl0aW1yblFNNVRsM1hlcXZZV1JqY3BvZlFQODd6NlgyR2JBK3I1ZjRR?=
 =?utf-8?B?WFA4RzFWcW1ZSEkra2JiNmN3YzJRS0E3WjRDOU92c293UDViWkV1M3N5Z2ZF?=
 =?utf-8?B?Y1NzMDBldFAyQlFhc2VQYVdqODQxL2FWY3VVS3RhZzRBbktDUVZMeFFib1JU?=
 =?utf-8?B?R1JGamszZUVXM3hObjZCWHFkWHdoZWZ3cHBNMmNBRHEwNTV4NFJvbVRZbDY5?=
 =?utf-8?B?K21QTWVEdVhneUtiaWVJWE1Jc2l2bXQrdzh0Rmd6L0NxRkxJS0F6Q254NTdv?=
 =?utf-8?B?Qm40akFtcTg1K2hTalhCOStJSjU4cWRIY0Q4RER5T2cxWjhKb3ZkTE1xTmQx?=
 =?utf-8?B?bnNQOWxZU3NrNHVtM3NiY1dKUUhnNUVwWjMvVmlDMngzbTk3L1RYTDhXTG5N?=
 =?utf-8?B?Q3dKcS9pY0lNLzcvVElLU09ZTGJ0Mks1MVhiRHhBOU4rU3RjK09oNkNJa1k5?=
 =?utf-8?B?ZDcwbitmcSt2V3JCTHFiTWI4RlpUazhYRzZyMStHNVpFS3UvQ2hQNW9PcWMz?=
 =?utf-8?Q?j6UlhGa+icFiQfmKHRUsEt6Y6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ghKzM4yd7wM7OpK5Vtg025OKl5rl8YxnfuvEdGRygslQbDE7R168c2EkHaU9gCzMC/E7m/GYJUrHCv0Qn6HOd5lelPG/DSeku/3vFcan0VmUMfV+nQYKf/rmmpa188mvRLPoCYpmIZYIPdFcIuNhvBFoQsKk4G+blwWPDPKWBZ32Wd32GOHyvcxjmR5kXlT2DCMYHgE36qCpOXj8DqPM4KmwcUla2H6h36vuhmM6EgYYmz4JSUUJrg3nVRNZDKc4jOwFrgGOzVNF8z/u735jzZVN48cSNDYVhJJpYDaoOaG+PulLYxdYCGzwBDFUdML8TQtAS4xi9w63oWguxyCBDxszJkpSOZrU6qTFqVrRJ7/QU1FR7Se+aqFA+XgVxiIoyq13KyiVwHIc3XBIh5tgMYj5dxpDvuYrLmZsIfPrLf+c+mwyzXNIV8o5vyRxHVAP/oUOzLVlewaJY6UfBVfUmXDNFpKfmNItaChJiuPWiQ54GSs7K85vbNAfUY+9h4Kj7Cu5FdfE4rXdUVvsPvW4SahhlQhbOepqbE6HVWWkqp/BO19dQTJPQsU6dd/dKRiuf21j4KJQI/2UhntSe2EGduFq8Z/zKLhFpRvDxqhTPIyhLai/1FJPq4eJzU/xikW+GL6KAr/k7xOC8JR4IIU7SA==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: db83df7a-355f-4b44-be2f-08dd5602d6ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB8844.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:13:55.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB10168
X-Proofpoint-GUID: HyKIfVabaRtyc-ODGHVPpfw3J1fja4zF
X-Proofpoint-ORIG-GUID: HyKIfVabaRtyc-ODGHVPpfw3J1fja4zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260007

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |   7 +
 drivers/pci/hotplug/pciehp_core.c       |  12 +
 drivers/pci/hotplug/pciehp_craye1k.c    | 659 ++++++++++++++++++++++++
 7 files changed, 717 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..1b83c43a548c 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
+
+		Using the pciehp_craye1k extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..a33920820c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6122,6 +6122,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 123c4c7c2ab5..75c77cec0b21 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver is it not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c66f4e..ea68ae041547 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -198,6 +198,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+bool is_craye1k_slot(struct controller *ctrl);
+int craye1k_init(void);
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..9a7a7b320810 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
 	}
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	if (is_craye1k_slot(ctrl)) {
+		/* slots 1-24 on Cray E1000s are controlled differently */
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
+	}
+#endif
 
 	/* register this slot with the hotplug pci core */
 	ctrl->hotplug_slot.ops = ops;
@@ -404,6 +411,11 @@ int __init pcie_hp_init(void)
 	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
 		pr_debug("Failure to register service\n");
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..844b36882316
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/dmi.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_GET_LED		0x0
+#define CRAYE1K_SET_LED		0x1
+#define CRAYE1K_SET_PRIMARY		0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define	CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+
+/* Return parent dir dentry */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (!parent)
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
+					     (int)msg->msgid,
+					     (int)craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+	mutex_init(&craye1k->lock);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err_ratelimited(dev,
+				    "Unable to register IPMI user, iface %d\n",
+				    craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn_ratelimited(dev, "Cannot create debugfs");
+
+	dev_info_ratelimited(dev,
+			     "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Returns: 0 on success, -1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return -1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return -1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k->lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k->lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+bool is_craye1k_slot(struct controller *ctrl)
+{
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+}
+
+int craye1k_init(void)
+{
+	if (!is_craye1k_board())
+		return 0;
+
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.5




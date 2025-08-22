Return-Path: <linux-pci+bounces-34618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA17B324B2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 23:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33F662288B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0922C1A5BB1;
	Fri, 22 Aug 2025 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="LnO+dpSV";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="THF3xgY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03119111A8;
	Fri, 22 Aug 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899168; cv=fail; b=lGXyRrEddkDNX65f3NBAQ3uwqkWviPjLZEyYR97JTGvDGi+7HZgzxjpA8QYk+CBhUK6QqMrpQkk2XceT53VN2V249rP2T637p3MjB1/avqpp8g0jrUoXku6lRI4OnEiloyLoW0pHOd/r8qu6w6RpDDFevonKvycr7Et/mXQr8Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899168; c=relaxed/simple;
	bh=6YA7trgpaqLJVtWOjqJp/J+4U7UuFU5lCZuQFe/atFE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=K56l2OIk21HGp0RLP7rlL/tQVv022YmxHFYoa3Q/oaROD+Eii4LHaL70/bXQTaj2qVwaNkoZqYsgCJ1ori77ApGQzoeVim3n+g2Neuh1cYHx56dv7KY22iCwyWW/EW3oxRF+YxNEyVTCKxLqqoy4qyYl7WII5h8SOnQLaww6DNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=LnO+dpSV; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=THF3xgY+; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M9erWb028199;
	Fri, 22 Aug 2025 14:36:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date : to
 : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=dTko0yUHsdlfpJNczCM2uNZknn9VBP1bLyNKMomfGps=;
 b=LnO+dpSVgWcovIihj6Hu4cTKzlT3c46Qr/FlqaacBI/4Hf0oaLbktodyZIzAGLZjtcu0
 bK41svjmfHITWGw1rNigTM+x2VtVAYv5Jizl4P6RO66Vlwu6uWSLDWDoKiLB2jVm6U1S
 2mM27rGxDZQNoOqU2+E+iZ22aw5lYIzJyjuUYqbPaD5SJqIbFRVcxyoZdq3GPc4iPn0s
 ABuT8G7HOYNO0eTl6Gmrf/M5WqIjUsUR27dPkEY/SINwvXxx0M/9c30Rn5CBG1vOAzg8
 qFHDTDgmdEdX9oJXsMYo3MlRSSScnP6UDM1aTtk/9YJds9d9KxPbEQEPbXK/A5YOy7OL 7g== 
Received: from bn8pr09cu001.outbound.protection.outlook.com (mail-eastus2azon11012063.outbound.protection.outlook.com [52.101.58.63])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 48p4xn2sjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onzBR9xAG5aiq1cITDvr9JAQCX38M79VyYr0PE5qd/gDmYZVV1XWZTQ1Gm44Gh/drPs5klk3SiRZl/fpmUMgvS4hlvhLYTZfVx5aNtrwVel5Hri2AhUX3U27dYOb1jYYBnYYYEbfv2NMrqXHB5f/5WIMQbw1R/EazmoMtsHXOBe1dg3v/FMpLntsfpg5JoM46j9uOEMxZVZm+wXrkhgjo/+z/rXVVSkPouent+9vdMvAfKUyDJNCU5ey3QCV4i61qgulwce/NizXkwYMlUx5MzHohD3hBuD/JXJbqQzx+LjdQhbyx6qU+p69A7qtuaVjyv5ve+T8Wsj0MDfxt+OEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTko0yUHsdlfpJNczCM2uNZknn9VBP1bLyNKMomfGps=;
 b=EqEJAfyooqbyl6f6Gd9N58lAeVyd2pIYW8CUlegW61gtOdJDDLN9yOy18fEU9GYcrhX0idNndrqF8j6/ZlkHjXU/r940dcbG6yf1t8buo7CrPoJ6y2eWqHF2DdCKxJW1/9U4AnHgHmgJBEsaQFV2pdq0oD0riDhfrudq2UAde6vagqV4znndeKHSTpBqwM39Sd3iJp23Frd2Mm+Ax8bbXRfONGSGI7dypnm/HdQO3MMtxRCfuF0HgkKu12uv5Q+FlbeGT7a/UXFexOYQ4nc7k52vNQGPPBsHRrZRYHSsGGwFSMVa3hvq8LWMOc90CZf1O8YCoZaxE+Jcl8f5+mhpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTko0yUHsdlfpJNczCM2uNZknn9VBP1bLyNKMomfGps=;
 b=THF3xgY+AUqxk/VoleHhVwmoJ7lHxz4eHRYgZmQc1H9Qd3TjvX3Vqv5Hc3ILT8N3/fJpjAWuL3rZoa4CsQtdnUdoElpV3fHUIXySxfb5LMgtxsOo0Az8npqY1d2VQOkfM5/ZuXA80nC7WwgKVUi24kaIy9xSAHzNkVs+3FUGthA=
Received: from SA1PR09MB11481.namprd09.prod.outlook.com (2603:10b6:806:372::6)
 by PH0PR09MB11680.namprd09.prod.outlook.com (2603:10b6:510:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 21:36:37 +0000
Received: from SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a]) by SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 21:36:37 +0000
Message-ID: <e5a6290a-7dc4-43b1-838d-bf43edae1faa@llnl.gov>
Date: Fri, 22 Aug 2025 14:36:34 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alok.a.tiwari@oracle.com, Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
        minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v4] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To SA1PR09MB11481.namprd09.prod.outlook.com
 (2603:10b6:806:372::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR09MB11481:EE_|PH0PR09MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c689dca-bb97-40d9-ef3c-08dde1c3f90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDdnT3VpZGpjM0pTeTNCZ0hFTXRMRDRTaGEvUG9TeEFWNWdKSnRKRGZyN2Mv?=
 =?utf-8?B?KzFhNUNRQ040c2UyT3BaT3ZjNWx4SHFKcDlCTTB4eGNkM096THpHNnNnVnAw?=
 =?utf-8?B?RHB1VWg3ZGpmUmxRR0piWTFOMjZoZStEaEZvRDR6eW93bVlWS1Z1NE5rU0Fa?=
 =?utf-8?B?RGtUbHdCT3h0dm5tWm9BTncyYmpPT0VyY2EwbVlZZHJwNlpMM0ZQU3oyUXQ3?=
 =?utf-8?B?akFScHZvMnNmUC9zNTl5ekJ5UURmRm9seS84Y0F0TnpLUjJHczNobTg2ak9p?=
 =?utf-8?B?ZkNHN2xNcGtwMTRFQWhHY1d5dWZwYlIwRWhEVGpGTXdSSnJPWnR0ekxGVDRt?=
 =?utf-8?B?a3Raam1YNVFhZzR1YXN2QW9lcHpNUVM4M0JVY0oxeVNMVHU5NWJFeWxqUWov?=
 =?utf-8?B?c0tzQlBsaDZNK0ZGb3lFK25UWHVMTFZ2WUJJV3cyUWVYNkhyZ1F0bU1VbExG?=
 =?utf-8?B?SVZFc3BaV0kxYWxKMWVuUll5RTVHODJYdXg0TXArQU9nNkZhbGlTUXdBM3Vl?=
 =?utf-8?B?MmJ6SENLMHhoM1ExSU9PMkU2WkNaYzdYSGtFRWJpVnByZlRIQjQrNXlUdUR6?=
 =?utf-8?B?WjRaMUZna2h5bEdWeVZuTTFZU2FpQnk5elJGdFM2ellUOU5ySlhtemlIbXNU?=
 =?utf-8?B?cTRqTllYaGlQdHhVRUREOUVLczB2dXE2SE8zL2pmVmVWK0lOOGNJZ05OVFM4?=
 =?utf-8?B?NEYvczd6c2wvUVJNdkkvQXR4UDY0VU5YUjFDVE5RQXNuUG5RMkZhS1lkb1hG?=
 =?utf-8?B?OTJra1BjdnkyTnA0VkNIS2VEcnp4NmZnRDFlOFdnU0RLN0l1aGcrRnBEVUlW?=
 =?utf-8?B?YnlYZVhaSU5NNWV6K2N4eWhhK3p1UGhXdFhOQS9IMFA5SlZjRkd4OERxTzFW?=
 =?utf-8?B?RWJ1TjQ0Z1hRd3V3QXFwTEpJT0JhekphT1NsSHFMOGYyeTFTUGJkQ2FGR2tF?=
 =?utf-8?B?T2Vrc2lIbG5PZ0szT1FnNytOWHl4WXBSRnNYOTJQWGJYQ090cXFBMUpBWmps?=
 =?utf-8?B?SngwRXV5L0xuMWdkU1hOQWwwd1VYZDdzZ3Q1bVhrbVYyVXNYeUtFOTZqS24z?=
 =?utf-8?B?UHJKcCt4UFRucmtTQUNmeDlGaGg1NHpja2JRM1FObERBZVJhMUp4MnNnZjA2?=
 =?utf-8?B?ZEJ2cUk1Y1BCNzFaSDkvV2d0enl1QlYxTFAwYlQybWNOYzdpU0k4Myt5dzRm?=
 =?utf-8?B?Q3BWZnk3ZEsxM3hnNDBFSk5NSHZjbGhyRnJuUllYanM4NWVZN2NjRVUxa0dW?=
 =?utf-8?B?OFBmVi9EODFDZ2dJWmV2UGpDMzlSb3ZNYS9LR2hwQW5QUWVnWG4vS1ZiK3Vw?=
 =?utf-8?B?ZExlTTA5SFlacXo3RHB3WnlRdlRpSDl4NnVjeXRiQXFyK3JWeE8rVkQwcGMv?=
 =?utf-8?B?YTlSakJQNkN6TWszWUNweW1xaDdSeDBBeUtnNmt2ZWJtZWF2bktDZGRIOEJW?=
 =?utf-8?B?UytGT0VuVm9lbG9tbEtlMnZEZWVsSURYMWh4OGIxUWNRNHptZGdMSnZzYXlV?=
 =?utf-8?B?SURWSDRXOGc5QjFFTXV2THBRRnZ5K2R5RWE1VCtxZUluVE05L0pZR2dIczFT?=
 =?utf-8?B?ZjljUFVRTHI1V1NEaVRXQjBGKytBQnpjL09rU2lpQzh0aElTRGVYQXdET1Nq?=
 =?utf-8?B?dm4xYStLTDRLYUJDdjJnRkh3OFpEMGlmeTZaUldHcFNjais3OThKcXBITW1Y?=
 =?utf-8?B?WTRNaWpmNDM2Z1ZWeUxhMHdtN3p1d3FiQ3NFZWgzY2ZXWm11NS9HTjg2QnBa?=
 =?utf-8?B?dnFkdDBxS3ExSWc4THBDK3NXZm9LR0wwZWtaclJnZVRUUTJhQk0yd2FpKzJv?=
 =?utf-8?B?eDlCem9ORmFrcnltNHcxRDU3QzN0ekpEN0xIQXZVVkNrRUR0c3g5YVk1d1BY?=
 =?utf-8?B?VGwzTDN6dUhjc0ZKWFNDa3E5K250eThBbm9uQmFYdzNqRlVBejAvQWhsak50?=
 =?utf-8?Q?2oOsHJR+Z8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB11481.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHpqL3NxZ1FmQkFzMXp5c2c3RktyeDUyZmQ1WnU1b0lORW1DcVhhbkVwS1Zy?=
 =?utf-8?B?dHE2NWFHay9KelpUbStlQkdOMk82UmNoRjlqZ2ZIY2VVelFFOXd2bjdiaVdq?=
 =?utf-8?B?aHkwcjRJODVOVUpkVWVkQnN1QlJJMGtreWFHZm1pTTZXNjRLZ2ZMTFZjVFh2?=
 =?utf-8?B?R0xLU0lQYWVTM25GSGduS0pDL0FmSGlobFFiVFRZSkVzOHpENHNvVk8xbGJG?=
 =?utf-8?B?cFJTR0xYZmt3Uys0NjJTYzRWNlpoM2cyS0pFemdieFZCdVBLczRzdmdZL0FZ?=
 =?utf-8?B?c05QbURQL3MwNmZOem9yVklkM1k0MnFCa0hIY1c5cWlLL1ZnR3RBbDBMcTVw?=
 =?utf-8?B?MURjSFRsR1RuZFBrQ0tpVll0SWtmQnA4cXFldVQxOW8xSTlxNzVWNWRUaS9x?=
 =?utf-8?B?c0NZVUptSGdydmh1V3A5RUNoSE1DamllQ05TUHJZSTRXMlBGa3hqWVpzdVh6?=
 =?utf-8?B?ZU1Oam9WKzRicXFUdDdhMVZJUGh0T0cra2pDSnJyVFlXT1dxblQ4dFBPcVNX?=
 =?utf-8?B?SjVBN1JiNWdjT2ZNSDI2eXd2R0hmUVZTRldYa0dranh3d1QweUc5a3AyREll?=
 =?utf-8?B?MnNXRDIzZ3U3N1JEcW5XT0JLNzdONVRKd1NRcEhtNFNRZkY5VmtKUS9qUktx?=
 =?utf-8?B?VkcrdTRjMXhHZjdZeFhvQ3RwU2k0N2JCcTdEZWtIeDVrcTRpR28ySlFmeXFw?=
 =?utf-8?B?MTFlTDBOQVFnZE1xY01lSGtzcUJXRmM0S2ZRYU4xRFdwNEdjMzVEWHJOWU5z?=
 =?utf-8?B?Sms3V0tFMG9DVXBNbHBqV0xSUitYS2MreWs3c2JPUWFMZ0NXQ3A4dW03UUE0?=
 =?utf-8?B?R2g1YXVDNFlmK2VabGZyelpoRzgwSitpLy9vSEdsY3RsUjRwcVNKaEdiQkcx?=
 =?utf-8?B?WkxKNm8zZVVBQlNMdGZNVkZaNVFSbmVpUytTUlg4SndERmtwL3E3SnRPTzlr?=
 =?utf-8?B?L09QakJVRTVEb0RRTjNTTFRicDJBYXAvd1FJY3M4MXRiUG5PMU9NcXBOUm44?=
 =?utf-8?B?V0JqajRrbjlQNkxUMkpRbVBSd3NXMTRSRmJpQ1dIMTY1L2s3dDdqamF2OU05?=
 =?utf-8?B?NmxsaU9JNzh2YnJjdFVVMUNDTUN0MWdvN3Q0bEVuTk9Jc3JGWFg0ZFRTZGNN?=
 =?utf-8?B?WkxVWnZtUVh3T2YyRlNjbHBkYitIMjlYSk11MzZLYURmRUhxek90dFJFdWcz?=
 =?utf-8?B?MUQzd21TcHh3Qkh6THlWN3ZpOGQwaTNzTzRVK2xDZVpOdU5ha2V1UGVkNXQ1?=
 =?utf-8?B?Vzk0aXdGVTZOK0o1dEczTE1nWEpIcGRjSW82cVN5TEVaMFVPWDhCMGVGYm4y?=
 =?utf-8?B?Q25tcEZMNFNWYU1teEI5TWp6VDRkVXdzODBZTzZkaG5PNktkTGdpMDQ3S1FQ?=
 =?utf-8?B?RDhxMmVzU1NlQnNsWFUvRzZ1WXB4MjdKNHdhdHF1Q2lGM0Y1N3JTY3BVNmhh?=
 =?utf-8?B?NTlRemtiUW1BZnUzQ2tibWFaTm00bi9mYkdKdDEwdWtUdm1GNll5L1JHTkh0?=
 =?utf-8?B?MStmZWJ3TFRZd3I4REhCMDBMaU5NaUplcTlEanlFb0U1a2xvS1pnSTd4eXAx?=
 =?utf-8?B?MmlTVzhubjlsRXl5eGRCUWNmYk96b0ptVGxLbVEvQ1RIbkIzNHJ4eVVLR3VH?=
 =?utf-8?B?WVEwclBvM0FrMjBKNVdkWW9rVEhXSzYzN2NIREtqeHl3bHZCZHZTL1JRZFBt?=
 =?utf-8?B?WXFudkRpZlhFcGJMZytuZnZYa0Nra0tJeVZNV2F2anFNbmgvTHlHemNoZFVs?=
 =?utf-8?B?ekVBUzlkTGRPQ1phQjQ5QXRRRS9SKzBpMm9FZ25abWUyakJkc3Q2a2lKc0xQ?=
 =?utf-8?B?MjF1d0MwRDBzQnFDOGZQQzJGR2hKQlArSzYwdUNoOUdrbDI5aVFSMlJhMDhY?=
 =?utf-8?B?MWxLQXRseGxNUWw5clQ4M0dnclYwM2dVQ2ZqZWdRekM0Q1o0OHBsMkcwN1V1?=
 =?utf-8?B?TFFvaUZ4T2RxVmRYbXZEaE5Bd1hCK1c2dmdJT2c3WlZiOGd2dXBVR25yMWpj?=
 =?utf-8?B?MkRmY1cyc1JXNHFYYmVqbnFjQjY4L2JkYitkaFVUVHdpVzIyVnVQbjArUlRC?=
 =?utf-8?B?K2EweFd4NS9Ib2Y4eEw1bkFiTXZtR0kyK3hoT1BtWTF1WEcwelJsVHVLZlhD?=
 =?utf-8?Q?5rFIWPr2Px9JcRKfbsOBmd/Z4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qB55F/NkuYmBhFQTHCvda+88m9jpEjLAnjyYQXMIc/0u9SeCxkuwZI0sgLWupzsYRN4ViggNeKXN0BTzoXA1X45MGKPWyPn1PQTDfRXuJkgYnGnntUczo8lHJoSdc6EPQkK+ZN2Ids9X8NnDmerEEgIvtieIlb+dzRjbEDr7poiFsvkrvzREu25IUx1MIYnk6kopghCSx2kZsV9EKe7qPnMIVdKmNDNuAkUnVYrZK64qAMKHMUR0WeuT45Xm6P/MFLWBjNAYDqv7yDzUbgLQ6GtJkOMswAjicf8HWX/EiY+3hzOHwC/ydhbzs/hE/gGNgyesCBNjs0t0WyaUn13EEb8AwEHUyRvBLEtorUukulO/eP6e0ZKkt/VD105RvFRakzEfVtRwELQ5YDpjWKpnD0MtU89MSbfDr8FBO4iYVUGlytj3K138EMWW1W5hU3AWygNQYT2WD4wbDWIHDUbWCQO6vscHmaxp+JhAzr/iv0E5VhxfzbMld3+PQwMjtyZN5NG1dRpkjvBIsBMwlwADL/Esecmhwi+c/V7OqNknpHWn6/Ux0TRBNyVhdkH5O6nWeaydgtythFTQnKJquR2tItG/7GUbxgvMoH4EYASW1RcIZu5Om8qNAkouq7Y0DpCRay/mmhYzw5FzsuUnHJugyw==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c689dca-bb97-40d9-ef3c-08dde1c3f90b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB11481.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 21:36:37.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB11680
X-Proofpoint-GUID: jg8cF9YL-AI457WmIff3mj-ju9TQGzko
X-Proofpoint-ORIG-GUID: jg8cF9YL-AI457WmIff3mj-ju9TQGzko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDIwMSBTYWx0ZWRfX0J5FFlj86PPh m90jR0LF2z8uZr7xweHw4NziF0P8B35NrltQRmoZAbwst4AVbA1wtc7UuO3SqaxhvsMsqmna8Sd +PVWzjQSevhEn+aXUxgOXensDsGCzzacVGKtz8IfGusQGuMjgRJhR4W15UNQNA9jibpenL7dtBI
 7qeKzCFGSl4e5t/hufqOoEw/56R/lwia9TZFWepyaMr6mSP+tNJtrzrhGYeJnJ43DD58LW2+57f viLdF78jB0WmiWqTMzXLKpwKTM1edzrykgUdn4IWe+Lud2fKhnnA0FGZllvRySD09Ap5NrDbrCR 1bMUFjdgdntnY1C3Hh7c1KMaSlLXUt36OTn2fKoGqaBqW2F0TVwZh2xBGoxdK6FDFutY8sdp3Ui LXmY5jD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220201

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v4:
 - Fix typo in Kconfig: "is it" ->  "it is"
 - Rename some #defines to CRAYE1K_SUBCMD_*
 - Use IS_ERR() check in craye1k_debugfs_init()
 - Return -EIO instead of -EINVAL when LED value check fails

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
index 69f952fffec7..9b1c008c39c2 100644
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
index fe168477caa4..6701fb9e211f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6459,6 +6459,11 @@ S:	Maintained
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
index 3207860b52e4..8994bffe04c1 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver it is not possible
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
index debc79b0adfb..f4c09a110a07 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -199,6 +199,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
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
index f59baa912970..835052384879 100644
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
@@ -378,6 +385,11 @@ int __init pcie_hp_init(void)
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
index 000000000000..72c636ceb976
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
+#define CRAYE1K_SUBCMD_GET_LED		0x0
+#define CRAYE1K_SUBCMD_SET_LED		0x1
+#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
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
+	if (IS_ERR(parent))
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
+	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
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
+	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
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
+	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
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
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
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
2.43.7


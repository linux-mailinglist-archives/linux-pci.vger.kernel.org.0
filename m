Return-Path: <linux-pci+bounces-13459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B6984A7A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043FA1F24985
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340671AB6D9;
	Tue, 24 Sep 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b5B+S3qf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92C5464A;
	Tue, 24 Sep 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200523; cv=fail; b=WAPCIUGJUYMiAd+C9JRo7OECraRiVz2c7b+fa2UzHnh/kWyb2jnktzYeoJ+VhszALdI6zUFrnAhmY8ufoxtUnzCwaMDnmy92Pfdtn0hUvO6blrKsjaxvkhzZxfmEI8/4Jj9FsPb+hHvvhAxrHD0k2o0Ad6LNSSu8vWZmsADuMXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200523; c=relaxed/simple;
	bh=oBt+FDGp5/tCZK/aKoqJjQ5dnT3K1XHSFTgiDKxvZYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRIfhqqW2uBletZiWUqxm/6sQwNc94u7/spmRk7sS62kezLQY+AZiLCeqNC2Q3vlIAEojPl5FmuEi8FRDOYNK+sYJgP7lktU5Cuips6D23hyL+1zsjkBFuPxluT5B4OuLyDPQkAeux6ObVQpMvY/zCxjtYrbgY4sA6j6aGYbjhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b5B+S3qf; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wps0NSxvMkFivv7PpjpaBIKhssoZrcg1KeR6vZUzjGxr2Pn2wm8d+iXiBbTeDxLMm3fT9ud8FkpAUNCG56omBaIkBvTq4Nv7ZyeH16CCy7278SC/k4nNBFebnfoEbTP4TyHVHL5SYQXSIrlmeEUUo3+XtEFatWd8cw559mZX3acZCoYrY/zU5L/UrF1320/XOrQmP9tp3lAXK5cXbZd8wHWvz1/g7ENTlA9Evh2mgsBmGFIyQatrgYU2VPUnY+va+ok54ZApR7jP2zTFMuQJbJXdULhisMHdOk1uqHSUiiofWryJhhw1+6eS+1g29wuk1XijGBN8Qd80GDpdEfmTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6El/BGuoDI29VsKdTdYzFYXEYq3lLybU81BiccYQvtI=;
 b=WLuVYLB/j9FSmxgTFZqukIAjGXUN+LVgxoQjkdW+IoGNV2ViqqMMXzQa7dIZWGeC9XsiWElW99RBMkOWJd0BPPQztpdmADCe4dfIt9q6gHkxQQXb3T4qqJcW04xnoBYkKYbbiPycy8IC7zv7i9s9MCIbnC78M8UZ8e4Q0eAoGGm6BDR0d+8WRHUQhYssrySCWn4sNeO43iHql3HmOp7oFjtDDZBjnolHNSIkz8p8eIkCkxrr0fk9mbeMGiXXkTCWBo/1u05K+juPH5WWO7teKVXRQbGMMENSbbeNUeBEJ6FSI8A+XPjJalL79a+ZDPasEtgIjO1gbvkDvypWnQzkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6El/BGuoDI29VsKdTdYzFYXEYq3lLybU81BiccYQvtI=;
 b=b5B+S3qfrGeJjGPw05n9sCA4SxlGsJYIEPUOz94bZ5+yJz9tjC+ohLiRs7GibBYtPQBY7xYK4oljD9UOCZgyCh8YhfLYf8iexE5CiXKpldF4FNm3liMHbIvfyjJ89zDmdoBA3lqBv9EFE3Fwx+i3KqMBx+ptHUPTyIiwPxpFMuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 17:55:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:55:17 +0000
Message-ID: <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
Date: Tue, 24 Sep 2024 12:55:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Baochen Qiang <quic_bqiang@quicinc.com>, rafael@kernel.org,
 mika.westerberg@linux.intel.com, ulf.hansson@linaro.org,
 bhelgaas@google.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 mpearson@lenovo.com, markpearson@lenovo.com, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
 <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
 <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 33201037-c905-4a7e-04cd-08dcdcc20cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZ1T1N6ZlNBVXNITUR0NjN3TkxGOE9XY2Mxc1BNb0ZXaUsvZGIxWlkrTHVC?=
 =?utf-8?B?NUJpY2xIdkk4K0pTZFJ0L1c5dyszMXcySnBYd2cweW9EWEVTZVh0eWcvN2ty?=
 =?utf-8?B?NDA1QlZMd083RllNMWozdFJ5Y2dSR2crZmpid2JPZlEvNEU2RnRQeDFxZDZt?=
 =?utf-8?B?cnAwREpoY0JPUVVOM0lVSldEeXhNemZJQ0dXTm1rY1dVeUh4R3Q5RUVnSCtC?=
 =?utf-8?B?SkZCWXN0MVBCZDI5a0RTemVKMGJNYkV3UE1rRTVxbXlVUXI3RldOdjkreGNW?=
 =?utf-8?B?c1lqeXY3aWxRamtLMjlDcGtuSW9jNUx4S3lQaERSekFDY1NFY3ppRjJaRkN4?=
 =?utf-8?B?dmRDTkhETzU1WE93R2ExSWtQR1JUTFRYbWlUc3N0cUtFSUN2cFRjNjJVS3Bo?=
 =?utf-8?B?RytBZGVtVDlqbkw0VGdRMStabEZkQ1lHaVVNMUxjcDZDeWdsSkdxb1VuazZT?=
 =?utf-8?B?U0pFaEx4WkRheEZqT1QzT3JhYTRQVjQxQ1QxWjBzckhjMlQ0QS9WVTFUSCtV?=
 =?utf-8?B?NlJVN2NzbTQyeWpJOHdBWUw3TitzVlhvczB5TFRsbXpVcVdpdGFzZnlOMklF?=
 =?utf-8?B?VjdsTnRXcnBVSEJCTlZocGorRXVucUo3VnRGU09CeXkxMW1tMTgwK1lLWXJz?=
 =?utf-8?B?OUZBNGFUVGcvWndTcTMrRjhwcTV5N0l3SU9ubHYrcHcyU1QybzlOMVd2NVph?=
 =?utf-8?B?ZkZ6eGhwSHdZZFJ1OEVMZXRWdW9UZHZyRE1HRjFkbDJKMWhkYkdJRHlydVRE?=
 =?utf-8?B?VktMRmZKNUx4cTduaGhxcDdtdjVMbmxYSXhVTWhCSHNrVXc0UnZSQkhIb0l2?=
 =?utf-8?B?ZUx3YXJDVzdCV2dueTB2dGdyOTlBZHBHYkhXVitTN2lOZVBkL3NYc3lzZnhy?=
 =?utf-8?B?cklzRUVENDV5bVZUUmhXTDhLcGltL0lvNW9QZGErN3BTYi9tRytQQkoya2xE?=
 =?utf-8?B?OHBRZmpEbGJDUTVlUVg2QkYwcng1OEl5Y01WbnpNcVlpL1UrZEM0M0luZHNx?=
 =?utf-8?B?c2Izb09hcW5Iby9LYXRpY2dpMGJSc3lxZ01TdllmZ1kwbFd4MHZkWjRFVkUv?=
 =?utf-8?B?OVdvOTdXZWhyV2RRbTlpY1hqckp0bVUzbHNlTXlQVzlSeWIzT0t1cU1ldHBp?=
 =?utf-8?B?cEx3cytoSlhqdk45d2pGS3cxekhnSE5oVmhxbXRnQ1VFdlNBM0NWWFhsWlFW?=
 =?utf-8?B?ZHJLVHdjeWxyeGU2M2VrTW41c1E2WC9KVkVzT3Vwemg3Y1o4SnR6ck04LzBK?=
 =?utf-8?B?WWhuNXJ5cXR4cjNqb1lWTS9HcW5wNU53eitjTmRGa3QzdUQ0azJsTnNvMHhI?=
 =?utf-8?B?WDkyL2ZSWU5FczVLZmIvMHJFa216SzZQa1ZYeGdkRGdWNkpSamtWa3AvQnZS?=
 =?utf-8?B?UkVWb1FlOGtERnFqTEcwSkdhS2Q4YVNXdTd5VEs3dnJYbHF5dHFpNFZ3b2VL?=
 =?utf-8?B?ZXVJenQ3RE9KeVlVSHE3aGsrejB5L2tZSFVkd09xL1pEQ3dEMnlobVozV2pE?=
 =?utf-8?B?dEEyQmxIQnN0M3Y2RDJiS0NqRDhSSTIzbXlid3dGbEhLUE0rOHVTVVV0Nys4?=
 =?utf-8?B?Zm5jSEFCdk92VDhKdFpURE1BZmdJQk5tRGFWNGhiRThxNEVoY2JqNk5nQ2pz?=
 =?utf-8?B?YXBOOUxVQm5qT0JieWlaeDhXMUZ3OVVUcG9Dc2R5am9JWG9sQytOUUdjaTJV?=
 =?utf-8?B?bkMyZUQwei9TbGwwVDRLRXIwQyt2d253elZBTC9qdGhWNlZSdk1wMEZSY24z?=
 =?utf-8?B?Uzc5akRpY0FhSE9rMnR1YThaMTFtRWc1aXg0eEd5NTVCR1Bxc1BKay95YzZh?=
 =?utf-8?Q?TBBM2UpcGUtpAks3Q6E1SKNsGMIwJL+xsxpYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elV2K1Y0YjJBK2JZbDEwNElSMjkyNmF4Q29nc1F0aHZhTUF4UlVmSTdxODJx?=
 =?utf-8?B?U054aTBOMkFzNVVadlFoNTBlanlINCsycmRnMXdHSWJxekRramowNCszUExK?=
 =?utf-8?B?SWFWSzBjRlFBenowMXo0MVZxUDZXZEtDSWd2T1VEYkJiN0FmQVVVczFkUlpZ?=
 =?utf-8?B?R1k2Y3MzNnA4MG1ETm5zbEh2Qi9pU3c3bU5SdmdTQS91ZXFZc2Q4VHJPRTI0?=
 =?utf-8?B?U0xOeDNpQmEvak53aW1nQWIzZUZ4TUt4cGI4anRsL1JkbXJvbkpDVlBNL29H?=
 =?utf-8?B?ODhKUlp4eFl4b0RzQlZIVFB5TVNQZnJPcDU5Q1BOY3pUcWVhTzhHa1FRSVpR?=
 =?utf-8?B?M3VtNkpES3dqRW05RGdQL3BQRjFmYTVtVFIvMm1nTVhDZlFOZDIvQzgvekpl?=
 =?utf-8?B?Mk95d1FVOUdNeC9vb1l2bDhlb2VBZllDTzlHQ0pUaVdoREVPU1BXUnF4MS9z?=
 =?utf-8?B?N0RPZ2JyL2NpdUt3Z0NRWk9GUFpPVmF3b0l3VTF3YUtXdGpMdUhZUVhrdHp5?=
 =?utf-8?B?UVdnSjREQm5pQmYyNGN2Nk5MNUVXVlVCLzA1V00zMEd3WERXRXV2aUVwL25K?=
 =?utf-8?B?WW00NTZEVzdoaU1JSStIQWxOa2FjaE1rem9ia0lUelJOT0hLc0NqeHNzc01H?=
 =?utf-8?B?MmFsY05zSEYvc0VPZGN2aW5QMFE5cFYwdFh0c1I4Z1FEd0tOT3NWSnpJMVll?=
 =?utf-8?B?SEJCc2lDOFdwWnhqSkZSYjhjTDhVczJoUGUxalZFSlh4LzdGYzR5NDU1ckVE?=
 =?utf-8?B?V2UvM0k0c2FRMEdyV3Q2aDdGZ2ZYdjMrSVZtMVRwUW92YmVqTGNQc0NJaDVE?=
 =?utf-8?B?RWhOVisyRTNlNHArbFpQdlEyeGVhbE8rN3NqVXhLL2I4aDJNLzJheENsZURR?=
 =?utf-8?B?MnRIaGJDR0JrUG16ODVqTjRQM3dDc0ZHQ2pFb2FjMTRhWDl3SGpCdGxQMlo0?=
 =?utf-8?B?UXV4bkk1cytYUHBFcWR3Mmd6aUwzVVNuM2lQOWFVSC9hcDB6RjNJQUtFdUhV?=
 =?utf-8?B?Ynh3anNwTkt4NFd0N3JBN2t2ZGlEMEN2cnB4TjVYNkFlQWZJS1F2MGZCbSth?=
 =?utf-8?B?bGc5T3VLYlNGRGx3NnB4VnQ2ZmdzWGd0UmxBZHptdFVNTWdRei9xS3pOQ01W?=
 =?utf-8?B?UUZUYUVuMCtCbkU5MTdrZm44TkNZLytENzhGZ0tQZGRTNEdFV25PNmxpWjFs?=
 =?utf-8?B?MnZQaDJrR2cvZnFaME1KVEN6SGM4ZkI2UGVnTjlzWktscktlWVFvalMvL2NX?=
 =?utf-8?B?Qk15TmF3VU5tb3ZmVDRJckpYNnlmTGQ4cFViNEg1dDNvcEdIQTJLUkIveERh?=
 =?utf-8?B?d05wYXdlSTlRdjQ1WlFkRldhZm1Ea21kQURxWmwySjNWUWtETkJBZEM4dkx5?=
 =?utf-8?B?T0Uyb0VQMXJVKzcySWoxU2FxYnJjMDYxeSs3ZlpyVmlWeVU0bkdnK0ZhUW16?=
 =?utf-8?B?Y1RTTmNaQktPNXd4RkprdXVXZmJwOGRjaS91bjloNDRmcTdIZlFCTmhlSi9h?=
 =?utf-8?B?cStkdXp1TC9Lc3hFRWxkazA3ZlJzcFlFcWk0bnREbENpZktHOTZpb0pwTVAv?=
 =?utf-8?B?c20xSStJSmljSyszcC9XdzJNMStKY2MvRElDTG1BZGR6SEFDUlRBM0RnSGtB?=
 =?utf-8?B?VXMzL2ZNNEJ4UTlHUjVGYWZLS1V0N1NEQ1J4T0pWT2hGdkhkc1dEby9kYlVD?=
 =?utf-8?B?WENPNDBTaU9QeGpFMTlDc2ZOblR2bWJKRUNaKy9KZzVDVW5yb3cwbVdCOFNz?=
 =?utf-8?B?THFNTDBZM24wZUtBTHZiR3g4cm40T0JXeDd5QVZDN3B3M1Y3cW5XSzlvOU9I?=
 =?utf-8?B?YjJVZmo1SFE4SS9qaEcxc3p5TFdPK3pDNEJkWXpBTCtBOEhRcTN5a242SlNi?=
 =?utf-8?B?elNuYmsyQTBjK0dSRGJJSHJhby9iNS9UVnFNMzRXdU90bzBuRGhMSkhWbTlK?=
 =?utf-8?B?SUFmN3lBekFidjZhMkdoZTVzbk9WRUQ5RlBwQVY5bDZEd3JhWFZyUVBwWmNG?=
 =?utf-8?B?aE1UZnVxb0U3RG9pRzVxUzRKRjZlNTBGaTdPS0xCM3BHN3ZmS3lkejRkNHVs?=
 =?utf-8?B?elhMSERWOHFqNGVKYllnMFZMbEhOZjNDNGp4Szhva2JhaHdvUVppQnFNN0l4?=
 =?utf-8?Q?FhOMnCvFCzjdx5L96e9ybBqgV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33201037-c905-4a7e-04cd-08dcdcc20cd0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:55:17.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7Whc3blbS8XRnGln6EarZYVJGg8s7/qctkzacONYRNmmA3z6XDqmcqOtXhfaTFpUsa5RwUpGLljao2CsXgXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

On 9/24/2024 00:52, Baochen Qiang wrote:
> 
> 
> On 9/23/2024 9:37 PM, Mario Limonciello wrote:
>> On 9/23/2024 05:07, Baochen Qiang wrote:
>>> Hi,
>>>
>>> recently it is reported that on some Lenovo machines (P16v, Z13 etc.) unexpected ACPI event wakeup is seen with kernel 6.10 [1][2]. To summary, the unexpected wakeup is triggered by simply unplug AC power or close lid of the laptop. Regression test shows this is caused by below commit, and with that reverted the issue is gone:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k?id=166a490f59ac10340ee5330e51c15188ce2a7f8f
>>>
>>> Well what confuses me is that this commit basically resets WLAN hardware before going to suspend. that said, WLAN target maintains limited functionality (PCIe link handling etc...) during system suspend and is thus not expected to wakeup system.
>>>
>>> kernel log shows this is an ACPI GPE event wakeup:
>>>
>>> Sep 22 22:34:32 fedora kernel: PM: Triggering wakeup from IRQ 9
>>> Sep 22 22:34:32 fedora kernel: ACPI: PM: ACPI non-EC GPE wakeup
>>> ...
>>> Sep 22 22:34:32 fedora kernel: PM: noirq resume of devices complete after 693.757 msecs
>>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x07
>>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x0e
>>>
>>> Consulting ACPI tables show GPE 0x07 is used by the EC and GPE 0x0e is used by GPP6 device:
>>>
>>> Scope (\_SB.PCI0.GPP6)
>>> {
>>>       ...
>>>       Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>>>       {
>>>           M460 ("PLA-ASL-\\_SB.PCI0.GPP6._PRW Return GPRW (0xE, 0x4)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
>>>           Return (Package (0x02)
>>>           {
>>>               0x0E,
>>>               0x04
>>>           })
>>>       }
>>>       ...
>>> }
>>>
>>> while GPP6 is the PCI bridge (the PCIe root port in this case) to which WLAN target is attached to:
>>>
>>> Device (GPP6)
>>> {
>>>       Name (_ADR, 0x00020002)  // _ADR: Address
>>>       ...
>>> }
>>>
>>> Scope (_SB.PCI0.GPP6)
>>> {
>>>       Device (WLAN)
>>>       {
>>>           ...
>>>       }
>>>       ...
>>> }
>>>
>>> and lspci also shows such relationship:
>>>
>>> $ lspci -vt
>>> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
>>>              ...
>>>              +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter
>>>              ....
>>>
>>> Based on above info:
>>> #1 is that valid to get the conclusion that this unexpected wakeup is triggered directly by PCIe bridge?
>>> #2 if this is related to WLAN (seems so based on the regression test), is it the WLAN wake pin (a GPIO pin?) that originally triggers this? and how does it affect the bridge?
>>> #3 quick tests show that with GPP6 wakeup disabled this issue is gone. so a workaround is to disable GPP6 wakeup before going to suspend and enable it back after resume. But is it safe to do so?
>>>
>>>
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921
>>>
>>
>> With pinctrl-amd there is an extra debugging message present [1] that is activated when you enable '/sys/power/pm_debug_messages' which will tell you if a GPIO is active during the suspend cycle.  That can help you to rule out whether this is the WoWLAN GPIO pin causing the behavior.
>>
>> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/pinctrl/pinctrl-amd.c#L626
> Thanks for the reminder, Mario.
> 
> I do notice that some reporters mentioned about this [1]. and I can also see this on my P16v machine:
> 
> [  881.799289] PM: suspend entry (s2idle)
> ...
> [  897.491440] PM: Triggering wakeup from IRQ 9
> [  897.491714] ACPI: PM: ACPI non-EC GPE wakeup
> [  897.491720] PM: resume from suspend-to-idle
> ...
> [  898.153259] PM: noirq resume of devices complete after 556.675 msecs
> [  898.153443] ACPI: GPE event 0x07
> [  898.153502] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 1st time
> ...
> [  898.314804] mhi mhi0: Requested to power ON //WLAN begin to reinitialize
> [  898.314841] mhi mhi0: Power on setup success
> [  898.694562] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  899.305898] GPIO 18 is active: 0x10157a00 //I guess this is the WoWLAN GPIO pin

Yeah that's what it looks like to me too.  The easiest way to confirm 
this (without a schematic that is) is to look at the _AEI / _EVT in the 
SSDT and see what is notified when this is active.

> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> ...
> [  899.826378] PM: suspend exit
> 
> 
> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:

I don't believe that just removing the kernel module is enough.  Can you 
physically remove the hardware?

> 
> [ 2640.849342] PM: suspend entry (s2idle)
> ...
> [ 2650.806234] PM: Triggering wakeup from IRQ 9
> ...
> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
> [ 2651.467880] ACPI: GPE event 0x07
> [ 2651.467961] ACPI: GPE event 0x0e
> ...
> [ 2651.848848] PM: suspend exit
> 
> 
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
> 

Is it possible for you to put a scope on the GPIO and/or PCIe analzyer 
on the bus?

It sounds to me that most likely what's going on is PME being asserted 
from WLAN controller.



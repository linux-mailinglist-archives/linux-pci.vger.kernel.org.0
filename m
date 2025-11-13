Return-Path: <linux-pci+bounces-41195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8BC5A5D0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 23:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5789A4F0B4A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F42E54B3;
	Thu, 13 Nov 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3A86GnGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9C2E093A;
	Thu, 13 Nov 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073579; cv=fail; b=KS8ku9YLzm9jAFfyANifQ5VQJwS7bv1InQNbvv1TOca6hJ0VXV9pbgWD7c7BmDXAw1x/EsfR2onewO8IIOc0qwVhdhn9OPWEq/Q1YyQqZ2JwuFn1DIV+Rt6wN3iDnPUacdDPG7iHkTy1Res80j4IQBkt7ibqpya37JWYE2sn/OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073579; c=relaxed/simple;
	bh=58weiXvAh5GpSPsaIY8aJ4xzrUcBeTHoc1KGAy2qzDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lp6znGcs/BAOj2gx4ra3Ai/+d0bx3F0K1ZArJVJ7o6NDy27S8vIpuk/uFVzt/oCUCNI9xvEF83SgWLPjh5bxlGA4t6uwZr/H9FpBZaJiut3sc7RGu5jOZPtEeOshtz+xGoeQr767V+kNCekXfyw/LV+1mvJS/quGqa4cjlAjzOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3A86GnGh; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOmckeoCGVFkv9Xk4SA00mU6XfGjkRHTh0qAQucGzy/qTPLn0ORs0Ockv4iux9H6lVYa2fOfhevAwt0bCW+3yvk1Dq3esSgOVU/BME0f9hsOknSfFsh83L5HxTYMnG5D5Xqv7ADt7Yzc5tT83Kxv7h58xpPW79kqphY52mDLwk1FWXxlmMBPUWNz96OPeHGVGYDYnts+ApOXPGImekPZ3yu2KWQybizvPo7dLCe1W26YAIQd61OvCMUKZFIioYsuuX4U/7IuK6TvpWpL11uP/5ikPP3zcbghqM/qjDgCu5rNSMP1gIND9oxRlePAzq0nUB48Of5GvdGpz4kOEcJL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoV1sxCAV5kMWKIjHuJx05SZSDAWpEMj3AvJ6CDZOFU=;
 b=IHHK9HruSkD4OC509rjaV/p+OxMyhLplgIKYY4WmYqFOrK/jrLu91IDsn7dXDwmR1axo8/oj2riVbNx/EIfP4AMuZgysOBbyP0e9wB+0BCnwcXgYgKvuTiRWpbgEoTYD29bl16pa3GokmPK+evn7VfTuXV7nc38q0lMyaFEMhDewNkCq/0iOoCKexEj+JDDoeQ704aPQwBMzgUidwZ8cAk81ltYnSWAbVuxK+9trYqaoFTe/NYgjePnORkyXZh+2AH+edm9OfiLBL+/5LqXz682GYWFR4Tkv+oh5gseurM1QwmAulmnseKKL/XFQtw+71MdOkOSTDju9x3JegfV6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoV1sxCAV5kMWKIjHuJx05SZSDAWpEMj3AvJ6CDZOFU=;
 b=3A86GnGhQAOTmhtRGoriFHWCTSFGj2NVLfcbg1N1I0vHyhzQVnB+AbV+BrCWkOgkCynzl5j/d0Ij4mXfAhFMp6RvnAZ43XSZRwgZ90ldiaeuZBfd41iAhE4dvSDmPV6nOySSZVF4vEI5w77ERXg62b0FP2c8bXvS2tqWEJm10Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 22:39:33 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 22:39:33 +0000
Message-ID: <07f52870-3a49-404c-af64-00fef9e5bb94@amd.com>
Date: Thu, 13 Nov 2025 16:39:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aRL08Y8g35xAzGLA@aschofie-mobl2.lan> <aRZQxoK2AjPKLkqV@aschofie-mobl2.lan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aRZQxoK2AjPKLkqV@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:806:6f::30) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd4dd10-7011-45a1-f0fe-08de23058430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENQSForUWN2R2cxVVpZMUdFOE9mOUZWSkFHRURyVFh6NlpZc0ZLVGQ4amdO?=
 =?utf-8?B?VG1iQmJmaVBianY0V2tyL1BLcjZmYWpuUWpFR09jaXhOaGJuTGZ6TG9NdGxF?=
 =?utf-8?B?eWVHSVM0a0RXY3dhQURNT2Y2RzJ4RmhOdnAyTDJDSVNPcjJWTzEyTlBHV0Ev?=
 =?utf-8?B?SmRLSmxPbERWbEZCN0p0bGRoWTJKMFdaMGxpUXpHMmRjMVJ5dlpqQUE1Y0R2?=
 =?utf-8?B?TFVKZ1dJeHd3SUdzKytWbFEwSmJjazZjbG81NndNOU9hSFpKdm83NTl6VzZT?=
 =?utf-8?B?cWI4djkzc0w0bmdiQWpaNHJzQkMwci9hL3BFU0d1dXBhenNXTy80aXpOR3gr?=
 =?utf-8?B?Sm5nQnh3TDRwNHRGWmVmOUNqMDd2RVhSYUQ0MGhTOEY2YkdtZ0xUeUlkZXll?=
 =?utf-8?B?cXhsN1dqb1BpTDRDT1R0MmxGNkM2Q2REZEdaT2JLK2UybUNTNExYakJXU3lH?=
 =?utf-8?B?aGJ4eUk0NGpYdWNtY3M2ZVpxSFRIc0hCeDN4WHIraG96T0NnSFQrV2lYTlJq?=
 =?utf-8?B?V2ZxZGwwWVZOeVJsYllmMnNNVUJScEZYTGpZNFVqeGJxcmNUaXVYcVVwSVJh?=
 =?utf-8?B?NnMzYzZUUDlCcWV1dFF4cFRlY21nMnpTaTJiNFVFMHQzU2o2ZlRxaTEyd0Z0?=
 =?utf-8?B?bUpsS2NsTW1oOVgyTFpNTktTZzVqOE41MVdJN295SFdmbFJUNTFhWkR0R2hu?=
 =?utf-8?B?RDF0OFV3MXNaUzVQaStqSDdtV1NSaUl3NFlmREowNVdIMm9vVFZmQVZzcldE?=
 =?utf-8?B?MW54WGRNZnpkNEdVMDhROUxqNTFSWWhVV1RXK2pqbFB3N2psWW1xanJ6eDJq?=
 =?utf-8?B?OGpQSGZrSlgwd0RnNGh5c1Qya1pjQ2lQQllBNERKOHV5clA4MkJRMmk0endI?=
 =?utf-8?B?SFV3UkF5ZUR5UkUzV1h5WmpzVE1HN2oyRmpBRmFLSHR0U21UblZGOFBCblZT?=
 =?utf-8?B?V2NxbGwzNDVNa1lsSjdkN3RXb29KTEQxQmVGUXZvbStjZDJDT21TRDN2QWJD?=
 =?utf-8?B?NDJCOHFQYkc4cjNIRU5Ka0F3THpaOGpYMEp1SncwaDBCMWpwNGhmRmZ6OXNM?=
 =?utf-8?B?RWJ6Z1dpRjNXNWZ5S0NPWjA0RWZseXpHd295TUk4VzVockxRRzZRd3BhVnhU?=
 =?utf-8?B?ckdXVEVzUGhUWDAyektLQzZWbURIditTNTU0clY0QlVKdVI0b0o5K3NQL2hT?=
 =?utf-8?B?MG84bWlvUU0wbXAxYjdjV05vYjVJLytad2lWS3NDUlJTWFJwa1ltMXBvZWRt?=
 =?utf-8?B?ajFuVkRWSStHRnM5Z3ZhL0RmcjNHYVFFSzBiMG5TNlBlYkxXTGNVQ2pWK0xl?=
 =?utf-8?B?SGUweFg5MG1CR1JDbmR3WThvTHJyYTZSSGtLWTEwaG1uMVNaUzVtOVdia25z?=
 =?utf-8?B?cHFwSDJmTjlXakFwM3VjVHdnWnJhRnBRRWNHd1lmQUFKb0xOeStjL1RLK0lT?=
 =?utf-8?B?bHpzU2Z0Yk5Jc2wzV0h1VkdHSXRhd0dSaXdMYkZyVVpuVTNCc29Cd2pFRkRw?=
 =?utf-8?B?bjFvdXgxWWRJMEpMUUtldWtkSHZSN3pleDYrSXUwSlgyZlo4VjZvRUdqTHdk?=
 =?utf-8?B?eFB0NlB3aUNrV0hlSmxSVVlrbEZZa1RQRzJQOVlPdWRoMjkxTERKNXJaL096?=
 =?utf-8?B?SmJHU1NwdUQ2NG1RbEV6UHhhVGY2T2JtZS9jK0I4bW45anRGSm92RWxiazBU?=
 =?utf-8?B?OXAyZW1UOGluM0tveVRLM0tPRDdhTUw2VGpoTjhhb1pKNmVsb2tOSk1kUXBX?=
 =?utf-8?B?ckhVSjB6R0g5Sm5zZndqQmVNc2dScmd6VUU1Vm9IK2d3T3p4eTR4aHJ6YXdQ?=
 =?utf-8?B?VElrbFNBZnA3NDVjeTJKZTZzTXM1YUJGUmF5c0NwbTdXdlpZY3ZZbHFaOTND?=
 =?utf-8?B?cVNsK3RNaTBleFlsUFJKSS9ZVC9Ua0RwUGRtZjVXbEd3WmRwRlNDS1Z1UWpt?=
 =?utf-8?Q?UAlRbBiS6bMxM2RAiaZCqoRyG8YmnX8F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTI3MlFYVUJxcTc4ZUxkWDBPSWVEQzVoT1d3bGMyZC9GRmw4ZWlFUk9PNXZF?=
 =?utf-8?B?OWs3QUVSTzlIQ1dVaHphdCtlRDk3TkJSWnhibVY2OE9wczRGeE1hTStNeHha?=
 =?utf-8?B?N2lrb0ZCalQ0WDZFa2VjaWFKV0p4K1NLZmhSL1NkSWtOKyt6Zzc4WmcvcFhS?=
 =?utf-8?B?dmFibXkvZTcySGJ6bmhYWGZhRDJtSlZlajlhMW5xektGN2V2TFpjb2hyZXA1?=
 =?utf-8?B?UEgrWExsMGE1NUZJeXd6Y00vZ05ZYTF3Ri8ybURUNkxGc1dQb2dXZTZXc1R2?=
 =?utf-8?B?WWRKdHhKd2FuOHVMbm43QUM0bXB0YzNpdlgrSWprSGNybEUvL3ZacDVKUENG?=
 =?utf-8?B?WlZFNVBRSnJaRE92WGpwZ29JTGdNbEF4aHRpb2JoVFB0U2pGc0NkdTVWRGt2?=
 =?utf-8?B?SGV6SytKUkpKQmp4Q3Myai9ldDF2bUMxNkY4emNKcThiY2Y2U0RYS3MxL3pD?=
 =?utf-8?B?OUxURUpObjdhZkhTbmZVam9kaE92cHdCNWxnb3BRcWR4N0FuTVBHNE81eHlV?=
 =?utf-8?B?OGtSWGZKQVk4UVJnRGJEOUpxQUNpbmdQOFZEeks4TGhvL1ErYnY5TFlhNUdm?=
 =?utf-8?B?UFZGSUFvbERyd3RneGg4bVcrNEVZbEo2Q1BBTUt1TVA1R3ljT3BMdUtsQVQv?=
 =?utf-8?B?OEVobjZrbXRENUExQ0lWNmluM1NNQ2krc2xDVFUrRVhKajlZSTVPT2x1aFRr?=
 =?utf-8?B?enU1c25SbW85S3ZTNjlxY2pxVndnQTVWekttUUVPOU9YZDgrSER4elV2Skxk?=
 =?utf-8?B?TmdKdk82WmxiSU5ndzI1ZWN5aTkwTUJQL3VzamVMaDdXQWtOUzNjMklucHVo?=
 =?utf-8?B?SHVmN0haTlVyZU5hVEhmQ0hya2F6UVlJYjdrd3ZndFc1Z3Z5eGRzcE5WcnY3?=
 =?utf-8?B?S241RitFRkEzc1UvMjZlQnRqS2V3Tk91T29rR3gzTmYybHBqb2RSR2V4aUkv?=
 =?utf-8?B?bHpjeEh5amFhNWVmM2RDSlQzK1lIZEdiNFNsdWRvd081bDJYdkhyWTJpdGJ4?=
 =?utf-8?B?WTVSY3M2VFNoS2U0MXplWFk5MDlLdGJXMGVobFpUTVBXc2pSN1hRRWdka3BB?=
 =?utf-8?B?ZFhMc3lOTVRINGtnUFlYSmtpbmJaYmlhYVNNdFRzVDJqbXpuY0lWZ2lZNy9l?=
 =?utf-8?B?NDJlYXQxem1abm81YjZJR1YwY044eFJrNmdPRU9DVUlVa2lNV2padXZrUkp2?=
 =?utf-8?B?SW1aRW9rU01helB6NFhRRnh1VldicW52d05iR1Q3MmxLcFBBSWNwMHJxcE4w?=
 =?utf-8?B?VXdoaEVoQlNQd0cvVXlKejFmTVQxcFZKcjN1SE9KNVNwODRTeVdQcFkweFg3?=
 =?utf-8?B?N1VGTUp6NnphOHhuZ3d0WWdsajc1WXpQRVV5RGlJWjNJRXI4dW92cU52M3Nw?=
 =?utf-8?B?blJEczkrV3J5NlNnM01LbzFyYzh0ZVFBdE5JTVBzZ1loUW1CZkp0eU9HUHNJ?=
 =?utf-8?B?Wm1DY2RjMkg0Yi9lY29jdmpuRVRYOEhCbjcydDhtNWdGUkVidG51ZFJKWnAv?=
 =?utf-8?B?Y0hibWNkUENYM1dlQUcrZFhnTWpLaEIwQkJSQ3oxOThmb0F6M3M4bVdSR2Jj?=
 =?utf-8?B?cHN3M00vMmlVbC9zRCs5RGhUakthUnM4RTZ0Y1kxRnMycUpZc2FxbG96MFZU?=
 =?utf-8?B?SytSQ05sMzhRV2pZSFh5WnhTeWpxK2Y0cXVTUEpoaWpEZmlvRkFKTFlKc25P?=
 =?utf-8?B?UVA3Ry9oUXkrRWorRTR0MzYrdVBvbkorSTNiaG5CbGw1YnlrZFlhWCthT0cv?=
 =?utf-8?B?Q2FkZXJ1TE9NTGp3REFtSTlSK3JGOC96ZDJTVzVoM21wOWZFRXdWQ2dMN2dL?=
 =?utf-8?B?Z1FoVlVodlNKNTZtS3NEaEFqcnlFTWs0QTY0R2hIVjZ4eWpBMlpGYnIwYkdW?=
 =?utf-8?B?bGdjQVlJVjVNOEJJK2FZUW5KYkxOVHZUalYzamxaQ1JkMlY5c1Q2YXVwOElT?=
 =?utf-8?B?V2pGaC8zcFRCbEVxcFk5ZHdJT1RYWmpFbE5Cai9iUk5UdmlqcTN3Q0o1QzNT?=
 =?utf-8?B?SVN4S1ZzZUVSTi8zOGM2Y1N3VnNENFFPQkFVNU9LTnhhOTI5bjdMVGUwNVFR?=
 =?utf-8?B?c3hVeDBIdmZtRmtUMmdHeVlvRkVuRFhyYXlzN1pTSEZtbjk4Ry8wSnBMYXJ3?=
 =?utf-8?Q?9ICr+03Q+9EOcczRO5ol2bb7o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd4dd10-7011-45a1-f0fe-08de23058430
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 22:39:33.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Rx2KAWso9+1lyxy2XppOaWJw0dFmeb+Qj2RqJxLRZBmO55KYOAI6bs8oPszmp6e7+PzTvPbUsf+EjZPKHGY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665



On 11/13/2025 3:42 PM, Alison Schofield wrote:
> On Tue, Nov 11, 2025 at 12:33:53AM -0800, Alison Schofield wrote:
>> On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
>>> CXL devices handle protocol errors via driver-specific callbacks rather
>>> than the generic pci_driver::err_handlers by default. The callbacks are
>>> implemented in the cxl_pci driver and are not part of struct pci_driver, so
>>> cxl_core must verify that a device is actually bound to the cxl_pci
>>> module's driver before invoking the callbacks (the device could be bound
>>> to another driver, e.g. VFIO).
>>>
>>> However, cxl_core can not reference symbols in the cxl_pci module because
>>> it creates a circular dependency. This prevents cxl_core from checking the
>>> EP's bound driver and calling the callbacks.
>>>
>>> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
>>> build it as part of the cxl_core module. Compile into cxl_core using
>>> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
>>> cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
>>> eliminates the circular dependency so cxl_core can safely perform
>>> bound-driver checks and invoke the CXL PCI callbacks.
>>>
>>> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
>>> parameter is bound to a CXL driver instance. This will be used in future
>>> patch when dequeuing work from the kfifo.
>> This one was troublesome in cxl-test, more circular dependencies.
>> I noticed you and GregP chatting about it, so I simply remove it from
>> the set for now (made all callsites true).
>>
>> With it gone, the set builds cxl-test and passes the test suite.
>> I'll watch what happens with this one, and can take another look at
>> the cxl-test issues if they persist.
> Hi Terry -
>
> I took another look, suspecting the circle issue started with the
> move of pci.c into the core, and not necessarily your new additions.
> There are two functions that are wrapped in cxl-test and now with
> this move are being called from the core and creating the 'circle':
>
> cxl_await_media_ready()
> cxl_rcd_component_reg_phys()
>
> Both those need the 'restrict' method, like for Patch 14.
>
> Once that is resolved, the new function cxl_pci_drv_bound()
> seems like it needs mocking and will require the same treatment.
>
> Suggest doing it in separate patches. First patch does the move
> and the cxl-test work.  Then a second patch adds the new function
> and it's cxl-test support.
>
> --Alison
>

Hi Alison,

Thanks for finding the issue. I'll start on the fix using the changes 
you described.

-Terry


>> A bit below...
>>
>> snip
>>
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
>>> similarity index 99%
>>> rename from drivers/cxl/pci.c
>>> rename to drivers/cxl/core/pci_drv.c
>>> index bd95be1f3d5c..06f2fd993cb0 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/core/pci_drv.c
>> Needs:
>> +#include "core.h"
>>
>> Compiler is warning: no previous prototypes.
>>
>> snip
>>



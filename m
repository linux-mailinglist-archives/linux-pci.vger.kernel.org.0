Return-Path: <linux-pci+bounces-29259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0BAD270F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 21:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E944D16F770
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E292A21D5B2;
	Mon,  9 Jun 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JG8uYTjh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A720D51C;
	Mon,  9 Jun 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499038; cv=fail; b=rTBD4z2z8oZ0+a/fAimdUPhaxx1eBSDpgbh4GQjMSTcIyZKIapPimx5+t+yxyMgtVLHUqCy8HspwQRbY8FHTYLNfbJhu9qM4Fa6LJfA8tpUHUvYuJbOzZtbuAXm3i8leEG5oxCja2FuFs8j2scFh0whNI6LhT9J3cT2xeJ3gMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499038; c=relaxed/simple;
	bh=bb9Wu+KcEMis3/6wsY6n5SyyWpuvvrW0gFnZShbtc6o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anwotbO/f5vwyk6tun3ds7AZfFhxMNR6fipiIUy7/5CUhvHokRjN56cMARrm2s9TJn5M1BHNarqCsrLnCY1TW5WafCqm1hS/jxaKQdb11yGvhXpV3HJLn0NCMGsQc13SeSSJ5AMSBdMdKXzpLibOj9fZiUZNQ7XUMXGkKviicR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JG8uYTjh; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffb6yVNsXGMd5DYqaEOTr2GAuABZSGa2e6W7JWMuuwGE0/ovh4ZLboH9XyAhQs4SRtu76toNQh90GmsZfxjX+afKEHUILk8FKcyr+p/C7HgHX5Ey/ZdXTaQJGyb8rXHh9pPD04ZOHYsTU1C/cubjPD2LDT6MZx6rRC5WkNc+IoiCDn6opSLu82Z6uaPMV+AUg1AFN1A68lOM20AS1janFDFINqFRV7dECwQZ+ljakVkvYS5qLveIoNZ21egG3yWwNtLidnXA0GzWaUrBvNTF1rLudfVby8GcQ29Dg/YL81YI2Z5bgl/1AEVFRluY3vQv6bid2IDafdNC2oMzQYXetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBrVfWD9Zmpyh+YK3V/Q5+yPWse44cpZY2m3h2/562U=;
 b=YOg/ndzvEv78rItoPRnzOD+e30ekfZQFV5+h5PrCrkf2xf0gzPjl3V+9J2s7Q+X2G5gZRfMY6phuIlxyT7K2JYxTIKc5VkNvSjZpWQAh/g1cDbJT4oePX5ESl3uq6sWshVupzUwfraHDyURly6U1DLkQ+McvuIuVX6JhNe/Od5IymssmpZSx4e4ZvZrZO/bS7MMFbPNgzYzlbLJhPrhviJD+WsOVpPCHBn3Ex80UAya6Cs8C1V9ynSTh/SKFrt/EP5H5nl7hAtS9C4bJcNtrQyKm9sidUxcGwo9+0olKtLm4omTWdikitb/gmbfMdxEslTH+L266mU7v+IME6m0zHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBrVfWD9Zmpyh+YK3V/Q5+yPWse44cpZY2m3h2/562U=;
 b=JG8uYTjhkTBYBB486CesM7icoXSpz3okPFSbJNpv06jYRUT00wUs/ePVNGMX0dgrqEobvNocUmlcG0ov3ObCt2ku2kN3AcRdCbEyfKpmj2NQz+xoCkguYVK+Tu4LvF58uIOyX+e3aW92LmLOV0og46w6PF75QCiBagqirTUXs1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 9 Jun
 2025 19:57:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 19:57:14 +0000
Message-ID: <d20d801a-49e5-4b78-bc1c-57f232ebd560@amd.com>
Date: Mon, 9 Jun 2025 14:57:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 rrichter@amd.com, peterz@infradead.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
 <c013da01-dc6b-470f-9dbb-e209e293763a@amd.com>
 <180a024d-9f93-4439-b25c-808a22665d2a@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <180a024d-9f93-4439-b25c-808a22665d2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:36e::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: b606bcaf-abc1-4a37-7041-08dda78fd445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTBuTXdQOU1NL3dYS3krZUhxS1hlQlhOREhwVGovenpTejliU2pqa3AyY1hQ?=
 =?utf-8?B?ZlNKbVRVU3JHZTB1d2xseklISGg3RXlUSlJ4YVp1TEc4aXFzMUxDeWkrWk40?=
 =?utf-8?B?ejZMVnJnNTgvT09ZLzB4SC9rSE1EZWU1dHJDMmcvN1BvcndpZTV0dFllNnVs?=
 =?utf-8?B?SGxwVFJxd0w1Y1FyYUtraGdmVE1xTVB5bXJ4WDJudUZZaUNpM3gvRlNFM1NN?=
 =?utf-8?B?OXoyendpQUN3bTJhMDRqZ3ROMzdUZHZ5b0dNaVA0dEh5SE0xb24zTHhNRzA2?=
 =?utf-8?B?TWhzSWpiQzZrNVJSQmp1THdBUTYyN0VpSWVsdTRPZyt0c281Mjg5V2F2VjNz?=
 =?utf-8?B?eU0rKzBZQ0tLWTY0a2NBMzJ5YmhyY2xEYkkva2hUdHoyaVA3eUsveWJYLy9J?=
 =?utf-8?B?KzViY1NhMW5VVkZza2pGa2FaeHFIZDdCUnJQNnZhSVJ5Q0lqU0YycGo5WlNw?=
 =?utf-8?B?ZjVuMk02T3VtQks0a3dBYyt2L0hWcHRqcmp6aWRCRzRhL1Faa0F2UTNzczBJ?=
 =?utf-8?B?TFZHeHM0K21LSGlaVHFuSW5ZMTZZaTJIU3F4NW5Vb1VxZWhudmJqb0tldjRV?=
 =?utf-8?B?bElHNTcxT3hiZW03b1I2ZnM5amNJcjI3N2JiaklGNTBnUUp2OXA5OEQwdmpn?=
 =?utf-8?B?aHRYSm9RV1dtdnBVMFY1RGJjYzJ0M2dWNVd6NmNpdXZmcVFjeHVIdDRMdysw?=
 =?utf-8?B?QWtZdEorckZRNC84VVZvZzZjYkpMTStBMDVxVXFyQkZMcXlGU3Y5eklka2xK?=
 =?utf-8?B?NEFlQXhoQmw3TFd6TG9EQldOdWZZQkhJa0N4eTJGdjRxb2lOaCtZL0JpaTRK?=
 =?utf-8?B?cFFYdjdGVjhNWHF0L1ZYRFRnSnhyTVF2NFc3SUxkRDkrVDRVZ0RYTWUzaGRG?=
 =?utf-8?B?MjJnNm1kSDV3eG9scGZVL3o4YjJBeHM4SGdTMDFJUmkvTitNUElQcmdGaHZp?=
 =?utf-8?B?YjlrOExlaldMVXFUZ2J4QlAzSmVTZ0xKQVErZHBkdjQxVjRSL2VRS3dGVXpO?=
 =?utf-8?B?YkFIYjBQQlM0ZExyek0rSmlyazc1RkxIWmEwT0h6MkdnOFppLy9Jdis5VG5p?=
 =?utf-8?B?MDFNQlNWd1VxSWhHR1hOUXdITUlmNFkyVUF1dTBCbVlXQTBIWVpTVW1PRE1Q?=
 =?utf-8?B?M21nY0FnYWdIcHlSdkUvRzIveWN4UjhlRGg1d1NrWnJTUk80ZmlySHR1T0tG?=
 =?utf-8?B?UVEwWWh5VklTeWNOSVBmWFR6WjBvUnI0azRQdzFVRk9TUU5LVlhkbnRtRENy?=
 =?utf-8?B?NW4xVkI0QkVrcW00SzV3VGlGUTE0SlpzU1ljMUR2bys4N2lzU044bFNSemM1?=
 =?utf-8?B?d2hCK1dwcVB1c1ZMZlFQTWo4eElaVUxmYUtmSFJVS2tIYjNuRVlhbkh6QWow?=
 =?utf-8?B?Zmt4eGlMaE1zVjBML3N6dlp3MjRZWTdHRFNaNytLbkxDKzVXdE1QSCtEY3lW?=
 =?utf-8?B?bDQzYUY4YXMrWnhHOU9aOVZsV20wWTQ5b28rRlI2YjZEbStUbFdXVGdWTys4?=
 =?utf-8?B?Q1ZDSFo4bVdFRmpkSGxrbzdrakJzQXFTelJYbklhQzhtelk2OHJYbWJ0V2N1?=
 =?utf-8?B?c2U1OHpLWFppeXVQN21WcUxsNFoyNWh6dlRZMnFnN0NUbjgvTkNxTFd6Mld0?=
 =?utf-8?B?ZlRCNlFqN0tCTHMxK0xOZmNGTVRDdWFUZnBMbC9Jc3d1YVFGVHpmeXQzUE85?=
 =?utf-8?B?NDdNL3FzZlIzOElOSXJSQkphM2RwbnRjOVp1V0JoV1JCSG4zOGRRdGZCSHdj?=
 =?utf-8?B?WHcrZEJjRi93dWdNQ2Ruc0lhOE40RFVwclNFWFRGajNqTEdMQVg3dmlVczh6?=
 =?utf-8?B?OE5Fd2kyRjU0NjNZNmp1Q2RzMExzODl4K2FMRCt6M2xXVkRlK254YjRqVVZ4?=
 =?utf-8?B?VVpDZHcxMzViSUtxSG85b0owcXBhSzFIdzhCMmZwTi9rL1FUWEIwNGE1Mjgw?=
 =?utf-8?B?clVadVM2Mkc3SWVHRmVCcUxUeUhzMk4zKzM4RnhiTUtrS1JjQ0hMaDN3dElE?=
 =?utf-8?B?cHVzZGUzYmt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmhvUm1nTDlmWVNRMFhETEIvK3RiN3pCenlzQ0xETVdIUGdtLzZzKzhsTU5q?=
 =?utf-8?B?WEZYR0JUcVJ1K3NCWHp4bWk4bzJ1NW82SWxkaUF0NDZsWjA2NjlpK1dCZmJE?=
 =?utf-8?B?RGhKNFUweDFRK3ZWdGVadldFTiswQWFIZTRzVzFFUjYrSmN5ZURZejEwVTFD?=
 =?utf-8?B?QVNEc2JCeTVUbnpRdm9GUUwyWjZrZnRpZnVkSlhab1dHV3pFeFppVnNkZm5z?=
 =?utf-8?B?REloKzJCQ0k0YVRIOTZNVUVrWDVQcHB1V2dQdDM3MmlxK0VvZ3o2dnd2U21w?=
 =?utf-8?B?UEwxSGV5bGdWMkRrdWRIVnZ4V2pFNE4yNUhyOXR1SVdBUlVFZzNkc2YvOG1W?=
 =?utf-8?B?QnNjSTduQXJveUZBOHFBS3ZPQ3JVbzdHOTdWcmg1cGFEM2E1Q0NzcGJzV20v?=
 =?utf-8?B?dUdYMGJoZHZKTkQyRXBMVlNpdWN3Y0YwSzdIcEgrNWVTQzlUL1ZIWlJpclky?=
 =?utf-8?B?WG05RXg5aEtUQU9uSkhMQzgreTFtTlJzN1psbDduTjZOZWR6Zk01MWRoc2lu?=
 =?utf-8?B?SlVEZ0lRRmlCTkMxNCtEaDNsWUxWRUxlQTJRSG5paE9mRzY3ajEyeDRjWjVI?=
 =?utf-8?B?bDJ3TGVtdkl2VlR2OEJ0SWZMT2lkYmZlTktUUjdLdEI3SytONk5QemphdEF1?=
 =?utf-8?B?Ky9vUVUrM0hpT1piNGI3eEpRdWNsN1J1aXFZWktrSkxDWnVRdTlLdWY2RS9K?=
 =?utf-8?B?Tks5L2JpL3dMamRtS1dIajh1UnoyZ1FwQnlWT2lLc1dJUkVsLzFWNHg4d1Br?=
 =?utf-8?B?VG1UdlZpdXFxWTdndkFLeHM1ZDcwTTRJc1FxdmhSRm8yZndVZjBZOHhuVzZ2?=
 =?utf-8?B?SWZ6VWpualJXSmpzYlQ0YmhrWTI1Q1owUThPZnA2NnZza0dKVXg4ME5ZdlMv?=
 =?utf-8?B?K1JpV09wV3RUYVAzbnc3cThreDB3YnZMaW5QelRiUGdQZFFobC9YdkNJU3NV?=
 =?utf-8?B?QlBITWZOL0dnak9UZVdDR2JqM0o5Y1hrVE9oUjVydW40RDZ5MTM0VUNmZ0Qx?=
 =?utf-8?B?OEovTnJMYXhBMW9ZeFNpQTllc3pzRTRTN25BTFJLTGh5VlArL0tpYkxhd3lR?=
 =?utf-8?B?TGdsSkpoK2t4RzMrNE1LUjBRWUp3N2xuamNCc1VzcTV5aXF1N1ZHWE55eU96?=
 =?utf-8?B?OTQ3b3NPekhyT2FkdHVRbHBBSHRjVWZsd1dXYjBwenFyang2Mm9nSG45KzRV?=
 =?utf-8?B?NGw0YXV4QUhHbTNRVFFOK01pcEFOblZ6OXVjV2ZaN0QydVdMZm1PeWI4YUtt?=
 =?utf-8?B?eHhlOGUxUnpGTDk0WFF2bjhWalp4UGlSN0QyWDkxR0VIbFNrSDFJSm1VWnVS?=
 =?utf-8?B?eFpmMUkzRGd5bldYZWxVZklQemtUNFlpdERFNWd3R3NmRGZSK21JRU41MDNE?=
 =?utf-8?B?Wm5FWm00bjhZamZQQk5XdGNhaXhSRTZIOVpyUEQzaEhOaUxhQkI4Y1JMVjlX?=
 =?utf-8?B?VG5vN3FiVFFQYUdOeStwMUJtVnBPODhWWGZhWjk5NmlCTDFsUnVkUFI4YXJC?=
 =?utf-8?B?UzI5WlZXc2ppTVZ3UjJhcU5Vc283aXhNTU9nRTZKVVJFTzZWT3hVNWo2TW41?=
 =?utf-8?B?cEI2QkNVdEtFQWZGSlhpa1RPYVhacWZIeE10bklrVlBrYzVFTHo5N2dKN3da?=
 =?utf-8?B?T3ZpazgwNnJEY3o2RzRZelVzWUZYb2UrcThxTTlBdUhjdlgrYVV1U280VEdi?=
 =?utf-8?B?eko4QU83TUpGcHlrNlVoMEhXZnBYT2N4MWVkaDF3bGdkLzR3dmpJTmdWbWw2?=
 =?utf-8?B?aDdZUHR4MThISVpnTWtuQVByS1RZdEw3czJsbGRGbmREWmN5bmZsWHJxMlU3?=
 =?utf-8?B?WCtuRFU2TE9wSitlZTVIZFBvSXZuRHN5TDMybTNpaVEwY2MrNTNMRXc5MnA1?=
 =?utf-8?B?SXJWOEVGb0VvQjdlZnZOdmc1a00xRGdvMXlrd0owbEE1WTBoNHZQWFl1M0Ra?=
 =?utf-8?B?MDlCaDZmT2RPR0RvQktqU09pSXc2TTRRZUFuVC9BaXBtaDZpb09NRXUzZFZE?=
 =?utf-8?B?WHY1MWhZSkc3bDY4bkN1T3BXWE5SN25EczIyZ01VVGQyWC82OGhsTDlRbnEw?=
 =?utf-8?B?SlRjSUNRSXF2TVNHbnBrS3BsUnFITWJJY2hZZ1ZOc3R2R1pmaDl3SFhES254?=
 =?utf-8?Q?ZFy2tEywi+12ctPQKYEcSSY8c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b606bcaf-abc1-4a37-7041-08dda78fd445
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:57:14.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK1ixWtce2Mrl/oaA6ktF6kTwdCtK/NNyRbvVe9ef1/TiMKU2m0uu29SpIuuTMDsdCTwGO2hcU+XvagTD9MLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343



On 6/6/2025 5:43 PM, Dave Jiang wrote:
>
> On 6/6/25 11:14 AM, Bowman, Terry wrote:
>>
>> On 6/6/2025 10:57 AM, Dave Jiang wrote:
>>> On 6/3/25 10:22 AM, Terry Bowman wrote:
>>>> The AER driver is now designed to forward CXL protocol errors to the CXL
>>>> driver. Update the CXL driver with functionality to dequeue the forwarded
>>>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>>>> error handling processing using the work received from the FIFO.
>>>>
>>>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>>>> AER service driver. This will begin the CXL protocol error processing
>>>> with a call to cxl_handle_prot_error().
>>>>
>>>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>>>> previously in the AER driver.
>>>>
>>>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>>>> and use in discovering the erring PCI device. Make scope based reference
>>>> increments/decrements for the discovered PCI device and the associated
>>>> CXL device.
>>>>
>>>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>>>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>>>> RCH errors will be processed with a call to walk the associated Root
>>>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>>>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>>>> so the CXL driver can walk the RCEC's downstream bus, searching for
>>>> the RCiEP.
>>>>
>>>> VH correctable error (CE) processing will call the CXL CE handler. VH
>>>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>>>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>>>> and pci_clean_device_status() used to clean up AER status after handling.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> ---
>>>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/pci/pci.c       |  1 +
>>>>  drivers/pci/pci.h       |  8 ----
>>>>  drivers/pci/pcie/aer.c  |  1 +
>>>>  drivers/pci/pcie/rcec.c |  1 +
>>>>  include/linux/aer.h     |  2 +
>>>>  include/linux/pci.h     | 10 +++++
>>>>  7 files changed, 107 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index d35525e79e04..9ed5c682e128 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>>>  
>>>>  #ifdef CONFIG_PCIEAER_CXL
>>>>  
>>>> +static void cxl_do_recovery(struct pci_dev *pdev)
>>>> +{
>>>> +}
>>>> +
>>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>>>> +{
>>>> +	struct cxl_prot_error_info *err_info = data;
>>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>>>> +	struct cxl_dev_state *cxlds;
>>>> +
>>>> +	/*
>>>> +	 * The capability, status, and control fields in Device 0,
>>>> +	 * Function 0 DVSEC control the CXL functionality of the
>>>> +	 * entire device (CXL 3.0, 8.1.3).
>>>> +	 */
>>>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>>>> +		return 0;
>>>> +
>>>> +	/*
>>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>>>> +	 * 3.0, 8.1.12.1).
>>>> +	 */
>>>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>>> Should use FIELD_GET() to be consistent with the rest of CXL code base
>> Ok.

Hi Dave,

I have a question. I found I need to do the same you recommended for is_cxl_mem_dev() in
drivers/pci/pcie/cxl_aer.c. Looks like I need to define:

#define PCI_CLASS_CODE_MASK         GENMASK(23, 8)

to be used as:

FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class)

What header file can I add the PCI_CLASS_CODE_MASK #define so that it can be used in CXL
and PCI drivers?

Terry


>>>> +		return 0;
>>>> +
>>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>>> I think you need to hold the pdev->dev lock while checking if the driver exists.
>> Ok.
>>>> +		return 0;
>>>> +
>>>> +	cxlds = pci_get_drvdata(pdev);
>>>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>>> Maybe a comment on why cxlmd->dev ref is needed here.
>> Good point.
>>>> +
>>>> +	if (err_info->severity == AER_CORRECTABLE)
>>>> +		cxl_cor_error_detected(pdev);
>>>> +	else
>>>> +		cxl_do_recovery(pdev);
>>>> +
>>>> +	return 1;
>>>> +}
>>>> +
>>>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>>>> +{
>>>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>>>> +				       err_info->function);
>>>> +	struct pci_dev *pdev __free(pci_dev_put) =
>>>> +		pci_get_domain_bus_and_slot(err_info->segment,
>>>> +					    err_info->bus,
>>>> +					    devfn);
>>> Looks like DanC already caught that. Maybe have this function return with a ref held. I would also add a comment for the function mention that the caller need to put the device.
>> Right. I made the change in v10 source after DanC commented. I'll add a comment that callers must decrement the reference count..
>>>> +	return pdev;
>>>> +}
>>>> +
>>>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>>>> +{
>>>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>>>> +
>>>> +	if (!pdev) {
>>>> +		pr_err("Failed to find the CXL device\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Internal errors of an RCEC indicate an AER error in an
>>>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>> +	 * device driver.
>>>> +	 */
>>>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>>>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>>>> +
>>> cxl_rch_handle_error_iter() holds the pdev device lock when handling errors. Does the code block below need locking?
>>>
>>> DJ
>> There is a guard_lock() in the EP CXL error handlers (cxl_error_detected()/cxl_cor_error_detected()). I have question about
>> the same for the non-EP handlers added later: should we add the same guard() for the CXL port handlers? That is in following patch:
>> [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error handlers.
> I would think so....
>
> DJ
>
>> Terry
>>>> +	if (err_info->severity == AER_CORRECTABLE) {
>>>> +		int aer = pdev->aer_cap;
>>>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>>>> +
>>>> +		if (aer)
>>>> +			pci_clear_and_set_config_dword(pdev,
>>>> +						       aer + PCI_ERR_COR_STATUS,
>>>> +						       0, PCI_ERR_COR_INTERNAL);
>>>> +
>>>> +		cxl_cor_error_detected(pdev);
>>>> +
>>>> +		pcie_clear_device_status(pdev);
>>>> +	} else {
>>>> +		cxl_do_recovery(pdev);
>>>> +	}
>>>> +}
>>>> +
>>>>  static void cxl_prot_err_work_fn(struct work_struct *work)
>>>>  {
>>>> +	struct cxl_prot_err_work_data wd;
>>>> +
>>>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>>>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>>>> +
>>>> +		cxl_handle_prot_error(err_info);
>>>> +	}
>>>>  }
>>>>  
>>>>  #else
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index e77d5b53c0ce..524ac32b744a 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>>>  #endif
>>>>  
>>>>  /**
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index d6296500b004..3c54a5ed803e 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>>>  void pci_rcec_init(struct pci_dev *dev);
>>>>  void pci_rcec_exit(struct pci_dev *dev);
>>>>  void pcie_link_rcec(struct pci_dev *rcec);
>>>> -void pcie_walk_rcec(struct pci_dev *rcec,
>>>> -		    int (*cb)(struct pci_dev *, void *),
>>>> -		    void *userdata);
>>>>  #else
>>>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>>>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>>> -				  int (*cb)(struct pci_dev *, void *),
>>>> -				  void *userdata) { }
>>>>  #endif
>>>>  
>>>>  #ifdef CONFIG_PCI_ATS
>>>> @@ -967,7 +961,6 @@ void pci_no_aer(void);
>>>>  void pci_aer_init(struct pci_dev *dev);
>>>>  void pci_aer_exit(struct pci_dev *dev);
>>>>  extern const struct attribute_group aer_stats_attr_group;
>>>> -void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>>  int pci_aer_clear_status(struct pci_dev *dev);
>>>>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>>>>  void pci_save_aer_state(struct pci_dev *dev);
>>>> @@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>>>  static inline void pci_no_aer(void) { }
>>>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>>>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 5350fa5be784..6e88331c6303 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>>>  	if (status)
>>>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>>>  
>>>>  /**
>>>>   * pci_aer_raw_clear_status - Clear AER error registers.
>>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>>> index d0bcd141ac9c..fb6cf6449a1d 100644
>>>> --- a/drivers/pci/pcie/rcec.c
>>>> +++ b/drivers/pci/pcie/rcec.c
>>>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>>>  
>>>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>>>  
>>>>  void pci_rcec_init(struct pci_dev *dev)
>>>>  {
>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>> index 550407240ab5..c9a18eca16f8 100644
>>>> --- a/include/linux/aer.h
>>>> +++ b/include/linux/aer.h
>>>> @@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
>>>>  
>>>>  #if defined(CONFIG_PCIEAER)
>>>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>>  int pcie_aer_is_native(struct pci_dev *dev);
>>>>  #else
>>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>  {
>>>>  	return -EINVAL;
>>>>  }
>>>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>>  #endif
>>>>  
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index bff3009f9ff0..cd53715d53f3 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
>>>>  
>>>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>>>  			  bool use_lt);
>>>> +void pcie_walk_rcec(struct pci_dev *rcec,
>>>> +		    int (*cb)(struct pci_dev *, void *),
>>>> +		    void *userdata);
>>>>  #else
>>>>  #define pcie_ports_disabled	true
>>>>  #define pcie_ports_native	false
>>>> @@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>>>  {
>>>>  	return -EOPNOTSUPP;
>>>>  }
>>>> +
>>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>>> +				  int (*cb)(struct pci_dev *, void *),
>>>> +				  void *userdata) { }
>>>> +
>>>>  #endif
>>>>  
>>>> +void pcie_clear_device_status(struct pci_dev *dev);
>>>> +
>>>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
>>



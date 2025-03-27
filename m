Return-Path: <linux-pci+bounces-24883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B9A73DCC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63771189403B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F62192F9;
	Thu, 27 Mar 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0gPeOYX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E526381C4;
	Thu, 27 Mar 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099160; cv=fail; b=nN4rSI7MKDnRrKpC/3XKSCyXl3quD4pliBPtWH2T/aFPPeREMmH0fJLoaMfY1awzEkWQmvByZ2c/pmHX0SW6AaV7H1Qkgb+Y0CYqzKuJiuX+RFbDAirZIUSz5+OCt/2E8lp0Npx/sm2Hc3ok6m/zmvqYP/wAYSWJgkNbiQi+Dsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099160; c=relaxed/simple;
	bh=RZZjFdacQoAGHtAj/iAij/aQpUA6x3S5RGvt/RmrZTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqgGmV5x8BIaCmhdrflSqtS+LaTVnZ/l7lVP5sVyXij5HmMVNtlKWQIwNwkjB093KQ9d8FNEeTVFQ2h/ZPxc9sM2JIQaymkQ3axX+Ye6vfR7SmYGRjU4rKU4wHUzSsI+KzeDDNhD1n7k2RG/LcnO/vguN7JnMYNMQWv2k9YfUR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0gPeOYX8; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRLCz+PsCJDGJHCPCdAgcnFylrW7vUfq06U+yktzE2FJ7bnx0iJcTUNStm4rojxWU2fMIhrUQTdZwi72pr/ykzbvwWTdDMTeEfjkjVc0sYFfq3Cgj326kEyQwmFgDrqkzXjp1geX8JUz+9WLn+nprt/w2hZX1Is/hdCgnEkOJ7L2sTB78HvHkWKRRU8vzES8/TuwaLsTvPt5//j6/r6ONB70cBc+kPZ2sla+wGW3Zm2eeEqVw9rn49DxMPY0q+zPkfeCc82o9U0s5JqJAOpvCV0yMusMpGx7x4BjuoKohaKJnswheAyvzEZpCT9SDCgXm/D10CXOpd8c0wnipp5MmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZIWbrypDii00oneHAyBwUDc2oIvqu595ibFogi9kYs=;
 b=YgLDTQsXMBp1yHisarglNXYjm+J8S74o2nP19Wd5S4vKk1v3EYZ+DsA5yNclf6wfGVI7/rIIysLjxJEhSPr2sj6DqmR4SFiKFe8WTILsfAHpJf9kkuoj2+FP0Pqjwk6NAWDX6LpBVVI8JKxfrMZDwrwHXZCmJYLgPgknNLilRI5f4HUd5JrGGIwdzPmXbhbvXwYak+N3v2c/OiqsXRV/qFPrYZ1xI9W1EJFldt8N4RW4+J8rc1AT/R46J/4USaHWgTm9aMUyj7IaSLQ9SP/udhucHZz0UoTO6VN+wzjbmQytNveg4Garp0z66e4/S4Z62gs+QeGmfmEwiS0RxQx+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZIWbrypDii00oneHAyBwUDc2oIvqu595ibFogi9kYs=;
 b=0gPeOYX8nqFmLcH7dgp9ftxpvAHzuZnzHkUdXfgdfy9LzzI+sQPLNNPFX8BIGLlWyhzR9HwGYtn21Y/hX706OQIhCT2t9laUIxtZroLsLCVB5uhFYefNwj/m/L45Yj2FpY3/jmTueILNZEfb2QtUm3cgM5DyeOXP8zB/Qv+W3AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 18:12:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:12:34 +0000
Message-ID: <9ae4740d-e2d9-4d49-b021-6712311842ed@amd.com>
Date: Thu, 27 Mar 2025 13:12:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327170802.GA1435872@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250327170802.GA1435872@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0022.namprd05.prod.outlook.com
 (2603:10b6:803:40::35) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 5120f533-bdb0-4995-1ac8-08dd6d5af2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3RBMVlldS9LNHh2ZVN6TTRpZ3hEWVNhWjFRS3paQ25GQ212ZXpmZ2h0ZTh5?=
 =?utf-8?B?REVjeGh3cmF4dEd4YytmS2ZaaUFKWTFicHJtK2F3QnQ4UldhNzNkQUFxaGla?=
 =?utf-8?B?dG85ejF6RFVaNlhqZFVxMVNOMmpOTndMcjhENEhMRkV0ZDUvNlExVkh0WFl6?=
 =?utf-8?B?cmZHQ2JOWUtrY1I3aXJWS3Fxbmd2Q0ZTSWRIdjc0TG1oQUg5c1RsZkVJc1hx?=
 =?utf-8?B?Q1VaT3pERFNWalVoeTRmZlNzZEJWQnpuR3ZOSHB6THZhbG9Ua1c3aEJUNnRG?=
 =?utf-8?B?Y0hyK3dORzBJMTN6NU56MTNwMU9raFFMZURQK2dkZkw5bmNYaDBKZE05V2Q3?=
 =?utf-8?B?dm5YUk1TZk03RVJ5NzZLUkttL0ZDZ0RCb0hxMERQWWVuM05yZ2cySlc5YWg4?=
 =?utf-8?B?a1FzWVFxQ2J4RFVzemY1YVVYc0RoS2FYMm9wZW1MUGFvU1hUTWZyREl0L05j?=
 =?utf-8?B?VktQbzhkeWc4MjFTQVoycDJwYVFHRDNSM01qNWh4MTJsNVVPR1dVZVlxb2sw?=
 =?utf-8?B?RWFibVdodHlOYVFudHgxdGJNTHZpRDl3V2Fkb1doSTFsTkEzQU5MeVZ5RjdQ?=
 =?utf-8?B?QjF2WmgzUkwvOVhxRUV2RnpUQVA3ZXdvSjFVWHpCNlVyZWM0YnA4UUN5N0ps?=
 =?utf-8?B?c05CU2JFejVXWSt2TWsyRXpjeWx3YnBOVXFmc2tleXk0L3AvMm9TUzY4WHgz?=
 =?utf-8?B?Z1RyeFZSWHQvUzZQenZqWUw4Yzc3eVVuN1FQVHcyMEhPMEs2SDA4NGw1bWFL?=
 =?utf-8?B?bk91VHdnZzVaTmZqRXZKTmRyWE1zYjRoWnowU1BwbnNCVGp3MzQ2bHU2Ykwz?=
 =?utf-8?B?U01URzRNWUZtcjU1SUpEZzRSSXJqRWZaNndINCt4V3V1MjNQeEJpUEFzMmd5?=
 =?utf-8?B?dWt6WCt6cG03YzlmcWMxaUVoVFVTR3Ixb3J3RkVLaTJLVVA4TGozRUVJbEZS?=
 =?utf-8?B?UEJKTmw1ZmUzOE1NcFJnTGFEbGVDbTBNUytjWjJvL05MOUxxUEt5WXRIL2hR?=
 =?utf-8?B?djNhNk1XTTRnR2hnUEZ2SzVXWmd4emZJbGVvNEpGN21xbHNUbUd2alpZWW5a?=
 =?utf-8?B?cmxma285ZGJuSmNTU0RtUWQxU0dHL3hqeExPVG1kZysxaTNiVGV6bmxxc0hU?=
 =?utf-8?B?eVY0aDBaaTVmanhhRnlSQTcxV3RPTm96bTdqRGUyVUdwUUJBaEZBdW5MYS9F?=
 =?utf-8?B?MmhEN296b0dnalR6cmc4bjJ0c2JYRXpoTkRLVkpldEhlTnI1UTE3WGRUVnd2?=
 =?utf-8?B?NlZJTTJmWEdzTXJhaFR4MHdjQjZJZGNWc0dWN25scnVrOE13eEVaVzJtKzRl?=
 =?utf-8?B?YVIzT21LZFJJcm1XL3Evd0UwMHVLTVVUNGlWOGlOR2J3UjVwZGVDa2YxTHhr?=
 =?utf-8?B?ZDhhOFpwcnZ3RGtyM3Z6cHh5Y2xKTDJOL0UxeElhQjBETXV5a3Q4Ri9iTk11?=
 =?utf-8?B?MzNtMWlyUysrckpQSkw3V2R5RjBneEFwUi92T2tjWnVja0w5dUIxRHJOa3VX?=
 =?utf-8?B?K0YvemRqUmUyU2Rxc2dxN2ZsT1BkbGo2eGRPOE5leURPeU14TDlkMFRXNys5?=
 =?utf-8?B?UUp2L0ZBbzZpaFNvb0I1ODUwaTRza0NHM3Jzcjd0Y0hyNnNwdURuaWkyVTlv?=
 =?utf-8?B?TzBkbWFFai9KMFl0a2EwandkR2NaYWdwWGdTbEZOM1RFUHJYVFN0LzhLaVpS?=
 =?utf-8?B?SGY0RnVoRDcvandBVFBuQUM0RUFCZDEwdTJKQ21xOGV4YStpbFBJS1NhQkFM?=
 =?utf-8?B?S2Z0dnBWNktHUThOWmQzQ0FENFZHanFwK3oyZjRiMUtVRWpjRXFyYktTME9o?=
 =?utf-8?B?SGoreDBvZ0xPQzVKa004a2Nwb0xJYmc3L2YxdGtMK2VwbDhXK1N1SXAwR0sv?=
 =?utf-8?Q?c5AmfKMA5X4fd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC80YWNOSlhETENmMEh5bXozT2NxWWJ3QUhqSmpYTG4rVTBRMXRmYkVaSkFJ?=
 =?utf-8?B?T2o0OUJhZWJ2NS9ZcXFocnNXdVo4Q3dBOFFZUktjZjBoOGcvNmV2WjllQ0F5?=
 =?utf-8?B?RjI4d0ZJTEpXME1iVklpTDR2Tis3V0hZUm1sZzdkTDRmZVVCcS9Jc3V1a1lO?=
 =?utf-8?B?NjNuR2I5ZDZNQ29mTEl2N0NLMitKUnhLTmY1ZTJxMU1vRlRpOU5wL3psOEVi?=
 =?utf-8?B?K0hyUFRjV1RmM0RHT214Z3B0ZG1aMjFKcVpwZ0crOVJhMkhJUWdJa2RFd1d5?=
 =?utf-8?B?eTRDVTExRThBZHhtQkhiR3VUZFlaL29iZmJ6dUFtbEo2cHljQ1pDNnBkbVhu?=
 =?utf-8?B?TE9wdWlpNGJ3S3VVLzZBeVRyejNoOE5PSHRnbkxnQlhoQXczTFN4V285dVF0?=
 =?utf-8?B?L3Evd0ZWSURkYVgzUVlFQlo1VHI1N05zbGRrc0VwdUkrWW9taW9qbUxvRjJ4?=
 =?utf-8?B?b0FabTVpdWF4bDRvaitSeU5zMkN5bXlzUHZCUSt5QXpVZkRIaFZBU0QyY012?=
 =?utf-8?B?OXRLU1orWjNYVzlUcnBnaHJCK2s4YU1LTHVhdXBwcWs3TEg3SG54RWxudEpt?=
 =?utf-8?B?NU1jQ0dEemI2c2xQbUhXMWhIL0dPVTZncjBwTXY5TUZ4cGRJZmNMdlNiOVov?=
 =?utf-8?B?RHRpUDNjNEFtNnNXR2JuNGxkZDVpRjRwdFNsMEw2Nk9tK1VORWlyNUp6SkxQ?=
 =?utf-8?B?ajlQU1NWTlEzWjJVZW1ldFg3Y1V3Vmt6TTVaaHgwMzVOUlRDbFVTeFdXc1dC?=
 =?utf-8?B?V1dISUF2b2dBV1NQWm01a0JJdTVwTlVzZ2twSHlFcHNybURYRDlDeFFLRG1t?=
 =?utf-8?B?amhTNDJsK3J4UlRROWJpcjdvRUZtVkNuVTM2ZU1RZ256REFkd2dxZDkvTGlC?=
 =?utf-8?B?TVRxaDRmWUJnSFB2dTEvb3RoTFYremN6UjlHQkFjaEowVDlQMDFNaWdsdVIv?=
 =?utf-8?B?R1N3U2hkQkZWN3VPOTB0VDYweUdYaEhxbEN1STVVOXdZMC9Zc25jaGhpT3Nu?=
 =?utf-8?B?Y2tVN3ExcFVIWlhLQ01zS3RkNERRT09ZalFsaHRKTW8yekhUR0JpbU8rcldS?=
 =?utf-8?B?TDJmRHYvb0VhTFZXVlJIRGVIRkdYZEdyYUVkbXJMZTNSS0ZUQmJMU1dHY2JJ?=
 =?utf-8?B?d0ZkUEdSWWJHMUxhK3V2eDl0RjRQNnNIODJhbFFEd1ByOU53TnRsWlZHdmRk?=
 =?utf-8?B?T1FhbkY4NEZqU0dmWmJYRkdQeHpzQUxwcGpnRS9paC9nV0VkMm16WkUzandy?=
 =?utf-8?B?S2lBOXVaN0JxMVdCUlRLTDl2K2QvUS9pQ2xRcHBZWWNMYmhodE5uWFBTaXhS?=
 =?utf-8?B?Z0s5eWhlTzNlTDVwU2xYMHlnMk9nMUxlT1BEYU9PYktqbGJLUjF4ZzRVdldS?=
 =?utf-8?B?Y3M5Y0VXVUE2REdENmo0dmhvcC8zbEZzR0htTnR3TVpodGI0TFR3UEpLOG1Y?=
 =?utf-8?B?dE5PZE91cElOQ2haeXVhTFZVR1dHTGlYdm8wSFlteVdvS2xmTVY2SndXMSsr?=
 =?utf-8?B?eFE0VFZneGJZSVA3bGtIckltSEY4Nm5nbzFaZ3kwSVBzWTd0RWdobm44akpj?=
 =?utf-8?B?elhFdU9LY0lVejI5YkVDeHA3aUlsVnV3ZFUxMncxd2JEUFhLa2tZaXhhVkd4?=
 =?utf-8?B?cWFzS3pYNE9vOG9uODFwb1NRcXl2NlZxYzhxaGpwV0pDc01PTkE3a0RTR1FV?=
 =?utf-8?B?Q2RnNEtBeDFJTHZTZ3MxMmEzNDg3b3FrK0FLK21nNmNhMnJ3MTJaNUc0Mkk0?=
 =?utf-8?B?QjUva1RRYVVLMEc0OHJyQmcwVHRDOG5XaTlBN3psRVA4SUU3d0pldkpRcjZS?=
 =?utf-8?B?YWQrWEdqWEY3WGlhU09OQXV0THRwbzE0RDc0RTh4dHc4RG9CMnYvWEhuRk1H?=
 =?utf-8?B?TVJJKzJlOU1HTlpTdnI3cVVJOE9CKzNLeWQ4QXlDOHluanl6VnhLSUlicUZC?=
 =?utf-8?B?b2hSUWZCbzFTa3JtVTdBY0IwcFVhZGR6bUdDRjdyU0NHVlpDTElXWWRZOWll?=
 =?utf-8?B?STNsTHVuQjlCTjI1V1NRR2NsOHNOOXNZMDFGTWI2czQ1cWxFSVhMUmN0Q3hp?=
 =?utf-8?B?UVB5S2dFZGw3b2JrVkVIS2RwbHF2V3FKUlFJeTNqbDhMN2gxSVU1aFUyRE43?=
 =?utf-8?Q?qWxBIAQ1CFQJ7hiXpxbGf52eO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5120f533-bdb0-4995-1ac8-08dd6d5af2ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:12:34.8028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebbjafb+MRdzw5Fs4xvyrPDnpaTqYrdR6xMlUvFU9Z7d2kN2yLA5yzmZBpfkBqwzxFKdNM+0f41NXjhhCWGFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650



On 3/27/2025 12:08 PM, Bjorn Helgaas wrote:
> On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt details with CXL driver. The notification is required for
>> the CXL drivers to then handle CXL RAS errors.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work. The cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement the registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
>> now. The CXL specific handling will be added in future patch.
>>
>> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
>> details used in completing error handling. This avoid duplicating some
>> function calls and allows the error to be treated generically when
>> possible.
>> ...
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/aer.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>> +#include <cxlpci.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> @@ -107,13 +108,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>> +			     struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	if (!pdev || !err_info) {
>> +		pr_warn_once("Error: parameter is NULL");
>> +		return -ENODEV;
> This is CXL code, so your call, but I'm always skeptical about testing
> for NULL and basically ignoring a code defect that got us here with a
> NULL pointer.  I would rather take the NULL pointer dereference fault
> and force a fix in the caller.
I sometimes struggle with too much parameter validation, especially in
new code. And there are often valid questions of "how can this happen
and does it need to be checked". Some of it borders on paranoid (pointing
back to initial development). Thanks for the feedback here, I will keep
this in mind.

>> +	}
>> +
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
>> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +		return -ENODEV;
> Similar.  A pci_warn_once() here seems like a debugging aid during
> development, not necessarily a production kind of thing.
>
> Thanks for printing the type.  I would use "%#x" to make it clear that
> it's hex.  There are about 1900 %X uses compared with 33K
> %x uses, but maybe you have a reason to capitalize it?
Got it "%x". Would you recommend the pci_warn_once() is removed?
>
>> +	}
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	*err_info = (struct cxl_prot_error_info){ 0 };
> Neat, I hadn't seen this idiom.
>
>> +	err_info->ras_base = cxlds->regs.ras;
>> +	err_info->severity = severity;
>> +	err_info->pdev = pdev;
>> +	err_info->dev = dev;
>> +
>> +	return 0;
>> +}
>> +
>> +struct work_struct cxl_prot_err_work;
>> +
>>  int cxl_ras_init(void)
>>  {
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	int rc;
>> +
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc) {
>> +		pr_err("Failed to register CPER kfifo with AER driver");
>> +		return rc;
>> +	}
>> +
>> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work, cxl_create_prot_err_info);
>> +	if (rc) {
>> +		pr_err("Failed to register kfifo with AER driver");
>> +		return rc;
>> +	}
>> +
>> +	return rc;
>>  }
>>  
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_prot_err_work();
>> +	cancel_work_sync(&cxl_prot_err_work);
>>  }
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..92d72c0423ab 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> @@ -135,4 +136,6 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>> +			     struct cxl_prot_error_info *err_info);
> What does the "_" in "_pdev" signify?  Looks unnecessarily different
> than the decls above.
_pdev shadows pdev. In previous patchset review Dan asked to add reference count
incr because much of this logic is during error handling and devices can go away.
Long story to say I was using the following throughout where needed:


int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
                             struct cxl_prot_error_info *err_info)
{
        struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);

>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 83f2069f111e..46123b70f496 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -110,6 +110,16 @@ struct aer_stats {
>>  static int pcie_aer_disable;
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
>> +struct work_struct *cxl_prot_err_work;
>> +static int (*cxl_create_prot_err_info)(struct pci_dev*, int severity,
>> +				       struct cxl_prot_error_info*);
> Space before "*" in the parameters.
I'm surprised checkpatch() didn't catch this. Maybe it's cause the parameter
itself is not present. Thanks!
>> +#endif
>> +
>>  void pci_no_aer(void)
>>  {
>>  	pcie_aer_disable = 1;
>> @@ -1577,6 +1587,35 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>>  
>> +
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work,
>> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
>> +								struct cxl_prot_error_info*))
> Ditto.  Rewrap to fit in 80 columns, unindent this function pointer
> decl to make it fit.  Same below in aer.h.
Ok, got it. Without using typedefs, right ?
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = work;
>> +	cxl_create_prot_err_info = _cxl_create_prot_err_info;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
>> +
>> +int cxl_unregister_prot_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = NULL;
>> +	cxl_create_prot_err_info = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
>> +
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_prot_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
>> +#endif
>> +
>>  static struct pcie_port_service_driver aerdriver = {
>>  	.name		= "aer",
>>  	.port_type	= PCIE_ANY_PORT,
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 947b63091902..761d6f5cd792 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -45,6 +46,24 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_prot_err_info - Error information used in CXL error handling
>> + * @pdev: PCI device with CXL error
>> + * @dev: CXL device with error. From CXL topology using ACPI/platform discovery
>> + * @ras_base: Mapped address of CXL RAS registers
>> + * @severity: CXL AER/RAS severity: AER_CORRECTABLE, AER_FATAL, AER_NONFATAL
>> + */
>> +struct cxl_prot_error_info {
>> +	struct pci_dev *pdev;
>> +	struct device *dev;
>> +	void __iomem *ras_base;
>> +	int severity;
> What does the "prot" in "cxl_prot_error_info" refer to?
Protocol. As in CXL Protocol Error Information. I suppose it needs to be renamed
if it wasn't obvious.
>
> There's basically no error info here other than "severity".
Correct. It's more accurately "CXL Protocol Error Context" but I didn't
want to re-use 'context' because 'context' is used for thread/process
statefulness. Also, I followed the existing CPER parallel work that uses
a similar kfifo etc. Thoughts on rename?

> I guess "dev" and "pdev" are separate devices (otherwise you would
> just use "&pdev->dev"), but I don't have any intuition about how they
> might be related, which is a little disconcerting.
"pdev" represents a PCIe device: RP, USP, DSP, or EP.  "dev" is the same
device as "pdev" but "dev" is found in CXL topology. "dev" is discovered through
ACPI/platform enumeration and interconnected with other CXL "devs" using upstream
and downstream links. Moving back and forth between "pdev" and its CXL "dev"
requires a search unique to the device type and point beginning the search.

BTW, CXL "dev" devices discussed here are the underlying devices for 'struct cxl_port',
'struct cxl_dports', and CXL upstream ports.

The 'struct cxl_prot_error_info' could possibly be removed where only a 'pdev' or 'dev' and AER severity are cached. When I started implementing the redesign I found cacheing this information made it simpler to implement. This could be revisited to improve. But there are 2 caveats to consider: 1. Removing the cached data will require invoking more SW calls for "pdev"->"dev" conversions, converting "dev" to CXL port, etc. 2. Will require saving the AER severity somewhere at a minimum.
> I would have thought that "ras_base" would be a property of "dev" (the
> CXL device) and wouldn't need to be separate.
"ras_base" is a common member of the CXL Port, CXL Downstream Port, CXL Upstream Port,
and CXL EP. If one wants the "ras_base" for a given CXL "dev" then the "dev" must be
converted to CXL Port, Downstream Port, or Upstream Port.
> From above, I guess "ras_base" is a property of cxlds, not
> cxlds->cxlmd->dev.  Maybe we should be keeping &cxlds here instead and
> letting the consumer look up cxlds->cxlmd->dev?
Yes, at this "point" in the patchset. It is updated later when support is added
for CXL Port devices.

Terry
>> +};
>> +
>> +struct cxl_prot_err_work_data {
>> +	struct cxl_prot_error_info err_info;
>> +};
>> +
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -56,6 +75,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work,
>> +			       int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
>> +								 struct cxl_prot_error_info*));
>> +int cxl_unregister_prot_err_work(void);
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
>> +#else
>> +static inline int
>> +cxl_register_prot_err_work(struct work_struct *work,
>> +			   int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
>> +							     struct cxl_prot_error_info*))
>> +{
>> +	return 0;
>> +}
>> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
>> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);
>> -- 
>> 2.34.1
>>



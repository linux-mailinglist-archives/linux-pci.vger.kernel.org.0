Return-Path: <linux-pci+bounces-36155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F1B57D69
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1223B179CEE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624428980A;
	Mon, 15 Sep 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5ms1JPf"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134C2D0283;
	Mon, 15 Sep 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943176; cv=fail; b=Y2Ef8gGyLggBJ4F/Urzcn0xCspVlfr+MRnjynRv0yc5cPEuVhpGVvpy1PJJ+RPG96edtinvdSTdxKZHpwnnJHE7ch3Nwe/xOvAKg/pT0RcBISpZ//pHZjm/cnsMWHQG77DUrgD9ehNYZxZ1MYwKIiqe4ODQTMExanQskNP1UypE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943176; c=relaxed/simple;
	bh=jlOAAlg5RD8M2yfzpcOtyY7TWD2iWsfJBQ4kXp06jhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eWSR5Ah0H+gcKsTGP1cTpeMsmNXPgVGigNdPNXXzkuFXt7pzRcvGHLq7EFG+/z9zQM6+dR8t8p03B+ZSWhVcydlaZOPHVzxfY5FmYDHQ0sqSsCiCMuswZ2yYCGblWi1lKAjv9mrjGFNF/EsPjibUhN+ykrC3aRtxmsoQAn1N9Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5ms1JPf; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngf87ljlg803kDneiy+/Xocusbmda1Gpox0DZaMfeVOEs560R1JLM4wOtdhv0Olqvqdw+F8yeIbM2d1ec545+Ml+wf8WvT0jfMdMRy1aAyT7oLXYAhnxuUmRgrFW6UpBUdBk8PdXiWk44Y+lJNQWyyCsQaLMKU63fQ5LPoJ0NlT/WUTYbzc2MNie6Vxr6sfj11LoJLjIAF3vTVqqig1FtjsEFIcERrmGGMNbce1FEU58bgM4q/UuZ17Z6cTaNOXcs32BjUG+b59n+c8KwKnwHlSquZST95qUi5dkiStwsVem/tbshI4ofTEqha5cGxpv9QjDRwKOQqOC+MaH2MeeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9OHvGhlS55cIIxiZch162SJJnc+s+s9kX1Zx2SQ6QU=;
 b=ljt9loI+RHQ9oiMH3ob59LQx44obgRHno6U7BK3iL3I/5Ao+gkxdXBfXEZYfJIRK5u96FeAadEJU2QLNPGhfuyx56bEaVJQbV4LW6rM8piK5198cJ+XBGBv9WmTBv6Zomu8gH4+3q0pKM9jxz//fsnyu/9GCblidoFS8cfa/TiEgbXlaVXn5KBbsoMcw34d8lAaT+ULqUh4nd7WcK3EMVWP5iV4NQy+/DjbuX+g+xtcVS31aw3fevQfV6wbXLVjcYTVzCGJ39204eFM30yzOpbXEW1WDgbGg5TmHuVBWZLkb6YB4ruhPn7YjLvIYAmUdtX4o8c4VelJNvszT2h0lfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9OHvGhlS55cIIxiZch162SJJnc+s+s9kX1Zx2SQ6QU=;
 b=E5ms1JPf8qlGaTLRxyOGDwiEgb4/OTe8slwz3WX3TkeHJI06KDFi8w747TLt6K3J30/uUKEOkIDQyV9JNyz9tArljYwMRo+7/M9v2ZtUTwEsb02Dti3Mm8cniZIvw6Rdvy0IwxAR6yLHCWU6gO70xT9RjoqPtp9ggLDCqgTwrDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:32:50 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:32:50 +0000
Message-ID: <0a844d55-f901-4ca0-9cff-54148f060531@amd.com>
Date: Mon, 15 Sep 2025 08:32:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-6-terry.bowman@amd.com>
 <20250829163355.00004fda@huawei.com>
 <ee9d1e0b-1583-4fd0-9598-753219957df1@amd.com>
 <fb81e416-6c12-490f-b600-dd05a7d9a727@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <fb81e416-6c12-490f-b600-dd05a7d9a727@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:806:a7::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: d37a1f4a-ed16-4407-120c-08ddf45c5d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXR5Q0dwNFJBdDVVN2tPM21HS3VPWktORjBOWElhS1pHVlpaS1hQa2QveTQ4?=
 =?utf-8?B?eGZhTHFwY242TThyWUFydGhXU2pqbUthL2RUOEoweEo0RGsvSTI0ZUdrS1I3?=
 =?utf-8?B?VnZFNHNSZHRRMkMxTmJCbHBaeHE5RTdOZnd3aHpqQnl4anZHQ0pNRWQySmdo?=
 =?utf-8?B?d3NvV0JWZnZKTnJOQ2RvdE5lRkUyZ1FSdzJaMUhNdE03dGdqbEgyejdmd0lM?=
 =?utf-8?B?L29ibVNiRFJvdnFxMjlocmNJWDNvNHp0UFpqZHBpOC9LZVR5RmZQZFNHMU54?=
 =?utf-8?B?d291V1Fwc0NjYjNrTXN6MXJlSDJzaHI4WGp3QjR1S0pEM3lLcDNuZTl2QlJu?=
 =?utf-8?B?cWhSWHZlNTFEanl0RnJ2MGhCNUFEY1NBWU8vbzhLUUVURDhQcm45WXJmT240?=
 =?utf-8?B?eFZUMkdsLzdYUEZ6dE0wVWN1dUlkOGZKV3BhUUI5NEt6cnByWGV3UzlFcXJ1?=
 =?utf-8?B?YXZxM2RvZG5FZU1DU1dHNjNTay8ySjN0SGozUHY1Q05xRmo2QjdNa2xLRk1s?=
 =?utf-8?B?OWJZNmZBWERvU0YxRlhhZGFCaTM4ZmZXaFJ5L1g0cmNWdHQ2V25mZ29WdWw5?=
 =?utf-8?B?U3U2ZlovUjk0eGJIWktLOU9yYXZlNlFESlU1T1BtUDgzWEdKUTFRZ2MxUXBF?=
 =?utf-8?B?aXlPc2J4Zk1HYkYyc0x4SkZKTFpaREM2YmJPN0dGVGVTRHNVaGJMZlFhalc4?=
 =?utf-8?B?OXVNRVlidUtNdnV6dWFZTk80Y0dDc1p2anRTdzViMHgwcDVoZVhSclY3Um9j?=
 =?utf-8?B?WEt4b0ZMVEpHTGxEbUdiRW9kRlNlK1JYL0NvODlxcTBtZUM1V0FsRFZueEV2?=
 =?utf-8?B?NVczN2ZHZjlzSmtXNTlNVW5lRk9Id2laVVVEenRvd3ZyZUNiVXl4Z0RDc3Jt?=
 =?utf-8?B?L3pzaU5Hc2dGbGF4am81SnR1RE9yS25JR0NXMXJ1czdYbytialg0UjhrbmNJ?=
 =?utf-8?B?aE9sN1R6dW1ZWlNUUUp3ZkZhRlRhTlFpakdPUXlJMUZEcCtYeXJwaHNqYWR4?=
 =?utf-8?B?VDJWb0EwL2dTOG1lOEc4MUpCSWp6dms5d1A1Rnd3ZnpVMHoxUTBwUTA2M3lm?=
 =?utf-8?B?dlYvQlcyNnRyNDBIcERFSlRRckU3RnhiUUMrQWRvZFo3KzB6Y0hVWWNuZnhm?=
 =?utf-8?B?V0lBbWxSUllaelVPb1FacFBVeFJ6ZE1wbCt5UXZGWDNBQkNSM0hyQUFFNDF6?=
 =?utf-8?B?QjJ4Y001UWZaWVJDa3FObDhZNGUzWld6b3BYRzdoVitUbkZIR2RHQ01iTms3?=
 =?utf-8?B?UDRwZjdIbDhkTnQ1K25ld25zOFc0QnZ3UGNMa0tvek1QSi90MlI3NHBaNDJJ?=
 =?utf-8?B?OXZjY3hVMWpzbVA4YkxoQ0hKRnN1L0JWNER0OXZtMEFIcFRrYWJudlB6OE05?=
 =?utf-8?B?QzgvUnlXOU43S2Y4eEEyTGxnRzZmM1lOZ3RRUmh0OHFSdnM0OVpDVlB4T29H?=
 =?utf-8?B?R0J6ajgvbmlTaERnaTYrZG1qbUtpcmQwR0d6cEtvMSszVkxEb0hXNENBTURu?=
 =?utf-8?B?K2gwL2w3a1hWRXh0Zk9VY2VHQXZ2WTNRS2gyck9Neml2WkZUdXlMUm5PNkJ6?=
 =?utf-8?B?NU1oRmFyNTVWdTBDN1hUZWxXdllSK21KcjZXTndWQjAxN0NNUnhsSUtXVU9O?=
 =?utf-8?B?bVhyd3NPU2ozeVlyRFFMcWNqZHVIKy9oRFJsaERickUybmo2aEpEemREeUtB?=
 =?utf-8?B?WGI5bWVMVnZSRkFtR09majFBd1NlYmN1aVE5d3BpUzQ2YnlDc1ZFb3FVYmdH?=
 =?utf-8?B?cUc5M0loMDE0SGFwNTV3aE1oWXhrY3BHb1JJdlh3QlVGS0VJR1g5aUEwNVNu?=
 =?utf-8?B?eWVrSXVZMGxtTTdKTnNYU21OV24xcmo5MkYxOVI1L1RCV3JPbmpYS2Z2UERv?=
 =?utf-8?B?MFF6NU83M0ExdkMyRE96OUh3S1kza3pLRjcrbDhlZ3YrYWxmVzFvWEhwSENN?=
 =?utf-8?Q?bJ+rL/Yhmog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhqcUhnNlYvVnpkZUVtMjNsanUxZHBHUWNzbi9zNmhMMzQrbDFDRklPeWhH?=
 =?utf-8?B?SGNsSHhObStGMEROZy91SUh2ZWgxaWFRaS9xSGZqVDV2TmRRZit0RFNPWldT?=
 =?utf-8?B?WFQvTXdhOFJKSGw4MlV4dC82TzVkbUhFTk9tTCt0cWhxeVJ0eUlRZzlXbm5U?=
 =?utf-8?B?TUNCZjBjeWc4cEgrTklMeVJCUWcxbk5Ieiszb3Zza0ljSjExUCs2RnZBRnBK?=
 =?utf-8?B?ZDlSTDFNWi9NK3luQyt3Um5IcU83bzJtakk1RDdjYSt6R0hEbi9sVjVJL01P?=
 =?utf-8?B?WFpHSmpQa2tHS3VvbGxpazJhOWxXNzcyTVhrVllZcnpMTWpwRXcyTUtTWFNC?=
 =?utf-8?B?TUFiUHRTQjNVNVZPWDNjM09vQ0xCNktpRUhrQ2Y3Y1VIUmZPcXVNYlJvNU44?=
 =?utf-8?B?NGNXcUNFaEM2RysxelJZS0FRUVFsOFVIbFdYVmk1WUg1T3JKN3JjRHZHMjVR?=
 =?utf-8?B?U2dtaC9kSFhRM1lCVE5LTzl0K0ZvYXhJMExBcTBMU29oOW1DT2NqYXNQNFlF?=
 =?utf-8?B?RndMZGlxR3FZRlBEOW5LenZpVllnNHlsajZWanBiOUlUeThEWVNyTm9ZUk5h?=
 =?utf-8?B?NjBLOXBkRnlSWldnM2NIdEJtdisrbHgxTGxxeTI4U3RKUmZkK1dUdWNzRU90?=
 =?utf-8?B?ZWtSU3RlOVJUOFdrME5jSlIwbjNBOG9HMTlQWmY5bERURTBBeTcrcmw2eTZJ?=
 =?utf-8?B?SVVFWHBNUEExS2Ixblhlb2Y3TXIyMk9GS2N0eUNzSnNIWnF3TldLWVJlMEgw?=
 =?utf-8?B?Y252N0VldlhCWWpOMGwvM2R2MmMyU3VRbTJkUjVLZXlocm9MUTFtQ1VpZXQx?=
 =?utf-8?B?NGdkbks0czQ5SDhKNVV0RzNTQUpnR1BmeFlWajZwc1dtRXhhTmVyWlhFVE90?=
 =?utf-8?B?UDdPcmlzYlM4SktETkVwYTI1RE9HMC9jQ0ZIVVZ4S0JOQVVzOWREQitXc2c5?=
 =?utf-8?B?VHNRd1orSGUwNmV3L0hSalluNmMrSG5xL2JuWnBwMEdLcHMxc0t3b3lNNDRz?=
 =?utf-8?B?MHFRcTNsbmNUT085dEhpNXVacnBqNU9rd2dVYytSd1lBeE5MZTdTTkxxeU5C?=
 =?utf-8?B?aHU3VUhZSENUN3RZZ21xalo3cFlYSllxTW9rSEE0UjEyZzhBQjduZlRxNVBS?=
 =?utf-8?B?UXJTKzFVajZQb085RzBZa2JwMlNaSXh4eHJma2lyQjBJbTNoejlPYXFDRGFy?=
 =?utf-8?B?RElOdVBWSHRNK1IzOThwcDFHOUtBdjQ3enI2bU1ZQ2UyZW1Jb1hWOEFwRFYv?=
 =?utf-8?B?VkVFR2toOExhTTd2K2JYWEF3UmtWQWo0OUY2U1hwMkNpWlNEREN1OVBUbDhp?=
 =?utf-8?B?bk50VVE2VVZrcVlRU2M2Y2txNmpQK2tqZGxGMVh4bkdkajNJNlRUdlFITDlU?=
 =?utf-8?B?ek1McDJBRW9oZnFTc1JSeWpvMzBtY1lxNDJqK2tsaFQ3bFY3dVRKQUIrcnNp?=
 =?utf-8?B?Tk9QcjJsUW1xUEltbXJBR3o4UWxXUWEwWG12ZFdqTDJmY0xQM1pONmJ3VnpM?=
 =?utf-8?B?bkdUamNMRklHQmc2WWJ1VXlOZXhUM0JhRU1mRjVGQjhhNndhRDdlN1NwNk95?=
 =?utf-8?B?T3g4K1dVcDY0dXl3WFRRc1BaekdxVGd1U0hrQWs4WHlnZktiVk1kdEV5Nm5a?=
 =?utf-8?B?TWgwaHhWVEhycmVtOHlQeHRrNkJ1TThSWUZDYUhwMnRCMExOTVVsNG1Bazdv?=
 =?utf-8?B?dlRuZ1FRUERyM2c5UnFFckovL0t6VUdITkNCY3MvN0E4bTUwMUtTNWoyMEpI?=
 =?utf-8?B?NGVFdFYrSHJNTm0wU2lVMVVMYjFiZ0hyWjQ4MHcvTFhITHZPc2JMWFhrVWU5?=
 =?utf-8?B?RTc0Q05ubHRtbVhCdVpPc293dU5jS2VwL0NtY244V2dNbU4reDAvaTlVQ2g5?=
 =?utf-8?B?bFFYa0luNmdIUGZqZVQraXBGYzM0UndOeHJaVWNCbk10TUt2MDMwZ1FLVnR1?=
 =?utf-8?B?NlNMVDVESFVnRjViMTJuWk1YYzVQKzN0MlRSZEd1MWJ3a2dYRUVGNnBUcjFx?=
 =?utf-8?B?am5XL2ErTWZPZjBKMzJVMG5HSzE0RGZuQ0JIbHRqM2JwUEJlZGxPL2ZhRG9G?=
 =?utf-8?B?M1ppSDdlbzQyYUhQTlFyUjc1TU9paWZ6dHdVT1JnQXhlNmdpdjgzL3lQNkRS?=
 =?utf-8?Q?i7RVx+Uu1SOc14Ess9szDp+kP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37a1f4a-ed16-4407-120c-08ddf45c5d55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:50.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2Lrk+Qn3HeiezIm4MTTdKc8YALQQs/msVa7nQFAx5jcvIRmlWoCdRaRM88XN5nNPGhgmfDUYqqvK19Px9UCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652



On 9/11/2025 2:41 PM, Dave Jiang wrote:
>
> On 9/11/25 10:48 AM, Bowman, Terry wrote:
>>
>> On 8/29/2025 10:33 AM, Jonathan Cameron wrote:
>>> On Tue, 26 Aug 2025 20:35:20 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>
>>>> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
>>>> from the CXL Virtual Hierarchy (VH) handling. This is because of the
>>>> differences in the RCH and VH topologies. Improve the maintainability and
>>>> add ability to enable/disable RCH handling.
>>>>
>>>> Move and combine the RCH handling code into a single block conditionally
>>>> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>
>>> How painful to move this to a ras_rch.c file and conditionally compile that?
>>>
>>> Would want to do that is some merged thing with patch 1 though, rather than
>>> moving at least some of the code twice.
>>>
>> I don't see an issue and the effort would be a simple rework of patch1 as you 
>> mentioned. But, it would drop the 'reviewed-by' sign-offs. Should we check with 
>> others about this too? 
> I would go ahead and do it.
>

Dan mentioned he prefers leaving it all together in drivers/cxl/ras.c.

https://lore.kernel.org/linux-cxl/68829db3d3e63_134cc710080@dwillia2-xfh.jf.intel.com.notmuch/

Terry

>> Terry
>>
>>>> ---
>>>> v10->v11:
>>>> - New patch
>>>> ---
>>>>  drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
>>>>  1 file changed, 90 insertions(+), 85 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index 0875ce8116ff..f42f9a255ef8 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -126,6 +126,7 @@ void cxl_ras_exit(void)
>>>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_CXL_RCH_RAS
>>>>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>>>  {
>>>>  	resource_size_t aer_phys;
>>>> @@ -141,18 +142,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>>>  	}
>>>>  }
>>>>  
>>>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>>>> -{
>>>> -	struct cxl_register_map *map = &dport->reg_map;
>>>> -	struct device *dev = dport->dport_dev;
>>>> -
>>>> -	if (!map->component_map.ras.valid)
>>>> -		dev_dbg(dev, "RAS registers not found\n");
>>>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>>>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>>>> -}
>>>> -
>>>>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>  {
>>>>  	void __iomem *aer_base = dport->regs.dport_aer;
>>>> @@ -177,6 +166,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>>>  }
>>>>  
>>>> +/*
>>>> + * Copy the AER capability registers using 32 bit read accesses.
>>>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>>> + * status after copying.
>>>> + *
>>>> + * @aer_base: base address of AER capability block in RCRB
>>>> + * @aer_regs: destination for copying AER capability
>>>> + */
>>>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>>> +				 struct aer_capability_regs *aer_regs)
>>>> +{
>>>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>>>> +	int n;
>>>> +
>>>> +	if (!aer_base)
>>>> +		return false;
>>>> +
>>>> +	/* Use readl() to guarantee 32-bit accesses */
>>>> +	for (n = 0; n < read_cnt; n++)
>>>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>>> +
>>>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/* Get AER severity. Return false if there is no error. */
>>>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>>> +				     int *severity)
>>>> +{
>>>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>>> +			*severity = AER_FATAL;
>>>> +		else
>>>> +			*severity = AER_NONFATAL;
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>>> +		*severity = AER_CORRECTABLE;
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>>> +{
>>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>> +	struct aer_capability_regs aer_regs;
>>>> +	struct cxl_dport *dport;
>>>> +	int severity;
>>>> +
>>>> +	struct cxl_port *port __free(put_cxl_port) =
>>>> +		cxl_pci_find_port(pdev, &dport);
>>>> +	if (!port)
>>>> +		return;
>>>> +
>>>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>>> +		return;
>>>> +
>>>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>>> +		return;
>>>> +
>>>> +	pci_print_aer(pdev, severity, &aer_regs);
>>>> +	if (severity == AER_CORRECTABLE)
>>>> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>>> +	else
>>>> +		cxl_handle_ras(cxlds, dport->regs.ras);
>>>> +}
>>>> +#else
>>>> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>>> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>>> +#endif
>>>> +
>>>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>>>> +{
>>>> +	struct cxl_register_map *map = &dport->reg_map;
>>>> +	struct device *dev = dport->dport_dev;
>>>> +
>>>> +	if (!map->component_map.ras.valid)
>>>> +		dev_dbg(dev, "RAS registers not found\n");
>>>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>>>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>>>> +}
>>>>  
>>>>  /**
>>>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>>> @@ -270,79 +348,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>>>  	return true;
>>>>  }
>>>>  
>>>> -/*
>>>> - * Copy the AER capability registers using 32 bit read accesses.
>>>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>>> - * status after copying.
>>>> - *
>>>> - * @aer_base: base address of AER capability block in RCRB
>>>> - * @aer_regs: destination for copying AER capability
>>>> - */
>>>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>>> -				 struct aer_capability_regs *aer_regs)
>>>> -{
>>>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>>>> -	int n;
>>>> -
>>>> -	if (!aer_base)
>>>> -		return false;
>>>> -
>>>> -	/* Use readl() to guarantee 32-bit accesses */
>>>> -	for (n = 0; n < read_cnt; n++)
>>>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>>> -
>>>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>>> -
>>>> -	return true;
>>>> -}
>>>> -
>>>> -/* Get AER severity. Return false if there is no error. */
>>>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>>> -				     int *severity)
>>>> -{
>>>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>>> -			*severity = AER_FATAL;
>>>> -		else
>>>> -			*severity = AER_NONFATAL;
>>>> -		return true;
>>>> -	}
>>>> -
>>>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>>> -		*severity = AER_CORRECTABLE;
>>>> -		return true;
>>>> -	}
>>>> -
>>>> -	return false;
>>>> -}
>>>> -
>>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>>> -{
>>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>> -	struct aer_capability_regs aer_regs;
>>>> -	struct cxl_dport *dport;
>>>> -	int severity;
>>>> -
>>>> -	struct cxl_port *port __free(put_cxl_port) =
>>>> -		cxl_pci_find_port(pdev, &dport);
>>>> -	if (!port)
>>>> -		return;
>>>> -
>>>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>>> -		return;
>>>> -
>>>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>>> -		return;
>>>> -
>>>> -	pci_print_aer(pdev, severity, &aer_regs);
>>>> -	if (severity == AER_CORRECTABLE)
>>>> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>>> -	else
>>>> -		cxl_handle_ras(cxlds, dport->regs.ras);
>>>> -}
>>>> -
>>>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>>>  {
>>>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);



Return-Path: <linux-pci+bounces-22286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85377A4345C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C961897B9A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6663254878;
	Tue, 25 Feb 2025 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DpDsBUu+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3B25484A
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458721; cv=fail; b=PjncZYws89AprYzDIpDXwZu1L0DR4TwMHSyBI6dz5ytvxGD6bK+mD8BVISzSh91yq45A8n7aQOqgbBCzfpt2tn97+xSc51hLghLzxPKH38XXVFX2xaoSwHIU/XzAswJ9r4vxQraTRsL9u2c0k44anOzNhjitTLrUZWpIBAXplw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458721; c=relaxed/simple;
	bh=/9/0IqXvVPkn7GAXCVPgOJzMEBb54ZSjcGwPwQqRUlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FShByxvzWlUHigeCtwGOO0lCqdzrXKy2ToDOMfC1FL8tbkfO10TKI8nssrsemQ/to/Zi2QwJ2LwT4FLIsInfZLxi/lX/e4aXi470qjXs9WohuNvxtB3d1g117h73YJwt1wfeFWgxQgkylWJ33UlowsqMEYMo40LE2n7wf87AlPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DpDsBUu+; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDpjLzDdJg6r+oJI6QHz9evkdFK74vO5a0vMJPm4HHI9nw6lRgbUM4wobgnWYsSbNnYkBeiSY44kN0DQ5QTa74hA5WatpAMMGv4jd39Se2SPvyyQxVGVnutVwxljPVprMv+2AwriURM6H7qiCGfdQ6E29bPIIVr6oZ0saVHNnw5s12rmSql8k2OcFY6oaIxb+wE9KAtAhW5jScNXa3rzmefkSi0SeZt/turpgm5q+ljga0O8WYIe2lLuCmevWmVtOllPBF+ruUpWABnwYs4iSjbqoNFKkkhVzVW2FuwGcMTrh5Az04rfjvXYQTNIybe21aV7xILqUR0us3dWTE3wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iY5xs/p6mlcsxgiJ7T53dGhEz20mGRH9pfgZz6mpKM=;
 b=Quo0CsbHKDAMJZdCt5GCWvmlipxlp3Xs0OcL1Yc2YehtIFBhp9FxMJ6BozwAYDc7jwZTRZHhQHU1S+FhNY6QrBXaUN8gKJTrSGFJErRG9hASyrTDTroyP02jG7X/IwY5Wn/mWEmePOAjQN9E9AAaxZJIWtam6ADGWG0JzfRaCNZy5KGSIkroFFNREhg07YZ+nC15vCY4SnKmu+Q9xQN/CA2pwvXDlXN/t4baV2veALlrfOllfsiwX3iqQ36zBrgvoo9ZsFjY/vGROqGDZ/teO7fYzGkPkreErGjAk2PYOdYFh8+F3zR7wvqZawspRW7bIYYAH+43rbezQEbZGmYwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iY5xs/p6mlcsxgiJ7T53dGhEz20mGRH9pfgZz6mpKM=;
 b=DpDsBUu+Md6X/q/xrJTzebXYhfRiGJ3DtyWRmnKtE/9HAwrpv4/WjRBwwDE4P3tmLOjGA+OkpVZssx8nmU1GYMQiCGY2JbXLxTnV2NAtJ6zUlDPSy+i/WXozeBHO9E97Lry4n5mvibo1zFVFjimcAEOZz9GIGYEChQfL8pcKJz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 04:45:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 04:45:16 +0000
Message-ID: <e1864dcb-fa7f-4c34-8031-a22360c9bd2b@amd.com>
Date: Tue, 25 Feb 2025 15:45:09 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <67b8e5328fd41_2d2c294e5@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67b8e5328fd41_2d2c294e5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0201.ausprd01.prod.outlook.com
 (2603:10c6:220:1ee::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2f608f-cf8f-4834-680d-08dd55573316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZwcnhFcVZ0QUNZZjY2Y2hHRVlpYUJ5V1lQWjl0NWg0c2EwTzlqNnpZdjc2?=
 =?utf-8?B?K2swbXErRkJKdVdGL1dVaUZXbFpuKzc1eWZRMWlhQ2ZxamVMcGh6cHpPNU5W?=
 =?utf-8?B?NVFGYWZzc3E4VTliMjM0b3BPQW5uZWxpVUlFN3JTWmV3R0xUTjg2TjlmOWJI?=
 =?utf-8?B?UTVrYWRjbFVza2QrYjRXOFpQalNKMzdSalVZSUJ4UWU1MHliUjZGV1A3QlB1?=
 =?utf-8?B?VzNXRW1yVFdwVkhpYVZmb2NsaGVBS3dla050WG9xdy95aHV5ejk1TkE1RXQ0?=
 =?utf-8?B?SkhtM1BkMUhiWTgyRU1wT2gxZFByU3BpYzZ3L1Ezdm1YeFp5R0NOclZVc3du?=
 =?utf-8?B?OVpTUm13SUNTOVU0SWhhelAreVZ1WnVUWGFvMHdkVXNoRXdzYisxSkJXUnRl?=
 =?utf-8?B?RFJCNFFhMUdYaTMya2Q4eUh3aHhmZWxKTWhNZXZiL2hESHpYRTdlZ2RqTGxN?=
 =?utf-8?B?eCtFSkZ2UFNzV0xEdHplQWxSemZoS2wxc2NnZno5a1prU2hFYU9mYUxwSjVH?=
 =?utf-8?B?dWhNaStDaU1paWpNVFcwbVNkTTV1Ri9QSzJsVGJabXhmZTA0ZHVKVE9HWWpY?=
 =?utf-8?B?WUk1clg5SHpBVEFadVpuUW1sTFdsVjFPWWRhaEFwMTc2MmxBazNkclFqSDFN?=
 =?utf-8?B?b2F1cmtMWHQ2eUdBbEgzK3VBZ0kzUlU3UENFVi9tc3JSajVKSUc4RG4yZ3I3?=
 =?utf-8?B?SDBKKzkxUllCSjBSdkVvR3NvUFdkcEJFbDkzWEtDSnZWd0Y4bnQ0dGRNdFp3?=
 =?utf-8?B?Ykd5dldTQ3pyVzVYc1c1MHZ1TWJiWVBVUU1QZU5BZC9WdyszQlZialdGZ2tZ?=
 =?utf-8?B?TnN3aUFyUjUwdXdFMzAxTDlySEN0djJVd0FVUDAwNzVQRzEzM0hPaDMxL1FY?=
 =?utf-8?B?N3habVE3VzQ0eUh1aGd1cFcxQ1BDcnIwWnNyZDZxZE44WXpZZm5iank4T28v?=
 =?utf-8?B?T1VPK3JMRXFnYzJxWGZ5Ym1UTGZESzVoVXlpaWhZK1pDL0hHWWljRytlVFlF?=
 =?utf-8?B?NXlycjh0NGEyV2x4ZFA4dXVNTEJncERaVE1TcTN5Zk80OU9UaU1oZ3NjOFNU?=
 =?utf-8?B?eWphKzJ6TWw2S0VNYk96ZzBKSzlDcDZKaHI0Y2JPWjhENGs4ZDVSSm1NSnpn?=
 =?utf-8?B?U3FXcEt6S0tza3FNQzhHbXl4bS8xMjlHb0VxWURDaDhFbksvNFpCK3dUNG5p?=
 =?utf-8?B?V1RoZzJXN3FtM2NkVVE4ajUyTUFMUXpyelozTUl4NnVEUm1BQnF5WjdTRTNh?=
 =?utf-8?B?aEFzTnNxcU10RHA2SzZ6UWo3cnJKeUp3eUUrL3Q2SVM3cEJjRVIvMCtLQkZr?=
 =?utf-8?B?Z1FiWjlpZFRSLzd5KzZSTzFXVkdMdUw4ejRsa2MxRTNFZXd6MHZQNCtoaDQy?=
 =?utf-8?B?a0RoZVFsU2J2UTc3TDNrNDg1ZHR6cUhOWEdQOUVvTkxZUUxRNE9sOW5jZHNE?=
 =?utf-8?B?cWtBK2xEWlMvL1FYS05lZHlPUDFxZkZsTVZSYlhiNVkwOGRXTHVRRGFsRFpj?=
 =?utf-8?B?V0xLMFd5em51SjhLNVplYWdlY0E4L0pHUEVzWndRYkZvQ1lGTWpud3YvOUhN?=
 =?utf-8?B?dXFzM0p1Ui9oYjFiUTJFVXRHVENMY3hpMzJzRnlIU2JLRnpBbDhEVEtFZnNa?=
 =?utf-8?B?TGVCZ0JhbkltS3Nvdi9Ta3BVRnlLajVXaVZyOXF2cEg4V090RGN2dEloZXkv?=
 =?utf-8?B?T2tZd0l4ckZUTWk0a1Q1UHRaTy9RREhCR0tZSWdXUy8rYzlLSDkySytLMUhi?=
 =?utf-8?B?eXNCQUpTYXU2MENlN1Q3WE10bkp4ZkxuVG5rbzh0OUdWK1c4V1lwUmFJOVlm?=
 =?utf-8?B?Qm5TbThCQ3RpRkJBVDhKbzZuY3BCQWdHZVdhK25yblZndDdibG1CNzc1OWox?=
 =?utf-8?Q?6KEcEt3yIPlVX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2RFUnVmdG5NNzRiMGdsNEtKQlErcTM4R3g1dmZERjdpTm1ERFl0dHZoNXFD?=
 =?utf-8?B?NGdubXNSdlZXbHlld0dCc05rRlUzZVdQWG1SdDV5cFNTVXVaWGZYeVNhaWZp?=
 =?utf-8?B?Qk0zcEh0eUR3RTVtbGdrR1Nvd2EzZjl1S05IZy9hTmxDT1N0cGJNY2JQa2pF?=
 =?utf-8?B?a3lWVHJ4aEFmRDNSVVR1Q3UrN2o0dHVoWURuYnlrSU8xQjNJVW56RXEycmhY?=
 =?utf-8?B?aUhNSjhyUWNHazNpM0JNdEtGcEIrRnNUMlRsSlNBbU5heTBETlpNNm55L2k2?=
 =?utf-8?B?MjBxdlNnblJLUWFJekFnZU9HN2laaVRpVlBUMUdGV0gxaXNLekNrYW5kNUpp?=
 =?utf-8?B?MDdaL3dsWFoyM1VyRlQ2dzdzOXd2SHl3eU1nWmgrQTg3bnVRUnNteWNaQU9x?=
 =?utf-8?B?WTFhVm5uYUV4b0wyNDlaelhWYk5ubm5mUDhGMk1TUXlBaTNPbC9xVlVBajRO?=
 =?utf-8?B?akY4TVVJQm5veUdZcThRR2Z3VndKS3lnZkE4RHlnck1pWjJqVG9TOEd4T1Fu?=
 =?utf-8?B?Qi9kUkhKbTJ2TzIwRlVMbG8vZzlEQjhkUGM0bmtoc3cyYUZVSFVyVnVYTlVJ?=
 =?utf-8?B?ajBMaXUzRGtEakR4UFRVK3RJZkxNWHRSaWJTdXlrSUtBWkxhNzk4L2EybUcy?=
 =?utf-8?B?Q2hqbFQ0a2VyYW1VaEVlVkpSK3NmaS9UV083dVloa1RybUs5N1UvMHBmZTk2?=
 =?utf-8?B?VTBlMW9NdEZWTlBrRGtsbGFZVUhyTmlBQXJkSENYQ0lnQm1BbS9KeENya2Rh?=
 =?utf-8?B?MHNod1VJeDlnSFJCNSthTzd1RlJQbUtSTWlPSjNZUW5GV3ZKWWV1ZWd0a1U4?=
 =?utf-8?B?ZzZJMjNMUFd4U1h2bFptM2VxZEtBdlBIYkp0N014QVVycEhla2FSZ0tLdVNx?=
 =?utf-8?B?aUQzc2NBQTlYaGUrTTJrSEpMSWgxRFo5Q2dwNkZVNjA5R21MQnJvSHo5UWJF?=
 =?utf-8?B?QzFFZVZRZ0pUR1NwSkh0R0xVL09RY3JIZjYxOVBWREQwZWhjcER6N2pndHlN?=
 =?utf-8?B?emI0NFhwQXJnQUVJTm5NclhiREc0WWhFUkwxb2UrMG5zTldZclFHVFpGUVR6?=
 =?utf-8?B?dHFwS1I0QnZjYk1WSG93ZGNTeDRPNUd2T3plaW0rTjM0eCtCNS9vanFrNkxL?=
 =?utf-8?B?enMxcjhIN3R4YWcwSGZyR1VabHRhOWp3NnF4WXdCaFQ0bklCVEMxMmVxTDdO?=
 =?utf-8?B?Z28zMm04NnJ4VnFHN1lvZXQ1bW1OcHZlZGVaVmhUQmRZdGdWTUFwQ0cxZXNK?=
 =?utf-8?B?b3FZQnoyeVB5Tzh4azBuV0dTYVVXZFV4ZlJCb2w0NVRhUTJqOHlVMXUwNTdo?=
 =?utf-8?B?YlVpQTQ2VHNQUXpxQWkyOGlST0JXdDk2cU0vYzduR2N0eityQ1BPQUM2ekM1?=
 =?utf-8?B?ZjNXdTJlemxaMjVBeU5yWithRHJDQ3hKS3VsYy9RWVRvVHlWMXlvZVFiWFRU?=
 =?utf-8?B?OGdQU29KR2Z3VGc2Z3NlMWd0c3dtWWlTWnk1bkRFRlY5VjNyYldsWUlvSWpV?=
 =?utf-8?B?dkVUbG9zeE02Ym9BQzBES2FQd3pCSGtSTjZHMERQVDNVNTdydy9mVHdJdXVZ?=
 =?utf-8?B?MkpjQzdpUTFtVWZqYUJYMkprN0hCZVdFTGI5WFMzQ1M1c3ZodnNwNC96T29J?=
 =?utf-8?B?TFl5YmVjY0FsSW1zK3lmWm9ZM0FyZUd2T2RtOHkwenpjbE9SYnVqZ3R4U2F3?=
 =?utf-8?B?TitrZXRHdnpVd2xOTUF5RDlTNys0Tld1aEZ5ZkNmaE53TmlndGE2U2poZHVS?=
 =?utf-8?B?dWdaN21JVlB3Z0orMnh2QTVFUmpweEFNUHRsa1NwOWZvVW1ocHVtVDQ0ci9J?=
 =?utf-8?B?QkQzMlgzYUlOcmZ0S2hYOG1DaXZPNzZCOEFEWTJoanB0bk4xUlZnRWtJTDdB?=
 =?utf-8?B?WEs0TEZlMnhhbWlid2MvcmhzbTVNU2lraTdZamtMZzhUZUVkSjk1UG5hUWZR?=
 =?utf-8?B?YzlTK2dYVUd5VVNJN0wrbnk5eTZqSFpEejJVazlQQ0Zmb1JEZHZJNmZ0V29N?=
 =?utf-8?B?d1B0TnRtdUNJdmpvWVdVV1RBdDd5aFNFTHBFQWlNcEhtcnlRTmpJT1JFSkVq?=
 =?utf-8?B?c3Q4NGFRcVdhZmdQY0ViL2tPVnA4S015b3A0OHpweHNCRzgrQWZmcVJreDJr?=
 =?utf-8?Q?V8o26NiP0GQXKz6m344dMKI3B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2f608f-cf8f-4834-680d-08dd55573316
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:45:16.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx0RnY8R0vLaIseFrxkHW2OjvDgqL+QsJPKt2OEfujSGJftqT1R3qT9SYMlSeZNmp6hLZzNSWGBz9/LIAh2zRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899



On 22/2/25 07:42, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>> On 6/12/24 09:23, Dan Williams wrote:
>>> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
>>> Environment (TEE) Device Interface Security Protocol (TDISP).  This
>>> interface definition builds upon Component Measurement and
>>> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
>>> adds support for assigning devices (PCI physical or virtual function) to
>>> a confidential VM such that the assigned device is enabled to access
>>> guest private memory protected by technologies like Intel TDX, AMD
>>> SEV-SNP, RISCV COVE, or ARM CCA.
>>>
>>> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
>>> of an agent that mediates between a "DSM" (Device Security Manager) and
>>> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
>>> to setup link security and assign devices. A confidential VM uses TSM
>>> ABIs to transition an assigned device into the TDISP "RUN" state and
>>> validate its configuration. From a Linux perspective the TSM abstracts
>>> many of the details of TDISP, IDE, and CMA. Some of those details leak
>>> through at times, but for the most part TDISP is an internal
>>> implementation detail of the TSM.
>>>
>>> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
>>> to pci-sysfs. The work in progress CONFIG_PCI_CMA (software
>>> kernel-native PCI authentication) that can depend on a local to the PCI
>>> core implementation, CONFIG_PCI_TSM needs to be prepared for late
>>> loading of the platform TSM driver. Consider that the TSM driver may
>>> itself be a PCI driver. Userspace can watch /sys/class/tsm/tsm0/uevent
>>> to know when the PCI core has TSM services enabled.
>>>
>>> The common verbs that the low-level TSM drivers implement are defined by
>>> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
>>> defined for secure session and IDE establishment. The 'probe' and
>>> 'remove' operations setup per-device context representing the device's
>>> security manager (DSM). Note that there is only one DSM expected per
>>> physical PCI function, and that coordinates a variable number of
>>> assignable interfaces to CVMs.
>>>
>>> The locking allows for multiple devices to be executing commands
>>> simultaneously, one outstanding command per-device and an rwsem flushes
>>> all in-flight commands when a TSM low-level driver/device is removed.
>>>
>>> Thanks to Wu Hao for his work on an early draft of this support.
>>>
>>> Cc: Lukas Wunner <lukas@wunner.de>
>>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>>> Cc: Alexey Kardashevskiy <aik@amd.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-bus-pci |   42 ++++
>>>    MAINTAINERS                             |    2
>>>    drivers/pci/Kconfig                     |   13 +
>>>    drivers/pci/Makefile                    |    1
>>>    drivers/pci/pci-sysfs.c                 |    4
>>>    drivers/pci/pci.h                       |   10 +
>>>    drivers/pci/probe.c                     |    1
>>>    drivers/pci/remove.c                    |    3
>>>    drivers/pci/tsm.c                       |  293 +++++++++++++++++++++++++++++++
>>>    drivers/virt/coco/host/tsm-core.c       |   19 ++
>>
>> It is sooo small, make me wonder why we need it at all...
> 
> I expect it to grow as more common cross-vendor host TSM functionality
> is added.
> 
>>> +static int pci_tsm_connect(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_tsm *pci_tsm = pdev->tsm;
>>> +	int rc;
>>> +
>>> +	lockdep_assert_held(&pci_tsm_rwsem);
>>> +	if_not_guard(mutex_intr, &pci_tsm->lock)
>>> +		return -EINTR;
>>> +
>>> +	if (pci_tsm->state >= PCI_TSM_CONNECT)
>>> +		return 0;
>>> +	if (pci_tsm->state < PCI_TSM_INIT)
>>> +		return -ENXIO;
>>> +
>>> +	rc = tsm_ops->connect(pdev);
>>
>> I thought ages ago it was suggested that DOE/SPDM loop happens in a
>> common place and not in the platform driver implementing
>> tsm_ops->connect() (but I may have missed the point then).
> 
> That's still the plan, but I would expect that to be a common helper
> that TSM drivers can use and does not need to be enforced as a midlayer
> detail in pci/tsm.c. We can add that to pci/doe.c or somewhere more
> appropriate for SPDM transport helpers.
> 
> [..]
>>> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
>>> new file mode 100644
>>> index 000000000000..beb0d68129bc
>>> --- /dev/null
>>> +++ b/include/linux/pci-tsm.h
>>> @@ -0,0 +1,83 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef __PCI_TSM_H
>>> +#define __PCI_TSM_H
>>> +#include <linux/mutex.h>
>>> +
>>> +struct pci_dev;
>>> +
>>> +/**
>>> + * struct pci_dsm - Device Security Manager context
>>> + * @pdev: physical device back pointer
>>> + */
>>> +struct pci_dsm {
>>> +	struct pci_dev *pdev;
>>> +};
>>> +
>>> +enum pci_tsm_state {
>>> +	PCI_TSM_ERR = -1,
>>> +	PCI_TSM_INIT,
>>> +	PCI_TSM_CONNECT,
>>> +};
>>> +
>>> +/**
>>> + * struct pci_tsm - Platform TSM transport context
>>> + * @state: reflect device initialized, connected, or bound
>>> + * @lock: protect @state vs pci_tsm_ops invocation
>>> + * @doe_mb: PCIe Data Object Exchange mailbox
>>> + * @dsm: TSM driver device context established by pci_tsm_ops.probe
>>> + */
>>> +struct pci_tsm {
>>> +	enum pci_tsm_state state;
>>> +	struct mutex lock;
>>> +	struct pci_doe_mb *doe_mb;
>>> +	struct pci_dsm *dsm;
>>> +};
>>
>> doe_mb and state look are device's attribures so will look more
>> appropriate in pci_dsm ("d" from "dsm" is "device"), and pci_tsm would
>> be some intimate knowledge of the ccp.ko (==PSP) about PCI PFs ("t" ==
>> "TEE" == TCB == PSP). Or I got it all wrong?
> 
> I typed up a long reply only to realize I think this can be made simpler
> by only having one common context and drop this subtle 'struct pci_dsm'
> distinction.
> 
> So, 'struct pci_tsm' is just the common core context / handle for
> drivers/pci/tsm.c to communicate with low level TSM driver
> implementation. It is allocated by pci_tsm_ops->probe() and freed by
> pci_tsm_ops->remove().
> 
> A low-level TSM driver can optionally wrap that core context with its
> own data, i.e. enforce a container_of() relationship between the core
> context and the low level context.

My sketch evolved much since I wrote this comment :) I've put the low 
level TSM bits into CCP.


> [..]
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 50811b7655dd..a0900e7d2012 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -535,6 +535,9 @@ struct pci_dev {
>>>    	u16		ide_cap;	/* Link Integrity & Data Encryption */
>>>    	u16		sel_ide_cap;	/* - Selective Stream register block */
>>>    	int		nr_ide_mem;	/* - Address range limits for streams */
>>> +#endif
>>> +#ifdef CONFIG_PCI_TSM
>>> +	struct pci_tsm *tsm;		/* TSM operation state */
>>>    #endif
>>>    	u16		acs_cap;	/* ACS Capability offset */
>>>    	u8		supported_speeds; /* Supported Link Speeds Vector */
>>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>>> index 1a97459fc23e..46b9a0c6ea4e 100644
>>> --- a/include/linux/tsm.h
>>> +++ b/include/linux/tsm.h
>>> @@ -111,7 +111,9 @@ struct tsm_report_ops {
>>>    int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>>>    int tsm_report_unregister(const struct tsm_report_ops *ops);
>>>    struct tsm_subsys;
>>> +struct pci_tsm_ops;
>>>    struct tsm_subsys *tsm_register(struct device *parent,
>>> -				const struct attribute_group **groups);
>>> +				const struct attribute_group **groups,
>>> +				const struct pci_tsm_ops *ops);
>>>    void tsm_unregister(struct tsm_subsys *subsys);
>>>    #endif /* __TSM_H */
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index 9635b27d2485..19bba65a262c 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -499,6 +499,7 @@
>>>    #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>>>    #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>>>    #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
>>> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>>>    #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>>>    #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>>>    #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
>>>
>>
>>
>> I am trying to wrap my head around your tsm. here is what I got in my tree:
>> https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>>
>> Shortly:
>>
>> drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to
>> control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi,
>> it does not know pci_dev;
>>
>> drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>>
>> drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>> - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>> - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>> ccp.ko knows about pci_dev and whatever else comes in the future, and
>> ccp.ko's "connect" implementation calls the IDE library (I am adopting
>> yours now, with some tweaks).
>>
>> tsm-dev and tsm-tdi embed struct dev each and are added as children to
>> PCI devices: no hide/show attrs, no additional TSM pointer in struct
>> device or pci_dev, looks like:
> 
> The motivation for building awareness of device-security properties
> natively into 'struct pci_dev' is the recognition that TSM-based
> security is not the only model that Linux needs to contend. The TSM
> flow is a superset of PCI-CMA and maybe PCI-IDE in the future (although
> Intel seems to be the only architecture that has a concept of allowing
> IDE establishment without a TSM).
> 
> I understand your motivations to make all of TSM functionality bolted
> onto the side of the PCI core. It has some nice properties. However, I
> think that is a SEV-TIO centric view of the world.

Very true.

> PCI device security
> attributes are PCI device attributes and have reason to exist with and
> without a TSM. In other words, certificates and measurements should not
> be placed behind a TSM ABI because certificates and measurements are
> expected to have a native PCI-CMA ABI.

The Lukas'es CMA ABI should just work on AMD, without any TSM. I am not 
sure if anyone wants CMA bits from the PSP when can be obtained from the 
device directly.


> It would be a useful property if software written to retrieve
> measurement and certificate chains did that relative to the PCI dev
> independent of TSM presence.
> 
>> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
>> device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind
>> tsm_tdi_status  tsm_tdi_status_user  uevent
>>
>> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>> device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user
>> tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>>
>> aik@sc ~> ls /sys/class/tsm/tsm0/
>> device  power  stream0:0000:e1:00.0  subsystem  uevent
>>
>> aik@sc ~> ls /sys/class/tsm-dev/
>> tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>>
>> aik@sc ~> ls /sys/class/tsm-tdi/
>> tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0
>> tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> 
> Right, so I remain unconvinced that Linux needs to contend with new "tsm"
> class devs vs PCI device objects with security properties especially
> when those security properties have a "TSM" and non-"TSM" flavor.

One of the thoughts was - when we start adding this TDISP to CXL (which 
is but also is not PCI), this may be handy, may be. Or, I dunno, 
USB-TDISP. The security objects are described in the PCIe spec now but 
the concept is generic really. Thanks,


-- 
Alexey



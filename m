Return-Path: <linux-pci+bounces-41658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F0C6FF97
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 045133A76D8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4032FA1D;
	Wed, 19 Nov 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LW0dDffr"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17232ED5D;
	Wed, 19 Nov 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567765; cv=fail; b=EIo2PVVE7e7ur9sWgnwIdbGdKiXAx7WvwiyrUvRitowhhBkI9fYuLZXswMzbsmJ/97Dyv4HnZm3CtGOXjp4MQ5dIjlTd4Qu5BV8aZwCeRO1Lw7Qe4noFQsVtZuzH3my8M6N+KEIzbLusyG2ppypoNr/0yYdRhYk7eSl2UiDfPEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567765; c=relaxed/simple;
	bh=IGaK3y1cbjB1re/VPsknkA3weCd4PDFwNWFMIm7zGDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E53Y9aw7vAD94S1BsSyPU+RUkJVIIkYcZySWRkZlQbAKxoWMMgC01kR1P5xgRzKw1PdGXRf86h+SqvWQSn9CpbPXolWoFrV/Twv7ZSu6TdjxZoG+8PNF7DgU8JWTDp6NilbkEMYkGua+jMt8oXohlDsU3u/nGhD9YQIcMNMPZvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LW0dDffr; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLrAMknfRG5eH+8glq01otYb7LRFfFE4OiQNzPY44QQP7q/CAX2qQzqTXQ78tbISa/X/p+qxlfmg83e9HQHxLoVMcP81W5qmIW8d3O20hTfLg+gdcd/e/bi5ZxC1HDJV6DePeWZqBMpRFjXqIsKPA+v3tbQuivMgenIa1g85LNJB5MH4Nx90gPctbaTnLHQHkyT82yxfI4XzQgAOEjipcfVzVk8QJ1at2+L/we/Z1goWTH6WG3fddQY/wdKgec1zJOnvxmjUCNtTA/eBdInT2oKni6Tf/bgh8imYLRUUAG9iM1InPcA5jrPJ/V2IVsYTwnl5jjDkKesfJmtQsPp/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S7A719ujXZT4mkFaF/ITNQJPCOtMy4Tpk/e1N3ERZE=;
 b=E/sSD1aFEluy58nDGMf18I/mj4/WoMy8jTS71hta/eo8qq+BG37+F+idcXDzXNcuRvhtbC4QJagUP/CETPG4It8h7eQwzputFx0KP3rscsjX3hAuzHvs9SibLEgnew0kD43yvceOzZLCSGLr7kIhDSZ/eRJIMo1vQVrCrnB7HLi2WmxtNSz+Ut9AQcMOPwvSsdFz28+/D7zReiS/mlOgzdtbvlYtV6I9HuySpilk0WLOA2BZQrBgW5EQkBKJTPVjRSoPyd6obCwr3mq+ON0d6K3QFRZLWMylRKCGK0sBmdwvGgx+W+QO82feNIzfD7X4G4r1BPqh9fjq4LDr0U8kLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S7A719ujXZT4mkFaF/ITNQJPCOtMy4Tpk/e1N3ERZE=;
 b=LW0dDffr0DbIyIaANtAMpQbSvyFXLoSGR+UGgN1a3Nwf43SR9Q0uXf7xUjcUyF2TSlwdaECTYE8swpIgzQHfIrHx5hFNsjVmsXWGHWWL/VMQZvW+ezf6/YfD9SvA2TL4UJXSXlqSDuEFzEdz0seFXPXhGQkNQ9FE//ajgIppmz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 19 Nov
 2025 15:56:00 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:56:00 +0000
Message-ID: <930fcd64-92b2-462c-8301-6c753f41c498@amd.com>
Date: Wed, 19 Nov 2025 09:55:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-3-terry.bowman@amd.com>
 <691d375d78bd8_1a37510040@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <691d375d78bd8_1a37510040@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:805:de::47) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddb9471-1410-49a8-0600-08de27842258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THlXTmRpTVpJSm9adGdvNVV0Y1hncFVMcTUvK2t3STUxbFU2NFpOcmFncCtB?=
 =?utf-8?B?c0lQZ2R1ZHNsWHhFUnlud3Y5ZDVkQXdqVjdjdFFWZ0gvWEhaWkJFaDdWc3Iw?=
 =?utf-8?B?VCtLeFlrRWFaNlVYSGpISTBIQ1RwL05sbHhoOUEwbWhnOU90Q0o0TWNOeFJG?=
 =?utf-8?B?MHExaGxLdDdzOHZNbFNzQ1YxMTVJVzNURlVMclpGUVhQbnMxWnc0eDZDSHJp?=
 =?utf-8?B?YnRkcDl0WXdid1Rtc1ZpdThWbjJCNkNGMy9ZN3RxeUovdlkxckpPSlpLM2h1?=
 =?utf-8?B?RXAzTnUvdnZ6OHFvRWMyWVRxMGY0T0p2R04rblVIKzRUM0VzczNHYmU2bG15?=
 =?utf-8?B?QkNjNmFnVXFLVEdORGFLUStFZm4xQjgvRmFaQWxEZHZkQWpjVVk4bEtiRXhE?=
 =?utf-8?B?WnZEK0FYK0VHaEpIZmQwcStsSWpMY3QxUVpOWlFVZ1IyOTdITGlMdHR6QVV5?=
 =?utf-8?B?cTlVTTdQcTdtNHhiWXZRa1graGgxckJ3aHp2RTBYYkZpektzZUc3VTBZcXFG?=
 =?utf-8?B?RkJGY3htcVV1aWprenM2UzBpNlNJT0RhdGU0ZHdwUUZkNENTd1ZjbCtzU21Z?=
 =?utf-8?B?Y1pMY3RkSFJsRzRVMDh1YytCeWtOYmVtYmhXS2FvNHJ6bExPc1RiQWY1SXJU?=
 =?utf-8?B?M1VFMEE2QzhUWjVQMmhvWDVDcVk0dFpzTlFRMWc3TVRxcWN1VE1Yb2UwV1RM?=
 =?utf-8?B?dmNFV29SY3B5M3UrYUExdk9uckhRSGRraWRwbnZEbmZVR3lwbkxEWTJldE1I?=
 =?utf-8?B?QVJjZXlsdERpZGdoQnhjYzFlU1dmUjkzTkYzR3JudHl2Q1B6TEIrVG9GYjRN?=
 =?utf-8?B?Z1JDNjgyUWJlNzlaSDUyM0hyeVR4TzVjWU9GNStNTFM1clFBYkhZK25MSE02?=
 =?utf-8?B?Y3A5anphRnlmWGNLWjl1M2RMSlVwVktoMmNZbmtEemNjQWNqMjk3OUhNcXh0?=
 =?utf-8?B?TTM0cW00Z0F5L0M4YXFHWkhISTJ1cGNrUmUzb0tydjVLS0M1ck9KTDdUeG8v?=
 =?utf-8?B?MS9BVFRVa3hKSnBUeEFxeVdBbjNoL1NiczZROXZDUmtzaWNRTSs4WnFQMGZV?=
 =?utf-8?B?bllFVHlCNjdwZUhUYkxYbUFrMDBXYlQ0NkxHN2dSZmhSdGVsNkoycUpsdGdS?=
 =?utf-8?B?Q0wvQUdFTFh4TVZoaEFlanpzTEhuZEFIR2JTb1M3S250clBtTmFSaFdtb3Er?=
 =?utf-8?B?c3RuT09LdW1adFhOaWFraFRzOFV0MXJZSUlwbElkbzQwYWx4b3N2MkwySlVa?=
 =?utf-8?B?S2NtWDBYZUttaHg0Uy9wZFZJMUwwTDdwWFBXWG1LSE9hazdwUE0vbEFQck1z?=
 =?utf-8?B?b0NJZCtxNlRCN1E0azF0YmJhOVpYRWcvRlFQS0d0aFU2YTJ0Y3JkOFZGQ2ho?=
 =?utf-8?B?aDZ3RU0yMWhsVlp3TjY3cE9ZQTVpaHRES1JQdis1TlpqVjBsWjE0d0dzbVFw?=
 =?utf-8?B?M1pEd2Q1Q2FqYkhIYzNkWUtzUm1yekVUSks4dlV3SlpRRVUzc0xWYmJvd0Fx?=
 =?utf-8?B?MHBEelJnWkZLS20zVEwyK0Q3dXVhSitBQ1JqczRua3Vmcm5JemlCQ3g2MmJi?=
 =?utf-8?B?bE92UEpnWlo3L2VmUzZ3RTU3NEJYa0NDdm9kN2F0Q1JrMGMyZU4wUDBUbXB6?=
 =?utf-8?B?RHZBcEpUOFhxdlRKOS9aUGlDN2hWbVNmRlNFbVR1YWdwUXlHbHBxallmWEI4?=
 =?utf-8?B?UXdJOXNWcTVxL2p1aHpoY1hxYzhZdFFuTW1tZjFzNlY4dTc1dXVNQUhubVNZ?=
 =?utf-8?B?UkxhWEVDdW9sd0RDMEk1Y1B3SDRCTVVsRXcwNk1NcTFpckFEeTRMeUpsdXQw?=
 =?utf-8?B?ZVdFemMwU1BmM3FuUWcxMUdqY2VnMVo3TUFKR0NBUmhpOWQ3WEZUcmFkUnVo?=
 =?utf-8?B?SHdHRjM3TXR0SEdqc0xiZHpTTDRyWFFVRm0yczB4SkZHU1RJNGZUbUNQWGtO?=
 =?utf-8?B?WWFjeExHQjFkaS9ReFJrUFgzaHhCSy81THJKbThFWVpyNndCTFd1dWdKblow?=
 =?utf-8?Q?5Kvk7NzCyd4JwO6O2PqtMLixguwKOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnRVSmk0Um82anNaWUNsWW93NGJUcWJpMDJrcFBsOE5sOXVaOVpRWTB4NjVD?=
 =?utf-8?B?c29kSEcwWXBXUkcxZ20vQTNQcHJOa3lkRXl4VnU2eG9VR1dMRWNJNGN2bFRT?=
 =?utf-8?B?QUVmTVJDRW1ucERUdXVjVXZKaWlpeU5xOE9WbmQ3VGwrOUU0aVJhbS9QQllJ?=
 =?utf-8?B?ZDVudmorVzF0SXNmZjBYYmtQbkx4K3NpcnFZazJvNS9kUDRPNUdBcU5XSmJ1?=
 =?utf-8?B?SnpNUXMwK3h0Sk4wN2R0THVjUWQraG93bGdERlZkWndQMitOLzQvM3lzVFIz?=
 =?utf-8?B?UjBXYzBtY3JqMnJkeS9SMENLU2pIdFRWM1dOUkExcUlPVDdoU3F3MXhORnRS?=
 =?utf-8?B?dTF1NmZMTTd1QmNUeWJiR1hIVlJoRWV2U1Faanl4WWRUandNUXRLR0pmSVhu?=
 =?utf-8?B?TUlNaS9UNllWQ2tpSENTZ3N5OUwybmJDVHhDOGhIRnVYM040S3lWODkrWlBK?=
 =?utf-8?B?Tktqa2R1TVRiK3F5YUJsY2ZjWEVXSmFJZDlPeExyRS9icHlVMDZteW82djdH?=
 =?utf-8?B?Ryt4bnBMdWZ4VVBsVFdEMEdpMW90bFJFY2J1M1BLRFRCYkZSU01LWEZqVWQ3?=
 =?utf-8?B?RHU4ODhSSVhLWVR1eWF4UW5ERHlLUW1SdVNhVE43TE4zSHJZeVJZdjhzRjFL?=
 =?utf-8?B?T1VTN1BTcS9JRVBTeXUyakVzbFRObTFYd0xCR2FpR0NXTW42MjZzUHpnTHNm?=
 =?utf-8?B?blRTTGtOVjJsNEhtNkhZa2cxTDgzc09TMFNaNEJsZU5USVFrV1VHSmtZWm4x?=
 =?utf-8?B?bFZld2xJS2xZajh5enhBd0w4eVNTYzkxWnVMc1V3dHlZbWpIa01oaHY1RTZ6?=
 =?utf-8?B?RTJObS9pN2d1ZlJic1RjN2hSQzRzdFU5cVlMR2FQVXJPM2E5ZFBTdnErUEx6?=
 =?utf-8?B?aVBwcWZqZ1d5VEEzN2dXZEFnQjZRR3F6TWtaY000NGF3dVRTZ1JRY1hYSSt1?=
 =?utf-8?B?ZUI4TWhwckdZOHo5akRpWVZsbWV4NXBhQWNVTzVOWlg1RVBRb1dkNDVsNHVs?=
 =?utf-8?B?QmdPcEVNU3NEczh6ODEwek9LRmVYU0pCUGZQQUJBYVpoY29kNkwzTEZ2VlN4?=
 =?utf-8?B?cVIwOHNKbFdZLzlJWlZ2RmRuZnVzSU5xdFlBWHlsVHBvMUsrYVJzZHZERS9s?=
 =?utf-8?B?My9wbDRYTFp0UFpHajlhQXdzeE9Rc0tSN2dCaUJvcm1PeTFVVU5aSjk1a0Qr?=
 =?utf-8?B?V0UxUnZMMVh5c2pvT0E4NmREVGE0ZUNoN1RyYWltZzNsQTRUQ0t0citCYy9Y?=
 =?utf-8?B?ODZPZ0dsWmRaUlNLVktaNTZjVmVzSi9VVmlYcUNRVE9sblpGNEx3a0U1bmFZ?=
 =?utf-8?B?bGFkWk1BZVFqT3lrYUtteHFhWlgzUmE3MEJqVlc1QTExWVI4VXFIVGlnUXgz?=
 =?utf-8?B?OEJpR3FPQkFGSGtMankwK0NvWTIzWkFGblAzd1VRS1dZUkFkTGhVWHhSZXRB?=
 =?utf-8?B?dWFLM3g4Y3VORUIzaGZ6YzZRLytlQW1kMkFSUGc2S09UYVU0RVRQZVJsR3hl?=
 =?utf-8?B?c2RFS2lNcTYrVnpjbUNPeDJTdWtYbytreHFuNDAyRld4aVhvMGp3eW5aZ0RF?=
 =?utf-8?B?bDlOdzFYZENtb3VjenF3UVRpSmNibUNnbVRDdHJ1Ri9qa3YvQzVLbnhqVHVS?=
 =?utf-8?B?NGUxYlRNNklRWGJPMm9JTUNteWhOeHNTR201N3dleC8zTDNLS2NvWnQ1UjVO?=
 =?utf-8?B?bnJjMFdxd2pGUGdDK1FXWFA4aGJTRm0rVU9DUDlHaDFjczhaWFJDQVBhd0Zn?=
 =?utf-8?B?dkVZbjhyMHo2NWNhR1JsNlpvV0RwV0NRZEg5U2h2RUhzbkt2OVBXQjVkQ1RG?=
 =?utf-8?B?NFFsUW1vSlhnMlJ2VmkzODZqZ1JOYzQrWVhrNk5wYnZ1RlNSZjkvR0VERjJC?=
 =?utf-8?B?VXZGeDk4M29XaEplRHBDcTRNUklLLzh6NVBjQnlPSWFheEZJbmhFTU4xUFpj?=
 =?utf-8?B?QVAwMjJFbG0vbFY0V1FoREFGU3BUNXNwTi96RmpMWStCb0o5MWQvSXhRZTN5?=
 =?utf-8?B?REd1aytmakYxdWRBb213c0o5RFhFQUwxbEp5ZW5hbVFpd01jT2Jyek9IQlYw?=
 =?utf-8?B?Vk5TZlNYSDZWYXhTZmNKSVFDWENWMFdxTUE1QncyN0VoWGdFOUtGbjk3TXlB?=
 =?utf-8?Q?pglansVHfLOXki95P7+udYETs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb9471-1410-49a8-0600-08de27842258
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:56:00.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odlPOE5QVJG2Hj3E8enMmBY3Z4M/CBbAl61gfJSpaH7eXIm1EuIlrFrAFgKyosLfjqimDTAuZXltBAMay8zxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106



On 11/18/2025 9:19 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
>> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
>> presence is used because it is required for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> CXL.cache and CXl.mem status.
>>
>> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
>> the parent downstream device. Once a device is created there is
>> possibilty the parent training or CXL state was updated as well. This
>> will make certain the correct parent CXL state is cached.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
>> ---
>>
>> Changes in v12->v13:
>> - Add Ben's "reviewed-by"
>>
>> Changes in v11->v12:
>> - Add review-by for Alejandro
>> - Add comment in set_pcie_cxl() explaining why updating parent status.
>>
>> Changes in v10->v11:
>> - Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
>>   downstream port by calling set_pcie_cxl(). (Dan)
>> - Retitle patch: 'Add' -> 'Introduce'
>> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
> [..]
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 0ce98e18b5a8..63124651f865 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>  		dev->is_thunderbolt = 1;
>>  }
>>  
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *parent;
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
>> +	if (dvsec) {
>> +		u16 cap;
>> +
>> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
>> +
>> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
>> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
>> +	}
>> +
>> +	if (!pci_is_pcie(dev) ||
>> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
>> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
>> +		return;
> Why are downstream ports excluded?
I thought we only need to check the upstream 'parent' if dev is an EP 
or USP as those are the only PCIe types in CXL that interface directly 
to the upstream dport device. And its the upstream dport device that must 
be checked to ensure it has the correct is_cxl setting. 

Do I need to update is_cxl for USP in the case of DSP-USP topology? 

Terry
>> +
>> +	/*
>> +	 * Update parent's CXL state because alternate protocol training
>> +	 * may have changed
>> +	 */
>> +	parent = pci_upstream_bridge(dev);
> This parent is a downstream port...


Terry


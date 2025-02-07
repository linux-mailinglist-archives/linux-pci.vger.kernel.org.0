Return-Path: <linux-pci+bounces-20937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA95A2CC77
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28F33AABC3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7119D072;
	Fri,  7 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4pV/I7eR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F018DB0E;
	Fri,  7 Feb 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956194; cv=fail; b=ZqFx+7rhQaZMgff6+T+q5FfMEnWMIdTjMtQfVNZH2ETirUpLLQUe/DWGRMgxlKXlfhkfpHpcxkbuzjpRld36FNDldFlKxW7NjZWQSBnE2jismGv+Ym2IDfAyNEUnwSNWlr0QvtFZn+Jx8pRf3qz08aESTI8dvTgx1yVDrmLxG+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956194; c=relaxed/simple;
	bh=XQwprlq63FMZOJk6A5qohAO9jqqXAcZ04X8MlKEuF6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XjXT2xFAXus4376GCEVOhXUxvw0UXln+eTozIro3DzR9IT6RlRYUH/Zugq7bOxg0+LVmg6xX/FwiKF+aVRGg2B8jcOdfeFZJl6uLYWFVPIHCnyZPGl6qZZxqx1voM3FbPFsCtoKZnir46JC2PvvcunwyhhrGjiwqfX/0kZG2TVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4pV/I7eR; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nar9Ch+FGvyeoINAnvIBqI3RwT6kzAiX00YnjmS+Pe21Bos1POFt/GfYzs7Fu0+Gkln6Y5WyNBRd/gZUU6MK9F0p53EwJswOrn1eW9Zny1fGVp9s4E6zTMUzp8qsRh43VDpDAeeZkbcg1vbAnCJ2XxcFu2shG76TBPEM9yiZ+FGvUSAzHLbq+UnbcZWMvBz+ie9ppP9RxoH0cDgekc4MZagtJpGruPr97exvaqr1TeWAjzP3c5TRhQ9LlfEhAM8oebm5Z5hrG7cQK3/oA9UWh4gOB9UwJYQCgYLlSHCxorZLL7rE7/OHyOFSHYQ68RFFbFJTyns/JZ9PKBoB3FeRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+EV6efjyEn6eEbRpupZyF2Ai0PdWevCvkYAp1sUoBM=;
 b=r+mhwEZsZpSE7ZNPCwS3MT4iyWOumhrar4VWf4ynE0jlswKewGUivjGp8dHjuBw4pDY7egfB/oJ5y8eZc9ljiwf+KTnrMJ6otx9LoIJEAiDaRd3pSsEvZWSBzVnmghZMKwv3KVpLJ5ZPVDfgsydNHAsOQNfEXeLv90pDB3NvWunBxVzBhPPSTFzrG9eWsVs8yt91MRI1nC/FZ2E9G/mWxGy+lJj4RsDMZtZDzLtqSz8Mvb0uG4evsULa3g2TUHNO9xFaB1bYAaOh+AhOlyIc/Lt3pFUIw9rftIg8mlX4FfrbZsajWtOEOk/OhVqLUuLc0ZTE7M03RWlEKouK2OLxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+EV6efjyEn6eEbRpupZyF2Ai0PdWevCvkYAp1sUoBM=;
 b=4pV/I7eRpCaK9i7Dd2EYzILUCDGY0hlfKjBjukiSMTB2T5DQXh+xO5cEX95LGrXxeOjtsQ3ih3HZh1vlR0/IeTQ75n+CWw5088T4fM+bpo7MsFK8ioxKDYJxC21UyddMmQkQ8I6JAtYVfUnu5mgDYH1M/0G5UgwIS9xcEaOxJ5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Fri, 7 Feb 2025 19:23:10 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 19:23:09 +0000
Message-ID: <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>
Date: Fri, 7 Feb 2025 13:23:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:806:127::33) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: dc62906a-7047-4fd1-bd41-08dd47acdb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2lvODY4UHRqSDQzdG14Ymhwdnhvc3VhMFFoczQ2MmVxMVU0SVMzcm52LzAx?=
 =?utf-8?B?TEx3NzdEZjRsbzZMWDJGWlBWNU5DVTg0S2ZWTVNIWGtWNGVEc2V5ek9MczZp?=
 =?utf-8?B?MTVtWDdFVUtrQnlMQk1qV1ovNms0Rmt0M1dmYk05ZG5OREtVK2xtcXZNTTh3?=
 =?utf-8?B?RzZBWlB1a3hNVHlFUm1vbktBaUVJV1BkM01xYWhiK1YyeHJEbWFGeTFqMUpJ?=
 =?utf-8?B?MHFBMGJtTHcwTDRueFRIMGFid29KQVluc25nOFQ2Sk9GcnNXYlZXekNmSzBo?=
 =?utf-8?B?NE1FZHdaNmRsbkhoVndrMnY2TFovYlUyMENMSGUyOFhQNUxRQWt0eFVtUUxp?=
 =?utf-8?B?R0crOXFqNU1qWXBlWDBUdURtY3dIUEJRTkFMOFhTNXErUXh0OWM4NTk2TlY4?=
 =?utf-8?B?U2pEZThFbGxJejd4VElzekFCbW44c1VNR3lTemFXS3lQQ0dldW02ditXWDgw?=
 =?utf-8?B?R2lFKzBpWGNBSWpqdGFSVDVoMy9keTU5S0tuV2YzRnlkd3F1NXJaMi9OQncy?=
 =?utf-8?B?SWpoaE9UeVo1NWdlQ1hYdjROWC9VRFl0UmxPanZGUU9lb0pkdWt2OTczaGVw?=
 =?utf-8?B?SmdnM1ZHZ29CekRBNllHalUxMExNb053a01haDMyVFE3VXFBYmtOZm0xVFZH?=
 =?utf-8?B?TlR6clVNMCs2bFF2Vktxa3VYcDBLTXRaWm15N3FYZE94QVpNK3ZyYzBIbzhp?=
 =?utf-8?B?RGs1aDZZdTBCcE9Gd2pMcVFnVEJoRldnMWxHeGsvOUtyN29jaUt6eDYrb3lo?=
 =?utf-8?B?b205RW96ek5heGdDalBUMzQ1WVUxbm1IZENMM1VJM3pqWk0vTzlEWG1WNU8v?=
 =?utf-8?B?Y3hEd2pXdnU2eUU4YVVwMVQzdW5lYlFHMERiUXc2MDFMVkI5bGdvdVNidnVF?=
 =?utf-8?B?cXZ2WU5KdEwwNFIybmxQbmZ2a1R5b0YwcE9ENzJWZ2g3ekQzUXVZMTlSTnlK?=
 =?utf-8?B?VklFcThGZEdERFJxalpwRG9xWHZ6Vnl4czV3R1N5YmI5ZmZhT2hIc1NEanNF?=
 =?utf-8?B?RDZ3STFTZFNmRUZNSS9DVzZGVVAzVk8zY1NiTnpSdU1pWWFMMmlUR1I1ZUlU?=
 =?utf-8?B?S3RVK1BCYThLRjM1VVRITmNKU0JBQlBCTnI0MmZrc0hCejVPQlR1bjFEZkRh?=
 =?utf-8?B?bEhKMFlORHY4enF4d0pTNWtkWkdIcXVTa0JuY1dYNkdndDBpdGNrNGJsSGlR?=
 =?utf-8?B?RHVDdW56VWp1RGd2Vy85UmhJRGpMaDFaWHV3T3lSYWZ1UnFyM0lSbTl0b3p2?=
 =?utf-8?B?WHlWMi9oOC9xa3c4OTI1VFk1eFpnSFJhSUhNNUpxaGEyZG04QXdSYW9rUW5l?=
 =?utf-8?B?WXRvc01wSGlTL3ZsUWxMZlVmbGcrdXB1UDZwT0lVQjUvMGxpckh2d1Q2WjV3?=
 =?utf-8?B?dTRKemRkQ24zNzB4Y0d0aVN6K3pVL085UjBtQkhYQThyU2IvdmFra0YwNTJQ?=
 =?utf-8?B?WGZtc3N5NkRORFZtYlZiTzd1cm1uVnNVVzZhMlRDc1NFaVZmQlhYVkl6MnNE?=
 =?utf-8?B?ZFFzQTIxanA2MG1FRGdvaUlYQm5sdEFObVl2RlZUVTcrWUUrd2FIZmFBL01q?=
 =?utf-8?B?UGo0bjRKK0xWdzVOTDRrOFZSODQyUy9Ga0pJcHRtV0pOMjBvRXRiL0EyNzJV?=
 =?utf-8?B?Q1JzQTJndzd4QkU4anZlN2pBWVZST3dpcndBYjIwOE40S0xncnNwbjgvSzV1?=
 =?utf-8?B?ell0MFVZaXVneTMzUjYxVVZxNVRMc2sxK0dsTk84bHpmMjhrRUlYWW1vakNS?=
 =?utf-8?B?RXk0dzB6bmJuOFlPQWU2M3kyK0tLaW1oM2ZZUkFjdTJZckpzanY2ME9qTlBR?=
 =?utf-8?B?dmJreWNPdS9ERDNZb3ZWazBMTCtnSGxCSDY4OUtyZXpnNFpVZzlMWnlydGg4?=
 =?utf-8?Q?E9ATm25N67eEj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RJU05hbm9IL2xZYXZiLzlTcFcvSnFoYkFvRWpLYis0czZkdDhlRDRla0hH?=
 =?utf-8?B?d2wxMXZFNEQwc05qaCtnRGtOMmhpOXVQcXpYSkhRdCsxRUtkV1pFVVdTOGxX?=
 =?utf-8?B?VHRxTnIrVWFJdFMvQTN3SFBOYnRYNnduUURveFFVelUzUWlMTkl0eHRTRzMy?=
 =?utf-8?B?dTZwL29hclVySkFpWFRWWXZPVG96NjByK2g5ZW5IQlVGbjhYdmkyazhEZmN2?=
 =?utf-8?B?STRmSkNrNElyaGlMQ2g2MlVRMFlCTHdoOU5BQk5xd1NSbXVtRjB3U0hYMEdy?=
 =?utf-8?B?YngvMXFWTk9FYWtBYnJIU3Qzd2czeWUxaG1McVJjVUpJak0yOUlXbjE1ZVp5?=
 =?utf-8?B?ZHNaUExtUjFSTnN3TW1JaElDOWt4NDFWdWNOaFlydi9TUG9BeUM1UUpLUFo4?=
 =?utf-8?B?NlRuYTZyZFVhYTJzbmx4Tzh5V1k0aUp3TGxOMnh1RnFiVkdhcVRIdzUwM1oz?=
 =?utf-8?B?T1pFTVlIT0FGZStWTndlM3RRWSszLzU1V2E4b0tEcDdkazR0ZlRUQmZESUlu?=
 =?utf-8?B?ZFB5UWIrU3A3V24rYUdxOWoxUllPV1ZEeEJjLzBKcWpla2gzZm1Ld3F3TGRO?=
 =?utf-8?B?SHp0cnptVDRrVzJQZEpKZjRaa3JQK3NwY1NoYWFpdTlLM2xoeUljMGFRbGNQ?=
 =?utf-8?B?eGlLejNiN3FnODFoYSs0RHpFMGZScDVEYWpYeThiSVlKaFJoQ1lFWGNWWGhr?=
 =?utf-8?B?NWs1cVhhbVVzRnFuWUoycmVscm5ackhkZ2YrL3d2RmZXUVB4NmpxTnlUVFdJ?=
 =?utf-8?B?bUZ5WGJqNm9rU3hLdHYyWjRCZzdLM1NmOTQ1OFcwRnh0S0Q2VE1BaUNyNmpp?=
 =?utf-8?B?d3JMeTZHSDhYbUZnL3cwU05IYURYSU10dzVWOU4xSkM1T1JteHdYVFovSlR0?=
 =?utf-8?B?MWx3VFQ3QUhuU0Y0S2hObE1ET3ZHZkZiOVhSK015T3ZzOVN2MENqZW0xZUVE?=
 =?utf-8?B?aTIzWTNPSy81OXFhdXlmWkd1V29HOXVDUUVhUDVBaVkramtEREFFd2NVYWpY?=
 =?utf-8?B?OE1ndWZBdmdRTElBbWxPUWplQS9HQ3Q0RTRJYTd3NDJyR0RNU0ZyTElyaTRB?=
 =?utf-8?B?RkU3N1dsQ0g1YVRvVFd6OW1vdWp2dVBMZXVnbWJGMnpFRlVoakRHWFBFUm42?=
 =?utf-8?B?ckl1bGNtMkVmWUpOa1A3YzRkYkVQdGdRUlhUUkhkcnNJTEFHNW0xV0EvNXhI?=
 =?utf-8?B?QXZmSFg4NVZJbTFlVzd1THZSVkdXRHR5TUNEVFVZWG9DQk1mZnZNSTIwaFRq?=
 =?utf-8?B?dnpmTHdBY1pmK20rb3JLU1czU3dRZlE3RWQ4SWRNajdxdG4wTjhyV25icFJk?=
 =?utf-8?B?Z2RVbGFhRXlKNzFRcGJQOXJlSjFHbGdFV2RBWlN3K2xXajJBSDdqdlJiTHVV?=
 =?utf-8?B?dE5Oc3NjQnNSU1l2QlA1UTJFa2UzaGdTdmpOK1cvaFhRMkxlR2JVb2E0dlp4?=
 =?utf-8?B?NzQvNGVKOUdlbXVOUHdyNDNNL2hjZTZLMnZjc1BFcHkxTXZ3dlVlN2puczYy?=
 =?utf-8?B?dXdFcjJoclc0YklUVm9Ld0Y2NzkvWlY3SlpEa1p6MGU5VGxVNEw1SXgyTzdY?=
 =?utf-8?B?eGhMd1NxRmZtVHBxdm9iS2wxamtsMVpZYmY2YjVQclVsTDZwbm9JV0dHNnVm?=
 =?utf-8?B?R1dCZVBRb0pMUUVWM2NsL0RnN2l5ZWhoaG93R3IxQTlVTmF4K3AxdTJxOUJL?=
 =?utf-8?B?K1BiWGh4cmdybUt1SndRTnc0bnducDFIdEdZUHlnUnlaN1A1cHp4MWRWVytU?=
 =?utf-8?B?Q3lrZmNrb2tmS1FUME05bGpxMmJ0azVGaG9IMXkyZ2J1MEw5S1UraXU4V1BY?=
 =?utf-8?B?UktIbDBuTHFtUStHMW5ITDZ5Nnc5SnkwQnJlZWNuQ0pjVUVKVzhBTzdzWkRG?=
 =?utf-8?B?anJCdklzaHZqOHR5UUNDaWhWcCtZYVUvOVFqQVlwZ3JwcjlDVG51QXA1UFA4?=
 =?utf-8?B?MWpUMnlRaGM0SUE0aE9uWjUrY3p1a0t1WEFDMk8raW9BK1psMDFJVmtUeHhT?=
 =?utf-8?B?RHlnWEtaZ0pqN1UvNUZCbHFCMzRHSStiYlpRdXFjRGpsVHFwOHZiaGNPelVG?=
 =?utf-8?B?OWVLdXJIdThZaTlvTmVNL3JVRW5oWUtvYnMzM2tTSS9NVGtGOE5jNFJ3bzlK?=
 =?utf-8?Q?AQFdPG1uxrTARXskaxIFer1hF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc62906a-7047-4fd1-bd41-08dd47acdb5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:23:09.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFJI4XVPdlQmpiZTNGN1jpGWXxY8H3TcYsiAsoYoh2Kza0M9ggNngKnHFa6U4HqTEn+6/we8romCdj3rNE8zWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308



On 2/7/2025 2:01 AM, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +		void __iomem *ras_base;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
>> +		ras_base = dport ? dport->regs.ras : NULL;
> I'm fairly certain dport can come back here uninitialized, you
> probably want to put this inside the `if (port)` block and 
> pre-initialize dport to NULL.
Right, it can. NULL dport check here covers this, no?:

		ras_base = dport ? dport->regs.ras : NULL;

Terry

>> +		if (port)
>> +			put_device(&port->dev);
>> +		return ras_base;
> You can probably even simplify this down to something like
>
> 		struct_cxl_dport *dport = NULL;
>
> 		port = find_cxl_port(&pdev->dev, &dport);
> 		if (port)
> 			put_device(&port->dev);
>
> 		return dport ? dport->regs.ras : NULL;
>
>
> ~Gregory



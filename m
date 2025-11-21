Return-Path: <linux-pci+bounces-41870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8FC7A620
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF054383B29
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671582BF3C5;
	Fri, 21 Nov 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivulif4E"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBE2C1780;
	Fri, 21 Nov 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736973; cv=fail; b=Q4XHuJRBbAvk+LMwyNW7e+E85Sz+QlOOOFt3FfId3Se25rXZjiQTkugIboNe8zKjnavQQzqtHq6q8yZkasm8MYW449wVGVp/mDuXsYFkcTZTqLsNKD6kqXYcLzwxquWTcFZ/E6AJl3WnxqD9l5naKs7UjhbSOc1vMYQNGbLfNQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736973; c=relaxed/simple;
	bh=2PH6QBrHMA53hWqysoK7sDdp2gEYjZjDJYHi2koCvR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbMt28auUKNwaTQkDzOxUNNueTE7SBOr20/OWWGGxv8iJU4FzSGrYvPX7TT/2aDcX6pEQ4nGBNUUpJVIKzZznXSDxh3V0jzJTNfuW+JT4Dto6E6UMVFAMnb0YEtA7fteWL/UJSI0THSs7QIugVW4Zy1L+UzzlM/gJmhi9aB2VT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivulif4E; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIt2dgUsm4MPCnkkneWeAD/EYlvNoYqmj88KiktE3RCxBzohSB3IX60K0/V4spG9Pn4n75zHTS2sifG6dVyAg602gFabZN272us9eSeNYmRyGr+ZF/Vowo100Gpz+WaiTun3HSKVrFmhiJKA3FaJ9oLfXAVVtFXym+YdKF9lOUjj/GbPHAM+2zOUn1sWkx5240hDCLkttfD1FFJfEkXwO6bvn/I20YIPPbF1+LOrOcitqJG38ojuTkBVHL3izu+78bhT4Bq+dZ3o8jMp49UAnc7pP7aYyz8pAzaeawAGoRXxl3BY61HvJco4vqmQeClnYnkSktcoQYFcLdQ8+t44Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpCVNTt16aTYuRfEM+yawodilbO+n4a/UNq7EjMk2ho=;
 b=gduNPnvcvX5nsYZTndJ7Yj/AYupmBBY5c2TvclxE/HXHLikzpmRG2npJQc6vgihnZpt4YAAUjMwze5je3f8sFfrwI8+uxJEjQIqDxOwH6ZYkBsUUxz+w9kS5V6UrEO5UqYQIXvbQeBXzbYbtzhFK1pNV6TC8TVKNp67Cpk9kcfEwQlo231vfum8BUwAtUSftnoNU3vVeM+RDI5Ml+9KS1Iig4qAygYBJG00kFsGGWWRNS+t8EJiNnNVgyXSKTXhaOmeVHI2In8VQNmeuIHXrUVrdQBMpajfyfdaeCCXlRR4NbEsMzPxuy3590ysqyfOkBvtU8JTBMBWo2CI8Rs8E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpCVNTt16aTYuRfEM+yawodilbO+n4a/UNq7EjMk2ho=;
 b=ivulif4E5CZikzJA84Y6TewHzDMEPzUqUSxJuJNLvwJY01/nQjwZso26GzgJd39AbPGOE8/2mt4ZjgSYR1EQugEuqqtCRHES6aAT6XrjPV/IzLgmn5D9eSPFTpGXd9fKlOFbJTvLH9sAYtKuY9qKPW4iBv5rpTJpofY33SuQH/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 14:56:07 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 14:56:06 +0000
Message-ID: <c5adb070-a45d-43e2-8d9c-515f5cefe6aa@amd.com>
Date: Fri, 21 Nov 2025 08:56:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 12/25] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
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
 <20251104170305.4163840-13-terry.bowman@amd.com>
 <691e3542c1b2a_1a37510046@dwillia2-mobl4.notmuch>
 <b104b695-a966-43e1-b4fa-1c8cce6d65e7@amd.com>
 <691e5559eb0c7_1aaf4100c3@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <691e5559eb0c7_1aaf4100c3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 51efe83d-7bc2-4623-3a8d-08de290e1943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2NKemFXSTh4TWtwQjJIM1VtMlFNZEQ1YkR0enFNRllWMkRMK1k3aDBTa3Er?=
 =?utf-8?B?N2hBMlhCL3J5Q2tvNWtUWVhEZi9rdnpnRHpiempkdjJ6dEhEVGc4TE53Rng5?=
 =?utf-8?B?bzVGUEtnbVFOUlRlMlQ0dHdvTWpKUUNSV2dpTkRpWjEwSUhqNHYzK3ByUXRN?=
 =?utf-8?B?VWVDbXovQVFXWG9Cb2xjalJJY0JFbGFtNC9RaXk3aU9EeGRsR0J3aG1qam10?=
 =?utf-8?B?QWRJcjFRZDF1M0VzQUxnN0xPN1dGTlMrMU1XTE5qUlhld0RCOVlmeEw3MWVB?=
 =?utf-8?B?RUdrMG1kQkc5ZlJFNG01U0RGcnRibURLZTR4LytKcEdTUHladXVhM0oySUI5?=
 =?utf-8?B?aWY2aGZiY25zK0d6S0w0Z1dQb0hVTC9rMHdvSG1WTENWcEYyZFo0VElQNmJa?=
 =?utf-8?B?TGpCaEgxZVhrSXJZeU1FSlI4NURPdVdUcGF6dk9DUGxvWklPei8zS3RkY0Fm?=
 =?utf-8?B?SHFIUFdlS1BHd29EakF3OURST1VJQUFubHgzRUZ5ZEh0bC85L29JU3RaVEY5?=
 =?utf-8?B?MXlQa1ZzTC8wUHRmeGpYS3Y2bitZVGMyUDdQTVc1ajB4VkFJc3YzSkVtamlG?=
 =?utf-8?B?a0hpOGFMNXViUDVucEY2UVh0MmlZVDU5K1dzRUYxNVQyS1BKSXlWc2pJKzZs?=
 =?utf-8?B?aGRkbHFIT1lYYTluUzRuZ09YQ0UwWEgvYk9vSi9IQlFGay9EZnpGaEVCaklU?=
 =?utf-8?B?emVqdFpFVHVmbEgwRkF4RG5EYnlIeTBub2FYMHJsUStsRmxpc1FxMkNyTDd0?=
 =?utf-8?B?WnNHU1pHVllNTzdZcHJZNGZpeUtZMi8xMGkvdVJobnAwTnN6MXJWM2ZPWldQ?=
 =?utf-8?B?a1NGNThvdkFlcFZaT3Z5UlJLYkZtY1BEcjZ0MTQycTJLTlZwRWJ2cXFmMXNQ?=
 =?utf-8?B?TVFlcjk1aGtxZ213ZCtMbHQ5ZTR3Ym9EYVlTMkJ0N0pCVGpVcmZOK2dEejA0?=
 =?utf-8?B?Z0lqUzFwa0FqSTN6Vk9nK3NMTWJ5Tkh6VmY2NmRlZzA2bDI3T005VE1kNm5h?=
 =?utf-8?B?YjlKN0Y5d2tzS2FkL2lNeVpVeGZzbFdYQnhieVEvV1JsQ1V3aEtqM2NITVZX?=
 =?utf-8?B?N1FLRFcvQzVObnJsbkQ0WDgwQytLMHdjRFBPMWRJc1BXRFE3aXg0WnZnd3Ay?=
 =?utf-8?B?NzErelVYdkU2YVJLT0lKajk4V0FFY0d2cTVxcGRXcXFMcXI1N000QUdORjFx?=
 =?utf-8?B?WFl5S1ErejNQSGtRNGdHZWtnakVEOG92WlRmOXB2U084VjBYN3liUjVSeVVj?=
 =?utf-8?B?aDJRT1I1WlVyWTNiZ2lsUi9CK3JNRWd5R1NVZGdJRlJ4RDJ4UE04dzZla1dE?=
 =?utf-8?B?cmp0ZVBQQ0dCQTFjMkxpd1BSWThycTU1ek0rWUc4YWNxUzYvSEtNZTdRcVF2?=
 =?utf-8?B?WU5uaEVLbFZHZFN1cHVuckJab3NMTGx5aHNER3dQdUpzTEJkRG9DdUJDOFNJ?=
 =?utf-8?B?c1FjWk1qdWlSVHBDYTVwZ3pua2xZMnprVW5WSm1pOFpTMW5yYXZqKzJGeVpE?=
 =?utf-8?B?ckd5T1dKMnR2RDN6QTVTSDZvVjhsU3lWamNGN1ZKZkFaRmJZeU56TWFQS1g4?=
 =?utf-8?B?d0NzYS9JcEpPeHBYb0hPRWpxMEVSMjEwRFJHcDBWZlUwaFFHd3dSSU1VOXFo?=
 =?utf-8?B?VnRCOGlCYkJLb1Z0dGxMaHFvWnFmcFJTcHhNN1l0OWZ0YktRa3pTRndLby9D?=
 =?utf-8?B?ZmxPUEQ5MmN4RmQ1MHAvcFhjWFowY2paczQ4dVY3MFZHKzN6NW43VXBtV2xL?=
 =?utf-8?B?OE1ZaGVtOERkOVdLSXg2SDZwWnRQbURqVUdUdmtiUitlRHdhZ2JIK2lFa3Vv?=
 =?utf-8?B?TG12UFozRHdtVHdzajk5dEg2aExBU2ozMk4ydzJTYytQUGIybGJqS0tLWGJu?=
 =?utf-8?B?Wlk1QUpOTFFYSjhPQmtsNmlDOUR6OUMxTkVvczBIY2ROS09tWHk3RXBKMEM2?=
 =?utf-8?Q?BshQtKLFRHShow1ssJg1OIhsBAhBrhEX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzAwS2w2dit6OVhacC8yVHd0OGczb1c4VjhkdXdQMy9yQjJPZ3ZJV0o0cHhZ?=
 =?utf-8?B?eUVyNHdiUDVlMkYvZi9kb1V5dk1DNTBYeDBvSHpYd1A0c04zcGl1dklKZlor?=
 =?utf-8?B?K3EyNHFCNUFDaU03NWlmNWtITDU4NmFiMVd0dFlkTU1zbHpFWXJnYUh5b01w?=
 =?utf-8?B?WE5rUHdkL2lraXpndmZLRXlSMGRKOUI4L3JSc0JDakIyRTdGc0NqSnF0MXUr?=
 =?utf-8?B?Z1hSMnlnbVR3RmVLcDNzWmlTV0RBZ1oyTGVIUzhTakl6ZkpKSWFSYXBpNnd6?=
 =?utf-8?B?dDl5NWdmUlhRakNVMWpqNGNobkJKbjdnSHZ1b1k2cEZRL2hNSWdocVpPREFt?=
 =?utf-8?B?ZmpRa3dxV2FqYW9DNDNTeFQ3eUU1SjJUdEZUV2I5cVNscXlEMm9janFUSzFj?=
 =?utf-8?B?NVMwMUh5eTJzamEza0R0Wi9vMHBpazVVVFZQc0RYd1BDNjluTkdCNUlDd1BQ?=
 =?utf-8?B?TkUwYWVhRXVUdXdxWmo5alNXOXRMdHRyUTdLaFhCVmJWV3Q5a3NoRWZYNCsz?=
 =?utf-8?B?VHRObjB1N1lXTDBuWWgzQ3krOFA4UnI2bDU3TG1pZjFSMTkxbXJjUlZCNXFI?=
 =?utf-8?B?Q0tGMXVxaDhxOVFBMVVpN0V0djdETEd5WWF0WFhsMklYVDcxRXZRVytVYlE3?=
 =?utf-8?B?d2U4ZSszK2JybWl5ZVc1SEVIK01NMDVBTUVoY3dlOHhIZHI3ZmFyY3RlTTdN?=
 =?utf-8?B?ZjRVZnpRc3N4QTdJVi8wdUFzSjhQZENGaDRUNk1OeEFnVnFYdnRzWmpZNndW?=
 =?utf-8?B?cms5TUd1M215L21UdExTVGFnUkxDWWVBbzVtTFZlUktxb2cwbXFrUkJjY2FY?=
 =?utf-8?B?dy9wMHNMWis2MVZFRU93UWd4aXFxYnUwUHBnN2hXdUdhT2NOdEYvZi9xaTZx?=
 =?utf-8?B?akY2Z1pSMUZzWGVjM0dNVXpVR1RlblRmcTVZK3FlbkxCUlZkQit0WnAvRW5G?=
 =?utf-8?B?STNRRG9wS3RUdUVGaU41N2pjdS9seUZSazgyMytMdkxVSXhGSzB3SHJHZTJU?=
 =?utf-8?B?UHhzWVdJdytIeC91SFNxRkhlN1lydWFBY21nQW50cmZOajJCSGR1ZGFRVjgz?=
 =?utf-8?B?dFZUSGNiSVVJZUp6Y2dkSzRETUJ4QWo2UENPSG5sdmliRERZNG52KzM4eS9D?=
 =?utf-8?B?S2MwSk4yTStFL2tDREZkaW1OUnVLWWlrbFZQa1pQbWZSdWZGQ1MrZ1VmKzk3?=
 =?utf-8?B?RTJNc2R1OC9pR2NYZE9BaEl4Yk90T0R5REZqSEZLa0dBUGFnVllWVDRjMVNZ?=
 =?utf-8?B?azFSbTgzdU9Nc1ozUVdsajNCcFY0YzRNbnB0VFAvN1R0VFJ6aXkybEFlYXdZ?=
 =?utf-8?B?Y25yYUVaRnBNVERucVFTYUlmZCs4bENPRUV3NGhIR3JMaE9hQmthTllYT1Bt?=
 =?utf-8?B?YXQrV25zNHdBR3Yvc3YxdFFZVU4rV011OUROYS9Db3hja09uMENaZ2oxSXJj?=
 =?utf-8?B?N2s0OS8vU0RiZkdvdUNqZG9BUlZSME41cVNuVlVvZDQ4S1VCU0UxTnh4U1lG?=
 =?utf-8?B?L2NpKzZISVU2WGNramM5QWNaZ2F6K01vQXJDbk9aOXZkREJCT0VBdDlNTGJp?=
 =?utf-8?B?cHJWRm5SejVPYzhLaWMxditNYzFhZFZML1E1WTQ5cGgvTHQzNm4rdW1DSDRO?=
 =?utf-8?B?Z2NnMi9kNEJlSzFQbEdFdEZ5REdlRWpOR0EvUFJjc0JiZ002Nkx3QlRnZThC?=
 =?utf-8?B?NFhHdlN1dGI0L05BVlJERlhUVXN0eTBNU0c0T21wZmtVMmhSR05wNnpMdDlw?=
 =?utf-8?B?aFdRVWdCeVBlOC9pOE1OMTZOTHpTeG1na0UyVGQwUnE5MG1DS2lKQnhWVGpN?=
 =?utf-8?B?bFdMRFMwUEI4Znk3aDZYM1A0a3hGS0lwUklJR0pYd2JEaVJ0WUtJdFo0bnVn?=
 =?utf-8?B?N1NRdldBMUMzWkxqbUkyV254NUZ3VzBQNlluNFRYTXNod01CRDV2NVpub1E0?=
 =?utf-8?B?dUlhQ0tXWUtqaCtiQU1WSXB3aU5iaXhydmVrNmZLVEJxbjUxK2FpTy9KZmZw?=
 =?utf-8?B?S0FDRmxtUVcvVXFjQkdVdldCWU9BbXNIcWJ0bkJYbk9nZkFBc2FWZnhWQkxh?=
 =?utf-8?B?ck9veGg3YXArVER2VjNCWVRtY0JyR2JvQXVraW1uV0IyWFZjcmkreGpsQVBk?=
 =?utf-8?Q?vkl6v9tE1mQ4xWQpoK8FvjiPI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51efe83d-7bc2-4623-3a8d-08de290e1943
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 14:56:06.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NtJ5Y4ZaqCDRuMM2FatLHtWegeYYjkTMhgBncH8WY/2VYZ/WWphA3ifdvKO/8qmqBxUwLiVzAbY0niuX2YwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734



On 11/19/2025 5:40 PM, dan.j.williams@intel.com wrote:
> Bowman, Terry wrote:
>>
>> On 11/19/2025 3:23 PM, dan.j.williams@intel.com wrote:
>>> Terry Bowman wrote:
>>>> CXL currently has separate trace routines for CXL Port errors and CXL
>>>> Endpoint errors. This is inconvenient for the user because they must enable
>>>> 2 sets of trace routines. Make updates to the trace logging such that a
>>>> single trace routine logs both CXL Endpoint and CXL Port protocol errors.
>>> No, this is not inconvient, this is required for compatible evolution of
>>> tracepoints. The change in this patch breaks compatibility as it
>>> violates the expectation the type and order of TP_ARGS does not change
>>> from one kernel to next.
>>>
>>>> Keep the trace log fields 'memdev' and 'host'. While these are not accurate
>>>> for non-Endpoints the fields will remain as-is to prevent breaking
>>>> userspace RAS trace consumers.
>>>>
>>>> Add serial number parameter to the trace logging. This is used for EPs
>>>> and 0 is provided for CXL port devices without a serial number.
>>>>
>>>> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
>>>> unchanged with respect to member data types and order.
>>>>
>>>> Below is output of correctable and uncorrectable protocol error logging.
>>>> CXL Root Port and CXL Endpoint examples are included below.
>>>>
>>>> Root Port:
>>>> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
>>>> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>>> A root port is not a "memdev", another awkward side effect of trying to
>>> combine 2 trace points with different use cases.
>>>
>>> So a NAK from me for this change (unless there is an strong reason for
>>> Linux to inflict the compat breakage), please keep the separate
>>> tracepoints they are for distinctly different use cases. A memdev
>>> protocol error is contained to that memdev, a port protocol error
>>> implicates every CXL.cachemem descendant of that port.
>> I misunderstood this comment from previous code review:
>> https://lore.kernel.org/linux-cxl/67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch/#t
> No, you did not misunderstand, I just did not realize at the time I was
> asking for compatibility breakage with that suggestion. Apologies for
> that thrash.
>
>> Are you OK with the following format for Port devices? Or let me know what format is needed.
>> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
>> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
> That looks good to me.
>
> Also, I realize this patch set has gone through many revisions. We
> really need to get at least some of these pre-req patches into a topic
> branch so they do not need to keep being sent out in this large series.


Do we want a serial number field in the port log (missing above)? CXL USP and DSP will have serial 
from the Identify Command. It would make the port logs look like:

cxl_port_aer_correctable_error: device=port1 parent=root0 serial=0 status='Received Error From Physical Layer'
cxl_port_aer_uncorrectable_error: device=port1 parent=root0 serial=0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte 

-Terry



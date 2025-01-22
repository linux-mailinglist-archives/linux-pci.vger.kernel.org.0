Return-Path: <linux-pci+bounces-20236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22274A19081
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506AA1885127
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E42101AD;
	Wed, 22 Jan 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h3Lhdic1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F28136A;
	Wed, 22 Jan 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544735; cv=fail; b=I5IzQmqMhpnb93DtYbL4usHT84UWUux07s1EPGzVpvka0xP61Vx7J0ts9rwibOr7L3dGPzz7idU8DcCV3L+zLCppOZBsNRz7le+NxwNL9QMD6//a3n3A8iDByfcJ/WnKG3YYXaOMeZ4z9zzmYy6Q5EIhE5FSiX6Q+QGy1VVC5C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544735; c=relaxed/simple;
	bh=zxHLir0Tv4IX5WB0H5PDoCmeJQuZF3aLugX3/r6VTRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i1tVN0RSVbqxLPGmbVAbcwGEhDjQGKMl/J7itOwqoqNl9STcA3t0E008CsqBFC0ZBE88gTyRV2K1CiyPWFsJihLs91t1/FTQJ67dAt9urXhvpNYsDsaZwgCmjdSV9jHVICx38cFARgARLF4p1NFztwRmiZMzluMRlgAdWRAwpd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h3Lhdic1; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzATEhYF4HYHMuDdIb8VfUvARn4qsWlfinudYqjcx2ToOO1RUh5NL2DF0ZPH9eHnPTTPWl7pGQl6XjVnj4VMOLGhna7lWu774VoONo/0+8j24X+6sGD2kfkp3csv+XCtvbu8vulK7OykS4KA4UJfKlNqTGi+iPGa4YTUXzmEHrtWaSiFFvKPLtfQ0yp+DQl+MVKeuQ7ATlmkz9BL5JprWnUwcgi4/yzDYECWHE698ONOSkFxj9ybc6YBDXS7iRQPfNZs3TFmwHevdYdo5D4zmEgGiPLfHO9PJjHVQSHqsq+TjJ3toVW2JctIvnSlX5HlMFUCBB2ZR8eALILkg2OXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl8pTNSUt1rFPj6xWoKzAuH+TCYbkgEiKPDnuaNlCO4=;
 b=S2BeGFbXNDS9inGrd8pjRMOVdyolCO6/1cNNRdEZshy2N5pW9JSdUH5qfJKyeQJ2u2Gj/PtAkVcmZUHnDox6KNqXPSri82dJI/P5o4nPJ53n9JVzo9Fgndij3TI5BInlO2u/yP2xQKcxp8t5x8TH4n7QSuoi0GkROogWPqDRNyNzMI0+tsK9HZRJr+XZnN65ZOrx1cHEyR08tBecv1tbudKRr+BKYaqd74yM+kg3TzIJsrxIv++aKst6AieZh7bGNyo8crUlDtr2DOvvjA81LAMnsqV37/lPd5uSci1Z2n7IDvt+5yg4SyXhfVrW21X0PG8rju4pz1CDAF+HwhJ6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl8pTNSUt1rFPj6xWoKzAuH+TCYbkgEiKPDnuaNlCO4=;
 b=h3Lhdic1PjhEglWWxbHIRv0NrLc99kfJ8zIhV2nUVZxCsfknTWEqrOdArn6mb48qhmhqCMngAGgGb/aU7UGSDhkKNADP9+KVABJBPz1vzWDc4lU5LmTAFNKnVKVfChqJq2rQun/Pqgs1Wp+HM6yEogHXL/wQmoN9vnJV5BOsRKIuYFflqQ42WBU5n9c5ExGutk2E3GNzdghTT0V4AmcO4xf0cc7tSb9fwMKfUvteaIlsrs4fQOhh5UTRfXKtqaqj8mLNNbX7dvAOFq66wYpYuxWLehPwKCDgziXLrAWlJ6yi+Cfg/ViAF+sLBx7/+v2MIY7nty2gFPlFk57Mlh/nhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 11:18:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 11:18:50 +0000
Message-ID: <72aa3800-320c-494b-ae46-b4f2ebf71e92@nvidia.com>
Date: Wed, 22 Jan 2025 11:18:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
To: Arnd Bergmann <arnd@arndb.de>, Niklas Cassel <cassel@kernel.org>
Cc: Hans Zhang <18255117159@163.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com> <Z5DDZnRX3H7RZR5S@ryzen>
 <a5a6677f-f2dd-4ff6-ab46-3a28f1d1487c@app.fastmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <a5a6677f-f2dd-4ff6-ab46-3a28f1d1487c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0490.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd98fe9-8dd7-4cbb-af68-08dd3ad68bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZPYksrK0ZueFJKQTZJbUUwMzM2d2R0NUFkbEx0dkNxMGxhQWdLSlZUa2p6?=
 =?utf-8?B?Z1ZSVTR5cFRXK2RNNnEwYjZ5eE56M3Z2MnQ5enlSdVpEOXdubmpWbTF1eldl?=
 =?utf-8?B?c1c4b3R0dDBXc0M1SkpnVWRaazFaVE5Wa2h2TDFPdVE3WjM0WmxVZ2RFZzdi?=
 =?utf-8?B?bVRjYVhZMU85S1hWOElqUnNaa1ZKVWlOdGxyU1ZPZ2VUckV3OEV1SEhIeEVk?=
 =?utf-8?B?Rm5YRm9PU0dKWi9ndWZ2Y1cwMzc2YUp2aGdwMmRsdGkxSVpXS1J6a2Z0aTI0?=
 =?utf-8?B?V04yMHg2a1F2aVAxL2ZhSS9pQytoakN2emc5NzZ5Zm10bmtLOE5ocDN0YlRW?=
 =?utf-8?B?cDg5Qi9JTWlCUFVybXB4NW84QjJHK1grT21vejB6cVEwZS9HWWNhTUVxTHNP?=
 =?utf-8?B?Q29Qc293SEFPMXNEOXFXQndZY0JxL3owN004dHJFcjIvVG1yUHR1aDZ0MkRO?=
 =?utf-8?B?aDB1WjF5b01aQmpVL1JCR3l0NWp5MDVQRVFwdjlSNitpYTBYM2o0TlFQcGlJ?=
 =?utf-8?B?QW1TTkYxVHltcnZFYXhqME9MdndwcmI1VHdYdU5XSk4yeEdqYUx0OUFvSHgz?=
 =?utf-8?B?Y3BkeEt1M2RRUTF6R09Kci85TDg1b2xUOHdMNGZwNlhNMTFGbTBxY2VnZVlq?=
 =?utf-8?B?engxT0lTai9BU0ZCUjRIY2phY2t1VzhZcXJneHlaOVMvTUVNbmY1RFpmbG1k?=
 =?utf-8?B?clk3QXgyN3FjTGdzQU1ReWlEUkNGSVdWak9oWW9SemFLMFN5TVpycStla3Fr?=
 =?utf-8?B?M1dSbXRsTHZwc0piR0wwZXNRZ1QzSEQyWDhMcVZ6RDlZMEtJeFhDSDhoYWdJ?=
 =?utf-8?B?QUI2SDRoVy9PMzBUVDdsZUQyWjNhNStkQXBwWG5oRVRwdlFwQnJKUStTVTJF?=
 =?utf-8?B?T2dHNGJKWVk4Vm1mYmlBZUNXKy8zNWhYNldaMFRrYmJQWk5qbmRRZWVKM2dZ?=
 =?utf-8?B?SFZseUQwN1ZKUU5KaFVJM1N4REhhY3VvNlBxVFN5ZGpRc0Y2K1FTTkI0aFI2?=
 =?utf-8?B?NW9BeFV0VElsczI3RHFQMEkwY3Zoekh5dkkvNllqVlcyUlE5RmRKZVJXeHFw?=
 =?utf-8?B?a0tIbG9wTlg5b0ovaTRrakt3N3B3L0FLZTVlak9Cb1RDaFNSbEVZT3NkSFM2?=
 =?utf-8?B?OUZSZlp5U2Rvc1ZNZGR1SXorckl2ME5nWDZZMFhOdUhnUGc2SVdDRjNXUnk4?=
 =?utf-8?B?blVUblJZUmh1NGVTcm9YRmpxN3RSZ1hmaHBUVnJEaE5OaVh5RWRNMzM3STBN?=
 =?utf-8?B?R3R0ZU1LblhFbHZxSHlYZEZOSmUzSW0zQmlUTGZaVTltVWRieXB4SXg2Q1Vq?=
 =?utf-8?B?ZGkxcDFpSHJ3NlN3TmtGL0xSN095Lzd1cHZmSmJFOUFhekJDT0dnZGVBekZV?=
 =?utf-8?B?em1iOE0wUFYvL04yM010SGlmSGJNckVOTWI4c3h5bjhpY08yQVIwMER2bDF1?=
 =?utf-8?B?NzF0ck9WRklEWGtldjJiemZob2poakJJL2pTMjhyRWR4K0xVUU1yUGF6VGJI?=
 =?utf-8?B?bWdWQUtFZGI0S1Y4VmZVQ0ZrSXh6L3dhNW13aVUvbFl6bWx6OUEweG5ZOGlP?=
 =?utf-8?B?dXBzTkZzUkMwb3Bqd2U4aHJCL01reGJOVVlYNkhkeDh5Yy9SUXZ2QVJQTUlG?=
 =?utf-8?B?VlozODJ2U2JaalJJU2hWYm5zTk83NGFZa0IzclY1RXJmTTFJazkydnQ0aWVR?=
 =?utf-8?B?Y0xnNEkvM21PNUVmVjhkcXhMTm9UZGFOV21WbjNVOTFlN1pvejN1clBOSTYx?=
 =?utf-8?B?RXhFYStlTERUc2dhQnNjWEhlaFlvbUhpaUNuZGhYVklRMTM4WkJQUEd2NHht?=
 =?utf-8?B?UUFYdlpVb3FLT0pZVXZPMzRxeEdkYUV5Y1JveGY3eUdqU0FvTEhsSGxCek9B?=
 =?utf-8?Q?Srn/gXmp6Nzwd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0h4aHBIZzJSdHh0RE9rU0o0dlpMZHBpQlNQRVFCVXRoaXI3Vko3RlZHTGx6?=
 =?utf-8?B?ZTVvWDFFRVRNckMrekJrQkdDTUJJeHlIbHhwWGtOY0ZuOTdQUm80U09oK21T?=
 =?utf-8?B?NjEvclZvdjdOQnJzWEtMMDA5ZFhadHVNaExtL3pMM25jaHVJT05IYmFVV3lV?=
 =?utf-8?B?THJFZXZqZWlyYmM0MEZjK2dSVzVGY1BtZW1MQ29rcWY3eVI1K3kwZXNQY1JI?=
 =?utf-8?B?MitKNndwQkMwalpJYXIwd251RjBiTGFLYlJxZURMR25TUlF1UklwUTZudkQ2?=
 =?utf-8?B?bXBrVFJ1ZXVsR3UxTktjODlsMVlUZ25QdjBVcjlKOFI2QkFVY2V3RWU2dGUr?=
 =?utf-8?B?QXdsWWl2bTh4dExCdEl3NkUyY21wWmhSQkNiZnJTMC9jOG9ZWWo3andSNzh6?=
 =?utf-8?B?ZUlxRG5NcVVCK05kODJNQXo1VzgwWGNwWSsyM0JVcGlBall5TTBGOEs5MytW?=
 =?utf-8?B?MVNmOW5VZ21ldFYwNXRRRXN5NTJyKzJuclVpeEZUS1FlekVvNWIxTGlQVTBi?=
 =?utf-8?B?SlNLQTNqTXd3WjFQWlc2dStSckQ3TFU1OUc3TDJYWCt0OVpJWDRFTGxSbGha?=
 =?utf-8?B?U2VScXNsY2xNVWpTZjYrOVRUTUh1aFJ0L0F3a3JzM0pGVlNJZ3pwZXVVNzBj?=
 =?utf-8?B?R1Nqa1VnZDA2SFg4MVFJeGExWUpUSW5BcyttcUNURTBKUVEvSXVIbEl4eEM0?=
 =?utf-8?B?Y2RLZ0JpMHozdDRQWGJEUGxuUGhBbjZDQWczV0NVMXozbzVZNDczOEJyOUxD?=
 =?utf-8?B?SEN0WFVUZVI4Yk9IbVdIcDRMRkIzMnhIUndoRXFYdGpPM09ONEU2S01oc2NJ?=
 =?utf-8?B?ekE4TU0xTEdkbTgxWmF3UWZaYWwzWGFKMWJhY0lucmd3Zkt3WlkvN0ZrQjRY?=
 =?utf-8?B?c3JDdS9RUktQRmUvZE1raE5BQ01MUHo2alNpc3hUYkxvc0tMdmxYNTVWREZE?=
 =?utf-8?B?Myt2REhQb0dwMzBrc0FrZ1EzYWtRM1hDclhyRS9CNTRKNldMSmI0QXFFYmta?=
 =?utf-8?B?ZzdLTjdPSVcxQ3pCTThWTGJWUDBrbjBYV1JySXRhMEQ2MmViejVSL3JtSXQ5?=
 =?utf-8?B?MDZSSWJjYnhhY0lWY3BJLzl0cDFlV2RRSFV3TllsQmpmQWJIeSs1bm8xUkRG?=
 =?utf-8?B?Y1JoRHhHR1pKSWN5WVoyZjIxNCtFMEtBS1oxREhZYk9kY0lldmRzWHJXalhD?=
 =?utf-8?B?c2QrM0NWTVJDV3FaV0NsTk5HOStKd0RRUTkzOFQ3cE83RlB3Y2FNc1R0ckRk?=
 =?utf-8?B?elFIdlA2WjJmejdCNHFibjNmVHQyM3VMMGVGZ0pZOFJta0VJL1k2b1J4aUJE?=
 =?utf-8?B?Ympjdy9JaXh5MmpYSytxb1BvazJZVG9wQUVkQWVRcngzcmJMNmVIejF2U255?=
 =?utf-8?B?QjBpZUZoQnVRK2hPSXRTM0lBc3A2RjVtK1FvVkJnM0MrTzBja1h6WlRyL0V2?=
 =?utf-8?B?ZnRyUkVreXV5SU8wYXBrWnlJREppWS9tTkpqNGRONDdLWWEyVTl1QkRyVVV6?=
 =?utf-8?B?VFJ0aWtEQUtWSjJYd0RoK1B4ZmZjR1pEN3VuTmM4VlpxTE9Na2FhSDFSSjR2?=
 =?utf-8?B?ZFE5S3FPVktJL3dsZkRSZEhwajhhUCtycU9NUlB3UWVhRXRjL3owTE5RVTV2?=
 =?utf-8?B?bDZ0M1RQWnJzOWR4Q1M4cmFiLytJWmFvUDNJYm9sOUxRQ1NrbjBhVUJOMStu?=
 =?utf-8?B?c3M4eDZMTXNJeWRGeTdIT3d6V0s4YmU4UjZyRDh0Q21aTytxWGREdlM0M3J6?=
 =?utf-8?B?YkJudTB2WkFXd3MvUU85ck1Dem1ucjBYWVZVMVlReXpPUlpVdFVoSUFPcWZp?=
 =?utf-8?B?ZWliZVNXY2JIdFd0VkdVMmF1a00yZ3draTNnNHBseENvVzM1a3pDcUpkVmhR?=
 =?utf-8?B?ZVBKMWJUd25adDhtMGU4Q2kxWDFGdmdZR204ZmNlU0FoWjAxbW42Ky9XaXhD?=
 =?utf-8?B?M1o0bE5ud3laOFRXY0lYSHZHWkRNMU5sQms1elJxUUpXK1pFS1ppcjh3K3hM?=
 =?utf-8?B?a1dRc1FXNU5sOUhLQXJGbVYxVkJvTFJ3RzV6d25acFFpL01HYUpPZTQybi9Q?=
 =?utf-8?B?U21jL29hOTk0UHJMeVlaR1JOSUJHUHdBT3A5OWFlR0NJZjFlaElUdFdLMEpH?=
 =?utf-8?B?ZkVIdjVLaTFldGExVXdKcFpVVDNzY2hla2hndUkxVU42cWJaeEFYdEtDVWw5?=
 =?utf-8?Q?tBje5GJk1I3mgnFCQb8iLb+ZN/P+cMlHmKGL2QS+JJqA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd98fe9-8dd7-4cbb-af68-08dd3ad68bbb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:18:50.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsRtvVloAbmkwwLxwaO+GWZvtg10aH5p/7lrCveE65eMwRUUSQZEZyjIm6sFAN3xhNqVWwo6Y1qdSgVnUBGcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733


On 22/01/2025 10:26, Arnd Bergmann wrote:
> On Wed, Jan 22, 2025, at 11:07, Niklas Cassel wrote:
>> On Tue, Jan 21, 2025 at 05:46:43PM +0000, Jon Hunter wrote:
>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/>>
>>>
>>> This change breaks building the kernel with GCC v7 and I see ...
>>>
>>> ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko]
>>> undefined!
>>> ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko]
>>> undefined!
>>>
>>> I know that this is an old GCC version, but this is a farm builder and the
>>> kernel still indicates that GCC v5.1 is still supported [0].
>>
>> do you have any idea what is going on here?
>>
>> I'm a bit puzzled, since looking at other reports of this error,
>> e.g.:
>> https://lore.kernel.org/all/20241018151016.3496613-1-arnd@kernel.org/
>>
>> using div_u64() is usually the solution for this problem (for things that
>> are not performance critical), not the cause of it... any ideas?
> 
> I have tried to look at the email thread, but not tried to reproduce
> it yet. I have two ideas about what might be happening:
> 
> a) something causes a /different/ division to call into
>     __aeabi_uldivmod(), not the one from div_u64().
> 
> b) the compiler notices one of the arguments to div_u64() being
>     constant in some cases and splits the calling function into
>     two special cases, for both the constant and non-constant
>     cases. This sometimes confuses the __builtin_constant_p()
>     in do_div() that decides to fall back to a 32-bit division.
> 
> Try looking at the .s file when you run
> 'make drivers/misc/pci_endpoint_test.s' to see where exactly it
> calls the two division functions, maybe you see the problem then,
> otherwise I can try to reproduce it here.


FWIW I have encountered similar problems with this before with this 
compiler ...

https://lore.kernel.org/linux-tegra/7733a4ca-330b-4127-af12-33f376fbbc47@nvidia.com/

Jon

-- 
nvpublic



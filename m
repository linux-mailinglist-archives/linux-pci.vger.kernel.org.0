Return-Path: <linux-pci+bounces-33419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF05B1B1D8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D47E16F0CB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29508259CB2;
	Tue,  5 Aug 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yP2O5F8o"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597751C6FE8;
	Tue,  5 Aug 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389344; cv=fail; b=Yh1MuAW2nvRCJKq91J/6PqvX25jm/Pdv0PDBuQ4rXNYqyf6Jc6ftFDLaf/TubFLc3l3hDs2rEQWw9OzhT7K5SoxN732oXi1LcFjcTOTptUQu9RA7/j1LbGiZE46hUbw3Gr4zh+GRrx2zjux4jUKwOYVCJ88yuIWkf7Gp4uFWee4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389344; c=relaxed/simple;
	bh=u8novWwqNlwWUs3XEHa4SLN11vCwdQZUHyW3BXN/nNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUi3psYNTmWe2uNCp/3TqTQ1S2siQk9pcbOnjKvhAtSaI5WDhJ7d9OJ/tDRickelz/cBotCh7dz0JPrJ/V5DCwgts7N+m0aiG8LDwMkFRvCQuv9cve+ndXg+SEtsWNckbMCfRPXRaLIngp+67OByB2WZhttraPiRtljUFHAkLIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yP2O5F8o; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybznPwPuBXyk5k/NYTrSodlS5+MTetdM9RGCjlx39C+ugeB6jOjgh9xAt+sNf7xxrPU3TK6shvnkQpYmAVO15qjQlFbBUaSDIyBeY2oYbJGAoLFv+1Bark/nSuRI0C6sC3UhXtGVqL8qLWLbIl1eE0ubd7X4K950G84/EvePGweQcXpQbrjSsJrb3PBIYC9Rxm/KguOzVP5dUaNFCrwLnT28WZICYytcnY86DbB7Lw3i4YZkU8OhoMCjWb5C40ATdIlEtmJI1g6v1Xsr7uyE5P3iTms8BFlApZzVOr2gerQ+Yfns+/WxGjnDrDywJZqckab90uTnikB5+GjwnjBvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6vVjHeUwH6GsAzMLgj+grkNUY0cBnmF6tH1Hhc17Bk=;
 b=HKp/UahRgm4zZ90YQpeb+ts3VEscewBOHQnhoreAuyyE0xdvS6hAbLGtNJGDv5UDiRLcR7FbefMZbhsAm96DSLKZ8XYYJqxk8ZYwU/QQUJdSLRLEwe7qmKgUXFu5Am3eo55xm1Oa6g+HuQw1GY3zG/rhVtiktQGWPJxvAqcHeupvwJu/7ElsIITv1MabPuJP4yIdhGpp+XhPLLJ9BusvhhsV/KZ/EqQaew2Vp3gdiwcGYrdkF8Q4nqcr5Y0WaVKvsGhw9U5E9vUU0Cgq0q8a64J3oMOsz6U1zEwXyibp8nrsFimDX+YgPUmjwcZT1z5MdKO1GoeE9Omqx+LEjLzM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6vVjHeUwH6GsAzMLgj+grkNUY0cBnmF6tH1Hhc17Bk=;
 b=yP2O5F8o01rHf5dT2/Mm0c2hrlQBLmf6gzID3DTnBH7kfkhQnSogkEA8/0KEr5CSD2cVcHFyawgDTW2Amczp9C6Cx4Yw6nZGKwhymdgHZakL8VRtDwngsmSioA1YfFyuIfpwP1WCTJXWKrc4BN+k9YNPEI1sdlQ+Q5z0xXbMzsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 10:22:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 10:22:18 +0000
Message-ID: <a22a1ab7-95c1-41be-b33b-a4009b55631c@amd.com>
Date: Tue, 5 Aug 2025 20:22:10 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250728143318.GD26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0106.ausprd01.prod.outlook.com
 (2603:10c6:10:111::21) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: a485e735-1ee2-47b5-fed0-08ddd409f4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG93Y1IyYnIrdmY3bmhWR25FVVFtYTZzbllKRnl6SG1GSWhBdFo5enpTdy9u?=
 =?utf-8?B?Q2kybG8ybVlvUm9Yd1JVNkh6dHcxNGM3WndmV3BJa3pudUp6YkY0K1RuNVBr?=
 =?utf-8?B?bmZuNGUwb0l1M0VQaC9DNGFRT2RTeVNTb1o2TmVreTA1VTFtQytIL0hqamlU?=
 =?utf-8?B?TWd6QzBzeUVTRGxyalBGQ1RDVVoyZkd4S05VVmZrakE5TW9TbDdCeTlpQm5x?=
 =?utf-8?B?Q1dOUWNlcUk3QzF1ZzVnY09BbWhic2dJeWcyVmtEMkw2cEtSZEtZeDFHbDZp?=
 =?utf-8?B?N0p5bE40NHVvU3JBcjJrR1JvWXB1TW12b3BlT21PbGNjYWU3K205ZjhFaHo4?=
 =?utf-8?B?dnRvYmIwWHgzNWhKREh1dy9DSDRvYmtNLzRBS3ZsbTV2OWQveGtIbUk3dGpp?=
 =?utf-8?B?VGx2N25LV25ydVZ5ZXdjTFo5S3FLUkRScHpvMjhxUHFCQUIvcy81YlZpUldT?=
 =?utf-8?B?ZlhtZVY2SzFjSkhyZ0EyYnJaejdwRysvR1g2RWFwREVrZ2hFS1BSMFc3YW9N?=
 =?utf-8?B?M0ZBdVljUVRlcVpoR3hydkV1azRVSHY5cGYxZU5VN2V4S0l5c2R5OVZ0ZFNV?=
 =?utf-8?B?WU5uRW96cUEvREowSDdWc2lRa2FMV2cvbWpJYitrQk53SEx5WTY1c2FnNUkv?=
 =?utf-8?B?cXJuVmhTUXFhZjJSZWxYVVRoZnRiN0d6cU9JdDJESzdqb0tWQUlMOHRsS0FM?=
 =?utf-8?B?c0RXUk14NmJnMmpKZ2xKYzQ5Vy9NM0o5eUJpQ2xHM1BCVmg0R1pzU0JpbVNC?=
 =?utf-8?B?MXJvTmxnd25FZUNRY3pmcGJyaktDam9sTkJRSHhVRnRyd0dDamlPeFV0U01B?=
 =?utf-8?B?TkJGNEJDUURDbHJrS3RNb0RoM09QeTV4c0lJMjcyMEZtZm5pS3V4TUxDV2p1?=
 =?utf-8?B?aUxHbHpWaG1zRU5hUWpxczhtVnhiMmVJMGhJdS80anBid3NLaGdNZm5vQnNH?=
 =?utf-8?B?QzZ2OGh4b3JScEU0cUxsNERXMUtpUzEyK2xkSEc2c3dTUWs4RkkvWDlIQUY4?=
 =?utf-8?B?NElIR2NSRU5TNEdSL0lkTkg1NzRQeHhBQS8rMU1nTkNXL2FHeFM2aWVtNTRx?=
 =?utf-8?B?VnFOOVY4OHZodGR0bU0wRi9WUXlqcmU4TE5jMlFiWTREUXhpVjIzL0dQcUxm?=
 =?utf-8?B?QkpVNVZRcTNOUE05dWIxekhZNGFIUHEvNlQzajNSZjI3bmQ5NVROTlJDNnpn?=
 =?utf-8?B?SjdnNWtMYUpwVFNCMklEdDJJWjkvdEpIS1NYRElxejFYWi9La3pvV1l6WVhv?=
 =?utf-8?B?d3RaeERXN1lJVUdKM1h3Q3Y4T1hmVVlJeklxVHZObUhNL003ektRbzJqN1Bv?=
 =?utf-8?B?Szl1Z0NLT3Q4Yis2czlQMmdtOEJYY3U2QnFnRFBJVGRLbHo4Tys5ODJ1Ty9Q?=
 =?utf-8?B?cHhGUHRpbkZOdXdDR0FiVWlPU1pLc1RPTGpoS0VMYTNBUGxTcTRkV3FIeVRX?=
 =?utf-8?B?ZTczdnVuNnJydmJWa1R2eGkwTXNjNnY3TU53RW54RE9XUTF3WjFFTEN6SkVE?=
 =?utf-8?B?SzZjZDZQVytzQU5DeGZoZGJCS0lRbGcrejJFaWM4Q1FwZGF2N2dnY3JnZVpq?=
 =?utf-8?B?QkJMdVZUUGFPZUFjc2NNbnJPYnIwYVBVQ1VFSUhSTHlCYldvRGdTNXA0cng4?=
 =?utf-8?B?cVZvYWVlOUlVaURpQkJLc1laYVdScWZtS25qSGlZOUVrbkNlakNqeFhtTVhC?=
 =?utf-8?B?ajZEbXFFaEw5MURHMG40eS9tOGI3VExLRmJPQXBBaGxudWJ1RGh5MUJocjJx?=
 =?utf-8?B?Y3BFckRBbCtqdkJiZGZicm9TZFFUaG91SEtrR1FLbDlmcHo3KzdTa2ZFS1Fu?=
 =?utf-8?B?b3pXVkJVM2RxbTRsNTlhQWM5bmwvNWVWcjRMMTVZZGlBa2luSlEwS21Xa3Mw?=
 =?utf-8?B?eldOTW1nYnUxTDBlSlp3TFNIWmFaTklhM2srTldyL0tHRDRMYVRLc1BqZ2Nw?=
 =?utf-8?Q?qMf50kIiAns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEpYSE15NTh5VElpRFpBWTNZSDkyZEo3ZXBVVTF5RzBZYTVHTXBCYlZnVjY4?=
 =?utf-8?B?MUw3NkV6enExdWcrRWJKd3VKWlpsT3Jvb29VTEpqVko5dTkvSkJDWEZ2c3RE?=
 =?utf-8?B?SDVLQ2RpN0w1M2V0cldqdjJTRWJZL00wc3hFbUVrWCtCQkRzTW1TU2k0K0dx?=
 =?utf-8?B?Vkdma2p5dG1admhhLzJaN1pHU29uQ2xwbHlrZmJNTnRHeXA3NHNxMmRFQmVT?=
 =?utf-8?B?SEZZRjhLV1l5SnNPdjB2OHUwK09pS0dHa1IrVVJPb1FsMlZvTXBiSHh3Q2lt?=
 =?utf-8?B?RCtCSzlGZ1R1SWI5WXRmR0tNbmlTNDV6SWNGd2QvckpJM2pQQjI5Q3ZubkhC?=
 =?utf-8?B?QVR0VnhNcFNGanp4NnZDckRTYzJFSnNiYXBaWkpGSnJpNjkrN3lnZEZ0bkxM?=
 =?utf-8?B?eTZhQlZTTWdJVC9zVTRiTE9BL3ZGQXU0SHUyaXU5S2ViSWZoV2QyUDV5OTkr?=
 =?utf-8?B?a3VOUVhob1J6WU81Mi9zWE0rR0ppUmx4WWsvdUNnNkJmSU9acEZoelNRWnp0?=
 =?utf-8?B?OGVuZTlYMkN2d082OVNMT3RKVytyckRtQ3FDQzkreStJaWJIZW1ncENKUTh5?=
 =?utf-8?B?bnBOdFRiekdyVzFVNlpGZS9jczFVb0NnN1B1YVdqNDVQUTNzUFZYeHhnQnc3?=
 =?utf-8?B?c1hRQW12QjFlZWhYeXo5V2xOSDB4MlFHZi9TQmgwMFh5cFRsekx0aWFEbWV5?=
 =?utf-8?B?a2VFQlR4TWt4R3pKWENrTGFiTzlkYkR5KzZpc3hIYkRBSlJPQTNmTjZGanhm?=
 =?utf-8?B?Q3A0QzZnT1U3MDF0cTNhUE94Q09aeDdEQVJTa2VWK0NPWHNITGNMNStUWW9i?=
 =?utf-8?B?eUMwc09uSFI3SDZnSmxEOFg5S3EwV0Rkay9TaGMyL3FWMnVRbWNzdHpHNXEw?=
 =?utf-8?B?K1hyYVcrUHkrYWsxeHJZV2FtTWdNM0JpeVY0ZEJlVVAyOTZtcG9UR0NrVTRt?=
 =?utf-8?B?bHpkWjhpVVppZm5ZSjhBQlM1SXVoM2FHNFVTdDJPUnR5VGR1a2ZuamZCT0w5?=
 =?utf-8?B?NnJSQ2plM0dPaEpYSGJhdzN5WEpwWXVKbzFLQ2R4d05FS2xHNVdHU212TFQx?=
 =?utf-8?B?dzhoRFIxSmJCT2RBU2NveWh6NHNoN2FaUVdHU1RWRVdmbjRmRzJ2OVFyLzZ4?=
 =?utf-8?B?ajlvUENMQkJkK25yeXVWTXV4eVZTNnN3Tk8ycDMzRHZyUFJrcFVudlV2OFBR?=
 =?utf-8?B?WDdENGVuNGZYVFYzWFRmQTFZWGdJTzdjMDZuTXoxZXMwK0hwTERGRmlSdFRw?=
 =?utf-8?B?d3E3NmtQTXBkdklGVERkNHhJV3FPUmE3UXNQQWVKcHBXT1crVmlxSzA1ajBr?=
 =?utf-8?B?MXkzcEM5UW44Qk5ObU8yMXVBSmZHY3BQVk95OHhTcGdqd0tjVnZXZ2tiQ3Rm?=
 =?utf-8?B?Nm1GVXBvR1FvTkptb2pLZTJXK0N1Rjdram8yb0tCY3ZxTU82em9taEZpbEk0?=
 =?utf-8?B?Zm1lc0tCSHEzQzlYam9VWEhlMWtXVkR3c005RWdzc2hZUDFRQ3dzbEhIakN5?=
 =?utf-8?B?WnphSHdLSW1qbTJnai9pR1RMZjFqWmdlQkxSaE1hWXE4dEJZUnJicXZmT01l?=
 =?utf-8?B?ZUtZYnJudW1LbkU0Ky9RamZ3Q2g1NktrUTFDL1JHMnIxVEZJbmFkV0xJc3V6?=
 =?utf-8?B?NEJoSitVKy8wL2Uvd3l6S3g4d1R4UkFyNnB5L3dIaElheGtZNk1ieGFGcTVu?=
 =?utf-8?B?UU5LcVVDd2svQ3lXZVJ3VzJ6WVdEdGRFZUJFcHBwdUtQaGVtYW91NnFkYTlL?=
 =?utf-8?B?ZmlZRmlRbURLTGpKbWszWHRqSElZcGhMTEFjS29BZzY5MWhhSHU1bnNSaHpT?=
 =?utf-8?B?VE9jUWdFcHRjTDA1V2N2RnVIQ3l6Z3FrNjNMNXpRMG1hc3MwT3Z3cGlhZTFI?=
 =?utf-8?B?OTZXZ25taXh4Rnp5QVV3VnBoRVV4WCt0Sk1yS0JobUVkK0RhNU83ZjJyK3c1?=
 =?utf-8?B?c25NNlhGelE4YVdmNzZjQlJHMno1YlVsbjhSU0hrbnkwVHFMYTBENnVLUnVD?=
 =?utf-8?B?amxuYWcrTFA5M09BT0FIazA1N3pwNXUxaXdnK2VnbVFTWm5Gb3duR2VFRW9U?=
 =?utf-8?B?eTJTZzQza2VNNDZKa25UdXp1TFFSZTd5L0h5bXY2TlFuLzFjMGlBWktZNWQ3?=
 =?utf-8?Q?RqcYwqckE//t9HSNEXg0xuBwo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a485e735-1ee2-47b5-fed0-08ddd409f4b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:22:18.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qtNjfWv2T7LTlYoKBN2JUVj6+gIMVm1edq9IGURKTQHT2+oNrlC+VvLfeeIwTcKD4PShJtKvwalOydIEWsu4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689



On 28/7/25 20:03, Jason Gunthorpe wrote:
> On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>>   	return crypt_ops->decrypt(addr, numpages);
>>   }
>>   EXPORT_SYMBOL_GPL(set_memory_decrypted);
>> +
>> +bool force_dma_unencrypted(struct device *dev)
>> +{
>> +	if (dev->tdi_enabled)
>> +		return false;
> 
> Is this OK? I see code like this:
> 
> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> 		phys_addr_t phys)
> {
> 	if (force_dma_unencrypted(dev))
> 		return phys_to_dma_unencrypted(dev, phys);
> 	return phys_to_dma(dev, phys);

I did write this in the first place so I'll comment :)

> 
> What are the ARM rules for generating dma addreses?
> 
> 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
>     and do "top bit IBA set"
> 
> 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
> 
> 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
>     normally??? Seems odd, I would have guessed the DMA address sould
>     be the same as case #1?
> 
> Can you document this in a comment?


On AMD, T=1 only encrypts the PCIe trafic, when a DMA request hits the IOMMU, the IOMMU decrypts it and then decides whether to encrypt it with a memory key: if there is secure vIOMMU - it will do what Cbit says in the guest IOMMU table (this is in the works) oooor just always set Cbit without guest vIOMMU (which is a big knob per a device and this is what my patches do now).

And with vIOMMU, I'd expect phys_to_dma_direct() not to be called as this one is in a direct map path.

> 
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 4940db137fff..d62e0dd9d8ee 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -688,6 +688,7 @@ struct device {
>>   #ifdef CONFIG_IOMMU_DMA
>>   	bool			dma_iommu:1;
>>   #endif
>> +	bool			tdi_enabled:1;
>>   };
> 
> I would give the dev->tdi_enabled a clearer name, maybe
> dev->encrypted_dma_supported ?


May be but "_enabled", not "_supported". And, ideally, with vIOMMU, at least AMD won't be needing it.

> 
> Also need to think carefully of a bitfield is OK here, we can't
> locklessly change a bitfield so need to audit that all members are set
> under, probably, the device lock or some other single threaded hand
> waving. It seems believable it is like that but should be checked out,
> and add a lockdep if it relies on the device lock.

True.

> 
> Jason
> 

-- 
Alexey



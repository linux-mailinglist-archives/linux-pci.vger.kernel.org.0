Return-Path: <linux-pci+bounces-35990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E28B54687
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704383B9DE8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3C2749F1;
	Fri, 12 Sep 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="R+kOhCRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE4223336
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668224; cv=fail; b=SJXW+WYoFHHhSoigcWfTXN4bIvdo8yr9x3rLSra3FiSpncFP46Q3p+RQY6zY2nHnYATHjhu7gbPhsrjGMR2prR3PTlwYF1S39EjqDPiwBwbY4Q39dwOIKZLq9HIuZhXzqy7BSOJUch5sNx2+lvQLvs+27P7TPqNvshqGkUFs064=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668224; c=relaxed/simple;
	bh=bx6IM2jIqmv5dutdNi06owb0pRWwwVUR3TZFnojCHPk=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=Chvel6LbxvmlFcA19p9/TCtMavT91RdTKsCf3vvMzFKjTeJ3X0qkTmaAikTzzQh02LXc3PbMmKuPGStFXi+ydvuHcJV2ohos0o3E4WcjqJobXVQIXoXh5foFy8McsghtmguEGhi2pBXB1eZDussTH7ouNRap/vuSZEnk+mAVU5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=R+kOhCRv; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C7wntb772303;
	Fri, 12 Sep 2025 09:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=QIr8TXocx
	kVHuQsJaMFd/MAhZUkI8TKxi6VUenE6vCY=; b=R+kOhCRvJ2Ysbi/yLXd/OIeYV
	7HkFK8HOZVHWUfJ5AxTkMg1TFkmJNwgdnesrGi5HO0b6tCiJC16SPToyJIlaAzkV
	+SPZT/1wo5cS+miRNqWcBnBB6XaCzB0gnD/Jswlys6SMRlFr84tUVUJVMWD+pLOj
	MlBEvrm8yRmWAeg0gZn3CB38UK5TZjDJS3lgcap0xa8mx7LnVxRBsT96UVe3VOct
	wgnT7LSV3/tg6lqBC4ko0ijVbODLrCz7uQTD05LP+QMjCxL/cREmK3Vtw21unyFw
	yVWmQN2VRwSgzSaSRj4PT0esn539Boj2j4FgGov87/2NiJi5PANOo1iXY4FvA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 491ve35ry8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 09:09:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUwXEETrc9xgtoZaAnpi6qKxFFDgLV8iMTRjDhCJibn3Lb3wjBhnNfewrNMqJQtnL5I2uaLxgx0I9V4KSON9/0en3hJSK0RWNzIYjQhGo9WNaWvg0V35hFekp44vCHl37qUptpGOj9JGDoNBDAX/4MRs5FCkyeI+9MXVUezkidrKcgHtbpeivWN6O8EQMM0PusBVYIzlfn16Qip19bSsUBmgewgQ3ekXHBMByBzyKPNyBo1RAPS/BL8fyyMmt6OFtK+n43XcdMqw0KjCIkMz3roSciXdeFRenmjt44VKNQYGa5abTecpkG2ku7LI0FBRB24b2YMqjmkRgs4hKXXNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIr8TXocxkVHuQsJaMFd/MAhZUkI8TKxi6VUenE6vCY=;
 b=lCz6ULokgsJMTxxpSO/Q0RlNgYaWwA6hWtlAR0tPuvG1dg9yWo4jbrJJQ7fBXjoL5jVlqAL4UcWyXe5xVkArdvieKSFOlr7cTDJu/7BOhZFUUj8tjPxnnL9fXkYAshZbYorrXasyTwNHmejZV2HQ5SsGwP9qc+69l0Dh4fkErlmc3YtENhDk7WMorc1sZN8M+16VepUue244tbrcp4m9MHCd3eJnNk+dkcR5060+xuMMWBzgaP50Gx761vsb8pst1eG2C+9V3GV7hrs8m59hmgu77dzPi6pvlBnXQ7YHZBB6iFauvbjZbCaQil9TR5p9AJ+55bCEEjASa5DvWJHoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:09:54 +0000
Received: from PH7PR11MB8456.namprd11.prod.outlook.com
 ([fe80::9973:fdf3:28c8:e174]) by PH7PR11MB8456.namprd11.prod.outlook.com
 ([fe80::9973:fdf3:28c8:e174%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:09:54 +0000
Message-ID: <e83a2af2-af0b-4670-bcf5-ad408571c2b0@windriver.com>
Date: Fri, 12 Sep 2025 11:09:48 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bhelgaas@google.com, michal.simek@amd.com, thippeswamy.havalige@amd.com,
        kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        robh@kernel.org
From: Jani Nurminen <jani.nurminen@windriver.com>
Subject: [PATCH] PCI: xilinx-nwl: Fix ECAM programming
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To PH7PR11MB8456.namprd11.prod.outlook.com
 (2603:10b6:510:2fe::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8456:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da24a80-041f-45ec-e385-08ddf1dc22f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3dhL3NVYU5OelZJbmxTK1BnYkhOdjZLci93TllkZkt3b05XMWJqaW9lcTBN?=
 =?utf-8?B?WkJueDVBZkdCOUpGUUFBZ2V2Yy9HMXlVQ2lwaVJkQSthWTU0Tm0xem10MWg1?=
 =?utf-8?B?aVorWkhiMHhCNmMyWEdVdkVyZVBvWkkzWEMwbXdkRHRZeERISGV3NGhMRlhN?=
 =?utf-8?B?UEowaTQ1RmNaRHVEUkpjL0prTENaQUhJdEZZWHVGM2JKVCtKTjVob2ZSZVFy?=
 =?utf-8?B?eXh6ejAzb3phbVBmakxLcFJYcDc4YWo1Z0dETEFxMy9YZU1YZmtBdUFMcysz?=
 =?utf-8?B?cUsyN05MbVVXVWphcXRrTTVZNVVxNTJuR1J4RTJZTXRHOSthU2VBVElMemdz?=
 =?utf-8?B?ZHUxWWxQTTFnQ2RvOWdKQ0ZOL3YvOTJHUkxWbnI1dEhDVGd0TlpFWWhGZFRn?=
 =?utf-8?B?K05ZWHJzSUdZTTVoYTJJUGRKZ24xeG50eGhraWRaWC9JN3pTY0NFR0ZybmVt?=
 =?utf-8?B?dHVsanRnUmtsMWt4NnlrSWROc0s2NmxLREZ4TjE4RzFIWWlUajdTamdSYWJK?=
 =?utf-8?B?UGhaZ3pwYTNHQ1Fud1NnbUlxRkozWjk5TjNPOVVpM3l3WnNmazVIdWxYQlFS?=
 =?utf-8?B?dHU2d1c3b2xQSUhJemNMWjBSU3AvWWNteUExWFpZOThOZHdVdDBjQ2xlUUN6?=
 =?utf-8?B?ZlE4ei92YVVOd01ES1FmekF3Skp2c2NVNUxMWGZCNDhsRTJrd0NkeXBGbU5s?=
 =?utf-8?B?eEpNT3l6YVFPVFUzZmlVUWFBa1B1NGg5bWhxaEVjN1BlcDI0SWozdWJMMFhV?=
 =?utf-8?B?ZkM4VGdBMmVjT0ZwamdRdk45WEJhUG4rQTl4bExkci9LWG1nQlVXbTg4MTdZ?=
 =?utf-8?B?alpFRkp0NnRldUVnM2JUeDhZTzNZbFhBNjBhSDJTZEZNMVBVUmtoaHlNMk4z?=
 =?utf-8?B?Q3dTTVoyVytuejRVaC9LYnNJV0svaXJKVzBjTzU3T0pWNjRoL01kUG9EbTIy?=
 =?utf-8?B?U2tJenIrZ0hrdVp6TCtIQlZ6MWx5djRXWllBNWtvMjlrQzZDcXZBUUowSUpw?=
 =?utf-8?B?VXhoNk1OQk5VRmNKYVZqeFFrbDEwS2YrU2I1WlRsVUFHUUdIKzdLaWh0UEJF?=
 =?utf-8?B?dVRiSlhCVlJwV3VtdmZrNHN2ZEkwUFg5L2gvVTlWd3FnUGFURkl4RTNnQko5?=
 =?utf-8?B?NWJta0Z4ZytJZE8zaTNPRDN3OHd4U09pVTV1Rk5kRkxQWWNUck8yOVduM1lE?=
 =?utf-8?B?dzJ3U3NMZXVuS204d3VlTUc2Wng1M202NWpiWmNNd1hyclhBMXhoSnFzSkkv?=
 =?utf-8?B?RWZlNi80U1JPclR2R2hjem9acmtXRWFRT2lMb0ZDa3NSc2k0U05FQXBHQ1d2?=
 =?utf-8?B?RFdKZjNuVEFNTVMyU052S3B4YnhudSt0NGY5SWdEdmtuT09PR3ZuZUM4bStr?=
 =?utf-8?B?MzMrYmFSMVVtNTZFTWhCbmNXMEtYbFNNaHJFbElzemd2MUVGUERKOVJrOEVB?=
 =?utf-8?B?ZHNoU2FhOGRYdWk0UDUrWDZWVXY3b2lMRXFhcXBSeDlWNUxuVnFXOUJJTTh3?=
 =?utf-8?B?SkZ5a1hZb0lrazN0Y2R2eVlwSmJZTklPN3RDc2xCMFBqQ3BZVTNXZWZCakdt?=
 =?utf-8?B?ME5BR3RUZ1VheXlzMDhZZGVndVAwUjFOOHJkNjBLVlRwenhyQTBZN3N0M0I0?=
 =?utf-8?B?U05qYk1rMnpKR1NPcUVrek0yQ29vMzJvWG92Rk4yRXlwSHpheXBZb1VaY3Na?=
 =?utf-8?B?MGwrcmFpN1FVT3kzYWNIWlpObXZ1SDNBdzJ5Y3hKM1BxZmxrK3FyMkVKZEg2?=
 =?utf-8?B?U01DdjBPaEgwN1dIQXF2UHk0U3NNTTFETHNONkcvQWVjbkNiTWpzbGRTU0d2?=
 =?utf-8?B?R0FmN2oveXVJcDdKQXEzbll1cTRySjNXNndzM0Y5V0ZSbm5oQWVDeXRJVmhw?=
 =?utf-8?B?OUNnSGdHaFRsR2JXTFpuY1dibk84Q0gremlDTU1PR09IL2xPMnNkVWdIcjhB?=
 =?utf-8?Q?N+zxCdOatQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRWOFBpcEhDdWFrazhTOGhOYW42Q0hJSVIrS2dwWlZYaVRMOFFqYlBzNlB2?=
 =?utf-8?B?MVBPSU5LWjA0YWpudEJmODhMRzdvOWwvQ3Jpa0k0OFdNTGlnenJqcnZVT29k?=
 =?utf-8?B?ZlY4b1EwSFNjOHc1d3J0ZGljTmh0NnBacFNYZzk3N3p6U2UxanpCQ2tGdHcr?=
 =?utf-8?B?QnVia2p2eDJlV29CeDB6Wm1kZFFUenBGbG5waGJRdkhpK3Z1bnZnV3QvQURF?=
 =?utf-8?B?b3Z1cm1udVErZDNDazJjZlpaMFFJS1kzTTE1VWNzcG0wd0twZUplaGgxUkZG?=
 =?utf-8?B?NlBmeXEyNnRUM2VmUWViVXhWZU05ZXhrTXFxakdJYUFOYUZnSlhDRXlJMCtD?=
 =?utf-8?B?WnY5NklObUNUS3R3SFBIaWk5S1A3R2pPTHp4N1M4YWdqUGRJVFR0WTBOSXJv?=
 =?utf-8?B?NGp0bEIyaDdvZGNMWFZmaW1MaE44ZXhtWnViRHZkNFVYL2xUNGpWUXNqaVlB?=
 =?utf-8?B?ditUc1BNRStwRDVSN2V4VG1MMmQ5NGk1Mk1lQnlsUHppcXQvaG5XanRuUEI0?=
 =?utf-8?B?ZDR1TjVjdXVwSk9ja25FTjA3dHkrWlFFWWZyZEI2SkhVTFRHWXJPSWV2cEs4?=
 =?utf-8?B?VGcxclprU3pXYmNXMGVlSkYra3ozOGdwTWFHWm9tTHltczhnc2NGQ3pFTFFT?=
 =?utf-8?B?UDBnYjZnQWdEcEg1cHRNblkvRy96dnEvQlRrN0pPcDhBemdGa3QwREZNNzBm?=
 =?utf-8?B?N1phZFFLUHJLTnUyVHdzV0pxWEhna2xXT25aNjZ0c0hkRjg5d0FXMis5QVdX?=
 =?utf-8?B?RVFyOEptd3RobytGZmNxeWozYUhtOERZQ2xUVGluUjk4NlA3aXIzYXhDZVF5?=
 =?utf-8?B?WEk2b04yVUdmbzdhMkNiKzZXQlN1Y3NpTmgvT3owajQxSE8rZ2VhanFqUkVm?=
 =?utf-8?B?dmYzRFpUc3BRYzhrSGd3SU1VVlhzbThyak8rZ1VYdVN1QVpDdnlhVERFdGZm?=
 =?utf-8?B?bVBkVkNNaS9PNDl0VGNhdCsyUmtrNlhsRkdpSUc5clFscGVGM1ZHZy9QTmtW?=
 =?utf-8?B?UUFUNEk4eUJzWXM0azNGOHJEdGRON3dtZ0loZis4MGhVcGNFaVI1U2ZxNWFG?=
 =?utf-8?B?UGNqamlaMTB1azNBNzJiOHI5bzFPSnU5b3hnbDRwMjJXWWlRc2NROGxZdGRu?=
 =?utf-8?B?ampPOWp3dmREM3UzbFZJSkhVYVZ5dENMd0VpcUtrc1V3ZUpXQVZ2L0F6WU9D?=
 =?utf-8?B?VUs4K0JNdFNud2lGV1RSSHdWQllJNTVKWjB2R2pON2J0YWVZWjA1UEFRNmxh?=
 =?utf-8?B?Z3BnNlVDWHl1czBORGNMUmUyTTQ0aVAxSVNFd09KSFFaQTRDWTRidFJXTC93?=
 =?utf-8?B?aWprRG9pRFVGZzNSVldNNE5UVEJUMDhSSGZYaC9lSXZ5RnY1eE81OStCb0JX?=
 =?utf-8?B?blhTNTBWN2dBQUFPRzM4TXUxRk9zWWZRb21uMkRsNlhTM05PTmIyQTVrRmhl?=
 =?utf-8?B?Q2tCNjJpWHBFTmNHd2xjV2gyb09QQitjcDBXemhvekRoZTJjWmVVWUJwbmxn?=
 =?utf-8?B?dDhFNldPR3FOdmFPUGxvY2xoY1lTOGZ3aGRORm5Rb294RUYxZmJHYmF1ZmJr?=
 =?utf-8?B?cVFINlhSRXpUQUtpeGplZzBFVnVsK1JFRGxRMzFwTjhlUit4MUp4aWNsVXh3?=
 =?utf-8?B?eVpiRTdKaGY0WlNUZ2tTV3p1SjNiVFJTZUx3Q25YWE91QUJJckU5U0g4cjVZ?=
 =?utf-8?B?UTBpUk1ia0dUczZpNDV0ZmJVcWZmWWFxQU5KeXUreGN1WUhteVo3QWJ4ZENS?=
 =?utf-8?B?NHUvMkJCcUpqbFUzQnF4WVlNcXlHQ1dsd1dheStrYkU2L1REUGo1eG4xS1Ix?=
 =?utf-8?B?RlZWU2pGYXE0V2UyV1lNV3pLU3kzQmxQSGpGTytCKzMwb05WcjJkK2tjZjRa?=
 =?utf-8?B?TmpGTGlFYmRYVkJEWUwrNlFOcmpwekRQUSs5QU9rbkN5emdyRk8yazJRN3po?=
 =?utf-8?B?azY0Um53NmVIY29yK3UzUnliMjZFdjZjVGlXNUJQZjhKTk1PK1YvSHFoQjFC?=
 =?utf-8?B?SmxRb0s5SUtSR1Y4bUYxMUY5UXVHNmxOVWlBc2JybGkrazBqRVZaTEE2RW1Q?=
 =?utf-8?B?bTlNUmZ5bVJLU2R2anB3S29KUWZBVUZ2a3gwaVg4cllBVjBNQjVMU0pESGZx?=
 =?utf-8?B?dExnWDhxcGR5aS85QXRpY2JEM256WmRsN2szd1ZaTzlUNnpQMUo0TW9saW84?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da24a80-041f-45ec-e385-08ddf1dc22f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:09:54.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDlk2X73fWGOFJs4K2Zr1HVLSf3RZ6+v8iOdkvgUmPe54ANMdqBTsBRGXNHB/LChCKWOiA0ZrCABEgv2N1tReawiz+DlIXIuhJA2vRpc2OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-Proofpoint-GUID: cZ5roGJ0OnL6htEooHDx7t_XdVjQr183
X-Authority-Analysis: v=2.4 cv=U4mSDfru c=1 sm=1 tr=0 ts=68c3e364 cx=c_pps
 a=RnuTvXxHdiR3w6MmYaEnsw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=6STyJf324C7b4UX_81UA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: cZ5roGJ0OnL6htEooHDx7t_XdVjQr183
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDA4NiBTYWx0ZWRfX9V1ntigni7jM
 ak0Q977ZR77sVUDAS73P2S0cJKZIZm7wdnGxTWKULjOGEQ/+svyxtpKwotJyGsu4RitnbHJzN92
 tjs+focjB6IuM3tcAjzXCKv9n7U0N+mNSyaMyaMEuuwcE0H5MQWWUlDXP+NKg4e0SKEUVoJIwHn
 MR5WZ5FlgGDJmt0ereFeUhMMwyIRDRNOwa6y2F6iDbBdDF/z8j9cYdYLVjg8nVtVOHkpmSzbkgD
 myJ1J7pUz/qdOlIX+bYRr1U6+upIq74WFQ5spG23VmbHdtV2pI8zaY5oHTmU648xvmz1Ivlf6mE
 PJZmWF9OPUICP0w8nImXvi8jpZDKeq+JvTY+UUDN0VyDcR2NQ+tFnoldPmG72I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

When PCIe has been set up by the bootloader, the ecam_size field in the
E_ECAM_CONTROL register already contains a value.

The value used to be 0xc (for 16 busses; 16 MB), but was bumped to 0x10
(for 256 busses; 256 MB) by the commit 2fccd11518f1 ("PCI: xilinx-nwl:
Modify ECAM size to enable support for 256 buses").

Regardless of what the bootloader has programmed, the driver ORs in a
new maximal value without doing a proper RMW sequence. This can lead to
problems.

For example, if the bootloader programs in 0xc and the driver uses 0x10,
the ORed result is 0x1c, which is beyond the ecam_max_size limit of 0x10
(from E_ECAM_CAPABILITIES).

Avoid the problems by doing a proper RMW.

Fixes: 2fccd11518f1 ("PCI: xilinx-nwl: Modify ECAM size to enable support for 256 buses")
Signed-off-by: Jani Nurminen <jani.nurminen@windriver.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 05b8c205493c..7db2c96c6cec 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -718,9 +718,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
-			  E_ECAM_CONTROL);
+	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
+	ecam_val &= ~E_ECAM_SIZE_LOC;
+	ecam_val |= NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT;
+	nwl_bridge_writel(pcie, ecam_val, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_LO);

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1



Return-Path: <linux-pci+bounces-44496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3ACD1277E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9AED302628D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1783570BD;
	Mon, 12 Jan 2026 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pv6SvPHH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d6vzpOhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0222BEC34;
	Mon, 12 Jan 2026 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219754; cv=fail; b=MCd6ViUKY63HzbVET/Q01f0CCN4KTpNFv25sY/lkD1WIAYrGs0k1rwXP/bsKt2IpM9KGTarFPQ1m1CcPkjHLMJEYAIilvyNmwfvbmdLhnlnThXonAOCpoHy90IfGR06UOSzyowtPHOTODlfjUFPT6hsB7S2mD8kTzjjzZzl2auU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219754; c=relaxed/simple;
	bh=u46yPLnb5CC0WJO1DamW1uhThHo8VD0/pAao/V+YdzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nifgGAybQ7jlzJtTOWVyXiNk9OFaIgx1Cn5mPdpvcxAFT50f5matwiSs18TTYd//wxVpA4bEr37n7KIsVPZ7XlZ786E6gs2VuygdkL8BB1XfteTuqhRMTQfLyrncTcyOIRkABQwVfDulFOJ8XtD1LLUBq0jUALLk0EkpsJ0zIgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pv6SvPHH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d6vzpOhy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNvSDJ143163;
	Mon, 12 Jan 2026 12:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u46yPLnb5CC0WJO1DamW1uhThHo8VD0/pAao/V+YdzY=; b=
	pv6SvPHHKIHy1xPDhaAbEIT/iYcx8VS+XwPqX117yqCaXYGZM9/aRNrLz2Ww/hmH
	TN+6PJbkp+mrvg0MvbbzA18I9UjPTfavrKirqiiSOu8FuMCpUKg5hcTtDAjqrncM
	1KUS1gFftNcXf/Y1wqYDJvc8MjQo8KR0Ng13+GVaxWC4kjxmjy8sUrHo3v9ckviM
	76+VeHqAPWFLwBrizfWlrJRuEjXQevNuOcPiW1z2MCu6N93kNQhMnFsCzMwZtaPc
	g2c7omPfTp73h704FI8109gZAHRVT97H1gzeo2m4NdSc0BE1ZGFLjPP1thh6eI+W
	rnblKHd3uUFRPQSylhxG5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrgnsh8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 12:07:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAR9Uo004173;
	Mon, 12 Jan 2026 12:07:06 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7h480b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 12:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiQG5rxcCfhqkZsBQoFD3f91HO0L6kRwIWIGzON0tA1chBXJm/OwYpAcSmwgW92Z9yxZo/5ToldWmfPC1CoT66t+A6uPD+C1zyRnK4s9phhrOQy1EaqXMCM8Tgc5uIuPUxa3x2jBT0avVyTERXGPJS2SSDfHD7SEQJeYXKoObX39vsILJL6gZOt25ZMnT2U3QHSq/eFfdKnBhqhhm60kiLs420UvRDikTe1O12Zkns0tq4hLtURohZDlY6awuHEnhzsYsDkrz1ac/eO9YI1Jruu8itUaV8hNkMxoqU14nmYFAcrqON+VHqT4bjsr0WE7gTvqmb8plGKBS1yIdKMfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u46yPLnb5CC0WJO1DamW1uhThHo8VD0/pAao/V+YdzY=;
 b=Xte9twZWBVZKPZsg4uEHjd3IIg46uItv57a9TInaHWu3qI2nG9QMEnTLDcRElbTxEN18um9YPDKt8gqr/F/DEC2m17r2BQZsJPKqJc5gDKpKSHuO/8JCFNEuC3rOVvPp0YipW5Nlj80lS403ImSNoL9rrTPcW1rWMgW58NtjAirkhJIJEhfl57lLEYqyApCytrAKh3TG72VulIictu13pp8tD2Q1ObcQPhJnsy7Dr3GvC4zU9QVjzD2+XguX4CFossQs3JDH1+T/zb5eijf6ej4HT8nJtJ+V4EomXaC9rABP4ovHkFpmZ4L57eZ8RwQ+D6N3SPot2w+9Rlt8aejXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u46yPLnb5CC0WJO1DamW1uhThHo8VD0/pAao/V+YdzY=;
 b=d6vzpOhytdERRvjY56cVqVCwrwtY6a9HF5hYj32aO25s/RNN66urg+HSP5Mvp3q9UPIYwWBQOmflXO/w83JJgAWoCwjtwA4KBj/f4tFjnsuYd71npdHsSg2w+axqC7iAz+Xz3LMfvKVBLTx3/TcZIoA4J7vhAIkLbaFhGN/RtGs=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by LV8PR10MB7966.namprd10.prod.outlook.com (2603:10b6:408:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:07:01 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 12:07:01 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
        Casey
 Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        dingtianhong <dingtianhong@huawei.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Alexander Duyck
	<alexanderduyck@fb.com>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Topic: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Index: AQHcZfNx6ACq7R62xkiLgv89EFhEMLVHjPeAgAE2mYCABehmAA==
Date: Mon, 12 Jan 2026 12:07:01 +0000
Message-ID: <EF44D08B-F7CC-41A1-A7AE-39A392182322@oracle.com>
References: <20260108175345.GA490809@bhelgaas>
In-Reply-To: <20260108175345.GA490809@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.200.81.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|LV8PR10MB7966:EE_
x-ms-office365-filtering-correlation-id: 07c45750-d8f3-4018-726c-08de51d317d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlJyeEQxdlNuN0hneTJWc29mQk11bFF1TUQwSnp3RGk5enBlUHZoOHRCblVn?=
 =?utf-8?B?VG1sdVFkRGZrZVZvaUdmTkx5Q3ZMYVVhZHorcEhZNDdYaG90cUVudGdtVXZ6?=
 =?utf-8?B?M3N0N0RFOVBKUDVKMjhJOXE0aWY1Y2gxZ2orK1d4NzI1MHhHeVhINjRUY3VJ?=
 =?utf-8?B?WUxRQ28yMFcvNEhyUGdSOG9UY0M2UkxETDRibHExM1k1emtwc0RDakgwNDI3?=
 =?utf-8?B?K1Z4bnVadm5KZWhlOFlDaFRkU2c0L2NiL1E5UG5zejlLZkZZWHYxTDhqVnZs?=
 =?utf-8?B?bVBPWk5FSTdGQXQ4RGFFOWNyRzQ2VEhtSHVqWjlpMGpSczMxOWNLQVJscWdW?=
 =?utf-8?B?aGNZek1qcGhaeFpoaS9ySFQ2aEdQSG12SEk1VmlpbStyN0psMm13amQ4OFY3?=
 =?utf-8?B?bzAwVEkzd1JEWUVvNWJFekpZcGNNY2JJR3EwWHpMby9xaW5QQ25RMVhKYjYr?=
 =?utf-8?B?M2NWYnZtd0tBd2hiMkpReEJxR1hMb2lYSnFaNGhkWUJPU2c2OXBvU2VpRk9M?=
 =?utf-8?B?RjBvQngya3lPWlByV1RaWnpxbU9TQjAwby82MW1iSFdVbklaNVFuSHBrWUZ5?=
 =?utf-8?B?NGJkVW0yL3Y4SXNUWWptRy9ja25JTVdDOThpMWJ0RmZNekNnL2czTkl2ZlVw?=
 =?utf-8?B?TVRnK3RuSXQyZTlaaGxHTEVOc09mOFlSb080UjI4NGxtbC9UazAzWmRmcGRs?=
 =?utf-8?B?bXlMYUFTNFhaWEVaMFJMOTR4ZlpjbmNjMHdSRkExa1FkUWJyUmYyWjlGM3Ju?=
 =?utf-8?B?UDR4MXdVMlAreXN4SDhIK2c5YlBpYlorQnBqU2IxVlRiWWlHakErTmhLVkpE?=
 =?utf-8?B?azVRMnVCSm1JUkxuRy9YKzZhSHpTMGp3Z3lYaHJFMGx5emwxTnRZNkR4MHh5?=
 =?utf-8?B?WmZoYnlvWjBzV2l5ZThHWFNjRjlQQ1g5WDg2TEtta1FrMkZVYXo0M3hYV2RY?=
 =?utf-8?B?cWFWeE1KVEFsTVowZDFzK0tjOW5GRklyUitmdGl1MkpoNlAyODV5NzViOGwv?=
 =?utf-8?B?aGJ0L0RKcjUvZ1E1czFUK3dyYW5JU1lwSENsUFAyQjJ5Qnd6OTZqMEtPZlN4?=
 =?utf-8?B?VEhmV3dXMDV3NnF2cTY0L2ZsOUxVaXYzU3dWMFZwWlNyNHNxcjNlbkY3bDR2?=
 =?utf-8?B?VGE1blJxb05HbjIyODI3Zlk1cFhTcWNtcHpFZVI0MXBzMnZ4RVdOWEtIcldx?=
 =?utf-8?B?WG1aQS9OK2cyVjJQOHVEY1ljOURCTmRGWHZvVHlxRWEyOVVtVTFVUjhLQ3ZI?=
 =?utf-8?B?RmJFQUhOVmswYzRGZEVCeERNY0ZpQXpueU1YUGtKV2lLcFhRbmY1bVJrdkRo?=
 =?utf-8?B?NENBRG5UYlV1YVFlZVhVdHVtTld1MXJUNXRHQlBYRGJvejBaOEdEOXE2K2ov?=
 =?utf-8?B?cUtkdG8xSHN3MVcwTFFWcHZXbDBJZitNckRZbUZnQXNMK1o5c0s1bGovNDFl?=
 =?utf-8?B?Rjc3ZXh2R0pIcXFSYmNHbk05NXZRYXZJSndmTFIyUldhc2JSMDhqOG9MdHM3?=
 =?utf-8?B?RFdpNjNaL2NuYm1UVWQycGxhU0dUQlpjeU9sQzZmTFl5Q09vc052N3J5ZHIw?=
 =?utf-8?B?QVhXdVlkdlVFa1lVaU42V1VMTmNIZFUwVDFkbXZGcWlJdG9QdUx3ZmJIcURG?=
 =?utf-8?B?bVh3TVQxN0xoa2s3TjRDNmFOZFErRDUrWlZ3dEVTdC9PcW9oSjN6OGhuSEsz?=
 =?utf-8?B?cDZxNmRYaEQzVXNrbVlsQzYzd2FpdC91a2hUVFN3N1VMdWxBeGJLc1NQTTRU?=
 =?utf-8?B?ampUVVNSTUFBVHluYUhlR0lJTjhrN2grRU1sQzdqWlpYNnZHdU9IOFNuUzlW?=
 =?utf-8?B?Tk1yRnRyRVRyT3pkNHhnTFphZjZMNXh6cEZmaFkwUWsvVStkMkNlN240cWFq?=
 =?utf-8?B?QnNoTS9qN0JDUVNoUnFhNjRkWC9IRFNoejh3K0EzNndKSVlYMnBkMFZ5WlVG?=
 =?utf-8?B?NjdGTHpHQW40NXowdWgycW5FNlQ1eGNWS3ljVW5DQi94c1Z6YkE5dGVHL1Zs?=
 =?utf-8?B?MElPSWxRN3lEcUMveGhxRmc1dWtkaUxUaG5YMFQvMkQ4aUhXbGd2dmJuY083?=
 =?utf-8?Q?sDhxuN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFJaZ3BjMjVSNjJGS1lvZHYvcGVVOU42d3NRRjlNOFZIalE3cEljU01LOHN5?=
 =?utf-8?B?RUJJdTE3U0p2SVY3ZSsyUXdHWkduYUJkM2Fka1JPUWdIVkhDY25qWU44bDht?=
 =?utf-8?B?YnZhN0ZtdUZzTWRlTVFkLzJyTGJQeW1uV1FsbHZyMFMvc09BeFFIblUrQ0hw?=
 =?utf-8?B?eG93S3ZDd2FuaWNuWjdheTFIZ2hCeXVoQnQvRHhWYUdlbFlWcG1OY3VWRGl5?=
 =?utf-8?B?RURJNFhkQlU4VWE3THRScTZRQVU0V2Z2UEtKd1hJeldRTWwrb3g5WTlDbjB6?=
 =?utf-8?B?ejV1ZllXTjFxb2JmSlp1MS94YW9yc2RUdFpTZStsNHdrSFd3dVg5TTJPajRv?=
 =?utf-8?B?VGdhK3QwZ3lCY3M2bE43QkRndy9mOXgvbGcvcjNkY3dxYlhMUWRlU2d0bGRC?=
 =?utf-8?B?U2tRbVlsZlZDVGlPVnJOSUpNaXB1MGdUYm5YcmxRV0FjTnF2SXNGUWhpbXAv?=
 =?utf-8?B?REx2TE9mdnZIT3lEYWJCMk00NWppSWJLTVBMRHRIV0xOTXJqbFRSQ3dpYmc4?=
 =?utf-8?B?Q3l3OStpVExuMkFQdExYRDU0Z1h3U0dFZjNnZHI0aWttUkZJclpUTi82Mll4?=
 =?utf-8?B?Tjd5bCtkVUF4V1JvTXpRV1l5TkVneEF5YXRtcVlMZU1uSFJaWGtrUi90WkNN?=
 =?utf-8?B?eU02SkRoY1YycmdIMlplN3VHVUdNVlJyV1ZsWjlweHQ5amJ1dE5NSVU5S0dV?=
 =?utf-8?B?K25YZVFYTW9uRzc2eUEyK1hVVjAyOUNRSXoyMUZEQWVRNFdlbzQ2Y2xrY0hw?=
 =?utf-8?B?TlJjczIrdTBReDFBRlo0UlNHcmpOb1F5MXNMYlJFU1J3Ym5GeFJaNU5tOWdI?=
 =?utf-8?B?T3dUUVE3ai9hOWhCMmc3Q0JQa2szdnU3bVErTUFQazZJKy9vR2djWkJhUnVS?=
 =?utf-8?B?WUpIMlFTcTBFNDRBM3RseDdGV0cxa212NmdSTEV2S1k5Y1ViSEZ0U3Fnam9Y?=
 =?utf-8?B?Tm9GdWxndVQ0NEtiUXdBb01VcHBNRkVRb21TcTdqKzFCYk0wZTRtalI2VGlh?=
 =?utf-8?B?c3RNWUZ1UXI3MW1pR2ZjWnIxOVR6RExJR1FjSzVOUTg2L29hcTlSOVcxSzJJ?=
 =?utf-8?B?MEI5a0dKVFVjMEExR00wM1hwa1l1SDdWOFpVTGMwMGxubWc0MkgwOVI1aHcw?=
 =?utf-8?B?c3VQK2hneGx5SkFmb1BaeENQQTd4VEw1NTJIZ3VUekJodng4R0lDUlQwZHor?=
 =?utf-8?B?NXF2S0c0Y0krQWFyeXpSSTRnSmdQOWMwaHEwZlk1bDgveC9ZTnc3U2JIWFhJ?=
 =?utf-8?B?czZGK25CNUJLaEFCbXFVZytZS0djTDdRcE1QQmtjVU91cG5DbnBtQU5WbzNN?=
 =?utf-8?B?dTJVVWEreVl4NmZ4SlNJRVpBT2k4V0t1TDM3VjlOWnpDU0JjK3kwdmxLYm5q?=
 =?utf-8?B?cGtDcVFJSFlWa1o0UnRQYmJHUW9MMnJNbHJ2dmhmVnU1TVFUWGxUUVB1Rjhi?=
 =?utf-8?B?b3NoODZmMElHUVNaU0J5NFpjekFndDZ6MnI3UWF1TUxhSGptODZDMlA3eGdy?=
 =?utf-8?B?SVI2MDN2RG5BUzdLZzJmVEd2ZUNXTFVDcjJ6d2xpOGdra0pxejVUdlplcDhp?=
 =?utf-8?B?cWdrbUYyYzBJOHZJdTJzQVZKYmZ5V1lhbDM3L25BV1I5TTh6Q05Wd3Z1NUpR?=
 =?utf-8?B?N2xJcm9pQ3NycWdFM1RUdkxmWm1vZXZLZUVheGV2eWdtUGZwZXVkcW5hWU5i?=
 =?utf-8?B?WWc4enpjRXljeUc5Z0dVQzkxdDZvVitQQ3B1dUJFZXd0azlIbXl3SDJ0SWgy?=
 =?utf-8?B?SzBmKzlvaXd2MEMxNHBqTFJBblhRN3RIR1ZqeWhHVHZKNTdMdjhoMGx4NG54?=
 =?utf-8?B?VUtCc0lZZWRIMlVodkxZZElCUHk0Nys4c21odHNMOVpaV3pIUlNWWTN3Z0E4?=
 =?utf-8?B?MnJSbEVBUFVPMXFKZHRXQm50aHhoMElkRThFbm5kMkh1anU4T01zZ2k1aXVl?=
 =?utf-8?B?ZnlNL3p5VW5WOUIxNVJsUVdnaGsrcGxoVUx1U0Y0M3RZNnk4WFpxbXR5YWZr?=
 =?utf-8?B?RjdDN05yVXRhazFmckZpdEh6SlBiOXJDcDJ3K2FHT2FJamVzLytXdnNpSWtY?=
 =?utf-8?B?a0UvdE9kMTQwRU9OOHhrZ3F2MmlNeXFvTWsxRVZWdGFETHRHaVFBb1Vld1dx?=
 =?utf-8?B?M2VJNkt0SXlRMlZ3c2REOHhLYzlNZURHTk14RFQ5S1ZXRExtR1lmNlV4TVNa?=
 =?utf-8?B?RWZTSzJLbGE2L25NWGk1ZUUwYzVDWFJHWHU2NkZTM3d3V2xLMGs4MThpT2w5?=
 =?utf-8?B?Ymo5OGV0OXREUGNWOUJLek5TZ3kvNWVrekQ4UFpjUmVneWxVUklJYnFCQng4?=
 =?utf-8?B?aGZsdTIvR0VKdmhkcnJLM1NabnZ1MDRSTkhpS3JCL0JIcnFYR3NKNHJPZ2Jz?=
 =?utf-8?Q?XDyCR/zpE9FJbAwA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <908449EF9C7FF54F94FFBD3AAF4D4194@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5VbED0Ee1KQj8yvieraOIoHpKDncHP/YAsqI/o34PSpTEK+0cZUcU//+uAD2HqggneomwJilur7f0rHYl8Akz2OdgrddhXGrMx/yTEzmTClJbtdYy2KOnsz1PvtnG6glHD2HMQ80T09+yIqPMCwUGV8WyGc+CgCdckV4yuzFAFOBk58OHj0estZF3tzbJGWYUJhxIa1vZsNp1CzthSSLMcurJkww9r6F9iabuXI/Hel3/qu2NM0FIw98hETL/pW7qHnd3QSf+3JftfdP8GUcB83nwILGbIj8nDqqxyH5K8xWAU6qwAFGkPbIoPC7hKjhb0N6hosyb52YfQF3HZqUGarU3mF5KvliR05xi+ShHzQ2tnCIRo6O0gQ9acBCDFERyrYQisTDntn3vm8R0zUxpoqQ5IeAz4Go+63JMLk/ROObnhuc9HyTL0bqdEWX8njBHQCCqz2U8cYReyHdpyj/Cx7MtBZYk1aszandl4ChPPSg0L84ePOAUtWfnicL8I6HJQBkQXhKxN52No3ECKTs+aaLAtNDRUQZnx+edKh323aNWGGipLAy5gx6goNz9MDtnODwIWd7AHI2IXZ/AVTpLP6aAJ+oupsUuxEaAxMR0C0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c45750-d8f3-4018-726c-08de51d317d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 12:07:01.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrNqcbCtX7YzWazU5eEokUdYfDpzUkq4gO9z0hC9ou2WmUatP1laJCppNTVilMJCbDWoKjbmLO3Bq+LZs+BBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120096
X-Authority-Analysis: v=2.4 cv=B/G0EetM c=1 sm=1 tr=0 ts=6964e3eb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=S7gPgYD2AAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=h76EqgP_y54LxknX8AIA:9 a=QEXdDO2ut3YA:10 a=1f8SinR9Uz0LDa1zYla5:22 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: hEcPZ_hEJy04B29wYQf8w3Y3yEEF7I4e
X-Proofpoint-ORIG-GUID: hEcPZ_hEJy04B29wYQf8w3Y3yEEF7I4e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5NyBTYWx0ZWRfXyx3SveiyU0Ra
 9cdjppHM4KGR9fP751knTD37oPQm0pxY5ZKsJe+hqZRTW9l3Q6uKxItK6qtOTCwMj+vf3uUUdE+
 x7bIaKoUeN1ul2MbrkYcnkZFuGHtAd+a/FK5slZQ8AcWjLNTZD50C5zcbZOn6GX9zYD1CkLCEzA
 xy+wpxeIyGTGUUTt7b1H3cjdNDGa4oZUP1Rf3T4GWXLfe2+sq6suJbFQVjiwdwrDxYCQ5qvTYc/
 EbGOZAJVBxHWcjUhK/ytJhkkvCQlymumLUnpFznTg58Uq7YXMRlGga41+r6LDb4I8dQVvX00gR7
 epkyNHqO3r0ehA5SftnNa78tB7LsUyDKZ8R6DppC8PTukwc9TTr6ZQY2kkJ9o7cX84amHb5dJa/
 DCBl/zA7Z54nJKnKWTr06Ct4tVKPtVI6/2eYERxoHNpifiuIOBuxQhsxHysWwNqhGBSXhaTjFwV
 8JrKTF5Zrsmr67MlwUHRlcgn4nhbErr+ir77+FWI=

DQoNCj4gT24gOCBKYW4gMjAyNiwgYXQgMTg6NTMsIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEphbiAwNywgMjAyNiBhdCAwNToyMjowNVBN
IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPj4gT24gRnJpLCBEZWMgMDUsIDIwMjUgYXQg
MDM6Mjg6MjlQTSArMDEwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4+IEFmdGVyIGNvbW1pdCA2
MGRiM2E0ZDhjYzkgKCJQQ0k6IEVuYWJsZSBQQ0llIEV4dGVuZGVkIFRhZ3MgaWYNCj4+PiBzdXBw
b3J0ZWQiKSwgdGhlIGtlcm5lbCBjb250cm9scyBlbmFibGVtZW50IG9mIGV4dGVuZGVkIHRhZ3MN
Cj4+PiAoRXh0VGFnKS4gU2ltaWxhciwgYWZ0ZXIgY29tbWl0IGE5OWI2NDZhZmE4YSAoIlBDSTog
RGlzYWJsZSBQQ0llDQo+Pj4gUmVsYXhlZCBPcmRlcmluZyBpZiB1bnN1cHBvcnRlZCIpLCB0aGUg
a2VybmVsIGNvbnRyb2xzIHRoZSByZWxheGVkDQo+Pj4gb3JkZXJpbmcgYml0IChSTyksIGluIHRo
ZSBzZW5zZSB0aGF0IHRoZSBrZXJuZWwga2VlcHMgdGhlIGJpdCBzZXQgKGlmDQo+Pj4gYWxyZWFk
eSBzZXQpIHVubGVzcyB0aGUgUkMgZG9lcyBub3Qgc3VwcG9ydCBpdC4NCj4+PiANCj4+PiBPbiBz
b21lIHBsYXRmb3Jtcywgd2hlbiBwcm9ncmFtX2hweF90eXBlMigpIGlzIGNhbGxlZCBhbmQgdGhl
IF9IUFgNCj4+PiBvYmplY3QncyBUeXBlMiByZWNvcmRzIGFyZSwgbGV0J3Mgc2F5LCBkdWJpb3Vz
LCB3ZSBtYXkgZW5kIHVwDQo+Pj4gcmVzZXR0aW5nIEV4dFRhZyBhbmQgUk8sIGFsdGhvdWdoIHRo
ZXkgd2VyZSBleHBsaWNpdCBzZXQgb3Iga2VwdCBzZXQNCj4+PiBieSB0aGUgT1NQTSBbMV0uDQo+
PiANCj4+IFRoaXMgdGV4dCBhYm91dCBUeXBlIDIgcmVjb3JkcyBpbiBBQ1BJIHI2LjYsIHNlYyA2
LjIuMTAuMywgc2VlbXMgYQ0KPj4gbGl0dGxlIGFtYmlndW91cyB0byBtZToNCj4+IA0KPj4gIEEg
UENJIEV4cHJlc3MtYXdhcmUgT1MgdGhhdCBoYXMgYXNzdW1lZCBvd25lcnNoaXAgb2YgbmF0aXZl
IGhvdCBwbHVnDQo+PiAgKHZpYSBfT1NDKSBidXQgZG9lcyBub3Qgc3VwcG9ydCBvciBkb2VzIG5v
dCBoYXZlIG93bmVyc2hpcCBvZiB0aGUNCj4+ICBBRVIgcmVnaXN0ZXIgc2V0IG11c3QgdXNlIHRo
ZSBkYXRhIHZhbHVlcyByZXR1cm5lZCBieSB0aGUgX0hQWA0KPj4gIG9iamVjdOKAmXMgVHlwZSAy
IHJlY29yZCB0byBwcm9ncmFtIHRoZSBBRVIgcmVnaXN0ZXJzIG9mIGEgaG90LWFkZGVkDQo+PiAg
UENJIEV4cHJlc3MgZGV2aWNlLiBIb3dldmVyLCBzaW5jZSB0aGUgVHlwZSAyIHJlY29yZCBhbHNv
IGluY2x1ZGVzDQo+PiAgcmVnaXN0ZXIgYml0cyB0aGF0IGhhdmUgZnVuY3Rpb25zIG90aGVyIHRo
YW4gQUVSLCBPU1BNIG11c3QgaWdub3JlDQo+PiAgdmFsdWVzIGNvbnRhaW5lZCB3aXRoaW4gdGhp
cyBzZXR0aW5nIHJlY29yZCB0aGF0IGFyZSBub3QgYXBwbGljYWJsZS4NCj4+IA0KPj4gSWYgSSBz
cXVpbnQsIEkgY2FuIHJlYWQgdGhhdCBhcyBtZWFuaW5nIHRoYXQgVHlwZSAyIGlzIHJlYWxseSB0
aGVyZQ0KPj4ganVzdCBmb3IgQUVSLCBhbmQgdGhlIE9TOg0KPj4gDQo+PiAgLSBzaG91bGQgb25s
eSB1c2UgYSBUeXBlIDIgcmVjb3JkIHdoZW4gaXQgb3ducyBQQ0llIG5hdGl2ZSBob3RwbHVnDQo+
PiAgICAobmF0aXZlX3BjaWVfaG90cGx1ZykgYnV0IGRvZXMgbm90IG93biBBRVIgKCFuYXRpdmVf
YWVyKSwNCj4+IA0KPj4gIC0gc2hvdWxkIG9ubHkgcHJvZ3JhbSBBRVIgcmVnaXN0ZXJzLCBhbmQN
Cj4+IA0KPj4gIC0gc2hvdWxkICppZ25vcmUqIGJpdHMgdW5yZWxhdGVkIHRvIEFFUi4NCj4+IA0K
Pj4gTW9zdCBvZiB0aGUgcmVnaXN0ZXJzIGluIFR5cGUgMiBhcmUgaW4gdGhlIEFFUiBDYXBhYmls
aXR5LiAgRGV2aWNlDQo+PiBDb250cm9sIGlzIGluIHRoZSBQQ0llIENhcGFiaWxpdHksIGJ1dCBp
ZiBfT1NDIGhhcyBncmFudGVkIEFFUg0KPj4gb3duZXJzaGlwIHRvIHRoZSBPUywgdGhhdCBpbmNs
dWRlcyB0aGUgRXJyb3IgUmVwb3J0aW5nIEVuYWJsZSBiaXRzIGluDQo+PiBEZXZpY2UgQ29udHJv
bCAodGhlcmUncyBhIFBDSSBGaXJtd2FyZSBzcGVjIEVDTiB0byB0aGlzIGVmZmVjdDoNCj4+IGh0
dHBzOi8vbWVtYmVycy5wY2lzaWcuY29tL3dnL0Zpcm13YXJlL2RvY3VtZW50LzIwNTE0KS4NCj4+
IA0KPj4gVHlwZSAyIGRvZXMgaW5jbHVkZSBMaW5rIENvbnRyb2wsIHdoaWNoIGlzIGluIHRoZSBQ
Q0llIENhcGFiaWxpdHkgYW5kDQo+PiBkb2Vzbid0IHNlZW0gcmVsYXRlZCB0byBBRVIsIHNvIG1h
eWJlIEknbSBvbiB0aGUgd3JvbmcgdHJhY2suICBCdXQgaWYNCj4+IFR5cGUgMiB3YXMgaW50ZW5k
ZWQgdG8gaGFuZGxlIHRoaW5ncyAqb3RoZXIqIHRoYW4gQUVSLCBJIHdvdWxkIHRoaW5rDQo+PiB0
aGUgUENJZSBDYXBhYmlsaXR5IFNsb3QgQ29udHJvbCBhbmQgUm9vdCBDb250cm9sIHdvdWxkIGhh
dmUgYmVlbg0KPj4gaW5jbHVkZWQuDQo+PiANCj4+IFNvICptYXliZSogcHJvZ3JhbV9ocHhfdHlw
ZTIoKSBzaG91bGQgbWFzayBvdXQgZXZlcnl0aGluZyBmcm9tDQo+PiBwY2lfZXhwX2RldmN0bF9v
ciBleGNlcHQgUENJX0VYUF9ERVZDVExfQ0VSRSwgUENJX0VYUF9ERVZDVExfTkZFUkUsDQo+PiBQ
Q0lfRVhQX0RFVkNUTF9GRVJFLCBhbmQgUENJX0VYUF9ERVZDVExfVVJSRT8gIEkgaGF2ZSBubyBp
ZGVhIHdoYXQgd2UNCj4+IHdvdWxkIGRvIHdpdGggTGluayBDb250cm9sIHRob3VnaC4NCj4+IA0K
Pj4gSSB3aXNoIEkga25ldyB0aGUgaGlzdG9yeSBvZiB0aGlzLCBidXQgSSBkb24ndC4NCj4gDQo+
IEkgcG9rZWQgYXJvdW5kIGluIHRoZSBvbGQgc3BlY3MgYW5kIGZvdW5kIHRoYXQgX0hQWCB3YXMg
YWRkZWQgaW4gQUNQSQ0KPiByMy4wLCB3aGVyZSB0aGUgVHlwZSAyIHJlY29yZCBvbmx5IGNvbnRh
aW5lZCBBRVIgcmVnaXN0ZXJzDQo+IChVbmNvcnJlY3RhYmxlIEVycm9yIE1hc2ssIFVuY29ycmVj
dGFibGUgRXJyb3IgU2V2ZXJpdHksIGFuZA0KPiBDb3JyZWN0YWJsZSBFcnJvciBNYXNrKSwgYW5k
IHRoZSBkZXNjcmlwdGlvbiBzYWlkIHRoaXM6DQo+IA0KPiAgT1NQTSB3aWxsIG9ubHkgZXZhbHVh
dGUgX0hQWCB3aXRoIFNldHRpbmcgUmVjb3JkIOKAkyBUeXBlIDIgaWYgT1NQTSBpcw0KPiAgbm90
IGNvbnRyb2xsaW5nIHRoZSBQQ0kgRXhwcmVzcyBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcgY2Fw
YWJpbGl0eS4NCj4gDQo+IEFDUEkgcjQuMCBjaGFuZ2VkIF9IUFggdG8gdGhlIGN1cnJlbnQgcjYu
NiBkZXNjcmlwdGlvbiBhbmQgYWRkZWQgYWxsDQo+IHRoZSByZWdpc3RlcnMgaW5jbHVkZWQgaW4g
cjYuNiAod2l0aG91dCBjaGFuZ2luZyB0aGUgcmVjb3JkIHJldmlzaW9uKS4NCj4gDQo+IFNvIEkg
dGhpbmsgd2Ugc2hvdWxkIGRvIHdoYXQgSSBwcm9wb3NlZCBhYm92ZSAob25seSBkbw0KPiBwcm9n
cmFtX2hweF90eXBlMigpIGlmIHRoZSBPUyBvd25zIFBDSWUgaG90cGx1ZyBidXQgbm90IEFFUiwg
YW5kIG9ubHkNCj4gdXBkYXRlIHRoZSBDRVJFL05GRVJFL0ZFUkUvVVJSRSBiaXRzIGluIERldmlj
ZSBDb250cm9sKS4gIEkgd291bGQNCj4gcHJvYmFibHkgbG9nIHRoZSBMaW5rIENvbnRyb2wgdmFs
dWVzIGlmIHRoZXkncmUgc2V0LCBidXQgb3RoZXJ3aXNlDQo+IGlnbm9yZSB0aGVtLg0KDQpPSy4g
SSBtdXN0IGFkbWl0IEkgd2FzIGEgbGl0dGxlIHB1enpsZWQgd2hlbiBJIHNhdyB0aGF0IHByb2dy
YW1faHB4X3R5cGUyKCkgd2FzIGNhbGxlZCB1bmNvbmRpdGlvbmFsbHkuIExldCBtZSB0YWtlIGEg
c3RhYiBvbiBhIHYyIGZvciB0aGlzLg0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IA0KPj4+IFRoZSBB
ZHZhbmNlZCBDb25maWd1cmF0aW9uIGFuZCBQb3dlciBJbnRlcmZhY2UgKEFDUEkpIFNwZWNpZmlj
YXRpb24NCj4+PiB2ZXJzaW9uIDYuNiBoYXMgYSBwcm92aXNpb24gdGhhdCBnaXZlcyB0aGUgT1NQ
TSB0aGUgYWJpbGl0eSB0bw0KPj4+IGNvbnRyb2wgdGhlc2UgYml0cyBhbnkgd2F5LiBJbiBhIG5v
dGUgaW4gc2VjdGlvbiA2LjIuOSwgaXQgaXMgc3RhdGVkOg0KPj4+IA0KPj4+ICJPU1BNIG1heSBv
dmVycmlkZSB0aGUgc2V0dGluZ3MgcHJvdmlkZWQgYnkgdGhlIF9IUFggb2JqZWN0J3MgVHlwZTIN
Cj4+PiByZWNvcmQgKFBDSSBFeHByZXNzIFNldHRpbmdzKSBvciBUeXBlMyByZWNvcmQgKFBDSSBF
eHByZXNzIERlc2NyaXB0b3INCj4+PiBTZXR0aW5ncykgd2hlbiBPU1BNIGhhcyBhc3N1bWVkIG5h
dGl2ZSBjb250cm9sIG9mIHRoZSBjb3JyZXNwb25kaW5nDQo+Pj4gZmVhdHVyZS4iDQo+Pj4gDQo+
Pj4gU28sIGluIG9yZGVyIHRvIHByZXNlcnZlIHRoZSBpbmNyZWFzZWQgcGVyZm9ybWFuY2Ugb2Yg
RXh0VGFnIGFuZCBSTyBvbg0KPj4+IHBsYXRmb3JtcyB0aGF0IHN1cHBvcnQgYW55IG9mIHRoZXNl
LCB3ZSBtYWtlIHN1cmUgcHJvZ3JhbV9ocHhfdHlwZTIoKQ0KPj4+IGRvZXNuJ3QgcmVzZXQgdGhl
bS4NCj4+PiANCj4+PiBbMV0gT3BlcmF0aW5nIFN5c3RlbS1kaXJlY3RlZCBjb25maWd1cmF0aW9u
IGFuZCBQb3dlciBNYW5hZ2VtZW50DQo+Pj4gDQo+Pj4gRml4ZXM6IDYwZGIzYTRkOGNjOSAoIlBD
STogRW5hYmxlIFBDSWUgRXh0ZW5kZWQgVGFncyBpZiBzdXBwb3J0ZWQiKQ0KPj4+IEZpeGVzOiBh
OTliNjQ2YWZhOGEgKCJQQ0k6IERpc2FibGUgUENJZSBSZWxheGVkIE9yZGVyaW5nIGlmIHVuc3Vw
cG9ydGVkIikNCj4+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBv
cmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGRyaXZlcnMvcGNpL3BjaS1hY3BpLmMgfCAxNSArKysr
KysrKystLS0tLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2ktYWNwaS5jIGIv
ZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPj4+IGluZGV4IDkzNjkzNzc3MjVmYTAuLjZhMmFlMWI4
MjE3MzIgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPj4+ICsrKyBi
L2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMNCj4+PiBAQCAtMzI0LDE1ICszMjQsMTggQEAgc3RhdGlj
IHZvaWQgcHJvZ3JhbV9ocHhfdHlwZTIoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IGhweF90
eXBlMiAqaHB4KQ0KPj4+IHJldHVybjsNCj4+PiB9DQo+Pj4gDQo+Pj4gLSAvKg0KPj4+IC0gICog
RG9uJ3QgYWxsb3cgX0hQWCB0byBjaGFuZ2UgTVBTIG9yIE1SUlMgc2V0dGluZ3MuICBXZSBtYW5h
Z2UNCj4+PiAtICAqIHRob3NlIHRvIG1ha2Ugc3VyZSB0aGV5J3JlIGNvbnNpc3RlbnQgd2l0aCB0
aGUgcmVzdCBvZiB0aGUNCj4+PiAtICAqIHBsYXRmb3JtLg0KPj4+ICsgLyogRG9uJ3QgYWxsb3cg
X0hQWCB0byBjaGFuZ2UgTVBTLCBNUlJTLCBFeHRUYWcsIG9yIFJPDQo+Pj4gKyAgKiBzZXR0aW5n
cy4gIFdlIG1hbmFnZSB0aG9zZSB0byBtYWtlIHN1cmUgdGhleSdyZSBjb25zaXN0ZW50DQo+Pj4g
KyAgKiB3aXRoIHRoZSByZXN0IG9mIHRoZSBwbGF0Zm9ybS4NCj4+PiAgKi8NCj4+PiBocHgtPnBj
aV9leHBfZGV2Y3RsX2FuZCB8PSBQQ0lfRVhQX0RFVkNUTF9QQVlMT0FEIHwNCj4+PiAtICAgICBQ
Q0lfRVhQX0RFVkNUTF9SRUFEUlE7DQo+Pj4gKyAgICBQQ0lfRVhQX0RFVkNUTF9SRUFEUlEgIHwN
Cj4+PiArICAgIFBDSV9FWFBfREVWQ1RMX0VYVF9UQUcgfA0KPj4+ICsgICAgUENJX0VYUF9ERVZD
VExfUkVMQVhfRU47DQo+Pj4gaHB4LT5wY2lfZXhwX2RldmN0bF9vciAmPSB+KFBDSV9FWFBfREVW
Q1RMX1BBWUxPQUQgfA0KPj4+IC0gICAgIFBDSV9FWFBfREVWQ1RMX1JFQURSUSk7DQo+Pj4gKyAg
ICAgUENJX0VYUF9ERVZDVExfUkVBRFJRICB8DQo+Pj4gKyAgICAgUENJX0VYUF9ERVZDVExfRVhU
X1RBRyB8DQo+Pj4gKyAgICAgUENJX0VYUF9ERVZDVExfUkVMQVhfRU4pOw0KPj4+IA0KPj4+IC8q
IEluaXRpYWxpemUgRGV2aWNlIENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4+PiBwY2llX2NhcGFiaWxp
dHlfY2xlYXJfYW5kX3NldF93b3JkKGRldiwgUENJX0VYUF9ERVZDVEwsDQo+Pj4gLS0gDQo+Pj4g
Mi40My41DQoNCg0K


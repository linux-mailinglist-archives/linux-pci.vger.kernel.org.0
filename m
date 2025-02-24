Return-Path: <linux-pci+bounces-22194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF303A41DC9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B14E7AB1C7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324B25A2D1;
	Mon, 24 Feb 2025 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WbZzgtNW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IWA8nZxg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB425D54E
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396511; cv=fail; b=Z1P9MITTbwB8FlfDruPtVrTLDkHA8wKeTmjLuh9aorZHZ3S8E1BeMBzKOokuY88GPBjmOlFF2zQOPWOBWy2ctpL6UAxrVTxueeKmyoaessv/KYL80SMyERqXngulF0wn2BhahEph3hwlhTa7LCktLcJ0x9ehrK5hFB0ieZ5bpd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396511; c=relaxed/simple;
	bh=LN6sS7bPkSXRY0hyEmNVvqbAcgR5OacnvyutOMKhK8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bd9+/ks80NGwhI4jglRi4wz5m2GDaHDeTEOrYdjweMQMK+gHRcQX7ABopgWVW+zuPhEYM0CSGNyoCYWwvFq/YvBgcCQM44HQY3DLnwKaiZ/YT/AQCAjhy/7avV/wN6mJkWwbj78Rnvx4JVM4EhMZD2iiECjJFu0TPhC+FNoNgmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WbZzgtNW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IWA8nZxg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMmp6007222;
	Mon, 24 Feb 2025 11:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Tn2dsbJ0Tak5rvsI5QnEg25/ptahovb9OZ95LFgvi9A=; b=
	WbZzgtNWRCjjo5echF8rnvkqqFdeQDcevjf5cdWDiokp/Ib+4uPrvSGCRBllXBg/
	45ERh/o4Z/Ppj/WLQWj6NTFDiroqqzwRyhqTVHouzZXQXkVCLmFGmPapnn2Ue+r2
	LkT53usdrBe2R7R9fs9PdSafmnSrpTpCyIdL13bQlf9qJIRR/egXLxg0In2ox4ei
	XzNW9qhhvyf3wLo0jnZh32mKdR+6F81yMjl3+YUnOCtd9nwskkrie7yMPedmgHqE
	KxlujLAJLSI+4T6jdDh2BjEFvQmlkZNPbwl29xX0xBsQEodE1jYuwCZcKb0HW/Rx
	SdRCdKTZ6c/0xGu1xUlbbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gajby8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:28:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBEN7t012665;
	Mon, 24 Feb 2025 11:28:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518sh1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTAE9ToKsoLSAqwfyKXs6+spW999ngaZxoQebP7ii7LP6Vc9Ncn4cWcDhP3PHI0ctjllrOlcy4pgZW4jAJW8S0lVTtD27PhDesvmORQhEd7OB3YFlB/ah5LZ2tZWvpUK6OS64zz0ZkWGknZ/mj34BZcEO9RDFeJOYDjU03sKMyyunv8LP8a1Y96WtEZ1sfRIz1mBb6KqTfMdAiVUhY/ThiBANjXv6qDYmURqtQfWhLJS4i3sso+AsenJUzRPqFUL+f0XIJFb2EHSUzUtvU+ByoSqalXHEx6VUG3n5Xqe4lxPZWOxybj7fCrump8QKuZqPHAY6LZPMlYT2iSEeH+ogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn2dsbJ0Tak5rvsI5QnEg25/ptahovb9OZ95LFgvi9A=;
 b=sXMeEosL9cJaCxIq1BlJ8N6YTCqAZiGoXq6YGXRYjFgZAN1oGMieSI4FZuVmzBvp8VgC0WTqM3Fe46AsLXQ1KnIlq/M61GRABoDpyNzM+7SqhNmoFXXsJe/zGZQjNeHasnQpDksSVFLFQXZikxKhUF6w5eAUPniIFADJHs+KJPtSkHBuwWmlvypVwKiApII/bo8AHTI53D7/8TsdXUMzr8qIcqT2ktrBpTOw+JC9XAFD9im0BX/ICerFyeTC6LeUgGrvpBJqg96mxPT5Sp0NHCH10lrunPrNXLBedAphKQsEKlNVOFQlWtbqRdJ3Eptz0XMUt1mTsqwTCFo7pbQVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn2dsbJ0Tak5rvsI5QnEg25/ptahovb9OZ95LFgvi9A=;
 b=IWA8nZxgiM3s9xkHVlXhCmhHXh5eP+9Sk6p5my0HbME4uJxZtMnx1KFCO2BoNb4IL+i0ZjX4Cs/BpESrwBG9PF8Y1yes6c4HfrKlktqFSRMZJvXJKpuRZhDRr1EKKkm/gcjE5xmEXsJouqfiQZIVQRN3qenlIWZvKJojMOZvc5s=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:28:09 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:28:09 +0000
Message-ID: <7687b818-a0c8-46af-b87c-8722d709547b@oracle.com>
Date: Mon, 24 Feb 2025 12:28:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log
 ratelimits
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-8-pandoh@google.com>
 <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
 <CAMC_AXWYmRCQ8EWsdC-yPYsujHLZuXc7f0J_4bUuwaZgkFpP8g@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXWYmRCQ8EWsdC-yPYsujHLZuXc7f0J_4bUuwaZgkFpP8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc20421-3b16-4d0e-bdfe-08dd54c650aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG5JOG5wWVM3L1ptY1czYS93VU91WmlvSlQyUGNGTW05dE03UUM4M01iTE1y?=
 =?utf-8?B?b3EwYkF6eTVsa2ZOZ3ZnaE01NGZ0ZVRKU05tcXYzMG9HMGFBczFrUWlBMEdX?=
 =?utf-8?B?emlMZFJVTmsrR3dTVlFDRTc1WElPZTRSMXduMnFwL3VqTmovbGlzRDB4VkFv?=
 =?utf-8?B?QlRHcEZpRmMra2d4VUsxdWh2c3FsUVJDaTdKbmRPcDk5QnY0dHNTVlFzTXlJ?=
 =?utf-8?B?Nm9YbmM0QlVqS1crZENFT3RmdjF0aGphdW82Z0s1eFBIREErZWpKNW1JeXI4?=
 =?utf-8?B?Rk1QRS9nTTdtY0lpNGJlTXRaZ0tQZ1hJTGprdUk5cUJkQTQzdW5GcENGZ1VI?=
 =?utf-8?B?RldkWnFzSGw5VVZpbEJDbGJOUWsvWktTbzM4U0tWMGQxOHVURTBOMUMvQWFv?=
 =?utf-8?B?V012Y2d0UStsZGhVQWUzYjNMNGdhK01yYU1CdW9BZjFEUW51M0J6Yk1tUGkx?=
 =?utf-8?B?d21nU3o3OFhUcFNxaFFBdmk4L2NRcy80RExDaGp0di94MzJxVHowZzdLMERL?=
 =?utf-8?B?NUJqOXNHZWFPd2JVckJyK0x1c1EwUXBBVFQ2NGkyTWJlSm5BTW0zN0xhK1Nj?=
 =?utf-8?B?eG1aNVpEOElFYlJyU1dNUHFPNEdoT0ZkRFdXMytaVGpDcXVhL2ZGUTlVVWNw?=
 =?utf-8?B?MGZnUkYyRmhyZDhoa09RNjVoc3JIQWE2aTVodkZ2VVlOMVZEL1BGNmNBekZ2?=
 =?utf-8?B?QUlmYXVhR1ZHUldNZ1Biay92ZkUrT1FsQlY1bEJ3MlVlMDJ5SUZZNE4rMG93?=
 =?utf-8?B?UlpIanRtRlpzd2lLQzdlQk9JZ3Q4d2VXTzRJaVlzOUhvTXk3VTdFdlRYYkt1?=
 =?utf-8?B?Z3JvcHN4Q0JlcndLejBzRXVSWHpmVzBzdXhWMTdVNTV2SVlsUjJaWHpjRmpw?=
 =?utf-8?B?am53Y2tUVGdSZ2FvcXRYaytiRDF6SjBWZytPekZTaERtZ3ZUMjIwTGEyRk85?=
 =?utf-8?B?d2N0TU1lQUs5ZnJHME83TVMvcDhEVFFQWk9zMGRHcVdDVWp2a2M1bDNobzZq?=
 =?utf-8?B?VDNHako4cklNMEhBVzMxR3BDR3RuOGVhUGJqRGRsMU5YejlGdVBka3BFbXpk?=
 =?utf-8?B?aCsrdVozM2RPd1ZVQ2FxYnUwUWErWHJjZU1kQy91bnAyeGdiV2hVQTNWcVdv?=
 =?utf-8?B?dEF0U0QzZ0FLVEhNZHNLdHJuZkV2b2xTOTJhalJSbVZCd2M1aGowZDhyZnZO?=
 =?utf-8?B?VG9kMW5nL1NnV3JMNTA5akZEYzZScmp6QlVZVXFHQTFtWEVsNFZxRml5Z2J4?=
 =?utf-8?B?aUhMNThDM1lIdU4vdGlWZkJlU1EwRUw2cTM5bVpPTmMvUVlta3Rla2FIZXFH?=
 =?utf-8?B?RzJXOS9vOGlHQ2ZKNXJRb0daeWd1bE9GRlNXblpkdUxSODBDZURNcDJTYnZh?=
 =?utf-8?B?NXFkMDhVdTZCV1BYSnMwaHljTllsTHYvUENhR0E2K0U4UkxnS2k2R0ZnckNT?=
 =?utf-8?B?MUlFeFI5SjFHN293Z0RRYi8wczNlek1GUVpXbXZhRkJKSEo4OXpsWE5VT29v?=
 =?utf-8?B?eGU3L1o5WGpVb1prZ1MxU2dwd1hQd25aU2JuVmhOR1prcG5rbld3dkV0ZXNO?=
 =?utf-8?B?YjhrOTBNUnh6YnVPd0g3MXVMSDhvcGVZcTRsdWlsb01Vc2hlVHBnUUFNT2xM?=
 =?utf-8?B?NHZQM1gxaGZCNFRuSmZCMjFHSVJZM0k2R3ZVS0VEbUg4QXdMNittSFU4WE1l?=
 =?utf-8?B?czBYQmxkazRNY0lRTWwycjZhUTRvQ1JMbzlLbU12dExHL1NRQUZLV1ZBN091?=
 =?utf-8?B?eFdYb2hKQWpPOFhPaXhLMkhyYm96YllFNDhVTGpwdUxpeXJSYnMxWUhKbndV?=
 =?utf-8?B?enFpRkZFaVRvQlUvT1NqUW9WbytqU295UkVhODFsYk13aDUwZSs1dy9JMnFD?=
 =?utf-8?Q?OUxJV88dxN92M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akZvTkNFMGZlOElrY0ZWRVl1OW9JVE90d0FrMHdhWDYxNnRGYWNHUzl6K2lq?=
 =?utf-8?B?QjYyOXhHaU5FQzQrYWs5REJqN2taT0RyTlA0WVNsekpzUkpBMFBkeGJYZUFo?=
 =?utf-8?B?NkxERjBtNkxUb2RKVU9ia05mK0hrZExOTmh4TTNmSWxvaHo5MWgrM0NzSWZE?=
 =?utf-8?B?cVVTVDBLejBGQ0M5NHVyOUZJMml3SUN2Z0J1Ky9KZFN6cVlVdTJHZzhHV3Rm?=
 =?utf-8?B?aWhweWJLeWsrUURtMHVCNkQrVkJJSW1Fc05MYU9tclh1WlBCQmlDeFBZRCtB?=
 =?utf-8?B?aGFnbnhIc2FoVC9NZStRZG93QTJMNUFiWGNvOTd5RjBBbUIzZWF1NFU2N0RD?=
 =?utf-8?B?cVl4eVFWNkRZM2h3TTlLeEIyU2RoQkJ5aTBwRHpQY216NFBkOHI4dWF4cFFa?=
 =?utf-8?B?b0hlcmEzckdDRm1Oc1NOMWczdnZ5Z1Zpd2dCTnZWODBKRGs4bE1jeSszSEVj?=
 =?utf-8?B?YjhHVWpQdENBZWx1YkVDNmp2OUxwRUFiU0tycEZyQkprbndnZFJLbW1oT1l1?=
 =?utf-8?B?OHBxYXRremd0aEdtdUR5b3I5ODZQemx1ZzUwQzJieGRzcWtFVzkvOGUxRFh6?=
 =?utf-8?B?MmV1ZDRwWVpFMlBrQUpFbHduTVAwTlR5YWt3eURrN0VrNTI4dmFBRGcydVNr?=
 =?utf-8?B?a2w0UFlzelQyZkpnMUVzSktVYVptV0swa3dHazNOb2N6T0J2ZTMwOG9NSXRq?=
 =?utf-8?B?RmVabGFsYkFhVklTc3FsM3h3Z2hSOFl0NllOeFNLYVNDMllaVVc0ZldLZlp3?=
 =?utf-8?B?ZUR3cDUvN1Qzbm8rYVdvM3NzZ2cwMDRsMXdnRDJueStsa1NzZXZyY3l3NUNS?=
 =?utf-8?B?MHZMMmN0aTcwZllhSWlsYUVJZ0xaclhQdW5EWWZsaG9aclF6bnlpcm1wb2NT?=
 =?utf-8?B?ZDVjdEdla3hQdEVqL0pzZmkvREJvQ3hMZGJIVmRBem03QWxLTSs3Z1lxWG5H?=
 =?utf-8?B?MnJNVVoxWFJQQlVHWC92MU5BaFNlZXBta3RxMk9IaHhhWWJFU2lMeHFRcmZy?=
 =?utf-8?B?a3dOV2thYWdxUU5veS9BTVYxUmVIWFhUYk1hMDZuM2U4UkJlQTNYb0x2ZG1E?=
 =?utf-8?B?NWJ3UGhvTW9mSFZSSlFtWGJLKzMzWWNIeGFhVytZK0FoakwzZDJQazM0bVgr?=
 =?utf-8?B?eTlrTFM1WURQNnp3Mk93QTNXaFduc1pjWEQzcXd3TUVaejI3bTNmZjVDb28r?=
 =?utf-8?B?WFB0YlNPaEpJbEMrTSs2d3k3V042Z25ybVdXbGRnZGFqZ1FzVm9BR2U4cWQ5?=
 =?utf-8?B?UnZvZmI1elhscDRaTENZcmt6ME9jWjRPSDlkSVQyU20vR2xTK20rVkJMcnNs?=
 =?utf-8?B?Sy9HUTlDdjlWdDRsOG9TUXIwQjZTa2NJQVJHQXcwNkFITm5sTW8zdTNrZmtW?=
 =?utf-8?B?aVVIQjFMZ3lMRTlqNmN1N3FYY3N0OHBoNTlKZkJSd3BpWlBEV0hBNnh6VHdB?=
 =?utf-8?B?c0EvM1NIemFCRWdMVlN6NEpsRVg1QVU3VURydGU0bXlBQUgzZU1ZbWJsU0pD?=
 =?utf-8?B?UzFpUmNPYllrSnMrL3pxTnV3NTZtbmJFK3B1Q1Mxa2FPUUVLc0ZUNVM5YTll?=
 =?utf-8?B?RWpPZWJaRCtqakVKWTdiK3NEYlZtbTRxVzhtT2dnZXNRd1RCSGlLVW9teEFa?=
 =?utf-8?B?aDYvOTFpMGRXd1k4MzQ4Z05QeE1JM2ZFUHRwbnBMZHYxanMrVE5OTmFMRlhU?=
 =?utf-8?B?dUlRVFdoYlU3RXdqbmgzVnltYnNWSC9XMVZIQmVUOU5kRjZqTWxuUUdnd29p?=
 =?utf-8?B?VCtyOUdBSVM4bWxyMVpMQytlVEVXekwxQ2dsWDl6S3B5SThhSmVpSDd3dHFH?=
 =?utf-8?B?WUx1dnFPZ0ovZ3pteDFseWpSWndPbEFhRW90WmRoc2hzN29pUTFPVSt6bSsy?=
 =?utf-8?B?ZG1IeFFFWlB1eFBnbjJjbm9CSlBRQ0hOQnptUVVuUGFtMXNwSy9sdjJKNzNE?=
 =?utf-8?B?TkQ0UkVVOHhxcEhST1VUK0ZkVFk5dENxRTJsQzdTM1RYbWVjOVQzcjNrSExj?=
 =?utf-8?B?VnFNaGdhMTFVWERMUktoeW81VEVjazdnNDJtck0zSXZ3Mm8xUVpPUHo1aThq?=
 =?utf-8?B?cXB3THFQRnV2QTlNNXYyeVk0MVA0YWVyKzBrMXo4cXNyQWdiYm8wWEkwdXIx?=
 =?utf-8?B?cWkzVUZaaVF1SWZ0RWhHNklHMlBSazN0clM2UDE5QWQzN2QvdGRjaGprUkVy?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aU/+/r806FhKn43iGBGR/c1YjhdqTKapitjJmilAOptSj74Q40UXs6OpCkNdg2LsWcXwH6BteQbRXL545BHEM1nKGBD51f1Z+G0U318cPxYPO21/N2XDk+zl9gyDoVLRcDaaWLxXnnr6QvStxQDBVFpJlgIiiS8CTB/6H4hxZ5fGSaIa5qRNgOGxA+VFjM4IrNbwrc8Eqj+f/pQihFxpm5PDy26ZKApmvAQ1yNe57TMbdVNE0ftKNW4G4uLN9+qCCa25AHxu0t+a09xCLQdBmfkwH6n9ETXOy2S2lyDZqUA5N5pclGHl1Tk/BmGEbbJzGu8CvZdCGeHBffr8mtmtZHLrr4IUQ4rRCzknKQPizu6Gv0LgB69OeIj+AfR1Q16KT9G3Ol6mxIlDUYdP0ZMzeiSxLxbE05Y+4mYNjYF/w99V2oHmMtENr3x6Ddc3HcC2bbllMz9cM2m3bmX2sPn0so8Khl1E2SO5B3KwSQEl03OTqkRrNv5Y8YZrXjjrWcpew+ut1tFv2fF07qTLs47MfSGSiTpp9hj6UqVCH2Gv2oLG23gXe6e3lVwDK/NVgpykLrr0ovReT/L+yj33jV0Zb9u5jdtilRrJJiyNTRK0wBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc20421-3b16-4d0e-bdfe-08dd54c650aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:28:09.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCa2X93rqrGw6O1MXbgXm4i0bk6NEQl1InN2rNqI98tNLv75rXxKQKg5+A5YWmudQLQqdQ0L+I3Ytz6YtZYPjhzvqYFs8csIdTpOJ24SugI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240084
X-Proofpoint-ORIG-GUID: uL05fDRHfeXp3xHeyzWq7Ko99CxH_8d4
X-Proofpoint-GUID: uL05fDRHfeXp3xHeyzWq7Ko99CxH_8d4

On 19/02/2025 03:50, Jon Pan-Doh wrote:
> On Mon, Feb 17, 2025 at 5:31 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> I don't think it's neccessary to keep ratelimits in a separate directory
>> when we decided to we keep the rest of AER attributes at the dev level.
> 
> My motivation for this is that there may be more AER sysfs attributes we want to
> expose. An example being OCP Fault Management roadmap which aims to have
> userspace manage/enforce AER settings (set/get PCIE AER regs) for datacenter
> repairability.
> 
> Given the permanence of sysfs entries, I think that it is reasonable
> to create a new
> directory to make AER sysfs attributes more extensible.

OK, I see what you mean. Maybe I was just unhappy with the naming but, 
to be completely honest, "aer_ratelimit" isn't an option, so I won't 
propose it as an alternative. Let's leave it as it is for now.

> Good catch. IRQ verbiage slipped in from v1. How's this:
> 
> These attributes show up under all the devices that are AER capable.
> They allow configuration of the rate at which AER errors are reported,
> with each of them dedicated to one error type (correctable or uncorrectable).

Perfect

>> The convention is that sysfs files should provide one value per file. It
>> won't be just people interacting with this interface, but scripts as
>> well. Parsing such a string is a hassle. As we can only change the burst
>> of the ratelimit, I'd simply emit pdev->aer_report->ratelimit.burst.
> 
> Ack. Will update in v3 and add explicit mention of ratelimit interval
> in sysfs-bus-pci-devices-aer_stats so context is still there.

Good!

All the best,
Karolina


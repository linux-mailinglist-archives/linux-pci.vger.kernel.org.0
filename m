Return-Path: <linux-pci+bounces-23110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9CA567A9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83333B5672
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CB149E0E;
	Fri,  7 Mar 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ABBcCGfe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wjw8rbc9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C62219A79
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349764; cv=fail; b=nGb7wC3WySfvU1yuWgOL4ttFSANoQBHgvFkXK0MJPN6CrdbzTpEvledSdHBgickiC/06S52k+dz22cqgMHwVmhwXKfaqyPdobWfv5VI3+qFezTW7+IqqeFtSsQ2Oc6YTZ5h+SeeqRytkETqUA93g2oCam6PR2hdOvw6p4SIdVDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349764; c=relaxed/simple;
	bh=ne4UPe+SHqG6LKn0M/cRZCibPq7bGrWsqk/NF+nCeRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNjDreaCS7C7vMZgB8AkKpCxdVHxaBLd0199WhBuHz2zyG1wR8T54gocmOrZm8XjQO18SDTZob1nA6wh81Jjogf8PvIZxESTiiSpxhFjfhsqT3fPomBCcobI6zyj/TQ49gXZ6+tcoOE27dUXqAZbU4S6d4Kvk2MPpushXxKiu1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ABBcCGfe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wjw8rbc9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271tofx031293;
	Fri, 7 Mar 2025 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fDZDRsOW3ZHb/BH2jLTKF51Hco1hRiuY2mANV9EWXSQ=; b=
	ABBcCGfez7nnZ8aKeP6+w60u9LG118E6WW+rNFQ95wtakq+L+73jM/mlIF/14jPp
	SvPVZMeKfwW66fIeA10V6tHMT0PuyL+O8sPatRhZ+mvBPNLCgHTv/UY3wRKD7iGR
	XIvedW8IXtZQKfF11ssXb8H7Hb/FbrOt++v80fs7BgSd+gORoxL7TlbBTns8fKuz
	r8vPbuaT3R7g9rJXBOg7BWxFvGhg6Y2fL2mGc/+3lN7FE1RXEQog0DKyUnkDBmt7
	RHDHE8OtiCGu49lthndC5UPH3it6sVJd6rYBIAgB+eot/OrNJ0rgC2IAWidhCUKu
	r6oaWXYjX9F16wJT0Kqy0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86v0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 12:10:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5279vIj3011042;
	Fri, 7 Mar 2025 12:10:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpf271f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 12:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdmU2eT7L+h5BH8w8srBnONXEd/5t7Rzmfs2X0E4W59k89jpii2gtFg5xBHcQNff0ePtgupvI3W+dnTyxV9tkmVSvhmucah3Y2KUQcISYFEVOfxcvl4E7aJZeMQFeOwh3lu2oD1y4bR3TvW7FwsIUTR1GR7fmWKLzgi3LgkF4qViaGZYH/xV6Jm4Sg0invWQ9zF/yXTUSNytkGNHSl1DBT7bOszfcHNj6OkGHfxGhceH7/5ybcsqoCjRfQ6mihHubLXxWJqYq6qc8XyyX0GoS6wkkgmD75hp0xrKrf6Oc4H9v+FQcSiCWDoNI/a7FJXo+ixk5Q+tUpDfoQTuNSkRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDZDRsOW3ZHb/BH2jLTKF51Hco1hRiuY2mANV9EWXSQ=;
 b=dxhMWtjYsBsATTCOE4YvujNtlA0vgR2KnQs748pddlPJwwVvn7WvSWzUHL6Dr5BCbBbFqorNOgjK9MfWxG6qfUxhwSfXw1t+3JPPhtMb1RavMCGplbQQjM4VuK4sgz965DYMoG6Ku00gKWtsBfdzo+jjggFm6KApFbTLBqk16XqI13e4izUeFqPwFY60KM8hv7f7PW0WZ78V25e5/tj6CcfWWIBy9focU5fPDZaKlExR4aw4VqOfLL0Xsy6E33BLVnRvlSWI7A4NkVp+ZB7gbHdFMy450vdf5IgS+99Odc2QqEFdSV4CKdvd/aB6zuwquk8C563vBOR/kV7agAhqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDZDRsOW3ZHb/BH2jLTKF51Hco1hRiuY2mANV9EWXSQ=;
 b=wjw8rbc9ZTKCFJfvlEaYRCKICxOr1qsGqY2oStG1t7uTpf0qkpP5yHppwNQcBh4XG1XnSNVQQV/ouL9MvLhFTx8zqQD1WTPMtf6X+c5VYUS/+3WJ/QpGjucNjfxhCzZgMLgADw9WamCJ9wp8FwPM5dCX6ko1wFa3JbOsU5oUfO4=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by MN6PR10MB7423.namprd10.prod.outlook.com (2603:10b6:208:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 12:10:41 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Fri, 7 Mar 2025
 12:10:41 +0000
Message-ID: <037da68f-791a-4f04-a39c-0fde3dac5704@oracle.com>
Date: Fri, 7 Mar 2025 13:10:33 +0100
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
 <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com>
 <CAMC_AXXaxsUDkOa1SED4F6AZ8TQceHOJfQMJ8FpmQ+=gzArV4Q@mail.gmail.com>
 <49bfa13d-756e-44e6-a14d-0e4940260bcd@oracle.com>
 <CAMC_AXUZDTWeF77Zog1tTXZ2FMKmk3-cVEbc1PaWnfF3zgGQuQ@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXUZDTWeF77Zog1tTXZ2FMKmk3-cVEbc1PaWnfF3zgGQuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|MN6PR10MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 457220a0-d45f-4c83-4a68-08dd5d71141e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTJLdG53RTFoZlVET3c2V2hJQnhncUpmTEE3eGZFQUZOTitybUhUdE5vZzJz?=
 =?utf-8?B?aVZoR1l0c0t6Z0w2c1JNcHpGbG1uSmd1NitLVWpSTXpUa1lTZlFMZHI0VG1a?=
 =?utf-8?B?OFk0Q3k2RjVJaFAwVSszOEZNOWVpZ28zNU02M2d1dHlhRlJNdmhQZ1N2TFh5?=
 =?utf-8?B?VHVuZkdIU1VRbzF3S0lLQ1RtNjYxK0ZiOHk5dDgwQTlCc2RGKzkvNGw4OEsy?=
 =?utf-8?B?SlhPOFQyOWUwd2h1UE9zRTNQZEphdXkzWnpMeWZJZFNBdlRQQlpkUyt3d3VD?=
 =?utf-8?B?cE9MaFR5Y0t4RW9zL2dkUi91eE1wYkdldFBSL1FrQmFvaThDUUxsenlIQkk5?=
 =?utf-8?B?dkxEV3N4WitJZ2dzYkdRRWwzdmpQSGcyaTVrbzJxOCtEVzJ0RnhOakZlQW9H?=
 =?utf-8?B?aHZrK0dBTGcxL2w0NjlDVm90TGZCREtybDRvZy8rY2ZPUnFnc2FmVS9jK2Vz?=
 =?utf-8?B?V2VjUUgxWlRab3lxTVg3bVhWSXIzdWp4ajkwM3J1WVRXdXZZRVJHMExkTjlK?=
 =?utf-8?B?dzd6YWdZaWhORG43dGEvU1FwSXhkMkF2UzVsZStQRU9Vb3c5QVUzSnM4VFV1?=
 =?utf-8?B?ejlOamxJbDZvYlNicWRoeHl5ZzJraUJyQ2Q4VldGbDhoVW1JLys3Qjhhd2Yy?=
 =?utf-8?B?d01jTU9iUjRoQUx0V1RZRHlSc2lnaE9Vd3VhQUV2Q1FQdHFwVUJCSGVzQ25y?=
 =?utf-8?B?VVdLQmo2dmRmN3B6Y3FjM05xdjhIMGdtTUQ1UC95Q3IwYlM1eVdjdHF2eTky?=
 =?utf-8?B?N1djNW13WGdnOWZwTWR2Q0Y4ZUsxb1RiV01xREo3bFJoaTJyT1B4OGpXWEdC?=
 =?utf-8?B?SkQvWFFzMjM5WG5NYTFuTVlLeHVKZ2xlZkZ6eGtFRjl6NERHWUozaDRTQlFq?=
 =?utf-8?B?TEg2K2JjS3NmeTVxekhhekRSL2tua1h6cG9xQzZSbHpSN3diRmg4T3YxUGxs?=
 =?utf-8?B?N0k3QVZicHNaOVJiYUZLbXplbDNKMkRBMW1aRUNlYnNTOFRhbVI0MDNscmdE?=
 =?utf-8?B?TE0vWFdmMWt4V1cxUHZlRWlIMHNqdDNvT2dmZVlpTEYwYmhaWDg4ejJzMUlk?=
 =?utf-8?B?RHpEaWZzeEw5a3hEcFdZeDFjUzNpUHVOTDlwWFlGbDBGeXBSbDFqaCtyamw2?=
 =?utf-8?B?Zzk5YVRyTll3dGNPd2lBWjE2eXJhTEwxNHU5VlY3Y2dEekZGaERUSjlLczdn?=
 =?utf-8?B?OWxrL1JqY01Yb0dla2NlbW41QzhoeTQ0YjRrT2hZdDdCUjVyL090eUpGSmJT?=
 =?utf-8?B?aGNHN3d6TU4rWDdkTjk5ZnZoUjVrRytEZkZmY2VMVS9kc3pmb2VEUkZIUWln?=
 =?utf-8?B?czdxek0vVG94L05Wb2xlejZqcnM2T2x0SDV5Mk9UbGVEU3hjR21MLzl3QUJG?=
 =?utf-8?B?VGNETnkrcDNaTUR5ZVR6L0F4UTQ1QzVvQkJNYWQ0S2xaZ0FMMU14Nlc4Tjhz?=
 =?utf-8?B?K2l4OW5MVFlWL0g4TkFaTTBDNmxuMGFGaDA2Y2hWQW84ekJCNm1DSTJRbjFq?=
 =?utf-8?B?UmN1TGZTemJnSERpdFJiU0NsanZEbGdrdnNKdUd3NE5nWC9nUWtWdlFmaFE1?=
 =?utf-8?B?alR4N0t0ZGhZOWF5ajJaemtHdWlUSG05T2wvcnZjNWdORWRON0xIODlQMncr?=
 =?utf-8?B?SkViVURULzZuUCtOYWRQWXlXajl5QUt1anRtOVI3ZlJ4d0JqdlVSNFdnQjV2?=
 =?utf-8?B?Vk5kN24rek9RRmdFUGJyS1hsVWQ4TDRaUXdaSHR1ZUpQVXZ3S3hGSlZHd1lE?=
 =?utf-8?B?THVKcklReEtzME02cHFMTE1hN2V3SmtYdVJQMGEwVTFLRldScFJYUXFoRXZy?=
 =?utf-8?B?bkxHNVQrb1Z3ZlM4YjYrTUNHdzJCREE3RU03ZkpBY0cwaFQ3RHIrTmgvM1Bt?=
 =?utf-8?Q?N8LhuZjh/zY09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUxGS3JjK0UzVmxnMUF3bEdtdTMzWlF3SWNhamk4RDNFSms4czAxc21WdGFJ?=
 =?utf-8?B?Lzh6eU4vNStnWW4yT1QyUEE5L241cWZla2NRNDV6VVc4NTQ5Rmlvc2dBWTRE?=
 =?utf-8?B?NjVMRjhHMFEwMmVrb3RyRjhvcWNtSVRvcWRUd2crb1FxM21PNmtMT1FZbFhm?=
 =?utf-8?B?MHRJTUxvQXBuUi9vYVF1NFpqRmdzR01oRWxnVXBYWG1kRTJGNG4xdDFpbWhP?=
 =?utf-8?B?MnhFdnp0WDhlZVdZYzdzU3NjVEhBQkYzTEJkS3lYeHIrNEY1QU04UGtKL1hR?=
 =?utf-8?B?R1ZyQUFBYi9yS0wxRmNWOEJ5dE13enpQT0FQdUFENVUzRWd2RTRHMUFsVU02?=
 =?utf-8?B?elZRLzVCbThYOWVqc2UzMGNwelZpbGNpaTRJZWdXYW5UL3IyU3RoVE1QbmZN?=
 =?utf-8?B?dEx5bVhwTVRqYWVkaVAzNUY5TGFiQU1SR1RnNFZONWpoUGRzMkFTYktwVkg5?=
 =?utf-8?B?M1BFZlBMMzhvYlZLaFhlQ0hGc3ozNnVvcEsvODZHS0dnV3ZhTFNLei9EdG80?=
 =?utf-8?B?YzY5UUFlb1ZhV1JhTGlPMGRYL1dHZzR6Qm9hcEpCWUlPOXhDcnlTV2pLTzdI?=
 =?utf-8?B?VTlIV1pJdExISjBsVTdXdzRwNU16TlJTaDNHL2RPeFZIM2hhcVFtV3Bucmhq?=
 =?utf-8?B?R0s1eWNjclpHWkJoU2dOWWZxeE9jZFZXbndTdmZqMDk4N3greFFPbjBnVjNC?=
 =?utf-8?B?S2xKWjNCa3dCODIvVy9LemRzNis2SFpwckRlbVJDLzRka1Z0ZDY0Q1hHUGpD?=
 =?utf-8?B?MmlhR3hJbG5pQ1N3dWxZenR5c0ZVMTJVWkIyQjA0b0NIRlZwQktjWXdaUzRl?=
 =?utf-8?B?S1pybjJLSlhEazZqOXdtWDZzWVh3UWZSYzRXYnkxeFJrZHFuV25YSGdrdDBh?=
 =?utf-8?B?emVLaGliZ3RoNysrOTZTb3pGcDhKUGtXQU5oWUlZdlVrQ3NrNlRyaHp5Q0hj?=
 =?utf-8?B?dWdGeFhub0x2Ym1aN3djMC9TMmp0L2lycVQ1V1NoWmdZdmZHWElCcmVWL1l2?=
 =?utf-8?B?QjBCTFFOaHkxRHRjcmhOOXpVSjhOUnpZekd5NFNpazd4OHJJanpyVFgvbmJJ?=
 =?utf-8?B?VGpLdk1lZHo0SGdZLzBRczlMVlNoUnVIOC9EOTd4UnVSRzFvZlJqajVUeDhQ?=
 =?utf-8?B?THA4bmlObmtpcVN2MStnZEZxYm1pWm92aVNtbW5STmtuUG5SU1pRV2dNOUsw?=
 =?utf-8?B?Y0hUM3NEc0JYTzNOdG9FNmVDLzdhbi9UUEZsb3kvYTJrTjhuSUpFSU9iOURU?=
 =?utf-8?B?Q0UxT043YnEzUE1OdGMxNXNXSTFKUjhuOVk4cVJtalhrMjBqMUNKa0lRNDNl?=
 =?utf-8?B?bFRSWnVWa3BHeVNVRTJmb3dMQWVENlIvc3B2L3ZLTHJBVGk0VE9BblNzNTNx?=
 =?utf-8?B?dElSUE8zNmlEdUVSZlMwcFRNNjdFaVhqQm53cnJSemlsbWZmbDVvSlA2dGxj?=
 =?utf-8?B?OHpxVTI5RmVSbzlaalV0S2RBYWFmMTVFNkt2eEdzeGFFNC93NFVRdVluMDZl?=
 =?utf-8?B?V1RmUkJ6eG1sNVczOWdwOG52SSs3d0QvUld5cUhjRXJEOWV1YWhORVYxM2dx?=
 =?utf-8?B?ZXdlNkZtZHhXbDUzYzhFdFRxeWcyVU9Ed2JKSC9xRW9PV2JDWkVMamtrOFov?=
 =?utf-8?B?c2VtcWxEM2NwS3lZMXYrUy9LeG01VHdxcE1tTkNLc1NzQVBEZXRMb0ZmRUFH?=
 =?utf-8?B?K1pFSVZZSUlYRU55SDYzeHJCaFRGQVpIMytzNGZHeHRHSkFOQlhaL2VINDM0?=
 =?utf-8?B?bjZnOWE3bCtUdUlFNURkaHdXQ1BvanQzN290WUFadllwVFRlYXVzeDdKcGZO?=
 =?utf-8?B?WFk1K3dtM094cDRURVBCQytQQ0M3c3Z0T3AvaGt2U01rUm4rTTMvb2ZyVG84?=
 =?utf-8?B?VTM1RUkxWVVBRE9TS0oxdFZTVzhSZDdwY3dxeFVSL0J5MlovVlpvQVc5WEJs?=
 =?utf-8?B?NmV4M2gxWnFoWktSZ0ZBeThzOHJ5K3VSWFFldnpJZFhmQTliczZSZnJkL2NF?=
 =?utf-8?B?YWJTS0xMUDRoUXlzaGFhWXBhaWZZRWVjU0VqbnJqbXhUM1JlTUFoSzVMcVRN?=
 =?utf-8?B?Nk1WMWpZS0xSRXNhNm40dzdnZUIyb2F4MzlzMzJnd0pxSWFTRTZwV2wreTd3?=
 =?utf-8?B?bzBaMVRpeDdncHVpT0FDM3dUd2lJd2VwOS81b2d1VzFaZFRMOUNOb0RYR3F6?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7n4lgAg0y5c6rNbXWBHyDEdLN0Eh4ilSz5oagSy2wtFjnA9u8ZeByW4gxUCl2bjOFttdP1351Dd+088w2jKbpVMWYNXH01H9rUoICWDU0XJB4/aDXxgUwyO90aQfDDQRYi75cwOxtMLKcabE947ITwkrVKrfqQXsNQeb9n3RxCr+m2fYw9UqpWoI9mZICHaGfau6nD/Me71cx1Jl/buhFDs5z/RUpS25xFZ20r3FisCOIMXYGVWakvVfM3J9ltkA/2U2VHCkUSQd28pg8vkdJlMMV7l1lv3RlUC4cLr1ylG4j+sV3ZPcl8ANLK4sFtJMZsvf76viBvU5CwAr9apGZCjlWO0soBfIu5CGRR5Bi9Ii3n9FFHmL3+xLrPo7z4986dMU65q1TR21yhOyjZRAK5Jeq7p2EA7eQtPESPr29ZhJZ2R20BB0zwjmn6Fq/qVtOZHkzfxbiLZ/rU8W78p6dEpPs/pz6Gs9lOFs6Ir9HdZPJlaxa+ACv1ZR/EAjw26j0RlEBp1uOloWi8mp1/QRuSce88xqKICQufQypLj7XTCGPmNJRtSs4zjVDuwPsDdWlM0f4ZhJk/ACzoPZBEp+DGn5dcK24o029Xo2AD3PA8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457220a0-d45f-4c83-4a68-08dd5d71141e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 12:10:41.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY3jJLcFqp42To00pTF3ADW8oI8IoPaPXm6uGEgImbkN5iQclybWdhK/6toyb4JfJjrlOKs+zzmf2xopD/iG58sCiSQZBEq7ssKeFPeVvZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070088
X-Proofpoint-ORIG-GUID: 5n-rzXxIkL7la7zg0iMJQ3Qo0zUT_323
X-Proofpoint-GUID: 5n-rzXxIkL7la7zg0iMJQ3Qo0zUT_323

On 04/03/2025 01:58, Jon Pan-Doh wrote:
> On Mon, Mar 3, 2025 at 12:31 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> In my opinion, we want them to be separate. We may want to see no logs
>> of errors but still have them recorded in rasdaemon, for example.
> 
> Understood. So the sysfs toggles could be something like:
> 
> aer/ratelimit_log_enable
> aer/ratelimit_irq_enable (with default = off)
> 
> This assumes that IRQ ratelimiting part is able to be merged.

Sounds good to me

> FYI, the current implementation ratelimits for both logs and trace
> events, but increments AER counters. If there's a scenario where you'd
> want no logs but have trace events sent, then we may need another
> ratelimit and/or roll that into IRQ ratelimiting (to avoid trace
> buffer/userspace agent getting inundated with events). Granted, there
> is probably a higher tolerance for spam there than in console logs.

Right, I see what you mean. I think we would like to still trace them, 
at least that's what I got from the conversation I had with Jonathan[1]. 
It would be good to agree on the final solution here.

All the best,
Karolina

--------------------------------------------------------------------
[1] - https://lore.kernel.org/linux-pci/20241216104424.00000fab@huawei.com/

> 
> If that's desirable, maybe it could be a follow-up as well? I figure
> this series is at least a good first step to handle any spam (vs.
> status quo).
> 
> Thanks,
> Jon



Return-Path: <linux-pci+bounces-20132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82FCA1698B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8483AACD9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B49D1B4257;
	Mon, 20 Jan 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AEHqXj86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMEnT/kW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99971B4241
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365180; cv=fail; b=VYXa6S9GdZ8nTIZxWd6zwzW7vgUsiFQ5QEVE9BeqHU+SBK9Cx01T7+Q/NM5j5M+LKNb7jzEUQ4lRp7+yVlkoVVusyfOyQuxSU/O/uDZcSsGXuUqRobBo5puFpMT83i+ord0facngmnJKOTvjsdmSwuIyHdVPtuV6iWPmmr/M6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365180; c=relaxed/simple;
	bh=w+PoqD3+7pzVoItvI8wu6UaIqO2qdbbpq3d0w8StcRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QL/h8cBrArfB1nlVNnc7L6oPccKS1ECZYgwMKArQ9fxxDgusQzM27XkWvc3OgsayIq63E/T++xAuiiyy+2o5pUGBI62IoRKyv9sa5UsbhT3tomQnzsV9Oyb2N96r+9uB/2hseOm1UJ1MajVG/706ioAFCu2FfZENRxd4a+nwfZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AEHqXj86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XMEnT/kW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7fwcJ023640;
	Mon, 20 Jan 2025 09:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=f/jMsMiQ95Gn67XBYsbmmVNR8+TtOmoaVQ+Tp7+TXxM=; b=
	AEHqXj86tvLFJ3HthzP5K5VUN6q8emQnOEtbo2QcVUXdCBlcefMG51sGEADBhMjY
	vq5G5DiA+OBqY2sTiaqxHQx9Fnc3owcpYiXchiSiwcduoO7sUv+3MsZA0QJ3S/X2
	W100X+MnMe7FYNwGkkdlxcM4zrhNmWPM8DEmKqivTuB6Y1xiO264eQopGzjaa+QU
	97i/kdOrmHgwmr9GFqGMdFTo/MC0HqRRc3IDBWlbJXfDncVEkARqdooWsyeg2E4W
	Kw6qlv9XPBoRqZ93fRnjRftUKOFMLu3CFUWscI+DQVHJ3Xhbt33LxehpDwmlcaMx
	UN4s5tYchn6IiLQgOjSitQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qak9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 09:26:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7ALiw036543;
	Mon, 20 Jan 2025 09:26:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917n58t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 09:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3QDuv21F8rvFLsNeVqIoTXDkYMgT2Vwo8EQzBZUrPVnxyIDf3/LhGHoZ4/k90NYqtyF4oH30YLAjSRt4q3e02knJlssFb4JwgajeSavHoCXebBTiP8P98YsiONUMFZozBrfKaSEhAlu1KDIef7zAaC0siyK+mXJdPs0CUyTyflCuAniGI/jtcf7Rhx1GuVWjhD8M9sRIAF6atOJANT155TSnmxGERbPDP0cHrb3DzTkJolJBavBc0rswTe62wNSpThFxBogfarwtdMz2elSKuOWgqaOso/inTwXgdMSb6FwNnPKdsbSCd3PcJ5ddJ3y+N8vy7Iv6aVzYhjbTYq1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/jMsMiQ95Gn67XBYsbmmVNR8+TtOmoaVQ+Tp7+TXxM=;
 b=GPOk25P//xTiKYBgOLClHXsJg8j81ybjLnDvAXkZ7h/LBVKNU3y5zrbZfXu+LpBN/I8XjBm4jMp/yYsV0AIlxTmqGkYjOkh7VH+rpmRlEF36MREEF6ukf1GdcxTSRicf4y8qduB1nnPT0O3cdgkXV4FCWuMb+Q69pd+CSHG0diDZ6FMMvwGO53GzaWEAqD9GMbM/YBbK50IQwq9KsfhT2xwB8j4COgmX1e1++RdsYmMe+UVU1RKdummWhb0JIu5c4XlbYCPsNJ9OVoVIWmfoSa9VGXvETUz/T5GUBNZ8GeC7aPBn+NGLZCeA5jlhwJILE7lN3uDxU8NSHkRweXn9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/jMsMiQ95Gn67XBYsbmmVNR8+TtOmoaVQ+Tp7+TXxM=;
 b=XMEnT/kWMoaL1bgO6zNsSPO3qsj3X8aCg8Axv21g0M5+jSeQs9IrKN3zZAheMFkBvFUsgWcSBi3dqQcrvBQfw9LKC3bPW1NxTxAXcqIVgdvd26I6EjBAhaWj9AHcQpy7ggrovcQRh5BPijVDxk3/RUJm6jMLACJKHCi9zAQ7dS0=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 09:26:01 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 09:26:01 +0000
Message-ID: <cc9f5b49-ca6f-4c65-9cae-b273fe9fb1c4@oracle.com>
Date: Mon, 20 Jan 2025 10:25:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-2-pandoh@google.com>
 <f9ccc68c-216d-4cb5-9e0d-d2b49854f06c@oracle.com>
 <CAMC_AXU2TtkO0cn3Yh4CVpaQC-D6eWo-yZmPKkLZJcAhnFA7iA@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXU2TtkO0cn3Yh4CVpaQC-D6eWo-yZmPKkLZJcAhnFA7iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 42524f6b-515f-4427-1913-08dd39347499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YURUZXR1WjJ1R0ZORFRSY2xUSEZSM0ZBODJGb20rQ2R4T3BiaTFQcWhOTmk0?=
 =?utf-8?B?b2dDaFhMQnFkdDI0SUhpNDBXZUo4RUFrVmJwWDhYM2RZSG5DZWNhNndiVzJW?=
 =?utf-8?B?Q0lyWHJUamdQbEYxbTk0TWtLQXBobVpXRWRwMDFQRlYwdEFidkwzTWlEcklx?=
 =?utf-8?B?aFIrNUs2ZTJ1V3YrZm9CR3FBU2ZiQWtXSzNTalhGQkdnckRMM0hQOFJTL0pt?=
 =?utf-8?B?bkE1NlFSRnZCYmVXRndQTUFBdWoxUFFITVFuSFVEb1JOWjlmL2NINXE1b1hS?=
 =?utf-8?B?U2FVY2lsVVZja255MTAxU3BuaStPQlVFcHIxTkxnYis0RnNNRE5lcXNOeWcx?=
 =?utf-8?B?emdrR0RscW5CKy9MYWpRVXdKSGlrdnBlZTlRRWhPM1hueXFOekNGb01iKzZF?=
 =?utf-8?B?MUl5SDhVWndkbkw4Rld5TDI1RHo3QXNJOXJTbnZ4cWF4ZVJHdE4rNFVFblNW?=
 =?utf-8?B?TzV1RTRIb3Z6M1BIcXhJcjNXSnNhemU2R09yR2xCWVJrc3UxdnNnOUpGVTE4?=
 =?utf-8?B?RDRqdUErbi9xaFBHMHBoSW15WlF2TFVRaCtpV2ZRaW9adWVzOE5UaGVaUWdt?=
 =?utf-8?B?ajNYM0xBNXdxOUNJTi9KQWN3MzROSTlIdThlbzZCZUFwOTNHb01TYW96Y1ZD?=
 =?utf-8?B?bTI3a3Y0aW5UeTdJdkQrSjZPemN6MkIrTE9DMmdCem81SWd2VEhwY0lvRG1m?=
 =?utf-8?B?WUdLZmtsakcxRjIzZ2s0YTNFY09wWG03UDAzRE1sRXhSN1FmNmZydFVPcUtQ?=
 =?utf-8?B?RjNTdHl4S1dIeEorM1g5Wk9NR3JUZy8yc1JWUjRCaGk0YnNpRVpwUm1ESktt?=
 =?utf-8?B?SzlQTzBRWUFuL1BncFh1Y0xMTjhkaG9PdGpmaUI3MC8zaUZMdjV0dkVKMFFU?=
 =?utf-8?B?WE1rRnlISVFYRG90ZGpxaWlRdnJmZ3NrRjJzTERhNEhrRE0vditRS0lMUnpx?=
 =?utf-8?B?MEVGR3hCdzlhcnZkZFpMVlZQdkJEQnJRNnhuQlZUanpNZmNiUnVDUEovMjAw?=
 =?utf-8?B?V01Cd2Jka3hTY1VkQmZXOU94NE5ISDJ5OTlUVzVXMjdpdnN6Wmd1dFVTVWFm?=
 =?utf-8?B?M0grd3FQZXFzUHltR2VDZUVuWkQ0NFh1Z3hPVTVuVEppSlFMKytiOGZQN0pm?=
 =?utf-8?B?S2I2UjFuUjFLODRXamJvY0c0ZFVMbTE0dGg5eUorU1FlZHBkL2MzR3ZQelZn?=
 =?utf-8?B?QTJHZ2Vyc1Q1RUp3L0xQdVc3eU9rL1NlQStrRUMxM0NKNGtOanU5TUdWRkZR?=
 =?utf-8?B?TmRzSlhKOWl0WTJabW5hMkpVbGFTYXJDT2J3Z3dNeEVMWG1zU1lCaU9tSkJM?=
 =?utf-8?B?eHcybWw1Q1NTc05VaWlxdU5NOXNyb1JTYWUrbjZLem1BYVIrMEtOTDBsV0wz?=
 =?utf-8?B?ZUJRRFpwek04MGZCb1lhSm5VWlBidUdZZGl6NzZGT0N1THMxbWNrTUdQK2tw?=
 =?utf-8?B?WlpsSHVFeXFyRHRJNHoyMHJYY1NpQkpsN0hqLzNLdVl5b1RueHdGTUVXNDNJ?=
 =?utf-8?B?SlcvdUF5NE12MXdPS2F1UnlyWUNCUkR1K1VXcDlvd3c3bW9ZY2w5SGV0SEJ6?=
 =?utf-8?B?Z2VsZUVzcEt5N3pOSm9iQnBVN3NFeGhYci9WeUx0d3VPV2swTEpkU1BqSkxQ?=
 =?utf-8?B?bEt3QmU5WlhIWEtaLzBvL3ZvUytoY0VzK01LUzE2YVc3SHZBNHVaVVk1bDBR?=
 =?utf-8?B?SUxHZTJrVk1pUTMxSGhxUmVDZTFkNU9tbkkvYkV6Y3F3RENWbDdhczFTRjhj?=
 =?utf-8?B?d3NKVjhMVk9vSXBzNHRIOGdOU1kxVGg0WFd6RUxzV21HODVlV0E0aGhqU2lt?=
 =?utf-8?B?QU80SmpuNSsyVktTeXlMdEJTNmdpMFVqU0tsMU52VTNsYy8xdFMzbnBvOHRT?=
 =?utf-8?Q?ZZPj+RFt2mF4H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUFiNWp3d0FUb0xBY3pkUTlwdU5OOEZMSFo3ZEhHTnBOS1ZtL1o2Yzdyd0Yv?=
 =?utf-8?B?Q001MFRxRDVaaEVRUDFJQjBMSTFGL2d4ZG90UmlyVFF1ZjMrQUN6bm14Tksw?=
 =?utf-8?B?akRrOG0wVHcxMCtGcG1ySW5iNmYyM3dtNjJNT1cyTGVVU2d4Y3ROSUZKNEt4?=
 =?utf-8?B?R1pFSE5BK1pUM09ITmkvNDgwUVNMdjlqbXNMQlN5SGxCdUdlN0tWYUxab2Z5?=
 =?utf-8?B?YXpBY04xc0RVeGhzc0NDblFyanZyN2lvenBUNjIzWjBGQ1NscHJ1YWlpeHg2?=
 =?utf-8?B?OWhaSENJRld4UmRFK1VmSjlURGQxb2NtcW83U1BLdzNqK3lTZU14OG0vWkdn?=
 =?utf-8?B?ZllTTS8wZ2NEcy9IWnE1STUyWlUwZmlFV2R6bUJRTURFTlRiczhxUG1qdXk4?=
 =?utf-8?B?aW00NWczM3dCMzE2WDhrZjlYaUYxUkNSeExCb0dqR1BOeHBORm1nYnV4UHV6?=
 =?utf-8?B?VDZXbGhBVG9uVWl1d0grMW5RSzMzdjJsaTd1RDh2bk1HYjRSVnhoeHNMbHlq?=
 =?utf-8?B?K25Ld0JnWVg1U1VlUGhYWHhuVUhxZEQramU2aHdqL0JzK1U4SWJ0c2hxclhQ?=
 =?utf-8?B?QkY2MGVVclZzS2NOdG01YjU2dDdjT0x3TTVZb3lEUDBRazAvZEZpMUMzQUl0?=
 =?utf-8?B?WGROWHlkN3VDMVNMNzlxWmZTc0VKbHA4dWF1U3RzaVR5MDhFd1MzRVJheWx2?=
 =?utf-8?B?NkhhM1NXUXNncFVmT2h5THo0NUt0SE9yQ1BEbVV4d2JVK1hPWHRGNnZuenhU?=
 =?utf-8?B?MEM1T0p5eWI4YXQxOHpZYWhaY0VnZWF2cUNvdWNYL1dyZ0RmVGlGOW5pQVhq?=
 =?utf-8?B?OGdFYW91dExzNDJBM0xnWi90VWY4QVZISS9JUUpLRjFFQTZKaUVLbENYQ1d1?=
 =?utf-8?B?aklKS0pKMlYwRzlyQkxMY2tJVFBXdGJHcE9mbHJDd203QVJabjZJdHBod1JP?=
 =?utf-8?B?ckUxVEU4Z0NUaVdsZzRnNk1Ka1lGTVdGYjdzK3lvRXQxZUpDampUVHdaajNu?=
 =?utf-8?B?YXZMb1hOd1YxNEdpeXVhUHF3Unc4am93M1dzNlNsYkxiU2FHdGU2WW1DR0pa?=
 =?utf-8?B?TVdZWmdyc3ZBcUVKUWthOEZCdDVJUGd2b0liMTdpbGJCSkNwSXBRakVIZ3ov?=
 =?utf-8?B?dEhTdlZiaE8wb21zS2RrZjE2WnhkSm5XczVmSWFvNWE1VndzR1lUU0I0dXJW?=
 =?utf-8?B?UHRqRElXbE1OOVNJU3JiVGtxNFBkUVQ2MEcrbG4zNzNmZUUzcnUvVkRYdG0y?=
 =?utf-8?B?Yi9WVEJPQ0owSDJDRjVwajE3OW5NY3JPMCtuMkJxZHhPcnRVY1puSFlPVVpP?=
 =?utf-8?B?dnY2RmN5cFEyZUY1N2xHby8xRFpSN2xPMm8yakxUbGI1Y3VuQkMvS1JWb0l5?=
 =?utf-8?B?aitSWi9EdnZvbW5qS1JxV01UQ056SXpCd1hPZE9qb2tjak90cEtjSUxUVWR0?=
 =?utf-8?B?WFh3RS9aekd3K3I1aTF3NHBJc3dXbXpCUmV5S0w4WVFYaWdQdS83TXJldTds?=
 =?utf-8?B?RjVsNHByWjZKSXJFZGV6NTNFUTkvcWdzMVlaQUYvUjR0ejR3V3ZEUUZvRVlK?=
 =?utf-8?B?dDVRQVFIbzEwVDEwRnBRSlRLb3FzKy9rWFFPczVxSEtHM2pOa1NVaVI3R2lv?=
 =?utf-8?B?ZEhtV3I5Wksrc2tmNmVmalVxN0p6Tm9tOGppYXp0Z3B4TlRQa3l1c2c2SWNw?=
 =?utf-8?B?UFoxNng3OXV4S2k0alpkZXl5Y2dReFF4YmU1U2g5U1JBOCtxVUVpU0F6bUFq?=
 =?utf-8?B?Y2lHT2E3bkpTUlpIcnd1UVpXNkdBeCtyakRPZytSeDJwS3k0VUFlUHZFQ25z?=
 =?utf-8?B?aitSWTBwSFZjNmZaMXdCTWljQU9KdkppNVdDakNCVFd0QTJObms1eWExM0ZL?=
 =?utf-8?B?My9rSVhwanVlU0R3VEEyTTBFQndHNWFHbzhWQ0EzWTFkdHhERURnT1BMS0Rm?=
 =?utf-8?B?ZjM4N0hzSmRwdkI0QUpCVCtEWEFsaHN0NTJHTkNza1JUdDVQVjVtbEpoWjRM?=
 =?utf-8?B?YXJCdkloWCswTWRSMlgrMUlVbW1PRXFTYmVnb2p5NFpEYVJob0U5TGY4c01D?=
 =?utf-8?B?YkdSYXp5bVBVMGYyeW50dEhXU2pGVWlwOE9XVEVTQlhxUTA0UmJUVmpsUFlN?=
 =?utf-8?B?Vk5IMHFNZ0RFbWQ3TUhLQ085ZGx1d2RQeENleGRjMW44UmlCQTdaTVJIZXdo?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a8tGfqHxYi0p0S0ABatEOAKaLQt7lOj6nCpjlKFQjz1nMrgQS5K/vbEGwgewJ33k89dkZEKxV5T3JT0Dz1bgY0ivDog6QTDHqzenWGs476XqFqqHqMWIZfS8A3FsT1/ZLxepTaSseC4DWXW8ZDBOqAbv/D6Kn0AukFHPDtYt0tBSg9KqVPcxutPfegPfGi9ZZISX7jLJ/e5YjRQ3L4TFXSa/boUhCIoH4cX+egZ9JYo0SKucjLlOnOIxLX8fa0s8sEIrMi7faReG61bSmBdCEBvL4neB8hDFTdmszFp3F6tT7OWTMRJVZFGbvFfZDBim7f3RMjJ5Vr05fKYi/o+5tU05ksUvwt0lwcrxAJIl1PNb9o862N/zB++DUyPCQ5KHnzJqk0hzbDYTi3gd+CACGp/xgwcUn2nUG1iyvZc5sP+eeMCNO3caGqchZL70wZvvagQe6z81EP6APpCvN9yx6z6njHdgyxrYHWnDEFiNh9mHUZtZtg2y9j4NfI30fK1lQuwAw5XlyBoW93A8zJDsLqN4qnMkJP81iJs4Sv6ueaLcb3Re6vcHN6iVMNePY8ZodktsdPKOSMFGJGA+JtX+THG8Fac4423Jj95Hz6Fz/OI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42524f6b-515f-4427-1913-08dd39347499
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 09:26:01.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhFpC3n+vQhNhYqr8q5+MXdh4vFKf6aTredgE5ChkXpXbRueBrLwhTthrQjzu9H+v0nZCgARCUrDg8wE3M9KBpfXUTy14MKwmABPR1qHGi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501200078
X-Proofpoint-GUID: nP-CoVSaruayqs_2wxQIsgZIRqJsXG-4
X-Proofpoint-ORIG-GUID: nP-CoVSaruayqs_2wxQIsgZIRqJsXG-4

On 18/01/2025 02:57, Jon Pan-Doh wrote:
> On Thu, Jan 16, 2025 at 6:27 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>>
>> I agree that the bus, device and function info is repeated later, but
>> isn't this line also about the fact we deal with one or multiple errors
>> in a message? The question is how valuable this information, in itself, is.
> 
> I think whether or not there are multiple errors can be gleaned from
> __aer_print_error(). It prints out all fields of the status register
> (as well as denotes the first error).

That's true, so I think it's reasonable to remove it.

For the code changes:
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>

As for the commit message, I'd drop the before-after dmesg messages and 
explain that the information presented by aer_print_port_info() can be 
easily inferred from the actual error messages. I had to read the code 
to remind myself what information is duplicated.

All the best,
Karolina

> 
> Thanks,
> Jon



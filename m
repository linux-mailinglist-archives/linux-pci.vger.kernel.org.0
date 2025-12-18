Return-Path: <linux-pci+bounces-43289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C411CCBC50
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C917301B5F5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90495315D33;
	Thu, 18 Dec 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OwgbWRB1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hBOAIFIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A021FF2A;
	Thu, 18 Dec 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060517; cv=fail; b=NKMArjF3xamSUmg4FkxxYkdE40wJ5QOFKRVYCyrQExfl5E5JzL15YfsTbkrh1DuSCSHPyrDEWM3217z8LULFTJQ9K6DLxEFl2vS7u8F4euiouus9+oG2UpYS9oDE3Glr8JE2e7VOOFf7wVDomXCUrBnws96aIdGU9coMZVct33w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060517; c=relaxed/simple;
	bh=hyxnU6GagtdVPELXANaJo9sDf5P7Q151wSLlv7F29C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YE0FovXjf5vEz3BAT5zR/cp1CaS33IE/IrwbipKlWqLgd5xhrPSjjpDyDYeAK+4qaJTWRV6KLs+Zoc6vi5BW9cF/WOBkfyRAb8lDlt0YLL5gDOGeQFiY1bhugw6TJVMQo330jq2HGqfl8NKmgkQ2gJ9sZK+qOPodofxJroxoPg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OwgbWRB1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hBOAIFIC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI7EUSB940895;
	Thu, 18 Dec 2025 12:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hyxnU6GagtdVPELXANaJo9sDf5P7Q151wSLlv7F29C0=; b=
	OwgbWRB1PFPHPZZYAl4ExwO4bJBHseTFzGx4aYROMWHLGYZk6RNe3aePCSZRepUe
	d8Yoq+YeD+X2ooA7rjErFL3CP9C07cET3dsp2cGC5Bw1MqAeq5HCBAIDY165+PlK
	v3rPUEcfTFPm2/nxGgnUqU9jzDA8B4WmC+bRY1c/6oucysQzg52WYBufr+KNFWjT
	V1ATjPcC6luvq5rntahisN4AHegBOradlh6imEn81pOWU09RPYKWQOnvfVP4l+Hu
	QBL7OSr+62R1ldlEyNXo/cZoERdFF9a5ihl3fcR4BymO/LTDi4ka18N0Ff/6+QA+
	lJg5p3iXwWSxvKEIM5eDiw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015ymxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 12:20:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIBqF2X022551;
	Thu, 18 Dec 2025 12:20:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xknu4ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 12:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHNnAWl/dmhrUopGDBz4oOszc7TLt5gFVTlNOIl0YeasZXYKkTxtrmU0oupZVgLDZn0RvmWv3Nc0OAeCGJF9BWf8z+Pc6hKPA492YvXqgyL/5PhwjWY6Fz9a+yNX3vlmfBkhrVuv/To8xtJgHCG3YDTuF3wQR3T18WCrWiwxJM8+Zo2vXXavizKq17PeD+Su4cipGZl8WkIGhGzdRDx9VxiFTdcnkGcoimrGjp8LuUegITjR+QBAOVlSUbOlG0VZLgpzcNWHe5apdwPweEhphclMdQ6ETMRHOjwiNbWe1W7LOdmY2PhO+Q3oft5JnUAdc953XQKLyWWuC4eazCKZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyxnU6GagtdVPELXANaJo9sDf5P7Q151wSLlv7F29C0=;
 b=qxqktgLhZT50Sy4qH6u0BcO+V56gicgGrhOWwQDJVjM+yq9Wl+sN3oqbLn0zNEsQkS9DSH94X841QEmSyjDA83VQtjhmlMtKs+0BGGEt1DOQRey1KyztRDrIzh5rzxTcpizZuvhLFVIT2xARyO7UbDizbh1nF4FKqoFsJ4Z6dGf8rggc7e8fj2KMPzSnkTLpkDPJzU5YIt3tZzSZU7VI9m4HxjAjrqTua43nqLMaGlkMmEnOaKMFRE1NPm95Dl1bl+4r35r1xq09QhMVurWe7SH2qvEY27XFYTeaZHThE9d2xFysupoIHRysQf6xxtCLtV+xkw76BYgNn+bB3fg3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyxnU6GagtdVPELXANaJo9sDf5P7Q151wSLlv7F29C0=;
 b=hBOAIFICoAGRTnufFvydoxy0j1AO76/F5EjjjDP0TGscUo9CK5nc4JsTsuQGqpNnu2YDNCe/5ddybzhdBwIpJkCXWb3uRNd0Xa7RwXrZARZl3LkBROyc2hX21d08X5Q3Shs2OIxs2quEUBEWbSCPKTF85mrrwIWZbgR2sWFqeMA=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 18 Dec
 2025 12:20:45 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:20:45 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
        Casey
 Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        dingtianhong <dingtianhong@huawei.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Topic: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Index: AQHcZfNx6ACq7R62xkiLgv89EFhEMLUnZYQA
Date: Thu, 18 Dec 2025 12:20:45 +0000
Message-ID: <D49C0D9C-96F9-4D2A-974C-7B6E0CBFB235@oracle.com>
References: <20251205142831.4063891-1-haakon.bugge@oracle.com>
In-Reply-To: <20251205142831.4063891-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.200.81.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SA1PR10MB6496:EE_
x-ms-office365-filtering-correlation-id: 106515a8-a005-4345-e9fb-08de3e2fdec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVpDQjhHYVRvdXFrNVo5OGloZm5TWWlaQ1JaaFZOci96YlV1eGZtTmtYbDB6?=
 =?utf-8?B?K3lBWGE0cW83a3BUdktZWGFFd1VPRFBXN3B3aGk0MlFZZDN2MjVxZVVQcmJE?=
 =?utf-8?B?U1BYSVVaNFZRbVJjWCt2MVFEaGdiNVIvN2tWbUVWT04yZ1NoUEFuR2FGZ2tL?=
 =?utf-8?B?NDNVeitOK1R6N1JYYlZKOThMVkNoMHZJR21udjJwTXNZeHQ4SDFGaFVQUHBn?=
 =?utf-8?B?NXdCSHJmZktyeUhndVJNMnlNYTRxK2pRdFlLcTFpM0xpa2RHN25YdmxhV1pw?=
 =?utf-8?B?RTR3SFJTVDZJbytLYmJ2Y1ZTc1JRVmltNVZ1WFljMUxSWHZVNmgwN1VDdVNT?=
 =?utf-8?B?MW1GUHpjNmNUeGZMTUFiZUgzVXdMdFZ0dk1mUnFGYzBXd25rVCtzTm5wTVhW?=
 =?utf-8?B?Z29hTjk3UXJHN2FTUWZXMFk0aVNKNHhMdFdnVnFrTXcxN2FJbnFqY2ZHU3JG?=
 =?utf-8?B?RFdVSktiK0pLSm1mWWZLclVYcDcwMzF1VTgxUG5xWi96cHFvNnRRYy81bmpC?=
 =?utf-8?B?QXRCZUlPekEyaDc5c0llRW5zckl2eWxHSWtOQWx2VDNzNjQ4Wk5wbFgyeTl0?=
 =?utf-8?B?d1BkSlhhVUFqRk9lSjRqUks0eUpncDRta0FNdDVzcjlvT29uOU9QeC9iUmVU?=
 =?utf-8?B?Qmp5T2ttT1dCL0h1WjBqY3FMMGlPdjFTZStRWXpVLzJicDdSSlNTSHRnNTBn?=
 =?utf-8?B?dDVnMExrMXZIWndpTDVVdlN0M2IvZEVld0llMXpCTm55aUFKN2pnTzRzZHBu?=
 =?utf-8?B?Y2Mvb09hdVVEL2VLVXl4MmpROHB5Qk04RUFUOGRRd3RqanhsN0ZNMkp3VXh0?=
 =?utf-8?B?OHprV0ZUekw2aTVNTDNhcHlzMk5aa0QrdjV5YU9ZZncxVHRrZEtDNGs1bisv?=
 =?utf-8?B?eHdnZWhWeDFYcjgrWm5wdjA2bXoybWJ0ZFN1MytHSmZTODR3TDF4aUJSZHEz?=
 =?utf-8?B?NWl2VmFZYVJXMXJGcHU2Nzlkc1dPNk4xaXhBeTdMOHRyQUlqSldUelZ5ZnM4?=
 =?utf-8?B?RlRjaGt6SjFZV3VESURxeDYzNlRWemVQVk5ESjRzWERleHFpUVdVMXc3cEVM?=
 =?utf-8?B?ak9CSlYzVHNmNzFmV2kvWXN6RUx5ZjFGNGxhOVVTVEF2YlBrYnJTTXFlVmJV?=
 =?utf-8?B?c3hCMGlYbGw2bElkUjdtLzEyQzFiUSs1UEI1akFhODNmN2NKZVRockFHRGwx?=
 =?utf-8?B?Wmg2dm10NDR0T1VTMkpGaDJ2WkhxejFoZjlVZFBmd3NKOTFQV20rQlRNV2Zi?=
 =?utf-8?B?SmpFVzBNZnZLcjZaOGV1b0JJRUN2Sy9aaW9VQVVJekJCS3I3R01WYjhBSDUx?=
 =?utf-8?B?N1F1K3ExWEpQbFNmcEpYNWxzUHhsdXcrY1lISUJSZ2RLNzdiQkx6cjk5Tlhx?=
 =?utf-8?B?Wm56aUdsTDBSeDVVZHR6dVorZ1ltWWhaRzFjMG9xUmtFOFYzbEsvY2NPVjk2?=
 =?utf-8?B?WTl3ZmNUMjF2VExXNXhFVElQTDhQKy9HT1pQWGFEazFtQTNWaGpJZTExdFQ2?=
 =?utf-8?B?dy81ak1WQmlwVjhBRzhEcWN1Nnowb0V5cTZZcGwvaHY3Vlp1OWV4VVNzZjhx?=
 =?utf-8?B?ZFBrUUthQ3orTUVUckxVeW5MeGp4cW5XY014bE4rN3JxdHFhN05jRzV6OHdH?=
 =?utf-8?B?b0xITjBZL0EzaTBJU2ZOaWtXQVBpWmYyRExKcTJ3THBtb3IvdkNWNkxuTGhO?=
 =?utf-8?B?TlRjNUNmSVlldWdHaHpJSXMySGVLUU41L0Evbm5rOVdYNStyRFJjSFN6MXd1?=
 =?utf-8?B?VjJwb0JydUpqTHFuSVBkK2lMZWdmRTRhdW9vbGlwRFlJN0U5RkdCUW5hcjNx?=
 =?utf-8?B?a3FEMy9CZFhGemN3emtYbkI5ZTZndTh4cmZleEN5aVdoZEp4L29DWWhlWU1G?=
 =?utf-8?B?UEtLOTdQaDA3U0RDT0w5SGl4TUErbjlja1hDYWtRY3BWTWdyZWl2NmVPSHUw?=
 =?utf-8?B?ZGpRd2JXM1IzaW9aZFowbzVpL1JXcnR2blE3K3ZDUXdDajNrSlpkRUszbG1M?=
 =?utf-8?B?Yk1XYjRDWmpuVTZ6UWR1NXlMRHRRamw4YzVoWjErbHhwcHgwcjVOeTI1eWhH?=
 =?utf-8?Q?oEpX+0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmhiYmx2Um82ajdjNk5PM1k0Wk1nZnI0UGJnbGhXSk1zMWVndkI2cWQ2elpE?=
 =?utf-8?B?WnVvYXAydXpJa3JZaU1DNGpja0dkNHZiU3kvaEF2TmhMS0xySE9ISkR2N1Rn?=
 =?utf-8?B?SjJOSU9UUkdteVY5YVlYQnJvVWJvbndxdDVKQjVUVTlVUEhJaitXcXcza3I2?=
 =?utf-8?B?VDJjUnQwc3R2YmRUTWxXSkxtRktuemQwOFAvaHVnRjhLYjlYREw1c3FuZE42?=
 =?utf-8?B?K1dFek1Cd1RSZC9jZjN0RnpzTHU4d2x6YjhOa0o2VGRMdFFtTUFrL2d0TWxZ?=
 =?utf-8?B?andyemFYZy9qSDAyK050K0VZbTFXZGptY2dNRitnNDJsVkZKNUxMU3pFaHdQ?=
 =?utf-8?B?Uk1tMFdqbnJ5ZjBrekxXWERPc0lxRmVFekl6L2w2bGx4R1U3emxDYnQxbjZu?=
 =?utf-8?B?ZzhNdUQyUXNEcjJMNDdvNjZ3MkxBbVFUNVhUSnVmUS9wVmc4V05yN1lxQ1p5?=
 =?utf-8?B?V2paYys0cDFiTlROc0VoOEt2QnhHYVhsYkJBNmFpUWdydGE5SEhkays3ZXVq?=
 =?utf-8?B?U2t0VHlPMGR3R2NUYk9qUnRmUkYrbERtMUJBSjdBZ29RQjlPTnVRdlgrQmkr?=
 =?utf-8?B?a1EvTVRCeGhvOEZvNEFhMHFKcnhCQmZPaS84Y0lGOXFzbi9iZWNzU0ZNbmt5?=
 =?utf-8?B?eXUzTTFPbmprd3hYNkhlRlhNNUNIc2N0SFBPeGRRRUhndUMyL2VDazh0dXVN?=
 =?utf-8?B?U2l2cFZWbW9wdzI2SWxBV2JROThybEJXN2F6NDJYRWhsNW5pRFFrbFRrT1JC?=
 =?utf-8?B?a1BIUDJBMU9BRGRBOU9LSEdqR2RNY1dXejJhbkRlbzlSdU5Zb2RqOWpwWHBr?=
 =?utf-8?B?R2w2VkZ6RnBWQ29JUzVIUy9uVkVZVElOQWV2RFhmRW5aMWZHTDBwVHplOWUv?=
 =?utf-8?B?eVExNnQ5ZDN6VDNkdW9CSkZFMzNWeStiSjE2V3RSeHEyZjZzVUV4VVlhVXRB?=
 =?utf-8?B?SUlTMzI2K0FZbVExUEtyTmNSbzYxUGJ6UnhmZVNVNjNEK3U4SFo5V0J1aDBL?=
 =?utf-8?B?Z3JkZ3FpRVRhc2wzUzlhd3grNDhZNzFaSXAvVVloZDJoc2cvU21ndnJSOUFr?=
 =?utf-8?B?ZDk1VWZiemc3MjlHK245RjRlN2RCTzM2Z1dCZUpIMGdnV3pGTXY1YUNhR2hw?=
 =?utf-8?B?S2g1NnJ3MjV5akJQdUpUZHJmckp1ZHlFbWVLNmVhMnI0a1JXWkZlVlBiaXFI?=
 =?utf-8?B?NTFQaFNkQ2hKalJtSGlEdzJSQnI5VTViTHlMbTR2TW40VHpBR2szMkd2cy9o?=
 =?utf-8?B?Ni9HVldNemlaMVlZTlFHQ1d2U1E3VGpvSFpleFd3dGhRRmo0cVVJTlVRcVN4?=
 =?utf-8?B?WThYcHdDU1QxYkp1Wk1vblY2QUNRdFhna3NBWWZRQWlFa1AxcVhLKzVQOWdv?=
 =?utf-8?B?ZXFuVTZWZmZxZUExdWtWRXhPNGhML2xwWHJIaFhoL2NTTDBLUmFOUDRDTGdL?=
 =?utf-8?B?bWtEWVlWcnU1VWhzbS9hZE5mbXZLaXFNNzZXNE1idHpYaEc3WFhrNWV3dStW?=
 =?utf-8?B?WjZoYUl2WEZRLzNVZ01hOWhtU3JwYWNBUFpRUWRzVnZnZVBzQmE2Nm4rclY0?=
 =?utf-8?B?aldQVE8xblZXR3BKSG10RUMvRUVxSE54ZkJ3cWFGNjIwaWZpS1hJZ0VxaVQx?=
 =?utf-8?B?R2ZjenF5Y0pUckRlL3hlWmlpRStxdnZQcExTMHFBSTR0cVJUemhwRXRTR01S?=
 =?utf-8?B?eHpnYmkwQjB3WGZ2Q1F0bG84YVBKMWVCc2hpL3R5NWhJQTZCdUxPY1I3MTJV?=
 =?utf-8?B?RDNKekhpWGdidmlMSHJNOU5UL2swOFdmUFVMU0dkQUpkdkpLN1ZNaWJxR1RH?=
 =?utf-8?B?elNwdUVxVXN5R2tuTnJhbFd6REM3SDJISDJQT1o1OGZOWUMzbEwyMTNrbjNL?=
 =?utf-8?B?Q0E2VWNjWWd4UkZlYVdSQlVoU3YwaGNUL3FtRmZ4YW03WlBTaXJveWdNdy9y?=
 =?utf-8?B?ajBTdG1zWVNPOVVkbmFOWmNyeS9RSldxR3NuVzg5dUVIQ0pCdERNbHdBT2Fa?=
 =?utf-8?B?RGJVM1JtakFKNWVtMDc2Mk1DeE9WelJiY0lRSlJOSllLcCsydTRJWkxwbWMy?=
 =?utf-8?B?WmdVV0JkUytUbkZNbytsejRWVWYwMTJ4dXQ0YXdhd3A4cC9SSDdmUVFsUXhN?=
 =?utf-8?B?dlBPVldRcElDSlBrUGk5MWFpdStnbHN4RVNxeXpMTzNiRHJDcUluZVVONTl6?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFDE9127AFF2E84A989461A219FAE899@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hFRqnPWQDON5JhjC3sfrXjcuj6mfYZn1GbQ/UMA/63WjRdIeeMjJrMp3xgSo8cf1A3VD6G//KAM/N1M4WCiJtiQrb4juG1wluEIbo2wVgfOxY6tUYrjgF0B4rNfd/i7kqAg+NEyilBfPbxB79zNMYfLBQz5b4ewKrNpxRNqdL+fVfOInTCrBOE+PbKB07BS/1rf1VBv0aG/rDgQ58OC7eUAhaXTXMMP8SHUIJtGFCAuqdR0SGH35lPaecDrivitbueC6tO54VgOppE3I1ZUIpuG2iGjbDhShPUdbFjX9y73Erbhk2O9BRFM3qqRk/EYwti04kOGkybk/f9teI1A1I/baqy/t21iDanVkjJ1DM5oSpwhabneu2eBn5mSEXA+Vw1w2p9XVOk2anfuREhyK7ZlAMt1312HV7YZhcqb1+EkaL3NDMhZn+Fb/NPfY23vzGT6btMTGXg1XqIWej3vzCQaUiG5v2tshEbXazc1GY2I3Gmkc9SOnjrjuvvY4hIN+Zr9CEUDKnHyiMTjN7sZP9EzGM+E/EpBZNTHfocKK12hRi8GDwULOdrnckUlIjAMkDxYdOr2xNLldokqb5MFdC0ilTqFGGuag1szgmZqjtRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106515a8-a005-4345-e9fb-08de3e2fdec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 12:20:45.4758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/h3WoGOOTkMBCOdiE22eJ4/ohGklkZzn4y9CbwfVhehrDu8uIC7/EQQEZrh9m4knbFJhctCw5GkKngcIFnzvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512180101
X-Proofpoint-GUID: wSd212IoZcJhZxHaReLQEzInQKB0zqAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwMiBTYWx0ZWRfXzUdMaov3XXLx
 EdZyzjRZAIHEu8fEj/y33XHUVOWbBUP61mSXaNfAKazan9pQAcfJNp7uFqsF59L7CvefSNDAy7q
 F8tNjkxcvmC2kbJsl2uTm95v54zEDH7ncXq3jKLGs9A6Sjca3HC6ZJNIqxwHeJz31NGCwtkRVDc
 qjlUaKbnMn59zR/F5ppB9+T6LpprwqmtjZ3uuyNCxuuuy/vESuIpSMhcx8oOhLE0Z8YUflWjN7z
 lzOh8i9/UvpHVb1f6/YabPZJtp4SfdbFuvl6zmbNPYhjIInLwO62Z/gvruF7/WdImXPvV02jdfT
 dLPqb9f0xugZQE9pj7PyASPjnT0TKcmHV/zJ1mvQNecWE9VPPm/MXJFgoRGTRYu19Eweo9ltWWu
 4VApeAun5jx9XhHSNrS4cR3UtNG9DLBSQEgeCS2I8Pdko3oW0xM=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6943f1a3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=K6a3azdwWOg0Fi7Zy70A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: wSd212IoZcJhZxHaReLQEzInQKB0zqAW

DQoNCj4gT24gNSBEZWMgMjAyNSwgYXQgMTM6MjgsIEjDpWtvbiBCdWdnZSA8SGFha29uLkJ1Z2dl
QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gQWZ0ZXIgY29tbWl0IDYwZGIzYTRkOGNjOSAoIlBD
STogRW5hYmxlIFBDSWUgRXh0ZW5kZWQgVGFncyBpZg0KPiBzdXBwb3J0ZWQiKSwgdGhlIGtlcm5l
bCBjb250cm9scyBlbmFibGVtZW50IG9mIGV4dGVuZGVkIHRhZ3MNCj4gKEV4dFRhZykuIFNpbWls
YXIsIGFmdGVyIGNvbW1pdCBhOTliNjQ2YWZhOGEgKCJQQ0k6IERpc2FibGUgUENJZQ0KPiBSZWxh
eGVkIE9yZGVyaW5nIGlmIHVuc3VwcG9ydGVkIiksIHRoZSBrZXJuZWwgY29udHJvbHMgdGhlIHJl
bGF4ZWQNCj4gb3JkZXJpbmcgYml0IChSTyksIGluIHRoZSBzZW5zZSB0aGF0IHRoZSBrZXJuZWwg
a2VlcHMgdGhlIGJpdCBzZXQgKGlmDQo+IGFscmVhZHkgc2V0KSB1bmxlc3MgdGhlIFJDIGRvZXMg
bm90IHN1cHBvcnQgaXQuDQo+IA0KPiBPbiBzb21lIHBsYXRmb3Jtcywgd2hlbiBwcm9ncmFtX2hw
eF90eXBlMigpIGlzIGNhbGxlZCBhbmQgdGhlIF9IUFgNCj4gb2JqZWN0J3MgVHlwZTIgcmVjb3Jk
cyBhcmUsIGxldCdzIHNheSwgZHViaW91cywgd2UgbWF5IGVuZCB1cA0KPiByZXNldHRpbmcgRXh0
VGFnIGFuZCBSTywgYWx0aG91Z2ggdGhleSB3ZXJlIGV4cGxpY2l0IHNldCBvciBrZXB0IHNldA0K
PiBieSB0aGUgT1NQTSBbMV0uDQo+IA0KPiBUaGUgQWR2YW5jZWQgQ29uZmlndXJhdGlvbiBhbmQg
UG93ZXIgSW50ZXJmYWNlIChBQ1BJKSBTcGVjaWZpY2F0aW9uDQo+IHZlcnNpb24gNi42IGhhcyBh
IHByb3Zpc2lvbiB0aGF0IGdpdmVzIHRoZSBPU1BNIHRoZSBhYmlsaXR5IHRvDQo+IGNvbnRyb2wg
dGhlc2UgYml0cyBhbnkgd2F5LiBJbiBhIG5vdGUgaW4gc2VjdGlvbiA2LjIuOSwgaXQgaXMgc3Rh
dGVkOg0KPiANCj4gIk9TUE0gbWF5IG92ZXJyaWRlIHRoZSBzZXR0aW5ncyBwcm92aWRlZCBieSB0
aGUgX0hQWCBvYmplY3QncyBUeXBlMg0KPiByZWNvcmQgKFBDSSBFeHByZXNzIFNldHRpbmdzKSBv
ciBUeXBlMyByZWNvcmQgKFBDSSBFeHByZXNzIERlc2NyaXB0b3INCj4gU2V0dGluZ3MpIHdoZW4g
T1NQTSBoYXMgYXNzdW1lZCBuYXRpdmUgY29udHJvbCBvZiB0aGUgY29ycmVzcG9uZGluZw0KPiBm
ZWF0dXJlLiINCj4gDQo+IFNvLCBpbiBvcmRlciB0byBwcmVzZXJ2ZSB0aGUgaW5jcmVhc2VkIHBl
cmZvcm1hbmNlIG9mIEV4dFRhZyBhbmQgUk8gb24NCj4gcGxhdGZvcm1zIHRoYXQgc3VwcG9ydCBh
bnkgb2YgdGhlc2UsIHdlIG1ha2Ugc3VyZSBwcm9ncmFtX2hweF90eXBlMigpDQo+IGRvZXNuJ3Qg
cmVzZXQgdGhlbS4NCj4gDQo+IFsxXSBPcGVyYXRpbmcgU3lzdGVtLWRpcmVjdGVkIGNvbmZpZ3Vy
YXRpb24gYW5kIFBvd2VyIE1hbmFnZW1lbnQNCj4gDQo+IEZpeGVzOiA2MGRiM2E0ZDhjYzkgKCJQ
Q0k6IEVuYWJsZSBQQ0llIEV4dGVuZGVkIFRhZ3MgaWYgc3VwcG9ydGVkIikNCj4gRml4ZXM6IGE5
OWI2NDZhZmE4YSAoIlBDSTogRGlzYWJsZSBQQ0llIFJlbGF4ZWQgT3JkZXJpbmcgaWYgdW5zdXBw
b3J0ZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFj
bGUuY29tPg0KDQpBIGdlbnRsZSBwaW5nIG9uIHRoaXMgb25lLg0KDQpUaHhzLCBIw6Vrb24NCg0K
PiAtLS0NCj4gZHJpdmVycy9wY2kvcGNpLWFjcGkuYyB8IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMgYi9kcml2ZXJzL3BjaS9wY2ktYWNwaS5j
DQo+IGluZGV4IDkzNjkzNzc3MjVmYTAuLjZhMmFlMWI4MjE3MzIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL3BjaS1hY3BpLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPiBA
QCAtMzI0LDE1ICszMjQsMTggQEAgc3RhdGljIHZvaWQgcHJvZ3JhbV9ocHhfdHlwZTIoc3RydWN0
IHBjaV9kZXYgKmRldiwgc3RydWN0IGhweF90eXBlMiAqaHB4KQ0KPiByZXR1cm47DQo+IH0NCj4g
DQo+IC0gLyoNCj4gLSAqIERvbid0IGFsbG93IF9IUFggdG8gY2hhbmdlIE1QUyBvciBNUlJTIHNl
dHRpbmdzLiAgV2UgbWFuYWdlDQo+IC0gKiB0aG9zZSB0byBtYWtlIHN1cmUgdGhleSdyZSBjb25z
aXN0ZW50IHdpdGggdGhlIHJlc3Qgb2YgdGhlDQo+IC0gKiBwbGF0Zm9ybS4NCj4gKyAvKiBEb24n
dCBhbGxvdyBfSFBYIHRvIGNoYW5nZSBNUFMsIE1SUlMsIEV4dFRhZywgb3IgUk8NCj4gKyAqIHNl
dHRpbmdzLiAgV2UgbWFuYWdlIHRob3NlIHRvIG1ha2Ugc3VyZSB0aGV5J3JlIGNvbnNpc3RlbnQN
Cj4gKyAqIHdpdGggdGhlIHJlc3Qgb2YgdGhlIHBsYXRmb3JtLg0KPiAqLw0KPiBocHgtPnBjaV9l
eHBfZGV2Y3RsX2FuZCB8PSBQQ0lfRVhQX0RFVkNUTF9QQVlMT0FEIHwNCj4gLSAgICBQQ0lfRVhQ
X0RFVkNUTF9SRUFEUlE7DQo+ICsgICBQQ0lfRVhQX0RFVkNUTF9SRUFEUlEgIHwNCj4gKyAgIFBD
SV9FWFBfREVWQ1RMX0VYVF9UQUcgfA0KPiArICAgUENJX0VYUF9ERVZDVExfUkVMQVhfRU47DQo+
IGhweC0+cGNpX2V4cF9kZXZjdGxfb3IgJj0gfihQQ0lfRVhQX0RFVkNUTF9QQVlMT0FEIHwNCj4g
LSAgICBQQ0lfRVhQX0RFVkNUTF9SRUFEUlEpOw0KPiArICAgIFBDSV9FWFBfREVWQ1RMX1JFQURS
USAgfA0KPiArICAgIFBDSV9FWFBfREVWQ1RMX0VYVF9UQUcgfA0KPiArICAgIFBDSV9FWFBfREVW
Q1RMX1JFTEFYX0VOKTsNCj4gDQo+IC8qIEluaXRpYWxpemUgRGV2aWNlIENvbnRyb2wgUmVnaXN0
ZXIgKi8NCj4gcGNpZV9jYXBhYmlsaXR5X2NsZWFyX2FuZF9zZXRfd29yZChkZXYsIFBDSV9FWFBf
REVWQ1RMLA0KPiAtLSANCj4gMi40My41DQo+IA0KDQo=


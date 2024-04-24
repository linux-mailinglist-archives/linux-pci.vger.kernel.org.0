Return-Path: <linux-pci+bounces-6623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2A8B0846
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67FBB220F1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A08159913;
	Wed, 24 Apr 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hPQ8/9Ya"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACC13DDD9;
	Wed, 24 Apr 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958046; cv=fail; b=AU+6HoZYaEYuJguMu7hPymgMjyjblnrGoDLey6RmMbgbcXq1Kvi65qLmOVYIKWhF+1HLR45IA6jP0+J6i2vLsmLVkFQ2U8ixI6ovF5PDLFsCPsQoC26f2Q8HpnQuM7w4sbgl8heMoId4G55XjzYFQjHpha9JIiyV572XQLyBZ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958046; c=relaxed/simple;
	bh=GI8GM75whXC/OK/tF7vFJR4G436ent9sPqjAkV/tO9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOSypMjpsiPwCMuANxaGy8LcXyPSb7qVT7dp+nphCq15jKS2MksnZJbUgoI538+OBobPDe79ZfTooab07rDQpq+GwJZlI/uthgZiF+BxfbAdY1509S1uA32CKG5aqLK/9mWFJ9smbkY+kIm+T9y70FLWb1N+E4EfMVnfiR2RRsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hPQ8/9Ya; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVNTwlRSU9dcQmf8X2OKl0US6/Wqnj9d0rBLJpmaghGJI9lk0KCHmRmAgiIOsKlfqioMi20YooJ32cUgPCxaC7enzaNWPXtULGJtsJos35FlcRiHKEzFL+PUp/wiHqgkjly6SaVAyeHJHPYaOGvp+cALCyk4GPx4WSE5WlgkJn3gULtYfuu1di2WTVTOaddsqu4MU5XgZmlQWjc00MUI9L9Sbet4JJTQlvo+kmYu8RX7zCzOqWHdwyRpfkD53gETjfF1fTCBdkNM+MumEW4cvF1cF56itnNLh0aJRY/ozUeOk2rsomnfnF+UiUycTsY/ef8yTE5aOGgrCKrZQciZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOTYefYVes/i2zk2WXuiNSl2cAWPPFOZTF+lM/Uc+88=;
 b=jS1wZ+mRz8Talh3JoYZEj0uCfIygYDEFtG8Fy1IKjMiimcED0r44Jm09PXaSA+SWKomSitQYuBvLR7a5Zys37gxE3g/STfbm6Cxq6Pw7Z+6qCeihHaRKeg8RteO36Vc1fvEFW6vcpc6ISXjkwIz0oTDkghkvsxbmZ+Ib6zlhA7qKajxoZ3zBf1qvRC/z3yhBdfkUfD4RneCD918pIF48FoCxx3VPVPsKcJJxKnnAUBI/yaolC68NLfkwn7Zgtcf72pFqLU5qc8KM5qsuTjsSCOMEBmYfn2wftUjKOjuDm93CdxyTkVvdXBHhxniyCJcCh2SudDQ3QCOyBaPDzOayzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOTYefYVes/i2zk2WXuiNSl2cAWPPFOZTF+lM/Uc+88=;
 b=hPQ8/9YaEHonALyNyfk1T/BWrI8PPNcAv3O0ZxGbNDv2h+coyhSchEq4zmfoXDt7rzjrjQlChRKG/VXH7qwIfkz6kAxfI035aQzYzP/KfiF5ktuBDJIOm5q+gC2OrRcbV0RDYS2oM/pfVafbt33W/Y1ncaJHh4Hax54k1qE6QyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 11:27:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 11:27:21 +0000
Message-ID: <c599baf5-5d10-4b17-b762-4f0f4a4ccfcc@amd.com>
Date: Wed, 24 Apr 2024 13:27:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] [RFT] arm64: zynqmp: Add PCIe phys
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-8-sean.anderson@linux.dev>
 <6f7355f6-ae84-4246-83ad-3450e036b111@amd.com>
 <SN7PR12MB7201F77EEAF9134E790E09DA8B102@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <SN7PR12MB7201F77EEAF9134E790E09DA8B102@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ce7f46-84af-440e-dbd6-08dc645181e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHJVUHgxRWNGdVpKdUNYMGtOR05JVE8yTWVndmNGT2tYWGZRT3A1YjBtcVlt?=
 =?utf-8?B?NWpSWER5RnZPNmFPa1U5cmppM0FVcmwvRk9jUXNUR2QzbWJzVE1qYzJybG84?=
 =?utf-8?B?WWd2aTFrM1N1Q2d3LzlNd2FNVS96WlhyNTN6dERreFBZQy9hcWE3MDczWkhr?=
 =?utf-8?B?bzZNeVpKNiswZkZHQ0JXRXhzTjBJMFpFVHF5U0l1czN5b3pLSm1kN2RQajJy?=
 =?utf-8?B?YWdYSVN4TU5PV0tSa2JmVlBwV2lvU1EwQkFXekFtV3RhQ2dRK2ttSENjekFI?=
 =?utf-8?B?OTBOWkU2dVZabytUNnJmNU9vNDc4SHZSMFN2OGhLOG1UYXdVSzdVRGw3ZDRi?=
 =?utf-8?B?MUtBYkdvTno0WFlwc1huTDEyT0IwenZnL3hiVjRXYmZMUHZFUG9EcWlyNDNz?=
 =?utf-8?B?eDBSUUJCa2tWcjRPRkl6UDFYU1RSdzVVUFh1cXFvVGZ1R2x4T0U3dHJXZCta?=
 =?utf-8?B?cS9iNTlsZTVXZXBlUTJYWVgyVzRmVkFEMXB3V2JNenM4M1gwRlRXQmNzWksr?=
 =?utf-8?B?MmlxeDVvWjFaKzVLKytuNXhZNC9MOFNTcmh4Z2hIamZjV3JzdlQ2Y2ZqWERN?=
 =?utf-8?B?VmhWWDExWm1zNk9IWTkwZlYwK2YyeUFud0hCOWZzZkxhWURpSkpFMUxxS0Vn?=
 =?utf-8?B?eXIyNVZzN1pmMGlNMjBQbE5FMHRVdytRVWx1ZkI0UUx1bHVreGdJdTV3UFpy?=
 =?utf-8?B?YUJ2SHFhV0lsUEpGdHNhNXhzc2xXVVo3c3dTSHpDd0xxL1YwZlV0bVF6Tksx?=
 =?utf-8?B?K2t2eXBidHhleE50TjFjRzA1OEJxcS9yME82YUFKZElRUkZ0RmxQbStYVDlX?=
 =?utf-8?B?U2tqckZYd2dpckhKZ0pGTzZrSXg0S2N2UXBueVRUWlNUVlRDeDlwZnBZTW9s?=
 =?utf-8?B?VUdQd254MWdHRmlvUytOTlFpVFltR2JvTDlwV01SSjUvbnpjbElQWnNxOVc0?=
 =?utf-8?B?a1FyQVBhSWNZbzJMaG9RckFwVGZYZnZELzR3amVPWGJEU2lZV0tWRGQ4WE96?=
 =?utf-8?B?TkwyNUlORVZ3dHMwbGI3QkdlTW00RVgxd0o0SnhFUkk5U3ZHaTg4NEZtanNQ?=
 =?utf-8?B?Ukw1Q2FnVHJuZVBjTEpibHpKVmxQTndINXltRndHWmt4U0lEd0h0RHRYazJy?=
 =?utf-8?B?ZnB6alhsMUs3R0IwY2dhT0V4MDdpL1RiVkc0UC8vdDBod1NXVDh6VFRJTlBH?=
 =?utf-8?B?Wm9DZW80UkpyUloxU3FhNHlVdmFIS2hOejhsRHd4QVloOWFtQ1IxL0l4aHVL?=
 =?utf-8?B?UzVpQTF5V082NnBDQlAwWnBDaVBOZXZ2eXFDMG5YRGdOWVVmZXdEYUtjVFRY?=
 =?utf-8?B?TDVvRDExeFovWUt4K0FWM041MGlkR3ZRM2hIZ3hpbHBUNzJpQ0VCbGoxaDhZ?=
 =?utf-8?B?NTFwY0RCTWZHV3YrUW9xQkh3dGRpUVlxZlRMemVlb2N5SFl2b2VRcUNCdW85?=
 =?utf-8?B?QmJVVDBwK0Q5c1FyZG5OZ1JYaWVDVTgzMEpCeGZ2akh2NUYxdzZGOHNnWVdl?=
 =?utf-8?B?R1lxVlkwWEFUM3RsaFZ4Sk9BTXlOTUNkTFBIcjhYTkh1UDA4Wk1PMUhrdXhX?=
 =?utf-8?B?RHNxVFgrVjQrU3pFU3BhQVk5UkJsT0UxREtnZmk0SDlncEZRRjNOY3NWVHRC?=
 =?utf-8?B?QzBNQm5VLzZFb2tSOVp4QU9tNUg1aUM5ckZvWWJjR1ZCL3pxeFBKUWpiSGZW?=
 =?utf-8?B?b0RBdzM0SHQrcElWRy8rOStSbU1tbEprOUJWUG1valZpZHRQbjRoZHl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1lIM1Ryek1Kd1hHdWpjMFhQN0d6NjBMNEVJSXF5NDdOSHFPOHNUVE1yWlEz?=
 =?utf-8?B?ZmxSWVRDZmJPMjhzL3NTN0ZQZTZkTHN4S3JSQVlVUEJwanB3Qks3SG9xeC9p?=
 =?utf-8?B?YmdDODJ5M1Q3SlNWdno4VWZVRzg3dmZNVXgvWXRtOTFLcmI2S2ZTdjRKdk1q?=
 =?utf-8?B?aHJ5OS9wc2o3NU9BN1lsZWhHcWk4VU5DTUI4T2lVb3U3RUMzamJybWpmOWJz?=
 =?utf-8?B?ZzV2UmVxMDNGYno2ZkJUK1hKTytuamVhaUI2UERQbSs4QnBtemdCV3U2RGxh?=
 =?utf-8?B?K3FjK2VPOW9EWnR2RzNGVHJ6OFJvZWFzQ2JCdDBYN1hDWWVoYjhRU1lkMDMz?=
 =?utf-8?B?SmN3c25NZkZLbktRTmtVdHF1VXl3U0Q2TWE2UHJFSVNCOHNOY3JGMlY4cTE1?=
 =?utf-8?B?L1FhS3FYOUU1NG9NZVZIcnFCM3RBZEVUcC9BWlNBOHBhNFZXeldKS0toVnlG?=
 =?utf-8?B?RldUeW1SeWtEaWZ5NjBVS0FwTzBvRG5lODBPN2Y2bUoxcnRkcmpkOFN3Y2hG?=
 =?utf-8?B?R251eXg0NGtGRHlSL2VxaW51M1RjcnBTK1liNzZrZUlLamRWVXduMzFnMkhT?=
 =?utf-8?B?L0t4dlFZQTJsdnZ2WWdnbWczK1BRd015N3AyUXRRcGdzaHo4MGhOZjMzNDky?=
 =?utf-8?B?aWxYZDQ3RnZYVGRYTEYwOCs4NW9zalVITU9xN3FIcHhZTEFoZ3h1MU02Q1Ry?=
 =?utf-8?B?WjVqY3ZqR2pzRXh4VksySXVscXpGNmRXeDFFZmJaVzQ1VkFvbVBKeUN2eGky?=
 =?utf-8?B?UUxjT3M1eW94OU1JZDF2UTFqNnlySUFva1BwdCtVd2RmWkN1TTJCNExoU0pZ?=
 =?utf-8?B?NjhyYkNpK285NFVMQU1lTWpnTTZWaVRpb1JKL1NnSjBTZWZNNWQ5TXNyeDVG?=
 =?utf-8?B?Tkp6VnJwcEtiMXRzZ0YrZWJMU1M2SVJiNjN1ekJLNDkvTE5WQnNXT1c0Ulhn?=
 =?utf-8?B?amFQMzh6TjR3dGpvZWp0N0JPeTNpQ1lla2RjaEJFbTBVVURQQks5Sm96ejkx?=
 =?utf-8?B?UVpQVEpBSmYyT0dwbXF2NnJZQkVxc05ScVl0RFhXdmdHVHZzTXdKejF6QTFZ?=
 =?utf-8?B?aHltNVJIaFNsQTdQdm1UZG5BVUl2SUo0b2JWeVBuSkdRclU3azMxTDBkV2JE?=
 =?utf-8?B?OVZjcDVzV0JKWEpiTXF5R0pGN1NaUjdTZHMvU29PZm0vMndLV1UyaHVHVnBE?=
 =?utf-8?B?OFhQZFByd0hNdHRvenpIMjFiazlJTjdpbGtHaGkvRnU3S1o1U0pHVmdHK3Nl?=
 =?utf-8?B?QzNMa3JjVEpET2dYRUEyWk5jTmFKempzQXB3N0xDMEtyZFVkUHBicC9jM2lT?=
 =?utf-8?B?dFlJWXIrT3BOSkh2Q2liai9MRG84RzF1ODFXR1VHK2JPTjArYzN5cksxSjYy?=
 =?utf-8?B?b0t4T21Kb01UekdoWUdnS2tYeDF5OHVqR0VDZkNEZ2crREwrNEx4Z3htRWR6?=
 =?utf-8?B?OVhTZDBnTVNTZVJIZnU3MFprbUF0alI5STJ5NUJKQkl6bmhGM1pPa0E0Y3Br?=
 =?utf-8?B?ekErYkhmM0diVVZEOXBNV1ArQXFRbFhiVUg1R2txUlRWdWRlbEx4bldHOWRp?=
 =?utf-8?B?Q3o3RGxFNW0zemVZQkIrZTB6NHZWR0k0TG9NYmkwYitpbzRJZWg2QjRpUGI1?=
 =?utf-8?B?MzZrVDBEUi8wRnZwbEFTOWs5dlhxb00rK2d5MUpzSGlPOURIQXh3NGoybFRu?=
 =?utf-8?B?QVhrUzBZTmRieU5ZSmk1WkNRWWJZbkhST1FPRjBMY2EwNWd1Wm9UUXpHc3A5?=
 =?utf-8?B?R0s0RG9GcnRQc0lvRURGdlBXN3ZCZkRua2hnTjVmUWIvZGlRQ0FmRWxtTzR6?=
 =?utf-8?B?OGd5ekQ1Z3N1OGxZZ0FTeUN3WUNmQlVwVkNYSSt3Z1E5dVQ3cWUzOXo0eFlQ?=
 =?utf-8?B?eHZIcmhMNWk4cnkwdG1TR3MvdjdqSzRBMkVMSm8zc2ZBemVFTkhDMFVxOHFQ?=
 =?utf-8?B?SEdhZ1dMZnhxSW1LekRuaGV1Y1UwWXlERUkwUW5rSFhsNXI1YjdkY2VrYkJr?=
 =?utf-8?B?bjBvUVB5M0tqTHZWeTRlNzZJS1M3NXhOYmY1Z1cybmxmaWNUcE8rZGk0ZHgw?=
 =?utf-8?B?aTdjQ0tJelV0Q0FMSW04ZVErZEo5aFhiN2VCR1V2Y2xOZzZiTEpHZDMzR0Nx?=
 =?utf-8?Q?GxVfcEed+Y+K1jwEsOTfwvVAn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce7f46-84af-440e-dbd6-08dc645181e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:27:21.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv+4C2qIm5fSOtMdCWoyGiQ2yjVPKd61l2zRxfqO5F0yPQXAJHlYrsIwJYW4a5/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264



On 4/24/24 11:11, Havalige, Thippeswamy wrote:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Tuesday, April 23, 2024 11:46 AM
>> To: Sean Anderson <sean.anderson@linux.dev>; Lorenzo Pieralisi
>> <lpieralisi@kernel.org>; Krzysztof Wilczyński <kw@linux.com>; Rob Herring
>> <robh@kernel.org>; linux-pci@vger.kernel.org; Gogada, Bharat Kumar
>> <bharat.kumar.gogada@amd.com>
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Havalige,
>> Thippeswamy <thippeswamy.havalige@amd.com>; Bjorn Helgaas
>> <bhelgaas@google.com>
>> Subject: Re: [PATCH 7/7] [RFT] arm64: zynqmp: Add PCIe phys
>>
>> Hi Bharat,
>>
>> On 4/22/24 21:59, Sean Anderson wrote:
>>> Add PCIe phy bindings for the ZCU102.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>> I don't have a ZCU102, so please test this.
>>>
>>>    arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> index ad8f23a0ec67..68fe53685351 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> @@ -941,6 +941,8 @@ conf-pull-none {
>>>
>>>    &pcie {
>>>    	status = "okay";
>>> +	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>>> +	phy-names = "pcie-phy0";
>>>    };
>>>
>>>    &psgtr {
>>
>> Please review and test this series.
>>
>> Thanks,
>> Michal
> 
> Reviewed and tested the patch.

can you please provide proper Tested-by: line?

Thanks,
Michal


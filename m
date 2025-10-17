Return-Path: <linux-pci+bounces-38454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4FDBE8456
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07F034E440A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACDF3431EB;
	Fri, 17 Oct 2025 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jx/X57F0"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFF3126DB
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699782; cv=fail; b=sAXbsPi3EI5ZWn7vgHON/biJWt7/HSUoiGngRlrTuO/4bgnBQkWN7qC4yLVcBLWtUa1+VK7ZRn3bOfPKOu1dhbiOoNHOupIgtnnYCst8tyvXBHFITc/V6lWmCgco+J3qAOAMMUooAG3H9aoWrJxLYTAP+IqTFGm8phQt9ofmS8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699782; c=relaxed/simple;
	bh=qxTb/2KVHSwHgfqxkw2x7jHA2VeYig1ul7SeNFMxju8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYKZNrmzMrVyQnNo0YGMuC34IxhCCc7MzZXV0gB/4CH9O6T6fruMw2/CV+6GS9+BaIhd4cbjHTjcW11ndK5mP2nj3MrP/qxc9fQU59/RwYLaYNyw+rVC+y8PoT6FGbJrgUhftXbsf0xl45i79pk3bm9PkYd8w0Vzo8TDfv3C8v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jx/X57F0; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI8a4rQfkgHc4PCHO59X1WE5yBcgjHrpf8OKWlw2eqKuwO3f7IjkN1whpdcj9Qc9flT1YBoT4DREB+sDYG1veac+kKuxrTpxQAlXKCyAcFSyioLIS/eDHUthWmNAsq3EKQrt+RU6QrKUlMimoWOHOGJnHQwsPerP+NLWKTDvnptSjnKaCXGM1ol2gl4ZaM3v+h+YZMxhK5rdRWklkoDWDVkkynjU6WJLTTDkqnjbeFVJTo7D1Y74BHRmluCvt6Ut5DADHMR4vGZnECKRhGPJNTmWT3Igztgnc5BmuknQ/4ySiYr/JOyrfQyG9K0kyzSSm9UWBYwFyoVlyCU9MvmZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wWpN4I4OpTi9Gty31SAIzi2MR7bRi6IzqG+kOwXt3A=;
 b=vW+rtyhUKECg18cmtbg+gpE9HKvqFVPU2euLFZpcpD+lfmJ6vGQGhAyxPKQc2r7GoR/iBNSIxrGeDx6k7pdgCjLYPx/vWMLOccsBkOzDi/ry9ikNkf6sj07+C3uweCbB9y4AA8E18ousUhwmMjqLxEJR+K4jjhi38g0zapCeVSM6EQn9enZl32gqPpdpaDBMELRiYhsZK8ERvG1my9mOYRxy1L3Qf8JpAHAlEcR3E5c5ybmu6qm3Cvx/AY1FQsr2p1fC/Hx4iSlYCD5bpbp1TGMW96RAp4w8BG/Zi4e0UZAU17A+01TNv+QkV9dF+4NmddF3pAl66BTlMb35n/iH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wWpN4I4OpTi9Gty31SAIzi2MR7bRi6IzqG+kOwXt3A=;
 b=Jx/X57F0WW2iZ429AMm26hDcwlEkGv5oAu/0jAByqyTcKLFfc6nGJ5+tRO0+U42Dccy2L8OMX6IuTRap25LFNjkL/gjlm45SVAEn6+2p+SXGtLt7S1YIzWzV++zSCoAKmE/d/0/svEs7KDeHQTtLTL6Yv6nzQfmImpOlrJE1UXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 11:16:18 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:16:17 +0000
Message-ID: <39568e87-4ca2-4818-afbb-ec853ff2b495@amd.com>
Date: Fri, 17 Oct 2025 22:15:52 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
 <3d100559-8eb8-46cb-94b3-34ca9fb6dd96@amd.com>
 <68f1c8daae384_2a201001e@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <68f1c8daae384_2a201001e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9755c202-a5a5-4118-4a3c-08de0d6e9777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3JtS21HNi9tLzFXSGFpLzYrSHVqWHFEeDdrQXhEbFZBSEUwT080L3BrejVj?=
 =?utf-8?B?eTNGNXErVnBVOSt2amFKUVFYUFZZdkFYWk1IOW1GMFRWOUdpM0xNbmxDNzJO?=
 =?utf-8?B?akpLS2hNb29yYTByTTV5aGJiRUw4MlhYd0FuZzlXTGs1SXNoRWtmaG4yZzRY?=
 =?utf-8?B?NS9CRldpNTh3RjhuSUVNQ3lhU0NNK3RBWnRVbHBUT3FycXRuRkVJK003NTY0?=
 =?utf-8?B?d0hVZVJaMEhJZFpXYjgrUjJBME94OTZQekoyOFNPRDJMbFREaE9tSmV3c0g2?=
 =?utf-8?B?K3lBQ21Xdkt2YXRlSHJLL3REMzZ1UkR2a0Uvbnc4d1Yxb1lib24zY00wa3E1?=
 =?utf-8?B?ZG5GVy9UTEFpek5TM1A0OGZkT3JNd2MwS2VUem12aXlLcmlMeDZEdkJ6eG1T?=
 =?utf-8?B?cVV6K09hR1ZDUysrMEg2aGdmMnJYWC9UMkJqQktTL2pmYU0rdTYzVWEwcEFV?=
 =?utf-8?B?RUxrLytPa2dDUEhDMW9HM2JXS1NIOWN4MTVxa3didTlYbUhRZnVMOXFXcUlk?=
 =?utf-8?B?Wk5CYlRJRjdoV21ZZ3c3UU9rTmNyNnREYWZZc0tDOVNLQndvOEowRWhwZHNR?=
 =?utf-8?B?ZUprY3hVeVFKSXhUN3VLeWh5ZlVVSnpuck5ZcmhCRGpnamxpcFpua2hpSktS?=
 =?utf-8?B?S1I2YTNDWkU2OENLRFFEY2pKSVBhRlp5SmhUck1NVG1EMytPZHE4WWdTKzRz?=
 =?utf-8?B?K3hLdW9Bd0RORHNiKzFqeHBqT2MyMnpnVTN4OFZ3N1VzZTJHZmRUWng2RnVz?=
 =?utf-8?B?RE9lUU1DSWZoMHN6TnVodjlkY1paOUZLUlhhZmFxdm43enRSVmNka0VBNzdF?=
 =?utf-8?B?cjNYQlVnNDU0U0lpMTlmK1hzOExwYjZJb3VwV0FFMGRCekhNb0ZjM01MeDll?=
 =?utf-8?B?QjRCNm5tSFNDa2hKYkcvWjk2aVlRVXY4UGF0ODRxSEg0VnlaMW5Yd1BiUlk1?=
 =?utf-8?B?RXA4MldsZTErcnFWdWZPRzErdjIvaFlZanJXQ1dzdGtQZVBCTjZFVFArUXR5?=
 =?utf-8?B?aTc4cWNzYVVpOEZCaTB6aUFLeUdSOHBvWElCdGFQc3luRm1ldFR4OG9XQUti?=
 =?utf-8?B?REN3RWdvYXJObk5DRXVGU25xKzZLK0EvY2RWY0xSM21OYTYwem5weUgrK2lk?=
 =?utf-8?B?OUtyZ0xNdkN6MkphWkZsOVZac0hXbW9UTzlQRHBHampvUHg4MDBUYnRFM0Zn?=
 =?utf-8?B?dUFlUTVUa1lCaUpMWE1hdGp4V2V4ZFdxbVBOTkNpRjIrMWZEZ1EwcDdQaEVj?=
 =?utf-8?B?ZVluZ1gzMjdUMFl0Mk1GSFBuZkMyQkhJYk44Rk05OG1VcTZLRjJ0dTN0NFBT?=
 =?utf-8?B?MEZzTVE2RlpUL2FaNGdINU91bmYzTGhiemhBeGRxL045ZWNTWnZ2OVNRMkFL?=
 =?utf-8?B?S2NwT2JseGMvZXFVUU8wOFBENjFaUXFXU0twazZqTkQzTUN4Nlc4azFCRjdH?=
 =?utf-8?B?SWtqR2Z5NGN1cEhuV25reC9BNCszdklCaFdvUGxtNlZsZm15bVd1eXhHbFhn?=
 =?utf-8?B?eGd2aDVudFZsQzh6eW5nV2paZ1BYd2duL1BWUU11KzhlRVczcTB0OXlrMEs2?=
 =?utf-8?B?QXhRVldZZVkzSmR4VTIva0ZNM3pFZ0JrZzFEMVd5NnhRRWhoRERNdkhldXF4?=
 =?utf-8?B?UjI2enh6TWl5WmVrNmM2dFFOd3JwcGYzSk5hMldrNGsrSmI0V3ZOdWxpSm1I?=
 =?utf-8?B?TzdnUE54RnBuWVZqaHhKME0rRjlDbWEzbjdTNUJzZjg0ODVrL0RZQjkxV2lj?=
 =?utf-8?B?RGxPbWdHbjhucGpJUU1BYUdmdDJDanFDL0VGVHdIQ0hjSUxPakVMeEJtU0Vl?=
 =?utf-8?B?Z1I2bjJyZTVDRmE3WG9iTDU2RmloZi9sTVFTd2pZK2RPTFl3a01yQXhJb2FC?=
 =?utf-8?B?aUdGWlA3SXUyRGxoTHloQmZ4ZmRseUlwTzRrb0V5REZQUHNSUTJZcHRtcktQ?=
 =?utf-8?Q?I+SLLOIFQJqPNtpdKaT/v85uLjvIx37L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZYdDB4TU9RSjZCbTluS0loRFRoRXFlQno5QjEwWlEwYXBldUt3d1NCZXFW?=
 =?utf-8?B?SmlVdGoxZXU5bGJ1bFdCb0VZaGpNZ3AvcEtQeGRYa0NLVnVyYlYzd1JMeXFI?=
 =?utf-8?B?WElObXI3VFVqZHdhMTJFWG50UTkxSWdTUUQzNTlPem5uZklncTlweTRWSHRz?=
 =?utf-8?B?V3VYejFpZkVFS3EzdysrdGFicGc3TzVzS09Vb3dRa25OVEZNMVRLN1BoL05B?=
 =?utf-8?B?eDNLWDZYRk1IeGMzWWZjRVIzQVpkaWFIQ3dTV3RqWHBhQktSdjVJMDN0L09w?=
 =?utf-8?B?NmQ2aFd4UzhXMERhL1pidFI1dVlTTGhFeUFHcmR2NGdVQ0I4eFdmVmZaQThC?=
 =?utf-8?B?OWVJYkFnTGRXd2I3bGRxM0JobnRUUVpvMlNmbUxWcnd6MzMxRWtqZUNvdE4w?=
 =?utf-8?B?a3IwYlhteTNxSUc0aTE2eDlpNFJDWjdsZzlyUTlZS3p1RVlkaTVGSE1RUjg1?=
 =?utf-8?B?YTlqV0dNUXF1aDRYeDFVaE8zK1pWQWlvWmwydm53UW5oaUZiN3hIcFdwSTJq?=
 =?utf-8?B?TWJYRno5WEc1MkVvb1lFdXRJQmNTQWlHZ1dteHNKS3RhckY4b0ZKeSt5d05V?=
 =?utf-8?B?YXh2VXhOTGtlSVRYcUhLd1RzWm9UbEVHdWdrV0k0azFhUHBXTFR1azYzbWxB?=
 =?utf-8?B?Q1I2OFppbHNQZGt1eWIrdGFJNStlUm5MNGNnSkkzZTNLVVE1UlBVSmZ2T3lr?=
 =?utf-8?B?bEVMTFFOOGRNcktxeE4xRWF2VytGSXlkOG4wMjQ2M0dsY3gwTFU5Tk5oWHls?=
 =?utf-8?B?YmxPVG8rNiswQm1DOTZwRDVJUDBmMzBZM3NIUHBtL0R0Z0RHbjF1Q0VZMjFa?=
 =?utf-8?B?S0UzMG9NOElWNVhmZktQUGp6OXAwNTBCUUNJalRKZzQ0ZkFhZ2VLQ1J2WFRF?=
 =?utf-8?B?SXo3NS9CMFNTMTY5TXU2Z2xLTUNweFIxZlhHcW83YVQ0bm4yb0Q0a1hoOW5u?=
 =?utf-8?B?U25Yb1V0WWEwTnFCaVBwenA5VWd4dzdHV3VvbVAwK1ZYeGozcGFxTTdiZmtu?=
 =?utf-8?B?VldjcjJvUkUwcEZDcFQrTzM1Um5oMkc1QUR6bXVoZU5VK1U4QU13QWtFVlM2?=
 =?utf-8?B?RjlwOURFMnZCWmpxY2pjK1BlOW4yNkt4THgyY2xBbDFYZFlMQUhKZGZrem10?=
 =?utf-8?B?dklleFJ5aDNvNzd3bTJkS1puRHhTeTBjdGxKMTNrNUhpNU9xWmM1YzRIN1dq?=
 =?utf-8?B?WEdlajh4ZHFEUEljdGZvaXlUWnBNL3ZCa2ZVeC92aUs4c0NUTG8vYTY1Tmg4?=
 =?utf-8?B?ZzNPTzJBU0NpZFkxV3FyWFFrZ1dUNnI4ZEw2NU1mTjErQlhiUXR4bmxtNVBx?=
 =?utf-8?B?czVWamtvckVhclc2dE95TDRUMmdpRG9jc1ExNVluZmNtWnMzRmtlZ05LNUl6?=
 =?utf-8?B?WFRCV1FLZUEwaklvTkRPUTllL1V4Nk1Od0pDRUQrRGl5aStjdnlBUUlzRkpx?=
 =?utf-8?B?WnZuZHY2WEtVYnkyVTVqSmR6eU5jZE1RRGx0SWwxV0ZUQkoxRS9QT0lDOEtS?=
 =?utf-8?B?aC9oQU4zR3BYMC9VN2tFNm81ZXM3K0I5ckh3S3VsY1krbFVCcWhhSDQ4dXcz?=
 =?utf-8?B?M0xHMW5CbnNzSjdhQXBOempoaENiQWNQTTQ0RzNUa3ZFNkZ4b1pYdjZLWDA0?=
 =?utf-8?B?K1V5N0M2dFNnM3NRN0UrUXRKYTJoeFRYMzFXSVA1QjFUSmliMkhMbzBjbE1s?=
 =?utf-8?B?elJKek5waTFnWEpSVHNlV2tkUE9LY3RrTzRvNHRVNHhWNTBEbG50OUpNR2xs?=
 =?utf-8?B?WUY2cTVsNkRBSHRnRDg5blozT1pXQmdxYTc0RjlhSWJrUFFoU0pKM1N6VUk5?=
 =?utf-8?B?aTdhcFJKTmxDT1NKZ2lGYTNMci8rYjZ3NTN3S1k2SXhKaDdoalBIUnQ3dVpO?=
 =?utf-8?B?RTE0TVVXUUxmY1h0M2NubDhmQ3lYcUtYNXdER2dibmVZU0RUVjJ0Uy9DczRx?=
 =?utf-8?B?UTIrSGFBWnQvT2FzWmFZdzRWL3hQUWpXRmJNMEliTi9hbEZKdzdWYWNWUGF4?=
 =?utf-8?B?SW82YkdDRmVFcTBxZ0VJaFY2TzN2UmsrMXYxMHRiMFJiOXM1dWNpWUZVMnd0?=
 =?utf-8?B?bVVCdGNIczhSajZHQkVGRnExYWVQcXVydVplMFhTNWpGU0V2V0VaZWV1dzRO?=
 =?utf-8?Q?ZsH/MZ1VkeieIRvM/sL6ct6eb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9755c202-a5a5-4118-4a3c-08de0d6e9777
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:16:17.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AphaSTfTuPc1uQW7x/FoTStoIpuuIqhLiAf6in7/dsSfH4bNbWRI0/4epbQs/SPudaM0sLN88pchRHvQTuo8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874



On 17/10/25 15:40, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> +	/*
>>> +	 * Now that in use ids are known, grab and assign a free id for idle
>>> +	 * streams to remove ambiguity of which key slot is being activated by a
>>> +	 * K_SET_GO event (PCIe r7.0 section 6.33.3 IDE Key Management (IDE_KM))
>>> +	 */
>>> +	reserved_id = find_first_zero_bit(pdev->ide_stream_map, U8_MAX);
>>
>>
>> pci_ide_init() is called when PCI is probing and at that point no
>> stream is enabled so reserved_id ends up as 0.
>>
>> Since my platform only wants 1 stream, should I have called
>> pci_ide_init_nr_streams() with "2", not "1"?
> 
> Hmm, no I would expect that number only needs to reflect the assignable
> id maps.
> 
>> pci_ide_stream_alloc() fails to find a stream - fails in:
>>
>>    struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
>>            pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
>>
>> as nr_sel_ide==1 (my EP has just one stream). If I go with
>> reserved_id==0 and set ide->stream_id=1 in the PSP TSM driver, then
>> streamindex#1 gets programmed (which is beyond the end of IDE cap)
>> with streamid=0. As if reserved_id is actually reserved_index but the
>> device wants me to reserve an ID.
> 
> The intent was ID reservation, not index. Will take a look, but first...
> 
>> We could simplify it by assigning something like "255" to all
>> unused+disabled streams. Thanks,
> 
> I thought we were still waiting to to determine if this behavior is a
> quirk of a test device, or something that Linux is going to see in
> production?

Well, the justification (about scarce resources in devices) remains so I suspect this behavior will continue.

And I tried blindly write "255" to all unused streams and that works fine too so the IDs do not have to be unique even for devices with that uncommon interpretation of the PCIe spec.

> Yes, I want the reserved id to start at 255 (unless BIOS already stole
> that id).
>
> In any event I will send out v7 without this, but include it in an
> incremental update along with the address association support from
> Yilun.

Sure. Thanks,


-- 
Alexey



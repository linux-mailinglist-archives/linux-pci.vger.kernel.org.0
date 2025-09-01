Return-Path: <linux-pci+bounces-35295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6EFB3F15B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 01:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26587A5996
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBC253B40;
	Mon,  1 Sep 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ojYgzNML"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C51BA4A
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756770570; cv=fail; b=u5rUQOlLGjt5ewfplD5hkl8eWeti0aPAulpq3GzHv0OR8ZKx/5gTW0+gduvpFAHJmI0wK8fbzXe919t4m1Cr0OQpUReCH9IkD101xL9U1qKHgN5fvtCk1SzZiKWRlrSvAEX3kxHgtClI9kUJrPn1W866vp1OyMxj4uYvuUC6b/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756770570; c=relaxed/simple;
	bh=1DhKHEhf2z7fPSj8QUgIBK+XlyP/55k/UGy1dnXi7CY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XEOSUWkELvyefwhnviHOZ9tTiKpRf5ZQw1cUBtCqOreCeI5eG7J1PQ2gcn7Bl+x4aYwr41rdTxE7yMNd/wnMlDt59k3SJ3sp4blXjcVchIcGVcddRa4HMO1sexUwPtvI1Glxa58SZOv6Hj7+brY5nlMK8l39PRhi6CaFxORDrXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ojYgzNML; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtpG1YpWW6WJOqgVf6jaxXtmKqVle47dR465905bxoJ5NT3pOabhivfu1INKktLpLSQFIjlPw2DEYitLb+G7zxQcAS9cTRKfiRNdNuEJ+cnC2jS6proMWXEN1KP/hVIWATSPH9FbKyKU0175w5MLvDO4MNLcGU2YKiuOvLcUE/RTswnvIsnNjO0OtTKCg18yn/SjGwTWKaBiyKhkJoE0QBEpcXA9Wn55bahl5WoGv6NgHTX71pZQWBGxqhuiDl9KvhFRBtqUnz0Xv4+MjHLFvIg54Qr5oYlxKN60DAD8qNWKWlwCJZ14ioIbLvhCUWINf0bkoNoWNhR/aFtprQbmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs7xcVZsk3+NSu03swA7yLkpVnn7tTtgCP3jrKwo81Q=;
 b=CgdGZGYaH05FE04M3OL28+lC+Biyp1EpJ5GePGkiS6UKIsjy77UCa9Ex2fYe/KZQNjUMp26O+PfQvAxB4mFM9f16Whgi260LM7yJH1Y+Kb4Zf6V7cttmG9LzCGjMQkgTkRJUPBiVVW0UeHGQJcEmuNtfHurnSwGqWt0bu2oSi9nYI6Mo34mz44/C6Oyxfh/D368uCPi8zQ5vnhxDJoeaRkzReMOi8t5AkrPk29wqHqh/QsPtKLWYWdJOzGDUpSzCGr4XIY3pgyYguMV/eSSPBCjcsAHNW43UFxxwX40JxGEqeBSR4n5EDXed+sVIqZ7h9QELKg2YyW6K+8N8IuFH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs7xcVZsk3+NSu03swA7yLkpVnn7tTtgCP3jrKwo81Q=;
 b=ojYgzNMLWa0ZqmG0gpSto0xG/oQ2s2+MD67vGvS7p2SPdlZeyqgUyu32xszzIRdDBGnv3DHafLN+nkwAMeZDdZn5ga/13l7QPmAcCq84dtcJuC1WN0C4u8V07icS5s2s0IPJ06Ozwb/v1vrMIFAm8EhHJNfSAkBE9jaALOxAMQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Mon, 1 Sep
 2025 23:49:24 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 23:49:24 +0000
Message-ID: <6b07daa7-665d-404a-b5aa-c6053dead62c@amd.com>
Date: Tue, 2 Sep 2025 09:49:18 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
 <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
 <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0048.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: e00f13bc-e8e3-4a62-adb6-08dde9b22ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUJIMVdTY0w0MEFiQk9XOVhQeFhsRzJrOC9pQ3pCMGYvc09WQ3FKQVErc0c5?=
 =?utf-8?B?WTZvb2lXRko4OUNPczk0QzRKaVhydkhFSkpPZm9uRDhuZ1N5R2hVZmFxc2RL?=
 =?utf-8?B?bXVJTVh4YkR5SVpsallwM0JDdGRxSUV5cE1yQnRtcWJCbGlEdXU2dGhjU3VM?=
 =?utf-8?B?N2pCYlR0N21uWUZ3S2tBQk5sRnRjZ0FjSGxDWHJaU05GUUdUOWMxYVM1alZk?=
 =?utf-8?B?RjVhbzlFN01INjdDNUVKclMvblRXbGlVUWZ6NWJOek5MN0lZNHZmMm9hR3Vm?=
 =?utf-8?B?YTYxaE1JMmpIb0lKdFFLS0JLZC9ENDEyVndwUm5yYmdDTFQ0MVZrQ0JLQi9W?=
 =?utf-8?B?aXJxdHFqajNzV2Q5NEIvblVUYXdSNEdUS1F3ckphckhPTCtWOHhQUGYzZTAv?=
 =?utf-8?B?T1UyZHpicVN0K0ozZUhWcnVkL1l2YzRHOXZnNXlxd0pnQTJEUE1sdy9ZRWdG?=
 =?utf-8?B?a0pZUWVJZTc3RTExcU11SHpSd3RjclRFamtNdk5JS1FBcE1rL0FESEc4aUlL?=
 =?utf-8?B?K2R0bm5IdVc1RFBGbHFnR1NWMzJKb0gxZEptY0FsdUZ1Qk5nN3JKS1dQR1FN?=
 =?utf-8?B?L0xrRWRLZ0l2T0dCdmR3MERyMUVSTjArUGZpWDdGYWpiTFdseWFpcmVGbEEz?=
 =?utf-8?B?LzFHT2xFbjF1dHlqOU9FOUxWdWdzbnhOUzFENE1vZHdRWWFsRDE3YkxNQ0g0?=
 =?utf-8?B?UHFBaG93QlJ6bnRjVUJSQy9LSzBDYU1taERJeDVsVVNYdE1SaEs4VHYySVB3?=
 =?utf-8?B?VUMxL29YbUc1OVBBM21uS0RBS3lUNXY5aVRQNTFVbk5nS2xxcDA1RFc1eUJF?=
 =?utf-8?B?dU9QRkYyYzBxZHo5OG1ENTREd2dNV3ZsUlIwM2I1TjNTa25rckUzQlVOMytP?=
 =?utf-8?B?MWtOZXY5ZTVsTWNxcTdJZWhVNjRiMUxHcndnWGtiM2h4dXRjUU51eWJ0MTRp?=
 =?utf-8?B?UGxFbndyVGtXWmw0VVd5UTF6aDRzZDVoZGN4ZWZ6OFZjWkF1NDZKaWtZR0Jx?=
 =?utf-8?B?M0JkL3U0Q2t6ZDczdGFjMUFYNTE5V0NQS1J5cWJkMGNQRitjV0VncGRCZGpN?=
 =?utf-8?B?elVpMHRCYjBLeVcyOHg1KzB2NTR3eEVGeGhUNEV2QmdaNFp2NEQ4S0YzR0Vw?=
 =?utf-8?B?TnN2Lzk3SU1Ybk5YcE9oWXIwZEF0bUxOMlJQd1ZPK3hQRDlKZmI5aklvTVhr?=
 =?utf-8?B?UkRpZHlFWFYxb2pOZWhHZlJ2dTBKcENiVzlSMFlhTnpCL1Zjc3ZoQ1hHa05y?=
 =?utf-8?B?cS9jZGVpN00xU2tGelBwZlAvVkVjM25XMGZxOGF4dTBoZ1lwdncrOUNielNI?=
 =?utf-8?B?MW4rQ3h4OUkwZFpJWXpJYUJhRTZWL21jMm5mUXMyS0JwVTZuZ1Q4Y3hzdjRa?=
 =?utf-8?B?ZnlhYXo2MkNnaXJGNkRGQmVDNHJpWm1EMTJIYkFiN01xUnFEM21LbHBYOGF3?=
 =?utf-8?B?dUI2aHcrbWNyUmVyRXVKTTZwcHRWbTJXc1RwOGhlck9TTTFXejFMbEJlYy9M?=
 =?utf-8?B?bk1LVzFraEdHdU1LQTluMHNkcVVGc2hSOUdZY1lWemlGM1hFOUxiQmluaGFC?=
 =?utf-8?B?UnV4cGF2S2oyOTZzZ3FSMXkvNW9uWU1ycFRpTjArZGNydXNTbEJDcGhYdk4x?=
 =?utf-8?B?cWFDbHdyTlNmSmdJYktxUGhaTlloZFhMRExDSENKaTNmSXV5Tm1zSTZ0aVAy?=
 =?utf-8?B?YVB3WTlMMGxKS3Jic3M5VW1hRGRNMkxBWGxVNUhtaUdJcmNVazNHU2FhaWlL?=
 =?utf-8?B?cjhYUGpYMXRVejVFdlBlcXNTMUJJWFBxM3JDM3FQbFd6aWpkcEc5QUdRdldP?=
 =?utf-8?B?SW4vNFFrMHB5REtPR2g5ZERaOEFvaGxEeVNqbEtJOGxKejdLMGZDbERzOFBO?=
 =?utf-8?B?emtGS0U2TDB0WkxZcUlRdlZ2NHY0eE5ld0NpdUo3NndOS29NTkxFdUo5eHBx?=
 =?utf-8?Q?NZRMqKkZVxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkh4QTdaR3lmdlFwK3oweWYzb3dlTkcvSURLdS9BOWNMMGZid1ZnZVpTamky?=
 =?utf-8?B?RmptazlXODBhRTNieU8va0NSdHlhSktLUmQ4ME96NnJ3dVRLbk02MEx3bExq?=
 =?utf-8?B?c3lBYlRIaFNNaUxZbXBYZVA4ZktSaTlpWVpRSGtjbGZjVVg3TXRXWXpMa2RD?=
 =?utf-8?B?T2lLeGRiZGdXQ25qWTlKb3Y0WXBsS0lvNUN3OG01MDh0azZLZ1hqYWNDK0lp?=
 =?utf-8?B?cjlVVm9zamQzbjlheGFiRWNOL21RU0RadTRIWDBtT2NuYUNNOXdpMEJxSEhQ?=
 =?utf-8?B?eG9NaE5QUi9hQTcwN21NMFhPYVRtbGx6TnZkeXUzQldiRFB6WkxndjdReDRL?=
 =?utf-8?B?ei9sZldUa01WUDdLdlp2NWRLOUFjREtWdzlwcFdvRFIxYVA2TUZYaHVBc1ZF?=
 =?utf-8?B?ZE1yaE1LYW9scEZUeGdvQzYraTV5RWVTL09UbHQwVUd0NytYWWhnZEFUR2lt?=
 =?utf-8?B?YXZ2bjU3QWg5bVkrUFM0S3hPV1R3SHp4RWNSNzBHaSs0aVNqMWdMZGNyb09r?=
 =?utf-8?B?TVgzanlwbFRYSW9WVTAyS0laRU1yeHFxUjVRLzlobzg0bEVZTFNSbGNIbTIr?=
 =?utf-8?B?SlRzcnYxVEROamhJejdSaEFVRDV1L3phUkVwUXU2amw3YXpDYjhuTTFkUkla?=
 =?utf-8?B?QStRdkRwc2U1OXJwM0Q3Vkl4aDZPbThWV1FrdVN2TXpLaFNYdDNKcm5FOXdB?=
 =?utf-8?B?YUFRY3VraVYyT2p6K3hWL3lLWmtyN2I3RVp5d1Y5d0E2SnhhMGJGcmI4d3lz?=
 =?utf-8?B?VFN2Vm1jeVp6Zm5naW4wS1ZpMzJvYWRibnRXeGdER3ExUHlJUFkrUnBUc1Bn?=
 =?utf-8?B?bnpmdUhQK2pxYTNiOTZBa3VuOFh5QXNJdU9XNGFXTmJYTy95NVE2cWczRkVI?=
 =?utf-8?B?RU42S3lxY0VtUFRHZ0xsUzBWbC9tZVhhZnpEOVhKTGR3UmpISFJaRmx2Mkdv?=
 =?utf-8?B?aHBNemZFbngwQnFOUXBqbkk2L0o5OVRNWlpPb09VWGxjZURMZkxta2tiRU1i?=
 =?utf-8?B?dWFzVWlFQ0VBZzVLTHN4ZGhscndBOVNXRW55UkpqZ3B6blNGL0JaVmdmVHBR?=
 =?utf-8?B?TWFhVm5zUUhNZkZvY3o4NVVzWHAyc1ZoQUlmY3VLOFFTd04zTHVMQzN4K3Jp?=
 =?utf-8?B?dnVUakErS2FLbGZtRlhtWnMxZWZyLzhUcHFtMU8zU3FkMFFkTTU1L2ZvcWpy?=
 =?utf-8?B?TzJkSGtDWEx0dnhtM2xsRm4zT0RCc3B6QjVKeHE2T3ZnWExlRnlOYTNWZXJZ?=
 =?utf-8?B?cWJmQkRkMXpkYWx2ZDdWUWtya25GSEI4SC9ySXRyUHZNTzg0ZkxYQVQ5Y1Rv?=
 =?utf-8?B?NmxETDFCRi9aeHJQZzVQaFhrQU8rRm11SlFJWW1LWnBDR0ZldG55V1R1eTNo?=
 =?utf-8?B?QlN3MzU5dEpwbWxVdmlsSFVVa3haVzhzTitFVlRYUjRKN0tOTW0yYWpTYUhY?=
 =?utf-8?B?MTlxUzh1ZzZzSU1GTFY4MEc4NXJENzlVR3pZK2daMjZVaDE2NlZ6RGtWMTNF?=
 =?utf-8?B?djVWb29HTXlrRE9BM0hOWklMdWJlRDA0dkdzclY5azhBSHNSWDlaS2x2N3Bo?=
 =?utf-8?B?VkZvZThaU2ZLdkZIcmYrMk55bklHVDZuNVVjWVYzZHg2dXZZM1NmWmcwNVk2?=
 =?utf-8?B?UVA2U2hSUmJSNUxTTkp6WG5Id1FzZDRocWl3Q2Y5VmpJYmh0MHFKekpFay9W?=
 =?utf-8?B?VHlOMWRhNFVoZVJJUnlPS0ZwNVdPTU5zdHJ4cXhBYXhEekpkMWxPSHdBM3Bl?=
 =?utf-8?B?UnBCNVZ6UUZzdVEzemhFNTJtakFhWVVJaUptc0E1dnlkVXltREMvMnQ0UlVx?=
 =?utf-8?B?ZUlDWWgrQzZQaUF4NFROK3dOZTgxRmFMaEIwSm5lOFR1a21MOHlEWlRWenVn?=
 =?utf-8?B?VXBCaEQ2WkN3bFlJa0s4WjFDaWRPcHB5ZzZ1L0lBSisxSmwzNHU0Z2Z5Y01S?=
 =?utf-8?B?ZDkzZG9MSzRrcnZVZ1VVb2g5WG1sMWxVZEozaUNiUVRHM3hrN2pHS2tHR3RJ?=
 =?utf-8?B?TVNHck1kZU9ueFdhWXJjNnVFRzhtWmJoZ2VoRVByL3BZNGFHZ01KbXA1TENy?=
 =?utf-8?B?d1lyS1JDcDVJREZ6TE5hMGR4WkNxNlhlT1ZNMWVWWStLY2ZsYnhoRnpJR3lD?=
 =?utf-8?Q?ik1nV6eEPJ8ZvJQvwIap5F6WF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00f13bc-e8e3-4a62-adb6-08dde9b22ddc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 23:49:24.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfEv9wUQkD+nbeO9JQML1CUUAGj5LIcCnPTNREoJf5P70SHJVi81SBDPbrZhbaDdOVFmAK5PgQ1a+7SOcHr+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272



On 30/8/25 12:37, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
>>>> these in pci_tsm_ops will document better which call is allowed on
>>>> what entity - DSM or TDI. Or may be ditch those back "pdev"
>>>> references?
>>>
>>> Not immediately understanding what change you want here. Do you want
>>> iommufd to track the pci_tdi?
>>
>> I'd like to either:
>>
>> - get rid of pdev back refs in pci_tsm/pci_tdi since we pass pci_dev
>> everywhere as if a pdev from pci_tsm/pci_tdi is used in, say, 1-2
>> places, then it is just cleaner to pass pdev to those places
>> explicitly
> 
> Maybe if we see that that are unused then they are easy to delete later.

It is way easier to do now than later when it grows. I'll dig a bit.


>> oooor
>>
>> - pass pci_tsm/pci_tdi to pci_tsm_ops hooks and use pdev in those when
>> needed, this way it is clearer from the hook prototype what it
>> operates on.
> 
> I think all of the operations need the pdev + extra data so it is always
> operating on the pdev to some extent. I think this is another, get
> "Aneesh and Yilun onboard" case.
>>>>> Out of curiosity (probably could go to the commit log) - for what kind
>>>> of request and on which platform we do not know the response size in
>>>> advance? On AMD, the request and response sizes are fixed.
>>>
>>> I don't know. Given this is to support any possible combination of TSM
>>> and ABI I took inspiration from fwctl which is trying to solve a similar
>>> common transport problem.
>>
>> If guest_req() returns NULL - what is it - error (no response) or
>> success ("request successfully accepted, no response needed")? The PSP
>> returns fw_err (which I pass in my guest_request hook), does this
>> interface suggest that my TSM dev should allocate a sizeof(fw_err)
>> buffer at least, and if there is more - then
>> sizeof(fw_err)+sizeof(response)? I thought TDX does return an error
>> code too, surprised to see it missing here.
> 
> As we talked about on the CCC call it sounds like at least TDX also
> wants to pass an explicit FW response code separate from the response
> buffer, so I will fix this up to not follow fwctl.
> 
> [..]
>>>> What is going to enforce this and how? It is a guest request, ideally
>>>> encrypted, and the host does not really have to know the nature of the
>>>> request (if the guest wants something from the host to do in addition
>>>> to what is it asking the TSM to do - then GHCB is for that). And 3 of
>>>> 4 AMD TIO requests (STATE_CHANGE is a host request and no plan for
>>>> DEBUG) do not fit in any category from the above anyway. imho we do
>>>> not need it at least now.
>>>
>>> While the TSM is in the trust boundary of the TVM, the TSM and the TVM
>>> are not necessarily trusted by the VMM. It has a responsibility to
>>> maintain its own security model especially when marshaling opaque blobs
>>> on behalf of a guest. This scope parameter serves the same purpose as it
>>> does in fwctl to maintain a security model and explicitly control for
>>> requests that are out of scope.
>>>
>>> The enforcement is market and regulatory forces to make solutions are
>>> not bypass security model expectations of the operating system.
>>
>> I get the idea, it just sounds like it should be a mask -
>> READ|WRITE|TDISP_STATE|DEBUG. Which category would MMIO_VALIDATE fall
>> (set "validated" in RMP)? Thanks,
> 
> Curious why is MMIO_VALIDATE separate from other Guest Physical Address
> validation? I think if it needs to be separate from other GPA validation
> then it would be in the PCI_TSM_REQ_STATE_CHANGE scope as it is just
> another expected step in the LOCKED->RUN transition.

For normal memory there is a guest "pvalidate" instruction to set the valid bit in the RMP. For MMIO, there is another bit in RMP which says "pvalidate" will fail on such entry, instead the PSP needs to set it (which is pretty much memcpy for it) as the guest needs assurance from the PSP that the RMP still maps the right thing. Thanks,



-- 
Alexey



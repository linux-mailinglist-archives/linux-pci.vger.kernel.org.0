Return-Path: <linux-pci+bounces-31982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A1B027D8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A393B7E9F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B0197A6C;
	Fri, 11 Jul 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rc+iivMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DA17736;
	Fri, 11 Jul 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277567; cv=fail; b=cKJlW0egOP+Pxt9icgVhjE6fitX4gQK78TTGK8MJMRVYa2L4uAIj7l4OeXT/KrhvR3tcv4fnEdePfNeAWJ25IEXYLwhsZJYqcPdbjnzfPgPBsZP8FhDtM7+rClspBk1ex35E9HfMXEz6sCgHTCj/w5+I5iGNn+QjRLqQkEwOwbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277567; c=relaxed/simple;
	bh=97QKnvuneVhPfeAnNmgCfOSIrrgtmzm3SVRlbemWTuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fizTcwEKssxMpkMV146N2mqfFfig4SipINFjRAgFJbK2tIj8+CQeW70ipJDp4OuoGsPfWGiFF3Vaiil2aqhIGP/dHCZwxgvpeMvB/EzZlHEA6XtVRYNr8jregjpCg3JduoTYeFG8Ni/96Hy/qiPpX8RHTu3kOvZTlvCh6XYJUX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rc+iivMB; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiR9hhgsEl8D3JQc6YyilG0/AGC29EuT+lJ8JtJ7K7dq3w2qiAs7zxkoCFaaAZl9RuGiVTLlUgY+mqgUIesEhuhkP/QsGnOCimyecMBX+Oqdm4aKdm20t/lUhWmZ5nwinGNFKxXIBs9J7UURYGWUlV1h2yOxit+GXE5tGvJt0RlLIKM4pf/aD7E6bJ51kvqdPpjqrv08dEjbE7OQOAc81IJAlpOo50aZ470WW1eR0CPuFEoDO2ibJLvF43rspT8tZfVjzLItdZVBZEYR76AeqGGN3OABdbtdUSo3gOp8MmAjvrxoNA5VS/IyFVcn9ik10KhXxwxPg9K+CHnPtnVKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icO+KDk0FbG2SViGNBNCBexBtNK88egRcriZ1Qm3eMM=;
 b=Z9rayBmw1QunNR0T0EngKeYOdnXnfWKZE14LkCnzR1MCFjSTts76XsV7QKKJR1KEH4Ps/3HhtxS/V314Uqa53+vuW312DfaA82mu61loSuMcPizsSnmRUR41CbHNsdNH1OpPksb8ApWNJw6bzT+zPU9adP0fM0Fk7vGDO0PiFXJAZkAfW/WOCTQSRjFTPaRmXYaVpSrQez7CqFqe4ptR4bSe9dxWndlJlI09a0/sO5mnPrYosw0wrV2SwZE9O9wCD2HIWUWjvVQVpav4AyErz1ER2psF2lYtHVdslfiKHmyWVp+CZ7r6hUgob2JLsKVjlgG2PcofNyAke5UompD73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icO+KDk0FbG2SViGNBNCBexBtNK88egRcriZ1Qm3eMM=;
 b=Rc+iivMBHZxEPO4k/AuUgJBAyp9zpWrKOtCFm0C5elrYJV/XIrOTRkuwQlsA4LmxJuVMV9aHthkITIJiFLlEP3atk/OvQse6sOzmcCivSeRQ4wdw9VlInTrhR/Varf0SAL9WXczyNHGxm/dNiT4sdzWczYrzzvk4hgrHfBCkU4YbXDKAa3FlO3JExCIFnfRUmJDSh0JLXNiC4WtLA1FgDi36lbcEyWA49o4ELKFy9qCK/hq1OPw+b1QrGflV4SMOwuGuwHdwBLPbO624E4TlHwUMpz7FMMzbchEzg0nmIoamUtp11RWfo0zvb83KCRK1aPVvRS22C0g/0+ZiiGGGww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 23:46:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 23:46:01 +0000
Message-ID: <4c885320-4fb7-4b6b-9dee-be65d1d6ec42@nvidia.com>
Date: Fri, 11 Jul 2025 19:45:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, bhelgaas@google.com,
 kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org> <20250711193537.GA935333@joelbox2>
 <CANiq72nP=u49vhj7+Z_digM+gKk0_=oAWUofbmyntyPsKy=+ew@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CANiq72nP=u49vhj7+Z_digM+gKk0_=oAWUofbmyntyPsKy=+ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: c62e9077-b82a-42bd-5274-08ddc0d517da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkcyOTZtUWloeUx5WDV0aGNsd2NyTFYyS3hycGdoTll0Y3h2aEw0Yndlc0pt?=
 =?utf-8?B?dlg2Rk5nSkQ1UG1XMU95MDNvU3hjOXlGUXdyVXNNMnJrcitCcW9EZk9DczVB?=
 =?utf-8?B?eGxOSkwvYWw3WTh1S3NWbGJ0b1J3amFXdkdtelNGbUZVQ214VHJ2QXRqdHAw?=
 =?utf-8?B?UzZpbE1mNHlWMjErdndMR2RoUmdjRHdJY291MlMyR0oxcHFpazlYWE1YR1g5?=
 =?utf-8?B?NEswZ004OXhBRE1NK1VkSjA2TmZGUTlkNDRZdlRSand4c1AzL3o3WjFyYXBa?=
 =?utf-8?B?RnhOakl0Vm96UVEzR25SQUpQUTVhNGJ3UmwrMW1YOGlyckhuSERqYmc2STRx?=
 =?utf-8?B?Y2V3c05qRmxLd0xwL1BVVW9DTHRDczA5U1VKYWhRbXVXMzJpc25ZdDZYWUZI?=
 =?utf-8?B?aFBnakt5aWFFanBQT0Q2OVM4SnNLYjJ1eW92WlV2TTJaZWV1WUJXQmo1UGJ1?=
 =?utf-8?B?TEg3bDlrUnhucm1BNVQ1R2d6U2MzYjBualRFNWp4elN1TnZKR0RsUkhUSVBk?=
 =?utf-8?B?b2FSbDdRNnpWRWRtemNVWlF0d2ttUmhFSUdDc2pYbkRDVy9oNlRkTk9Xb0w4?=
 =?utf-8?B?anYyb1RPeVVaYzlwUkR5ODNZYmZoRXI4TUpudGhUZklrRUtlV1ZaZDJXUmdl?=
 =?utf-8?B?eHVNOHJIc2krQzZmWVRaMmdnOFJHVElyTnJ6b3E3T1BBV0xMMnloTi9JYTlx?=
 =?utf-8?B?ajcwVWhhYnVxZWI4c1l0VENSTFo4SmYrK3ZHRHFZdkQvZEN5UlhTK3hGRWdn?=
 =?utf-8?B?N2NRL1dPekFwY3FXZllmbm5vMjdaeXE2TS9pZzQ3aTc1YVo4YmFNeklDR25S?=
 =?utf-8?B?eDFhMXkwRE1pR2ZKWUhtY3ZKWEpaWlFOQ1NDMGlaVitmVjJuZGJTMjZFWjJB?=
 =?utf-8?B?YzRTMlgrZVRqRGpRZE9tMENYK0tyejVVNllwendOMXhhK1pEV3NaS0MycXBT?=
 =?utf-8?B?c3lPWjRkaS9WSHAzMFV5ek5nQjNJSVhsYVZFY3dOM0VpekUyN1YzenV6TVI0?=
 =?utf-8?B?VTBmb2lvb1FYdDgwYlZNZHJDWEREYitTRHQ3eU1WaU1Vc0NhUTFDY3ZXMElh?=
 =?utf-8?B?YWVkNytTUUtTWmdOL0craC9LeExXYlJhUVIrU3pvMjhBQVdaTTZ4ZktsbUls?=
 =?utf-8?B?RGZnTHNJOWx4WTh2Yk05MW9qRkNOWm1oSW1IQS9rM1pOYjJySVhiZEpkOXNz?=
 =?utf-8?B?OUl4WmxLN3JDKzYyV1Q5bEpRN0drSTRjRlZ4RDhrdnEzTXplSGJWVjZJcDlN?=
 =?utf-8?B?YWl6bWVCdDNEUnlrRFdWYVptTFJaaU53SXl5SmJBWm5rU1lJWUYzdXNEUFVt?=
 =?utf-8?B?Q1RSclpFS0xBa2VLbVd3Z0xvZnhTZW5Va0d2MVFmYW9iQng2bEFrY3JjSjAx?=
 =?utf-8?B?U2N2dWpXWUFGSkszc1FjNjA3SkxVMXQ0Y3VyWFJubEFMTUxIVHk3Z2dvc2ZR?=
 =?utf-8?B?NGgxWWpKa21sbUdMVzUwQ21ZTURZb0ZkWkUvR0g3OFFVeVBWNEZrQnJseDNL?=
 =?utf-8?B?aFFIV3Y2ZnczV1dkYlB0R3U1cDUxV3VDT0hIcHllblNQMmFaQkI5S0FNOElW?=
 =?utf-8?B?MGZwb0tQZ0FHV3V0RW1DRVZQMGZQZTNIVmQ2Nmpqc0tZL0tmZEVVK1pCZDVI?=
 =?utf-8?B?ZXpmeEtNNkZZZnJDMHZtQUJiVCtwRy9FQkY4c05RSWpsZ1NhSUIrQXhUUDdy?=
 =?utf-8?B?d1FjNW5JNStCQ3RMa3dCL3JkWUU1ZlBDdkppaFp4UTFJdGtJVjRJeGxWTzNI?=
 =?utf-8?B?TDlBSVlKajFOb0pPYUM2WkI4VGQydnptcFdNUWI5aEgxYmJnWjFWSWhXbTd0?=
 =?utf-8?B?SkE5aFVZN3FJcmJtckFQai8vTmw5ZC94Vk9kaHM5Y0pFbmlDVk9CODdXcS8w?=
 =?utf-8?B?L3VSYWViQnhkZkRVZlZTeDlVenk0RWpMRFVNSUJjRzJPMkU2S0JZdUFFRmlB?=
 =?utf-8?Q?mf/gdRX+hWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRDcU1zU1FlUklCc2FMUlYzNE1IdGxWRkxWYU1LZmh6S2NhVFVoNmt2aGtn?=
 =?utf-8?B?bzZjZUM2RE9WbUZTOW5oTG9jQUx6NTQ3Y004NmhxdkNTRVBvMzRGakxiV1RS?=
 =?utf-8?B?S2xsSWFYQllRc051UzZmeDl2L1BYOHVnV1I2eXg3VmJjSHM1dGFEUW5pNUU3?=
 =?utf-8?B?ZTF0cnpINVRTOWpJQjJWY0dWNmVQOEZ2dEV3NUZtT1BkREJKcDJFSHJ6Mm9P?=
 =?utf-8?B?bWIzYjFnbExuOFN0TkVuL015OEhOYjZzWFM2MXlCclBDUG5TYVFNejc0YklY?=
 =?utf-8?B?R1lGYnV2R1JxbnVoZnk4aVpMaEpZWklGd3hlNUQ2TEVEcW5QeTRwVTdHZE5G?=
 =?utf-8?B?S1ZReDArUTMvNnE5NnNBcnRac0tJWG9tQ0xTRVEySXlROERzMUNrNzhRRXlC?=
 =?utf-8?B?bUh0UkR2ekZVcHlWZkJrM2FPbGRXVnljL1I1THIyaEMrQnN1UGpMS2JWaDhE?=
 =?utf-8?B?UlgzNmJnTTdES1J1UUpBOVUycWQ2WXI4WVNyZmwwS0dZakllS0licVlJTmJY?=
 =?utf-8?B?Ni9vQ0ZtQ01waUZSZDlkd1ZTSEs4U0czQVp3TTI2dkw4Tk96RTh0SjE4SjdQ?=
 =?utf-8?B?RWpuUEFHaDFXZi9rVC9QVG1oa203anl3MmI5dkQ4MzVsQUNzMThCNDM4TTBt?=
 =?utf-8?B?bGN6c1RLUG1qSmIrMGRFeWdRQ05vbEhtcjFhb2pvSEczamtoNEY4dldsVXB6?=
 =?utf-8?B?ajJTM1l3dUo5bU5Qc1U1Tk9ZMUxXS245M1ZUYnRpR1RIcTloNVNscFFITzhu?=
 =?utf-8?B?OEZKZTdrRXYrcHJBeGdSeHZuUytuTUg5Q3NTNkxwRWZ3cDIwWHZNUlgwTHVJ?=
 =?utf-8?B?RjBZcHl0enhMVXlxT2NvRU41ME5KWHdVRU5zQU1GbktKMEFwZVFUSkdXbVhn?=
 =?utf-8?B?Y0ROMGx5dC9WcVVNcEtnQStwd3ZwekUvQmlwWktGZmdIWkdsOHZ6Qm1yVk5X?=
 =?utf-8?B?UnJLcnF2VEl4LzJzRnZrbVhENjU3alp0bGdtNlc2MWpGS2d3Z2hMa0tZZUVL?=
 =?utf-8?B?bnRka3JUWmkwMENNNWtFcVpnR2prUmVBeGljeXZVdVhqV3VMcWlYaVEra2Fw?=
 =?utf-8?B?Z1VQdXlEM3pkZmxXUkhuRkVkSkhqc1dxZDI1TUFxb1RVT1FIK2phcVdxNXc2?=
 =?utf-8?B?T0o1ZEtSdFI5YU95QkNZQTRyM3QrNHVIdGF1MTNJaWFTZzFFUHcwNkVhT1Ez?=
 =?utf-8?B?ejRNT2NRZmZLM0xHUFJybjlrcVQzcm5MQUZTSnA4R3hGZTlTTEUweVBqc0tB?=
 =?utf-8?B?SjVmNSsrak0xUnlPd2kybUxXZVExNk9HdFhwamRlcFN6ei9GSEoweG44NE9p?=
 =?utf-8?B?MFY0RWZidG94cW5ENG9Xbm5qQ3cyTWJBbkkyNTI5K0E5RE5wYmhMU2c2cllH?=
 =?utf-8?B?ZTg3dHVSalFYMVpiZXhxeFhOVFcyUnovYUxubzQwR0RlbUJIbnhUdzVCdmJp?=
 =?utf-8?B?Z2NHaEFLb1lEWGh3OXJ6QWpnVUVQWmZXc1pKRldPcThaZ2hvOEpRMXBoN3VY?=
 =?utf-8?B?TlhUR3BjOG0yZXNNRGRCeUpQMmszYWdIWUo3QXZ0eW1YRVNxTnBUMTlJcnRF?=
 =?utf-8?B?TVRLdm52b1JBckV5LzZXU2Z4cjNKQklVM0FVUWFJR2QxMlkxNFM4SW82OFVz?=
 =?utf-8?B?Y0pDTzNDYnNTbDkyZlFlV0JlZzRqdU9keDhtdWNXZkp0SjBCbCtZTVkrdllC?=
 =?utf-8?B?OTdOWjRuV0RaQjl1U3YyTmFlZkczb0paRm9LWkZ5OGlWZHFBVThsc3ViNUZn?=
 =?utf-8?B?dG5Od0dGK08wUXUwOFhGeG5YbU9mNHROd1FoYndKK1pkU0YvaWYrZWVHNW15?=
 =?utf-8?B?aUZuamUrOGMvYlh3RFpTbFlBM21jSGs4eVVKcFVOaUE4WkNJOE9NOEdZZlMx?=
 =?utf-8?B?UmJtT2ZMZFhOMTRjU2RDZlkwbGlnakw4d0RJWTkxQzZpOGtFeWxuVFcwanNv?=
 =?utf-8?B?RDJVbzFtRFYyY0pEUEwwY0ZVN2dxWC9HQ3FDbVlHbkloaVVuVkkzQ3EvS2p5?=
 =?utf-8?B?SU0zNDBETTZKQVlMSDRQNUFlU1RaWnREdG01L2x5Z0pTT09OTnZmLzQ3SlRl?=
 =?utf-8?B?REgvRlFlcE04Q2dKL2VBRjVwWUpDQzgxd2Y5VTVjUmIxQkFkb1p2Zm1xQ1VS?=
 =?utf-8?B?VHJTVVdyL3hjdHk3REV4STFDYTFCazZ2cHI0K2xpcFZzYW94eG5pMWdDNDBC?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62e9077-b82a-42bd-5274-08ddc0d517da
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:46:01.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cUyI2apVwqF3S/6KrgcIzCNr9/wBss8sIaV5vQJwyBrFDzH1TR/2pcw/5dYtZrZ/EKAMDXkLXk+UjeV2ndSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256



On 7/11/2025 4:14 PM, Miguel Ojeda wrote:
> On Fri, Jul 11, 2025 at 9:35 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
>>
>> 2. Since the Rust code is wrapping around the C code, the data race is
>> happening entirely on the C side right? So can we just rely on KCSAN to catch
>> concurrency issues instead of marking the callers as unsafe? I feel the
>> unsafe { } really might make the driver code ugly.
>>
>> 3. Maybe we could document this issue than enforce it via unsafe? My concern
>> is wrapping unsafe { } makes the calling code ugly.
> 
> Yeah, this sort of dilemma comes up from time to time, yeah, e.g. see:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72k_NNFsQ=GGCsur34CTYhSFC0m=mHS83mTB8HQCDBcW=w@mail.gmail.com/
>     https://lore.kernel.org/rust-for-linux/CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com/
> 
> In short: that is the job of `unsafe {}` -- if we start to avoid it
> just to make code prettier, then it loses its power.
> 
> There are few alternatives/notes, though:
> 
>   - If there is a way to somehow guarantee or check that something is
> safe, perhaps with a tool like Klint, then that could allow us to
> avoid `unsafe`.
> 
>   - If the blocks are very repetitive in a single user and don't add
> any value, then one could consider having users write a single `unsafe
> {}` where they promise to uphold X instead of requiring it in further
> calls.
> 
>   - Worst case, we can promote something to the potential ASH list
> idea ("Acknowledged Soundness Holes"): a list where we document things
> that do not require `unsafe {}` that should require it but don't for
> strong practical reasons.
> 
>> 5. In theory, all rust bindings wrappers are unsafe and we do mark it around
>> the bindings call, right? But in this case, we're also making the calling
>> code of the unsafe caller as unsafe. C code is 'unsafe' obviously from Rust
>> PoV but I am not sure we worry about the internal implementation-unsafety of
>> the C code because then maybe most bindings wrappers would need to be unsafe,
>> not only these DMA ones.
> 
> It is orthogonal -- you may have a safe function that uses `unsafe {}`
> inside (e.g. to call a C function), but also you will see unsafe
> functions with just safe code inside. And, of course, safe functions
> with only safe code inside and unsafe functions with `unsafe {}`
> blocks inside.
> 
> In other words, a safe function does not mean unsafe code is used or
> not inside. Similarly, an unsafe function does not mean unsafe code is
> used (or not) inside either.
> 
> This is the usual "two meaning of `unsafe`" -- that of e.g. functions
> (where it means there are safety preconditions for calling a function)
> and that of e.g. `unsafe {}` blocks (where it means the caller must
> play by the rules, e.g. satisfy the safety preconditions to call an
> unsafe function).
> 
> So a Rust function that calls C functions (and thus uses `unsafe {}`)
> may or may not need to be unsafe -- it all depends on the case. That
> is, it depends on whether callers can cause UB or not. And similarly,
> a Rust function that does not use unsafe (including not calling C
> functions) can still be very much unsafe, because other code may rely
> on that code for soundness (e.g. an unsafe method that assigns to an
> internal pointer which then other safe methods rely on).
> 
Thanks for this clarification and write up! I need it so thank you very much Miguel!

 - Joel



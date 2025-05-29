Return-Path: <linux-pci+bounces-28540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B0AC77A8
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17C2500B36
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AA253957;
	Thu, 29 May 2025 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/KySBh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4513AC1;
	Thu, 29 May 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496580; cv=fail; b=Ea5V0k48cVNtX0tpf6pkfSdZTxJzwKWHB5JnzspR7qW6mPKDsNtuX4vg3/GkXjskMIh0tL6mGunCjJweUykNdpnoYqzLsL/nkfVFEi0r6uOy8Koflp2WaivM6EHc6iXR0P2DWLM3LT8dD6Bk75wBW061XjHguxzMJBsliwARECQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496580; c=relaxed/simple;
	bh=C+M+TOmeeJ1BEJwYvh3f+RyebBIh+iLAUuzteZRg95E=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MBFzuLc/kAMfxGVvAwN2MQdpqE1iMktvOf+5/cQCXaEmBCRs2LuA+LEBMjJCH+N0mWYbB9eQPyY+6/Cy5tftl/c3a+aLvc3YZ2lPGBRvszjxWW8wBV0lFXYxXDOptlygEPqHnP9CHcwUR/Ox7Ry3lSDnOmA9/NXxmtMG+5CHw0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/KySBh5; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI94LGIO6ha2ir8FzN5jRGDiQMDgE7sWE3Wbr6k2L8+v16dvLQBACaLuk6C4Z2yLF9rlOAyjv3b5P/Y7gzzx1ChWZGMR+LtfBpylWBeSmvEGg9WSUak1lxATTyQCZFzEIKUiR8i38MkZutxoOoIZcLR3taahEt6AisWtZexmYhnCCX1ldHfrZVcHL6ydZi5rm/Bdre9sFzp4A5qMDGRAgo1B/NSJXQocNXTkm4JJsP9PQ/xIE2JBpP7oJkZnTtJLNmd5JgHQGgDaQNmGJzpsuKj3cmPrDYuW/18jnEpthPzzPj5EwDCABkYjw4Q6oqp1OGoc8dFIzKDy5OtcqZ46fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QELpkHI0pNN4A+ZvtnsJNnF2RKWRZZRBNMN88P/IYyE=;
 b=kxcAoWQ9XSkgQHcy399tzf4p1/1BrOM+PMxOGkSth++WTfIs4SvUZDgpFQ9rg4EHCr7KfEmA9NkYT/xn0FfsmFvBr8awnaieMnoeltzw0BB9C2OxkVqLP09RCllgmHpwCA0UAkRMr0Us/DEVUP4oCSMmon77yZeI29g4Ax5CJBQnoxd9JAPP5n+O7Gx+4HLH5dz8MetrInvOHB2QtVaxU3Yvzf/GOqBJXQ9mAHBpDvsAsDkPD1wXzfYg5n6mKoD6upDNcSwQPTJJHEwkvmNAf+HzcYh/L6k+ARvaWv/g97BZOe4odSEX9gQWARUGIn5sTYhvfEmVaH4WZ5gfy+YUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QELpkHI0pNN4A+ZvtnsJNnF2RKWRZZRBNMN88P/IYyE=;
 b=z/KySBh52ZSLkBTRKFnn4OPoFsnyu54mIu+i6Ipz9IU3N4hwAzxEDn120H7NmzAoRRZBulB/mK6mg8y6EiMb9H81/AIkWFXz++1tQONknH4phQAJh7o/kExx4jjRNCOaiyeESoe8zaIR0NBfl8KTkL0OgA53vdUKYAAVc5uaHiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 05:29:34 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 05:29:34 +0000
Message-ID: <91e2985f-0815-4918-b7cf-c593bc2fa96b@amd.com>
Date: Thu, 29 May 2025 15:29:23 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/18] PCI device authentication
From: Alexey Kardashevskiy <aik@amd.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
 Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
 Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com> <ZovrK7GsDpOMp3Bz@wunner.de>
 <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com> <Z6zN8R-E9uJpkU7j@wunner.de>
 <dab69e0c-37c2-41f1-a9db-fe116fe4cbbd@amd.com>
Content-Language: en-US
In-Reply-To: <dab69e0c-37c2-41f1-a9db-fe116fe4cbbd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cf0c75-546f-48ba-0ef2-08dd9e71cb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUE3Z2dvRklOc0F0azFkN3JjdlU4UmIvY2tMRld1VWovY25ON0svUldXcklE?=
 =?utf-8?B?TStXMmlnZldjcndVOWpKUGtQRDJmVk5RcENyMVlTQXpMaFpEV1NNTHBjT3Nj?=
 =?utf-8?B?YzNFVWc1Y1F3TG5pRldkckx5d0Z4a05ocmtHOWQxRlV0WWE5NEg3R3NXWjll?=
 =?utf-8?B?NHUrVk0vWFdDQktTbWNsNlhOWXFFSG90Q3RVcGI5TVZ6K05BYVpuRU5meUxr?=
 =?utf-8?B?UGJ5UHQ4SHdsMUozb2hvMGZZQlF2WjUwakxjM1pXYS9xck1HUnA3SmV6djhH?=
 =?utf-8?B?R0FIRysxcGZHZ0Q2V0hidXQ3ZVFzWUdwa3BXS05PaERsSzVtanlYU01BeTFt?=
 =?utf-8?B?MGhSUUFDMUlUSnVrZXE5eWJZV1lRNXFKWHJDSWozeTBYK2FqZ1BTSFJWUDd3?=
 =?utf-8?B?SW1CTTlNUjJMMGRzaU5nUGlSL2RDZGo4NERjT0hYNUtsQVk0NDJxN09hSjJ0?=
 =?utf-8?B?RnlpRlpEQ1Fzc1A2K2w5TmF1dGNVZE84eE50a000U0VGWFlyd3RzanZGK3pH?=
 =?utf-8?B?MnZyWHJ0eXNOZGl5TXdCK2Y1a3pybHEzSXVrL0RlNjZsenZaR2R1aCtud0dU?=
 =?utf-8?B?Vit3QnpnVFpFQ1dkVVd5dU9HRE5ZS1JNZWRCOWsrdEFjN3F2Q2hzRUZsalpx?=
 =?utf-8?B?b2R1S3pXS2hMRGVwcDd5OFltWno1Zzgwclo3enFkYktzenJqc3dIbkZrbldN?=
 =?utf-8?B?eVIrUm1Fdll0Mk1YdHFxYlFXUGxEdFYzc3FxcktOU1dZcHdOaEIrbWVmcnlX?=
 =?utf-8?B?R2VRZFRzclR1TjlWRHJ6UUYzWmtVWklSbHdjK2t6TlV4YWtlWm5mRjZ0cDJM?=
 =?utf-8?B?TlVZUFlrVG1kalFnb09DYktLZmkwN3JkL0V4TG50UEVMR2VjcVB4MWVoOVkx?=
 =?utf-8?B?NmxmZVcyU0grYytjYzg3YjNiMVhKZUF2YzhZSW5ySFRiNFloQmxrZVhwNkcw?=
 =?utf-8?B?OUVnZ0EwVVFJV2FJUlFvejkxWXdMdHpZanVIeFY0RnhqdDNGY29hc2thbG1G?=
 =?utf-8?B?Slg5MmZmWGx5WEpPT1hSSDZWRW1LNUJtSzRjRTdKWk4vYzlZZDkzcEhrbmUx?=
 =?utf-8?B?WVJEL05QVmpsQVJaNTZTcXgwNDJIWGVoUUhObVljci9YSkRCSnNSYWJFT2tH?=
 =?utf-8?B?aS9WYVdBSVNlNisrYVdUNmwrVTB3Wi9sd1JIeUFMT0dMdE5pUUJjdGtpMlV1?=
 =?utf-8?B?Ujk0MWJhRGQxcERsSDJNNWlGMWVDVDBTRmdUcGMvNm9TWW1nOXp4em1JOUto?=
 =?utf-8?B?Ym9WU21sL2xxS1puWGVMNWxnUVIxejlIajFQZUx6RUE5UXZPQ1RkWkRubFk5?=
 =?utf-8?B?VUdkWURsbkdCb2dXMWt6Sjl0d0VUMm04UU5wOVFTc2wxV0s0d084aDBCem5r?=
 =?utf-8?B?NThXOHhhOGhCb1kxcXJUVGFVM1B3TjNKcVE5YXcvU05zVDg0V0paMXc3S0Qv?=
 =?utf-8?B?M3VvS2g4bWhLRHNlaXdaTFR0c0JsVkMxM05zREIvZ29iM3k5ZTkvQ2lwdGhi?=
 =?utf-8?B?UmpzcmRCMWxpelhPKzRkeDBtVTFWZHVGYk1qV0tFOXkzb245eTBMR01MMU9o?=
 =?utf-8?B?bmhWLzdIa3BqdnoyLzZVT1lVcndSaGdodFhoTWJmYXYyN1JUMW9BQnJtditM?=
 =?utf-8?B?WFFPMVJrNTQvNjNrb0l4eGZSN016alNHZW1WUG1xNEUrTlBFc1F6QWFMQ25m?=
 =?utf-8?B?bUpjMEpXRjlYR2tDK1hqSWJwdDBxOGwvOUxad1J1R1k2WG8zakVMbXU2Qzdh?=
 =?utf-8?B?aDJyWU9kaTk1NEZ0bUhJOE5NZCtvcjRkQXJKUmJSaXBzdmtQRDhPV3dXbHlt?=
 =?utf-8?B?M3dobVhHc0VGZ0RCdTE5WEJObVg5S3FFcGlPRVA3UzdVSEExelJTMXQ5T1dR?=
 =?utf-8?B?cjVoSXFDbGplcDY5QXJ6YTgyOCtQbkhxOGxvb3g1Vm1ZNy94eTR5d2F5eUFE?=
 =?utf-8?Q?QFexsZjvISaWiBpsi4/EWN8NUZtKyUs9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHhXTkhrRFMyb0VCLzF4cWkvSE9SK0pQbWlCcko4a1NvR1VoRE5PVm01enls?=
 =?utf-8?B?N1FuRXVNMm42RXV5bGhteUhmdXdVWmJOd3p3YkhIQ0U2NkxJQzl4cWJGaG8r?=
 =?utf-8?B?NW9BSFBRWDdFRVExTHgxRXpWQ0lHWVZUK05OQlZWUklwYTZMaGtEb2liR3RJ?=
 =?utf-8?B?bVZIckNRb2trdFI1UWQxeC9tWi94YXpobXFBR0VKS3lnUDVLZWtsKzNiWk8y?=
 =?utf-8?B?TU9oYmh2NVlFdUtXM1BWeHV1TUlBQ2hsdWptakxvbVlmNEJzQ29ZR2psemRq?=
 =?utf-8?B?aVJ4czA1Vm4yNERIbWdYVU10dFBqaGhSWUJ4N29jeGVoWkNwSXpkN214NCtG?=
 =?utf-8?B?YjRuZjc3WFIvVHJkNlAwd0VkWlNEMFRTbE93V1MvZjNsODVMZkZNWUJwWEF3?=
 =?utf-8?B?d2FYRVFrdCtnUy91amgvR0d4NG5Sd3Bkc3lDbWp2QStCQ2hVbCsxSzZDaW1I?=
 =?utf-8?B?dmpDOXNIcEJoU25aUnNiUFFOL1FvekM2MFFlamtEMnN6V3BSYjFrUDUwSVh0?=
 =?utf-8?B?UUcyWFI0SHp4UzNoWTNZazA2Mmxuc1JWeFBnaXJHY2pqRUh2TmQvYmtNS0Vi?=
 =?utf-8?B?N3BTVWsxS1VmSUdwZTJDS2lXOFIrS2V2aGZPSTlsY1NSSFh3alp0VDF3aVM3?=
 =?utf-8?B?Yk5aNFlHS2p2ZGVhcHJqTDcrQ0ZZQm90STRkVXJrRnVRVmx4T0didmZEMDBw?=
 =?utf-8?B?RUhHSnRBMkVHaENtK3VESk8rY1VCbHcyNk5Mb0w3Skg4TFpNV0FaaXVTQWNu?=
 =?utf-8?B?NlBVNml2OTcycklwNHIwOGZBdWp1NzdYTzVBUVJEL0RVS3NadSsxNmRtemxi?=
 =?utf-8?B?dmVnU1RDd2lwZkUySnJ5cE5UTFFjeFcrRG9OWkxITHMrTVNQRUJoaWRlb3FS?=
 =?utf-8?B?ZGdwVUduYnFFdTlsaE5RcVQzTzduRnM2TUt6Yk8yN2c1eXR5OStGcDZxQ0xa?=
 =?utf-8?B?RCs3RE1JemxmVjFQS2wrb212ME52aHpvSzZ6OFBHVjQ0UXkxRFZBOGhrREZH?=
 =?utf-8?B?OWRGbVA3M1gveXV1VUJnYnA0dVEzTktDY0Y0QnRBanlYei84bjArb0dDN3N5?=
 =?utf-8?B?Y1pxbmpCcmxNUVdvMTgxbVZiV1pSbWNCWGVsaUFuNGUwa2o2MlhuSDV2TmV3?=
 =?utf-8?B?aFZmUGVUd1pyOUcwTGphM3ZaVFJzbU1pd3B3LzVVR0NGcFhMR0RhZ2dDVERC?=
 =?utf-8?B?dS9lamx1V0x3TmlSamhwUXJjOXZoMVR2bExVMVVrMENOenltaGVrSThjb1F5?=
 =?utf-8?B?aXZOZE9HOVV0Nm5RRkcwdWhXRE9RTDZYQnlyODhnb1dBbkp5LzZwUXo0bU81?=
 =?utf-8?B?T0FKYVR5RkdlbjdhNzlKMVUwSlhGbkVFVTJQR2MyeU1vR1RxQmpEZjhzZTRC?=
 =?utf-8?B?cWQ5S3ZCV0gzL2hhd0tJOG5RN3FEK3NHU0t0cTdhcDBOWk40WHBNNnh6ZkJ0?=
 =?utf-8?B?N01uU25JNElRbHlnazVUTE4rQzk5ejJZQ1FRWGNoMFJzdEJLL2dXNTRtWWxX?=
 =?utf-8?B?SXU3Yi93YUhqTHp6cGJaeWJqa09pTks1RjZ5YW1qVjhkQlBXV01ZUk1CN2tE?=
 =?utf-8?B?bjFydUtQbDI5KzFqQnhXWm81SlQ5RnE5SUFGZnduTE5pKzcrTkRLSEJoVHdH?=
 =?utf-8?B?U2xLYUxTdnU3VG44WGtsN1FLSTRETkFoUllBRDVPOW9NREtzUmZZVHFheHJT?=
 =?utf-8?B?NzBBNHlVL0JjL0hvS2NqMVZKdUNXeUg5YXJVWW5CNVZGck5TRnd6aHFmTDZ1?=
 =?utf-8?B?Y012KzBPRHNFU09pSUk1OUxLc29maXV2SkZLSElyWUpSQXZhMHppWkEzbW9F?=
 =?utf-8?B?YzlXSG1xSmJ6Um5JUmtvQlZ6NU9BZzVVTTZ0ZUlDanBzbGtxZlZGYVFwYk55?=
 =?utf-8?B?dFVuTmhIVlhBN1htUVdpNGpZZVVkZlBmblE0UWJoSVFYQXFIMXg0R29aQUhZ?=
 =?utf-8?B?N25FZlZvdkVTUEhMaEp5WVR6aTZWQytzTHF1bFFWSFc4K2Uxa1ptS3lEUEwy?=
 =?utf-8?B?NVZNRkVVZllWc2VCeHZoejkzOWkwQTM2SlkyZndPcXdEdmZGN0xTck5VZmk0?=
 =?utf-8?B?dDJ4b0ppZ0FhSVd1dDN0ZjZDZ1BvTmMzR3NScDdFLzNmLzdPYW9yZjQ2NzlE?=
 =?utf-8?Q?aEdH34zyYggg6ewDolVlrV+Tn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cf0c75-546f-48ba-0ef2-08dd9e71cb71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:29:34.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3g+ZRPAvxFcEc45KcCG9fM0np+96lgKuC9cHKVddz1V9uDL2kN/UNmFqQpkDiZd9eSpvPzpEhrocp0pii7S1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884



On 20/5/25 18:35, Alexey Kardashevskiy wrote:
> 
> 
> On 13/2/25 03:36, Lukas Wunner wrote:
>> On Tue, Feb 11, 2025 at 12:30:21PM +1100, Alexey Kardashevskiy wrote:
>>>>> On 1/7/24 05:35, Lukas Wunner wrote:
>>>>>> PCI device authentication v2
>>>>>>
>>>>>> Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
>>>>>> expose the result in sysfs.
>>>
>>> Has any further development happened since then? I am asking as I have the
>>> CMA-v2 in my TSM exercise tree (to catch conflicts, etc) but I do not see
>>> any change in your github or kernel.org/devsec since v2 and that v2 does not
>>> merge nicely with the current upstream.
>>
>> Please find a rebase of v2 on v6.14-rc2 on this branch:
>>
>> https://github.com/l1k/linux/commits/doe
>>
>> A portion of the crypto patches that were part of v2 have landed in v6.13.
>> So the rebased version has shrunk.
>>
>> There was a bit of fallout caused by the upstreamed crypto patches
>> and dealing with that kept me occupied during the v6.13 cycle.
>> However I'm now back working on the PCI/CMA patches,
> 
> Any luck with these? Asking as there is another respin  https://lore.kernel.org/r/20250516054732.2055093-1-dan.j.williams@intel.com  and it considers merge with yours. Thanks,

Ping?

> 
>> specifically the migration to netlink for retrieval of signatures
>> and measurements as discussed at Plumbers.
>>
>> Thanks,
>>
>> Lukas
> 

-- 
Alexey



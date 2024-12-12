Return-Path: <linux-pci+bounces-18256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCA9EE465
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4658D1886B7E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FA210F62;
	Thu, 12 Dec 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1NDLofT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9710F2;
	Thu, 12 Dec 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000251; cv=fail; b=XoLQ6TgGz82amiKDahOYcaW9B0nNrs2kA43gb7gXK4ffdbMewLhIzrKqUzz1bNiM3kNHtex+mj2Geor/Q1IW9uld/OT9dLXuXZNv6UIA+8Vi3WlRr82DhhqWdLdPsyVUSN0A61EuBGUmJ8dAsQOKUMIzllbg5Lz6q69wmL++s0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000251; c=relaxed/simple;
	bh=+tEdKxADL5/Cha9pB2rxBanpkiq4lXsqaZRUH8ztRCA=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNFbVVIHzncO/nyVvfK7W+ObD6d8m2pR04nOkyWegiiROBc49JIiVOTTywy4JdPXU7mD1FX3CbaaXdNqfcOFHsttJg6zCXQmERGF9Ml2BMya7a/S8NByZi23nlQzrkrYMfbN5zx4BHWFGdEc1pt64jwzrv7AhmjF9w/WznlyM4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1NDLofT6; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRZLK60uEA0V5vInfvlT7cm2tYgbYIVjlu9ew2RIl6eg0UevEYEiHufnvPoW153zMNtUYkUL2HKx4Pewgf9Y4hHsiCYzuxbNKw7W0EFXF/4T8dx0VQwfqXJPcvPOaHKNOf1YesNCch72V6QMnMqOIgGtIKfUxFSyqL3XZ8CdyTyayd7Wqm0Ye3v6JpZwE9lgAXXyYaMlrumabqW29NN260AyFxefN0apN6R5Z3mxJu6uy4CPyAUZp+0Ot2hEidgLQQ3TCNlBSvLBVHgyXvfHqMAdRvuN16BjySQ4RskOKpITmj1d1MXTbXvQIkrYzBUx1nI4WUPWLn0tDgPWlH7v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXbgK0a2JCPAAzRcxRuTDW3ociSeUVmbqeJSdvvWwmo=;
 b=Ea2yJD0kNAfYdeM2UwRO6jbsVSQNWe0hcTGmFIhaBNWfEGq36f+x49eX0nignZXzk7/1WERAgIxaGcRTbvF9/aW7886sYxcpKobQNK5VO5hMV7vX+kjb99HajL7uVj1JcvIygcTwbD7SVQndJfLDebYvYHTmGMOVXvuVU3meQrQXSvh61L8k20UczAbMumUrnwT/dgvCyyR0PMwqn3DLCeFd7yvOPoAgtloHivvIyege9FJPPwIBDHWIE8kCJeGZfhZ2ZeDKzWnsloraWsPkfwCG09OrFAlM+b2Ipv9CRCaQI2QAmZg38gYKcrlZ3yaIoNnSU8lvsS2XWOpYyC7S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXbgK0a2JCPAAzRcxRuTDW3ociSeUVmbqeJSdvvWwmo=;
 b=1NDLofT6JxLOiaUzoXI13OEbt6Vee/spLIWOB52t9FgQ9wNNMQn1IajmGBppzWhQO4S9Otzp8o51HjO8Tf3LYxSu+NbTJrbgpGAyhuE8DUtjjFW7R5wBWNxsX9K041pTJBmpjWPI8K+wIIiU5+wxgTbZj7UtAqN6PZi4Z8ygEHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 10:44:07 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 10:44:07 +0000
Message-ID: <15da313a-b289-fb06-2f1b-eba5dfe5d30c@amd.com>
Date: Thu, 12 Dec 2024 10:44:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-16-terry.bowman@amd.com>
 <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
In-Reply-To: <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efff7ef-6265-42de-7712-08dd1a99e72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnQvZXBMenNQcS9DU0d0SU1USVZjRUlsYUIySHhSS1ZxQlpabS93c0E4YktU?=
 =?utf-8?B?UEFtVWd5bkh6ZGlKSGxLUTRUSTIzbklEMjlqUE5uYmtsSjJDOW9hcldhMGh3?=
 =?utf-8?B?bXRBdWxvcWpwenhyZFdzY1IzcnZWRXRmTzlhckFabjJIZ1QweHJLcWRZeVBn?=
 =?utf-8?B?bGJoZkZiSnNibGNhNUovZEtTS05FMWJ6TGg0WktTNlNkMUpHcHd0SkRlazAw?=
 =?utf-8?B?SlVtZFl0ak4vbU9EQklhT1c5K3lvMkVOa1RBUlRoVnozckdCTTBiT05iMnlB?=
 =?utf-8?B?L2t0QndTcVlTZTB2TTQvVXJldG12VHUwNlBsajEwT0h2S3lUK3c1anJnRkQx?=
 =?utf-8?B?N2JYMXF0eThYdlpPUi81OVNhRHlpNHhaNzN1WmlTMXF0KzFaZnh1cHpNVkU0?=
 =?utf-8?B?amlkclNhTWpHQkIvQnRIMmQ0VFM0RVZxMnVGVi9xcm1aQTNXZUdibmRaRTlI?=
 =?utf-8?B?UnlJRHZDLytCME1iUnZvT25sekxTSFRMcnVUZFFUSUdCQWJ4b0cwUm5lN1l1?=
 =?utf-8?B?ZmVIZmVvcmJZVkhZT2xKK1ZWMWZIWkpVaW9qaHliN0FzK2pJNWR4VmRUaCtt?=
 =?utf-8?B?Nk85TUdCb2ZVZjc2OVU2cG1laTNKeC9vYmpNQlh0Z0FBK2xTUE9iS0xMclor?=
 =?utf-8?B?NGNUUXBIOUs0M3U1SFZxMWt6eUEvQUE4anFwQXhvamR2WmpyQUxuRmJuV2lP?=
 =?utf-8?B?TnRBUU53NnRzeUhVTThVMTIyRmJoZFNJUDk5Q2pqZmVwMkplYTFRYU1YVXl3?=
 =?utf-8?B?eUNoa1NDUENIOHhMcHBUQU8vUDJMekNXWll6Y1VpSzZQUlJRN3F3RjlQL2cz?=
 =?utf-8?B?cDNQWFRVcloySnJpaUxnTkEzajRJSkQ3dk1XNEE1cGgyZjBCd3JxQTdFeGRF?=
 =?utf-8?B?SzBjSzhTWGRHN2NOTnptbFhISkpJTHJydC9qQTVuaS84QXBuTUs0M1M0YlRm?=
 =?utf-8?B?VnFFS3YyQWFkdkQ1SHBvcmQ2SUNUWkZDSG8xbFZaWXd2dlNxWHNuR3I4c00v?=
 =?utf-8?B?OHJkM0p6Q002TDFUNTZYRkVoK2NyK01xMXJhYXIwQ2RYVnhMMURYUXoxQUxw?=
 =?utf-8?B?cjNDdDJpMmpwREE1Mk1YZVZHL3FUQ1NYcnlMemJYN3U4U1FjaWd3U3kxKzYr?=
 =?utf-8?B?Z3JlcWsvZXUxUkZJWmNPMm9UWmlVeFBiUW5mbytGTEVkNXVWazVrSDNUd1Zy?=
 =?utf-8?B?NERvbWJaZ3oyeU1YQ1F1R01ocTlnQkJIVEdkcW9FamdhMnQ0NkZKR29VenZJ?=
 =?utf-8?B?ZXo3aU5nNk9PSVE1WkVFdnJDTkd3RG1HaVJvUEtaaDVEWlFRZHd3V3pHNHBk?=
 =?utf-8?B?K0hqOWJxdWVMaFBxQk5jaGcxc014YXk2N0JsbzRDWUdzbE54V0RYSlcyWk50?=
 =?utf-8?B?RnFlT1hxczJNSTB0ZDZEYjRYUUVkbVhOcHlNdzZJdVcyckl2UFhZMmw2RkpV?=
 =?utf-8?B?UnlCbXFJTThScjMydU54My9TZ1hnd0laU0N6c2I4Y04vNmJ5ZVRIY29KMkVm?=
 =?utf-8?B?TmZ1M3k3MDZOZ0IwYmg4dmxkcTdGRWNBWTFSTjhya00rR0FtNWxtdlB1dklR?=
 =?utf-8?B?eWdBZUZZTFJWTUhjNWp6U2d1NVpZNGZPS1JYZFhOa0xBdUFSSmtGMjA2amM3?=
 =?utf-8?B?allQZ09zN0gvTjVyN1NaS0tjY3pyTjZnZVRqeXFwRml5YjU3LzlmYkJLRGhq?=
 =?utf-8?B?NE5vMmtvbWJzMTVaVFdNelpOSk9OVzV1eGIxSFFsVzNtZWUxWHFqQU5ybXky?=
 =?utf-8?B?aVJvMkRGZUloSnhkbXhwWkxqZXdLclhsb09LL2l4aEc1bkI3eWRkMHZGcEVG?=
 =?utf-8?B?SDVzemZQQ1pvVTBvdXR6ei80Z05yK2FBU3g2djV2Z2NNRjNzUHU5QllHMVQ4?=
 =?utf-8?Q?kr8NDXT8P98hA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1MzcDhXNjBPY2hpMG5vRHFOOG4xOFQ3cTBCRHpLYWQyNk85WFdmMmVZR0pr?=
 =?utf-8?B?ZG8vU1luVFExLzFZVFg1bFdRcEcyTFBjcWtBUHJhOXQ0UmxSUTJtYjNRZUNy?=
 =?utf-8?B?aWU1Uzk3TkR6WU5KNWxXZ1lKb1hCWmZMZnBvb1hHd2JLWm9NVjVFU2dvN3Vv?=
 =?utf-8?B?WEQ5NHJuc0dHUXU5UDZxUlVxZVR5K2RleUg4TzhaYkJiQ25ub28wSmxaOW5O?=
 =?utf-8?B?dithdzEyK0Q2M1VHd3F2RGJTRUJZc3lkd0o2MGlhblJkaUNZRkx5NkR5U1NW?=
 =?utf-8?B?S3V6MnM2NUVzZ21yeW5WR0NERmJDSFowNHZQcVl2b0I5eWVkbmRSR3gxdW5X?=
 =?utf-8?B?dEVqMnZudG1wU3JMNWhPN2YrU2Q1ZTJYbUFiLzhYc3A5THh4OGc2RHZEU1Vu?=
 =?utf-8?B?TXdHb28wTFV5RWhSOFBvYndZVytQUkh2QlhPUWNkV2swT3d4c3FVNjVreWpU?=
 =?utf-8?B?SnVIRXpnMnZYUlgvVG44WTMzM1daM0lrRXdkdlpaNXdjRll0NUJFdG9XZXBH?=
 =?utf-8?B?SDB0WEZBSUtERnNwVG9nT0pnZk9uak51aTNsYzVmSXJPZ016czhjSEw0VHZW?=
 =?utf-8?B?VFBKK1ZhVVFRRVM2a2hYb3cwZTBjVS91b2V4WXZGekkrSk9xbnV0dHlXTHky?=
 =?utf-8?B?VTBRZFQrUmtMaUhDejlyNzNOdDV3bjBOMVpQOEdmZ3ZkYzdwb2lhay9TRWJ4?=
 =?utf-8?B?NkVaeTZuN0JKOTRjeTNCSittRTdLeFczVmNFOTRENmFqTlcyT0tCbnVNbjMx?=
 =?utf-8?B?ZmJVc3dJUFBsVVltOXdCY0hNaXlrR1Zhb3AvVkpiWWJOOHU4OWVIOUZZVWl5?=
 =?utf-8?B?YnlBd1FOV0xweTFtQVFESWQxZjNkUmdFRXZ1eEx6NFEzRno4ZWVleFBhdU5q?=
 =?utf-8?B?bjF4MjJpOCtBU1BiNG5uVHROWHQzSVhxYzJTTzFpeEovL09OYVhqa3d2NWcw?=
 =?utf-8?B?Qi9aUitheWFQdnMxRUtIRFN2YVpLTDd2dXN1SUYvZUN5TjNrYTNpU0VadEtD?=
 =?utf-8?B?MEFqWk5xUDVYSG5LNDdUR1lQQ21nSTQrRHJ1QitGSWhaSWZ1V2ljRnh1QXZR?=
 =?utf-8?B?a0tYbkcrLzI4MllLTzJGeko4ZGdsWUJKekdONTd2L1hMMGZLMTNsSWR5RWwx?=
 =?utf-8?B?Zi9aS0VBdWt2aThXR3lrdlVJMnorR2dOOWdNV3NocUFZYVlRNVd6VHdzaTJD?=
 =?utf-8?B?dXdKMHZHcFFieDNxcmZKUnNNbXRVVFJNWWN5c3VIZWl4MENCTzZHZ1pvMDR3?=
 =?utf-8?B?aFliUDNDc1gzUXR4VmEycENrckJTMW52R0J3cVBTSXp0eUQrVzYyeWJBbmhu?=
 =?utf-8?B?eTR3RWd0VVpYVGZPaFVSUnorNytoZlVRSjcybDZJYXhWU0paVVZOWWY1Rmc5?=
 =?utf-8?B?VWs2ZEpxS1RxemV0OUxTbkRVMmp5U3VlR0w4UTNNZGZBQlIyMXdKNEN3WEti?=
 =?utf-8?B?VFQ3bFlUVm9RZ2ZqVGM5V21LaHowaDhBdDBWbGdDbEpJVzNRMDU3Z1Q4OXQz?=
 =?utf-8?B?a0tWRUF3cThzWHNORGhiVmR1VURENisyZEhtMHRWb0VFV1BNbHRTTGNvTEFm?=
 =?utf-8?B?dUxqamRMTEtJb0JPTW5YSDVxRXg3WVBIU1YrQUhGUTViUjNXaWllbEd1K2Yz?=
 =?utf-8?B?YWltU1FjRjIwbFY1SGxwbURtUTRvdGdFL3dKbGZ5aFhnbHA5QUJUWnVjNVl1?=
 =?utf-8?B?RE4xUmtON1FEYzhEN3Jzd29QclZuQjY4bTRlSC9JeVR2SEdyc0cwQlIvWjB3?=
 =?utf-8?B?blQ5cForcmpRQlBwbU5zcjBCRmJuejdrdVNkVWNxUUJmV2dmT3BQWW9HckEr?=
 =?utf-8?B?T0p4TzZmL2dYd0NZcUFWa1g5UXh6dTUvejZPT2psWTBTdWU1WUhkZGlEUVps?=
 =?utf-8?B?b08yS3FRTGJVTkdCcjlMdFFHdWhSTlhDUEhPWXF6TFp4ZjNJMXRrajlHVjQr?=
 =?utf-8?B?d2dUVXRHayttNzZCcFczb29jWEp1VXJNbmtUL1hPTVpQTkd5VVJjSW9jeUNE?=
 =?utf-8?B?WDFaY2FkaGxrTUZDMVZ4dC9rME9JWmpFQ254WUcvVnFjVnY4ZmtLSG9OZmpK?=
 =?utf-8?B?UUpnWTN0N2dhc20vWkI4V1lGaUtoZFl0V0N0eDI5elY5enpjQ1Z1SE1UZFRt?=
 =?utf-8?Q?6Bfb5rYxah5dRR4ybJVkbesC8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efff7ef-6265-42de-7712-08dd1a99e72e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:44:06.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzGRnZlJdNYuPv5DM5jbgPHZRZIKQ0rY5y4DVx+2A5PbqFpOolQbWyqP90AB1rIX1GvTeKILTQqimG7JTRr08Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390


On 12/12/24 09:44, Alejandro Lucero Palau wrote:
>
> On 12/11/24 23:40, Terry Bowman wrote:
>> The AER service driver enables PCIe Uncorrectable Internal Errors 
>> (UIE) and
>> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
>> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
>> enablement is needed for CXL PCIe Upstream and Downstream Ports 
>> inorder to
>> notify the associated Root Port and OS.[1]
>>
>> Export the AER service driver's pci_aer_unmask_internal_errors() 
>> function
>> to CXL namespace.
>>
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
>>
>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>
>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 2 ++
>>   drivers/pci/pcie/aer.c | 5 +++--
>>   include/linux/aer.h    | 1 +
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9734a4c55b29..740ac5d8809f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port 
>> *port)
>>         cxl_assign_port_error_handlers(pdev);
>>       devm_add_action_or_reset(port->uport_dev, 
>> cxl_clear_port_error_handlers, pdev);
>> +    pci_aer_unmask_internal_errors(pdev);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>   @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct 
>> cxl_dport *dport)
>>         cxl_assign_port_error_handlers(pdev);
>>       devm_add_action_or_reset(dport_dev, 
>> cxl_clear_port_error_handlers, pdev);
>> +    pci_aer_unmask_internal_errors(pdev);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>   diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 861521872318..0fa1b1ed48c9 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info 
>> *info)
>>       return info->status & PCI_ERR_UNC_INTN;
>>   }
>>   -#ifdef CONFIG_PCIEAER_CXL
>
>
> This ifdef move puzzles me. I would expect to use it when the next 
> function is invoked instead of moving it here.
>
> It seems weird to have such a config but code using those related 
> functions not aware of it.
>
>
>>   /**
>>    * pci_aer_unmask_internal_errors - unmask internal errors
>>    * @dev: pointer to the pcie_dev data structure
>> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info 
>> *info)
>>    * Note: AER must be enabled and supported by the device which must be
>>    * checked in advance, e.g. with pcie_aer_is_native().
>>    */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   {
>>       int aer = dev->aer_cap;
>>       u32 mask;
>> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct 
>> pci_dev *dev)
>>       mask &= ~PCI_ERR_COR_INTERNAL;
>>       pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);


Forgot to mention all these exports are changing in 6.13 with the second 
macro param being now an string, so just

EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");


Not affected in the codebase linked to this patchset, but I hope it 
helps you when getting weird errors with a newer kernel.


>>   +#ifdef CONFIG_PCIEAER_CXL
>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>   {
>>       /*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4b97f38f3fcf..093293f9f12b 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int 
>> aer_severity,
>>   int cper_severity_to_aer(int cper_severity);
>>   void aer_recover_queue(int domain, unsigned int bus, unsigned int 
>> devfn,
>>                  int severity, struct aer_capability_regs *aer_regs);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>   #endif //_AER_H_
>


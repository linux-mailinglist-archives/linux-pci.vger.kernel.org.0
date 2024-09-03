Return-Path: <linux-pci+bounces-12678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5396A447
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A21C23DE3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD018BB98;
	Tue,  3 Sep 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yqbH3xh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5918B49A;
	Tue,  3 Sep 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380971; cv=fail; b=R72Pw28NQ+E3zLDFwORZUxpnB+Sc5VUDwwLp+1LG3DybzT4JQK5gMjslILGPKUCsBdjxLa7obk3d2yBoWVedwDq6JEMx+Nl8xUuJqCsGnWGLCgkVHbHWASNdlv42GYZT6ce4J84vzAge0gtCv3BYXQbLBgi57qs0JEn0dgzLdiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380971; c=relaxed/simple;
	bh=davqs1Py54b9xm8B/uUJPYZOPSzwEauofZPv6NIrbmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQURnsVfk16GTXUsBZ78jCYuU436rvKe74yz6RYKi0ZbU0xEyeVyYXI3GXGjj442B8iX2UsBqnL+AUetplhfCmRbX+rRxE2mOwQyDKOJnW5BfPnskvouYW5cLzZdaxNFapxFuIu10iB42BNY48nOsuoE5caqZzyBVBe2Ns7Y3fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yqbH3xh2; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP/sdIb9/d2CfpZuDw/Ch4pDhD8R++zASYD+lWagnXJjZfvvs+fke/ulB3TYwKawD1flg67V58V5/dGBframBbIxcS3stwXAnkID1DxMrUHoJ49vYlxUWmwRiHO9KcK0G4HWUD6CMfTn9x9FoD5tCfSwmrLg/JwPNw9ebCBCmztrnvZBsZDcnWtQrT1gRq5DEfJYrx1maL6xV/8lr+fgBd+6wuUw0fTc0mxZ8VPSUS1d1Kkqz3+bCOSJ+5IewdY80J1fqxrFLLWcOTCesAKJiB52MKzu9Lbq8DXZA0JSMq1V30TEWvr6oUWJtjpck5h5tvSoGcGlDf163cqFvLOlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMyapjXq0x2WsGli8rOVBjAHgyUwBrrSs2HmsghX1ng=;
 b=wBNxXl8N+SAPWZkf/3uZTXfQ02borsP0lLwanhixELScrdFvmpfG/VLZo0Ydf5B7w3+ejG/O/mlcfnj8THl9I9U2ini3tqpnziCjHZ7nnV9mUT6Ys55n4C/ZL4TV0KLKy+N8v1qelOfzcHDaojLF4R2oga2kGOgz0Jjd69RJEe3mfyQQ83Euxq2csWwj4tJY1NJ1YdpD8qZI6sabM/9h7ytgnS8J761qEwtO6lOzXceBMsHtvmKlEPImZKaQTwug5lF0qsKIl2pjyAOkoxJctua+q0PPdBf+9mgXvKR7rwPm6Z/dFFuyWngWf9N9IO3kJq77b9Vk+LYnZQDwZLfmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMyapjXq0x2WsGli8rOVBjAHgyUwBrrSs2HmsghX1ng=;
 b=yqbH3xh2QF6oeMBu7rFNd8l7GlUwEGUGkVnY+1H7v6ybKE1RVHHIUe9FJguJ3+yRxKufZaR0IlLO8b6rxgeImLZGXvyUraNeSuViLhb9XoO1JkEkHg+z4YJvSrW4zh978GGWQYaFjOPwbrcJ5+hgWKbKZhXTDpJ8PvQKuacsAwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 16:29:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:29:26 +0000
Message-ID: <6ac2dfbf-fd9a-4223-8d9e-bb41dbf98b1a@amd.com>
Date: Tue, 3 Sep 2024 11:29:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240830000137.GA84915@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240830000137.GA84915@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eee4f88-080a-4ab8-6327-08dccc3593cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVRZWUZ3OFNMSmMxQ2c2NWNqRHQ5Smo5UVNzMWIzSER4WFJzUkhOY05uZjVl?=
 =?utf-8?B?VzNhNXR5cGhoMVBBS3QzQTBpUjFMaEtTdXU0Wmh2TmxjSXFjblpudVY5QTJj?=
 =?utf-8?B?dHhCYTh2YVlMWm9UTFQ3NnFicWdTQ3FCZmV0WjlSQnBDUTIxOFliSlIzdHVQ?=
 =?utf-8?B?V1JZWlpiQWF4SFAwem82bTExekVobmtqOXZWTUFrU1FPTjJKN1ZLUTJsbzI1?=
 =?utf-8?B?Szh1MXRqVG9XMGFxcm9GbzhzYjNZSVZ4S1M3dTRxRTFsQnVhME40YnBhaVl3?=
 =?utf-8?B?VVdrYmhLOENhZU1pRE9rK2xnSGhmcjlIWHhVeEgreC8wRW16cHd5aGU2ZHYr?=
 =?utf-8?B?cjlaa3l2ODFOS1NXUUJBcmZiMG5uMThHVFZrWENHRWtRbmxJa3lWUEZmSzZr?=
 =?utf-8?B?SHhBOWpwSGFuQmZOU2NUNTZZSHJHTXlDcEhSazB3NTFPTVpiTmN0RjhZbWVO?=
 =?utf-8?B?Uzl3QXR2WnhDQ05hdW9KSFVNaUdlbWFOdE41ZFJJdVQwalFWQ1NJdG5rZkh3?=
 =?utf-8?B?MXBlTUVNZHdFQitEbDR6eFVIMTd6THl3WEpDOUJ6NWtzSW4yZm5zSmNSSU1j?=
 =?utf-8?B?TUJEbUE5bDBqcjlQNFNXaWI2TFFqVkprc0VlRjBpSXdsckQ1ZUtySmFtMEV3?=
 =?utf-8?B?dTY1dDVBeG5zZ1I1Ump0OVdEWWthcUp6WXR3dVUxd0ZRM2x0Qjlhc3VwS0tm?=
 =?utf-8?B?cEJoOFNwZVdNL1pVT1pzeWNOc3ZZdlIxQjk5NWVqdWlzalVqYitVSTlwM0hU?=
 =?utf-8?B?Sm5HSm90YklRWGFaVWxMUU9ULzJIZnRVeFFyL3FacmZzbXJTQmVielRrTCt4?=
 =?utf-8?B?MUZsWHRxemxSSjJobFVEYW8vMzJHWm0wZnBVaWZjVENzOHl6a2Q0YzNXeStZ?=
 =?utf-8?B?MTl6bklnT0hnZnZiakZsVmliTUJ6YzE5RkxaVW5zeXljVm5xbzZhZHAvcXo0?=
 =?utf-8?B?c2wyOFNOVUdrWk4yZU5LVVk0V25xcVJPU2Q5N29Id0Z6bXdTbU1SNjYvMC9V?=
 =?utf-8?B?VWp5SHZsU3BmUW9uNFpVOXZaYnNGMkJ5MUJESFNlRjgwL2VXcWcvVXNISTRl?=
 =?utf-8?B?NTZPR0tjTTZqd29RSm5QU3NuOFdtUmJPNG4zOTMrRXJYRzdzYkN2Z0xtNlJJ?=
 =?utf-8?B?WjlET1ZNa3NyOVJqdjBLUHFxazZJS2NCNnlDM3pYTW9QM1NKUWtTaVl4QkxB?=
 =?utf-8?B?Z3FPRWRNMlY0RlVMTk92MWJPcmJkcFVsRXRnZmYvV3MvREtlSFMvQjVlVUdB?=
 =?utf-8?B?TlcwS3NSZ2hxM3J6VytoczR0V09yOWxLR09VaWZlT01sb2RkYys0MDJHZkVI?=
 =?utf-8?B?bGxLa1FXclMrR1R6WWFucGJHWXZ1bGoySzZ0cktyaXBIV1NrN1dDc29MWlA2?=
 =?utf-8?B?NHlWSVlKMURxS29zdXF6ME5iNEhhVkFKb05qQlhKbHA3enZFczRrbkpRcGpU?=
 =?utf-8?B?RFR4R0xoNTM5eS9CUVphZWR6R0lQSHNPMGNJalY0S0sxbjlGWU5kc0ZtU3dC?=
 =?utf-8?B?U2VWcGJoVURrVGZ4a3ZIeEZ3SGRtbCtSWGRYbEVCMFdYUTZTcFFnSnYycnA1?=
 =?utf-8?B?L01zdVVZQzQvMG8vZUF1bGVnbHo2VzdGNWkvWWx3dUJOUXYwcWlRTHRKeFpN?=
 =?utf-8?B?NEFjbGFEbWp0WDQ2QzBjWjlEemtOeXdXWUVDY0x6ODRQWmp1Z0VNV1R3bU5o?=
 =?utf-8?B?L1dHS21HcDJLRXpHMWt5dUpDdTJYUEdZOVBlVWxBc1RxSFQxMStVcHh0WCsy?=
 =?utf-8?B?RHNpWDdWOUpaYnY4Vmp2ZWcvbGN6bERSYmxBRXVEWHBVbHVvdEYxQzh4WWVS?=
 =?utf-8?Q?/MfysDKu5FGlc8HPPy8d0rH0Yl84Y3E774E+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGtaZ0ZEWXRaR2ZjVXhPZEI0V1N1L3FLUDh4N0o5QldLZG0rT0N3bGkxMzVq?=
 =?utf-8?B?ZjFJQmZtWDliTmZVcWgzbGx1VkUzMmJXbmRrWDltMmRKUVZIdEoxdEljVkpB?=
 =?utf-8?B?UEdwNVQwbzNocE1iZnQ1aXg3UU1uT2lhS0g2UFpWMUNiSGJRUWp4N0pyZ1Vz?=
 =?utf-8?B?bDJHS0JvaTJQV1BReGxZaEdDWGRDTi9LTDVibnNjczVxZlU2cDlZZ2Z3Rm1v?=
 =?utf-8?B?MGsvNnB6NUZkVkpSQ0MwcHZLakpFVkg3aHVUOHA2Q2s2c2NlQXZMRjVwMGQ4?=
 =?utf-8?B?MS9lR3RvTnlocFp0TmU1YnlJTm82bmJxZ25aeWdlZlVjRWNybGNLN2dhVWtH?=
 =?utf-8?B?OEJ2SVN5dFR3Mkhjck0waXd0Y1l3MGptQ0ljQVlZUlZMTUhocElSVmJGejFT?=
 =?utf-8?B?b0JKQ25ZSDgvMWsvM01xK3liK1NmOXdtditiaUlsbTNBZ1VrTVFhNzZDMUJZ?=
 =?utf-8?B?WEpiRDdxdlVYQ0dRUGVxeHNZdTZHcnpTWGp5M0VUWlVwTnlNV2JrQTc1LzhC?=
 =?utf-8?B?MXBucitiLzljU1FCZVRxUk4xSE81V1JJdFpxSk9CSmsySVdBZG9pSFF5Z3Fo?=
 =?utf-8?B?QjYvTFhWUWpSTEpHZUFnTHFiNm5ZbWRLbEg2QTEwZ1Z5YUcyQUFicHluY1Jt?=
 =?utf-8?B?SFBjL1lHNnhKZzUzaGR0Qmp3SGpiRHE3WjBKN1V2MGh6aTVMSGlIWkpCRGZV?=
 =?utf-8?B?WktGdVIyaEZ1blJwUE5PUk00b0U0eEt0RnR4azZMeTZKSWVIU2VjNUQvNWtQ?=
 =?utf-8?B?clR4T082cnE0RmNmTWhDV04zTjdhVmVVeGdwdlBaVVZ0SCtuc2wxc0dzKyta?=
 =?utf-8?B?UFJMejFwSHRDVUtxT2VQL1R1N3dsS3BBUnBaY2tGSkNFQk0rT0krSVFRdEkx?=
 =?utf-8?B?T1g0ek1JOVcvK0RqZFpjaW5BUTIrMytqeUNPNGEyakZ6TUFlUDBkWTFpUVZE?=
 =?utf-8?B?aXloNHFVNndLekgySDFwbjEvT3d5YmZpeXlCNllGU21oY0RNRGxhWWtrVHpP?=
 =?utf-8?B?RG95TVhvSk40dmdGZGVYaEhzdmNKQjJHaWFReThTQU1OTUFwWXNnN2JQS2JW?=
 =?utf-8?B?d0RtaVhYZDJyR3drcjlYSEswcEV2aFBWWmNHclhWbEUrSjdEM292dFQzaE9V?=
 =?utf-8?B?TVlMamRreVJFZEprUTdxTWRrR1ZTdU5RRitLcDdZTDVGYXk2eHBvUG41blhm?=
 =?utf-8?B?S1JodGJVZ3M4SzljYWNBQUJhUHFFL1JITFc3c3h1dW05dG4xbjA3V1U1K1ZH?=
 =?utf-8?B?RCtCaEtpNHp6b0hXWnN4NjE5U3JWa0hsZnJNT3duUm0rY201UFlLSEh1dHMx?=
 =?utf-8?B?OGtia2ZnWnhPc1JhVjg2bWwvVFJzNzNMbXFRZ3JQWVZrdHhqS29ialVZZGZU?=
 =?utf-8?B?MjI5S28yMS9EalJqbmYvSThLN3JWTncvc1dhQTQyb1Z3Sng0NmNheHB1ankw?=
 =?utf-8?B?TWdmSENFbFEyVnhVK3pMTHNWbWMySEpORmMrNzdkVFhmWXUxSjgwYVFnNStZ?=
 =?utf-8?B?alVhOGg2MUFmQ0d4TlY0QjhqUjdwRDV4WEswaWJlc1ZTSjNyRCtaYlFRNHBw?=
 =?utf-8?B?T0ZjMVVHRkgvZXE4WW1LYzNBNGdOb014Zm5PVXlHb3YxNWxxWU5JTWVuUTRi?=
 =?utf-8?B?a3Evc1dQL0pGVTI4TmZobU1IRzNXZDdEVW8wVytYZXBLUW1hdzhWU2lsYWFx?=
 =?utf-8?B?UkFIN3FFT1UySVRxUVF3TkZGNWxrREt0NHpnMWhvbVVQWFhjbE5IOWRiM0h0?=
 =?utf-8?B?bHhiR2tQdEw1Q3AxZTFvQ25YbjJBSERlNWtMSnJhRFd2ZW1qNWZxVzRKTXZ2?=
 =?utf-8?B?ZVBtUXZSZnRUbjRFWTh1QTNHQkhSb2hleEx2anE2dG1lL2hJc2grcnBDVFJV?=
 =?utf-8?B?SjZqZDlxMXZ4TkUrMWJzbUE0OVVZZUY4UkNmOU5wWUw3ZGQzWWtBbWIyRmta?=
 =?utf-8?B?c0VsajdpMjNFNHRVWURlakEzTXZROHBaTzN1TlpIRGFod0Yzc3dON2ovQTRl?=
 =?utf-8?B?MEo2TUQ3aFJENEFUQ3Vqd0s0K2srVUM2bzc5aWd4L3g4dEFvZWl0UU4rR3gv?=
 =?utf-8?B?ZXlTUS9vbmtoQlZRRG93bGEzZWpadWthaENwZ2dKVzNGK3BJVE9JTEtOUmFZ?=
 =?utf-8?Q?oMUizXYZ7NiwFV5PffcX5Yay9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eee4f88-080a-4ab8-6327-08dccc3593cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:29:26.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltmxqZhoaPPbIcM3ltU7rfqUwb1IvXilCb1R4mF+q4VCkvkNFf4qAYo1QvoKZGmPOJZuh6CxK1alwQgOAOxaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

On 8/29/2024 19:01, Bjorn Helgaas wrote:
> On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If a dock is plugged in at the same time as autosuspend delay then
>> this can cause malfunctions in the USB4 stack. This happens because
>> the device is still in D3cold at the time that the PCI core handed
>> control back to the USB4 stack.
>>
>> A device that has gone through a reset may return a value in
>> PCI_COMMAND but that doesn't mean it's finished transitioning to D0.
>> For devices that support power management explicitly check
>> PCI_PM_CTRL on everything but system resume to ensure the transition
>> happened.
> 
> Still trying to understand what's going on here.
> 
> I posted a change to pci_dev_wait() to read Vendor ID, look for Config
> RRS status, and wait for a successful completion (when RRS Software
> Visibility is enabled) [1].
> 
> You tested that and found that it didn't help with *this* issue [2].
> I assume you tested something like v6.11-rc plus the patches from [1],
> i.e., without the PCI_PM_CTRL changes in this series.
> 
>    1) Initially the device is in D0
> 
>    2) We put it in D3cold (using some ACPI method) because the
>    autosuspend delay expired (?)
> 
>    3) Plugging in the dock wakes up the device, so we power up the
>    device (via pci_power_up(), which again uses some ACPI method), and
>    it should transition to D0uninitialized
> 
>    4) The USB4 stack sees the device but thinks it's in D3cold (?)
> 
> If your testing only included [1], but did not include the
> pci_power_up() change from patch 3/5 "Verify functions currently in
> D3cold have entered D0", I don't think we would call pci_dev_wait(),
> so I wouldn't expect [1] to make any difference.
> 
> If you *did* include both [1] and patch 3/5, the implication would be
> that pci_dev_wait() successfully read the Vendor ID, meaning the
> device is not in D3cold when pci_power_up() returns.

The testing here was from the LTS 6.6.y kernel with both [1] and patch 
3/5 from this series.

I can get testing from 6.11-rc6 with a combination of patches if you 
would like.

> 
> Can you clarify what you see and possibly expand/correct my timeline
> above?

The timeline you shared is nearly correct.  The USB4 stack *thinks* the 
device is in D0 because of the return of pci_power_up().

As by polling PCI_PM_CTRL we can see it's still in D3, so it hasn't made 
it to D0uninitialized yet.

I guess I reading between the lines you have an assumption that you 
can't read the vendor ID from D3; which doesn't appear to be the case 
from our testing.

> 
> [1] https://lore.kernel.org/linux-pci/20240827234848.4429-1-helgaas@kernel.org/
> [2] https://lore.kernel.org/linux-pci/30d9589a-8050-421b-a9a5-ad3422feadad@amd.com/
> 
>> Devices that don't support power management and system resume will
>> continue to use PCI_COMMAND.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4->v5:
>>   * Fix misleading indentation
>>   * Amend commit message
>> ---
>>   drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 1e219057a5069..f032a4aaec268 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
>>   	 * the read (except when CRS SV is enabled and the read was for the
>>   	 * Vendor ID; in that case it synthesizes 0x0001 data).
>>   	 *
>> -	 * Wait for the device to return a non-CRS completion.  Read the
>> -	 * Command register instead of Vendor ID so we don't have to
>> -	 * contend with the CRS SV value.
>> +	 * Wait for the device to return a non-CRS completion.  On devices
>> +	 * that support PM control and on waits that aren't part of system
>> +	 * resume read the PM control register to ensure the device has
>> +	 * transitioned to D0.  On devices that don't support PM control,
>> +	 * or during system resume read the command register to instead of
>> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>>   	 */
>>   	for (;;) {
>> -		u32 id;
>> -
>>   		if (pci_dev_is_disconnected(dev)) {
>>   			pci_dbg(dev, "disconnected; not waiting\n");
>>   			return -ENOTTY;
>>   		}
>>   
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -		if (!PCI_POSSIBLE_ERROR(id))
>> -			break;
>> +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
>> +			u16 pmcsr;
>> +
>> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
>> +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
>> +				break;
>> +		} else {
>> +			u32 id;
>> +
>> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
>> +			if (!PCI_POSSIBLE_ERROR(id))
>> +				break;
>> +		}
>>   
>>   		if (delay > timeout) {
>>   			pci_warn(dev, "not ready %dms after %s; giving up\n",
>> -- 
>> 2.43.0
>>



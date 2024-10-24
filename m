Return-Path: <linux-pci+bounces-15248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF09AF49D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B30B213A9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867E1ACDED;
	Thu, 24 Oct 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hbLelNCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD5189B84;
	Thu, 24 Oct 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804847; cv=fail; b=dwPFxVkPXjAj0NQ822UVF11eKWytyuEIkoFyTrxq/dIIN4KCbGbfeHgZM9GvMifWh4T4HqCdz9cTqHhs12d5b9XOfn80iYSUvSqG1qZ9KUlyBKd0fxk+2PYbbOzlCEeXW2x/m5Ty1j3HrtXibu5/B71gWGzgtbH5bUuE2soCcFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804847; c=relaxed/simple;
	bh=LmapVONzAxaWre15R4iHMJMHO7i0xFmcLw90kyBB3L8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBp9ixAGCwCBOVryBTiTBRXO54WBKyhbCfB7WxutWGQpHUedZlheC3fJlfE7e1ktfs/QNgyQAZD6l2nLfyVdE15jVQSdo/lqJO4NtWqKv6Y4MAy3ObSACyQdwySgQoKEdn6q1xs/tGOzdSC4AQYdpF7oOQkNb+46qqwtTYGtaso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hbLelNCa; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSlBmrcAlm+UOG64yI26xDYmOMYBKc3UhLUy2ms6UEQH3ZP/2sZRrLLuf7GDbF2UEkh6etP37JeKWI/iFvWYrTf09jFWMHTAuhDw0YwfQqBdp4VH47MJHN5h1eQbHKnXsODK+9kgHsTFy0FhJB8FSnKFs0QVcHPIcCUAnvP2evAO+GNAwifz/PgcpMCrgWMNv7XjtpIkf/4MIFvnXccnNZWqL2zlRdm6bmCwI3X17O0OodODnVAU9ySxvt2yeKxyUZKiTkBKdU+BWRqrzSfcKULjIxaWqoWmjLU3B3LqpOdQyXExfMvMHEdLydoTEwMbLbWN9Eoi0WL7eejF4j/psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAdvFQC6fbGMPOLldwGJ6P3dM+brVn4RqB8RBCzp7W8=;
 b=WxTSmg+WTVGilBxExbXFXTZKdYcWajbcCoXUZPIUK4lKDdyI5GP1zGi4hSTn0VEukoyhXA4eQ0c+Lys1XTdIrb7+sSYO1Aof/2Gbm66TCQkPg7YCqokn2g/U8sR9GrKbCcNLOn3hdjDUYGVrlu7mI3t9g8+eOqsUQVC0vPw34PxR4zu+TPJj+VSFeKQ83dG+PTsu4NhTxxxjZ7VdMTcYDsvnIB7uoSmNDETVY+bFrLH/O6pWjj6YROAobQrtZxUIB6qp5DVKKt72X54vO+ivIPR/uTPaSCNifCK4i5pVhsZO019KdpTKPmFWjWLN8JS/XK4tCLb4la2nldzGY3GW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAdvFQC6fbGMPOLldwGJ6P3dM+brVn4RqB8RBCzp7W8=;
 b=hbLelNCa3LyWBwMydGUVj3u7NsUsiEwLzhK2RUoQ857IG+qxSgMeG/rtmvhukOlt7Uo7/gTNNvYW8fs0qL0SRScpv0iKjxKUg11Gahxkn0joUxEB3vYAhfWGr5E2Jqgrd3C30tlk3FhiFBp2qmmN08MZB2tCFW79aks6DAvfk5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 21:20:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 21:20:38 +0000
Message-ID: <0018d26a-ffd5-42fc-8cc4-9e689834a808@amd.com>
Date: Thu, 24 Oct 2024 16:20:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, bhelgaas@google.com,
 Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
 linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
References: <20241024210652.GA1003184@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241024210652.GA1003184@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c2d5d7-2420-4b9f-6890-08dcf471b49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJ4end6L3dGWHBHUjh6ZCthelNZSytPOGxXVjJCbFpNNld0U0h1OWdiM0g4?=
 =?utf-8?B?OU9pWGdJK2RkUS9IYndzbHcrZ2MvWEU5ODk3UStiYXBJOStxQk9uVEM5LzVR?=
 =?utf-8?B?dUplR2djWUsyKzZnSWFjNkJQdHdOeFFhR0RCNDlkZ1l0VUtUbXQ0OHdJR3Va?=
 =?utf-8?B?aFNqcHFEbko5UGtDdUZlZjhyZERKTmlZbHladFFLemhnQVVwWFV2ZFlPRFNz?=
 =?utf-8?B?K2tkN3RLZ0Z5TEMrMjhaZzl3bGpBdjhvOHpMWkhyL250R0F2eVBlY05rZUNU?=
 =?utf-8?B?bnhRaG9qZzhnYnlNSmNkR0hoTERtckFMWXJsS0IzRVJzbmZ4b1Vtd3NYRncw?=
 =?utf-8?B?MGlTcHFQYjNZNVhVM2lRSjQza1RXbXpCSjFJc1hBZHJVUC85UFNDeUxBMmJR?=
 =?utf-8?B?THYvTUxQdm9TcnBNalJ0Z3V6cWlvREFoWmxpclhXdWl4V1B1RUdOTDhCbzBr?=
 =?utf-8?B?KzRDakkwaGR6ajF3MHVYcDRyMVFMS0FqRExtSnA3d1BldWZ4QkxOcXE3d1NY?=
 =?utf-8?B?R2NpNnk1ZzY2MllOSXU4UDVXUWF1OEhwWU12YXB4cFZNRkpMZ0VrZzZUUndO?=
 =?utf-8?B?RmtWTytaUVpPbTZUbGVSVFNhZXNDRGZrcGVmMDlDSmgzK3RNZlNGdk5IQjlG?=
 =?utf-8?B?QmRqa1NnWkdadHNGeGtUM2V5aVBDa1haU2xEbEVSVFZDNUxvS2txVzBtdUtD?=
 =?utf-8?B?M0Q1c0V1aXlPTXcyUk9Oc1pjN3FDWGlPT3Z0ekx5S1NUT0hLa0MxK0ZlaEFj?=
 =?utf-8?B?Z0o4N3Q1TXdjUmtmWHZiOUU1ZHprdTFZempNSE5EYjMzYkNiVFhONktPNkh4?=
 =?utf-8?B?eDM2T21GUk5Gdk9qR3BsSCszMzRqbktCQkJqN3c3TnBERW5lOTd4VXhSWGpO?=
 =?utf-8?B?ZW1jaFNiLzQ0SUtHWDhKMEpJTnptQnZKTGdWYWNxQysrT3lTUkNOdlNNR0Vu?=
 =?utf-8?B?NDNuSjA2MmR4b2d4K2doQ0x2bUZWUURlWk9ROGtVQ2NVeWVoZ0RCbmVlY3F3?=
 =?utf-8?B?MDRlZFNLOTZKZG9YUmI4ekg2M1FYN0FlM0wrVjJ4NU1pUWxEN080c09oK0Q0?=
 =?utf-8?B?eUdaaVBUNDRzQUM4d1hJbGwvQXVTNDF3dWdaYVEzeDQ5a2NjNlJ4aS9UKzZu?=
 =?utf-8?B?OXAvTVhTMVVOYjB3Q0NtRmxZL2I5N2tXOW92cG03czQzaVJEcVJGTFJQSUIz?=
 =?utf-8?B?SW9pVGlxa29SRE1pNzRhOGtBRk5neERvSit4UzVpRmh5TWFXYVNxMVRnbzZw?=
 =?utf-8?B?dnlyYVkyVzlVRERkWjVNYlVVSkFmVnNSZGRXRlQvK2dqNEVaeXZBaTE5SnJH?=
 =?utf-8?B?Ty9LUkUwcjAyVkMyVDVKNVlkaUtXVm9kUkRtWDNSWlhrVWZidG9RUzFjSmho?=
 =?utf-8?B?V0JUSUd2VTJWeFJTaU4wdDNMc0RjK29rV2ZWT2tyUkhvTms1bTJDWWFydGhs?=
 =?utf-8?B?VHVyM2JHZmRwVEdDQTg0c0c1Sjk4L2RwalJRRmxOQWg5U3NiN2pUVGRXNmx0?=
 =?utf-8?B?SDluTVB6d1N2eTRPc1F2d1BkSE1JSFVmUEJ3Y25RNDQ4V3dudmhaTmJtRGw4?=
 =?utf-8?B?NnRkNGJITDFuZzVrSmlhYzRuaE1UT2M4U21kZnROMXNTZXdrbGhTZkxUaERV?=
 =?utf-8?B?OTRid0hld3dOWVRLOHhMVFIwK0tiL1k3eFNGN2JsL1U3cEI1eGdvQVltQnJu?=
 =?utf-8?B?ODFZTUxVSEhtZ0grb3BrSlp0VVk4aEh1QmMzYzZCYUpYaDJaVGs2TFhGajcx?=
 =?utf-8?Q?PIyVXyU9kMYXKzjUbgJodefuqxA1MKe0k42lr8/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdBRzlNRUNhVE9tOEQzNWlwODhKY3VLaEJwTFl2enI1ZUhkSGVHb2JaTTBQ?=
 =?utf-8?B?TlM3L3dhT2U4RnVKUWdlZmJNVm5WQ0MxMU9TVC9BL1BMMWkyeUpIa3NDZndt?=
 =?utf-8?B?WVpTemdUSkVIdEtUQjMzN3FpcnRHVUZSN1FMdGg0TWYrZWV5NThqOEFhdXpn?=
 =?utf-8?B?aTdjS0oxYWJMSm5ncDZpUVZsMjQ5cGkrd3ZVaitmTHVTZ1VlN0NKTC9qcVlE?=
 =?utf-8?B?aTlOMExLYUdWdlVZRTRsSlBTU0hoeDZ0S0hpZEo5OGpmZlRNZkVxWDdYK3dK?=
 =?utf-8?B?R3YxaVpWMmpHSUpESkU3K2VEK1lOblVET2Rlb3VxWnBoUkw0UjM1eDZaWGlK?=
 =?utf-8?B?MExQRkRyeUozbUlxT2hNQmxaRHhPa0Fra2Jyb2VxQXlCem40TlBUUzFPUVNY?=
 =?utf-8?B?eWxCalRsTFZzSjRWMTFWWUs4WnZZazB3Z2NiYjVRQUJJemF3OVh4TGZoQkJQ?=
 =?utf-8?B?a2g5WCtUNkRlWVBQQmFlNnFwMThFSlY2a1g4MXRzNk5PcXBDc2xPYUUyYjBz?=
 =?utf-8?B?SnpIYW5CYjU0dEdJbTRZL1U1U0ZaVDVzbGFUUXRzT05FTXRQeG5tT2tOV29M?=
 =?utf-8?B?U2lpeFRUcTJtcER5djR4Ymk2UythR0xhMzhBdWMyQVA4dDYrMDlOdEQwbmxv?=
 =?utf-8?B?bFN2TnR2U1VNSXlVMXZFS3ZPWHUvekNnVjdodDJHaTN0dUx0YllLV2JIdFd0?=
 =?utf-8?B?UmFENmVlN0Z1Qk0xUmZraFBZWjhPald4UGdpM0tkeWRaZG0zNHV5S2xtV1dJ?=
 =?utf-8?B?Z09UM25yRmdmcEJXaTF4aWxKcm9ONVcrMmdYcGdHdCtrdVdIRXRqeURYRG40?=
 =?utf-8?B?eWhwNHpocXBDUDlhVy9DTnB0eGxCc0tqRFg4UlY1VDFjZTNmSnlhbDkrNG01?=
 =?utf-8?B?d2dTeUxSditxWFZmTzNQczJhaWZRdU9MK21SWFNMVmZYRHVGaUpRa1oxckVR?=
 =?utf-8?B?SzdJTS9OUnNNZVhhMW5MU29jY1QrNUd2emhjZEptWVoxOEd6Z203ZUpUYjFI?=
 =?utf-8?B?TWQ1dEIzandrMzhmNTdLQjN5K0J6NS9VWVJPdk1kU0JicWhpU1Z6aHdtcUQ2?=
 =?utf-8?B?U0ZtTVM5MUI2YVl0ak41bk1tM2RXMm94clg4bkptaHhoSFMvVjhSd0JELzZJ?=
 =?utf-8?B?L1hSc25GaGVXSWt6clJIdjlBSjdyVG1KZXh5U2NXYU9pU0lrRUo3WUdUUjhO?=
 =?utf-8?B?cEpJc3BxSTIrenFCcitOV1h1L0JNbXM4eHF6MDd6VGNUT2w4YzUwM2RSTVk1?=
 =?utf-8?B?QWNqazYzd3NnbnBUeEtSSE5pcllxMGxPYkE2OG1XYVpBYnA3WGxPN0djYi9h?=
 =?utf-8?B?bVlPUjZrMmFqNkt3TXBaOVFVK2tEUTd2U1dUbTZsS0VzcVg3ZXUwQitZc1VY?=
 =?utf-8?B?YjRGZHNlRUVnTVdMamJGL20vbXpUWk1pQUFERE82UFZhWTU3V2dvRC84dDRI?=
 =?utf-8?B?WjQ5QThudVZJa0ZsazV4Nk1VcnQ4bEJwd2dlUURadS95R0cybitJNDhBdFNF?=
 =?utf-8?B?WTBWVEduNnVMQitxTjU1S0N2ektpR1pMcXVENm5IbExLSkNDdnpYSVh3L2RJ?=
 =?utf-8?B?WkllZ2k2MTJwMndZVGJkQlRseTZ2T29FMVcyUURFZWUzK2JxbTFpUDFYWTFW?=
 =?utf-8?B?MzNUeFg2VktQTDFTQjRkenhJK3RYbDdMNjdYZWMwS084ejE3djRXSmhtYm5C?=
 =?utf-8?B?UnpUL2hqMVg0MUJoZkRSWXdhOEM4aDJ0WkdjUk1OaS9wS0NQK0hlVDBUNGxJ?=
 =?utf-8?B?alRYckh3T3o5M0ZBYkVQeE1LZTdieE16cFBmZVdjWjNGb2RXUTBlbkdNVElp?=
 =?utf-8?B?UmxieVIxWEdEeENzV1U1SzFtdzg0KzU0SFhic0VYaDNZQkZRd2hGL200bVE4?=
 =?utf-8?B?YWphdlBuNkdjYk9jUXd6Nm9CcHZCMDV5UEY1OTlyaEMzU1ZoUzV1ZSt3bytS?=
 =?utf-8?B?UUlTcTczY2R4SU53c2pIOSsweHQxQlJSa0VpRVlWaEVyRXRIejZsTTdFb3lI?=
 =?utf-8?B?Z1BjTzB5WE5oM21zNlNOb0dHS1RLbTBIa216UENMUWdkejlBTldSSnI4MnRP?=
 =?utf-8?B?YlNxOUQ2U0t6RnFDM0YzY3ZLNWtOQU50NmQ2L0VGd0xNZWdzV3NMNWV5clY0?=
 =?utf-8?Q?f7K/GmzicntfT9GUh5RQwLKLm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c2d5d7-2420-4b9f-6890-08dcf471b49e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 21:20:38.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EEkJNq2bByHe9LCxv1zGcDmD+YtCWG2q3bGbvKRlLyLXpDgWZcfBOy5gpJS0fdImLdf8r2oqMQDdzkE+uYwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

On 10/24/2024 16:06, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2024 at 03:08:41PM -0500, Mario Limonciello wrote:
>> On 10/24/2024 12:46, Bjorn Helgaas wrote:
>>> On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
>>>> On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
>> ...
> 
>>>>> The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
>>>>> ideal since all those pci_get_*() interfaces are kind of ugly in my
>>>>> opinion, and using them means we have to encode topology details in
>>>>> the kernel.  But this still seems like a big improvement.
>>>>
>>>> Thanks for the feedback. Hopefully, we'll come to some improved
>>>> solution. :)
>>>>
>>>> Can you please elaborate on your concern? Is it about saying "thing X is
>>>> always at SBDF A:B:C.D" or something else?
>>>
>>> "Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
>>> nothing about the actual functionality of the device.  A PCI
>>> Vendor/Device ID or a PNP ID identifies the device programming model
>>> independent of its geographical location.  Inferring the functionality
>>> and programming model from the location is a maintenance issue because
>>> hardware may change the address.
>>>
>>> PCI bus numbers are under software control, so in general it's not
>>> safe to rely on them, although in this case these devices are probably
>>> on root buses where the bus number is either fixed or determined by
>>> BIOS configuration of the host bridge.
>>>
>>> I don't like the pci_get_*() functions because they break the driver
>>> model.  The usual .probe() model binds a device to a driver, which
>>> essentially means the driver owns the device and its resources, and
>>> the driver and doesn't have to worry about other code interfering.
>>
>> Are you suggesting that perhaps we should be introducing amd_smn (patch 10)
>> as a PCI driver that binds "to the root device" instead?
> 
> I don't know any of the specifics, so I can't really opine on that.
> 
> The PCI specs envision that a Vendor/Device ID defines the programming
> model of the device, and you would only use a new Device ID when that
> programming model changes.
> 
> Of course, vendors like to define a new set of Device IDs for every
> new chipset even when no driver changes are required, so even if a new
> SMN works exactly the same as in previous chipsets, you're probably
> back to having to add a new Device ID for every new chipset.

Yeah; this I believe is why we're here today and trying to find 
something more manageable (IE this series).

> 
> The Subsystem Vendor ID and Subsystem ID exist to solve a similar
> problem (sort of in reverse).  If AMD could allocate a Subsystem ID
> for this SMN programming model and use that same ID in every chipset,
> you could make a pci_driver.id_table entry that would match them all,
> e.g.,
> 
>    .vendor = PCI_VENDOR_ID_AMD,
>    .device = PCI_ANY_ID,
>    .subvendor = PCI_VENDOR_ID_AMD,
>    .subdevice = PCI_SUBSYSTEM_AMD_SMN,
> 
> (pci_device_id.subdevice is misnamed; the spec calls it "Subsystem ID")

Isn't the subsystem ID based typically upon the platform it's running 
on?  For example I seem to recall on Dell systems it's used the value 
that was in the SBMIOS ProductSKU field here (IoW not something AMD 
would control).

I mean I guess maybe we could do a:

     .vendor = PCI_VENDOR_ID_AMD,
     .device = PCI_ANY_ID,
     .class = PCI_CLASS_BRIDGE_HOST << 8

And then in probe() figure out if it's the right one, but that's still 
pretty ugly, eh?

> 
>> There are some areas that do discovery (for example amd_node_get_root() in
>> patch 6/16).
> 
> Sort of.  amd_node_get_root() and amd_node_get_func() both just grub
> through all the devices that the PCI core has enumerated and return
> the one that has the right geographical address.
> 
> There's no binding to a driver, so another driver could come along and
> bind to the same device, and then you have a potential conflict.
> 
> You also give up all the standard driver model infrastructure for
> hotplug, power management, etc.  Granted, you probably don't care
> about those things here.

Right; I agree none of that matters here.





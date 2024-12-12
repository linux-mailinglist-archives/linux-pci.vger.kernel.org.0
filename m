Return-Path: <linux-pci+bounces-18346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A098C9EFEA1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 22:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E94188841E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62F192D7B;
	Thu, 12 Dec 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VyOJ1JjP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69EB1714BF;
	Thu, 12 Dec 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040006; cv=fail; b=qjxyi+UoeNavPDRS03RUxxfL9tyVbeWdZV9m1kwnI5VMhWEg0Jx79dV0rsfVhSVEEdMb2HU25GHkxrKdAUVKgQq5cPgwdkxsBd0BQXOvlawD4+7QCGuOVfJACKUSPdSi1785ALFosDLCVg3oMDl6Gzlwgmo7zQTbIqnonoZpHJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040006; c=relaxed/simple;
	bh=HXUeF/JQ9lmSaks4ikD3PpCXBhwztA/FHcVV0/nnwSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhgvjtKc68vCy91c/tyMHE+bUptHWMLAQfEjfHp3N2ILPZP9e7ivOk6aZDnAYUs1fN4XSObe/fIIOhQQV2URb5TjfnJ4Os4orjgYwTXrRHy6EAdvldt8g/QZDDKdNoWK1zPtOjpg42lHlEl9j8EuY5OLADB8g5N5cMDfeg8nZUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VyOJ1JjP reason="signature verification failed"; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPIJaiDLmlG+OUme3hAnMq1uEyi39xKe8N1iqi0LRBIV/UJ/EVOz8EViBAeA3x0ph3LeK4fLfNk/jo85aFOjVLcgjFgZ9zZnsRQy/4yYWfITSSXGgXr4KiNX9uyEEXsO2nHr0CMjg2gwsJ48kekHHQun8HE8iNn3QMdTvmdJ9lXoOuhgU2kWuQxF4cOJ/uEg6NeYU/XS+JFpH+6nkCE/5zuhF9LcQqD5SO8b1dk9mKbBgqDX4K/UQVEipmtmmWOq8WajenGZ6FFQzOCyte4o0FocPqaeObbYRmXflkYnnCxaz5Fv3r9cE6LMPHGHUHWoqtl+QF0xKN+QlrGsKASY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb7/NjgwXjEowoRyApeb9QNEyqs0Et59nVrN5KUNJgU=;
 b=gA9gura7BfYHiwnE31D1qQ6SULHbbQk9MxPwhNLp52whBSD055L2+dh6UM00VQB+uGG8dJvRMcjAj5YNq3iAnQ+RiUByd/Ax0xidl579cesWbl2lfiSHIIO48i5ZvZq0+ej8ocEwpUIbDVmPYPLkit9ECHUWfv4jpy35nxh604Xi3CjQsAFxt892+NsTjVPh+MMudsLG3Tx/D+nKcfr525sOSLatmgAAu0utzGzga/wYo2HtOeNCbaXpwl4QjbTq9HNMBoRB/5g2UjLKfOg982DQYo2zwR/Pvg0jRmv5jxTP+M9V5CAKdC+A8ohtd4DyErRR7kbFUsMcc/esocME0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb7/NjgwXjEowoRyApeb9QNEyqs0Et59nVrN5KUNJgU=;
 b=VyOJ1JjPG7n4U1jo47oIZwjpuPMrfxFl+dgnMLCcjkvC2Pfdq6sJxGxDxGnL0hQA6uBN7XwZ9kv+CPJ0JVaREK8a+/rFFZN+4Tk5HGTuP1m8A4sRyHpfzfc2i/MI402oNBMk77rJP/pGguWgbXDodOFuFRHPpCG+15f9X6BfZBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:46:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 21:46:41 +0000
Date: Thu, 12 Dec 2024 16:46:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, tony.luck@intel.com, mario.limonciello@amd.com,
	bhelgaas@google.com, jdelvare@suse.com, linux@roeck-us.net,
	clemens@ladisch.de, Shyam-sundar.S-k@amd.com,
	Hans de Goede <hdegoede@redhat.com>,
	naveenkrishna.chatradhi@amd.com, suma.hegde@amd.com,
	LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2.1] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
Message-ID: <20241212214637.GA80677@yaz-khff2.amd.com>
References: <20241212172711.1944927-1-yazen.ghannam@amd.com>
 <65375593-f2e0-e03b-7e7f-ad8be58772d4@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65375593-f2e0-e03b-7e7f-ad8be58772d4@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0461.namprd03.prod.outlook.com
 (2603:10b6:408:139::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 28eb9d39-ea70-4cc2-8f09-08dd1af676c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?h3aMtBsrzUQsK9NeXJxCK4Zfxm0zFRnd0dm34OtwJvZlEvdAdOoFx+AFQd?=
 =?iso-8859-1?Q?hSu2XzS35/duHw94EBGO7aHM4Hq9PKAlmA1CfMHkQx4KMoHlBZnh+5oZXm?=
 =?iso-8859-1?Q?RLcNRb/8OSxAZbQ1LiGQ+ggFMNiyBFGsaQKg6Alyvg7ENumdAGY02nU+hr?=
 =?iso-8859-1?Q?EHFF2PU2pJMLLFxbmRdiYTj0NFd7rUYui2jl0xyg7orwAF4A9GJnmuCswI?=
 =?iso-8859-1?Q?J9TVSI8vM9gG8ebZCtMY6Uxc4YVUG5/fBkA4nitJsttxtPgkBRsDzKBoTy?=
 =?iso-8859-1?Q?8ESXPnJncyzM3uwmw2UnfRbhUk5lip4xE9TJZP26OFqvDp4ewKCTE3sGsG?=
 =?iso-8859-1?Q?/+JNSen6QqFwB70zFt2XlC0wWZMHTdUUZV0NJ9jknpzKEElAtMr1ljGz+T?=
 =?iso-8859-1?Q?PqrsFoHE1WBwsbmwiCAfLAyL8mfDRZapSTWV3gWYxuZUMJ/3GCRPopXuNX?=
 =?iso-8859-1?Q?JBqW52dJOgnt+n9aqUnI4/GvmDAsbIrhGrHnSVoNWusLcCL8lUo8VK2/s6?=
 =?iso-8859-1?Q?MC+v9OXNVscowFwTqQ0+o2ADgAE6x5Xi02XkM1ZlZCmZ6MLJX+ETaVkaWf?=
 =?iso-8859-1?Q?E1nrAhLMHYidHbEYnFbsUIEjV8DPDtRF6jd0JJDOQDB8GyoHB4PW5VHU18?=
 =?iso-8859-1?Q?gcL3L72gfoaFCLUQIa5BKG4PuLQskx2b9XRckA70wVLTzjZTuRiyx4wtmZ?=
 =?iso-8859-1?Q?dTd0Y68D6ccuyGk4iGBujYUKN7pkDsPoA/uawGdZNbRPDwKkUs/8iBpYO2?=
 =?iso-8859-1?Q?LcP5fjgqDcIcdVNN6zgzSeb5ufC28TXvx796EAJxmvxnSGA9wUQuXZ/m6w?=
 =?iso-8859-1?Q?eEHgxJoOveez2n9CN788FH5c5wxf3uc6/5BcGJWLEuwka4wXvKl+v109Ha?=
 =?iso-8859-1?Q?GTK4oun8kCNMxHnShxC64c7NLWd4zAQNK/TGJKB9T9DR0z/16k9Jh5Lv4J?=
 =?iso-8859-1?Q?IUjRuL6McTSr5N80Ui9C6HOKENgLBdFSVWmbvaJ7FIRBudAQ0Repcv6D2b?=
 =?iso-8859-1?Q?3BnWR70wcXKn0qDSY/NYMbrpDBXteWzgw5R2KnBIzs22CqhRgA5UfmwV5a?=
 =?iso-8859-1?Q?N0j+6FJmqp1WkcNRN8FlVk6j8xgvPZh6pkfdykIEsuVer3Fru2+15aDeTH?=
 =?iso-8859-1?Q?6mWHPV2zoHcdDUFPdLbPBph74zehlSpWIQA73hB+03QJ+DVyJ5ebwFmfcv?=
 =?iso-8859-1?Q?a1id9ML2eHW/5BJQBOSWoQoCBu3ITwmnZuNrpbs+lFc81EZX0MbDgcqvy6?=
 =?iso-8859-1?Q?LWoRJhkPcA60PQ+QGkj1ThvSweDFhB5iLMsc1OJcqJ4sCNLMg78ci6uVhg?=
 =?iso-8859-1?Q?DtmQlHc9np8njYj86lEIhF31mXHGA/GGyD6fmer2PXkbaboQ6Pl5SrO+6q?=
 =?iso-8859-1?Q?sxHaNQ1KikgfyCEPac05+OB56Q7su+3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QxyyCn0BaJTr/CrhFUu6KXD5QXlsyYwK8HhcR2PRIKnMUaB/wXEroknsqQ?=
 =?iso-8859-1?Q?iFOE0Q/x7UWBG+fKR59UFlJ/oQpYtz185ui8TcDy7gC0pLQpENk06BUVha?=
 =?iso-8859-1?Q?9uVnk6tYeoLQ2SneVIlXCnZv4bYLhPvknYJh6qWaAUSNZ/5lzIctFHGY1O?=
 =?iso-8859-1?Q?EeYpgVyO5tMiRBrh29yN2XXxUKA20Y5WYv53fUg7Uo6dWPmI3pMBkUewOZ?=
 =?iso-8859-1?Q?W5eeA5u1PJhZpVZ9a4iURvovGT/ETAfzKMdl6T1Bp+lpeyCClp23BpVilE?=
 =?iso-8859-1?Q?6w4M4GtZXbsqZonwME1myjGr1h7FndMeVcrlBZSSi978RIMkbC3me1uLJa?=
 =?iso-8859-1?Q?c3HchZvzD7Pztgrt5c+wbxV3dGvbDuRnIu4wixNjsN4gCnMk/C5cV55kmu?=
 =?iso-8859-1?Q?OV0NrbqtCk+TojC9ACn9wyA7GetayLVaTR1DZiB03XVcwYL7BRHDX0Is7j?=
 =?iso-8859-1?Q?j/2DBPSZpejtCUMOULrAEesKwDZAE1RvSn8cx6M1nT+LuvVKVUsdDJz0wq?=
 =?iso-8859-1?Q?dqB59UkMCAui2liZBHwTce4RI7tAI+59cySmUHpvLV+RqoanM+PCxxM5u2?=
 =?iso-8859-1?Q?T0AFp/PbK0pwPRMXWBDEV5ceK2zzfj5aBxOwsn/OUnqm27MfyWE+6bPo3v?=
 =?iso-8859-1?Q?9WWRIFur0oZRYz4/PeFIUrN8J4F7Gew6wVZW5VEftBerR/KiWRhVGtcN98?=
 =?iso-8859-1?Q?ZzqoiP4F2IHH9gyN9OQ3dzgjY2GqtMYX8R5pH2BWFm+n/11qM1l6WPG385?=
 =?iso-8859-1?Q?Wn/EPsOmkrc2gueDINnqVSBpKSpdK6WtI5Fl9D3zil/TCZ8onza3d9l1Wi?=
 =?iso-8859-1?Q?EdOKE9dGpwpvVmpjgkfHiisJILnMIRHQlQhkMwGHHuSLvC0Dkc19BC5ewn?=
 =?iso-8859-1?Q?vZ9QSMKH0Y6PE8slVVvtyCKJp42ms9P3un+ff+rrzVsHbDJIdi2C3ozSk3?=
 =?iso-8859-1?Q?MQhElh8I+kyJHmKDjMxYptBYoQODpBJXqa1mADOTKclMWpYYvkEdATTEF0?=
 =?iso-8859-1?Q?zEHMKFnqFioHNEg19TGX85aL7pzeSRT5VZtpE+HHN6AmmBVmIT1JmbzmrM?=
 =?iso-8859-1?Q?4VsOJwfkrZKwcmQrJ6OTDYU8AFumkfz3vCu0NH3No5RErQNCfpWi7c5Wyp?=
 =?iso-8859-1?Q?tlaCac7W+2BmEeyQVvi8TRPd2SK2/gkvAsKvJeq26BQw6A0s6MxdB5l4iL?=
 =?iso-8859-1?Q?nwUnbCFrQcm6rzGdIh3W4jfCVJ9yxIHExot8JBYu7gkmSkW+eDkONNlKBO?=
 =?iso-8859-1?Q?QjDG+GwwX0i+tSDvLk9BqWw7xsNUPERuysc8zIpcWb0Z++XQye0JGZx0SG?=
 =?iso-8859-1?Q?+kdlU153+IBdjbrHrayfAGliuM3oSOvZOj7zBpDUlGIe6x4SVnOUsERNHH?=
 =?iso-8859-1?Q?PoAWl5AD9VhQK2IKLm/4NP7n4TsvyhV11ODVPKoX5/VCW8m0BfmUuYiHBp?=
 =?iso-8859-1?Q?YzC3lGW9LQ4a69Z3tCHCiL+FivDragJcYntBqvnef5ZOSrovVfmOk8b24E?=
 =?iso-8859-1?Q?EkQ2jysC/MBV4tlZX1uXP+EN9wuPqs6XxuSB8acFjA5Libe7TWqSXBlS+E?=
 =?iso-8859-1?Q?Qq/7y/0hA/pFMYbks+IeIVce2RtZySCxxM87MsciLifCe10/QaXpz12yzD?=
 =?iso-8859-1?Q?zW43EA4xF6HalCE+xStFGvcSzGkdboomgZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eb9d39-ea70-4cc2-8f09-08dd1af676c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:46:41.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QskZbxYldxAoZ2PIuUcKLcQyAXhyYxSfh7/++SW6nhrQ2dpkJHO8VF182uqNwXT21oeHjpjqZdEzpPW9SH30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On Thu, Dec 12, 2024 at 08:50:26PM +0200, Ilpo Järvinen wrote:
> On Thu, 12 Dec 2024, Yazen Ghannam wrote:

[...]

> > @@ -95,7 +80,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
> >   * Static array of 8 + 1(for NULL) elements is created below
> >   * to create sysfs groups for sockets.
> >   * is_bin_visible function is used to show / hide the necessary groups.
> > + *
> > + * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
> > + * then the attributes and groups below must be adjusted.
> >   */
> > +static_assert(MAX_AMD_NUM_NODES == 8);
> 
> Please also add the #include for it.
>

Just to confirm, you mean for static_assert()?

  #include <linux/build_bug.h>

Thanks,
Yazen


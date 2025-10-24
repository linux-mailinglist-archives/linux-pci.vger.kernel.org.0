Return-Path: <linux-pci+bounces-39267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81EC068D5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18AAE4F876C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22BA31D746;
	Fri, 24 Oct 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDkdTN8a"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD4313552;
	Fri, 24 Oct 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313386; cv=fail; b=PXti5DhCI6jcZOVyWTs+jwlshkPhwB0k0h98FBsnxn3toqhZAsd0tHetrXN/5ZvLZLf/ee5e3iFdQHpFrZPr97/RUJNVjlsl6giYm/wdEeJ93AHVUvQWuNrxWX289OUa7tytEDHAS5mw7DoT7dGGXMiTEYdWLNcJDPKgH8B0faQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313386; c=relaxed/simple;
	bh=4QFSW+VgabJQTpr/Hi3iBGGrdxqiLy6ExFHKp41Qhr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dsCATXQ7+p3odvZeixiVUrr399m8zNYDAyb23Pqcx7liZn+V+3RGDyeFlUggy1+SyQ70qt36E9LO8aBeFjMBK36VN3wQ1XqU1obYzRPeTu+PP7v7ow+d0HsXsp7XMpSXqfYLcGFdB9Ot3EPVzs2wbUAbZbJv7HuyLf961ztvar0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDkdTN8a; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttn8iHZHVVUPeAVnXpum4y36msfxUYO7y5Wg25VVNjOS4NP7IWGEHGt9byw2fRq5JZV8jxuslSkrbNl4VrJfT3SGXlp+S60pkynqFdJcEUlccy5ikQc6jpqt8aPbpPPOq0qSk1vU87++s4kAwSgiWJTnTl6yTFHg8bLVkDawMH7kC/eNKiNQcIU08n4vxEWyO8VnoPvPn1ZudQv2P5s6Pq9ElfLNyDbH5Xv83MDXbAqnTRvQhvObora9GcPcLgVF20EFHih2cNQBGyWa2lAA3Lrge5cw4PUfhbKzZfSBF26p6jHM3w+hZLy3ujRoRh17hafBgjvuEFzsb+7KzkE6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruAnUcc1+lZ67uaf3lE128bJmddDd2J1GYpv+v4z7SU=;
 b=DTic0kfS1ZkRfxkD2rNRz2wMFlE7iqix22UzqWbGX8/xDXSYjVVKNaeiNTgBTnMFEE1E7WJO/hF0/ajm/EXc4SDQcpKr4O0MXA3aBgrdLqeKII0P3ErvhUhPcIrIRzqkMK482k+P5Dp2+lOMd77qZ9R/J5Ew45VOpqzh5mqWizCUKvt1NMZZ92p8Y2USA7IPyrM9No7R0zWHdgGg27rAhG3Hfe7ILxCIgCq80qBR1s7BFR0xb3M83fzao5wWXO+o1OZHAM0T7O5aTdc3s6bElC5OrmjN0/j5NWYXi92mhmGE0vXqXpcJpJmiJULZTuY6NiutCUA1OA1xDJhK3EtADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruAnUcc1+lZ67uaf3lE128bJmddDd2J1GYpv+v4z7SU=;
 b=fDkdTN8ap66rfTM9/hYFHDwxDvOtjiN8ctt7uKbP4DSxxQYCFTVyRKJikdvWiqgPhSZ6pEVAMLtNIAMrXyJL3P7f/Ok9iQe9W1Dv4Qg8Te+lCWxUViTFPhAXv1R6lcj10SE5RvsOxFh6i1/V4a/ZCXDJ2gCOYP/1L3VJqyRvwLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:43:02 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:43:02 +0000
Date: Fri, 24 Oct 2025 09:42:56 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251024134256.GA27286@yaz-khff2.amd.com>
References: <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <20251023202503.72987338.michal.pecio@gmail.com>
 <20251023190429.GB796848@yaz-khff2.amd.com>
 <20251023190901.GA840389@yaz-khff2.amd.com>
 <20251024104851.4d3030b0.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024104851.4d3030b0.michal.pecio@gmail.com>
X-ClientProxiedBy: BN1PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:e0::11) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: e1377dd6-7eda-4b43-db53-08de13034009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKcCQf7zgkU/CjHy64DYS3HvcA9lmgyA+D8MptLrLMzuD9NS4Xxn/YOt1o5n?=
 =?us-ascii?Q?aZz5sRMSo9Y6QzXBj2q7/a+FE4XdxxoEroBlv1s89WhFftRKBs7bkC3yNBOc?=
 =?us-ascii?Q?AlWAbVipE+Enpj/93Z+dKssCUPwIEZBpma1OgV7imqXmLrDQFUGlIQbbBPyV?=
 =?us-ascii?Q?MVJJH7cOVW/W/mv+T1fbC70a35dYPCo4D5z07XGSjAXCcHIy1CvD17K7EMVY?=
 =?us-ascii?Q?Y0SKARy8h8Gtx5NVYhLlh3GQqTE5K+4R5UgmuR5CDHC/6irdnbcn1QAOBTn0?=
 =?us-ascii?Q?uq0wGl657nJOp8yiAtf/qYFbE9aA5+cTjbsGEOHG1IJzHRyoU4NZUaDWnbkB?=
 =?us-ascii?Q?LT+1fAkjtiHAjTM6qCRAYVdJGDm/NlChS8wK1Ou5ZI5PqfpggzU3bOI5/GDo?=
 =?us-ascii?Q?WNnM4F2jRP6k6bqTGzNf69pddFaDHzcXuMoCZgz01tYy/pRYb8b+wEbynouR?=
 =?us-ascii?Q?2pqkNA1xglqFp8rR/ftBWN8kZFjoWw0douwZUR5OhNzOMohsSlb7H/AkLW/Q?=
 =?us-ascii?Q?ZeTgg87eBpac3OzSOSMfrJws8plDYsYhNNuGLgkeLwszPiqpMeRz7zoboAJu?=
 =?us-ascii?Q?Ki3xpz0EbCGNJi6eyz6WVhE0vJqXZMFE417Xag7F0oqGDuKhrILJBvP9oXAa?=
 =?us-ascii?Q?yKxLgVFURPfvLSEuRL+KjIhy94dDdvZV0y4DaYaGfqgO3rFR8UR0rOoRyIEf?=
 =?us-ascii?Q?s1GXDr+qAU2oeleU3JSHpCAatsY7rT/bOUMbUjEy8D+AGES+CuVGuDrVEWQY?=
 =?us-ascii?Q?Vq3tkmOVZz1Tpbg7Dx6RTURrv9edfM8+Zzz3dkl3N86Y2VOJxnXxPhk9CP6N?=
 =?us-ascii?Q?wypovbujTmi10lLCpyAMdWl70diXehUAMBvpCPcfA+Wc7mtQ3md6Q/w1gHXL?=
 =?us-ascii?Q?xD+iG3pWrQiUzUEHFSrJuhyc58ybMzTLwWEz1BKM7cAGV52rnUrid7m9t/3u?=
 =?us-ascii?Q?j59thtvzUUoSPdJWEvF4MDO/RPp+3dT5kT9EKBqQbX1oNiB+ZIpO0YbhDtQ3?=
 =?us-ascii?Q?Bg2JtjGNnvhXkxXgbPApRJF/MqeaJhNmINlvuFGQU1LaPJBZIBpc7j+xqmDZ?=
 =?us-ascii?Q?i2LNUSn9MrpNoFJl8CqHXLLbNLT0n9K+fAN7rcIV2qoxxvAjDd8jmF8BX43g?=
 =?us-ascii?Q?BXaCrVQf9e1u9Yk774lB5xt1wLKYjY0Yjov7DgUFMERhkXgKSco8iJLYaoCE?=
 =?us-ascii?Q?F8Cbvth0z7FtcUctHVBZWs5U3l/qgkr5UO6Og6hjIHhP8oH3M3H4y2gY8Yzj?=
 =?us-ascii?Q?UQowU83Mi40ixZ3jYXzy3dct6218LDGspILDlVQ4lBEKsCeOqWyuelonNp41?=
 =?us-ascii?Q?+3kvNj+fJK2BYeRnj8LiVS8eOLztaG9w1Foi2H6FBL+qDeGCc2ySYzW1eChG?=
 =?us-ascii?Q?4RWRL4AP/UWAquE/FWBCzuOGlv9I8YqR1d69U4VYeEbgvNqpoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/jtlAYoEP4Ja+s/59nSCMwmThjLORbKj9Ko04MZQHBwNvFQq+j943xnoYjf?=
 =?us-ascii?Q?TYqsmr8p0HtkoMh39LGOpWPxJjp9iqFu2ISizZHWyBrRnE/SsKs/lxnFbA9d?=
 =?us-ascii?Q?c3K6ohgnAr5IYXlKoX7KxvH4FHh0rA2/u3sRNLTAfJjywKzzC/ltuf8yavmK?=
 =?us-ascii?Q?p73jp1oFvoZcmVdKTffanOP5QqFlz5/4qpDU/w+kU8tSew+McW8XY82RLsNx?=
 =?us-ascii?Q?ezetD66N+6C2Tu/YsfP+MmkOmxCGzbGlQeO5KAbPpk2rJZDA04aLpR0ucNIF?=
 =?us-ascii?Q?QQD0JR6ekv1mked9XraJPoDgVPQ3CiWyvi5KQljazaCv5NYRiTOxkM938+i4?=
 =?us-ascii?Q?c/IWGlPNlRUVoI3VqSOI3USSoq3fgWpnRR0M378KsiCEtnSi7WcFCo0Y/uqL?=
 =?us-ascii?Q?E4qabXJ+WeqshA+uU16XM2titex/mf6kwQnx5KF82r5JmEukbz9sOno/wQnv?=
 =?us-ascii?Q?1yhvFDeff1AExaXkRPdif71FefwPXjWl3soyYPMchkF1v3ebRF33D+1udpug?=
 =?us-ascii?Q?MZtK/ph+5ZduSn7pOv9xlR9ncEUmiwV6VpzfVORSI74+ZvchgQnuNjzQ3O63?=
 =?us-ascii?Q?BZEH8DFOFZMifUT6ysErv7euUzi3Mg1xIMymRvodIPmO5wWXOI3yBIW/xF1u?=
 =?us-ascii?Q?n4F6QgrlQpnXROawSDCpO5+yB5zBToFLQFrUq/UF0+rkPpFoVgZxHhgMUnr5?=
 =?us-ascii?Q?N/ZAkQhYEs1FERVdwnfpQT5H/GzQCOrq4YoDT37nbpiZPBAyNNqjHzb3fSgt?=
 =?us-ascii?Q?MfV1aPJisnvh4qDSxW8EJahy24KFIy1zHmyhbIdS0PoMaORfl6rOjoovYNoc?=
 =?us-ascii?Q?K/oOnM3YTfwV9NPmFwiaeBvbfF2JvbOXBeqkQYoY1B5pEUlrNBcmLpZ+8QFj?=
 =?us-ascii?Q?QdZO9sY03nTr+yoXcnv8m60GQAAwb/gOAXZs6NwSl1LYXJh+HsS3LLnemkTu?=
 =?us-ascii?Q?WbgLgdRYBaosyWbjImiIkzuahHILC/HnhI693q2fap52e2ivCUYQmzvw7APP?=
 =?us-ascii?Q?/gNrs+j3YKLLYbWMDgbCfpvl7D/VjdUmlVpDQy6GTzHbzl5i65uOkQW1xUsd?=
 =?us-ascii?Q?NLje11xhdC15Z/jkMt8Uoksz4c0kQx32cWlVIr24wPHK3mic97159KY2zwU0?=
 =?us-ascii?Q?LKzwntBos5MKipS1WhHHGpEEPo25gzQPY+eyUWM1X5rxFnVv8lYnQVkNgm0I?=
 =?us-ascii?Q?HoVhiwlA9hwARW0Yj+Ez3ersY0B1eCPCL+UrtPhhzoS5mnB98rFf0EA8QfXd?=
 =?us-ascii?Q?WuNW4gwJWEbLm5hXCmkqHRxTPs7k978D7IKro2S4AJwrheZfLGCsDwBQQAiG?=
 =?us-ascii?Q?yEShJtoFdDIA6ml3766fQTgp9kDzrX1+j3WJWHEwQ5+eQfHyrO5WeIyuQzSS?=
 =?us-ascii?Q?uMy2KgnRzs33cKFKYlg/xwXYkgqDj+1Yj//lBxRoeDD25zvpSbxlpOSWHWwF?=
 =?us-ascii?Q?e1EfnunrmDAkQpO1mui2r9t4BgbY3zizhn5ic64g5W8odCy+ig/4z5n+2M3h?=
 =?us-ascii?Q?i4o3vH4krHCQy3JRiHQQ1EGQNGD6Ed3nBW7bVi17fhsvrY8kzHRoMuI0VOdB?=
 =?us-ascii?Q?mzRVEpUhxpBHJhE0edwHqcrgv4OrEGXSZFdl6WgI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1377dd6-7eda-4b43-db53-08de13034009
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:43:01.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnmpCqih/vMrV6yWDMbHW8BPZeN+cP4WmeLHPy8LCyErFbBmTKTabWA7Z5tlNG2q78gHv6Yu6o9POzruWwVZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

On Fri, Oct 24, 2025 at 10:48:51AM +0200, Michal Pecio wrote:
> On Thu, 23 Oct 2025 15:09:01 -0400, Yazen Ghannam wrote:

[...]

> 
> > Sorry for the rapid emails. Here's another interesting commit:
> > f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> 
> I have this commit on 6.12 but it doesn't help.
> 
> As I understand, APIC ID is a bitfield of the form:
> 
> [package ID] ... [core ID] [thread ID]
> 
> In my case, per debugfs:
> 
> domain: Thread     shift: 0 dom_size:     1 max_threads:     1
> domain: Core       shift: 2 dom_size:     4 max_threads:     4
> domain: Module     shift: 2 dom_size:     1 max_threads:     4
> domain: Tile       shift: 2 dom_size:     1 max_threads:     4
> domain: Die        shift: 2 dom_size:     1 max_threads:     4
> domain: DieGrp     shift: 2 dom_size:     1 max_threads:     4
> domain: Package    shift: 2 dom_size:     1 max_threads:     4
> 
> So my phantom APICs simply look like another package with weird
> non-sequential ID. (Probably not an ACPI spec violation yet?)
> 
> f0551af02130 only rejects disabled APICs in the same packages as
> enabled ones. An earlier proposal in that thread was to reject all
> disabled APICs on bare metal unless explicitly "online capable":
> 
> https://lore.kernel.org/all/87sf15ugsz.ffs@tglx/
> 
> This clearly goes against fed8d8773b8e and it seems to go against
> what you wrote about AMD BIOSes potentially marking CPUs as disabled
> in MADT and presumably allowing OS to wake them up with ACPI?

Yes, that's right. It's not clear how this should be handled. :/

> 
> You asked elsewhere what happens if I online CPU5/6. I don't have
> directories for them in /sys/, so not sure if I need any extra steps
> to make them appear, or the kernel considers those CPUs bogus for
> some reason and amd_nb could do the same?
> 
> Bitmaps from /sys/:
> /sys/devices/system/cpu/enabled:0-3
> /sys/devices/system/cpu/kernel_max:5
> /sys/devices/system/cpu/offline:4-5
> /sys/devices/system/cpu/online:0-3
> /sys/devices/system/cpu/possible:0-5
> /sys/devices/system/cpu/present:0-3

Right, good question. Why bother marking some CPUs as "possible" if we
can't bring them online?

> 
> I tried 6.18-rc2 and it's same thing, except EDAC and GART don't work.
> On both kernels, possible_cpus=4 fixes it:
> 
> [    0.072066] CPU topo: Limiting to 4 possible CPUs
> [    0.072074] CPU topo: CPU limit of 4 reached. Ignoring further CPUs
> [    0.072082] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
> [    0.072084] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.072086] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.072089] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.072090] ACPI: HPET id: 0x8300 base: 0xfed00000
> [    0.072097] CPU topo: Max. logical packages:   1
> [    0.072097] CPU topo: Max. logical dies:       1
> [    0.072098] CPU topo: Max. dies per package:   1
> [    0.072103] CPU topo: Max. threads per core:   1
> [    0.072105] CPU topo: Num. cores per package:     4
> [    0.072105] CPU topo: Num. threads per package:   4
> [    0.072106] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> [    0.072107] CPU topo: Rejected CPUs 2

Thanks for checking this.

By the way, have you looked through your BIOS settings to see if there's
something relevant? Maybe there's an option to remove the
bogus/placeholder APIC entries?

Here's the K10 BKDG for reference:
https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

The "CPU Cores and Downcoring" section has some explicit restrictions on
what is possible. So maybe something there can be used to filter out
bogus CPU entries.

Thanks,
Yazen


Return-Path: <linux-pci+bounces-16929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AD9CF52E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E9281079
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D6188CCA;
	Fri, 15 Nov 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="btXaYJwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B31AF0CE;
	Fri, 15 Nov 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699970; cv=fail; b=UsGC4ECFfmjoZ2N8TgVnLILd1+AFuJJJ24ASOgBVFddUHZQhFChC+h27h61AzAIX29CYt753/anWDwz/V1Ol/wXAJMFuYsI8IbDMmXeHh/tQNCWb1oCCqzsvMfQ9IrXygQ+z//8yd7hQXUlnRMAklRoVMNrbvD3NiV8I9luA7hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699970; c=relaxed/simple;
	bh=VovgMPz4tf6X5evrWmS9KnukGNcAwh9lR0Oke4hrypY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdRydH96hyQHPwDv2M3/WxD0yGanBUb09oMmiewpG9nmYhrS+lee2prSlquw+nNIEImfN27p4bbkIkBPdxCe1s76fZf4sLBA8bYP/u7RTh/SnewdraulUxv3cuJvSwAXsGuLJ63jEkVNw+1BUxR0lbbcpC3ZDkHtsaMOTgYEY8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=btXaYJwk; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyAJ7tdKz4ooSMa2UKi3ZKNnF7TgoOjQSl1MQzcnRGxJjo7oZuxfSXbaTvDkn39F9rTStX0B85Z7O41wtg4vy/z8jGkkuK+BjOsxvEIQdqOVm1BFhR4Og5BVb4FdZaRfb08PddcALywzpk6Fo2b1nJJ/TIGhitlBCjQ3ML7EEzVOLJBtSZYL0FrkkT5tt4jSBoabvOVUugyBTp2DwksKEWVRWKbe1a6XiTTqdItl22sc+xd700NyRwCSH9LBxYXNPuuYBp/W6JC1Yt6FFPsKeywujkWZHK79M3axguY9OjKPxAIw6Oyn3oPkYGI3+OmTBHa/YJTyQgd/kwwUrx2ggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL0pkgcpZX/SisT+p8+JQwtxaQqm3qiBkRRIxC8HTlg=;
 b=bsB7EBLh/l5Mr7xbWDrWkACx0nXQMqWg9iWyCT/dIjAUCGLJ9dT4Jn/mJ1bvHJIe8IT9xuBnpxnP7rOeinFX0QKmX4L4SATyzAvOUoCHMN8wqlkjEIw1FkCvTzgVEG9GrNKgMGGGTnKsUnWY9d+OtKJyIpMaP/b8QsOtfP+C4PgIG8hzwU26lMv66HRbs/MvxkJV+W4FjAqLHo88mfg3IKWltr2HVm6pn8wiXuQXHqh3xW+8c9g/R7x6sHnDssekGREB0BG4LpPthI4aNnxa/2i4Hnsx5WjpUjkTAC445KcTKsMEqd0AGjEK0PLS2CWoTGnaQHcEkkIQ8QZifTBEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL0pkgcpZX/SisT+p8+JQwtxaQqm3qiBkRRIxC8HTlg=;
 b=btXaYJwkFSmfB6e3Y4SKdssd/Kt0u3w+bv5xwN8+f0xNIyV8lKyIJ5ZfelBfIHGFaVY0dp+Lg+5Jid7CdsqlKhieCAiLvkK0Xf0+wB562ST36KPFnSPXudJoftQ0sdPAIxxFv+pCReinF8nKOAh1DkS/O6IW1oyY1h9PKX+JyYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Fri, 15 Nov 2024 19:46:04 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 19:46:04 +0000
Message-ID: <21fbec11-94dc-4189-b9a8-041840ebf913@amd.com>
Date: Fri, 15 Nov 2024 13:46:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Li Ming <ming4.li@outlook.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com> <ZzYo5hNkcIjKAZ4i@wunner.de>
 <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
 <VI1PR10MB201607EB59D6C0884A57995CCE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <VI1PR10MB201607EB59D6C0884A57995CCE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 8348c3bd-92e5-4740-800d-08dd05ae23fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHJET3R5aERrWGNzNjkxaTFhd2dtcmlDR0pXaXVMUFM4UHZVemxKdy9Relhl?=
 =?utf-8?B?WUZvTjQ0emhBODUyN2dDci85NWJtbTFJaW82WVhGbjV1d3FqY1NtR0VIOHFh?=
 =?utf-8?B?ZFlXT0ExRHNJRmlDY3F6YUxLV1o4ZDFQdXIyc2RCV1BJODExUW1MaUk5R0pR?=
 =?utf-8?B?TmlDbnZOSXc5Zkh4Y3pydjNUSVg4Ri9YSUR0QUdsVXVXY3lxeTlaVnl0czhG?=
 =?utf-8?B?OUlMdjhoUnh1VHNuZUZxMFhEZi9lRU9QcEdQM21xOHhpMmtJQzNHS3J2SFJH?=
 =?utf-8?B?dFhGVUlVMkY4YUg2a3BJUWRMaVAwNmFSRm9GYmZjYmVTU0xHeCsrNzRweW1J?=
 =?utf-8?B?ZHRoanJpYzM5ZEZuR0lqeGd4Z01zM1JqcVFzU21FbXB3ZDBnQy8vL25JY2Jo?=
 =?utf-8?B?V2lnY1NRMUJkeHRyZFFxRm5QUGtmdEZJRzhseW5IbmlvK3ZpUGU4ZGpBSFZw?=
 =?utf-8?B?d3NIcEdBcVVpQWkzR1p5aXZJR2szcm14ZmFPakx0ZHBoM21Mak5BcWlLSFVq?=
 =?utf-8?B?THVKM0hJbFRpeGV2czhMY2ord0NHTlM0ZEhPN2poY3FxeU94RnZkdi85ek9y?=
 =?utf-8?B?MjdDV21sYlB3Rll5czFWbHYzb2EvYzQ2ZzNBUDVHb2xHRlM0dHhmM1F2dVJ6?=
 =?utf-8?B?MitRczJMU0tGQnlpYlVtQVMySGZtVFJZSGJCMjFFNWlEd09kb0tmQTFEaVFR?=
 =?utf-8?B?K2EyS3o3VG53cHVMZWQ5L3pYN2hpaFNOVXZscFF0ekl5MkNhRnhWWVltZ0R2?=
 =?utf-8?B?aGk5TWRLK3VLUnRjUHJKY3NmZ2w4RUhBaHdzTjMzc0FUaFNJNDg5dFg4dHFq?=
 =?utf-8?B?UEhxMHRGNDVqbFIrb1NIZEJYRjFXdVVoNVlmbWloSE9SNU1BMDlCa0ZZRjYx?=
 =?utf-8?B?WXVPODFWK1JFWE96VDJDMzRGUHAxVmg2RjEzUk40RHpFSm15ZVB4OTA5ZzFQ?=
 =?utf-8?B?VWEvNkdTaFBSM0ZVVXBGMVZSQWxQM21memFqQ0IxZ3VaeXRreEk2czF6N2ph?=
 =?utf-8?B?b2EreTZZVUFjREFOMmtGeGFaSTM3RG9FU0ZTcTYwKzhMblZlQVR3dURlelNy?=
 =?utf-8?B?T1kzaDhwdW02UjRNVk9DeVJIeFAzLzFjNWZhS2FTVDFsbmlNdjBVQWRPNkgx?=
 =?utf-8?B?WDdlWnMyVTIwd0JhMG1zQlRGM1lXNFU2Qmtad3FMMWROZ2NsL3krQkdkSVpR?=
 =?utf-8?B?K1hBTlNkdzM2b0JUM3NBT1dQZ2QyRW9RZkQrUXBuc3FaOHRoaThvay9STlR6?=
 =?utf-8?B?NnhVSkczSXA5TUJ1LzR1TmlkbE8yN2RMT2V5WnpkNjR1ZElqTTZFZnZ2M3Fa?=
 =?utf-8?B?bGtEQnczdGQ0NDhJQVlGWkF2OGd1NVNSOUR1Nnhsd2xoMmxZWDBMNjBDOTRJ?=
 =?utf-8?B?NEw2Y1g1aXpUeWJZZHZKbGR1OXZWMCtKUDh1WDJSL1ZnUXBFRXVLOEd4QnN0?=
 =?utf-8?B?OUx4WGVhZXdkMTR5QWFCLzhhbjJObmRKa1FnSGUvY1BiNUowV1Q5djVpNkgz?=
 =?utf-8?B?UkF6Vit2bWF1ZjNJMUMvajRsN3krUi95SGNIeUtHTjVHN1ZQNGp6MmJ5Qk5y?=
 =?utf-8?B?eFRyMTZOcTRVSndiek5GUnFWczlrZHQ5K2tIMk02bHFDZW53VVI0bzFRY2lJ?=
 =?utf-8?B?b3ExYi9TdGcySFU1Q281TmNCNFpoUlZuMzkxWDBOMnk0UExLUkpuVEVqVWdR?=
 =?utf-8?B?bDQyM3F2Z3VCNjFxOXBGNHpVbzFaR0tCRHJGU0p4UDBjdFhEdytESlpFeXk2?=
 =?utf-8?Q?ThQeWf/k1X0hOtgBn8mFiLmRdBU1oxUr/4lQmzL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnplZUtZVWVDVlhWZG1IUTNVL0ZmbFB0Q1NFU2JuTmdZLzdOWXM1bElwQUN0?=
 =?utf-8?B?d0dwTTJKdS9ud3RrSUNjR3BzaXBBUnF0aHFFRnRHVDhEMXZ4cFlyMEppWUx0?=
 =?utf-8?B?aGdkL0VvZEtrcENBMFJETUNpNkJFZStVSXE3SFlQSlZQbDRjZnZsOFhMM0xz?=
 =?utf-8?B?S3Iyc0k5Q1BxYVlZbUVMNFVUTytHK2xxSzM4V2JjRGU0WlVVUUIvQ2pyUlpU?=
 =?utf-8?B?S0NyTWRTbjVYZVBMdms4MkhpQTdTeHM2Z2F5cWlQR2F6MGJjdG1aYyt0V0N5?=
 =?utf-8?B?YmVMbVlOVkRpYVZUakFuWkl2OXQ5NWsxVng1QzVFVlNoSTlpTThTdE4zbVlm?=
 =?utf-8?B?eVRVQXZvd3h0SUZja2xCck5KaFNzbVF6MkVXZXFmazd3cHVzYkdUOStMSVE2?=
 =?utf-8?B?b29Ndm91UEF2Yjh4dEVtWEpRRUVIRnNSb05scHdMSmlmd1VGNGt5N1dtNkNk?=
 =?utf-8?B?VmVZVTdpTWNWTDE1d2JackpnTC92QXpyNjlPKzg4dVZCVHUxZDB3d1o5Q0RU?=
 =?utf-8?B?MmcwbWhvNElTYm96dHlsRjRJSUJqS0tlNlB0YWtwbWROaSs3QTJQNElCSkVS?=
 =?utf-8?B?MUp5YTVjc20zN2Ztbld0N1NIcVAvT3lCRjhOZEdnWWJqRndUOGttSGNubkpn?=
 =?utf-8?B?cHJ4TGpOT21GMi82SEF0ZHFzSVhZWkpCN3l1ZGJmbG03ajhZOGpMQ0F0UHRn?=
 =?utf-8?B?MWFXanZNVEVTK0IxU1NmTWllMjdxU2srRUxnQWx5NlBBMEUrdW1XKzhRMEpV?=
 =?utf-8?B?N2t1ZE9NRUpQSFZYeGtrdFJZU2JZOGhZN29oWFgrVzZlelVTMzRxaTRreEZK?=
 =?utf-8?B?a05NaHYwODFYNGdTVWRhZkhIUmErZXpYb2ppQ1gxbDJWSGVCV2lkS2pTenVL?=
 =?utf-8?B?czdqc0Z1ZmZ1OFVITUxDZWtydUxSSzNDay9DeXFNMzkwRFl4MVFkQmRVTFow?=
 =?utf-8?B?dHdlQ0NrcGQ2OVBoYlMwaFhhemE4dUEvVnY0MjI5OU1yc1djYUR1UWpPQ29L?=
 =?utf-8?B?QjF0VmU5Y1pQN1NSaXJQQ0F3eko1eEs2WjB4NVlLNzhJK2dZVlc2dms4ZjhM?=
 =?utf-8?B?QWtOazJCSHgxZmxRNkNvLzNKWnpXNERnN3N2aVlQMHU4UHVnT1JlQzlzV3BO?=
 =?utf-8?B?WWYybkVzcURVZ2NnZkhBR2IrRE04YzMvRW43dmdQU3o1NEVTU0k1ZjVlVVBY?=
 =?utf-8?B?MHNOZ2FORmZNaWpCdFp1UFNaWndFRUFZSWwwTEkzS2xXK1dJWkhCZG9YVXJj?=
 =?utf-8?B?WG9KVU5NMVppYzhmMnhQajJCWkNhSmJHQ0h0S0J2NFZKQStna0VZYlRGL05Q?=
 =?utf-8?B?eVkzb1UvSmZNL1R6K1ZCWDU2ZVB0NS9jalVFc2RYK05MdDE3eVhBaGZMZnh5?=
 =?utf-8?B?c0cwVXEyd1lhZGNON1BLUlQwMHlxbW9VdHUyVkJUaE0wdkhjb01zeDA0MXJh?=
 =?utf-8?B?UjdaOGlEVThxT3FjTVZ5eldwNWw1TVBWZVJGVkZwSTJFRFJ5MkdPeTVkS2hs?=
 =?utf-8?B?REtvOGlnS3hPTTZPVFdzU0poZkh5NnJ6aXRsT1luQSsvNlBmZmFPMWNxVFVz?=
 =?utf-8?B?eVo4TG9CN3IzcGVKbEMyUTB5cGRUdlVrbVdSYk5kTjFJUHQxdFFUc2ZDTlhB?=
 =?utf-8?B?Ym8rWWVQeENZdzNRb0RYT0xHTWtETVN4WmhXQzZQUjl5bUpmRzZtN2FYWm9U?=
 =?utf-8?B?RGVJWXBpU2pxZzgzazRkNTVRM0NOMXZ4aVpXRmFlazQ1cGU5dGNPWUlkaklQ?=
 =?utf-8?B?U3MzSHlMcUdhUlVRQUNSM0k0V2JwcXJrS3V5V0VPdVRTaC9xb2xvcjJ4LzVH?=
 =?utf-8?B?YjFNempUd0N4cXhTUVkrYU0xQS9XYVYrb0IxK3FiREVqN0VnOUI1SURrUXBQ?=
 =?utf-8?B?M3c2Z2lzTzNaa3FGcmlsd1dTdC80WmlxVFgrWmVvTEN6MDFsa3NSL0FVd2dr?=
 =?utf-8?B?dE5EVHBISmNwOVlnOXRjeFRVYXcwaVhiZEwrM0N3Rkx4Tko4bDNDUmJUdVFY?=
 =?utf-8?B?RE55TzdMUjI5V2xreDcyT0t3Q0xlVDRVSlNPWUNjc1ZBc2FwN0sxUHJOWWdq?=
 =?utf-8?B?dkQ1bElzQ1pTeWdwMVJaSThKR01wZ0FXaEFGczBXRE91eXM0ckIvKzRIM1RJ?=
 =?utf-8?Q?uzTU9VYVYcpD7N4pf9I4Ya6Al?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8348c3bd-92e5-4740-800d-08dd05ae23fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:46:04.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdz0faEonJiEELmuiDVt8KMHugETL4MpCK5S7B97w4HP0GlkJ429REVnKWiW9hGtM8h24cbhyMes60ZsUnLTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288



On 11/15/2024 8:49 AM, Li Ming wrote:
>
> On 2024/11/15 2:41, Bowman, Terry wrote:
>> Hi Lukas,
>>
>> I added comments below.
>>
>> On 11/14/2024 10:44 AM, Lukas Wunner wrote:
>>> On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
>>>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>   
>>>>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>   {
>>>> -	cxl_handle_error(dev, info);
>>>> -	pci_aer_handle_error(dev, info);
>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>> +		cxl_handle_error(dev, info);
>>>> +	else
>>>> +		pci_aer_handle_error(dev, info);
>>>> +
>>>>   	pci_dev_put(dev);
>>>>   }
>>> If you just do this at the top of cxl_handle_error()...
>>>
>>> 	if (!is_internal_error(info))
>>> 		return;
>>>
>>> ...you avoid the need to move is_internal_error() around and the
>>> patch becomes simpler and easier to review.
>> If is_internal_error()==0, then pci_aer_handle_error() should be called to process the PCIe error. Your suggestion would require returning a value from cxl_handle_error(). And then more "if" logic would be required for the cxl_handle_error() return value. Should both is_internal_error() and handles_cxl_errors()be moved into cxl_handle_error()? Would give this:
>>
>>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>   {
>> -	cxl_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (!cxl_handle_error(dev, info))
>> +		pci_aer_handle_error(dev, info);
>> +
>>   	pci_dev_put(dev);
>>   }
>>

We could do that. And with that change it might need handles_cxl_errors() renamed
to something more correct, like handle_cxl_error()?

Regards,
Terry




Return-Path: <linux-pci+bounces-11707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747549538B8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EC71F24D3A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAA1B14E9;
	Thu, 15 Aug 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rOPfZLw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680619E7E8;
	Thu, 15 Aug 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741472; cv=fail; b=MmY8ZDa+URhHh1JfuLRwmQ+kUzCsKBK/aMNsMnzLGdvU8ULrH9N2Em1mgK9ZDZi0W3I26gS7PZZLgK/4C1HejeSuEGxDY/yboahBGpyPXGZjN1qpclpWyDs6UbKVU/g9QjqtkC3tehTE0G5vo3XDNr53xqsVLC7K97cxMCsXu6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741472; c=relaxed/simple;
	bh=iNmf2CUKF7SZrb+dnDybXMiymMlkvX3ZDqrQa/lgi0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHH68LtR0hURmP2OwI1auXxMwJXb3LN3cZI6DfVVFhQgptXV57F+4Yk3QQnhPzFp6C/55OxB+AtstY3JCMFkleKyV+F8QSb3e2gZvu0pANyilWEQzYdMTmtvUxfwOYzMCtt2Qzzz73CIkkzYSX20q83TyEt8jC8EK38cuwNR11M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rOPfZLw1; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg17JXSMBQhPcJuSDs1F/MELBzC3QVVucY1OkPDCQvPRrq0tAFzrhhiN6xKxVFY6O0Cna5lg4x/jclCqQ95NhsHDbmbPuhQjpRmQnr2HVFuthewYzby7F3gbpgVaPCCQrkGMwfV6JRqvFPbgr2+PCON+OvJcYoSiTTRY25JZgNFn1FUrCcb4fsZGgl+PtDqcA3UqI8Ak9dy1OmfHvjOymvJ4RG6Cpy+M5zVm9voG2VU1K3e8JpJqxnSqShQtAmBXWjL+U3C7Lkhz6Hi3cv66qz3T3oD1JV76tTSdauap/MIqa4TyT2kcDXTkV5lqONERUGDkqFil+XYZ881Z9eEdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnFzTe0yIHe64nNd1OjCiGyuOY3G3uvvj40Mvqpk8Dw=;
 b=FUjbuzUkyxlWxJVrO5jWaf2nB92bd9ZU9AmAemM8QTHBe7+MAFDSrkA6938DPns2bCol2k32U3lTyFr7s29D7jxDxJGJmQeC9U5fvj1+e34MzQZRaN53ccWmDO9zEk+pCRurSZmsvdKIgiMYQIM1stXH8m/m4Pdln2tqXdqjRzIy1exMT1Tg5vqH+yxXF21EIflB7fBhywxgZOfx+TBmuMftDGXDbohbKocH0gfG/5rBzEdn9Oxa8we+7nVXv2AFO7eEU9X2LrrZH1dZl4Nqn6dj/xlBSPoWJ03jjGHVIwiiOyznhtmVxnDKWSaP5XwH8Ctv/ELIw1XGvBQI97asyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnFzTe0yIHe64nNd1OjCiGyuOY3G3uvvj40Mvqpk8Dw=;
 b=rOPfZLw1RMEBq238Podnob7Q/xKCl++3aiMxksYrnRFdPLINpGjYWL2vwxgeN09aAbPCdauf3TxQlTlOuc5HBRCbP1wVPkVIalChLx559R9n9pjbrHfOXnKPBbh26I6hxiEgIprtASBf1cpiHzPY00AiO8LyY1ReoMptt/2CFJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Thu, 15 Aug 2024 17:04:26 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 17:04:26 +0000
Date: Thu, 15 Aug 2024 13:04:23 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Richard Gong <richard.gong@amd.com>
Cc: bp@alien8.de, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/amd_nb: Add a new PCI ID for AMD family 1Ah model 60h
Message-ID: <20240815170423.GA127319@yaz-khff2.amd.com>
References: <20240815151240.3132382-1-richard.gong@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815151240.3132382-1-richard.gong@amd.com>
X-ClientProxiedBy: BN9PR03CA0403.namprd03.prod.outlook.com
 (2603:10b6:408:111::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb03c9c-75db-47e7-99bd-08dcbd4c519c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xO35/45fsgJ8cE0I+fVGsPKb3nsE4Rm8BMdPt6rv/IMlJDAsyurVWoDgj0jk?=
 =?us-ascii?Q?ZvPHmIHKM/SH4Wuwg9LJJYaXsxota1bzA8iIJXrrP/UoGbNfuV3ho4ONd+Xd?=
 =?us-ascii?Q?XmwLwE8UwLdqcydiqGmulaYLRD+kWm9q56ANqGHT4iXAo+avvMzeikjx0Vqn?=
 =?us-ascii?Q?4hoN28yTEPBVGVjMTLmMNjMvipAXOKDElfZuC5QVWjjuoWhTuYnHi7kEm6pd?=
 =?us-ascii?Q?FTEk2zlljPTj6BZPdI+lIg5rePXGHW9hnOpirI6WKiMNmE7WCDPqZmEyr52q?=
 =?us-ascii?Q?7T+ehyq3I2l/lCXxfMGerTplQUpZpVoE5AfgVXl5+QImUP//s+4GvCc0Vx8n?=
 =?us-ascii?Q?TNKMYGS3fqFgBhwVpyO6Yhe7HDRzlaX9cav2/N8J5AzihpfHHDpgsjCiSHRx?=
 =?us-ascii?Q?y+zUhE4GxUE6T82DvILK3JuuMUNUPRhRwEIw8vlwNmC1mykb29W5ENY9FguW?=
 =?us-ascii?Q?RB8Kt4s1qTu+pTmQP5TQD+Z9Qq9tU054Bc+zn+E+w321tmtPrho6jg/sFoUg?=
 =?us-ascii?Q?Apl2d4ruljtn31Byrwbn77bjC6kJ2/nMWeMAB5sPGU9jUnDcag1hF53cWVwB?=
 =?us-ascii?Q?GBTyGbwwx/1xdq0jaDe+mvIEULZwn2LJ71WqsXmm0Z7hSWQS+3+ROJeGbtun?=
 =?us-ascii?Q?zFp6Y5XPePZPetYzEd+YryphFdI42pAuDIIa1M6bXKdsJJGc6Z7YydQXt6Ja?=
 =?us-ascii?Q?re2WbWFqYSblhe4Zk5zNO/GZ1qQz4QxEhGE6F+AGgtcZFZixKvmFWE2vDSsp?=
 =?us-ascii?Q?6PPPpcvMbq3UzVChgFzEuS5pum2u86zrJrwh+a1SUluCBjesV9AcEqUMgPPb?=
 =?us-ascii?Q?dULVXmLL72M62+cRJwIApUhZq21FvKLos/EQdOCFFEbCGJnzIdHKqrN5RfnR?=
 =?us-ascii?Q?kpVlxQtT9TBTDiOH0b+5YCyGpclM+uj0FAsUj6vaDTfYmxNrnKth8REaAY2j?=
 =?us-ascii?Q?z3KuLEwkZ7PbIIUqHTs4DDaNmnjkU5BeGMbmZq8yF0ym2CO9hdwqqZcLR27q?=
 =?us-ascii?Q?6FgpEUrKNF/OciqBV5ZBlzwwM+1eHxjzkhcHf+w7mZK8vxeFW6XE737/IhUU?=
 =?us-ascii?Q?TjmB8qqN73LvOhrcaPDYMFWOQ+/yUpA2s86lHd1xnHbHQzYgqxZWQBE3OuFN?=
 =?us-ascii?Q?unq7nQk1CIofb1ZCsmlehRBIgg/DRH5izA/jTHRT1yH9OT1gtH0yZ/6TZ2w2?=
 =?us-ascii?Q?thuQ5wMaoNVRm01jvq1OQ+SkeL9uhm1Xrj2lpU80hbVIFrWvPlR21AUnUGv3?=
 =?us-ascii?Q?88UWwD77zimh8W/a+sp+VlTGA8Clo7niiQaJ1geFjZh0sTdZfSzLv6xsNVs8?=
 =?us-ascii?Q?eDTpxdKs1DAFFkzukp6F4P6m/Kz3FNlaqLxgOVo8IKlPEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2asrMLMh5Vw0KQ0knVZCZDY9ojKYI/XcbkzxnNU2cSGHAHdwx85ilPsCZo+v?=
 =?us-ascii?Q?wiFgIRbdcB39OsKx1ENJ24G/Vxu5TAJEHFeuGdhx1cHF8n+00jDsbUDOKr/n?=
 =?us-ascii?Q?NRd8tAEM0IWMm1cim2hYR9Hmwe4VfSGodRTXrrbIQ/lc94I3eqEZLL4EoWVn?=
 =?us-ascii?Q?AZcZMqWYtBwpww3KZB7lFl7cR++ZY6vwJKM5uHOYBkl76E0AM1Wh37ro0M0f?=
 =?us-ascii?Q?1zxlNyNUW/DTKP25eJMWrTUOZLAivXOiWjTc5JUkU1h0U1zy/Uc9FMR6F6Ku?=
 =?us-ascii?Q?IGCchCFHr2MEFpoLPjaTniW1vow2+vwI8OM3ISTYldmIOqMLfuDm1bs3TPOo?=
 =?us-ascii?Q?jLo+AxLAGVMsUVtye69SxJO/hvoHMu5jZE+EDAH7IxUi7LixJp0lbFRg58H+?=
 =?us-ascii?Q?1USq6VfyuZMKdDxCRnZtNjCKImPF2Rb8ETe54WjXfmO00GGTCuObz9KKLMIf?=
 =?us-ascii?Q?pfCYJN4NVVZjr27t8a0o3UXuSdaqDmi0a1MON4tvgBMxoiijRiaH4VLpIG4u?=
 =?us-ascii?Q?ADvuX4W8g4k3VajC5Oc2j3/3pUaku9aKjdhY0UUchZvOu9/Oli1fsJ0F9U08?=
 =?us-ascii?Q?9xIoaUx+3aHNIJ1pVNppgVGBF1loGSer2bLy9FZcOi9Y5+vX9jy04OOOrZkL?=
 =?us-ascii?Q?yqAp051HyA8bBsipMIQlKDPb4p9lTnsXVXnqO/Gxqvr8PaG+/gl/Vg2sS2ac?=
 =?us-ascii?Q?5iJlCoX1wSvd4hYs0pdxmpvEKxrdqQrWoJ5O9IYkssEFSLx2WoKsU5EqY5kx?=
 =?us-ascii?Q?zvEjOkxNFNu4MzICHIr30RUYfXR3hq306a3w9fsns4+lp4HSO2aRGHxw7p9N?=
 =?us-ascii?Q?Rv/lKxMDcPVUkx05CrhzlHTbX/aVQvDgKC6wBgub0bfCp0W7H33aXMyz5dhs?=
 =?us-ascii?Q?GkrxaIvjWuX7JpTwa9mRWYr0LieKMiN5UkfOqR0qtWth+f5UGQjH6QzcPWQr?=
 =?us-ascii?Q?SnDkTjXaCXRnnvU6TYLViM80bQbwSHzWyky5vEEXZQ7TiQjzf40cHBnzjBUU?=
 =?us-ascii?Q?qWMIxPXJeNbUxOawWrEPG81rIvgZxRqk94m0iDFGEpo+PYFnGu4LAUP5jWZm?=
 =?us-ascii?Q?FANZ7cji3hAND5P47JonFAfVXpuN9n05LYH9xIBzeuBu8tewdB0ku8qW8Tqe?=
 =?us-ascii?Q?D7uh9H7Ad/XG55MAL03vUfWhpUE7vj/ETxUGPkOzgjcyOvW46kbuI1osv2Uy?=
 =?us-ascii?Q?jtSWRshAlwTCE0E9oM2VPtiDLWVC0VmW8acCvO9L4BxMStXlvqyZGejM/+9J?=
 =?us-ascii?Q?zdZ9iMPq9PHxxJVpkaUIjCI00/bIVMglXJkTqAJoebhm3Rj8a4CeIio5XRBu?=
 =?us-ascii?Q?PWW+6feSz6x23duuGNppVp1lbm6Rbwal+Vj5h5kwlBBcxcI4zQQWsjNuBvwU?=
 =?us-ascii?Q?7iSWpE25VIcxyOFN/edUvrYW7J9P7aZpTeYCPTiTtc7T57Uo+gqyfX+qRfXK?=
 =?us-ascii?Q?z0p1yHCFEcinnCuIaPQ8/+Q9mepFdT4inh+c9uZU0ZW9bge8kNWQ0Jx+n8nn?=
 =?us-ascii?Q?mrnRKdNBm42gv21hSh3s0zYln8xYhbShe2ySnYxqUnWz0pvd0h4EgbtzGLu4?=
 =?us-ascii?Q?y+e7dSKXMdG5OKeF0C1Knfhn8lR0tnTKzDY+aFvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb03c9c-75db-47e7-99bd-08dcbd4c519c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:04:26.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DNBSK2ZcYMYjcaaBYWvbynnJ80wYccMXIyAKEXw8vtgcTfyOLbKZvnoAMCkv/xWOqYKzKakBEwfKc0ucxEOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

On Thu, Aug 15, 2024 at 10:12:40AM -0500, Richard Gong wrote:
> Add a new PCI ID for Device 18h and Function 4.
> 
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> (Without this device ID, amd-atl driver failed to load)
> ---
>  arch/x86/kernel/amd_nb.c | 1 +
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 61eadde08511..7566d2c079c2 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -125,6 +125,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
>  	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 91182aa1d2ec..d7abfa5beaec 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -581,6 +581,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4 0x124c

This is only used in amd_nb.c, so it should be defined there. There is
already a list of "F4" IDs where this can be included.

Thanks,
Yazen


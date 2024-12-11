Return-Path: <linux-pci+bounces-18174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A09ED6C3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB40282116
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5421DE3C0;
	Wed, 11 Dec 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H81OOFeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DC2594BD;
	Wed, 11 Dec 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946469; cv=fail; b=OySPwQ+fCJTZvHHMBJX2arzbFaJ9fKrJANouTZ92MPZXIaHvYwX08zuRIQiiEWJE7Hqt2jAR+ZG1pe0w4r9uhvou9Jd6Kf4hnJqs1PMKIyfR0cmbZinyfgXXM7WjdMdjmDTWaiih6yIh09uACW4rIuKvm/+HDjjBWhsTn4P7JvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946469; c=relaxed/simple;
	bh=DCY8umbeEhfY+Z3N3ywwNiIbybD9JEBcVQc18gtcizo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmpW9MclhC0/j4udPpKfMUKpo9xmxrVMffYeHPFNNrH0bvgZiMniRmggKln8PTYh3uVFc3YyPnGEaYVYZALr4g1rbHINsFIxUdIqPP6WpfMVOYB6jGDBVde0hKiiborrbLTG9dkMkKO6MaxxEIg42Bef7LFg+1gK8YUlnKUAQe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H81OOFeI; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHr1AmF8bL/3JVQvoMmDPqLRVf/3mblNlgtitQLnbjoNAEgtPGRCMmiRRQsrE6qUfy8bKI6y+NLcx9jLKN3aB1wZX3aY5UsNld3RnM8HZ4pJTO8QGSM6/yuIlHJ018DR3Lyx5A2Xt0YZvvaeBkamdWV8uCFEEjGsQYI2Et2DbOo5lweFGfvoUMvjnVATKb0qAgJQWIqqBzvNAsh+bp5eMGrmRYVk0H1a64hqyqxtZm0wURsPRxezTvU5limGrxdEamScKlrA8tsmgixqHgpMGlvOQWyXN/RorzKf3SxEwHGJpoOb/eHtuearjs/8mfW4GT1hMfWLekUEtXiQLP3Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ct/Znm2GCeFpIfguKLollOWdUcvzJwPlkDdzg/FS8=;
 b=d0iDZeOlcMiSvBs1Y5KnbtTfSUG3CrF4488VPII633mXUtybqBhc63FagV75TY21oHzSC0iqw08uABTQeYK+CxWbJVLL+6HZfpJ71Lhdwk4eu8TXPj1R+twU7uMSVzjvIA1EYGsteMssc2Bqy8MyHOeFOi7mwNpnXoZdodTswJVcXQ9Xd9dHIYw7Ojm0J1WKyEN+bsIPTyvG88GnnXtRAlqNE/5ky8ydAj6pdjQ3UD8dRwjOmtZraaOVMae5qIT2loORzhXugt5L1kV+1IBUNEAyhw1jPfTYJoTGfARZbuYtp/aHoy6gstqGAN5XuTuveoNQnjqZlCBsyVvOsYM3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ct/Znm2GCeFpIfguKLollOWdUcvzJwPlkDdzg/FS8=;
 b=H81OOFeIGGiwj4z52fq6gNIme/HaHPhsYx6oHw8Lkrq3Gdr5lmppIqCK4o9zlNuf/SuwYr+69ZQM9hHOZZs5o2kSdupVjWS3z51GjXs8mf+NVP76M9o4kUNc2T+NEd2Cqv7+RB99Xc9T4ZaEWb4b+WQ1iIqUgYsIt6cJCv22Lj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 11 Dec
 2024 19:47:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 19:47:44 +0000
Date: Wed, 11 Dec 2024 14:47:35 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH v4 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20241211194735.GB1960478@yaz-khff2.amd.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
 <20241205114048.60291-4-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205114048.60291-4-LeoLiu-oc@zhaoxin.com>
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: fe94e544-ddce-47ed-7d4c-08dd1a1cae52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WxDml9QHgyBKjTlQ8W4mMZKpL3d7pIeyShiKaHUc5AAuTCb/Bq3YxmUZYnw?=
 =?us-ascii?Q?5JaFS/12688K0lDFa0oNZxdQ41ZrWBt8EnGDnBBhyRYvRFZo3de1YyJfiY/Q?=
 =?us-ascii?Q?wmAh1IquFJXD/nlvt/uX77ZVStabkHsFVYVmmOzeDSg0yE0Gjeog1bTyrkhH?=
 =?us-ascii?Q?EhPKz9xvzgeSC6AfipL42CtlJlYXWCx3b5ByZN/UwvADel/zj941z5442q3q?=
 =?us-ascii?Q?nl1nogY2UWKKPrO5/thf7uzAbEiWs4E8ndazA4x4qZbejVIMZFYwl0Fesa4R?=
 =?us-ascii?Q?DozSztsXxSSGqlm0fptEfWoOuOaBK4czDtzw/KeQj+wea9WdskKkLN4F3zxy?=
 =?us-ascii?Q?wsg8H3l2SHdW4iIy/x+w3IBLX9WTqjPsv58VHLvT1nmatP9Jbr6FLA+py7PQ?=
 =?us-ascii?Q?6/bbQ6jwNmToMG1fo892VDfqpPdHd5V0tFgKIxTPc3ErEbNyAVwrcl1J8+1+?=
 =?us-ascii?Q?ikK4RjpPDcmMQdEAylWBizzjAQlMdGx4Px5sXNKL9fXsXZxdUPBTWkUjlYNy?=
 =?us-ascii?Q?DxOnMJN9HL9GlNkvGr00tTVSgwSrCUaRKKFh5Gg0OaMIxyiLYyUHggNW5b24?=
 =?us-ascii?Q?V3OQHC0eMz4jpFhOshzE7zJglvM/mm+ToRnHXkulRtG1vOuZQgUSZ+KeMcSh?=
 =?us-ascii?Q?Vz58qAs+BcnFt1veSGZzWVpn42mGGzk44D5EJxfexB0j4At3LukHRRDUZkR8?=
 =?us-ascii?Q?Z/fVdWk020Ovz/sESYC+/onsUqf+3vJtWb5PsTRCMGYaCyiq+4GBLaB0+taM?=
 =?us-ascii?Q?EYHcDEIihiy8S0yaBpgEY/I7Q1aO1c8Xehl8jAmg1g2YmrqzZMqa3kmczgxO?=
 =?us-ascii?Q?9R4pplS1KIaIzPK2ahP0FI3Hm3htmjiMfQa6Sndb0QzOI9tkAw9mIt26H2YV?=
 =?us-ascii?Q?qhy31OzZxZpK7zEN1miif97hZlLe2W4H0rlBda5IV55fSTVK1znlJwxhPxtV?=
 =?us-ascii?Q?Dni14xawmnXAryUh5rdwre8T4D0C79WeYt9JK5ZXcdI4ZT4RN4SEk0QZKMCr?=
 =?us-ascii?Q?Wq4nG4CdHK2pUUDKSJzqVeSepU/hh/HdDHUkVjTh34lqm0ZL53tM1noZfHyn?=
 =?us-ascii?Q?WGEGnS+B79kNyQ3yGP/CMcFUaYt1dvuSxLbnYvhmi5nVE0+puhQ2bB4ZfMut?=
 =?us-ascii?Q?3/rYp/+nAxRkQcLXRCkt1V4UW7CF2j4FcJ/M7KK/cOGUVaSXF9oHypRtyPSx?=
 =?us-ascii?Q?3cBY12k3nl3/PGyDUriYvwP8BB03y2BkCUY9VU1Noh0IMBwe0L/FLZFYJNP/?=
 =?us-ascii?Q?S8XOGMQxuXO2URdMd3TwQkaAGUNu0XxG5Q0w9q9GytCaqZo7j8UyKGqoc9lu?=
 =?us-ascii?Q?lixSR3vtiKwO9Rnz1T4YuWHlZkpV0kwiZeHKcC7ZoucHSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcpjwxCKL+RxlnFuzVtEQrZkjWCvFJ2Z8jnFxYOn2T9DDIxGV45LY8MU2wFv?=
 =?us-ascii?Q?ltAJVJFN82g9hwXaKko6RhRH3x7G/UU7ekM41cgZaXbSLK8XgK56N/s0NhYl?=
 =?us-ascii?Q?gCXaStF14MW7UPLPz4ekasvFf01iWF4ue7e1TPEAlT1lPy1VVb9AIfLQB+bU?=
 =?us-ascii?Q?Md1WCsKt1WGduZMfeAok7l9mskkyZz9QJZkmCr2EYQ1i/n/QvpgYQJuL3C7f?=
 =?us-ascii?Q?nOGOSkBPaGSgU2MfByMwqlJaqy+68ALsD3HJmecrFYK4/c+cXISDVTxQhX+w?=
 =?us-ascii?Q?aJDu5i/V1ZzFQZZhqfbzZdIIXm1AAJIdJBC6xVqb4aNw7OJwBAZKrqu4BYvM?=
 =?us-ascii?Q?DyzqpbypIeUFvZfHaQeMuhjRghwa/78iiOw2nlSkvzPJxDOBb5OUi8J8qnyT?=
 =?us-ascii?Q?xsWSET++xLj6AW2NEj5u0e8bSvX6J8T+iM3wQYcbOfKRT5lU9GRkj0Hags4w?=
 =?us-ascii?Q?abFctk21rILnM+tRjPQnhVlZkv8aNcdufJsil2FAk3JIH7GEVWXXxpMV3fT5?=
 =?us-ascii?Q?2cBUU4hUfDZWu0jarzz40HXjCjrIW9c0TCxlpS2mgOPr2szivQo70tPzZWFh?=
 =?us-ascii?Q?kE+VmEEdLimDSi19aPeNbCV6UOsko83bujRB1BM5DtYJtc0wDJj1KakB1DOX?=
 =?us-ascii?Q?Msy4oBq7lFYXY4Zi8/sml0rfEWCBnuV/jj3rouqwvENsSYtqY6zoOppCtYSG?=
 =?us-ascii?Q?xU2e8M2CAh/V+68on1aSSd9DFkMqyCPVN9stDvyIfqhPV94rRmK8a44sGVqo?=
 =?us-ascii?Q?EhZgJBvmcX/snZu6/0cVx1ZLBsrcenFQQ2hmMAvOuJg4D6ubn4YSzdsxr1SB?=
 =?us-ascii?Q?VOgQZocHaZ95W4EH0wFtU7Yt9WWrD8yDr6nYMYjmx0fEfw/HJUX6HZ5LiP0N?=
 =?us-ascii?Q?9bDK4z74aME9IqX6Ex3dYApxYdMCFwPLSKc/xRxf0JqWhBamZw4wtX58pqSm?=
 =?us-ascii?Q?JNJheMJq4y+Jmd2rN+ulOkEJNh4lnhI89Pi6PxZ2sRgLeIDbTBg7NmMhiKoV?=
 =?us-ascii?Q?Ar/BjZ4J3gCICGQ3nzo5Kru122yrZsAHlrxpNy2CfTI9qPe45zjgldNQtzdQ?=
 =?us-ascii?Q?/b06ZWiEn3nw9pCE2iub5I0DJxJXDa5nNBgvODkJ91Sju9SKew90aZ4walyA?=
 =?us-ascii?Q?VBZrSYNruY+fGi7cBnCvAX975AfTI9/kft2c1Rp8S/RsH5rYArmbgGahEOxQ?=
 =?us-ascii?Q?X+zwbtbmXPVxAR8ZatCWYARY3onmCuqFukxxud1oDmZuT5qHyYZRSQhZxCaI?=
 =?us-ascii?Q?2KEiuVXwl/pvdJBuCIHHWXKbYZH8gsLAeLI5sQueGkJUE7VU9SZirVNd6Xoh?=
 =?us-ascii?Q?uHLlaGEH56qpGDQkEmSMe6hDIZxg9Uq8WuIZ4EDB7FAL1WKNble9XaBqj+nT?=
 =?us-ascii?Q?a2KZTjBYtjiu8cAfdFXl78IJwRhZjZ4pT+QnP8ny4/3cnXJbE3rnJvJ4qU9i?=
 =?us-ascii?Q?8SjWnNLpaquzbdwAxGZHcaFYwxrhgh0cFOAYDmAU1ADYKbL2Z4iLQ0V+fM54?=
 =?us-ascii?Q?THyrF/Xqx3/nBNl6JZFlzk+BZR5k/ShnxTmo2nlaJoTeJ3h2QDlVDmT/+bg0?=
 =?us-ascii?Q?p1SjGU98o7O2jmmdV1/YtUx1EF3Dm9ODaISxhi78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe94e544-ddce-47ed-7d4c-08dd1a1cae52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:47:44.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL4/JzueIlWtQqFF/pgcO8GImhcBkBM6Jxz2lnfjMS5SZV0qAX+8MeqDJ3dUnsgp6Qur6AV1SNkw5hJYouob0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

On Thu, Dec 05, 2024 at 07:40:48PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
> the purpose of this function is to extract register value from HEST PCIe
> AER structures and program them into AER Capabilities. This function
> applies to all hardware platforms that has a PCI Express AER structure
> in HEST.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  drivers/pci/pci-acpi.c | 103 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h      |   9 ++++
>  drivers/pci/probe.c    |   1 +
>  3 files changed, 113 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..6e29af8e6cc4 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/rwsem.h>
> +#include <acpi/apei.h>
>  #include "pci.h"
>  
>  /*
> @@ -806,6 +807,108 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  	return -ENODEV;
>  }
>  
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * program_hest_aer_common() - configure AER common registers for Root Ports,
> + * Endpoints and PCIe to PCI/PCI-X bridges
> + */
> +static void program_hest_aer_common(struct acpi_hest_aer_common aer_common,
> +				    struct pci_dev *dev, int pos)
> +{
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_mask;
> +	u32 adv_cap;
> +
> +	uncor_mask = aer_common.uncorrectable_mask;
> +	uncor_severity = aer_common.uncorrectable_severity;
> +	cor_mask = aer_common.correctable_mask;
> +	adv_cap = aer_common.advanced_capabilities;
> +

These can be done at the same time as the declarations. Same for the
remaining functions.

> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
> +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
> +}
> +
> +static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root,
> +				  struct pci_dev *dev, int pos)
> +{
> +	u32 root_err_cmd;
> +
> +	root_err_cmd = aer_root->root_error_command;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
> +}
> +
> +static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
> +				    struct pci_dev *dev, int pos)
> +{
> +	u32 uncor_mask2;
> +	u32 uncor_severity2;
> +	u32 adv_cap2;
> +
> +	uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
> +	uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
> +	adv_cap2 = hest_aer_bridge->advanced_capabilities2;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
> +}
> +
> +static void program_hest_aer_params(struct hest_parse_aer_info info)
> +{
> +	struct pci_dev *dev;
> +	int port_type;
> +	int pos;
> +	struct acpi_hest_aer_root *hest_aer_root;
> +	struct acpi_hest_aer *hest_aer_endpoint;
> +	struct acpi_hest_aer_bridge *hest_aer_bridge;
> +
> +	dev = info.pci_dev;
> +	port_type = pci_pcie_type(dev);
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!pos)
> +		return;
> +
> +	switch (port_type) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		hest_aer_root = info.hest_aer_root_port;
> +		program_hest_aer_common(hest_aer_root->aer, dev, pos);
> +		program_hest_aer_root(hest_aer_root, dev, pos);
> +	break;
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		hest_aer_endpoint = info.hest_aer_endpoint;
> +		program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
> +	break;
> +	case PCI_EXP_TYPE_PCI_BRIDGE:
> +		hest_aer_bridge = info.hest_aer_bridge;
> +		program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
> +		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
> +	break;
> +	default:
> +		return;
> +	break;
> +	}
> +}
> +
> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	struct hest_parse_aer_info info = {
> +		.pci_dev = dev
> +	};
> +
> +	if (!pci_is_pcie(dev))
> +		return -ENODEV;
> +
> +	if (apei_hest_parse(hest_parse_pcie_aer, &info) == 1)

Don't need the "== 1".

> +		program_hest_aer_params(info);
> +
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * pciehp_is_native - Check whether a hotplug port is handled by the OS
>   * @bridge: Hotplug port to check
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..78bdc121c905 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -897,6 +897,15 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_ACPI_APEI
> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev);

The return value is never checked, so this can return void.

> +#else
> +static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
>  int pci_acpi_program_hp_params(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..33b8b46ca554 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2304,6 +2304,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_serr(dev);
>  
>  	pci_acpi_program_hp_params(dev);
> +	pci_acpi_program_hest_aer_params(dev);

This should not be called here unconditionally.

OS should only write AER registers if granted permission through
_OSC.

It would be more appropriate to call this from pci_aer_init().

Thanks,
Yazen


Return-Path: <linux-pci+bounces-10520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6193501D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA81C209CB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6D1B86F8;
	Thu, 18 Jul 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OlEPm5M2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFF7D3EF;
	Thu, 18 Jul 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317619; cv=fail; b=CCX7QJRACJiaMa3xHxR1Kf5Bbxws3Oi3ffffm1FY1bsH0lSj95lZsLbKfprnq534pnKv5rgT7MOKHXw34MGbuiF1MTKJYAFxBdYWFsv0XvLx34QZLRnZ81NquvmNxJJqOSG0JcfsaLZSuv4hOyFPWRLsYNdyHBvmsteuj71nxDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317619; c=relaxed/simple;
	bh=bxL2MYOLY7gbaeUjZ3Oen5CxjMJZ+GAq9AXFx7eJfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hlChGxw9D+KjF4+/1MCcl7K9yYuKmxhLfQrrfGd1YTZ/o6yRFjemYOwqB4Au5wkSqR7vIlZXUslAJOJ5sRKBocr22apPzMMxVZt/mQWmi8/t6zQ3BHMZL270Wl9TbZDKl5qwIKtov4UkTbwClxMJ77ajVQ1jldooIf45xHJP56Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OlEPm5M2; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3Pe3ar8cNcSqfdunXerSc61jqZBmj2eTh+BBH7fFGaJUZY0z6R0FH4HAyJeotuD2XVYwh9dCBu7i37ek2dW4pua+huUPYHhLN7txwP4KgyY3JQBlQk/dXsDqC23g1fSsZ2xc3FpI6ou0qbM866VDCeJkfBeQm7QN95mQiX2UJCS5YA7pGDIpds97mLTdaqabSAhUI0E/4Fsj9G8n4HehHlaMWJNPC4wCLGSbx4nROhy55KeccTxeyKEwi3jQoiFLnm5VtXtZxwRuicJMO1YIUotyaIWdUH89ujUUzCiJBqMzgMNabGWSfgllo8eYxxX+9KZY3JDCfNH0qcBPcqY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAW1/wgAqx92vGH48mmAnT374vsCjCELUqnPA2jxeFc=;
 b=wWp8Qs4dDjY3XzhqMWAVR3rnFDCZ/gDvp9EqpMNw+FUO0EQAYNMJP7Y+88U//0AH6NnOQVmeIPRldvWGCs/ue2TNR6q5KH5bkqRFSOkLE2CAQd/Dao9mNvxDcJC8q22nhvTGi9TEYNjC+Fr24pEgU0HzPsnZeNp6Mh6Bv+xDMTBvVGFkrSWR9lzDEzl8wW0LBu3ufUbllm+r5tQr3vc4eQoaLE8c/mnXfVE+SGa+DnJw4TqVo8DUfmqjvCknp9361/4QmvlLiGx2tPsXOiJvDjZTskhbdQMuBTGxqHiNOSAT14jJez11fjUjhmVjlhe/uhkJzuKkOItxwoZsbGe+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAW1/wgAqx92vGH48mmAnT374vsCjCELUqnPA2jxeFc=;
 b=OlEPm5M2tu/g/Sj5kdUjON95OrnrurgKZUzBEay/pEfLmk1PQzeSttZCWdqVGNi1YfPLFqUSfm/DlbOKWFYIigyyklf122g2YQZsOIVyyhftjpIifqzAnOe9tFin3lzFq4lWwtzPdvZQ5uhGmvHD6AiKLTxrsQluehriN6Pdzpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 15:46:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 15:46:50 +0000
Date: Thu, 18 Jul 2024 11:46:46 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 0/3] Parse the HEST PCIe AER and set to relevant
 registers
Message-ID: <20240718154646.GA63955@yaz-khff2.amd.com>
References: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
 <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 947d9cd3-a4e2-4565-b189-08dca740d694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tk8GfAsQx4y3CgMREGNlJHHmVxs/BhHLn26sRSBSlJkpzYvGGRfg0ux9BpNX?=
 =?us-ascii?Q?jtROkB3XIqRGJ0AuVtb190F5ImeKbyT4ZS+oOr/XjYYL7h3PW18Gvz+UK3nO?=
 =?us-ascii?Q?ANn7QzFzxEGQVmUClHFBoVvyYpb0jcoRKqmRz0cLBKMjPioxtAqi0BaD9cC1?=
 =?us-ascii?Q?vyvbXwU0LLOitRWisvQjOJnMhjYjy0bWjwZxgy1mjkjsawb7RmlKolbZYkxe?=
 =?us-ascii?Q?rRL72UWn8kiW6fBH2iFgXPCNEukZffWzGWq3Za00z7ScNXEDj36mEDi0huwO?=
 =?us-ascii?Q?PIEt4BUXf/S3C7kxJXsp01cqGCPHp0AJ31lQrWWRYLopK5zfAZ1diPaVTaJK?=
 =?us-ascii?Q?WySLEvdNACr/nsWZKvsEoFRCj8pTXi8xJ8zRWEunUlAL5RNYdr5ARFin/LBO?=
 =?us-ascii?Q?37BEaE0jpauent0mp6+q8dspFEhsas+wiYuygYhHyfLf6DLCMpjfCSdwqTOz?=
 =?us-ascii?Q?dsj5ocYGJPyw8dbY1XsMoMd0QKZCUgb8UU9YrvtMLrTRl8BeH/mCB9t5AXCF?=
 =?us-ascii?Q?isUpeWE35mKEhbh9ykgSLqdJ/i+Cy/tD8mfZNlrnF1fv9HdS4o9o1YyjrYAm?=
 =?us-ascii?Q?Kvb/iPntGVMb6fwXXn1ADOmye6T66XlUXZFxt5+Ojz8mVN6qz5kMDapdrLGC?=
 =?us-ascii?Q?AuBWqCgXP05UB/HDbNN0FZwUxRAxGWys9V/h+tOg7S+uU3cXptrnRz2c95ql?=
 =?us-ascii?Q?J27nTEwUUNCf7iZzMUw3lDq9c4qA6MWd1tY/a7cD0HJO/tXNKpoh/K4iSzKm?=
 =?us-ascii?Q?UmIQiMCIww/Q+7SA1IOezvC8Zchz0fEf7ra5sG68EMmIkiVqUpmBO4uaJkZw?=
 =?us-ascii?Q?eWNxHBlZvkJ7V/Do5J4IImZpvXt14Jyl5x9Eno5kecW3FFOaCXPCj6Z9a4eB?=
 =?us-ascii?Q?qNvKhvYy7PCziOYnSAdlydHOqZwopidwVj1QvYmVUBOMn/PWVO+cW+/R1jH4?=
 =?us-ascii?Q?4MqEK2ARP8x+RE4FrATyLLzkO4YBgQZx1loUNWr1C0S3DyTNOCzRUMoPrSqc?=
 =?us-ascii?Q?XLjCrQGNrPmXTIKVP1rWHd1FkI+RSIz/DBLhN5W01ycZoiizby0MOZeavtgO?=
 =?us-ascii?Q?Sm9ysa9UxGhEYjhPxTNobR1Vw/KqEaUk3qhBUAkgzLkCmqhpoFBNBavNwdfF?=
 =?us-ascii?Q?3bqXtSaWc1K1NrFRCZCKd24xfXuMeUt8qW/rQp9pa4p+KKqbupZUVu54+Q5y?=
 =?us-ascii?Q?G1PuGNj3gePFfyyvqQliGILw+3ufi7SHvedT0ErBF45Ktvv80vUe8iIX/IJ+?=
 =?us-ascii?Q?wSARUqDI/I5qOaIQU/RRjHo47iSL1dTT3rffIJd5YZM/TOHMiPTYsmom/0Us?=
 =?us-ascii?Q?KU1oObnbNJIWF509/9X9heYhQmCDgZ7zpdvkdpBcOXG6/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YZLSgnGRlbaCMjvmYk5Ucz4Dj3sEZi5BGVDy32Pca77csRn7LWdpd5X3Ll5?=
 =?us-ascii?Q?5tnXKGDlWiLsSoaUX3k9dVlHvsdGU0Zs3Qy7vS9xujDcquqTqkdfEFypS+F+?=
 =?us-ascii?Q?lviNJ5ZaI85GvKGvLCPM+U1E7eQL8cgN2J31N1pH4ZhO48No4E/P+qKsGGl8?=
 =?us-ascii?Q?kdaxqEI7VM2nYX9uTUnSRDWCxQkP01QGtN/2pxe9wb51Y1wIt/kMOAYob/QF?=
 =?us-ascii?Q?600/7R0PU0KdS9S9+8sSxmCZymYxjZW/q2j+zFlbh2VaKwaOuISNybgC1r0g?=
 =?us-ascii?Q?elc9wJ/R3aOTDUSGSZwIEteJHADUjw041MdQ3FdjrctPvSFyua8ruE4eCtUs?=
 =?us-ascii?Q?5W5508l7Rj0DmG2DHzj8uoIigAI//6kFWYqOUqMWUsmu1Z2eOeD7lf6FoXUz?=
 =?us-ascii?Q?Li5oT2V5iz7oPEFUec4zyuEjPKH/+9evYcwOnbQJM+JqM9FR69gNLxeRDeW6?=
 =?us-ascii?Q?Mxo4jfYikqEMLRUTnfm8yQ8JC9BnwouGttM3S8mYtRRVE2u7T+dqZp8x4uTa?=
 =?us-ascii?Q?JCCqv/a02FM6uICKHqc0B0FDv7fDlnJ5YkzYFXHgaioC2TwF4LTLhpy56vNi?=
 =?us-ascii?Q?12gEeeFWHr0wbAptSoJ2hXKJttlZXAVAhtcslx/etMwIUI5XI6dniKgyBYKe?=
 =?us-ascii?Q?JhJhtR+vOF7YufAip/ppQHfzj+DvCu/mQJLxbu6An5YnnNoXvEHugEJkLHgI?=
 =?us-ascii?Q?kWT6gw361/OLVs5c8zzRVuFy62PuIIYsVfjQh1N/ezSyLJBhcBFqc5MBwacZ?=
 =?us-ascii?Q?dmcGlMiObeNWiOfvJpKzn7PiJh6qf5hcs8V2qXzaFLT3/vKMbljcr9xEmbim?=
 =?us-ascii?Q?mDS2R/P2/Tq4Tfk+6vZwu6kSItN1pEofjzK5vM4NvvewVO/98luA7D0TGAfp?=
 =?us-ascii?Q?iC8Ew5khfElSdU+8ij+pWiUfbJ7RcG76N7FmuiJCZaYYlWIRagITqNdrT5DU?=
 =?us-ascii?Q?vPj1bFA+5rQ6iQJgOmYbGV/VoG3ohjjPxdR/w5HlOTNEnDXsGz6M+xcFShOU?=
 =?us-ascii?Q?w5hfXMJLLaJydaPP3bBrClIi37zdMr0Lu6qfWIdzOB0Fkxk/J8DFeohlkrws?=
 =?us-ascii?Q?tBk0S8zy9Ci7SNlE7vFs5AJj7IIQw61wN++UmNv1aWrOuOGS41DcMBJ6un6i?=
 =?us-ascii?Q?ASmCq/9AfPHUXRP4qy6mFD3jh0d0ITxh4rChpNuYFeDaUt3eQIakvoxvdd6c?=
 =?us-ascii?Q?bJePhai1UGv2H63ziHeuUgpHzxNVjrnlg0IAEiqQTFxPfUul1cY87XQrM3DL?=
 =?us-ascii?Q?XjFuSIRIlO3aeTgK5Isy1uLFHOe2Q86hMVmlNfP0j3WGs6b6UPRzoC0zgmlO?=
 =?us-ascii?Q?D0wf78GKwrOZjUGPq7qbEyLJQUTHaf2BWUX/cMBRhBr9sD7dEjG5IU6HP8Kk?=
 =?us-ascii?Q?dJvUzXDgv9ytI4hqAV0ozs1PhF+sC/4dtOlrwlehhZDcwafG4F/yzH29IUeK?=
 =?us-ascii?Q?98jkZD026FbHD1W+mL2ldEixkFy+1vyZn+WLgwJuwkkm9XMlFmiIwbxpSv7m?=
 =?us-ascii?Q?j2VTaZO3qfuVTJNGdAif/hy6jrdoDDkZRU264qw4k1F5sRpZkGnXPHQHvLiV?=
 =?us-ascii?Q?qjAFkp/XWdsGy56gyzKVLDFHxR7nJLXpuRSIfTpL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947d9cd3-a4e2-4565-b189-08dca740d694
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:46:50.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSf+Zb4LxnIDfRpbCgVaOymqIj8P+QEs4raeX7ZP0kvsUAC/0R4btT9qytFK6HmBrlqm9au6cZ1BGbs8L5ZWdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

On Thu, Jul 18, 2024 at 02:24:02PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
> r6.5, the register value form HEST PCI Express AER Structure should be
> written to relevant PCIe Device's AER Capabilities. So the purpose of the
> patch set is to extract register value from HEST PCI Express AER
> structures and program them into PCIe Device's AER registers.
> Refer to the ACPI SPEC r6.5 for the more detailed description. This patch
> is an effective supplement to _HPP/_HPX method when the Firmware does not
> support the _HPP/_HPX method and can be specially configured for the AER
> register of the specific device.
> 
> v1->v2:
> - Move the definition of structure "hest_parse_aer_info" to file apei.h.
> 
> v2->v3:
> - The applicable hardware for this patch is added to the commit
>   information.
> - Change the function name "program_hest_aer_endpoint" to
>   "program_hest_aer_common".
> - Add the comment to function "program_hest_aer_common".
> - Remove the "PCI_EXP_TYPE_PCIE_BRIDGE" branch handling in function
>   "program_hest_aer_params".
>

Please include a link to previous threads, if possible.

Thanks,
Yazen


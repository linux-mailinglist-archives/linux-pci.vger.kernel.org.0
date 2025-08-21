Return-Path: <linux-pci+bounces-34486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC0B30236
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 20:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF8C581DA2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2271335BAB;
	Thu, 21 Aug 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOWbRllU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23222305E26;
	Thu, 21 Aug 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801430; cv=fail; b=fp9xRaDmVdZU9oVh/spAvXG+/xlmN3VRs4BfT/L6zalq3eua+Fp6X13IoPif0FDISN0bkYyPNOd4Hf8JmvMNApMaGhJSi7SHhpQZPIQnoVSTeAN0g2ME7TovRWv/Hu2jX991Z9pxzjmDmVxHRXmW40Zo33B8fCrmhm6SOOHOV8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801430; c=relaxed/simple;
	bh=Oe65oDrkXUhpZGsQK/HA1IPfdp3Ud8lGlRGBlhUfsqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=loHhPUuac/E+Cc6a6BWo/7sHq7Ri2kxQMDNMU7faqpSIVU9RYauNMwDvSEpOPgW7MZBnvbi6MhIoo2uL04iqmPxPM/Ba7CoMUh8LNMb032c0JyhAALqqCbhtZvaGicu4zBGidU5C/V9yXk1djL7at51g/Iu/zMTVrbLr4U+M7DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dOWbRllU; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxNWGVXXjY/dwoVsc3BEwfjvs0zD8HsMAxR7sUcDmKbOpJ2Aat6K6YB0jrWUAru4k7IakBUE8r8gsNmKhqwE82l9meqhCmMu8+Vr0G2xJKAzKWfgBX0NkF0WmgagrbUEinpQvYQv2QtGyDRVtRzWl+clndDbADbtt91TC+zXqq3c3hhN4jXC/cd14copYYi+QWrCWHCKz/Lbf9azgdQUSSUu1FrcJYGGLBIRqlgoUBwGaEwWZ9OGmku3vfb2LbNe0XgLU7y45YPfv7Q+j9WepFph4SHhOMojRbIbRvCTayUpr+G7ZP4HjOdVhiDeZeaSWMPJvhiAeaPdHuYAknCQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVqIvHRUGAIk18t1cGbdXV4kxRnWuMrsyECLpBLIFtk=;
 b=wc7gUOfNk/ZTEyMtFMJTtTQgzj2jrrAyF2uAfsY5VABvxWd71kgNYxL4NNNYbF/QEkSI3eIvEw34DWQd/Ydwd8ZSgiaiMQoDmPkZ6I4aYBLf5UfuuaYWzv8NhpovU/gmGV6kNbyu8WErQOTlCn/PlnzIlOiZ0AjEjVX9exak8b5/mNmoSIDsB0YnpdkVpN6CKyb9gyEAStEwDME2mACIedHJoRieIJu5X8H6lowd1Ef1TONQ8m2cSGP4/DljH5dZlRvZEwcjwRg5uTV92CArS46+QemOaETMU4sih0nYtpEM9kxINqNadpQAyBDHbUgmAWw9AvQbNuAnRTQP0H+hHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVqIvHRUGAIk18t1cGbdXV4kxRnWuMrsyECLpBLIFtk=;
 b=dOWbRllUEgmEYzuLYxroRHhuKGNVmvpVDg6xGLfvLPpoBhxR9yFxFVM9tPA2bCYaRBZ1sURw1zUOVTDtDAcEPPoTZOKnK68TOiQT4N+0OMoJCui4t969cWR6yge+W8I1QE2JuwN+srZ4N9GHPMwW6lktP+0/BM0Ti3eN2GqclLZ9Fjk0gcUgVjzS/4JbIFTn/IoH3ddmhGTrL8pQ5fVRNGZNZhg9F+k7YTDBXPGT//AzmxrgrO5dUF+I+9+6cthErMM4QI+2xXJG9F2wyeTykuZBvxDK4jak+pxzUlopXo0MQjJ5yywQQzckXcHSgY+tKlf+D05f+swMHoUPb0ywSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 18:37:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 18:37:06 +0000
Date: Thu, 21 Aug 2025 15:37:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, etzhao1900@gmail.com
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250821183704.GP802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <20250818234241.GF802098@nvidia.com>
 <aKQG9/skig6F8LdQ@Asurada-Nvidia>
 <20250819125249.GG802098@nvidia.com>
 <aKSyzI9Xz3J0nhfk@Asurada-Nvidia>
 <20250821131304.GM802098@nvidia.com>
 <aKc5niDWTwaCInH2@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKc5niDWTwaCInH2@Asurada-Nvidia>
X-ClientProxiedBy: DM6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:5:80::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: cce18cd4-ccee-499d-d03a-08dde0e1ba9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EACZZ0vFxT+KKmAqKdQkBdu7Xlm1DT3rqnZtt3ZHJGL20OGuC2EYsGfVE+A8?=
 =?us-ascii?Q?q/8jsQF+YP/9X8Ot3kaXRi6h9ye6/K3u1le3rjv9N4yqymsVys0qflbUILb0?=
 =?us-ascii?Q?NxJLe6PXkVqw7T6R2pFM9xHmtLLqrRON5uDBZ/GUNtCPtkIPkS8bvNKi9YU6?=
 =?us-ascii?Q?OoSY0yIR9mpT+X5vomiubWjEzpzRwbcDR7K/yhrx3HVfzr6Xjd4LPLBiFWwG?=
 =?us-ascii?Q?2rVf50liqCDsY6dG5bVN3/CKCkbnpJRjtTwChDwyCvcS1xk6JUvUS1b2Dg0T?=
 =?us-ascii?Q?tWcNx1FQWitgos8uw8sPRVrIljea71tK2ju1g9FDiZmWok3GWuQGTTftCuuG?=
 =?us-ascii?Q?gA9L1J/Kxkr2tn1j2+T54j5rBuUX4prU9F6MS86x7OmD4rPPNLWJr07Ian8s?=
 =?us-ascii?Q?hY/IQNE7SjW83KTooCyXUtDW8n2H9ofqalmA0tbMsiupu+t/awlyFdupMEB5?=
 =?us-ascii?Q?vwz7LH7fjmdKrojJQ7vMzoW9sAa3isjK1xihrYpj4aqPKf0PBlY4gvlNfysN?=
 =?us-ascii?Q?N26wRdfLE9YGGAs414d1j5KXN4Mqxf9px7R28FO8dxe0OCWkVY1a5PuGuJLA?=
 =?us-ascii?Q?ClKm/9I5ihd4DwCeJMdhEPdcaTwCliEXaN/A1HDySW+LvblPNAx55BAMqc8H?=
 =?us-ascii?Q?cF7wADFlcrY7ytjvOEyz20prRtFGGzTlrX0ZUqOe4DGgJDZ7yHwe/TnRDHKl?=
 =?us-ascii?Q?evm1Or/0l3vLMp5JL9KOF3eJ37dLwox27+TLAh2upQurAKzX8xgVGVurenpt?=
 =?us-ascii?Q?CVhobzhlQtUEwujtXdBAxwYyC9/cA52m7sjS4WrJvwFPGptueeER9pd5bdLy?=
 =?us-ascii?Q?X5D3o/K3kwZNHg46Q3tPyTOtv1DCfaYMh9U3nEE2TXQaLlL8Y2dPOk6aZ2k7?=
 =?us-ascii?Q?O123MxbA2WO+nsArUEmZvM3MsCcCd2cRuxX+buJMM4X75x7V4MVKy9Dk6u8I?=
 =?us-ascii?Q?1brzTGrHpQxAYOxfK6+d+ZDgOD2hMHYV3rOLuCn0eWClWFnyASuSQbUxzk3Q?=
 =?us-ascii?Q?2wM4Z4sdXw52hneH0rYpaNoL9PD38TMQDrT88kqiLfZjR6PTpoUaiGDIZ93P?=
 =?us-ascii?Q?t8iOJzSEdoigfLPkh+qDRIJlYrLyVKB9LCXiLyqibc9D8dmFnLxjbRswMSq2?=
 =?us-ascii?Q?4I++f60Qm/S4eyBYJ5Z5F9+/5hD69JJSVMiI99HXeqEb2oysfNHwlmf3xmcE?=
 =?us-ascii?Q?JuKXIIm8SxnfWKy447WGSkVcF6mOiTYaIeHyhWt0OEu2NzVofGwDChpevJ78?=
 =?us-ascii?Q?x0Y9iaP8nhtN5Kcve8RpyehVkpJbtl/sEDskQBIugtMHEOobi7CzozPxVjgl?=
 =?us-ascii?Q?Qx6BbQ1NBJI5l3PEsmPd61yEL2IM98+yUf7ZifTgMQhCVS+JoftqaT3ExrVd?=
 =?us-ascii?Q?dodMiNsg7kBuFhFO1sg+kSFTbDKWn5DAvNUw29p1luegjFpCT4KA7Sxx1sY5?=
 =?us-ascii?Q?TAd7OSETRiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FI6Q68YLrUrpJfi+iiMwsG7wwYPutIgbpto6YKklKspsadXE/DQgfpAmKWZV?=
 =?us-ascii?Q?3oN6UbwuKoUMIfIPxQAPgnpYz/81cIuPTpaP0g0BRrnrGyb3BTYvu1FQsE/j?=
 =?us-ascii?Q?DM3GvjHBAy1tszNFiPqOjPZUUIIcIyumx+opSaKhponWT2+028F+pH4uNjHy?=
 =?us-ascii?Q?o+v5dsx3ipWp+7VVM1WQKHRaJ2IQxdj90D2pnKZXPLbq2Yykc2qtULzMQnKF?=
 =?us-ascii?Q?Q7oC30FKiRZ/xTdxlugh1PBx/DGfgCQFXxbDQ7Jz/YX7kyv3qm6mae+iPC3o?=
 =?us-ascii?Q?GsjkLJB+1zqlrnTzgrvqqaEOB8emPWTJufTnvLVDW/b8K9IxyqTo8B7ltiPI?=
 =?us-ascii?Q?Q8avYaujOU/dzqWyPEi0Q8fj2vGC08sfUD4d2UVC8eUX65KKr737TFSaSoKQ?=
 =?us-ascii?Q?Neocm6ewszmbIFrrEgYH38xijA6z6j5L5QcMkoRdBLjZ2U0J2/QgM3YmPBSP?=
 =?us-ascii?Q?3NnNH0OoqpUgyWRu2j0FsaACFg3Ncni8YA2lyFXGkPSM/lc0FUde5sWUJtL6?=
 =?us-ascii?Q?M0nujN630YiORDFNfqL4ndSctXb9mXD6tsBJd44NnuvDbSsmdOD86mkjqHRq?=
 =?us-ascii?Q?aWEsByHxlL3WAxmDCmjP0vVfGi9GvODzfv6s7UDJdMdHEtyE+Hlr9cHVO5Ba?=
 =?us-ascii?Q?edT61Ns8COcNukTnztBNWjeqmZQMvw/dyD14QzhE34Z8XwkJNDW37pkT0TN1?=
 =?us-ascii?Q?AbtctDyxgFm+TpnVEkeZAmckSRgUVabCH01m31ILpE4xBG1hCNXdewjP6ISl?=
 =?us-ascii?Q?3XIOFjUela6NkwejhDHWCpNMNywuKB4po2Ihgp6nenO2Cpxh7ohCmAUWyvRv?=
 =?us-ascii?Q?gsB93scgwrREN5kDjC7RjcgTmv1jk68Ebda7FHGA/SVz4dsPT5A7Wl5IeKyd?=
 =?us-ascii?Q?L+ybFvQS0JNUgirAX6FPh7LmDC9BPCuScU0Z6F3GbZvnKsMnaWNba9HVQ+x9?=
 =?us-ascii?Q?d8GvBw0eGSw7mheaJ5svWFCswnGVodRET2LukSecTXQpYduXljB5/KWhiNun?=
 =?us-ascii?Q?OfeWi8osYE46LKOp7zeEooOlb0UFZJeV0+uYRlGqbqtGAwl7xpVIDh+emwVb?=
 =?us-ascii?Q?GzjFh6pKuNhD4ZQHLSc88vJ+Ro96xZ2/SbfWPG4Bvw82PmLHYhmUZlH7wpNT?=
 =?us-ascii?Q?jVSkrL0InlXeoFVrVGPq7MkTuk519yl49IjEmLwzj9cJT8s5aCLA13IdE04G?=
 =?us-ascii?Q?HUWl0BCREqGTUybu8AuCODBVAvMbh9rLaZak/3ahHspdIBgYAMpolTDnHCsV?=
 =?us-ascii?Q?UxRYKXXrk2lS6XK0pCocsHqhP1PoqnEw+JsQXMDFLeU7c7cUmliEPHy40EtG?=
 =?us-ascii?Q?ZB/M+aXilFiM8x1KHR2tgG7KCdoG48BpC16QgKQaQxlkt9zEdcLOwWZJnTJ+?=
 =?us-ascii?Q?LXcee4vAsqp1iF9ElBZATR2LlLTTSHTDf6NXxcPSJOxlO1I3uzBvi28IqoZF?=
 =?us-ascii?Q?eBQY05wFNiX6t2RsKZwUCtSgl9XJt5RxeJaNl/iwHyrKpdiCYbc0WUX3AcwN?=
 =?us-ascii?Q?4Szoj69j2zPpKcwtJ57nL0zsXBunucfWqn2s0XWkMM5VBE/4wXbjVmyBGWGw?=
 =?us-ascii?Q?kovmlH6Xhl6ZhQgVn/XvS0607t3OkMb2fOSAgN0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce18cd4-ccee-499d-d03a-08dde0e1ba9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:37:06.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs1ErMQy38d8Tl9tMUO1GbV8jVAsOC5tFeWx9aihJuikn+CZ2LiU7zkLVqiWHh0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On Thu, Aug 21, 2025 at 08:22:06AM -0700, Nicolin Chen wrote:
> I should have pasted the full piece:
> drivers/gpu/drm/tegra/drm.c-960-	/*
> drivers/gpu/drm/tegra/drm.c:961:	 * If the host1x client is already attached to an IOMMU domain that is
> drivers/gpu/drm/tegra/drm.c-962-	 * not the shared IOMMU domain, don't try to attach it to a different
> drivers/gpu/drm/tegra/drm.c-963-	 * domain. This allows using the IOMMU-backed DMA API.
> drivers/gpu/drm/tegra/drm.c-964-	 */
> drivers/gpu/drm/tegra/drm.c-965-	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
> drivers/gpu/drm/tegra/drm.c-966-	    domain != tegra->domain)
> 
> So, the check is two-fold:
> 1) is attached
> 2) is the shared IOMMU domain (tegra->domain?)

Yea

 iommu_is_domain_currently_attached(dev, tegra->domain)

> Overall, I feel this would be a big project yet arguably for a low
> reward..

Indeed, we can drop a FIXME comment there and leave it as the last
user or something perhaps

Jason


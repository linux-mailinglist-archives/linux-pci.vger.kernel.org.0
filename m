Return-Path: <linux-pci+bounces-41272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40703C5F34C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DC23B862F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547D345722;
	Fri, 14 Nov 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oMDOpPAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC92561AE;
	Fri, 14 Nov 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151366; cv=fail; b=jAwSBZX7i/6+pbNNyFsz6+fdfl+uLyGD9ZVAKgTN+6C9YjRvYelKIInAvS6+i2hzkQhY+DgN2Xt1urEPB1nzkMyiCFJ8H84wub0T/2/6dFKEr1NOKqGMUsLYZOEzx9M34v5ZJGkqiAe1SAjdfuEC+NWH3NSeE6pNJuCVSX92cHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151366; c=relaxed/simple;
	bh=SiuJvX1+D9iAuNHt15paz0lcVszbaouB8hJhmkBKQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtrspewczvBkwFaBfMO2rvJZLI0GIbk5k8YQlI5MSqY+VkDJYA0zD+pu4RLhC6TPQw7zeDlO8juPeXvD66w/HG1fK+YuLrKyHXU4/EW0kEJYzgQKY/62f5qv6oKlTLcOsODHrhg80XMB538HYKvFnnspU4VfUgArVfWtFNCNrk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oMDOpPAq; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnqLfX5IPRyhNnZhDBffXkN1bwUhXYnLewskVt4UVXcSVX+t/TLCnWTGlOdyd4ZjJ2rtx69j/1BA9S8ph6xkeKq+ji8uBnguBn1duWUDeQ3wtVrGAimU4aE2CvoJQt46X38YHIfhEgRYK2v1PSfRUwVS9afm45nr0vKtbnhGjVv/nZbV/INQioaEtIpkd8er3x4rJ7QJ77Srx19xjnwOO/IlY1Z3uTujqi4QuUsIsdgP9g4iK1TrgdVKSmSBqrsayr2sMP9otkbazX3Jxuvkc2SbLqVl8xgf+Yt1IdlrLldKURULsc2xZ9vtDTFol25yJV1M37PdtKIVkmDHhGPgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE4MSPjjMGMn3mIRc7ZCq2+/lv5G/flAGJmknJ2S1E4=;
 b=kVupjfYtkJrydZECfSMret4ymRUONrsJBRdRqNcBREAokmHrZWj1GQYcXi+Kzr259vNTP/4VzGJdCdJ9sV6wZuOWrQPm7EfOpjnx+T+Ze8May3t35BwFZaOBUvPSk496dIrmFN5dgWLPL8MKCpLaRBpR9M8vqKEkSEzUOSLejbqF3zs9OaZnil7xieRfuO0JFLVc90GTwAaYHHgyMYAnJ38B6eUh+vmUBaE93GKhl/1Ifhu+F4RE0yWPTdimsm86mbVeLT0nCqDu8w7+dyTth4dN2jVoqguChtvyCXVYiTdOJjDok5Ci/oSTLtdPsCeOiYbprsixzkBUtprKfQcYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE4MSPjjMGMn3mIRc7ZCq2+/lv5G/flAGJmknJ2S1E4=;
 b=oMDOpPAqufJ5kJqVIg5ZC36nH1jk9NuxT6nnhjTR926NYshkIAC1xpQZivfxAIQ9nkLF7Zu4FGpT2bOZBSGezyqgEZMAdsNbV0xb0IBKkJt+z1G34a7XmGPZJlp0ovzVGASn717FpHJzkLtF6u1Jf4nkd2vgXDtyA/sgqnbLcKVtoGcsOlkiCl3nsalMKUCpHQ1Jbt41RXtGkufxGK24WwwjcnNxBtaQ3yjWUXgDLiN794xMjoi+GMhAAJjLHyEhkCMnrOv+UqOFWIPOTeJyYBSemBfpfUREm8qim/foWbiOkDxmROChk5Iwbk+Te3+VAvCO3ajVthVXppA58XOtzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:15:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:15:58 +0000
Date: Fri, 14 Nov 2025 15:15:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Dhruva Gole <d-gole@ti.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/3] PM: runtime: Wrapper macros for
 ACQUIRE()/ACQUIRE_ERR()
Message-ID: <aReN+P5UZTnS1Tww@lizhi-Precision-Tower-5810>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
 <3400866.aeNJFYEL58@rafael.j.wysocki>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3400866.aeNJFYEL58@rafael.j.wysocki>
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ac6f6b-875a-453b-c20a-08de23ba9f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l3a/B/pmqnr2tXP5UZrHy+3smCcUTmXc4eM2oVtY866m5+k6nk5baLdQ6R6/?=
 =?us-ascii?Q?lt3Gwvrc1B0tDBSIdYj9reyA5DUjTYMbITU6AHomVYn2LwQmrHBxA8i5bGuB?=
 =?us-ascii?Q?c3M4/jo4CB/H7uJhRPcVkXy4UEHtDj4NhGWBBtvX6V/HRX5dgjGq0p9/tt5H?=
 =?us-ascii?Q?B/cuUa0qnOuwJgVAWDw7bO2H9bRFGkLV6CtIiAY0pNTHi7LhKpkdBMjmej5B?=
 =?us-ascii?Q?q1LGoJb67Rmc1VkQ1fPoeDj0Ii2s5dsN7ay1UcdKjbmQOpzafmLknVy4Yk4X?=
 =?us-ascii?Q?4rEQzyu7xi96usgluzaFhtp8W7QIGV6m5i5gsOD/KEdvCvCjU7Voqx5hX1F7?=
 =?us-ascii?Q?Nx0equQxX5xgcfMZVhX6cbfSSeNTxntFBB+YEfkzhNqHL81ieeoK8N0Jsapj?=
 =?us-ascii?Q?JoZboT3izuATuGFWlM2N1PNcaLgmT/Wrju35M390omOvPUeURyX5ssbc3XSo?=
 =?us-ascii?Q?OV3/ldQNh21LgaNqaxTBQ+5N3GFv/hAcQppuzGMrQaHDi/jACbYRZbMaGTnt?=
 =?us-ascii?Q?glI/V5dOA5L85nrQLCOkT97OXH9l7k8kn+9NDivbVXsyIsC0FyvcHQ/6J5zO?=
 =?us-ascii?Q?G92Qcb0i2zHs9bzkgk1lzW6hCZqrXzgomdTrGLSsqAalXUdQLsTLFVQZW1XW?=
 =?us-ascii?Q?UJMSJ4VqqGn/qc7P7rOXIX5eZoDtAjCovGFbqzRRjng+Kvza3Foo2JTb6LSZ?=
 =?us-ascii?Q?iw4x46Z4zcoXsAbMs9aebCNYULJoHG+zobuPBMz9MrunZym8wHmNfgu7kSEu?=
 =?us-ascii?Q?KfrPs7nt6ObdPQ5X1MNGdPMpULJOjhSAb7nG3a8We4DXLmRZnGCSywPjksg5?=
 =?us-ascii?Q?rq85tsHCOOuCKhkSz5o6oSzHBchheCa3TAT57CmCz+XVYkCLmCrkGhSeOa4P?=
 =?us-ascii?Q?97gCvtV4W1ahF8fv98WEF+y6waJxVqVWJFWu4Xvm0tcFCf07HwW2LKPv8ByF?=
 =?us-ascii?Q?+hR5+asEbd+YkJUBwTCDrrMuq/38O83wmUOuKO6psAh6Uu6vZVnGcQK2zzRd?=
 =?us-ascii?Q?DilscLZmt3QiI/63ZTTdzPgOmdtUDauCglW/RX3qDPPF6sZtOuDkDF+ciLCP?=
 =?us-ascii?Q?kYaDr6KacyB8/htuicJ5SFfaMKACNDyxDZMdm31Hu6vaFA3wzZ6eRZNhZkQd?=
 =?us-ascii?Q?D2Kvt2ofPJFe+gJDR8QWpU+UALxhac//0eaHVsbUEO5dE4IA/8P7SZE1zwxg?=
 =?us-ascii?Q?Shmt//kM9jYS1jcv5jfss6tUxt9q9P6Uvh4Cx9j7fzTAxjlyhu0XR4gC8Ee+?=
 =?us-ascii?Q?3E9jJjO3nz+0pll+rVFzI/fIYH+h11sSrc3hssT3fqRPZkY100KmJ5CFBcJK?=
 =?us-ascii?Q?d9vQf/oexa0xsI5P/RbmNC4IsTjCWebAWxIJh9krKvPrVOJsVhl4eO7rxSY4?=
 =?us-ascii?Q?ZpB97ioyP+KGzKL5m5M3Um1QecaDVgz9RH0m+6JoP1mlENojLxbBio8NFdfo?=
 =?us-ascii?Q?Uu7Vb6l18kqi+t7y6C+gYQc1PvLx7oLsDncsidUOHpvl7VPtX14pWRtZR0pS?=
 =?us-ascii?Q?MSfwnnjfXv8MazrW3fp5bgg0uQFhpOqZFziP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYt+UwSAdnhMiabObyJLpHiJXBEzFdb2fIl01Dw1W0RueGFk7gOVfCM2oiit?=
 =?us-ascii?Q?ffTcQ+nvf6tkRgoOWr6O5Fk8fpsxlHEgjDJM0vMQsTCbeNHnpub1GY8c9pTc?=
 =?us-ascii?Q?uwm0qbjsni1nb73d5LYLeq5mFe8bznkjylPfzPtpo9hSHjUOjH1DoPamvMX3?=
 =?us-ascii?Q?Y0wqr5y0NFvf0tXjtVSaqd8c52Xop/Eb3iuOsONm9/xiBrQZKxRjVLD5jCJz?=
 =?us-ascii?Q?72itcfsBKuC9xTUNZi9E+lI6sc/045Py77yU2BdVWQnbiGbu+JOUoKHACExC?=
 =?us-ascii?Q?v12GtDSohPzqsyi1NSRMA+i/NCqFElQVFHc2T6+X76l1Mko/AAgF+WzL732i?=
 =?us-ascii?Q?QivUQtd/JUN/xuFPf1OaGsVVKwfWf5oLLGBU7cjPBMayYDJW7SJ+CxXX5obu?=
 =?us-ascii?Q?2OwlDC8StFafAYPvuhVB1Age050nhffw1h/724PdYSQXNeC10E357QK19EEQ?=
 =?us-ascii?Q?Gz2Pu3Q7e8Z+jJOCppGQAUZ7BunATM9vC8n8W06+1NlF5SUzGK1CBy+GwdJC?=
 =?us-ascii?Q?TZqrBpvX7C48/5YZzvACBemattRg/3zTE+iW9+ZhQboKnv3qRPxFx5ct76ZQ?=
 =?us-ascii?Q?0Yx/UI5Z74bP4YxnpKPgeWDlLOMh8TSvvIUZRb758wQJW8sztzHmMmUhY3UT?=
 =?us-ascii?Q?IGyWom1gYahzjbFR4XmHRL7xMZdM9okMtl9OCGYxWdpiUqjWUIfjpwUqLyl/?=
 =?us-ascii?Q?4u+6j9S6vzl61MNqmoLuTOXzYpAnpJLloCBaLsng2yvcZlT1DLv0O/vaYit5?=
 =?us-ascii?Q?5Lgkjv04RtSWCxX63gl6vzj5rLdArdHHKQ7nCj9CoTuppbpfGm5S76rdKhbd?=
 =?us-ascii?Q?xtmc94Y3tN/phNmDlmKIOTIhdpxEGj+uOkWW2+HmcP++lQby3/X0jJ9crV/A?=
 =?us-ascii?Q?bA1djLb1tYKoS6iBprI+5ZT72kUVOSew6hLofzx4ni9Drkk3eVyMIRaFulxH?=
 =?us-ascii?Q?lOtmMZN8L4uo5ZDNvWBYjzglMOwsRlMjwBiXjXdYZTcTRqQiFOK9Za2VHlP5?=
 =?us-ascii?Q?UWEy1J5urSxfsZmyVgPrTaTin7/dkuzbICR4WeHomnkYEGX8eyu2XVWdpswd?=
 =?us-ascii?Q?SYggoMONT3071Lb903xAbOb4yqxsNrJq9pTiYaprBOt4gWYQJKT4ENJHKzaP?=
 =?us-ascii?Q?Ga0SIAPxyCQEYtOjik+Ns/DtwZDCSJyNBSoT0l1I9a7U9vFDwifG+eFCuEpc?=
 =?us-ascii?Q?z3tVR3SNcAfoid4yN5FtJ/h1yCj15KaqdPrtrIHY/NpTTVPNS/+Dl8ijCVBw?=
 =?us-ascii?Q?oGro6uluOyeCWCJO/k1WXff2eOy1eWN95T2ctvfFUqlT4ob/bczZCjhdNQkd?=
 =?us-ascii?Q?6lpvDeqZO7dMrZSb4xnSkas9nefUfaOQI1AEfTgCgSO1ZlB+33CqMKxUUODa?=
 =?us-ascii?Q?Pd25I+j8mdBHltE7yd3QL/9N+eGZlV11cdsQn0h9UtzjzsV+k8JLMoXc/J63?=
 =?us-ascii?Q?KOVGFEIqBvchUmbUnWoyJ8iLbh2lOuEdUL5ebhfYFfaOqRdVdi72DPPBp9Aj?=
 =?us-ascii?Q?9l3BLelYxZ2XHOVR4UhAAKycNEuG0KRF+6XednqeCq95La5lkziVhJLCZyhR?=
 =?us-ascii?Q?MxmxxRonuwrFrj0ApsGoqMtqVVk0oQs8fnOckFsS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ac6f6b-875a-453b-c20a-08de23ba9f76
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:15:58.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlwMIq6kx8Gi59qKs0ay/YpIRigWQSRh8hzTBZd+9CcR8Dg/+zFInvAjoHmOw5+aw/DLeTAXGyvU9FZYCKGVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

On Thu, Nov 13, 2025 at 08:33:33PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
> usage counter guards introduced recently: pm_runtime_active_try,
> pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
> pm_runtime_active_auto_try_enabled.
>
> The new macros should be more straightforward to use.
>
> For example, they can be used for rewriting a piece of code like below:
>
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
>                 return ret;
>
> in the following way:
>
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
>                 return ret;
>
> If the original code does not care about the specific error code
> returned when attepmting to resume the device:
>
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
>                 return -ENXIO;
>
> it may be changed like this:
>
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>                 return -ENXIO;
>
> Link: https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>
> v1 -> v2:
>    * The new macros take the guard variable name as a parameter.
>    * The new ERR macro takes a guard variable pointer as a parameter (Dan).
>    * Added underscore prefix to the macro parameter names.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
>  include/linux/pm_runtime.h |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -637,6 +637,30 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>  		  pm_runtime_resume_and_get(_T), _RET == 0)
>
> +/* ACQUIRE() wrapper macros for the guards defined above. */
> +
> +#define PM_RUNTIME_ACQUIRE(_dev, _var)			\
> +	ACQUIRE(pm_runtime_active_try, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_auto_try, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_IF_ENABLED(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_try_enabled, _var)(_dev)
> +
> +#define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
> +	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
> +
> +/*
> + * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
> + *
> + * Always check PM_RUNTIME_ACQUIRE_ERR() after using one of the
> + * PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be used with
> + * any of them) and if it is nonzero, avoid accessing the given device.
> + */
> +#define PM_RUNTIME_ACQUIRE_ERR(_var_ptr)	\
> +	ACQUIRE_ERR(pm_runtime_active, _var_ptr)
> +
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>   * @dev: Target device.
>
>
>


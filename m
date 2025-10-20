Return-Path: <linux-pci+bounces-38716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF4BEFAA6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97703189C490
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029A2DA779;
	Mon, 20 Oct 2025 07:27:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023137.outbound.protection.outlook.com [40.107.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8F2D7DC1;
	Mon, 20 Oct 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945262; cv=fail; b=nrI3rVrurGRx80uNPAhJaKCRtkCAve/NjphWt7SPVxpz+T3sIfwrEnEBYb8WjzRl/dIW4mFNz8LdCbpGuHuwrttq4iCVbd6ZdgfEERUKTzHO8QQfauxol/01+AZz7YQeXObFC6emZDoXc02gR/n4M9dyHLzbG9jToRzKATkMVz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945262; c=relaxed/simple;
	bh=1Rj6bFTlIvROltuYVn1+49aym1NtOTJ8y9OuiDMNiA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkZyd+a9DF4KftecIoQRZwWZsi9cUJnHLA4g2IyEn4JvQ0WcNW4daClq+A0eqAn+AKi+HgA3Mjh6nC21R6kfXGlqTtZ5If4vlrvl5ONkSM1jsbCwGKLLWLldOCTRnfYQ2TK4mPhq0SBl4orXVwysre7sUmSqPPq6L9xgPA7vcqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmUfXcFU84GdJ+RV37r/QL8WebzxRl5cWUvjC8RtjNAbxx23g9E1yjyEtpHp7TVyyOlNdzV5ysZDRltFcIkWRG4ios/OwcMmn8+SBWCn+QY9+qxzQc+ij/y3S42kcE7EmaeCd74baKlsgnd4e0lTDhQh/JEI6zpWKiQRUsakAsVNzsB1+qYyFI5e1ZMSasFTa1myA4kKlNmq2Or0sU0k7EaqwUd5OmL9FaKjFjVJ13s2KLyLFRuekPGbs8OeaHFwMwvguG0vePq23/RsFwY7GO/dgBRAtF4MfYvPEuS6x5gWyIttUz3QgxKCclWSo344A2bWPQGLrFCUS1rkD7wzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I5rXfH4WmNa3kjZzZRqtq+P3MAtbpuPTavj4eEawww=;
 b=GKRJyKPM9BvxodPkdVgYSIlwU70bM7Y/aCOV1GNaiyiJF0BNp7CcxzlSp/IRCaWxxVQam71E/OQICe2SWHn4PAEC5aAyT/IsDXPAfBvfWZXVVjc3k2pse92XVBOiDWOQtSrsW0qgUQ2HCKnnX4EThnsiMFpimYn7D0feej6cLM+QY0dDhB9wPdFMQgiaCzLZsNN1P+8HQXTn7vrM0oJaZ3JTYyigXngOVFCPBW6e4WH+DVGiqYBFr7sgKqSI/vYcDZXXjqplsjYRTRNdSALJkqJYORDQ31WHymuNF6w8IunHJAfiLKp+t1V7F2xfvGo3DwzzW7HcEBXeaEYEXIliLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20) by
 SEZPR06MB6423.apcprd06.prod.outlook.com (2603:1096:101:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Mon, 20 Oct
 2025 07:27:35 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:1:cafe::ac) by SG2PR06CA0188.outlook.office365.com
 (2603:1096:4:1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 07:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 07:27:33 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E9F8941C0146;
	Mon, 20 Oct 2025 15:27:32 +0800 (CST)
Message-ID: <293858b1-db91-4525-b8b3-c98c7837ec73@cixtech.com>
Date: Mon, 20 Oct 2025 15:27:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
To: kernel test robot <lkp@intel.com>, bhelgaas@google.com,
 helgaas@kernel.org, lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020042857.706786-5-hans.zhang@cixtech.com>
 <202510201553.x7S0SaZ1-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <202510201553.x7S0SaZ1-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEZPR06MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: a58eaa9b-9e40-4d3e-b43f-08de0faa22ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVnRWFMUHMxeDlvNzk3cHFKMUgrdmxpREEzeUF6eWdqbWVuR2FBRzUzbmVF?=
 =?utf-8?B?SllzSE4yVG93Uy9jZ0ZDRWdjRW5pU2p5c1psbzQ0elh3NTg2Mnoyc3djM2VT?=
 =?utf-8?B?ZFJtZEUwY3dtc2paSVBId3VYSUU0NENyaGF5VmlSdnVXQTlZTXBJWS9mRXFi?=
 =?utf-8?B?OVQySjFpblB3TS9ETVJUbWVJNVFpczk2MHNPVEdhQ2ZvcEFvcnJ6N2JDaFp0?=
 =?utf-8?B?NDRyTkx6N0NMWjF2WnlmYVF5NVdLblN2d1hCVDlSVTNaRUFJZ09mSEZoWHlI?=
 =?utf-8?B?NDZ6RXFSdkJDdWZldXd4eGpMZVhndzJ2ZUlta2tLdHcvSnBicmd0SjJCZS9V?=
 =?utf-8?B?WFRHVVF0NWJPNUJTcWttVkRxUHUzaHg0RlFhUGs5ZFlIcThSU1h0SFBXaFFX?=
 =?utf-8?B?U0pJR3g2cWFuV213UnhHTk1BN2tYV2tqRitqKzZvcmpqVW45M251TFdLNWo0?=
 =?utf-8?B?S1BqbkpYOHBoOGlRM0NybVhjc1o2aHVhemxsYUdDYk1qSUNTbjJRZEZpakMz?=
 =?utf-8?B?Y1plRGtML0ZaY2FrS3JLNzVqUE0wYlJ4ckFneEkrdmdITjRERkp0RGVvaG5p?=
 =?utf-8?B?MU8zWmlGRlBOdFpLL3BabFgrQzFFaDI4QzJHZFhmaGp5SGE3YURMNzVVZVBj?=
 =?utf-8?B?VVdDUUcvNjMyTlhwNE9WTTFiR1F4RHlNMGFpcXQvV0hPVHlsY05uOW9pa3pR?=
 =?utf-8?B?R0xKRzViWG1aK3RhdzNId1hKNllLNWE3SEgyS2pWS1ZON09xeitBZHZOZ0pk?=
 =?utf-8?B?Y3UyMnNkNjZ2QzlwTVJUY01tR25PVkg3TzllRWlCSld6eFNPV0tsMUlDZXVL?=
 =?utf-8?B?VW9pbXVNVW1nRnFyZ1RtK2JQRXNIU3NlckxTamoxUmN4Q21uaDd4eFQrZC9L?=
 =?utf-8?B?VFFhbENuYjhhT014c0l2NjJLcU90ZURNWEhqUTQ3OHlwK290Q004SzhKMENH?=
 =?utf-8?B?ZnI1WC8vVmVCVFZuNUZkRVVGTlBWMEFvUExpY2o2WVNNSmIwUml4VnNlYjc3?=
 =?utf-8?B?Y2tLcWZ4bjUzUjZON3p1bmFNZkdXVzNOMlJtUWVHdzM0TnVCUmxrdDVHMElz?=
 =?utf-8?B?T3FUS1dEVzNPNDlvQ1kybHgwNWs2VFpENkRDMXJCY2VxcXZPVG9SaFh2bXly?=
 =?utf-8?B?R3RESzVGUlZGckM0ekdPODdqN3NvL3RlRkUzVVZSakZHU0xmNGRrVjd0c050?=
 =?utf-8?B?U3NnaGFPVndjd3JWRkVmUmpwbVdqbjlIblZYQitBTjQ5L0QrcE5ndWRZY2ZC?=
 =?utf-8?B?bDlTU3QrcHVoOVdxb3ZTUzN2Z0hNMjZQdFhkWG8vaFh3R2pGOGFuMnJsZkpJ?=
 =?utf-8?B?OVZzYkVLVGs4MWtEQmN3V29KUzdtMVBNdjV3WVBWZllmQUVSV2h5c0kxQXB0?=
 =?utf-8?B?MTk0N3pSNWRYdjBHR2pWQWp3czlHVWtxZExSanlWa3FIaW41dExxZWh5a0NT?=
 =?utf-8?B?bUlGY1JKWnl0VDR5SUVHSlloWndwWnpNb1hqdW9kOW5TUmx5UHlPTW1VVU1T?=
 =?utf-8?B?UmJwMUVvSTZaS0szc1Y3cXd5dnlTV1g0bWE4bnl5WDM3UFBRcW9FSDhiVGRk?=
 =?utf-8?B?OTZOUlU2aEFkM2dNR2NxMy9JeW9RT1p4YmxkbDIycDF0cVZGUllxdHVBUVQz?=
 =?utf-8?B?NmVmQkVGU1BubnZHbndoRFNvLzZRWmJMakV0cmdDMDlFdEpFV1psRjZKTWlK?=
 =?utf-8?B?aEh1ZDBvRy9wU1FzaFVEUHFZM2oySys5eXZZTDA1ZWNzYWJtRGxnb0FCN3Vz?=
 =?utf-8?B?Y2FxV0d6M0F5dEhwdDhTQUN4TTByZEUyR0dKWkdPNWovbVpITXZENnJGdFc5?=
 =?utf-8?B?R2xJMGkzR2NrV0RTa1dhdFlRQVh0aU42aXYvZG9TSnRic2lzcjd5UEorcndj?=
 =?utf-8?B?VlUxeE1wSlowZ1FZdEtaUTNuam5UVEdJdUhhbkd1eWgxRk5kR1p2NjZFd2xJ?=
 =?utf-8?B?YnAvU0dnZ0V0RHVUSGZoUnBYU3VQTEQ1aDFIVGpOcHRqcS9oYTVtY3VDclVV?=
 =?utf-8?B?ZG5FUzV4SkpqWktRYm1kM1hOeFZxaWpSenZOSmY0WFRQOXVSeTlmR0FadmZ4?=
 =?utf-8?B?SzMvMGViOHhTdkQ0WlhqUHY0RFR4N1o5ZlBudldhM3F4RzVjQVAySjR1SWQ4?=
 =?utf-8?Q?PUHXUFI4qRC6QjFu8XI8aBm1Z?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:27:33.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58eaa9b-9e40-4d3e-b43f-08de0faa22ff
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6423



On 10/20/2025 3:19 PM, kernel test robot wrote:
> EXTERNAL EMAIL
> 
> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 211ddde0823f1442e4ad052a2f30f050145ccada]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Add-module-support-for-platform-controller-driver/20251020-123246
> base:   211ddde0823f1442e4ad052a2f30f050145ccada
> patch link:    https://lore.kernel.org/r/20251020042857.706786-5-hans.zhang%40cixtech.com
> patch subject: [PATCH v10 04/10] PCI: cadence: Add support for High Perf Architecture (HPA) controller
> config: i386-buildonly-randconfig-002-20251020 (https://download.01.org/0day-ci/archive/20251020/202510201553.x7S0SaZ1-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251020/202510201553.x7S0SaZ1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510201553.x7S0SaZ1-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:96:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>        96 |         if (rc->quirk_retrain_flag)
>           |             ^~~~~~~~~~~~~~~~~~~~~~
>     drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:98:9: note: uninitialized use occurs here
>        98 |         return ret;
>           |                ^~~
>     drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:96:2: note: remove the 'if' if its condition is always true
>        96 |         if (rc->quirk_retrain_flag)
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>        97 |                 ret = cdns_pcie_retrain(pcie);
>     drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:84:18: note: initialize the variable 'ret' to silence this warning
>        84 |         int retries, ret;
>           |                         ^
>           |                          = 0
>     1 warning generated.
> 

Hi,

Manikandan is on vacation. I'll wait for some review comments on this 
series of patches first and then send the next version, which will fix 
this issue.

int retries, ret = 0;

Best regards,
Hans

> 
> vim +96 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> 
>      79
>      80  static int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
>      81  {
>      82          struct device *dev = pcie->dev;
>      83          struct cdns_pcie_rc *rc;
>      84          int retries, ret;
>      85
>      86          rc = container_of(pcie, struct cdns_pcie_rc, pcie);
>      87
>      88          /* Check if the link is up or not */
>      89          for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>      90                  if (cdns_pcie_hpa_link_up(pcie)) {
>      91                          dev_info(dev, "Link up\n");
>      92                          return 0;
>      93                  }
>      94                  usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>      95          }
>    > 96          if (rc->quirk_retrain_flag)
>      97                  ret = cdns_pcie_retrain(pcie);
>      98          return ret;
>      99  }
>     100
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5424D6887
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiCKSjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiCKSja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 13:39:30 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F43766B;
        Fri, 11 Mar 2022 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647023906; x=1678559906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4KMmcZq9iYcm7zU+PV1ghcFmoDOgXCkCmuwpZ208LLQ=;
  b=WH+htBUCAb+nOS8iGeBJEgJ9AZrkxYh1Z/aDTTEQfQeQ2UHRoCK+C9u4
   7qbGUZD6KLr5SafOXRoa7Hxeuh8T8nH6Lfgxagalr6dIBwuSmBTf6QXv/
   UfBLP2O4v2TXI3hUc6l0SlvDcyzVXpvZxdF5sM4dlWnonlcm4ggC5+1Qu
   WuMbTtqf9tvOow88EBY/kaiOHKXVLNTQT5X14xsdybIX674Woh5FfHt/8
   e4NcWNGQjU38Rc7EXKpoGTcGSjS0cmb67+uU74vs0N6HrJk3FfQabA61p
   tvfibQQJg5jiizjwCCgiINoE0pyKiBHckmiXTJ5iIsGFc3OHcXe/pYx0d
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="316352189"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="316352189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 10:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="689146712"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2022 10:38:25 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 10:38:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 10:38:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 10:38:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTnTF1luehlYfJkhirjdCDF6oZ0CAmakw+bHziYRgke452KgY3tEnoWEkbVYqAiUkCWssyY2yiwdBxGlFgsldhNCsWbN7Nomv7RZcNAXtNUxHTDhDyKPytx0YgzTepkzJSxelqlbcE9gXkvsH51UHR/cI64i0e43k7JccT03itVbTmoVI4lD9pwyvsHaidie5DvDYdUkPgF5nWzS//7N7qUBwLTfKi7QtB+UlIfoA1UJ8ZajA3fMBCPqSi7BpfVnHSp1LaVN/nStEOYy/SD5Ummu2QoOFbH9VB69RN01CUHxP3TQncxCwD1VgD4dELag+eSumTV4+Yq7cKq2uezkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DkNFdnd3TaJpqBDJKs6LfeFPcTHhYitNB0dRz582/g=;
 b=J4z7fFtw56ncychazaT1pB2R1GRVB7ZTKRTnXA+PwKbYzhx2AhGJ2+eB8of13OqtOA+fGUmkKWy6xB+ixCbjsonm7jYDr/za91hk9nCGgJRubqUGjI2i1IH8kcvgLYghw8MCjtTpNLWJOwEH2wkduAg8OeDcO8B9PFsYt/5LIqTzk73xv3w1JdLxtiUeIjWW2vwHH5xa9ztUJY1VRG/5VQteMWVdSLBY40sf6BmUTM39yDUYnNR5hvP6KGau7PvFGoAY6/ksQBrV/2Hjbqzp4Xf2Spuob9aaPFcG+PxxcFq0klH9TPi4qsug10y0//v4BNAGT79tM/A+JBp4EbK98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 18:38:23 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 18:38:23 +0000
Message-ID: <7d5de631-3ebc-01ee-69b8-ae105408cb59@intel.com>
Date:   Fri, 11 Mar 2022 19:38:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220224202937.2414867-1-rajvi.jingar@intel.com>
 <20220224202937.2414867-2-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220224202937.2414867-2-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 576b9929-96a7-4b05-49cb-08da038e5250
X-MS-TrafficTypeDiagnostic: SA2PR11MB5034:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB5034102E883EEC496C9198ECCB0C9@SA2PR11MB5034.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkHa/EODCHjbs7Rb4k990dnq509cKisDT8Bdjyb5YWNnh9R6q1gF5wyZ/S/JqVZqzFLZpLwydcYdxz+PjRc671goISM5Och18FHzDhLx5h8j7mFIIpbz3vXE7yqFid2svQKCI22MgqoTVPYQ4qvSc7m1CydqhGzGX1zk25fug74cVOyjZGt0YBSkZC8PaLIa5UCFT7VZMOObe7heLt3rK0g1Ws8TN06dRZsJoUI+LWIZitk0vROKSdVVBglSDHKBQx/vIs49/TwLQ4Nfpk/Ra99ZybW7Y5j3A3CIY6TpELBMVTf4dkcXq2V8ehMZPR/0/8KWwcDEKpudhidcvYaETa8UDW4ljETyfwY6C00Y/sigavqhP6UFeQ2TQzyeR6hFBXWlrT2zGg/uuzhloMIbHi7UagqAsaIdAVjsbGbB1LxF1leTpsOnnpNdOnYJoTUpkKrmUUMZKPr2C1pjNrrHXwLxoMDaORLbt6GKtUiJPu0FGXHtJRLMVajrlleH0E59+1Pk3Y9sCt9GsCNtymDQUr4MBrU1goFlbmQXnOWa4ZWhb4h1PaEykxVRmLTHMmulHHXYJu49Dtwnws9YteozkyKZZkcedoXgucivtCPUAFYfgsRGPX7OSpTjQiquSPTcnvLjsDUNeQsw/XdwtX4tftjVXIdWRXIEymOJk71XNuIVKZkpibcfK3B9oWV3y+Xsj4wliDLZEJUp59n726Mu0zYl2PQ9c3ArC0a6J+9CVto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(82960400001)(31686004)(6666004)(53546011)(186003)(36916002)(8676002)(66556008)(86362001)(2616005)(36756003)(6506007)(5660300002)(83380400001)(26005)(4326008)(508600001)(316002)(2906002)(8936002)(6486002)(6512007)(66476007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllqUThYS2hpTmE4TGlTZE5IVTc2NmQzM1dCeFQ0WHVlMGk3eXdJL0hJSVlC?=
 =?utf-8?B?K2VjRjF1d3VvRFJjZWRiWVo1bnV3endBMm9TZDRNYVlKMXVqdTE5anJ2Mm9P?=
 =?utf-8?B?T00yN3NOQit6NVJNOXRHbWpsVW4ySHc3T0NlekRiMTJCUGZOeGgzb3J1R2g1?=
 =?utf-8?B?RWdOeGN5RjRhd0NVcndvOEM1eUNWY3JRMGRibThQdGNaSUFlRTRBTE1yWk1O?=
 =?utf-8?B?d21nZ3k5aklmMWVqdnpjQ0xRMjIrMGZsNmd4dnJrdFAxNXM3Njhwb1dPMnZ0?=
 =?utf-8?B?QWcxUUloSXlGQXhZTnFxaDNCT29ZK2RsOWJ0ZE1lYTFUME5DNGpCTFFJUktn?=
 =?utf-8?B?Q3A0UUhneTZMNjlGSjNGWHNVSVluZTRQblF5eHBzUW5NMjc4NXVZbjg4S3g3?=
 =?utf-8?B?L2hiV1RITDUvQ3o2dUZhRkl4bFpjZlNORTFqdUo5WTNFd3JIQTVjVDRma2lX?=
 =?utf-8?B?d21EOFFjR1h1aUhLRTl3Tyt1NnVLZkhPaXhrWitUOXBXYkhpRFhlR01WV2Ns?=
 =?utf-8?B?NmRobHBya0pONTV2N0huSWdRNTJrQmJidGM5dUo1OXNlaXpvdUVoekNXK0Zj?=
 =?utf-8?B?THBtYXRqTVFWdkVWQWpQNks2UGdUY09FY2hINCs0QllTM2NpRXVKS09vRFFi?=
 =?utf-8?B?ZHBxamFObjBrSnVOTzB4NFZUUC9QQ2FUZHpwdkxCMVJaMFNRdGFuRlpSMFd3?=
 =?utf-8?B?OGlReFVrU1MwZmpGM3praTJlTkE5VWZlYVlsQUQzaitxRzdCL05NajFMSzVT?=
 =?utf-8?B?RlhwWXBNTXV4eGV0aHM2eVBYL1psTFoyQzh4Z2M3RTZPdmdLeCt3cTBHblBE?=
 =?utf-8?B?bjhteldyMlBMUXFqYW5yeUFoL2Z6OE9BTWhuRVZLMVQ4dzFmL2hnTVRWYS9G?=
 =?utf-8?B?TUdYeUZyNUJLZHU4ekg5ZUduK0IwWGpOTHpneENuYURKMTR0b0FlQlNmNjZs?=
 =?utf-8?B?UUxnODFTTnFheEsrMGRhZ3Zoa3VjMEJCTDhkWHVpMlQ5QU5mT1NHUnBWM01m?=
 =?utf-8?B?Ync1c1NUVWx4ekcyckhHRHpxcGk5RWNYY0RJbTlYU2Q4SFF3bjJLUFNpTTlD?=
 =?utf-8?B?NG95ZUNsT0tJZWd0U0gxTXhqK1c3NGgzZ1A0K2JvOWRKNmhjRW1XREZyNWN3?=
 =?utf-8?B?NlpmMUJENmxVTkxDZDhlVHpIaUMwWlpONkgreUE4NStaUEcrUFFhOWxmMVF3?=
 =?utf-8?B?OWxJK2Z2TzZyNFRSWTNPeWdLcHBOQlhpaDBVS1dWd2lHbzRSMGJ2ZjNrK3NT?=
 =?utf-8?B?OTk3cW9HMmJ5d0VpK3ZVbkJEUUhFVVpMMHlnd0owYjd4OVdCeEhWRGRYaHlm?=
 =?utf-8?B?M21IdFFvMGtndlZEOE9Ca3graTNPMGhZclYxVGJhMU9XUmVrVmxNSFhGYUpq?=
 =?utf-8?B?L2EwMHpucjcwZ0cvZVA0RVFzN1VTYk9WOVBQMWlLS1FaU2ZmWHpCZnMxczBG?=
 =?utf-8?B?eWdYWXpsOGViUWlBYzg4dEtKQkc1QUVhTUt4YXZMOUEzOWZ6d0hRSTM5R01N?=
 =?utf-8?B?dU1qbUJtVU9TSlRWWUJLQklJdk9PWi9WbDdVQjZYc2lIRFRtNnVPdEZma3F5?=
 =?utf-8?B?ZjVsWC94Zzh0TmdNdGlJMFlHOFJ2ZVo0T1puRE5TZ3VhZ2h3NlpSdDZ1YjUr?=
 =?utf-8?B?azdIWjVpYm1raUt0ZU4xd3pMTnZNWVlDVVE0ci9vTUpxbnVoNnlRd1RPWU9B?=
 =?utf-8?B?ZlFkUnFMTCt4S0Z6YWJoMUNxT0NKd0JpY0JxVjFtSUVqRTJjeWpURVlGajAv?=
 =?utf-8?B?L3lGdVZ3UWNualNTTk16S0NnVmNjN1JoanJhNXlISlJmejlIZU1paUlPWkgv?=
 =?utf-8?B?cXRWK0tKb2VOblhTS3FoZTA4K092eExGcmxMQjQyYTZ1SWJ2VXdxL3FTeFhm?=
 =?utf-8?B?RGMxbU1Yb1N5c2V3eHRjOUt0Y2J5WERQeDVNbVZwcXFKbnkxemJMVnMvSVdE?=
 =?utf-8?B?OFpDWDhzYzhwaG9uamJuYU1yaER0SVppZk80dmg1MnZLdGV6Z3llZmlBMisx?=
 =?utf-8?B?OEZnUFBaeE1BPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b9929-96a7-4b05-49cb-08da038e5250
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:38:22.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQSmfMqRndh9U1a8xrPQWlSv5FqpGaBvex6Njv/jxa6TSSY7fgUwu85owM4AcdLhqaouhFO61HmOrGtGglBf3JIFJfJzOBS05fVfZFw6uyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/24/2022 9:29 PM, Rajvi Jingar wrote:
> For the PCIe devices (like nvme) that do not go into D3 state still need to
> disable PTM on PCIe root ports to allow the port to enter a lower-power PM
> state and the SoC to reach a lower-power idle state as a whole. Move the
> pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is not
> followed for devices that do not go into D3. This patch fixes the issue
> seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with Coffee
> Lake CPU platforms to get improved residency in low power idle states.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>

I would add a Fixes tag pointing to the commit that introduced 
pci_disable_ptm().

Otherwise I agree with this change:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/pci/pci-driver.c | 11 +++++++++++
>   drivers/pci/pci.c        | 10 ----------
>   2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index ac3f7e1676a9..8be3f81afdf6 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -836,6 +836,17 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +
> +		/*
> +		 * There are systems (for example, Intel mobile chips since Coffee
> +		 * Lake) where the power drawn while suspended can be significantly
> +		 * reduced by disabling PTM on PCIe root ports as this allows the
> +		 * port to enter a lower-power PM state and the SoC to reach a
> +		 * lower-power idle state as a whole.
> +		 */
> +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> +			pci_disable_ptm(pci_dev);
> +
>   		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>   			pci_prepare_to_sleep(pci_dev);
>   	}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..f8768672c064 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2660,16 +2660,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>   	if (target_state == PCI_POWER_ERROR)
>   		return -EIO;
>   
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>   	pci_enable_wake(dev, target_state, wakeup);
>   
>   	error = pci_set_power_state(dev, target_state);



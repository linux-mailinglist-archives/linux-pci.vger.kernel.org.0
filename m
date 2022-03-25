Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2404E7986
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359820AbiCYQ6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354491AbiCYQ6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 12:58:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469693CFE6;
        Fri, 25 Mar 2022 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648227404; x=1679763404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e+gazxV02hO4Y0QttnzzPG5b4go6J2+ijR2StZtIa5Q=;
  b=lD7oJz+cxE7Jqtql7+LwDeHotVR+S/8CTRijiIsRmNa3oqzUqUm4xUhs
   s9KSVPuzh/52zb5u6wTWup6hugVBzt8ONI8Y5J0EFQeSHLCLDMkFyvIV8
   0tdwLEBdP32ASp/dHMpMTW/NuoUlUgU4fRYFbb1oHR5xPX03ToKVNm0Ac
   HTu9bfUuFfdqh1n3ydeKvon7oKFjV6jD12kTN0U4muen7VHsgEj9U+fAK
   BgdtSLEhxBTTIYX1USEzX8bFDf/GsNeZDH78LqqIeI/oZmYxMXJqk0wF9
   52Xt16UTDaS9mqugsOihHrsQV9obKG9//uOwqC9VFtSjzEEG9E1QLXcRI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258864667"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258864667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 09:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="648321347"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 09:56:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 09:56:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 09:56:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 25 Mar 2022 09:56:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 25 Mar 2022 09:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElHgRwhP4STrAU7FYNZWcouihm8CgXddMeKbNEDXE/0U7IrRiUH2dYMNlxlE6PoUlat3ELDLMQvGKNdzMHSH3Wd9lUjw5coK0MYhgLaqfum+ge6GhW3W1v+ypm+CJKXSlRZwm+6dfEG7JX9iBVGzN5TeAuoYJNJFQAbhvY+tn8yjFXaym9N7ZgH27hHgBlz6ZUfa3FxwGHqAn2oBmS8afUupjxXfdEubOPMXufgF3uX2CzeJH5015NvezOZNlaxO0cD4k5QOk5b9QoOXNngcyBLiuhtxo8ABuot/gaG2/i0f4nDDG3ebcAGu0C0UmR0f3uJwwlsKY8UFc1Mp7VP93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AjwmJIHDcCRmD6Qlx6kTlcvEt2aftS6cfBn/25ch7c=;
 b=K5gPADiWJSSVrr4UFssnkMHSy11JXxBUDrWAInb786927ROHinAt02IZZHoxPT8hNu+e6mFERWAzDjcySQFDfWaVhg7FzweL38JBPZrZQpOzvolrSb+NC2i1Q+zXTPB/+iv4UKe1ZZEn1ouWN+bs2epJRkIDKz4MSQXP8XkVM/HIL64WltEMmJcUzGIO4DGYC7U41jLmFmDHIT27UIagwAP1rTRSCXv9Qj74FZow8+z3X8HYu3fxxKTRcB7I2/qH0NbRwORDhG6vzmrPHq3NMSyT4alLS/YSZNBMJQI6b4ocHdWydW43yMBxfG3rGwZUjZc2laXdttvzTMSaPKwZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB3337.namprd11.prod.outlook.com (2603:10b6:5:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Fri, 25 Mar 2022 16:56:26 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5081.022; Fri, 25 Mar 2022
 16:56:26 +0000
Message-ID: <16ba3681-a6fc-1359-2016-9d2199b6805a@intel.com>
Date:   Fri, 25 Mar 2022 17:56:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220318221932.3305691-1-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220318221932.3305691-1-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:203:51::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1b6227-24b3-4be0-53ac-08da0e80662f
X-MS-TrafficTypeDiagnostic: DM6PR11MB3337:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB33375EB06A8059A48375D9D9CB1A9@DM6PR11MB3337.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGRDDuziZ7jnBsXz0Vv77VKBiIER2RITiyLXY9Snw6Irkz1ltihshPJ6VgC/9lM6yPhgRsvQclrPhiI+CwjzreFe2Rv3g9kZEv35+4eH8SDXuxC5O2EP/jodNWGQUm4jgUqBgYoRkq2Ahkk1/gK91zo0WO3PxowWtbstUzKRN0EIuOWUJ+k73XfrkWm46bzCODznBHkLz+VZu29SfLW0CvIut9h6Xo6h4BkJ903U4et8gWL/JBXq6AbyTTpIImHqjA1tzKQMTzAUq+DK7zYQqb8sVizHF8QANSFwjy4O++1Y0S0VzqN6s8lqeZ2MbEMjHeBChU7mTCv9vN/6UxoWFyRkslEjURJcBqy4aGSRlYby413TbBoMsC0gYsWgyo3xHBmihFae7rmmTrQu6vkCgNgYjTTnoOD2ZvPWwL/OHz0BfkdEWZKfjVLjgjI3v8M7SSpj1d0FSTNnG3f3+fLK8mNIzE5B7tX77Cvw+ieu1i2O5Hxe+AwgrXWd5XiuVFk5L96cey+D1s9FWfbvnZ3uWkJadpRc4qRhnzxFYHNvHX4uW3jWLvPS7aJZoXXP9grqIKW49Iw243ivASWONi0IfZzHKDQ8GZAPdXTUV824mESfEiozvzTIajWjD87tPhKRtIWpG/aJ7aOFAS7nNRbjxPUExgKGtxBStUb2id5h1/YjkfDUSMr6MQZUTecw89myMCDVE3DVyN82alp4nyElsrpnLgKjzHwJA4jf7HoKims=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(6666004)(66946007)(8936002)(6486002)(6506007)(8676002)(66476007)(316002)(66556008)(31696002)(508600001)(83380400001)(82960400001)(36916002)(186003)(2616005)(38100700002)(4326008)(53546011)(2906002)(6512007)(36756003)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhGTmxvajRCMWgzU2VIaGs1Vmd0cWJ2UHp4MVNwK0lBM05tTVJHeUhKdTlk?=
 =?utf-8?B?ZXkrejl5YVNzMlQycHhVNUlyNHhCRXdMdVU3SW1rMmxjc284MDJ1QlBmc1pE?=
 =?utf-8?B?RjlLWHhXM1J3aU9ySXlqY1Z4NTRUWkNNcmZiMVJCSVZoVXVHNlBVeG8xVzRL?=
 =?utf-8?B?QTdKYnVUbmFSZmhycWVYL2ZPcXlId1NjMUJlQWI4Y01NbVAwTTgza1d3ZC8y?=
 =?utf-8?B?R0ZLZ0d3NUVoWHkzL01oT3hPalE0ZDd1TXVyM2o1Mm5Jb0U3YmxTamRCcUo5?=
 =?utf-8?B?K2ZtcXl5dVJJMG93Qno3d2NvcVR1Yk5DZll0SVV5ejRzVnRDb1k0aURBRlhm?=
 =?utf-8?B?T1JpWkpENUZldGJGOVd1ZGVKQkNKaVgzTnRSb0IwNmlOUmpha28wNGVXYXh3?=
 =?utf-8?B?STg5NFBVVVJieUU3Tll6S0oyL200Z1pFZ0J1MDJURTVvalQwRnJzb3hOU1F5?=
 =?utf-8?B?dGdicUhlelczS0ZiTU1EN0JEZGRjVzlReXBSQnZqNjdPTk5DVkZPbWNUSVFl?=
 =?utf-8?B?TkVPakt5SnhKUDFUUXdMV0ZySGt4ZEdVZ1FvVXR0aDJkd09ydEJ3WVI5N0tz?=
 =?utf-8?B?RTBaK2tTdUhWZHZMdXdiNXVvK1F4SnN4VVhlQVBaMWttZTVkSHRWUnA0Rnhm?=
 =?utf-8?B?MjZvNTlEK0lUZXZFSTIyeXpOWnhUMjhGRmZmaGEzcjJpYmJGaWJFMGlEV3NR?=
 =?utf-8?B?Nnd6SmFWNWlDa0RJZXNJM0NwZGtvNFZ4RW1ITW51b1NibEYzanpsdkhlKzBn?=
 =?utf-8?B?TmVnWURmZWk2NU80Um9DNXpMYTUxYlI4eU9STVJ3U0JSTXJyU3MrSlhsMURZ?=
 =?utf-8?B?MGxLVWlqVDRINit0NkxWdGJOZDJMQ3MvcURzM1c1c3NXa1pzK1lHcDFUbmI4?=
 =?utf-8?B?U0EzcWVZQjZsaEFBeXorbHhSSDRBbkJkRW9oelF4NlFETHpMaUMvQ0NldElz?=
 =?utf-8?B?TEFiRFlOeHFneGJGOTBoejdHWCtrY2ZCNFJrQnlzVWswMEVCZXdIL0JzY04y?=
 =?utf-8?B?MWpBU3VWTi93SGE2cXpNMHBGWGZrWmM3K00rb1QyNkQ1dlN3RStyVGRIMUZ6?=
 =?utf-8?B?aXA4eGtYcFh6UktLUDU3VEVJNkNnS2h5QVRNU2JSVTBWSjhhRnhyck9tNHo4?=
 =?utf-8?B?OWl4bWRuUFNUSGNNVWhaSVNqdmhmekFHcm42SU9tTzZqRFJ4ck81RkVlRUMz?=
 =?utf-8?B?cW0xbVhyUDZ3NHg2SW8wSDNBdCtPNGl2SUpsQzR3RWY3OXVFSHBjOWN2RmIv?=
 =?utf-8?B?OWk0SUUyR2paQ0FONW9UdzRQZ3IyaUlIdTY5bndibmx4U1NhTzVlTnZGbmgw?=
 =?utf-8?B?eCtMNi8xNVlZVXBTSEJkTVZiK2lmS0pYd1phYnBTdmFFRzVvY0RVRnJ1d2lw?=
 =?utf-8?B?c3Q3OGVWdGxYcjVqMzNHS09KTDVOYm5qamV2MUJlcFJSQzQ3WUhRRmw3TThv?=
 =?utf-8?B?US9MbjVFbTg5bW1uanBJSnJia3I3dzVUanRYc1BJUENpNkxNbGpFOFVsdytn?=
 =?utf-8?B?OVF2eWJkdUVqK0F4d1lKRTU4cHM5SWtPQ0RCRzNxTzdNM3lDcmlMS1VEZ1hI?=
 =?utf-8?B?TGJtMEw1RWRkUzBNM0N6Z3Y5enMyYmRwZnp3M2oxRm5wTnVCb0M2ZVhhN0xM?=
 =?utf-8?B?MlcrS0FKMmw3eEJVeDZRdkpHaTFPbkxZN3dEaWYvR0Q2bm1GNi9KMW1weWVp?=
 =?utf-8?B?UFhhVUNXVENkUnYyaHd4a0QyYStDc2FuYmNWb3RnUzBxRFRHRXFUV3JLb3Bk?=
 =?utf-8?B?a3prcTBnWlJrNE9IaEdwVW1HbDZrejVwVGRtUUdhTDhNOUNFYUF4S1UyVEVu?=
 =?utf-8?B?WVZGWllWeTNaYW9XNmFwSU9nOFJpd0NacnlncFNGK2EzbTNOd3lXNFZPVWFv?=
 =?utf-8?B?ckp0ekxBQUpwRytPU1RXcnl3SmNGeEExS1FPZU1pVk15dkVSVGR4RXpOcy9S?=
 =?utf-8?B?UzFab2laNy8wUHVucmNyeUlIaWhvUEZURi9GZmRyWWRUMU9zWWI2QU1Bc253?=
 =?utf-8?B?VTRKaFdrd0l3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db1b6227-24b3-4be0-53ac-08da0e80662f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:56:26.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ik4vXnv6EGfZiof7EEw4R+Ec1iNOw3J8WnmrD+UT/zsEWjs5eU6Tmda/8YIcw2qUF2w2fd6F4pk+eOtxINtXMN23RkJbUhzhJ/onqLyWkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/2022 11:19 PM, Rajvi Jingar wrote:
> The state of the device is saved during pci_pm_suspend_noirq(), if it
> has not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   v1 -> v2: add comments to the changes
>   v2 -> v3: move changelog after "---" marker

And you need to add one more "---" marker right after it.

Analogously in the second patch.

>   drivers/pci/pci-driver.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..ffe76f238d7e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -834,20 +834,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   		}
>   	}
>   
> -	if (pci_dev->skip_bus_pm) {
> +	if (!pci_dev->state_saved) {
> +		pci_save_state(pci_dev);
>   		/*
> -		 * Either the device is a bridge with a child in D0 below it, or
> -		 * the function is running for the second time in a row without
> -		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  The device should
> -		 * be in D0 at this point, but if it is a bridge, it may be
> -		 * necessary to save its state.
> +		 * If the device is a bridge with a child in D0 below it, it needs to
> +		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> +		 * low-power state in that case.
>   		 */
> -		if (!pci_dev->state_saved)
> -			pci_save_state(pci_dev);
> -	} else if (!pci_dev->state_saved) {
> -		pci_save_state(pci_dev);
> -		if (pci_power_manageable(pci_dev))
> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>   			pci_prepare_to_sleep(pci_dev);
>   	}
>   



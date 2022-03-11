Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211C4D6874
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbiCKSeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 13:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCKSeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 13:34:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B55C793A;
        Fri, 11 Mar 2022 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647023612; x=1678559612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=giBOsqaTI7IpEbB8tC1orVq/g1vMqJ+5z2WNUssXhD0=;
  b=leNrWJhaP+31wneMXO35LoWQP6Rq1qDxE3A5bZ3BQE+ej59F+Mcnht7Y
   KuECEJaL3qJJrKDFOux+1iq6fcY0uzGHCH10rK7GuzOt+PXS9hBrL4ogb
   WPwlEYp4PL93NIPj14UiyJhHFxZV0HOolyFBB/RANBQpEBoTz2SVj1SX0
   2JZ0sA9i/iREi124X/OgLUz/ZTQgWWs/tnkX/4wdWgQ5iHZGWfvG585gd
   Ty1oHV1BOFS3KScsAkZTKloBSGCyt7uMvlzEcc2tffjvGe1Jn5zFqPNK0
   hP4nh6W9xeSJXVksbemeCE3rFabvLNbZx44NiuTfnrqJ9YV1JFvktkdQx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="236231847"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="236231847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 10:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="689145466"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2022 10:33:31 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 10:33:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 10:33:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 10:33:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 10:33:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO/c67izoZ7gzF+iAfU3EpvCyFht25QVXeXjY5KBxM1PvAJtr1oAvz9/CexT7mgYWn+hspw2Zq22kNoewT0tA3cEsxGtLqM7WB+rw0dmSMQc6XWQw+qenbbiuEZ7F2xIEAvaIo+PV4nrVV+FCZOFFR4HJerwhxt54zkoYBmRQOgFLnO/P++MzImp/8MQTWxDivgQMLavp59OXeIzm2+HCKPIH7t8jeip/lwyNQHgD8p5W6/6rzhn+Ac7RNDsQUyPg2i2xBi2PshEREOs5k6tKI4l1cTqjE2nhAYE0aNqaD3UERgxtsVNtygdZbtw/FXBir3/0tnkOAiiPMjaz6i0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy/rEsCvcvqKQj2uIrbNSWNU1pMN5rx6/u03FSE/pEE=;
 b=msTMqcdKs67OSyBf7wSYYxGatEHla1m+mjM1TJx9RshWiRecivqCuLSySnc0nSG+qm450S/HcU2zGcFW0v4h4M/oKX/YgSh8ZTQY4HBW5YfmilhUNYhccOK8u7ooQ4YlDkRdzCEGIbRw2Q5kd9rIdyWXDpwSPAjBSIf4Pj9aFe5SD1fkpthckQqAF3yQCuanoD4/3Xe0iZ2sOGA0WyIuEiUMZFsa23Su/qHeGUPjMbaXSo4nteIHkSSP6Xq2kMKb1Xa4CRSVL1e8UMmyxZNKDDsIatrBbjTFFuQEz9DcJTSjgkd7BTBCVgzknzN82njDdWCsTuLqm/rqLm+ImH2i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 18:33:27 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 18:33:27 +0000
Message-ID: <17f70982-5805-b9f7-cdec-96d1ce589b9a@intel.com>
Date:   Fri, 11 Mar 2022 19:33:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220224202937.2414867-1-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220224202937.2414867-1-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a13402-e13a-4d24-e386-08da038da232
X-MS-TrafficTypeDiagnostic: SA2PR11MB5033:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB5033C19F14420CF9F947A9F9CB0C9@SA2PR11MB5033.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwejZK1m/XS6WCRvse+Nl+OPrTsC6ZqMgCw8aDaBQNhc/RakQIqzN2aznoLAqQgkevoftZdRsUPkogTTOSfAhNSKvR8xPS/cWef3b3ufAdndldS72xML67eSByrITU5UaFSu4NcJ+Y9HAT7qrgbr9PpNgoEmw61pLPZbb8IYlYiLvvBrXKiD3DTBK1WH5bZa0Hahi2hi4cSiZ06FwBqrNejQ4C8cL+EhPQK/Qx8+ngqkRf8CTHyjxLZMtC2nvo91/f1VwL+FwKd+2x1k6dfa70A4VlG3c1rDcGwkJt8iT6H3WqvB4BI80RRKGqWHFCtDOxy1nWobOXBOrD25wiPjWkOsShtPGzi2aO8GCL7Ng34vBJH3AVil1iIp3VGmUBP+iRocCrFIg5R/TXXQE5ku/4HjPebZaUfuUN5E6LXOpoDq3oNcMDY+NnqLtgIar4/X6TTBsuWL3Ry42GLsZcgO6QrPKkvBQwbCHvR8xUbcX/DOb8h4N1NSMCsOHFmQip0u2zpDbq8cxCRVB9Y4z67zaoDEyRcV7I1kMPEsWfFGeGnfNtlLHF+WQD0wrgX0Pcp+lc16snktbzYsr9Wjp9EMvJSv+fH3PCmNq7fufd5IwM3V99/wl17wozw+1OJ8ghHJUpSe3/NOBChJwiQzIS5169UxQ+zRbh+0MT5bNZke/4zJW14TNHYkZqDp+QGH2bmv6ovXG17Q1JRol4IgC7VtKbpqyFIWY/rmDnb9eQG4WFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(83380400001)(5660300002)(38100700002)(6486002)(6512007)(36756003)(31686004)(2906002)(2616005)(53546011)(6506007)(508600001)(36916002)(8936002)(31696002)(86362001)(186003)(26005)(6666004)(316002)(8676002)(66556008)(4326008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjRCMG1scVhOWnlTMVhManh5TG4yL3ovRVhEbEpWenpYTnI5VDNraFNNQlNU?=
 =?utf-8?B?QjBUSit3Yk1JekhweEVQK29jckdvMzVjMk1JRW9ZYUROLy9KcjJ6eGhHL3lm?=
 =?utf-8?B?b1hlRG1BeU1haXFGWFVyOFQvMDVXOVlGTWo5bGMzeEtsZlZONzk0K21DYlVU?=
 =?utf-8?B?SnovekZvQ3MzWm93SEpPc210WTg5dFQxNm9hV3ZTUklZRGxrYzhzK3krTmJT?=
 =?utf-8?B?T2hucUMveHYrd3FpNENkbnA4RXp1bDFDb2NBY0VlNFdoRUxIY2lYVXRhUEhO?=
 =?utf-8?B?YW9lZHZzTlRpTW5JQmtVdlhOTkVVWUFQVGl1bFBCOWkvUkxUZ0xRSEowbSs4?=
 =?utf-8?B?eE1pc1IrbnFiQUlRcmRIckZMYlVKQkdBdDFBTGtMR3ZzV3pSU2hMS3B0aVRY?=
 =?utf-8?B?VmwwYTRVQlk5aExxbUVqNkh1Z3BBb3dMQmhnTUZVSWVZMzNsME5uR3lDOXMr?=
 =?utf-8?B?b2FZbTN6QnFpUTl1S2U3SHNiNzRmL1YyUm1Ebng5cUFCMTBTcnQ0OTRyNmNz?=
 =?utf-8?B?WGI3Qm5RK05XV2pObGptRFJ3alRESnk3ZVRoMjNmai9LaVlJT0kyWkxOMjcx?=
 =?utf-8?B?ZlhzSWd3V1RpUkpDSm0rODJuME0wdGNqY0J5b0ZzcGFRUkF4bnB2aU50ZStq?=
 =?utf-8?B?VUlORUhmTys2ejFza2p5SXNSRGFnczgwYUhIbFhlL1Y3NW42Y1hwNFozTkNT?=
 =?utf-8?B?bHk1bzhmbXlJSFM0eGVzbkZxUW9VTjRWK2FtSjkzblQ4WjlRaFpaSmR1MGl1?=
 =?utf-8?B?K3l1UHpmUFNkWjBVOG9qTVFmckVMVVk4bTRIcVJub3V2OFd5eGFOYTNSakRJ?=
 =?utf-8?B?MTdKN3F5QUFabi8wUzVGM21nSnU0QklMV29Rb2pQNkhaTjFOeDRlcEwyZWZ5?=
 =?utf-8?B?WWZjRCszK295TEpMSlB1WlZBY25UdzN0MjkzZndLNmM3MDcvWTBlL3FKaGVt?=
 =?utf-8?B?aU9LV2xBaUdKUExib1NmQkxERGlvdmpZc25vaTV5RkJxYzd2M01wNHpHQnZ1?=
 =?utf-8?B?QU4zMm11M2JQUXRsU1dGVC9iUzFpbFpzcEhlQUxpM3BwNGxGZWdONk9PZ3VS?=
 =?utf-8?B?T2k3c3RCRkY3NE82eEVCYmxYTHd2emVCYWJUclFNL2YvcVhWdlJUdVJ3NEQ4?=
 =?utf-8?B?ejczcUxLVjMxSnVhZG82VXhwUEpZem9rNURpNi9iZy9zZjdzTWRlYm4vMTU5?=
 =?utf-8?B?UUhvL05pNkIvTlZRRS9qdWR0LzN5SlRhMHVLaWVkcThVTG53RTEvUWVzbHh1?=
 =?utf-8?B?YldYd3BiOFNnSnpReVh1emwyY0JBY3BsQTVqYXU1T3VJTk43YUk5bHo3YVhR?=
 =?utf-8?B?S1RycVdlc2hqRlJ4cldtaGhTRW0yYWYxRDlTL1NGbVJMT3pFSVM4dmZKMUpm?=
 =?utf-8?B?MGE0QWxoOUtCWTFuVDk4MzZpdmhRWlNCMERCMzQ0U0lvUkRCenN2eCtQNVNn?=
 =?utf-8?B?bUUzUWVDMVNmNmNNT2p5bEVHQ2xCdTJwTGhUNUJGSzNLUFYrNy9GTDR6enZv?=
 =?utf-8?B?bUs0NWozTE5jS1RpQ25qWlNZVUpzV1dKY24xOGhtbDhNQnJRa0ZrQ0hDZDVO?=
 =?utf-8?B?OXhZUXE3Y3YySVQ3TnBYdy9GUDlXNDBvbHRGMExnaU03M1lFdWpKUDgyTVp0?=
 =?utf-8?B?NFQ4Vm1YTWpuS04yNzY1Y25tTWQxeVZEQ1RjRXlML3UxcEh2bisrWEZvK1FN?=
 =?utf-8?B?RmF1YUQ5MzdPU1NWRzNzWlJSWTF0SVVLdVdWL0ZzWU5kRGVnY2Q2T1pBYmlK?=
 =?utf-8?B?MkxpeWZOVW45TEVKL3ZRaC9ydUJvRzZTTkVTbEVwZ0g2ZWtQTWptdXRYbFhx?=
 =?utf-8?B?b0xtNDdrdHl4YWxTZUdDdVlhNjlzNmxpUXJtdkF6RHpsMjRZa05pYXF6NlRJ?=
 =?utf-8?B?ZnB4OExCcGhBQ09iTHZoRnc0dXZyNmlneXdveGRKNFZTRW9lTmh3elNQS2xB?=
 =?utf-8?B?WE8yM08rTjlVVURnVElCZEd1c21RZERpSGZuUitIUVpnQUdEUXJiYmRLUWhE?=
 =?utf-8?B?c0Z1VnJqMEQ4RG81VnA1R2VCZndHVjJYSnQ5WUlpSmY3NithQS9hbjVEM1BH?=
 =?utf-8?B?bGtkQ1BJWlpvU29BYTI1NS84RmFJdDZpdGx5WXVWMmV5RUVzZzVZUDNIT08r?=
 =?utf-8?B?YVk3aGJsdE9hZ25SR29IK3NVYW1hQm1Nd2FVTmhMdDljYlVXZnZDcDZwT3V0?=
 =?utf-8?B?YUlpM0R2R3oxVnlLY2JmZkJtQUovYkFOMkx6S3cwKzk5VDRmbkRFVVpyc0JT?=
 =?utf-8?B?REtJd3BhWXgya1dCWEFoaDc1clVBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a13402-e13a-4d24-e386-08da038da232
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:33:27.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XekYhJwxTBRAnJCofeb4if9GjBxijsqC9Tqo62YprqqLqQqJBS8zb9pEx8jKv0CYOR6uQGy5M/C/nm8lvk6kBHkzZ+Mx3lgmUKBnyF/1MwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
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
> The state of the device is saved during pci_pm_suspend_noirq(), if it has
> not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   drivers/pci/pci-driver.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..ac3f7e1676a9 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -834,20 +834,9 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   		}
>   	}
>   
> -	if (pci_dev->skip_bus_pm) {
> -		/*
> -		 * Either the device is a bridge with a child in D0 below it, or
> -		 * the function is running for the second time in a row without
> -		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  The device should
> -		 * be in D0 at this point, but if it is a bridge, it may be
> -		 * necessary to save its state.
> -		 */

The comment is outdated, but the role of skip_bus_pm needs to be 
explained.  It only applies to the bridge with a child in D0 case now, 
because the other one has gone away, so I would put a new comment before 
the reworked check below.


> -		if (!pci_dev->state_saved)
> -			pci_save_state(pci_dev);
> -	} else if (!pci_dev->state_saved) {
> +	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> -		if (pci_power_manageable(pci_dev))

For example:

/*

  * If the device is a bridge with a child in D0 below it, it needs to 
stay in D0, so check

  * skip_bus_pm to avoid putting it into a low-power state in that case.

  */


> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>   			pci_prepare_to_sleep(pci_dev);
>   	}
>   



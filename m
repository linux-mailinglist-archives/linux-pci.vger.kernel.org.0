Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5E7581DD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGRQQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRQQA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 12:16:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF4B5
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689696959; x=1721232959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AjvlCCvxS2nAinFwSPP4eFKAgOk3NbGfIuugMy8cf+w=;
  b=HOph3qasMDFoZBuxBsVlx+VJ7tYiYgGcF8xoEqCld19UDxU2XvqUZjHZ
   JxJ7GREcX440pDLirUMAaQQphnBqxoWkMaLjWrBOtj98MKFGBv+kjm7dv
   svp6Y2uR1vE2CKTdyLFEnm4HpLbOLdLxdcdTC84ITDxSlguueTSw5kUkc
   HKZy/n2tSdxWRJMHvvd3o7K8t+fezXkq0IRGuuK33ojxmQH15EyVZ2EEn
   Lu2soNO+AHLrtoIYpXdgLjl2QNvx796fQqa4sZyS/e1/R5oEB71ubueO5
   aHUJgggCPR0BkaVjtjP8ueNYR1+vkZdGZ1G+i3FBkjjp2Urd7lgBEIw58
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366290936"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366290936"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837333604"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="837333604"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 09:15:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 09:15:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 09:15:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 09:15:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 09:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV+dmTZeMpQ6CJU/GBsYkuSxcb2e1FOcNv1oW3TZKXVhR2mOqbg4L8xFp4oXqJrvmLmj1H5uSbedoTqItPbaB5OhwnAvqvN/PhbICBDP9lM14/a9lAaiZymEGq1JFm25PLOEboquJbWEOlg/vvWmyJDXnda137bsVfhiKcXOSDW44zUxeSAPFsx2pOO3j/ppBTxCPO72L6JoeEfjJCYpolMf/0yQ6CUZlR9OVIBxcGhCLXkgvcmn07Ny9Q+bMRCuUMx1mJHCFF3yz1GHc4WXcwhE941E4jN4nY7JpjXzTAUtogInXGrUvmCR2P47nPbPQQwQd+72coIQeePUOxr8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIR1jXexKqZ1vQ0W7vYw556Da3TFmSREPKu2YvErlok=;
 b=l6/YoYefRipo2A/5cVdozq6gdr/yurM58t6CMm+YWNW4UyUtxrzqzP6YXajGjXahWmSMLz8V3oHc+sfvTK53C8yTRUZ1SbJ41IppJAliMM9SMkRRFQDFyMYvB/m2sFUnbPEEgKbm6HsChTN3ytdrCALNppFotI/s8l902vwRQe4psh4zrRQ3uHOeT5xRMItD0lnk1DSatOhTGeEF4GDqC+cuFxvxgFabf5dslrX7h39Z4WaQHSOgFXpnUGpFvYojTpPCgewDTgvaR+Lc/7iAGudIWkAqa9eCo/9OH2qFctYF8wuTIR4yA9klrTZ0Uu0aDJwbNsjTHIUzPQ5cF+pCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 16:15:21 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:15:21 +0000
Message-ID: <af05bc6d-adf3-a0d1-534d-976f99e96d58@intel.com>
Date:   Tue, 18 Jul 2023 19:15:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <intel-wired-lan@lists.osuosl.org>, <linux-pci@vger.kernel.org>,
        "Edri, Michael" <michael.edri@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20230717171927.78516-1-sasha.neftin@intel.com>
 <80bfadb3-5af3-0100-30bb-c5008660d5a5@molgen.mpg.de>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
In-Reply-To: <80bfadb3-5af3-0100-30bb-c5008660d5a5@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: cc88fe87-2014-472b-6a51-08db87aa2f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVgqJRIEFYN49+YAxH1MKQ+jEOK9M959BbX65YY21BPFZnvujyI/rKgmTPoMMdiWeBnBs8Ehim6pXLuvQFvM92Yq6NSD18YBn+d8dHFa1XPWRA6EIpIQwsoJyOq3XnDnh/RA0SY6MckvrbKNK1t0zqTmLu1gM261C3cgBCnVbNyMfRi3gzeIG7Z5M32kzOq0mX+JKpfj3B5JjyU46+kKLStC/xoc9qkIGPujP7zMk1LX1xnfO+CsSTdgK1GfPoCfK0zPRA/YU+J7o8wwsdIiDVmZO7DsloROT5nkJQh69IyyKNTBLy8alh1pPHzlRpv2sURJVD64aPqjKXXjewxLSAwRf8uaoLPIlrDWulXaIZki4a5ixmdda+bWjpn4P/UrABD1BuHgOrsCTGOycDcNhIJI0f1ZnFEZXDPJ6sdl67WWe5rgAA83UB38nPCB1vAIpiqBtkFz7Nv7bY0LRZdGdqoBAirXL1teInEWCe7uz9xCgeLfOt2aENI0y/kPEcDuPoN4/dWmcnGPQvdIXyV55MRjJbx2PNsvDEALcDwTJv4/5HUSqqvYOAAa9D9zPoakZ4HzZu5SfESe0ocg2GO6mjAznyj+c5jc54yDPlqR8NmhTOM/9uNItkFvZGumJmlovM6SM4ndoj2XN6Q8t8mJjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(82960400001)(53546011)(38100700002)(6506007)(26005)(186003)(107886003)(2616005)(83380400001)(36756003)(2906002)(5660300002)(54906003)(31696002)(478600001)(6512007)(6666004)(86362001)(6486002)(316002)(41300700001)(66476007)(8676002)(8936002)(6916009)(66556008)(4326008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1IeCtZVmlVTGovTWZOdHZyUDBaak15TzUzTjd3U2UzSlRFMUN1eXkzZTQy?=
 =?utf-8?B?TzZKRGRkek5NdDJqUUpIQnNDSUNudTA0TFZQM0Z6WEN5bGdrMWFVT05nZk85?=
 =?utf-8?B?cmJ1WEE3bDhwV0lzVExoQlF1MTV6UlhzdnBrLzcxT3diYWNyc0xGOXBJc1A3?=
 =?utf-8?B?TjNuTjlvWTBXRVVuSlk2TTlIeWhtV1VUVW5nS3hKK2d0eUVwdHpLMkNZbktQ?=
 =?utf-8?B?VDFvTTM3UkY4c1U4bEliREE2bitkaUtMWFJMQmZZbE82K3hBQk55UkUySFJU?=
 =?utf-8?B?NnpkZm9BaTR1TWRObGZpZDRIMHZsYURkM2NKTy8rMXVoN1FCbktGVGxnai9i?=
 =?utf-8?B?TXBoRkNWQnBQUU9IUnBPRDN4K0JDSzludWJmVGMvWUdIeG5mdzZ5ZDk2QlpK?=
 =?utf-8?B?eXVtR3A2L3hYNExYQWI4TlZMTVk4SU1pK1kyQnVWeTJOMTBiK1N3M2lVK0FZ?=
 =?utf-8?B?QzlkTXk3TTN2ZjhySmVNUUM0Si9nWk42SzVwajNMbHdOazdvaFQzL1ZpZnhC?=
 =?utf-8?B?SGMrRmhtVldwdGVtYWc2VkowblBsdXljR3QrVlp4NjBzYlVTQUZCSXNrOUlr?=
 =?utf-8?B?ellVRC9iYkpYbmZDLzNmeGNBanoycUN5NjdIK1VIbEgxWGw4UlJuVkRJNG9l?=
 =?utf-8?B?aGVlWS9BdVBrRElIR1N5Unc5QmZWTUNlYVJSWTRQSWgwM2lOSExJZURGWU5j?=
 =?utf-8?B?bE1NZFFkYnVERjArTU1NVStldGpOcUg1ZzIrWVFFMS8wckxNNEEyV21MWDM3?=
 =?utf-8?B?NVVOdDhiTEo5UUorZmdqK1dDN2NNcWdFSzQ2QnV1QjBKNVhUcXV5MW83ZStE?=
 =?utf-8?B?RU5RaFFZRC9rTXo5OHBjQXdQY0NoK0YvenJqRVZvVFhTdnBRbGZmWlRRUk9G?=
 =?utf-8?B?YXVYTlkrS3gvQU9GSVZ1elpidlV0RjlYOUs5MEQ4OG0xRkVWaWRSR2ZieWZ2?=
 =?utf-8?B?NjBhMXBiYnA1U2JsdzhTZUlOZXBqL1RtRTVDWEhhdS9wMy9JeGtvQnFFeDZP?=
 =?utf-8?B?RmlJd1R3aVcxWC8xU0xaeGN2OGxnNDFEZjM3T0hLRnRxd0lqem5EeDY4WFBW?=
 =?utf-8?B?U2V6U2gzSHJ1OFY2ODJNOFNlVG9oTFhPd2NJTW5LZ0c5eDBUTWI5bnFzRUZu?=
 =?utf-8?B?Q0lWVjNBR0hMVTdLd3RWeXU1UU9xOFN5UlNzeFMveFdYM3p6Si8zdm44aVkx?=
 =?utf-8?B?c2tmN0o4SW02U2diMmprQVVwNW13bFgrdGFEVmx4VGVzb0lFT1JVdUo1MjdQ?=
 =?utf-8?B?Qm9nRHVmdkJGcFRSZXFCbFdUNmVRR2dKenErNjNWamFVNjBRdzBOM21sd2xL?=
 =?utf-8?B?S2dwa3F1ZkswcG1DZWEvYU1iczJudUNPdm9XR3FQbUU2UVB0K3RmZ3crRnc1?=
 =?utf-8?B?elRNOWVqME1mdGdNVFRJMGhpN2ZlY3pLM3N2M09wUXdNOUREY0pwRnB3S2tI?=
 =?utf-8?B?ZzVLYzRWd0dDSjJRZTRNdzhBK1ZoNkg2d0Q3NDJlTTV1WjlOclMwUlQzYWhV?=
 =?utf-8?B?TzlyZFFlekM0ZUF4NENvYVNuVytLQUsvTElnUElid0RGYlFmOC9aYnZjeEJj?=
 =?utf-8?B?Wm9UeGRSSFN4aThLaXpJRTRUWThzS1dFTzJQWFJpTFZJK3VSbjFZYnBPWlI5?=
 =?utf-8?B?TXJnc1U2VW1nazVRbmhkdHBhTm9JWlVuR2JXYmFKSlVtQ1Vjcm5RRklnellw?=
 =?utf-8?B?ckQ2bEF3TE5CdjYzZXVPNHdpck1uU29LWUlkM2NHcnQ4WWhxdFBoNThmblJk?=
 =?utf-8?B?Q0Q2NENMT2hOT3lkOW1qZDZXOFdmOG5OMTFOc3VKbVFPNFIxcXZwM2IyL0xz?=
 =?utf-8?B?WFQyelpFTmxIcUg5bGdXd2RWNFU3MnRrWURtckJEYXgxUGNBNzBjSmQ0VXBZ?=
 =?utf-8?B?dEI5dU9OUHVIcXp3dlgvSnh0Zy9SMnBESUw0MXpHY2VjTEZENzNVdGlHY1Zi?=
 =?utf-8?B?a3ZGNDBoM0ErRmVweENObnc3V2U0bDlLN3lRTmFiZHplVnpDU25uVWF3WktW?=
 =?utf-8?B?YlFJclRoMXl2S3YyMXNLZVVxM3dva1hNTndHWldiV2VyanUvaGxWRmNIUFN0?=
 =?utf-8?B?ZWFtdUIwYWRMNkU4aDI0aks5aEFGMGRaQUpkWEhMTUg1RGpaUGRBSDVHU0RQ?=
 =?utf-8?Q?m3Pd1qVK5rWnyXvJFo8nxShdN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc88fe87-2014-472b-6a51-08db87aa2f26
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:15:21.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJM9G0mMSFHTrvkSjtunQBJl/ih0reaLLK3sTJPhH1Eecn69fUiJ3BQV1aJj1VKA7CJUiTy9+aBgDL/iEraVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/17/2023 20:32, Paul Menzel wrote:
> [Cc: +linux-pci@vger.kernel.org]
> 
> Dear Sasha,
> 
> 
> Thank you for your patch.
> 
> Maybe be more specific in the commit message summary. Maybe:
> 
> igc: Decrease PTM short interval from 10 us to 1 us

Good.

> 
> Am 17.07.23 um 19:19 schrieb Sasha Neftin:
>> With the 10us interval, we were seeing PTM transactions taking around 
>> 12us.
>> With the 1us interval, PTM dialogs took around 2us. Checked with the PCIe
>> sniffer.
> 
> On what board, and with what device and what firmware versions?

Any with the PTM support. HW feature and not dependent on the firmware.

> 
>> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
>> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h 
>> b/drivers/net/ethernet/intel/igc/igc_defines.h
>> index 44a507029946..c3722f524ea7 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -549,7 +549,7 @@
>>   #define IGC_PTM_CTRL_SHRT_CYC(usec)    (((usec) & 0x2f) << 2)
>>   #define IGC_PTM_CTRL_PTM_TO(usec)    (((usec) & 0xff) << 8)
>> -#define IGC_PTM_SHORT_CYC_DEFAULT    10  /* Default Short/interrupted 
>> cycle interval */
>> +#define IGC_PTM_SHORT_CYC_DEFAULT    1   /* Default short cycle 
>> interval */
> 
> Why is the comment updated?

Interval, not interrupt...

> 
>>   #define IGC_PTM_CYC_TIME_DEFAULT    5   /* Default PTM cycle time */
>>   #define IGC_PTM_TIMEOUT_DEFAULT        255 /* Default timeout for 
>> PTM errors */
> 
> 
> Kind regards,
> 
> Paul

Sasha

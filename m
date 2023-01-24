Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37623678CEB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 01:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjAXAgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 19:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXAgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 19:36:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B739B81;
        Mon, 23 Jan 2023 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674520565; x=1706056565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KfTSgPczIztJ6ZlfcKWxde33VcsDAh7II2OfrCByvYg=;
  b=Dxh+JxBzQ6rOHc0LA/Rgi6YqvYdQzYAmTIUmz9SpjIyyks+t9kAbaHBe
   avvLgxNZv/EQTt6ZwTxZFT4h2ZhpwRbPD5u2A9ad2Sd4CS6vHObG/XC3X
   J99Orl/4yIZr3LKtCUtIRGjNSigbHiIiSBn0XOF36cxwifosZmxA7VKc9
   d8czzATlp90WRpLAhhXRQVNypEIABiHby9iqHYdni4robUksDTCAwCuvr
   EqK72mzwK3oyGm11rwBXDAdUZu7ES5cPSxtGznl8xXzSEKM01aEHYSqUq
   ISHAJ7KNHbKTcDRct6AnRzTdd5w1olYEgln+5h4Q4Uza3jZa0259O1unw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326233808"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326233808"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:36:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655232891"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655232891"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 16:36:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:36:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:36:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:36:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:35:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPYbetUZ9Sn/rtDtl/sBfnDhvTmIAPqQh/G5T/3tviEaEh9kqJ7CXpps42O0zQOwDc6i1QyJ7wMqhJtXqgB2Yen21pnMAUCF6cLBwY3eYl3LZ9hJyfOsrG9r1D9cJbuGXvUizcuDCeFwYJDUYp1IRwbdOxU0ZimI7N1Yzc00BTLmE37fUKNS8oRrdgJWqC2tXpkUSbdYOaXFPwSRyIYCaOCC1XjADlMueb3Msxmdcl+i79oSuhQ7BznoQeXYC9fwFqhILNH6fasPrUmpfOwcAs9vugTLZQl/OdTLR/REYBwekVXKbo3onAoV2LaIaVmHfYDeudUp3/wiIhB+iqCvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtPTbrWqpE8YyiaCXRp/mrHFX/w2hFJJvEwHNtszTPY=;
 b=ROp0IEyMWaB1JsOAAH5FAAAustmPwKEpsAGEkjy5EETfhxaoLGJG4TCcompVZyYcEPb3+UNzz6pvVxZNB9tr3NvLMyVR0frzOYrMTiXVq3Op056waVyME9ydHhGpZpU0cEZW3LUMN88+V2wZO4M7wDg/otL9RiOdYFKp4jSFAhndDbh1FH7CG+aAYIBsVNi1ot/M26n9wy0dIyRpfZA1NrjDnunvbjZCNn/kRVEfSN7nCRAF3M3xHMsnRsfHOO45xy+35QZEllbvBBuQkNXd8NWhddCxpyKi1uiaEVquVdKC4FoyLessrd7CupkSw1SMl9MzYZc6ZUmxvbt+Etvm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4977.namprd11.prod.outlook.com (2603:10b6:303:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:35:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:35:57 +0000
Date:   Mon, 23 Jan 2023 16:35:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/DOE: Fix memory leak with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <63cf27ea17c33_521a294ee@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: db19c452-7069-4b58-98e7-08dafda2f59a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdSLVJsBIpu5luN4H5eO+4b0Mmbtv7mm95dwxmujqxPZPTbopN3SjMrBv8Kg46Iz/3vK+cJj44iV9UsMLdSIvTmzyjzkLY/4c423rtm8O08u7w6GsuPeR00RDCk7T6NjPM2P5qBpRbP94S6BQc/Xx6kHfacoOwXzlGx+7E7Q6lG6ihMK71ANCqqP3xUE9uOiUQD3o1nUbrUZJ7ySo+XysfAN0n5KmgROvl8EE8S+AxcTP4Y4veK3ypH+mSyw4TVucC9TT1fTiFPtGuIZKr2qDzPXR+BY7hULDGz6CfMEfXNN+9IDL3q4BRwESvjIl5qvpLqA7L9M6zK2SKluyy9HmGH5dGc7mjjOWxt1IclddkTrEQqkLlq0sQGE/OGySx0fVyriQO5di4LJTJ1dlXkvF4FMCBW/r9mWDr5OYn7Se06kGDsEpQd20dC8E1QiLUlXPLYA/6ck1Y4xrBIdrHHLsHdKBSc7MY6eNMMcNuGsEG0kkf4aQbIuMRQC8lX1Nuvao8HagXTjWXSvOCZUxQDCKgSQM9afkWOCfaxG5mCncXTShu2kmJ58nfrPoPyolDGm0KErXY5YblKVsqGFna7x5KLMRAAAOfGnP9DBzCp/YWt3xTegsTApedJ3XL1G60Q5Xu7S+/mchO4sinGDNnjLGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(83380400001)(38100700002)(82960400001)(86362001)(2906002)(4744005)(44832011)(5660300002)(41300700001)(8936002)(4326008)(186003)(8676002)(9686003)(6512007)(26005)(6506007)(316002)(6666004)(66946007)(66556008)(54906003)(66476007)(110136005)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWP14Mi3SuwZwSVuNFoofknPfFO9Q2oDPLRxTNln1YDG0QVxB0IASV3A9rVy?=
 =?us-ascii?Q?yKOe1ThG8/uGeyjbFOED4evkEfSDGliX1NHCeRI2ISplxsJN15xB9zdTM4br?=
 =?us-ascii?Q?b7+QvWRImOKhsCjtCfWXJuMiezU8QH0TCsOHvZCwGAyQoQqQuWOL2/zII5Lq?=
 =?us-ascii?Q?Yk8cx07dZFaHUJWuZH1H4p49Jrygnun9PZsnUXQ0JT7fiNsfUn8kxeZ6vYWE?=
 =?us-ascii?Q?tWiejodBIjsXv5mpJ6a6CFhzqh0/dSG0whH3GS46SztwoAuxYFv9Of///tro?=
 =?us-ascii?Q?tCKKzTmRqj71ekH7lB4gAAw22ujprSrTbWZnVCBowG897Y/mjvw6AR4SivKa?=
 =?us-ascii?Q?OdFMQKvIs/l4tM9M3Tpmc1Pt6i2Wp62Lvvb5W9MADrp4UInXDsgDgXUe5Mml?=
 =?us-ascii?Q?5drupnTzzSl4pAfwiuyzz4g7p936zazGBzv3BrfQQRuE4rcgcM7fC/8zxhZZ?=
 =?us-ascii?Q?hZT5qfYpLGZBV01sGkGxYPbC8KkLBDxBDlTKEyvxKbLn/lpbw8WF3Zq+xHCg?=
 =?us-ascii?Q?NXeGkWo/EoRsSP+/sv/HyjSv/AptTNhdLBiInwhycBN7JoIyFTUZW1NcWuwY?=
 =?us-ascii?Q?0g20aB0JwbiYwVfpL/olJ+adreQ4OBDHKGcqtLKNRorishdHiGh1ohs+Kylk?=
 =?us-ascii?Q?Ga1yCtgaDULULE5HtYlRJG3pPPZ2XJzjRJ4JA14kv0DO40kAz9OSg13zjely?=
 =?us-ascii?Q?ZJ85swnuVFXHLLEcxNgsW5gkp1GmnotDXXNfx9zcn1GdvkUl7aCX2B/WOofT?=
 =?us-ascii?Q?tlMREmLLrehJrMyDZQKIEK7me8CDmVB0DTYzCFIoG7Zb4Mkv/JIMEghWvZsD?=
 =?us-ascii?Q?YR7Gv4La/Qx55Ey4JW93DQLvY5rDCjNRVk6SJvjTgMxVkM+UNFmfZptcNdvy?=
 =?us-ascii?Q?6PbyRKOtl9Nh5x+9axsxW+sd5CA6GQKU9/t1IIY42PvdVL6VaDUhCdnG7i51?=
 =?us-ascii?Q?KrU9CLr/SeDjefOycsyBwghj+JTGF9q9D4v6KxjUU/rwh4NWoZKTk9F1lRol?=
 =?us-ascii?Q?dfccMxLkWpqmUBqDshv0xWYQLszXTSIWZAtpbDRcNDPBs/QFpmSNMJNbJXHp?=
 =?us-ascii?Q?jbEMSDcUaZp6mNKJY8x8e6VnSboFVLJsMZpKkTBUni2u4VywAIgq2z+Sc51c?=
 =?us-ascii?Q?xo+ZPROQTtZ73ANX05aSqIDKKZllVYbAD2nE/wDmkXVZbQU65GUwZpQNUv4x?=
 =?us-ascii?Q?6Q8o0cdJL0RnbIFnPOF60YXBfHP3jHzkPAXYlJAQW9L4pRbBLX83+kQ6tdS9?=
 =?us-ascii?Q?LFYhiKH928vUx2aWZg5gxSJgU8P+rT8rAnKkQHIyGk2ELmZ/aXj8Beid14z0?=
 =?us-ascii?Q?tLd800hwcxRgm7eUzsoh9tG04TOb5poQ9+OWcHNHDRaAGLzBu4V20dIsZXTW?=
 =?us-ascii?Q?g0UE689WTzRRapTaie19BRmv1BYNP7WpUjFwpovY8IcXPue9WjfKaySoZPvN?=
 =?us-ascii?Q?op4p9GxMn+JgEAY9WtnblNmm3O7d6UzIC1iuiDWjMHIcvGn2PaMv85QH4uUL?=
 =?us-ascii?Q?BtMezq7Z+4QQUHa05UaQzySNHqXSsOEMbiNXVlA/H0I2potwgwZOO+ROgDYX?=
 =?us-ascii?Q?bnmJnnsm3NuO0CknIN2MGJMuIPRx3xPHcEQ/c6Y/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db19c452-7069-4b58-98e7-08dafda2f59a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:35:57.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv2Y0MrzsGvCLzn++T40aNBrpJKVx+pmGSOO75IxyA2NTGiSLC9OtM4VsSfJhTz7BOV9IksD2cuBMwv3s8py9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> After a pci_doe_task completes, its work_struct needs to be destroyed
> to avoid a memory leak with CONFIG_DEBUG_OBJECTS=y.
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/doe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 12a6752351bf..7451b5732044 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -224,6 +224,7 @@ static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
>  	task->complete(task);
> +	destroy_work_on_stack(&task->work);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> -- 
> 2.39.1
> 



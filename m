Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE163AE2F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiK1Q6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiK1Q6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 11:58:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE860C2;
        Mon, 28 Nov 2022 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669654674; x=1701190674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hxKglMjNRIifPrpeTQdjCp96BuAWSWlPZ00hjsXWryg=;
  b=HK0AbVXH4ajjb8Nfx8xJbQSb+Bcui3rjqviAndGkMFqI67TIJfptdjsj
   HJkOxk+lEZaB794FvvgI46H0LOSBlJpWo/FiwHXev1B6EPfDlWicU9G0z
   iEz6bE8tTsOzqsuXHj22LBnfixzYmrC7OH95CUi5wfMSJVqnHBoKX4DM7
   hUkId+/eIOxLtaQJ9AAySHOykJOu8Z6PJ2gFXPGfdHdXR9aMvgBu57klo
   V0Wq1sor31zcRCYmuyTequHx/kOoRMz0zlGS7Zk6FIyoTIM9HsxX0Zx+l
   o4qFPLQDKzwx7I1BeDgca3tzVFanTl2DkwoL3C3sZiXDgWdCuMv/GQCfd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="295270817"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="295270817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 08:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="637285490"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="637285490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2022 08:57:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 08:57:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 08:57:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 08:57:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 08:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrnrdfsvb8qleMncpnWbyb3yqEMrf1sMbZAS+9xrj1QLgZVSMFihP08TAd+pVd5rdLrsvumvMh2XanEAoe6C5K/6cJlI9N/dfLEz5Myer4iACqxg6aYE01dE1ywXC7iTYiD4uSYQdUZoJ5B0a1R5raAla5K3sO1bny9CcHWr9LNpw/V1dqkDwtUE+CRvqMIzTJ39yagdQ8eeHLPXojAycm3g3R6r7dXP2xGiIEEJ6ZcskMJihOOvkTN4lUZmieOJkTfCP5evKEkOYJs5P4r9Apr6yPVuBL0NiR3VOPI56+BluxK540aVU59RkStuvO3uOeIG2ON54Gtq/Xso3vB4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/bTRpC+BOToA/iLhAz9EBPrKYvBhDEsaZ6Qk512ksM=;
 b=QbqdHQ4OwzFSf+T6uuEwHbMC9+RT5bQpN3nMVDdcuECm4I12SCmGGOdSciWI3sYiqBV1bnDsTn7sHyBgjiiUbhXeoasqoMbR6O10dTueNkY6OO0ORBjNi6xgeQ/Eg2ImOFEfOCouQrFwvOvq4J3YslQLbw09hECQ5Cn/3azuwql83a4zlwprzr9T5lTS/FEAlNFvMFWUiNSPhKkjAs/+3tgLk1AxckNmQl2G4ost29AMCpM8ubpVYQ2wUrdkXelEdeh5EY7znAKhJppPjofzdmmZg5sjVjWs9U3WZ0WMuluJNWMsk7oxPYVLNjvshKwl/8wHzY2xF7jzLJgWQrte4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 16:57:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 16:57:47 +0000
Date:   Mon, 28 Nov 2022 08:57:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] PCI/DOE: Remove asynchronous task support
Message-ID: <Y4TogTL4PUv2uk6n@iweiny-desk3>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128095112.6047-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221128095112.6047-1-hdanton@sina.com>
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 58237810-cd43-4529-d4c1-08dad161ad46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDdZncivCdWHrqFJbbZRsLOulDo8jm9KtHMjbX7q18d56y1AlTVHk9sG2Un8Cu/VtCaEKLEF3Iy/OqM+EgQ3k+sBohdpGagoavdAMCpSa/s7Jrj4OGXPTU3vJCAiXRRU+MrTBtVNLQPdVW2ndeqlYTOHRV7WWAV+ddZ2y/vz4tE6Q7PFXKPEs8q1JGfAfd5W+Bkq0vqNKR6Cq64kr4ZFUM5xBzVltKKDVPgBTzNZV09AEb6eOQpRxESiedsdPePSIFUEs6i5LloqN83kVs/5VpEiv+tcT5mrLyS47vrlgcZXQuVIFhHXoPuPo0E+dDkgHr9/U2rQFEkQtFOCUtWdXEzCg4tXlYuw3fOpLHCL7cB9JBf0fFgA/dNAaPYhiEQ+ZOU9pCcszUCnXS1wu9xZMtn976EsU1xOGsFC5f0G/GCvLzheyeQq+lGMzYFW4K6b8DaaL6dWBzkedZKxVMZaDg237qk4wYt8VZX+jz0pYg5TQZRVdcYdavOcujizoSpO75ieI15BIB64lqbjZ4oAHj6pW71P2WMZlON63rQcbRxFwc+fiLVghsJd+u6KryW03HZgOCApBQmxQFj1VvBzUWgQ09rEa05k6vlDDqYCtBZ5TBQWUeI3VM59vfrg2aFqWEMp0ajGQ5Pa/5/x4EsOAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(86362001)(2906002)(26005)(38100700002)(6486002)(478600001)(6916009)(83380400001)(316002)(8936002)(4744005)(54906003)(44832011)(186003)(41300700001)(9686003)(6512007)(6506007)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(33716001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ymgHAnI6jfYAw3IK1ePXsl+tCDITtVrGCwawPPo9+bg2Bg423bS29HjKomf?=
 =?us-ascii?Q?89ED132z3vc4Uow3vt9/PGlun1Ke6ZN3rwZj+hqYKgaSYdFKwPviZvH5AnR+?=
 =?us-ascii?Q?F3e7HjhIRuYP9y7PnucRw5IFUhwxDxtunrwtsA/q8euYPEO23ZM4lFncK4u2?=
 =?us-ascii?Q?IZ/NJbwH8AYL1j79SNZ5tGdqx1u86lkHvf37w/v7BpHZdpVoy8QQ26/oyt8Q?=
 =?us-ascii?Q?OqmGOSeW3rR4ehup0ys0HcXZoBp6K6sOz9QjAAx6F57TXSzuwV1HQhdDjl5p?=
 =?us-ascii?Q?X7yqJ9Y+tEPR1cO9/oNRB8pwUNwelJQVFkMq1V0TUvO32QV6+iXeFN7m8+aU?=
 =?us-ascii?Q?xVGUzuwLbIVGwvviYCcNHoQW4ldmap3n5dgHTvJG1r7xAvrHULH6mTYra061?=
 =?us-ascii?Q?aJusTEeM0Dp1icjs++wiK2EwPXR0Fh6JflHrYY8zLuaCno4HqfNjOqplwspg?=
 =?us-ascii?Q?tI4REZgksN+XxOxdA2w/bp7S21XJWkiUaXfogxl/dxYAwqR5qV3cc75CkDII?=
 =?us-ascii?Q?CqiJxB7lPcYe/HMZsN7smcJpFEqTMpGoseo5fF075JigAiMy69JCNxXIBzlg?=
 =?us-ascii?Q?xR0xs7QlP/hPWDJG6bejuNYg4Yujk4DULarJGZ12H3/FTQ7N3CaOvnMaoR5e?=
 =?us-ascii?Q?RViHK9nznEqCnakC3xwAYgOG4q4UEhlpY9m7E79asKZ9i68cJJK748fR2v/Q?=
 =?us-ascii?Q?+vCL5hgUHMJMNjnv1n7KbN5O8gvu3C/HHUM2cbT2zyTlgATVflrNfdGbx8sN?=
 =?us-ascii?Q?EVcPk7rD5WP5vuyTzGiJ8dhkIJ7HxUTL/nZYpazD2f6tTyWUsR+HbWR74da1?=
 =?us-ascii?Q?oSORAeVMrIQJYrvEQViSDmMJjmPWBqg3ToX0+JXWKKBvzXHYTWhupgNnn0Ex?=
 =?us-ascii?Q?3a0yN7zVGV+XCvqJc73s4XMZ6jl35jkK7HPJgGjLkKPVEVFyoEdA5JoCKUmr?=
 =?us-ascii?Q?r+zFldJ2OPRxW9Q0d0hsK4GDU2wUNMzbctIW+kdhl7mIM6Pn67bHP6tKsAw3?=
 =?us-ascii?Q?Zzuy8ODyYXb9iNjbJmdTWnmM/HjWYd8JL8QJDlzMbdMtb51oKiByh2rdIQfH?=
 =?us-ascii?Q?SBQ9kk72Ml7ckrtu+GrDCL9BegamBsEuEVokZIQXnkpgZ/i81ojv2vHAik65?=
 =?us-ascii?Q?Ss4OXMFkq96jtsACSF7Z6lYOGNchZXPTitiiTvG83d3nJ2pNDFTC7JLgSGEK?=
 =?us-ascii?Q?1718sDhXJswuju2ipth/kkJV2PZFOcK96zTC5IXJjFoiTzSkiKcuLh5eFJnO?=
 =?us-ascii?Q?PzUoyHUwb1yxAlSk6Sw5MYmMxZChE1xqMS0X3h83S0vwTepvvg+qEXosgW64?=
 =?us-ascii?Q?31h1WGvzHlHa8B5f02Bb+Z3hGXsCHP4i3ApoCYrWmxCAmdg/wxqSliIgy2lb?=
 =?us-ascii?Q?GbT4yHAusieA7QtwPZr2K+OxFg6QckJX61AVIk6GSyY23wWyYzBsoUQBbNxy?=
 =?us-ascii?Q?noBQu4y93uaDuldyS9h3V2bBPf/KrCNVRO+TuuvIGRVKX2J4trznOgMFVtpv?=
 =?us-ascii?Q?g7C1tZG9Qp6xcopviVrzXh4+EeG7jk1Rel/asHaA2ryShh3hWtFn6gutXpLY?=
 =?us-ascii?Q?OWkLHrp0HfjhHFh3nAgnWa5gLkLONB2KKUcJnAJ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58237810-cd43-4529-d4c1-08dad161ad46
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 16:57:47.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SokowjInAWXjq3RRC8SP2upbKRCFSKqvFas2cbci9Kydarr35nX5feFsf8PuZ8yQAnrKDpROkP2eBt1oHz9xZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 05:51:12PM +0800, Hillf Danton wrote:
> On 27 Nov 2022 20:03:38 -0800 Ira Weiny <ira.weiny@intel.com>
> > @@ -49,7 +48,7 @@ struct pci_doe_mb {
> >  	struct xarray prots;
> >  
> >  	wait_queue_head_t wq;
> > -	struct workqueue_struct *work_queue;
> > +	struct mutex lock;
> >  	unsigned long flags;
> >  };
> 
> Add a followup cleanup patch to cut wait queue off as the wakeup in
> pci_doe_flush_mb() is gone.

Thanks.  That should have been part of patch 1/2 as it is gone then.

Ira

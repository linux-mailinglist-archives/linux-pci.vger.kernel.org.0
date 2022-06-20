Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9D5526AF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiFTVrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFTVrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 17:47:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92286C16;
        Mon, 20 Jun 2022 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655761622; x=1687297622;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XZ3Dq7KHdME90nJPRann1Vv71MzA4uuh5m4jw/nnQ7U=;
  b=RNjXnvGOFBLJDzPXs33ofFHvl+T+JMygTWI4tD2Eiz/PX7vmmh+B/8Wg
   U1lGqViieYxQaJ2WOtWJ0SBNb206Sw7Nrx0yO2ZEZT1Blq9kusWtu4EBv
   iln7N6hD2xNVredEOEtjyXZ5P2hBhmcTHXtSGQRhbE/bVIgTDbGJFqFls
   ofeoQPXyD0AiGrR5YmgM4U5Ut0XoIgzExZhnhaioaS5COyklAX+bEAZlR
   BzbTO6jMjhVl+Wl+S9yIWLYhIRPqKTRn5CYOebXt0V+D+/7EBjn3k1ixn
   fexjB9dXZAEPS7X+J4+daBIhsZ1EVS7YVNbFZhl2cIVwqi93iSsiaG0Vc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="281032133"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="281032133"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="585038131"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 14:47:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 14:47:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 14:47:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 14:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU6qBwXQbAK+e7PIR0ymOl6xzvNaDMz9iZCf0wnb5RPJPFJDMcs5NIJif67iaKuEJtbtEkRhyWb605Kzjmy1+bMjR8mux3a/CC4s1OgfAKu+fNB9nQzpZt28yi2SSHp7rkyLLbDBYiZyY7hEYP3XzaRoY5Kyt6yLYeAK2bo+QAZxYUbwSCbdlHr5Zb3o9vdI/gD0OXyO9AIa6VVzbZJFSjJyutInmXvp/24oLX9brudqVUhrgcQJIQFlwgvP718gfxd4V1IF8LiBEE0haNeQLiGTG3hjU24MUKw+wd+rv9a/YYG82cYqfSphlFzXOkmL8LiGldlTutdmom+cEbvpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3XFxTPHkrbv4MwUvXDXZ1ti9aLV/KfBspT6Ajbag60=;
 b=GT6nHU/BoCLXbdf/XE6cNlvpSNqT2iH6GBfA2rUnM00a1FYa1Vv6Xqy77NNl052MjOl2AoTEIKHr45Lj4JzbQOULpdrYv8PIJ58I2cOmRwp8QahFLhun+4k53+56Zm8So04koc6PtIUlOyCPnt9VQic94sfwwKTYgRbpY93xJNUYEUFUb2xV5od4Lf5iwfJGOtq2TROSCfQygbqBJGEcG7TelPH933dqu+xKNoOrgE2PFPEWUrTNKQEcHK4+lHR3hYGwu/z81okW+1TZlgmxYx8W5+Fq+wE7Yvnj3cYPyTICn5KsFpXDHxhyobFYhBUChA3hTnOAG3x4H0BAiJgYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR11MB1355.namprd11.prod.outlook.com (2603:10b6:3:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Mon, 20 Jun 2022 21:46:59 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 21:46:59 +0000
Date:   Mon, 20 Jun 2022 14:46:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Ben Widawsky" <ben@bwidawsk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YrDqz+x1IFKBRzom@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-4-ira.weiny@intel.com>
 <DM8PR11MB56695090626BCEC3E3E101AD89B09@DM8PR11MB5669.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB56695090626BCEC3E3E101AD89B09@DM8PR11MB5669.namprd11.prod.outlook.com>
X-ClientProxiedBy: MWHPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:300:4b::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98f13eb-72be-4460-8f20-08da53066767
X-MS-TrafficTypeDiagnostic: DM5PR11MB1355:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1355F58C3C521E8A719CA042F7B09@DM5PR11MB1355.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Il7lcFihihN4Z/962nqTvmlaHUUtdgjbacDTxz+J5JBj1FjbGDvPuzL044pn7Tn1X1CuOr+Pl+WO3gbkiVDLyfAmNHVEj6xkMlm821nI3uyGAFJL2sPzlBoceIK37jbnPIFRVf8tR+Je+q7alVrqDu3LSdwckekRi7Kiu6+hVxGww5EDh9e7nYyB0WRdU6NEvx1L2aYEPCljFxGlGMTzf43ropR/w6DON+MVn3qnCpfHmtEWXcCkUVXJjLdRsi+QIr2D0lpu1+2acJuMDBgD/HpWMHIJvcwmi6f9tn9z2gIdM4YfqyBML3eEQhmE7b0RXKrqlQ0vuZeczvIHu2eWNPEGPwM5FiDbRse0xmlxCxAs6oyDwEb9a6ShBwF7ffj4JOAWT/t9fXmZZ5XeP82q9hqrb7E2dSIiIK27ihRZabLopu/ZrZNrdE0IrlSKLF2LHQeCud96jbi2S9CNjNfAxq/FjDwtR11ibXok14aBpy8RQsD3GqDCPWT5E7MhOvieBWMOaur0FqeouL1+aGP47ZpSKfQK7KfLleFMttCPvUB2OTwixdAD1FFfvODOhoL5EWYpTbXBw8SKiXn5eh6bomrvN5g4uerKd+JPP38tN6FfszZW+SQTBlCdOwxp1G7zyKASETOOQywG11oEgXmgeRdfOCJTP6vA6gxxvzkjEfVXOFDgMkHI12m44noax5O4iBZb665G5+MJR3KyIv6Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(39860400002)(396003)(366004)(376002)(82960400001)(9686003)(6666004)(5660300002)(6486002)(15650500001)(83380400001)(26005)(2906002)(6512007)(38100700002)(6506007)(86362001)(66476007)(66946007)(6862004)(66556008)(478600001)(8936002)(33716001)(4326008)(8676002)(41300700001)(186003)(316002)(54906003)(6636002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AEY5O0ki01xBDjDwsVPSXTp/s89+myn8JqIF1Ety4OFoiZN0r/xSdujEgn5R?=
 =?us-ascii?Q?4+nnH6GyYmWZOBQ3r7x9EWm4lD6KTJAofTVT+EKnobAMMpwsyUfPwoVJxtXJ?=
 =?us-ascii?Q?WKuV7u+qFBOKTFxvY4GIpctZ+M5JYIaLPCV2UjppK8wqqFc2jbZS1uTfywzD?=
 =?us-ascii?Q?NgQCLHs8obsrTvcmvf7A/qq4R7R55a1ck6+rQNA45QDb7i7X5SKvvMwzd0/N?=
 =?us-ascii?Q?lrRdhaMajogXF32QmxCXLWR3phOIr8tydiiQHmmwdI30bzv1Jks+3m+/whaP?=
 =?us-ascii?Q?HtOcUGRFv0QKYXrdmUDXrX/LBe/8DgtUk3UamzIBEF0VpFdba4X14RF5ygGL?=
 =?us-ascii?Q?F7WDdHGqNN6D06vsOMSteAoxwfmLosr/7wgtp3QT3AIrbn6rr2XU9QOnHqTC?=
 =?us-ascii?Q?NiPnbNqBlEPdhV/w8xqPMeboD4A5AvQeGfvf8tBIZ4LBNLRkcVEdvwSx42LG?=
 =?us-ascii?Q?IPlP/oB97SjA+Wyktfiq9tC3inhk4cHZIL9eAQBfq1Eolf4qK0YC99r4Vzg2?=
 =?us-ascii?Q?GSRPbPNWnnImElRK0daTKBII3VbwBH2pfosTyrSkHLAVe/q4oLWJDZiVc9PD?=
 =?us-ascii?Q?YgLx8sfAPSjzc5phJLeZoiaEwbDTK3dKOqlRNX87CivNVlvGlIFktoUNe8I9?=
 =?us-ascii?Q?4x1Vy5IPio886LEjUjvetYhqtWRpWigI+Y8kzGmiglzDktDt8D6O2zrTrXA1?=
 =?us-ascii?Q?y+gBjxZLYadsQXQdfTByKt7x8pxCnfs3qEL+Wg5kkYTPDMueOC8hT6BhBkFU?=
 =?us-ascii?Q?sUgzzbn/ENLaVWtiv6XH3HYxqCu0ObDR+LzwA3yP2plg3Yi0L/9z0q/6mAz3?=
 =?us-ascii?Q?mfFXQnEBdu1gl7O9d5ylnYXxyqC3M13BmUOGoukDSYV3TRKeO5TZB+jYVk7L?=
 =?us-ascii?Q?Ir3aV7NBKCcjXLrFDCb9EAryIHwwMfUlXz6DKDw8Lk+CUlbSNrXBhiPry7qs?=
 =?us-ascii?Q?yhK413YUndTqxWGBWUHEQaVOX0haLPYetuF27wRpg2+uEYWJtwLZAAEIgpHh?=
 =?us-ascii?Q?hUxElnxHodtpU4DboF3BliU1s4+ufTIka3doBT+XVBDujWUwMIMBmtKk75IB?=
 =?us-ascii?Q?MZLE9W+/MNG17TKqd/eBgWbRFHWDv/G+5q//kti2hy4MqvZbMtnOu13Lt0NN?=
 =?us-ascii?Q?6fDCiMmP4cHgOGgVZ8UELGYGGq2WrNtHitke3aYBRVw7E6EwSfI2ImbLI3ir?=
 =?us-ascii?Q?l72QLZUYoFhkM5T8YcI6oFOhANAPjT3WNJihrRRjUHVw3wL7Yf+DatQa20EB?=
 =?us-ascii?Q?TlyMd3pKVF8ezQjAeb/6GQu0Hc+th34ZgAN498N+BeYMh8N/URjG1w4VHe/K?=
 =?us-ascii?Q?N9lmvb+NxPudyluBBY7gBmAiB8XZokg+f+1UCsyUmq5+CQfEXNX5rc2ePGU7?=
 =?us-ascii?Q?Ep+a5lKZds7nRfvE2Ba1xOJvDyyMHu7K7F5zj8NP/ae4DvFLwTGCz5MOxMVY?=
 =?us-ascii?Q?qROyadN6PHuR2yLaW9W3x+ILyMWu46lmc9tysD0hzzIfigRXib5RHR5thIDY?=
 =?us-ascii?Q?IZuc3Fkx2Rs6zntGzhcLxkh0hcZn53nsxA+BiyXplfQDnqNm4ijy1Krcywde?=
 =?us-ascii?Q?I+6PpNarhhdHxidZMa/0hvTadB3xCKGqnmQk1HBsO2mzSLKLmacjPJUEqQuF?=
 =?us-ascii?Q?t43+D0r1vfV4i6YcB+1umCQfschiDGuuJolRMq4qSEzG3eM7Yy40J5q9tjBp?=
 =?us-ascii?Q?/u549LApwbUHkYldPW0GhQSmN15ffJEmhR2qsczrzVpgc3BBHksOSOaPfu7t?=
 =?us-ascii?Q?9a9RlH8g6Tj7AxIuZme8y+Bhrx314ag=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f13eb-72be-4460-8f20-08da53066767
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 21:46:59.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQlocMkId+n04duJsHwtfSutvgYVLwacUhIo+PP+mdV0aZtDmKH6jN8yhvmHHzSlIZJ7xgETO6u7gjKzBoknpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 01:39:45AM -0700, Zhuo, Qiuxu wrote:
> > From: ira.weiny@intel.com <ira.weiny@intel.com>
> > Sent: Sunday, June 5, 2022 8:51 AM
> > ...
> > +static void retire_cur_task(struct pci_doe_mb *doe_mb) {
> > +	spin_lock(&doe_mb->task_lock);
> > +	doe_mb->cur_task = NULL;
> > +	spin_unlock(&doe_mb->task_lock);
> > +	wake_up_interruptible(&doe_mb->wq);
> > +}
> > +
> > +static void doe_statemachine_work(struct work_struct *work) {
> > +	struct delayed_work *w = to_delayed_work(work);
> > +	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
> > +						 statemachine);
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	enum pci_doe_state prev_state;
> > +	struct pci_doe_task *task;
> > +	u32 val;
> > +	int rc;
> > +
> > +	spin_lock(&doe_mb->task_lock);
> > +	task = doe_mb->cur_task;
> > +	spin_unlock(&doe_mb->task_lock);
> 
>               I don't think it needs the lock protection here. 
>               No matter "task" is !NULL or NULL, it is checked before it's used within this function.

No it does not.

However, Dan has suggested reworking the workqueue and I think it will
eliminate this.  I kept the lock more as a marker of where cur_task was being
used even though it was not required.  The fact that the rest of the function
goes on to use a local alias was suspicious but was covered by the workqueue
operation.  I tried to explain that in the commit message but reworking as Dan
has suggested is better overall.

Thanks for the review!

Ira


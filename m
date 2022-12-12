Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB37649861
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 05:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLLEWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 23:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiLLEV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 23:21:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F3B1D6;
        Sun, 11 Dec 2022 20:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670818915; x=1702354915;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IkJ6Gx5UnrfhuZJH2Jp5crgX7Bgzr6K8Waaq0MXkwz4=;
  b=C0OZ61gYcu3938YedClY/Nvl2xjw6q2aZiNWY3eClbkTv4ewMBt1hwOv
   7IMkOULDSwfFoQ0zKGPRcnnFPPBfu3b1lYIaBqI4issXibHA6Zo/FSgvm
   p572bxxvD6EeZvSVsFbphiKCvvVUmC3r/FO8EsKIUHsdia60DzvklBu/q
   cvVODo/tNqaLc/tMPklbCO23DcTtT4sURW84PWKBQCXgJvI5nH3oZDxfz
   Fx8qYmGweXXqS0m5rMgBWn93RhSWMlwTWFg2ZxtX9DV6KfF0POnbubJWR
   dIfy2y36/FcRduEkj8IL+BEukbYyKxOfyyLJPOECg9d8b4WbQh7JEKwuy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="319621459"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="319621459"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 20:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641612910"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641612910"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2022 20:21:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 20:21:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 20:21:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 20:21:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 20:21:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEz8jboeMSiu8VdZ9QQmBtbyBE/qc5PKFrc2/cJ7aKKI/REH9mC6YKzv308XgBnCPIlGhf4QqLDSIy06eYnKxnpZ45tryeeA7vFIq3MymPimYOcdfzdYINjJVN6OFiGp/0PIBll609jJUcui41FjCFwuNwCxISEj5Puq5v2+fXGSnx5M8M8QxCoyTkgZg7d0ggphYklart6iBmEnInR/dcbqsPw83u5q8cIbomI/8CwH5X8Bs4JWbfIncbQ1XAKYd1qRi+8oFjuhFQwFcKs2BRTJlFjwo9oCcSmKNVbI0LS4JAT44Lwt8gswZfyJs0/PuLRgrSJW6C3FkfdQbXmUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WrFYnjs8qTIiILSGHAsLIQsJ2CLOrSdl21DWgfR4ak=;
 b=RmUmT4wBl8XGkmKXgW5DM5lHPiD/HJxaT3+GtLeh0narASx2UxtGBW4vNs+oRQckE1M9d7w9NTphxsO3uusERCe9UkqYwT+tXUNERYCaD63q/0nGR+2qEUNoj+FTyAr+0lmijKFGCFBogFIXHXLlQ5wE4xd6hxsWY/IaydSmvKWFsWM5qvR2ulpfdM5KBfbNC89kzNsdr7iuD8JEZgjZQVHGNzKzkxVD6cEuYMbXT5N78zyT4oP7eEBIYrAKs6v8HkKgdHisdhxoFM8LslB0lyVPInhWV/G76+vyBsallsJ6+oyg2Z9zsc2juKXRh3f05SshmlDAoXtt8dyIFHHqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 04:21:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 04:21:34 +0000
Date:   Sun, 11 Dec 2022 20:21:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 8/8] cxl/test: Simulate event log overflow
Message-ID: <Y5asQ5d1TYRC9sHd@iweiny-mobl>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-9-ira.weiny@intel.com>
 <6393bc47d518d_579c129475@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393bc47d518d_579c129475@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 8582c441-aa30-4789-9004-08dadbf85981
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjlZmRL+cQGMkG6UHdM88BoFNELNDm4s3Kyn6+pifHhBCxOo+4qnHjzsmRgg7eBteIq3TshxFLKHqkjr6jvtHVCzNXi/TjMRDt03CQYMNfaJlZ92t1r5uMtr/DV/cGPIskcbDF3GE6B/AD4Ywxh/LX7Yvcm3lSDa0uN8CX93MIxpCRjF5W2Ibmgjqp2n16PdEn50wri7Z3nwGJcjdkrRdpce+KVX+qIBGOIioh9GJNUajdQGvJFPYyS2m3EMcrLVNFuqSwl0Iys4ppld4KfmZp9kBJO4NzZOGAPFH3uKOp2nhaa3ET7/ypTS8AB01TqilHOC3k5gUGcmwkBM3eI/VTymALWz/JcknEqk+pKyVMtLu14y+KfrT7skFuk4FpE1J6fze34idOTJaAtxpZDekSCsg41AXiM1pNiHSJbyatlb28m6UekcGlZTIKTJhTA2StJifKsNvRUci4sl3r9vPiPL00wKzjp2dgAmnS+PWX4YIS38+qX1Z2O1UQMVoaKYZXneJnx7azyEpLeNhkeN2HLwpmCbZcZLzmp0PdKvcOrDRqVdpYsJBmxSMGIksNAOQckrNCDmXGg1/xcun2cwRtGJbqJGVvXSwqF6E8mrAV0TY4WW5uEXAP5DHtU7CmZQ4pdN0/j9ySnxj2pLTp6/aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(478600001)(6666004)(6486002)(33716001)(26005)(6506007)(9686003)(6512007)(186003)(83380400001)(6636002)(316002)(5660300002)(4744005)(2906002)(54906003)(66946007)(4326008)(8676002)(66556008)(66476007)(8936002)(6862004)(86362001)(44832011)(41300700001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRDPO13P9+u/z4GY7QuRv5ZkDzEHrDD1oRgqp03NVIv8289HOiWfIWMkMCO1?=
 =?us-ascii?Q?kxmf07pePWKuhxKUF5Ol17BjbMJmCP996CCVSHtOO0qCYepba4lcFVvdPdmk?=
 =?us-ascii?Q?cCdtc5nBEjRscl4lSzsuTKBjk8BlwZQ7CKtOG0o76oEk7LtV7sTaM1OYtbg/?=
 =?us-ascii?Q?OsqMihqo3TPRFHQHr16/dkgWeK6CzfLHq9QfcTfslM9d4mEf4gfHxT19u9fo?=
 =?us-ascii?Q?4QCP1vZhEmmVfblnoDjw2mdsfYhkV6ZCTi7dbAgKq54axmPonKMUrz6N/g0u?=
 =?us-ascii?Q?SyYK5baQXsa/QS4f92GCfiSZweu1JEHsEX1WUZsjKvlvzwzvwhyPcTC8o0/L?=
 =?us-ascii?Q?YSqRM7nN/Us5p7wb7gj68GO9dH1fPQd6wYkyTPdrFmIq5pFc26zjjpg8BUJb?=
 =?us-ascii?Q?WtPoThGF2IW6HQMQ2zLzQVfG3i2b4tBpkzfxdvIdmnBLVk1kTU6TeqEf3M/X?=
 =?us-ascii?Q?qBk06DuYZeocawF3EM6pfZHRDytRo5b6+ORFV6jN4Dd620ndpQLuLFcKc30G?=
 =?us-ascii?Q?2CbGaQ6yiKirpMuqv2xLmD8k+2loqVvigkqfK5GsaCAlBdXB39L8mYtpcusB?=
 =?us-ascii?Q?F3KqUWbPO/cDWV4KiI9XjbTsOnd7vdcOEdHdaLfrfxjNbZvPjdn+kGmpV5pI?=
 =?us-ascii?Q?T6eAyvul0/Y877fKA2jcrzPeJpcoGu4ogL2Pj1iSjXOt3rwS7vpCV4L/GZfE?=
 =?us-ascii?Q?xADm3oLcQIviLExL752i9k/UYjXGHCKFObJ/lsWzBaGzjN6hm7AOicmINYJQ?=
 =?us-ascii?Q?ffBCSGxmo5B+crJmUqffuV5eigEKZuxu6ksXSiHpKBM2zDoWBCSYtUOVjLyX?=
 =?us-ascii?Q?+QSGT7woiQnLbuLs3IzgaDm4fbWZmPEoNKmfLgTa3pNAqEht3gm4FajvnuZU?=
 =?us-ascii?Q?YttWa8qqDH+BLoLmZ1hHps2DevS5qGTwQi/k7LLDI35Ii5/GtE8EIXe7wJKQ?=
 =?us-ascii?Q?6h4YKpS7laogPV49UEbTbnTPK5pJL3kdKfTHn/XoL8POlEJ4oFGg5R1TGk1W?=
 =?us-ascii?Q?UtMQllGhCuQeA3Dw2bAnLFIvvRTwg8cpYssrnYTLld8AbqSOhkSX2mVmKokJ?=
 =?us-ascii?Q?SJ14KRf4wpmcuTZdkWNyECsrMrJhs9Z+1jD5LVkEvuqZ2KmcxG3AiO32j6sU?=
 =?us-ascii?Q?M98SYRPeZ4OIYyTgYkQNQ6i5BvO125EC0OgV99QG6lclyhjP/CIuT5ZWxz26?=
 =?us-ascii?Q?bFRs/ujPWVvZ8oKlS588YfI7pq+FACM3oc/DAqmAUaNYfzYiF7mo7vfgMb6n?=
 =?us-ascii?Q?K9SNSi177HOwMElpmSn5szgG747waNpNt2M2Wy/REdQwUlLZO2Dtox8ZDuOx?=
 =?us-ascii?Q?/BdiiZ6ULxNVvUCKNrQ7tOiOv3zylcfQU5gaMgOI9p8Vtw8++8tpZdv8y8nC?=
 =?us-ascii?Q?6zTv9O3ffIKmBjHWSFvUsoyZ6HbrRNQgpbN1cJhb0MJqw5yR1e5aE3VPPa2L?=
 =?us-ascii?Q?dYf9SNfvK9z+AdweJGKqREGxitvUU5pnJUSqU+7gJJ39TKH+JEFeVziYhU2p?=
 =?us-ascii?Q?U56Wl7phi3GTniuCwpRNiOsrBGgrtHleZ92uKZaIMcpCzeFp0HccAiLxyfsR?=
 =?us-ascii?Q?yMSJO8RifIN45is7vneXHmjKPpsiFaZXELLiqe5G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8582c441-aa30-4789-9004-08dadbf85981
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 04:21:33.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NL/O7R48liwx7aXbaX6oms/j6c34Fj+XiEPVAtBMSbHjPvAF1a9/BhWJCT7Wh3Aqh+Y/P/nz4OjUhvnn1IFM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:52:55PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Log overflow is marked by a separate trace message.
> > 
> > Simulate a log with lots of messages and flag overflow until space is
> > cleared.
> 
> This and patch 7 look good to me after addressing the move to mem.c.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!
Ira

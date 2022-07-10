Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE656CC19
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 02:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJAuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 20:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJAuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 20:50:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316613D7D;
        Sat,  9 Jul 2022 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657414200; x=1688950200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9rrrt7i5m964o6L0o9x9Ls4nZ/Hn208RM91LvphB0hc=;
  b=gbfDoffCldGSM1rUW34OOZNmb4vIs6jUeA+4NfR6qVVr9AsQz309ZJqq
   0Tg6Xjtm453DT8Opq+9J1cd93XQiMfqRXwgq10qFMJavBaBC+2o8YQH0W
   kKEC2BYxBeM43F/kS9JfcYb6qgjiWAwjojF2XzI9MfRcP1buomlBLXTg1
   K+QiLzO+1hnzdlJcHB7HJUYjURO4Xykd8AzC1Yg9J4c+J4QaX6GD/fMVt
   Wm3cVuvoF99pD2XrvEDmfEGEzzKObROq5uc9snPvMAAr3mhqDtffVLOx4
   rlKlMh4pk2rfMjHNpz2vA72YAAZBCxToVK7TaZ7Nm6aeeQnC3NtyupWO8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283224178"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="283224178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 17:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="621659613"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 17:49:59 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 17:49:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 17:49:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 17:49:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 17:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiNKxrtXM+S6wKuJubzxrY3kUkanmAJ5C3jeu5yYZgGrN9sE9W/DhoZA5XmWb6LoiRJJC6EvkhRvU9L49ukebpZuBvIJYh4R5O+oCUTCv2Qap7EHOeqbJ6GGchbSniKmfOIWxI0tTWE22JGgurUH4pd8D8M/ZtaBjK32CQVEjqHcJsZiblD5V1V1u1QF/UbTaU/VJU7wipqK192nDzW/sUKF2Y8tHU3qxnDKA7GsJonhXIci9JGCYNJFRlmuCcDWjmlXJ9Hj+B54a0Elg5DVaXv2gJeQJJ99a556RjWgbT4t+598H0N4nTtKEBPvOeP5CzZ1sN93pmBBxZAMz2nE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SDVwOZGC9m3I1PI2stPfoEkk6TSDECVesMVW7Lln5M=;
 b=Uy7HbLM83STINCfmBWmLLlnVjEY7H3eIZfGCRjA6AI2STAlw+m+fYbpPmLmv5ylRYmyVzmDUKhEefhvEKB5Ndnz323u3cGi3QQ1oJT2mH7cJBFlccrypwXCMccH+t06shRLj0tYZ4jY/LDS3cxgaS9Hhid0CQbcVLG0vlZj9P9uiY2rs7ES7aj4AEkiceP+unqKjhxLvN/hymYxtEP5q4kBeeqPLe82IAxQBb41DmT5G96EEZRtKimPPUShFwGfgLm4SWIAuFziUwa4VOvr1p2sZh0+2AGSQhP8ERhCV9+oWghXcZyybo9f/zzd6znz7UXSVbWSJv3/PzeAiNww9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2595.namprd11.prod.outlook.com
 (2603:10b6:406:b1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 00:49:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 00:49:56 +0000
Date:   Sat, 9 Jul 2022 17:49:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <62ca223241425_2da5bd2948c@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
 <20220628171204.00006ad4@Huawei.com>
 <20220630115638.000021be@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630115638.000021be@Huawei.com>
X-ClientProxiedBy: MWHPR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:300:94::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c5cd872-29a9-4afe-7dbd-08da620e1b77
X-MS-TrafficTypeDiagnostic: BN7PR11MB2595:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +skop+Ikmd/2bTjHxv1k47ngHStMaXX4DtyvHiG4yyByieWttpdS83+15BZKdWvto4jMoItIGguhOW4BsFUTDyZpDiyhxFIWlCospf1K5+2KAxdC1gWUCO3iOJriaJeHne0PgAH6AoL3iFqG4eU7CzxwqRdDevUfjNSZpljovNf2ixdAmkflG/BWwvXlYMMiOt+99P+O0UVTOiyKPJfJ5y9PGytmVomPhrj1BwGMf/u80MRpPpbB+U6unQOHrLDLTSPhNkc+9gS4yHlZvPCECQDgbImC8db8TYIceZDB/U9mszRdDpGOuTgSOQJkyFLXaTtC4tgVKk54fK2MPtD5FNm8A9L6Nvd2Vsnu5/O9Yi2jQ5SRZFMjIxPbZLHytC2AdY9xMealTyPHK3k5EC4YhK1TPPVDQl6EM4SbXDbM/gXNHzdPTpVQkABdIBqjHFwbVMra9Y3ZQpiH2S41Q6rrGLR98a7cO8+PGonVlx5fK0aCg0g6A3MCz4ywVyQVn3kA20TSq8JQobAMQhDdrlIY6VVKsgBkMiV8Y4REyQdHoCFu3N6GkZHZNsfrSgNsoR5BRP2hHTrt1yh+LncjD7wHhjodL80jSnbgwsiar198L2xvlkDgBX5NLSZymk8Nchk/LIhW/XHMtA0xyFvGfPmWCytNIOwzAg7dvpMU8YURBt724CnyItZ8cFzWUv37buBNMB18sZERSMAxrzPBB2lIkdfF/3IgcErTomeZIgAdWZej8Ei6Qi1eOimGOaKlegfyS6zLLVxiZuimvOqreuzApg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39860400002)(396003)(8676002)(110136005)(66946007)(66476007)(316002)(4326008)(66556008)(83380400001)(82960400001)(86362001)(5660300002)(26005)(6506007)(6486002)(6512007)(38100700002)(2906002)(186003)(8936002)(41300700001)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IK1PkoztZnqfX6TfN7TuC/wIdjYgtzuON6IhwE1TxwHgacTACxWyPz2FiM/?=
 =?us-ascii?Q?gM0G1IiCzplLudVd/u3Pe7UkmgzzwzH8HVFzUyLGGDuuH62FTWRJNpwE7mHr?=
 =?us-ascii?Q?o5vI4RQq/ZVqnJEzV+TdtZx4UccbV41uf0Pw1UKNYM/Xz8/Fch0OakhiGqXG?=
 =?us-ascii?Q?Y1ASNeMMVRg3Cp1nG5O+azqt3vM2ISCEM8ABi+FxRqKMRuUJ/OhWnQCyin38?=
 =?us-ascii?Q?IovQB8V8cMZd8Y2ZVmpU53KnnVDciRuDvFJm3MylrDcSrBVLWyZhpLwEwYx3?=
 =?us-ascii?Q?nzDqToW9YUK0adYsjv/1uk7BQRGQ9QIEPvn7LPu+ED8+d1WYaRMeXDXgHLto?=
 =?us-ascii?Q?I2HHPag9wWDIm96XZ2G88CUykPjJsEmLEaruEBwYqDJJLmEUhsPejjQK+YAa?=
 =?us-ascii?Q?w8JNGSDBMbmD0rg7T1rd1X/ZLiKbSVjhgELWgeLZ4o5rmtd7MRAgWPTlMRNV?=
 =?us-ascii?Q?eICJbQsxRKjJ6ENVc/rGOaf56otOp92o+RXQ1X5psG7M+fVADFsz9N/zir0g?=
 =?us-ascii?Q?o3PqZyqPbJuK3ZaxRAUecfpimpSnQuVCh39diCL70SaEfsAliSqkudTDPv9z?=
 =?us-ascii?Q?LTMYiys77w7G7LJxysLQ+qYxkBxWn4ohPfw2paiThmzr0ppq+mwIBCUoLP1e?=
 =?us-ascii?Q?tTHGcag1LseuQnwFFUoqUWaMMtBSHUgFkIUj9EBACNwodxFto9C3z4OM7kEa?=
 =?us-ascii?Q?LjQgDEDCUjS8j64mlKYF318vu8P3mtW0qFMYo7byOu9qdGWJ75gjZkXQPNQ/?=
 =?us-ascii?Q?LB6faZF+bebyOdeeTjVTRKzHT3x/oJf/1ku53JfEPQc4o1wynqDkNibXmast?=
 =?us-ascii?Q?9c18DuRxDzesveepsbm6IJl40tJk3Mw7eKBzhT42T0vRcUVW7eMJLkDus5wF?=
 =?us-ascii?Q?fxSKf+nwOMz5IId/NjcjQPem+uAoWk/YNqYWs+iL0TiX7BXuSVRLoBgpLvTG?=
 =?us-ascii?Q?98mXHkWJge8Z2TXantq2mwSLHo8I5oLF6omN2eyB80YfraySz7W+ls5SwKUL?=
 =?us-ascii?Q?H6MKnwphoeXmq2glc2c67M7SdeV7oQfEwR3Av/ZyD2dogMgWqsppBEIszCPD?=
 =?us-ascii?Q?ft6JDgkhOhOBU/1MKFbLAuOv7t5SzcFcXxfwxreDEE8a2Coqa0kKImmTWDKP?=
 =?us-ascii?Q?PAgvq6STeIORbNSqol8OWhxxYEcwPcQAJWp2eneWRLnJJe+jmbtf0z9SUQXn?=
 =?us-ascii?Q?4Q6jOe3/2g7EYexidprufieC3I5CYxipKo24UeIljNxAnlh1f4kknYGp3myd?=
 =?us-ascii?Q?ovxYNmZ+1K/YADUYrGignvp3dQtQNr06zfDIvoi8HHxLKxaRaz65XVl8IHum?=
 =?us-ascii?Q?DoxTpFFaWBfXA/HjVKo5X5OyZd0zXE/m8GtjqRWXks3sA45m303z9v4FW3Pb?=
 =?us-ascii?Q?TIwHtXBPgzGgp6JU6FjelJjMzVsmd3fKSGW4aFon5c8MlmO8n/tclFPn5gbW?=
 =?us-ascii?Q?ZGDa0WXIvP2cdjLGN8ky52utZyHsJbvmZkV5u4DgV5/F3KVS7LqV6HKbqK9J?=
 =?us-ascii?Q?BpkJI/JMAEy3KTQS4DroUNMn51j4oKejmmPu43ffLoP6GEcZt76hh63Y2zke?=
 =?us-ascii?Q?tkRvVdz7j1TQyEfdu5ZwGUVk/DHZnFZ168cjHhLPck4fykirb0hmmQOcTUNo?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5cd872-29a9-4afe-7dbd-08da620e1b77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 00:49:55.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnk1spdDf3XcL7kgEbcrskp+9YX9JttJzxlPPY71u6YgBCUmEXrlWUgHyQc5pS/lR9oxFjsysSg1yIx6pdRbkl6wxc7XxxfJDiOmHLn+KpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 28 Jun 2022 17:12:04 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Thu, 23 Jun 2022 19:45:57 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Currently 'struct cxl_decoder' contains the superset of attributes
> > > needed for all decoder types. Before more type-specific attributes are
> > > added to the common definition, reorganize 'struct cxl_decoder' into type
> > > specific objects.
> > > 
> > > This patch, the first of three, factors out a cxl_switch_decoder type.
> > > The 'switch' decoder type represents the decoder instances of cxl_port's
> > > that route from the root of a CXL memory decode topology to the
> > > endpoints. They come in two flavors, root-level decoders, statically
> > > defined by platform firmware, and mid-level decoders, where
> > > interleave-granularity, interleave-width, and the target list are
> > > mutable.  
> > 
> > I'd like to see this info on cxl_switch_decoder being used for
> > switches AND other stuff as docs next to the definition. It confused
> > me when looked directly at the resulting of applying this series
> > and made more sense once I read to this patch.
> > 
> > > 
> > > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > Basic idea is fine, but there are a few places where I think this is
> > 'too clever' with error handling and it's worth duplicating a few
> > error messages to keep the flow simpler.
> > 
> 
> follow up on that. I'd missed the kfree(alloc) hiding in plain
> sight at the end of the function.
> 
> 
> 
> > > @@ -1179,13 +1210,27 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > >  {
> > >  	struct cxl_decoder *cxld;
> > >  	struct device *dev;
> > > +	void *alloc;
> > >  	int rc = 0;
> > >  
> > >  	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> > >  		return ERR_PTR(-EINVAL);
> > >  
> > > -	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > > -	if (!cxld)
> > > +	if (nr_targets) {
> > > +		struct cxl_switch_decoder *cxlsd;
> > > +
> > > +		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);  
> > 
> > I'd rather see a local check on the allocation failure even if it adds a few lines
> > of duplicated code - which after you've dropped the local alloc variable won't be
> > much even after a later patch adds another path in here.  The eventual code
> > of this function is more than a little nasty when an early return in each
> > path would, as far as I can tell, give the same result without the at least
> > 3 null checks prior to returning (to ensure nothing happens before reaching
> > the if (!alloc)
> 
> clearly not enough caffeine that day as I'd missed the use for unifying
> the frees at the end of the function... Just noticed that in a later patch
> that touches the error path.
> 
> I still don't much like the complexity of the flow, but can see why you did it
> this way now.

Appreciate it, it's much cleaner now with the nudge to take a second
look at reducing the complexity.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F806F79DE
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDX6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 19:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDX6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 19:58:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39B8A68
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683244721; x=1714780721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uwg7Te+6lobU3p8/oEZ3ntkrzpsfCxmF228eEZJcFws=;
  b=lfUMhYpuqy/cG/gNLqOe3CNUdPDEieVga48O53Q2zjXSfbUvtulOXLhj
   tgOS2VXLQpgbqKbuFNEdPjiquc5gq+yi/r5lKiJO2qDkuvgTRo0BKWAEI
   RIZEyvhxhi8lxbOyb2nitTc3BNIFiPsf7BCan4dPhgAKYokhgNeOqqAIO
   M1jBVx52g0mTYoKCV5tbCKk53DNYhyTRtIs1Ob72YUQJpIKfTmuY+Zmrx
   /P9XKSqJ/q63UFmbTJyOXvyMBA8hEvjDoZpEZLzTKbCXCnapmuuwkDDH+
   TP6EIRq3p8T8kdju9LpmoHHA5PrtDlPnhEKL7lWyDP3A0x4iJ2ul9kC05
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346559669"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="346559669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 16:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674777434"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="674777434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2023 16:58:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 16:58:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 16:58:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 16:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoV5HA+WdQOBqyNs2TgomzDyKR0g6NKhCg40Nbl1GTUUheKIo0dAzpXJIU9H0XrBaVcFOZ6SdwmlXEZF9KgvwLoGnnQnmKxmWOe9OgQ+Ra4RGHaB1yhwHQp4iD8HUwPpZ5tvmgtx6tR5ZnWIjW9HWavEb6HvllFGZYKajmPcXt25H//hNksqg/fzD4XQlV1ijPtIei8ZQYdcPsBX4RsRFo9UXh0wVts6mCSTjBT1lGh9cYFP44XVCNBohDotzFVr28r8DkCq3o2samxSuC9Ourw2/LC/Wwj34lUFkY6aHaEbefzQBx9AiUdvoH2u4fAb/ouN00gvFbRKTsC3LpbBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwg7Te+6lobU3p8/oEZ3ntkrzpsfCxmF228eEZJcFws=;
 b=PlZAV0P/MK+iGPgJ2UhRf5MQeSmXoXdtbMqzfGzCqX74MzL0p5CME0qtfxmP2Oy4Kh9UpIZ7gBabXJQrnA7j4YVXfV/xqHvDIwkRY/DNFzFPIf+vSnUOMnJhC/AGF2YCfOVbGOOFNMwvpLf6HFLtqRgNY/evDKEhLxq1FGl5ceA5pqsjTk8vjS9EXgQAewBtZC0v3/GGMT6ZsMh6jpJsgZzwQc8UwCOpYBHf1trvrstz0+PcSNGhHaIYDu0buaCsXOFt7vjhARXmwO/ZStsnp7Kef0AsL/suUoiZLuUs9Xma8k8nqFho7UXqCeKk5hStHamqJztDwSG3UNKBSBDStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 23:58:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 23:58:37 +0000
Date:   Thu, 4 May 2023 16:58:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <stuart.w.hayes@gmail.com>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH 2/3] misc: enclosure, ses: simplify some get callbacks
Message-ID: <645446ab23922_2ec5d2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
 <20221117163407.28472-3-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117163407.28472-3-mariusz.tkaczyk@linux.intel.com>
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6a00ef-5fcd-4726-456d-08db4cfb7a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5vl7naDfLbXRIgD5DEgGgPhLvomyuSzoomMZQ7MoXVWrxLPqfBQYEKQH61oC6XEbr7/2EpDjLzx2ma6x4xgtns8szME43iJluREvNUIJCa7GkZVfS5CX8okDs0VQPOWDAvxs7ascqNAjr2NTEnjCvIRZopk2rA+pzhOTZmifIO4P3oHjVuGrZFksrh8SO09WTJfQ+MJdAJJtT5lsPM57Q6Ub2QpjfxuT/xoZiJAs9SSIQClAUupw0ym2WyTRsFTYVynBja2dzZ0dIca4q8g04dt5NmbYEMthBXigRzcCPyv8CmYbX5dsuZ7w4hP9N+SsuTgUtinyQitSDS2tzSgCrCp7GnKx9GMfS9MRzeI5a33p2UMWBM5J3c/TQp4oGcA0EVqb1oHhTcBErY1GPskdbNlIv/j40IPvLYbf9E1VfA72DgOMc3EbkXnr+F1VZbjDFjq+V4jVlI1bnAXNn1P4GBihEM18vtAI1hzDrN2/CS6JQl1UN0UXKpZCAbQmYKy4x3eYnP2vbw7qoaJ7Q2RaNQ76NA6VU//Yy9HHe0TPji3DxJzLW+hcIkJFm0/jd6z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(478600001)(4744005)(6486002)(41300700001)(8676002)(2906002)(316002)(8936002)(6506007)(9686003)(4326008)(66556008)(66476007)(66946007)(6512007)(26005)(186003)(86362001)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULYz7/Sxf8ivFaOYIVOWR+OUnVD9jNMQ2bB6mk+esg/HGjtt0mpAEFRgCKY2?=
 =?us-ascii?Q?HMfvah+3aJE7yKhnHEvdfjp+CfQ7PZMfl0S6IBs9R4ht8H+jgXg8X1Rqr4UN?=
 =?us-ascii?Q?veKQad1rzTUJ/RuMM7ZzuvxCRUtIEl1jL2sTj0zkEbkPG1s03Vi83DV/wlTW?=
 =?us-ascii?Q?3TXg1OFiHhDUw+otfUoCZi52LtQ61I5ovFPSvMowiysp2+Vwt79ZUg6J8Fg8?=
 =?us-ascii?Q?N2qqtOBvJFBHBT627zlB9dmzJjHoC+x0pNz2D2iA83la6FMMZOeACQj8AwPZ?=
 =?us-ascii?Q?VDGbfmMFiBOVlkRuLZlzpP0Hn4J5koQqBEDj6AoEXh+9UxX3E/wxrY3uVBfY?=
 =?us-ascii?Q?M3S6JtVsKHZ/C08T9sMufG5v9YV/gQpviQeVSVBVk43vAv1DqB4VyzvqJAjk?=
 =?us-ascii?Q?NBa4MH1YQo9Mhw1si5q1Do1tjncjlJK4jyY8yuoHbxIPdaKmPyL2ekeqw/mX?=
 =?us-ascii?Q?bBLlnv1RnfWSBf6fg5q/dDj/pY2XEXf3ebC2eEAtIwiyzJfZBTyvObnlU7qE?=
 =?us-ascii?Q?HYXB/VKzunHQv3/1NY93qs8u6DuK+1vFNDQ0TU1E1vegSAWdfxBguyz1/zWv?=
 =?us-ascii?Q?FqiGv6xvWbpBY3VEWfhJ3IdwQi+JkgFYlfVrUbcPNMx8GJof05m2APqBkfYI?=
 =?us-ascii?Q?w58IXp6PsvKbUjl2t1q2H0iO3YPMWcviTfqTGlJMf7geTIisLmvRPS2eeEUJ?=
 =?us-ascii?Q?8z9ulBMTkwSqE9cKl0g5frcBMB161tMNL0JXeQVKmO2CLGNzBZmIbbeljAgx?=
 =?us-ascii?Q?O1wh42ASCGoSzpvIiA1INnsW8aLTmSJ7OYVHpzh14kUd+fUn3NOMDcBUg2Zi?=
 =?us-ascii?Q?HlUCAgpsvMBOGb0JM7cxSZ8XBDpxaof011SrVjwCfwNViJNtworZq1tU0e40?=
 =?us-ascii?Q?I+2PN0oDHsMiLULO4cX5/EdraaaNv4N4eandCLUaYtn5c82A1vTkZUIHJEYl?=
 =?us-ascii?Q?4h83MRMMVXQZWescMl51AbzZ19T5n9qQL7xQ/jIcKnzd9VdfdRkzWSxK7GxQ?=
 =?us-ascii?Q?CfndHIepGEE8Pwb7NccTYWqBsIST4CRX4lpqMKSXf4TMdJkWqmXwXpSTwsji?=
 =?us-ascii?Q?d/gjPmIQVE6Sqy10AKQlx2y27huQ8lCB0ArHp7D4Nd54oZ2ge5kwBwYqu1RM?=
 =?us-ascii?Q?BRhfMaMwHGvEfCQIGbiOQhThS7b2fscSwpepCcYNPG29LzgTDy02YQ+E7Q0+?=
 =?us-ascii?Q?FVHInljib/bH6B4RcdDZhbSMqrjJke7Xa/T9bpziUzSHlp7kFVh8EPTRP+UY?=
 =?us-ascii?Q?COzuHrbK6wt2hnjz7rZD6dcv7O8P/DXjWEKi7RMfkIdl6HsiDJIlbSWjGZ5H?=
 =?us-ascii?Q?0ZmbFch0ZK67tyzDaYDpTWh6A8rD7FtlTQ6R2BNgERWoz1JGgDoy1jcHtMwN?=
 =?us-ascii?Q?E2go95kbVLQeDZlMAzI/j61AieYN6EdQZjn0+u7cQZa1rLMjVJagFMI9iV1B?=
 =?us-ascii?Q?aSOb9lvAJtf+VOeO9WA1OWMPik+3XP0N4YH+63x+IHC9/uWHzbx+1tVFPfUW?=
 =?us-ascii?Q?/aNhlg2itcj29IUDKeRDmSx+zj3ClNvAjSHRkSa9zyt7PWwIqGNd/kgrihUK?=
 =?us-ascii?Q?2EEOKzbqvE9X0D84dmWkJtm3oPnz17Qmikoi09/qBv0BHkIf7wUniagzbky6?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6a00ef-5fcd-4726-456d-08db4cfb7a02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 23:58:37.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApPCIShwZaNNNRLYyZox8FwOQXP+4iJCht/vlp2ykvg/W0EBedh2SwDO8pg5R/f2Vnbks9d/4DwDneshGe3gPLchVx+JehYz/zDs4U/WrF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mariusz Tkaczyk wrote:
> Remove active, status, fault and locate variables from
> enclosure_component struct. Return then directly.
> No functional changes intended.

This looks ok although it's not a clear win on the diffstat. Does this
make the NPEM implementation easier to remove the indirection through
"struct enclosure_component" for reading fresh values? That would help
make the case.

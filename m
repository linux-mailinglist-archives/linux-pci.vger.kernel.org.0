Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DA692BA3
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 00:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBJXvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 18:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBJXvL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 18:51:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E6BBA1;
        Fri, 10 Feb 2023 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073069; x=1707609069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GocVGuaVlJurE0k3uweX2YBE8OmlOaKIPNpy/xnDJIs=;
  b=RQeCyp8JNAJnZmI2gRj82O7A+EiRWExC5Bfql1NrTgRlAGDKvCoFuARu
   CNRWYBhUXNWigg+5U9IAyIQ47SvGFE2jd7dvqUTjnG8GI3NqebF88IYzw
   drDVBJKcE373y0wbqrfXRd3Qd47esKPbLv2IJNaVgTzdoNZacSb8L7vqh
   2PBd4F/u53LwZCof1DzJTZ9jKdFQpwTHKVrrSyyePByW5l/11gRru5TX8
   x/4Azn0+IUd7DHg/B10lN2MaHIG9l3QV3PJVVZqsYO4amTO6kohBXIFnB
   CTeuXLLmOk4rnu0f+ZD66sfnxfRCypyYWwxJzVIeilBxmYWBtGDlRis9r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331861171"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331861171"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756951151"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756951151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 15:51:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:51:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:51:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z58MTLAbYz0hKYC1vjlBF4+BJ9/VIjWdthZjXw1RzPU076oTESFyoldhHOQX4RZ2SS1pRE9mDtPv2UsmPcchHCAfuSS9tZk8F52Qw+UgLIu7LBo27MnDQUq59FDkXqei8/S7XDrr7PsgMMREJNqv+CgjCtjkIYkuiEgaXVkWqkKm/54upM64dlgxsMikd//r5Wl7ndBEP1B5t5aAexQhWfIJjUMgKi05lhncr6PmX0E2mQ7s2PeU9STfJrUUlsgzPvkfk5CchXAoaZE1tnqxO0EASW5cfx/ypddhZ/FlVBKNUlx7LCHFeaaeCRSw635ZzrIFu92MBPxWOnuaCyXAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEXRDupCzELSOLEkJaWYMxPRHGciF6l+tA1TVkn486I=;
 b=QVKK6NG57jD2tElatIqnoOIdU7wMs7ayeZPFuNHnoezO9/H5nUclcnCGrqyMYgJ/kg347kTEPOmtQq5DGNBXE8wW+Zf4wojzroE0Xf+j8miI4ZTu4D9gdxP6YKVz4IHgSB3c6p+6WzAT4Xr1PZrbOKuiugBQ6JvJMujs1TctixF95M9jB6YX1XaAplvaIw6XQukbIlAA+SbmaVCD0JQ8CFwhE1SzG2VFQ0q3RnD53IOa+/QKQB629FDq5qY16h971TxB5+KyP48RnItnIJs7BJ/GIzdexZ1yKBFHRUDUuoGlzNBXoDI8zqT6uf8Qv8ghAJc6v8/F9nwMkTf2JaA6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Fri, 10 Feb
 2023 23:50:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 23:50:56 +0000
Date:   Fri, 10 Feb 2023 15:50:53 -0800
From:   Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH v2 01/10] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <63e6d85d5cf40_1e49432941b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 0442eae3-0f92-40b1-5682-08db0bc1a6b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zC6+KNl6Cw0C48YK220D7zc0N3bW8x58OLgErzSfI8m3WfzqlHus2VL+KCOZgVwoRLBkltJrhtVHxLM6RabjpY1HHDmLjmDGynmOcavmK3W5+TerifTy6vF11++woQL1RXTj9TUWxt3vfvRv0w81XKGdPFXff1gFxKTwrHk1xv+De7Ej59v2PcOdJR1DGuqqGKHWe5qoCDII5D7xBLib1irAwEzGop1xXCtF32nrQ05sleM2JBNZmO5ClZdrCwMIB4ngQVt9cePZRfGGCmmtOz2vNSmGtPHpSN0NsLImpg68lZGVmW5PrYRW6IixZb/BWehpo/17oipxmfTmUug98PGN5cyJcPNIz7n4UZd+dZOip3TNpVcAWZhQNMBQOU6Q5/VEbCKZ0Vxn8kPVsaPcUGzqWyxIIFyppnEqI7J68VGK+VXcENtfx3k4VWTSo3X+DhlhLGLAcdyBzrqhk736FFdJklxNw/wrwIrzlfNj2uIo4vhszbRwbUMFkGbff3/5wYrVTNqwg1nLVvjFJYr/GJwJPDtJFQ8ljQWUZzbg4jcGex6PwOjWV+nGEuPKXJIAz1UFabEWNrssJuKERpKCNuvWkNXEH7x5HBy8FLHzZsgL46quuMKUMlujipRwN9Id6BSH8r3svREK1QxGXSqpU8VdQqgG8+CsFvuBMrEU+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(6486002)(8936002)(9686003)(6512007)(966005)(26005)(186003)(5660300002)(66556008)(316002)(8676002)(66946007)(6666004)(41300700001)(2906002)(83380400001)(66476007)(54906003)(478600001)(6506007)(110136005)(86362001)(4326008)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/joSTpEbCEFYEn/YNEB1YZ348bO/p+J/M0MGdjNw4EhW6C8hjeedhdIh7p/p?=
 =?us-ascii?Q?lPsRA9iVA4uaunR6nKrIF7jXC/fu6vOMV7TKjznMfwUQ/dG6203s5in5NLNl?=
 =?us-ascii?Q?dr/jy0Z3/hzxasMPyctp6wa556z9sQBxc+MfzEkq4YU0Qv5S6MXwoVmCeJGn?=
 =?us-ascii?Q?IwrF78V37CYRgrDiw9oQX5UV4lJvZ8r+PQVPq+GTbeOPPjkCnLXiJQkYQfkH?=
 =?us-ascii?Q?MJbEmSdM0iv1uCMb3zfv9WjMAXqJny5B8WzTxRtXHXG+H3YKvUXozmncndJB?=
 =?us-ascii?Q?UdZszN4YTCKVID1NrRk+41Bawm+dqXAyUtsipC/px/j65RyqaJyE2PxlvsA0?=
 =?us-ascii?Q?cq21JxrV2YhTQ5GYexGa2iqE59LNG+dgsSOlxU52ZPaprQXEAqH37XCtkWX/?=
 =?us-ascii?Q?elqD1bTZdyVrny81nmZCQVQkUw1sS1yMFNHxN/Q6N/vK6xH3SNoDFmIamS7K?=
 =?us-ascii?Q?TSZBN218gAZrhFp4tPOcJNTbCuB3zhXdcF3GHsNNgFHNOD9j/EJ280f2m/bv?=
 =?us-ascii?Q?PWGgfukld5jsuAnXq9UZNaY63v8BYInry8mo8h4B4QAxXEIJJgAXxmp9HTH2?=
 =?us-ascii?Q?RSVlJoHJYDfOV89x+sn91zoi+1h+/iRWEvybyv3pMApKBgxO75/cVS1laigj?=
 =?us-ascii?Q?rnaMfO+m9PypYMfxWzPNEk1BESSq2ybw4GxNQRX+bA4EZG1cCrAvKY4yfHWG?=
 =?us-ascii?Q?pNewZZAnrAYOoR2I8BPpPrHSFiW/uYOiw+dBylH2kMmdY3hYkfY/nhTUaYeg?=
 =?us-ascii?Q?OE24r9cqp19CJZrasOmwrzIdg4P64OzX6f6RcnPkWmp5rKQSf/KSuL34RD9n?=
 =?us-ascii?Q?7Sd2o9lx5W9zel1L7vDCWHH3XMHzoKFj7HbQqetkqsEmgBqD2EsVOtGX459P?=
 =?us-ascii?Q?TnNROjDsrYvzmEqrELgeTYZXQvxMBQBVexn47xsohLQInAXJqBA167CnUPO8?=
 =?us-ascii?Q?hWZFVhyvHAaJo/+SsX08/9TyslYbfk2lssKx8rSQS/H3FYmB+FtIsmeDxoFn?=
 =?us-ascii?Q?2ikSF/JtNMlLjwNRXzo6V3zV7G+YO8ong/e1Je5VXmCerFFNzhmfaywueK1H?=
 =?us-ascii?Q?ffsda3RCYS/zFfo/ddWo58CI0/uYb4p/7L5kHikiP4WDsf6DuZrrX/CzkEJe?=
 =?us-ascii?Q?ZDP7zRdH74miRzO28ooq1j77brAZNi43ppZdzxGLJCp5N/6UWJu/PePFUdza?=
 =?us-ascii?Q?5M9jLjVg3BFyq3NPZVDJ2DDmiwxul11SLRkFX3w+zVXALxJNcEr89+QqKFNW?=
 =?us-ascii?Q?iGDJXxOV2aWSBQs+vva+BlF0faQNi6spCwhwzUfNB8lEwRMrdBrxstrZE4vY?=
 =?us-ascii?Q?miP6+sr7ILirZRZcAXwYPwaGSZ7BgcZNzA3jQCHbHptku3q550wwp9p1zFxk?=
 =?us-ascii?Q?yHLeW64NgqyPKW3tYTgAe0Ss4Czf7Xbkh9ts2v6MHyREradW8yshTGHFWxtK?=
 =?us-ascii?Q?SYCi66BRezZ/+t7NBOsygNABwsHpuz0IB6sBh/By5e31hwPAVijE6840aXoZ?=
 =?us-ascii?Q?AABysaaMVt+uBmQ/qAVvHVpPLtV3x1hc1bFNTbvkkp19pK+sXyssYGojpS+W?=
 =?us-ascii?Q?ThupN1jd8otU+qYaPoSLnuYMXWB4VIu5gADUeW/AkOIi66flkJwBkEZh0K5Y?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0442eae3-0f92-40b1-5682-08db0bc1a6b3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:50:55.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUEF9NnQ6aJYnaJxMxYopphbM36lkqP70+Mh/14VfASWIUpgnEF7zmXloQvClrTsxGg/V6GH/Y9zm3kF6jqvdXC/Qp4+REns7VNGf3Uy7Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> 
> All callers of pci_doe_submit_task() allocate the work_struct on the
> stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> short-term fix.
> 
> Stacktrace for posterity:
> 
> WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  pci_doe_submit_task+0x5d/0xd0
>  pci_doe_discovery+0xb4/0x100
>  pcim_doe_create_mb+0x219/0x290
>  cxl_pci_probe+0x192/0x430
>  local_pci_probe+0x41/0x80
>  pci_device_probe+0xb3/0x220
>  really_probe+0xde/0x380
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach_async_helper+0x5c/0xe0
>  async_run_entry_fn+0x30/0x130
>  process_one_work+0x294/0x5b0
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5CE692BA7
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 00:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBJXwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 18:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBJXwh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 18:52:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6D79B39;
        Fri, 10 Feb 2023 15:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073154; x=1707609154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B0jyx0WsuItmI/fVYhfe66/ZngSA0Jb5M5CZnW9697w=;
  b=FESnVpQ6c0/oULmE4ejmmLNR18OH+8+xdiGW42Tou0FeuZ3hL6/f7RKH
   +AbfzpSwFosl9eEr1rs2lX1YkFdWtxoXyQWAANxNh/7Yh7WpQPoy/XQC4
   c16AqqA/yvGQxUh5EbzK/fZjQMjlmWXuzPSelNBVPhenQT8LtshkeESyp
   eh/zWnN5ufpxcQ2YFr4AwLUxTFypmO5LOdTKJhHjQxwcCrbnpku7xFNyJ
   v37/TYWNwhgoQk++XgaBTqRMzPHGwPjCnT5zaEbCgEng2QXUNmHixgwO/
   QFiNlF5zD9X+lblaju8Sg3GwPtxs8o1KlJZLW2Yj+Ga4YsqWIiqPxnQO1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332697330"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332697330"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="736891574"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="736891574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2023 15:52:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:52:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:52:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDQ4oqpqOvWq42q8xdBACAvhCy08dSOTssQUe/dkrmu9Xz4USTSgCuloFs1MJPA04MdgGkoJfFHlobRI5L6uBFvpilP1YuEug8Wjft/TlKUmImx04SU09ksgsux/rDUtuAj+5ZnBPMl0ob6qGcZ0rM6eEeey+2Lf9hDocSZngzNfNDKcpgRih5L5mwAuZJqeePGtso1r+ZM30rewYCsTh88JmqQKXfHyvx1BsQstrgBuax/qyq8F4kki7ze6rGwvYMJJBYlNWO9y3is80SesCnLDXQrrdUnCjmRZl4IMNG0Eojfz8hrqRM7uUSfTm/UMlVBlh6SZu1fU99WytvUV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTBzL7OJDu4fFEaUqgX0wAg+9tnbCsBIUernsjp35kw=;
 b=mXg+UNEL6XN6mCv7LRtEhRd0+ekTrYsYyuZY1KDVQRZB3sMyGZyEPblUMD9zx11E0UI0CidHk636yc0+EL0gDh4n4NWi5l9PSpQvK0yVc7rhg0fhz2PzS9QWrxt2FIlmCuWfq+gNRBu/MFEqnb8MF7Z3MgHNcj8ATDgP6FVmjxBOK2U/9TIZULoG92PC3/0qfbiyw9ZanI7VzjQwVPeUlRxCKJFCsB/NtMPDgbXVrzIIGI7wvLfOXVZNHa6Dt1QgM+OMZebGwXBBI7xHQGWiAGLu1/KgykDQ02jvf3BNFU/4zhLmD2o+O8ULjHGko2SPfGxl4r2oMzZjkZbS4zVNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Fri, 10 Feb
 2023 23:52:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 23:52:30 +0000
Date:   Fri, 10 Feb 2023 15:52:27 -0800
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
Subject: RE: [PATCH v2 02/10] PCI/DOE: Fix memory leak with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <63e6d8bb89015_1e494329482@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2babd605-be9d-4cd6-c3fb-08db0bc1defc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4ICnIzQxiy4p76ogP8rNAVuymq/aan+pR2ku0DvOJmGWv2VPG54TL4QvmOXDZ8oheDRVLVNcYBKxhCSdXwXFj2GIarl/zRjMyuWlaMOAIAtJuRVlPttfmm1U+I9k++YIVa4ggT7OUzCVcIeDbwDNbLBeh6MJjxCfJuxpzJk5EjNxItnPU6SnUlKbqbD6fkSaGJl/M77omdAW0JTjPErTqRfCzup1DsNMFPDjhjtaFlEC1nR8hLYWM3NdIJdQAro9pYKWPJxSlG6XtciIn5eQ5mZbSMi8XXwDQo+vOxkWkpEC13ApyAnPjjS2vwCYxUjciJJjprQqQfJY/XQMbruYl8rE35Minn0WlicLID/r0dLAHtfPu15c1KecUjiAqrSNfRrKbxKrdL9yPc+MtgCHLXRsDDCvna+Po5qEG3/Cm89P3/FyQL1qoOGsrDT/aPXq3R8PqneHtoAQQv0n0z+CMSRs2Lmv/hcsa/s7DHP3esh3iyCIG6uPl7PrHCOLjvEHXoGHqm8rvp/uWBp/ymHgnSv9HoTlC5/2eKX3x2U9mMlAMKP2nDMeKCbtzOJs5I+wRSrPYQ39pQ/pat3XJq8iF4KTagEBM/dRrs128IHj5/KK/I0ooWbec0jfQ4HlDW8kXh1DgiZoSgwzVOkp+LdNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(6486002)(8936002)(9686003)(6512007)(26005)(186003)(5660300002)(66556008)(316002)(8676002)(66946007)(6666004)(41300700001)(2906002)(83380400001)(66476007)(54906003)(478600001)(6506007)(110136005)(86362001)(4744005)(4326008)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yW3Lu8MPJ9nglYQL3qoQ3mcNa0lPiJ1GYIQWoXu1wLj6Ey7bBwBupfpZ+OZ?=
 =?us-ascii?Q?i/sVaikDlMHcvcicTCtW83g+WGqWd2KOjm+Qz5Wnh/vJ3QK7LPDz8FAVnheD?=
 =?us-ascii?Q?CRlRCewhuIXCOsHJktaZxdclkJsR/xbkfeg5QrR2cMquBOgP4CfOA27D81jd?=
 =?us-ascii?Q?8nOW2NTw2YCQn9lZFEDhB1PHSzoZ5mQiWso8GbCMiA/2Rsm5kiZYshaS+aaF?=
 =?us-ascii?Q?jA6xwIma1ea+4mjBv05oJv0Ydjt1PLMZPSX1gVqyTqYZRTOFyizvknjvcjOk?=
 =?us-ascii?Q?Mpio1DLnuhJ0/a6g5OSJrj59X3Y6TDVyxM3dZjDikAnI0D5vGsbWJrRYc6mE?=
 =?us-ascii?Q?verp3/grKiZQmlEiiKDhrd/tfy10tkgn2x2NmF4Ev01ZxYM/NYdtzHLL1OTJ?=
 =?us-ascii?Q?OIqkbJzzIgzmDM05oWpZOkiFy/4Cc0y1kowyDeCDM1b9da1erJeaobg35ZuG?=
 =?us-ascii?Q?fxyYFOzUCupBSLbmEt4PdQD7NfsTW2bV0X2zh9eHM3yEYT3BYsbqp0O4bueB?=
 =?us-ascii?Q?OiamSChhA/H7MWNIM3cycP0gWDPiW2oI++lkiAKUMNCYxWoUhZ4vWsMT+kEA?=
 =?us-ascii?Q?//zJHrW0ZxvAYMmIwlGBOTskg2XHXnUxRUxB0KnjGd4apEHszgQuK3d7M+JK?=
 =?us-ascii?Q?YaKOIYeCCixWwMiOM194N3nnCuArUUqV2sy7nMBExoVG53FUoyUxjzBCv0Dw?=
 =?us-ascii?Q?Qckoq+x+pKG1ar8GKhyCoI0VnOw/fwlSyF9f/cKzEnKXmHoctUFGWraQrjwK?=
 =?us-ascii?Q?s3fcc1SYpD4jcg0ICg51+Ldf1rpXl6Xh77rvRicx8UEIZDFnE8SwfHui1zuX?=
 =?us-ascii?Q?Ilzg8lCaeQ72ZETkiAHpKt+KCdBhBGH0n4jyWe5Kko4dksD80A030SJeBbLV?=
 =?us-ascii?Q?Rc2klP/58S/0Qk/r7N1+8Osg3Mr0cK7IVtJEyIrCX25mv6+L8kqYJkxDzcxw?=
 =?us-ascii?Q?1fxZ8Td/ofIrKfuHLEJg16eAzOoJ8rqOWRz1hn8fpUXWoVSI35iJBJGV4ZTe?=
 =?us-ascii?Q?8q12Fv5T1T6MvT4ibFfXhQ2sSQbDXADto4R4gkUnUWZZ44COKUZFt6i0xxAV?=
 =?us-ascii?Q?Ap1RBW74BerfAtCcRkn8HVeza5vw+yZEZu4ZrkI1T2WlXOMu24Gjru8SHaCc?=
 =?us-ascii?Q?+PlNqfOKRaM+tICMnGVvmw+xuGhE8EM0wtLiC/DsG5TJcnnI7s/Ia4TIF/z9?=
 =?us-ascii?Q?J1+xGopd7cv7k3JsPF5WF+KJzsSCM9N1bhMEBN29tROdJPteH4MNhTYus/Wy?=
 =?us-ascii?Q?qBEqV0ZsjC4uyESNXEeoRcmC0hIjx7Xcs9FP8+J0jacSYUSFmZouoQqtqHrP?=
 =?us-ascii?Q?bfmkydAQOj87z7m06UCG+DQcc/ncqGh/xKdgkzUz+lmV2bXoB9dWngWCbtLi?=
 =?us-ascii?Q?OnqKKmPdLp9UEbSmE31mi3NnaJIUlYWOwb56A8weswkTrS8K13+KEINSkzIc?=
 =?us-ascii?Q?1tekMk5Z4FbrBLJZwcb7X0ew7Rl1mZU1O09N2qD1uo6UzyQUAuFrvEMRY9vk?=
 =?us-ascii?Q?OxlcXAfxphR3gmtnST6FGjllR7q6ASLguu36YrqbNvYAMA/8bFLxx4sqWyAf?=
 =?us-ascii?Q?GipuTpMSc8ggBceS2JwBs7peB0+gVmVu83n81YFIamhc7JV8WrgfD52YKx6m?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2babd605-be9d-4cd6-c3fb-08db0bc1defc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:52:30.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ucAAk+FEay2EAzPIvoASPGFzyz6Aoo7vuKq/CuS+mlfRQWynfD0ApDRVvL7bn4d3cireWU0Q/fNTlfL66mFQzkg7Lg1h7xRxdTIixgzEb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
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
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

While this could be squashed with the previous patch they really are
independent fixes.

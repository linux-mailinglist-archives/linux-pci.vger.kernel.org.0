Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A123E6E54FE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 01:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDQXL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDQXL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 19:11:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27DA3A92;
        Mon, 17 Apr 2023 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681773086; x=1713309086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2joLVYDq759xzq4OSIotSmuXUzwTvumGOgzlD1gEyhQ=;
  b=gMhFeHNhff+Rna0Ve19E0iyGXVZYDNkm1nm+kHPt4DWY2gfDb0Dxcp5H
   hy7btSDgXPVYoG0KXXcpfJ4rODOb2jbMI8dDiJ1T3PINndTO67+HE1+4R
   STml3Icizka3eNw6+erSFKW0FlDz4wtyb8b8ooNz1w0M3vfajqq3U/uRP
   jYKDCdFeYE/lIZeeFShgIQeP4My6fX3SoOWr98ZkKzhGETQ0frFx8zS7J
   Xi9pc20YhImjIfUGSJcODcl+3jXmkEwNn47aT84CpWtDhqsnf7zW9X1GK
   frPNDYx8piKGLi1d1CMLwVoDLXcooo5DvwOoONFcwEdta4qXbfI8AttLJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="407923580"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="407923580"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="755466985"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="755466985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2023 16:11:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 16:11:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 16:11:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 16:11:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFG7FsQ34Wpw/DBT9Z6vIWVGONruKQ8vJzibDcpf93N4LWXQWMG34wUfRCUvgEPWbkjg8QhFWY0DwJAhX+yZHP5aNnlRV048g+TCHhvCFpfTEQejwng4rDw1ORmnNaMxsBRkwmJgn21M7Z/vfO6q2T9s2TO2sWnAGwr+KQ0hJTkH2REF9w3WqxKXrso1kKnX4aYv0orh6uYhrfHURqS8hAhKefvnkxW6+Ra7qgrvolsOPllmOfQWevyuxFCLPZoDcHZDUsxKLTUwaxLmy0Hb8ZPiMj+aU7tl1BP/clHM7b+HWLhZZHL7OfAM7wywOnMeuToPBoQ0PhZwoYMo+x6KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9qmfph7s/fSd2TCO7OMz15+axOl1oHiZv4ENWosd6Q=;
 b=ftCkOqzKC5b41v+12KlbIAMhxygJoR7FGEL3NacmDidn1wbZRf7vNIY0KmYvp/+k6OmqxI81HC0+F1W/6uOuGRCEkXMB5355kYyYslk2fyYH2GLaJxAe30660Ga0ebeBcPhEagvgQ8pxBo9UkveRtwOtZniBBTcJkT5M47rcZH0op4+JoW4HqJEb1CYodMmNDe1Jxi/wcsQ4QYMDn4hTvqNy8/cp4VQdpbKnTjmyKHW2bevErRPptpvBjOWRhcb8frqAv6Y2U9hLIq9FDUoGCOcrl3e8+1tDQSSTE59kEpdB1SqUHfOijZfH+GiFM5Lxc1fVPo+1btC8vqpnan/sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:11:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 23:11:23 +0000
Date:   Mon, 17 Apr 2023 16:11:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] PCI/AER: Export cper_print_aer() for use by
 modules
Message-ID: <643dd21856099_1b6629482@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-4-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:a03:80::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 58115eb5-3d3b-448c-44e1-08db3f990f86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FNEpL3kkiYWhIfLjCGOb636FzJNhWYdfwmZQlgOIW81At4SypYxNAayTnQdCqXBdZQdD+U6tW9dYDkiqcKwyZhHLKArJYVrdvFMQIxKCwwhhnJBOFMAbw2Qmo5A6zifCbdvCN1/cnOwCESLMwmTgDc1Rd1Q98UyLA4O/NnU8B8s+Blw0N0HyWa6zt7TS7ixbkSCg7tGcUvKVE6FzAZimII0WgpZjmO3yYPkcBFQDfiFhlKkpEzJtzYSpMelzAYtHJrAU6hQfBJxVYnIF5FIHAAVV/oabz8f8xQoYub1RMqUqOIb1oX1KFkCXeJU6yrR6bri3g6s1ROqFmPHlRNmxmFw3UCnxwy7aQf/iuHsEkZ3yijU7m3d/dQnu5m6mVEfRGaS62c/gzNOyhbRu6SjE1S5Z4/yVej39bWLrzAa5RypM5snSQ4E0OB+k/E3BThE19ebGXgnKsiblv121/JPTTpsCAJSKqc8eEa9CvMO5MN8z13pX5PizsGT9sXzhYdVob/gZ78tto6YYp5V2QGQc0/QocqZ3btNexnRVinRe13PRgkOHCDhx58j9T6NFiMX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(4326008)(54906003)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(41300700001)(5660300002)(8676002)(8936002)(2906002)(7416002)(86362001)(82960400001)(38100700002)(6506007)(9686003)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbCyyoJR32ExtnuvuQ/TBD01dG0ZJdxUwT0Zi/DJSlFcxHZMaJKFnfTfvlHP?=
 =?us-ascii?Q?E/1ftRUV2sc5O0SK2q3+0GBphs2ukkWlvmZ3ECtK1Kp0ywO/t1C0GcONsxer?=
 =?us-ascii?Q?vpNpYbMiG18PejzdCJwdIA8HfFibc1n3rWmfY1MHwuQEf6qTQB8O/kEAaK/F?=
 =?us-ascii?Q?ScG+uaBr2RjyxgstQPiOiBUWdvfz9TDf+pa/NpH5XutEMCSV75LgQHjCbIrU?=
 =?us-ascii?Q?akR+hxux8i8X8qH1fitWgC99x6RIlVKmprMYGC1bz4QgpE8qE9M77hLIM68S?=
 =?us-ascii?Q?0WiFlV+GYfvOoRrTnoV0XeFEnXEOv5XGcAnBBRzI+gTuUCPms7tpGiWcoz4c?=
 =?us-ascii?Q?P6/AIYRye6pn3CEN3uCzusYIeXI8WMOS3a/SWy45TGNqPzlDOud1JtqaSdI/?=
 =?us-ascii?Q?AtTcD+6HnlJ8J3iA5k6ZATYrkc3kCkeYY7AuhpdScVqD/Hct0aKVwlDSoi48?=
 =?us-ascii?Q?pdsCxyj+NBqdNHLYSkkKl3hOAqTHuQO9PPd77prWmUxMToxXWfzLVyi9RoVi?=
 =?us-ascii?Q?ISn5ygy1VVX8N4wjIgCmisMqQg/aHEqKDImS7FkFzU38rq7d8ToCf/3HzQDV?=
 =?us-ascii?Q?z/+LqAqI/A+OveR2J+1Dp5aSB8zkPPo6a15JB2re9++20nQvAv0uTXdW6k6Z?=
 =?us-ascii?Q?UZ2a6fMwuBqTZvj54uNOv7/4ZiqeG4Os7E/SBKUm9GJUF6YuGJYXshykFVPO?=
 =?us-ascii?Q?rVGuJPMdv09N0U6kyXS391X/OkH2HQrNPtGQk+z9ZNzDgxzYizfAD7BP9eS/?=
 =?us-ascii?Q?CmFMswFH8z6gCx76OB7xBhXPvUsvvgaoVRjfQLNOFyJHtfes8GmRelFHaDzh?=
 =?us-ascii?Q?5ChEEfBIEpuyg1wik8giLpwxo23yHoYefEO/qaugIkzPiu9nuWt7zswkAC+V?=
 =?us-ascii?Q?nxbfIkCm74RZRVxIPUfAL6S0HSIPZBeXmt2m9dVQvAk8d5PNBAd18Y/lisMc?=
 =?us-ascii?Q?HcLsYN9HfG/xUe7gOUmoW1Vvv7CsiNs2dyHAT4+Tx0URTEGwAVIgkvFgzUUi?=
 =?us-ascii?Q?T1g0sFYiEfDSzsi/Wkc9eyTpx93SRCQZ2PDsTXB36fFXUBjNDcNEKsIIkCm3?=
 =?us-ascii?Q?rcX2dixyC+84Oz1cxYc3CQNzCszP4GNEZXwrOUf1i9uSnTMhZ6Pk3SBWzLBL?=
 =?us-ascii?Q?v+BjROzDoLltvO+S7/4VSKSmRqewWG9DKdNEcLfEVWe9CRoHAoy7QWmHeV5J?=
 =?us-ascii?Q?IBIsShS+pOCJ8F+jpWdBjZGwfPZNQhLn6Fo/Ugos5sEBSyF5ESMZm6BswPxe?=
 =?us-ascii?Q?63x9wu1S+a8SQ5AtsfIhctD5Yl7CHGE3BpfKbA01UBzV9bQqpY37HdTZiWWy?=
 =?us-ascii?Q?mFfGR4DuspIJq4NErOpjdr31uSyLjFlQAf0iNgGcdsmeRrtLBPFgzvqpinBM?=
 =?us-ascii?Q?9riEUWa7MqkmmhAoWXf1HUI1d+gcH5OUQGcPtvHK2GTVyehFybIrwUKJqAXE?=
 =?us-ascii?Q?6wuhvjNtvSYo5u/hBTjJXFv+BiOjkdyJkQ5Y3w9Wxwtoi6G989jfxmbl4P0v?=
 =?us-ascii?Q?zYlLR5sddxu4dPiD/fngDjXh7pW4520zbeF5SxrWZ9/o+e2pXqCGXlQ9Uy1T?=
 =?us-ascii?Q?eGM5ZO4paUNFQeQH2wiBePCOU+DzSbM2UF4u9eZ37nvW9XcTg05vfLONAAgp?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58115eb5-3d3b-448c-44e1-08db3f990f86
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:11:22.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fD8RFyKeBr9+nmM+r4xSX7CbW7G3KLo2Eq5kMTNFQtNKCkuAb4K4C1365cd48+6luYkx7d0zndnI328nQEmSCVdAWcEra9BrPQFGQBcxLwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for restricted CXL host
> (RCH) logging. cper_print_aer() is not exported and as a result is not
> available to the CXL driver or other loadable modules. Export
> cper_print_aer() making it available to CXL and other loadable modules.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..7a25b62d9e01 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -812,6 +812,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> +EXPORT_SYMBOL_GPL(cper_print_aer);

Same EXPORT_SYMBOL_NS_GPL() as the last patch, I can't imagine another
scenario where this symbol needs exporting.

Does this not need a stub in the CONFIG_PCIEAER=n case? Maybe that's
handled in the CXL code, I'll keep reading...

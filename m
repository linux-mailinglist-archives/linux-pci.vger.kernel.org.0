Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F44558D58
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiFXCpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiFXCpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B156759;
        Thu, 23 Jun 2022 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038748; x=1687574748;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vshyiKNIRiivM0/GNnEbZ6TFPukiX5fyudCX+h0lFd8=;
  b=SZbz1nbr+tJnVW/XOhrsinxD2MzmT+XAk4nRWYOuZ/W/aCZUyJlCVspS
   9RVFhygaN0A5uR2XdzNtOrhgmav0r8dVuxhMWXA5gX/3LtbmtseAltc/u
   axwzR+MkMFpAp0UN3sn+hMzOyv+S9Ora/iQtOcLSe/YstScQDo5ZbwUbf
   MXzNYPKqxa57LgrUWQCURkENHwOn1ZOvNUuwIpzW6BJ4k4IoKJUMz9xj0
   COM4ABoeVh12rhA4TpU8MJ9UKzji18wELcNvvPXc/f33Y90JaDGYaDIam
   cpL8l8Uy+sL0LORLEuqMRjAeXlyJEKA5tdN0Wl2CK8rT/owMPwgJK9bAj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="263941317"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="263941317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351582"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:45:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZQhVp3YBCSRzS5CK29Qy9PvWNdwBvGQjebG3azMaTIMj5Y22KxRh0FtrrU0lH/1Ggzzl6EKmtX/F3nXZ/xSddLPEGqsavbfc5cfucL0gT78HNTcYAsQm3phZBcVALgxy0LjyJkMgU66vVJSGaUdqYkKS2ddsTqf7fT7TRzCvfjk0X9yvA0GyX3yuJk2Mqd1Gi1TEwKF4jLoYhk/vhDdwdRrdKOQPdnDh+GcWWkOnBHeCq2k8wlu4HHyB+rBNTaSxzENswUHIaAVRosQBqYHhyaqLL1DkQBlTxyA5YSN+FABsJrnvghM4Jy+I11VGvwbHwARVaGqtrMdyzgiTVn2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLxX+MtRX/Xq92dSdaH1c/b5Gkf5el2qnzTKsEWcGfk=;
 b=cKBmXG2ccYYKOCSggvfE371xDN814xKPU2kl9HotLXHpgx13IkSgDXZu31018RZAG2cfAdO6+a/GJFVM2b6rVymjcCB0ENyzhG3+ZpwKweiuLdLCGE4l4tW4bZRxSv9qsDxi0KulIZVMj+aUy4PrzOo8+ps1MMv3VWde61u99Sj6yXib5Iur+ykj7c/FTohjC8hZzUHCb29+ANYK8VUJcF6empGVzpLelVEedl9krYq5G86bK0oe6zlq9LeoCzWOZ0JCni9DDKFjTNFcQt1jCwajefiPgf8KdKIman+pJfJqwx/1ZJvP7nI0rlc8jwuGFjgUSKt+KG2I4LfiqvvzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:45 +0000
Date:   Thu, 23 Jun 2022 19:45:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 06/46] cxl/core: Drop is_cxl_decoder()
Message-ID: <165603874340.551046.15491766127759244728.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a59395-bdde-4bd6-f549-08da558ba2f3
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bM8RuYwKbr9iqIbSG6VRTndXruxcmJMZ+WFz+dTUcsn6M/gQ8TX/A1yVecMinkHdol2yrRiuRQYS6Ge6+86ug8M+LRdo/w0BmDYIZbW4tqPN9CUk1+9zV7lkezD5fcVp7bp5aQzfnoAV0F1A3ng2w23G/WR7D/KbGscB5YsNc1Zpeq3sOMeK5g4H4pwl7oaTKe3+ACyZEtbEAF6RCiJ1BiK5+u1BfnS6yuP5ZKtf5HzzZVgNcE2XNj6t+93BtKv+0Kq9qtp4xIJ2Jd/KSy4Eec5Y78MgWiH9C4FN9xp34Hj781gyNDzyYaIRsztvMHb73KbzKTMwWTHu+LjhLpQ9dVeheJ+5/xb6y1HsNTw7iRTQzwAhcXYXNL11J+a7JZB9XSr8aGkAqiK179HfuUDwfZ3udXdD4KvKSVF0DutXPRw0kxtsVyNXNwu+FyypqJQH9lSwJlkTbfZMsXbwaa1BX/aZmxw0lv4kqdUJWjv9WuehKjPlQJa0sl6vJNhy6N/7gxEmu929YnMYamt2SWaHVNY+8lWUiHfROoLBbda04Im4b6a9UOnw/e5ln5Rm7c2/Jl3N36nbzrr7eY2m3HgX5XBOZn9XXJGRfzZhal9ruU6vVGNA6fPkEj9jZFDeb22QU1TV8FuWUSFEgJ+/Iol9DwOLDCRSQ7bPCEBCTraYOi2uNRvYj0IirnY6lb5vAV8CLsGT0CExUdD/pYUwdV3oka2mWNMbnMwJDyk9Xs4PPLABgvdo4coz3lx06ISsJGuL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C2SH4rNmF8ty3MpvhJ2TbbxxmNkRZM9zAY+9FZRZC1yen2jO/9TIKdXE5KHi?=
 =?us-ascii?Q?BWXBVJTmoKTZIjzdXBxrgEdBYLTUi28MnexnRi989ylIkSGAQcucojtHS73V?=
 =?us-ascii?Q?UOjwX9Wn1E7HKlbwrmnD5lQrXA5kgyDMTvYQbobCzh4auBMk4T56Hdlr/sBH?=
 =?us-ascii?Q?6dJuzQwb+aqKjdG5mJwM1kMl1bJmYzsypGfbdYHPGwmooEuY3BI8A3f+H0VU?=
 =?us-ascii?Q?6LNGGR5+QreRYHp6PwSpf+Ja9Ze6qDr9IGBC8FhdSZcyJUNobsJwcD5ZHO6x?=
 =?us-ascii?Q?5mmN6c4rMTT/TvLHF4X5NoAW9SKrKWf5B6nETsQEGJV5x5MwZCkXDWYoH0pO?=
 =?us-ascii?Q?KLl4A630Oh6VzqFtVmUFhZ9uxdzHNV8CavzlnPQOgOvMbHetafApxKDNe7AS?=
 =?us-ascii?Q?pqDcAnQ3VatKWjoVK2RXFikIzxehYdDgt3AVlyiGlH83EcwiwY0slwv+O+8k?=
 =?us-ascii?Q?aetsLujf6Z4rp/NOhBTMAZhjdIq1UcULqX0LqGZHwEc06glmPy4EaQxRoYgJ?=
 =?us-ascii?Q?7/cZyvg9RAmRvPcZmTBNL+YB6mi/qsvyyDupUMDLbWeF4EJoivk/+cAqCskx?=
 =?us-ascii?Q?bgDkyT/SZHX3upzsbtpsJYe0K38SWVNp2hs4iK90P16Q1M7tReJe6ncAVYjK?=
 =?us-ascii?Q?T293TFHUuV2Ih9FR4DefHZFUJl+QjWC9ehP4ykjQueWako92H6cfpHu5bRmf?=
 =?us-ascii?Q?63pkBh4VxE2hJFQpoMU8GwyXF7X8IQuQK15JHuNGZ/2Fv7pWYQDRarbV3zq0?=
 =?us-ascii?Q?XznGa75lLP7Wg5f/Q8eXymSqgeKPll6RZXM3KOW17w09FWKCjbiYVzVH0Ifk?=
 =?us-ascii?Q?LEXoSbMYK+8r8AvxuG2npEPjuDTfrLBbSCn3fXytH+4Xz1IwGAKVTdizsgMn?=
 =?us-ascii?Q?mWUy8spkr8yX18suFwa4+apACSR577HNDZisMyiBnbdApL6J8Yyb6gbOKSqi?=
 =?us-ascii?Q?7g5pkqHJ00Ib79eHbwuBed9kCqr8pj6uYtNtrfU8HaxEFDlJM96I95vITum7?=
 =?us-ascii?Q?kIkBcgmNvl27Vyrwtezmnzt1fWW2fYaQqrp6pAfKevPl/CA4OnTDZcjSxkUO?=
 =?us-ascii?Q?6PVCoI3huRwsU6uabwlBvRCR6s5zmGGw9sFTFnQQNPu4UCsnEAsAMwoREk/l?=
 =?us-ascii?Q?CTSzylWonNaYDd5Hb/1/JDuwzNvUKOyWXew+GngJiVfYFA6VguQkjhVK9Dih?=
 =?us-ascii?Q?FyM+xikKzl+EExAsZylClZzsZuRO5WE0TqOpkp6STqYaqP3l1BocicbGTumz?=
 =?us-ascii?Q?FozHEmN1vwlRncPat3/XmN+TC/Zg0g7G2ESZ78tqRJyYGwKi+YfFBPhPfq7r?=
 =?us-ascii?Q?t1m6IlZMLQu+2O7M243FdwWAWb6HxDy/mKuYL+0d/Cvi8Mc8j+m9z1yuU+Ux?=
 =?us-ascii?Q?R0FMy0QGJyBEACwGhSn8Cs/HLXIoWTyWZM8OKn258Fwewk7YmfOmLTxQ3r1V?=
 =?us-ascii?Q?CseZb1GSEPzle+scDfiu5qfNzUDpLnaJ1Eieit8g8hDMby6jlx4yZIxvfMFm?=
 =?us-ascii?Q?nfF5uhPTX6uDnRPY75U99ZChzzVyQkvASyNCXMnGF1HLFHPJTV+YlCx5AHtF?=
 =?us-ascii?Q?pIJNksQ9rurqGmP6490Q6w7OvKC5QhZb15NwgVOkZgjaCR4IvRcwX2wwhLul?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a59395-bdde-4bd6-f549-08da558ba2f3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:45.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUmM+jcYX+ESiRxcuQdIUZLVXk8bKwCwbvnBlU7OBi3GtF0fSpDRK+/JKPzaCxdtGBxoHZaCggIEFr5Tt5W8TG21bvn06341GNNkIjKYs5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This helper was only used to identify the object type for lockdep
purposes. Now that lockdep support is done with explicit lock classes,
this helper can be dropped.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    6 ------
 drivers/cxl/cxl.h       |    1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b51eb41aa839..13c321afe076 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -271,12 +271,6 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
-bool is_cxl_decoder(struct device *dev)
-{
-	return dev->type && dev->type->release == cxl_decoder_release;
-}
-EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
-
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 35ce17872fc1..6e08fe8cc0fe 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -337,7 +337,6 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
-bool is_cxl_decoder(struct device *dev);
 struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 					   unsigned int nr_targets);
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,


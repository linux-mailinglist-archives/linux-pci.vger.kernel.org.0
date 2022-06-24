Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD558D53
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFXCp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiFXCp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5756756;
        Thu, 23 Jun 2022 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038725; x=1687574725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=96xr+m7dAUviAItr5RCqd3u90WkJS6j6w751u44aiWU=;
  b=LNWk+b5ROftUlXoBtfhjqKlbmPn2+iYteqCH30CCGfkWu+dHbg+BHISw
   5c/TfCJlJto8ibwpOZo6So2VDtfSpVb8i70RVBBR3H+UGA12uPxkyeEs6
   UvGSr8lOFsMZh2nKwd3ESCwfERuYafkse5/RxamLMULkmvz9xVUwSxlHZ
   HwFa+sRgBb8E5/sXS7P7tfDYFnaaW8UrRb17F1OfdnWzYeFkaSbHhNQlR
   Pk88BnFXEnbiq23SkqRfzwObFt7Sg0R0TKrpsGGbuiWkziBpDy2fEnYAL
   Hm6kCwJYSPfcg2/quqRL3D3Eu7y1FxgDvO7wq4SCzdAmEGtvs8yuXjYgj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306369892"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306369892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351411"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:45:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWmS0Irzve6EXIYjUINl6FJbnU6U/KqcCJiKurGS9Y7hp42uKgOmWXniw+6PAADOa9rog0xhepBvmsHMhhqhYEleQOqeWyqEBtda9xZoKBYwyQY/WUa0BZ/5fwSgde9PZ6Ma3QEo3SSAjEuZoq+w24hp6FTX2ihuXQVx2RHI1Os0XohuqK8DY1l/oeZMxW55pkOlNm47SWOioIIrD1xVeW6vhRVQPQwXNlWd62Mu/J8pOglEb1TxnQMA2CpysOAVGaq8a8/9eRGkVTnHuakrX3QH3D+VyW0spgrzNi41nVWfQibjEcUfTQRLN+CC3NJrwb2NDnFhzK6IyXAOCuFKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbc85OHAgyvJtOJL0+4pSfNh8P1vrj/IajGeq9zhwgc=;
 b=WcTxgTIl0Pk5c29vRxXEW/bBY0YghIdgOqGEh055/qXjThBeKP5i60uO4ocd6Ulyej+efPBvJdFnO0eLwQRoDZouvKPCSrIAKsbcfqg0wIEGUSZhwcJhVWhHLHNZS/SCY4WYXPKNTkn3HBjV+pqbbSl0S/bPHRSxA/7OlpFfm+EL8aZ+ZV2LFX3HyXUhS4o0E/UNkV25ccbFNF5z0+mrfqCxqCjSdk4LyO0/OruE8t2TejUIJ7qXMmmsWd+Yvt5Tb3iWEIv/0/aJ5YSsB52mEMgmtBkdMvLlR2tmRMYpWp93icb9LqDsPz/IFs8wiHF+6cIV+dw07F59AGxYn2VvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:23 +0000
Date:   Thu, 23 Jun 2022 19:45:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 03/46] cxl/hdm: Use local hdm variable
Message-ID: <165603872171.551046.913207574344536475.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR1701CA0001.namprd17.prod.outlook.com
 (2603:10b6:301:14::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be838c50-a7ac-4e47-a1ce-08da558b9623
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4A0Z/AcFpVz/NjOIWph8gTWsC8PExg8rnQJ2kaav4g7tfGoaX2UZKE/VcxCGpOteu11JeJoXrW1ihJHadG/un51QsdiNH1hwME0hAibERLIo4Qgxx8+OH0GMD4ww99PO5C8YjHl+I2OSlZ7W4xaQTFfmzbsTxoyYeeWmNUvVQ9rSWxx1eFfz8LYQVvXOar4MsaIBCBkEdmrhdgIuwux3a95iNItShMnRA9t7nb+OSIAvuAE1sdtJylQSYNRSJTa1Go9EGTYNGEfF6BL4Xvk8Yyer+dlfO3apf+7dfQs07FEm3/7tl/0ONQA92IXEGfeU63MF0eh+xw3FPxO/69Mkz0kCSaeEhgAqilxK2uHEuuk00EbjwkkOmmOwfqwB2QWbtH0iq7fzFEwpdMW79oryZ7yWPqUEQS2I3Ew+Ngnj2IYk1wKjr/mGnle55vyzkP3Vop+GdJx86GWw/r2erO/y6GsoiFTc/Z1NRKRphv5OdEuy2lSUbf1w8Sa34M11nihLw3g3U1cYnyngqUtAqrkLxfdG5MjbaBHxduEEd0FUw2KoXOXjLvV5ww8VZtJ/U6UFCIeGGUCOA03eId1huV0DLvxq7hZp5Bz71hXWmWLskSOngcpOHJ6XZvcP1YpRD9e98N4/hA1wbEr6zw1BZUOKnQkPpJ2mxfljKhuQhSv/7lg+qeRTH2FIVSov+CvGC8dCF+J1Q+atHDOlFziNXhCUyLuArQObcTZah6vh3Dan52tvc7HJEpKa9fpIwLWVhtr2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(186003)(4744005)(41300700001)(316002)(83380400001)(8936002)(86362001)(103116003)(478600001)(26005)(5660300002)(2906002)(6486002)(6916009)(33716001)(66476007)(66556008)(9686003)(8676002)(6506007)(6512007)(66946007)(82960400001)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9htpAoPFxM6UcaIa75lkA+m79zXIIpmw0pl/VJGU3m+FI7y8XoQ+EQWpSJK?=
 =?us-ascii?Q?E9jtS8+bDD9ZemvMSsDNdugkOZkvbd3no9aBxWVsHhW04r6EV7I7/pvdIWWD?=
 =?us-ascii?Q?VyArbnDXMZOE/7eQ4zu2nh6pkehoC0nG3eHUF0obW+C260RGkZi7+2LzGh9v?=
 =?us-ascii?Q?YRQrG8epjpsQhrWo27thzgz81rQ+n+ogFYK2KQ2vXRzpYtk2NukaQm2d8s10?=
 =?us-ascii?Q?y2uNURxeYGB9Mmka/lqjJlCWACjc3nUXnrvUBRwftrObLc5vuBW4B3sEheQv?=
 =?us-ascii?Q?Z8JLtOmSo5M7q8AeQne85wlUka/QKD0Pq5ZRQrjz4J9VD7mL3b3/436kb+3c?=
 =?us-ascii?Q?Zvg9bbcxGlo2OfnT37DZb7vL/uXcoJTx+b/HJs5GJX8YcWzMskiGEb6TInZj?=
 =?us-ascii?Q?djvXPBJ45hK6+Z0Vskh+ruM6b9FWLEiiXrdgD0QNX87hfwoR9UdZeU/+7lB2?=
 =?us-ascii?Q?nIX27/NYlJAaC0GcY+wWqWFHD6dUc/NO28skfcwuRGxICBH4sKWPCzXJz00m?=
 =?us-ascii?Q?WElqZLp0WHHX5lZFmMAGPbRtfzzSss9WXy/9m9lcVooOgal8IiwvVZs+H5Mb?=
 =?us-ascii?Q?sQ/fkhlTSPGqi9GVRtpXBgsWHqwD7piXmyOxqCXDjaiypX0XN/4/6TtljVTW?=
 =?us-ascii?Q?O47b+o08ecN8xH+fqypX8PPiL0p0q6A/JjL/nyTgGmb89n0aygL/vb5d1iph?=
 =?us-ascii?Q?IGJNAhsiN9RsiUQ1zbkjIMcpc9b2N4brhe8LWTgTCJL9k6HVrtHQ7JiYtGQZ?=
 =?us-ascii?Q?f1Ltq+NvWlJ2DInWU/l9AkBqCTQk28vD9UFhj0b6h8/UMlXGXoT+ivH/tjoY?=
 =?us-ascii?Q?GhV0hTnhMjg4dG7bt7+DqkkTrYTNaTYz/thJ+CCWbcll8HsO6+D4rJUUAdDK?=
 =?us-ascii?Q?tKqDzZL8sCJ063tCCIVXevWI8EwrqDk6jbZfnWIcvAVf734qaCgBmV0Peo79?=
 =?us-ascii?Q?6R/En+a66qPzBTshaNUEcz+OjOdllT7IiE9sp2tAkY4d5GhvQlMxw3KwsAF+?=
 =?us-ascii?Q?6e9tddE5AJYxWi3l+xN491ROZaaHDAQFMiLhmq3sPQqJQDX3yCyYV2BPlgAm?=
 =?us-ascii?Q?U/Cqq4IctPcZnwXyjGHKAgaDFt31Vu9YfP4JAqUGvsr5CFrTG+36mQ0edOK1?=
 =?us-ascii?Q?CRXf+wl+ET4S39zJwmWtDwdj/zUCVFyrYqUsZuwRqPwDzwoBFmleuK19Ca11?=
 =?us-ascii?Q?Imge75ZR7LCUia7x/qDitIyEjLhcydf937G0/uvPEyxWBn4pbMC6akrqC7eK?=
 =?us-ascii?Q?ww2T6DW5ANcFSBAJRxQC3H70evJU2p2Im9KsYsnNdAEBQn5Q4zCMH7XNk5iB?=
 =?us-ascii?Q?QLRqcNpHv/KyggetSb0aSLbiSGcFXsEGZ30p7oyrxWgUYt8SIN1fCrGgSsDz?=
 =?us-ascii?Q?zdoNz0U4HlHBl0C60vIQgdWTu4QDvLPXNbrUFkc1eJrw+0l4Ko3k1ovz01t3?=
 =?us-ascii?Q?Q2E2x6SDPA8pWmc7+g9igcZqdenwq9FiDNKGaSC6jHzu2H31+8AAXVxW0pV7?=
 =?us-ascii?Q?P6XW6bzGOHmFxYAJDRZoNmgujlfidvc0tHSR/LxkZ7R1IB4ZRf2nAMEXiYzt?=
 =?us-ascii?Q?VHJrO2VbPf7guffSReVnu6vobfzh5JJPv3mv3iEdWFnIxWkcgTEJU444zdYg?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be838c50-a7ac-4e47-a1ce-08da558b9623
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:23.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdwsoK4RGLETtTGLvl1xGa8AhUf7i9Wyd6DuQBZSM1hAJR5HwZ6Dm4U9XHJFQHf3LIT02QKynroU82FsvkN+6xdvP7hS2btM2OLWs/TSxg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <bwidawsk@kernel.org>

Save a few characters and use the already initialized local variable.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index bfc8ee876278..ba3d2d959c71 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -251,8 +251,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			return PTR_ERR(cxld);
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map,
-				      cxlhdm->regs.hdm_decoder, i);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
 		if (rc) {
 			put_device(&cxld->dev);
 			failed++;


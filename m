Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF75752C9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGNQaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGNQaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:30:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0852CDD4;
        Thu, 14 Jul 2022 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657816219; x=1689352219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cWCw3mIAUBthocY3HL9tZECzN8wG8eZF/2nKRRyDt5w=;
  b=GbhG/ZvaNBXjvUbmpxhyPI+BiDnG75tQ2SCpIE/eBAo4MqtbzrjGivPO
   iOrVdsax1TtTz4eW9PCHjRjdUwgd7Gr3DSJlkPvd6juPZLn5LraSxTHrK
   e+dDgR9MFYu4sXAPCMYvAK7Vm1j/8zn4Fq6k2mnwiw6cMZJCUD3vU6SXb
   lsQfJ9bNL75mf0ssF2/PjZX0vMMEv/u7+ZfGMaaxaqx65d3PNf0ZxQGiO
   Wh+BcefI//KssMHvvKFwryc/1cvHRAUyxDlYDlH8PlB2zedw8+RgzEpdy
   a5xc4TBPspQRVhvQGPk3ggxkStFfoSLwAtnqJTMdljfy5cXiMId8Zy8jU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265353091"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265353091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="546330156"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 09:27:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:27:10 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:27:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 09:27:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 09:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEPntaLbd1JHA9cgU+5AK0JCDgb3G6ugjJ0LBxqBYhCUp38dyZpZxGUTABdIGVJbjpkiWwN5OhGNYyqveMeXUHRcbMpfGqXog1S5tfwwSFCl3TTZVxLiM59zq7hV7HAE4fbDMLzTcaqF7ogsw63Iez2FiaxA521FRd9HjvY5jMcpzg/e1xLG/viiVS1yHypVhYdQMQ5CXcn7dgPlWjJ+m1BxFPATPAvzwzNUNAVf27LFnWLD8sKs5VJQRbgqykZa5A9cTwrZu6oe3aA+ViD57v3vK4kznCQqj4KmDE/A9x6vyTwieS+ugyxjklGDAV6f3cV94egjVtveCrbOcfeNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwqiA/eg4wzhzsTsryJHyjoqMqmw1gzt0iS7ppVslys=;
 b=QUVLNUGAKnV0JJ3zrYYjGlBbufgpaCjFUAeiEQibJ0nuaDtxVwfDt7K0jp6E899ck61QFFJzCYXTNPXINzrnEVpw8JDEnQp6X/tKgDNqeUppzlx4MbqNqGZH9meBa+7768wbrNqi/7HpqeeGdnrDjzQ0MDGepM2CSLBpIAqAa5BeKj63aHEWa8spM9LGHLhIbNa1RmQOzKaXsymmp/A9cUp5YWjee1HTCGcaQfUceo47Sz5V8MZGIgfOpnyQHUzWFILw5bGbZCR9xFIgN1SdzO9N8+ObPiCMvGB6H3+FoRqEC6sex5aWlvpFte28WHxZs0jRcgybLL2fwsM76oFCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL0PR11MB3492.namprd11.prod.outlook.com
 (2603:10b6:208:7c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 16:27:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 16:27:07 +0000
Date:   Thu, 14 Jul 2022 09:27:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-9-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-9-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625143ab-71af-4c4e-f2bb-08da65b5b1be
X-MS-TrafficTypeDiagnostic: BL0PR11MB3492:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI33EZ9cTu4vMNBkadoAMNNbZE5vDb9IO6HVtbQvpexkPWThNKXsS35EsaHUX8MH4nICRXxv4ajCfOrH/6McJk1xuU4QoapPgVMJAohxJgyWrtuPXXtkuVUxB3OjcMpKPa4+891ByWaa2yr4mRo54t8DP86bN2eowwUeHRRIiIQdg0eoomaLMs+tjAJg7sjyhUbAols8d8nACekxp+Gy4HYkC3iexX/56vn6/rHtxcEUu9m64scZKOzDqG2dGDnFVCy1YClbbO7YIE/fSfmVwwW/9WJwluWkC4CwI2YAC0RWMmTJLH07pLBfYzKFIpw6nUWs2nlDEE3TPrqhBHbnEUK7uxUAqYn8fICfNuwW/LEzJSmpAFa8B27N+IJxbwhbrFYqJo4/ykt/w9LTbtmdlIOl3fTz2Ng+Hej7FdnpGfU1cpR0da+zJlRgMOnNbfO8IK57vOOkFcyJuaNz/mS9F7do5b7R8cY0FUjRV79LJEprufXQqmOMgfo2TElP+KhOCBc2iFq9Wn3csc9SHHRFDSOl29KJyZ31QJN+JnbbRPqB0/kPB0tuOnvpACdG+MNwmxihSQ9snOHbWMeAzr6n7KaD/UedCqsKykHkzj7ZeEkGe/bVlANn/6gwUh5QlKVnEcDicCljhRrNKzifwGuLJDioqGpI2Jof4R2CxJ1SWPuciRvAcg/8IoouJ07D385hlWaZoOwhvIfTzNJBKDMrbvZEZF6ypkBm3N73UZ6oSiU+LDBzJ+n9hqIfspbD6Tm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(136003)(366004)(478600001)(82960400001)(2906002)(6506007)(6666004)(110136005)(316002)(38100700002)(41300700001)(9686003)(4744005)(54906003)(6512007)(66476007)(66946007)(8936002)(186003)(83380400001)(66556008)(5660300002)(86362001)(8676002)(4326008)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PAyyZOrnSFXytOSiCaGx26ogwNquyP9QwL0Gd/jcEno6LtdifXbqDeQEa06g?=
 =?us-ascii?Q?4vX5sNy0Bz+FvhHL9BOm1Yh/ZlMS/a51Iiw2b6lmm6CgYA3gVesSDnXpkE3U?=
 =?us-ascii?Q?aBN5qZYbTFDM06CvAENzJlWWsEoj5sKOVGmH0vD3jIwYK1GKsx31KPUA+dmZ?=
 =?us-ascii?Q?1k7qO51JFWHuB+jHLMymP4FJ5KNP3XLcxpfxI+nP8BhvybU6oSIdc6PH+/9N?=
 =?us-ascii?Q?8oEtin5FscBvhFClUIh34+9BAl+9dpEMv9ucWPmqyT1rWRkUjCaHJ1OOIpbH?=
 =?us-ascii?Q?1HjWgK+ma+8wBHkt+88B1FH+VIQRzuVZjTW0W9Kb4CrAabJUlGFh1ZtFhNhJ?=
 =?us-ascii?Q?wtUEEA1oE/PTpswLyv0Lfbpvw3aTTndDhzlA4zO4W0IbwgIZ8V/pUjlbswmd?=
 =?us-ascii?Q?Dt0t0S/Vs/7uD3LzCvuXz8DMJMGrYAfwLrhARW+mx6yjHv1DFDG1Adq7gr/J?=
 =?us-ascii?Q?Ukfa0u1bS+JNaWaBUJBWZqtMEV6qnOjJTIHfVcp5+mxJz+gFcl5+BRQ2lpAG?=
 =?us-ascii?Q?0kmgPNSVX5EKbBRIJhnGr9dm4TExk7M3bpuno8gI3mT0zEDMr3xPPRWb73W+?=
 =?us-ascii?Q?XRLggP93Jr02YBEF2qXTqA4UWsfqJOZ82Sliw+bf15bhjzntmsoAOTcYx12v?=
 =?us-ascii?Q?yztBxEfATgKe66pxnttei9oVr8P+nTG96VwyAyFuEsmvQ2pc7+dHdEoj7Fzy?=
 =?us-ascii?Q?21pkimXPaqvyTZWZMNl6kc+byL54sklmq+PxRVQFJ+4VhuK6YJSrjmtFDX1P?=
 =?us-ascii?Q?CjGHFhjf8KYSbZ86kSXZZSMfd4/YXs74JUVusi9tndfqDaFiigkztkL/h4Dp?=
 =?us-ascii?Q?E77adwNkeZjMb6+0Oax2+aDSsvGsPLHHIdCrWclm3nO3XST3x5XDPKQUDKu7?=
 =?us-ascii?Q?4JAQP4OijqGLtSIcxt/XX6xo7JTQptWwc9RwTPPVof1WECmlen+2GVE0hdFB?=
 =?us-ascii?Q?a+de4eyvhMbN0cNTHZcLXEEvOOfQsPFWMuTHK5tyTKFEU3ZiIjceSAfdVNf0?=
 =?us-ascii?Q?colYaRQ7pGdObDoDSCp6Ch+nweusJ2H9cUlw8mlrTcpI3lkjvDI4ov9FM1AZ?=
 =?us-ascii?Q?tsn/TL0XjF4G4B7EyBWz2MTPme0EEOE0bDmHitE+PNug2GnoGxzXijFdlcjl?=
 =?us-ascii?Q?NrGCh5wZq1nYDRWe05QpPanSDdHANy4KDAYQcLNNMgwRBJfus2YGe7MAsdJm?=
 =?us-ascii?Q?FsMmskIROvIQmq6AfNJaC+S6vle15stzQcl1xKKa48iXWWpzvGVYRfbuMlNi?=
 =?us-ascii?Q?lDP1/yWyB4oPk9np3lds2cmDv8SJSkNOaKibbFBCT02rIi2px7eDtUk5niCW?=
 =?us-ascii?Q?1Wgb/1jZFLpfos9uYk6ottt42+jXx9cLGApTeyD9Fxkmnj3ZzDCxXhrPVoT+?=
 =?us-ascii?Q?e1Y4c/C+3USLsAhLCY/DJdT0qc01K9RTLZShNvAVK1t4dcP3ElhqWBtlPuix?=
 =?us-ascii?Q?rg0WnrYUnCIgcHnLWESGYf9lVc+ziekcxT1D4ItFzYT/+uuyW/tLu/MK4bBC?=
 =?us-ascii?Q?X/UT69XvvJfyegd11XsQZNz9RM5a20sSFQlFRStuMMAnDEpA2m/Xns/CGiLu?=
 =?us-ascii?Q?an57prn8A9maAEW9tkuqSfQKL6p7Or34PVe/8b+n3C6duYnx6ogwuJTVNl7J?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 625143ab-71af-4c4e-f2bb-08da65b5b1be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 16:27:07.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAF2vYiN4M7bMDS4EWsIU1Dh7sGTbAmi6azEuw/405UOEi157oZrAQBopqfrS6nImCpsjtM/qvXMI4IjdiBglABOY5QAh8ZLacChvKz4RXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3492
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.

I don't know what "different parts of a valid state" means. The CDAT
should not be changing as it is being read unless someone is issuing a
set-partition while the DOE operation is happening. Rather than
arbitrary retries, block out set-partition while CDAT is being read.

You can use {set,clear}_exclusive_cxl_commands() to temporarily lock out
set-partition while the CDAT read is happening.

...and since this series is only for enabling 

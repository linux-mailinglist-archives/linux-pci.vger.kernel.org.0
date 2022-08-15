Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806FA5927BD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 04:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiHOCRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Aug 2022 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHOCRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2022 22:17:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D814313CC3;
        Sun, 14 Aug 2022 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660529839; x=1692065839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zhIHOU4LznH6tolLckPKSP00R92b5LT+YIiGCGJhmtM=;
  b=nYDKN0zaMR9YZwT6XIb1MoYjjtdToShbMDxmAsIStx9/gdSilUflhu6V
   syNeukTqTe2AesNuadzCo5TyS9ZGSgnlVkzcWTJqnTy8I0WjnyEc0hhJC
   KSkBrvTMF7lq6OCTLXeJw88tiJdJp3vbtg3r0O3WRXlzSMeHWKRse7qlf
   otFjZsKjUhhDV/JytUp6TK6rqT4AnUJVq/J7T56vastzCX8tMfzcsQ0f6
   g/919QKhy+n2BIwMvuqjFvIhefVkx1riOJu7DKrg/idv33VBkN/PI6w2V
   Yy1OSpZQ9pqO6DOB+ElP0IyA/Ioc3cSIbksanqQSeEX3+6FKw/vfKGLgo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278832129"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="278832129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="748777555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2022 19:17:18 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:17:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:17:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 19:17:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 19:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMZEhTRbeajzmqstcem6HbLyhfNuJWKfU7Loi7l7tgKnCx2NPIkX8sjsitsTFLBZVcVz/2vUrIwzYYToY2oxE7qoaDIVdYZJndjFP3TZ74PKEOG3uJuznkWYi13gOn8Q7V5lv+CISoiQzAiVNlmnMZ6y/1ip/KRjDc/VTYn/Zy3f6CBriXEOWHTYOQiCMfbztB0a0w//WnH0g9wt0evjncZjp1ZYFWqwzO+MZckeLSHIVbyG8zE8g52ucb8yy0VMJjD3QQTSmCCvsaxiReNOk/k7yIKCXi1piKxqG7nLAsHw7LuAwG0Trcnj7F60BalO2RH8VEckaZ3u9EgK4ydmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2v65V5g9bouENr7c6S3hYW5C4LZWw8MpaZ3z9XaYxc=;
 b=Z9WdOAPBLvEYJ5Tv2df3dTSK6a7KOp82zltP3KDGlV7sbrRjLQKkRmCP9E8MkFWlj6xYfwSLUlRp7OUT6J/q2UMG9nq1CVMWB34VlHz5a6BvJuRKIgX/+vGUn5LdcOPscxkwCoBkt/SQG9+TsIObMjlQ21qGTDfbOdnHxKjHf2v4IsRVLQh+XoDDD47A8xi1jCYqTjjNBgaGQiKwdLHF18GgcdJdP3i/NKlCRI2UR4tYjFSZ3fVqHs9mEiNDgMIeZcmmtaYblQ5RICqRQJE2vQDLTbFI5j4W9yqkeRlgSLq8a5dHtR5syuWvZ1GUPhBNHFmCGIYXadwWYuovOVoVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by SN6PR11MB2975.namprd11.prod.outlook.com (2603:10b6:805:d0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 02:17:14 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::54cf:fae5:634a:9722]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::54cf:fae5:634a:9722%7]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 02:17:13 +0000
Message-ID: <a3f72cdd-884d-efa1-89e8-f9d6660bf760@intel.com>
Date:   Mon, 15 Aug 2022 10:17:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V16 3/6] PCI/DOE: Add DOE mailbox support functions
Content-Language: en-US
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20220719205249.566684-1-ira.weiny@intel.com>
 <20220719205249.566684-4-ira.weiny@intel.com>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20220719205249.566684-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c2787e-f07a-472c-dc04-08da7e644445
X-MS-TrafficTypeDiagnostic: SN6PR11MB2975:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIBO5eDaoqF9wCJ7zIeKW94myzS541TafZV3pKP4bCqBlkU1eJ4gbMMkXZfHwlI/R6kNtt3E4OEXkMjDKVhS+JNTKGctDcyGWkhTI3MK+qcigykscCfa8GK6SDt8xqzgwvpBR3p2qcSVvSWdGNTpVMx2gpfsHeD1Ky84Dp+2gq/DFzm2TKVt20hFcnCsURxlJT7jsr7d5y3UKejSkGSYVuOtDb/PYrP+2MSEkvdd69vAFRwZ2PZtxXX7J3Fbi3kWr4+a2GbnerhyGfUB1/Zd6WYu0/EZolVTV5PoHctfPD4rko2YO7tBNY1Bp7Hf5+gmyeNUr9QdVGuXWYTFQI7bF7BQhv/Bi6bOYcE0cKYY7opU1VQrCoDqiiZcG/Kpiiz+aJvnVOl2g6oHZ3HD9lcnyyL4wax6EO18z5yFWVXJv1tV/OwmYsq6OIk/Ep8PBhtvHP94JAd0t9nR9p7G2iqpQTXzIX1BqHwvhx/RKZrJSdjF7Zu8fNXpTwAS+FPs+SuGdvWtgmL9sMYQe/eNbTnhTTunEkegx1UusDeQpHjrC6k3VkSAJ2YtFl1e1Un6qPKGsAI/kvA3iIwRMZPgXoIpUJpIj8Jy2agGGUTCE99T1xPQ0ieFm2x0DoMdf7ZIC1Etz1RFddaMEPfX9VdgUkEUaD/w0KqraPOg85QGmnupoLEyLLVEEJ+Elll7US9f/k3oqUzXCzjW1eEtOcJqhGzkACeoQ4cCwF/aDR/gbZnxHLHgHUPOE9cR6b/gqHWqO13L0ahBBQNQZl0ep2HHsWdYdX0BYZn2G6IwezCB8DqXzs90DcsWqUyDTHQ+OWVKu/zJsJgr7oLebaZkvoQHoJ3kHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(2616005)(186003)(38100700002)(83380400001)(5660300002)(66946007)(8936002)(4326008)(66556008)(66476007)(8676002)(15650500001)(478600001)(2906002)(86362001)(6512007)(6666004)(26005)(36916002)(6486002)(6506007)(53546011)(41300700001)(316002)(82960400001)(54906003)(31686004)(31696002)(110136005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXYxVmxCVWx2SVhYMWgrTTM4VkZ1eGplRHI3Tk1xa0pFakoyMC95RHNZNFVX?=
 =?utf-8?B?d2lJaW91WWw0a0V1cWtNOXA1NkhZQURGdnhab0gvdS9wMytPT2RWRWFtOW93?=
 =?utf-8?B?b25PYXJqUG1wMUlZVmNnM0QvdnpOb1ArdENDYkhqUzZmcTduLzd5SS9BaGkx?=
 =?utf-8?B?dmJvcGFsVXo1TWFOQVVGWWN5NXVaM2NvZVpMcHE2RTZ1am1oZTZVeTlrQ0JU?=
 =?utf-8?B?Qm5uR3ZNc2docnJNYTJteFN6Ri9aaDRDaXNRRDhxcExmK05mZnZsMENpQ1NH?=
 =?utf-8?B?a21KaUVhQ1RwRldZQzhBMXExeHJVWUFBMVhGRWxxMXQxYmVRSVpoanE4aCsv?=
 =?utf-8?B?bkJQRmFkdDMrR2FDdVRiWEFDRHgvSWRlbHI2RDJNVDhjL2YwUitZUTd4TmZO?=
 =?utf-8?B?TmZ4ajNPYWJkelhwbklKT050d0o2Q1crQlFHRGM5b0tmcWV4dy9aVlV0MU1R?=
 =?utf-8?B?aHRVV3NhSXg1UldxNERxRHJLUnBURnFReEZOSTVGVWJ3ZGQxMTBaVjd6bzNT?=
 =?utf-8?B?dmtHUW55U2VScVZNR3dsM2pUUTNPczFIcDdHd2pzN2pHWjZva0t0TWZ1dlly?=
 =?utf-8?B?RExseGN1SHA0OFFJSE5qdm5WalpTWE5YeUc2ZlFkczhTOWliTzBlWjNUT1Zp?=
 =?utf-8?B?bjQvUzZMOFdwaDFTUUJQOXlySmNLMm8yRzMvVUVtWk1ML3lSREVvSEFwVThi?=
 =?utf-8?B?RVlCcFViTlhCR0xFTzFZcGVjaW05b09Wbzk4RXdNWE9FSzEramUwV0VIVlV1?=
 =?utf-8?B?WjdYQXpuUTcyUUVscFJja0FxbEgrbEJteFRmcE54andkZnVUYXl3clFucytk?=
 =?utf-8?B?RGl0RDdVdjZzMEwxcFhsaDJFbDNEdFVKYUU1eWlVSUVkdlBaVlM0L043RUtx?=
 =?utf-8?B?dGxXTmVTMnZFZWFPWGZXcWhBQmFIK1VIdjZyZWtkVGZsQlNIdHd6aFlwYmJ0?=
 =?utf-8?B?RXFQT1NsUGt3WUpZbjZFaXBiY1VERWN1c1hPcXNZWEpRWExtbkVnMkZQd0VP?=
 =?utf-8?B?SVhjM1ZaVXVtdzlRb212YXBwWGpuOVpLOWxub1JwZ3hZRkVtWXBrNzJXL1J0?=
 =?utf-8?B?Y041V0d5aWJ1a0FXc0ZXcGlZR0F6bUhIblRSV0kvU0lVRVpNL2R3ejhQQ1l2?=
 =?utf-8?B?WFVmWVdEK1ZVU3VyWmV1UUVLT040SEpYdlFjeTFLa1hrRFB2RjVMTmdYSmJ0?=
 =?utf-8?B?eXhnTFhnNVRkVXczY3hhb0lQSk9tL1NuL2hsWEZ3QTVnbW1IWlAzR29GMDM5?=
 =?utf-8?B?UHZMeEgrSnVQSjlrcW1pQU1FWEdFYlJUUVdYWTVXbjlHdjlkU29Pa0pKQVRL?=
 =?utf-8?B?ZVdJQ3ppeTh0eUEwUm5SNjZBWHppb0Y4SVJiZWQ2UmllbEJ5eERNa2FaZzdW?=
 =?utf-8?B?dktKaVFZMFhnZkNoYzJEUE9YZDkzYVhtNXQvdzJsNkhyYUczUU1BcmxuYWhF?=
 =?utf-8?B?Y3VIQkhnL3ZYNDNhMFAxNkRORUV3T2NXQmxubHZlOGtpbFdjRC9WY29TL1Vt?=
 =?utf-8?B?b1ZnRlZlakJDTXV3VkhZRmJOWXRYOFVodGc0cEg3VFpESFMrcnp6cXdnTXFB?=
 =?utf-8?B?U3N5Z2Fvd2hrS3hDbCtBSUNqVk1UaFh2eHIvcldabGZrNHMwZUR0T3N2Y014?=
 =?utf-8?B?VEMrTE1SOXFPQ1k0UUQ3OU9hRlhtZk0rQ2Flcng5cVZwY3JQL3Z1RVdWTmlv?=
 =?utf-8?B?Q2ZmM2dEOG9wTWxTZ2hQdElnak1MeFl2LzRlVy9KYXlSZmpHdjdCRUtobCtS?=
 =?utf-8?B?MFZiYkxKYVV6TDNXNXNxV2hvN1NwNWtWRnpQZUZFSkdyZzl4TktsakUreHlZ?=
 =?utf-8?B?cnJmSTE4aWhRMys0WCtKZjFxZWprOFNDZnEyUWZQZ0RMWXdiNFFBakxqTHd4?=
 =?utf-8?B?QlhHVzJLS0p6U2xGNUJuV1VQRnljSU9KcFVJYVhlTEhPWkRjbjcrQ1NDb1ov?=
 =?utf-8?B?TnlJdzhLdVpIR1F6TlZFdEx5RXhxMnRkRGFzUmJYUEYwOTBVWWpwV1ZkUytF?=
 =?utf-8?B?bDc2ZkpyMHZGOXBLNEZkTmh2YzhIcWJ4dzhqeEZsVHh3eVFhUEwzNlNvN0JD?=
 =?utf-8?B?QUpTUDVuak1BS3RveHk1UkJnL1ZwZkowRnVJY0wxMTBZUUw0bVBUN2hHTWpK?=
 =?utf-8?Q?ASUpL+4F5cRAMjNnHq80GZpyU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c2787e-f07a-472c-dc04-08da7e644445
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 02:17:13.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD8S5ECGTlewSFRo1RHyfIkvez3QSPUuGqEdFVTLXwtHlcdsqbacfKm1LMOB41c+kERHfOHmI4Ea1DwbrF6aig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2975
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/20/2022 4:52 AM, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, and task submission.  Destruction
> of the mailboxes is device managed.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---

> +/**
> + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + *
> + * @doe_mb: DOE mailbox capability to submit to
> + * @task: task to be queued
> + *
> + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> + * Returns upon queueing the task object.  If the queue is full this function
> + * will sleep until there is room in the queue.
> + *
> + * task->complete will be called when the state machine is done processing this
> + * task.
> + *
> + * Excess data will be discarded.
> + *
> + * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> + */
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> +		return -EINVAL;
> +
> +	/*
> +	 * DOE requests must be a whole number of DW and the response needs to
> +	 * be big enough for at least 1 DW
> +	 */
> +	if (task->request_pl_sz % sizeof(u32) ||
> +	    task->response_pl_sz < sizeof(u32))
> +		return -EINVAL;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	task->doe_mb = doe_mb;
> +	INIT_WORK(&task->work, doe_statemachine_work);
> +	queue_work(doe_mb->work_queue, &task->work);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_submit_task);

I'm curious why there is not a sychronous function for DOE users. I think some protocols over DOE need a DOE sychrounous interface(e.g. SPDM, TDISP, IDE...). These protocols have to implement an sychronous function over pci_doe_submit_task() by themselves, maybe we can implement an generic sychronous function in PCI/DOE for these DOE users.

Thanks
Ming

> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> new file mode 100644
> index 000000000000..ed9b4df792b8
> --- /dev/null
> +++ b/include/linux/pci-doe.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#ifndef LINUX_PCI_DOE_H
> +#define LINUX_PCI_DOE_H
> +
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +struct pci_doe_mb;
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload (bytes)
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload (bytes)
> + * @rv: Return value.  Length of received response or error (bytes)
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + * @work: Used internally by the mailbox
> + * @doe_mb: Used internally by the mailbox
> + *
> + * The payload sizes and rv are specified in bytes with the following
> + * restrictions concerning the protocol.
> + *
> + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> + *	3) rv is returned as bytes but it will be a multiple of double words
> + *
> + * NOTE there is no need for the caller to initialize work or doe_mb.
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +
> +	/* No need for the user to initialize these fields */
> +	struct work_struct work;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/**
> + * pci_doe_for_each_off - Iterate each DOE capability
> + * @pdev: struct pci_dev to iterate
> + * @off: u16 of config space offset of each mailbox capability found
> + */
> +#define pci_doe_for_each_off(pdev, off) \
> +	for (off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE); \
> +		off > 0; \
> +		off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE))
> +
> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> +
> +#endif
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 108f8523fa04..57b8e2ffb1dd 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -737,7 +737,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1103,4 +1104,30 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>  
> +/* Data Object Exchange */
> +#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
> +#define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */
> +#define  PCI_DOE_CAP_INT_MSG_NUM		0x00000ffe  /* Interrupt Message Number */
> +#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
> +#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
> +#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
> +#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
> +#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
> +#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
> +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
> +#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
> +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
> +#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
> +#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
> +
> +/* DOE Data Object - note not actually registers */
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> +
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> +
>  #endif /* LINUX_PCI_REGS_H */

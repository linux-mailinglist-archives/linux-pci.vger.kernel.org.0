Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDD648A76
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLIWEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLIWEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:04:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988EA3854;
        Fri,  9 Dec 2022 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670623471; x=1702159471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C/V7FpOekR7RB0etTZgZAaCB1C693pycMGUAGZRs9og=;
  b=U3FVG025OLJE3jsjP4ctZgTG29s9xxclqPtzUXNU+kTzPdMsw1mjT9Nb
   Jxy7ztQoJt6jVSxVN82znyaIKBd1luwEztnhNYRbj1b3M1zMJRkdPrgwn
   PYehlhtCD0R2IBbVcwQCN5/DY/IsvQlMkbVpI/lc6u0E/ybMejKUX0u2Y
   +QAlYAmqtIWkdG25H+Qn2eRGGOSlFbsQvJpKYWPOohiAhmUZgaRW549Rj
   bnpAoIBfrr7ugiZB1cbosnO9jB7TasPn4trnzEBHrNCWEjrSmcm8PqIiA
   EnrKGGiFdl+1g8HNUZdv4L9zq1ynjZjcF4ikL2jwsyo3ZhAIdWSma/cs9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="305199063"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="305199063"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="736347567"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="736347567"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2022 14:04:30 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:04:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:04:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:04:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDsOqUpErLRco+cQU4xYI2I9yq+Wv5BaqQEdOjpHYun/Vq0xpN9Bp91YSOwJPD2JxLFNV7NqCbNY1skKA/sRJMQp5n8pOpVbrbBAk7XttEqGFnFC2tRm5jiAFUELhIj5+qBoWBAIGDCGR70WIPFrsyeeVRjIiDryuYcpRro49pCo++4nsmkcviJPENtGVDm6RcdMkDiuQMPPfzL0Caso+wU6G+KXZsmYCYo0apEEP3BRvnQl98GfaOJoq793yhopHleTrnbst5qb1mRxPvJfk1dJt0RE8930KJFTHLhk+/0E5s5PTLF1vX1ZT20OFAcKjJBl9t5dQS+0X5KsnLromA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ita+hmoH47LlLtHcyH9HpfdWqO76C9wlHHfCqNyRbqU=;
 b=juK+ymBdEUELRymHlLbPvVLQqxJJssZjIujOMxB/NSpUxmRL3ilkdgaLpq28qdaLP54a6RFDB4I+s3JJfsfp/4+MVK0OhxOklOlJx/aRC82b0fyie5HV77AVX7CgeEZL25LhW2J9F7csZzvlXavbo7fQr8zeW+cYNyjBnSRSAxGzz4x2uNB9DdDuwhiVQM8yD1s3YW8PjXys55biESvQhALNbMOwI2Z9iNUvRcyi7Ui/gQsTVXzF6rynJzQp9dA8AUcWk8GNPiiK55uaZ4qdhTY4U5SvHkPIeH74rZgWJ4vHBQu3GpXuqzyNid7uw5OmJLPT+MMs4vqxaLgDCYcWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ2PR11MB7520.namprd11.prod.outlook.com
 (2603:10b6:a03:4c2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 22:04:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:04:26 +0000
Date:   Fri, 9 Dec 2022 14:04:23 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V3 3/8] cxl/mem: Trace General Media Event Record
Message-ID: <6393b0e7971ba_579c129446@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-4-ira.weiny@intel.com>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ2PR11MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e3714a-192d-4359-4ffe-08dada315676
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QP/Po20U9joWuOQf7o0A98R6HBSOkkzZiQ7ysPaoDE0mWriFXNCp1cFqFoVYn2wWzPa2/SP204ta0htH/oq6tmXpAVR753NeJ5RRvIum5fYL4P4zQZ3vYirQsCqJ90Rfpi+XP1PScsC7JWro7XguGAQ4jMam66vjclfom6eDZO0GHVBdt5oYb/1+Vnd6traVe2+wpFPS410XhlXdA/cvSNNVsicEAwbOfhGTPIuv0Sqv3eadb5AwxMeXRglnaOvFfpdh4SOKFWCh0jWVVu+PK+TZR6vYvG2Xopmkboa10HRkp+NroicgdBeS+0wWqviVgXDBDmyWR1UBwYRmBgY78wNpHwUxggQpYDIZ1hfxT288wZUzrx6KIh8UO+I4SULVU8Bpg8e7Zk/1jNaSU6xAzTCwlpR4HWubB/xgFar3tqWzcmmV5Z7uf/sohDXcPg+CnZ37uTHJkix8822onaqtQ6pORZjyCnbI98+Zyu6VehdsvzeSjTF1sO8JTTad1nG/R65HSGDkEChN71o0ecXqutMvtr1Oas2zrL47NASuarBBLCxZnJQjHwx/u/SiaITa/nyXRRuVQDPEOu11fNfVrlpXWz5LDsT5b9hdCcnCTUPp4umVHh6hM3pwv87jzul1gwCXH1ZsP+PmdZUWx6/LQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(38100700002)(2906002)(82960400001)(6862004)(6200100001)(8936002)(5660300002)(83380400001)(86362001)(54906003)(316002)(6512007)(478600001)(186003)(6486002)(6666004)(9686003)(41300700001)(4326008)(8676002)(26005)(6506007)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnUFxriAKmaFW5rs+QJWmhaNUJMWkqwbFAr7yJPJ8Ahg2KlrOvoUfE03nvms?=
 =?us-ascii?Q?ix84a/Brypa9Qk5dPNopVXpt5JV6F6mvFilzP9lWaIMH498mnAKwPLoTISC+?=
 =?us-ascii?Q?AM3QybWcCMHc/dR5cwZRDuKxLqKcyDS3bPCfKpqSTBnKqwNPUVaiUwVTFHJI?=
 =?us-ascii?Q?OlAraR1TowgmrO+IW1ujqtXv5gMyoLuUGAzoTEsqt3RSEi3zn3AAzNSPxCQp?=
 =?us-ascii?Q?/pk5QrGnFHUF2YQf6qug2AfGGq2eJyiiIDRvuj6hZ/QNfzH1ALPtOWz/GE5+?=
 =?us-ascii?Q?2fCpgHBdRfxgyvHWpGl5WQYSVRi/YpLa/QEeXAtkm9yO1LmS7Xwm+fRzL5vl?=
 =?us-ascii?Q?iNZUego4C60IqmlQFhMTZYMagZ5rhrQOkc1MTqhEc/WWaheCsPY4wItoKUH0?=
 =?us-ascii?Q?lTKdvQUXwMc0C+UkI6dso3foje9Bv8wmEm2Roy3c8bqG1mKFqZuan4na5xUq?=
 =?us-ascii?Q?ABWTiHHU+7vHsFA/mb6xsQsKAz+jObkVErjV/ygksbu2DjgK7Y9sNPjotpWd?=
 =?us-ascii?Q?O++x+BQeUAPbJmrvVdPRCOszGcM3Ql7RTm3AyQTj50XZlpZsl9sZwVswz2xT?=
 =?us-ascii?Q?zJmmq5yJ7vPG9jflVUWPX81SkI2rCNjI0k9oqEz8jBPchL0eXCMnRKm0XTFQ?=
 =?us-ascii?Q?xMRjKPBXEZelVWRPw73EUShfaF+IU9K2txnQZbxStMjagI1Apqq0rACr759d?=
 =?us-ascii?Q?DKlvSBatznwAyVvZK9M1MTpp/zUDUJXBgyQ+PSzp1/dueh3ESCOGcdVc0zeG?=
 =?us-ascii?Q?IXu/pxPMl9170cYvULkGlKarY/t60gBZhEEdQkH+JsU3NECNKcxVEKpw0w1I?=
 =?us-ascii?Q?ck2SZFluXTFbkoP+Z8adWKvfVK85orqjo/bqGCD0aKzuM9rTLCBrf/fNrxHG?=
 =?us-ascii?Q?CXU0XtvtvW7qMGZdhmxxuEKhc9MSxreEGLJ83DrywRYXXf64tGzFg9tBEdpp?=
 =?us-ascii?Q?kqIw5qepIU7XiWSprUMqaSm5l9azBep5FQXV4YCNHFs+1bP0KzODRowx22Pg?=
 =?us-ascii?Q?DYOOuGIyro2VCsxgBM5/V9HNoRNJ0ntJX9xCsp/AReHcvTXBnRDNru/wrlOP?=
 =?us-ascii?Q?x27CyblsWifjQV+4zc8onFHvhVR8FRLQdCSPkE++RRAAKH/fxaQ4QJXHyyi3?=
 =?us-ascii?Q?Yjxe8mQJw4N+jorSzB0rliHOclLHDzkdknJTW9/iLdnjou77L8tGFndCUBaN?=
 =?us-ascii?Q?Qpqy/Z+1py8yprG1q6XTHiqp3Un4PhZtBZEQ88Cmk5HSNnGyuRx5n7VbcQiv?=
 =?us-ascii?Q?RoSu5U7aEwaCnLYaZQYz5x3Dnzab1T2xa8y2AufJ4fEF+dJXZjkR/6yBGMie?=
 =?us-ascii?Q?6g0pfZnErijT/y7UynJbbXvYOK0MyWqsEvZNzcWaeFTt2vVKK9ar9wnGqrZb?=
 =?us-ascii?Q?wf+Ux7DK3tTZMrldS69RiXWO8wHw4v8antCh82UdOkTmiWNfb4U9V2+sjhvj?=
 =?us-ascii?Q?VKdIWf6UuxqW1AWITam1+vcbbKXh9uFOgTcTWwwdZgXlInBWaZwkNY08ykTH?=
 =?us-ascii?Q?/sfYa94YUWbu/e8Zyml7hG6xKJEd6lmGIhRvZe/TmwM3q+aB7+a1Vjv1k8Yu?=
 =?us-ascii?Q?CMDnkxxpmAULEt+Gs49/5zR6jk3asS8nvUYMueH/c4nvO+X0md4NZ6uupiO+?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e3714a-192d-4359-4ffe-08dada315676
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:04:26.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REShB3PFs2xK6OjN5a8Ap6DQls15Hw6NxfFUMdnzxP8hsuMtm5HGpB7Uoi326KWHgJ2yNU6f+Pvf8OItw3uRs7ix1UK5UU4cn6nHstazsTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
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

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> 
> Determine if the event read is a general media record and if so trace
> the record as a General Media Event Record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2:
> 	Dan
> 		Remove trace_*_enabled() calls
> 		Pass struct device to trace points
> 
> Changes from V1:
> 	Jonathan
> 		fix spec references for CXL rev 3.0
> 		Make flags all caps
> 
> Changes from RFC v2:
> 	Output DPA flags as a single field
> 	Ensure names of fields match what TP_print outputs
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Remove Reserved field
> 
> Changes from RFC:
> 	Add reserved byte array
> 	Use common CXL event header record macros
> 	Jonathan
> 		Use unaligned_le{24,16} for unaligned fields
> 		Don't use the inverse of phy addr mask
> 	Dave Jiang
> 		s/cxl_gen_media_event/general_media
> 		s/cxl_evt_gen_media/cxl_event_gen_media
> ---
>  drivers/cxl/core/mbox.c  |  30 +++++++++-
>  drivers/cxl/core/trace.h | 124 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h     |  19 ++++++
>  3 files changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2b25691a9b09..0d8c66f1cdc5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -718,6 +718,32 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +static const uuid_t gen_media_event_uuid =
> +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> +
> +static void cxl_trace_event_record(const struct device *dev,
> +				   enum cxl_event_log_type type,
> +				   struct cxl_event_record_raw *record)
> +{
> +	uuid_t *id = &record->hdr.id;
> +
> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		struct cxl_event_gen_media *rec =
> +				(struct cxl_event_gen_media *)record;
> +
> +		trace_cxl_general_media(dev, type, rec);
> +		return;
> +	}
> +
> +	/* For unknown record types print just the header */
> +	trace_cxl_generic_event(dev, type, record);
> +}
> +
>  static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>  				  enum cxl_event_log_type log,
>  				  struct cxl_get_event_payload *get_pl)
> @@ -810,8 +836,8 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  			int i;
>  
>  			for (i = 0; i < nr_rec; i++)
> -				trace_cxl_generic_event(cxlds->dev, type,
> -							&payload->records[i]);
> +				cxl_trace_event_record(cxlds->dev, type,
> +						       &payload->records[i]);
>  
>  			rc = cxl_clear_event_record(cxlds, type, payload);
>  			if (rc) {
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 24eef6909f13..82462942590b 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -223,6 +223,130 @@ TRACE_EVENT(cxl_generic_event,
>  		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
>  );
>  
> +/*
> + * Physical Address field masks
> + *
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + *
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> +
> +#define CXL_DPA_VOLATILE			BIT(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
> +	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> +)
> +
> +/*
> + * General Media Event Record - GMER
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
> +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
> +#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
> +)
> +
> +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
> +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
> +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> +#define show_mem_event_type(type)	__print_symbolic(type,			\
> +	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
> +	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
> +	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> +)
> +
> +#define CXL_GMER_TRANS_UNKNOWN				0x00
> +#define CXL_GMER_TRANS_HOST_READ			0x01
> +#define CXL_GMER_TRANS_HOST_WRITE			0x02
> +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
> +#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
> +#define show_trans_type(type)	__print_symbolic(type,					\
> +	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
> +	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
> +	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
> +	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
> +	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
> +)
> +
> +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> +#define CXL_GMER_VALID_RANK				BIT(1)
> +#define CXL_GMER_VALID_DEVICE				BIT(2)
> +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> +)
> +
> +TRACE_EVENT(cxl_general_media,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_event_gen_media *rec),
> +
> +	TP_ARGS(dev, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		/* General Media */
> +		__field(u64, dpa)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u32, device)
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +		__field(u16, validity_flags)
> +		/* Following are out of order to pack trace record */
> +		__field(u8, rank)
> +		__field(u8, dpa_flags)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> +
> +		/* General Media */
> +		__entry->dpa = le64_to_cpu(rec->phys_addr);
> +		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
> +		/* Mask after flags have been parsed */
> +		__entry->dpa &= CXL_DPA_MASK;
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->device = get_unaligned_le24(rec->device);
> +		memcpy(__entry->comp_id, &rec->component_id,
> +			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> +		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> +	),
> +
> +	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
> +		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> +		"device=%x comp_id=%s validity_flags='%s'",
> +		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->device,
> +		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> +		show_valid_flags(__entry->validity_flags)
> +	)
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 350cb460e7fc..a5f5d4a380af 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -456,6 +456,25 @@ struct cxl_mbox_clear_event_payload {
>  		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
>  		sizeof(__le16))
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> +struct cxl_event_gen_media {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +	u8 device[3];
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +	u8 reserved[0x2e];

If you reflow this one again to make capitalization of symbols
consistent in the trace prints perhaps change that to decimal, but
that's not a blocker.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

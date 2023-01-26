Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186867D830
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjAZWKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 17:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjAZWKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 17:10:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E434330;
        Thu, 26 Jan 2023 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674771013; x=1706307013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0NxS5qezSpgkc5M8tp4r/WykVuewxbOMqTNreIx/Wsk=;
  b=eY3EdswUbgYKrspBjBCRN9PYcTXbrpzDMIeY1qqHnnkEbVFFDVvmujZZ
   jYCOhf9vhLFgF2Lv55E3vWyWq9x5Et7dRsfeECI8bPzOCKiEkxyQgMxJp
   el1fEnz3ZIJGXlpmpvaDgZgtvY1CrQ3uzRNcpL+O96DmrWfSTEDhvse3p
   EYAthHFJN6dXdII/4Ny/D+eOkV3Z1PKwg8DxzQfZGOnJQn0BxJYuQOc65
   yTwUwzjC3vVateYsxL6L+K6J1UXIWGF2ECPwWXEiaLD743jjXq77l/Mg0
   S5MfbItRs94hnXE6rFp851Vow5KBJdHCsaD05xL6aiaOy0AvwS9aK0UIN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329079242"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329079242"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 13:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="787000785"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="787000785"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2023 13:53:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 13:53:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 13:53:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 13:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWCBYClxQdoRf+/2SMGyq2xJ2F94yKlHaU9+ch4estWRakGWFmzt8XecGuzqivqwT5DRip7EVk0WkHjKqXc/m7ptvaNZFkcU0x3sZ+xNkoIlysiC5VO3AzdjOn+1Jlnauhkk0MA9B/2i6EOU8eUfjZ/Krka9BDPkoZhm4/7r13VHQ25ScnaLWEzFrQdxW/dnTwBWAcJM19emGl7t7HuQXKUSrjgTWCT9dheS8tlxEhZsmMvlJEvnzATZrzUW0bvMPWUkPjA4FZzD4x6jxO8HAtOZEIdVGO4WVPMKZNdmlcZBD2dtxeIX2A2UWUQ2f34/WvVpemdeHZt9j9D5kpr2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX6oUtvzSyCgK3D/AcaaWS7Rc7Rg2EoHU85tdywuEqc=;
 b=TmGXtyeEjjV62g60xLsm/PLJc8v49DoinykmjFV0ajnf6A2xM0d6ItVGMbbholr4/Ibk0Eo9dXXjvS3J+Kpdr0acYPUcvHN4aF7YXYGYDzgZTW79WRJrMXr+UAdkFUkItLNyEz3YMUwxnbqA1b8nsLw5zpHxIfsgEZWlHYTuboJtIVKMc+/iS575ws3Gy8SqTBhWtfc8JNvTgk8AWWw+eJ/qdlXX8hparMpim5dmvPPxjbIyCVWz+1VIrOVXkYaFyo7MUSchl6nDWmJsZIA4iruUDc7GaKKHmyhBdnZCBGvYwR3WqzCXgLTgfKI62sUn2hjwOj74+tUecFaxU1e4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 21:53:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 21:53:44 +0000
Date:   Thu, 26 Jan 2023 13:53:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v7 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <63d2f66498b27_ea22229452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f6c572-ec75-49c4-2ab5-08daffe7cb62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SDFzRDkGubMZCh6UtMDMbMwYpiLtNnJgs38Ya6R2Sy35Z2iOz52jH07RKTqKylL3dt/A+B/7eDLC5F/18AyXrhKTb+2CWLZkeImzIyOSmLdIUkNBcYzja4sNoLi+jH5DQYRjqqh8k4QEtUCVF5NsNStF6aB3QS1PBdAJPpxAUkk3TDGGaArLOip8TgHJ2lfInUWcT2BL/riRIVVzQYGRX3RTDrl/uCgmeCYZWGXQHFGEndxC+jbHXuNNGyUh8tHNF3uBWE1LFhE2aX2aA0jJ+BINqcRxuuAEpNPMD+txqotvi1IpHVxVm0a3CXPTwgjeZJJWX3WuD4ofFGoFMYpLvIPm00t1Y2nrf969Lc/TYPwVJXJAp3xOUeVHetL0Gaf7IbTAhUr+aQgwRL48LPonmsndnTp6Eumkl/UQk6duuBfUbwxSk4POdag5mT1OYCP5DYQe1TWRqx3wmuiqqWIhqY3Vm4Vg4q0Mc3RJZMsv1/UccAoiV1IiXT8TzefZwdkCYTNWbd4ypKrilMlkXLl2y4ojG4RnZLxaSp2kmgnuaX4+rJJAE5+EmXE2J7Z7ZtSRuPk4c7DpWTIAuK/e2pd78scfGBFSRm0TiRaU68aj68Bnr9NV9qdGNCKscWNz9nTFshshILEmqw9PeobdrilxEUfxw+63QkfhhyGoc9L84RNIKersioEr1je6RHUJccw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(41300700001)(66556008)(66946007)(66476007)(4326008)(83380400001)(38100700002)(2906002)(8936002)(8676002)(82960400001)(30864003)(5660300002)(6486002)(86362001)(478600001)(6512007)(6506007)(9686003)(26005)(186003)(6666004)(110136005)(54906003)(316002)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJYj9WgvMsNNxbO3WZaWiHU1Vt+9JJIvEaJFl36suVZqeCIiQ5yE+AteCqOU?=
 =?us-ascii?Q?L0a58bXTsH5s2an9033BEGJu8fdzj0QzKjQIH5Ri0i5xSTF3DxdSS253SDVE?=
 =?us-ascii?Q?pUwhhu9jt0sIMrJTFEg2d4ES3rfJ7yQvtnKQCUfAwhEC3Z+uFd3Sud04dEjQ?=
 =?us-ascii?Q?GWvpoNDxJaiBh+z2hNd9iftfZx/tIsizeKv0JFVCEtsOhumsIrhKjYLp/3xc?=
 =?us-ascii?Q?GHQGFOLCXgB+/9egUH8559lVkG1dNOF8DrnMYrvFPLq9H0+51TsNn5prPyxk?=
 =?us-ascii?Q?4hSWSft60EcUi5++kyOdqA7b6G5CAZkiBmZwvCeFjTMsccirQIy1kANKISas?=
 =?us-ascii?Q?2EkS5Fe0lOrN9WSxus14K437zZ9N0a44gwBwqezi1t1BCp8AfpILAEnVGkJD?=
 =?us-ascii?Q?HUne8u1FfddPMRnYHUEDXoEZYaY/L5KrF1aSkk4qeg4lYbDqyMGUW0nPGNbm?=
 =?us-ascii?Q?OIdwMC3qQ8laqBfkTCARis8SuHCTFiTYdLqMfh9AMkYWMUpeVsdbLCrOnSQM?=
 =?us-ascii?Q?ZWpT8wEqHOpHJkHZldIGSXTUuQ6IQuy24zDIVYRWktj4PMHsiNB6TPpRmbjB?=
 =?us-ascii?Q?k1hVtPCpDSe2IcoHYOt8dazpGYt1GPcmLwOOt+hgCCC37dbNFKWaD0+9ADD9?=
 =?us-ascii?Q?XHsyp26ZN1jriCjE924dHk7hCw8WAYI3QB3INyMfPSiYitFM3pqtMZP9/EpC?=
 =?us-ascii?Q?Xs7oWKPDI/GaoPJgBVXxS3358Vwt3yQpgboqdI+lmVq+YnrfPvkPbBQTgcIS?=
 =?us-ascii?Q?z+koH6iDZ2giWbFFLfHdfbCU4MfPXD3TA/0cUT4MpT/72BVWaq4lSS1ZhVfh?=
 =?us-ascii?Q?9wfvMvb9EXY3FD5NVEONsnkNJ7og7tVCfzSG8kLc6Da8dHc7fUwFP73D0MSW?=
 =?us-ascii?Q?QTk0aTGHyNnMy9be8l2UzbUj3zNM/TiMyfIoUg4QAlhuBeEevjDmCcOsRiYE?=
 =?us-ascii?Q?cVpMrwCY+iCMXcONfaTthCcQGo1rrPfqng7NIUCU6HMalbVSBUvel1DZOYYw?=
 =?us-ascii?Q?BmLICH9re1f0EPMYK8Zdb2chaLK7xhoU/j3WlAGFkNWG68mH8AA6QUtUjgHL?=
 =?us-ascii?Q?MFLQ5YYqrI7Vd9xX3POV1IaU7sWd2tXvlb4GuVTHsCBlW25yeAsKxd5KlGrw?=
 =?us-ascii?Q?KfcYshPab/gnRNX6yJpYu33rQKJm4b1TqSZk43BsBKnv7zXSpo5Qw9VjGZ9x?=
 =?us-ascii?Q?pTHLi4UC2S4wZGzHuH0q5t8ZIq2a/pm0LIQ4xkRU1U/6eshfv41Xw49D78Ho?=
 =?us-ascii?Q?l759LXUNq98SvrrzVYdrlnmVYbIa+oHTHff8UXqjA1M13UD2z/nfCroE0wLv?=
 =?us-ascii?Q?CLvevC+SnBcFxtjPEDR8jSJYANN9XEbE3unfbJSZ7h4L/bWafczH/7cPF/CF?=
 =?us-ascii?Q?bertjQzCKyTX3xipwx1+QqLQsTvLXEzogfZmK79nuBygd8OBBTAArMiBXAxq?=
 =?us-ascii?Q?t6KlLBjmg7r37BXB8DrS49ENGHdWXHg4fOWYE5zW7HgXmIACzidROdOvDX+O?=
 =?us-ascii?Q?hLpnINaFbDvJX+NRHdim0dUBQph/EfTRKYo3BzR36Xn1d0ZKETwM5goCxJK4?=
 =?us-ascii?Q?DdixHZpkqFNUtSqmA3cno4E3dTFwYwqJFEE9P+t91QnvyBfSovNuW7RAFPXw?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f6c572-ec75-49c4-2ab5-08daffe7cb62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 21:53:44.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1KuRJipc8ok/MGzeXsG8QYVdN9q7KUtgVR8fFHaNkQZyHClyd91wujFzkYe2T7ZlV6a9NSQLDaqoUh1C7WBKkm6ByI/ksuWkBseOIBg+7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> 8.2.9.2.3 Clear Event Records mailbox command.
> 
> If the result of negotiating CXL Error Reporting Control is OS control,
> read and clear all event logs on driver load.
> 
> Ensure a clean slate of events by reading and clearing the events on
> driver load.
> 
> The status register is not used because a device may continue to trigger
> events and the only requirement is to empty the log at least once.  This
> allows for the required transition from empty to non-empty for interrupt
> generation.  Handling of interrupts is in a follow on patch.
> 
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
> 
> This patch traces a raw event record and leaves specific event record
> type tracing to subsequent patches.  Macros are created to aid in
> tracing the common CXL Event header fields.
> 
> Each record is cleared explicitly.  A clear all bit is specified but is
> only valid when the log overflows.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes in v7:
>         Jonathan
> 		Picked up Jonathans review
> 		Shorten dev error line lengths
> 		Return error from devm_add_action_or_reset
> 	Jonathan/Dan
> 		Make struct cxl_mbox_clear_event_payload a dynamic struct
> 		Clarify meaning of CXL_CLEAR_EVENT_MAX_HANDLES
> 	Jonathan
> 		Only allocate buffer if native cxl error is true
> ---
>  drivers/cxl/core/mbox.c  | 148 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h        |  12 ++++
>  drivers/cxl/cxlmem.h     |  79 +++++++++++++++++++++++++
>  drivers/cxl/pci.c        |  42 ++++++++++++++
>  5 files changed, 401 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..c329c1e67a2c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -8,6 +8,7 @@
>  #include <cxl.h>
>  
>  #include "core.h"
> +#include "trace.h"
>  
>  static bool cxl_raw_allow_all;
>  
> @@ -717,6 +718,152 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +				  enum cxl_event_log_type log,
> +				  struct cxl_get_event_payload *get_pl)
> +{
> +	struct cxl_mbox_clear_event_payload *payload;
> +	u16 total = le16_to_cpu(get_pl->record_count);
> +	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> +	size_t pl_size = struct_size(payload, handles, max_handles);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u16 cnt;
> +	int rc = 0;
> +	int i;
> +
> +	/* Payload size may limit the max handles */
> +	if (pl_size > cxlds->payload_size) {
> +		max_handles = (cxlds->payload_size - sizeof(*payload)) /
> +				sizeof(__le16);
> +		pl_size = struct_size(payload, handles, max_handles);
> +	}
> +
> +	payload = kvzalloc(pl_size, GFP_KERNEL);
> +	if (!payload)
> +		return -ENOMEM;
> +
> +	*payload = (struct cxl_mbox_clear_event_payload) {
> +		.event_log = log,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +		.payload_in = payload,
> +		.size_in = pl_size,
> +	};
> +
> +	/*
> +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> +	 * Record can return up to 0xffff records.
> +	 */
> +	i = 0;
> +	for (cnt = 0; cnt < total; cnt++) {
> +		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> +			log, le16_to_cpu(payload->handles[i]));
> +
> +		if (i == max_handles) {
> +			payload->nr_recs = i;
> +			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +			if (rc)
> +				goto free_pl;
> +			i = 0;
> +		}
> +	}
> +
> +	/* Clear what is left if any */
> +	if (i) {
> +		payload->nr_recs = i;
> +		mbox_cmd.size_in = struct_size(payload, handles, i);
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc)
> +			goto free_pl;
> +	}
> +
> +free_pl:
> +	kvfree(payload);
> +	return rc;
> +}
> +
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload *payload;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u8 log_type = type;
> +	u16 nr_rec;
> +
> +	mutex_lock(&cxlds->event.log_lock);
> +	payload = cxlds->event.buf;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +		.payload_in = &log_type,
> +		.size_in = sizeof(log_type),
> +		.payload_out = payload,
> +		.size_out = cxlds->payload_size,
> +		.min_out = struct_size(payload, records, 0),
> +	};
> +
> +	do {
> +		int rc, i;
> +
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc) {
> +			dev_err_ratelimited(cxlds->dev,
> +				"Event log '%d': Failed to query event records : %d",
> +				type, rc);
> +			break;
> +		}
> +
> +		nr_rec = le16_to_cpu(payload->record_count);
> +		if (!nr_rec)
> +			break;
> +
> +		for (i = 0; i < nr_rec; i++)
> +			trace_cxl_generic_event(cxlds->dev, type,
> +						&payload->records[i]);
> +
> +		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +			trace_cxl_overflow(cxlds->dev, type, payload);
> +
> +		rc = cxl_clear_event_record(cxlds, type, payload);
> +		if (rc) {
> +			dev_err_ratelimited(cxlds->dev,
> +				"Event log '%d': Failed to clear events : %d",
> +				type, rc);
> +			break;
> +		}
> +	} while (nr_rec);
> +
> +	mutex_unlock(&cxlds->event.log_lock);
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> +{
> +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +
> +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	if (status & CXLDEV_EVENT_STATUS_WARN)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	if (status & CXLDEV_EVENT_STATUS_INFO)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> @@ -868,6 +1015,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->event.log_lock);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 20ca2fe2ca8e..6898212fcb47 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -6,7 +6,9 @@
>  #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _CXL_EVENTS_H
>  
> +#include <asm-generic/unaligned.h>
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include <linux/tracepoint.h>

Interesting, any particular reason you chose this include order?

I tend to prefer an include order along the lines of:

linux/
asm*/
local.h

...i.e. just going from general purpose, to arch-specific, to subsystem-specific


>  
>  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> @@ -103,6 +105,124 @@ TRACE_EVENT(cxl_aer_correctable_error,
>  	)
>  );
>  
> +#include <linux/tracepoint.h>
> +
> +#define cxl_event_log_type_str(type)				\
> +	__print_symbolic(type,					\
> +		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
> +		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
> +		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
> +		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
> +
> +TRACE_EVENT(cxl_overflow,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(int, log)
> +		__field(u64, first_ts)
> +		__field(u64, last_ts)
> +		__field(u16, count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: log=%s : %u records from %llu to %llu",
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> +		__entry->count, __entry->first_ts, __entry->last_ts)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
> +)
> +
> +/*
> + * Define macros for the common header of each CXL event.
> + *
> + * Tracepoints using these macros must do 3 things:
> + *
> + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> + *	   pass the dev, log, and CXL event header
> + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> + *
> + * See the generic_event tracepoint as an example.
> + */
> +#define CXL_EVT_TP_entry					\
> +	__string(dev_name, dev_name(dev))			\
> +	__field(int, log)					\
> +	__field_struct(uuid_t, hdr_uuid)			\
> +	__field(u32, hdr_flags)					\
> +	__field(u16, hdr_handle)				\
> +	__field(u16, hdr_related_handle)			\
> +	__field(u64, hdr_timestamp)				\
> +	__field(u8, hdr_length)					\
> +	__field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dev, l, hdr)					\
> +	__assign_str(dev_name, dev_name(dev));					\
> +	__entry->log = (l);							\
> +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> +	__entry->hdr_length = (hdr).length;					\
> +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> +		"handle=%x related_handle=%x maint_op_class=%u"			\
> +		" : " fmt,							\
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		##__VA_ARGS__)
> +
> +TRACE_EVENT(cxl_generic_event,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_event_record_raw *rec),
> +
> +	TP_ARGS(dev, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> +	),
> +
> +	CXL_EVT_TP_printk("%s",
> +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..5974d1082210 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -156,6 +156,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
>  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
>  
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +
> +#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> +				 CXLDEV_EVENT_STATUS_WARN |	\
> +				 CXLDEV_EVENT_STATUS_FAIL |	\
> +				 CXLDEV_EVENT_STATUS_FATAL)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..0f272206e294 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
> +#include <linux/uuid.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -193,6 +194,17 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * struct cxl_event_state - Event log driver state
> + *
> + * @event_buf: Buffer to receive event data
> + * @event_log_lock: Serialize event_buf and log use
> + */
> +struct cxl_event_state {
> +	struct cxl_get_event_payload *buf;
> +	struct mutex log_lock;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -266,12 +278,16 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	struct cxl_event_state event;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -347,6 +363,68 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[15];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[10];
> +	struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_MAX
> +};
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;
> +	u8 reserved[3];
> +	__le16 handles[];
> +} __packed;
> +#define CXL_CLEAR_EVENT_MAX_HANDLES 0xff /* max based on nr_recs */

Any concern if I just fix this up to U8_MAX? Makes it more explicit that
the limitation is derived from the data type of the variable. Then you
don't even need the comment.

> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -441,6 +519,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a66aadb4df0..0fd7742ee70c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -417,8 +417,39 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +static void cxl_mem_free_event_buffer(void *buf)
> +{
> +	kvfree(buf);
> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_log_lock.
> + */
> +static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_get_event_payload *buf;
> +	int rc;
> +
> +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +		cxlds->payload_size);

This does not really add anything useful to the debug spew there's
already a debug print that emits the mailbox size.

> +
> +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	rc = devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
> +				      buf);

Minor, but this function is called cxl_mem_alloc_event_buf() and the
freeing function is called cxl_mem_free_event_buffer(). Using the
abbreviation for both means this all fits on the line.

I can just make these small edits on applying:

@@ -417,7 +417,7 @@ static void disable_aer(void *pdev)
        pci_disable_pcie_error_reporting(pdev);
 }
 
-static void cxl_mem_free_event_buffer(void *buf)
+static void free_event_buf(void *buf)
 {
        kvfree(buf);
 }
@@ -429,22 +429,13 @@ static void cxl_mem_free_event_buffer(void *buf)
 static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
 {
        struct cxl_get_event_payload *buf;
-       int rc;
-
-       dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
-               cxlds->payload_size);
 
        buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
        if (!buf)
                return -ENOMEM;
-
-       rc = devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
-                                     buf);
-       if (rc)
-               return rc;
-
        cxlds->event.buf = buf;
-       return 0;
+
+       return devm_add_action_or_reset(cxlds->dev, free_event_buf, buf);
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)

> +	if (rc)
> +		return rc;
> +
> +	cxlds->event.buf = buf;
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> @@ -494,6 +525,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	/*
> +	 * When BIOS maintains CXL error reporting control, it will process
> +	 * event records.  Only one agent can do so.
> +	 */
> +	if (host_bridge->native_cxl_error) {
> +		rc = cxl_mem_alloc_event_buf(cxlds);
> +		if (rc)
> +			return rc;
> +		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +	}
> +
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);

Otherwise, looks good.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E439560FB1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 05:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiF3Df7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3Df6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 23:35:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54797122;
        Wed, 29 Jun 2022 20:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656560157; x=1688096157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KKeKSYrQaxrkbxEJ/oEpnCSre+gCcJO9st4hZHwsR3M=;
  b=V3SMfuuWwkskEFOnBZ8mxVZhchuYnlZXmaauQGW/4k+q8XSdxnLSNzyD
   xtq+RnzWAMKCVt4krTPXv1zfN1gmW+a6VLIu0fspxKkcoL14TuvmtntEA
   Yy5e5ZU+EvRKqEMwPPK1QqJd3kxkDa+MNevGsT58AhqOEOEOjCDlakCn3
   aJz9QMyBlHFJPFBpR1C9BsCst2JTswgZQSSBLfOXdS3nkfOTwv6ckmdYl
   BPeRezB6nnRkazjBYojJf4fBVpirXCP+zklU+s5qOo8esibXkJTGZ0soV
   94wVw3o9MP9GhRV9gLOz7b1GAV6GCxHoYmCPdoLNqAI3GwPh1Y2RGOApx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282964391"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282964391"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 20:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="837398444"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2022 20:35:44 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 20:35:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 20:35:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 20:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+G1h8oQ8BaI55FC/fAP0sKOb5eYb3zk8w4G8UJvEc/DKF3nkYHzggrbrwjgrKMdgjD70hh6J4fPaaw27f8oDR5vqk02lqX7rglHITGyaBZzqD+8agL0H5YnxUTJaguTn8J8m/Qx/KATHeBy+aWfKjoepba7vUz27katnGBKnOCuNm1nc6joVqWXFDqJJjd+ntS3+fN4Y8cIwSKfGWNjM1spKs/0q3ue7ssCGHRyOHQclAHMCSFbO9TQPtD81laINp/yZyZ7hPr48qBc7/yIUY8Bn8QDEOCNnHkke/eQevT2Fq85AnB6h8ggg80clHXSC75MqNYyzd7pAOA9qn6f5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omIN/JJ39VyOByRsGb6icKb0lSGtG2KNWKf6abyXn98=;
 b=jrHCAZwdp6EhFXcVbsu9L0YEv4lQ5y5U7nLqp9381NfXRmf3S1B3cCMfk5VVe4jGVKetM7mZqeVcuuw7p5HfuMj4GVSiMAWKTDzUtz1x/ZFNWKjAx68CjKxTNLznjOkOQ3hqzLXHXZPdA7lLMe/jG5UhrJQjtIunW+I/3+fJ+JcDCpa4nL1BFFBf2Xg5yJBKkOPGSJlSyoIucaK26xq52WuVORq22eH/aS7n6gb94PnKM9tqb9OYrlH/dZiBtfop7N2J1hMDooKAuQybZrK7eTIO7sgP4GjDEPdknR7CHZdW2b3VsKOTyFPELc9pVoB82ePSbpkdQjusaEY+TipcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MWHPR11MB1325.namprd11.prod.outlook.com (2603:10b6:300:1d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 03:35:41 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 03:35:41 +0000
Date:   Wed, 29 Jun 2022 20:35:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 6/9] cxl/port: Read CDAT table
Message-ID: <Yr0aBnTJtFXrCUSM@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-7-ira.weiny@intel.com>
 <20220628154727.0000021c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628154727.0000021c@Huawei.com>
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2055aa6-bbd0-41ed-f61f-08da5a499b64
X-MS-TrafficTypeDiagnostic: MWHPR11MB1325:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jdpAksXOFOZ2Veh3nKSeDMtPRWyP2HZC8TGjG71QLuxjKY0C+BESItHUS3btVPYW2QqgW/Rk5TVMxTE5YN5qEj8OBDgdn02all9qd/8SFkBdNolC9fyedOQJHHsSTL0DvAvo8oefR4Ek7+8UmczwxIuFGz+P7PZcjDcARSbGlH3hinSFuc5GMug+NNcoUT02Pus7LXyk7Vs0ucHpgU8NQeq034RmPcuGyto+1Zo5IdbRwlEnQtPgr+Uw4nvRF/jEgHExgrNxpnQvG9/QH9XKwsoqU/zHmgF7aHjlKaW3zTQ8GNfflwtEzG4ZgM6W7hn9CEkJeVMyL2vmRCWjrf64nLmZe2RJZr/XU58h8mJaFGpdRPFNRoQB4P8ZjSI3h9kRUBpKyThuEEqjgdn72AQjNqgo8rJ9RBX7P7/uWa2DNhj4vAyrxZguomEsIO5t4iMJhtFI5mx84Ja+9XYCk6OegK+7VB0XIj1whTsEuZ2d2AK2l92zcEKZWFsgH0qxF3AgI/mevyGAsujHxi5OUOsqKNZsk8+DWS/V7jUWnMbeH7iJjM3wHpf6uRkJgVp+GOPzVgQhNdoYM7ltknBK5jxNeGCsTzaDxu/T4yZllKr220Cfyt6NBRHSnJDXslMDe0+XlajQPmJ2QbYLFmeczS4J95uVwBRGU+zzvGkIdci0NvOZejbn2MxJ2hiBsnY9wv6YYFVMCn8c8eJO8w6DeAfS60UutOZzPSMxKiLGGVfTYxo/NwS3aSXnNHHO71mbF9WR+Bk2uu1YTUATgDMwSDIP+qLCnANldYCOEQINV63BsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(66946007)(8676002)(4326008)(6666004)(316002)(41300700001)(186003)(9686003)(66556008)(66476007)(5660300002)(6512007)(82960400001)(6506007)(86362001)(8936002)(478600001)(2906002)(966005)(33716001)(6916009)(83380400001)(6486002)(38100700002)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fNnQV7GRarl+k/JapNe8gY98mN0udzNgAho1Wr+wfxHDg4jBFIHPXpXMG+9?=
 =?us-ascii?Q?Ugx2IWPuDigVjT+/ENQop3x8GUm0ouhFgJAVdsQ8wyqqyFyknOXjIyD0jM1a?=
 =?us-ascii?Q?HIU2zw9EJzZiIly3CSQXi/vkY9ibjMgE7m/JeQ+mGCupdjj6hpSUYtp5SK5f?=
 =?us-ascii?Q?7EnKusAF2KSgF4YripzlgOmqDC2vXfyHHR0eF3TBG5mL5syGVbc8Tdct/UcA?=
 =?us-ascii?Q?+nVJoIy/VoZX4cxu5h4ea9Fz1bdJj9Xa/zEE3ugJ9IDcuibsMb2V1/EiLW/Z?=
 =?us-ascii?Q?osMXFCsTACbkAs2HC/0CYx0KpQGyLEZ2Qrc6iZeCRceKnVRAU/UO/EHjAfZW?=
 =?us-ascii?Q?nRN3m17e1BI6FxYaKVAh75y18MkmTRDm+/zt/fP6pzKLpNMGU4KAodtZr9d4?=
 =?us-ascii?Q?QympU1JP0siTdZgyhSppF/ifdFQvRjvtntRUG6/qv7g7IEd5L6etG0LbpFON?=
 =?us-ascii?Q?hkHTGBuVvHvd3VBNt4FK8ZvMlFBGVyrP9yTVKKlyVe9iib6mJkDQB8292mFU?=
 =?us-ascii?Q?7wexTyKC3/3vDk1XMdy4I84w4TOw9Y+Juq1x6uVZ+XgamjoJ+wqoOAaGHdP7?=
 =?us-ascii?Q?CczyMo+EoQ/cFvxQtYyZlLyVGgKC3NVkIV7nLfRAj0c/OR3s2zIkxao35uXb?=
 =?us-ascii?Q?zEvztJeALKj13r2R21QxKQrlAaNwuJwrz6lNS6PoiH0rsJmK1frAkvAgcHz7?=
 =?us-ascii?Q?Z1yD2ewacckayLhC6gtxbpD92JDhuGiE+rvVhX5nlSGympNLvs3x95TBokKP?=
 =?us-ascii?Q?v3vU66cqpomJWf0CID/la9+H2K1ddimaqvX7vEGf0ORADbXdh+0zbZGlSXjo?=
 =?us-ascii?Q?Kqo+rp9uY5NB5QgzwLwDqU8ONHtZZxwuvDrHxtv1LFVDCv8pXyXKnnm0u6J9?=
 =?us-ascii?Q?2vPqmfL8gtMuNIoLDwcfZvU3+AHy4Bgdg7Pqg5F9IvHooO1OaOU5z3fh/KI0?=
 =?us-ascii?Q?c+0aZgjeo7gLrFxyNSKo7SWEqCYBvq5m2FbM30usGJnadfPY5umtKLhOWg0X?=
 =?us-ascii?Q?hn8KfMDObf9Z8JmfdyShhpvQ8KrD99/Rxu5jYR7n/z8iGfnKpf5Bhp9bpKFL?=
 =?us-ascii?Q?jA1A8mwpyy3DqPfk7fAFiW1q5HfJ9Em6rANvm/CfDi2AAmiomztNLvUfxvd/?=
 =?us-ascii?Q?3mWFDxSv6kmyuZuzSg4T32xBwNh2MCuo0PHtRKXYdD/aH2aXVg5oZipznFvr?=
 =?us-ascii?Q?zxIMP1tOnzxK3cYsL40XuYyXDzCiLWrr/2srkrwjkyAWEJtFbvJ059QY4zI6?=
 =?us-ascii?Q?/EPXRhYJDBK0ItSUMuxbLQCEzfm7OAIAHklSWaWhTrAqAZhqWMJqSpGrvvBT?=
 =?us-ascii?Q?mToFIbM6nHiMUzU46MdTnrqDRTRFJZR/7M5swLGS2lkShQXOqvyHQGAizOxl?=
 =?us-ascii?Q?yAzktoUGy2s/K2CJJZogWhsW+YBVssvvDZfgTzmZe5kOk3bDs/yDDGkFodGT?=
 =?us-ascii?Q?JPamFQQA3Rln772nJUHFbPpdtF9Vs1Gs+LSmHdy8iSHpWIRNsoLl1tUp4Ycg?=
 =?us-ascii?Q?i+cUh7NzlQvU8yxDb39/elXCTWZhrHs6fs2nlHWuAA4s2Fv6ESlsqLuYgTfd?=
 =?us-ascii?Q?/NcDi/UtwY5Vp26qQVn4KzPFPyIV9EsjPiYddOjPMmMifa2FBqLUnMg4I71X?=
 =?us-ascii?Q?rE6VtzhdizD8IbDKBqZSw4AGyamog5ZJoQOkUPSX563E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2055aa6-bbd0-41ed-f61f-08da5a499b64
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 03:35:41.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HL1WkJRCeClD8U2NNoR/a3vUVoBbnXogfXAORIolmjaZ4FGrTxdlO4ptsRddeLXMmuDIx+JA1dN/reIFXJxDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:47:27PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:24 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The OS will need CDAT data from CXL devices to properly set up
> > interleave sets.  Currently this is supported through a DOE mailbox
> > which supports CDAT.
> > 
> > Search the DOE mailboxes available, query CDAT data, and cache the data
> > for later parsing.
> > 
> > Provide a sysfs binary attribute to allow dumping of the CDAT.
> > 
> > Binary dumping is modeled on /sys/firmware/ACPI/tables/
> > 
> > The ability to dump this table will be very useful for emulation of real
> > devices once they become available as QEMU CXL type 3 device emulation will
> > be able to load this file in.
> > 
> > This does not support table updates at runtime. It will always provide
> > whatever was there when first cached. Handling of table updates can be
> > implemented later.
> > 
> > Finally create a complete list of CDAT defines within cdat.h for code
> > wishing to decode the CDAT table.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> One query inline, though I'm fine with it either way, just want to
> understand your logic in keeping completion when Dan suggested using
> flush_work() to achieve the same thing.
> 
> > 
> > ---
> > Changes from V11:
> > 	Adjust for the use of DOE mailbox xarray
> > 	Dan Williams:
> > 		Remove unnecessary get/put device
> > 		Use new BIN_ATTR_ADMIN_RO macro
> > 		Flag that CDAT was supported
> > 			If there is a read error then the CDAT sysfs
> > 			will return a 0 length entry
> > 
> ...
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..4bd479ec0253 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -4,10 +4,12 @@
> 
> > +static int cxl_cdat_get_length(struct device *dev,
> > +			       struct pci_doe_mb *cdat_mb,
> > +			       size_t *length)
> > +{
> > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > +	u32 cdat_response_pl[32];
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_doe_task task = {
> > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > +		.request_pl = &cdat_request_pl,
> > +		.request_pl_sz = sizeof(cdat_request_pl),
> > +		.response_pl = cdat_response_pl,
> > +		.response_pl_sz = sizeof(cdat_response_pl),
> > +		.complete = cxl_doe_task_complete,
> > +		.private = &c,
> > +	};
> > +	int rc = 0;
> > +
> > +	rc = pci_doe_submit_task(cdat_mb, &task);
> > +	if (rc < 0) {
> > +		dev_err(dev, "DOE submit failed: %d", rc);
> > +		return rc;
> > +	}
> > +	wait_for_completion(&c);
> 
> Dan mentioned in his review that we could just use
> flush_work() and drop the completion logic and callback.
> Why didn't you go that way?  Would want to wrap it up
> in pci_doe_wait_task() or something like that.

In early reviews of the Aux Bus work Dan also specified the above design
pattern.

	"I would expect that the caller of this routine [pci_doe_exchange_sync]
	would want to specify the task and end_task() callback and use that as
	the completion signal.  It may also want "no wait" behavior where it is
	prepared for the DOE result to come back sometime later. With that
	change the exchange fields can move into the task directly."

	-- https://lore.kernel.org/linux-cxl/CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com/

I've renamed pci_doe_exchange_sync() pci_doe_submit_task() because of other
feedback.  Here the callback is set to cxl_doe_task_complete() and we have to
wait because this particular query needs the length prior to the next task
being issued.

I use flush_workqueue() within the shutdown handling (or if someone destroys
the mailbox or abort fails) to first block new work from being submitted
(PCI_DOE_FLAG_DEAD), cancel the running work if needed (PCI_DOE_FLAG_CANCEL
[was ABORT]), and then flush the queue causing all the pending work to error
when seeing PCI_DOE_FLAG_DEAD.

Ira

> 
> > +
> > +	if (task.rv < 1)
> > +		return -EIO;
> > +
> > +	*length = cdat_response_pl[1];
> > +	dev_dbg(dev, "CDAT length %zu\n", *length);
> > +
> > +	return rc;
> > +}
> > +

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7559C92B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiHVTpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiHVTpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 15:45:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F550054;
        Mon, 22 Aug 2022 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661197500; x=1692733500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CJz0NMiKEP0FIShkvn755YxVUEx1TbGtwhgiNX0HihU=;
  b=d+fSk1yCSuCNtzTZCTmJHkpU8j/qYD1cFm2FNhZeNVhuetcbG0Q846Xq
   EuXDokDAr4v3c/bqLdxb7UKkZd6Xq6PqhsVGzXXPIzvxv8dWLf7bElC2i
   MPg4ailNFetYu7B331dJF59Kt64jVH5kGYtz6VzGrqrQb50wCGWKTUnCE
   pj+W1+Dt3vNrjQIi+mga6xvhNb3i4t+tyg8Tn+PDOtF9gSmCWpzR49qfD
   WKYTjZxJptYnPx7BeKn7mJtzfiguUX6tdprWe0Y1eSKs+KYf4/bia4qre
   GMXg30iZ9knhqgycl1vqcglYWQghRObUfOa5KF6dXA5VoNaUqH5nnbPma
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293503222"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="293503222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 12:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698407655"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 12:44:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 12:44:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 12:44:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 12:44:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 12:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8RNrLQLBojpNvboww5R0WxQAQmT0Ap8UgkxjwdB9xcoM54xwO5THlQWSPYELJfujpdyWISPnZJ6Oj5hJhUUaZBXQuuGzYhtmGWXxUnPhm4l/yVSN98RZQPtPS0SBOPAEjNYZwNBve9eMq2E7yieNhuMU4QMRG1uKNmXXhl5MQhWPWfRXrkCHEnQBDUP/Y48S+CfbEvujn2O78C73ktPhS5l1htHuqx2lgtpHMIz1c6MP4pxVz5DLE5BjRjYE1gDCpjPEoV9eSuufBv2fljWJJ5b8lNDyExz3KBLZ5G51xXPtzWGRBIax8AsU4y7r3+jH+6GHz6iK4wqo1UyhAem4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=491fcHEuu+0JyYJMpA+dABXLeuipOY8syVe7HEmTtio=;
 b=PjMYk2MCxQM2F1B4OdUSCKP4QiiwDQ66JLlFzr8ODUNiZ4AUmqgOpQuC3TxAGQASD4jRalsSP3vpWGj+HmcF1b76G+bnMTxH6aa65HwLB+TcuN6ATt89J63+1VfcuU0jwneMw+hAzShE51mLgYd3ovE24x/LD0V7bC2WhmhTv6hIs264Xpbu2SXjEU8KQ9Vsx1/TPvg9Jcep3SRFYvS4YimCLTjj8gPLIewShp0b/lf4mL/LkC1EFesrIMr7OE6RGpwVLCPp0YuvppocMgb6BC/DzQqQzk/+coH7FwMv+BLC03yY9vWTzx33Itt6bA32f+cEA/SftXgn+zmD2J3uCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6710.namprd11.prod.outlook.com
 (2603:10b6:806:25a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 19:44:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 19:44:56 +0000
Date:   Mon, 22 Aug 2022 12:44:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220822005237.540039-1-ira.weiny@intel.com>
 <20220822005237.540039-2-ira.weiny@intel.com>
 <YwMktMqN0oFgCeZn@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwMktMqN0oFgCeZn@kroah.com>
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e365e187-3100-4228-5891-08da8476ca73
X-MS-TrafficTypeDiagnostic: SA1PR11MB6710:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTh2kOypfB1WbjndkhCXmgZRAmIVXVdGI/NINqp/d1Ag4zVCjY7RmmRsDuQm8pK0VUS53oSxjQEgASblT7ZvmzN/TrjegRFjX3dq7MdSZtR3cKbEfjjrqpj2FoevUeJ4eQQtJ96AUjIC1KD7S7fA2I7LO0jpZ955Fui4r3t42ZM7JgZFJj+HxiCjDvGNhMlkoYopqRaFCVvjkJkj/NjOl4LZo55ng2iouXo5tbpdhUrMncHnl+wVR0z2etSdok8UxMsOgH74qit1znJbU2IZHEuSGz2b6RHHxoZYzmLOonkO1KkeKdQsjzNM3XJyzAZXx1rRjI0K0aZdS/NS0g2g+6Pp8pLp1hjlwXzARSgJ8p9u3uREEK0ceObrqRARjehEXGq1n/dHHkJzsrmCEfx3Z5zDRR9JVL32Gg1BIPJ+HTH7HiBrjYzn/YZseSQlnYl/LwDtszmwYGhg3ye4nqVNI6kgdUFPkPORfua6yApTk7as55+5fD6a6l4AVauyhOKiMKAuFb8VTXrTa3Nb8z2UpuKJhJIaTOVUcjp9uehcTOBvtAQ4vpToerBL20J01KEaEOMOsme48onfiwKbNle6UxewBXADxC1cjPZ15njVw8XfMbXXqIO+HkeBwoP6YPpAMho7Nl3ZwMsD+Cg9Rs6spxufd6kphjoftfZis64JdH2+cqERUAgmJZdL43CfKMGj+f61j/PQMEBxuGdzoCS0XzJXRI0CDkJOycAC2h++hZa90C3+fdA0WTXhvCrur1e5m1oxcusK0ej318rile7x+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(54906003)(6636002)(86362001)(8676002)(4326008)(478600001)(66556008)(6486002)(6506007)(5660300002)(966005)(6512007)(9686003)(186003)(26005)(41300700001)(82960400001)(2906002)(8936002)(83380400001)(66946007)(316002)(38100700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2t2wwIRxMXQwYwa/HT5flwiCLIbAdRjl7310HH/hZ0aK8b7V6iNUMPRUXKq?=
 =?us-ascii?Q?zjIAN5FO2iDQVGovohueEEh/ijEhxjWOxP5bFe8yDsKPicgdUkaJwsx2Z+o2?=
 =?us-ascii?Q?hKyVGPn7xaqtv/NDFRvZUqJmetpx/0/vSsKUKEyoxbFQgPpzWuzeIXcs/o9H?=
 =?us-ascii?Q?ugNKve/Xqx2IQleSDemTU/4GXOPMdxshlSB210lj0YeyrUweMohAsTp/a6vB?=
 =?us-ascii?Q?FJxB1nRRkk7pveL1w2OGr3MqpPHxWx9VTA4MnOuJbZMNlFNPzBQMlHZq6yL1?=
 =?us-ascii?Q?JSrLs2i3KHiQ2l+uGMprVvQ1+0Fd5XVDwPC4bvyFoR4vv8naHRyEMein9Q5L?=
 =?us-ascii?Q?r68RvoZhYH03uT1JppKBFz7Lv1rRt3gz9HdegnzRJNLlBI1nRNTBLUsjwTcs?=
 =?us-ascii?Q?mo0MGP+mdYtc/AocUmcr2wdEQ5nzVutRmNFI0BHcyEtKR2H6k42x/vCSWf2m?=
 =?us-ascii?Q?LwHepcTj3VO/nSgx1UN3yw8mG9bCVyTeKOlLeDzYyS+QrBe++EwF7/U1AiSJ?=
 =?us-ascii?Q?ZHIN0ZS1Qz18zqOG1G4xbgOI/7epveh/OtCD+O/Pvp/lEUMR/b2mhUd8hbrE?=
 =?us-ascii?Q?SGHC39KjGxCPw8vuAV60R1qGkhyKP36RvDVoXUAxv3Wv8GesQD14xl1k6HmB?=
 =?us-ascii?Q?vBLHl0ZP4WCeJ13Jat0zYBnqtEUS3ncjijg0tRYs2dLu2JbKDhsZ3O6wixUB?=
 =?us-ascii?Q?w+Ei52m3t9HErJg7+jMnW8pr/UMHqgaLQc+rXY/gOxUIwE/NjPv9/CHGYlia?=
 =?us-ascii?Q?CpycGVf7gNpwyxenqp82Qbs6enIL7gpS6+JqK/zhrC/d1xk459KQdWc261Bz?=
 =?us-ascii?Q?9g0PWacC3bFWOdoyY7iWW70WzNUwfSIqBYaMC76DBpz5EDsSoiTqFko7yLUI?=
 =?us-ascii?Q?eP/cbgdN2aNmvgo+JoOR4KOLj/hnMeJsZb2Er5bxOlU+ugWYAkKyGkHIDp9D?=
 =?us-ascii?Q?yWFE2YefKrGWXCMbU1CkRt4tFpulMwdV0kl05seNZUKOBKiZ+VKBajQ40JZE?=
 =?us-ascii?Q?wdKbR+YVKwHwf7QwkKEI9YMYhCnv0CgIF+4R3MVZVNIgZ5MCBtonc6fu77Da?=
 =?us-ascii?Q?m4TkvpDcyCZrEbCH1wmpwjGT/6W93rdUdipySj7W2MKyglaQLxdwAwnNWWdD?=
 =?us-ascii?Q?tueTktKnlo4WOSl1BCHn+/hFLElVOn1lM7z+wZlp5crca7eGL7mE3gAp2wPi?=
 =?us-ascii?Q?C9dcow2omDtgCHffOCazMQopf4Yq/Gk7j2vrLv0gNUzKMkSt2SvaAnO06j5U?=
 =?us-ascii?Q?cGfDNNLVJRU/uRVkbrn/Ns/7NEH0dIeV9wzG85S5XFE7GwIAkaLoqku1CV+r?=
 =?us-ascii?Q?GtY61mYSAWj9/XvlttyFqEnZ/LTRgxC7qSIxlU3ZDHuZr+mPBjb9xa7tDt3B?=
 =?us-ascii?Q?2R5tcuRTbz2N4CtBS6rVvvh6v8UQmtt2u76t+oi6fDFRqRmJX6SbvSiT0mK9?=
 =?us-ascii?Q?OUXo+7YESgP30oOopFD2RHjorZKoQzoGe+L2nolVdXgjuvA0gwvDVhPIemdc?=
 =?us-ascii?Q?PLQe0obBZS59HsJy8ZFfdsArnsncPFxm83HOUw/o5CygUpc/RC8nRofjLjpq?=
 =?us-ascii?Q?mzg6Q75PeU1I1H+D5UJTDpnZVFLjFB3S/G9nPWZuOe0fkgiCEYZqsXc92AFm?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e365e187-3100-4228-5891-08da8476ca73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 19:44:56.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPfMJZKpZ99fwao3puGiRfEd9ZCjqfB7XdPql4bvVaXVL9fGPB8V0OiGPKpbOQ0oUrLI0+Xy3lwuYZ/Cj1wEWj9FUewZV7RfCPOh1SYjN08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greg Kroah-Hartman wrote:
> On Sun, Aug 21, 2022 at 08:52:36PM -0400, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > PCI config space access from user space has traditionally been
> > unrestricted with writes being an understood risk for device operation.
> > 
> > Unfortunately, device breakage or odd behavior from config writes lacks
> > indicators that can leave driver writers confused when evaluating
> > failures.  This is especially true with the new PCIe Data Object
> > Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> > space through things such as vendor defined protocols may affect device
> > operation without complete breakage.
> 
> What userspace tools are out there messing with PCI config space through
> userspace on these devices today?  How is this the kernel's fault if
> someone runs such a thing?
> 
> > A prior proposal restricted read and writes completely.[1]  Greg and
> > Bjorn pointed out that proposal is flawed for a couple of reasons.
> > First, lspci should always be allowed and should not interfere with any
> > device operation.  Second, setpci is a valuable tool that is sometimes
> > necessary and it should not be completely restricted.[2]  Finally
> > methods exist for full lock of device access if required.
> > 
> > Even though access should not be restricted it would be nice for driver
> > writers to be able to flag critical parts of the config space such that
> > interference from user space can be detected.
> > 
> > Introduce pci_request_config_region_exclusive() to mark exclusive config
> > regions.  Such regions trigger a warning and kernel taint if accessed
> > via user space.
> > 
> > [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> > [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from[1]:
> > 	Change name to pci_request_config_region_exclusive()
> > 	Don't flag reads at all.
> > 	Allow writes with a warn and taint of the kernel.
> > 	Update commit message
> > 	Forward port to latest tree.
> > ---
> >  drivers/pci/pci-sysfs.c |  6 ++++++
> >  drivers/pci/probe.c     |  6 ++++++
> >  include/linux/ioport.h  |  2 ++
> >  include/linux/pci.h     | 16 ++++++++++++++++
> >  kernel/resource.c       | 13 ++++++++-----
> >  5 files changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index fc804e08e3cb..de41d761bdf5 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -755,6 +755,12 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (resource_is_exclusive(&dev->config_resource, off,
> > +				  count)) {
> > +		pci_warn(dev, "Write to restricted range %llx detected", off);

Note to Ira, I would expect a message like:

"Unexpected user write to kernel-exclusive config offset %#llx\n"

...this probaly also wants current->comm similar to the
lockdown_is_locked_down() warning.

> Will this allow any user to spam the kernel log from userspace?  You
> might want to rate-limit it, right?

It should be a once-only message. You only get one chance to trample on
a configuration address range that the kernel cares about and then
tainted.

> > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > +	}
> > +
> >  	if (off > dev->cfg_size)
> >  		return 0;
> >  	if (off + count > dev->cfg_size) {
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 6280e780a48c..d81d7457058b 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2303,6 +2303,12 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
> >  	INIT_LIST_HEAD(&dev->bus_list);
> >  	dev->dev.type = &pci_dev_type;
> >  	dev->bus = pci_bus_get(bus);
> > +	dev->config_resource = (struct resource) {
> > +		.name = "PCI Config",
> > +		.start = 0,
> > +		.end = -1,
> > +	};
> > +
> >  #ifdef CONFIG_PCI_MSI
> >  	raw_spin_lock_init(&dev->msi_lock);
> >  #endif
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 616b683563a9..cf1de55d14da 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -312,6 +312,8 @@ extern void __devm_release_region(struct device *dev, struct resource *parent,
> >  				  resource_size_t start, resource_size_t n);
> >  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
> >  extern bool iomem_is_exclusive(u64 addr);
> > +extern bool resource_is_exclusive(struct resource *resource, u64 addr,
> > +				  resource_size_t size);
> >  
> >  extern int
> >  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 81a57b498f22..dde37bfa0ca5 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -409,6 +409,7 @@ struct pci_dev {
> >  	 */
> >  	unsigned int	irq;
> >  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> > +	struct resource config_resource;		 /* driver exclusive config ranges */
> 
> So the driver only gets 1 range to mark this way?

No, config_resource is just the base of the resource tree to walk
similar to how iomem_resource is consumed in the current
iomem_is_exclusive() implementation.

> What are the ranges for typical devices that have this problem?

Unfortunately DOE is an extended capability that can pop any number of
instances in that per-device list.

Although I also think there is potential to use this in something like
pci_iomap() to trigger a future warning if userspace mucks with the BARs
that the driver is using.

> This still feels very odd to me, how far do we have to go to protect
> userspace from doing bad things on systems when they have the
> permissions and access to do those bad things?

Right, this mechanism isn't about protection as much as it is reserving
the space for kernel implementations of DOE protocols. Outright
'protection' is already there today in the form CONFIG_LOCK_DOWN_KERNEL
that prevents userspace config writes. There just are not many distro
kernels that turn that protection on.

> What are you trying to protect yourself from, bogus bug reports by
> people doing bad things and then blaming you?  That's easy to handle,
> just ignore them :)

I asked Ira to push on this to protect the kernel from people like me,
:). So, there is this massively complicated specification for device
attestation and link integrity / encryption protection (SPDM and IDE)
that has applications to both PCIe and CXL. I do not see a path in the
near term to land that support in the kernel.

DOE being user accessible though, lends itself to pure userspace
implementations of SPDM and IDE infrastructure. I want to develop that
infrastructure, but also have the kernel reserve the space / right to
obviate that implementation with kernel control of the DOE mailbox, SPDM
sessions, and IDE keys in the future.

The warning helps keeps proof-of-concept and/or proprietary DOE code out
of production release streams on the observation that end users tend to
demand warn-free and taint-free kernel deployments.

Similar to CONFIG_IO_STRICT_DEVMEM, just turn this warning off if you
are a distribution kernel vendor who does not care about DOE vendor
tools affecting system state, and turn on CONFIG_LOCK_DOWN_KERNEL if you
are on the other end of the spectrum and want protection from such
things. The warn is middle-road option that I expect most distros would
use.

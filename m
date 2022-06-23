Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2C5587FD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiFWS6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiFWS6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 14:58:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3D42489;
        Thu, 23 Jun 2022 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656007392; x=1687543392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hqo71hZdVehYBvg8F+d5ayo0he14B1wqbTTfsZ1YACw=;
  b=du03qeDAP3KhSlfV+M1l9h679nLt//K7THowmhCjkk7c5bbprGYqUNv/
   9qgGSqR0u3sP27AvsAns7xp5rZKI046VFoPL5lud0ihD964o1YUxYj95U
   X8ecmt7o3NXRNBGBGQElhhUBb2qyG5dcAINcLCrs6FiowCvnvVEBUS+5f
   GiQhggxjtg5yQrq8AwrthRpSzvpZKR/HZHIQ8tTf64s1CvyxV/L0gzRcR
   MRWH8OY7JYcmqS+pRxzAJH52FwvDC1BxTlmNxArIhQC6mp+XgiPqucqN+
   Y03QmLJYkfZWwvdiimwitDWe4mvq0x2Dt3VoHOfi24Emhwfy73OQQfarb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261227692"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261227692"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="678171391"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 11:03:09 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:03:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:03:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 11:03:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 11:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsvGvKeZgoOaaBdopZcxOb0Wr04soAyLOOfq2Iadiv+VLcpgzdkqPs29mzF0FNCCUR0dCpAUkT1ttbVnzWz78YTBZPdjguVS4abgw5fyLHhU/PsAk9tv1LEq7IHmpM8hcgtAfTEplQn7PYudPdbTyqaR9CUrR81vZwmde2J1JNl5ME2h9oB/EW1ubcAG3W8FBMg8S678Q45wmzpC++uzsw5tfOSh+g4vTNrJEIQrhJOEGgtOMCgrao2Vhq15PfXkzCz2238M3ZNhlAjr9G5ZDkiUgOge6GrSijEF7b9jaSp2QFEwF8b2gwaj0akSxwX+y3dJF5GHn4eRmc4TgLnZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvXQY50ZfiGD8qNvHWUS2gmOSWYuxCVrvevpkHwDAk0=;
 b=KJZOWDkgFhv+12vzk1QP/DIf6MqoouxSk4KWrfS571XNzqVKkXPyWs9b04ve8UoQMgEBvu8ZhN3QMSYJmRAeJRRhNp+WceAvLrb7EkfJWJvND6DyiRjh2/BLqNF8LcEENBPX/gW3CsAjse5lbi4xn4re/xoWGMeRMGhIoXZcF97n+Lu0kIiStfu4vFjNcktdxDnqb1FMvoma0FK3DQSlGxgp+p9jiKq5k/Okjg2l+gAOMAYxX2zjDNO/pcDili1fnt0fLXfJrGoyl+eXBKnV4izJcpY5gfY01Z2Auitspqhsof/5QJx+wVZ+4XEAIcdT3TTSpIFKXSaNS2MMM19TOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4874.namprd11.prod.outlook.com
 (2603:10b6:806:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Thu, 23 Jun
 2022 18:03:05 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 18:03:05 +0000
Date:   Thu, 23 Jun 2022 11:03:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <62b4aad6a2e71_3c3ff0294aa@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <20220620112328.00004f63@Huawei.com>
 <YrOea1PQbSA09A6r@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrOea1PQbSA09A6r@iweiny-desk3>
X-ClientProxiedBy: MWHPR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:301:14::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3156e646-02cb-41d2-7ab9-08da55429ee1
X-MS-TrafficTypeDiagnostic: SA2PR11MB4874:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnrWNg4Ld4sE/FquLBSuajuK8F2qxVnN4qMOyC9ROB0JuPea31UO5i1vUSn5Z5dOqIT/ATWWj2PCRqGQ/lPWqBONRluQdGZon97zxPhhXhbV9csFHJ+ukRD6Z5kCfW4AomK99NhjWWQTjvdlVDwszkSxZl+8dDivdLEeJdzD6vGxm4PhvyyorOCqZJziFhknR4JxCoO9yGoTLQdDM4PiPkhDGD8yuntKm+eni6juH1xm6PV73J/0kBgE6Dkxj+0gXwfBGDeg0R4CBjlKBW1/H1BVkxsfq/uUoqfe+L1I2slsjpqLl28b2eWfyGaKUpy6+zS4NAaEkoXpuXnm5tO28CzGbRJCrnabBRsXDrX04tvaYx4KEW23hCqQ+cx+vf5gE+POw9JG8Fwu+MzAwoqs8wUh9NptPNtj52fLQlg17w3ZYNTefzadxmVf48rJ1yjQslmBEAzIPd9cveDnrmxD2M9V9kyhtNwpaFUPXBrGLUAC2SUYfW/wY6I1doSH7V4r7AMOm4NF9K+G3VdwKol/iMLLz5QcfL0nh5Yet3IKc4ri6FrtWNpdgFRh+ma1AIFL/w1Km5GchUbIeS8kca1gbPp6YTFfnIbCcBEWT1WjotjpHvMKMEQVGVPTq850to3/bo0ulQjSMJC0ryHBgIcePxQtndTTF4RXK2ru1Agp4MFw4kqtGyW/3nCRGueeHHvui5bhGW5jZbTrjNo4ySB5+9gQe+9B5WxWq3YLJ6F6IRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(2906002)(478600001)(316002)(6486002)(38100700002)(8936002)(26005)(9686003)(83380400001)(110136005)(66556008)(5660300002)(6512007)(66946007)(86362001)(41300700001)(66476007)(8676002)(54906003)(15650500001)(6506007)(186003)(82960400001)(4326008)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdvUhLXhVii81sSFcoC21r1tB8p1aJP6Z6JLQjuXoEDkj12gFhPPJIMwpMRO?=
 =?us-ascii?Q?cWrcAi2yB1yBKJrosD4IDmf1w+EyF9S7UtiP0VudDrHbg4VSm6LKdcfyOZgS?=
 =?us-ascii?Q?p7kLYwYuFSoEJFuPpf7kwUoRVK+1klisuyLVAbag4G1xhtT2059RnXIHy91f?=
 =?us-ascii?Q?xTfIEbg/W3SiW22rpgCX5o0kncTRG71xAi7WUbdfYszWlOMbxappHX66t7IO?=
 =?us-ascii?Q?FjwhK7BAlKiQq1uOHvw8IfE2VCUqoqfzqrrNHAfBcZQBGnInX0DX+eHSp7Wq?=
 =?us-ascii?Q?S/0xiebvP2MGGk8PQ5u0B7CWmlNKNOuUQXQQPsSUt+02j/q3Ga0TUlDUF2Up?=
 =?us-ascii?Q?bAh9Nh6ITfYSShIqIwWsIqHySaqd/AMj++KpflBmHBLPahss2vzN7Lzg1nhi?=
 =?us-ascii?Q?0WfRslDklyKjHADZJCM/tmEUaX0fJUc2Brr9aCyI9y+oxoicjyyq/fPkwJ27?=
 =?us-ascii?Q?yApFbK4mTlyC2o4ugMYWm/ePMTEoL9iNC53p9wtw51durnSJMCKGW9iXQiaB?=
 =?us-ascii?Q?n3RDt1Ptns/jA75meY0ft8ejT6/ICZLMOyvT2A47+B7JduVoE7Hqn75TRR1C?=
 =?us-ascii?Q?o9MRz1S0ZEwfIuxGI2cht00lLmmd2I/+20DgFvL7UEdsaXcCzljDYrdH3Tkn?=
 =?us-ascii?Q?Q+dUxGkuDUSrQr8RpFpZ2WnTiAJ35gUHHAlAXOKTIExhcsJvXqlQ7ST8hKtE?=
 =?us-ascii?Q?NS7Uq681BdDLQf+6LBpZ1k2uqpP/D3rSfKs5zR6Jlj01Gt0Ge5n3xt41epJT?=
 =?us-ascii?Q?DKd3440Vpi4McikhYJy+JlcltHhQathbbiLi/ogHuIK6CS6SuMHLR+7+EsaX?=
 =?us-ascii?Q?b5Imi4X0Xo+G7C+AAO/UuOiDaMsLFIJ99+H3q3dPVbFdUI3IDdGnI8XtccOH?=
 =?us-ascii?Q?8a3w3C5x6LFTnIbhC4WuXl3uTurxScwF7mZs/AmkwgbaDqx1XOZKIyDIduhU?=
 =?us-ascii?Q?5jWgmZKqnVaf5vKK+FiGSPdgyaWXLmeAeSMKmrGa4TMkS/T7/T/sPXOtDSaq?=
 =?us-ascii?Q?05xfgZB+oF5ubW8hkcBoDIHbcW3w4zBuBH1Clj2SfaMMhxy2Y3TmtcnUTSbo?=
 =?us-ascii?Q?6TgGVZlivvaEkm1RB+dXZBAS4qJz4+soFPzThtJzK3NQ8LRvqz/7G4D6WonB?=
 =?us-ascii?Q?gH6BvUEinduDrtX8cFRWk2WBRCsOgCz9lJRbCIBgdUVHqeP0C+wOlvEKRFB8?=
 =?us-ascii?Q?TzRVoiuhT0cJ1agKLflgsPxcTNigvkCW7QhKvJQibQEnNZpQCnnp5UzEkDAG?=
 =?us-ascii?Q?KL7V8hxt1WnuogETOKNhLK5rFoUjzby1MgzEi7fjqIs3EgLaL9obx4QErDpX?=
 =?us-ascii?Q?R4YH+c3FBt9hqsRAyEKVvxiMKQqoHrmVUmG23EFod5ht1cUKXWuuJaoFU+pd?=
 =?us-ascii?Q?E5ILpHM9Anitwrh47w5Vm549q+Lb7Ug0+PqUQYoVWR2e1GL+1ADzUw+/0Rew?=
 =?us-ascii?Q?+DETY4zi/NIpD9QRgs8za4cwgXXrPh6robb9QTZ/Qb3XkAyQ8DaNIkt3rtge?=
 =?us-ascii?Q?BebJ70U/9iW1aXc2R4bS4rlPPfk/pCvTH6eRCxA9BXJYQqfJtyjO8el/8NOG?=
 =?us-ascii?Q?cDLgQBxLnWNoSuoYb9kZNFiKHosPrMPc9RsgBKZ2rOU6qZiyqnb4uQSrqF2f?=
 =?us-ascii?Q?mk47X1eXbUrgalJEaVpgkgNL4CoqU+5lfxpucEdUDgzEiY2dJPZXTg6fUCuD?=
 =?us-ascii?Q?G2Z9QtSQ3n/XrVtmuSzzIuVZo1yrP/Seb0r1lAuYmNhf0eAQvCnl/By+5GZ2?=
 =?us-ascii?Q?P2xk+KZUEcfNczggcOFa90zFnzuWPW0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3156e646-02cb-41d2-7ab9-08da55429ee1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 18:03:04.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58ufXz5yX0xQT5AcfANyfmVxnKUInoNZIVvW1Qp5xI4fw1gfphp3gdY38LQ6oKlrlf0e3z+KU4wQFKsB/ACszO/MsOOpMAe6Z0ItRQUcPX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Mon, Jun 20, 2022 at 11:23:28AM +0100, Jonathan Cameron wrote:
> > On Fri, 17 Jun 2022 15:56:38 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> 
> [snip]
> 
> > > > +static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
> > > > +{
> > > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > > +	int offset = doe_mb->cap_offset;
> > > > +	int rc;
> > > > +
> > > > +	/*
> > > > +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> > > > +	 * this multiple times and thus is called here to ensure that mastering
> > > > +	 * is enabled even if the driver has done so.
> > > > +	 */  
> > > 
> > > It is required for MSI/MSIx to work, yes, but if the caller that created
> > > the doe object has not set it yet that's its prerogative.
> > 
> > We went around this in one of the earlier threads, and I think consensus
> > was that it made sense to have this in core code.
> 
> Yes we did.  This is where Bjorn asked for this to be done I thought.
> 
> I verified that pci_set_master() is fine to call more than one time.  If the
> caller asks for irq support I think it is fine to do this here to ensure that
> support is enabled.

Its moot now that irq support is being pushed out to a follow-on
change, but I think its unfortunate that this makes it difficult to
audit when and where a device will be enabled to send cycles. If at all
possible I think it makes sense to keep this the responsibility of the
driver for the pci_dev. Similar to how pcie_port_device_register() does
this on behalf of the services it registers rather than each service
doing this itself.

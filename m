Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28DC5611D3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 07:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiF3FdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiF3FdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 01:33:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB452647;
        Wed, 29 Jun 2022 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656567193; x=1688103193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Abd2WZMwoJq+d090+GPm2YhhHu2KIVyprEe4y+JPIjA=;
  b=n/LM6/tR5kcr504qs0sxiXtL3caEI5KF0hTr3TbY6/hjI8soqbopuDY2
   tqLHJJNhz8t+Ih9RF22pTHndxKrR6bkI06l/hyIqR6jpvnuMqHw1L4xEc
   Wd9qze9uYIV0RoO/LF4ov1qyQHZp5x/QSHdjzLPRswuDiZ9jS9mqslooE
   HRIwZFX27wLk/Y0q1dDwXg0bXsYLmxEwyoaxow2Fzj/fJRMVjXIILyELf
   2D90QJAIzLzZyz1iQOxrorbpZLeKyPf1ty8R/U1JG33BkW+s2EZAKrY+K
   kGOx4LxTmuHQ54rEen3Xkms1AMvTrlJAO3xfGDQe1bLAXPclTEFkc1M0R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307753054"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="307753054"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 22:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="733489642"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2022 22:33:13 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 22:33:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 22:33:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 22:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdEj10T0JBDOXuV5wCU1jJQin9koT3DoUr9nAyAH5wHTSKfrAhm/YGMVeqdK7a4PvtUok8Znqe6Wx3BOWtcEiSgWMYr0D0Tvn3gQ6tN+AOOgBUy0TjVeJJSim7WQkQ+/EAb2We561glM9iuJ9hMcNiswwJ2pnUAS6d4mhk+QM5jqhwoEfRdk0d62NCm4xrr4gDqcLJuh48kjoLAsS44CgivdNxqtbFHFwR0up0HdBS54mi3jbN9P/ixSUC5LvlAMS483txaCRhLhSQ/cvHbn3CMPiulNXwqMy+N1XfEI9bbNZcwOHJqZOD/bb2Rj/fdAn4j3J6sZRaA6gTA48mQFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5GPdTgBG+QS6yKbW6QQdb4aERAbBpVFw6ufkjVrjIM=;
 b=Di5+9pPZODrz1DmUCTk0mYn6ZHVqM93VmAKPMBHAEDNLc8T1yOK1n0R8DqwwomU7Inn4HANaxkNthYtfhRwHb1bx50sdvXH+sb/xQgwP1PSBbT1Hrzl3pOfeCUoJAZ8k0mFrqOrHwPeeXcz6IedaZpGvHntlk6yhOhiZXtQQ6OnjTKSOG/7FX3il5ot1g2u5Lt1TUffjEiH3RL0wU3hiCeGNqL6PtYguueQ0CJk31vtsbel756DLf2xrGUVNgQsyb7+uE/1MQFI4PTDGUqvTrCNVhPK6fl8HQ05eUUQcQ7Rhzqt8eEpMTqJwIPr33OunAz/iGV3avjbKJIsZcdMsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 05:33:06 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 05:33:05 +0000
Date:   Wed, 29 Jun 2022 22:32:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <Yr01iZhuG5YHThDg@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-5-ira.weiny@intel.com>
 <20220628153317.00002e36@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628153317.00002e36@Huawei.com>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2cd31f8-a737-484b-d1ec-08da5a5a0211
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLvM61ccKC3ZfGs+fNT7oVoT0UpQ9OfisssqS8hsMhPWxLij4K0DlHQu+I72NKjKuYqNGAq/7N5VhSID1quRI/ck2FeUrPow/UNPXsuacNymabf8S+GzMJjaLsLpZXv0/ISjArP1S2aESt+Sez4+N+QbGEwJ/UvVVChq/mzmvcSVHXOiHbfP68SIwk4fN51D6fovHbobjj3tZbuOVw4RCPBfWryCJZcw3hYY+35+hfEU0e458x5MHEqgnC/zrBoSTNViVb6aRxqnhudJRFuaKszZi6WIx2sFeGq+Ph4Q/Odt4vuX9Ij1hxYNJbKAZAwa8Hw4H39EupDyQ+tKnVjPZPxMOyC2U+5mZnVUAKl4Qwe1wQAfjgqoH8u4wgsIm9CfiHcqSkxZ2HGMngUKYgeVI2Sif/5UJK9CENMk3sknJLxmIfD5gPhTP56xmdXhGAWF2umMHnx8Z1RZxQWGDPjX3SD/q3D/9t5R1l2mqeHa8fYAxhUcWIALcrSVnVAtq2mWAG8xWg7HiPcY9uBN0LYfn1hEbDGyrTd7m7mtLewtZq4pohRGe72RLo9L2g2npv09vB7UzZVKVYC8QV7JxcXhFuXDfaCgAr296iy1l0ZwlGxZKGwlOiJmkkoy3nXnqVcJ3Olwya5LGm8hgDfNd+7LlTQ6CWNyh69NSj3FenmAvgrrHvcpcTFAp40MbGULjpX1b05wryVV4K0KJcpG/F7d28afj4r6S1GR7XyHup0W/DmhggdjnHWbNtwtJQ41zd4HPR2KFC2zWbDnyTFZ4SGbcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(5660300002)(41300700001)(186003)(8936002)(86362001)(478600001)(6506007)(2906002)(6666004)(44832011)(9686003)(6486002)(33716001)(6916009)(6512007)(83380400001)(4326008)(66946007)(38100700002)(8676002)(66556008)(66476007)(316002)(15650500001)(82960400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JipUcshqbXIkIP3S7/tJphm4JJYJtRiNp2pqdvfuW+K63vykn4wL6oePcfPy?=
 =?us-ascii?Q?Yr6zM0ic5OsvA99H7Ai0oVgtoZceeNmkJ4/H9wktwSaBJX52Lxkp6X3PG9/3?=
 =?us-ascii?Q?JUNZdjIChucEOGxCgqeEIO1YcbBYCGaWUn9FiQBYMulgD0e3eOsc/S/EAVLv?=
 =?us-ascii?Q?1eHwqK3IJe/kiAJXMvCy1TewD/c3h7rdghDPHwOPHQ+1ce0E9HMf0o87bcwM?=
 =?us-ascii?Q?ickyPkrRRcOSeLg+oovPKpLABTQzkvvj++B75+yAsFfZknAGoEQslC43IU4S?=
 =?us-ascii?Q?S6/65ysRGDSn0W9i1XeZvIt1GcKVRJcbrt03QLnBLfwK5Iae8ZaOiMtUFdd5?=
 =?us-ascii?Q?gRCxnQ1kLbsWm0S1ydjpQ2yJXTE76iIex8tf9cuxnNUrA+tenHVqqkCTHoRZ?=
 =?us-ascii?Q?paMzD64RqFD6eNt+jBQXUPyxGL/MunLnqsJHrMtq+zyjl+CaEZxLnivc5Gxo?=
 =?us-ascii?Q?zjuITMQOmLcSDNJ54OJZ2GgPvuyDdtyIB0n4viQl+aH/hF4STAmTbqdaByR2?=
 =?us-ascii?Q?BZEJGN4RIB9mx5SGbXsDJEX8ji+tVhUeHXdZebhbYEEZSzV7END3zbQAk8r/?=
 =?us-ascii?Q?eA/nBXnnwwKYeFdP0cJ7zX9+mGsvUq4Xynkw4fIcG8593nN+RHDlbzoQ/hqw?=
 =?us-ascii?Q?DgAruVUdIKMEgFGprYgOqvWtAdl1gzkXqV/BalMUC+8+rkEfRT4LfMcsTYLe?=
 =?us-ascii?Q?9eyFSRKgXY2msMinLBDSae5x7EvQqm1kM7XlYJyi46Zpvx7e2pN/Yl7CP2uD?=
 =?us-ascii?Q?AjJ3bx8YHzJ2xgoXrUDHYv/znCVZPfUYqEe0L+bcGaC41MesUHWeOYczXvOF?=
 =?us-ascii?Q?ezgtlRaM5FECZOiyv/B7AdM+mbFJvzyA+aj5ALq1DTRwCP5Dyo57HB+7mK6D?=
 =?us-ascii?Q?WnPweB2E1uYpuN3p7Lcy5D/kkToe8GXZyae3g78ZKC24tRNMaiOjdWzxv/Du?=
 =?us-ascii?Q?oWu1QDr3SbFk9oaJhf4GX93ufIhI3Y5V8c4hYwIR3zuNaH3ncIqlX6E8gbcR?=
 =?us-ascii?Q?1BGe7WHfR4Av3wr8FZWxBffBUs0UOm/0CKgiJivK2RNOu/yJLtNG/otfrqy1?=
 =?us-ascii?Q?8qsYR1HeMPVE8Wo4/AykKS76ID+BB7CdvfEBiYFdO0PlLTeyfMYwDj3emAg7?=
 =?us-ascii?Q?bOdrzSn8Ul/3hYLqk4YUusdYsGJwNXICNhf7AqCMeGUUgRApMMT7hKGT5fTK?=
 =?us-ascii?Q?y/czRw/bdt51cITxGOnvgdUuUxx3QzRW8qDzO1vtozBMb9hDqTIjCKC6lLfj?=
 =?us-ascii?Q?LxJc4I4tmWqzK3/UYDPWln6jsWhZvrzey9eioQPM12Ho+expfi4TBTLhcUgp?=
 =?us-ascii?Q?ibeWh1rrPEe+zIF2jV1peOlFon6L+kmUJrXG0MJ5f5pXr9J9ZtU6FarmIKWl?=
 =?us-ascii?Q?boMSC7E+9IygCSJO1mBM3e5mD8errJinxF4u1Kll89nVSo9q3zlhJXIwdkSb?=
 =?us-ascii?Q?y92FUbL5DpBn+vQk6kOcsLJc9Z0cWgi5elPcJ6yutlo3by6SWqbpUD5IHkDr?=
 =?us-ascii?Q?E1l9cXQCublfVmq/HjcBK77vkKx6ds2z+In+Tp/x9fwEn1RZae1Jzo85qWZd?=
 =?us-ascii?Q?4RmPefnNSo+jghieMYTyoDpKb1Cr+dq+8iS6lkNCN/uJL3vdBn59xrShcQ8J?=
 =?us-ascii?Q?Sd5FzF8LEu9cnWhrjhJJVdPuAQpUcF65o3L+5DwFlZgt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd31f8-a737-484b-d1ec-08da5a5a0211
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 05:33:05.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITwketLE1LcwG+K04gsJrmQBUg4WleAIogxDrJdwOfecZG7pg4Pw7mUGhxPCzJ6xI2CJ9aF9qkExOvZPOsXJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:33:17PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:22 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DOE mailbox objects will be needed for various mailbox communications
> > with each memory device.
> > 
> > Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> > as found.
> > 
> > It is not anticipated that this is the final resting place for the
> > iteration of the DOE devices.  The support of switch ports will drive
> > this code into the PCIe side.  In this imagined architecture the CXL
> > port driver would then query into the PCI device for the DOE mailbox
> > array.
> > 
> > For now creating the mailboxes in the CXL port is good enough for the
> > endpoints.  Later PCIe ports will need to support this to support switch
> > ports more generically.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> My main comment on this is that we should not paper over any errors in
> DOE setup.  Those indicate a bug or hardware fault, so like anything similar
> we should at very least document why it makes sense to continue.  In most
> cases I'd argue it doesn't as something is very wrong.
> 
> > 
> > ---
> > Changes from V11:
> > 	Drop review from: Ben Widawsky <bwidawsk@kernel.org>
> > 	Remove irq code for now
> > 	Adjust for pci_doe_get_int_msg_num()
> > 	Adjust for pcim_doe_create_mb()
> > 		(No longer need to handle the destroy.)
> > 	Use xarray for DOE mailbox array
> > 
> > Changes from V9:
> > 	Bug fix: ensure DOE mailboxes are iterated before memdev add
> > 	Ben Widawsky
> > 		Set use_irq to false and just return on error.
> > 		Don't return a value from devm_cxl_pci_create_doe()
> > 		Skip allocating doe_mb array if there are no mailboxes
> > 		Skip requesting irqs if none found.
> > 	Ben/Jonathan Cameron
> > 		s/num_irqs/max_irqs
> > 
> > Changes from V8:
> > 	Move PCI_DOE selection to CXL_BUS to support future patches
> > 	which move queries into the port code.
> > 	Remove Auxiliary device arch
> > 	Squash the functionality of the auxiliary driver into this
> > 	patch.
> > 	Split out the irq handling a bit.
> > 
> > Changes from V7:
> > 	Minor code clean ups
> > 	Rebased on cxl-pending
> > 
> > Changes from V6:
> > 	Move all the auxiliary device stuff to the CXL layer
> > 
> > Changes from V5:
> > 	Split the CXL specific stuff off from the PCI DOE create
> > 	auxiliary device code.
> > ---
> >  drivers/cxl/Kconfig  |  1 +
> >  drivers/cxl/cxlmem.h |  3 +++
> >  drivers/cxl/pci.c    | 37 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index f64e3984689f..7adaaf80b302 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -2,6 +2,7 @@
> >  menuconfig CXL_BUS
> >  	tristate "CXL (Compute Express Link) Devices Support"
> >  	depends on PCI
> > +	select PCI_DOE
> >  	help
> >  	  CXL is a bus that is electrically compatible with PCI Express, but
> >  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 60d10ee1e7fc..360f282ef80c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -191,6 +191,7 @@ struct cxl_endpoint_dvsec_info {
> >   * @component_reg_phys: register base of component registers
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> > + * @doe_mbs: PCI DOE mailbox array
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -224,6 +225,8 @@ struct cxl_dev_state {
> >  	resource_size_t component_reg_phys;
> >  	u64 serial;
> >  
> > +	struct xarray doe_mbs;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 5a0ae46d4989..5821e6c1253b 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <linux/io.h>
> >  #include "cxlmem.h"
> >  #include "cxlpci.h"
> > @@ -386,6 +387,37 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	return rc;
> >  }
> >  
> > +static void cxl_pci_destroy_doe(void *mbs)
> > +{
> > +	struct xarray *xa = mbs;
> 
> Local variable doesn't add anything...
> 
> > +
> > +	xa_destroy(xa);
> > +}
> > +
> > +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	u16 off = 0;
> > +
> > +	pci_doe_for_each_off(pdev, off) {
> > +		struct pci_doe_mb *doe_mb;
> > +
> > +		doe_mb = pcim_doe_create_mb(pdev, off, -1);
> > +		if (IS_ERR(doe_mb)) {
> > +			pci_err(pdev,
> > +				"Failed to create MB object for MB @ %x\n",
> > +				off);
> 
> Definitely at least need a comment for why papering over this failure is
> fine.  My gut feeling is we shouldn't ignore it.

I'm so confused at this point I don't really know any more.  :-/

> 
> > +			doe_mb = NULL;

This at least needs to be a continue.

> > +		}
> > +
> > +		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL))
> > +			break;
> 
> If we hit that break something has gone horribly wrong and we shouldn't
> paper over it either.  We might have a partial list of DOEs and callers
> after this will have no way of knowing it isn't the full list.

I _thought_ that we did not care if some mailboxes failed or not.

If CDAT is not supported on any of the mailboxes found then CDAT will not show
up on sysfs (as per Dan's last comment).  If it was supported on a mailbox but
no data is found the sysfs will show up but be 0 length.

At this layer I thought we agreed to skip over these errors.  If a protocol is
needed at a higher layer and it is not found on any of the mailboxes the errors
should show up in that layer.  In this series CDAT is not 100% necessary as
devices can work without it.  So the errors were mostly paper'ed over in favor
of just printing error messages and muddle on.

The xa_insert() deserves a pci_err() though.

And I'll add a comment indicating finding mailboxes is 'best effort' and higher
layers may error out the device depending on necessity.  How about this?

        /* 
         * Mailbox creation is best effort.  Higher layers must determine if
         * the lack of a mailbox for their protocol is a device failure or not.
         */

> 
> > +
> > +		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
> > +	}
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -408,6 +440,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlds))
> >  		return PTR_ERR(cxlds);
> >  
> > +	xa_init(&cxlds->doe_mbs);
> > +	devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs);
> 
> _or_reset()?  If the devm registration itself fails we want to bail out cleanly.
> It's vanishingly unlikely to happen, but we should still handle that case.
> 

Actually no; xa_destroy does not need to be called at this point if we fail.
However, I do need to check the return of devm_add_action and fails if it is
not set.  Thanks again!

Ira

> > +
> >  	cxlds->serial = pci_get_dsn(pdev);
> >  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> >  		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> > @@ -434,6 +469,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> >  
> > +	devm_cxl_pci_create_doe(cxlds);
> > +
> >  	rc = cxl_pci_setup_mailbox(cxlds);
> >  	if (rc)
> >  		return rc;
> 

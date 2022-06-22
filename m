Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECE55519C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359558AbiFVQrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357872AbiFVQrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 12:47:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40DE40A38;
        Wed, 22 Jun 2022 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655916406; x=1687452406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0KmNyhtfgaXzQ79DCNgG8ieByTlNDejFoxd4drbOMpE=;
  b=e+FEbffWulFB+kzRMLTvsAaUgHd+656d9JEg8nOx9Nnm744Plb68G+FW
   Ze7egorrmv4bL8GSAfC30HUqsLxoFY1So36TtOsTeJfBSlKTkjRCquS0K
   prFqFVVvoWTdWY5cQBt7pRLCTOszdVa5SkVGeVOnXbqqKRz3mRdz67s+b
   nb02LEczuo/nHG3HyZ4FIfQVzxU0tq/O/Xkn7jPWZkj+rqq86PM8Z3a0J
   9phT+quB5GXrcg7dKGC2kXsS0tUUxVm2Othsnr5/Qa0WgJBWKnEwQL9WQ
   Bt3tQ0uDJSD3qmEClGXU3LNt23nXcHa8UKenhrBP8YSpKHdjJGDPgzGQy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260905924"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260905924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677642496"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 09:46:46 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 09:46:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 09:46:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 09:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX3WHD+8lfNnxegkS2malXOWgUJEV7p9ggjpC08LxzJOjyTENYn1sfhBCI7mYS3wXG5199TwitFxpTkqCRWnEy7UHY7eMsDT5Jxx7ha1LYW/Caj+YqUEbPYYI0LEpJqlJtir8oCmLWdc5kZnfkjo7hZInOm/ueiSy/hYQntCvmQZz7pddanXa/GZVmVcTi5DQteXRire2rYJSJHA4P4jgR4I6/d5xxsYbaCgEzZimKKVw9IAoWK4fJwSYsDodAZvYZxF3NwtZpCF7B4NdHD2XGsYdfA+CcQytywUi4xPFmoB/iCHKunrUdxuXLd3jfs1SIlikuKd7g4AdgHTCf+yoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U676qNd4RIsj3bpljhk9DFcCFeQQG7kwat4vsc7ltP4=;
 b=g06TMNJkTtPyz9dubGuZV3iPjsqEvWlX9gl/YpLgMMQZWSCPrNAqnEI3WhOQnVwbomW/kikVrCwvK0zboT0fgO2Hv/wWAtsR0AZTX0yiDKcK9F7oQ7m9wa75N/bkJVHUgq/I1DKJ2dsz03/EMe+x8mzg/PfHVfvgyihZXEFUaAAlMnz3TettCGSg2diMfTTfPdzIymtP9hTXjQ+l6Veub2X8weZxMVNoHmnuyTDM3UYF5GypMf/KIE+TMCQRPKfPKnI0dxSNRb2W3xTeK1Ja5Zs9p2VhiO2lOHVkghr9lmbL0dp2f/YKQeXW+8fPTNJeYlLjntccUe3auwTXkmj9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH0PR11MB5755.namprd11.prod.outlook.com (2603:10b6:610:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 16:46:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 16:46:42 +0000
Date:   Wed, 22 Jun 2022 09:46:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YrNHbhGKs9DDMnm2@iweiny-desk3>
References: <20220617224019.GA1208614@bhelgaas>
 <20220618163927.GA1235355@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220618163927.GA1235355@bhelgaas>
X-ClientProxiedBy: CO2PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:104:3::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03d6170-8255-46e1-efc8-08da546ec948
X-MS-TrafficTypeDiagnostic: CH0PR11MB5755:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB5755CAE7B336BC8C72B5FB06F7B29@CH0PR11MB5755.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oJNg8f//5GAO7rng0b25c/hLQN/f7t6ZJS1Gx3Go+o4uzFgi190Ufwse6+jbhDMEAnGpPvGcIbYoe0VziyQB2VIR38XswdfxQ/6U/psPVwmYCNlDFAqDXLtkK+UGVMJm9HGBlMp7icLyuHUzGNas9sKwYVgUUGQ+FGf6Nas1EizW23QBK/UJNH+YvNZ1rWAeaVTfDuI2+cA9e5NY+xt7N/2ziv7k3rWJ0x4ayCZCTi/NBu63gcKN1nCNrFvEMw4PvQYzOwcjhVo3OdJaho8BOMT1HaD7RFCa2M1xkE0UVJBkYAHGZWku0m9SWe507ik564KHiQ3UOAKyB5jFQSkz3EMTrniK2+OOkVB0Og/pYJFABGXBX1VbTvpLAOqcY0rrgNtlnz9+HW8qboa1km7sdXckNyFmvCCx6tKX8WeG6oAvHnwbMBtxR29lEednAYzyT3hSnR6fJaI5Jijm60u/AZRas6GUeAP3nMJDuWuih+tUj+nBE/zQUjJ++0bkghTd83CS+7Z9qNPzxtKqUPkKTwGK9D28PO4xS0b6SMdnDB49nRxjozU8zlyNeVV0MDeVePL4MYbp6V4LXx4CBre2LiY6yNZoDm0B3Q837x93DNWhaG414KVRzFYnx71pjmuwdjs+FpWsZPV12MZX7oiY2tapiK9966M04udg001AxjRADMeXHa7W689WM0P6yoblj/B0k6DKm23zC3JUKBnGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(8676002)(26005)(33716001)(6512007)(5660300002)(38100700002)(478600001)(86362001)(41300700001)(15650500001)(83380400001)(2906002)(82960400001)(9686003)(66556008)(44832011)(54906003)(6506007)(186003)(66946007)(66476007)(8936002)(4326008)(6486002)(316002)(6916009)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVy3GUyV351dRDiAehwPdSPXY/PI9aY0mQygJK79xKbrmMZThccOCU14TpcR?=
 =?us-ascii?Q?LF9RB51DNnn+o+uIvfGmY9/12IkZXIwJZGNp5j8Rv0Vs1U/18bMeQErjXESp?=
 =?us-ascii?Q?ADi7TkThLCSz7A3SVoI0HaTeF7lss+zH7QEF67cpLLnMZM2b6q1Bkh3NT5OU?=
 =?us-ascii?Q?t6NVYFneatJL1cC1xvRpg0z13AFahwLu+eHTrBtVBTUgey79l3ECUP/BF3Wm?=
 =?us-ascii?Q?2s0UJgsjzlUpIbPHlQ8taXItxqebxqr0lca/BIGh2PSIZhh0g9QjfdwXxclC?=
 =?us-ascii?Q?obDQWEXoSzb9R8VX29PsGIYfVKdFgPK/61ZrAH4CCDIQ4zATuVBvbd4BMazb?=
 =?us-ascii?Q?AoTI8K+oljECTW4P738Fvgykg2Ue0SNDC3aYgwcptry+Mx6+EBHVTomzzFN1?=
 =?us-ascii?Q?6XN7upj46+E+ujgGCSgoSXrGebecs6vsqE1FgkuI6UdcPRELqKDf9AWrphR0?=
 =?us-ascii?Q?sag4t+76SQxXj4WbH+NKnGcQBTT3Ktla/GGEr5U/cbQz3A1sOAqz8DQjYYMq?=
 =?us-ascii?Q?vMtUoprinxQMZImrkiL5cDvNQmrsD7Nvv6uuCU37IHyTLhAXZ7zJ64A6Ngxm?=
 =?us-ascii?Q?CvkQAXjE6ldicYO4LXoRqfJF224R9D+Q0WMMFkufmgBqXWByyPZIyHHzJspH?=
 =?us-ascii?Q?wPlxON9XTXyXos5n0PuIQ4WolPFimWJkorvNfrLgRtlDXFpbrF5c0KIML9Zx?=
 =?us-ascii?Q?K5B9vPZbyEYt/woBgFwU55vlXoMGiZ1FSRYAlQJWSA3K05BEcInbR/ee/YWF?=
 =?us-ascii?Q?KvK1nGCS/wdNAvL7YdtjRvXpql4/PRIYAsXG7oW2zEUxOOmoNwteRurABFuE?=
 =?us-ascii?Q?i60V4pt6V2c5Z5sGyhXJ+YRLEhdiwpbxJbcyJY+mA22n2DgQ8gfZOsTEyWxk?=
 =?us-ascii?Q?Ve4dsJE1yfFJ0fXEN5BCJAG8Pjve17PByf4iWOreQV0A8dn6RuBW7VLvn6yy?=
 =?us-ascii?Q?4mNhotcSYI6yfqC12Wz/uj9UnuMwNEZWZgi85Q4KcPJ7A8LSrl8ZjrOoFmaS?=
 =?us-ascii?Q?f0Mzhwo9J9B1vGJ1eEE2c3K8JbmYM8V7zeobLHeN1BHYeYqCPVZN3JCJVSh6?=
 =?us-ascii?Q?ex+sy5RvBLawH5+bdAwJRIZSFIwpE5iwBFbetuIA1UUyUeGkDA9u+UCHr8VO?=
 =?us-ascii?Q?FNHVLOu7UqZxd/JC7m01IsajFlxKTxreULINYqXKqk/YEI3N0rG6k4gvQTbt?=
 =?us-ascii?Q?ty07kMXZ3lK4PzsWPKXPm/PuSVuqVI7Uh3OWRlBEk9mDkh5kft/qAcexd4Zz?=
 =?us-ascii?Q?ErBcTTlWWgMnpBpBU/j4I+cD5HCkn5g4jzQWiVvjBXkrHXRqKJu4nMA0U+UG?=
 =?us-ascii?Q?Ml9JwaQnR9RPuX07H7cUSKP8LP8F/aLTMezfQY0+zkWdW5yjJYXxKj+G81Mu?=
 =?us-ascii?Q?PfTpFgqDCwiNkzdrIXa41xD2oEjhSf7hOKWMqoiM7tfOkctKKekhqIX8gOlR?=
 =?us-ascii?Q?o3prSLs3505vQDAiY+FDhp8565JWgNQ611XiLZ8IVUjM0yODw2yGIQKhlbZo?=
 =?us-ascii?Q?A9xY/8XwL1ke6BPehfxXc9sdmTzEvuqFiTJC9XY5Q/bX4Pjy3S95ynIVtXlP?=
 =?us-ascii?Q?g74Z8hPfWwiOFEbvhm7OHRX9WQqB/u9yhjcmoL32+hXLI8tkULF3OMmVpD+0?=
 =?us-ascii?Q?tqjbsk8N34m2CExNZ1UEgecsnS7m7Lb6khIroKT9OUTNFeEHcA80apHmyfxr?=
 =?us-ascii?Q?U3qc8bPoamvQgqnlvtDhTzyCNlnEE89khVXIc9pJ0lA3J3ASo6jkDTCLbVkm?=
 =?us-ascii?Q?fWVpKQ6nLd/jAFqlq4j0AYIDDioLWfA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c03d6170-8255-46e1-efc8-08da546ec948
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 16:46:42.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Azin8Cyp5e6oaNYNPHTz7HRCbYlkQbNybXd8TqArhEgZoNF2LrnAI2fZGPVYXJ0hdh+6FjsTilpD+TuNGleYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5755
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

On Sat, Jun 18, 2022 at 11:39:27AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 17, 2022 at 05:40:19PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 10, 2022 at 01:22:54PM -0700, ira.weiny@intel.com wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> > > mailbox with standard protocol discovery.  Each mailbox is accessed
> > > through a DOE Extended Capability.
> 
> > > + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> > > + *
> > > + * @pdev: The PCI device
> > > + * @offset: Offset of the DOE mailbox
> > > + *
> > > + * Returns: irq number on success
> > > + *	    -errno if irqs are not supported on this mailbox
> > > + */
> > > +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> > > +{
> > > +	u32 val;
> > > +
> > > +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > > +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);
> > 
> > Confusing function name (and comment) since PCI_DOE_CAP_IRQ is an
> > Interrupt Message Number that has nothing to do with Linux IRQ
> > numbers.
> > 
> > I see we already have PCI_EXP_FLAGS_IRQ, PCI_ERR_ROOT_AER_IRQ,
> > PCI_EXP_DPC_IRQ, so I guess you're in good company.
> 
> Should have been more clear about this: I think we should rename the
> new one to be PCI_DOE_CAP_INT_MSG_NUM or similar, and rename the
> function as well.  It's too confusing to use "irq" for both Linux IRQs
> and what the spec calls "Interupt Message Numbers".

Oh...  ok I was thinking of using int_msg_num in the function and variable
names.  I was just not sure about 'int'.  But if you like it then I do too!
:-D

I'll update the code as well as that macro.

Thanks again!
Ira

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2755515D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359315AbiFVQio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFVQio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 12:38:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A563584F;
        Wed, 22 Jun 2022 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655915920; x=1687451920;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uXlGwFrT4vQgECdH2jDTmtQaiPrjDucZYl92Uxy0EAs=;
  b=BMRB8iZws1szDMITe94sn2sVl97JnJ3uJ92FjNTSut6bNu3d1botjqmY
   TjQKr2Q4om7f/Ige+UaB2hVGptbCRxBqGkrXyj43jX4XqeeiCuh5a0rND
   rT3Nz1NtXxQkd/k3Kp+lEO+RnzS57mSYXuSZUIgnHeH4NEodvJYyAEZP1
   WJe4EhHCEvCVF/rPt6TlKbT3BkO7a3eNhGgBe3QS3pWtl83OgAR8Pc/a4
   DxtQhzxTRL5wXZuy4PkEEEXxfeh6+9AQkj4WzaZ8iBhC7xCVvbBVXqrPA
   pCeRUkggRHrZ6DuCbaP6DS+AYyjoQ8ZVdYZ8KZM9SHrYuUg5VCg+sBAqG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280516125"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280516125"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592270732"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2022 09:38:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 09:38:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 09:38:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 09:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqs98qP4Jt63+X8XP+Gs9XhsxAeMCqb2DMP0gnDlafe4T2moTeI18t+S99xZOMYl8MOgpEYssKMnszUKUMvXlhN4l6p9aOhs0sC1k4P/rO1kSeRgldfvN3xm5q2Pt6MTRaCeMuMFfuIZ9UXvdnmSaZQS4LXI9SEYOB3/sJXe6tzGyKN0yWcIz06GRobNbQVQvasxgPXC6014ULXtvq0NNPO6y5QfuotHSj0Q0IhFX17Z1AFuLq+cbTxO9vYI5KGrvIX2O5D2z2gPmTTNBLpklls7fYksaiVx/Qd/p/UwGSK8BEFyOvge6R5UqymMNnGQ0hZ5u4qAHqwR8YsIH+ewlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zUEVSuXYfEzbV/4TfwaAS9uB2oNb09mrfEPzHzayeQ=;
 b=oPJbdoBIcX7egh6ji0NgOKH1BoxItBuH0e44HqDVQQYna0W2GDGrE85fAp+EaiN0iTRlU2/I3i03LS4RIum8cVnzYqA+7MoMjYNtVkEg9NY03h5dW6oJNbzlTo3ekfqF3xV9KW4SMZ/HKdErfQ+Jyg2IdnOeEGkDv3bMJZ/2EugJO6orbDcyEKB3982fSs4pEneDgpK66eKyKKJSYriWKBVPpvcgZSitamn9AVae0xloOVfj952ZYPBw0GKDPef/x7lGxAiU01BDgiMjI5/Pbm8rJyQClAkSRnqX/suPuK8bjPdmD/0nki8Z2KFOlmQD4MPHP3IVp8COEtyiyeDCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BYAPR11MB3205.namprd11.prod.outlook.com (2603:10b6:a03:1e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.17; Wed, 22 Jun 2022 16:38:37 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 16:38:37 +0000
Date:   Wed, 22 Jun 2022 09:38:31 -0700
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
Message-ID: <YrNFh9CfwxmO+rsy@iweiny-desk3>
References: <20220610202259.3544623-4-ira.weiny@intel.com>
 <20220617224019.GA1208614@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617224019.GA1208614@bhelgaas>
X-ClientProxiedBy: MWHPR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:301:15::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c4b5d4b-aa08-4988-9a58-08da546da7cc
X-MS-TrafficTypeDiagnostic: BYAPR11MB3205:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB320502D8C7FD77DD54653083F7B29@BYAPR11MB3205.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5CgF7SoSHn8jdsbXmzswmznIFjjLWZMsYsGHeDaSHQxWa/4CYUUPoE1QyT8+MsA/GSccpfU8GBQqQ6Yek1EmB0TlzYv/kNFyI9eM9b3EeHcBYUzv0kYEV+gHmmwV76S6IWNxLRrGBVrbOn/9IM2X1x0lJCpq7TpeCX6i1k1DZWL7cHN/ROFlE3XJrgPzvzBBJlSkVb8lL9R301LhEcFZvlrlKiIyOpWIM8fpc3XDj7+cuSlxn2gSuw5cTW2/6y2FctGneuWjJD2zhw9lYoLCDVH5lNIQU3yeq9E9AHNNv5RlRPO3wdZtwXtR6hFBbzV9jCvzS8JgHfoKK3khBwHUtb+l+F/OVH4fEA8i2tg/miiD2S7CZ+Fo/52zK1cLPTxz6wuo/RaK/JgrdwHx095Iiex0faePfBIJhUskkZtgdYx73ZQ8cs25QJ3p8d+580/Sf44RTWr8jbdfrGIq15upYJMwb9YMMkz6KIlOA+H59VoMP7zDVGf2pF28d3pP1D71g9BQ9N6qcjffmTKjEzMoJS/1aGV0ODUGOXJZASsIiYi+a7DLLIIubQ8RQBygQFLCwbwDfvw4yQ+12Q1GQILihnQlNbRWTXAn4NLCTiXfOtMis7aTCjbPfykSuAgVjQh09jihdsp1+n8R8Ow7Zl7GYjicUql9DGVaH+CSx4n9och5EXT7dmP8bhiS+76n3lW3LDbNp45JcZupopZJW4wXXPcFH+XbICk3+lD7JneKwyTjzm1F6D3FC3QeCHhkGOp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(15650500001)(44832011)(5660300002)(26005)(478600001)(8936002)(2906002)(9686003)(6512007)(4326008)(6506007)(6916009)(6486002)(66946007)(186003)(54906003)(66556008)(8676002)(66476007)(316002)(41300700001)(6666004)(86362001)(82960400001)(83380400001)(33716001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3HRHB71Q87pMogP0F7VMMHQ27YDQSCH1/KooumO2/smCnH9RwYYeso5XqcF?=
 =?us-ascii?Q?D2BRh7OmeLJMmNvak1cUGSWjTTBR3tPkIsq4+ePtKV6Fq+WrCKOPF42/2NQn?=
 =?us-ascii?Q?XTcfg3KCoOuZ8WexRIA3IBtqWRDt6oWTLmyiqzzZgPvyRYNi5gahn+XKZ0UA?=
 =?us-ascii?Q?oWyGEn/qjPvNe+2Bh4xJoo6yXnoatoB7TD52wYb9uGtG1+KHuuuHmxmASSLg?=
 =?us-ascii?Q?7O+ZXcWIbGs307gv2vzxg+YaTyrAzRFRNWsdDw6KnhKXP3KeD5++j2ry2dm7?=
 =?us-ascii?Q?SdiEefEVaFP4BfLxbeNe3/9TP91tDIgjUKuBA+yOAokL/0wCMoGHrJjSGo96?=
 =?us-ascii?Q?z3n33ssKRfPoo+k2Oz7QKyZZA7DUKRNIcZg55RtdQfJufouRTGvX+61QtN6u?=
 =?us-ascii?Q?AkuGb642rqzturqALw3M232B8tiRzdcghjomWhLrV03SH/i/Xsw+u7k4xbJ4?=
 =?us-ascii?Q?eYMjsxMbh5Ty84OJTcBg7MzktjjAbSTkU9+Nhkxrzb8UBRqF0mwTIjYQYDWV?=
 =?us-ascii?Q?FK4uwYF9laFIpAuUN54cHzGSeogVbAZv64wokcCzdSDAGdv4rTJN9A0EnFpP?=
 =?us-ascii?Q?V6oz1HiNMrxaiNeXzDxFivCLrJYm3mFZ+wwmk1Uj79ACmzdHf5g6DDLn054Z?=
 =?us-ascii?Q?TVvON//0ot5pxfBkN3B0PKtXEpPn9wlVC7oXVlPlyaJaoi5SpYWFNDG7navf?=
 =?us-ascii?Q?DseUyC0SyPG96Dol5DnNPxeIuF/mZUVNusvFuPzzv8WwoRyUzncN5/aoJTJ5?=
 =?us-ascii?Q?yu2mSc9HnkCXy1wdpdhHNPrZMBtj3N7QLo4f+iNMBEjLp8B7rwn32aqHlDnb?=
 =?us-ascii?Q?rBO80osWchAD6a9C46R/OG17ZgmsjZFcxQzhPqOXtUH0qhF+gYsnwhoErkT3?=
 =?us-ascii?Q?4qkAaAeQGZHZ+H/QiM8W3O9L6RryTuQElX5fBV9cVKtOGCutXLl5CPrruN8h?=
 =?us-ascii?Q?2Fvv/p0PnrIloP4Ufl8vAwYV0YWOIyurfM0AQ+LtqEUky0ujz5tfXGnkpfMb?=
 =?us-ascii?Q?LoTfGmpf0RkjfShMlgCyiBVxfA0bA1jqFU5nlgQrTr6Sbeq5f1LMtQgoVn3S?=
 =?us-ascii?Q?tnEwgFAEAJogYWKbD/FpMpNXPoKHXUFbFgVYRTzZiL83zNHPUOfp+6j91dEF?=
 =?us-ascii?Q?izgmK8+zA61uUox2AusYYWhtThiaD4GH6n66qkQoNxXDSOAkOH5l38tcIO+u?=
 =?us-ascii?Q?UUcjqqNOcnMlulq9hFHyfb+sS8M4a3E/8RGJsdygGDr86h4mU8bPRa3xa0IB?=
 =?us-ascii?Q?0ipIe8DSdH96p30zKzHasVdnd/6AEEwRSyp2O9+5TBhiBLd0FzkBcMBpgbjt?=
 =?us-ascii?Q?0//b6zQreIYk02xAR1u+Z99O6rI1/Wu+YWUwpjHdlasFn6pLb0wr262y8Gpf?=
 =?us-ascii?Q?De0VyGjXiRRmHJTr2VuMutRoXg3X4QC0f++OhFoucbQWk7/reTPsOfMiS1Ao?=
 =?us-ascii?Q?hAXb+QzCDHzH05tT6CWyN8QGWxRDNetBFuVMC+/OsjYJCbPx1FD5nQPrbZE6?=
 =?us-ascii?Q?U7zL65ahLUtDYtL5dALg0tR1hbfkR9fCK+a6JLqQrZEchzFX8cWOUgmIM+fH?=
 =?us-ascii?Q?n5kooqQNzlOQHInZn+id4doFSH9csSzXYqO0nsznl4zGm7pVQEZHw39oD70O?=
 =?us-ascii?Q?2qWGbGyfG/OXoMENZY//5wdm7GJsP5kWwALOrbkuE4SriduT/VLF9ZLmV+gs?=
 =?us-ascii?Q?1cvyMBDJuCdYvEfzkcFgP1cvi1RE1XsrY05wTsOow1eBcu/mVfCcZVe4eRW8?=
 =?us-ascii?Q?GvkhRiejiw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4b5d4b-aa08-4988-9a58-08da546da7cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 16:38:37.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDx0MQ9KivVfIRBFFqFTcjfRSMKG1o0LL0fFm/maBhOvuxQIIs6/gtMXeh9Oa6t8y8F9TPbPnD0A9kEh/pJgkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 05:40:19PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2022 at 01:22:54PM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> 
> > +/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> 
> s/PCI/PCIe/ (up in commit log, too, I guess :))
> 
> Not that there will ever be a conventional PCI r6.0 spec, but there
> was a PCI r3.0 well as a PCIe r3.0, so might as well keep them
> straight.

Done.

> 
> > +struct pci_doe_mb {
> > +	struct pci_dev *pdev;
> 
> Trivial, but I would put cap_offset here next to pdev because the
> (pdev, cap_offset) tuple is basically the identifier for the DOE
> instance.

Done.

> 
> > +	struct completion abort_c;
> > +	int irq;
> > +	struct pci_doe_protocol *prots;
> > +	int num_prots;
> > +	u16 cap_offset;
> 
> > +static void pci_doe_abort_start(struct pci_doe_mb *doe_mb)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	u32 val;
> > +
> > +	val = PCI_DOE_CTRL_ABORT;
> > +	if (doe_mb->irq >= 0)
> 
> Is zero a valid IRQ?  In general, I don't think it is, but maybe this
> is a special case.  Or maybe this is actually the "Interrupt Message
> Number" mentioned in sec 6.30.3?  If so maybe something other than
> "irq" would be a better name here.

Yes I think irq is a bad name.  I think 0 is valid here because this is the
Interrupt Message Number" from the DOE Capabilities Register (7.9.24.2).

At least with Qemu 0 is returned for the 1st mailbox.  I'm not sure if that is
valid or not but I think it is.

But reading that in detail I think there is even more complexity than Jonathan
or I realized with regard to MSI vs MSI-X.

I'm going to leave the irq support in this layer (changing 'irq' to
'irq_msg_num'?)  but I think the callers will need to resolve what support they
enable.

> 
> Possibly relevant: a85a6c86c25b ("driver core: platform: Clarify that
> IRQ 0 is invalid")
> 
> > +		pci_err(pdev,
> > +			"DOE [%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> 
> Wouldn't make a big difference, but could consider something like this
> for enforced consistency:
> 
>   #define dev_fmt(fmt) "DOE: " fmt

Good idea.

> 
> > +	case DOE_WAIT_ABORT:
> > +	case DOE_WAIT_ABORT_ON_ERR:
> > +		prev_state = doe_mb->state;
> > +
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > +			doe_mb->state = DOE_IDLE;
> > +			/* Back to normal state - carry on */
> > +			retire_cur_task(doe_mb);
> > +		} else if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> > +			/* Task has timed out and is dead - abort */
> > +			pci_err(pdev, "DOE [%x] ABORT timed out\n",
> > +				doe_mb->cap_offset);
> > +			set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > +			retire_cur_task(doe_mb);
> > +		}
> > +
> > +		/*
> > +		 * For deliberately triggered abort, someone is
> > +		 * waiting.
> > +		 */
> > +		if (prev_state == DOE_WAIT_ABORT) {
> > +			if (task)
> > +				signal_task_complete(task, -EFAULT);
> > +			complete(&doe_mb->abort_c);
> > +		}
> > +
> > +		return;
> > +	}
> 
> The "return" in each case is perfectly correct, but it feels a little
> more conventional to make them "break" and return once here after the
> switch to make it clear that the only way to get to the labels is via
> an error path "goto".

Done.

> 
> > +err_abort:
> > +	doe_mb->state = DOE_WAIT_ABORT_ON_ERR;
> > +	pci_doe_abort_start(doe_mb);
> > +err_busy:
> > +	signal_task_complete(task, rc);
> > +	if (doe_mb->state == DOE_IDLE)
> > +		retire_cur_task(doe_mb);
> > +}
> 
> > +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> 
> s/MSIx/MSI-X/ (typical spelling in spec)
> 
> > +	 * this multiple times and thus is called here to ensure that mastering
> > +	 * is enabled even if the driver has done so.
> > +	 */
> > +	pci_set_master(pdev);
> > +	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
> > +			     "DOE[%d:%s]", irq, pci_name(pdev));
> 
> I assume the "DOE[%d:%s]" part appears in /proc/interrupts?

Yes

> Is it
> redundant to include "irq", since /proc/interrupts already prints it,
> or is there somewhere else where "irq" is useful?

As you pointed out irq is the wrong name here.  This is just the message
number.

> 
> How does the user associate this IRQ in /proc/interrupts with a
> specific DOE capability?  Should we include the cap_offset along with
> the pci_name()?

Good idea, cap_offset is much more useful.  In my testing the irq's were all
unique but as Dan pointed out I did not realize that the message number could
be shared.

> 
> > + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> > + *
> > + * @pdev: The PCI device
> > + * @offset: Offset of the DOE mailbox
> > + *
> > + * Returns: irq number on success
> > + *	    -errno if irqs are not supported on this mailbox
> 
> I normally capitalize IRQ/IRQs in comments.  There are probably others
> throughout the file.  I notice some are already capitalized but not all.

Done.

> 
> > + */
> > +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> > +{
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> > +		return -EOPNOTSUPP;
> > +
> > +	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);
> 
> Confusing function name (and comment) since PCI_DOE_CAP_IRQ is an
> Interrupt Message Number that has nothing to do with Linux IRQ
> numbers.

Agreed.  Changed to pci_doe_get_irq_msg_num();  With corresponding fixups to
the kdoc.

> 
> I see we already have PCI_EXP_FLAGS_IRQ, PCI_ERR_ROOT_AER_IRQ,
> PCI_EXP_DPC_IRQ, so I guess you're in good company.
> 
> At least maybe update the comment to say "Interrupt Message Number"
> instead of "irq".

Yea I did that too.

> 
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > + *			     protocol
> > + * @doe_mb: DOE mailbox capability to query
> > + * @vid: Protocol Vendor ID
> > + * @type: Protocol type
> > + *
> > + * RETURNS: True if the DOE mailbox supports the protocol specified
> 
> Is the typical use that the caller has a few specific protocols it
> cares about?

That is how CXL needs it right now yes.

> There's no case where a caller might want to enumerate
> them all?

Not at this time.

> I guess they're all in prots[], but that's supposed to be
> opaque to users.

Agreed.  Something else would be needed in that use case.

> 
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > +{
> > +	int i;
> > +
> > +	/* The discovery protocol must always be supported */
> > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > +		return true;
> > +
> > +	for (i = 0; i < doe_mb->num_prots; i++)
> > +		if ((doe_mb->prots[i].vid == vid) &&
> > +		    (doe_mb->prots[i].type == type))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> 
> > + * struct pci_doe_task - represents a single query/response
> > + *
> > + * @prot: DOE Protocol
> > + * @request_pl: The request payload
> > + * @request_pl_sz: Size of the request payload
> 
> Size is in dwords, not bytes, I guess?

No.  Those are in bytes and the DOE layer takes care of the DW conversion.
I'll update the kdoc to make that clear.

Thanks again for the review,
Ira

> 
> > + * @response_pl: The response payload
> > + * @response_pl_sz: Size of the response payload
> > + * @rv: Return value.  Length of received response or error
> > + * @complete: Called when task is complete
> > + * @private: Private data for the consumer
> > + */
> > +struct pci_doe_task {
> > +	struct pci_doe_protocol prot;
> > +	u32 *request_pl;
> > +	size_t request_pl_sz;
> > +	u32 *response_pl;
> > +	size_t response_pl_sz;
> > +	int rv;
> > +	void (*complete)(struct pci_doe_task *task);
> > +	void *private;
> > +};

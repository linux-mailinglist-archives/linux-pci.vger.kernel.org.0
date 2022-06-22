Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFA556ED5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376921AbiFVXG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356351AbiFVXGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 19:06:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B253F8A9;
        Wed, 22 Jun 2022 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655939183; x=1687475183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=elRyFWS3oykqFYoN4WyQTDdhWbgbEyuCmYeoOs8MJd4=;
  b=EBFQA8wnSy+IrpDXUJ9YcP9ZsvdLo1moJii2aB8nwgDAGN8Lx/1l6sJv
   jtDE6cx0D16m657SG5nhVm5VEKI6EWsTQOm65euyxmE88nFp91UhSrGg5
   hmAf35bLk0t9//uehfzp8yNH4GEcCn7O4ghxfV2KHq7yIgLI+mhoMEB/L
   CIxOhVM785oODLe3BEjFnlHcy9/zSPJY6pCdfa4AhKpbveGCfby2hiNvf
   nntwkJInmaMjVr0/uR9AvOVWn+GCN35magzx5Ma1nRduNruQ3TYFELybJ
   bhtt1xxgrs704f7jlRhfuMv7OeFamvzUSHe4oVoWqIQjNq6RS3JwJitmQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261002271"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="261002271"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834357414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 16:06:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:06:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 16:06:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 16:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1ckkpPeDGhhGc4V0+vXH4QmKBaVHm+TYO1hLT1cEx+iS9w/XUe2V28FqqZZk4k2ywisA4m59RdotEy/yzTaR3MMVLPEkQWRH8EW++laAvTmQ3FANjKKA/6GIvIEVidaiNCUIu34nvHGZKH/L/Z4QB/AXzyvNwTCSl/Rj/Nz/QhT0Ff5imcN7QBwX5guihxto8K/Db+P4PFqnSogriY1JcTQYlqsh+tBarmSW11y5Xuz3dunY3s2QcHU1TYzWyoL50KTkLcKZ6Zu7BfF8DanMaMRFsB8/8Rc92qAEXwR06BgGdbui4IAxgL1sdu0aCCf1ALTLtSlybpPlk45vG7ETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiY8m+99+YO4Oi2sgTDvxdyWT9rA/3USrbutcrLko0E=;
 b=Z4CdIWUde84w6DQYLYEQDxMCEDviAFhMBvuTTGvggIjn/nLVrxGavSYDAIB9adtF6HzdPyzfBDiofCvIAu50x27ZYgzs5aJKkt+3Vwy/kl8IvEIN8uQeEc5U5wRM3qs3jDRKtiz7ZRKoucKM8mWhv5kzB5LBIfcCwdYG3O5BHad5yuqcyzvFZxJe8SbNgRo7t1fg0xkwXUvQoMfgBEbnn/WWWDiw2hmEU1In4PgqVS9Foj6Cp2H7iPvrGUxHRPZ/eN3gozgQB8uB01fJwfxK7kI2jBdGxvfVtYVWRmdVO1Fm/PxWRcC73mCUm2XktqM7GVjBvVEr+KpyJSGKfCvWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Wed, 22 Jun 2022 23:06:21 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 23:06:20 +0000
Date:   Wed, 22 Jun 2022 16:06:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YrOgaBPFvBzGy5oe@iweiny-desk3>
References: <20220610202259.3544623-4-ira.weiny@intel.com>
 <20220617224019.GA1208614@bhelgaas>
 <20220620102449.000041d4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620102449.000041d4@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1a3547d-202d-43f8-9604-08da54a3d20b
X-MS-TrafficTypeDiagnostic: DS0PR11MB6542:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DS0PR11MB654208D75D813A20F46C1CF9F7B29@DS0PR11MB6542.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0s2xr3UKrxmCfEpaWbfhxAJa5BH7VZWsu7yga6KfHQHkX6HUcec8NEp6QN6jlkwuUV4pcOAILFI2Cdkaq+oW8QEMhqlhLjLFebp9NHcKrVY8I+/RTsoRwL+WZ77L3cnXz+eMEkvIgLfvEpJPbydHFQ8hDKfGdMDclXOsSTdNALYt7KxE+IrdB5cDx+4B27heJNp0GeCO+7FlcdMG7/Cfyme2dfqVDwMv9r3hfXPeoQV89Yq6j439tGI/ja/bRyO2MpcaRSNiKwze3Gekw/d5HmXK/k/XXzlq+OATqP532M/Kdrcdiqr57kBunPSfr+Ap6O4q7gDxlGKkbE8vIL5SceVUAg8wCchVM9yC05y7XRl9zC7QDHCbDcLyn4RwrHYg2KX9iy2PqgcIynTlYK6kYyJfk1gxpDDGJvjqkjfwzoyN8eNnZQ2dGzwbyPlFiKWGcC2uQAvm5SMvqEfifC5FtawF2dn57IVGrl4Mn9K5OuaOSV8DzmEyPD4B+XcIf/b6XVHHUyZar+5qWgK7IL3JElu8N6Ia59vF7Hc1JDdOLVH1jkJv2sasuiIa8gARmJoZa5phY8Not/w9rhhmOXZBJXOU2Y5p88cqoS+dRpfYK+rCZL6f/GHC5zFux+xhO9HRcUjzJ7pPKQwge61HnXkJctNyfo1TvMj7JynuVz7zi+ueR637Ec2L/EqAIa3Ly36q2IIwYImCuXE3tdx4yxLbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(6506007)(6486002)(66556008)(4326008)(26005)(33716001)(44832011)(186003)(8936002)(66946007)(316002)(6916009)(2906002)(66476007)(15650500001)(478600001)(9686003)(38100700002)(86362001)(82960400001)(5660300002)(41300700001)(6512007)(54906003)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QLBMwAduMdXoQk5wFwOvDXuCd2KLu2mCLVTmWRswx4kCJTt5Mduiqo39WR7?=
 =?us-ascii?Q?PUFhK8brwZIJiKN7YNN7PtxwZm9xN4XZT2C+9Bly2dvG/lI2J9IuO3083XWy?=
 =?us-ascii?Q?FrJUntgwiR/z5+z6epwYApHbcci3XNh7m+6DWLKElBKQl8LoGawbBGic6OjP?=
 =?us-ascii?Q?AhSd42k+sdfRgPCmuVBSqFxGBUF3Hx6FbfIe6S0DFElN0TykWBfnjDwzWuUv?=
 =?us-ascii?Q?Fv6wZ5BxQVCoDB+FvTu6+2R4bvzVIOzPiaUV6PwJvFx9mjoVkSz3Z8aEhyR0?=
 =?us-ascii?Q?XmBFPPiqvaZpw2BFMd7/365r43Eko8sKnBgp4TG2kt3alzx2lkmdExApuxBY?=
 =?us-ascii?Q?KuXb5s3Y1vPI8CGr8jq9QxwFCZBwh40OALmb6r4o8i1A52Hpir40mBrRGpsc?=
 =?us-ascii?Q?I8l6TshslTxOMf/mbH5lw62mlea8FuI300Juz0Ebs7IeYv4PYzk6vcjtVofy?=
 =?us-ascii?Q?LZ04IiyKY/VoX0PltwqAw79LwJxhW9PZg5AuXYNQztkKztuY+u2TRyrTr5VE?=
 =?us-ascii?Q?UYHpbjMD3k64sEClJmcZf4WXts287lRL8/1GOgxDml6XQs2VkpaEiclbQE04?=
 =?us-ascii?Q?G9k4RBroJ5b1EWn+ESJo8PZbZtEYyeM9Ew6mIIuR/ZGCihi1zN9PHdLxKf7A?=
 =?us-ascii?Q?r6vrqrsbUTYuNBnhaG3iNwJXQ5yjVXVu374DkQCysCycgQK4nGTmkDfJXpEe?=
 =?us-ascii?Q?6j2BG9EVVG5UrbFTttMoFIkEiitPune5ZWhMg3UnJOXVZ0kI1JvElA6hLIm4?=
 =?us-ascii?Q?8oGfclHoQEX2fnkz9b37dLNolcuDNsbv0yaZ5q+9hYKCJ+Kr849K0RdxGyOj?=
 =?us-ascii?Q?x1VqD6T8XCGLF5rfIJrWDb6xtSHlrRnGL5G/MZ9xyy/iD5+u2Jm7QLu7hl4A?=
 =?us-ascii?Q?JmHM9DO1+WONvvtr+swc6iuIuLYdtT3+thmIGAkQFur6+pxDty/wGKOVgOwT?=
 =?us-ascii?Q?Set3ePL1TbrbB8edcAqQ2PzApmmLmBpPcJmR118gqpW24zpGx/5FE84BGU8X?=
 =?us-ascii?Q?GvjcAcau7maccabHW9Lzrmg0AHo3VObg3Q+RCrtYs7eMeOYNuF2MbqOSFqZH?=
 =?us-ascii?Q?HhDlUOEtkJWf3s2YWvx6sWtqf5HkFvd7C0KhKAcoEB1bALsJ4gjE3PgBGAv4?=
 =?us-ascii?Q?kjMQi2+3RcDyR8dCWEucubKLXy1DOuDCDnXp/6EWVf21x9Onkvd2jnPbpjIb?=
 =?us-ascii?Q?gdWBOrazXAAlNQkzAsCmk691pagRTNp5dqNsw2PIm+DfhL1NRGbTIeTQZKPR?=
 =?us-ascii?Q?k+8SHrOV3nyxRuw6O08ub2VnQEob3APtBNNzJ3sgIl7d9PaBMDJ1DeV4QVKt?=
 =?us-ascii?Q?AbI00buH+EoHzepROZ5oKG/9SGynopXz/p5KqLr+kKPls/FQZ7WoRTBTRG8t?=
 =?us-ascii?Q?UOA1sGwM01/lacKybiW7h44Ogmy45IIy2omHOOqo+gqvLVVn69DIp/1oOyuM?=
 =?us-ascii?Q?aP/uTzJTH/+6pCp4/n2QR8ZzhinFIeLNhr/MtnDA6O4Psw0AHDS45X7ndFRt?=
 =?us-ascii?Q?w10h0waneKHzxM5qsU0QhaLTytocfxAbFrUMzQ1ccnOjyH28ckGRBNY8fTWQ?=
 =?us-ascii?Q?xEHpoVtD07Qal44AAPSi+4UvGeU7DzzKLMpk1SxZmEv8xCgtDjRA4F1FPyrl?=
 =?us-ascii?Q?/a/zXaeWYb402pmj4Nja2TzqNZd6oUHObB/DrT6ijlXKSE4B4dBHRHAnPvyV?=
 =?us-ascii?Q?OAUlIQljWiZLINfqE+uVakBwdweQTgUuLCjdTQ7DZf2BHSF82rIbPxrvvUFk?=
 =?us-ascii?Q?uXmVdXkN078HkLfLXV7JXPDi/oxS8FM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a3547d-202d-43f8-9604-08da54a3d20b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 23:06:20.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXZw594k/3T9W5ZClZGG+49mUJA7kpMmDoh7/WMCwnBdu1YTShLaeMKNkowqf/1GGlzBX+1d4TKvcvwa3Bu5FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
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

On Mon, Jun 20, 2022 at 10:24:49AM +0100, Jonathan Cameron wrote:
> 
> Hi Bjorn,
> 
> Thanks for reviewing!  Up to Ira of course, but I agree with all your
> comments

Me too!  :-D

> - a few responses to questions follow.
>
> 
> > 
> > > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > > + *			     protocol
> > > + * @doe_mb: DOE mailbox capability to query
> > > + * @vid: Protocol Vendor ID
> > > + * @type: Protocol type
> > > + *
> > > + * RETURNS: True if the DOE mailbox supports the protocol specified  
> > 
> > Is the typical use that the caller has a few specific protocols it
> > cares about?  There's no case where a caller might want to enumerate
> > them all?  I guess they're all in prots[], but that's supposed to be
> > opaque to users.
> 
> Given each protocol needs specific handling in the driver, the only
> usecase for a general enumeration would be debug I think.  Maybe
> it makes sense to provide that info to userspace somewhere, but
> definitely feels like something for a follow up discussion.

Yep, CXL just needs to find out which mailbox has CDAT on it.

> > 
> > > + */
> > > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > > +{
> > > +	int i;
> > > +
> > > +	/* The discovery protocol must always be supported */
> > > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > > +		return true;
> > > +
> > > +	for (i = 0; i < doe_mb->num_prots; i++)
> > > +		if ((doe_mb->prots[i].vid == vid) &&
> > > +		    (doe_mb->prots[i].type == type))
> > > +			return true;
> > > +
> > > +	return false;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);  
> > 
> > > + * struct pci_doe_task - represents a single query/response
> > > + *
> > > + * @prot: DOE Protocol
> > > + * @request_pl: The request payload
> > > + * @request_pl_sz: Size of the request payload  
> > 
> > Size is in dwords, not bytes, I guess?
> 
> It's in bytes (IIRC) - we divide it by. It's a bit of a mess,
> but there are parts of SPDM over CMA where messages are not
> full number of dwords. My thinking was that we 'might' move
> the padding into the generic code if this becomes something
> multiple protocols need.  For now the RFC does the
> padding at the CMA layer.

I think at this layer the DOE protocol specifies all message sizes are in
multiples of DW's.  So I think this layer should enforce that.  Other protocols
will need to pad if they need to based on their need.

> Let's avoid this being unclear in future by stating that it's
> in bytes in the comment.

Already done!

Thanks Jonathan!
Ira

> 
> Jonathan
> 
> > 
> > > + * @response_pl: The response payload
> > > + * @response_pl_sz: Size of the response payload
> > > + * @rv: Return value.  Length of received response or error
> > > + * @complete: Called when task is complete
> > > + * @private: Private data for the consumer
> > > + */
> > > +struct pci_doe_task {
> > > +	struct pci_doe_protocol prot;
> > > +	u32 *request_pl;
> > > +	size_t request_pl_sz;
> > > +	u32 *response_pl;
> > > +	size_t response_pl_sz;
> > > +	int rv;
> > > +	void (*complete)(struct pci_doe_task *task);
> > > +	void *private;
> > > +};  
> 

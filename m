Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6652A4A9189
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 01:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356192AbiBDATw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 19:19:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:27359 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245100AbiBDATw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 19:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643933992; x=1675469992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJBEnVf+uGC5k+2TsH/EsT1p612+ri1pGI1abHc9un0=;
  b=IpvhVe6Ob1a+SW6ujje5Ba+UEoMhoup2RXlob8WlGY8vZwVF+jT2iKC8
   B2ncOiqp7KFyAe8F/wQMly6JnxhhTQXp2YnVXjhV5hF1jJ1vHE83nO0al
   STYE0D40h708cs48T9oNWWqGrliB3Z8xr+1bn5zVfslSJwidqqnlQsynQ
   jGoiIXlkAKW2ibzFiE0ET75OFb0wEXhPT0tDvDAD1J2NbuSEu3CQZGQac
   6GUKmtHbUZUNi0FmALrB1o4lidIlN9zTvKRm3BWH0PZrFAZtMSNjfZx2Y
   hwHF8+TfhwH7LxsvlN5y7o1z0+2hZW3MskvqiHaipd7pSg8un7dEln9BW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309025370"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="309025370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:19:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="483444251"
Received: from jsclarke-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:19:51 -0800
Date:   Thu, 3 Feb 2022 16:19:50 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] cxl/region: Introduce concept of region
 configuration
Message-ID: <20220204001950.cxncxxxsmoyc6jcy@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com>
 <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220201231117.lksqoukbvss6e3ec@intel.com>
 <CAPcyv4iGQWXX8rzCH7BJUSyvDXbdiuHw4kLiuqGmVVBGTh2a1Q@mail.gmail.com>
 <20220203222300.gf4st36yoqjxq5q6@intel.com>
 <CAPcyv4icq8_9E+ziU5KKYrAepUtNP32Qf6wYGYpcUU2K1P4mAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4icq8_9E+ziU5KKYrAepUtNP32Qf6wYGYpcUU2K1P4mAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-03 15:27:02, Dan Williams wrote:
> On Thu, Feb 3, 2022 at 2:23 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-02-03 09:48:49, Dan Williams wrote:
> > > On Tue, Feb 1, 2022 at 3:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 22-01-28 16:25:34, Dan Williams wrote:
> > > > > On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > >
> > > > > > The region creation APIs create a vacant region. Configuring the region
> > > > > > works in the same way as similar subsystems such as devdax. Sysfs attrs
> > > > > > will be provided to allow userspace to configure the region.  Finally
> > > > > > once all configuration is complete, userspace may activate the region.
> > > > > >
> > > > > > Introduced here are the most basic attributes needed to configure a
> > > > > > region. Details of these attribute are described in the ABI
> > > > >
> > > > > s/attribute/attributes/
> > > > >
> > > > > > Documentation. Sanity checking of configuration parameters are done at
> > > > > > region binding time. This consolidates all such logic in one place,
> > > > > > rather than being strewn across multiple places.
> > > > >
> > > > > I think that's too late for some of the validation. The complex
> > > > > validation that the region driver does throughout the topology is
> > > > > different from the basic input validation that can  be done at the
> > > > > sysfs write time. For example ,this patch allows negative
> > > > > interleave_granularity values to specified, just return -EINVAL. I
> > > > > agree that sysfs should not validate everything, I disagree with
> > > > > pushing all validation to cxl_region_probe().
> > > > >
> > > >
> > > > Two points:c
> > > > 1. How do we distinguish "basic input validation". It'd be good if we could
> > > >    define "basic input validation". For instance, when I first wrote these
> > > >    patches, x3 would have been EINVAL, but today it's allowed. Can you help
> > > >    enumerate what you consider basic.
> > >
> > > I internalized this kernel design principle from Dave Miller many
> > > years ago paraphrasing "push decision making out to leaf code as much
> > > as possible", and centralizing all validation in cxl_region_probe()
> > > violates. The software that makes the mistake does not know it made a
> > > mistake until much later and "probe failed" is less descriptive than
> > > "EINVAL writing interleave_ways" . I wish I could find the thread
> > > because it also talked about his iteration process.
> >
> > It would definitely be interesting to understand why pushing decision making
> > into the leaf code is a violation. Was it primary around the descriptiveness of
> > the error?
> 
> You mean the other way round, why is it a violation to move decision
> making into the core? It was a comment about the inflexibility of the
> core logic vs leaf logic, in the case of CXL it's about the
> observability of errors at the right granularity which the core can
> not do because the core is disconnected from the transaction that
> injected the error.

I did mean the other way around. The thing that gets tricky if you do it at the
sysfs boundary is you do have to start seeing the interface as stateful. Perhaps
the complexity I see arising from this won't materialize, so I'll try it and
see. It seems like it can get messy quickly though.

> 
> > > Basic input validation to me is things like:
> > >
> > > - Don't allow writes while the region is active
> > > - Check that values are in bound. So yes, the interleave-ways value of
> > > 3 would fail until the kernel supports it, and granularity values >
> > > 16K would also fail.
> > > - Check that memdevs are actually downstream targets of the given decoder
> > > - Check that the region uuid is unique
> >
> > These are obviously easy and informative at attr store time (in fact, active was
> > meant to be checked already for many cases). So if we agree to codify this at
> > probe via WARN, and add it to kdoc, I've no problem with it.
> 
> Why is WARN needed? Either the sysfs validation does it job correctly
> or it doesn't. Also if sysfs didn't WARN when the bad input is
> specified why would the core do anything higher than dev_err()?
> Basically I think the bar for WARN is obvious kernel programming error
> where only a kernel-developer will see it vs EINVAL at runtime
> scenarios. I have seen Greg raise the bar for WARN in his reviews
> given how many deployments turn on 'panic_on_warn'.

Ultimately some checking will need to occur in one form or another in region
probe(). Either explicit via conditional: if (!is_valid(interleave_ways)) return
-EINVAL, or implicitly, for example 1 << (rootd_ig - cxlr_ig) is some invalid
nonsense which later fails host bridge programming verification. Before
discussing further, which are you suggesting?

> 
> > > - Check that decoder has capacity
> > > - Check that the memdev has capacity
> > > - Check that the decoder to map the DPA is actually available given
> > > decoders must be programmed in increasing DPA order
> > >
> > > Essentially any validation short of walking the topology to program
> > > upstream decoders since those errors are only resolved by racing
> > > region probes that try to grab upstream decoder resources.
> > >
> >
> > I intentionally avoided doing a lot of these until probe because it seemed like
> > not a great policy to deny regions from being populated if another region
> > utilizing those resources hasn't been bound yes. For a simple example, if x1
> > region A is created and utilizes all of memdev ɑ's capacity you block out any
> > other region setup using memdev ɑ, even if region A wasn't bound. There's a
> > similar problem with specifying decoders as part of configuration.
> >
> > I'll infer from your comment that you are fine with this tradeoff, or you have
> > some other way to manage this in mind.
> 
> It comes back to observability if threadA allocates all the DPA then
> yes all other threads should see -ENOSPC. No different than if 3 fdisk
> threads all tried to create a partition, the first one to the kernel
> wins. If threadA does not end up activating that regionA's capacity
> that's userspace's fault, and the admin needs to make sure that
> configuration does not race itself. The kernel allocating DPA
> immediately lets those races be found early such that threadB finds
> all the DPA gone and stops trying to create the region.

Okay. I don't have a strong opinion on how userspace should or shouldn't use
this interface. It seems less friendly to do it this way, but per the following
comment, if it's root only, it doesn't really matter.

I was under the impression you expected userspace to manage the DPA as well. I
don't really see any reason why the kernel should manage it if userspace is
already handling all these other bits. Let userspace set the offset and size
(can make a single device attr for it), and upon doing so it gets reserved.

> 
> > I really see any validation which requires removal of resources from the system
> > to be more fit for bind time. I suppose if the proposal is to move the region
> > attributes to be DEVICE_ATTR_ADMIN, that pushes the problem onto the system
> > administrator. It just seemed like most of the interface could be non-root.
> 
> None of the sysfs entries for CXL are writable by non-root.
> 
> DEVICE_ATTR_RW() is 0644
> DEVICE_ATTR_ADMIN_RW() is 0600

My mistake. I forgot about that.

> 
> Yes, pushing the problem onto the sysadmin is the only option. Only
> CAP_SYS_ADMIN can be trusted to muck with the physical address layout
> of the system. Even then CONFIG_LOCKDOWN_KERNEL wants to limit what
> CAP_SYS_ADMIN can to do the memory configuration, so I don't see any
> room for non-root to be considered in this ABI.

That's fine. As the interface is today (before your requested changes) only
region->probe() is something that mucks with the physical address layout. It
could theoretically be entirely configured (not bound) by userspace.

> 
> >
> > > >
> > > > 2. I like the idea that all validation takes place in one place. Obviously you
> > > >    do not. So, see #1 and I will rework.
> > >
> > > The validation helpers need to be written once, where they are called
> > > does not much matter, does it?
> > >
> >
> > Somewhat addressed above too...
> >
> > I think that depends on whether the full list is established as mentioned. If in
> > the region driver we can put several assertions that a variety of things don't
> > need [re]validation, then it doesn't matter. Without this, when trying to debug
> > or add code you need to figure out which place is doing the validation and which
> > place should do it.
> 
> All I can say it has not been a problem in practice for NVDIMM debug
> scenarios which does validation at probe for pre-existing namespaces
> and validation at sysfs write for namespace creation.
> 
> > At the very least I think the plan should be established in a kdoc.
> 
> Sure, a "CXL Region: Theory of Operation" would be a good document to
> lead into the patch series as a follow-on to "CXL Bus: Theory of
> Operation".

Yeah. I will write it once we close this discussion.


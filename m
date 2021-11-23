Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90E45A75E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 17:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhKWQT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 11:19:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:59371 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhKWQT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 11:19:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="298462060"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="298462060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:14:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="591243411"
Received: from kazushig-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.142.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:14:44 -0800
Date:   Tue, 23 Nov 2021 08:14:43 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211123161443.6gsl67mskttwpoyo@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-21-ben.widawsky@intel.com>
 <20211122174132.00001f80@Huawei.com>
 <20211122233820.nxb5daiakkbdqd7w@intel.com>
 <20211123113823.00007ce7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123113823.00007ce7@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-23 11:38:23, Jonathan Cameron wrote:
> On Mon, 22 Nov 2021 15:38:20 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> ...
> 
> > > > +static int enumerate_hdm_decoders(struct cxl_port *port,
> > > > +				  struct cxl_port_data *portdata)
> > > > +{
> > > > +	void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
> > > > +	bool global_enable;
> > > > +	u32 global_ctrl;
> > > > +	int i = 0;
> > > > +
> > > > +	global_ctrl = readl(hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > > > +	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
> > > > +	if (!global_enable) {
> > > > +		i = dvsec_range_used(port);
> > > > +		if (i) {
> > > > +			dev_err(&port->dev,
> > > > +				"Couldn't add port because device is using DVSEC range registers\n");
> > > > +			return -EBUSY;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < portdata->caps.count; i++) {
> > > > +		int rc, target_count = portdata->caps.tc;
> > > > +		struct cxl_decoder *cxld;
> > > > +		int *target_map = NULL;
> > > > +		u64 size;
> > > > +
> > > > +		if (is_endpoint_port(port))
> > > > +			target_count = 0;
> > > > +
> > > > +		cxld = cxl_decoder_alloc(port, target_count);
> > > > +		if (IS_ERR(cxld)) {
> > > > +			dev_warn(&port->dev,
> > > > +				 "Failed to allocate the decoder\n");
> > > > +			return PTR_ERR(cxld);
> > > > +		}
> > > > +
> > > > +		cxld->target_type = CXL_DECODER_EXPANDER;
> > > > +		cxld->interleave_ways = 1;
> > > > +		cxld->interleave_granularity = 0;
> > > > +
> > > > +		size = get_decoder_size(hdm_decoder, i);
> > > > +		if (size != 0) {
> > > > +#define decoderN(reg, n) hdm_decoder + CXL_HDM_DECODER0_##reg(n)  
> > > 
> > > Perhaps this block in the if (size != 0) would be more readable if broken out
> > > to a utility function?  
> > 
> > I don't get this comment, there is already get_decoder_size(). Can you please
> > elaborate?
> 
> Sure.  Just talking about having something like
> 
> 		if (size != 0)
> 			init_decoder() // or something better named
> 
> as an alternative to this deep nesting. 
> 

Sounds good. I can combine it with the similar initialization done in cxl_acpi.

> > 
> > > As normal I'm not keen on the macro magic if we can avoid it.
> > >   
> > 
> > Yeah - just trying to not have to deal with wrapping long lines.
> > 
> > >   
> > > > +			int temp[CXL_DECODER_MAX_INTERLEAVE];
> > > > +			u64 base;
> > > > +			u32 ctrl;
> > > > +			int j;
> > > > +			union {
> > > > +				u64 value;
> > > > +				char target_id[8];
> > > > +			} target_list;  
> > > 
> > > I thought we tried to avoid this union usage in kernel because of the whole
> > > thing about c compilers being able to do what they like with it...
> > >   
> > 
> > I wasn't aware of the restriction. I can change it back if it's required. It
> > does look a lot nicer this way. Is there a reference to this issue somewhere?
> 
> Hmm. Seems I was out of date on this.  There is a mess in the c99 standard that
> contradicts itself on whether you can do this or not.
> 
> https://davmac.wordpress.com/2010/02/26/c99-revisited/

Thanks for the link.

> 
> The pull request for a patch form Andy got a Linus response...
> 
> https://lore.kernel.org/all/CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com/
> 

That was a fun read :-)

I'll defer to Dan on this. This was actually his code that he suggested in
review of the RFC.

> 
> > 
> > > > +
> > > > +			target_map = temp;  
> > > 
> > > This is set to a variable that goes out of scope whilst target_map is still in
> > > use.
> > >   
> > 
> > Yikes. I'm pretty surprised the compiler didn't catch this.
> > 
> > > > +			ctrl = readl(decoderN(CTRL_OFFSET, i));
> > > > +			base = ioread64_hi_lo(decoderN(BASE_LOW_OFFSET, i));
> > > > +
> > > > +			cxld->decoder_range = (struct range){
> > > > +				.start = base,
> > > > +				.end = base + size - 1
> > > > +			};
> > > > +
> > > > +			cxld->flags = CXL_DECODER_F_ENABLE;
> > > > +			cxld->interleave_ways = to_interleave_ways(ctrl);
> > > > +			cxld->interleave_granularity =
> > > > +				to_interleave_granularity(ctrl);
> > > > +
> > > > +			if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
> > > > +				cxld->target_type = CXL_DECODER_ACCELERATOR;
> > > > +
> > > > +			target_list.value = ioread64_hi_lo(decoderN(TL_LOW, i));
> > > > +			for (j = 0; j < cxld->interleave_ways; j++)
> > > > +				target_map[j] = target_list.target_id[j];
> > > > +#undef decoderN
> > > > +		}
> > > > +
> > > > +		rc = cxl_decoder_add_locked(cxld, target_map);
> > > > +		if (rc)
> > > > +			put_device(&cxld->dev);
> > > > +		else
> > > > +			rc = cxl_decoder_autoremove(&port->dev, cxld);
> > > > +		if (rc)
> > > > +			dev_err(&port->dev, "Failed to add decoder\n");  
> > > 
> > > If that fails on the autoremove registration (unlikely) this message
> > > will be rather confusing - as the add was fine...
> > > 
> > > This nest of carrying on when we have an error is getting ever deeper...
> > >   
> > 
> > Yeah, this is not great. I will clean it up.
> > 
> > Thanks.
> > 
> > > > +		else
> > > > +			dev_dbg(&cxld->dev, "Added to port %s\n",
> > > > +				dev_name(&port->dev));
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Turn on global enable now since DVSEC ranges aren't being used and
> > > > +	 * we'll eventually want the decoder enabled.
> > > > +	 */
> > > > +	if (!global_enable) {
> > > > +		dev_dbg(&port->dev, "Enabling HDM decode\n");
> > > > +		writel(global_ctrl | CXL_HDM_DECODER_ENABLE, hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +  
> 

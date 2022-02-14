Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99964B591F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbiBNRwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 12:52:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbiBNRwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 12:52:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DBB3D;
        Mon, 14 Feb 2022 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644861118; x=1676397118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cR44Mw0r1As2uZD2TGw6A/9SkXX7vG7HVflW3VfE7FE=;
  b=VwQiGgKTeP/uIkqqzaLyU64u5XnxA/devsyrj9xFUOwJeDbc2fab5Sow
   y5kcLi06U0QBExlsk2wjeYC9NAj3++xJsDxP3azYK6A5ZAQ7c6pEG/YYZ
   rRzJlgyemA4CIkn+J6LB0RkTGV+ochgrIzUHh3IBIL9fqPwqs0qXxuwRU
   c7fdihpB1slwisoXyLVslgXC/FIR1WiybOTe2K6j2BoAkbcuBTr9fzDoE
   LVPiDaKkNDFJ3QhZEghnCJMixucDIIeyNdiA3Tk++yZc2dxyib9pfObgU
   r5i+UD4Y4l5fNUkUxq5w9lvkYOSBYyEFV9YjmiSeqTe0CbI9sbZZTNVtp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="310885024"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="310885024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:51:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="632264778"
Received: from mheninge-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.134])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:51:57 -0800
Date:   Mon, 14 Feb 2022 09:51:55 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 08/14] cxl/region: HB port config verification
Message-ID: <20220214175155.uufw4dd77ol4vtwf@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-9-ben.widawsky@intel.com>
 <20220214162037.0000104b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214162037.0000104b@Huawei.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-14 16:20:37, Jonathan Cameron wrote:
> On Thu, 27 Jan 2022 16:27:01 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Host bridge root port verification determines if the device ordering in
> > an interleave set can be programmed through the host bridges and
> > switches.
> > 
> > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > Software Guide, chapter 2.13.15. The current version of the guide does
> > not yet support x3 interleave configurations, and so that's not
> > supported here either.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> 
> > +static struct cxl_dport *get_rp(struct cxl_memdev *ep)
> > +{
> > +	struct cxl_port *port, *parent_port = port = ep->port;
> > +	struct cxl_dport *dport;
> > +
> > +	while (!is_cxl_root(port)) {
> > +		parent_port = to_cxl_port(port->dev.parent);
> > +		if (parent_port->depth == 1)
> > +			list_for_each_entry(dport, &parent_port->dports, list)
> > +				if (dport->dport == port->uport->parent->parent)
> > +					return dport;
> > +		port = parent_port;
> > +	}
> > +
> > +	BUG();
> 
> I know you mentioned you were reworking this patch set anyway, but
> I thought I'd give some quick debugging related feedback.
> 
> When running against a single switch in qemu (patches out once
> things are actually working), I hit this BUG()
> printing dev_name for the port->uport->parent->parent gives
> pci0000:0c but the matches are sort against
> 0000:0c:00.0 etc
> 
> So looks like one too many levels of parent in this case at least.

Hmm. This definitely looks dubious now that I see it again. Let me try to figure
out how to rework it. I think it would be good to ask Dan as well. Much of the
topology relationship works from bottom up, but top down is less easy.
Previously I had used pci-isms to do this but Dan has been working on keeping
the two domains isolated, which I agree is a good idea.

> 
> The other bug I haven't chased down yet is that if we happen
> to have downstream ports of the switch with duplicate ids
> (far too easy to do in QEMU as port_num is an optional
> parameter for switch DS ports) it's detected and the probe fails
> - but then it tries again and we get an infinite loop of new
> ports being created and failing to probe...

Is this allowed by spec? We shouldn't infinite loop, but I can't imagine the
driver could do anything saner than fail to probe for such a case.

> I'll get back this one once I have it working with
> a valid switch config.

Thanks.

> 
> Jonathan
> 
> > +	return NULL;
> > +}

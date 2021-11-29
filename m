Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF82462208
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 21:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhK2UVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 15:21:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:40524 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhK2UR1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="322303948"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="322303948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 12:12:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511850977"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 12:12:42 -0800
Date:   Mon, 29 Nov 2021 12:12:40 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/23] cxl: Introduce endpoint decoders
Message-ID: <20211129201240.dydsrxfcclnyx5i7@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-13-ben.widawsky@intel.com>
 <20211122162039.000022c1@Huawei.com>
 <20211122193751.gipqgs5ap24dacm3@intel.com>
 <CAPcyv4gBmc+C4d1RExH5qB2qunhkkMRqNZwzz29gc-1uaJiM4A@mail.gmail.com>
 <20211129200514.2o2zmjelfl3nahyt@intel.com>
 <CAPcyv4gONHAxas+=LfJnQSOf+3gZPr6i+mJLV6NO8ODFGoVfJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gONHAxas+=LfJnQSOf+3gZPr6i+mJLV6NO8ODFGoVfJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-29 12:07:00, Dan Williams wrote:
> On Mon, Nov 29, 2021 at 12:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-11-24 16:07:23, Dan Williams wrote:
> > > On Mon, Nov 22, 2021 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 21-11-22 16:20:39, Jonathan Cameron wrote:
> > > > > On Fri, 19 Nov 2021 16:02:39 -0800
> > > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > > Endpoints have decoders too. It is useful to share the same
> > > > > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > > > > targets), only the underlying physical medium. As a result, some special
> > > > > > casing is needed.
> > > > > >
> > > > > > There is no functional change introduced yet as endpoints don't actually
> > > > > > enumerate decoders yet.
> > > > > >
> > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > >
> > > > > I'm not a fan of special values like using 0 here to indicate endpoint
> > > > > device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
> > > > > and possibly wrappers for the non ep case and ep one.
> > > > >
> > > > > Jonathan
> > > > >
> > > >
> > > > My inclination is the opposite. However, I think you and Dan both brought up
> > > > something to this effect in the previous RFCs.
> > > >
> > > > Dan, do you have a preference here?
> > >
> > > I was thinking something along the lines of what Jonathan wants,
> > > explicit per-type APIs, but internal / private to the core can use
> > > heuristics like nr_targets == 0 == endpoint.
> > >
> > > So unexport cxl_decoder_alloc() and have separate:
> > >
> > > cxl_root_decoder_alloc()
> > > cxl_switch_decoder_alloc()
> > > cxl_endpoint_decoder_alloc()
> > >
> > > ...apis that use a static cxl_decoder_alloc() internally. Probably
> > > also wants a cxl_endpoint_decoder_add() that drops the need to pass a
> > > NULL @target_map.
> >
> > Would you a like a prep patch to set up the APIs first, or just do it all in
> > one?
> 
> Prep patch to switch over the current usages to the new style before
> introducing more helpers sounds good to me.

Thanks for the suggestions... Looking again, I think it makes sense to squash it
into the patch before this which documents and tightens up this exact API.

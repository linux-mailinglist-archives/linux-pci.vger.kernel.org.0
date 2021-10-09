Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC28427C7B
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhJISGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 14:06:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:62010 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhJISGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 14:06:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="287559672"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="287559672"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 11:04:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="489895338"
Received: from apendlex-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.129.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 11:04:10 -0700
Date:   Sat, 9 Oct 2021 11:04:09 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v3 02/10] cxl/pci: Remove dev_dbg for unknown register
 blocks
Message-ID: <20211009180409.rf7vqdly4loubthe@intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379784717.692348.3478221381958300790.stgit@dwillia2-desk3.amr.corp.intel.com>
 <0f625a108a2905c4f7d7ebb5b0db62b42f865338.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f625a108a2905c4f7d7ebb5b0db62b42f865338.camel@perches.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-10-09 09:48:10, Joe Perches wrote:
> On Sat, 2021-10-09 at 09:44 -0700, Dan Williams wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > While interesting to driver developers, the dev_dbg message doesn't do
> > much except clutter up logs.
> 
> So?  This isn't enabled by default.  How does it 'clutter' logs?
> 

Clutter logs for driver developers working on this subsystem. It's fine to drop
this and just use the next sentence as the explanation as well.

> > This information should be attainable
> > through sysfs, and someday lspci like utilities. This change
> > additionally helps reduce the LOC in a subsequent patch to refactor some
> > of cxl_pci register mapping.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pci.c |    3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 64180f46c895..ccc7c2573ddc 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -475,9 +475,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
> >  		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> >  					  &reg_type);
> >  
> > 
> > -		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
> > -			bar, offset, reg_type);
> > -
> >  		/* Ignore unknown register block types */
> >  		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
> >  			continue;
> > 
> 
> 

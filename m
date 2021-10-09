Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F84E427C34
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJIQ6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:58:38 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:43924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229624AbhJIQ6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Oct 2021 12:58:37 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Oct 2021 12:58:37 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 1C3C0806CED7;
        Sat,  9 Oct 2021 16:48:14 +0000 (UTC)
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5F1F332637;
        Sat,  9 Oct 2021 16:48:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 5976213D95;
        Sat,  9 Oct 2021 16:48:11 +0000 (UTC)
Message-ID: <0f625a108a2905c4f7d7ebb5b0db62b42f865338.camel@perches.com>
Subject: Re: [PATCH v3 02/10] cxl/pci: Remove dev_dbg for unknown register
 blocks
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Date:   Sat, 09 Oct 2021 09:48:10 -0700
In-Reply-To: <163379784717.692348.3478221381958300790.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
         <163379784717.692348.3478221381958300790.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.22
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5976213D95
X-Stat-Signature: a5tduneyhcpcb19yw7gotamc4ery6puk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19EJkk5YGlMmhTfgufSNgJ6p7Sugk4y9po=
X-HE-Tag: 1633798091-718472
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2021-10-09 at 09:44 -0700, Dan Williams wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> While interesting to driver developers, the dev_dbg message doesn't do
> much except clutter up logs.

So?  This isn't enabled by default.  How does it 'clutter' logs?

> This information should be attainable
> through sysfs, and someday lspci like utilities. This change
> additionally helps reduce the LOC in a subsequent patch to refactor some
> of cxl_pci register mapping.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 64180f46c895..ccc7c2573ddc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -475,9 +475,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>  		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
>  					  &reg_type);
>  
> 
> -		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
> -			bar, offset, reg_type);
> -
>  		/* Ignore unknown register block types */
>  		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
>  			continue;
> 



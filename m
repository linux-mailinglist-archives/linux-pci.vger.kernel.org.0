Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CFA4A534B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiAaXeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:34:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:23240 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbiAaXeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643672064; x=1675208064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBqo/QNzZkUmC1dVhH4eRazFolaU1vo+ekxaiEWD1Bo=;
  b=NgrmSIVFTLf8AWNcXyx68Lo6Yrx1WkdlENk8DpbGtA/O82XP/vLrnQpB
   So1jXw68jQqIZSUiv0xFG8NUTEDQFR2aABO22zvvqfYp1bHzrQ3IDq2hH
   fyf5LayP8/r9HWGPQ9cZt1A8jdPhqA7ePQWyeR/iOsjXXHdEfsWyJ6dFi
   pvy+/IBUt9gf96+FTOoBz0unMobeh0dbYHHHUv5Q06eZpHZTw7Km38T81
   fpBDiXHJPPmSdPhXxCpzjwwZbXnM173ny4NyZ8eP47PG1Dftvs8WuQos6
   eET98g71XJXEw1nFXvZ0EY+V5W66A4UqUTZMbFQX4jB0nrZgsRbC1fI5K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308307568"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="308307568"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:34:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="675898451"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:34:23 -0800
Date:   Mon, 31 Jan 2022 15:34:22 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
Message-ID: <20220131233422.xo6sugw4bvoyh6ia@intel.com>
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-25 18:54:36, Dan Williams wrote:
> Lockdep reports:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.16.0-rc1+ #142 Tainted: G           OE
>  ------------------------------------------------------
>  cxl/1220 is trying to acquire lock:
>  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> 
>  but task is already holding lock:
>  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> 
> ...where cxl_remove_ep() is a helper that wants to delete ports while
> holding a lock on the host device for that port. That sets up a lockdep
> violation whereby target_list_show() can not rely holding the decoder's
> device lock while walking the target_list. Switch to a dedicated seqlock
> for this purpose.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes in v4:
> - Fix missing unlock in error exit case (Ben)

Could you help me understand why we need a lock at all for the target list? I
thought the target list remains static throughout the lifetime of the decoder at
which point, the only issue would be reading the sysfs entries while the decoder
is being destroyed. Is that possible?

> 
>  drivers/cxl/core/port.c |   30 ++++++++++++++++++++++++------
>  drivers/cxl/cxl.h       |    2 ++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f58b2d502ac8..5188d47180f1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -104,14 +104,11 @@ static ssize_t target_type_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(target_type);
>  
> -static ssize_t target_list_show(struct device *dev,
> -			       struct device_attribute *attr, char *buf)
> +static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
>  {
> -	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  	ssize_t offset = 0;
>  	int i, rc = 0;
>  
> -	cxl_device_lock(dev);
>  	for (i = 0; i < cxld->interleave_ways; i++) {
>  		struct cxl_dport *dport = cxld->target[i];
>  		struct cxl_dport *next = NULL;
> @@ -127,10 +124,28 @@ static ssize_t target_list_show(struct device *dev,
>  			break;
>  		offset += rc;
>  	}
> -	cxl_device_unlock(dev);
>  
>  	if (rc < 0)
>  		return rc;
> +	return offset;
> +}
> +
> +static ssize_t target_list_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	ssize_t offset;
> +	unsigned int seq;
> +	int rc;
> +
> +	do {
> +		seq = read_seqbegin(&cxld->target_lock);
> +		rc = emit_target_list(cxld, buf);
> +	} while (read_seqretry(&cxld->target_lock, seq));
> +
> +	if (rc < 0)
> +		return rc;
> +	offset = rc;
>  
>  	rc = sysfs_emit_at(buf, offset, "\n");
>  	if (rc < 0)
> @@ -494,15 +509,17 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  		goto out_unlock;
>  	}
>  
> +	write_seqlock(&cxld->target_lock);
>  	for (i = 0; i < cxld->nr_targets; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
>  		if (!dport) {
>  			rc = -ENXIO;
> -			goto out_unlock;
> +			break;
>  		}
>  		cxld->target[i] = dport;
>  	}
> +	write_sequnlock(&cxld->target_lock);
>  
>  out_unlock:
>  	cxl_device_unlock(&port->dev);
> @@ -543,6 +560,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  
>  	cxld->id = rc;
>  	cxld->nr_targets = nr_targets;
> +	seqlock_init(&cxld->target_lock);
>  	dev = &cxld->dev;
>  	device_initialize(dev);
>  	device_set_pm_not_required(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 569cbe7f23d6..47c256ad105f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -185,6 +185,7 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> + * @target_lock: coordinate coherent reads of the target list
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -199,6 +200,7 @@ struct cxl_decoder {
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
>  	unsigned long flags;
> +	seqlock_t target_lock;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50E4A4B27
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiAaP7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 10:59:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4570 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiAaP7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 10:59:43 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnXmt3VfKz67Dqh;
        Mon, 31 Jan 2022 23:59:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 31 Jan 2022 16:59:41 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 15:59:40 +0000
Date:   Mon, 31 Jan 2022 15:59:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
Message-ID: <20220131155934.000064ac@Huawei.com>
In-Reply-To: <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jan 2022 18:54:36 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

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
Suggested additional tidy up inline.

Thanks,

Jonathan

> ---
> Changes in v4:
> - Fix missing unlock in error exit case (Ben)
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

Now you don't have a lock to unlock above, the only path that can
hit this if (rc < 0) is an if (rc < 0) in the for loop.
Perhaps just return directly there.

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


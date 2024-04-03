Return-Path: <linux-pci+bounces-5627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70C897434
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B742B2F4C2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD468149DFD;
	Wed,  3 Apr 2024 15:33:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595814A092;
	Wed,  3 Apr 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158384; cv=none; b=GVcd+hxHANpvNQxB1fJU32/BDaIjyM+g0ZjcCcyHZTIyH5fhPRtFDtjwDriCSK8zT2Fkp15mMIuhq8KGy1JK6VuWtEh55AAiIOZe8v7cwD3PurgkcyZaOnQsXcdp2Jr46WiFmeLVpGYGoc1A5nl/yjy2tJ35JUhov2hJxO9NvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158384; c=relaxed/simple;
	bh=Y9qSdSpzbdwnvl4yimQ5LkxXUJS/dIyokpWtEqQqIEk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnRJUfpu+vudEnE+OGi/5WNg5bhdqds6+Y96ec8sskX8BNSzedh2nJq9VF5BM7dAqHkhKFTdLa9PieyahFRarUHiqfyWtO79LAZdG9qKwRzMtoEg1BNtGxScEk4MtUgwYkfI5dIBLrH+pOIUvmhICik7erzyh/IHiL+25ifzf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8pdB130sz6G9Ns;
	Wed,  3 Apr 2024 23:31:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6AA01404F9;
	Wed,  3 Apr 2024 23:32:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 16:32:58 +0100
Date: Wed, 3 Apr 2024 16:32:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <20240403163257.000060e1@Huawei.com>
In-Reply-To: <20240402234848.3287160-5-dave.jiang@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-5-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Apr 2024 16:45:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if a decoder is marked as enabled in software but the
> decoder control register indicates it's not committed.
> 
> A helper function is added to find discrepancy between the decoder
> software state versus the hardware register state.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

As I said way back on v1, this smells hacky.

Why not pass the info on what reset was done down from the PCI core?
I see Bjorn commented it would be *possible* to do it in the PCI core
but raised other concerns that needed addressing first (I think you've
dealt with thosenow).  Doesn't look that hard to me (I've not coded it
up yet though).

The core code knows how far it got down the list reset_methods before
it succeeded in resetting.  So...

Modify __pci_reset_function_locked() to return the index of the reset
method that succeeded. Then pass that to pci_dev_restore().
Finally push it into a reset_done2() that takes that as an extra
parameter and the driver can see if it is FLR or SBR.
The extended reset_done is to avoid modifying lots of drivers.
However a quick grep suggests it's not that heavily used (15ish?)
so maybe just add the parameter.

There are a few other paths, but non look that problematic at
first glance...

So Bjorn, now the rest of this is hopefully close to what you'll be
happey with, which way do you prefer?



> ---
> v3:
> - Rename decocer_hw_mismatch() to __cxl_endpoint_decoder_reset_detected(). (Dan)
> - Move register accessing function to core/pci.c. (Dan)
> - Add kernel taint to decoder reset. (Dan)
> ---
>  drivers/cxl/core/pci.c | 31 +++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/pci.c      | 20 ++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c496a9710d62..597221f7f19b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1045,3 +1045,34 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
>  
>  	return cxl_flit_size(pdev) * MEGA / bw;
>  }
> +
> +static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = data;
> +	struct cxl_decoder *cxld;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 ctrl;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	cxld = &cxled->cxld;
> +	cxlhdm = dev_get_drvdata(&port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +}
> +
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
> +{
> +	return device_for_each_child(&port->dev, port,
> +				     __cxl_endpoint_decoder_reset_detected);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..e3c237c50b59 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -895,6 +895,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c1,
>  			     struct access_coordinate *c2);
>  
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 110478573296..5dc1f28a031d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -957,11 +957,31 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static void cxl_reset_done(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &pdev->dev;
> +
> +	/*
> +	 * FLR does not expect to touch the HDM decoders and related registers.
> +	 * SBR however will wipe all device configurations.
> +	 * Issue warning if there was active decoder before reset that no
> +	 * longer exists.
> +	 */
> +	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
> +		add_taint(TAINT_USER, LOCKDEP_NOW_UNRELIABLE);
> +	}
> +}
> +
>  static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
>  	.cor_error_detected	= cxl_cor_error_detected,
> +	.reset_done	= cxl_reset_done,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {



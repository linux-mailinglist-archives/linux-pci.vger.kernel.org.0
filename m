Return-Path: <linux-pci+bounces-5727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E58988CA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F7D1F2B131
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D17E86630;
	Thu,  4 Apr 2024 13:29:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764F126F11;
	Thu,  4 Apr 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237366; cv=none; b=ZDjmwmSdwYHKmwTZYNIUTX05gA8Kk89Z0FG483K3AOk0QTZrLZ6QLu+TX70++DCqKhJuIEk8THdtsY4w4WPAhh8BhbyT+abf1HahFiiSuCoPBTFp3CEBUNZt7w0O2XJuSqkGo1nDppIekjamkxaekk9Hmv5Q7XFjJxk3qJ4QgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237366; c=relaxed/simple;
	bh=JXUSbR3DZMUdA5qPCn8yNi7WcEgGX4f05m/gtXUyQxU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvVWPnNb+Btz7Tq8NOOTH26qlr4TtsjbugsdBcbKBJJGwkZ04AcH/wLUo4UeD+eknuL+dSsn0a7FylNzV1TFzKkVS3h24N9pE1dfVJV6j1eaqWJMgRmCqbTF2DtgWNIQaF3cz0EDM2p0zFhiOwLduHxg4t9uv2MVLMwr0RnG45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Mm76wPJz6J7Q4;
	Thu,  4 Apr 2024 21:24:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33C8F140B2F;
	Thu,  4 Apr 2024 21:29:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:29:10 +0100
Date: Thu, 4 Apr 2024 14:29:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 3/4] PCI: Create new reset method to force SBR for
 CXL
Message-ID: <20240404142909.00002084@Huawei.com>
In-Reply-To: <3d4a14a8-7720-4ecc-9099-1bb94b3e7013@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-4-dave.jiang@intel.com>
	<20240403160911.000016c0@Huawei.com>
	<3d4a14a8-7720-4ecc-9099-1bb94b3e7013@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >   
> >> +
> >> +	bridge = pci_upstream_bridge(dev);
> >> +	if (!bridge)
> >> +		return -ENOTTY;
> >> +
> >> +	dvsec = cxl_port_dvsec(bridge);
> >> +	if (!dvsec)
> >> +		return -ENOTTY;
> >> +
> >> +	if (probe)
> >> +		return 0;
> >> +
> >> +	pci_cfg_access_lock(bridge);
> >> +	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> >> +	if (rc) {
> >> +		rc = -ENOTTY;
> >> +		goto out;
> >> +	}
> >> +
> >> +	if (!(reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)) {
> >> +		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> >> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> >> +				      val);
> >> +	} else {
> >> +		val = reg;
> >> +	}
> >> +
> >> +	rc = pci_reset_bus_function(dev, probe);
> >> +
> >> +	if (reg != val)
> >> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, reg);
> >> +
> >> +out:
> >> +	pci_cfg_access_unlock(bridge);  
> > 
> > Maybe a guard() use case to allow early returns in error paths?  
> 
> I'm not seeing a good way to do it. pci_cfg_access_lock/unlock() isn't like your typical lock/unlock. It locks, changes some pci_dev internal stuff, and then unlocks in both functions. The pci_lock isn't being held after lock() call.
> 

You've lost me.

Why does guard() care about the internals?

All it does is stash a copy of the '_lock' - here the bridge struct pci_dev then call the _unlock
on it when the stashed copy of that pointer when it goes out of scope.

Those functions don't need to hold a conventional lock.  Though in this case
I believe the lock is effectively pci_dev->block_cfg_access.

FWIW we do the similar in IIO (with a conditional lock for extra fun :)
https://elixir.bootlin.com/linux/v6.9-rc2/source/include/linux/iio/iio.h#L650
That is setting a flag much like this one.  Don't look too closely at that though
as it evolved into a slightly odd form and needs a revisit.

This was a possible nice to have, not something I care that much about
in this patch set so feel free to not do it :)

Jonathan



> >   
> >> +	return rc;
> >> +}
> >> +
> >>  void pci_dev_lock(struct pci_dev *dev)
> >>  {
> >>  	/* block PM suspend, driver probe, etc. */
> >> @@ -5066,6 +5109,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> >>  	{ pci_af_flr, .name = "af_flr" },
> >>  	{ pci_pm_reset, .name = "pm" },
> >>  	{ pci_reset_bus_function, .name = "bus" },
> >> +	{ cxl_reset_bus_function, .name = "cxl_bus" },
> >>  };
> >>  
> >>  static ssize_t reset_method_show(struct device *dev,
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 16493426a04f..235f37715a43 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -51,7 +51,7 @@
> >>  			       PCI_STATUS_PARITY)
> >>  
> >>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> >> -#define PCI_NUM_RESET_METHODS 7
> >> +#define PCI_NUM_RESET_METHODS 8
> >>  
> >>  #define PCI_RESET_PROBE		true
> >>  #define PCI_RESET_DO_RESET	false  
> >   
> 



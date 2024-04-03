Return-Path: <linux-pci+bounces-5626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC189739E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA631F298F6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3F14BF9F;
	Wed,  3 Apr 2024 15:09:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAE14F12B;
	Wed,  3 Apr 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156960; cv=none; b=LLre4QCHmYGSco4FzoW+xKOA10ljBb4vhjtzRsMEGqsgP+32Mx2d5s3On+masvM/STrpkmHlgB7b2g70ocSkBczjZajCyLbLfdCoy5nc/bECtXcCA1NKdVRMEMFXk4HymBk2Kq2t52cMyxB6IRw1pf4VDyQdH9e3QzkYKc/N1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156960; c=relaxed/simple;
	bh=K/Bu3nMM+75KI6spo0DW9xO/zRADw+o9zkSLzBWlj+k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPyGjqLE8DEIE2k+d7iDvuFtToqVmbPa69ADT3W4obIkEsy45b1ft3lYQbOLTa0IR92BCc/a+59PVpbM8rQtEnj+30Wj3SbaKAFrfEYP7mbBqcjqSYFtye2KPgrhjfqR8X/YDeSE92yymg9QPtBZbknbabFZv5sOSCIv2PQlh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8p1v1Rf4z6D9r9;
	Wed,  3 Apr 2024 23:04:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1337F140516;
	Wed,  3 Apr 2024 23:09:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 16:09:12 +0100
Date: Wed, 3 Apr 2024 16:09:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 3/4] PCI: Create new reset method to force SBR for
 CXL
Message-ID: <20240403160911.000016c0@Huawei.com>
In-Reply-To: <20240402234848.3287160-4-dave.jiang@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-4-dave.jiang@intel.com>
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

On Tue, 2 Apr 2024 16:45:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec r3.1 8.1.5.2
> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
> new PCI reset method "cxl_bus" to force SBR on CXL ports by setting
> the unmask SBR bit in the CXL DVSEC port control register before performing
> the bus reset and restore the original value of the bit post reset. The
> new reset method allows the user to intentionally perform SBR on a CXL
> device without needing to set the "Unmask SBR" bit via a user tool.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few trivial things inline.  Otherwise looks fine.

FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v3:
> - move cxl_port_dvsec() to previous patch. (Dan)
> - add pci_cfg_access_lock() for the bridge. (Dan)
> - Change cxl_bus_force method to cxl_bus. (Dan)
> ---
>  drivers/pci/pci.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  2 +-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 00eddb451102..3989c8888813 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4982,6 +4982,49 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
>  
> +static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> +{
> +	struct pci_dev *bridge;
> +	int dvsec;

Lukas' comment on previous applies to this as well.

> +	int rc;
> +	u16 reg, val;

Maybe combine lines as appropriate.

> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (!bridge)
> +		return -ENOTTY;
> +
> +	dvsec = cxl_port_dvsec(bridge);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	pci_cfg_access_lock(bridge);
> +	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	if (rc) {
> +		rc = -ENOTTY;
> +		goto out;
> +	}
> +
> +	if (!(reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)) {
> +		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +				      val);
> +	} else {
> +		val = reg;
> +	}
> +
> +	rc = pci_reset_bus_function(dev, probe);
> +
> +	if (reg != val)
> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, reg);
> +
> +out:
> +	pci_cfg_access_unlock(bridge);

Maybe a guard() use case to allow early returns in error paths?

> +	return rc;
> +}
> +
>  void pci_dev_lock(struct pci_dev *dev)
>  {
>  	/* block PM suspend, driver probe, etc. */
> @@ -5066,6 +5109,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
> +	{ cxl_reset_bus_function, .name = "cxl_bus" },
>  };
>  
>  static ssize_t reset_method_show(struct device *dev,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..235f37715a43 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 7
> +#define PCI_NUM_RESET_METHODS 8
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false



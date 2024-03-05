Return-Path: <linux-pci+bounces-4539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B28729FC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 23:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8882D1C230DE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88212D1F3;
	Tue,  5 Mar 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1m5VrYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815B17BBF;
	Tue,  5 Mar 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676755; cv=none; b=ohY+rSn2bBWQpKVq/DIjZ6AodWw162u9HJ4fdMmrnlT691ngnIyQ9OdHcZaMx7+PJepoz7gOA7MJp5K+tJlFuE+fylNyZs0Met6dCAZjTI9zzF/H3vOKwj7TM0pmHBBU+uUxjREs55zhJ4ATbevpyDyZ2MARXcmfWXmUGR7Epps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676755; c=relaxed/simple;
	bh=V86iOJugE3FTlxMwknhidf2Vlg+oyA0yfcu8FM8Gnp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gVVS9wTUf18Lf1X2z3QdkbIppgm0tsSE0tjmQQV1Kphh9SUz3aWwpzO8mZIAEQ9lHU9Nq5K2HlcmDovql02e3yGCrrH78/PvbQjQ7LRcgmiu6MgB/jUMa7NrW9WLjn0m6xy0FeTUW5L4YMpwUYBJUCruofE4l0RRYol2OxiGIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1m5VrYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39DAC433F1;
	Tue,  5 Mar 2024 22:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709676755;
	bh=V86iOJugE3FTlxMwknhidf2Vlg+oyA0yfcu8FM8Gnp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f1m5VrYC4ZjpWkw/oNbiG8/4oV0qzFuGBv9NwH7pBLoVEGyjEHoE2mwMkyBwAMlQa
	 ucEZuBOCHOoMOTAsCzMLqcK4C5HIy8OwRfl45LK2yMCtPnvK8glNGl74F64GAyVp/F
	 FSj6y5z9u1exznmtGee734X1n3eBolxer5+hZQqfAea71qLAAlSl+In6MM7Bw2hd49
	 cmhpQnPd+nC6D0X0E7ivseq0uo4voQyvV1t0cH8LmrtYmhF7pvAxZPb34Gq60fsWMI
	 c/3TmQSjDUuiRndrGA6N5nWmrWrL23RT9tuC9qSX87v0cdmB3Aco9wPHpSD50XZDCW
	 lrp3qx5sKwjQQ==
Date: Tue, 5 Mar 2024 16:12:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/sysfs: Demacrofy pci_dev_resource_resize_attr(n)
 functions
Message-ID: <20240305221233.GA554011@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222114607.1837-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 22, 2024 at 01:46:06PM +0200, Ilpo Järvinen wrote:
> pci_dev_resource_resize_attr(n) macro is invoked for six resources,
> creating a large footprint function for each resource.
> 
> Rework the macro to only create a function that calls a helper function
> so the compiler can decide if it warrants to inline the function or
> not.
> 
> With x86_64 defconfig, this saves roughly 2.5kB:
> 
> $ scripts/bloat-o-meter drivers/pci/pci-sysfs.o{.old,.new}
> add/remove: 1/0 grow/shrink: 0/6 up/down: 512/-2934 (-2422)
> Function                                     old     new   delta
> __resource_resize_store                        -     512    +512
> resource5_resize_store                       503      14    -489
> resource4_resize_store                       503      14    -489
> resource3_resize_store                       503      14    -489
> resource2_resize_store                       503      14    -489
> resource1_resize_store                       503      14    -489
> resource0_resize_store                       500      11    -489
> Total: Before=13399, After=10977, chg -18.08%
> 
> (The compiler seemingly chose to still inline __resource_resize_show()
> which is fine, those functions are not very complex/large.)
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/sysfs for v6.9, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 138 +++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..613c5fc4f0a2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1410,79 +1410,89 @@ static const struct attribute_group pci_dev_reset_attr_group = {
>  	.is_visible = pci_dev_reset_attr_is_visible,
>  };
>  
> +static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
> +
> +	pci_config_pm_runtime_get(pdev);
> +
> +	ret = sysfs_emit(buf, "%016llx\n",
> +			 (u64)pci_rebar_get_possible_sizes(pdev, n));
> +
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
> +}
> +
> +static ssize_t __resource_resize_store(struct device *dev, int n,
> +				       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long size, flags;
> +	int ret, i;
> +	u16 cmd;
> +
> +	if (kstrtoul(buf, 0, &size) < 0)
> +		return -EINVAL;
> +
> +	device_lock(dev);
> +	if (dev->driver) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	pci_config_pm_runtime_get(pdev);
> +
> +	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
> +		ret = aperture_remove_conflicting_pci_devices(pdev,
> +						"resourceN_resize");
> +		if (ret)
> +			goto pm_put;
> +	}
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND,
> +			      cmd & ~PCI_COMMAND_MEMORY);
> +
> +	flags = pci_resource_flags(pdev, n);
> +
> +	pci_remove_resource_files(pdev);
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i) &&
> +		    pci_resource_flags(pdev, i) == flags)
> +			pci_release_resource(pdev, i);
> +	}
> +
> +	ret = pci_resize_resource(pdev, n, size);
> +
> +	pci_assign_unassigned_bus_resources(pdev->bus);
> +
> +	if (pci_create_resource_files(pdev))
> +		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
> +
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +pm_put:
> +	pci_config_pm_runtime_put(pdev);
> +unlock:
> +	device_unlock(dev);
> +
> +	return ret ? ret : count;
> +}
> +
>  #define pci_dev_resource_resize_attr(n)					\
>  static ssize_t resource##n##_resize_show(struct device *dev,		\
>  					 struct device_attribute *attr,	\
> -					 char * buf)			\
> +					 char *buf)			\
>  {									\
> -	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	ssize_t ret;							\
> -									\
> -	pci_config_pm_runtime_get(pdev);				\
> -									\
> -	ret = sysfs_emit(buf, "%016llx\n",				\
> -			 (u64)pci_rebar_get_possible_sizes(pdev, n));	\
> -									\
> -	pci_config_pm_runtime_put(pdev);				\
> -									\
> -	return ret;							\
> +	return __resource_resize_show(dev, n, buf);			\
>  }									\
> -									\
>  static ssize_t resource##n##_resize_store(struct device *dev,		\
>  					  struct device_attribute *attr,\
>  					  const char *buf, size_t count)\
>  {									\
> -	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	unsigned long size, flags;					\
> -	int ret, i;							\
> -	u16 cmd;							\
> -									\
> -	if (kstrtoul(buf, 0, &size) < 0)				\
> -		return -EINVAL;						\
> -									\
> -	device_lock(dev);						\
> -	if (dev->driver) {						\
> -		ret = -EBUSY;						\
> -		goto unlock;						\
> -	}								\
> -									\
> -	pci_config_pm_runtime_get(pdev);				\
> -									\
> -	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {		\
> -		ret = aperture_remove_conflicting_pci_devices(pdev,	\
> -						"resourceN_resize");	\
> -		if (ret)						\
> -			goto pm_put;					\
> -	}								\
> -									\
> -	pci_read_config_word(pdev, PCI_COMMAND, &cmd);			\
> -	pci_write_config_word(pdev, PCI_COMMAND,			\
> -			      cmd & ~PCI_COMMAND_MEMORY);		\
> -									\
> -	flags = pci_resource_flags(pdev, n);				\
> -									\
> -	pci_remove_resource_files(pdev);				\
> -									\
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
> -		if (pci_resource_len(pdev, i) &&			\
> -		    pci_resource_flags(pdev, i) == flags)		\
> -			pci_release_resource(pdev, i);			\
> -	}								\
> -									\
> -	ret = pci_resize_resource(pdev, n, size);			\
> -									\
> -	pci_assign_unassigned_bus_resources(pdev->bus);			\
> -									\
> -	if (pci_create_resource_files(pdev))				\
> -		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");\
> -									\
> -	pci_write_config_word(pdev, PCI_COMMAND, cmd);			\
> -pm_put:									\
> -	pci_config_pm_runtime_put(pdev);				\
> -unlock:									\
> -	device_unlock(dev);						\
> -									\
> -	return ret ? ret : count;					\
> +	return __resource_resize_store(dev, n, buf, count);		\
>  }									\
>  static DEVICE_ATTR_RW(resource##n##_resize)
>  
> -- 
> 2.39.2
> 


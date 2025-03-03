Return-Path: <linux-pci+bounces-22775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8CA4CAAD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09311170E68
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C60225A34;
	Mon,  3 Mar 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OovLkFaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B721B9EC;
	Mon,  3 Mar 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024964; cv=none; b=GM7D9NuIRazzXL7JgPmBs/7oWdLA1X9RV7RWNKIR4xEnqtyy3cGJkj/WiJKOsUjghBTQ1I82cTaf7mi6trUXTGJrZv/C1yPIZZYnK2t7TQAINLI4jQP4OoJuo0YJZZ+rcST/ynPUEpJKj5fJOSB/4na77l1Y7K+qgf/7+Jntjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024964; c=relaxed/simple;
	bh=b8cpnI0t1ZGE/4GhGe0WJPPFmne1LjgPLSwPpkjCOuU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/Qlit8YxHYOXt+byXYq2Q6IzevtN/Ww1W05tHkWrLZVnwryIJfedDFTQvmULe3VMa9cP6AlALv0XMa9EOAWzr7TWOHRDO3QJ/1rd1qqbkxiOUJkRLN1fDytRu7mDck3TZRKm066Jgy209X1rAv7sK6OEIncofgH/N3h4YABq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OovLkFaM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e897847086so35399936d6.3;
        Mon, 03 Mar 2025 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741024961; x=1741629761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uaH51U1EARjWt1wUptMoCo83LSnQN+HwOWnZIFYX+bw=;
        b=OovLkFaMr6EnwYXcSIiP2SH4+CnqgQ94k7zf5Az2wqyhF2504PhpzSPehs8HsGge4f
         iWiMRKCf/x+dt4KN7IXkjENqiPFG4BT3382PmbAWwC879/vCO1sihk0CwjSUxRKNNlgG
         xi8nly5rbRfXs/Je/W+vrIzkWpPzNSyzCAlCjXNqKfvpZ4r/LlC6tNK6eLz/crEzy4gH
         8hTUbJQ7q640Lt4X17eYs0y8ktWPxMDoKZyRjeLYukrBzDMaDjIDEWzMpGYfj6ltb5s5
         89jB/hQgJ8rArjLJMGYk34KW+OV0ayCcfo6AQ7n71q2QM8ey76J1GrOr460m/jKjBp2H
         ZZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741024961; x=1741629761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaH51U1EARjWt1wUptMoCo83LSnQN+HwOWnZIFYX+bw=;
        b=M0e0LN8EjnSWJk9nqJOOGXVf63Yrzu2D3iTj+SnqdDbdmJwCBYP1GLCly0R8IL8GOU
         pluTM+H0bsFhR23jjFZLTrBh/Vo88vus93+Mp/msXYDn3npLMTyxTsf7aYj9rvECuGuA
         ntYd3r0V4gV4pZgN9rAfZHzZjDa/G5/ZrIJ2aeRNRvl7/YXkipkIDAiY3WERDs7kyfNn
         ZAd64GGKuClyWGoCIBx05ZgC4XE4S3StutNEIDEcN0l36MTcfjpxvL0Yscv3gDNQJ/Te
         61qZbSuAS9wTsReTy/hybR9XrS0wMT0+ZF9F8yVpBVEKKYi6wbZxCWcityuM6tS7rh0z
         en4w==
X-Forwarded-Encrypted: i=1; AJvYcCUY2IL7I3elXvKC8C7NWZfPG8NOPrd+pR5I4JgTMTV0FpviBl3hPc1PDVDOhrB4UXwAAttuGZHHuG4MtPd5gwnnCg==@vger.kernel.org, AJvYcCVRUZyXpZzH+ZKrDKiRAqFesyj9QfEpGYEaO0GRiBkY6OkZ9ZipMecjgvroVMC4kwncyvq6YsSYKOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRseeT+XTjdmorcrHLN1pLs4D7GzIAkU5YPIf0PF6Dl0fTUjR
	AfewlG415V646qbI/L2kq9iknKWR6imS2aIqFM1X/xJIwjxaWoBB
X-Gm-Gg: ASbGncvdjAgJS3ZGKiZ9dP0cZBWlfOoNhYI4yKT9HX9SmiR7az5/tbgLlmEYMeE4ke0
	LzveC2DNmczRhf12zidEbg4aCVX5IITHHsuDCQyfzGBWSBrvppPzUQ9gK8srWz5qW+b5WkWAotr
	F9PiCX7Kq71VCp6jK+slmBZQ2amHRRWBLgrxeR0YXgP0+wL1JC/jtJyfu1vfWFCA+G4c6U9gcWE
	ex38gAVmWOtm8l8H/y4J4GC8Ajl8tebNahaodB/XimEbm42OXOZckMehhZyikYEFYv6G2Np/clU
	PpniDuqCWU5UM3aQAZfw5ge8hryNQZEvduql9wnS
X-Google-Smtp-Source: AGHT+IHjzkfcwb10GrGN3uoaAD93gQYyAxTYz59dkNKhr3SqimWrYHhjEzDaYdTtiZWAuzKMb2Txaw==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ac9:55ad with SMTP id 6a1803df08f44-6e8a0d94f85mr225579736d6.37.1741024960502;
        Mon, 03 Mar 2025 10:02:40 -0800 (PST)
Received: from debian ([2607:fb90:8e63:c2b3:5405:c8bf:c1d1:41d5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89763479csm55795596d6.2.2025.03.03.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:02:39 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 10:02:32 -0800
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <Z8XuuNb6TRevUlHH@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-6-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:48PM +0530, Shradha Todi wrote:
> Add support to provide statistical counter interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
One comment inline.
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  61 +++++
>  .../controller/dwc/pcie-designware-debugfs.c  | 229 +++++++++++++++++-
>  2 files changed, 289 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index 6ee0897fe753..650a89b0511e 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -81,3 +81,64 @@ Description:	rasdes_err_inj is the directory which can be used to inject errors
>  
>  			<count>
>  				Number of errors to be injected

...

> +
> +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t pos;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> +	mutex_unlock(&rinfo->reg_event_lock);
> +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> +}

Do we need to check whether the counter is enabled or not for the event
before retrieving the counter value?

Fan
> +
>  #define dwc_debugfs_create(name)			\
>  debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>  			&dbg_ ## name ## _fops)
> @@ -249,6 +436,23 @@ static const struct file_operations dwc_pcie_err_inj_ops = {
>  	.write = err_inj_write,
>  };
>  
> +static const struct file_operations dwc_pcie_counter_enable_ops = {
> +	.open = simple_open,
> +	.read = counter_enable_read,
> +	.write = counter_enable_write,
> +};
> +
> +static const struct file_operations dwc_pcie_counter_lane_ops = {
> +	.open = simple_open,
> +	.read = counter_lane_read,
> +	.write = counter_lane_write,
> +};
> +
> +static const struct file_operations dwc_pcie_counter_value_ops = {
> +	.open = simple_open,
> +	.read = counter_value_read,
> +};
> +
>  static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> @@ -258,7 +462,7 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  
>  static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  {
> -	struct dentry *rasdes_debug, *rasdes_err_inj;
> +	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
>  	struct dwc_pcie_rasdes_info *rasdes_info;
>  	struct dwc_pcie_rasdes_priv *priv_tmp;
>  	struct device *dev = pci->dev;
> @@ -277,6 +481,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  	/* Create subdirectories for Debug, Error injection, Statistics */
>  	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
>  	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> +	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
>  
>  	mutex_init(&rasdes_info->reg_event_lock);
>  	rasdes_info->ras_cap_offset = ras_cap;
> @@ -299,6 +504,28 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
>  				    &dwc_pcie_err_inj_ops);
>  	}
> +
> +	/* Create debugfs files for Statistical counter subdirectory */
> +	for (i = 0; i < ARRAY_SIZE(event_list); i++) {
> +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp) {
> +			ret = -ENOMEM;
> +			goto err_deinit;
> +		}
> +
> +		priv_tmp->idx = i;
> +		priv_tmp->pci = pci;
> +		rasdes_events = debugfs_create_dir(event_list[i].name, rasdes_event_counter);
> +		if (event_list[i].group_no == 0 || event_list[i].group_no == 4) {
> +			debugfs_create_file("lane_select", 0644, rasdes_events,
> +					    priv_tmp, &dwc_pcie_counter_lane_ops);
> +		}
> +		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
> +				    &dwc_pcie_counter_value_ops);
> +		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
> +				    &dwc_pcie_counter_enable_ops);
> +	}
> +
>  	return 0;
>  
>  err_deinit:
> -- 
> 2.17.1
> 


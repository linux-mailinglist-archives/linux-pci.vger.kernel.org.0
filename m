Return-Path: <linux-pci+bounces-10058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6B92D038
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6898BB26683
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33618FA32;
	Wed, 10 Jul 2024 11:05:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15B18FDC1
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609523; cv=none; b=bad5c19d+wYoQsagXvdzJTyqXyuthmbg0iQ9Uk9MquQnXKH976Bb/EpbEndipJJ8JmvBhQR6+F6UK4FV00YEJJRC6gOQHhONrvD+ZMbiYKno3xez2B0i0PDfjfX9dZp9lEbU+Lb5c6Z61PIAOKf/a5rgQX/Cfs2VMS/vLSKfydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609523; c=relaxed/simple;
	bh=lheWxZ6PhqyLTA7pNvJWA5swWF27yqO+gGVsEDllpEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt4ho7AEUEbz5oIxZOa9fSrzmhII/utpf76ol3pnL1TtTgS110mCHjt/yf3np1MebHEcqaCMwGMFMXjFYzm4HgLB16hsXhbXbNsc2F4hrlNDhwTTJsA+B+ddTznpcs7Lv7zr5b6an+tt53uR/GDZnACoFE4TvQslpLgSQQoFwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0ebd1ef9so3333183b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 04:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720609521; x=1721214321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW6VnXLh6yAGCOiu5ey/4pWQHcRx5mD1i6eDXjK9Svg=;
        b=p49b5DOckNZqIMQ+hcolSv9oyKnvF0Wh4dcZVDvw7xQ1+DRAj0xGi2Ge4zDUo7LnPn
         n5mac1D52PDVD5OdaYmXTohWazffC3sRkeG3cTsLbWqszlY2Kpj5Dhu4e6IFIlsIP+uO
         HUvr2XGZ5AaiLxIovP67dSVLvsMA1mPY8lfRNtrk9EmkQD8mjOXIpILbf2UkRtw8izbo
         Ogpyf349R3M/uVZyOZM1vWJEWMLnOu/7WvqQlP+R5vNL/NIRV0ScEgmfNpVnSpOtxaLR
         nnGN6do7penFtgSLX8aK7/J5i3Iunb2gUkWkMUdrkgWkdlLMzcalHb6gLJUNe7HWJ7Q2
         zY4Q==
X-Gm-Message-State: AOJu0YyYE1tC5P5Hw5RpjAp1R6jf/hcQJcOYvP9T0eU84prOWB4jNDIa
	tsRzPyJ80bQqkU8EgUSdPBDXyf3TRNUW3G/VpEtXF+Fz78kdMC8BMEHGIB4qDtbB3A==
X-Google-Smtp-Source: AGHT+IERAdRMHiU/rNoL2GkHhF1Fn5mQIO2RmZWzvQ6xwW5vMz6H7HG2GlPKyzO4XKVXMfh/rVK0TQ==
X-Received: by 2002:a05:6a00:23c2:b0:70b:20d9:3c2a with SMTP id d2e1a72fcca58-70b436630e6mr5715813b3a.28.1720609521461;
        Wed, 10 Jul 2024 04:05:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396739fsm3479085b3a.116.2024.07.10.04.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:05:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:05:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v1] Export PBEC Data register into sysfs
Message-ID: <20240710110519.GA3949574@rocinante>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>

Hello,

[...]
> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information 
> has traditionally been difficult. This is because the 'lspci' command, 
> which is a standard tool for displaying information about PCI devices, 
> cannot access PBEC information. `lspci` is a standard tool for displaying
> information about PCI devices.

Will you also be making changes to the pciutils project to expose this
using the lspci utility?

That said, we already expose "config" sysfs object, would using it work to
obtain the data you need?

> +static ssize_t pbec_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	size_t len = 0;
> +	int i, pos;
> +	u32 data;
> +
> +	if (!pci_is_pcie(pci_dev))
> +		return 0;

This is not needed, I believe the "is_visible" callback for this specific
attributes group checks for this already.

> +	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> +	if (!pos)
> +		return 0;

It would be -EINVAL, customarily.  I suppose, the -ENOTSUPP or -ENOSYS could
do too, but most of the other PCI sysfs objects returns -EINVAL back to the
userspace to indicate that something is wrong.

> +	for (i = 0; i < 0xff; i++) {

Does this 0xff need to be documented?  Something specific to the PBEC feature?

> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
> +		if (!data)
> +			break;

We should return an error here, something like -EINVAL perhaps.

> +		len += sysfs_emit_at(buf, len, "%04x\n", data);
> +	}
> +
> +	return len;

How frequently do you think this new sysfs object would be accessed?  It's
not uncommon for the PCI configuration space access to be slow for some
devices.

Thank you!

	Krzysztof


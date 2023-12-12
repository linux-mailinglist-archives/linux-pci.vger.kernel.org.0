Return-Path: <linux-pci+bounces-788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44980E583
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24A51C20981
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908718031;
	Tue, 12 Dec 2023 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FtT1NeLI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A4136
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 00:08:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2a444311so52323975e9.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 00:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702368538; x=1702973338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ9ea9ok6ZP/daUsmJ5Nh5VRT1Vhh0QOAkcU3YgmvrE=;
        b=FtT1NeLIlgYig+jqCcb4c0GjeuBJQU0XdUUsgHK7SGUmoY/fzr6Y/qUfPhLbn/lJY9
         3eEWFlS4EmyNMBpm2zGPal1sX0b5LVDFTwjzEEATxYCucL9vW4lH54I/FL4WJJV9423C
         +HHlBgSM18/lJZ0XKsV07jUcKMUdIESxVfdQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702368538; x=1702973338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ9ea9ok6ZP/daUsmJ5Nh5VRT1Vhh0QOAkcU3YgmvrE=;
        b=h9lm8ccjaDL56NM87sKllEVRURp0fxEhEB8Ybv6LBStnqHV+BgtSXIWE5qnrF1xKyu
         fIz0qn9Ysl8oDw4yRZ2xQoYZmcQ7sVL5qdcgFS3eCsW6zVG8VGa3IfTnmoVuZZVOvxNs
         gJJZM399Y5ry7heP4eZ7jCDXKaodvWmhXPGWXdfNYj3ACSi2fRYlT3vNOelhiDlwzThB
         I4wMDHmnq+rD9ffw2gnezfq3vrKK+F20YMr479V6rRjJDALBEf+/42vX+jB/IBTemvCV
         X/Q2UoyTrzsaQVMFHMO3W9tmpgUrhtQOnKHgNNWXoylYjOaPotgblH65IqoGtvYs2Vd+
         6xcQ==
X-Gm-Message-State: AOJu0Ywo5dcPzvk6UmzLZTBUZkJBF+wK1inIlEoRLEYTufRWgMQi5jTJ
	pTh4RB6vwSy2LdJuuyg9Sq6Seg==
X-Google-Smtp-Source: AGHT+IFiLEbU7MXeHb/3JUtaP7dLoEfB9T02V0TbySRKV6sYpsT8WjQ7hIYcImSy3eOwCQDp6dIJng==
X-Received: by 2002:a05:600c:28e:b0:40c:53d4:391 with SMTP id 14-20020a05600c028e00b0040c53d40391mr34795wmk.24.1702368538240;
        Tue, 12 Dec 2023 00:08:58 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b004094e565e71sm15611143wmr.23.2023.12.12.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:08:58 -0800 (PST)
Date: Tue, 12 Dec 2023 09:08:57 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
	Alex Deucher <Alexander.Deucher@amd.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
	Honglei Huang <Honglei1.Huang@amd.com>,
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 1/3] xen/pci: Add xen_reset_device_state
 function
Message-ID: <ZXgVGWLZEnLt0Pqn@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-2-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210161519.1550860-2-Jiqian.Chen@amd.com>

On Mon, Dec 11, 2023 at 12:15:17AM +0800, Jiqian Chen wrote:
> When device on dom0 side has been reset, the vpci on Xen side
> won't get notification, so that the cached state in vpci is
> all out of date with the real device state.
> To solve that problem, add a new function to clear all vpci
> device state when device is reset on dom0 side.
> 
> And call that function in pcistub_init_device. Because when
> using "pci-assignable-add" to assign a passthrough device in
> Xen, it will reset passthrough device and the vpci state will
> out of date, and then device will fail to restore bar state.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/xen/pci.c                  | 12 ++++++++++++
>  drivers/xen/xen-pciback/pci_stub.c |  4 ++++
>  include/xen/interface/physdev.h    |  8 ++++++++
>  include/xen/pci.h                  |  6 ++++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 72d4e3f193af..e9b30bc09139 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
>  	return r;
>  }
>  
> +int xen_reset_device_state(const struct pci_dev *dev)
> +{
> +	struct physdev_pci_device device = {
> +		.seg = pci_domain_nr(dev->bus),
> +		.bus = dev->bus->number,
> +		.devfn = dev->devfn
> +	};
> +
> +	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
> +}
> +EXPORT_SYMBOL_GPL(xen_reset_device_state);
> +
>  static int xen_pci_notifier(struct notifier_block *nb,
>  			    unsigned long action, void *data)
>  {
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index e34b623e4b41..24f599eaec14 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -421,6 +421,10 @@ static int pcistub_init_device(struct pci_dev *dev)
>  	else {
>  		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
>  		__pci_reset_function_locked(dev);
> +		if (!xen_pv_domain())
> +			err = xen_reset_device_state(dev);
> +		if (err)
> +			goto config_release;

I think you are missing other instances where
__pci_reset_function_locked() is called in pci_stub.c?  See
pcistub_device_release() and pcistub_put_pci_dev().

Overall I'm not sure why the hypercall wrapper needs to live in
xen/pci.c.  I think it would be better if you could create a static
wrapper in pci_stub.c that does the call to
__pci_reset_function_locked() plus PHYSDEVOP_pci_device_state_reset.
That would make it less likely that new callers of
__pci_reset_function_locked() are introduced without noticing the need
to also call PHYSDEVOP_pci_device_state_reset.

Thanks, Roger.


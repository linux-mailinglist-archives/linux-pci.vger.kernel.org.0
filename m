Return-Path: <linux-pci+bounces-22761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADCA4C325
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 15:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F378F16B655
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090F2AE69;
	Mon,  3 Mar 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KtfmI3zq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A578F40
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011407; cv=none; b=ElPm4oxp7fOPx8GQoYw9kIcVXuLpt2STHQ0nZuJE0gycpcD/3jrck2jc3+ean9vWHH5nW1JS7wpb9m6s6dDPJNee8Q/EhXrH8V7eUiZf+0uF9ZkKcMP4FNoP2Ktx57kjaIfKE1LZ+HpqBZf6BU/6hPwayzwU5RZ2DtBkI2bp1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011407; c=relaxed/simple;
	bh=FP1QKBFPUcrMI2AawgU0YCWUvxa2VeGB+6LbEEtYqOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1IZGUs6Ioxd7xNpTDXfTWULoDSAjZ0wXbSikzqty+35SrbFkP1p2xs2rrkFlhHh1nDleNLNe3J/7oNFDLNZTO2KzZ8UHxAmWZCjIzXt2aEycCQi+357aDNTdMww811g3kNePd2Gn3rTb4xhQiGYNPD4MDdNEeA6n6Ne+Ka/kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=KtfmI3zq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2235c5818a3so46090375ad.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 06:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741011405; x=1741616205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHyQ1S6OcoiWu2NIhoviRiSzrc0wSkcr90Nm+vU00/w=;
        b=KtfmI3zqTNLJ3v/qawt1jcLBBHfz2zziJzXUR7IwLKbNQF2TBGZ4WWXGJuGnnV3YOO
         VpO9XWiZjTaYp3pQJPyJaeYTOrKMMWeX7NtmiiP6e01GnZH98EHNPA8USZSfN/RF3EVc
         D63TQv2m+fHtG2IbrvZxzd+RTKf/KVXqlT1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011405; x=1741616205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHyQ1S6OcoiWu2NIhoviRiSzrc0wSkcr90Nm+vU00/w=;
        b=FfmxCQbCfMddFpNcZdSRqXADvHOwhVT8A9uTrg6C8vxG+FqQTUqKzEaOGL1fX4CwzB
         Kn4aIWSItgKARTNkn5P5Ts/hSjGdFfQGUN98KDfOdS1NnzFUIZgPi/U3UPiSOv+O+uZU
         uSiYsKGncWPjOj4PyyU/ChhmGGUVBIE4O7pK5tETT5qKUV5rrfC7cKQUkcfx4FSCxYMF
         Oxr+rBVJ+DHml6CmyUFhuMlVrYyzHh0MjfIj8odOAsigbiQYHSA3RtYhX+vRNrPwKKYg
         BjUx236u5FrfOQapquEyTX7sDlQiiGk/+ri8IzSDz+UOLZMxpLtcHUCtOdx3OiGP/a6A
         P6rA==
X-Forwarded-Encrypted: i=1; AJvYcCUBlTaMXPAghhKZRHYoPWbvyd7oNNgQiq699wQZZx58aIoatupo888c/17T0rfyFDx6x/eyvs7rx/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW19+7hr9KMLJqETRNJG+GZ+ttBYaECbq5wjF9MHXvYuHBZLwL
	MHVQy4O4hnPMKJr7LoRrPCWDgUST3a6tii1d5yTE39UZ4dfx51MPJYJSXJl5LQU=
X-Gm-Gg: ASbGnctRj4+JEA/RuRp+5ULYnbswZmGuKNwt+r5XIO0MHU0MXpAB/2l4SnT7WSQROoh
	LHmsIV/XD3QtOxQAfDD5hAs5AygjBq3GB+efiiUL0YsNDTYzFrJT6bEUIMvsJ1RHQ8h5UcA63Qw
	fcK07UuL7QimKB2vxkYud4Ot1EPzWNDIn/BgUbs6JgMg6m/PF3dwrRU2zQXZsK0F8rqNb+asr8v
	XEZc5zZ+ECHfHZb744Br0pLrBeOUhFw/wqbb5g5pvo6GgoPq927gvMN/RkYvCKDlNpKq3QWqprC
	tgC9PzYq4YLQXZn/76LJuBsg24qB4xtrRR7Q+h/RMb2fFC16kg==
X-Google-Smtp-Source: AGHT+IGoLI4X4aCiq6Qh2tqDp2VFm/jy5ZG2qcvCISc/6H3iGzMjb0RkAikmZjUbfxoQpMD0LN0TIw==
X-Received: by 2002:a05:6a00:ccc:b0:736:48d1:57f7 with SMTP id d2e1a72fcca58-73648d159c8mr7714064b3a.7.1741011405046;
        Mon, 03 Mar 2025 06:16:45 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7364ef011c1sm2591656b3a.111.2025.03.03.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:16:44 -0800 (PST)
Date: Mon, 3 Mar 2025 15:16:39 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/3] PCI: vmd: Disable MSI remapping bypass under Xen
Message-ID: <Z8W5x73El3aUOs5i@macbook.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <20250219092059.90850-3-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219092059.90850-3-roger.pau@citrix.com>

Hello Nirmal,

Can I please get an Ack or a request for changes on the patch below
for the VMD controller code?

Thanks, Roger.

On Wed, Feb 19, 2025 at 10:20:56AM +0100, Roger Pau Monne wrote:
> MSI remapping bypass (directly configuring MSI entries for devices on the
> VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
> and hence cannot configure the entries using the pIRQ interface in the PV
> case, and in the PVH case traps won't be setup for MSI entries for such
> devices.
> 
> Until Xen is aware of devices in the VMD bus prevent the
> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
> any kind of Xen guest.
> 
> The MSI remapping bypass is an optional feature of VMD bridges, and hence
> when running under Xen it will be masked and devices will be forced to
> redirect its interrupts from the VMD bridge.  That mode of operation must
> always be supported by VMD bridges and works when Xen is not aware of
> devices behind the VMD bridge.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Changes since v2:
>  - Adjust patch subject.
>  - Adjust code comment.
> 
> Changes since v1:
>  - Add xen header.
>  - Expand comment.
> ---
>  drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947350..e619accca49d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,8 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  
> +#include <xen/xen.h>
> +
>  #include <asm/irqdomain.h>
>  
>  #define VMD_CFGBAR	0
> @@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int err;
>  
> +	if (xen_domain()) {
> +		/*
> +		 * Xen doesn't have knowledge about devices in the VMD bus
> +		 * because the config space of devices behind the VMD bridge is
> +		 * not known to Xen, and hence Xen cannot discover or configure
> +		 * them in any way.
> +		 *
> +		 * Bypass of MSI remapping won't work in that case as direct
> +		 * write by Linux to the MSI entries won't result in functional
> +		 * interrupts, as Xen is the entity that manages the host
> +		 * interrupt controller and must configure interrupts.  However
> +		 * multiplexing of interrupts by the VMD bridge will work under
> +		 * Xen, so force the usage of that mode which must always be
> +		 * supported by VMD bridges.
> +		 */
> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +	}
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> -- 
> 2.46.0
> 


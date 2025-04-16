Return-Path: <linux-pci+bounces-25992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F4AA8B67B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0513AED1B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4249E230BD6;
	Wed, 16 Apr 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m47wcpp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EA21B9DE;
	Wed, 16 Apr 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798320; cv=none; b=aK5sljJX+ombUoCwyPzxeFe8yEG5xpQYq6lcK52GjajVSYNmc5dIc7UkQBUQSj6KGNG3J5FudP6ih0zHpIoctMGikQmssrjkLWdZCmlpVsTgXln4QncOmFIlND7hdaRyauiouTSi/JlViOAxLHDaQO3rkP/fJQgCKOLRVWEBV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798320; c=relaxed/simple;
	bh=sMOm/Ug7DGLCAyPc/DeuHOwZPq41wEA6GsniVW1seLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi+o6YKZWUkebgAOcZljLPjEKg29OrEjBjBD8OZhjnuibfgQShCiBLc6jMEj4JYSIVuqGcr2ZGdt8c9EVkNYeMTFiBCobiX8H0UurqwZRWk/4vO9bN+aiK1cX+FcKc2yIBgEWOl1LvWjVwmFJIZ9lAl2fsEh2ixvM5MK9Ea8LA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m47wcpp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6014BC4CEE2;
	Wed, 16 Apr 2025 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744798319;
	bh=sMOm/Ug7DGLCAyPc/DeuHOwZPq41wEA6GsniVW1seLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m47wcpp35Wjj8X0JVajKjrLGZ5iICpGfq0lDHCvuInLAGqqk2BCB7GPLfkoxKdWyY
	 zP5BUvN7oEZShx49us+YRl7YPYLSccDjpgT4fX9uB5bYLVXmOhdAPN8WhLl21IsQRd
	 K+qlLh+AHguAczi1qrdQ9xfx9c3muNoQiZhWWM1twwZPsfmIyitgD+oCT0wn8Hue5H
	 NVpZmwMcPZtP6vYRt1hU8EuuDyn0rvk+LCJskWiRxLZUWOMtFEHnQE3bKsu8L/390k
	 x2Zv9kXeXwa8SOtczEa6o/Z26sQmpfrF+0HJBxrqyxVi6eZwpRkxYdq81H0tCHRUnR
	 PbXPNdiVwVIHg==
Date: Wed, 16 Apr 2025 12:11:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use PCI_STD_NUM_BARS instead of 6
Message-ID: <Z_-Caya2spaSV8f4@ryzen>
References: <20250416100239.6958-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416100239.6958-1-ilpo.jarvinen@linux.intel.com>

On Wed, Apr 16, 2025 at 01:02:39PM +0300, Ilpo Järvinen wrote:
> pci_read_bases() is given literal 6 that means PCI_STD_NUM_BARS.
> Replace the literal with the define to annotate the code better.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..08971fca0819 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2058,7 +2058,7 @@ int pci_setup_device(struct pci_dev *dev)
>  		if (class == PCI_CLASS_BRIDGE_PCI)
>  			goto bad;
>  		pci_read_irq(dev);
> -		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
> +		pci_read_bases(dev, PCI_STD_NUM_BARS, PCI_ROM_ADDRESS);
>  
>  		pci_subsystem_ids(dev, &dev->subsystem_vendor, &dev->subsystem_device);
>  
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.39.5
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>


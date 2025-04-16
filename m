Return-Path: <linux-pci+bounces-26040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651CA90B3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98273B0601
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF321518B;
	Wed, 16 Apr 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb94Bwnn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655751FB3;
	Wed, 16 Apr 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827833; cv=none; b=nRgAIpFlDdVl9AArEqFdK1aRawqnJbqcQSjEjuZk9GNYFsaiZ1McT3oxBkizQTY51B/tshgokeNSkYRBCigUyXGkInFsnqqPHwTFWUbnznZq7ZueXb5+PyXCGAxHehjBDhYmb8wUI8JdetbHSpOLhGSYhHvzWpNTsUenBBcP49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827833; c=relaxed/simple;
	bh=2WRZGk0SvPyuTSIfxKF4t3npHnGcBbdve+9zfCeTWYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IWzYPyYhjEY3KWQLs051nSXWCTnb/pJtAUAIwJth16YOg93KGaAwU0N9zezJ4yDOBO9Z4/dBXgnqmtugnxXxpMk1vHFpznmfiyTOzQARG7lNmYtW3dWcz5N+jClin7GbVZ/W834RSklOXLO/s/sne1UEdHT0Dvp/y2WW5E/n/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb94Bwnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18926C4CEE2;
	Wed, 16 Apr 2025 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744827833;
	bh=2WRZGk0SvPyuTSIfxKF4t3npHnGcBbdve+9zfCeTWYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gb94Bwnn+iJDIZfiS3widCto+11q0xY5FnIOCXQStX673DzR4g9SJEmxlm+/RKmSb
	 3xxaOwCDZJ0HMQaql3lUVihXkGuuDWUZ0VqrELOyHWT4Uz8GoHtVfnV/T/cbGpP95P
	 8k6ul0dIVo/l1nAmvLpvCbPiOCdWtclg7PAwLq5Zn/PCbcTWNJhAjQWQOxdIyX1A0H
	 p1bkUMLcY+GkFFctEPZ0h/kjLWNzM9wuo4m8+b5aVvG/HhMtUEwjPY1h1Qh/CIVbES
	 dVzpIL6BR+euN9nRZfBhZUNVVeWkgUY1bahiR8vMkgh0EHeUqrlBZTFOOciHc5TJyd
	 C9neJQ9I9Blhg==
Date: Wed, 16 Apr 2025 13:23:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use PCI_STD_NUM_BARS instead of 6
Message-ID: <20250416182351.GA75338@bhelgaas>
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

Applied to pci/enumeration for v6.16, thanks!

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


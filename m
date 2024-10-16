Return-Path: <linux-pci+bounces-14693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C069A12DD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C941C2345A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB018C332;
	Wed, 16 Oct 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Reydivza"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917D125B9;
	Wed, 16 Oct 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107966; cv=none; b=uuMfMsjCxXz70p1ny494tXTLDpD7PEe+AFztu/b0d7yTF671flVZDkgsOEugJOMv1MyE8SKtzxoPnugY6WlguxhxniOpBrZhimfhjceWAyl3qh+e7kvkT1o1s6J/HnlUoYmyCVMaDaI1s5rjkGQ/6MAsrfgQTrSTNSH4v30I+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107966; c=relaxed/simple;
	bh=ifHMEAeYIwdiOm/4PBeeFzJGOx+gjxtq/ST9MHK03Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k9DDaFPa1ZVaZwblCzg3BH/Xjz2JsCkeM6cVx2jtgBtTHOoI7Y6tlhlzhysV5Y9URlpdiWvoNCtoEagxYLUxR7xKGWAPh3KoB09XtHxtj/EpwjVjTpV+LS0KNlHHtlcghz5qm9+Vw/iz1cgejuuZmPTTpRNH11le2daPP/gJ640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Reydivza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF41CC4CEC5;
	Wed, 16 Oct 2024 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729107965;
	bh=ifHMEAeYIwdiOm/4PBeeFzJGOx+gjxtq/ST9MHK03Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ReydivzaMlpl+P/IaWv4Oas2W/qiHIBodRRXaRX/o9ao9/Rm9gEX6I267ZIyuQkts
	 XHYotW5hmNyhTATYVsLmaaqjHghebRz1QILZv36lbIh+yzv6LEvhnI0yroPdIkCEEe
	 cBcZyL3AxsnECIz4B5bDJUB58wYS9hbbqiRV5BvYMQMbCnZGRFMKaRbUt574BXddbz
	 FYjI3Ynb/OLC53b7Bjm/V/gMQLycZRr8HbBSv8fnjfYC+CvxZ8GL1Mii5omPRqmvRy
	 xvM5jyGdIGzWaWOdlWfxZlSPlI54rWm/G11EB2VpZH58+haTFONbEZRVRKOAwE0bOV
	 vzo6u5hOt7jGw==
Date: Wed, 16 Oct 2024 14:46:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: scott@spiteful.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cpcihp: remove uneccessary field
Message-ID: <20241016194604.GA646755@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014131917.324667-1-trintaeoitogc@gmail.com>

On Mon, Oct 14, 2024 at 10:19:17AM -0300, Guilherme Giacomo Simoes wrote:
> The hardware_test field in cpci_hp_controller_ops is uneccessary because
> no file is being used. How a pointer need a space in memory for storage
> the address (4 bytes in 32bits systems and 8 bytes in 64 bits sustems),
> remove this dead code to reduce resource consumption.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Applied to pci/hotplug for v6.13, thanks!

> ---
>  drivers/pci/hotplug/cpci_hotplug.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index 6d8970d8c3f2..03fa39ab0c88 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -44,7 +44,6 @@ struct cpci_hp_controller_ops {
>  	int (*enable_irq)(void);
>  	int (*disable_irq)(void);
>  	int (*check_irq)(void *dev_id);
> -	int (*hardware_test)(struct slot *slot, u32 value);
>  	u8  (*get_power)(struct slot *slot);
>  	int (*set_power)(struct slot *slot, int value);
>  };
> -- 
> 2.46.2
> 


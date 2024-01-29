Return-Path: <linux-pci+bounces-2737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F4B8412D4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54661C21A71
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8B4205B;
	Mon, 29 Jan 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi5HQsfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674A2E85E;
	Mon, 29 Jan 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554546; cv=none; b=JiOhH26QtvgQZzuhPQz4ScckJ0+qIid64n9xzN/z6++LMAL7Z2GoKouF6iCAbcvnonm2LVvfeeh6VWcwr430WCZg71P9wgi5PvtGBz9stKFs/0oOPRjdyHOdG/GZTtfPOoN0gv3fbAtOzYP/bJgtuyztj15fK1CJaPL8k8cBJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554546; c=relaxed/simple;
	bh=FzcRRuUgsytx5htHBrImWkUMo8eLI1xEsTJFjI4Q/ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j1yuPgJtFQS0jnCwvQ2GlCLK0vqfSkvZp0o6nWbhmaUNhDnlwPxKL1oRifpadRFadGp0M3OQOw8059/eAFaO4no1SFgESGXqYZzZJCWULflcU6XFUllBYeHNuiPqzyC39pQElw+tPJQeTmQVMuAq1gOmnAgd5d0HUEUIaFxXE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi5HQsfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DE5C433F1;
	Mon, 29 Jan 2024 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706554545;
	bh=FzcRRuUgsytx5htHBrImWkUMo8eLI1xEsTJFjI4Q/ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Mi5HQsfAfo8vg4TKpZx+YaI5RMJkwzzNbNr6+nufMBiJgryfd1RAqGWRqozoz6mcP
	 wUtMQwZX0n/4An2fCxHPaAJvydaofAq5JeJLu1ltdDZtSM6U2UJpbE+mPwSWjV4nyN
	 BvXtiotZaCTKde7tlV6wuU8ZxSAzmHimE4W4tcp7fXLDvuBxLgCtSivtyvMyxZliQe
	 h6l/sWHwUHTgoQWHmYTr87pl/gtVMJuYgoHLNDC2WiaRsXVcOS+NK3N+SrQh45RZrv
	 y5FYrH+wboQiuGV+/7eaqXulcvbILr+1HpNkTWXXFAreEv3hTtBnl5XLCM4m92NKx5
	 v/31jk1D/7iJA==
Date: Mon, 29 Jan 2024 12:55:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: Do not wait for disconnected devices when
 resuming
Message-ID: <20240129185544.GA471021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129112710.2852-3-ilpo.jarvinen@linux.intel.com>

On Mon, Jan 29, 2024 at 01:27:10PM +0200, Ilpo Järvinen wrote:
> On runtime resume, pci_dev_wait() is called:
>   pci_pm_runtime_resume()
>     pci_pm_bridge_power_up_actions()
>       pci_bridge_wait_for_secondary_bus()
>         pci_dev_wait()
> 
> While a device is runtime suspended along with its PCIe hierarchy, the
> device could get disconnected. In such case, the link will not come up
> no matter how log pci_dev_wait() waits for it.

s/PCIe/PCI/ (unless this is a PCIe-specific thing)
s/log/long/

> Besides the above mentioned case, there could be other ways to get the
> device disconnected while pci_dev_wait() is waiting for the link to
> come up.
> 
> Make pci_dev_wait() to exit if the device is already disconnected to
> avoid unnecessary delay. As disconnected device is not really even a
> failure in the same sense as link failing to come up for whatever
> reason, return 0 instead of errno.

The device being disconnected is not the same as a link failure.  Do
all the callers do the right thing if pci_dev_wait() returns success
when there's no device there?

> Also make sure compiler does not become too clever with
> dev->error_state and use READ_ONCE() to force a fetch for the
> up-to-date value.

I think we should have a comment there to say why READ_ONCE() is
needed.  Otherwise it's hard to know whether a future change might
make it unnecessary.

> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.c | 5 +++++
>  drivers/pci/pci.h | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..ec9bf6c90312 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1250,6 +1250,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	for (;;) {
>  		u32 id;
>  
> +		if (pci_dev_is_disconnected(dev)) {
> +			pci_dbg(dev, "disconnected; not waiting\n");
> +			return 0;
> +		}
> +
>  		pci_read_config_dword(dev, PCI_COMMAND, &id);
>  		if (!PCI_POSSIBLE_ERROR(id))
>  			break;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..563a275dff67 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/pci.h>
>  
> +#include <asm/rwonce.h>
> +
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>  #define MAX_NR_DEVFNS 256
>  
> @@ -370,7 +372,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  
>  static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  {
> -	return dev->error_state == pci_channel_io_perm_failure;
> +	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
>  }
>  
>  /* pci_dev priv_flags */
> -- 
> 2.39.2
> 


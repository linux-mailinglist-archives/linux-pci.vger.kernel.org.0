Return-Path: <linux-pci+bounces-7251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505788C01F8
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8256DB216AB
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDB65F;
	Wed,  8 May 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3a268Gj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4C652;
	Wed,  8 May 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185819; cv=none; b=CFCxE99Nb2k1q7QxFo3mkchWnx2IWFmotNbI279vij2KVSSuy15Q5CBVp4H5RIiz9hPqF21plFW0xfpX5+3txhk+FZZYO9RRcXrIQrke04eiQDFqN9xd9DitSiI54qO7g5wGFnqHWb/qXMVCBLdnBdYxEji7xNwXiylKW9nIVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185819; c=relaxed/simple;
	bh=FthUkrX5z95LrzSNogEsZER1NsERc0w012QGDgI+cxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gORRrU2ApVUHwt4D6UljtWoNDzHavXzdEYfJprDL62W/5VtAJVTts0lzFnOARIoQB/a3QU6098DYcCZuSS/Y6P8dpVwmSETtaHAFvSksVwTrCq788badxTVMCJsjNCyvtpXZNPC/Ck7Bi6ovP8kxjOWLGXzPnAkuyqqdmkC8dMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3a268Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B4C113CC;
	Wed,  8 May 2024 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185819;
	bh=FthUkrX5z95LrzSNogEsZER1NsERc0w012QGDgI+cxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E3a268GjpNr0aBu9zs7jRz4Pu5sBvwiFr0KoJV/HDYxLvzHNDo48KPw6hKnYDgnvL
	 VWaC9jylrD+uRI1Bm4rnyjKCzNOyP/RwUgINv+bWGw6urJ1kiVbl2DaECX1/gWU19P
	 gglEo5tVzdr75AASY7TirmwMg1GfNl9Z7mvZFQzOTTSz69cvjpx1Ck5fEqCIVOFmy/
	 EtyNPJSQ0fLNl0ikhMGnrv/bu/akCF9bibfTvKRw+mndaD/TQdzhpiRZ+l4/5Z/asI
	 dJLGelP2LJ7PpVEuqwzMWWPqNRBifhC2rAIJeLIl118eszhmtAT4kWjnDqVsJVcAPB
	 2ztu3vsAC9IKQ==
Date: Wed, 8 May 2024 11:30:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/1] PCI: Do not wait for disconnected devices when
 resuming
Message-ID: <20240508163017.GA1770909@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208132322.4811-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 08, 2024 at 03:23:21PM +0200, Ilpo Järvinen wrote:
> On runtime resume, pci_dev_wait() is called:
>   pci_pm_runtime_resume()
>     pci_pm_bridge_power_up_actions()
>       pci_bridge_wait_for_secondary_bus()
>         pci_dev_wait()
> 
> While a device is runtime suspended along with its PCI hierarchy, the
> device could get disconnected. In such case, the link will not come up
> no matter how long pci_dev_wait() waits for it.
> 
> Besides the above mentioned case, there could be other ways to get the
> device disconnected while pci_dev_wait() is waiting for the link to
> come up.
> 
> Make pci_dev_wait() to exit if the device is already disconnected to
> avoid unnecessary delay.
> 
> The use cases of pci_dev_wait() boil down to two:
>   1. Waiting for the device after reset
>   2. pci_bridge_wait_for_secondary_bus()
> 
> The callers in both cases seem to benefit from propagating the
> disconnection as error even if device disconnection would be more
> analoguous to the case where there is no device in the first place
> which return 0 from pci_dev_wait(). In the case 2, it results in
> unnecessary marking of the devices disconnected again but that is
> just harmless extra work.
> 
> Also make sure compiler does not become too clever with
> dev->error_state and use READ_ONCE() to force a fetch for the
> up-to-date value.
> 
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/enumeration for v6.10, thanks!

> ---
> 
> v2:
> 
> Sent independent of the other patch.
> 
> Return -ENOTTY instead of 0 because it aligns better with the
> expecations of the reset use case and only causes unnecessary
> disconnect marking in the pci_bridge_wait_for_secondary_bus()
> case for devices that are already marked disconnected.
> 
>  drivers/pci/pci.c | 5 +++++
>  drivers/pci/pci.h | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ca4159472a72..14c57296a0aa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1250,6 +1250,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	for (;;) {
>  		u32 id;
>  
> +		if (pci_dev_is_disconnected(dev)) {
> +			pci_dbg(dev, "disconnected; not waiting\n");
> +			return -ENOTTY;
> +		}
> +
>  		pci_read_config_dword(dev, PCI_COMMAND, &id);
>  		if (!PCI_POSSIBLE_ERROR(id))
>  			break;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..58a32d2d2e96 100644
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
> @@ -370,7 +372,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  
>  static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  {
> -	return dev->error_state == pci_channel_io_perm_failure;
> +	/*
> +	 * error_state is set in pci_dev_set_io_state() using xchg/cmpxchg()
> +	 * and read w/o common lock. READ_ONCE() ensures compiler cannot cache
> +	 * the value (e.g. inside the loop in pci_dev_wait()).
> +	 */
> +	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
>  }
>  
>  /* pci_dev priv_flags */
> -- 
> 2.39.2
> 


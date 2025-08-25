Return-Path: <linux-pci+bounces-34686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27EBB34EEA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 00:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E48C3ACBB4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA571A9FB8;
	Mon, 25 Aug 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKesTbLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E24A33;
	Mon, 25 Aug 2025 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160497; cv=none; b=g38jyYKxSpwEm1pwq09NlN7gFHshTVj7G4+L0rHpnVQ2LI81ZaFLyYtLo5QBYRNOX/2KP1ryAZaXoAZPaACwdifvRSNzjOka1xjZ32XTaX7V83H+Sxgc+WKhJtJsNUNmblOWIsdS/g7xCPMDxI1fHifhXaRM5B9fmyMlDZNp5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160497; c=relaxed/simple;
	bh=1L1AMdIXakqF4oFhemuvzl1klkE1NdZzGzIJyFFccH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lTBvRhQAhCr2NXyHLdXlM9AYtLrgkZWWlm3eEwlufixj/5cFWvSM9tpMccsjBffWCNnUq3aZR5hgB2WKZAtoMPO570u7gi9Hh2Nd4k+rPt5gQk1YZioY6gjv3hnmI5X5hBb4MwvmIbIF8AT28d3R0YpI8Zfhf6tw6tblScBk/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKesTbLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB690C4CEED;
	Mon, 25 Aug 2025 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756160495;
	bh=1L1AMdIXakqF4oFhemuvzl1klkE1NdZzGzIJyFFccH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VKesTbLeCYuq1TwE/MAEQ2ULIODY4Mo2e6+NWiSqA8IWwgfwiZYRP783bqAoUprla
	 SMfxTllMwfDYNoJXY4BBMq2A0Svp0m8X3SYElrvKz07JNKApySlceic921u2aOMx6a
	 TV942BsXs8q+vbOrosqx4o4S5o6Yinds2KTeizof0DwwJxoLdhDVeaz1Qow8O43uIO
	 4/LObGqzcWiZtYNquiSIqAKle0eLZXFx4PIb+lGx0N6nUXeIeXMOvPhsOUzzsXwcBb
	 /sbUAkFks7PDvR0K6wHdGZ53sfANkojvyw9Z0NqUqsJj8g5O0iPgeP/2vNke8OEGPQ
	 CGxTPKLham6aA==
Date: Mon, 25 Aug 2025 17:21:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Fix failure detection during resource resize
Message-ID: <20250825222134.GA802347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822123359.16305-4-ilpo.jarvinen@linux.intel.com>

On Fri, Aug 22, 2025 at 03:33:59PM +0300, Ilpo Järvinen wrote:
> Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync") the failed list is always built and returned to let
> the caller decide what to do with the failures. The caller may want to
> retry resource fitting and assignment and before that can happen, the
> resources should be restored to their original state (a reset
> effectively clears the struct resource), which requires returning them
> on the failed list so that the original state remains stored in the
> associated struct pci_dev_resource.
> 
> Resource resizing is different from the ordinary resource fitting and
> assignment in that it only considers part of the resources. This means
> failures for other resource types are not relevant at all and should be
> ignored. As resize doesn't unassign such unrelated resources, those
> resource ending up into the failed list implies assignment of that
> resource must have failed before resize too. The check in
> pci_reassign_bridge_resources() to decide if the whole assignment is
> successful, however, is based on list emptiness which will cause false
> negatives when the failed list has resources with an unrelated type.
> 
> If the failed list is not empty, call pci_required_resource_failed()
> and extend it to be able to filter on specific resource types too (if
> provided).
> 
> Calling pci_required_resource_failed() at this point is slightly
> problematic because the resource itself is reset when the failed list
> is constructed in __assign_resources_sorted(). As a result,
> pci_resource_is_optional() does not have access to the original
> resource flags. This could be worked around by restoring and
> re-reseting the resource around the call to pci_resource_is_optional(),
> however, it shouldn't cause issue as resource resizing is meant for
> 64-bit prefetchable resources according to Christian König (see the
> Link which unfortunately doesn't point directly to Christian's reply
> because lore didn't store that email at all).
> 
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com/
> Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> Closes: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/

I'm trying to connect this fix with the Asynchronous SError Interrupt
crash that Scott reported here.  From the call trace:

  ...
  arm64_serror_panic+0x6c/0x90
  do_serror+0x58/0x60
  el1h_64_error_handler+0x38/0x60
  el1h_64_error+0x84/0x88
  _raw_spin_lock_irqsave+0x34/0xb0 (P)
  amdgpu_ih_process+0xf0/0x150 [amdgpu]
  amdgpu_irq_handler+0x34/0xa0 [amdgpu]
  __handle_irq_event_percpu+0x60/0x248
  handle_irq_event+0x4c/0xc0
  handle_fasteoi_irq+0xa0/0x1c8
  handle_irq_desc+0x3c/0x68
  generic_handle_domain_irq+0x24/0x40
  __gic_handle_irq_from_irqson.isra.0+0x15c/0x260
  gic_handle_irq+0x28/0x80
  call_on_irq_stack+0x24/0x30
  do_interrupt_handler+0x88/0xa0
  el1_interrupt+0x44/0xd0
  el1h_64_irq_handler+0x18/0x28
  el1h_64_irq+0x84/0x88
  amdgpu_device_rreg.part.0+0x4c/0x190 [amdgpu] (P)
  amdgpu_device_rreg+0x24/0x40 [amdgpu]

I guess something happened in amdgpu_device_rreg() that caused an
interrupt, maybe a bogus virtual address for a register?

And then amdgpu_ih_process() did something that caused the SError?  Or
since it seems to be asynchronous, maybe the amdgpu_ih_process()
connection is coincidental and the SError was a consequence of
something else?

I'd like to have a bread crumb here in the commit log that connects
this fix with something a user might see, but I don't know what that
would look like.

> Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index df5aec46c29d..def29506700e 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -28,6 +28,10 @@
>  #include <linux/acpi.h>
>  #include "pci.h"
>  
> +#define PCI_RES_TYPE_MASK \
> +	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> +	 IORESOURCE_MEM_64)
> +
>  unsigned int pci_flags;
>  EXPORT_SYMBOL_GPL(pci_flags);
>  
> @@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
>  }
>  
>  /* Return: @true if assignment of a required resource failed. */
> -static bool pci_required_resource_failed(struct list_head *fail_head)
> +static bool pci_required_resource_failed(struct list_head *fail_head,
> +					 unsigned long type)
>  {
>  	struct pci_dev_resource *fail_res;
>  
> +	type &= PCI_RES_TYPE_MASK;
> +
>  	list_for_each_entry(fail_res, fail_head, list) {
>  		int idx = pci_resource_num(fail_res->dev, fail_res->res);
>  
> +		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) != type)
> +			continue;
> +
>  		if (!pci_resource_is_optional(fail_res->dev, idx))
>  			return true;
>  	}
> @@ -504,7 +514,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  	}
>  
>  	/* Without realloc_head and only optional fails, nothing more to do. */
> -	if (!pci_required_resource_failed(&local_fail_head) &&
> +	if (!pci_required_resource_failed(&local_fail_head, 0) &&
>  	    list_empty(realloc_head)) {
>  		list_for_each_entry(save_res, &save_head, list) {
>  			struct resource *res = save_res->res;
> @@ -1708,10 +1718,6 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
>  	}
>  }
>  
> -#define PCI_RES_TYPE_MASK \
> -	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> -	 IORESOURCE_MEM_64)
> -
>  static void pci_bridge_release_resources(struct pci_bus *bus,
>  					 unsigned long type)
>  {
> @@ -2450,8 +2456,12 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  		free_list(&added);
>  
>  	if (!list_empty(&failed)) {
> -		ret = -ENOSPC;
> -		goto cleanup;
> +		if (pci_required_resource_failed(&failed, type)) {
> +			ret = -ENOSPC;
> +			goto cleanup;
> +		}
> +		/* Only resources with unrelated types failed (again) */
> +		free_list(&failed);
>  	}
>  
>  	list_for_each_entry(dev_res, &saved, list) {
> -- 
> 2.39.5
> 


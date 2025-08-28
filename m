Return-Path: <linux-pci+bounces-35038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45734B3A4C0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06157987D04
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3224166D;
	Thu, 28 Aug 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srr7Szg1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F92264B8;
	Thu, 28 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395660; cv=none; b=mrVn7cIxwmHVaMwTRlCa/WURpFwYu/zu96xE+nOn2uZeQvQnB8gaLE5427V+51kFdR4oJVQo4sk+qPV73QPhDvEwxDN9aleUya07HmBCi8b3aXc8esJFKYQgBlXQwLhUu9Et5Tu07Ni1WSRW9JN3v9yzbziUBq6ANOFv2fhRwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395660; c=relaxed/simple;
	bh=fDAFNMCGd4s0nqggGLcVQSBxpDA3i/ljwPD8Ayr/bUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NLclvwdw4yET39fB7YvCiFI88fyY1j1EImHDcLeQBhmim/glJGhL12uqarFH1M7rldBxO0bpCwLgUTWD9lBPfHFz5Jfsfcve4P4DT0lfkemjS/24KH08CfA64M/Wtk/Qu45R+wVkVTZ9MCRLnvi0W+lNviJ1CkQ+LtE236wzX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srr7Szg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474B5C4CEEB;
	Thu, 28 Aug 2025 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756395659;
	bh=fDAFNMCGd4s0nqggGLcVQSBxpDA3i/ljwPD8Ayr/bUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=srr7Szg11N29PiIqoyD++2t566rMiBW/fnoEXIXNSYKYSGzdE5kzgmizUFR2Sd5mq
	 7NvGnbHyzgGVmMrOZBNQuEpgbV0xWRHkPkc9JBNfNJsIOJqB5iMNCzWtnm0zZogZ8i
	 9ODCddFfZH6JkkIqmNbAKh49U16VozXJOF3IM6ZB19zQEHfzzA3AJxHF8fVhJjRfEg
	 JMMhNBLM1KpejoQiHuC05ee7e3wolyVrra0FhXCs00IaOiDf5e0p5m/iXMt5y6TA2P
	 +A44wg1TCfgvc0/3/aOaDdc0nW/AT3iUI5RdBUdhIxRymo/Iw5RFwIEf4Mc77o9By3
	 J2FO5tE+bR24w==
Date: Thu, 28 Aug 2025 10:40:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: logang@deltatee.com, kurt.schwemmer@microsemi.com, bhelgaas@google.com,
	julia.lawall@inria.fr, kelvin.cao@microchip.com,
	wesley.sheng@microchip.com, stephen.bates@microsemi.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: switchtec: Replace manual locks with guard
Message-ID: <20250828154057.GA945052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828093556.810911-1-karanja99erick@gmail.com>

On Thu, Aug 28, 2025 at 12:35:55PM +0300, Erick Karanja wrote:
> Replace lock/unlock pairs with guards to simplify and tidy up the code
> 
> Generated-by: Coccinelle SmPL
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

Applied to pci/switchtec for v6.18, thanks, Erick!

> ---
>  drivers/pci/switch/switchtec.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index b14dfab04d84..5ff84fb8fb0f 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -269,10 +269,9 @@ static void mrpc_event_work(struct work_struct *work)
>  
>  	dev_dbg(&stdev->dev, "%s\n", __func__);
>  
> -	mutex_lock(&stdev->mrpc_mutex);
> +	guard(mutex)(&stdev->mrpc_mutex);
>  	cancel_delayed_work(&stdev->mrpc_timeout);
>  	mrpc_complete_cmd(stdev);
> -	mutex_unlock(&stdev->mrpc_mutex);
>  }
>  
>  static void mrpc_error_complete_cmd(struct switchtec_dev *stdev)
> @@ -1322,18 +1321,18 @@ static void stdev_kill(struct switchtec_dev *stdev)
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
>  
>  	/* Mark the hardware as unavailable and complete all completions */
> -	mutex_lock(&stdev->mrpc_mutex);
> -	stdev->alive = false;
> -
> -	/* Wake up and kill any users waiting on an MRPC request */
> -	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
> -		stuser->cmd_done = true;
> -		wake_up_interruptible(&stuser->cmd_comp);
> -		list_del_init(&stuser->list);
> -		stuser_put(stuser);
> -	}
> +	scoped_guard (mutex, &stdev->mrpc_mutex) {
> +		stdev->alive = false;
> +
> +		/* Wake up and kill any users waiting on an MRPC request */
> +		list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
> +			stuser->cmd_done = true;
> +			wake_up_interruptible(&stuser->cmd_comp);
> +			list_del_init(&stuser->list);
> +			stuser_put(stuser);
> +		}
>  
> -	mutex_unlock(&stdev->mrpc_mutex);
> +	}
>  
>  	/* Wake up any users waiting on event_wq */
>  	wake_up_interruptible(&stdev->event_wq);
> -- 
> 2.43.0
> 


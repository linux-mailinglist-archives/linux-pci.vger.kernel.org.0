Return-Path: <linux-pci+bounces-13656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6198AA80
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27A287F22
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2F192584;
	Mon, 30 Sep 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWrKCUNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F0126C03;
	Mon, 30 Sep 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715799; cv=none; b=O5fToI/dIvU6jcvEFTlDNMxpqAuPfbsYt6RrICJBgby2yF0yzuxQoSbqKAdHb3wqHqJi4o4eU2CvFvklYxnS/oZHdJT6PQzeB9fdYXD+smmhvqrE0iIAUS4yqRJ1LOZbP1S4vRV23zF+8JqV7EiX35PWy8uMj/RoEFvEAFGY+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715799; c=relaxed/simple;
	bh=NnaCVmo2sAdCg/1A50cYqv41sscTIee2oNnVYOFRF34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OmA4NPmQVQVFksMvXn2tdGpQTRo1TLRL6VJeHcmgFDkyyA7m5viTNXBHAIDJ2ISRgbILenCo3SQFrFS6v7qSXy7cWmGbLP/zZbWIg29Tfx/qVg2+elqFbgl88ieLKZa0bInKBOwCum+oY7Kgl1yOppItSUp+P7g/7y/nPX+EzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWrKCUNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD606C4CEC7;
	Mon, 30 Sep 2024 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715799;
	bh=NnaCVmo2sAdCg/1A50cYqv41sscTIee2oNnVYOFRF34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aWrKCUNuj3/lDoJtEMI9OXCFRZlpkBDAcRbuvS8f+hc75OCtJdnc7mfPiOSdaWkzK
	 Mx/SbR76wWoHd18aTRZaDIo58nLtZIXABIUyrdEDO+/jRjS9cJorfotu8VeH0HKXA0
	 gOLTwyR0TckNi2dqabv3wqrRSlInslTuM/gj0WDXq7vWvr2zifZ25R21buR73AJAMF
	 YQHlTmyRkh6IQQm+QO7cQ1Pm9OwJ4Bk+ef/wJhFX+5ofhVj4NFrizk1OVekGrsEJCB
	 Oau9ckl13VEdhhpGLzu6PMy5uwE+mlnqrKLmgpEdo6OHnMYiPDidbG9SiR9HPpalSt
	 XoO8RLxl4EQfQ==
Date: Mon, 30 Sep 2024 12:03:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hotplug: Remove "Returns" kerneldoc from void
 functions
Message-ID: <20240930170317.GA180055@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930124436.17908-1-ilpo.jarvinen@linux.intel.com>

On Mon, Sep 30, 2024 at 03:44:36PM +0300, Ilpo Järvinen wrote:
> pci_hp_deregister() was converted to void by the commit 51bbf9bee34f
> ("PCI: hotplug: Demidlayer registration with the core") but its
> kerneldoc still describes the return value. pci_hp_del() and
> pci_hp_destroy() have been void since they were introduced in that same
> commit.
> 
> Remove the return value description from the kerneldoc of those
> functions.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/misc for v6.13, thanks Ilpo!

> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index 058d5937d8a9..69b18b07f60a 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -498,8 +498,6 @@ EXPORT_SYMBOL_GPL(pci_hp_add);
>   *
>   * The @slot must have been registered with the pci hotplug subsystem
>   * previously with a call to pci_hp_register().
> - *
> - * Returns 0 if successful, anything else for an error.
>   */
>  void pci_hp_deregister(struct hotplug_slot *slot)
>  {
> @@ -513,8 +511,6 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
>   * @slot: pointer to the &struct hotplug_slot to unpublish
>   *
>   * Remove a hotplug slot's sysfs interface.
> - *
> - * Returns 0 on success or a negative int on error.
>   */
>  void pci_hp_del(struct hotplug_slot *slot)
>  {
> @@ -545,8 +541,6 @@ EXPORT_SYMBOL_GPL(pci_hp_del);
>   * the driver may no longer invoke hotplug_slot_name() to get the slot's
>   * unique name.  The driver no longer needs to handle a ->reset_slot callback
>   * from this point on.
> - *
> - * Returns 0 on success or a negative int on error.
>   */
>  void pci_hp_destroy(struct hotplug_slot *slot)
>  {
> -- 
> 2.39.5
> 


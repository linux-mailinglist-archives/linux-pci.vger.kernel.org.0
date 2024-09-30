Return-Path: <linux-pci+bounces-13653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89D98AA1B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F001F23BC4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB247198A3F;
	Mon, 30 Sep 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAadccar"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5D195381;
	Mon, 30 Sep 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714568; cv=none; b=EiqaYGjdfz/fXeDTdO/XqW3hg6+brurRN4O1hb+YBQynQroF/cXXMUx/Z27jZCreIzWQpde3TWfrqRHBMcbuQtJKM14xL45swZ6HcbOq1gXfFwQ+WtBs/k5EPwFec8jkCRV0Y166VxyorMSNLBPlvABLA6z2p2No5w6z/xJ7qHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714568; c=relaxed/simple;
	bh=e+N9Wftnz138OBY0jZAnIIG3PVBfXY7dM/DnQeglwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nFbVRP84bnPZYL/Sf/+Z4qVPqkDOHCekFySSHrlEIZ3MH26JNovbx0eN6uv8Oeo4WTLZChi87CA6olFHizoZ2V/CRbuH1w5DNEeNj6xiuxTRbHvsdFwKPBBDVhehC893XXwtv7/URiyobqd/NFyKp2lxZEbgMmdgImhV9rUJr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAadccar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B17C4CEC7;
	Mon, 30 Sep 2024 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714568;
	bh=e+N9Wftnz138OBY0jZAnIIG3PVBfXY7dM/DnQeglwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YAadccarkoZ4zofCPFCli2wMk25pASpvSoOAu/n0OGgnI4tL/5aogbJqJGj5TcPfE
	 N4d01tRwN3eOfxM/zVJTluGZEDD9cMSaxEk4cfP4JWljbcT4gKb+uHeqzXrOHu8Oo4
	 Rz3p23GQeSMvKf/eqfQj6i5vjxRhXTI0jl2ayP1rvmL11/2pRQNZoAtEeAl9M46e4b
	 XBEbkhfyEJMtW4Wm/9z1kvpKYCWmE9H6+4+27Koh3W1LNwKvsV0trGVWsLRCEC25VB
	 aWnI5Rq221yhrmn9CSsb7JSY7nHiKY1U5qxl+FwsA692lDO9tsrCDZO9Ji6zFjLWGG
	 ZrswqEKHl4lGQ==
Date: Mon, 30 Sep 2024 11:42:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/35] PCI: hotplug: Reorganize kerneldoc parameter names
Message-ID: <20240930164246.GA179357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930112121.95324-23-Julia.Lawall@inria.fr>

On Mon, Sep 30, 2024 at 01:21:08PM +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to pci/misc for v6.13, thank you!

> ---
>  drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index 058d5937d8a9..db09d4992e6e 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -388,8 +388,8 @@ static struct hotplug_slot *get_slot_from_name(const char *name)
>  
>  /**
>   * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
> - * @bus: bus this slot is on
>   * @slot: pointer to the &struct hotplug_slot to register
> + * @bus: bus this slot is on
>   * @devnr: device number
>   * @name: name registered with kobject core
>   * @owner: caller module owner
> 


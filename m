Return-Path: <linux-pci+bounces-22664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACEA4A475
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E616D327
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9361C57B2;
	Fri, 28 Feb 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK/pGqUn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F823F38F;
	Fri, 28 Feb 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776338; cv=none; b=u/qM+Puh3JnY61W+Wgj6avrtmgRqW2AYNkTuxvkLyV9jEkyBVgxMbS/UBWAucRMLiO0LDLYDQV+7nGneB33/IcrjJAf4RQBe6gyS8Ob4b+N5R7v+aW5HQqn+yBarC3UKbbh/sf2x8hi+AMhojA+U1ea/GrmHv2Vz/OFu6xd+L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776338; c=relaxed/simple;
	bh=ZareocIr6rf/July5PaSSL4Wqz+XwvXpNXxxM8+Z9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nNIvHhESVADzf3exsU5914eCKrlJb8IWXNmVc9hsp+ZlQY0O8nSKLeV+O7r8gXi4qURGy4YH+c38FQNshQzQmtmD1pVlT3nfShzXJnjblGvXLyeOSZHv3bxyP135QPwJz+Y5Vx2+VJPcclhr7MwiLRi2/GBUUCkUKN8YeTOsyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK/pGqUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2BAC4CED6;
	Fri, 28 Feb 2025 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740776337;
	bh=ZareocIr6rf/July5PaSSL4Wqz+XwvXpNXxxM8+Z9fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tK/pGqUn21d6SMEuUDYj53e0GS9clGkdoY/AIoO5qmmsgKfTnx5w/zfNyE61WvrWY
	 bOtSo8XfNZ8tK/b3euIOm/mDb0SyECh5hdjpVhpQPRo2o+L+VU7XEeiihGZ8z6kB9L
	 p2K+7lI9ir67dVz+TXKdXwAhCPh5hkvzOrJwTsLU4HdMj7GLO6Ps+nyOojC78pu75c
	 l1g8wZvs3bVZdlVQuzPBYYvgE3vBv9Qbp5YwauYx3XxEDVEhM1ORiLPGawJr8hCO0h
	 /TRvjx9hLp8xXeiq25yA7Wei+6OhYwKEZwvbZGsZT88A047vxCQNJz/qN1Muifep3q
	 3gfP7Jncc88wg==
Date: Fri, 28 Feb 2025 14:58:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 2/5] PCI: of: Use device_{add,remove}_of_node() to
 attach of_node to existing device
Message-ID: <20250228205855.GA67436@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224141356.36325-3-herve.codina@bootlin.com>

On Mon, Feb 24, 2025 at 03:13:52PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices. The newly created of_node is attached
> to an existing device. This is done setting directly pdev->dev.of_node
> in the code.
> 
> Even if pdev->dev.of_node cannot be previously set, this doesn't handle
> the fwnode field of the struct device. Indeed, this field needs to be
> set if it hasn't already been set.
> 
> device_{add,remove}_of_node() have been introduced to handle this case.

I guess another way to say this is:

  - If dev->of_node has already been set, it is an error and we want
    to do nothing.  The error is impossible in this case because
    of_pci_make_dev_node() returns early if dev->of_node has been set.

  - Otherwise, we want to set dev->of_node (just as we previously
    did), and

  - if dev->fwnode has not been set, we want to set that too.

So the whole point of this is to set dev->fwnode, which we didn't do
before.  But has np->fwnode been set to anything?  Maybe it's buried
somewhere inside of_changeset_create_node(), but I didn't see it.

I can't tell if this actually *does* anything.  And if it does, all
the above is basically C code translated into English, so it doesn't
tell us *why* this is useful, which is what I try to put in the merge
commit log.

> Use them instead of the direct setting.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/pci/of.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7a806f5c0d20..fb5e6da1ead0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -653,8 +653,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	np = pci_device_to_OF_node(pdev);
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> -	pdev->dev.of_node = NULL;
>  
> +	device_remove_of_node(&pdev->dev);
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);
>  	of_node_put(np);
> @@ -711,11 +711,18 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  		goto out_free_node;
>  
>  	np->data = cset;
> -	pdev->dev.of_node = np;
> +
> +	ret = device_add_of_node(&pdev->dev, np);
> +	if (ret)
> +		goto out_revert_cset;
> +
>  	kfree(name);
>  
>  	return;
>  
> +out_revert_cset:
> +	np->data = NULL;
> +	of_changeset_revert(cset);
>  out_free_node:
>  	of_node_put(np);
>  out_destroy_cset:
> -- 
> 2.48.1
> 


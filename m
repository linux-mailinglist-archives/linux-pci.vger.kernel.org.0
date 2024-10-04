Return-Path: <linux-pci+bounces-13873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C883991219
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE52B2849E7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B382146A93;
	Fri,  4 Oct 2024 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meT76XwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3E4437F;
	Fri,  4 Oct 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079417; cv=none; b=fwA219/ZGz1wufZmjIEm+34cWsIo6r/04C8fvIrPX96XZOgmHZJiZWXtTXJwsJmBvI5xHScMvtp7g2UBnKI7oMq8XcaPr632MJwLh4FgSgVLw5dSAFpGI/EdpiH3giVXqKquUh5P+kvCkVPvE9X5k6pNnKEiRbxpDqdSSRsJbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079417; c=relaxed/simple;
	bh=PciJuGU3l4jP8BemO+yHVHD1zY9sEkpCqasr2WXeRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i7NqVmqQFhqNqoFsEgw7yWQLoNh03FodGUlOH2shcw+E2hTqLYf/pYJ1xiB6fU73miRMpXyq/5LrqPj+jtqJnPdFMsVKbtw1KpaUDsiPKN3Pso1p425Snk43o5pBBxAGO9zsn1PaX7T/2iPWiQsTyyeGQ2nWlb3ew53JJ/47lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meT76XwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58DC4CEC6;
	Fri,  4 Oct 2024 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079416;
	bh=PciJuGU3l4jP8BemO+yHVHD1zY9sEkpCqasr2WXeRqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=meT76XwFp3KLO1ZA98MJm1nN39CfWBN88X1V4mUT4Ib88Y9MJZAjqjt5+5qMX74Il
	 qoKMOzOnQ3ZzvhSlFRYHfpUWLg7UZYmQLO2DnHLJZ+hhlwghKM4W+QwTS4ZZ2cZCXn
	 /sLS0ZGWslLkTBUgMlAs0AKSCcuBcagVwbLYnp0DuaY8fDTrOQkWP+0hC6eFNELXwP
	 IzdsXaLfPTNlg1G/Ho4W4wX+aFGQxXF9xz+C7fEPkR6z2cRee/D7tYx3UAvyUK1JpS
	 ggjCYvmlkP0SjFKxQwiOPWH8w5DvKp8HHPHE0HptwtOatGhzMK9MwJmMqe7MFrJY9V
	 W0YyJS5y5q+xw==
Date: Fri, 4 Oct 2024 17:03:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Cleanup convoluted logic in pci_create_slot()
Message-ID: <20241004220333.GA363904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004152240.7926-1-ilpo.jarvinen@linux.intel.com>

On Fri, Oct 04, 2024 at 06:22:40PM +0300, Ilpo Järvinen wrote:
> pci_create_slot() has an if () which can be made simpler by splitting
> it into two parts. In order to not duplicate error handling, add a new
> label too to handle kobj put.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/misc for v6.13, thank you!

> ---
>  drivers/pci/slot.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 0f87cade10f7..9ac5a4f26794 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -244,12 +244,13 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot = get_slot(parent, slot_nr);
>  	if (slot) {
>  		if (hotplug) {
> -			if ((err = slot->hotplug ? -EBUSY : 0)
> -			     || (err = rename_slot(slot, name))) {
> -				kobject_put(&slot->kobj);
> -				slot = NULL;
> -				goto err;
> +			if (slot->hotplug) {
> +				err = -EBUSY;
> +				goto put_slot;
>  			}
> +			err = rename_slot(slot, name);
> +			if (err)
> +				goto put_slot;
>  		}
>  		goto out;
>  	}
> @@ -278,10 +279,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
>  				   "%s", slot_name);
> -	if (err) {
> -		kobject_put(&slot->kobj);
> -		goto err;
> -	}
> +	if (err)
> +		goto put_slot;
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &parent->devices, bus_list)
> @@ -296,6 +295,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	kfree(slot_name);
>  	mutex_unlock(&pci_slot_mutex);
>  	return slot;
> +
> +put_slot:
> +	kobject_put(&slot->kobj);
>  err:
>  	slot = ERR_PTR(err);
>  	goto out;
> -- 
> 2.39.5
> 


Return-Path: <linux-pci+bounces-25762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB7AA873F3
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 23:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54A016909D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750F1EA7CD;
	Sun, 13 Apr 2025 21:08:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D22629D;
	Sun, 13 Apr 2025 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578517; cv=none; b=pvodvem53iE3v5YzAELvon+gS8EcnOlGPR2xKA4sn1NPg/vgt5UNaXDoUzETcTFrlOdhxJQwKoxQKfElzWghvrzUD93O3q8UNGffF3yzvQyEY6+5w3tCN3g4WGnW/HyS4uNgAByZcnvQV8ud+ohqqb8X6AJYoPoIRWsxLeIai0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578517; c=relaxed/simple;
	bh=VAvPDSG43f+CK44ya2evE8thgbKnAR5SCegn3dzxd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdwIgenTYwtmwsZqlcXr86OPW38G8KJQk0s18HzbWSq1i3j7J28hU49wfJ+HPRzR7hiQGV6UJDf7z0/efcSbck9XfxPMbbaUDs2Sn0oA3dG+VxZzmjXRJXIgzSOuh7EgQey7MnXOpbL70c1R6nL0+s4qWQ7NTgWxyTdX9jdD9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B3A072C4C885;
	Sun, 13 Apr 2025 23:07:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BA6334A854; Sun, 13 Apr 2025 23:08:31 +0200 (CEST)
Date: Sun, 13 Apr 2025 23:08:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v3 2/5] PCI/pwrctrl: Move pci_pwrctrl_unregister() to
 pci_destroy_dev()
Message-ID: <Z_wnz1SyIWjnhJJt@wunner.de>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
 <20250116-pci-pwrctrl-slot-v3-2-827473c8fbf4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-2-827473c8fbf4@linaro.org>

On Thu, Jan 16, 2025 at 07:39:12PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> PCI core will try to access the devices even after pci_stop_dev() for
> things like Data Object Exchange (DOE), ASPM etc... So move
> pci_pwrctrl_unregister() to the near end of pci_destroy_dev() to make sure
> that the devices are powered down only after the PCI core is done with
> them.
[...]
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -41,7 +41,6 @@ static void pci_stop_dev(struct pci_dev *dev)
>  	if (!pci_dev_test_and_clear_added(dev))
>  		return;
>  
> -	pci_pwrctrl_unregister(&dev->dev);
>  	device_release_driver(&dev->dev);
>  	pci_proc_detach_device(dev);
>  	pci_remove_sysfs_dev_files(dev);
> @@ -64,6 +63,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	pci_doe_destroy(dev);
>  	pcie_aspm_exit_link_state(dev);
>  	pci_bridge_d3_update(dev);
> +	pci_pwrctrl_unregister(&dev->dev);
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }

The above is now commit 2d923930f2e3 ("PCI/pwrctrl: Move
pci_pwrctrl_unregister() to pci_destroy_dev()"), which went
into v6.15-rc1.

While inspecting the code for an unrelated issue, I noticed a
potential ordering problem here:

Prior to 2d923930f2e3, pci_pwrctrl_unregister() was called before
of_pci_remove_node().  The order is reversed now.

So if the of_node of a PCI device was created dynamically (note the
OF_DYNAMIC check in of_pci_remove_node()), the of_node may now be
destroyed and pdev->dev.of_node may be set to NULL.

Afterwards pci_pwrctrl_unregister() bails out for lack of an of_node.

It's a change of behavior vis-à-vis what the code did prior to
2d923930f2e3.

I don't have a board using a power controller for a PCI device,
so I'm not really sure if this is an issue in practice and if so,
how it should be solved.  One obvious solution would be to move the
invocation of of_pci_remove_node() to pci_destroy_dev(), after the
invocation of pci_pwrctrl_unregister().

However I'm confused that of_pci_remove_node() is currently gated by
the PCI_DEV_ADDED flag.  Well I guess the reason is that the counterpart,
of_pci_make_dev_node(), is gated by the flag as well.  But why?
And why is the latter additionally gated by pci_is_bridge() but the
former is not?

Thanks,

Lukas


Return-Path: <linux-pci+bounces-3250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14A84EA00
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1151F23F43
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863F381D2;
	Thu,  8 Feb 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9x3rqPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B94C3A9;
	Thu,  8 Feb 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426060; cv=none; b=E7+j4R9+F/v/aiUwfcODQKxz9XnVuOM1Dgk/qB11kQS8Fjagmi6WXEk0xVAsxiGwKlHSoLaOv/fXBv2FhrQdvLbEbkfvwNCMt92dnNPoyx6DbQ9cLtsdaREX1jFJ1cidm25NLOhMzIroBm6u4fmicNkeik9eOtDhpI7mNsm/V+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426060; c=relaxed/simple;
	bh=Hdoe7W5c920HPkuwxWkQyZB/vC/76N9PRpNeiD5BvEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SJBakot1ENu3WUZtqf5O3ZeMXo5oM3b3hSo5OCl5A/Sk+y5Dva/q2Tnxfd0hdmAccGFBoOKt3O1QV0ZlP0n4tijyye7cXX0rNmLwzotfnrZBN+RoETTtPyUFwT2G/aCIxeLWgSKguuL5LUDHYJQdPbFwkAPiG/HgnnR6STo/PQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9x3rqPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD2C433C7;
	Thu,  8 Feb 2024 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707426060;
	bh=Hdoe7W5c920HPkuwxWkQyZB/vC/76N9PRpNeiD5BvEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t9x3rqPPMMn0xcWH0z4XlHF1UauZWQQsMIeEY4HwjWbpHdw/Vvm8c69J5nLVsbH4I
	 5gdSykPN5GcJJaJlQ/HmF0Mbazk/WKx2EP6EK1wNhHdkBPDGZXlXx3QCTtCm+oBXJm
	 XRbb9au99XPAmEgfpnrDWtBxejN9/39M4ZrDVnFDrLeOE6rE/Lu7AiJO9FH+hg6xiO
	 1SRQNbsUNtl1TpaaGq4Krcprk6ah/skw+txj28l6saPwAgonU0EJZHhuqDAJikV/Bu
	 9s+QZnZzMjw6y0dLxuiCJMSF1cy9favxsCt7PwPpi+0PMGiDSZ4xr7wrxaETTGshSv
	 WFfcSy7LTfeHA==
Date: Thu, 8 Feb 2024 15:00:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: make pcie_port_bus_type const
Message-ID: <20240208210058.GA971698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-bus_cleanup-pci2-v1-1-5e578210b6f2@marliere.net>

On Thu, Feb 08, 2024 at 04:41:46PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pcie_port_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to pci/misc for v6.9, thanks!

Subject line adjusted to:

  PCI: Make pcie_port_bus_type const

to match history.

> ---
>  drivers/pci/pci-driver.c   | 2 +-
>  drivers/pci/pcie/portdrv.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index ec838f2e892e..a29098e24683 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1705,7 +1705,7 @@ static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
>  	return 1;
>  }
>  
> -struct bus_type pcie_port_bus_type = {
> +const struct bus_type pcie_port_bus_type = {
>  	.name		= "pci_express",
>  	.match		= pcie_port_bus_match,
>  };
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1f3803bde7ee..12c89ea0313b 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -96,7 +96,7 @@ struct pcie_port_service_driver {
>  int pcie_port_service_register(struct pcie_port_service_driver *new);
>  void pcie_port_service_unregister(struct pcie_port_service_driver *new);
>  
> -extern struct bus_type pcie_port_bus_type;
> +extern const struct bus_type pcie_port_bus_type;
>  
>  struct pci_dev;
>  
> 
> ---
> base-commit: cc24b2d080dca2ce1c89a8a71c00bdf21155f357
> change-id: 20240208-bus_cleanup-pci2-61fe9c495d08
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 


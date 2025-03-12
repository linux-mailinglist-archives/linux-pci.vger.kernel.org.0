Return-Path: <linux-pci+bounces-23535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3DA5E592
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D2B18955C4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 20:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E41EEA28;
	Wed, 12 Mar 2025 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkBUjIhL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4491EB5DD;
	Wed, 12 Mar 2025 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812242; cv=none; b=ITOFqeShutWA9pq+mxCOjTjMMmYMaI+Wu7Bw3hczMoD1oVwe8wucelZ4zI2f534B0k/VEem0HpnT/4d5Ft2XNbbAmeunHGXZMgr8l0Z9E4VFB742DtTb+J4exEytYjQwixwC83AY/JERgtxxLmjEJ4LTJONYMpxwMqhH2GSrc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812242; c=relaxed/simple;
	bh=fJkqcS+zvjrpK0/H6/7NewYLFk5ccEwBkbPRdgafu20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hPp+JnGqxnR4GTYg5IAY9aRs7NkWZa+rJmfivIx/kget5VEzDAa0mC3NLgsROkQd4s0HDDYCvjtUB0/7wNepUIURZIaWv2sIOT0Eowpj+Ka8W3ONiFF+3kOoOQXpk+hKPZU0qf2FqVRUVNIArDsUIxI4Db4SbpMqw1RoDp76IJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkBUjIhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C753BC4CEDD;
	Wed, 12 Mar 2025 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741812242;
	bh=fJkqcS+zvjrpK0/H6/7NewYLFk5ccEwBkbPRdgafu20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jkBUjIhLUDxutkWjozn0EvvIB+SwubMT3F3LOpaylPNwyDnl6bjsxsaaiKtJv4GBo
	 wEvcjKkVJKCT6FPMs9e4CYGNxBjIBy5uykjm9Nfu6LKfcsbFGFtqDqcEKLsceiAjvZ
	 Lm0iS6i41yy3iok4Q7Jgr6v1GEkl3v3H9z3RQOHg2eINR0thbipsHHIpec+FBZ2QTj
	 CBvIBIqwkMPk6a9NynVYGogv4fHZDjLFjLaKUFRZhF8UK3GlbB8GiO6a6hqfZFS/3h
	 66MZXObHN9I9ex1OVHE+T5ruxvllSmeoh3ftD4yoxfNjZqz3D2D+jOMWbaSlY/NNxw
	 Sj+G9NhHYHV1w==
Date: Wed, 12 Mar 2025 15:44:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Move pci_rescan_bus_bridge_resize() declaration
 to pci/pci.h
Message-ID: <20250312204400.GA708146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>

On Tue, Mar 11, 2025 at 07:46:58PM +0200, Ilpo Järvinen wrote:
> pci_rescan_bus_bridge_resize() is only used by code inside PCI
> subsystem. The comment also falsely advertizes it to be for hotplug
> drivers, yet the only caller is from sysfs store function. Move the
> function declaration into pci/pci.h.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied all four patches to pci/resource for v6.15, thanks, Ilpo!

> ---
>  drivers/pci/pci.h   | 2 ++
>  include/linux/pci.h | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..be2f43c9d3b0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -309,6 +309,8 @@ enum pci_bar_type {
>  struct device *pci_get_host_bridge_device(struct pci_dev *dev);
>  void pci_put_host_bridge_device(struct device *dev);
>  
> +unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
> +
>  int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  				int rrs_timeout);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..d788acf2686a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1455,7 +1455,6 @@ void set_pcie_port_type(struct pci_dev *pdev);
>  void set_pcie_hotplug_bridge(struct pci_dev *pdev);
>  
>  /* Functions for PCI Hotplug drivers to use */
> -unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
>  unsigned int pci_rescan_bus(struct pci_bus *bus);
>  void pci_lock_rescan_remove(void);
>  void pci_unlock_rescan_remove(void);
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 


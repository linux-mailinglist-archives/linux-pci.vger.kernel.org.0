Return-Path: <linux-pci+bounces-7070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C927E8BBA2E
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9815B21550
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92718F513;
	Sat,  4 May 2024 08:54:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385912B72;
	Sat,  4 May 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714812868; cv=none; b=Tr1L3d9GssFEVTPaktqIwk71EDoOpMYUVYKo5h6fzqvL9tlmSRvob5vkmKizE5cL2f58lNSj8ZsvjRE9i9hkxUJkJscTsftuYohOfQ/AIuAWC4WbgdfL/iqFlROelEfe+sA075dhHQLmB+fkLtrCjeJhw2mSqjRSPC+z/LaFYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714812868; c=relaxed/simple;
	bh=by3XQQG8YFnDKF4C662orwTdpQvrT8yA1UTPsBBsQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnGgzfMq3dHTNQmHvu+Og3Th2tsnYFSUaVnySATbL45HIdN7m40/xoy5JWG0L7mpo7mN4rJrsKbrOerVQhhz3VVYEP7i/WeNPSgDmM2U0FZUf8ykGEFjNewzshmunXc2jTGW2+NbD0J6BWaXcBnDDF0Pd/O1+wEdeFNAlDNZg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C42543000E447;
	Sat,  4 May 2024 10:54:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9CF6148D184; Sat,  4 May 2024 10:54:15 +0200 (CEST)
Date: Sat, 4 May 2024 10:54:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <ZjX3t1NerOlGBhzw@wunner.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>

On Fri, May 03, 2024 at 09:23:20PM +0200, Nam Cao wrote:
> If there is no bus number available for the downstream bus of the
> hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
> regardless, and the kernel crashes.
> 
> Abort if pci_hp_add_bridge() fails.
[...]
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -58,8 +58,13 @@ int pciehp_configure_device(struct controller *ctrl)
>  		goto out;
>  	}
>  
> -	for_each_pci_bridge(dev, parent)
> -		pci_hp_add_bridge(dev);
> +	for_each_pci_bridge(dev, parent) {
> +		if (pci_hp_add_bridge(dev)) {
> +			pci_stop_and_remove_bus_device(dev);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}

Is the pci_stop_and_remove_bus_device() really necessary here?
Why not just leave the bridge as is, without any child devices?

Thanks,

Lukas


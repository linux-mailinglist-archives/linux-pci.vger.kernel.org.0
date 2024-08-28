Return-Path: <linux-pci+bounces-12322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DA961D82
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEF61C21CBB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 04:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD03BBE2;
	Wed, 28 Aug 2024 04:17:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289691870;
	Wed, 28 Aug 2024 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818637; cv=none; b=EqE6FU0P2ZMPg3buhnOEAiYQ34+iuueyPOSgQjea1LtcdZmUZlcEugiQiQCSESn6kU7D+/BG1M27Lpal8sWsqgHlFM+LPJ6x6FmKGANNfxL9mtJ26tEwT/5X2kjW2XmybwZHPrXVWOUP7LnY/t/d6djPNeqHrNPaNiUnTf534/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818637; c=relaxed/simple;
	bh=uTMHCjwmujxJaDcRijqzCQt6BpZnhMoNhPLe+OHBsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLxupFDtQL8xL52A6QY1gAu6KZSES+FWqhTASDUZtZdxbD47p1tjgjzf2fHMiIJYix/Urd3ydtBl0Tq62nGF+zphL1SNLtV2VHVK52caLbBhRwESGANE6izBy4p5x2QtZl8m2qWrdJfhqOqhwuwFfHEXaycTE61T8iEUXXoXKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E524D300002D5;
	Wed, 28 Aug 2024 06:17:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C623D3AD231; Wed, 28 Aug 2024 06:17:04 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:17:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 1/3] PCI: Wait for device readiness with
 Configuration RRS
Message-ID: <Zs6kwHX7EIGvnf9_@wunner.de>
References: <20240827234848.4429-1-helgaas@kernel.org>
 <20240827234848.4429-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827234848.4429-2-helgaas@kernel.org>

On Tue, Aug 27, 2024 at 06:48:46PM -0500, Bjorn Helgaas wrote:
> @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  			return -ENOTTY;
>  		}
>  
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> -			break;
> +		if (root && root->config_crs_sv) {
> +			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +			if (!pci_bus_crs_vendor_id(id))
> +				break;

There was an effort from Amazon back in 2020/2021 to improve CRS support:

https://lore.kernel.org/linux-pci/20200307172044.29645-1-stanspas@amazon.com/

One suggestion you raised in the subsequent discussion was to use a
16-bit (word) instead of a 32-bit (dword) read of the Vendor ID
register to avoid issues with devices that don't implement CRS SV
correctly:

https://lore.kernel.org/linux-pci/20210913160745.GA1329939@bjorn-Precision-5520/

I realize that pci_bus_crs_vendor_id() masks the Device ID bits,
so probably no biggie.  Just want to make sure all lessons learned
during previous discussions on this topic are considered. :)

Thanks,

Lukas


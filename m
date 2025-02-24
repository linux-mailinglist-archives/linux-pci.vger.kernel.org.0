Return-Path: <linux-pci+bounces-22249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A1A42B31
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8177E188C629
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082B2661B7;
	Mon, 24 Feb 2025 18:20:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689A264F93;
	Mon, 24 Feb 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421219; cv=none; b=sNTQI3AqiBRUfkljMvx8i35a5HLkMg10dZAlhY/gB7fy4F9DnZB/CW1sPY/kaBGuFxNp3xToINvki7YEm6ec2dkqxYhnowBcjqL8J1aovNVuJ856GxBUh/jX9P1l2Dgfesizb4F1fOnTNk69ritpsTogol7jgEFnGpiv4g6NrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421219; c=relaxed/simple;
	bh=49xXBc1ycQecRqINlj/S10WDVEpHaLb95IwbBpWVPn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngR8V5Kt1eaP/VWNsrbDS6RKgjX8hT6w1yD8clN7JfAblSQ0PD4vKSyLac5FHcx6jnRt2BvD2/KhOd80ja5hJq4LfKM1J16WjUQ+ZfFGBmed+cqypAwOmrNGclEA7BOGQPeQeHK2ym/ZJC8jdHViZUwdz11y1JJq4ikXjRmyfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3013E3000222C;
	Mon, 24 Feb 2025 19:12:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 099015F7D2D; Mon, 24 Feb 2025 19:12:11 +0100 (CET)
Date: Mon, 24 Feb 2025 19:12:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z7y2e-EJLijQsp8D@wunner.de>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224034500.23024-3-feng.tang@linux.alibaba.com>

On Mon, Feb 24, 2025 at 11:44:58AM +0800, Feng Tang wrote:
> @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_disable_hp_interrupts_early(dev);
>  	}

Moving the Slot Control code from pciehp to portdrv (as is done in
patch 1 of this series) is hackish.  It should be avoided if at all
possible.

As I've already said before...

https://lore.kernel.org/all/Z6HYuBDP6uvE1Sf4@wunner.de/

...it seems clearing those interrupts is only necessary
in the CONFIG_HOTPLUG_PCI_PCIE=n case.  And in that case,
there is no second Slot Control write, so there is no delay
to be observed.

Hence the proper solution is to make the clearing of the
interrupts conditional on: !IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)

You keep sending new versions of these patches that do not
incorporate the feedback I provided in the above-linked e-mail.

Please re-read that e-mail and verify if the solution that
I proposed solves the problem.  That solution does not
require moving the Slot Control code from pciehp to portdrv.

Thanks,

Lukas


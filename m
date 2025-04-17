Return-Path: <linux-pci+bounces-26109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3158A91F27
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1919E7A7F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93924EAA9;
	Thu, 17 Apr 2025 14:08:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF592512D7;
	Thu, 17 Apr 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898924; cv=none; b=i0v7JQzg/ngRULqX4k4k2fDoUpO0wwN8UHHNnw175CbJyPaGUf1SyDWye9C8dHnmg/mqINblv2v+FxoEM0hQQZbTY5wfSdARZdX6kJSnPkBN3ZRx/l8pbCz6LGW8OTY8LvCL+IedZRLn1B46T9Y1ng81M4a/LWQhxt0IrfYSkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898924; c=relaxed/simple;
	bh=NpvKRT8qb3gzwy4mW7KuevNscS4HRyz37dPBTIaWGO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdY9F1+CgE+Z+WoBnJTg6srs9hnx41EqHjRiomnhdxyUW/lurxcoKEkqWw5gqbyNxi66Bscmdl3j7Unh3uwHHfoT9cI+PB2VFC6gmlCFqjSSY2k2S0Bh04087nthjBZnbM7gqKLDIbpKKfO77DYFGNWWMNhAciZB3VJKX4JcpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 62BC72C07110;
	Thu, 17 Apr 2025 16:08:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D08915D318; Thu, 17 Apr 2025 16:08:37 +0200 (CEST)
Date: Thu, 17 Apr 2025 16:08:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Replace lbms_count with
 PCIE_LINK_LBMS_SEEN flag
Message-ID: <aAELZfjCCZUE4aos@wunner.de>
References: <20250417124633.11470-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417124633.11470-1-ilpo.jarvinen@linux.intel.com>

On Thu, Apr 17, 2025 at 03:46:32PM +0300, Ilpo Järvinen wrote:
> PCIe BW controller counts LBMS assertions for the purposes of the
> Target Speed quirk. It was also a plan to expose the LBMS count through
> sysfs to allow better diagnosing link related issues. Lukas Wunner
> suggested, however, that adding a trace event would be better for
> diagnostics purposes. Leaving only Target Speed quirk as an user of the
> lbms_count.
> 
> The logic in the Target Speed quirk does not require keeping count of
> LBMS assertions but a simple flag is enough which can be placed into
> pci_dev's priv_flags. The reduced complexity allows removing
> pcie_bwctrl_lbms_rwsem.
[...]
> This will conflict with the new flags Lukas added due to the hp fixes
> but it should be simple to deal with that conflict while merging the
> topic branches.

Hm, perhaps it would be easier to merge this if it would use bit 6
instead of bit 4.  Then it would just be a trivial merge conflict
between two topic branches (pci/hotplug and pci/bwctrl, I presume).
The way it is now, it will require manually tweaking the bit after
applying the patch.

> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -557,6 +557,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  #define PCI_DPC_RECOVERED 1
>  #define PCI_DPC_RECOVERING 2
>  #define PCI_DEV_REMOVED 3
> +#define PCIE_LINK_LBMS_SEEN	4

The two newly added bits on the pci/hotplug branch use the prefix
"PCI_LINK_".  It would be slightly neater if this used the same prefix.

>  drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>  drivers/pci/pci.c                 |  2 +-
>  drivers/pci/pci.h                 | 10 ++---
>  drivers/pci/pcie/bwctrl.c         | 63 +++++++++----------------------
>  drivers/pci/quirks.c              | 10 ++---
>  5 files changed, 25 insertions(+), 62 deletions(-)

Obviously a nice, welcome simplification, shaving off 37 LoC.
Thanks for doing this!

Lukas


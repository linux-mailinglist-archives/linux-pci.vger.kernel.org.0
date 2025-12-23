Return-Path: <linux-pci+bounces-43608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE437CDA1C2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9B33016993
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDA23E355;
	Tue, 23 Dec 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFTFCDe3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF0199920;
	Tue, 23 Dec 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511121; cv=none; b=vGDrrOnySDUW3d6p/zF2E0a+cxnRNivdXHQc814iNu+t7g7PYWsGVZ8/5y+D3RRbu/uR1sJyhMkTsSwsoOafw6Av34IhW/yXzjQUWig9JtctROr4McrhxkFn4P95KyYwUSo37nR7mNF2PatCgsoNuhq+ycpWdL2VJx4cdnrvKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511121; c=relaxed/simple;
	bh=pU886dBvKNWaEjJnGJgar5XIftw1cnun54U8deT2xWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p+FhbrW82F8h/pKUVmbk850uw64DggFa4n8WtOx8X87xi740y9kboxJkMvaef4UzmHGgY+FRGpNqWCJsjb3SCtU4oTJxCSVVIANpZ+th8HHJgy5NddRneFtsiRwUn78x6E0Ko/8VqU2vWuHACnQ9tEybfKadjtUiYvzhdVFxbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFTFCDe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51AC113D0;
	Tue, 23 Dec 2025 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511118;
	bh=pU886dBvKNWaEjJnGJgar5XIftw1cnun54U8deT2xWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rFTFCDe3cKErf3OOUxm+9BBxMiCTQ+mTXmi8A7iMrXGZhAORWDgamq3jj/1RNbbW+
	 fTyyrX2R3O4nRgw3p5FLUO3k6GjoB4tetkRRsQYNxTiTpxXM+cszRTqOqWa2kWSrLB
	 KQ+1JlJ5lGNPCQhryzHh4/wC9GwWFLSVNPHocZU7ojJTzJMJx8VqxRfp0RnbJ+xA3k
	 QeuaeJD/796KO3rxDhq784DuqGV7mbQJ7WQem40cSINvaj0cCepiuwQ6uCiyWD9h3/
	 FHCJ7QiFTqqqmHKFJWCRMMISiDPCQEQRvPnePf5G59Fcp29SdhUjEbGHywkNLjqzd0
	 XK8Dyc/WjpioQ==
Date: Tue, 23 Dec 2025 11:31:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	linux-kernel@vger.kernel.org, yi1.lai@intel.com
Subject: Re: [PATCH] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <20251223173157.GA4025076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223085601.2607455-1-yilun.xu@linux.intel.com>

On Tue, Dec 23, 2025 at 04:56:01PM +0800, Xu Yilun wrote:
> The symlink name streamH.R.E is unique within a specific host bridge but
> not across the system. Error occurs e.g. when creating the first stream
> on a second host bridge:
> 
> [ 1244.034755] sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'

Drop timestamp because it's no relevant.  Indent quoted material two
spaces.

> Fix this by adding host bridge name into symlink name for TSM class
> devices. It should be OK to change the uAPI to
> /sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E since it's new and has few
> users.

Looks like this adds "pciDDDD:BB:" to one name, which is described
here and in the Documentation/ABI change.

> Internally in the IDE library, store the full name in struct pci_ide
> so TSM symlinks can use it directly, while PCI host bridge symlinks
> can skip the host bridge name to keep concise.

And shortens this name, but no example or doc update?  Or maybe the
shortening just strips the "pciDDDD:BB" to preserve the existing names
somewhere else?

I'm just confused about which symlinks are changing (adding
"pciDDDD:BB") and which are being kept concise (either by staying the
same or being shortened).

> Fixes: a4438f06b1db ("PCI/TSM: Report active IDE streams")
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tsm |  2 +-
>  drivers/pci/ide.c                         | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 6fc1a5ac6da1..eff71e42c60e 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -8,7 +8,7 @@ Description:
>  		link encryption and other device-security features coordinated
>  		through a platform tsm.
>  
> -What:		/sys/class/tsm/tsmN/streamH.R.E
> +What:		/sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E
>  Contact:	linux-pci@vger.kernel.org
>  Description:
>  		(RO) When a host bridge has established a secure connection via
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index f0ef474e1a0d..db1c7423bf39 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -425,6 +425,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>  	struct pci_ide_stream_id __sid;
>  	u8 ep_stream, rp_stream;
> +	const char *short_name;
>  	int rc;
>  
>  	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> @@ -441,13 +442,16 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  
>  	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
>  	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> -	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s:stream%d.%d.%d",
> +						   dev_name(&hb->dev),
>  						   ide->host_bridge_stream,
>  						   rp_stream, ep_stream);
>  	if (!name)
>  		return -ENOMEM;
>  
> -	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	/* Skip host bridge name in the host bridge context */
> +	short_name = name + strlen(dev_name(&hb->dev)) + 1;
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, short_name);
>  	if (rc)
>  		return rc;
>  
> @@ -471,8 +475,10 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
>  {
>  	struct pci_dev *pdev = ide->pdev;
>  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	const char *short_name;
>  
> -	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	short_name = ide->name + strlen(dev_name(&hb->dev)) + 1;
> +	sysfs_remove_link(&hb->dev.kobj, short_name);
>  	kfree(ide->name);
>  	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
>  	ide->name = NULL;
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.25.1
> 


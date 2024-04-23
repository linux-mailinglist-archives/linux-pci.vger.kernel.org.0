Return-Path: <linux-pci+bounces-6597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B48AF8C1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9454928FE39
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4616143865;
	Tue, 23 Apr 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W25NFkYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C72142E85;
	Tue, 23 Apr 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906596; cv=none; b=Z9hHoRLpr5Ak6KkSXvi3vMixaTLhUwjeR4kf4TKuOIo4psLOHQ8bT79ecGL4V4qoNZTYCKeX6DKLHVp3kl+qBqtq4VCToK3Uoqz+ZO9IO8DXBhPvt1+XckCDqUSz9KkmIKYRoFjkc26AFOhPQTGbmft0ur1/jS+TlZdapEUAsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906596; c=relaxed/simple;
	bh=FIZLwnCJ46nQbu1Ba72yWKSGnIGxieYcIGj7+JomHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DgbSB1r2sFgXC/Mns9NujlX+yhhZ4pGmev/74HaPJf/oIZ+eyyIM2aqzgywg1TKcSukkUjTAlgCPrj6XyElNJdgyJFOjB4Y6aJ8w0sVh+kuwmNpiLlVIggU9cVYKD/vrE++L5SIwejmKqmtIGcqrC2gx8zotZfYofgm9MtG0DAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W25NFkYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCCCC116B1;
	Tue, 23 Apr 2024 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713906596;
	bh=FIZLwnCJ46nQbu1Ba72yWKSGnIGxieYcIGj7+JomHgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W25NFkYBxeqYwzD6bWFyCiPs+/hDKJ5tM9c7gw7IddM2ObyMGQliK7AubkPy1bRNk
	 AacBYM457pzUWBi+TxeNgSqierSERtATQ09RfBVv/wU9KOh417QI02SAqndawIasGg
	 VFT3e5VBEqtejXS6KzchJcnzyuhMOvziWcurziITzpPs3lBh/Cqyi1eiwuGi/ZnjAM
	 xjXm5koQN0rjh+NCQ5tuH60x3b8w4Gly0YgMHGUdyP+pCn0VakdL4OYaevq5XdzcKv
	 jjs6eXn+StBMxt1YsqIHBmq4oczpBFd38T++5OYs5QoZhmwhe76AxPNihTCumo8cIu
	 Rqz+0rsXieylA==
Date: Tue, 23 Apr 2024 16:09:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
Message-ID: <20240423210954.GA467443@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116143258.483235-1-vidyas@nvidia.com>

On Tue, Jan 16, 2024 at 08:02:58PM +0530, Vidya Sagar wrote:
> The enumeration process leaves the 'Received Master Abort' bit set in
> the Secondary Status Register of the downstream port in the following
> scenarios.
> 
> (1) The device connected to the downstream port has ARI capability
>     and that makes the kernel set the 'ARI Forwarding Enable' bit in
>     the Device Control 2 Register of the downstream port. This
>     effectively makes the downstream port forward the configuration
>     requests targeting the devices downstream of it, even though they
>     don't exist in reality. It causes the downstream devices return
>     completions with UR set in the status in turn causing 'Received
>     Master Abort' bit set.
> 
>     In contrast, if the downstream device doesn't have ARI capability,
>     the 'ARI Forwarding Enable' bit in the downstream port is not set
>     and any configuration requests targeting the downstream devices
>     that don't exist are terminated (section 6.13 of PCI Express Base
>     6.0 spec) in the downstream port itself resulting in no change of
>     the 'Received Master Abort' bit.
> 
> (2) A PCIe switch is connected to the downstream port and when the
>     enumeration flow tries to explore the presence of devices that
>     don't really exist downstream of the switch, the downstream
>     port receives the completions with UR set causing the 'Received
>     Master Abort' bit set.
> 
> Clear 'Received Master Abort' bit to keep the bridge device in a clean
> state post enumeration.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied to pci/enumeration for v6.10, thanks!

I shortened the commit log because I think this happens all the time,
not just in the specific cases you mentioned above:

    PCI: Clear Secondary Status errors after enumeration

    We enumerate devices by attempting config reads to the Vendor ID of each
    possible device.  On conventional PCI, if no device responds, the read
    terminates with a Master Abort (PCI r3.0, sec 6.1).  On PCIe, the config
    read is terminated as an Unsupported Request (PCIe r6.0, sec 2.3.2,
    7.5.1.3.7).  In either case, if the read addressed a device below a bridge,
    it is logged by setting "Received Master Abort" in the bridge Secondary
    Status register.

    Clear any errors logged in the Secondary Status register after enumeration.

> ---
> V2:
> * Changed commit message based on Bjorn's feedback
> 
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 795534589b98..640d2871b061 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	}
>  
>  out:
> +	/* Clear errors in the Secondary Status Register */
> +	pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
> +
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
>  	pm_runtime_put(&dev->dev);
> -- 
> 2.25.1
> 


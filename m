Return-Path: <linux-pci+bounces-2448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28517837740
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 00:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22C01F24AAD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717C374E7;
	Mon, 22 Jan 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRB+oBBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07136B0C;
	Mon, 22 Jan 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964429; cv=none; b=RRD5So1mhtsvSlJJVQx2zU4Km7gFy/k8jOWP+MiUHR/qDqDyDC+Lv63YihR1Me5MjyweE5html1lGmM6K46Szt0HTTIPjn70rhRWszk6yoSTQ/WzKqen8tM9zApym/HHfxp3ANZyN4lvdToSRGPQx+a+Rdi3lH9fueehVKUFgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964429; c=relaxed/simple;
	bh=zSGD4Ci6DJ0vZvzDYCjqP9tLlzmLMqoKbD5SnqjHrqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z0DI7MHcdFw5gQbXbhUL9E5S/utvSDsMJ8Vt2HjZ7X7OppypKq40t+O4hXw/t1ZPc7msaTGDtQBFq3T99+jczIVTBfiV7Yt3UOSjAtKH4+S6n88oVPvOK+2wUxdbVDOLgSifMpVkNmR0Mio0cgQycqwopwB0kvxbyjvy2ChQia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRB+oBBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF4C433B2;
	Mon, 22 Jan 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705964428;
	bh=zSGD4Ci6DJ0vZvzDYCjqP9tLlzmLMqoKbD5SnqjHrqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gRB+oBBxCsHW4pSCQmACISlVPmO4dMDjO4Cn9S3dF5ck4Z+5JA2wTVILKH8FgrVcx
	 l7/QUAceIbSWIy+0kT0yfljPPAPyc060ppSh7gWfgYXJkneSPdba+05IFNidF4N/Di
	 QDmhO7bj3z2SGCHZArOWD7zJqdhnPK7LQmIPwAqSUVWx5O0JAPIItxym31M/Rroga8
	 SVsRX3svYuUggxsRUjsoisORJ/9g3J1Vj59UplZr5C7cyDkI7/ArTW5cYv/ggu0pYS
	 ZLuzY1TxFGRkmnibjxs9rDoo9P6+AkDkLkFrLf62HIv/jLWnBFDNk123yXf4SjTcBw
	 RU5aYDugc+Bbw==
Date: Mon, 22 Jan 2024 17:00:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
Message-ID: <20240122230026.GA290856@bhelgaas>
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

Are these the only possible ways this error is logged?  I expected
them to be logged when we enumerate below a Root Port that has nothing
attached, for example.

Does clearing them in pci_scan_bridge_extend() cover all ways this
error might be logged during enumeration?  I can't remember whether
all enumeration goes through this path.

> Clear 'Received Master Abort' bit to keep the bridge device in a clean
> state post enumeration.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
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


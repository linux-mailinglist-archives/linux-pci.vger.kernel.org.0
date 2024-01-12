Return-Path: <linux-pci+bounces-2121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3A82C437
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760161F2234D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDE1B5A5;
	Fri, 12 Jan 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/zzcq8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72117C78;
	Fri, 12 Jan 2024 17:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58747C433F1;
	Fri, 12 Jan 2024 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079184;
	bh=ChOHcFdSRNFjvK3N8OYYhuCgtYXFpkTyeUTD5QgblIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y/zzcq8EM1YES3DPDYMNeuSgyTK4ElDmYRAE6AbLqPcpzI0xKRqZtpTbd5s5JwYeS
	 93waMWxV8pcyAlzlU9+/kgh2wPTk6U9cNDuLFEFRFU/01mLjboHttb9ID1F9AFWGUm
	 T8849i4Ep4lio4qhfYZ+VYpyqS4YtcL8nzMNYxhqoznesU0ZW2n6j7ySLCzdqYIpBp
	 XSLixugrSd89EfkOFvKAWYgeZrkjQbdTCvCs8K9ZhNEKA9nDoqniS038QxkmkoIcxk
	 IlK+jG9xfNzJGKl2MZMEjlHZgsg4zOOzoAyZNyGymByfgjPI4LaSdd5yvMKX7MiMue
	 zGFJfuW2kb1tA==
Date: Fri, 12 Jan 2024 11:06:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: Clear errors logged in Secondary Status Register
Message-ID: <20240112170622.GA2272469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104013229.693041-1-vidyas@nvidia.com>

On Thu, Jan 04, 2024 at 07:02:29AM +0530, Vidya Sagar wrote:
> If a downstream port has a PCIe switch connected to it, the enumeration
> process leaves the 'Received Master Abort' bit set in the Secondary
> Status Register of the downstream port because of the Unsupported
> Requests (URs) take place in the downstream hierarchy. Since the
> ownership of Secondary Status Register always lies with the OS including
> systems with Firmware-First approach for error handling[1], clear the
> error status bits in the Secondary Status Register post enumeration.

I would expect these URs to happen when enumerating below *all* PCIe
Root Ports (not just when switches are present), and Master Aborts
should happen in conventional PCI.

Similarly, I don't think Firmware-First is relevant here.  Only the
fact that the OS owns PCI_SEC_STATUS because there's no mechanism to
negotiate for platform ownership of it.

We're in the merge window right now, so we'll start merging v6.9
material after v6.8-rc1 is tagged.

> [1] https://lore.kernel.org/all/1fb9d746-0695-4d19-af98-f442f31cd464@nvidia.com/T/
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 43159965e09e..edf8202465d8 100644
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


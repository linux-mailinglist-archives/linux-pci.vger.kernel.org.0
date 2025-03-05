Return-Path: <linux-pci+bounces-23018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E328A50E73
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A771116BFCB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35316266565;
	Wed,  5 Mar 2025 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvx3hYwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DB2586C3;
	Wed,  5 Mar 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213219; cv=none; b=fGfScRJkqQvWZlwi6CPnsX5u/B3nAQxUPL4DaQSPnqCfXmBHNRfKO2uEffk4ZXbRAUxVzhSzDCXa+Fc0Mo0RSrz4FWt/uX0G1kZGuJsoYXZ9MKcb8cWUGePR3UXFeaG0k6nr6Ulm9XgauGE0oPecIpjXYB8PQCKE6abBzV0XRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213219; c=relaxed/simple;
	bh=9Vd3NTCGG6rS4oIOqn+qZLQzZjw8AOh8blq9HS/31Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TNjOMIjC2oQuNWpqSA3gLUKtzWYlUWidxxSWJUr+R2EqipfbQ/h/DSOyURJ0ajmJTgB86ynfuz63Ia9DN6vaoZnv7ut9mdX23LuWgq/PgMLpG3hjBCr1663mh36X9M+hUzqz5bDd/1Ctm3c0HQ4QINFm9265l4l1LVoY5eXLO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvx3hYwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DE3C4CED1;
	Wed,  5 Mar 2025 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213218;
	bh=9Vd3NTCGG6rS4oIOqn+qZLQzZjw8AOh8blq9HS/31Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uvx3hYwq0hayfCBHEqvi0Iwc3QIe/dEAiwkM80O8sW72vN0IhEDXgLpkQA1L7fXGg
	 9aVNqPh/AFDO/Agc3YHs58DTMxC5davA3bxAWN7s57A512AedS3rayx97Na1rP3KAq
	 ex7zDoV7i6cGJbNsuz1HN1dqZe0SnmaWxFyJeaVfmjMhKBRTMgW5KvLpADWtNH4rqL
	 7yfViBzT13i6mXjwYNwBzOvzBBYofZRllNDaY3+3sz/1ZW8FmvT/yGsLyi6EjMgG6n
	 QWbRI5hDCbBW8qGlfFjbhs4iIzfG4CYr8atyeGTHMBKMnMqwGxx/Z8TZ6T/fzmc2Js
	 B0dhiHPqSTIoQ==
Date: Wed, 5 Mar 2025 16:20:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>, ChunHao Lin <hau@realtek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125
 2.5GbE Controller
Message-ID: <20250305222016.GA316198@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063035.415717-1-hans.zhang@cixtech.com>

[+cc r8169 maintainers, since upstream r8169 claims device 0x8125]

On Wed, Mar 05, 2025 at 02:30:35PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> This patch is intended to disable L0s ASPM link state for RTL8125 2.5GbE
> Controller due to the fact that it is possible to corrupt TX data when
> coming back out of L0s on some systems. This quirk uses the ASPM api to
> prevent the ASPM subsystem from re-enabling the L0s state.

Sounds like this should be a documented erratum.  Realtek folks?  Or
maybe an erratum on the other end of the link, which looks like a CIX
Root Port:

  https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001

If it's a CIX Root Port defect, it could affect devices other than
RTL8125.

> And it causes the following AER errors:
>   pcieport 0003:30:00.0: AER: Multiple Corrected error received: 0003:31:00.0
>   pcieport 0003:30:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>   pcieport 0003:30:00.0:   device [1f6c:0001] error status/mask=00001000/0000e000
>   pcieport 0003:30:00.0:    [12] Timeout
>   r8125 0003:31:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>   r8125 0003:31:00.0:   device [10ec:8125] error status/mask=00001000/0000e000
>   r8125 0003:31:00.0:    [12] Timeout
>   r8125 0003:31:00.0: AER:   Error of this Agent is reported first

Looks like a driver name of "r8125", but I don't see that upstream.
Is this an out-of-tree driver?

> And the RTL8125 website does not say that it supports L0s. It only supports
> L1 and L1ss.
> 
> RTL8125 website: https://www.realtek.com/Product/Index?id=3962

I don't think it matters what the web site says.  Apparently the
device advertises L0s support via Link Capabilities.

> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  drivers/pci/quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 82b21e34c545..5f69bb5ee3ff 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2514,6 +2514,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>  
> +/*
> + * The RTL8125 may experience data corruption issues when transitioning out
> + * of L0S. To prevent this we need to disable L0S on the PCIe link.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8125, quirk_disable_aspm_l0s);
> +
>  static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>  {
>  	pci_info(dev, "Disabling ASPM L0s/L1\n");
> 
> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
> -- 
> 2.47.1
> 


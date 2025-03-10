Return-Path: <linux-pci+bounces-23359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DCA5A354
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3B5189045C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5FB236426;
	Mon, 10 Mar 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQBHNVh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CC236424;
	Mon, 10 Mar 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632167; cv=none; b=JZQ1Wady9NT/P+2QKvUhBOTJA0Qx83XSIf4Kx19LZ6/4t4ri3J+Xc8aGCFNiz6gIoQXwRHHjlk2whccHASO/d7cHFk2Q5eMxl/TQ3vVguwJlijxq1PXvneXfS1xvvkm9nmUt+zJc/dNhaxkcEQEGZ8CMwnsoltWT1bbBjqxI8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632167; c=relaxed/simple;
	bh=YNRphFqGjgTEjPGkM9UZWxMHWivBWatGWtrbAv+KPpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q0HoLBWf+P3FbJ9INYmIGgLwM7C8Jn1+f7CZs5i85Anx0DcIxvCFHi/eoAox4brTxw44tsNJSgnXnQ3EQuOUkbpYQaQCRAn2uHSDVX61eF4o7U8DwzA0HpbrRYtBkw7nxPA6vxGE7dCH/p+ZlTVpIrc7Wj8gPftz+jRpjuAo9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQBHNVh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4835FC4CEE5;
	Mon, 10 Mar 2025 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632166;
	bh=YNRphFqGjgTEjPGkM9UZWxMHWivBWatGWtrbAv+KPpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KQBHNVh53CSM+lCS0LzWyQSBZKBHiGkE/jk2UJsVk+QTVD92y2G+Zru6GXVgB5tXp
	 IzdBoq/GUtrzLNhA676QUBbJM3T+flq/n3aTsmOuIKjvtwAM21zdwkFkIHYYw2IQ3n
	 AlwlrtKBf2xX2/7sSDR7F2F6DGbBAaeDaaKKAnA27NKXPGgYUyQS6XLFveZOhPCpqF
	 TqPpbTRIKj0ew1N/o6o1LNyhK7V5GlrF2MEqbCjCKRhY2yNF2nfV6pLEJDKaUyV5BP
	 ZiYxCPfimewtzi4iDpcYUlDrWQa6/sSMq5hc+jXClx1nPozDRluY9uBCvYLiHJY9P2
	 fUlgw/IC4eJpw==
Date: Mon, 10 Mar 2025 13:42:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Enable Configuration RRS SV early
Message-ID: <20250310184244.GA561828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303210217.199504-1-helgaas@kernel.org>

On Mon, Mar 03, 2025 at 03:02:17PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Following a reset, a Function may respond to Config Requests with Request
> Retry Status (RRS) Completion Status to indicate that it is temporarily
> unable to process the Request, but will be able to process the Request in
> the future (PCIe r6.0, sec 2.3.1).
> 
> If the Configuration RRS Software Visibility feature is enabled and a Root
> Complex receives RRS for a config read of the Vendor ID, the Root Complex
> completes the Request to the host by returning PCI_VENDOR_ID_PCI_SIG,
> 0x0001 (sec 2.3.2).
> 
> The Config RRS SV feature applies only to Root Ports and is not directly
> related to pci_scan_bridge_extend().  Move the RRS SV enable to
> set_pcie_port_type() where we handle other PCIe-specific configuration.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/enumeration for v6.15

> ---
>  drivers/pci/probe.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..0b013b196d00 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1373,8 +1373,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
>  			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
>  
> -	pci_enable_rrs_sv(dev);
> -
>  	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
>  	    !is_cardbus && !broken) {
>  		unsigned int cmax, buses;
> @@ -1615,6 +1613,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_cap = pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg = reg16;
> +
> +	type = pci_pcie_type(pdev);
> +	if (type == PCI_EXP_TYPE_ROOT_PORT)
> +		pci_enable_rrs_sv(pdev);
> +
>  	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
>  	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
>  
> @@ -1631,7 +1634,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	 * correctly so detect impossible configurations here and correct
>  	 * the port type accordingly.
>  	 */
> -	type = pci_pcie_type(pdev);
>  	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
>  		/*
>  		 * If pdev claims to be downstream port but the parent
> -- 
> 2.34.1
> 


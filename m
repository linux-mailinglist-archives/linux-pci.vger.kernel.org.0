Return-Path: <linux-pci+bounces-24413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F3A6C574
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ABC173A1A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599B2309AD;
	Fri, 21 Mar 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edTn6pjs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7D22E415
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593836; cv=none; b=qo84AgCi89FU4lobO+aS1iv7kAITBc4i/I/1xDnjoqPvcXgxhKAR4bReyZ5zsKKE1FOg6IPUOR+2G2nLBDcH9rQU7c1tARM+p1kymjiuX1hJ4g9rK6IhrgiXtO0qj1t6Qh2FIZBaTpmeHwfYqbBdbKOWAX/uhlX13T1Ib2fLchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593836; c=relaxed/simple;
	bh=gaw/X8JZTloBbUSk5XIghCbyat9lMdT1D0bFxyiYlTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e4hcg4dPQq0eEDGZ3Ak82/UxH1jejdK2RfUFgBEjw7QfK/Z1TgPLz1MV56i/ymmBs5wNZ1JvVkL8pAapG3nbnwRaqNvI1kuoL+guKh3Kq/FDEZIOQzaBtSLybW0am5kxTxyPWNSretyJnzD5ppWVr6rx/g3RwVdhJcqFBcURU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edTn6pjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209DC4CEE3;
	Fri, 21 Mar 2025 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593836;
	bh=gaw/X8JZTloBbUSk5XIghCbyat9lMdT1D0bFxyiYlTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=edTn6pjsM4ZWBjiOReZDyrpf8w9hkiLAHL+rqfr78KZ1nnaKlgxBrs17zdZx75D3q
	 LZrtEs+tnWGRssnpoljMXdMGSqF9Y9kkvv5A1MTYnYh0f3tpg4X/XEmGEn0Zn7BPuU
	 UHVksiuz1cpQZ/3MjqoB0MAEJxkBtotiiytlz9g2NsFXKNW2EPkOIQQztZYv6FAoCh
	 T6xORWlJ1JxkpYwo3FMtdlW7oZEljrHs4KTxIzuDTyPZIBA1+A32DP5uyVR7Zu47nq
	 gqOwJ+GCJ5BJBtbX52D48Cg75sMybRsCqCtYv0l9f6zvmimPrvz9S1bIkfh+S/Rw0W
	 jpFFHQDHnnexw==
Date: Fri, 21 Mar 2025 16:50:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/7] PCI: endpoint: Add intx_capable to epc_features
Message-ID: <20250321215034.GA1169728@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310111016.859445-13-cassel@kernel.org>

On Mon, Mar 10, 2025 at 12:10:21PM +0100, Niklas Cassel wrote:
> In struct pci_epc_features, an EPC driver can already specify if they
> support MSI (by setting msi_capable) and MSI-X (by setting msix_capable).
> 
> Thus, for consistency, allow an EPC driver to specify if it supports
> INTx interrupts as well (by setting intx_capable).
> 
> Since this struct is zero initialized, EPC drivers that want to claim
> INTx support will need to set intx_capable to true.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  include/linux/pci-epc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 9970ae73c8df..5872652291cc 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -232,6 +232,7 @@ struct pci_epc_features {
>  	unsigned int	linkup_notifier : 1;
>  	unsigned int	msi_capable : 1;
>  	unsigned int	msix_capable : 1;
> +	unsigned int	intx_capable : 1;

Kernel-doc warning:

  $ find include -name \*pci\* | xargs scripts/kernel-doc -none
  include/linux/pci-epc.h:239: warning: Function parameter or struct member 'intx_capable' not described in 'pci_epc_features'

I'm actually not sure why we merged this, since there's nothing in the
tree that sets intx_capable to anything other than false.  Maybe
there's something coming?

Bjorn


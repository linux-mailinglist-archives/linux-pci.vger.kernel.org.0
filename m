Return-Path: <linux-pci+bounces-18447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5B9F2192
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B07416608A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29462819;
	Sun, 15 Dec 2024 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaAHXfUx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF491634;
	Sun, 15 Dec 2024 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734221596; cv=none; b=jFQPRcSEb3cAslgi73Ws483H5eTZkLoDtExZmDzQV0KAofDGNnlcRivlXtamNXjNJQ8arjQ/fiWk9iquy46KEfT5CQepHjHL0JHmtUPBViriawP2lf7UUiVJGoNyvX45qV+MwHMQgWHFoBCgQdIINeQhnt0Cr30tejxJFEQQx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734221596; c=relaxed/simple;
	bh=GOxtTBS0yKclfTbkzcgYLXgciMLHebdnxXnJIfg8xcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lHlmEZlhACT4etaTdk/P3g5n8KW1KyM2LAkAHvURhtk52uJbIcYHBkceNqKgnb0lzxqJqMNP8XOirr+7BLGqYiHmNpGAXzo/q1TRrL1+DTytAfzL8nmClbKSr0KFWpZXzTb+6hcrJ/DJMfEUd1ctIcawgTytzNVoBG42TB3QoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaAHXfUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B0C4CED1;
	Sun, 15 Dec 2024 00:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734221595;
	bh=GOxtTBS0yKclfTbkzcgYLXgciMLHebdnxXnJIfg8xcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NaAHXfUxtGgsVp/1JftfM7ApkQteOqXoL2wa03UIRyoj/IR73gVRkAlwX7G9U3OJ5
	 MMsifXAJYwgTDk0gsii651oZgcaCFC44EqspBdwzFAzb2QIrqOAI4WU0fSgGa5vn1Y
	 WQLZ6tsgEjqDd6ozo464Mm0NJs6dSnkmUdzxbwfYPjK0NbiJ7v52ayDeVXDCHwVQ7n
	 AyjftSVb9Od6MXYucJRp5Ieu66iQWoI5m7M+yvoK6xIa67T8xze8E5Yg6ZeTKWWGpQ
	 yTPHLyOAdwj3KGo0VFcMwM7b5eKaBUhdljM6uP4/2yFiV+fzrauxya4aCYu3+0UXmx
	 Ms4+0Tv3AGipg==
Date: Sat, 14 Dec 2024 18:13:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 13/14] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
Message-ID: <20241215001313.GA3482864@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015849.190271-14-dlemoal@kernel.org>

On Thu, Oct 17, 2024 at 10:58:48AM +0900, Damien Le Moal wrote:
> Currently, the Rockchip PCIe endpoint controller driver does not handle
> the PERST# signal, which prevents detecting when link training should
> actually be started or if the host resets the device. This however can
> be supported using the controller reset_gpios property set as an input
> GPIO for endpoint mode.

> @@ -50,6 +51,9 @@ struct rockchip_pcie_ep {
>  	u64			irq_pci_addr;
>  	u8			irq_pci_fn;
>  	u8			irq_pending;
> +	int			perst_irq;
> +	bool			perst_asserted;
> +	bool			link_up;
>  	struct delayed_work	link_training;
>  };

I should have caught this last cycle, but just noticed this:

  $ make W=1 -k drivers/pci/ drivers/misc/pci_*
  ...
    CC      drivers/pci/controller/pcie-rockchip-ep.o
  drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
  drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
  drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
  drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'


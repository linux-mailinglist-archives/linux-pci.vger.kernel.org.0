Return-Path: <linux-pci+bounces-43836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19615CE9523
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 550BE3002BAA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4C279792;
	Tue, 30 Dec 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggqtloqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA72737F2;
	Tue, 30 Dec 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089656; cv=none; b=Ae7KM2lejjnIs43RGd1TGrcLzinJBQlpaQaAxVf2kwyI9T+wna41l+/99TXpFm/SXLQgfKJPaRFz8ZO4eQjHc4wu0bSbID/rZozhYVXrFjcyPUTjO4M0pNhxcFymMtx8VHIbctGYBaq4jG5e8gK4LiliB3LqQ+wDbKSkMUrc/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089656; c=relaxed/simple;
	bh=Caci6saiVAb+HvtzJHAbyeQq5WFsqlhsTwR5cy1cZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE3XvArxOChqDkNm7wGRZt+/ErqM1h4pk0lAJ2jY7DqZvItWYkMGiamrZZM8wXdranKvZvpmn2Uedx+gF7Utcbnj6/2jG+kjE1AZ1U/GnTEM/w7qODbxHstLjCnNIPdCfsS8p8da4L4gx0bdwvEnMyFDigfJYLbfbkzwa5LLZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggqtloqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BC8C4CEFB;
	Tue, 30 Dec 2025 10:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767089656;
	bh=Caci6saiVAb+HvtzJHAbyeQq5WFsqlhsTwR5cy1cZ88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgqtloqwQpYOstMbM/OQEP/BH6DDA/vpcGRA5le0/zyfMKUxErS2rx1yGo9m/PxRC
	 MUjrSLl5AqGmYMS4FxjzggbrNw7zSxcTDIK4HZvnKErHrIZ1GNaLGt93Z7tzR2V8VD
	 53WLcwF4EFuqTmyUtuUhd3dXAnUzQ2lOfw+eLIdHuXj6UGLc2bMESE6DL0q0Jb5a0c
	 KhCYEz+hiIqpvp+0/hqYH/RaN5cb85sC7LadNBBSyCSh7F+02VtIZGU5umhFb+GrCn
	 TJD7i+76tJxndoz9XY5D1OMc/aLe6EVLqTd9AZsMa2NxXHgoR7rld44AQCvxTRbhWy
	 nDG67YabVwpnw==
Date: Tue, 30 Dec 2025 11:14:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/6] Revert "PCI: dw-rockchip: Don't wait for link
 since we can detect Link Up"
Message-ID: <aVOl8mfKiYX51gRL@ryzen>
References: <20251222064207.3246632-9-cassel@kernel.org>
 <20251226223159.GA4143516@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226223159.GA4143516@bhelgaas>

Hello Bjorn,

On Fri, Dec 26, 2025 at 04:31:59PM -0600, Bjorn Helgaas wrote:
> > The long term plan is to migrate this driver to the pwrctrl framework,
> > once it adds proper support for powering up and enumerating PCIe switches.
> 
> "Proper" is hiding some important details here.  pwrctrl already
> supports powering up and enumerating switches.  I think this refers to
> [1], where Mani says the plan is for pwrctrl to power up everything
> before the initial bus scan so we can figure out how many buses are
> needed.
> 
> [1] https://lore.kernel.org/linux-pci/fle74skju2rorxmfdvosmeyrx3g75rysuszov5ofvde2exj4ir@3kfjyfyhczmn/

Correct.

This series has already been merged to the pci/controller/dwc branch
(although for some reason this branch is not merged to pci/next yet),
and I can see that Mani have rephrased the commit messages to be more
specific and to avoid the word proper.

Please tell me if there is some futher action needed from my part.


Kind regards,
Niklas


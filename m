Return-Path: <linux-pci+bounces-22201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4248A42091
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B41189D28D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470A248897;
	Mon, 24 Feb 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMWrqEzA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA8248895
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403518; cv=none; b=BKqtHYDV/2QfPUdcdhNkUinqo8h8oX12K/7s/sHkDUhJvxMi2WNcSzFKi3RJ8Q9vuCjH+5aFnLUHLhKOdia+MJC39cEhbH1LGdWzAhYiNXPEiALb3d/Xhxmt3h1ffg5pvhi0VQRZ6WvR9H2J3cMedHhdBvkRpWs+MYlDMSLkmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403518; c=relaxed/simple;
	bh=f+jBt+UvFyvGfIi7pwNF4JHGl+j9HQh83qu4Pr478C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnmeGbhCzkG8yoqL5ELG7jz/5s6vIidJSzSH+TqfnQxa/WKXq0LK8iaoq2ZrZ3/RDEGYRQPcXO3merzJX2/XcOADSE/D6B7OsThTbTRfqoWOQiaQC84q68v6UUGA4vwe6J3SY4mYMPTQetaX4sXm6SmaoCCfasBWtFumEW7ZH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMWrqEzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F8AC4CED6;
	Mon, 24 Feb 2025 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403518;
	bh=f+jBt+UvFyvGfIi7pwNF4JHGl+j9HQh83qu4Pr478C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMWrqEzAHvZJffPZSCNHQ6acoLPYC6xRUQ4vAL4zuKgxVwnfWqpuanxhRLGdMkIr+
	 qlpLTszzAVgKj1g/bTqR2MfQ+qkwjuJeBmf7UXVcP0EOAnts1Tks1sBvNo9/TSvXrK
	 7tbcEEFgYMdqyhBNJlix0y+Lx9IGwbybWAC/0EoYi1YGWe87AJjhywmRQ4KafsDV91
	 FmR9X9I2OwVJMzAqa+sR1wDvnVB5KDDO08IGzest7KuwwCJ5fYCWI6R5ofn5BmJ9CS
	 Hkik4ks7EpihAwEnJBRQeDB3IOZ/cjmE8A/InJSnF2xh7c/8Wp4qmcpgHVBu3nnviw
	 0HnQraZ9nYLGA==
Date: Mon, 24 Feb 2025 14:25:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Remove superfluous function
 dw_pcie_ep_find_ext_capability()
Message-ID: <Z7xzOSBgSeHrk4xP@ryzen>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250222155002.lnig57ku6treeznz@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222155002.lnig57ku6treeznz@thinkpad>

On Sat, Feb 22, 2025 at 09:20:02PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 21, 2025 at 09:26:47PM +0100, Niklas Cassel wrote:
> > Remove the superfluous function dw_pcie_ep_find_ext_capability(), as it is
> > virtually identical to dw_pcie_find_ext_capability().
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I will be busy so will probably not have time to resin this for 1-2 weeks.

Perhaps patch 1/2 in this series could be picked up in the meantime, since
it really has nothing to do with patch 2/2.


Kind regards,
Niklas


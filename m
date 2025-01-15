Return-Path: <linux-pci+bounces-19928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB6A12DAD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA673A4BBC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247A1DA62E;
	Wed, 15 Jan 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLTsSBZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94214D599;
	Wed, 15 Jan 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976560; cv=none; b=PP/wEmZcHheeP1ra10twVmBNEk0npIXXGuSVAbrq+150TDFVxmniUkb0kNcwNJlflH49y+qulR2BguUG/DQUTXtfgc/8KsLV5PwbYVsWApMTsr9pX47Y14aDcY+6Ysbu8mb+V0mul05gyK6LDzeNpAXCmWxCP3ApNiZ+IQKjgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976560; c=relaxed/simple;
	bh=Q0R9yzx2IdDjM84ZdIhit3Ub3eTS5HNerUhf13EGlHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i02IkrHRkC5RwIrGEaQWgrllFKK1EvD1W2CjRB1idWSzdi8Buoiasav8GTXRj34x90v07lyf5SC815z4Q3gccORfBsHR+iPqQO3Kn6bYKTf3Q+2av/dAgE7r+gtQjVuCsq0nGg8wBSqAsRuV6fRZiJwz4V/wPkGpGpfcn+qXPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLTsSBZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A6BC4CED1;
	Wed, 15 Jan 2025 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976560;
	bh=Q0R9yzx2IdDjM84ZdIhit3Ub3eTS5HNerUhf13EGlHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sLTsSBZY8I41548whX0cnkjIV5sreItAraP2dYpE1APrWd5dQpMNOgR6zperJ66Xu
	 b0b1E4beNO3X97HrGqpdjtUWgVz7nl8pIsYZBnuqfQsW9egAXGGngsfHGB6hNoewcO
	 bC5ySvxTKyVgyVQHK42z4N7kOAfh0jTc84XAItT+BjepykdjjN8ZgMUTbkpvEBMwe2
	 L2pMOEDnNBaLdtHU3DusdJlRRaE03tdBXNpTExnhYO20dm+NGoBB9z2+btkXaa/PRN
	 XmQ29JRMIaGM1fe8FoKaW4Lu5yppkNz9VFyaY5UtGY1YKOGnk+RRO8iotcVAhgmQtr
	 rJmqGGkAlMkpA==
Date: Wed, 15 Jan 2025 15:29:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI: Simplify bus range parsing
Message-ID: <20250115212918.GA555721@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113231557.441289-1-helgaas@kernel.org>

On Mon, Jan 13, 2025 at 05:15:53PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Unexport of_pci_parse_bus_range() since it's only used in drivers/pci/of.c.
> 
> Drop the "No bus range found" message since host bridges typically lead to
> [bus 00-ff], and we already default to that if there is no "bus-range" DT
> property, so there's no point in requiring it in DT or complaining if it's
> not there.
> 
> Drop bus range parameters from devm_of_pci_get_host_bridge_resources()
> since they're always the same values.
> 
> Update a sparc comment that referred to of_pci_get_host_bridge_resources(),
> which no longer exists.
> 
> Bjorn Helgaas (4):
>   PCI: Unexport of_pci_parse_bus_range()
>   PCI: of: Drop 'No bus range found' message
>   PCI: of: Simplify devm_of_pci_get_host_bridge_resources() interface
>   sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()
> 
>  arch/sparc/kernel/pci_common.c |  2 +-
>  drivers/pci/of.c               | 22 ++++++++++------------
>  drivers/pci/pci.h              |  7 -------
>  3 files changed, 11 insertions(+), 20 deletions(-)

Applied to pci/of for v6.14.

> Changes since v1
> (https://lore.kernel.org/r/20250103213129.5182-1-helgaas@kernel.org):
>   - Fix compile error
>   - Drop 'No bus range found' message
>   - Add Ack from Andreas for the sparc/PCI comment update
>   - Add Reviewed-by from Rob for the unexport patch


Return-Path: <linux-pci+bounces-25841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDEAA885AC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117F1563F1D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8A28DF0B;
	Mon, 14 Apr 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQlh+xJk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDD28936A
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640107; cv=none; b=KtoqoxY+u/A/JQBrOAZGx5OdWUgJiBu+rzkyiiBdE0mRJS3jtrl8SpoNH8ZMEJ9q8W9oq04vuZkQsesgA/3G/G9tx1IqrO6bENl6NC/4D6G3XCxmyUyZijms9PCSWg6PFagst0fUCjgydm0Xgv85MjAQEB2jUPcdiMXaQf4ffJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640107; c=relaxed/simple;
	bh=N59mWOOmWYHFDa9wgd8r2eaYDiBQILRhojph9hULj9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxdUh/PsxkiPXs4yzv+Kuri6I5kY3J/KXBYRMWRS2gUOHxafW6TipVfNaSO4UJlePVmSqCjI0V6tcFRzUMogfuoLF6Kdst6/h10PRLIHCBTuaOEdOsMG5KIo8ytg3VaKmJNvCCPXku1WW9whgz8J5ztKgfIbZl+4V01N5K/Sxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQlh+xJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3455FC4CEE2;
	Mon, 14 Apr 2025 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640106;
	bh=N59mWOOmWYHFDa9wgd8r2eaYDiBQILRhojph9hULj9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQlh+xJkLK8zR2EKzmrKEhYIjgvdIUwlT7vbz19lC+HCBa3zRIOisBtf7SPvAHeCh
	 8+t45kJAbu3enKP1KBM/giIp6BWaJyQemD99BGFoZCyh6wNieD8UY+akHZIz+UOASt
	 jQrqDu2Ul3VO2djOxYKUBCIc666Jk7x1inTG0XH7Fg/qeerBnlANQXj7quV1rB6yq3
	 qVGD66K5IEHaNI0yjnGyv/AMlkXRSCGzBTpMmrcBWe67zeZE9+ctL9yKQyxvcqxLcw
	 Ta3gTCxbmo7xz6/EylwdeolbOQJvRbLr8RER2YRk1HsUvNzSVkQt30r2Q5LLi+rvbq
	 AQOMsSepFwC6A==
Date: Mon, 14 Apr 2025 16:15:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Enable L0S capability
Message-ID: <Z_0YZnJUiJdffqtA@ryzen>
References: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>

On Mon, Apr 14, 2025 at 09:27:31AM +0800, Shawn Lin wrote:
> L0S capability isn't enabled on all SoCs by default, so enabling it
> in order to make ASPM L0S work on Rockchip platforms. We have been
> testing it for quite a long time and found the default FTS number
> provided by DWC core doesn't work stable and make LTSSM switch between
> L0S and Recovery, leading to long exit latency, even fail to link sometimes.
> So override it to the max 255 which seems work fine under test for both PHYs
> used by Rockchip platforms.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>


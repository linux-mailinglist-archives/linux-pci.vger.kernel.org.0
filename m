Return-Path: <linux-pci+bounces-41990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD2C828E0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A393AEA88
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2032E6BA;
	Mon, 24 Nov 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga8QXg8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143A2F363C;
	Mon, 24 Nov 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020379; cv=none; b=I6xzbNgRv6gvzPxbcpsgVN34y7zLYkFkC0oAeycRMwLOQ/s2OXwts+EloB6QpSzzfD08Szose+kSGlRJLEvmZX9gWlDDpZSQPPBZ/h1tCKWQLJPApRN31zgfoAnVoLc4iiNtLpQVB69TafCe/a56gT5UTVnS3ahWyEoBTVU+tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020379; c=relaxed/simple;
	bh=Mn992qsllYM14Z14kmIBgsP6C2fYWqJdQ1/Gpx4Iyyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fr/VgQTwOlaNOapwTXUEYjNu5W5gQv0ErF3KBo2HbO2Q5w9FTKR4FCMel1tQhajvon4Ebt6hag9ZqgKS20s3t9yB+15qh8wPizJcGPJBZcLtGqiXLO8pPuhxyYu4FZ60gwuf8vmc3kSKfmC+iICwO6dHzQ6wRCMD/e7ROqPP7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga8QXg8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2FC4CEF1;
	Mon, 24 Nov 2025 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020379;
	bh=Mn992qsllYM14Z14kmIBgsP6C2fYWqJdQ1/Gpx4Iyyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ga8QXg8YOYS8Qs3xO3wgPfADlTRyQ1B/+l8yCHt29FqdM6eAcgacAxTDy7qrTvXGv
	 bS5/LRb3eLuW5ap09C6K/IiMG459WuusAZqzIBUrsa8yv99TqdXsLeMwu7oVmq21cO
	 ZNaTfZsYeUJJwiTLwteONBzZZwlHjaZxAPaZzdlJWuB1V6EgZNALiYwiuYZ68A45tX
	 Xbcn5oQeY9N/M/eejrGYzCoG47uNN7bXFcdgqckX8S9ypi9I+GfLohzedOjd+KJS+a
	 Fhe3VgYziSE/yaYUyxQrNqHnA1A/XgQzu8QWoVjGOcdEJoRAaK/ChSW+0/2PwHvKDg
	 8EVTGtCROVnRA==
Date: Mon, 24 Nov 2025 15:39:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: host-generic: Move bridge allocation outside of
 pci_host_common_init()
Message-ID: <20251124213937.GA2716196@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120113630.2036078-1-maz@kernel.org>

On Thu, Nov 20, 2025 at 11:36:30AM +0000, Marc Zyngier wrote:
> Having the host bridge allocation inside pci_host_common_init() results
> in a lot of complexity in the pcie-apple driver (the only direct user
> of this function outside of code PCI code).
> 
> It forces the allocation of driver-specific tracking structures outside
> of the bridge allocation, which in turns requires it to use inneficient
> data structures to match the bridge and the private structre as needed.

Nits since you plan to repost:

s/in turns/in turn/ (maybe a British/American idiom difference?)
s/inneficient/inefficient/
s/structre/structure/

> Instead, let the bridge structure be passed to pci_host_common_init(),
> allowing the driver to allocate it together with the private data,
> as it is usually intended. The driver can then retrieve the bridge
> via the owning device attached to the PCI config window structure.
> This allows the pcie-apple driver to be significantly simplified.

Nice simplification, thanks for doing this!

Bjorn


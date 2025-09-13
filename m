Return-Path: <linux-pci+bounces-36082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDEB55EF6
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 08:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4765F583C31
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873B2E6CB4;
	Sat, 13 Sep 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsrAUWQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708315D1
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744944; cv=none; b=lfunVg1sJHJBma4tvVFknjbj5qxsjamql8cVgm0C7QUK/qJIDaacsygGNhrnFwI+na6OtFpJftVR7jSJYMXQlZqAzTmijO/mTCH8WUm0SpqPiUUL3bz0QYHx4OhjZ+TwJ9ClEleaPgdXQ3IdY9UJqQHTbmt7Yk/hlPUSDbSrULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744944; c=relaxed/simple;
	bh=+tGRqPU3CNM5AXx6swpVf+YLcfPRrzMt5yM2nz195Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRZsJkCGsu4WyvYFakiytd2immDSdpkCMr5xVwVb/nnSKPN8Vl9Z/029h4+faF98zqgTF0fmHZp/kY/ZKUCYwDe6JW9nMy8OTlrDN832HG5ItsgpQ49i4ESLdYmipqlBTPN8QD4sHiH5hSI1ANWM2jafFak5Gol68s+xkcPb/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsrAUWQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D18EC4CEEB;
	Sat, 13 Sep 2025 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757744943;
	bh=+tGRqPU3CNM5AXx6swpVf+YLcfPRrzMt5yM2nz195Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsrAUWQ5x27t0yJLkZ7m1D3JqoHfyeaDLsjFBnDVW3bzqSjOb1DZ6ihKNKIkgkg6y
	 6B2UxUTbw/LWHoVBVBNul/C6r2kBK2q0f231seGRir3qll789POswl6n3I+anxvgzJ
	 0OekBfz7qxjLKKdYhfP8kGpPOvl0/MyiymgaC20lNpypYhfb+qHEH8ioTaNDBT3Z5c
	 FbDxg+NA2iXQWgqwqUuIjI6aBELC4VoV6p/T9M0MoaQh7E7dg/ZlQHGYz+l7AGeTAl
	 o4gbpGvxh0nlLt3eYOza4a3MMb3ciRpftwogO95UDyv+R0ppTCfVyY1P0TG8vRpqw0
	 FWXqKCOKAnv3A==
Date: Sat, 13 Sep 2025 15:29:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Message-ID: <20250913062901.GC1992308@rocinante>
References: <20250913054815.141503-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250913054815.141503-1-shinichiro.kawasaki@wdc.com>

Hello,

> When endpoint controller driver is immature, the fields dma_chan_tx and
> dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> initialization. However, pci_epf_test_clean_dma_chan() assumes that they
> are always non-NULL valid values, and causes kernel panic when the

Simply saying that the fields can be NULL, which can lead to a panic on
access in some cases, and hence it's prudent to check for the non-NULL
values, would be sufficient.

Wording-wise, whether the driver is immature, mature, or middle-aged, it's
completely irrelevant here.

Otherwise, changes look good, as such:

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you,

	Krzysztof


Return-Path: <linux-pci+bounces-33940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED868B249A5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BAB7A9C1B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9112E0B5C;
	Wed, 13 Aug 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On55YdP8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954382D9ECC;
	Wed, 13 Aug 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088949; cv=none; b=AKW5ISgnNqqd70wMgXzGpqKGW7eHtORDTJ5kypSvBZmxpPZe2/lXuqXwjQovJOOU9+WQufEY4GWVgNOh9VhZVJFWYZEhNRc/5PHEUn/hPwgP3KZlEaAI6IYBiWD0RwhSheebci9p8qXmqEZKSjtwO/nJ1prf6OTWe4yOqGmlEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088949; c=relaxed/simple;
	bh=xP7ntQZYFxDDcd4ELFoAFkis6twZtrBEioZreOWlOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVklkeGu5lFfHg1jcxx47s06H6R75dp+wCm5boCnUq3SwlNiuJoRiTx9Of86T5PMtgYoc58t3SWOiVPcvePIhksdRP56acSG3eRHBOn9enPG336VhQdtTIPlDbveGQwxERV0nItpUBmdU/lrOkr8JyPW3ru0u1sOlG6JXRXrWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On55YdP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6E1C4CEEB;
	Wed, 13 Aug 2025 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088949;
	bh=xP7ntQZYFxDDcd4ELFoAFkis6twZtrBEioZreOWlOO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On55YdP8xBGxXiG0h3+ieSi//EnMc12FwKlfKErdvgj0u4/AHCRQRi7Ys5Xm1nFY9
	 WAkeW8AocEWyRHfBfZrT0Ne06SLXog6qKFIRJvnkLVV7texQaiHiCmFpcFKu6rTk33
	 gDRisf6bPZh0doJRF8i5OvGle7wiKH8jI5BuabBHWAG9UoVV2nGSAGdoc82UN3dzhq
	 HuZmQ9mYLuaqb1D76STC3d0cIR/mdnDCBx2BfBw1W9ifpIGOEhRAxYUzogWwSZfPAA
	 8tWrwakkTxIT/vDDmJ2CaDKNkkBXA9SBIWzg5rTWdFtAbwqiRnWzlEZEubCM8guZa3
	 SwuDLF4jRjMpA==
Date: Wed, 13 Aug 2025 14:42:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
Message-ID: <aJyILhOnXDJB4GgD@ryzen>
References: <20250620155507.1022099-1-18255117159@163.com>
 <aHdXwr-UZz6jZX3f@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHdXwr-UZz6jZX3f@ryzen>

On Wed, Jul 16, 2025 at 09:41:54AM +0200, Niklas Cassel wrote:
> On Fri, Jun 20, 2025 at 11:55:05PM +0800, Hans Zhang wrote:
> (snip)
> > ---
> > 
> > Hans Zhang (2):
> >   PCI: Configure root port MPS during host probing
> >   PCI: dwc: Remove redundant MPS configuration
> > 
> >  drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
> >  drivers/pci/probe.c                    | 10 ++++++++++
> >  2 files changed, 10 insertions(+), 17 deletions(-)
> > 
> > 
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > -- 
> > 2.25.1
> > 
> 
> Any chance of this series getting picked up?

Gentle ping.


Kind regards,
Niklas


Return-Path: <linux-pci+bounces-27525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7FAB1D5B
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 21:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AC23A5379
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27225DB18;
	Fri,  9 May 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvAKp9bv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623F153BD9;
	Fri,  9 May 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819369; cv=none; b=pUTofqox9nQteU3KpiNm/mWWzaQMGeYvu95vK6kQze/G80qyO3+yaUoLCpSy4NUrpMUO/7gBjiEwwgYCfFgzIAGtZSwOnbBLR0QbVm9EygciuLoj1XRouYq5RoCbs4xBFNc3pkszMypcpiZw1ehaDQz/aBr0hPy3+A/tKqzIiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819369; c=relaxed/simple;
	bh=2wr73b/j+3h7jOVG9AtnBt3hTUmdy8M2hdaX+BsWRcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecTskbSDflQgae6kGuQKHVS3tgK9FjqpZ6pU7XYczVH2CqPLTMMACIUXO/PgkBeeIIDoMOKmeWRBi8LNaVW/++N6yr2ebFTBsmkz218enSJd96SJOAIuYizfPmMzvb9nQ/yna4I7FMcLBKYOg0SmTYM/lDrxa/XG6GfFZl6HkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvAKp9bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7BBC4CEE4;
	Fri,  9 May 2025 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746819369;
	bh=2wr73b/j+3h7jOVG9AtnBt3hTUmdy8M2hdaX+BsWRcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvAKp9bv0AgWLH7iSUSO9ihmi7WU9Z1bJN6V5jo/LsF+m/Lb48pD22un9TgooryDf
	 MLlSlljtHnodVuOkAIufYZ/oYaoLjyuLEJguvu/IDiD9wiYqhVbsqoXnPLZ3yhQ83T
	 2rgwpN3Uqi2AqxunIakoBjHmmyUPyO3SM+YLRcuCrOCK08+qVXZifRBXD8MxDJDY5C
	 5Jz8aJoHV4e7p3/pmObraHdkbRttQFITyotyMmg+zy82k+hvjv9Dc+Phxg6PAedi83
	 eCiAZ55Sooc5JNUepHMlacNxJp9swkUKlFW1eVKptmvrZfEW526BZNXu4/QCEI29iD
	 QDZxb5mKofC3A==
Date: Fri, 9 May 2025 14:36:07 -0500
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, saravanak@google.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 3/8] of/irq: Export of_irq_count()
Message-ID: <20250509193607.GA4076274-robh@kernel.org>
References: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
 <20250430103236.3511989-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430103236.3511989-4-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 30, 2025 at 01:32:31PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Export of_irq_count() to be able to use it in modules.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

Already have a similar patch pending.

Rob

[1] https://lore.kernel.org/all/20250331230034.806124-2-willmcvicker@google.com/


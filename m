Return-Path: <linux-pci+bounces-24999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E054FA76150
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268451889329
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687141D5ADE;
	Mon, 31 Mar 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0MVxr7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED11D54E2;
	Mon, 31 Mar 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409209; cv=none; b=CMcWJLNnWC3FNxS5rM+pV+DNBHZ0IWyYytl3GdI/gZ4k65aMS8pR1wTcyoOJPMwJcMxsZBX9jN/nbtU3fvpfC4eNwm0MJGGuWXyDFuK703IskLQniY90v/iko/ruJJGK7DoOmjHlOTEcZIQb1nfLVg2+DiLKqkyefjkuBswv9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409209; c=relaxed/simple;
	bh=VXxFxHZK8YI/P4GsKu4JzltWluQVJHCyC/qX/kW2Ars=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9neYPKYezvPDp2wE06f5OLgBmBJJ6VzN/sXBpI2mSFLCX44wKImkwjTlEXc2NWVLFV/bsq0p1ljIujELUmVXHrmeN2h14jJHQ49AV//zG8r2n9Joh57wIrNXTOu7lN1FYLpNRVEUHhKWT7Hc1ZlZAG9sfXF3vZwYxfH6v93/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0MVxr7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27FBC4CEE5;
	Mon, 31 Mar 2025 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743409208;
	bh=VXxFxHZK8YI/P4GsKu4JzltWluQVJHCyC/qX/kW2Ars=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0MVxr7SWsGz09FCeo/mbZGUhEy6sE2B7F9J2KGvWnhNIlbWWYcHVbD5Nd8Q0DMjX
	 CPBJbyVVCgnV6rKqWVtdNsdW/RMY+E0lFLdSKZUsAzNUtbGfaPzaMw+FqwIyJX61TZ
	 0FNqyOdxR/dmCwafSGrvqy56cCT44gq2xpJ7imhRdmoJiryrbW6o9sWfi/d9AH4SO5
	 K+rcq6YXWm/efJo29pN1aEvptRNAwsRzy01L/8uR4ATaWWXyXuFO0p40FI4opcnJfH
	 oxbCT2j0hLvXDRS8Nbq/H2Dg6ftAUO9pfHExgEotQuvQdLzg8FD2MJcuRuZZRzEVO+
	 do5JrglvID+uw==
Date: Mon, 31 Mar 2025 10:20:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: vendor-prefixes: Add Retronix
 Technology Inc.
Message-ID: <20250331-logical-furry-rhino-04acf3@krzk-bin>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <20250330195715.332106-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250330195715.332106-3-marek.vasut+renesas@mailbox.org>

On Sun, Mar 30, 2025 at 09:56:10PM +0200, Marek Vasut wrote:
> Add vendor prefix for Retronix Technology Inc.
> https://www.retronix.com.tw/en/about.html
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



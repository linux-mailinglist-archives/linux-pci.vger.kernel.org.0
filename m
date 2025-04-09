Return-Path: <linux-pci+bounces-25543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA572A81F71
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6396F8A7815
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553325A652;
	Wed,  9 Apr 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGFDyZu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DA25A64B
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186049; cv=none; b=MWGe+h7x960N6+W7CPaCW0UmxuJtTEO8ONCpAUuBjuPY4rX2+81G3ybvZyD+6kg54I7rBfdN9wIl4tIgAq3qiuZlcTrYpsU/+DHZ7v4348MBDcICqLmf1DdeaK1R/dxXvbEFLcE4Q+uXmrmzujjZfAie3mztqxqerq/PlpOK0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186049; c=relaxed/simple;
	bh=tNluW/24rMyIOMJea3X50pjI8OCgeby0BZTQU82vJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXIce/slRRUsMFqEXr0Nl/GtyoD65fGa1ZP8iQhl89jzYBLKuUD9MHlzhm8RLEtR9Y2ye32ABQ0QEN7dtZLM0OzZN9vgTC16zQNXIBtR7Q9ZSNswlSE6JaEDkjkTyFBM6SWiNSEZZxQwwP4oXZJoYb2nHKGTUBYeyCvB1n6jJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGFDyZu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50C5C4CEE3;
	Wed,  9 Apr 2025 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744186048;
	bh=tNluW/24rMyIOMJea3X50pjI8OCgeby0BZTQU82vJ6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGFDyZu7YseIGrQ53Az9pAzLGJPuaIdJwrezIAZP5Z9wBzSFDJOs7+SbLGXGCZaIu
	 AYR1O0yryExF++M8usY8FwBv7yowUMl0VLx7NA4japM40ZJw8rsOT7rNz35MgWMGoP
	 hEp+xBBViqq2ygD7/e4Mb9meqdtGCKHM7SkrusB1nA6VNGGgqp/EesazTAg6KMi1BA
	 l1I42dCpFg1OEQqqkHtectPSNUVjKE2iZ5HIco9txeMw/p+I6LMKi27H1Pbc3phCme
	 YlrTEanoEKExCPLsmBc76UhisYK/4X3udbQkh0nmcgR6P04MjQC+JWL74ZGk4WJ9NL
	 aVj3+f1M0qq/Q==
Date: Wed, 9 Apr 2025 10:07:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip-ep: Mark RK3399 as intx_capable
Message-ID: <Z_Yqu83HCb_bYKIL@ryzen>
References: <20250326200115.3804380-2-cassel@kernel.org>
 <20250328122123.GA1187318@rocinante>
 <20250328123614.GA1188225@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328123614.GA1188225@rocinante>

Hello Krzysztof,

On Fri, Mar 28, 2025 at 09:36:14PM +0900, Krzysztof Wilczyński wrote:
> 
> That said, Bjorn is preparing this Pull Request, this might not make the
> cut at this time.

-rc1 is out.

Any chance to get this queued up now? (So that it doesn't get lost.)


Kind regards,
Niklas


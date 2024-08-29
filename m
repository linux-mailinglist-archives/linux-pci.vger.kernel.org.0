Return-Path: <linux-pci+bounces-12407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C409963B12
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B63287171
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BF132103;
	Thu, 29 Aug 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6CCYQ/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCD249EB;
	Thu, 29 Aug 2024 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911950; cv=none; b=DokQklX+3Fym79f064JQOi8Vm58t9qwufTBPM1Pg99W5XeqFoZku+ZYNuzSX5UAj3nPlsQklEXq9lidq8E5w9YqZHi5ADSHZ4Hgvy2LGDVVDRoN+vvSikIS8av/E193RE0ig4feMeUYvTZFKGDodKb9wNpnS6VVVlzh4STyqA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911950; c=relaxed/simple;
	bh=fUh+gganf82ip2dJ2Nztr6H7Y6AvMJX0ZtDoyTs9tPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0/3twIRo+TUVT/18gPS/7IgK6k9MaZoux1zIP9e/hZa34iZIv2CZHmS22wg9kkvL+MaoBZ56nWAVLo65WACyZoP6CW7D/y+HdKQJySlJ0bh7mH2/PeK4vPbI9FactgG0t4qFjAp5+7Jtp2Weq00xPC094dTtchFzcXMS3NNXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6CCYQ/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC3C4CEC1;
	Thu, 29 Aug 2024 06:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724911950;
	bh=fUh+gganf82ip2dJ2Nztr6H7Y6AvMJX0ZtDoyTs9tPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6CCYQ/0NA2i3dPL1Kuj9U/pMIuzeU6Qj+lMSgdk790uXPgLzY6kHDU+zQemprIUA
	 +8SlXVKfrfqSSOjEmVs42uZsaM+gzf89G6w4rUo+9u+Sk1UUfF/gzqSlNAysaievyH
	 lmW0rjk4im6dE7vu8UnaOo9IlURVaGK4JAsopP7UORMyFbr3iM8Qx80mYVMYn3TZlF
	 +0njCMn9eSwypOTAZrgI3G92CdOUUPQYzjCM80ojFpq2Q1CMz98oq4CrxJ0wsSdsq3
	 O0YLh1TsWIsQ8Y97fGi9HWxlTetqet70GZpVk4Q6Ro5Gs7ta5itl7OqVvLjNLd3ppF
	 ddMUz78ksCFSQ==
Date: Thu, 29 Aug 2024 08:12:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v3 4/7] arm64: dts: ti: k3-am65-main: Add VMAP registers
 to PCI root complexes
Message-ID: <bsxsk3zy5wyao7ljdf37idff4jf5g3gsp7amkywbm7z55vrt4j@fz4x4vjkfehm>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
 <988ddd76b742240d42aa2733ad92c6e7b82a3f0e.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <988ddd76b742240d42aa2733ad92c6e7b82a3f0e.1724868080.git.jan.kiszka@siemens.com>

On Wed, Aug 28, 2024 at 08:01:17PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Rewrap the long lines at this chance.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 

You still have DTS packed in the middle of driver changes, suggesting
dependency.

Such ordering does not make sense, because entire DTS goes separate tree
and branch. It only complicates stuff because if you have dependency,
which you cannot have, it won't be that easily visible.

You already got the same comment.

Please fix your driver to remove dependency and ABI break, and then fix
the patch order.

Best regards,
Krzysztof



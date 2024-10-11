Return-Path: <linux-pci+bounces-14335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F199A765
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA4A1C23413
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F407A194094;
	Fri, 11 Oct 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIvN7uSx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787E28684;
	Fri, 11 Oct 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659939; cv=none; b=md3jwA/e+Xhe65yvqV/u7TLnRaEOQQVoKMy62DTcbV0RUFTbj4xDD6aVonhQlDVrrBn77b6B25qbZV9AiYvs09JvnIfUMBNlNdB33zvbRIrUnZj+1VaJC+LuOXspb0hBR5TigDcISjiWSyGfYVdz+iH8A4p9nuL21HWMfJAUBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659939; c=relaxed/simple;
	bh=PWqeU0S4dPGTPRLP47yatV5LXJlT5bWaYQppBjjkpSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6eqM2IM9bcBb4Zavkgdb9WCY7ngmY/w4Y90wKvYF+cX0KKMhsbjfcfmQNQRyDAEKfIJCeIJq45/uQMT5n6+Y2avrTVqNkZiuNbatTceGqiVAUvUszv/k1qpGsiA1q8gyOkJnq/ojYcbYHTnBNkuuZ9CDuOItnqqwRZsab3BtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIvN7uSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3416C4CEC3;
	Fri, 11 Oct 2024 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659939;
	bh=PWqeU0S4dPGTPRLP47yatV5LXJlT5bWaYQppBjjkpSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIvN7uSxtIb7am5w4GP5Z81WaAesV5KYoa6PPv2T+bMlOoLqMTLA+YrFtc5Kx/SCz
	 5YKo/B+TkVsVnz9OqsOG7qAi3MIMH5h0sSXQc4ekCEcIrwpKcSyc7XFDc9XqMbfVVn
	 6UD1CpkqfF4bKVGhEHMta4Sh44zwnOjJlPXSV9kwwU2bX8r8Sc/5KfFmZ8chKKqyXz
	 Lx12eTUJXld8zvugxvb7mNejsvBQe36NfcSTfLfAIKgQFEUUI8qAp7FMF+CPmUFUfw
	 NGUmhPzxcKHjhQs/bE7RJ0zuHuVdRrkc7qUGju2xF85JJIBAwSVW+TQgQB2522Gspy
	 GGU9t6u5fa4Lw==
Date: Fri, 11 Oct 2024 17:18:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] of: Constify safe_name() kobject arg
Message-ID: <lyofzs2pbnp565two53smogmebunfvgrj2rxrltlkkoix75uph@qlxgavv3x3z6>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-6-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-6-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:19AM -0500, Rob Herring (Arm) wrote:
> The kobject is not modified by safe_name() function, so make it const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/of/kobj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-pci+bounces-14332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D928A99A746
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDDF1F23C56
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD11946C2;
	Fri, 11 Oct 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrGo4YzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55855194158;
	Fri, 11 Oct 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659606; cv=none; b=dja0PZ4gdGRm50Boc5K+d4o45k1YEoZaXxjsjfjGBe/iqCf8W79N+1jzaYgkRuOyBZkvR0o5oy/hDy7NxytlUEwzo95Ykz0pYX8OXvuI2L0zfMdcxRFAV+1EQaqMGLVy7+IZgyaFfUL6ZAdhDWjdVL5Aq0gR4wPbTR4FZBNBgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659606; c=relaxed/simple;
	bh=GwP6D3rMh59AApYmRBzDix559eOXNE1+vsDwURefIv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhtoYz94GaWjKK1vYTiYSAqS6v6vT9hlPj1HOD32IID4qr4eWLKy5WDD8rMXQBkKiefcMZNkEHsuzz9IWvUvMSjrg7Ed9hhoUBARCV4fJnOXxuyCx54YJrw21UbYmdVWZt33RSgRcAjS1xM54ETjnyftZwoyfa3GQibIVFaPFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrGo4YzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09004C4CEC3;
	Fri, 11 Oct 2024 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659605;
	bh=GwP6D3rMh59AApYmRBzDix559eOXNE1+vsDwURefIv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrGo4YzV8FbuwQgiT7splfSZwzgf2eIYsWZreqGm2RhvzFANP4LAeg5hxhQoWVbSf
	 Z6urvPW1PeEqEsIy5DXkDs/ieVQJxPKP8sO+MkBH83helh4EkL4DRDxcVka1+vIB0k
	 f7PO1NqddOGlSxItrm3BBPr43BgQI8DbMcugkaF/Mo/etzpwmsxjAo2bVQQnLj4Xt5
	 95oygke0jXCu0gETR5evJfJ4YY0DDqiyEgPF7PlTZJHqitivqmNdhDut8F0mAk1iSV
	 v2R+ajQvlbFyMESt+lI/5sem4ivbQdNembtbHFI8fohw96OeX4fptSpejmq8WrMLfY
	 yS+JE47bJ1s+Q==
Date: Fri, 11 Oct 2024 17:13:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] of: Constify struct device_node function arguments
Message-ID: <ye5zgi3vk6bmxxo6eaniu7shuxogbeugy3q3v6rfr4lmcyjdl2@zdgjabray644>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-3-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-3-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:16AM -0500, Rob Herring (Arm) wrote:
> Functions which don't change the refcount or otherwise modify struct
> device_node can make struct device_node const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



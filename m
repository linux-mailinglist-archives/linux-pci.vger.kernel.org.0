Return-Path: <linux-pci+bounces-14334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781899A762
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230F02864F4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586C194137;
	Fri, 11 Oct 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGxPxyZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4915B0F2;
	Fri, 11 Oct 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659903; cv=none; b=L39TvcIu0hb0no1IzX4J6yg6uFiDxHiryTM4K9hyciHJL31mLOdApL8kz+C/ueS1e5CgYlhiDqd4JpXgxJzeMs1bksDBYM4QNQrRFzG3e7gQ38bmHbV3BB8kEP5xYc5Dc/+YxnpoLGnbMwCv6hMDn0AOiXN2t6xnvaJVLRiTJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659903; c=relaxed/simple;
	bh=7zOPO8oHeKUirv7ZiwuhyKrEj+sdf0LgJj7UoHqRHH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cteYm4oku3a5AQQmNMHQ9q4GCDr85TYtOKMlDp+47Y7hpuSMdwoYBo7/sa1+rkZ6X557LTV3GQkG2KfdehAcvQ+mN9/tBHt0y5xWuFrtWNr1lOQXXET8U5I0i430+MXMx3a0wHKYoiePvrjE82mN1pfl9GKV4q3mFJnLobu8EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGxPxyZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FC5C4CEC3;
	Fri, 11 Oct 2024 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659903;
	bh=7zOPO8oHeKUirv7ZiwuhyKrEj+sdf0LgJj7UoHqRHH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGxPxyZCxJX+e6H1EmO/RZKERNIG5kudOhdq0NvOUuU7wsKQbezw6JH9qpl4W1EXF
	 uFRjc3qkCQDfbkReyx3wi4PIoyH0fVXryhIUpDSKoDHUBXH6TMddJaYzhjwfimyABq
	 S8gw9DwUiGDMXIcBBX6hhHVRQQkUZCtSfcdxx6BA2LE3qMf6esodAueM643Jg8L+3Z
	 EAV1z8P8QLOIhNNqoe2kVAUgVxA8RbkCWQNP9QEjecAxqSPzviCUmr/r7wQUAfztQS
	 Q5vhQp8NsUMZv2Vl3u7PjlzBNf6LydfZ89vEHFQu65B5jL6glDqNRHL/52bfH28zEF
	 LG4rw06Ue2Rjw==
Date: Fri, 11 Oct 2024 17:18:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7] of: Constify of_changeset_entry function arguments
Message-ID: <s34x7fz5qfhz7hupe44ncb2rm4cop4x57iwmg6zalmuoaeiqjt@qjrt2ogotjus>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-5-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-5-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:18AM -0500, Rob Herring (Arm) wrote:
> __of_changeset_entry_invert() and __of_changeset_entry_revert() don't
> modify struct of_changeset_entry arguments, so they can be const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/of/dynamic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-pci+bounces-14333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875F99A75B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E56284DBF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77088194A53;
	Fri, 11 Oct 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ2C1ibz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCB1946B3;
	Fri, 11 Oct 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659857; cv=none; b=N4AZfmTz6TzFpIjF7NvRaOAr0LnBjno9FhwBL90CAWSAd+w32Fh7+xTBISby4XPIHR0idtogeKBELxuNUVircxqJT1K0TFQP1vl2cQquWALSeHcb076tI/4j9bt2MgVHlo59TQ70SpySNPUE8iKf9/IgdCoa9sNh6Uw3alDHJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659857; c=relaxed/simple;
	bh=s3WPRncOOtlvuIQAxXGDGfyNYBXqgMJOL403/T3Qwfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPG5CnDgArGOJdk6Lt+cU1+ZoO7Bdio+7IsWfEqtBnwsm+L2nKZ2Ccdq7U1Ay/OzVDL1A9t8cKJjB1scrk6Je9C58zrtO3j53poIYLzW0Rq35SqrPqPTWmwxkc/auK1k6am4bKntzRxj7/V/6e7/3+b3Je6volm1zt0iOGt/3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ2C1ibz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FAC4CEC3;
	Fri, 11 Oct 2024 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659856;
	bh=s3WPRncOOtlvuIQAxXGDGfyNYBXqgMJOL403/T3Qwfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQ2C1ibzyp90EMhBnsTnMm1dIvN8qNuaFsHI1c9JwmGPtm/BCA9AZ8Gs4DT3cF2zc
	 Xs1avmR6KIF11GQdYW7G71MpfoluqaUrmODbSkHvAcrOK+gvjlBAGAkMppZY0sRu4Z
	 UHAvefMcG82QXfAv9hiI4jRkfQ2JMqNc8itf9pDot3yw1PLBeANazZgNmd/VqpTs1j
	 Tk38GdoX5qS3d9f96N0wd461XxSinBJS0ZVFo60ujN9uA5E1SGNxIVHJz6D0890t5u
	 tNHMZ96ZckZ90sgxXkvvToHeSn3e/69q5uV7i5Qj3VeERNOChyFupPATeyFi6yShjc
	 AQpMzBbPo7iXw==
Date: Fri, 11 Oct 2024 17:17:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] of: Constify struct property pointers
Message-ID: <afhwdpkqaptkrdcmtvwr4nqcndvurreginsny25hmexlca3los@ovxvo7cp5gdl>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-4-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-4-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:17AM -0500, Rob Herring (Arm) wrote:
> Most accesses to struct property do not modify it, so constify struct
> property pointers where ever possible in the DT core code.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-pci+bounces-31058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8296BAED594
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D410E163B44
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7DD21B191;
	Mon, 30 Jun 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGhdBsoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E276BFC0;
	Mon, 30 Jun 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268550; cv=none; b=pXtnQuLiixn/71iMiHzoitdBVlG0f7PhS8mhEsJxFaizq0i//iy0kKX97Bb4t3NV5rolCY0whcwrHUsUycxPGHeuUoI87pqDP8nWZOQm7LZrFgdunS509QuBeLmZUD0Pkkh5CwiBhnbiRT40w9IzccqaRrRhctb1KWVB355sOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268550; c=relaxed/simple;
	bh=+INW3nAu0nxQ/JcAC4uwQZLDZ2j0TSAZCd9ja+OVjs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te6Z8kpNs1jWKo7MCNv9RJ4zzH2zlTYxMbNZNjWRc8PhNx9ZiIuhKvsGVGejvdB/LKfxEf+HbIZfMhVzxdihOwoW1Fc6cA9rOv9KHZSMXgqi7LhRrZ9/RsedKDrpdwd332KfQu9M17plSZnXbpvVVAYvLU9jqw/tw/fN1cKisjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGhdBsoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEF5C4CEE3;
	Mon, 30 Jun 2025 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268550;
	bh=+INW3nAu0nxQ/JcAC4uwQZLDZ2j0TSAZCd9ja+OVjs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGhdBsoLhOFDArOIcJ2yfIl0KV0fzMrdmXUzH8aDrGRjyE25aY2C51cM5Dr3VH30/
	 /2PcGSxbqi3Kzx5Dj57rg+5vFbw+mCfYnScnZ6SNRPqwvt5bMRalb3v2uvvmfhYrwB
	 0asbQBfEdwIcMB2ADOx0SIMkGZdBAzQ9oXc28Jc4o8LwKZcA3MfEbbGzTEPfDUvZTY
	 MWHot4Hy1CdXreExtEmPOvhAAxB/CrYBDG3G28GhQxK4oeuRv8w22HX3UZAzsC4Add
	 p1IOG9hcLPieOUweTIsrJv9msD3CtkgABxjozTXo89usmrbAepbcOz9SEBJ9Fn4NLc
	 2Lulg4va6Eqkw==
Date: Mon, 30 Jun 2025 09:29:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/14] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Message-ID: <20250630-delectable-greedy-sambar-5dacd8@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-13-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-13-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:15:59PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add myself as maintainer of Sky1 PCIe host driver
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>

Where? Provide please lore links, since your changelog/cover letter is
missing them.

Best regards,
Krzysztof



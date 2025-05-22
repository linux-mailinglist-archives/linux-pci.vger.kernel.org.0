Return-Path: <linux-pci+bounces-28280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E20AC1120
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF6E1663D9
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C369145A18;
	Thu, 22 May 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvks9uFP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7132F9DA;
	Thu, 22 May 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931737; cv=none; b=KrupMNbmhRm4xvZR+RFEYxZ+phmbMS9/eu89kusmJyoer8CT85T4WQDITklg/5uK1ueSjRdHomntI9NB4/B1vThkiRHMv2Sjbr7YUqNqFScNm1+ExbR7owKi2bS1zweB7luvIWTTpAABLmSHTgUUhnFQgv8ne93E7KH4V+eaFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931737; c=relaxed/simple;
	bh=KQunkX5Y+69leEqE6y50+DVV28FqijPf6zXjTdQfLFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcXxPppCQHcyi5b5muQvNUM3IUXkLc2O6Z/PBsXB4BDT7C8SVpPXVxKu01OZgzmaEZcBlKp8CU/v3QQc8t1GeqQX6Va5lHAGsR3XfcuWhj0KAP9qPJGT4dxe2CZDqK5Kx4Xh8D2SsyhZMHijYylDH4OD4LQ0kuvE5OlJFUob03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvks9uFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D1C4CEE4;
	Thu, 22 May 2025 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931737;
	bh=KQunkX5Y+69leEqE6y50+DVV28FqijPf6zXjTdQfLFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bvks9uFPJX/IOvkjeyVjdSR9Jaa+F6bP10MpCkbDTAGTyGee457NqgBFeNFMG565T
	 oTiQlhDPMJsoTKSBR8RmQdXLf1cly9dnc11JB9+t6qfUcMEr8WH7LqG53UlhomHNZ3
	 JE1GwAChFy5ZNnHK8bzJOjL/5MH8YCnOwHK6Ai+mC31+UjRYLitp/xNfrXahimf4xh
	 btTXo0DYCiWFi0bkQKVy/3HTc7jt+IzZ/Rnd68rxvLYPr6Q7HxFP9TBOkfu71RStUX
	 cBP+dGe1zhb/2hFfa1tFfTIRlJtjWl8nMNZYSQJ7CBC8reTSzdaALEAc3djjmlTd1p
	 xEAgUPzzXottg==
Date: Fri, 23 May 2025 01:35:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
Message-ID: <20250522163535.GA3558378@rocinante>
References: <20250522163251.399223-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522163251.399223-1-18255117159@163.com>

Hello,

[...]
>  drivers/i2c/busses/i2c-tegra.c | 1 +

I think you got a wrong set of maintainers here. :)

Thank you!

	Krzysztof


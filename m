Return-Path: <linux-pci+bounces-26539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0306A98BCD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450C93AB4F6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5D137750;
	Wed, 23 Apr 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2QLIIhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF457C9F;
	Wed, 23 Apr 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416122; cv=none; b=i2+3c1EceLYf5J1ICOQvXmCXnTrtH3BCSmg1TalRvAd1Zycnk5Q0uOwDrqCC6eCJ9GHw3+bzIcFZstqVsCMs9S31J3gymnvYTW+y56Ep8hrw445zBTnVvybkHay1QefgzAZnErTKwOHDnL4O5O0wsyMs/7zGlI6milbz4j/k0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416122; c=relaxed/simple;
	bh=FhtTxTGZzdDSVEvNHPZnCN6HydplmlNu6hhbDRLgF94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCGcW1wXChzsYklJUBrc2raqi6WyCwp29Mpct4n+VLnZFn4WvaOwxRu6NLSnfIWmZCPImk0m464aLOilXgfbyV/3BzVmdrxZgMN/pKxJWX2G7hfCvZNzDPRXW7cvNHQwPMB2ByC62kqmM8XggPDoYgioSg9uVU34KFPnEp7hNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2QLIIhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7871BC4CEE3;
	Wed, 23 Apr 2025 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745416122;
	bh=FhtTxTGZzdDSVEvNHPZnCN6HydplmlNu6hhbDRLgF94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2QLIIhA465PQj3ci+RSQMjXCQKXLCmaooB8zhyNTlZwDv1HvbML0F0jD/zMhqJwO
	 zAx7rxRtj+Fv+PT1qZil4gzcailjW3VWP+fA1kpuKWPnhETA/JV4R7E0IuvbSl5BGr
	 4pR2joftw5BbWpUsNlKl7X5Kl9XOgh2Gx0ZBUS3R51J7vqZm86R0j7rBaePvNxUK8V
	 4XpGkBJOsJyGFDcpuFR6GbEz/0W8/8+mVPIAoBdmXjaOsgXagJG0WUOHZRq13b/L/1
	 fTnJc4twdTw6ZleAr9BQmVCrRvheN5RFIpFTstFqRNW2Aew4isAPrMRvVk8Xb+SJYQ
	 r6d7GzsfIhZ+w==
Date: Wed, 23 Apr 2025 15:48:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
Message-ID: <aAjvtH-Y81Rsy8zK@ryzen>
References: <20250423105415.305556-1-18255117159@163.com>
 <20250423105415.305556-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423105415.305556-4-18255117159@163.com>

On Wed, Apr 23, 2025 at 06:54:15PM +0800, Hans Zhang wrote:
> Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
> leading to code duplication. Centralize the logic using FIELD_GET. This
> removes redundancy and abstracts hardware-specific bit masking, ensuring
> consistent link state handling.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


Return-Path: <linux-pci+bounces-5526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BF894DA2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125221C21C3D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5717BD5;
	Tue,  2 Apr 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsjlnELG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35811772D
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046874; cv=none; b=tPjWz+6p4PVStxlXStxyymEzUr9JLt0MZP8KXM4zXJ+rzlTnthyWAVEfedoMw80Wk8qHPHz8wrbJVO6rSaBYx+pSs+m3a6urc1nvRQMfs6lIwOM+cbLfam+HloJCjIpfmd2Vjd+EBmcG/sGUqoUUptIz5na8wWnRohJKrA8T3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046874; c=relaxed/simple;
	bh=WkQJV6R8cNCkTPJI7XJ0ACJnQSCJvJy1qj/CeIl6XdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFM+nYWuk3NcLvnXPSa409XK5oK4DF2h1n8tTINAC0T/71AtwuRprFVYA5zXfNBp+2Zu3B1OGmlMLm6qZsefoKoCJCN8WBtgTSG3q06jzcKfEFGTjbTprcMTnjddcLILwqtyu0iYNf9sKKUH9k3ZxafUGrvStoCsUVZi71wUbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsjlnELG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C2C433F1;
	Tue,  2 Apr 2024 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046874;
	bh=WkQJV6R8cNCkTPJI7XJ0ACJnQSCJvJy1qj/CeIl6XdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsjlnELGeu3oyAbvXKgK0mYBhBzaIrvPzdqTuaBxDJGul3UivOkKtATRrKCG/VfVM
	 MMkY1iJlLYSI7QRo60gl7LZLW5uF4zXYJKBqswkcz9J+lmjOEEDxuZGUdPuEJdtc8w
	 Rt2Xd9us2JlIUTNsi6EVk2sisnZOvASSPD61GCaK2gA032kaAW5LCgx01vQuHGU+jn
	 CYWKkQsYoFukKJD82DsW5ITGYXo51zKd71JmWoPunVui1gYoh6nQDnQdyUkqyUzriV
	 +cEBMN/OS7Tr1F+IzPok163+tDzok3GLxtj76g1w1IWWMYXOFZEiJ6HV61fl9X1L5u
	 +fCPlvnT8K4sg==
Date: Tue, 2 Apr 2024 10:34:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kishon@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, kishon@kernel.org,
	kw@linux.com, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, Frank.li@nxp.com
Subject: Re: [PATCH 1/1] misc: pci_endpoint_test: Refactor
 dma_set_mask_and_coherent() logic
Message-ID: <ZgvDFR0HDopzy9zD@ryzen>
References: <20240328160632.848414-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328160632.848414-1-Frank.Li@nxp.com>

On Thu, Mar 28, 2024 at 12:06:32PM -0400, Frank Li wrote:
> dma_set_mask_and_coherent() will never return failure when mask >= 32bit.
> So needn't  fall back to set dma_set_mask_and_coherent(32).
> 
> Even if dma_set_mask_and_coherent(48) failure,
> dma_set_mask_and_coherent(32) will be failure according to the same reason.
> 
> The function dma_set_mask_and_coherent() defines the device DMA access
> address width. If it's capable of accessing 48 bits, it inherently supports
> 32-bit space as well.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Kishon,

do you remember why you set the DMA mask to 48-bits in the first place?
It seems a bit random.


Kind regards,
Niklas


Return-Path: <linux-pci+bounces-7143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CB8BDCB1
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A337285A24
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39213BAE9;
	Tue,  7 May 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM93Mlv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498413C667;
	Tue,  7 May 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068143; cv=none; b=tEvRGzkTbJj9tTFk1VdAiMY4DSYlaC3Ix+r64fiWUN8kjNaEc0e97lZ7fUnIx80bX2r1BCORLQapVkENdHju4s84Vt0DiGHnVJhLcpHizMPGJZT3xjlAcUDDsL/bf0pPH99x004kNpRRgmLIjg6hj/Ss9yWjbLGHGB/eH31W6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068143; c=relaxed/simple;
	bh=uSLcxGXRL/0Oim0oSJlxmzZQQX6ug/aSy/1i3zrYigY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4MjkTkyMbWGl5NPLF8SP5T2OSgXzgMiMNm1D/H20zw6ozXfcOdgrbiccobA4vZbU2CMUPFeTaSXuJRtajHk6cd5mRvLwgX241XLOTtSNKAPQfs20TWjQKPvZUhxT495NNyN99zinYYN6ctcdxiA9N3xoz3jt22NrAWGI3+MmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM93Mlv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D15C2BBFC;
	Tue,  7 May 2024 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715068143;
	bh=uSLcxGXRL/0Oim0oSJlxmzZQQX6ug/aSy/1i3zrYigY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gM93Mlv8MYmcaS8Flyh5LYVFSclkdxfJj7xa2kPLuUy+qWDBgQQRUNwKaDRXIUAZX
	 bjEjc+vAm0nZvjYymbTexObr/1Nzsiy05CBoyheQ5ODz1uBqs87B74FsDqdJ0P8Baw
	 MQniSMo3tQHev8MBdPLab2gg6JgUq1OrwrWlADVQ+eVvngC/Q30YQFr8p3zM1JZtmb
	 5nCNwwrvCCHeTa2xsI9BKqEGein//ZuV3Lj9cHpvFNO8ZOTYdk99qHTFr/5mogXEkw
	 I1TSyEN7g0+pNo4inKRnz4kHNV2d0qTRyfPluEPXJPShq+d/btfhY13KZ4+E9cWEhh
	 oYczS141q0GCw==
Date: Tue, 7 May 2024 09:48:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, imx@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org, kishon@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/1] misc: pci_endpoint_test: Refactor
 dma_set_mask_and_coherent() logic
Message-ID: <Zjnc6s97DbrGm8t1@ryzen.lan>
References: <20240502195903.3191049-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502195903.3191049-1-Frank.Li@nxp.com>

On Thu, May 02, 2024 at 03:59:03PM -0400, Frank Li wrote:
> dma_set_mask_and_coherent() should never fail when the mask is >= 32bit,
> unless the architecture has no DMA support. So no need check for the error
> and also no need to set dma_set_mask_and_coherent(32) as a fallback.
> 
> Even if dma_set_mask_and_coherent(48) fails due to the lack of DMA support
> (theoretically), then dma_set_mask_and_coherent(32) will also fail for the
> same reason. So the fallback doesn't make sense.
> 
> Due to the above reasons, let's simplify the code by setting the streaming
> and coherent DMA mask to 48 bits.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


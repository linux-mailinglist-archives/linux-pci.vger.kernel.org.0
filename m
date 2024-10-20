Return-Path: <linux-pci+bounces-14912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CA9A51D2
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 02:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076F31F21994
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 00:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C063D;
	Sun, 20 Oct 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDwiTcqk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A161370
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729385994; cv=none; b=us63VtxLGeUgMFOtjUkxwwKP+oTYgMT7j7WHSGpuWTWmiVsn2oHbEFrjnOorxgbPItZeIOvLLFCgA3fXngxQa8A1nnWLDnjTpIOwr0yfLLBZO2C/dFhIYp0kzyB5LDu1Myski2UINlh1kX+hWzqmN/IuLdxrmqSADpbIM0DjbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729385994; c=relaxed/simple;
	bh=00lU/pV0Ea1WnaQW5Ku8/QhMhUc8shS7mBJDVhzcYjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xsq+frSFJ884fDpppcur+LAhcOmTjsG7YAWfuKwqVgYLpZR+BxqoPxd8AYl3Jtn6dWAenD6exnRbmFV/vgeoM0ZyrYAuOAad/qFTpuGioHNUqr8U8Qze7IAquLQsbYYIxas/ZlRm3Enn2/4bmwd5mpBx9KnkRwi+FfIcE4pL9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDwiTcqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6DC4CEC5;
	Sun, 20 Oct 2024 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729385994;
	bh=00lU/pV0Ea1WnaQW5Ku8/QhMhUc8shS7mBJDVhzcYjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDwiTcqkKUZVs24o3QSy3ieIgmatn+psaDR5KMMyCM03UHThGoXwIgp/emZDeyIdd
	 WfQH5Qg+Jc8Fvn08x7tn21vIm2dS52du9V8YYSeTWrxw5BSggHsoRXyzoEC3kFnOSX
	 GAHtoEzIehHhIhGxfhxHOYf7x4I3gkravuoUMgWq2LMTPzgPKzr1DQ/dNIs7u0YZMN
	 QWXOzryUiioKf4DJhGqNS2ICMuGs25FIU4xmd1MZL+kqH+Ddh4llg+PUb59yfRvMt3
	 XZ7BhBjeTp4POJTYbffG4WTi/U/f6KcJxfRAyRbQFN+wO1/m0ivn0KZYqfOtCdAbdR
	 efltzvrDOeonQ==
Message-ID: <eafaae5d-53d8-4ab6-9c81-861476a6359d@kernel.org>
Date: Sun, 20 Oct 2024 09:59:51 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: dwc: ep: Minor alignment cleanups
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20241017132052.4014605-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241017132052.4014605-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 22:20, Niklas Cassel wrote:
> Hello all,
> 
> Here comes minor cleanups related to the new address alignment APIs.
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (2):
>   PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
>   PCI: dwc: ep: Use align addr function for
>     dw_pcie_ep_raise_{msi,msix}_irq()
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


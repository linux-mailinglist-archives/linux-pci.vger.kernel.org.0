Return-Path: <linux-pci+bounces-33864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB1B22C03
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15358620AE6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D230E820;
	Tue, 12 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4d+QYHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9130AADC
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013700; cv=none; b=YpYFU7oslQhUQeuYiginkVct+Iagvo//gr/yTaR72DwPGpCNb72Z0Sv011lg/0v+q1jawt5PbgQ2kESF+IdYRbgVtDP1tepXUIRssCi0K4cQvXAZ+2acgvo8u9GML/x6MZwdk8KoURunSpUG5hs8Fm0cH8I+kA3zXEVgSxezeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013700; c=relaxed/simple;
	bh=l+/NMqer3yxkRej217f2damoyUKqyvJzz2qguxRKke4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQxTp9CzP/q6iFj2ASDumX9uPPL1tneY7mPKYWdEgNysIWAaF2Z/OcDGxfDZ+/peU7kNGX6kUamin8cKR/7lBJCbDsxxRgozcbXNK1+HLMdJY0HtZp9jA/mpkJC+YSXrNYtP6DRYpQLe+f7AQQSUNsLp9YhDEPu+k/bsL1S5Pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4d+QYHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE161C4CEF7;
	Tue, 12 Aug 2025 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013700;
	bh=l+/NMqer3yxkRej217f2damoyUKqyvJzz2qguxRKke4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4d+QYHhwAZhrq/LTuRMAeD8NJjYUzP+235AxmUK0qV4+mBkTcYL/5At2mOEErx/D
	 MfF/6tjyf0t88xYF4XF52F92TFIrzgzHtW+fmFw/Voh1rg1XitzNmoi7C5Tpqy0QRN
	 0sxgnGhTlep0sWH/8r00MoJmutDrARMq9a4u0F2WpYB0F2040NagqaSMZ6IHNUIchE
	 7hkghCIp8nUFpOWnBkdXGpAPsTgtvqaQjIXpK5UauSz9O4BJON+JGkIvd1yfhPeM1K
	 WsREdNTVf/zmepPR8U4CezlcaHalGfQPJ0qQUFCumyvcSl5iJM097GTckmBqpNL8Bg
	 spaoh7lVeIjtg==
Date: Tue, 12 Aug 2025 21:18:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Make the display of vf_device more readble
Message-ID: <kmvc3rmyjhhnf7hewclvr444x5qsumtcmopjfinrokbqvgypxj@oo5siznjfcol>
References: <20250324131233.116341-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324131233.116341-1-kanie@linux.alibaba.com>

On Mon, Mar 24, 2025 at 09:12:33PM GMT, Guixin Liu wrote:
> Add "0x" prefixes and set its print width to enhance formatting.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/iov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9e4770cdd4d5..df40663c1881 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -500,7 +500,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
> +	return sysfs_emit(buf, "0x%04x\n", pdev->sriov->vf_device);
>  }
>  
>  static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்


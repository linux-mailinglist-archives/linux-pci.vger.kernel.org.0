Return-Path: <linux-pci+bounces-6060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F189FF2D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42381F26EB0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AF15B0E4;
	Wed, 10 Apr 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfS/C5Np"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA441168DC;
	Wed, 10 Apr 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771695; cv=none; b=FjTSE+1lTLYUkw+tsLAShcTG9u3eLoEu8AYo4IaCQgfW6Lq2Gl0oDbXzsHFLZvfOUudoZ73mj5ACW+QMcuc4D704Lw9Nud04tcR6yhk5FNN/OqcEIHzErKOIVVwNDakYKSm0CLfM16d9fW+l3xMzBG7XWaVpkMLq7El4FWFd7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771695; c=relaxed/simple;
	bh=tS6YbthaaUDrS4by0h9EYVy7UoJb/iB/sGx3veAA9LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXh67AubkorNd+SaAmrgAmpDp+i9byDv3q7F3P95EEipE7LEWquOJV7taPODzYo3BOZJG79FDsg1RCHmX9ghRfZc2SM6bGyD7triDfVgghCErYLd3oWPQ6qvCRST3hK7u2nQU1l9R0Vl7tqj2Q41qA6ARbP8aduBVWKqnaVpbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfS/C5Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2ACC433F1;
	Wed, 10 Apr 2024 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771694;
	bh=tS6YbthaaUDrS4by0h9EYVy7UoJb/iB/sGx3veAA9LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfS/C5NpR5JzRxqO4fJbYh9vPtnxZTwGFvMQVBsjtCBUvWC0lkEwyFGSjwZ50jb3i
	 CgxJxBTYxLdElR+uhNVYoW64YzwnQjq7KfJvzD8Y8uj+6zeq+zBAFCjhbAhbUHRYcp
	 sEO84Em0zPrdKobFac+aYjVT0C3wlFZWPXUfdmXPI32ooX/jbUEuRcs9I9gXGHDohL
	 EUdlcWLwzRXnl+fsCOJ9JaoSiSS7JjVLN6U0OOX86v6U95QqgriPl3rT23bcnZSAS6
	 jOMGp7v3MBgut4rk8+Kypv+sFziuAlsQ+Fk6qzViwRT5DnQLKaG7J4uhBzi93POvMv
	 BNKRhR2JK1JVQ==
Date: Wed, 10 Apr 2024 23:24:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v6 7/7] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Message-ID: <20240410175441.GE16629@thinkpad>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-8-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410004832.3726922-8-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 10, 2024 at 09:48:32AM +0900, Yoshihiro Shimoda wrote:
> To avoid becoming struct pci_device_id pci_endpoint_test_tbl longer
> and longer, document a policy. For example, if PCIe endpoint controller
> can configure vendor id and/or product id, you can reuse one of
> existing entries to test.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> Cc: Frank Li <Frank.li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a7..3c8a0afad91d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -980,6 +980,7 @@ static const struct pci_endpoint_test_data j721e_data = {
>  	.irq_type = IRQ_TYPE_MSI,
>  };
>  
> +/* Don't need to add a new entry if you can use existing entry to test */

'Do not add a new entry if the controller can use existing VID:PID combinations'

- Mani

>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
>  	  .driver_data = (kernel_ulong_t)&default_data,
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-5283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92F88EE6A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE8B1C2E783
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06814F112;
	Wed, 27 Mar 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ3OlFQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267F14EC62;
	Wed, 27 Mar 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564938; cv=none; b=Jtn43Ne7GiVg28UDKFUEc+CFEN3dblqH5agrK6zEqw/FnkeuoE/iZmKVMkWyZZjDqdc65pccxvyGgpcV58/tNWLpXcl5zRZLc30s1+OkZR8M9algn6NwM5auUDO2q1UkJY5a9/Z7vi+AO6OP/1AyXQIIkbWRMyINhL6b3upUdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564938; c=relaxed/simple;
	bh=Ayu5sbY83RnLGYxoVK12+brj0XUZ7gMZ19xzE/1cEbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XmB6nUu6sQZbqZlIr3eH6olFMpT5WDZKKuJsOmdJt3b1iQ3XVnxP7x2XVOvjb8WVqdubquXrIIG7ZX9P79VKnYBZucFU0lkY/wSkP5QLKqJmI2X6SVX56AfiJPaYeHZKuk0IL6ygixNKtZyIbGdEQYaD7WceOs2KzlMtQWWL3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ3OlFQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC47C433F1;
	Wed, 27 Mar 2024 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711564938;
	bh=Ayu5sbY83RnLGYxoVK12+brj0XUZ7gMZ19xzE/1cEbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nJ3OlFQJ68vOy1WuQlzzmO8aV0CoFuKWrKFMYibCeIBshAgdTY3ETMEZf72vPoAbt
	 vt1hn00tSbLsn1FzSNtFJGBHfFZMemmBVi9svpXH1ngxXMXJWcg4SuXpxy6Au+XhMU
	 SP9KQFzQgbA9aXDXihe2cDG++Hia1LTPeD+vaC0EHzQRQtQfBAZYru7rJMy7RdK+X8
	 nx9WaAkPNQ6tlyVzFduHSRx996MqKVF9RO1uvXR8ux1VL3kzQHPnsRYieoM/o+IT7D
	 a4paY9JNEN/j4uROvt+2URLdZUDERKnYeOmKzOJgMcwdbmqu/sbat2YvUjwFwptipQ
	 fh1y1G1VETR2w==
Date: Wed, 27 Mar 2024 13:42:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as PCI DWC Maintainer
Message-ID: <20240327184216.GA1533920@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326085130.12487-1-manivannan.sadhasivam@linaro.org>

On Tue, Mar 26, 2024 at 02:21:30PM +0530, Manivannan Sadhasivam wrote:
> Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
> And there is no indication from him expressing willingless to
> continue contributing to the driver.
> 
> So let's drop him from the MAINTAINERS entry.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Added a CREDITS entry and applied to for-linus for v6.9, thanks!

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9038abd8411e..94cfebf41905 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16965,7 +16965,6 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> -M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -- 
> 2.25.1
> 


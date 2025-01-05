Return-Path: <linux-pci+bounces-19312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F4A01AB2
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0AE18830DC
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50431143725;
	Sun,  5 Jan 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPWckYMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB5146A7B
	for <linux-pci@vger.kernel.org>; Sun,  5 Jan 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736096014; cv=none; b=E/YQKPVQ6pcx/twVi2qoZSeeI6uDbDCHx0AVyohb+nTqWnJ8o6y7BTilMccVIwhMf0Vr6ZNTgzUxmzlkt4h0HUwJuXY7C2cl+JI/4gsVCGwHAvWFECnuMO8gvWwTn4JRz7goFtyGOsi/Cj+vW0MUt7TFtuQqfS+8k/EVLs2rMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736096014; c=relaxed/simple;
	bh=dm2CVgOeUMxnPwXmGBh9jXrkwI8tzVSGMW+uPQsvvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or5GAyEIXF5mSHCONIiRkv+w95sEDD5IWlUIeafM9vQ11RPq8DBJitS1bkX4pJlgnqmhbhapdnpkzR6Q1qmS+Xh6IUwsI3Es9MSuwRaxLs/pmB7/R0FzqbDuH8iw0RtaYg9d+g3DOv9jx3JNPcc51qIeFx7NeoEUnD5i3UmZDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPWckYMl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso189090625ad.3
        for <linux-pci@vger.kernel.org>; Sun, 05 Jan 2025 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736096012; x=1736700812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVkkUKi3TEoqcrBW9O+G+7DHI8k94lZ9o3ZtGWTmR/4=;
        b=mPWckYMltnQaOuwzmgoZgs8qf62FTGOFFR+u+PQDIxtCPx1wOi/O1xV8y4pjWFDHbM
         yQ7lcdIxSjUySuxlrIn4i0z6t5iax9/Tup//uu4pv1PcvWoKQOIHY7ENveahYvdBkrvL
         L8kW5Bb56zLDrMkojIAKe78oK8WE8iPu0w1uyw2nsN8A+3YTzmOKH/1LyaFOysltBwGX
         VD4Bnblw2aKiGLJz7tMSrD4s2i8a9OBTgiRLqJjHTwYLZLlhvEK2yJzeoV6nNXU2o6mG
         U1VqwiAuJSr+WMIbusVJGp2jzRSWvc3ITCHL0gvDGytc+mySaUecMKMW2H4dYOUJXDfM
         +JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736096012; x=1736700812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVkkUKi3TEoqcrBW9O+G+7DHI8k94lZ9o3ZtGWTmR/4=;
        b=MBCfpp988Phk4unJa3dUdRyzAqBNVpw4F8w5pOObXH2AJDtF7DThjT+QxDHLqxrATv
         MaZ/+1zRcUCJXwi9Tjo1Swc4IjtTOjjjVIFtokG3rC1mo/3qk73MpsGCNiDYltkUjRwI
         CS/2XZSe8oAnSDVCd7mbEpUyv+2l2lApO0rWnjkv1TjYo2fTcgLXswC6CeSCtenkfNPF
         pjekAglY32SNIZ8qQrKZpWG/NSLL1hoy2i7qlIF4nkI6FEr+n3q8OCjLZBynMiEippry
         ZRQJ7KOWszcBHo7ErdvLjuCqNwmf5/N9rDMsgDNrvTMC72x8H4umAI9p6bkKdKWumjla
         iAUA==
X-Forwarded-Encrypted: i=1; AJvYcCWA2omv3stjdDQndbdFo+NydcCJNICGm7oP1A/rm+KhDw+z18NiuEkYXooqzcsb8QpM4HQYOYaEPkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQy5O2+t4dnLDEYpM21sVH/t089h/3KwWfC/nY19UbyH1ECuK
	jyQzTWecXpvYQNJiot+CWN/cjmF2U17RcFrW9385DAvlzgHEem3x+9OAr+Gm+w==
X-Gm-Gg: ASbGnct25M3M1xrDiEqu5X30/GKoasKV/QcRvKAjJS5V8WtpO9eonb9CNEFFhwm6h9F
	WF+p4iu5HGE3IPjwJ1icg2xuegp8HH/gFsVfRxaS7u7fmio+ZZUlvDhZbtaMDcWozhZ7JOn9Xmk
	U57a16uprEE4kGreFcr1IiGlBuh2H/HvCMMuKoVlj4yae4zN0Fk8FOptWZtF/DVgVs+7gIiFpi1
	pSQe9c8/YW8KXvUCqWCDqENQ4/++GboVOQxVImqlRyfosQRz//50yt6SzneKFiXndf8Mg==
X-Google-Smtp-Source: AGHT+IGXvIwm3XR62M68f0UJnGgdNvu8I3ovTYOD52PhzIp4domidCXZMxXz5eNuZ3JRWmxru94gqA==
X-Received: by 2002:a17:902:f681:b0:216:7ee9:2227 with SMTP id d9443c01a7336-219e6f11630mr820530235ad.36.1736096012108;
        Sun, 05 Jan 2025 08:53:32 -0800 (PST)
Received: from thinkpad ([117.193.213.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962dc0sm278473755ad.32.2025.01.05.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:53:31 -0800 (PST)
Date: Sun, 5 Jan 2025 22:23:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kingdix10@qq.com
Cc: s.shtylyov@omp.ru, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Message-ID: <20250105165324.swmtt4qedut5eald@thinkpad>
References: <5f8d43fe-25e3-450d-b5c2-2d69b9bc9923@omp.ru>
 <tencent_6F826F87DF787845466AE67AEFF37E073E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6F826F87DF787845466AE67AEFF37E073E08@qq.com>

On Sun, Jan 05, 2025 at 01:57:51PM +0800, kingdix10@qq.com wrote:
> From: King Dix <kingdix10@qq.com>
> 
> When using devm_request_mem_region to request a resource, if the passed
> variable is a stack string variable, it will lead to an oops issue when
> eecuting the command cat /proc/iomem.
> 

Is this your observation or you saw the oops? If the latter, please include
the relevant log snippet for reference.

> Fix this by replacing outbound_name with the name of the previously
> requested resource.
> 
> Signed-off-by: King Dix <kingdix10@qq.com>

Also, please do not send next version as a reply to the previous one.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
>   - Fix the code indentation issue.
> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index 047e2cef5afc..c5e0d025bc43 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
>  		}
>  		if (!devm_request_mem_region(&pdev->dev, res->start,
>  					     resource_size(res),
> -					     outbound_name)) {
> +					     res->name)) {
>  			dev_err(pcie->dev, "Cannot request memory region %s.\n",
>  				outbound_name);
>  			return -EIO;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்


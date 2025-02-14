Return-Path: <linux-pci+bounces-21426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE8A357E5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBC188FD34
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A257204C2D;
	Fri, 14 Feb 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2USEROi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409C18A6CE
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518239; cv=none; b=d9yqtMTCpHvEqyBAFv5HSC+12nZZLS4VZ2uNv9pnu5DAG/9jBqxshwWf6FKOKRNRls7udMqRCBLMrXikYyxQrG4CAiXx8swQFtxCRfAARVNoCYtI0lq34rC87O3+Ta201/ztpFpgZNWb5bWw182yx68VSX6G5Eei6lqeb3wf8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518239; c=relaxed/simple;
	bh=28rW3L+4nMWFL+nhXSzHh6pgOySV65uLWE7NC0neh+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7CJDRC/BH8X2FgNLZmghlvXEluubWwwNaoxUPU9nYMIT7p4AxEG+jnTY08O+3StKjijusknAIGPszJ9NWSDr084pyk1SvcA7tv21/Dw+uWkPnmyqEbMBJ6ixSbc2TSomRbTkMUt9MLS6mFiZd34zuiEJ5ekyA3sLJQlFxo9ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2USEROi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220f4dd756eso2988925ad.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 23:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739518237; x=1740123037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ws4LKbTJycmWRh3Ik4Ggj9kxLRFUQc51QCqp+xMN91E=;
        b=o2USEROiSFsMWKvAq9/RdDSAK4f94iZSNoF0qjH9antxgF+fwhRDpH7OxLUl8nVyRG
         LjmQaV1glqmyU1XIMQvEY3F7Nbpt+r8gnkvUG8XOAnxgyK5gZbju0sc3ZA+adqLs0oud
         T+BgWkoZpTMAspWSghQrV2+wOL6cptoPeMTjSLqtKdWZPLOfudLToqpGUDhp1EDvZY84
         DFHmh/JLS7iuy6mQ96FF7u1fyJecDS5hTq2KS08L+Y7b7fszbKd/otySLnBlJ68vPIEo
         WoUWJxW9gYJturSFg76HJtTxv5Fv4DOEc7AoA0n4+agDmjcm+JVRj/rDvZ31Nf//7i8V
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518237; x=1740123037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws4LKbTJycmWRh3Ik4Ggj9kxLRFUQc51QCqp+xMN91E=;
        b=Wof5uc6Cj+kjoiT96zX2qj+zUndg26sEWfGxP9Fjdqh52efMM+RYsEr6ZCde98+IOV
         p0WW4lr7oDhkvo1PVBCqckX05WuSYR69IOdwiPbEJ8HTzXDlNtjn+4UpH5xq2ejxEUi6
         Q0EPWLLBZNJlepX58IbC3O5LnujCISZ7jHdcX/bfVnWyDHwZM/eacHBRK8UfJvU3Ud0N
         +LNkqDj6xOsvwPu3H9O/8qtsNx3r4dIqAW7Sb07/gYK2sj2004GydeCoCfPg/im6HXU0
         08StXEhhJklUc/X4Ad08oUPYbnpnB6HYxpPSROPm3ZidqCKUXLC+fMnVndD6GxzIgiVW
         LuIg==
X-Forwarded-Encrypted: i=1; AJvYcCWo/x4BHnLB6haXZzt6PDWT6Hw1BRQpAVA87aZy11zZZcDTTUdeMixIsX8EOIs4C8IwTLMRtcmM9yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvjw4AB+D/2pDyh017il3wOWgQPsAkRnVbsV/DG08all54+GjQ
	sL6BPwXA7yIERFxWq5FMtyBdnV8OmNIka7ZjOeo+TV8j4/cG/nXL/3jLn7ItzQ==
X-Gm-Gg: ASbGncv5+YOm6ZXBMZYVra6XzcfQVQ69Ntsd0/tX1wXU/ofZntmiswIvPEnCdZsqqyF
	Jtpa9j69mdzX7iPN+YPztk9/kU0eWXkcOD7ZUnb5OLCOaemsrOtcTjJdFy0e4hhN7jEnoj47MQ3
	y0ZXuy/cA50s2xwVbMmKqsJJSaxYk/C/4xXz/Z6snahwJPvj0e+64AA3u1G4Ufr2Zd9qPJ2rbzm
	Dl1mb8qIAXFP/zgBkNdc5/gtkzNSNmSvVTvCCFooliXeWXJH3uctba4WbkJZxKD0onikiOdUHll
	BrTnTBbu2HixO+JAJUNxRpjHnCXURAo=
X-Google-Smtp-Source: AGHT+IF0u2uYmR+S94peEcofW8EmAj70ydB2+yw1LVmSVhy63KgDEAG/iBAcVgqhQzg4Mo/5g9Mo9Q==
X-Received: by 2002:a17:902:cf4c:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-220d20e901amr96943215ad.27.1739518236765;
        Thu, 13 Feb 2025 23:30:36 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220e21d2453sm18272205ad.184.2025.02.13.23.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:30:36 -0800 (PST)
Date: Fri, 14 Feb 2025 13:00:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207103923.32190-1-18255117159@163.com>

On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> Registers below:
> 
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 
> Signed-off-by: hans.zhang <18255117159@163.com>
> ---
> Changes since v1-v2:
> - Change email number and Signed-off-by
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>  drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index e0cc4560dfde..0bf4cde34f51 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>  	spin_unlock_irqrestore(&ep->lock, flags);
>  
>  	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> -		 CDNS_PCIE_MSG_NO_DATA;
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>  	writel(0, ep->irq_cpu_addr + offset);
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..39ee9945c903 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>  #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>  #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>  	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> +#define CDNS_PCIE_MSG_DATA			BIT(16)

Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
have reported it as malformed TLP isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


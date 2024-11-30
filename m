Return-Path: <linux-pci+bounces-17490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C649DEF54
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CE4B21D41
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D614B087;
	Sat, 30 Nov 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amrgLxTa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129F146D57
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955081; cv=none; b=p2hogXC9iE+HsvguvuFulvzGGWs6QxeSDLkKO5s+QedyQJ8Qph/Gs6mLj7C8ciejbfbf9syKv2H+B/QGMgwmbvDlxiTuR9z9LozVx+STB77L0ja6+p3EJ3UmplfZyw2lIzIceCQTmE89l+z1LnRjX4uBzQWAjyGQuTtQ7gXgn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955081; c=relaxed/simple;
	bh=+9Rv1meKwFoGwBueJHF3aRtwWO2NMZMqX9fJgKowzDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgnq9XlMFgK3uVJ7wfIqzgEotDP26P0BEPVGz5psIY+2pIGVtR3vvqqSqb61C2WgwC/TWK2A8h3f7mzx7pjfGXoRmVFkx9mIN6Xkqmg/khxlOZ0Ww98X9UyfGhStnPi1vzk4kBUG50z2iLO9biUsk5D9H+3lRqbNy19McZiSXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=amrgLxTa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-212884028a3so16058015ad.0
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 00:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955079; x=1733559879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFSlUwJW++7AImpDWJTjlpGnjU6KAdzveqanoZG7RC0=;
        b=amrgLxTaTwoTLMW2gVdk8q3RMsEUI24efrtbc2+Bwu0XpIkqary6LtZqW7RvaCLeCm
         SCmlig19ZHvEWQ3t6FG/LbcX51MwQvy5JpUgMrQls6AnMgwTpwtbPv7t+UheE4LNB5Nb
         i+RqQvk/2kmXMDuxSpF8z+kP2Rx3QD4dnRvDjpKuansHxdE8Vdeh/bksvN0ReNLs7Ao3
         XdAKPevIBZoic7r1Sqf8NBF34JE9Lr+cJhcvaBDSMHxH5euP+Uqb2bmCSCvysGCLQmnv
         Ff1YMYoYgmrfj8NivmDMiGA+J55HgGCcC4uF3lapGa+pfK+jBPUt8n8+LYQ6KKjwc832
         2kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955079; x=1733559879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFSlUwJW++7AImpDWJTjlpGnjU6KAdzveqanoZG7RC0=;
        b=Eaey82QNzCh+hbgQufeI5+qmuHKBnLWCRtgUT+vz3Yyi4X/Hgf7oBS1iEKkSGoUZzR
         ajUMzuxhfA5vbOFUg+4YQxDTHwqQm2cCde2pzu9OjxNtSPKWIx1PXblV1fE/USIzb79U
         l62Oj5JqoG6/GzvoOA5Wlfnxeyi0J8xNwueHsC21rGsvUHxWka2hsv7N6wYN8LGMDtLb
         fi9Cv5GyDk1/dYhOMIRJLQxj/6L/vCWlrziRuCCpYlp8rRurkORYI427CK9AP8xPbYg+
         8QTyHAw4B/z0ybs7YhaSfGMefQ2VuIyGWjCr8GikC/2sDFqKjga1aOx3CyELyZF1PFVD
         SBGg==
X-Forwarded-Encrypted: i=1; AJvYcCXJyjs8gltOYOD71qh5tjQRYngUkIVUPWP4IYFwpSXFD8SNDY4cce+f48J3PQsJi+PVsLOv/p+iMfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dLQaI/VqXkAOUG2bFJibMQvhShzoUJNTRnRpzulpMUhxnOR8
	O0ljyx1JDbo9/61oqvZnDClF26joUC7iZnu6Xxxi2P6bW8xOvkrqXqsveqBrKg==
X-Gm-Gg: ASbGncsDWRiViifdtKAxdz93vSKonVLM14rl4KbToNYUvhPfIWk7oqPWJ6DllqyYmuO
	KTYcXBJl01DieH4WpmoFMtX6VXleGTGaYoQrQhStVJtIKt6gN63GphBGEZ2VYe4KrxRB2yl+tcf
	5R7X/9sYlSQTgi8lGjN3RrfklqAJZKTgOc8EtiSnmBJG9BcNlehmlNeUHhFmcAqg0kjvvgco3pV
	b0AF+9BELmR6hzcQj9A4kmKRuJTcaBlsIhjoN6kSzjJjXPRjBKUMzjuPKV0
X-Google-Smtp-Source: AGHT+IHfNrECnT4m3BYbV3Axx7kNpuLJW72y34V5NO2563h7Tp0rnefPTP0jQMid5Kvoeys/xjIzJg==
X-Received: by 2002:a17:902:db10:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-21565c2f650mr10765265ad.6.1732955078727;
        Sat, 30 Nov 2024 00:24:38 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548e144b0sm20218995ad.68.2024.11.30.00.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:24:38 -0800 (PST)
Date: Sat, 30 Nov 2024 13:54:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/6] PCI: dwc: ep: Add missing checks when dynamically
 changing a BAR
Message-ID: <20241130082429.r7vm3dpzamzrbj5r@thinkpad>
References: <20241127103016.3481128-8-cassel@kernel.org>
 <20241127103016.3481128-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127103016.3481128-10-cassel@kernel.org>

On Wed, Nov 27, 2024 at 11:30:18AM +0100, Niklas Cassel wrote:
> In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
> inbound map address") set_bar() was modified to support dynamically
> changing the physical address of a BAR.
> 
> This means that set_bar() can be called twice, without ever calling
> clear_bar(), as calling clear_bar() would clear the BAR's PCI address
> assigned by the host).
> 
> This can only be done if the new BAR configuration doesn't fundamentally
> differ from the existing BAR configuration. Add these missing checks.
> 
> While at it, add comments which clarifies the support for dynamically
> changing the physical address of a BAR. (Which was also missing.)
> 
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index bad588ef69a4..01c739aaf61a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,8 +222,28 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	if (ep->epf_bar[bar])
> +	/*
> +	 * Certain EPF drivers dynamically change the physical address of a BAR
> +	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host).
> +	 */
> +	if (ep->epf_bar[bar]) {
> +		/*
> +		 * We can only dynamically change a BAR if the new configuration
> +		 * doesn't fundamentally differ from the existing configuration.
> +		 */
> +		if (ep->epf_bar[bar]->barno != bar ||
> +		    ep->epf_bar[bar]->size != size ||
> +		    ep->epf_bar[bar]->flags != flags)
> +			return -EINVAL;
> +
> +		/*
> +		 * When dynamically changing a BAR, skip writing the BAR reg, as
> +		 * that would clear the BAR's PCI address assigned by the host.
> +		 */
>  		goto config_atu;
> +	}
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்


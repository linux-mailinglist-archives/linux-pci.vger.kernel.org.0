Return-Path: <linux-pci+bounces-5591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7989671A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5712853C2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F85D738;
	Wed,  3 Apr 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBPQUaDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BB74424
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130433; cv=none; b=sW/75nJkhwvuvs4UjTZBrbHDP+ImiBYqMjy3dNno9SLn39vfo1+5qvR7C18EVML4p1bn2Weh7WoEzVwTI9EkLHgKc8rmm9M8f8UDE8wHmudTJ6Ah96qNHqySM2H7dJgjls8Z55oueDAYCg9qwHuI7iEmnnHDS320SqKPvy9PoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130433; c=relaxed/simple;
	bh=zf1P4YjKNU49xhRHY7kdmDsG9aQEP359TRbS0DVNrc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdoS/j91NJkRnpSi/93ov+w1fqCKWbVn91S+tQ4hX53f3/yuSoreFK7lfgL+e9/sZs23DhPtaLB8hbyUPWe4PVmBRUsTeCMThZnlUSWxIv8dBjAZ8Bfm7M75yCIs4TwnMOBdH0vh5mjEmm1oD1duTrdnOAJ6U06XjEjPkk4At+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBPQUaDo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so3912059a91.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130431; x=1712735231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eyf9OUPhyFpexPCg/sbDr7vPA3r4fZY9/47FH8T//Kg=;
        b=CBPQUaDo8Fwtssq4Jpd/BEMJe1RwSSIMcE+JK8OHIqT7C3Tf9QAHXKcbOfhklizDOm
         EHqzFXHw1c3g5v4IMh+vLF3WTa2E7WCS1wjUSZB2OUqn1bfSlanDhgOZXOTrPQtnhLJr
         ZyFffDW1sxcoMbbpF32KE9/6yV4k0xzthxnssx3nq00d4jxLPG5wIv/bGW7T0TZcKwRW
         m6HdLeNTkvd2lb1dCZDkPRBJX5gIe5aC8XAKm7ClyR5F11mzkaRrfn9SBMBpPrl+rPC6
         /pwYnbIMb9DghH0pueeyWaqH1ePVF2mvtFbcmlytWw5hjoCKNgsnT/GIFUCDVd0SLwBE
         NKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130431; x=1712735231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyf9OUPhyFpexPCg/sbDr7vPA3r4fZY9/47FH8T//Kg=;
        b=oofWFPi+XnY2p0VOh6I/ozilOFnsyH33LwRIwgnCtKD7LrDYZxBKjG/DR9ghHNtDeI
         OWOLvtb+DwlS68EQFQ9ehFdgoH/e2LY/alTWoHBFNue0F992ri4bt6u54KB7XHEwPS1J
         ygnSfUNYfs0Xyn7HKk3N1hWTWuqpFEaOJOJs+kbv0B5dZ6JMqG+ozTkFFqoqrch+QWjd
         KEfs94p6qc5ZVo3ERdoX0khYJ8Wvl3eNKRQ+Ul74OZW2pJwB2RErH+boJOsjt8GcEmUa
         mMx1YVCHqsKwbbrPoq7F6vQgatfAZJu6MgzixiWD6nn3/ToqiNOPu79XPoIvDWvym0Tt
         dBAg==
X-Forwarded-Encrypted: i=1; AJvYcCVPWeyU/dkaaQHSlj+jpm67ZDc9RPsxH9WyB7/38g6wg2YX3mr1YfwE0JRDM61mRytsCjMJUXXKLzgbSkB/STKjmoY9J/LTy7Wu
X-Gm-Message-State: AOJu0Yy+mIaah3DZDStz4Tag9BuTk8QQFyt9avOsh3N5+vfUOSCgmrkp
	pbZXhLkf7zLSRC0XrcBMZ/FrnO7lucyd0kxRaIDXJ/+VZJecITxYShqSwM9QZA==
X-Google-Smtp-Source: AGHT+IHFO7RluEat3u9RpMuitm50YKfHCKMYkpyEAgDIs5j1Fv8bkoYfxAEPXlbcPcu0Z7Aw9GNkwg==
X-Received: by 2002:a17:90a:df88:b0:29b:ad3a:7b01 with SMTP id p8-20020a17090adf8800b0029bad3a7b01mr1760395pjv.46.1712130431432;
        Wed, 03 Apr 2024 00:47:11 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id nl11-20020a17090b384b00b002a058159ff8sm1303429pjb.8.2024.04.03.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:47:11 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:17:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 05/18] PCI: endpoint: test: Synchronously cancel
 command handler work
Message-ID: <20240403074702.GD25309@thinkpad>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240330041928.1555578-6-dlemoal@kernel.org>

On Sat, Mar 30, 2024 at 01:19:15PM +0900, Damien Le Moal wrote:
> Replace the call to cancel_delayed_work() with a call to
> cancel_delayed_work_sync() in pci_epf_test_unbind(). This ensures that
> the command handler is really stopped when proceeding with dma and bar
> cleanup.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0e285e539538..ab40c3182677 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -709,7 +709,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	struct pci_epf_bar *epf_bar;
>  	int bar;
>  
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		epf_bar = &epf->bar[bar];
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்


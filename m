Return-Path: <linux-pci+bounces-5592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5489671D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AC71F29142
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463605C90F;
	Wed,  3 Apr 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHKTTYTx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E0286A6
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130512; cv=none; b=CCVCy2ByEroVhDOuEZPoJAxJB2kU8D9D1BFG9vYO3Kn+Lkt+8A0ZNL2L8oV6xg6b23n2xoBVqPIXz/Qwymfo/Lhw0VSs4iQEhaKVJdBEf3ktd2TCPgFj59I5s5hgAV8jl5eaaTSJOIvFVf7VWuIsSs7zkNfb/kupLvxEgWrIFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130512; c=relaxed/simple;
	bh=OZCWJyZgp+qNMYaaO6OuRtDvknKTFDJ6C9xvIxJZYWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsxPgBe6CgBzEp3vvyeFbJCze3VNM6WzzCfBr46temRFlicXVGrWbJ+Y6YSO+cyvbTquHO9vhjJXg+T8JXpotuShsYrlvetv7bdEizosH9Sx8DPi259WsEbU9IioYQLRyhYhOulfPqjyrVRXAgJ2tg4GRIb0K7CPq9XVGyH2184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHKTTYTx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0411c0a52so51522335ad.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130510; x=1712735310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oiLhE3nJcxEv6fm07mV5XlsWCD0O08cn9iKLU7OjZzY=;
        b=RHKTTYTxaY6CcIi8QdX7W02/oKr82d7NzKwojKY2hMn9LCl/2nVLAFcF9hVvFqQvvr
         xrqe7WeqTGYknHjFxDVI/mndVNrRBgAz6K/MKojIbms4kGVfQIhiugcYlvjs1IzcKnkK
         hO9b4RLKOniYSNMSawL1qxyiEpMdxnBekiZfrVOJP4BZj28+jyH/lN7pwkK9kGPJKIFJ
         /wgCgfp2nEFpx78ZsXHE7gfECdaEC5nF/D+8ThUs8mHJkQRCLMwH5NWfAkrxipPH+I7S
         RxFTPkzHI/pm2eWoIEJhPK3qON/o/PpFLjtNfY+UY2+MZRCAIKH7hTkOEuCuI7GPzKAI
         mYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130510; x=1712735310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiLhE3nJcxEv6fm07mV5XlsWCD0O08cn9iKLU7OjZzY=;
        b=BUS+KGGClbjJpyc3ELXJXTtdyu5pE9YyoUBWMaWh3yC8QcvYo33qA6FAs9Z3htzZIa
         IzzGO1DTVLzpHkn4U+E0fEue8CtrjOIDeGkdu5t3e0JCvMXNVqu6g1oTR5JeYvMNB48s
         2hiB0AREyVLvGsEOVykdcOKuEKuONxNbKfcVe25MjAAQDWUQOCgsvftk+h23n9m0qVdH
         6s3uM8McANZFT7sGPjDgvWaFD74upmFO7z4/NITsttB3rLAHYAL0dx/8N3gZwGrsJm7C
         KKEqdmfqByjcK7yYmgUpnFeGtEiF+BW8pHZ5ktLiB0qt5I3GV97ZC3pzZRD7+YQE3KXB
         FVuA==
X-Forwarded-Encrypted: i=1; AJvYcCW1q3nZ37d8TVzXfVip+jSq0HhvX5OnI35E3dMw9tfpFOBRaCFzEZtPfj8PZ9BRbiYWmDkVAgxz0RTFSdVQx9Plj5K96fJWjZwf
X-Gm-Message-State: AOJu0YzTTXO6TTq3lsGkPFu1QW6IO2lf5qgG4BJlz9EwJAb5kR3g8e58
	n48gpU/8smqfC8789aPTlbRytAH7o+gOaNpJvRxKkuik3mJVfyK9klFbP/71rA==
X-Google-Smtp-Source: AGHT+IHNyPa653DZR4WUPhXaph3qHIeFF1sftZgr1SEp+rlYp4MQGikAbqndRiCsKzJkwfzdnQDVWw==
X-Received: by 2002:a17:902:64c8:b0:1e2:7879:9646 with SMTP id y8-20020a17090264c800b001e278799646mr2958847pli.36.1712130509976;
        Wed, 03 Apr 2024 00:48:29 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001e0942da6c7sm12473372plc.284.2024.04.03.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:48:29 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:18:23 +0530
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
Subject: Re: [PATCH v2 06/18] PCI: endpoint: test: Implement link_down event
 operation
Message-ID: <20240403074823.GE25309@thinkpad>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240330041928.1555578-7-dlemoal@kernel.org>

On Sat, Mar 30, 2024 at 01:19:16PM +0900, Damien Le Moal wrote:
> Implement the link_down event operation to stop the command execution
> delayed work when the endpoint controller notifies a link down event.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

This patch is already part of another series I posted [1] and under review. So
this can be dropped.

- Mani

[1] https://lore.kernel.org/linux-pci/20240401-pci-epf-rework-v2-9-970dbe90b99d@linaro.org/

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ab40c3182677..e6d4e1747c9f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -824,9 +824,19 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_link_down(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.core_init = pci_epf_test_core_init,
>  	.link_up = pci_epf_test_link_up,
> +	.link_down = pci_epf_test_link_down,
>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்


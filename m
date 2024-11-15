Return-Path: <linux-pci+bounces-16815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96D9CD700
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655881F2227C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479AA1862B8;
	Fri, 15 Nov 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICYYqrld"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276A175D5D
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651617; cv=none; b=FF7tBZDTW7LdRx1X5KEAzgfRSmKr8XgBIHwIbS9hVty5kUwxyoqgUqSwHHGmbqmUAMj1WvgueQqmqOdED6L2xhBMFD495ZpQwLWdgg8oXpPFbHxwAYYG0ScPieCwyCBr7JU5PbGZF8l0m2VISozFua1JI8ZKoj6+zBJioU8shtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651617; c=relaxed/simple;
	bh=O3WtPpgxqXZU/97gRh2z3OoHJn5s5gnDPic2IlHiwVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkxCeO+v1NGNIAbSg5mXdL7B+9CeSFYNDkbepq6V1jNAs/ND9ZTSXpMAP8hcH8X7mA63aIukDZVJRQZtoHj7cth2fbQvS+vKUvVlIFhsnnCTZ/3aPDXIyswn/HMBxhU7/c6jHxLNC9nSItwVmhIX206YhbgESsw/5fQI7ZhNlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ICYYqrld; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so14884865ad.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731651614; x=1732256414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gKUJ2cNG0t/qB73uD+0bQQcA1KeJf1H91Ybk4Lvf6A=;
        b=ICYYqrldnEUjt5J4fmEfgztR01XEkRfBjgqtaPzzFgvP9Q8oI9ugFnX2G3LhLsaRJE
         j+gYKmQoQXsVM7TenIJbhjvHjPVq0GS8EHmCULp62UNMN1Sv5vUPMHAVnuExvnfqvout
         5OZync4jL1Rj8cnalBhxvcApuECCe2GFJV1DAXDVwSEmrdpQlbHOXC7qVALBObA6AScP
         9IcroUv5PD2lbvzyKHxYwb3ogqKadwNZqcntAxC0vBXApeGx2pwkw+nLV9xgjY9xi70y
         6irIX1CHPvNf0srxFpQOzw9NjzzTMg6hgCTTDjQ+3KxjQ+VE+oxftYURoIFysybaiOx3
         Z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651614; x=1732256414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gKUJ2cNG0t/qB73uD+0bQQcA1KeJf1H91Ybk4Lvf6A=;
        b=sxfsJjUVDx3iP8uInpQQI4Cm1X213SBGLxd2jW11zhn2kznqTnBVlxHiw7wMvVAQFE
         jSNFTRLObwU78gwgLHm4f/Xf+A4zf7mPjIDGyHrmTu+2nBWF3Vs5A5JpJo/+od/v1oTH
         oBb4JQc+3S9viCYiU3wNLemUuh7szSyzllZrrvokV5MwNNUWNNfIxEU03sUFX13Mscab
         PsKXwzlR2/P5OQh1XDvYcQSLA3+JWoveyty9ww6unFgM9SsFt7l718ZMKmd4mdWuCsU6
         cHxuoHOomdk+deEpPzuLi0GYDXmPhhb+6pjSltt3THmA6NerrtfE/r/g1k5kPU/P96xl
         9gIw==
X-Forwarded-Encrypted: i=1; AJvYcCVb+GgJjonrUxuw1clbWgFipvbuaFNPiz99nTWNhQxx87JT+yB6SGiurz4otlaqlx490cEYVIwHUTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/COKrfknHXadSNZ5qpLRycScOqF/AjyraoNxrnJpCYmNShCn8
	CctmaM5S+gkw8h0Xgr8m++gsB3wajbW70zQh0P5/VsFrAfRHLjL24KSo1oEabA==
X-Google-Smtp-Source: AGHT+IEbADa24OOCr64EMECKMnFPpNDtB+pfm88K+JWVfITt31bJPhoSBXJFkrjbhoFDajn7rZEVFw==
X-Received: by 2002:a17:902:f651:b0:20d:345a:9641 with SMTP id d9443c01a7336-211d0d8444cmr20995845ad.27.1731651614011;
        Thu, 14 Nov 2024 22:20:14 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47b62sm5786625ad.175.2024.11.14.22.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:20:13 -0800 (PST)
Date: Fri, 15 Nov 2024 11:50:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028084644.3778081-1-peng.fan@oss.nxp.com>

On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer exists,
> so of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA, even
> if the IDA was allocated in static IDA. So the flow is as below:
> A: of_changeset_revert
>     pci_host_common_remove
>      pci_bus_release_domain_nr
>        of_pci_bus_release_domain_nr
>          of_get_pci_domain_nr      # fails because overlay is gone
>          ida_free(&pci_domain_nr_dynamic_ida)
> 
> With driver calls pci_host_common_remove explicity, the flow becomes:
> B pci_host_common_remove
>    pci_bus_release_domain_nr
>     of_pci_bus_release_domain_nr
>      of_get_pci_domain_nr      # succeeds in this order
>       ida_free(&pci_domain_nr_static_ida)
> A of_changeset_revert
>    pci_host_common_remove
> 
> With updated flow, the pci_host_common_remove will be called twice,
> so need to check 'bridge->bus' to avoid accessing invalid pointer.
> 
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I went through the previous discussion [1] and I couldn't see an agreement on
the point raised by Bjorn on 'removing the host bridge before the overlay'.

I do think this is a valid point and if you do not think so, please state the
reason.

- Mani

[1] https://lore.kernel.org/lkml/20230913115737.GA426735@bhelgaas/

> ---
> 
> V1:
>  Not sure to keep the fixes here. I could drop the Fixes tag if it is
>  improper.
>  This is to revisit the patch [1] which was rejected last year. This
>  new flow is using the suggest flow following Bjorn's suggestion.
>  But of_changeset_revert will still invoke plaform_remove and then
>  pci_host_common_remove. So worked out this patch together with a patch
>  to jailhouse driver as below:
>  static void destroy_vpci_of_overlay(void)
>  {
> +       struct device_node *vpci_node = NULL;
> +
>         if (overlay_applied) {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,6,0)
> +               vpci_node = of_find_node_by_path("/pci@0");
> +               if (vpci_node) {
> +                       struct platform_device *pdev = of_find_device_by_node(vpci_node);
> +                       if (!pdev)
> +                               printk("Not found device for /pci@0\n");
> +                       else {
> +                               pci_host_common_remove(pdev);
> +                               platform_device_put(pdev);
> +                       }
> +               }
> +               of_node_put(vpci_node);
> +#endif
> +
>                 of_changeset_revert(&overlay_changeset);
> 
>  [1] https://lore.kernel.org/lkml/20230908224858.GA306960@bhelgaas/T/#md12e6097d91a012ede78c997fc5abf460029a569
> 
>  drivers/pci/controller/pci-host-common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index cf5f59a745b3..5a9c29fc57cd 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -86,8 +86,10 @@ void pci_host_common_remove(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  
>  	pci_lock_rescan_remove();
> -	pci_stop_root_bus(bridge->bus);
> -	pci_remove_root_bus(bridge->bus);
> +	if (bridge->bus) {
> +		pci_stop_root_bus(bridge->bus);
> +		pci_remove_root_bus(bridge->bus);
> +	}
>  	pci_unlock_rescan_remove();
>  }
>  EXPORT_SYMBOL_GPL(pci_host_common_remove);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்


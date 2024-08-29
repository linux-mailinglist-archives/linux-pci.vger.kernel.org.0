Return-Path: <linux-pci+bounces-12404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165219639F0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AD3285A30
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF731494C3;
	Thu, 29 Aug 2024 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dk7vYYVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8613C8FF
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909848; cv=none; b=PA33seyYJPl4zyKrOp7g12HBqsK37B40LkZKRCOCawH3yn6F3aCi6Yr/aEALGl9BQ0Fgcrx4DJboWd8EEWRJQmD/vT9XsMotP1o/k1f+VYTafCjWpSKxhmcAadPz4Q/W0WINga4orEGD0C/TIkrKpiq2ro8Du13r8jnwMvX1YvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909848; c=relaxed/simple;
	bh=qD7ebZNdArLGz1UyWTFq1yDHD6DlP1syHwDD/mleSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgMDZge7HJ1qXH8XTpFC0o9TOlkwxuzrq2G+zwnrs+VSZqm5UuvrwAIUlgMqmIcRu04mdV+X+e0BaG85dn8pr+CR9WEY15zY6AJeGexVTvX1Jywj4UfOIOe5H8FM91MNvFe0gwUCSdlA4yUZAVrYTJ1GIpiJ2N3FnW5kI1fO81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dk7vYYVi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20231aa8908so1948155ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724909845; x=1725514645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrVNScHyA8siqcwGagEWT1GIw67KMMaKbjDlL/wsrMY=;
        b=dk7vYYVinR/IBIupn+u5ltPPtbh0w9rlT3M/oClFO1KIty3XBQXV4j1z5CQx0Z5lHE
         FittyhTW6jfiNpPVr5cRDWDSyVr5iG7GM003TWrLgYip+wDNgENimqM8JyfczAB4i/ps
         PSxBQpxKIPf2IjTIqK3gaBLMvOFV23onuTfn6s2TUx09+Wl1X41jZG7qvYcdptWSQbzS
         fXL4T1Nj36JVCo1AsYdOV0DEW0bjBARzrB4s9ceuNCqa/5MNYpi3/AxN8ASmN6SN9pQZ
         zC0ULqvKdAZ3xXWf/OEaDezWbvVN4Hc3JzEpdhrpeExUohoSDUJpvZOETxdFwTK3o/WW
         tSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724909845; x=1725514645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrVNScHyA8siqcwGagEWT1GIw67KMMaKbjDlL/wsrMY=;
        b=OP8T1DiUy0Bys5ubVAsP+UkO0T0czz4+WcL7QlEbajI3XzAhRlgQlWX5PY2g10Cyun
         kchbLoLWc8ZvKdq4iTVvA4SkVzo5xXSgqdMx+TvqpXERRBcF/RYNgF+12aA14UuUfDOO
         KEcaOl7ORi29czT85lXDkB0R/dpzP/jRrt7d1JjXlHqO1BENZmGOu3a3IMqFWL2pqlBU
         9yRo0UpVWsODO7HoDIJE9eaiVtYf0DHPOrJ1AvE1lfGBtO2hKkvViQpqI6yibN7CZBpf
         0rKf511Jhm9XEunmZRiidGFyTIRCKTgIaZjUAcx+gg9aE4I6jBPiLiQ/ADPeKJpgjkaY
         MU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUl/rSc9mzX67RqQGZN2xSG6YCjbsTthH3JRP+HXvgES7bx8YUc3S+Q9d01Dy9PiGuqvWix9ZaXeS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhaL7VOxYRbt2LixSufnpHqJtZUR8/Nk3EnrNOCjKPXtr82T+
	JBXYlKyYabM5tFmaxPZWEFAVzL2jPIUJUgfLB9AKNgv98YuMTS50tX9JCr+1FA==
X-Google-Smtp-Source: AGHT+IHYVzYFsTDl7Qb0RREM7yv53xVhDCi5Y3JRA2rhvcxmy5c8PWS8Jb3jlzDACM6hONljzDoqvw==
X-Received: by 2002:a17:903:2350:b0:1f7:26f:9185 with SMTP id d9443c01a7336-2050c34fd6cmr19991505ad.10.1724909845213;
        Wed, 28 Aug 2024 22:37:25 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b37d5sm3814485ad.25.2024.08.28.22.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 22:37:24 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:07:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240829053720.gmblrai2hkd73el3@thinkpad>
References: <20240828140108.5562-1-manivannan.sadhasivam@linaro.org>
 <20240828205945.GA37767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828205945.GA37767@bhelgaas>

On Wed, Aug 28, 2024 at 03:59:45PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 28, 2024 at 07:31:08PM +0530, Manivannan Sadhasivam wrote:
> > qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> > enables the controller resources like clocks, regulator, PHY. On one of the
> > new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> > on all of the supported Qcom endpoint SoCs, refclk comes from the host
> > (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> > whole SoC crash on the new SoC.
> > 
> > qcom_pcie_enable_resources() is already called by
> > qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> > available at that time.
> > 
> > Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> > qcom_pcie_ep_probe() to prevent the crash.
> > 
> > Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v2:
> > 
> > - Changed the patch description to mention the crash clearly as suggested by
> >   Bjorn
> 
> Clearly mentioning the crash as rationale for the change is *part* of
> what I was looking for.
> 
> The rest, just as important, is information about what sort of crash
> this is, because I hope and suspect the crash is recoverable, and we
> *should* recover from it because PERST# may occur at arbitrary times,
> so trying to avoid it is never going to be reliable.
> 

I did mention 'whole SoC crash' which typically means unrecoverable state as
the SoC would crash (not just the driver). On Qcom SoCs, this will also lead the
SoC to boot into EDL (Emergency Download) mode so that the users can collect
dumps on the crash.

As I mentioned in earlier thread, I don't know how to avoid this crash entirely
(host asserting PERST# at random times) and still depend on refclk from host.
The best possible thing we can do is, at the time of PERST# assert, we can
notify the EPF driver to cancel all the work and not touch any registers that
require active refclk which is what the driver currently does.

And I'm also working on SRIS support which will allow the endpoint to generate
its own refclk and planning to make that mode as the default working mode.
Still the users could opt for non-SRIS mode (current mode of requiring refclk
from host) through DT.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


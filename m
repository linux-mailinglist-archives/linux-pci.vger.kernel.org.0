Return-Path: <linux-pci+bounces-24092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38FA6899B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E21770C7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5EA2066DA;
	Wed, 19 Mar 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErdaFt3H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468533991
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380346; cv=none; b=F2fTelF/cX0uDECj6HKq9S70t+ynTE8FYvWKMRS4u6WaRlHe+PaJQyNc/N2QJ47xwSOBmlCeDb0pbFwdVQ4BUv2clz0jcNHC1wEWcw77A/gT8BOyeRO03Ux+LNtbGEwXKKVtcFr4G2KbdzER3PIw6UcnMyJxeyWtZ75qMZ/zIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380346; c=relaxed/simple;
	bh=XpIZsgmvvxNNIAMRoNlx26gRU9BTDC3eUsBzOPt2Ra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PziNzMprJPXzY2D17+jJAVyyFib13pH7E+jXkbdDjC6FeU5NDpiDgqKyvYDhLSgiCoN3/gNqe1nMGYUXpK84U2dgEqYLfsnFk7I+0CZdJZzQBbNEaNaCoTJhtj/of2TtWmaktgeuJ+NYc77cRb4lSFVkZCAcQXmo1Q2mfm1h5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErdaFt3H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264aefc45dso13317515ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742380344; x=1742985144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evNZMhqkj1ttyktAM6FNCpZ80KvQoIj6HuNmJYBDqp4=;
        b=ErdaFt3H2S7cxn20jmO0GT1cBQWHrsuCcCWaLnlCx6zeXV+btG2kMAVqWgchdYrX89
         lMptYFL9CUUR2JomolmU/bwAoTkrjwm9TrmPdjF0FfnBx6CCVsa2dJ2KQx1OGoyUdFFq
         daWUYM9/9HatJvbWX9BqNaPvuTbQ0mgVlkfHhcWOUqMrqN4Duqhu/ma8lpAIg0C0eU/G
         h8oYHF6cQIAHitgmwflGqCOeaYNpdA108xCcOV7GSYXveGrllP9JhqWlH/lcbtcGotLP
         iTjlT2TWavYASjGazNlqHGwqARN1wjfSowT6Q3iLyaNeopWpqEMEhOclcF47iMoAZSkQ
         W72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380344; x=1742985144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evNZMhqkj1ttyktAM6FNCpZ80KvQoIj6HuNmJYBDqp4=;
        b=PdHE3OJPHM/xLTFN9dK/HBjCsqHkjpoq3jYh7gsB8OlZ0RtO7Id4pQ0M0ZpSjJkLOX
         bcoTbjk0ub4VuqK0YRuwz9k3AbrLFZVQJwfEW48RxE+fnmR7iWelkRv9EYGHs8P0JHdy
         Kw52ye9wRDgZuYmmszzUDjd0QEYBuP8zfmZ8T7OoZJhX1zjP6E6DLH57B+gM0yu1Pzki
         98uBweqgMfgS+CVCOXBUyf3x//GBYnPQHyh18ieGQ3eGo7bMZ1G940hH6itttBVB5UTT
         xgQO8BR11Srue8MEdw/hYFCKDTTbYpqbV0QMt4yMMSK2OwYehPFOaEjijaKwzchMRepH
         pF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaB5d4KfZM6hsAHyDLajYR71E9wmHDEjBTfa0FedVW/aYVDFe6y/ddIAhKOMOp18xSOM5cfCRhbfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYpMnQML5P+eYA/5Vk+tZlFePXOoV+dOi4mLFmrQlvt852dQ0
	WV+SCUT1lFoxnJ4awnPo02CmYmQKtQ8xfiA70xww8GswIHyBLBLXglt1yiOWmo30wbZEajrYQLo
	=
X-Gm-Gg: ASbGncuRFMPXOeAt/x0k4IoEdlJTncQ2ozIA6COjhtRpVD1E6KPPz2ZiNHmW/Zi+9fe
	k/JyOnq/Av7TO8HKHLQYsyvo3di/T+O8YW9Emwq2Ezz27AhUUo0sDp19QQ8q22lX0HkNX4tuOEw
	3groCxSOfWSJvXs5WFZkisgs2WM7IFggfZG8tuNFhLwS0XTOGcK3UyI7iugdR4+IolOt9PYQ+iP
	DTojrG/23RAFwbgTbOZRXWr7LZKnwddcwvdIYZCuNFwgzwR6gr13LVy5IxTWQvvvN5laP+tU5I2
	ooiZhFWlczlI2xnVBOS8R8DBeydLfocM373jLZED4u+S27JiTrE2HAU=
X-Google-Smtp-Source: AGHT+IEP6MgbdWZWJAzv7d+SZahNfAT+u7CepjEY9PXUCqNZUa5QkB79CIbo0WUj8WbyfNiS2xiL0w==
X-Received: by 2002:a17:903:2287:b0:224:1074:63a2 with SMTP id d9443c01a7336-22649cb2f7fmr35461815ad.43.1742380343853;
        Wed, 19 Mar 2025 03:32:23 -0700 (PDT)
Received: from thinkpad ([120.60.70.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6c8dsm110467105ad.156.2025.03.19.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:32:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:02:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <20250319103217.aaoxpzk2baqna5vc@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
 <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318081239.rvbk3rqud7wcj5pj@uda0492258>

On Tue, Mar 18, 2025 at 01:42:39PM +0530, Siddharth Vadapalli wrote:
> On Tue, Mar 18, 2025 at 01:33:04PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> > > Introduce the helper function cdns_pcie_ep_disable() which will undo the
> > > configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> > > by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> > > to cleanup on their exit path.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
> > >  2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > index eeb2afdd223e..85bec57fa5d9 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
> > >  	.get_features	= cdns_pcie_ep_get_features,
> > >  };
> > >  
> > > +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> > > +{
> > > +	struct device *dev = ep->pcie.dev;
> > > +	struct pci_epc *epc = to_pci_epc(dev);
> > > +
> > 
> > pci_epc_deinit_notify()
> 
> I had initially planned to add this, but I noticed that it is not
> invoked by dw_pcie_ep_deinit() within
> drivers/pci/controller/dwc/pcie-designware-ep.c
> Since cdns_pcie_ep_disable() is similar to dw_pcie_ep_deinit(), I
> decided to drop it. Current callers of pci_epc_deinit_notify() are:
> drivers/pci/controller/dwc/pcie-qcom-ep.c
> drivers/pci/controller/dwc/pcie-tegra194.c
> while there are many more users of dw_pcie_ep_deinit() that don't invoke
> pci_epc_deinit_notify().
> 
> While I don't intend to justify dropping pci_epc_deinit_notify() in the
> cleanup path, I wanted to check if this should be added to
> dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
> is different from cdns_pcie_ep_disable()? Please let me know.
> 

Reason why it was not added to dw_pcie_ep_deinit() because, deinit_notify() is
supposed to be called while performing the resource cleanup with active refclk.

Some plaforms (Tegra, Qcom) depend on refclk from host. So if deinit_notify() is
called when there is no refclk, it will crash the endpoint SoC. But since
cadence endpoint platforms seem to generate their own refclk, you can call
deinit_notify() during deinit phase.

That said, I noticed some issues in the DWC cleanup path while checking the code
now. Will submit fixes for them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


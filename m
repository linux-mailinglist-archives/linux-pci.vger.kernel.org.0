Return-Path: <linux-pci+bounces-27744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65484AB7171
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E4A189927F
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AC1C701A;
	Wed, 14 May 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdSiqa6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229517B425
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240401; cv=none; b=i9bz8ADTI9MOdampdWwSdylUP+SBepxCgQarFMz963IzROo/OJWb66MQ6iVVQfzYpmrvLxUzRyX3vWm+S/ckYIqan9phIaIH+PCZZ7fquiwUgzcakeIWxsXIg/Rz9h86vjyamkrlULDLUsXpLBI44zd92rwW3snI5jfF3JT4xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240401; c=relaxed/simple;
	bh=EylYPAhha75brtQOCOFRFeLMtFLPLOh7si42ePDVpmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9Mnp+CIF/BJ1YUM6s+g3QPNQuSnJeCmv1liEaYnO7CWo/ER7ZmLrjnSa7oh8Deih/xAHQ5Sy8q0ta+gBks+wwNoZlwktu9rcT3gzXbYhTVwmmEnZlievJlq6ig7D0k3m1550qogeivBYxShx5gAnOMtKtxwyLkwbiD4ujencGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdSiqa6h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso291975e9.0
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747240398; x=1747845198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkj+eXJWD3zKSY4LtYDXeZfa8DE+DGWzE6g5lQpJzPc=;
        b=xdSiqa6hvuXiOyFBoYrJ/qa8BH0LD5qlfFkrPt4y5a0ArnBUyLelDpzRwxMxJ863MU
         bukhI4mqSbdo2+9RCPvujtd7i8tVtUwmutj223iNUiDoOHdQbPsUJ2HNj9RHvHUf/M/X
         TvY+Jq2upBPF5VEGFfLYFKq2xhZCj8BQDvHHxLaBbN/BM2/LgJLt7ilHte78vDlEI1nJ
         9ykYDL7BHTtCuyU7KyLFUSv/E/lUUj0NmXmZurOCnqVFPMXCVtRPxUDM1dhIELV2gsCm
         +NCfcfOHkv9mgPw6JfBqPgOv7vKA/1nIS/+kr3oD73KEJCNEYrQkbBsey1n5I7CA+DIt
         kCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240398; x=1747845198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkj+eXJWD3zKSY4LtYDXeZfa8DE+DGWzE6g5lQpJzPc=;
        b=xMkcNKrkbK3c4L6VUqEVG4uGbV4/o2dm7Qyus8A5Zlwd/kTqPfub/ieSXpBfEpbsaZ
         QAkUamYNQpA3QVFklwvJM20GRLqnBR9rRw1wof5bxJ6OMR6tKP6BVLND6dlBX0JHadNv
         ylqIRQjTknLVNLki3Q3sDYpcRAtQei2WdbMZj+DFJTdgK0yjM+s0lOurpb+Qh/su3Itn
         HRnHBNLuyx6rAtamM3Fhw49aVwK58IHjaiWQeV+POS8QXZjw8XLxQesuoh7U+3+IP8W9
         suRLiEInrBfllz8MIrMiFTgEogYIUfGY20s62MGqB/ElMXZHPgFq0uWDjs207+fuzptg
         0SYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEW9ci9z5GK4Et7y5gT7qArhVc0T26TT3vfahh+DrX3DJqXGErLTOsD4dUOY4x996/awdmNGztijY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywn7ni8MjBSt3b5PnFyZ8z6pfuQGTXuCe3wEpxuBUWiYwgrkX8
	KEcAe/S/BKep6di49WLCFTe0whjrBiUlnadFggWvcDzSKHWXGhXPddfJwZ1tmw==
X-Gm-Gg: ASbGnctL4UcwGsjFb/XQDtgOB9s4LuuUXWrtv3UuFWyFo0VQcX/tpafjXNbaUM4zR9p
	zDNMcmS/W9qyeGCD0+qoMJ6TVHovGtVI5G5GRA+QZSPkXf97w/4lXN/PiIUK8vG+wfNm2XBsrw8
	plCalcIzXS7FcnIX/qCh0NyCinJhw4nBaxsGQgiWLP82ULfoVcOOa1XXF+X/RR9qhduE0lFYkZ+
	ugnajBkD7jxn43MzSgtiFJPoXbsU20kkyOmdfl1VpigX0xDbc52cO2rOWaK/s2xJ9kPX3jhMY8G
	hAc0dZs7c2l8cjQUPeoMG+DkZlXysYYEDbu3y6FIhFKf87Zs532Xd4KrlaLIFx5w9AaK8KUuDPT
	5zt1/47NkufwUiw==
X-Google-Smtp-Source: AGHT+IFPC9mL+DlWLaHagO2PQibPE5IAsRnVspZO3QJiVtK+BzyLXCvkMi6qfUPBM+PpkrIO8X/e5g==
X-Received: by 2002:a05:600c:b8c:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-442f4c8fe71mr33161715e9.16.1747240397611;
        Wed, 14 May 2025 09:33:17 -0700 (PDT)
Received: from thinkpad (112.8.30.213.rev.vodafone.pt. [213.30.8.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951b57sm37447745e9.21.2025.05.14.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:33:17 -0700 (PDT)
Date: Wed, 14 May 2025 17:33:15 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <dglc4iqxxrjnbpqazi2xuzdblpcszcdb7q5nlz2ezzzyeujpvc@672myo6djcji>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
 <8006a0ae-b45d-d22f-65a9-20a65f3224b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8006a0ae-b45d-d22f-65a9-20a65f3224b0@oss.qualcomm.com>

On Wed, May 14, 2025 at 12:00:11PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 5/8/2025 12:40 PM, Manivannan Sadhasivam wrote:
> > The PCI link, when down, needs to be recovered to bring it back. But that
> > cannot be done in a generic way as link recovery procedure is specific to
> > host bridges. So add a new API pci_host_handle_link_down() that could be
> > called by the host bridge drivers when the link goes down.
> > 
> > The API will iterate through all the slots and calls the pcie_do_recovery()
> > function with 'pci_channel_io_frozen' as the state. This will result in the
> > execution of the AER Fatal error handling code. Since the link down
> > recovery is pretty much the same as AER Fatal error handling,
> > pcie_do_recovery() helper is reused here. First the AER error_detected
> > callback will be triggered for the bridge and the downstream devices. Then,
> > pci_host_reset_slot() will be called for the slot, which will reset the
> > slot using 'reset_slot' callback to recover the link. Once that's done,
> > resume message will be broadcasted to the bridge and the downstream devices
> > indicating successful link recovery.
> > 
> > In case if the AER support is not enabled in the kernel, only
> > pci_bus_error_reset() will be called for each slots as there is no way we
> > could inform the drivers about link recovery.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++++++++++
> >   drivers/pci/controller/pci-host-common.h |  1 +
> >   drivers/pci/pci.c                        |  1 +
> >   drivers/pci/pcie/err.c                   |  1 +
> >   4 files changed, 61 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > index f93bc7034e697250711833a5151f7ef177cd62a0..f916f0a874a61ddfbfd99f96975c00fb66dd224c 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -12,9 +12,11 @@
> >   #include <linux/of.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_pci.h>
> > +#include <linux/pci.h>
> >   #include <linux/pci-ecam.h>
> >   #include <linux/platform_device.h>
> > +#include "../pci.h"
> >   #include "pci-host-common.h"
> >   static void gen_pci_unmap_cfg(void *ptr)
> > @@ -96,5 +98,61 @@ void pci_host_common_remove(struct platform_device *pdev)
> >   }
> >   EXPORT_SYMBOL_GPL(pci_host_common_remove);
> > +#if IS_ENABLED(CONFIG_PCIEAER)
> > +static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +
> > +	ret = pci_bus_error_reset(dev);
> > +	if (ret) {
> > +		pci_err(dev, "Failed to reset slot: %d\n", ret);
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> > +
> > +	pci_info(dev, "Slot has been reset\n");
> > +
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> > +static void pci_host_recover_slots(struct pci_host_bridge *host)
> > +{
> > +	struct pci_bus *bus = host->bus;
> > +	struct pci_dev *dev;
> > +
> > +	for_each_pci_bridge(dev, bus) {
> > +		if (!pci_is_root_bus(bus))
> bus here is always constant here, we may need to have check
> for dev here like if (!pci_is_root_bus(dev->bus))

Good catch! Ammended it while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


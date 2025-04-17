Return-Path: <linux-pci+bounces-26068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D1A91580
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FB5189E38E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5521A431;
	Thu, 17 Apr 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQqR4Pm8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EA219A76
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875738; cv=none; b=mCAgjEhqWytDcIe0Eyh2QuJAuxGi80eycS2euwaahyFQ5yK+eRUbT4xIMhFWvU+f+ckXBfCulUfU7KKwmfIdvMmZMic2R1Aj2tOY3vs1PgPNMkWO+bpxC1AwQEseUR4ezjgasHahLGcBBC03phtjPK+HTqt1XwJFYcROeOAb0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875738; c=relaxed/simple;
	bh=mVQwtEZSIlgHa/mm1mmUYoeDx30+E8QTcMPkDxPlNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxsITIIbQVd48gwBe+9Ycm1x8XBHV4CqwqGvEnc03pwLQdriUp3ZRJciwnQUzqsIUNsG+KCXy8aO7XmaGaLzhTMkNCVsSi1BwjHxttVCSuCHW2RCgRz2yOckF/RC42zEXeDcRuCN1ypk0Z9QhPd/wKwj9EgZdsXAlDytxTu8tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQqR4Pm8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227b828de00so5161665ad.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744875735; x=1745480535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDgB7wJ22ie3HmeLXVm86GHefERwHEPMmaPgZUtFTeM=;
        b=wQqR4Pm8rBZKdlxXyseRgKtd9U9JpvKFaxiVpgCLU69FG7KhNy3kcP064s6ki0Cabx
         H3nhgMN3CavkbM0vZ7svGG+PzM4ZLYWrVwNOz7OvR4KLKbMcOs/r8IMyumx+MJL5xa2h
         B7s7sCeZGLgfKdh0KWN5LXfqzfHSmYwYp1drtgqYeELQVcyk5PvKv2qDZfQWcXCkdGf8
         K47PsP2JXVDe7YjntJMr5OgyHcR8hWbCu0A27Qto6czighlnSyqIsoZOdEJra60xtudP
         8+90v6WsznqbIFsIbmQZrKki8WdDv7E3kzTJd4Uk8iuMtfsM/NvC/Tyk6o67AVJVg/Bw
         G+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744875735; x=1745480535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDgB7wJ22ie3HmeLXVm86GHefERwHEPMmaPgZUtFTeM=;
        b=Ew11MuOXTCtjozzH26Z7DtM4Ouz2w5TjzXIaNlo/g0QdQakeAnykEc00UFtNqjnBbV
         +jhzO6KkGPA0yKytoERfcMQmACS040FEfMnAn4830tm8obxRVpGOMjF9CVKch8Q343pX
         jnKbQd0/I7jlce2yA0qCMkHaEIG5HYWXLiswiOK2T/4t0lSciTJQ0bpfcfLcaiLL7a2m
         H7YR3wzNls9lm/s6fLPtzWEY/D0IKVrS/OYJf4NcjFlgn/6uGWBQEZ0JF+s9BpY0sUss
         NLcBpfYzyH0hV6CHGJm2wD37NJN8CSVIffTG72sqq6hpGBcSYZkb4gw2rXI3f3oGu58/
         nk0g==
X-Forwarded-Encrypted: i=1; AJvYcCWjhXzesjdvW+vffFtXnfi7m74ik9r1eH2ZxOgXzchW7ORkHChX/OgUHavOFE1zpO8QhuJQR/Hc8mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiDaxnje4Epzq509Fpnlg41aoIdGnmSk7Mrc9pdfwTPBDOFHs
	cE0FMq1Ynmc3IE0+jG++lFMekWtElYteTez28hWHIlmAbe+Gk1DBj1YVlBnDTQ==
X-Gm-Gg: ASbGnctNemP0rCLslmlOyLVb9GlfmnXoOuPgc4yTOfoQaFskBe0EWjOziywBq9WWjtO
	4vxqmx4NIVxq98oT6xoFBfkUXE2HrBkWmLbTcp+frmI6kHbByFemFXV00k8hxAUBm/OoqPkytFD
	PbW/fa/8ekAfKOKbPhbAisp9hKBIh69urV5i5W8TbOOz1FOW0i3jU0HAhfs1vepLUhKUIQw85/N
	lZ5x2ej2Qz4WVneSmsXSvt7fHTyLpFwiODBaGo+S4Es7byAOvFJiLVYEqd8L2Ax+oh6CSm6QW9I
	r4uYuzKEz7H8L24RPidWoHS5QuMdApZP++sOt95EiIwbzUzj0c5/5mp0aXE=
X-Google-Smtp-Source: AGHT+IG/Yi/qk4YGrJvgZRoRnXd14pk5pi5diwpsqtszPlC13bqbgZFlocoYN6rPXNF0yZn07MCGQQ==
X-Received: by 2002:a17:902:dacc:b0:223:35cb:e421 with SMTP id d9443c01a7336-22c35985d1dmr68962035ad.49.1744875735660;
        Thu, 17 Apr 2025 00:42:15 -0700 (PDT)
Received: from thinkpad ([120.60.54.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3e0e19d2sm15264935ad.91.2025.04.17.00.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:42:15 -0700 (PDT)
Date: Thu, 17 Apr 2025 13:12:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, dingwei@marvell.com, cassel@kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: Add link down handling for host bridges
Message-ID: <doyt4kcaffgjm5u5notcjnqur7ydim3dpo4se5em2an36wa3rp@xzntx4sa47dl>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
 <20250416-pcie-reset-slot-v2-3-efe76b278c10@linaro.org>
 <Z__hZ2M8wDHn2XSn@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z__hZ2M8wDHn2XSn@wunner.de>

On Wed, Apr 16, 2025 at 06:57:11PM +0200, Lukas Wunner wrote:
> On Wed, Apr 16, 2025 at 09:59:05PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -270,3 +270,30 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  
> >  	return status;
> >  }
> > +
> > +static pci_ers_result_t pcie_do_slot_reset(struct pci_dev *dev)
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
> > +void pcie_do_recover_slots(struct pci_host_bridge *host)
> > +{
> > +	struct pci_bus *bus = host->bus;
> > +	struct pci_dev *dev;
> > +
> > +	for_each_pci_bridge(dev, bus) {
> > +		if (pci_is_root_bus(bus))
> > +			pcie_do_recovery(dev, pci_channel_io_frozen,
> > +					 pcie_do_slot_reset);
> > +	}
> > +}
> 
> Since pcie_do_slot_reset(), pcie_do_recover_slots() and
> pcie_do_recover_slots() are only needed on platforms with a
> specific host controller (and not, say, on x86), it would be good
> if they could be kept e.g. in a library in drivers/pci/controller/
> to avoid unnecessarily enlarging the .text section for everyone else.
> 
> One option would be the existing pci-host-common.c, another a
> completely new file.
> 

I don't like introducing a new file, so I'll make pci-host-common as a common
library for host controller drivers and move this code there.

> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -966,6 +966,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
> >  int pci_aer_raw_clear_status(struct pci_dev *dev);
> >  void pci_save_aer_state(struct pci_dev *dev);
> >  void pci_restore_aer_state(struct pci_dev *dev);
> > +void pcie_do_recover_slots(struct pci_host_bridge *host);
> >  #else
> >  static inline void pci_no_aer(void) { }
> >  static inline void pci_aer_init(struct pci_dev *d) { }
> > @@ -975,6 +976,26 @@ static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
> >  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> >  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> >  static inline void pci_restore_aer_state(struct pci_dev *dev) { }
> > +static inline void pcie_do_recover_slots(struct pci_host_bridge *host)
> > +{
> > +	struct pci_bus *bus = host->bus;
> > +	struct pci_dev *dev;
> > +	int ret;
> > +
> > +	if (!host->reset_slot)
> > +		dev_warn(&host->dev, "Missing reset_slot() callback\n");
> > +
> > +	for_each_pci_bridge(dev, bus) {
> > +		if (!pci_is_root_bus(bus))
> > +			continue;
> > +
> > +		ret = pci_bus_error_reset(dev);
> > +		if (ret)
> > +			pci_err(dev, "Failed to reset slot: %d\n", ret);
> > +		else
> > +			pci_info(dev, "Slot has been reset\n");
> > +	}
> > +}
> >  #endif
> 
> Unusual to have such a large inline function in a header.
> Can this likewise be moved to some library file and separated
> from the other version via #ifdef please?
> 

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


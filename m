Return-Path: <linux-pci+bounces-16227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0709C03AB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E52A2869D0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA91F7565;
	Thu,  7 Nov 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbruhLMn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043691F7545
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978144; cv=none; b=m0WT6Bf1poV8ZrEqAcIa8D70CH3iVYxwYQDKY90F798RaMK/slNYBejGpu/i+R0iYZ3wrsUMev/aeBacCMrd0dSJ2GNrp4EMAt/7b1n0LR1qWqJTJXPGBzetbKQemGy+urgnS7a+8DOIMXB8YglZVAgPmjfSBPBudxlrUg4GAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978144; c=relaxed/simple;
	bh=ZISETJHVKVOROEahJ6aXIlndVdLFuZzmPKMdWHW/Lr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpY7hvC0PujfNHvSODg2OaWTNNigLCna578eUNrV9pgpGVmP6mx3U8QsvMhvHqKSh4WFVn3K1+0e08O7YeM5B/IeGmQJYZUTJ1NKTVnUNFkqkbeBPKDSaJcLZ4NE+PmZLsqyEgSJVPENnJq62G8q982def+prFf+EiWm45kVrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbruhLMn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43158625112so7456365e9.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 03:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730978141; x=1731582941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yjbN5RFCWY6g4oYj1O998KVa8p0FR8tIt1YX199wtbE=;
        b=AbruhLMns30yKEj6N6ItuFpmehPsqAkNEa7beChWR4zwtcPt/I3XIqkzIl8yqo4HeP
         EPm3uf2sUFc8A7MzPF12CAVjThUU44Apz2F/EcVnf2pW8QsrdSMS98IJZK8iWwJpTbCj
         9lBjK5PdlNsPt/tqcKREidmdp3H8wfPh6HTs22I5a2RiuZCCPBhhMupMiL5O4rqr5wOb
         l4xtA6LIy14q22B/CsjUTPgbiz5hmkavGrKL4Sqrwwwd7rotIAm/9ui75VWZWx4HLcA8
         D/fYPT7RHWJSWd3tHi+0puzD1+lg5FOJWpkggU6RSuw8k1RNKMRIX49aCtjOU1jLOLbD
         5EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978141; x=1731582941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjbN5RFCWY6g4oYj1O998KVa8p0FR8tIt1YX199wtbE=;
        b=ankn5KcAoW5Ewxn5xGdVNHW+MJUO34Fo2GJU1sLmb7Bs/dKrhpyMF7/D96hSGp6f4u
         Gf/WyXWLMEv5iaSmnOcyeVWarvcBxNbdOkibMVdn/9pAc7zj6J6C3hyKbYV1z14PXe2a
         LAn0B3Kpj7ny0bZD4kMXX7w6eJUfAcY0kOv5TYjJvfqXlTrhcsStYJ0v7d9xjR2cKG3D
         vqAGUGvYHw3DRcQdtdU/WWQklXiUO3SO0Ut+C/HyflWL+X+gXWsZgn5pI+S6HeS6lI6m
         QbEMVYN+vbyxq8UPlRMYzapZtd/hqFQwE1UYbgV4orwLnMjG/D/AfTfu3rxrnQbqEADq
         XqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmeOCYzZEkpAELUch5p0VrL3viqeV2+Om4UtM85B899NyskKFt4WCE9//b9jdDKAHga75fZPFyr9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWneNxwcY1nymiXL06paCv9ZU8n5vmGhGfI1dT7CZsaem2x+Y4
	2YXzbbcyrKRyUdtqFjFm8Pvt64052uPwKOnRCoeHnMMurIXY2sBT7AtcOcSXMg==
X-Google-Smtp-Source: AGHT+IHCskfzGRVkMfe1cYYZ6SCQCAQDJbEdWEw29Ms5JOnp/e/1J7AIx9NEPn2iCbZrSBon0cVpFg==
X-Received: by 2002:a05:600c:1ca9:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-43283242bafmr186409885e9.2.1730978141247;
        Thu, 07 Nov 2024 03:15:41 -0800 (PST)
Received: from thinkpad ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c037bsm55668925e9.22.2024.11.07.03.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:15:40 -0800 (PST)
Date: Thu, 7 Nov 2024 11:15:38 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at
 least one power supply is present
Message-ID: <20241107111538.2koeeb2gcch5zq3t@thinkpad>
References: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org>
 <20241106212826.GA1540916@bhelgaas>
 <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>

On Thu, Nov 07, 2024 at 10:52:35AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 6, 2024 at 10:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Oct 25, 2024 at 01:24:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Currently, pwrctl devices are created if the corresponding PCI nodes are
> > > defined in devicetree. But this is not correct, because not all PCI nodes
> > > defined in devicetree require pwrctl support. Pwrctl comes into picture
> > > only when the device requires kernel to manage its power state. This can
> > > be determined using the power supply properties present in the devicetree
> > > node of the device.
> >
> > > +bool of_pci_is_supply_present(struct device_node *np)
> > > +{
> > > +     struct property *prop;
> > > +     char *supply;
> > > +
> > > +     if (!np)
> > > +             return false;
> >
> > Why do we need to test !np here?  It should always be non-NULL.
> >
> 
> Right, I think this can be dropped. We check for the OF node in the
> function above.
> 

I think it was a leftover that I didn't cleanup. But I do plan to move this API
to drivers/of once 6.13-rc1 is out. So even if it didn't get dropped now, I will
do it later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


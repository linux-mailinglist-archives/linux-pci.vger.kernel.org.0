Return-Path: <linux-pci+bounces-2334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC25832519
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17AFB222A0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D9D29E;
	Fri, 19 Jan 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTL18LzH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE03CA4A
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650041; cv=none; b=bE3TQmks7otZ871+mXOigQIjPZNWUTA07ufhkiISeyXIln4yQiYYFImH2ffk4jeATIn3ckDr/lu3DpGWMfKPiKov6VrTnJhwbA5TptiNEmPtN/ijh65EdzWRbCOFxtxz8rmEp3qFTDlf9xIci19KsJjE7CKT+/AUkfbbVXNglA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650041; c=relaxed/simple;
	bh=doJXC6Va4CIGwN0Iih+lnDY4rEtE9LT5x0R3GE7ft3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zft49CBA05mvH1FnbjKXSLMqIzWmImQXi4aeHE/LIvy51olcTljOs6d8QRlcrZ35tiILrBWATRZ+nCsZQONNwmActczMAdAHuMYqyU7NXfjW48fdER3hLmDIzuepsz53oRo0OdTjMbSS933Z6LdRSvefcug+sixhhx/9eqRUFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HTL18LzH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ebca94cf74so4915127b3.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 23:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705650039; x=1706254839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/pCciHi5Q2QbdDlTTGF4sQWlv8rfTqfk0RnQ7BpddI=;
        b=HTL18LzHcTuZEbp5aft3GZIOckw+LNLs5gM4ora3uwPplOORc7F2a5wKF3LnJegAo2
         6bLkydg0XTZEd6WtLuxrWPx+DFU0RgH68/jVPoM/2C5FyKwLXAaeNbzbh23rPYT9aIPp
         XgtooxoXWJDPfvuTx5qfS3X7QsPsX5Ucv42DB/DRLbEy6EHuK2iSbZEgoG088OIDJtoF
         uX8+ACF23oS0n16BtjB+jaIxVh/BFl3gCKKRDpYcswOpcEaVSru/wzl9OMShOJjI66wS
         E/sBdO/Pv3WjgBeD2u6AIchyZQL/kFA20x+LAIBnCXuWbQd1aZ6CaFnciFqIhDLSAoQI
         uuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650039; x=1706254839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pCciHi5Q2QbdDlTTGF4sQWlv8rfTqfk0RnQ7BpddI=;
        b=wAptdLQw30GJRtjutdatT8x0MxOo9OoAz2swpjzPiWlaMIRokkgmOuTjuvKlLSqwjo
         R8wT6JjKBXtQnLmRjG+CJHtGomOslwEo3O3Im9TGsT3Ze9AbKJdfhQPghCvHNWp2nv/G
         qbmDh19niJoaWH1dW7vkLxk4MngJk1NkFtdAJpVY5bIRuIDSJK9n0/Qbw3bIdiLhO7hn
         7CpIoiTprafUj9brRjjfRFW6O1e3tr3sdNRJLTwoOaRp7IIYEdBQcR6Dfb8BQlfmf67m
         4F5X5O5bwCfF1CqrKq/wucIvrqO5Q7l5Q42PcI0LdaNjmzUP32m2+eGkVfEelbkKMZK1
         u8Kw==
X-Gm-Message-State: AOJu0Yx6xtaHSbUgYnmn5M+Khq980FZvBsZiLygP9B/6FEHT0zz+oiuj
	X1adZXy6oF61wM3HFXuj0+8SRbvMFKz9edAUy1SqX8oAsveJL49K+O4+y9/tyA==
X-Google-Smtp-Source: AGHT+IFif71Ycltu5NAwE+xEaIuhXpxYXlFAE9CPDleciOcCYkZ8dIHhV7jbWLz1sVNxISitJziMVw==
X-Received: by 2002:a81:9c46:0:b0:5d7:1940:7d8f with SMTP id n6-20020a819c46000000b005d719407d8fmr1746824ywa.102.1705650039184;
        Thu, 18 Jan 2024 23:40:39 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id bq26-20020a05622a1c1a00b0042a1e10d46asm1009984qtb.25.2024.01.18.23.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 23:40:38 -0800 (PST)
Date: Fri, 19 Jan 2024 13:10:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Johan Hovold <johan@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <20240119074030.GB2866@thinkpad>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <20230711073719.GA36617@thinkpad>
 <ZaENr7jQ35winQAe@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaENr7jQ35winQAe@google.com>

On Fri, Jan 12, 2024 at 03:30:15PM +0530, Ajay Agarwal wrote:

[...]

> > No, IMO the offending commit was wrong in serving its purpose so a revert makes
> > sense. Because, if the intention was to reduce the boot delay then it did not
> > fix that because dw_pcie_wait_for_link() is still called from intel-gw's
> > host_init() callback. You just skipped another instance which is there in
> > dw_pcie_host_init().
> > 
> > So to fix this issue properly intel-gw needs to do 2 things:
> > 
> > 1. Move the ltssm_enable to start_link() callback and get rid of
> > dw_pcie_wait_for_link() from its host_init() callback. If there is any special
> > reason to not do this way, please explain.
> > 
> > 2. Enable async probe so that other drivers can continue probing while this
> > driver waits for the link to be up. This will almost make the delay negligible.
> > 
> > The above 2 should be done in separate patches.
> > 
> > - Mani
> >
> Mani, the intention is not to fix the intel-gw driver in any manner. It
> calls dw_pcie_wait_for_link explicitly in the probe path and checks for
> the error as well. So it has to live with the delay and the probe
> failure if the link does not come up.
> 
> My intention is just to get rid of the 1 sec delay for the drivers that
> do not define the start_link callback, and hence do not expect that the
> link will come up during probe anyway.
> 

Ok, this clarifies, thanks.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


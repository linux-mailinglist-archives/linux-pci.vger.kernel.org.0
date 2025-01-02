Return-Path: <linux-pci+bounces-19148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72F9FF68D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAE1881B53
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2418C035;
	Thu,  2 Jan 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT08JefV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E84431
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735801454; cv=none; b=DMGACgeHIt2D6NbI+whs4WxSLg9NCQAk3THL5T9rdA1rR9jzAndvA7z50JXYpOEk7t20XXf/gV8TqzIFZ9WX1JYcSuncR8BDYAWnq87m07LuknLLDuHdBWWIgsRhzo1UG4tqbBLEUmWR54bmfQXZwWrH1zBU/eZEbjgDdc89UC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735801454; c=relaxed/simple;
	bh=zieacA1cYlHL87jzXdWRIgLRo2zS5s609/3sOj0WpDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWGXTHz1ecqlWjcddW1LiagFk6vWBkEtetNKPPnOeKxm3/4msFMolv+1Wwy1x8SMsd8eJNhMNMzQv9iMU822D3AZY1ECsB8G/uTVy7rUnsL3bj6ap6Amb2EwrWOw8EGNxKaMPlfhdMol/8nCS1ivOJfiUW+w5oLQrXsC0tY72wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PT08JefV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so132330865ad.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Jan 2025 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735801453; x=1736406253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHyUTKV8cPdD2XAVx2quh19xU07+Qy2rusEJ0dFWoeY=;
        b=PT08JefVm2JdTRp5H6zg3y6zCVji6ZuQRdYFlkZTHNKeKmEovCn8dRYZ9cPCBAy4U8
         7cLPUN2+PJMkdc3nfqRIjjMoXery17W2uRF1V1HgFXcHK/vWVW2MNyAFad4NQ366YBkC
         VqXJDX4DO4sDoQlAAOW87DQ8pocuy/wk5YBF2p0oz4o0L8BGGHs+1jx5n/EtljqFQ2fv
         z3PhgeWKBAuGaGfAqyBacR5hoZVmdD1PMVTBBLG5PX8fcsI+ZBxdFnRO0HUN7roBj5Po
         myQMU9nVjtduUhOq/ytWRZDhe+OYeltAnhgAd/ShLvJnY0OeNHAWUWV6yjVKo3MdmB+D
         +yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735801453; x=1736406253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHyUTKV8cPdD2XAVx2quh19xU07+Qy2rusEJ0dFWoeY=;
        b=SJIwLtPZIbUXnKtIMGJx9olbWRjDV6tyfkNk7Sj/16l3sJjeH7tbqzEPDP6HDCh0YZ
         H2TD4yBcHd+2VZZtUi3wIDU7NXfSKxyoa8DwE1SlArcpxlfCOkP5k4pqc6Ul4LN0GaB+
         Jsy5xuCvQrCraJCh5jRyQKkFhwEZY8P8KlSKAmLks+P6oYzV60HJrqu4Er/GM+TVIhEz
         IiwSJ7eOUmQ//RAtfGAEnpqrV61+2zEtdgWU0IBKnXtlOZu7D7MPCfTSF3rcpQ9vkxQr
         f2lmZeZp/74gn7ydzt3Kga6okT/wK7eqTo+sy/9NXgGn8EKaAOaAM3ffLe3kbdc/Vwuy
         oQwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgdsts3f+Ah5C+SW672XCix/dTkBlhvYf9ujuayukd1kfpv6yKWu8D4dFIaizibwqrBHszsZqYRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/ZF1mpmyGpQHkQ8XQQWxJHzl0N737f/RToG49SV3imrOcaKF
	dLd6xOCH0GpL8OkuSzez9i/Diw44XBj9bQ0VZwh3ZyfvUMI7W3R+tvUVlaCdCg==
X-Gm-Gg: ASbGncuZaKCZBkBtrDFTb8Rnlg63RWKBbARsVXa8OS5xfKTYQYKs9pUkaZupdENdTtk
	oebUuJWfMhXzm+sZNGoqru94U2k+DOXKOFJtjacTmpUJ/sKfUR3zB+uorORs0F9ZQ/kgSim3Evx
	agiwZLqfns6Zs2pY9ySAKQvc3JLaS7XJ878EAmh+W7JnAa2SwRjVnuP8hMZItDgNqQXMBHYLiWg
	0LfLxqj9V9XTpa3GAWjbFJi7ZMUjuacj6clfAoq73rQ6lY7NC57fINvYdiT80O4/I+5
X-Google-Smtp-Source: AGHT+IHveiYw51Ybj8GZVsAu8rFz0ffgplnugz6CVwRBRHmUA3RuHT29SnSj6wt1va/tqT00jC21hQ==
X-Received: by 2002:a05:6a00:8d1:b0:725:df1a:281 with SMTP id d2e1a72fcca58-72abdda0cf3mr53988360b3a.10.1735801452677;
        Wed, 01 Jan 2025 23:04:12 -0800 (PST)
Received: from thinkpad ([117.213.100.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164d3sm23643829b3a.15.2025.01.01.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 23:04:12 -0800 (PST)
Date: Thu, 2 Jan 2025 12:34:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH v4 3/3] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <20250102070404.aempesitsqktfnle@thinkpad>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>
 <Z3QtEihbiKIGogWA@ryzen>
 <20241231191812.ymyss2dh7naz4oda@thinkpad>
 <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>

On Tue, Dec 31, 2024 at 08:33:57PM +0100, Niklas Cassel wrote:
> 
> 
> On 31 December 2024 20:18:12 CET, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >On Tue, Dec 31, 2024 at 06:42:42PM +0100, Niklas Cassel wrote:
> >> On Tue, Dec 31, 2024 at 06:43:41PM +0530, Manivannan Sadhasivam wrote:
> >> 
> >> (...)
> >> 
> >> > +	#  RUN           pci_ep_data_transfer.dma.COPY_TEST ...
> >> > +	#            OK  pci_ep_data_transfer.dma.COPY_TEST
> >> > +	ok 11 pci_ep_data_transfer.dma.COPY_TEST
> >> > +	# PASSED: 11 / 11 tests passed.
> >> > +	# Totals: pass:11 fail:0 xfail:0 xpass:0 skip:0 error:0
> >> > +
> >> > +
> >> > +Testcase 11 (pci_ep_data_transfer.dma.COPY_TEST) will fail for most of the DMA
> >> > +capable endpoint controllers due to the absence of the MEMCPY over DMA. For such
> >> > +controllers, it is advisable to skip the forementioned testcase using below
> >> > +command::
> >> 
> >> Hm.. this is strictly not correct. If will currently fail because pci-epf-test.c
> >> does:
> >> if ((reg->flags & FLAG_USE_DMA) && epf_test->dma_private)
> >> 	return -EINVAL;
> >> 
> >> So even if a DMA driver has support for the DMA_MEMCPY cap, if the DMA driver
> >> also has the DMA_PRIVATE cap, this test will fail because of the code in
> >> pci-epf-test.c.
> >> 
> >
> >Right. But I think the condition should be changed to test for the MEMCPY
> >capability instead. Like,
> >
> >diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> >index ef6677f34116..0b211d60a85b 100644
> >--- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >@@ -328,7 +328,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
> >        void *copy_buf = NULL, *buf;
> > 
> >        if (reg->flags & FLAG_USE_DMA) {
> >-               if (epf_test->dma_private) {
> >+               if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
> >                        dev_err(dev, "Cannot transfer data using DMA\n");
> >                        ret = -EINVAL;
> >                        goto set_status;
> >
> 
> That check does seem to make more sense than the code that is currently there.
> (Perhaps send this as a proper patch?)

Will do.

> Note that I'm not an expert at dmaengine.
> 
> I have some patches that adds DMA_MEMCPY to dw-edma, but I'm not sure if the DWC eDMA hardware supports having both src and dst as PCI addresses, or if only one of them can be a PCI address (with the other one being a local address).
> 
> If only one of them can be a PCI address, then I'm not sure if your suggested patch is correct.
> 

I don't see why that would be an issue. DMA_MEMCPY is independent of PCI/local
addresses. If a dmaengine driver support doing MEMCPY, then the dma cap should
be sufficient. As you said, if a controller supports both SLAVE and MEMCPY, the
test currently errors out, which is wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


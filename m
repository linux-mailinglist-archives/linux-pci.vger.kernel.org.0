Return-Path: <linux-pci+bounces-986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDF812C88
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938C1B212C9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7FF2AD04;
	Thu, 14 Dec 2023 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMKhkrud"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B4E0
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:09:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso6768613b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702548583; x=1703153383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWNR+uChpD2XCXHiRI7apkxqBy405ej3EqIXUwuAYoY=;
        b=JMKhkrudGBgnElxQGlQTxUO2CM6RMZzBPWNxIl3d1beMbjshgWsQMUMMciYIQc6uOx
         LvpUqdMW/CLRrG0uRxKT8PCAz4SkiN44dN6gLO3EXEpUjsOblZULrMEzmPc0c+vh++iU
         dWQPKJD/oKfWh2r8wSC/DICoVyoZmjfvIDOzSpdVGrKzclcGaxOxh+KwhJo3pNtqjKIs
         Fw0rH6JGw7qJ/gUMcQW9fd3tAxPcrkWqDxv9oFK+3+wSGP210smgcBdnXc4JZoXwWajV
         2ccAr9OyCyCc+xP5OnpE0Pqgr4l9vwAYkHP13eg6C3wR8Ro3GN0GWnZ4NDMfW66dljV7
         fLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548583; x=1703153383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWNR+uChpD2XCXHiRI7apkxqBy405ej3EqIXUwuAYoY=;
        b=gcO2W4zTQrSKEqvaoYW8sIQIYrllg5L5pTEHp0pdk+4jsFFk2118EB6Ip+R1526xQ/
         NPj5Q1y1NtIgUyMlELy1lO/fcxQMFXFXPliqDJBwtIBIAY72QGIhpKMMncyRKfeRxJVL
         sjVfNRmnFE9UBzqEjrVq4Yc3ag0oPETnlQQ/ZY6O+TkdsAOvRIKA0TGm9tKEjcAAfFNz
         ogOt1qnsyaxUVWg+qHr9SNyg9zH32NRZzIgbE3u1SIBmR5tv0H3nJrBA/jq6Cz1MKTxz
         pxB8/RR9A3wJjW/ggx1qRCG/LuPvb6JLb2MXQewVCzA0MI22UV7Hcbti/p+/KOl1x/Q9
         GGBw==
X-Gm-Message-State: AOJu0YyuiAatsAOrkH79DdbUqDf2PGLbrdM2hZPf0sXflwA6pUgPhaF/
	FeykfHbX7vBwmVmQUeKwhEl4
X-Google-Smtp-Source: AGHT+IFoBTL8upshvJpDsA2gdrqL9OnkLrHFDhbqOefDhz6lfrJvqtCI/Af60s/auvjujU8gBjKneQ==
X-Received: by 2002:a05:6a00:2195:b0:6ce:6518:702f with SMTP id h21-20020a056a00219500b006ce6518702fmr11386629pfi.28.1702548583327;
        Thu, 14 Dec 2023 02:09:43 -0800 (PST)
Received: from thinkpad ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id ca40-20020a056a0206a800b005897bfc2ed3sm9703702pgb.93.2023.12.14.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:09:42 -0800 (PST)
Date: Thu, 14 Dec 2023 15:39:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231214100936.GI2938@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
 <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>

On Thu, Dec 14, 2023 at 03:10:01PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 11/27/2023 6:15 PM, Manivannan Sadhasivam wrote:
> > Now that both eDMA and iATU are prepared to support async transfer, let's
> > enable MHI async read/write by supplying the relevant callbacks.
> > 
> > In the absence of eDMA, iATU will be used for both sync and async
> > operations.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 3d09a37e5f7c..d3d6a1054036 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
> >   	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> >   	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> >   	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> > +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
> >   	if (info->flags & MHI_EPF_USE_DMA) {
> >   		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
> >   		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> > -	} else {
> > -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> > -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> > +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> > +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> 
> I think the read_async & write async should be updated inside the if
> condition where MHI_EPF_USE_DMA flag is set.
> 

That's what being done here. Am I missing anything?

- Mani

> - Krishna Chaitanya.
> 
> >   	}
> >   	/* Register the MHI EP controller */

-- 
மணிவண்ணன் சதாசிவம்


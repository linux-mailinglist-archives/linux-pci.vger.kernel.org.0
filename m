Return-Path: <linux-pci+bounces-19908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8665A1293D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AD51649EA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F7193079;
	Wed, 15 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMjHE87q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8A15D5C5
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960149; cv=none; b=u8/k+Q+t2nEWwnx0XiMqG4Uij/VJem/VzSyycLHH20Xiq0WJPAXYcH+0T1OzJ56dGCkLsiix8DNDFdPUV6YuJtL1Vlz9f6nyLzZHsd4K2PXRZ4d5rcHsrrv9+sJplEL3Ag5hIkdDAZVGgsDl7dTJe/xDpgQsh46pSv+YZVzkXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960149; c=relaxed/simple;
	bh=s0RYUsI9GuIYcld2DxebLf3JpxuLGsW/B03O64UrCl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqj//sycOEoEpW5fggSafXdhAtSHzvqhB+c/XxnQbQ7q0e4op/u5ixNQjYkRH9Mp3UdXnrxOj/NPShqn38UeMBoKMVxxmamtTkuTGw6a+8WLrXO2lrRU/Gu1Jf+F+IN+6w5MK0GvchadALIUCh1gWSVRPGBFBjiK/OL3uNpum5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMjHE87q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21631789fcdso14486425ad.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736960147; x=1737564947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iLEMpPTOfcGIE0TnoMMm2t6EP058ZQmyPf3B3ef9ims=;
        b=iMjHE87qcjMC1g9nbgSUIwmkio5PDNi43BylUDfs0fFT4JUinp5GUEfglICX6d1LRH
         iBVfKVJu/iojTA4uTFWay4UvsFob6U90cKMUloEObQNYQRkD51OMBsKIHspkI5ahXwzF
         q7QMQJJ+SENZEHI70//HMFArQ4x3+UBy+q/n4JMkWXvNYH5Ib/7Kl6+v3bnaYQclYqqO
         7UPKCuH2RF3Rs5Il0wEPoEUVLpy0aJM1oi99XTjZ86cjI/WmNtz37X4nd75MwqwONT0/
         xW3A7OuLj37xFDuRnrA7nNRyTYUVp+MSR5gPJL3GUJOCdNU02YChFXuX2TjwsRtFv+2T
         cgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960147; x=1737564947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLEMpPTOfcGIE0TnoMMm2t6EP058ZQmyPf3B3ef9ims=;
        b=WoAxLGelXHA2wOLjEX5hiRyXAZsvvkUJ+g2nyqqHwbiwiHvls6luXzUzLxKaw/orJ8
         23/YIsyhka4k9zkc8+zrhzboEtwz71JyWjSRrZifKg8vpoa4jIrMdS6NmX+RjODPJfzo
         +GS5CWSVOj2c4OXPugokD3Y4Z/3BjFQXxYrIKLKYZ+mYVIj3hGA07mDWNTsSE6DM5s02
         a3Gr2uRqV5MM6jixWJB29lkd7+sdtXhNyofMLlxxmXC0TXd/8JmuKdc6ZLRbMs18fK4E
         d+3A1DrS+ySWapYSmxwuUETOPTuDthfP33FRW9O4tlq4mlYrCHFuZouzxcypxzJZpciV
         xBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWJe/odvp4Gg2GSsVPQkn0DVS+9w0DGP4r4++x8CJE6Sba9EVwx8Y4KEA58KlX57turuP9MbfD1xJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbZZAH9HAB2fh7xjDgH3/k4PbUY3JBqdyEUN+ELmovBynWKT6
	dBopsjeebcQAWcU/HpBaoWwfKbDkDEwLn/my/Zxb2kjfOApD1mGEAQQyhcy4Vw==
X-Gm-Gg: ASbGncuuLIffyV/mYcbKPwB/p3pDy23tRql8CNfOKhHMp39jqtJ2COZnUrpL+3ggVFI
	xuIB76zGZvpHsF48K2hJh88bDfF/oRJzPF9bAma4NwL5I9j3RR0K1c9y7WWJPEJ0L/bCtdLxVN+
	9+QN1n01LN/IP0ipuGOb+4pIGHuxHXkHD4CWmW6KPmq4eoMhiPpAZipNhb7rXEen5FDfTNZ4vUy
	4ZufPvKSF4LMQgufU9AELV9JFeD1cFl4DDTGv01Db3d+yxQQ5t+YUirC/N21cptLuE=
X-Google-Smtp-Source: AGHT+IH7JbYkc+q9KET2yNRSdVgBxZjaXkn6cyEXwedR9a4FGw68GsofruEhVKa2oHfSVEZNAWMULw==
X-Received: by 2002:a05:6a20:d488:b0:1e1:f88a:3106 with SMTP id adf61e73a8af0-1eb0250632fmr5545770637.7.1736960146987;
        Wed, 15 Jan 2025 08:55:46 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d4d6b477sm9940172a12.61.2025.01.15.08.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:55:44 -0800 (PST)
Date: Wed, 15 Jan 2025 22:25:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Fan Ni' <nifan.cxl@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in DWC
Message-ID: <20250115165530.kgzxax7fctguu5x2@thinkpad>
References: <20241206074456.17401-1-shradha.t@samsung.com>
 <CGME20241206074242epcas5p35c4db25aade3f328a93475225c170bb7@epcas5p3.samsung.com>
 <20241206074456.17401-3-shradha.t@samsung.com>
 <Z1dvOn_9_3Y9oRCa@smc-140338-bm01>
 <0d6001db4bbd$06de0f80$149a2e80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d6001db4bbd$06de0f80$149a2e80$@samsung.com>

On Wed, Dec 11, 2024 at 04:38:34PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Fan Ni <nifan.cxl@gmail.com>
> > Sent: 10 December 2024 03:59
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com; quic_krichai@quicinc.com;
> > gost.dev@samsung.com
> > Subject: Re: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in DWC
> > 
> > On Fri, Dec 06, 2024 at 01:14:56PM +0530, Shradha Todi wrote:
> > > Add support to use the RASDES feature of DesignWare PCIe controller
> > > using debugfs entries.
> > >
> > > RASDES is a vendor specific extended PCIe capability which reads the
> > > current hardware internal state of PCIe device. Following primary
> > > features are provided to userspace via debugfs:
> > > - Debug registers
> > > - Error injection
> > > - Statistical counters
> > 
> > I think this patch can break into several to make it easier to review.
> > For example, it can be divided by the three features list above, with the documentation change coming last as a
> separate
> > patch.
> > 
> 
> Sure Fan. I have no issues in breaking this into smaller patches. Though I think the documentation
> should go along with the implementation rather than a separate patch?
> Anyway, I'll wait for some time for further review comments or if anyone has any objection to
> splitting the patches before going for the next revision.
> 

I don't mind splitting the patches, but as you said, the documentation should go
in the same patch that adds driver support.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


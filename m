Return-Path: <linux-pci+bounces-19297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBFCA01362
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B013A3BA4
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2761494DC;
	Sat,  4 Jan 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3VmHtxP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525215624D
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980418; cv=none; b=Kcrmw3LvzAYTD/aBXOWIJVtXn0CWb7Yg9HmkBoVKuI1hBgDxT4FzYX5jAnicexAL7IL/zBeftk42w0QWVyVR+h5Bk+KpWn+UjPoRV5O0/KNrcHEgUlMhPk5scZFtiPqFvHCgTQ7EA6xodWJJ3C/eu0FrUj+QQGnTGaBG9QWlP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980418; c=relaxed/simple;
	bh=TjY/6pV32+njkEI5WSoHVYC8HiICEjJm1Ig28kbsJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWDIKoTWDTsjq4AI0OinForCYuTeRES15mQC//03/84I2X5jyDG3ZP1pknjPthVCZOCI53ZkCo45DfgFh6+qixOtWH4FgO4SkgoOAirl0y3D9dYUIYhP4pF4d6NG3PrlwiFtjB72B6yoC24eVycNveu/Vf1FAvVgLAGIiousAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3VmHtxP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so107865405ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Jan 2025 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735980416; x=1736585216; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BED1OiqbW/D03kzeEArLqAHs1VR2sOTzUUOsGbrMumI=;
        b=L3VmHtxPB2CgdqTdWUMSg9aJqoeX8UfZ/6kVZlH3Gx1GNLUClUELXY1+ezH39YCypF
         dFh2zUMFsZa7QzPNzICXZ6LxurLWLjO3gWEy9yGMFuNS5TzvpP96b2wgUA6LkS4k51Gl
         /1tRheq2WTTgyoKvY1QVRpZwvxFHVMeG2YaBU7LbqrmB6JJY5oQzYvT64c0Q6kpO9Mmq
         t1UQaXXD6WdzYju3x0vGs0d/BCsub5KPMrCdRTGwaUusOmDYLWG/MWenFKbpkFYtEHD/
         h3StRjb6hOHyX2NyrKqpc8Xpn/9ZQzxL0GFhFgQN43Ob7+EyS9gTEwoIsj9BmB+usDpv
         fusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735980416; x=1736585216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BED1OiqbW/D03kzeEArLqAHs1VR2sOTzUUOsGbrMumI=;
        b=DVF8S0KHkwqw757KuoyWARggkld0qpH8s+oz1HKFG0HJ0QqmaZm40eSe0KiX8qkyCX
         vlipc4jKCAuQgpWyaiDjOGqyG6Ifo2HWL6146Tk5m4PAHJQTkPyIW6UZkrX5WvlrludH
         yFmR4Tbx8RuSkwZ8JiX+vfsAyh8ji/mywnqHw5pR0dyFwkmkQWmGnbqYsDEKJiatbQrL
         5DBioQyV7gm4mcAGB1iw/MvMVrEHsXR29yvIFkjOZllhAnJ9iXhNPkMgddd7jl/ZK609
         6b8bGfkfazBC9YHkQCArObYYB4JHEElKPvpFDWjGkyb1iZXsw+WgQWsYtr3Tnq8NMvfw
         a50A==
X-Forwarded-Encrypted: i=1; AJvYcCX5974jmkCg/XmGEOXpLTjoB4ifQmZyUOQnfaZZc1loKx3kKzYiPu8LHTjCDcnPclyWr2vuh2uhXaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPGUtHNR5MlqIxnarsDItJG6XHC+Ij2WZRJ50GQKVQZOiTC0V
	s6/Z24c7bmPgMdPl1LREllws/25TMiGEVRhovgZ3pciZIQFSu19SN+FWbHzHdw==
X-Gm-Gg: ASbGncsJjVlHbqKjDCeOPiklovVg+3XBHkJT2kS5rDeQVQiFaRVWRhEA9rOPmYph2xc
	Rqy910tlm474RiFhtmb8+ioo6Z83Ukjv6Qqn3wHtYjatoVSKABnRdf7+Wbtft6w7dc3E5PKVb/s
	NNBQJI2dGwogJw6EUxUSEvrlAowj94UQWPlaFU8U7E06Xeorx12PI9CyZWDSB6EFDIcjTF2IIRm
	qLr/qDIW52KuZAUzGzDvxBvxXwBMl2eCty+ICAbEtPqYc/dBAVET98C7WfJQ0aVeLs=
X-Google-Smtp-Source: AGHT+IExyI+LQKsCQuxymDr0yXl4jQLAveiONqPIcCazQbCOPqZ7zZULeWsdWyXUQ0Fn1P8AYHpqdw==
X-Received: by 2002:a17:902:f693:b0:215:50fb:ae4a with SMTP id d9443c01a7336-219e6cd0fe8mr716947285ad.0.1735980416389;
        Sat, 04 Jan 2025 00:46:56 -0800 (PST)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6156sm248684065ad.209.2025.01.04.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 00:46:56 -0800 (PST)
Date: Sat, 4 Jan 2025 14:16:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Fix potential truncation in
 dw_pcie_edma_irq_verify()
Message-ID: <20250104084652.2t6oilbns7kfz2ep@thinkpad>
References: <20250104002119.2681246-2-cassel@kernel.org>
 <20250104042901.47qx5iiez3gkdtrt@thinkpad>
 <Z3i8fQ8CRGzZuhUT@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3i8fQ8CRGzZuhUT@ryzen>

On Sat, Jan 04, 2025 at 05:43:41AM +0100, Niklas Cassel wrote:
> On Sat, Jan 04, 2025 at 09:59:01AM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Jan 04, 2025 at 01:21:20AM +0100, Niklas Cassel wrote:
> > > Increase the size of the string buffer to avoid potential truncation in
> > > dw_pcie_edma_irq_verify().
> > > 
> > > This fixes the following build warning when compiling with W=1:
> > > 
> > > drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> > > drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
> > >   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> > >       |                                                  ^~
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Changes since v2:
> > > -Simply increase the size of the string buffer instead of chaning the
> > >  print format specifier.
> > > 
> > >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 3c683b6119c3..145e7f579072 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -971,7 +971,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> > >  {
> > >  	struct platform_device *pdev = to_platform_device(pci->dev);
> > >  	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
> > > -	char name[6];
> > > +	char name[15];
> > 
> > Isn't 14 big enough to hold INT_MAX + 'dma'? Not a big deal, but asking just for
> > the sake of correctness.
> 
> We need to be able to hold INT_MIN which is "-2147483648" 11 chars/bytes
> + "dma" 3 chars/bytes + terminating null byte (1 char/byte) = 15.
> 

Ah, brain fade (missing the null byte termination).

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


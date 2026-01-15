Return-Path: <linux-pci+bounces-44883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E9D21DAB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 01:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C80183008E27
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114586250;
	Thu, 15 Jan 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAQBYeBB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831B3D76
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768436964; cv=none; b=M4S//ptA7xJTE9Hu/365EXmAGMBz80OK+bIl81WuTcQOL8/msc1+ZanyeX+DcgccJb0Xlj0impaHfZg2IGtTYqO7WeRXotXMujzYjHHa3MgU/pzcGmgLqmBlLYowhks9tO40NjuyLyR/Nc264gz93QLbJTf5eDWRcdNyFOnj7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768436964; c=relaxed/simple;
	bh=SVsMVXMLZfuhPiPAwanW9L8Zy3F0saKO63e8wKR3e8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIzMJN7Ou8dmFew5m0q5htN8aJsALVanXndm3T156oLv2sZ8KLcvwYGUPEN3MQBsfk0HlXoaTLZPfL86kDDjLrlHDoHY+HlxUnM0wc5BDtz+36/yL687yxKyp3ddm4KIgwwUyKLHJhBCslKsIdzRNrxsYldQ+7ipkD4Cllb1OPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAQBYeBB; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso889052eec.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768436962; x=1769041762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkEkhYbrNY5/B4PnqPn1YOtnmIYmQjjEjUsVFrM5qCY=;
        b=YAQBYeBBa4jWRQB/AkwOgdO4zX8W+LZS2bVPZy9wZ3KPWboeyIQxLzgf9kF3jduyM2
         dIzCDM9A/wJZrqy6Bv5nCosKRLUqUvAK59qKizvpJBQ5b1e/ZwvDpjqUYgwP7f1uhF3/
         iO/pdUXvogUcVe3/wfhlvpM/2DPenPXo5FA82lC4I5jmmBkMVIu/ouE7mZ4vBF4ac4dd
         AJyNSOVjMLzu5aREpNSP1UrZKThlosKOiUXz7gPJR/yN+hnIroE1ppAPL+XXGM0n6qiG
         jwkT8Q9snVZZqVtMu0XKmvwCiDu/tlG10flGb7GfrBlDmipE2IyVTsT2+EPNJKCv9RQj
         Y1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768436962; x=1769041762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkEkhYbrNY5/B4PnqPn1YOtnmIYmQjjEjUsVFrM5qCY=;
        b=YoCpJp8LbXiAz1MQaSyw/7L3mEUrT3MQRSXafzdeOEUagSeEV6PEXdh1FalXhYyVlO
         0/tooTro8JcKCKxYnU8OmiuH3fa8+InMMNKdmWRC5K5lSXc55O57eaaqW5Pimbgn86lQ
         KmX0usBixHYT4GM+zy+pP31lLH8dt/PUKYtT4X7ATaXQWQmKyzmA1OjrUwaxnADaaRbX
         CxtmKO0LH7/P5AfBzUR0ytYJ1R5cVfOAT3NdfVWRZky6ea8p2JmLERD2NFVCm69FEe34
         lMSA0Smit5dpck0kctzsBsPMkdQpzPvIg7zyluJUOs/uqR9kx5za1Fs/xlJYy3tSYeX/
         zBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZIg2eRXDFKTxf+Vs5c6nfx3zkOWcACyZEF8vJbFRRgfAufgAzjQPHRuMwiFN2B0LSsT+ne+vMSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5vT2Ywn0P+aXGTVsXrJ1L4hBn794l57tMJuKFq0hTeq2qBbl
	bkVL7nwvrlmClvrTe2e8CMDsAz+xAztRf6nnNfk03aQrkRK2Szx35igedVyQsgD/B8g=
X-Gm-Gg: AY/fxX5n7Gcu7rKWKtk6s2l3FQboP5pQs30VhLHt5I8xo09vLoA5LfdKrFA5/Di7UoM
	Rq4jl4tgkxTm2DP39MMxDSkYCuQRLBqAEt3YXL9G+OGU0nTIFnZ3m63QlnrTURXx8mkWaZkbb/y
	38R/N/4GTwHAvWIv1wGjqAaRWtI85HcvcE/J9kWKam53SqMJeg9o9HZ4HHAu1pygUa55jvPSm+I
	OwFtNSiCAYDimn/fcowM5AgTHmLruOwK6PZtt75L3IHVaTdWONVcNEC20vxJA4o+F2V0hNQGADR
	9ozfKSM5xHKjhZ1tveZkpKJL9pfWfd9w0yeNp8KkD9U/6EV7iQ6+ZSQtMdjS9vXZvVjPYdvUhRZ
	Bex1GAAymXDlFxTEHXV1uSXIfdcmijLxHw9sNBoGZo3/oJAUdfADINPyTq+FQFEQI2Mj9Rgj3QY
	S/7MSZenMIiZmrw6u8eBTQ
X-Received: by 2002:a05:7301:410c:b0:2b4:5a2d:80c with SMTP id 5a478bee46e88-2b486c93f53mr4567821eec.11.1768436962280;
        Wed, 14 Jan 2026 16:29:22 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a55e2sm20827544eec.8.2026.01.14.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:29:21 -0800 (PST)
Date: Thu, 15 Jan 2026 08:29:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root
 Ports
Message-ID: <aWg0uytowyzbOBMX@inochi.infowork>
References: <20260109040756.731169-2-inochiama@gmail.com>
 <rbypcgy3laht64wrjdnpo2xgjcuriy2avmeo5kxlpqdw5mk4lk@lwyjoq5p62iq>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rbypcgy3laht64wrjdnpo2xgjcuriy2avmeo5kxlpqdw5mk4lk@lwyjoq5p62iq>

On Tue, Jan 13, 2026 at 08:23:17PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 09, 2026 at 12:07:54PM +0800, Inochi Amaoto wrote:
> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > states for devicetree platforms") force enable ASPM on all device tree
> > platform, the SG2042 root port breaks as it advertises L0s and L1
> > capabilities without supporting it.
> > 
> > Override the L0s and L1 Support advertised in Link Capabilities in
> > the LINKCTL register of SG2042 Root Ports, so it doesn't try to enable
> > those states.
> > 
> 
> You need to disable L0s and L1 capabilities in LNKCAP. LNKCTL change is
> volatile, since both PCI core and userspace can override it as long as the
> capabilities are supported.
> 
> - Mani
> 

Good to know, I will switch to the LNKCAP.

Regards,
Inochi

> > Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> > Change from original patch:
> > 1. use driver to mask the ASPM advertisement
> > 
> > Separate from the folloing patch
> > - https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
> > ---
> >  drivers/pci/controller/cadence/pcie-sg2042.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> > index 0c50c74d03ee..9c42e05d3c46 100644
> > --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> > +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> > @@ -32,6 +32,15 @@ static struct pci_ops sg2042_pcie_child_ops = {
> >  	.write		= pci_generic_config_write,
> >  };
> > 
> > +static void sg2042_pcie_disable_l0s_l1(struct cdns_pcie *pcie)
> > +{
> > +	u32 val;
> > +
> > +	val = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL);
> > +	val &= ~PCI_EXP_LNKCTL_ASPMC;
> > +	cdns_pcie_rp_writew(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL, val);
> > +}
> > +
> >  static int sg2042_pcie_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -68,6 +77,8 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> > 
> > +	sg2042_pcie_disable_l0s_l1(pcie);
> > +
> >  	return 0;
> >  }
> > 
> > --
> > 2.52.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்


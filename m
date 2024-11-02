Return-Path: <linux-pci+bounces-15836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EAE9B9FD1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431E41F21F4E
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC518BC21;
	Sat,  2 Nov 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUS8DIzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153B18B46C
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548485; cv=none; b=bVnOB/PGGFUiIgmIlAt8k2+dorltvzbF08CfD6D/0Bc4lzuZPjVzl4FnKYGJRlcmIUCghYkQKGSpqUemXvRKnt1d4ifQRKim/Q86DgvgYnMJ/N60zOtYjGeeKwO1A3qkHHUvhcClJSmvuioIXdXjSKUbxNa31ziqBpwwcVKzSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548485; c=relaxed/simple;
	bh=uenxxXG7WDG5CmlqwyqtlRiBDcCxllosDV07ROVKTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGvnlnKlaJlMfWbbZLdXWPC0VJ9qb8M4V8ETuqsZuXJzAPXRCewwQrgcxaUjWqdJS8EYZiARjEon3BTjh5TcAvmqfVidnuWELvnlkKNFdeRMOGN0kvMhkp5a42Of2rIAIUoMp7r8AgVT/v0EMzcLzsgTrsgEgm0NQB0joji8wgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUS8DIzs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1337530b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730548483; x=1731153283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf5PO0O/8GxH6YaffdPErJ0yX0DmIFh2NMk1EvLbRA8=;
        b=IUS8DIzshwXzRJ+SILtR52xEwHD331mF8+Mqa0MuTJS6Uy1xdmdyd5w95N29cYSCt7
         QitljdWOA+mMdbt1YvZ0isZhJ0PzGaXiCxoy9J1RYBm3QAdRTBadUS5GqhLBl0Mt2b5r
         xxQzKMNzr6Q4YdxG/d52DsDxH0vzqjlGWonFjF/Hzy+FDad012NJiC5hXgaB6NK9iM13
         W89kjJXFHq1YButE2kso7ulkrC6SXZIkAsvvUE7hNetCd4NHECq80Gk/uFEJK3MiUYIv
         Cz18HT2hdZ3iXhTsUsy+QiBCsGMBVnYc5VgssmPM18vkbiRPO6CfFH2P6ZDYieOl4KFw
         RHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548483; x=1731153283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf5PO0O/8GxH6YaffdPErJ0yX0DmIFh2NMk1EvLbRA8=;
        b=gO/mYppWz9Pf18nd9lgzf4EtkiZ3HsbpDffrL5Rw064G4/NNfGZ/qaMa+jflCeCuw7
         9v0GWCkKlI6EDY1a/A58a04gP8q0SlKvhpYPk636CTiqmHiwRJHnfeFCeOVk2EnYVJ4u
         Z4lE7YuaGKgoC/sioLz6+jpWf+np6Pa7bJnNusMgYbYq/Ylup90l36D6Ed2zLGyS3avs
         D584zO0OvGFo/GOY/bECPk1EBI+Z0XXby4HbMPsn5+1sDbx3qUusbkkKdHooUkUocFSl
         +d/+FlZtNBMCCuImrWokwpf0zHv7CiBgMq/s+xK/aHh0KylHkgq6I6s478b90LQ3MXOM
         Fztw==
X-Forwarded-Encrypted: i=1; AJvYcCUc22xnJR8CKNMIbt8PYWdZdOwFk1TKQ9VSD9dDICSEj/nBuTIGXhfluwdo2QskX/sI7Ic12ieneMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Tp2dYrKEfVLAKfiUy5GepZkeAlmb8xx+T4aNzPq5vOfSSCqr
	8wxPmtaA2mZZzTBn3Hze0vpdCIE4o6kpNwMFrm/SSbuJkHHkdYY3PAhrzPNLbw==
X-Google-Smtp-Source: AGHT+IFBSMlqCkyuHYgmkW0THyLKy0cIuZ+FHeVb4thr/BQ4WLID6ROgAM8u2xitC9jx8P6RXoMQtA==
X-Received: by 2002:a05:6a00:1397:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-720b9c96d0emr14158400b3a.13.1730548483312;
        Sat, 02 Nov 2024 04:54:43 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8cf3sm4023582b3a.20.2024.11.02.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:54:42 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:24:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102115435.s7oycrh2pjkfhpsu@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
 <20241102111012.23zwz4et2qkafyca@thinkpad>
 <86jzdl27my.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86jzdl27my.wl-maz@kernel.org>

On Sat, Nov 02, 2024 at 11:32:37AM +0000, Marc Zyngier wrote:
> On Sat, 02 Nov 2024 11:10:12 +0000,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > > Some PCIe host bridges require special handling when enabling or disabling
> > > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > > to identify the source of DMA accesses.
> > > 
> > > Without this mapping, DMA accesses may target unintended memory, which
> > > would corrupt memory or read the wrong data.
> > > 
> > > Add a host bridge .enable_device() hook the imx6 driver can use to
> > > configure the Requester ID to StreamID mapping. The hardware table isn't
> > > big enough to map all possible Requester IDs, so this hook may fail if no
> > > table space is available. In that case, return failure from
> > > pci_enable_device().
> > > 
> > > It might make more sense to make pci_set_master() decline to enable bus
> > > mastering and return failure, but it currently doesn't have a way to return
> > > failure.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v2 to v3
> > > - use Bjorn suggest's commit message.
> > > - call disable_device() when error happen.
> > > 
> > > Change from v1 to v2
> > > - move enable(disable)device ops to pci_host_bridge
> > > ---
> > >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> > >  include/linux/pci.h |  2 ++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> > >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > >  {
> > >  	int err;
> > > +	struct pci_host_bridge *host_bridge;
> > >  	struct pci_dev *bridge;
> > >  	u16 cmd;
> > >  	u8 pin;
> > > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > >  	if (bridge)
> > >  		pcie_aspm_powersave_config_link(bridge);
> > >  
> > > +	host_bridge = pci_find_host_bridge(dev->bus);
> > > +	if (host_bridge && host_bridge->enable_device) {
> > > +		err = host_bridge->enable_device(host_bridge, dev);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > 
> > How about wrapping the enable/disable part in a helper?
> > 
> > 	int pci_host_bridge_enable_device(dev);
> > 	void pci_host_bridge_disable_device(dev);
> > 
> > The definition could be placed in drivers/pci/pci.h as an inline
> > function.
> 
> What does it bring? I would see the point if there was another user.
> But this is very much core infrastructure which doesn't lend itself to
> duplication.
> 
> Unless you have something in mind?
> 

IMO, it adds a nice encapsulation to help readers understand what this piece of
code is all about and also keeps the callers short. Plus the disable helper is
reused in both error and pci_disable_device() (if that matters).

- Mani

-- 
மணிவண்ணன் சதாசிவம்


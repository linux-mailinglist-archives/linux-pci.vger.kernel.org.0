Return-Path: <linux-pci+bounces-1432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403AC81EEB5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92891B21292
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0116446BE;
	Wed, 27 Dec 2023 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="XvOKITcx";
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="aUk30iLS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D1446B3
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e67e37661so4527835e87.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 03:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703678309; x=1704283109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmOgFLjbKObpkaPAeAy9ABsJp2iJpN7M5BSuPIgW5lU=;
        b=bD+DxxW7BBapRdzdX/UWZItWboesEra33mRj+mYLp8vWeQ/t9nLCwuKA9FxbeW9kEZ
         LTqvAmCbR+CG8LDmJc4Sh8aLdehL2faj3Njht2mVTi42A4hpkSRKH7eLlw7TD28hq141
         QkvotcvBpQsYyciDFIhQeM7tkplrn2dXzHz+TjG9LrF9/k8x8EoQ7jjJ5yGQLy9KAdLJ
         5m65++j6SoifaVCAL06thADSdb8u0TELLn8IJfrTP01WC0RVcmUiJKbC8oEcGTCCpDnB
         PpBpYHqOZvVq+h0EY/kwcukhh2VbIb9kVL1JEijSWg2KwM4CXsz2FCEn9Cen2RmfDq7Q
         ooTg==
X-Gm-Message-State: AOJu0Yy8J4OjAnOttfJ/DVx5SDlVgwhPo/dP7TmhCTUsA9f4MMNLaMQd
	tHbK8OHdwF2ndJ00HWMEY9XsQPHRr31DPg==
X-Google-Smtp-Source: AGHT+IFrDFZWpJ4q2xaNOKQ42mtRZji/apH4noD8gcBNYBEduBEgocSXBDCYBLfERppObBWJnKJ62A==
X-Received: by 2002:ac2:555c:0:b0:50e:56ba:8943 with SMTP id l28-20020ac2555c000000b0050e56ba8943mr2949748lfk.49.1703678309409;
        Wed, 27 Dec 2023 03:58:29 -0800 (PST)
Received: from flawful.org (c-55f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.85])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050e84c6bfbasm244863lfb.48.2023.12.27.03.58.28
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1703678308; bh=+aTZS/59bRS3M6j/U2OkEFP2JKMaeS4bCnmm6beD6nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvOKITcxX1Ioy2DtrMpnNJ1d2BOp/2MGx/peblwV3hpZkTplJuXu/bjRsvskw8Ozg
	 p4eoUfGnATt2DGcvEck7IidFhBrOBzGurUm5GrGgY1Ns2VbnMXVrpZqKKbtAyrHM5C
	 D6rPTBaRMixvHTzX8hPCbEYg4y/AcmEJrDBkDSfA=
Received: by flawful.org (Postfix, from userid 112)
	id 0B781B99; Wed, 27 Dec 2023 12:58:28 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1703678267; bh=+aTZS/59bRS3M6j/U2OkEFP2JKMaeS4bCnmm6beD6nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUk30iLSvglrSGxT+GYwh/atsutn1bmS8RQYoBu1R+LZDrptXcmHb+Vml9jYqMucA
	 uTA9B9WtgYWb3/JcUiusQl4GHmET9xiHWvEGA3UN5BuxWYc/qHYLqshJk5JtEP/CA+
	 HXC6tMeaBSvzvPv2yg7lXeBISi2u4EuL0TF871Lo=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id 396A5B41;
	Wed, 27 Dec 2023 12:57:32 +0100 (CET)
Date: Wed, 27 Dec 2023 12:57:31 +0100
From: Niklas Cassel <nks@flawful.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <ZYwRK2Vh5PLRcrQo@x1-carbon>
References: <20231128132231.2221614-1-nks@flawful.org>
 <20231226221714.GA1468266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226221714.GA1468266@bhelgaas>

Hello Bjorn,

On Tue, Dec 26, 2023 at 04:17:14PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> > 
> > Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> > correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> > support iATUs which require a specific alignment.
> > 
> > However, this support cannot have been properly tested.
> > 
> > The whole point is for the iATU to map an address that is aligned,
> > using dw_pcie_ep_map_addr(), and then let the writel() write to
> > ep->msi_mem + aligned_offset.
> > 
> > Thus, modify the address that is mapped such that it is aligned.
> > With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> > dw_pcie_ep_raise_msi_irq().

For the record, this patch is already queued up:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc


> 
> Was there a problem report for this?  Since 6f5e193bfb55 appeared in
> v5.7 (May 31 2020), and this should affect imx6, keystone am654,
> dw-pcie (platform), and keembay, it seems a little weird that this bug
> persisted so long.  Maybe nobody really uses endpoint support yet?
> 
> But I assume you observed a failure and tested this fix somewhere.

Yes, I verified it on rockchip rk3588.

I'm working on upstreaming rk3588 EP support:
https://github.com/floatious/linux/commits/rockchip-pcie-ep

Right now rk3588 only has support for RC in mainline.


The fix is only needed for platforms which:
1) supports MSI-X
2) has an iATU alignment requirement,
so where epc->mem->window.page_size != 0.

pci_epc_mem_init() calls pci_epc_multi_mem_init() which
initializes epc->mem->window.page_size with ep->page_size.

$ git grep page_size drivers/pci/controller/dwc/

So it will not affect pcie-designware-plat.c, nor pcie-keembay.c,
since they don't set any ep->page_size.

It will not affect pcie-tegra194.c, since it doesn't use
dw_pcie_ep_raise_msix_irq().

Looking at pci-imx6.c, imx6_pcie_ep_raise_irq() calls
dw_pcie_ep_raise_msix_irq(), but:

static const struct pci_epc_features imx8m_pcie_epc_features = {
        .msix_capable = false,
}

so while pci-imx6.c will call dw_pcie_ep_raise_msix_irq(),
I assume that it will return early, in this if-statement:
https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L596-L598

That leaves just pci-keystone.c (am654 compatible only).

I don't know why no one has reported this bug before,
I can only assume insufficient testing.

I guess you might be lucky and happen to get an address that is
aligned to the iATU alignment requirement, but that is unlikely
to happen when rebooting and running pcitest.sh multiple times.


> 
> And the failure is that we send the wrong MSI-X vector or something
> and get an unexpected IRQ and a driver hang or something?  In other
> words, how does the bug manifest to users?

pcitest.sh fails the MSI-X tests.
With this fix the MSI-X tests in pcitest.sh passes.


> 
> > Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> > Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > Changes since v1:
> > -Clarified commit message.
> > -Add a working email for Kishon to CC.
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index f6207989fc6a..bc94d7f39535 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	}
> >  
> >  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > +	msg_addr &= ~aligned_offset;
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> >  				  epc->mem->window.page_size);
> 
> Total tangent and I don't know enough to suggest any changes, but it's
> a little strange as a reader that we want to write to ep->msi_mem, and
> the ATU setup with dw_pcie_ep_map_addr() doesn't involve ep->msi_mem
> at all.
> 
> I see that ep->msi_mem is allocated and ioremapped far away in
> dw_pcie_ep_init().  It's just a little weird that there's no
> connection *here* with ep->msi_mem.

There is a connection. dw_pcie_ep_raise_msix_irq() uses ep->msi_mem_phys,
which is the physical address of ep->msi_mem:

ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
                                  epc->mem->window.page_size);  


> 
> I assume dw_pcie_ep_map_addr(), writel(), dw_pcie_ep_unmap_addr() have
> to happen atomically so nobody else uses that piece of the ATU while
> we're doing this?  There's no mutex here, so I guess we must know this
> is atomic already because of something else?

Most devices have multiple iATUs (so multiple iATU indexes).

pcie-designware-ep.c:dw_pcie_ep_outbound_atu()
uses find_first_zero_bit() to make sure that a specific iATU (index)
is not reused for something else:
https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L208

A specific iATU (index) is then freed by dw_pcie_ep_unmap_addr(),
which does a clear_bit() for that iATU (index).

It is a bit scary that there is no mutex or anything, since
find_first_zero_bit() is _not_ atomic, so if we have concurrent calls
to dw_pcie_ep_map_addr(), things might break, but that is a separate
issue.

I assume that this patch series will improve the concurrency issue,
if it gets accepted:
https://lore.kernel.org/linux-pci/20231212022749.625238-1-yury.norov@gmail.com/


Kind regards,
Niklas


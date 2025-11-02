Return-Path: <linux-pci+bounces-40068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82AC290CE
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2DE34E6245
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551B218AAF;
	Sun,  2 Nov 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF/tw33G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF31C5D59;
	Sun,  2 Nov 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096107; cv=none; b=J1lofNmpwl0xQq+JzVgMhXueCbvFTaZbvi/hyTGZvsydM/ePcCoGlHlWW3YTallxt2s46lWJYXjPuCoOOEoKYstr/OuePigI0b1P8sJeEZHxHOausvJJE/aVeAt+jALhpEL2p6SwYfKYSBnfOdeOJgVR11rMuEiCw2OzkhcCkys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096107; c=relaxed/simple;
	bh=FH0BzuS1tbXUJxSwIHQjZhrYUg0CGD4OU9FMRivhPYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYI5a1Rvuc4OevKPDTEe+QAO3XzxYBJek2UPuBwce4mopH5qlr7kXjVkw/y4j8g1JMBhpOnMtHTIKIQ91Wxm52TrHH7Ye6q8GQBpi3wjSw9C2EBlFB6Wb6LkZZBJwhZetfmXTm3l6J4S0jZmlIXHoGzVLAYDCXSyRoWj80Fld08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF/tw33G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98D0C4CEF7;
	Sun,  2 Nov 2025 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762096107;
	bh=FH0BzuS1tbXUJxSwIHQjZhrYUg0CGD4OU9FMRivhPYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XF/tw33GPXN5g9nb4CnSO3suUvGDUbsKEOQvCm/4UTFbCA7N6iQ49Dx5bfu9su//X
	 2M+CHsI7bfJDi7tceiNfXgSNsKEF2x9Rh6yyPmjIHX7KpW6OyoaC+OjcpRSwKR2I5B
	 6LX8ZGqHBUCwZoY6bCUXbzUN/U90i1NmAnNXA6q5fyBnFXGutrymoJFPRznw1+8K00
	 mEdWRmrOCoP/Bgbb8OFMZBBK8NIGoumCBzu53Cz5d6W0hnOwAV0xWLq8MICbOKdDLH
	 AX8Xz07KghkXhHy1+N0h5RzJcadcKZ8HCurkctWO4h8tj4W9mXFVUGUQmBMhjc7d2R
	 DjZuKNJEx7DbQ==
Date: Sun, 2 Nov 2025 20:38:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "helgaas@kernel.org" <helgaas@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"fugang.duan@cixtech.com" <fugang.duan@cixtech.com>, "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>, 
	"peter.chen@cixtech.com" <peter.chen@cixtech.com>, 
	"cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <jmxdju5aon3biunji6rplxmapb6j7ozet37olxtcknznqekw7p@a3bj7glbxc4n>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
 <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
 <CH2PPF4D26F8E1C0BE70D4B6BB9B3A334D9A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PPF4D26F8E1C0BE70D4B6BB9B3A334D9A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Sun, Nov 02, 2025 at 05:51:05AM +0000, Manikandan Karunakaran Pillai wrote:
> Hi Mani,
> 
> Pls find my comments below.
> 
> >> >> +			value |=
> >> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> >> >> +	} else {
> >> >> +		value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> >> >> +		if ((flags & IORESOURCE_PREFETCH))
> >> >> +			value |=
> >> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> >> >> +	}
> >> >> +
> >> >> +	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
> >> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >> >CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >> +static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
> >> >> +					 struct resource_entry *entry)
> >> >
> >> >This and other functions are almost same as in 'pcie-cadence-host'. Why
> >don't
> >> >you reuse them in a common library?
> >>
> >> The function cdns_pcie_hpa_host_bar_config() calls functions
> >cdns_pcie_hpa_host_bar_ib_config()
> >> which is not common. All functions that are common between the two
> >architecture are moved to the
> >> common library file based on earlier comments.
> >>
> >
> >This is not a good reason to duplicate the whole function. You could just make
> >the common function accept the callback ib_config() and pass either
> >cdns_pcie_host_bar_ib_config() or cdns_pcie_hpa_host_bar_ib_config().
> >
> >This pattern could be done for other functions as well. Please audit all of them
> >and move them to common library. Currently, I could see a lot of duplications
> >that could be avoided.
> 
> The very first patch  for this feature included an ops struct  which was registered (very similar to a callback). Are are asking me to again implement the same design which was earlier rejected ?
> 

You didn't provide any link to the discussion, so how can I decide without
looking into it?

> Secondly except the names of the functions, the registers and their offset written and the sequence also changes for the implementations.
> 

I don't think so. From a quick look, at least cdns_pcie_hpa_host_bar_config(),
cdns_pcie_hpa_host_map_dma_ranges() are mostly similar. You can keep the
functions having different register configurations, but should try to move
others.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


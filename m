Return-Path: <linux-pci+bounces-40072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7DDC29256
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64481188CF66
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C16246BD5;
	Sun,  2 Nov 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIY+dR+9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CA224F3;
	Sun,  2 Nov 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101556; cv=none; b=FCTXzXbR6Ka7hPV9CII8rGL6uTTiErqh1m+EjRqiKpyPxwLi45XEHC9w8Lwg5zXJyvEyjRrEWXtHSioZu08fTmxdnn1CwL6qRLE2mM6oG7rW7vrsw/HjW6tbDx6RVVYY27vGfZ0QfhowpmUHR8e3LYLTQ9G5ewHFC7pLrVjhUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101556; c=relaxed/simple;
	bh=3ZArhkFRm+rcLEEFYZIIpNf1RwXO+ECi8B982GOi3o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usLRMNVy8iL9bjtyvEA/VzYjOdtxO9MnaRgmRRak6ZdkQQJ9oXkQyn/gEjobSfRVrvifxVxBp9q7mwbkSQo/uFEmVrlnTfDVIpaL4I7txat497JQDlnDy7k9wWishyQVtMuWwcLlPMTlSWBHFAE/oNmIdXHexQLfXJhFlvJ5HTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIY+dR+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CFEC4CEF7;
	Sun,  2 Nov 2025 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762101555;
	bh=3ZArhkFRm+rcLEEFYZIIpNf1RwXO+ECi8B982GOi3o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIY+dR+9wK3ci9HadcuWXCO4qEbZa4GQ+4sksCx2lUowRCXDGmAwM3+GKX1jk1vLb
	 o00nlS6OcT22fhZTVgyTnZZFyJg9KPnSa1ebWJJUH0EngnJYqSrXb7h34+l78jjTLh
	 VSLgjBa2AHoQy+M5twQOuSOd2iuTmOdjY+LFuboyawQ5ItrEH8+KXGD3OmstDjFU4Y
	 HeECCnrCbhNPgmEdnlzoSD7k3HWpJGiaEtPNXh7y9TLPntV/oz3LiIaglaa5s3802N
	 /ijtm2XILap+b2HCsMyJiruDsWAwG1fgJ3cKAPHv2XqieHI54yFuUnzHAXvkzCvDwC
	 JWvUlSRz8aNmw==
Date: Sun, 2 Nov 2025 22:09:01 +0530
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
Message-ID: <wegcjrrgtzetavfujj24obsuc5av6kzqjtw62neffpgoga7qfo@pxnunfe5aqrc>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
 <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
 <CH2PPF4D26F8E1C0BE70D4B6BB9B3A334D9A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <jmxdju5aon3biunji6rplxmapb6j7ozet37olxtcknznqekw7p@a3bj7glbxc4n>
 <CH2PPF4D26F8E1CB5EFC6AC9818A065A519A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PPF4D26F8E1CB5EFC6AC9818A065A519A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Sun, Nov 02, 2025 at 03:53:01PM +0000, Manikandan Karunakaran Pillai wrote:
> 
> 
> >-----Original Message-----
> >From: Manivannan Sadhasivam <mani@kernel.org>
> >Sent: Sunday, November 2, 2025 8:38 PM
> >To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
> >Cc: hans.zhang@cixtech.com; bhelgaas@google.com; helgaas@kernel.org;
> >lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> >kwilczynski@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> >fugang.duan@cixtech.com; guoyin.chen@cixtech.com;
> >peter.chen@cixtech.com; cix-kernel-upstream@cixtech.com; linux-
> >pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
> >Architecture (HPA) controller
> >
> >EXTERNAL MAIL
> >
> >
> >On Sun, Nov 02, 2025 at 05:51:05AM +0000, Manikandan Karunakaran Pillai
> >wrote:
> >> Hi Mani,
> >>
> >> Pls find my comments below.
> >>
> >> >> >> +			value |=
> >> >> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> >> >> >> +	} else {
> >> >> >> +		value |=
> >HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> >> >> >> +		if ((flags & IORESOURCE_PREFETCH))
> >> >> >> +			value |=
> >> >> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> >> >> >> +	}
> >> >> >> +
> >> >> >> +	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
> >> >> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >> >> >CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> >> >> >> +
> >> >> >> +	return 0;
> >> >> >> +}
> >> >> >> +
> >> >> >> +static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
> >> >> >> +					 struct resource_entry *entry)
> >> >> >
> >> >> >This and other functions are almost same as in 'pcie-cadence-host'. Why
> >> >don't
> >> >> >you reuse them in a common library?
> >> >>
> >> >> The function cdns_pcie_hpa_host_bar_config() calls functions
> >> >cdns_pcie_hpa_host_bar_ib_config()
> >> >> which is not common. All functions that are common between the two
> >> >architecture are moved to the
> >> >> common library file based on earlier comments.
> >> >>
> >> >
> >> >This is not a good reason to duplicate the whole function. You could just
> >make
> >> >the common function accept the callback ib_config() and pass either
> >> >cdns_pcie_host_bar_ib_config() or cdns_pcie_hpa_host_bar_ib_config().
> >> >
> >> >This pattern could be done for other functions as well. Please audit all of
> >them
> >> >and move them to common library. Currently, I could see a lot of
> >duplications
> >> >that could be avoided.
> >>
> >> The very first patch  for this feature included an ops struct  which was
> >registered (very similar to a callback). Are are asking me to again implement
> >the same design which was earlier rejected ?
> >>
> >
> >You didn't provide any link to the discussion, so how can I decide without
> >looking into it?
> 
> https://www.spinics.net/lists//devicetree/msg814276.html 
> 
> Patch v5 - 5/5 has the comments on callback.
> 

That was a completely different comment. Both Rob and myself suggested getting
rid of platform specific ops and move towards the common library.

Here, I'm suggesting you to have some functions in the common library accept a
callback as a function argument for the controller arch (host vs HPA). This will
allow you to have more functions in the common library as opposed to duplicating
the function definitions.

Both are not the same.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


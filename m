Return-Path: <linux-pci+bounces-32071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FAB04093
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066C2188929C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B99253B52;
	Mon, 14 Jul 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3ddQ4qh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C720246BB9;
	Mon, 14 Jul 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501093; cv=none; b=DiSe/XhnlW0VNRPGMnvAqZAMZKGSXP8zoo/RNWK80Xs+lCxBeZCQGBru01U1alcg8ttWI6fOj+0cHdMkKZVDlCQ135aSiQsCkhbd+Mhzqj0JOEojY6zT8v9FHj5cWwaU9fJz9kOEWh1OJ/v08AVJ34wgeUYjAlVSy19cyeEHNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501093; c=relaxed/simple;
	bh=wEFbqS8TlqYik+f8XbfTNLMdRUhavAYHebu3HmoWO50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlLV4SweN+gGhYGFxHlykPlFNSwYQEDZakr+l/Wnc98kt1qzzyx7++hIDmQtyRo3DKWfMkNYO68cuOpdyjSGlKa4+7Jr/leIU+5z5+cG/zr69T4xCVVvemD57+4s/XwfRmYOL0YrIgnGr8VmpHxGAWG2G3Efz1iDE8hA5wQKOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3ddQ4qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA606C4CEED;
	Mon, 14 Jul 2025 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752501092;
	bh=wEFbqS8TlqYik+f8XbfTNLMdRUhavAYHebu3HmoWO50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3ddQ4qhYjcSKCYEWWshXmRIhOzJtNxAdmeOK6CWi+oVNPEN3DO+2jGTH4lAlruIG
	 8+y9K9w8FTayMurEMmYs+HJMLbwH93DOBGTDYbMkK8hO/UUo2/nSvH7eCjGeeWkOey
	 mgiu7JMTM4aHNcSd0WPWuZtphZIbRlYB7F0KcK12xap9MT1nZm83j4IF/QAIjxf2s4
	 YFZmrw00/pkiG7+S+JC4sJiqXvv9pbtl9bkP7nP0K2OBeBAViMpnbmC3blCaJGgZ9Z
	 LVGKAotp9ugJVjEBFL+kqX1qJxiWcWz+30H/LxzJUGav3P83Twf/E0XDrYGGRg8D3r
	 TePbTsIYH05gQ==
Date: Mon, 14 Jul 2025 19:21:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <gwpn5no4i2wwwk3qo4tcgp6z6floo6k2ymzfuucg3tbwtmccte@ydsupmrd2nqu>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com>
 <20250711230013.GA2309106@bhelgaas>
 <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
 <9543b1eb-5bd2-bea1-742f-60cbc28bb365@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9543b1eb-5bd2-bea1-742f-60cbc28bb365@linux.intel.com>

On Sun, Jul 13, 2025 at 07:27:57PM GMT, Ilpo Järvinen wrote:
> On Sat, 12 Jul 2025, Manivannan Sadhasivam wrote:
> > On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> > > On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo Järvinen wrote:
> > > 
> > > > +++ b/include/linux/pci.h
> > > > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
> > > >  #ifdef CONFIG_PCIEASPM
> > > >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> > > >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > > 
> > > AFAICT there's no caller of this at all.  Why do we keep it?
> > > 
> > 
> > I'm just working on a series to convert the ath{10/11/12}k drivers to use this
> > API instead of modifying LNKCTL register directly:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n961
> 
> Great. I assume but "this API" you meant disable/enable link state that 
> are real pair unlike the current pci_enable_link_state()?
> 

Yes. I actually based my series on top of this series, but I guess I should just
merge the API change patch to my series as it is relatively small compared to
this one (so it will get merged quicker).

> Did ath1xk need to do some hw specific register updates when changing ASPM 
> state?
> 

Fortunately, no.

> I tried to do similar conversion in r8169 (and actually also ath1xk too) 
> but it was a while ago already. If I understood the code correctly, r8169 
> seems to write some HW specific registers when changing ASPM state so I 
> would have likely need to add some ops for it to play nice with state 
> changes not originating from the driver itself but from the ASPM driver, 
> which is where the work then stalled.
> 

ath driver changes are straightforward, but I need to add an inline function to
convert lnkctl setting to aspm states:

static inline int ath_pci_aspm_state(u16 lnkctl)
{
	int state = 0;

	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
		state |= PCIE_LINK_STATE_L0S;
	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
		state |= PCIE_LINK_STATE_L1;

	return state;
}

Currently, it is in ath/ath.h, but if you feel that we should move it to
include/linux/pci.h, let me know!

> > > > -int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> > > 
> > > We only have two callers of this (pcie-qcom.c and vmd.c, both in
> > > drivers/pci/), so it's not clear to me that it needs to be in
> > > include/linux/pci.h.
> > > 
> > > I'm a little dubious about it in the first place since I don't think
> > > drivers should be enabling ASPM states on their own, but pcie-qcom.c
> > > and vmd.c are PCIe controller drivers, not PCI device drivers, so I
> > > guess we can live with them for now.
> > > 
> > > IMO the "someday" goal should be that we get rid of aspm_policy and
> > > enable all the available power saving states by default.  We have
> > > sysfs knobs that administrators can use if necessary, and drivers or
> > > quirks can disable states if they need to work around hardware
> > > defects.
> > 
> > Yeah, I think the default should be powersave and let the users disable it for
> > performance if they want.
> 
> I'm certainly not against improvements in this front, but I think we need 
> to get rid off custom ASPM disable code from the drivers first.
> 

It would be difficult IMO as drivers have their own usecases. For instance, the
ath drivers need to disable ASPM states to avoid issues during firmware
download. Then they need to enable ASPM back once the firmware is up and
running.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


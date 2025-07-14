Return-Path: <linux-pci+bounces-32084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE8B04805
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BD53AEB4C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3F22A7E9;
	Mon, 14 Jul 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecMBadbj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0451662E7;
	Mon, 14 Jul 2025 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522132; cv=none; b=h6DOMiJq0Y1Gy+k1q+FE3lah+a6HH93qHpzNxhW89AHzuQDr4Na37Ivsn9dbJpzZ7VvXTAxvnrOH5r35cgmOzePhHYW3xh0P+r0Z3geLzaj1EiNT/JsNpuhUEX5l/yk9M9fEOTcvHtzJO1ig/VEe2o8xNJZTPyn9GAvwlym1XuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522132; c=relaxed/simple;
	bh=ZwfxCQTzGcagrhNN128iX8ZCx0f/OBRMMJHaiqxxpiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YstFbFbITDcQ59+J2Y9XzrRJAFCHE0x/Bv+BlYHU8EmEDFXNj5xZTUvs0+mh90f7APvlZhgJ6Bl9zadBI6NswIs7EgvaVB1+lOgQZIunqHqk2qHyg8Ljl+EihihBysE6OxffcuKugvaiXzlV+eVaC6JGzUbNy8lwRPyGncEK9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecMBadbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7978DC4CEED;
	Mon, 14 Jul 2025 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752522130;
	bh=ZwfxCQTzGcagrhNN128iX8ZCx0f/OBRMMJHaiqxxpiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ecMBadbjd7FZqxSx5x58d/jEVKcEidTJa/y2tEB91mpgRzILb/XNeffNmHfcve2at
	 Bfu/oNAn0YGbWYgbGvB7St73SXCvXih8WZCa20Sfp4N5Slw/Jz1GVQn7FrHoJDX4w3
	 DVmrHZso9y/CxNND/f7hplvFfiJbBTVs5nfv3lDnHta/jrKE8ACVOCef4lY1p20DRW
	 iipvykN6PuX4S3ek4w1Iqk5wvRbAkDexurWSHWFpuyxLw/DgnwyMQ9nRQBpymbNQTL
	 wp+2fshCBaFY6LY1sI1L8C/yLD1oVWjJ/qHQR//JYsEsQ1Xw5v+NLKUgeDRcoIoAH3
	 G3ijQrgYbpjzg==
Date: Mon, 14 Jul 2025 14:42:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <20250714194209.GA2415586@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gwpn5no4i2wwwk3qo4tcgp6z6floo6k2ymzfuucg3tbwtmccte@ydsupmrd2nqu>

On Mon, Jul 14, 2025 at 07:21:21PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jul 13, 2025 at 07:27:57PM GMT, Ilpo Järvinen wrote:
> > On Sat, 12 Jul 2025, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> > > > On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo Järvinen wrote:
> > > > 
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
> > > > >  #ifdef CONFIG_PCIEASPM
> > > > >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> > > > >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > > > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > > > 
> > > > AFAICT there's no caller of this at all.  Why do we keep it?
> > > 
> > > I'm just working on a series to convert the ath{10/11/12}k
> > > drivers to use this API instead of modifying LNKCTL register
> > > directly:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n961
> > 
> > Great. I assume but "this API" you meant disable/enable link state
> > that are real pair unlike the current pci_enable_link_state()?
> 
> Yes. I actually based my series on top of this series, but I guess I
> should just merge the API change patch to my series as it is
> relatively small compared to this one (so it will get merged
> quicker).
> 
> > Did ath1xk need to do some hw specific register updates when
> > changing ASPM state?
> 
> Fortunately, no.
> 
> > I tried to do similar conversion in r8169 (and actually also
> > ath1xk too) but it was a while ago already. If I understood the
> > code correctly, r8169 seems to write some HW specific registers
> > when changing ASPM state so I would have likely need to add some
> > ops for it to play nice with state changes not originating from
> > the driver itself but from the ASPM driver, which is where the
> > work then stalled.

Pffft.  Device-specific configuration when changing ASPM state is a
device defect in my book.  ASPM is clearly designed to be managed
outside the driver.  What is the driver supposed to do about this if
the platform retains control of ASPM?  There's no possibility of a
driver hook for that.

> ath driver changes are straightforward, but I need to add an inline
> function to convert lnkctl setting to aspm states:
> 
> static inline int ath_pci_aspm_state(u16 lnkctl)
> {
> 	int state = 0;
> 
> 	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> 		state |= PCIE_LINK_STATE_L0S;
> 	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> 		state |= PCIE_LINK_STATE_L1;
> 
> 	return state;
> }
> 
> Currently, it is in ath/ath.h, but if you feel that we should move it to
> include/linux/pci.h, let me know!

I haven't looked at the implementation here, but I don't think drivers
should check LNKCTL to decide this.  If the device doesn't work with
L0s or L1 or whatever, that's what the driver should tell us.

Bjorn


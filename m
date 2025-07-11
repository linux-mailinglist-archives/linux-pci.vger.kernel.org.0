Return-Path: <linux-pci+bounces-31966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965FB02749
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482EC1C8849A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4F223327;
	Fri, 11 Jul 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1910RDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BE1F63C1;
	Fri, 11 Jul 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274815; cv=none; b=HlaaCa1pAM77PHBtbNZnQXgYejQwxfPW9Cvb9+LubPRZE+FXpngB/vRRVyP9rYe4REr3N2H0JbQ+YZMuy9ankM8WgElJTYfRhBuh0Ms57TVz3N70HETAtO/egIpINtpAz4L12wZ3Sqe8xzGgjC7lXRBg30S+hxk1zz87wiDrhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274815; c=relaxed/simple;
	bh=I/WYWVtYM4EC/upgYCe6fwOOyi0ZjnLy4T8UxOcBMNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EYN4KNKkYrNq91Wo/uw8tM6LY2n0EcEvV9hh/22K+baMOnTpycj9n9pUTX0Xr8l/iRQ7+k9XerJYebmyz0MlzNoskowJNN1HPcxhLwth+pwthPnBF6Wy3VaELkE4T2ERqU3jIGr+u8k2nH+JY31q3fH3kdTko11CZS7EPxsER2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1910RDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2460DC4CEED;
	Fri, 11 Jul 2025 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752274815;
	bh=I/WYWVtYM4EC/upgYCe6fwOOyi0ZjnLy4T8UxOcBMNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B1910RDgevOjKAnH5ke4u1MUJuUNgfkaBqgr/BQLtOBt1fxIS7pqRbFSRnLY0Yqvp
	 y8jmPFHe9c3Y8XsL6JI7P2hlZ5h6hkXysZYTD2vm3nzfz8vAVRxdw6bjawGH7f7v9x
	 FoGqGXteH3zJkoa8KUS4yNoYKCxHfIbXmL7nCMymcl7QyA2baqALxdShLSjdYgFrbF
	 vJMOZg/kpgPGDmWCJuDPwcf0yc0WaFZZxM0bkceOGYGl5MUeXw88aHd5R3iWyaBrRT
	 tnrC34A+VtQHKtiaQr1MI9g4L525RZg/ImWIFuZp7vxygrY2Zb6BLUJsFwzzhVzCZ4
	 cNobNaAiQE+3A==
Date: Fri, 11 Jul 2025 18:00:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <20250711230013.GA2309106@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com>

On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo Järvinen wrote:

> +++ b/include/linux/pci.h
> @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>  #ifdef CONFIG_PCIEASPM
>  int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> -int pci_enable_link_state(struct pci_dev *pdev, int state);

AFAICT there's no caller of this at all.  Why do we keep it?

> -int pci_enable_link_state_locked(struct pci_dev *pdev, int state);

We only have two callers of this (pcie-qcom.c and vmd.c, both in
drivers/pci/), so it's not clear to me that it needs to be in
include/linux/pci.h.

I'm a little dubious about it in the first place since I don't think
drivers should be enabling ASPM states on their own, but pcie-qcom.c
and vmd.c are PCIe controller drivers, not PCI device drivers, so I
guess we can live with them for now.

IMO the "someday" goal should be that we get rid of aspm_policy and
enable all the available power saving states by default.  We have
sysfs knobs that administrators can use if necessary, and drivers or
quirks can disable states if they need to work around hardware
defects.

I think the compiled-in aspm_policy default and the module parameters
are basically chicken switches that only exist because aspm.c and some
devices aren't robust enough.

Bjorn


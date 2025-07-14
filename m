Return-Path: <linux-pci+bounces-32082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB09B047E0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F96E3A2B16
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0626D4C9;
	Mon, 14 Jul 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfcY4L78"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397452E36F0;
	Mon, 14 Jul 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520887; cv=none; b=aABKuVrI/zK5Lcs0Z8xkN8dysOAur1Y2wtuJXVHlFDS4ntgZHlOdxS/mIukk2FiGLWXIz1aV3TG0R3PV31Ko+xkAxHNbp20SqSvdpnbJZuS8WrLacx6JcdfUZVpix2igB32KPVQn45CF7woivabrdmIMOfp20kBrx/jQUyFAYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520887; c=relaxed/simple;
	bh=ssDIZ6lVVA4nrtzbmsJMiQpIz0j9r1OlWlOQVhLVCvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G7vKdbkVEs05fCFfp3qtA8di9nv4i8tSsB/XEpeRvMdj8UgI6ifSDZ2r+gl4ACLDaqozluRCZR9ZZjdIJ1NeidKqwBjzFZdHMdWLRvyztZ0eAGHTaZb255nCLvS8YK1LLwST+jKy0Zt0GUldvQ58T6kJwufrMXSUysIsrsuXi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfcY4L78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D403C4CEED;
	Mon, 14 Jul 2025 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752520886;
	bh=ssDIZ6lVVA4nrtzbmsJMiQpIz0j9r1OlWlOQVhLVCvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IfcY4L78k/3SXQBULobxN/UA/xkUaUJv8YvUlHtFq8SQMkkvrTOf57L0/xtif0kSb
	 AARXv/2u9T6tCh5t0Ghqm6rXXPwMEkw0jIBAkQ3on7G3+sn65Tn11RUlZlmeagaLct
	 7KrF4B+138fcR1lYKla5ELX244Pnt1tU4EmObeUmmOgN6u5o+1yG1Vlo5SwJ6OOi+5
	 zweksJIKL/m41i3EEmooQWe5YQa45PY1e2CW3Gwq2N51QsKmGXxVkQWrz9FAaOwe2C
	 u5xJm958+ifYl/pNM/j/Jlzzt+nqfMINOoEjn13jtGRFsIFLYlsOgEkswevC4D9i5W
	 K63r8BywQb3Iw==
Date: Mon, 14 Jul 2025 14:21:25 -0500
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
Message-ID: <20250714192125.GA2414954@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>

On Sat, Jul 12, 2025 at 03:05:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> > On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo Järvinen wrote:
> > 
> > > +++ b/include/linux/pci.h
> > > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
> > >  #ifdef CONFIG_PCIEASPM
> > >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> > >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > 
> > AFAICT there's no caller of this at all.  Why do we keep it?
> 
> I'm just working on a series to convert the ath{10/11/12}k drivers to use this
> API instead of modifying LNKCTL register directly:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n961

Awesome!  It will be great to get more of the ASPM gunk out of
drivers.


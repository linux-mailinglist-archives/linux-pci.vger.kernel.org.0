Return-Path: <linux-pci+bounces-35092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D990B3B611
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AF3B20DE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A92853EF;
	Fri, 29 Aug 2025 08:35:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD6261B6D;
	Fri, 29 Aug 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456525; cv=none; b=laVSc2+QfcrTZXUBjBg/gl9hfmCpnYlxoBAuTsvr9HjUc23QEH144tHRrgjEPmq/MCObaOTjagy4tykCsNe+Dy66EfhR1ve9YMJcXks9/ZNW6/cOnPxh1h1rfrmBdDsR6ak7C2gWGWvBfAtGgySx3J7rTgUvHNyOy1Ggv0aUn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456525; c=relaxed/simple;
	bh=zhFUw5FTo/Ejp3wHfGNYEMRD/5WGxpxHaIqzXWPclzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puSBbknJ6J4Wj5CfVQUBHpNQYy7NaTRwfROXEQgGod7RIGf8mAnk/cipRL+zLMkn6SK88hhp4nAGWwYWY9AcHIXRYCEJH4kG9/aS35z0454qug3JobVqGqnSXts7P9XQkV0lYt99bL4KpAFGDH2vR8ZUyG/D/CFJbY/GsFUHods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 98F5D2C09E19;
	Fri, 29 Aug 2025 10:35:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A41242A4F0; Fri, 29 Aug 2025 10:35:20 +0200 (CEST)
Date: Fri, 29 Aug 2025 10:35:20 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/4] PCI: host-common: Add link down handling for Root
 Ports
Message-ID: <aLFmSFe5iyYDrIjt@wunner.de>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <20250715-pci-port-reset-v6-2-6f9cce94e7bb@oss.qualcomm.com>
 <aLC7KIoi-LoH2en4@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLC7KIoi-LoH2en4@google.com>

On Thu, Aug 28, 2025 at 01:25:12PM -0700, Brian Norris wrote:
> On the flip side: it's not clear
> PCI_ERS_RESULT_NEED_RESET+pci_channel_io_normal works as documented
> either. An endpoint might think it's requesting a slot reset, but
> pcie_do_recovery() will ignore that and skip reset_subordinates()
> (pci_host_reset_root_port()).
> 
> All in all, the docs sound like endpoints _should_ have control over
> whether we exercise a full port/slot reset for all types of errors. But
> in practice, we do not actually give it that control. i.e., your commit
> message is correct, and the docs are not.
> 
> I have half a mind to suggest the appended change, so the behavior
> matches (some of) the docs a little better [1].

A change similar to the one you're proposing is already queued on the
pci/aer topic branch for v6.18:

https://git.kernel.org/pci/pci/c/d0a2dee7d458

Here's the corresponding cover letter:

https://lore.kernel.org/r/cover.1755008151.git.lukas@wunner.de

There was a discussion why I didn't take the exact same approach you're
proposing, but only a similar one:

https://lore.kernel.org/r/aJ2uE6v46Zib30Jh@wunner.de
https://lore.kernel.org/r/aKHWf3L0NCl_CET5@wunner.de


> Specifically, I'm trying to see what's supposed to happen with
> PCI_ERS_RESULT_CAN_RECOVER. I see that for pci_channel_io_frozen, almost
> all endpoint drivers return PCI_ERS_RESULT_NEED_RESET, but if drivers
> actually return PCI_ERS_RESULT_CAN_RECOVER, it's unclear what should
> happen.
> 
> Today, we don't actually respect it; pcie_do_recovery() just calls
> reset_subordinates() (pci_host_reset_root_port()) unconditionally. The
> only thing that return code affects is whether we call
> report_mmio_enabled() vs report_slot_reset() afterward. This seems odd.

In the series queued on pci/aer, I've only allowed drivers to opt in
to a reset on Non-Fatal Errors.  I didn't dare also letting them opt
out of a reset on Fatal Errors.

These changes of behavior are always risky, so it seemed prudent to not
introduce too many changes at once.  There was no urgent need to also
change behavior for Fatal Errors for the use case at hand (the xe graphics
driver).  I went through all drivers with pci_error_handlers to avoid
breaking any of them.  It's very tedious work, takes weeks.  It would
be necessary to do that again when changing behavior for Fatal Errors.

pcieaer-howto.rst justifies the unconditional reset on Fatal Errors by
saying that the link is unreliable and that a reset is thus required.

On the other hand, pci-error-recovery.rst (which is a few months older
than pcieaer-howto.rst) says in section "STEP 3: Link Reset":
"This is a PCIe specific step and is done whenever a fatal error has been
detected"

I'm wondering if the authors of pcieaer-howto.rst took that at face value
and thought they'd *have* to reset the link on Fatal Errors.

Looking through the Fatal Errors in PCIe r7.0 sec 6.2.7, I think a reset
is justified for some of them, but optional for others.  Which leads me
to believe that the AER driver should actually enforce a reset only for
certain Fatal Errors, not all of them.  So this seems like something
worth revisiting in the future.


> All in all, the docs sound like endpoints _should_ have control over
> whether we exercise a full port/slot reset for all types of errors. But
> in practice, we do not actually give it that control. i.e., your commit
> message is correct, and the docs are not.

Indeed the documentation is no longer in sync with the code.  I've just
submitted a series to rectify that and cc'ed you:

https://lore.kernel.org/r/cover.1756451884.git.lukas@wunner.de

Thanks,

Lukas


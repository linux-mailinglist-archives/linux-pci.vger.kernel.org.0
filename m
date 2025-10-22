Return-Path: <linux-pci+bounces-39042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF6BFD539
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67C8582056
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304F350298;
	Wed, 22 Oct 2025 16:19:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7C2BEC22
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149950; cv=none; b=e1oZn976Y/k2m0WldluHjNxSK3A9D54e23v4WUCUnh1gX4knm4laK8yjOfP+NqLiKrgP6OZuZnhCZidHj/p/UFiQyuuQZXm7yjk/v0Qk7ZSMsZH3G3yW+CiJaDojwh4KZR3hFoS3k5sFAqJzmDCThoJIv59yAaGAEG0JaLJ2nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149950; c=relaxed/simple;
	bh=8KEqGmF4e7gzWoRPSgXKhPWtwJlmQI+DbduQT+DzD9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMOcWrv96tfMZIxPFloojmDcVNKjkmlo7lc5RuhNDonIJlz4xqDls1c66zxdJQxVh95pGkPVAUsjgoJtLNZc8Zzeq3ovASHibp8cwn/NtPl8vp+DONM5YEL70aeAjc4R04e7jH7HE8fwLeY0BkiXZxekrhp1FpOqi17Q+Quanoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EEE792C06438;
	Wed, 22 Oct 2025 18:19:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D48114A12; Wed, 22 Oct 2025 18:19:05 +0200 (CEST)
Date: Wed, 22 Oct 2025 18:19:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?Adri=E0_Vilanova_Mart=EDnez?= <me@avm99963.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <aPkD-cECjlXx3kJP@wunner.de>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
 <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
 <aPj4kUglHgBm4uAt@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPj4kUglHgBm4uAt@wunner.de>

On Wed, Oct 22, 2025 at 05:30:25PM +0200, Lukas Wunner wrote:
> Looking at the ASPM configuration in the lspci output you've provided,
> I note that after booting without 4d4c10f763d7, ASPM is disabled on
> the Root Port but L1 is enabled on the Wifi card!
> 
> After resuming from system sleep, ASPM is disabled on both of them
> (with and without 4d4c10f763d7).
> 
> I suspect the incongruence of ASPM settings between Root Port and
> Wifi card is the root cause of the Presence Detect Changed flaps
> as well as the Correctable Errors.  I guess the BIOS set these
> incorrectly.  Looking at the code in:
> 
> pcie_aspm_init_link_state()
>   pcie_aspm_cap_init()
> 
> ... it first disables L0s and L1 to initialize L1 substates,
> then restores the register values as they were set by BIOS.
> This feels wrong.  The safest option is probably to instead
> disable L0s and/or L1 if either of them was only enabled
> on one of the two link partners.

Below is a completely untested patch to force ASPM to the
intersection of the two link partners, thus fixing incongruent
BIOS settings.  Does it help on a kernel with 4d4c10f763d7?
If it does, what's the behavior if applied to a kernel without
4d4c10f763d7?

I tried to find errata on the Intel AC 7265 "Stone Peak" wifi card
and instead found this document which explains that only L1 and
not L0s is supported:

https://fcc.report/FCC-ID/2AVBM-GK5/5728379.pdf

Thanks,

Lukas

-- >8 --

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281..7fd3eda 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -830,8 +830,8 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u16 parent_lnkctl, child_lnkctl, common_lnkctl;
 	u32 parent_lnkcap, child_lnkcap;
-	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 
 	if (blacklist) {
@@ -900,6 +900,12 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Restore L0s/L1 if they were enabled */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		common_lnkctl = FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) &
+				FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl);
+		parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPMC;
+		parent_lnkctl |= common_lnkctl;
+		child_lnkctl &= ~PCI_EXP_LNKCTL_ASPMC;
+		child_lnkctl |= common_lnkctl;
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
 	}


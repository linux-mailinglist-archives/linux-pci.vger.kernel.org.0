Return-Path: <linux-pci+bounces-21353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34382A3430E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCEF1887630
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AD2222A7;
	Thu, 13 Feb 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsx9dFEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CB281349;
	Thu, 13 Feb 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457623; cv=none; b=DXvwaKwFJoN8xW+97d4imj8c5q9KjQpzDDOaIIRtzTMqN6wy2mbyvSxmTAAT9p5ZvKdq+bpErKkQanpcPHgqakgZmhJ1w9/T3ZqYsGmgBTgwcSbIORyPUEXCAFxx+1xL7uwVD0j40YXSOFZFGktPud8lo4H9zTVO+X3Y674Xd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457623; c=relaxed/simple;
	bh=c2EICeY4G2Sh4ub6i//PddhAY/cHWby1P7zXvPMW3SM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R9BjgFbcas3bTarjWs+4vVwYuHUbUrARMxMuYAjJaaohgiYJ8x01//Awhlf1iOIxfA+L4sPTIpI+RXH5acbyD3JlB7RDYUmo9nXkSfoYa5Lw/GVmVy9+MfXl+1tlMh++ej+rY2qraJrTw7TMmSsSAOG2FQU1smqk2d49QlkdMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsx9dFEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592D4C4CED1;
	Thu, 13 Feb 2025 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457623;
	bh=c2EICeY4G2Sh4ub6i//PddhAY/cHWby1P7zXvPMW3SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tsx9dFEjBaK+AawFbQcXoElNPU7qIwnloBmvgufjKOAwVh5LLDuVNyz5hpceHJO2T
	 3qpOWYilaa/vs/YHgU60T/29cv15HjCgIKss0ibnUz+8k3fOcrafSM3dvnfkgKViWG
	 9GU3ujspmzjIDN1rBVI8c0r/uNK7DinvsZ4js0NihiJsIYvJo4ECDOuJI0WQyq3Bv7
	 PSGws4wLn8+tG1bv7ue27JqdnpVV4JySewDSfbSErYgDXn4m3YNQlDgiEJ/3glPQ6F
	 KlVm0zFwVSoMqYMG8Kf/n4LoCv+wwAToYy5BJPmbJyF2M8AC9uqcS591VKr3+FzosD
	 BpAcj9zg4ZAWw==
Date: Thu, 13 Feb 2025 08:40:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-pci@vger.kernel.org
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, Jan Beulich <jbeulich@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Deren Wu <Deren.Wu@mediatek.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Shayne Chen <Shayne.Chen@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid FLR for Mediatek MT7922 WiFi
Message-ID: <20250213144021.GA114126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212193516.88741-1-helgaas@kernel.org>

On Wed, Feb 12, 2025 at 01:35:16PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The Mediatek MT7922 WiFi device advertises FLR support, but it apparently
> does not work, and all subsequent config reads return ~0:
> 
>   pci 0000:01:00.0: [14c3:0616] type 00 class 0x028000 PCIe Endpoint
>   pciback 0000:01:00.0: not ready 65535ms after FLR; giving up
> 
> After an FLR, pci_dev_wait() waits for the device to become ready.  Prior
> to d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS"),
> it polls PCI_COMMAND until it is something other that PCI_POSSIBLE_ERROR
> (~0).  If it times out, pci_dev_wait() returns -ENOTTY and
> __pci_reset_function_locked() tries the next available reset method.
> Typically this is Secondary Bus Reset, which does work, so the MT7922 is
> eventually usable.
> 
> After d591f6804e7e, if Configuration Request Retry Status Software
> Visibility (RRS SV) is enabled, pci_dev_wait() polls PCI_VENDOR_ID until it
> is something other than the special 0x0001 Vendor ID that indicates a
> completion with RRS status.
> 
> When RRS SV is enabled, reads of PCI_VENDOR_ID should return either 0x0001,
> i.e., the config read was completed with RRS, or a valid Vendor ID.  On the
> MT7922, it seems that all config reads after FLR return ~0 indefinitely.
> When pci_dev_wait() reads PCI_VENDOR_ID and gets 0xffff, it assumes that's
> a valid Vendor ID and the device is now ready, so it returns with success.
> 
> After pci_dev_wait() returns success, we restore config space and continue.
> Since the MT7922 is not actually ready after the FLR, the restore fails and
> the device is unusable.
> 
> We considered changing pci_dev_wait() to continue polling if a
> PCI_VENDOR_ID read returns either 0x0001 or 0xffff.  This "works" as it did
> before d591f6804e7e, although we have to wait for the timeout and then fall
> back to SBR.  But it doesn't work for SR-IOV VFs, which *always* return
> 0xffff as the Vendor ID.
> 
> Mark Mediatek MT7922 WiFi devices to avoid the use of FLR completely.  This
> will cause fallback to another reset method, such as SBR.
> 
> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
> Link: https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582927149
> Link: https://lore.kernel.org/r/Z4pHll_6GX7OUBzQ@mail-itl
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Marek's tested-by to pci/for-linus for v6.14.

I also added a cc: stable tag.

> ---
>  drivers/pci/quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b84ff7bade82..82b21e34c545 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5522,7 +5522,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   * AMD Matisse USB 3.0 Host Controller 0x149c
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
> - *
> + * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> @@ -5534,6 +5534,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
>  
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> -- 
> 2.34.1
> 


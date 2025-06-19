Return-Path: <linux-pci+bounces-30177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD3AE045B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C25188683D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F722D7B9;
	Thu, 19 Jun 2025 11:52:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C422DFA6;
	Thu, 19 Jun 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333950; cv=none; b=F8K7N2OADEHx7bcbBMCgCgGp5qTXuhGssuUurp5vG2zX7ruZ+prmo3qay3K/dS/VMVgW49r25O3yBJL7YvAkugMPw40KuB2sDZBj0B7gn65FsgBVrR8ZGxKb72T/pwHIDn15mBtyx0D3xlFm229ocH0TUux+osz6TH3gZfPLWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333950; c=relaxed/simple;
	bh=y+mfvfRO3LvLtvSawFm5KlpFLf6wmj080xPpPri1ADo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq5zW+nfLoLeX6K594KsM7RoymFapaAYljeB4eaY+ToBeBEg3eLOvWYcDUrunMcRUauLUEgQMTOGBL7761h9Jdp/qJ06KsTbUuNXBL0TGHk7jzzunz5MNENLdp9MEL3zt7MV+j9qUCCf6aXMI6BDIoyd9jDasy+CK1Bcm1IPgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 934DD200B1D0;
	Thu, 19 Jun 2025 13:52:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 865ED4103A; Thu, 19 Jun 2025 13:52:23 +0200 (CEST)
Date: Thu, 19 Jun 2025 13:52:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	peter.du@hj-micro.com, jemma.zhang@hj-micro.com
Subject: Re: [RFC PATCH] PCI: pciehp: Replace fixed delay with polling for
 slot power-off
Message-ID: <aFP598Yyl0el1uKh@wunner.de>
References: <20250619093228.283171-1-andy.xu@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619093228.283171-1-andy.xu@hj-micro.com>

On Thu, Jun 19, 2025 at 05:32:28PM +0800, Hongbo Yao wrote:
> Fixed 1-second delay in remove_board() fails to accommodate certain
> hardware like multi-host OCP cards, which exhibit longer power-off
> latencies.

Please name the affected product(s).

They don't seem to comply to the spec.  How prevalent are they?
If there are only few deployed, quirks like this are probably
best addressed by an out-of-tree patch.

> Logs before fix:
> [157.778307] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0001 from Slot Status
> [157.778321] pcieport 0003:00:00.0: pciehp: Slot(31): Attention button pressed
> [157.785445] pcieport 0003:00:00.0: pciehp: Slot(31): Powering off due to button press
> [157.798931] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0001 from Slot Status

This log excerpt mixes messages from two separate hotplug ports
(0003:00:00.0 and 000b:00:02.0).  Are these hotplug ports related?
If not, please reduce the log excerpt to a single hotplug port
to avoid confusion.

> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -30,6 +30,25 @@
>  #define SAFE_REMOVAL	 true
>  #define SURPRISE_REMOVAL false
>  
> +static void pciehp_wait_for_link_inactive(struct controller *ctrl)
> +{
> +	u16 lnk_status;
> +	int timeout = 10000, step = 20;
> +
> +	do {
> +		pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> +					  &lnk_status);
> +
> +		if (!(lnk_status & PCI_EXP_LNKSTA_DLLLA))
> +			return;
> +
> +		msleep(step);
> +		timeout -= step;
> +	} while (timeout >= 0);
> +
> +	ctrl_dbg(ctrl, "Timeout waiting for link inactive state\n");
> +}

Any chance you can use one of the existing helpers, such as
pcie_wait_for_link()?

Is the 10 second delay chosen arbitrarily or how did you come up
with it?  How much time do the affected products really need?

> @@ -119,8 +138,11 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>  		 * After turning power off, we must wait for at least 1 second
>  		 * before taking any action that relies on power having been
>  		 * removed from the slot/adapter.
> +		 *
> +		 * Extended wait with polling to ensure hardware has completed
> +		 * power-off sequence.
>  		 */
> -		msleep(1000);
> +		pciehp_wait_for_link_inactive(ctrl);
>  
>  		/* Ignore link or presence changes caused by power off */
>  		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),

Please keep the msleep(1000), that's the minimum we need to wait
per PCIe r6.3 sec 6.7.1.8.

Please make the extra wait for link down conditional on
ctrl->pcie->port->link_active_reporting.  (DLLLA reporting is
optional for hotplug ports conforming to older spec revisions.)

Thanks,

Lukas


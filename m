Return-Path: <linux-pci+bounces-21836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB77A3C7DD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FBC3B00FB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43A21481A;
	Wed, 19 Feb 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNe2cJC4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC071E4AB;
	Wed, 19 Feb 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990809; cv=none; b=icTnEk46DZCihD6sHyajfplPrbJMB7Nf+ZPMZ5w2h15o3DlH5KuG2us1yZZh6aqBrHyG3wah6uCSkZ1qjPqWMqiP4oIB+1hJTwcDShHxok4H0/O3TYJnYQEhTgWiX8SdU53I1elxQnB8Wel9lZ6lKIHFWRNs3JTWE1a5HMi0d3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990809; c=relaxed/simple;
	bh=aWMFQ2zDDAVtHHfcPcX1+CRkmv36nV0yhax/HAyClbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jrakmitzmvKUa5QJvBOF9WDlH5SxbDFU2YL84KElIZ6a+AAakZcZY4NdjoojOKKr7UNhmleQ76XuJP3Ysqk8O+d9xONZ01ARGUPp2Y5bi/Y74pkNedUoU57219aXnP9IfJEzsk1wTebUWg3FLmjKtMqofowaS15tUF3NM36ZX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNe2cJC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6961EC4CED1;
	Wed, 19 Feb 2025 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739990808;
	bh=aWMFQ2zDDAVtHHfcPcX1+CRkmv36nV0yhax/HAyClbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jNe2cJC4XJAIb4Qj59HQFTi4BzSldncwzHKet61psAIarl/gT3lsxzGlT5AZfhw1s
	 wn3CuUMXIKwKoOhE2Tzwctu8rmbQWHsIoinIWmgXoOHJnjYbcRnna3Y/IObqPm4n1h
	 Qu6nLLutEgGoJ6s/OrX5xAxGZWujPwSOp2UKRpNQGsNdbyPHAECggmxs7IE1wF/adc
	 1Eon0TT6U18qR/3tMLzuzQM8t9drxCV9S5llRVapA8nuly2wKoCTxefXWeqym3m7pN
	 ad1+TOnET1Uw1tWlMYcywYcF/E9UV1/blNKu/2wd/fk4825mw9Wv8JO5DrFqReZCMQ
	 Q36G+bNd/64vQ==
Date: Wed, 19 Feb 2025 12:46:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	AceLan Kao <acelan.kao@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Put devices to low power state on shutdown'
Message-ID: <20250219184646.GA226882@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208074147.22945-1-kaihengf@nvidia.com>

[+to Rafael, +cc linux-pm]

On Sun, Dec 08, 2024 at 03:41:47PM +0800, Kai-Heng Feng wrote:
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
> 
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
> 
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.

aer_remove() disables AER interrupts, so I guess there must be a
non-AER interrupt being generated during shutdown?

If so, AER is a red herring and including the AER details above is a
distraction from whatever the real interrupt cause is.

> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
> 
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
> 
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  drivers/pci/pci-driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 35270172c833..248e0c9fd161 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
>  
> +	/*
> +	 * If driver already changed device's power state, it can mean the
> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
> +	 * as is.
> +	 */
> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> +		pci_prepare_to_sleep(pci_dev);


I don't know enough to draw inferences about PCI_D0 meaning a wakeup
setting is in place or a workaround being used.  That doesn't seem
like enough to be useful for me to maintain this in the future.  But
my power management understanding is pretty meager.

Would like an ack from Rafael for this.

>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -- 
> 2.47.0
> 


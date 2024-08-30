Return-Path: <linux-pci+bounces-12465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680619653BB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 02:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CC7B23B95
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 00:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97861139B;
	Fri, 30 Aug 2024 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8tp/Vrx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E922181;
	Fri, 30 Aug 2024 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724976100; cv=none; b=V3rUS+iO04Sbj3rupU4YWC89sW+2hjVLpGzfgegAfhwWO24+5Hc4EttmR7iSD/gNdRiT70vosE1QFiob7/9KZebCr16XdQ514uO9Xz/0jLg2DJ3mpkiKy+gQQBYmLQ0emTSzYcB1RykZBfFOOhd0sHMw6TjGk55ALXpGbiSkZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724976100; c=relaxed/simple;
	bh=T1ME1rHLVVmL3cGLna7XZrJPyHcnjZSXYF872fS4UtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X8pmBPBtgkb30Fg60GGcDxuPVS+7ziCr7/bt5UmulEWWzSwePGKn81T2m07ulETOAjoGAYHYFsAgwwVzLosZUjNajJl84/yZQ5oaWE3U2TrPhuCj9jfzdKHUhKy46zWFSkEqgGqCwCzljKq5aPDYenG7U6yF6SeRjlt5QwUTHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8tp/Vrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91313C4CEC1;
	Fri, 30 Aug 2024 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724976099;
	bh=T1ME1rHLVVmL3cGLna7XZrJPyHcnjZSXYF872fS4UtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O8tp/Vrxv/ZLEyEcfHgugAoQH6YMqi4gEx5+9S48khvX1P3sQY3fJoC9kitGjD7NT
	 jxJnz0IuATZLq2MFxt+Jt98u4LipYVCr0Ex8HCeNs1S4RWaaqZa/uSYMq44ffYLJOU
	 3hmG7vDdCz3D6IZGI55KRLXJsxKWmhZc6cdFI+UpFNMG9jbzJe3QEIPG2owG2Ato4O
	 ed+4ch7MiQ1Zf8tAJFmrO91VnFD8W/7K4pLx8xflLrrUZu5NVefmbKeHLhIJ+9xBEe
	 RPO4zJrsZggopeYJgwFBWz5PKCyBqRM+P1fvRMsgtE9aBXGjxsMMKY1ce3ClL4Ub6S
	 AXf7X3EagbxhA==
Date: Thu, 29 Aug 2024 19:01:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240830000137.GA84915@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823154023.360234-3-superm1@kernel.org>

On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a dock is plugged in at the same time as autosuspend delay then
> this can cause malfunctions in the USB4 stack. This happens because
> the device is still in D3cold at the time that the PCI core handed
> control back to the USB4 stack.
> 
> A device that has gone through a reset may return a value in
> PCI_COMMAND but that doesn't mean it's finished transitioning to D0.
> For devices that support power management explicitly check
> PCI_PM_CTRL on everything but system resume to ensure the transition
> happened.

Still trying to understand what's going on here.

I posted a change to pci_dev_wait() to read Vendor ID, look for Config
RRS status, and wait for a successful completion (when RRS Software
Visibility is enabled) [1].

You tested that and found that it didn't help with *this* issue [2].
I assume you tested something like v6.11-rc plus the patches from [1],
i.e., without the PCI_PM_CTRL changes in this series.

  1) Initially the device is in D0

  2) We put it in D3cold (using some ACPI method) because the
  autosuspend delay expired (?)

  3) Plugging in the dock wakes up the device, so we power up the
  device (via pci_power_up(), which again uses some ACPI method), and
  it should transition to D0uninitialized

  4) The USB4 stack sees the device but thinks it's in D3cold (?)

If your testing only included [1], but did not include the
pci_power_up() change from patch 3/5 "Verify functions currently in
D3cold have entered D0", I don't think we would call pci_dev_wait(),
so I wouldn't expect [1] to make any difference.

If you *did* include both [1] and patch 3/5, the implication would be
that pci_dev_wait() successfully read the Vendor ID, meaning the
device is not in D3cold when pci_power_up() returns.

Can you clarify what you see and possibly expand/correct my timeline
above?

[1] https://lore.kernel.org/linux-pci/20240827234848.4429-1-helgaas@kernel.org/
[2] https://lore.kernel.org/linux-pci/30d9589a-8050-421b-a9a5-ad3422feadad@amd.com/

> Devices that don't support power management and system resume will
> continue to use PCI_COMMAND.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Fix misleading indentation
>  * Amend commit message
> ---
>  drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1e219057a5069..f032a4aaec268 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
>  	 * the read (except when CRS SV is enabled and the read was for the
>  	 * Vendor ID; in that case it synthesizes 0x0001 data).
>  	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> +	 * Wait for the device to return a non-CRS completion.  On devices
> +	 * that support PM control and on waits that aren't part of system
> +	 * resume read the PM control register to ensure the device has
> +	 * transitioned to D0.  On devices that don't support PM control,
> +	 * or during system resume read the command register to instead of
> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>  	 */
>  	for (;;) {
> -		u32 id;
> -
>  		if (pci_dev_is_disconnected(dev)) {
>  			pci_dbg(dev, "disconnected; not waiting\n");
>  			return -ENOTTY;
>  		}
>  
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> -			break;
> +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
> +			u16 pmcsr;
> +
> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
> +				break;
> +		} else {
> +			u32 id;
> +
> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
> +			if (!PCI_POSSIBLE_ERROR(id))
> +				break;
> +		}
>  
>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
> -- 
> 2.43.0
> 


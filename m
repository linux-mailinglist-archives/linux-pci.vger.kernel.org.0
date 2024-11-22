Return-Path: <linux-pci+bounces-17229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1119D65C3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35697282659
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B718A6AA;
	Fri, 22 Nov 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE9n+TDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C41189F36;
	Fri, 22 Nov 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314052; cv=none; b=McxJhhP1LSzZhSg4ZbafgbqnQwgfYMVVoQKyKp15Lvm/q8K6WJLeFSWJPesLR44zQ1EHlcbpVnthXDNRJj8sVJkBKUXzeN5Q6mQwmyH3QGxaipcF1bR3CNwthi6CSg7z9IbUuAsgBrXPqrdecO4BeZc7ukJrE5A9kh0jUubljxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314052; c=relaxed/simple;
	bh=TDoD+lOCxLL6fD8iEhwdRn95Pj9mWgTMDjgMOuci1bI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BNvbYVl7rYKoO4T3/BwtSfnK6iYNFHi2VUEn6ht0+5PYxIEPzMJZD3EACICg0fleQ/OD82U9aZjIg8kcVf+Hg91TxipOYkVu7M9ULeJCtT8QPvLMxcqPydCWHeodvrRX0iAr82mb/mJY5GiWlNGYhJRVIl6KO/5Z9XbOwZZO3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE9n+TDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEF9C4CECE;
	Fri, 22 Nov 2024 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314052;
	bh=TDoD+lOCxLL6fD8iEhwdRn95Pj9mWgTMDjgMOuci1bI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BE9n+TDB06+cbTv4npSy9jlp4wRibJIPfyJTme6OgdI69fT2wzJQoGyDbiZsE/Gf3
	 RStKNEJ8+BcJenqy9K6Im0bc2Uk5PhQdef9qb/UUK9VFFkMYJyCxnshBddkyi3VJGN
	 wd3wg4OLyu9xzqu79o6tbSxMQdWv47QDWhv42Om5tw84iiPrJ2Vd7sDQc8buds74uB
	 FoSG4xxR9Y50nMJ29kb25XayBuTK4FjTZloxXvZ2XsYFbrmcRGN1Ihg8TdSUDLkrCT
	 eDM+Z1fqVzDaHn2SKMqwaRJ773cq+NTjmK6lucdswbn9QiaacDECtccBy/xWJfESed
	 RT6K9JXbPqbCA==
Date: Fri, 22 Nov 2024 16:20:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241122222050.GA2444028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>

[+cc Rafael]

On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> PCI core allows users to configure the D3Cold state for each PCI device
> through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> to allow/disallow the PCI devices to enter D3Cold during system suspend.
>
> So make use of this flag in the NVMe driver to shutdown the NVMe device
> during system suspend if the user has allowed D3Cold for the device.
> Existing checks in the NVMe driver decide whether to shut down the device
> (based on platform/device limitations), so use this flag as the last resort
> to keep the existing behavior.
> 
> The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> D3Cold and the users can disallow it through sysfs if they want.

What problem does this solve?  I guess there must be a case where
suspend leaves NVMe in a higher power state than you want?

What does it mean that this is the "last resort to keep the existing
behavior"?  All the checks are OR'd together and none have side
effects, so the order doesn't really matter.  It changes the existing
behavior *unless* the user has explicitly cleared d3cold_allowed via
sysfs.

pdev->d3cold_allowed is set by default, so I guess this change means
that unless the user clears d3cold_allowed, we let the PCI core decide
the suspend state instead of managing it directly in nvme_suspend()?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4b9fda0b1d9a..a4d4687854bf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
>  	 */
>  	if (pm_suspend_via_firmware() || !ctrl->npss ||
>  	    !pcie_aspm_enabled(pdev) ||
> -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> +	    pdev->d3cold_allowed)
>  		return nvme_disable_prepare_reset(ndev, true);

I guess your intent is that if users prevent use of D3cold via sysfs,
we'll use the NVMe-specific power states, and otherwise, the PCI core
will decide?

I think returning 0 here means the PCI core decides what state to use
in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
could be any state from D0 to D3cold depending on platform support and
wakeup considerations (see pci_target_state()).

I'm not sure the use of pdev->d3cold_allowed here really expresses
your underlying intent.  It suggests that you're really hoping for
D3cold, but that's only a possibility if firmware supports it, and we
have no visibility into that here.

It also seems contrary to the earlier comment that suggests we prefer
host managed nvme power settings:

  * The platform does not remove power for a kernel managed suspend so
  * use host managed nvme power settings for lowest idle power if
  * possible. This should have quicker resume latency than a full device
  * shutdown.  But if the firmware is involved after the suspend or the
  * device does not support any non-default power states, shut down the
  * device fully.

Bjorn


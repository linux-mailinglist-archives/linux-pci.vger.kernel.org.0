Return-Path: <linux-pci+bounces-6461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F78AA412
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719801C21605
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97717AD66;
	Thu, 18 Apr 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqMh5SX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A462F30;
	Thu, 18 Apr 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472534; cv=none; b=I0mRYmGB0yWujApE1L5az0gTUTfIQCaGS4SYJBJFFRP4Jpr4be6IuMQwGMjI4Fupkdk5JNYgQz0rxTfGQdjDypNhgFdrU40axf1IwMurzXh943jmWlQFiQ362o8T51RBJoutK0eaRv2Q6Thxtd86MDE9EJVxr/THvbLgFmsBC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472534; c=relaxed/simple;
	bh=/k8CBxtFFxCCrPyB0ZQkRVXX+qR7tZDSRdyejPSOIGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M+ELGr6ALsN4FQ7hYJnl9iA6nX1WwR0YtBYuvsx2th6DOL/OKRy56gvVV8PABOjhsProXJD74Vcej+TfL/Z9x597G2T2/4JlvVoYaxkAmnPc/oY7pvnmxXZNmtXxQnaHWiNQmdEOUZQdNDd796p3g7YOU03mR8VD9z+7jI/IDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqMh5SX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22406C113CC;
	Thu, 18 Apr 2024 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713472533;
	bh=/k8CBxtFFxCCrPyB0ZQkRVXX+qR7tZDSRdyejPSOIGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lqMh5SX89qQB4n0qiw+izwaIkIAQ9m5dPQcveLPH9gV04HsYTxKOqyV8WjIy8YPDm
	 BjMiHFMgSW1lLjFpuhr5b/MKyBGNWBuqzUxQDvHB8FONBTMR1Mx9rd/qZtH2C/QJHh
	 T1WQQnf/Fl3i57nr5m7v09tpEhCH5clUGCA+23zY/B/8P4w5LxBpU6NQPtUA59FhB3
	 4p8O4tUN8AyPthpZOn5UtZ1MbfKcLlxLGSAnRTQ1B7E3NCabGXoeS32keleyGYfETw
	 brXTPMqtDcxieiwey+Qu8NTZlP8WR+aLwPLPYKRTrsiSdgRgDS1+v7eTDwHkRrB5/M
	 HQZsTmxFMiBgQ==
Date: Thu, 18 Apr 2024 15:35:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	kch@nvidia.com, hch@lst.de, gloriouseggroll@gmail.com,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
Message-ID: <20240418203531.GA251408@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416043225.1462548-2-kai.heng.feng@canonical.com>

On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> When the power rail gets cut off, the hardware can create some electric
> noise on the link that triggers AER. If IRQ is shared between AER with
> PME, such AER noise will cause a spurious wakeup on system suspend.
> 
> When the power rail gets back, the firmware of the device resets itself
> and can create unexpected behavior like sending PTM messages. For this
> case, the driver will always be too late to toggle off features should
> be disabled.
> 
> As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> the power will be turned off during suspend process, disable AER service
> and re-enable it during the resume process. This should not affect the
> basic functionality.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for reviving this series.  I tried follow the history about
this, but there are at least two series that were very similar and I
can't put it all together.

> ---
> v8:
>  - Add more bug reports.
> 
> v7:
>  - Wording
>  - Disable AER completely (again) if power will be turned off
> 
> v6:
> v5:
>  - Wording.
> 
> v4:
> v3:
>  - No change.
> 
> v2:
>  - Only disable AER IRQ.
>  - No more check on PME IRQ#.
>  - Use helper.
> 
>  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..bea7818c2d1b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> +		aer_disable_rootport(rpc);

Why do we check pci_ancestor_pr3_present(pdev) and
pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
to disable AER interrupts on suspend in general.  I think it will be
better if we do that consistently on all platforms, not special cases
based on details of how we suspend.

Also, why do we use aer_disable_rootport() instead of just
aer_disable_irq()?  I think it's the interrupt that causes issues on
suspend.  I see that there *were* some versions that used
aer_disable_irq(), but I can't find the reason it changed.

> +
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> +		aer_enable_rootport(rpc);
> +
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver = {
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> +	.suspend	= aer_suspend,
> +	.resume		= aer_resume,
>  	.remove		= aer_remove,
>  };
>  
> -- 
> 2.34.1
> 


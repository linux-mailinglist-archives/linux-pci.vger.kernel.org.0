Return-Path: <linux-pci+bounces-34800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7EB37530
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EE13609C0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E392D7DD0;
	Tue, 26 Aug 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maR/9c+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1562E0409;
	Tue, 26 Aug 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249554; cv=none; b=ATweAd5xj7dVmGpSXgAloS452ya1+SlduvKqK6MQEz+9zG1mxnuedApbHXaCLlMmd1ZNfhQPNiKRUfCJk9y5D61XZ6DgvwY5oYnmpGuyTIxiGae4VEqwlUeDDtrptTEKMzLrVYh0AbVBKQXK5tqGlacGpw/JMpyhNpgQKo3/lNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249554; c=relaxed/simple;
	bh=TaabfLhWhjplhJQg4SnsjHtvJlDRzRWxgWp1G4NXpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HaRn+FzhTITU+DOmlSI1BD5kwS+O1SyBspkmbDwDJjGthlDg3ujq2JZmZVru/X6f9HDw6JSW3U7oU16fsQffZCUei/gb3NiBIKPhI+FbJaYf9GljiJn0Tr74ZTAX37D80DJaowU29eNQoL5bZR12ZzDd41h9AdFTYPhHW7KbOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maR/9c+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCE2C4CEF1;
	Tue, 26 Aug 2025 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756249554;
	bh=TaabfLhWhjplhJQg4SnsjHtvJlDRzRWxgWp1G4NXpcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=maR/9c+J9qJgXLSLlhb+5MqaGpUAFmc/vgRNYIctQyxRbv8UvQaF8ewV2Q5V33FB4
	 boTGZ8SHRJgS/gKvHhr6KBo5CrEsQmQvBkVZ4Mdq8oMMImujZ3odO8bzY+XYza+Aqn
	 eEsfEUDVU21YdhMDXQUb5VAjc/j2sIgGCDSvS6VNxIFVkH7xT3cjFfiTE8B+ElQKE0
	 3xL84KQyJn2GTwFxlVxqoYld0wLIato/nIzx+iSPYxdWj6r/sTexOu8JP/ZfUHdcWx
	 Rot2jnHh2QQFBPwBzWVHV8q8Oqd36IKXxuTTjnPXoye1axVd0kXtlU97ACTl7PyFMT
	 cZDuNE61lDOUg==
Date: Tue, 26 Aug 2025 18:05:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] PCI: Replace msleep with fsleep for precise
 secondary bus reset
Message-ID: <20250826230552.GA860063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826170315.721551-3-18255117159@163.com>

On Wed, Aug 27, 2025 at 01:03:09AM +0800, Hans Zhang wrote:
> The msleep() function with small values (less than 20ms) may not sleep
> for the exact duration due to the kernel's timer wheel design. According
> to the comment in kernel/time/sleep_timeout.c:
> 
>   "The slack of timers which will end up in level 0 depends on sleep
>   duration (msecs) and HZ configuration. For example, with HZ=1000 and
>   a requested sleep of 2ms, the slack can be as high as 50% (1ms) because
>   the minimum slack is 12.5% but the actual calculation for level 0 timers
>   is slack = MSECS_PER_TICK / msecs. This means that msleep(2) can
>   actually take up to 3ms (2ms + 1ms) on a system with HZ=1000."

I thought I heard something about 20ms being the minimum actual delay
for small msleeps.  I suppose the error is larger for HZ=100 systems.

The fsleep() would turn into something between 2ms and 2.5ms, so if
we're talking about reducing 3ms to 2.5ms, I have a hard time getting
worried about that.

And we're going to wait at least 100ms before touching the device
below the bridge anyway.

> This unnecessary delay can impact system responsiveness during PCI
> operations, especially since the PCIe r7.0 specification, section
> 7.5.1.3.13, requires only a minimum Trst of 1ms. We double this to 2ms
> to ensure we meet the minimum requirement, but using msleep(2) may
> actually wait longer than needed.
> 
> Using fsleep() provides a more precise delay that matches the stated
> intent of the code. The fsleep() function uses high-resolution timers
> where available to achieve microsecond precision.
> 
> Replace msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS) with
> fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US) to ensure the actual delay is
> closer to the intended 2ms delay.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  drivers/pci/pci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c05a4c2fa643..81105dfc2f62 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4964,7 +4964,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>  
>  	/* Double this to 2ms to ensure that we meet the minimum requirement */
> -	msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
> +	fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US);
>  
>  	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4d7e9c3f3453..9d38ef26c6a9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -61,7 +61,7 @@ struct pcie_tlp_log;
>  #define PCIE_LINK_WAIT_SLEEP_MS		90
>  
>  /* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
> -#define PCI_T_RST_SEC_BUS_DELAY_MS	1
> +#define PCI_T_RST_SEC_BUS_DELAY_US	1000
>  
>  /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
>  #define PCIE_MSG_TYPE_R_RC	0
> -- 
> 2.25.1
> 


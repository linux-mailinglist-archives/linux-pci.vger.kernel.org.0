Return-Path: <linux-pci+bounces-6047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184789FD66
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CCBB2273D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1517B4F8;
	Wed, 10 Apr 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrlISI/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA73C38;
	Wed, 10 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767602; cv=none; b=KzqU9GhrvLV3kD8ebFIYNQ4+3Knn9rj/AYZ2IC7sMCj436VvSISOt4eV64Fcw22N3suX4zKSoqp6EK+kKceg115tqYJvg+T5NOKJwh2+tXcp33wt5iwtb7nrDQ39ZqQlJa2lVR06/EChGmFzfENoqrY0b8t7tATXJALMq7knai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767602; c=relaxed/simple;
	bh=qii5UQvff+KsRQSbgkC2NNYV6wkpNnpnheroe4v9t/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JqUVJTSNBfUDi7iQYK2SzUAPNriyCWeHXFr4Q9WJSqwpQEtv3fs9BYfnpIAuEBAZrDLCFD8NcrSReFf6lgTqPwMMxArIomJTyZQC6IRqgo5jZaYjFuBN243y1kXFz1AvfV4CzWb9qxzNw/n1rOdyJ8aDlP6OKGzrAz/kNIcQ8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrlISI/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60AC433C7;
	Wed, 10 Apr 2024 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767601;
	bh=qii5UQvff+KsRQSbgkC2NNYV6wkpNnpnheroe4v9t/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rrlISI/1hPx3IK1LGSir1GMuUTLKufF2CXZlbXUh8V3HTisTyPo/IdycxxKaDl5Sl
	 YNca5UxKCfT6KMSIaF389cW7WNDhKt4WD2Ebkne3OzYkvLkJUTIG9/rvoHYzGFzdd9
	 66E4j2QaPDntzVWR39GfbQSw3AEjHLhTc9ZgwcEDYzv3Bybv5gy8RpS7AxbaefoeWe
	 EYv0mkkgmKazPoD6f1tM954DWU8fGndLL/dyhlUfHu7y1ZW0UNIgX7HmziGLEeo0kL
	 cE+xC9JOoQYcwVaJC7JLE45R4W1loTLRhedDrHdpPrP6FCeRFuIcbFx9RiSRKuVpfv
	 OgS+je+X/CZrg==
Date: Wed, 10 Apr 2024 11:46:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Heintzmann <heintzmann.eric@free.fr>
Subject: Re: [PATCH] PCI: Add a quirk for preventing D3 on a bridge
Message-ID: <20240410164639.GA2145972@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307163709.323-1-mario.limonciello@amd.com>

On Thu, Mar 07, 2024 at 10:37:09AM -0600, Mario Limonciello wrote:
> Hewlett-Packard HP Pavilion 17 Notebook PC/1972 is an Intel Ivy Bridge
> system with a muxless AMD Radeon dGPU.  Attempting to use the dGPU fails
> with the following sequence:
> 
> ```
> ACPI Error: Aborting method \AMD3._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> radeon 0000:01:00.0: not ready 1023ms after resume; waiting
> radeon 0000:01:00.0: not ready 2047ms after resume; waiting
> radeon 0000:01:00.0: not ready 4095ms after resume; waiting
> radeon 0000:01:00.0: not ready 8191ms after resume; waiting
> radeon 0000:01:00.0: not ready 16383ms after resume; waiting
> radeon 0000:01:00.0: not ready 32767ms after resume; waiting
> radeon 0000:01:00.0: not ready 65535ms after resume; giving up
> radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> ```
> 
> The issue is that the root port the dGPU is connected to can't handle
> the transition from D3cold to D0 so the dGPU can't properly exit runpm.
> 
> The existing logic in pci_bridge_d3_possible() checks for systems that
> are newer than 2015 to decide that D3 is safe.  This would nominally work
> for an Ivy Bridge system (which was discontinued in 2015), but this system
> appears to have continued to receive BIOS updates until 2017 and so this
> existing logic doesn't appropriately capture it.
> 
> Add the system to bridge_d3_blacklist to prevent port pm from being used.
> 
> Reported-and-tested-by: Eric Heintzmann <heintzmann.eric@free.fr>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to pci/pm for v6.10, thanks!

> ---
>  drivers/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c3585229c12a..9d5d08a420f1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3102,6 +3102,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>  			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
>  		},
>  	},
> +	{
> +		/*
> +		 * Changing power state of root port dGPU is connected fails
> +		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> +		 */
> +		.ident = "Hewlett-Packard HP Pavilion 17 Notebook PC/1972",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_BOARD_NAME, "1972"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
> +		},
> +	},
>  #endif
>  	{ }
>  };
> -- 
> 2.34.1
> 


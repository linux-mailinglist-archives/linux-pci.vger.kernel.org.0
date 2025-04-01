Return-Path: <linux-pci+bounces-25093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB0A78253
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A40164D84
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7751DEFC6;
	Tue,  1 Apr 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAHRh+/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B651D63DD;
	Tue,  1 Apr 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532232; cv=none; b=Aai4LBEA1PpDBiTYUr3KJyBY1m/3m+LkPF692MgZIk/7yhTlaWKKJhBSzsZR/Tkbtz6s5qWSY0HZbXut3SE2QQtzW6JCHzHueD82m0jk7ga4FEzGcv4fWSkptpUoe8wmNeLvttjpvNtwQuNLM/lvi6T7dA9WjXp4LadbUDXcFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532232; c=relaxed/simple;
	bh=4os2+XbhmtioCCLMDuFXfGu111eWd2jMSbaGOz3FyPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dCABcmK5f2bgqgySRVR76T66SpRPtxYWLlVSKhCBLLy4S2UlFHvJ0G3hsVklnagrfgyWz4xFavt+sbUY3RNtXGWlkcQSr/F1p0sD1Iiu2AsCE6aNhE3LRI1PJOzKbeRjVlTG7FmuXfyjdb9RiyTkqHT2I+0pUcVWvk5lATLYP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAHRh+/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5CDC4CEE4;
	Tue,  1 Apr 2025 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743532231;
	bh=4os2+XbhmtioCCLMDuFXfGu111eWd2jMSbaGOz3FyPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DAHRh+/oTEELBMDZFuJyitH+sbvoLVMs1xVnGHazWk23/GFAxn/k8udDP/jhl34wI
	 jE3e5UIZQForRM9/zCaHFU4mHsFJ/0LZw/B2SNHn40suKvJTjxz47Gv1BrlSiZPWsl
	 XeTpOtwry9aP1jdvbMrFbaDJiPvbXgPAZ9rfbUvNWxgIE0gVYdswG2V1VWQxuWv06y
	 KPILXd4N5DS/ymQcjhXui8Lu0XQf0YWftEKl0pi4j9wh8hC4PvdCxUJJSx8fSCgNJx
	 qHGFzu/MgaH9Ymm7i9fzlot8fMKjJ5I8Cgl0Lhkby8688D7EAN6/xl4q/iTDcF+3KX
	 qjuircOLlW5kw==
Date: Tue, 1 Apr 2025 13:30:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20250401183030.GA1676293@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401153225.96379-3-anshuman.gupta@intel.com>

On Tue, Apr 01, 2025 at 09:02:15PM +0530, Anshuman Gupta wrote:
> Implement _DSM Method 11 as per PCI firmware specs
> section 4.6.11 Rev 3.3.

"PCI Firmware r3.3, sec 4.6.11" so the citation is major to minor.

"0xb" or "0Bh" to match spec usage.

> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/pci/pci-acpi.c   | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  7 ++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index ebd49e43457e..04149f037664 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1499,6 +1499,59 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
>  }
>  EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
>  
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DSM
> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us
> + *
> + * This function sends a request to the host BIOS via ACPI _DSM to grant the
> + * required PERST# delay for the specified PCI device. It evaluates the _DSM
> + * to request the PERST# delay and handles the response accordingly.
> + *
> + * Return: returns 0 on success and errno on failure.
> + */
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> +{
> +	union acpi_object in_obj = {
> +		.integer.type = ACPI_TYPE_INTEGER,
> +		.integer.value = delay_us,
> +	};
> +
> +	union acpi_object *out_obj;
> +	acpi_handle handle;
> +	int result, ret = -EINVAL;
> +
> +	if (!dev || !ACPI_HANDLE(&dev->dev))
> +		return -EINVAL;
> +
> +	handle = ACPI_HANDLE(&dev->dev);

acpi_check_dsm().

> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_PERST_ASSERTION_DELAY,
> +					  &in_obj, ACPI_TYPE_INTEGER);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +
> +	if (result == delay_us) {
> +		dev_info(&dev->dev, "PERST# Assertion Delay set to"
> +			 "%u microseconds\n", delay_us);

pci_info().

Join these into a single string, even though they won't fit in a line
without wrapping.  This is to make them easier to grep for when a user
reports seeing the message.  (Do this on the previous patch too, where
I forgot to mention it.)

> +		ret = 0;
> +	} else if (result == 0) {
> +		dev_warn(&dev->dev, "PERST# Assertion Delay request failed,"
> +			 "no previous valid request\n");
> +	} else {
> +		dev_warn(&dev->dev,
> +			 "PERST# Assertion Delay request failed"
> +			 "Previous valid delay: %u microseconds\n", result);
> +	}
> +
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);


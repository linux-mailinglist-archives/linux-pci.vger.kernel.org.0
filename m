Return-Path: <linux-pci+bounces-25095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BBA782FC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A581E7A2FE1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955520FA84;
	Tue,  1 Apr 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLJXM434"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19820E704;
	Tue,  1 Apr 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537397; cv=none; b=nW67nOiX+JuFY+NHfuZ0tPru9Kea9EGxomLar2FyKHTyDlNx4Fjz+RGQCm7WXKqRn4/da6OB4EGZmXc1xNFvhS099O6i+nb58LIK+FHGvb87GIN4O7oHS/E3hwjaLgF1t2l0aOkdazlz5BtDFrJW9xmD8TB+EVejFhOuiqSUKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537397; c=relaxed/simple;
	bh=hMcdxVjaB2WYoME8Ntk0l/AL9MofZG8qTy2kZe5dA/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CmIPzTJ1XvnaXQkDXge+E7sOUNS4Jv0nOn60M7tP/8YVWL6xWBJyKkkiFALoBZPIj5Q5jZiqbqnv+RSc/GtsS0drDEoTzLGZbLNzXHSUMRplwSOs5vYT3LdHZFhFAda4LhZclLWTFzycmcPJK3bdmdbrhI7JRBGmQ6AS2VWDAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLJXM434; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C7EC4CEE4;
	Tue,  1 Apr 2025 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743537396;
	bh=hMcdxVjaB2WYoME8Ntk0l/AL9MofZG8qTy2kZe5dA/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gLJXM434R87cWPuk0i2iI2qX1RqnALIe+oZ5MjqrQbnZGPoKy5czTu+578B3nnUVA
	 jj9W9k5rZkhEzrFBDURTgm6h99xC+/UyUjqTg5cpgLNd9UfSliuPbs3O5JoCouSD2v
	 HOAS2VGt4pkLKoJJCYQZnoR7Nau4oF52Vu9diJa1Iq8lZ6b4pfxSJJU6pTfkObwZKE
	 R2fOt6scIi4VUrA7Nsw2cW3vXgPe8+O48sVOBWJ8mimAIKOC4O/BpM6khmj3fz710w
	 7Ck9XjiXYyM1HfzFRlgzOkxqobRIRQQPQDs7O+CumPq6DrNwydXp8NsGktoXaakNbX
	 Zo7MnQDVFHg+A==
Date: Tue, 1 Apr 2025 14:56:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH 06/12] drm/xe/vrsr: Initialize VRSR feature
Message-ID: <20250401195635.GA1679245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401153225.96379-7-anshuman.gupta@intel.com>

On Tue, Apr 01, 2025 at 09:02:19PM +0530, Anshuman Gupta wrote:
> From: Badal Nilawar <badal.nilawar@intel.com>
> 
> Initialize VRSR feature by requesting Auxilary Power and PERST# assertion
> delay. Include an API to enable VRSR feature.

s/Auxilary/Auxiliary/

I would include the name of the API directly.

> +#define     PCODE_D3_VRSR_PERST_SHIFT	16

PCODE_D3_VRSR_PERST_SHIFT is not used by this series; maybe omit it?

> +#define	    POWER_D3_VRSR_PSERST_MASK	REG_GENMASK(31, 16)

s/PSERST/PERST/ (looks like a typo?)

> +static void xe_pm_vrsr_init(struct xe_device *xe)
> +{
> +	int ret;
> +
> +	/* Check if platform support d3cold vrsr */

Nicer to consistently capitalize as "VRSR" in comments, commit
logs, and messages.

Similar with "D3cold" ("D3cold" is used ~100 times in the tree,
"D3Cold" ~20, mostly in xe).

> +	if (!xe->info.has_vrsr)
> +		return;
> +
> +	if (!xe_pm_vrsr_capable(xe))
> +		return;
> +
> +	/*
> +	 * If the VRSR initialization fails, the device will proceed with the regular
> +	 * D3 Cold flow
> +	 */
> +	ret = pci_acpi_aux_power_setup(xe);
> +	if (ret) {
> +		drm_info(&xe->drm, "VRSR capable %s\n", "No");

Kinda weird to use %s when the text is a known constant.

> +		return;
> +	}
> +
> +	xe->d3cold.vrsr_capable = true;
> +	drm_info(&xe->drm, "VRSR capable %s\n", "Yes");

Same.

> +}


Return-Path: <linux-pci+bounces-5934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E7D89DA12
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F32B23C78
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0212F391;
	Tue,  9 Apr 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhYzTK0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5E12F38E;
	Tue,  9 Apr 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668964; cv=none; b=nes0E5OpN5rzS69tPuhao4s6iNe/WZLoVZgZsFBXsTcI3/Ua1n6yogTuZueA/xEp0UHlfP48HH7g9/vKwRCNRFAPY8CkVpsz4XG3WgHOXhsyVshD8PLvZ0+xiHCNJHcEbwYQP+u7rjzZKIRd9MD3FLgErYQUVHvVMSsGsTBic8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668964; c=relaxed/simple;
	bh=0ZWvbvLK1XD95XLQAIVSGXfXjBT4UbBzmYUhKoyHqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e8C8I2PY/5MtH67YDfJjlGZuaMvlkBbYOgU5wLjHQEy+7CGvBlIl+b4mu0F+FwV5wtaT2byaDjFXXgxBfHitCDykCdLeXVDnhOetwJFolnICu1jG8b6KCW+Hgi20Yj4lYnq9eB+zj9C0TYEDyLfdwXJ2RXrcz/V64YVok++cx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhYzTK0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87502C433F1;
	Tue,  9 Apr 2024 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668963;
	bh=0ZWvbvLK1XD95XLQAIVSGXfXjBT4UbBzmYUhKoyHqgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XhYzTK0UJbnxsl4W+kiyrvLUP+wHyBDYiX2fo8yLQSAL18XcE2l6PctoxiwC+nMwZ
	 mdh9WfaNufQJfmz+4r92n4nIlsH/HZfkppTxCe+7qhdhVbj3aMOWDZ50MNbkh7VAHe
	 jBUnlJDHLeIE796YBFGLiB150oKjZ/oaLG0rFUWQxkE4WXfL7Q/yibdZfY/9y6PmFT
	 +l3lBDs3x1MaVEQv+valb+7Qjtn1oBR1xDiIrTGekuthlt6tk0epN2Pz58VlIAwm1w
	 2Vp/YeOgAxCmmQdCEnM+YaNaR5R79/YBSwi2FV+hkP9yXau4wh6EAMbNcG9m8OQrO9
	 Esaon+PCQ7wqA==
Date: Tue, 9 Apr 2024 08:22:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ppwaskie@kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <20240409132241.GA2071709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407210526.8500-1-ppwaskie@kernel.org>

On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:
> From: PJ Waskiewicz <ppwaskie@kernel.org>
> 
> Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> drivers on Emerald Rapids systems.  However, on some production
> systems from some vendors, a buggy BIOS exists that improperly
> populates the ACPI => PCI mappings.

Can you be more specific about what this ACPI => PCI mapping is?
If you already know what the problem is, I'm sure this is obvious, but
otherwise it's not.

> This leads to the cxl_acpi
> driver to fail probe when it cannot find the root port's _UID, in
> order to look up the device's CXL attributes in the CEDT.
> 
> Add a bit more of a descriptive message that the lookup failure
> could be a bad BIOS, rather than just "failed."
> 
> Signed-off-by: PJ Waskiewicz <ppwaskie@kernel.org>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af5cb818f84d..56019466a09c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>  
>  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
>  	if (rc != AE_OK) {
> -		dev_err(dev, "unable to retrieve _UID\n");
> +		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
>  		return -ENOENT;
>  	}
>  
> -- 
> 2.40.1
> 


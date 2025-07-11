Return-Path: <linux-pci+bounces-31961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F7B0267F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B4A16FD26
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB41F03F3;
	Fri, 11 Jul 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkO5tjFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81D155389;
	Fri, 11 Jul 2025 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270360; cv=none; b=OIliXpQW3X6NGnKvJohViCu+Ct2FFnbgE0irpoZ2klIRpZThbm2gR7xgpcWB2mUiMXufBwpIGadfYb9f9/tqBqFY+/xWA1RqDi3b7rAQX9hg95ZLQ8cnoXhiiSFvFvpqiUuot90+TQknj/xLsPLjM6JnoOadVa0DGKjkV0e7oSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270360; c=relaxed/simple;
	bh=SVPARDXoIYbIvHPwhZO/owhQLfsvXzF2C36T9ofsUMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CxBxgpvcvVcJzeaOxbYH5VCkJpe9RwL7vJu14NuHoz3bufWwQVjmYHWw8z/B/K+ZxV4zy/K04Ln9TAIQXZ1aJFlN8twe2miaCBSpo4ZNS3hGGUVqCHWaaT6pq9gXtgNOReC3mY3No6tfdD3kQGZiRqBRTwcLq0P8B/eAXrQaSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkO5tjFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FC7C4CEED;
	Fri, 11 Jul 2025 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752270359;
	bh=SVPARDXoIYbIvHPwhZO/owhQLfsvXzF2C36T9ofsUMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kkO5tjFTvYlRwsFVXavHXqv3/cX/fbjkQ5ZD0abSuCtvKz67RF0Y6voaYSgfGqYdV
	 nzW5jMO+XCzTjdQ/E/NVK0yxirB5G0HASdC/urQwijjw9WBAV7g3rBOaDHsoxgsW+n
	 1n4ZMT5UUKGVBp0m6j5aTKF2/KN/XnEytrJZgbeAGYeAQx56xVIjkwgUeGavQLZWqf
	 mBkDLD5BRXqxSssAOP84oYzI+/USVZgGwUKvJCjtEdK12phsUnqBufQ4y7SbB+wBBC
	 ZAZ0nAwDKshYiSS//mHTSFr55FHZQ4IT7dVvkmWsmTHDLcWwq+dXPx1eSGhHee8K6E
	 eBWen7SHORZig==
Date: Fri, 11 Jul 2025 16:45:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/11] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Message-ID: <20250711214558.GA2308483@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-mhi_bw_up-v4-10-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:31PM +0530, Krishna Chaitanya Chundru wrote:
> Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
> so that other kernel drivers can use it.

Name the function explicitly in subject and commit log.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pci.c   | 12 ++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113bdfd2263d8e2f6b3ec802f56b712e..8950e88826e27accfe699e31fba8f4077c26296f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6018,6 +6018,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> +/**
> + * pci_lnkctl2_bus_speed - convert lnkctl2 speed to pci_bus_speed
> + * @speed: LNKCAP2 SLS value
> + *
> + * Return: pci_bus_speed
> + */
> +enum pci_bus_speed pci_lnkctl2_bus_speed(int speed)
> +{
> +	return pcie_link_speed[speed];
> +}
> +EXPORT_SYMBOL(pci_lnkctl2_bus_speed);

You mention both "lnkctl2" and "LNKCAP2" and I don't know whether you
mean Link Capabilities 2 or Link Control 2, and I don't know what the
bits passed in are.

I expect something like FIELD_GET(PCI_EXP_LNKCAP2_SLS, value) here
that tells us clearly where it came from, so the caller isn't
responsible for extracting it.  And it takes some kind of unsigned
value, probably a u32 if it came from Link Capabilities 2.

Bjorn


Return-Path: <linux-pci+bounces-21130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732BA2FDD9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABA83A5035
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953925A2BB;
	Mon, 10 Feb 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyRI67Ln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994F2586DC;
	Mon, 10 Feb 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228074; cv=none; b=UtH7OZYz5hZTUGToFnQgSvanad8NKM7oHyFviUZl9raMw4B3T0aZcJ7uiQ/Oa0QdDHk9IH9I+BMXgW3F11a6RavAin9siPMOMGuz8RjNUF8PzviJfA30B2n0gBY7jJh/rnuUT9yHDuAqoi8+s7XollRlzTBQwM8/Na8JcNEKhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228074; c=relaxed/simple;
	bh=Q8RgZGfu6/4fLSoxxxA7fP+5VfBEWk/q/XN4oDjBeUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pTuUAAJN7Z/Dg1baItVaDyhrETIpLNLLJrUAzw5ecZ5cEcXNT9FKmcdkowxDKWfr2AcIWCcDDEus+us72fBfzZy3ln/PxLeqI7sJXy8dLQhNNX6tLkxp/WVt21Jj93b37AkU+D634aF1stqjgUe+a92KdLjkUKg5+VmlexoItV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyRI67Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40726C4CED1;
	Mon, 10 Feb 2025 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739228073;
	bh=Q8RgZGfu6/4fLSoxxxA7fP+5VfBEWk/q/XN4oDjBeUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GyRI67Ln2Dzs/4iqHaa2+qLV2lwLd+ycNlXoprGS2D7x75zoWVqAZINFrL2cUxuLJ
	 0uMH2SEcWV1rIPBLg+6dUi/i1rPfqIbTuolR2qrxzih7nGDXXsV/1EsMwbA3wp2q3U
	 IdRIRBqzE96rklMThPyc3h73wun7BOrqcQZjPVbAJyPbrhgDL2YIunKdQ+hC9ji44c
	 QwKJMB6JuXurHcu4JeNKX1gMEIs4zMxC7EGW6vuWHkYCMRkG/7oXdxyyo5ZoxHQxpH
	 ZXylddAQVs1Z7PhAEH+xS9h+Lu82wJBw8FAj32bpNpD5yL5k7Fq4kAyeNUk5pLafQN
	 h455LvLZsRCwg==
Date: Mon, 10 Feb 2025 16:54:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 4/4] PCI: qcom: Enable ECAM feature
Message-ID: <20250210225431.GA21989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>

On Fri, Feb 07, 2025 at 04:58:59AM +0530, Krishna Chaitanya Chundru wrote:
> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> gives us the offset from which ELBI starts. so use this offset and cfg
> win to map these regions instead of doing the ioremap again.

> +	/* Set the ECAM base */
> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> +
> +	/*
> +	 * The only device on root bus is the Root Port. Any access other than that
> +	 * should not go out of the link and should return all F's. Since the iATU
> +	 * is configured for the buses which starts after root bus, block the transactions
> +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.

99% of this file fits in 80 columns.  Wrap comments to do the same.

The text doesn't quite make sense because accesses to devices on the
root bus *never* involve a link.  Only Root Ports have links and the
links all lead to buses other than the root bus.


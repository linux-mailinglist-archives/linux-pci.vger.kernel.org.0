Return-Path: <linux-pci+bounces-3837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DA85E6A4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76CCB2399C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32985923;
	Wed, 21 Feb 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAxQtPEU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21D82D97;
	Wed, 21 Feb 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541419; cv=none; b=dw1Aox30q75X91HwGKm+5vk4STv/oAW+iaSejtBphQjfC6Qc2bdZwBr+ys1bBnmGeADZo0SkTKbuntCE1w1iALD8NVoJRBTxO6flO/M/OK4XsKO+GxJ4euPK7i+Z/uLmPjjsK8JniUsSLsmUS9YLILvtDeOXXIBTxpZ6wGqGW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541419; c=relaxed/simple;
	bh=berq+dLx79W8QR0JZxbmG5z5E9hVyr2TYj6ftH2W+DU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i2xN8LqpPXCrfJ8GvRd0euugK9PlPAhTUFmpkwdoM3Fep5BPO36/zuDByFfF3P7NkvzWuaOSt+D3hq5g9PccBOdqqB62kt7TEOQoEPKPXfGNiVyzjA0jo2Oy4+KCYaWlPKx8a8LOhmMveCMMJYs4f9vFtSjL8GM0gCSNUtCMC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAxQtPEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4A9C433F1;
	Wed, 21 Feb 2024 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541418;
	bh=berq+dLx79W8QR0JZxbmG5z5E9hVyr2TYj6ftH2W+DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kAxQtPEUYCxY9bKxoBer0CmYny/X0JyU63M+Zl/i/VzgkRePbL+RgKth1AS9f84aJ
	 pipANzIjhKdTzS7DuhOhXkPkSD1YzBrGIemEDirSKyujLbCuin7x1iPed2ztjiZTWa
	 JI7kRYnpbDTzV6EcGMrHY90bQVK49to7toCJ8LwEHG+RKisqOzK4VVyTukMxcs7w8V
	 k4rUkFsTBKcM9LW6Z2t4h/YyQTVwNvTSFBNDN9hQe4WvmguAgsUV6FUbJdjqnqpS+Y
	 xMYCW7OQMmNIkzxu56Iu6qvGRr60fbvqSGuTpAX2zMjhfgfy0DYN0deFfYqeUuuYIP
	 nY/uFVgop4ysQ==
Date: Wed, 21 Feb 2024 12:50:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: root <root@hu-msarkar-hyd.qualcomm.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, quic_nitegupt@quicinc.com,
	quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Message-ID: <20240221185017.GA1536431@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>

On Wed, Feb 21, 2024 at 07:34:04PM +0530, root wrote:
> From: Nitesh Gupta <nitegupt@quicinc.com>
> 
> Synopsys Controllers provide capabilities to detect various controller

"Synopsys controllers"?  "Synopsys" refers to the DesignWare core, but
most of this code is in the qcom driver.  If it's qcom-specific, this
should say "Qualcomm controllers".

> level errors. These can range from controller interface error to random
> PCIe configuration errors. This patch intends to add support to detect
> these errors and report it to userspace entity via sysfs, which can take
> appropriate actions to mitigate the errors.

s/This patch intends to add/Add/, so the commit log says what the
patch *does*, not "what it intends to do".

> +
> +/*
> + * Error Reporting DBI register
> + */

Typical style in this file (granted, it's not 100% consistent) is to
make these single-line comments, i.e.,

  /* Error Reporting DBI register */

> +#define DBI_DEVICE_CONTROL_DEVICE_STATUS	0x78
> +#define DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG	0x8c

Most other #defines in this file use upper-case hex.

> +#define PCIE_AER_EXT_CAP_ID			0x01

Why not the existing PCI_EXT_CAP_ID_ERR?  If this is the standard PCIe
AER stuff, we shouldn't make it needlessly device-specific.

> +#define PCI_EXT_CAP_RASDP_ID			0x0b

Looks like possibly PCI_EXT_CAP_ID_VNDR?  Capability IDs are
definitely not device-specific.  The fact that a PCI_EXT_CAP_ID_VNDR
capability in a device with Vendor ID PCI_VENDOR_ID_QCOM has a
qcom-specific meaning is obviously specific to qcom, but the
Capability ID itself is not.

> +/* DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG register fields */
> +#define PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN		BIT(0)
> +#define PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN	BIT(1)
> +#define PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN	BIT(2)
> +
> +/* DBI_DEVICE_CONTROL_DEVICE_STATUS register fields */
> +#define PCIE_CAP_UNSUPPORT_REQ_REP_EN		BIT(3)
> +#define PCIE_CAP_FATAL_ERR_REPORT_EN		BIT(2)
> +#define PCIE_CAP_NON_FATAL_ERR_REPORT_EN	BIT(1)
> +#define PCIE_CAP_CORR_ERR_REPORT_EN		BIT(0)

These look like alternate ways to access the generic PCIe Capability.
If that's the case, either use the existing PCI_EXP_RTCTL_SECEE,
PCI_EXP_DEVCTL_CERE, etc., or at least match the "RTCTL_SECEE" parts
of the names so we can see the connection.

> +/* DBI_ADV_ERR_CAP_CTRL_OFF register fields */
> +#define ECRC_GEN_EN				BIT(6)
> +#define ECRC_CHECK_EN				BIT(8)

Do these correspond to PCI_ERR_CAP_ECRC_GENE, PCI_ERR_CAP_ECRC_CHKE?

> +/* DBI_ROOT_ERR_CMD_OFF register fields */
> +#define CORR_ERR_REPORTING_EN			BIT(0)
> +#define NON_FATAL_ERR_REPORTING_EN		BIT(1)
> +#define FATAL_ERR_REPORTING_EN			BIT(2)

PCI_ERR_ROOT_CMD_COR_EN, etc?

> +static void qcom_pcie_enable_error_reporting_2_7_0(struct qcom_pcie *pcie)
> +{
> + ...

> +	val = readl(pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
> +	val |= (PCIE_CAP_CORR_ERR_REPORT_EN | PCIE_CAP_NON_FATAL_ERR_REPORT_EN |
> +			PCIE_CAP_FATAL_ERR_REPORT_EN | PCIE_CAP_UNSUPPORT_REQ_REP_EN);
> +	writel(val, pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);

Is there any way to split the AER part (specified by the PCIe spec)
from the qcom-specific (or dwc-specific) part?  This looks an awful
lot like pci_enable_pcie_error_reporting(), and we should do this in
the PCI core in a generic way if possible.

> +	val = readl(pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
> +	val |= (PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN | PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN |
> +			PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN);
> +	writel(val, pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);

Bjorn


Return-Path: <linux-pci+bounces-29985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E3ADDF70
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 01:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A13A4846
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E81898E8;
	Tue, 17 Jun 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYrh+TJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6B2F5313;
	Tue, 17 Jun 2025 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201932; cv=none; b=KoGYIfSo5EdUmGDN0vPO1XJYq46G/+qrV5Ux0YAm1GouH+B9Z9rZBkyLwel/r8tr8zMsgHfxPVoHcVQWxsupH13ZEMPHSSi2NGDK3eL4uU3Rd5LG08PxDQOl7UzDPA14KSVA/xesW2iaez1XGOFppRj1LergJXXZn/CJTFZ7gTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201932; c=relaxed/simple;
	bh=/B1RkUot2UjJrd5z+c7h5VWR07uAJ8Xr0Hm1ihBcNb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uZRGKFSJ6k0ltj3jqKvKCe84VAqpQW3kF3y56c1X65bOFx7MBuNZYpqYhU9C0k41cP++TOSn27OCzIsMAj876P+eX4U/lxbsnwglo5mrXDX1rgkoEQ9mGhpZie7/OPwXW/0B7MgCqRfzKuShIr44VZTl0uSvXnQQCWMMwwEbYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYrh+TJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC8C4CEED;
	Tue, 17 Jun 2025 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201931;
	bh=/B1RkUot2UjJrd5z+c7h5VWR07uAJ8Xr0Hm1ihBcNb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PYrh+TJ9VcezAZi26nVUY8qNHMh5CSlvYt8Nejewaf3xULQKxhUCkwXVxILgd7qky
	 +o34pizCXa6IA3jnQTfGXg2SEPrw5RfRe3a71n3mQucuM42YjHwvlumV8iMnGujXXl
	 q7LOM+te5jKLDbmgSg+9EPwDvDb/xITkWthUbAdGlcD8en8CtFA1RPGgdtGBqNRUqu
	 rGvQaThNfpbcq/8qMUCaT729RWEEk0n682deNI6BR7OrQ1xLF7j75KYfgzncyDfmLU
	 9xyJbHtTtA72gZwX6q++JHOGhw/CnCOxVy3t5XgAAOd1yvGM7noZz4Y1qZ5odiHwrt
	 XU+nJAPxQk+pw==
Date: Tue, 17 Jun 2025 18:12:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] PCI: dwc: Add debugfs support for PTM context
Message-ID: <20250617231210.GA1172093@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pcie-ptm-v4-3-02d26d51400b@linaro.org>

On Mon, May 05, 2025 at 07:54:41PM +0530, Manivannan Sadhasivam wrote:
> Synopsys Designware PCIe IPs support PTM capability as defined in the PCIe
> spec r6.0, sec 6.21. The PTM context information is exposed through Vendor
> Specific Extended Capability (VSEC) registers on supported controller
> implementation.

> +const struct pcie_ptm_ops dw_pcie_ptm_ops = {

Sparse complains:

  CHECK   drivers/pci/controller/dwc/pcie-designware-debugfs.c
drivers/pci/controller/dwc/pcie-designware-debugfs.c:868:27: warning: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?

I should have noticed this earlier, sorry.  As of v6.16-rc1, this is
now 852a1fdd34a8 ("PCI: dwc: Add debugfs support for PTM context")
upstream.

Bjorn


Return-Path: <linux-pci+bounces-22900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527DA4ED48
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9013A3AFB09
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FC24EA9B;
	Tue,  4 Mar 2025 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQuMUOIQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC831D7995;
	Tue,  4 Mar 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115300; cv=none; b=cqRn6HRp5jD4/MO90EXAyuXixRl2sCmu/WH/HlgKnMtsTpEMbJs3Fg9Km8hwFEB7fRRiNHxkZvAGb87/N/6frV3Pp4AVJHAofqn9fYknNL+9Z8G0Fa/ldZYqnn9+ArIzf7NHRZiFrDsruw+JWgL/OG7ogH3b1h3bsB7huN6/kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115300; c=relaxed/simple;
	bh=g2ihsxLxAkJEVcm9wKXS60iX5wYnYkx5vGLDQ45KKSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tg09fCxeugCrrW/b5YgXuf2stzWRj3MnHQBot00dD5bp6SecnBLClcUfmSU8sdYvrSt3IhG9NkCK/z6/HViCetdtfErzclY76l2v6byO/vZkhB/lJOeriHlcTlN1ZL4ztB/I58TeS2c+aAU5Xj8RczJv+fBq/iqXyzOfVF2udB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQuMUOIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B07C4CEE5;
	Tue,  4 Mar 2025 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115299;
	bh=g2ihsxLxAkJEVcm9wKXS60iX5wYnYkx5vGLDQ45KKSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KQuMUOIQDuJY1Z+DBI+r7oMOZa4+TNIQ0kCXWEpcLph/kilyCGrfVL7KVTMiIHW/O
	 sBOigS+Dv/FjJEkIYJMAYbFEyWqDfLeQ/H/jnqggrTI11Wf+5AvG8vFSJts7oUKKHL
	 +o8Y8zURkoCaQUnbwVqrmOz6CYoSQXdPM7VC8IpkCbmu57vT/VtpTXz2dsU9+O6//s
	 mfVwocIj60zwAzBIKzo88qZqH1nAlV6SgdtJzNlARdXVNfv4qyUSmn7hzp/uonkIoK
	 o2NsTwjGu+V9v4i8r7H/JRUGLzA1BIpPW8+Cya2g6dcaCBYcCL59+c0egfvZNP7kbp
	 8vf8vyxOuVRtg==
Date: Tue, 4 Mar 2025 13:08:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 2/2] PCI: artpec6: Use
 use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
Message-ID: <20250304190816.GA253203@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-axis-v1-2-ed475ab3a3ed@nxp.com>

On Tue, Mar 04, 2025 at 12:49:36PM -0500, Frank Li wrote:
> Remove artpec6_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> fetch address translation from the device tree.

Shouldn't we be able to detect platforms where DT doesn't describe the
translation correctly?  E.g., by running .cpu_addr_fixup() on a
res.start value and comparing the result to the parent_bus_addr()?
Then we could complain about it if they don't match.

Bjorn


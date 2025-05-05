Return-Path: <linux-pci+bounces-27192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D379AA9BA0
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148AD189DEB7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D61D54EE;
	Mon,  5 May 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oteTA5T4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C94BA49;
	Mon,  5 May 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470236; cv=none; b=fFdIW8FIlQ8hwH47zadYyDOD+HLXJCQo3q6BG6bS7Hi8hxv5+dHRFp1Et/rZRR43sYQ9qSJek/h21k8ETBArlxily4g9J2IxTU0ssKiO+NsxlNSDNaCN3lCPCpxo5pm3oQCv/fHVMXPpt0DwmNZ5mscBPe7DbcZ3geo9phFz1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470236; c=relaxed/simple;
	bh=uY9U9yOmUL1HEVZham59KUg3v/H3UvAiLXotlR3xw/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SW/gs0LezZGrOyvprUsmgS3454QuT02QGB63rS9xYCvxE9wwbuaTgI/bJxNmXnLL/hwoJOIUkrmkPujLguieuO0qI+s94yAH/dK5/AWDRM12yzNDgkha8B1Sd5i5cjpzZQMOoBIKBzKxX7BHjAsY5NVwOGCBuAl3HBQ1JiYuIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oteTA5T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE68C4CEE4;
	Mon,  5 May 2025 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746470235;
	bh=uY9U9yOmUL1HEVZham59KUg3v/H3UvAiLXotlR3xw/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oteTA5T4GoCGN5Y8OQRyLswify4lv+548Iu0zTHa4ZbPAzuYHa1jlsOcTgJoCJGly
	 3DEgqO7LX4s9BUbFF5Pwm1sLYJiKUA5YbPn5bJNIvbyE4ibfC+XvNpmDFl0YV0yCJX
	 /wK5mZ0ueuPoGweeAmnmr8AjlARBQVjWBtGpikGVMYDmvowWPkhWsoykYr6ViziCp0
	 MYSuhvjeIq/ELlIu2nF82629/34x3vJcEpGqarcPdPoZVb/sedZZc/LlU3yKI2JzeT
	 +o91SRVHh7rlB8kazowbeQiK/U3BDBriBcjIF9Wh/S/sj93vmS/8S4RJA2D8d4n5bt
	 O+qvHXF9T8qTQ==
Date: Mon, 5 May 2025 13:37:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: Add debugfs support for exposing PTM context
Message-ID: <20250505183714.GA990024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pcie-ptm-v4-1-02d26d51400b@linaro.org>

On Mon, May 05, 2025 at 07:54:39PM +0530, Manivannan Sadhasivam wrote:
> Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
> sec 6.21 allows precise coordination of timing information across multiple
> components in a PCIe hierarchy with independent local time clocks.
> 
> PCI core already supports enabling PTM in the root port and endpoint
> devices through PTM Extended Capability registers. But the PTM context
> supported by the PTM capable components such as Root Complex (RC) and
> Endpoint (EP) controllers were not exposed as of now.

IIUC, the PCIe spec defines the PTM link protocol in terms of these
timestamps, but it does not provide any visibility of them to
software, so any visibility is device-specific.  I think it's worth
mentioning something to this effect.

Bjorn


Return-Path: <linux-pci+bounces-30976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1EAEC1DF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3F2564DEA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0525F784;
	Fri, 27 Jun 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL6lFfm1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625D25D20D;
	Fri, 27 Jun 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059270; cv=none; b=a+678sGhnTEWb5VuKqb+wT8yCkmNZr8Z3cKCGpG+tWpicEsgoFUJ7n4tRByoupQ60d/kmbCpwyGN3B2VMIQFoN5D43x0ysezkIzz98orSRS3+u11IOWDv5DvmXba+BJXQBqHtf8SoubSSL0BYZmq+B+FxtwMMm0r9HK97KF0z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059270; c=relaxed/simple;
	bh=87jq3UNGAunmwZrI/3JQ5eBj1P2HSlHE9VvJ80kDosk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsZBrXMkXOoY6FIKNOYo0dr0ZD7eVpszgBJGvkzoz2BFswQ1pfd+cemba+jhxWVgq7ztS9tG88qsxhwTPYoMlkfpWHecvmWFEfJvSZJOSLHaR8y4Qj2qmIIrLDE9eJ003bNqeecm+v3PxDa2W+U8OuAyuwcBANd/XyGaAcBc52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL6lFfm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1440C4CEE3;
	Fri, 27 Jun 2025 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751059270;
	bh=87jq3UNGAunmwZrI/3JQ5eBj1P2HSlHE9VvJ80kDosk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rL6lFfm1SPJz6Th3DuiDCMbVnrrFB7flRlGxAX0TRgjgxfwgUS6k5hNyysk2AKHlX
	 tfqEr4sMsAaIqrkO8YEKjGRf2EF42aH5TPQ8dskVYXaDtZ6pNTUycKpxdpDWqr4qYO
	 +1juy6Wdi0olfb4YGwByC0d538lig2Kih5iLGtTQI5+gAGNvGmCxVpVIqXkCpouL5n
	 eHrt+Jr5TXrJ4QAeO0HO29AJW76dj0MwqSL6IyS1S6RD/ihsoHgm22vtBMV4xVLq3D
	 VDJl6EtCZrp0kq50XDbq/sLcQbr3i3t60WVWfgQvwd069dqekHEZkYIjxUJ+LB0tEq
	 Y/DEML/Or1SsQ==
Date: Fri, 27 Jun 2025 16:21:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: mani@kernel.org, thippeswamy.havalige@amd.com,
	bharat.kumar.gogada@amd.com, bhelgaas@google.com,
	lpieralisi@kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	cassel@kernel.org, krzk+dt@kernel.org, kw@linux.com,
	conor+dt@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add example usage of
 reset-gpios for PCIe RP PERST#
Message-ID: <175105926858.163560.8044521916399216806.robh@kernel.org>
References: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
 <20250626054906.3277029-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626054906.3277029-2-sai.krishna.musham@amd.com>


On Thu, 26 Jun 2025 11:19:05 +0530, Sai Krishna Musham wrote:
> Update the device tree binding example to include usage of the
> `reset-gpios` property in PCIe Root Port (RP) bridge node for PERST#
> signal handling.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v4:
> - Remove reset-gpios define as it is already part of pci-bus-common.yaml.
> 
> Changes in v3:
> - Move reset-gpios to PCI bridge node.
> 
> Changes in v2:
> - Update commit message
> 
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



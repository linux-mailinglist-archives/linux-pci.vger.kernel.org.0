Return-Path: <linux-pci+bounces-22445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A583A46304
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF4189852C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A422236E3;
	Wed, 26 Feb 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ2sDdhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2552236E1
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580562; cv=none; b=KXl04GHR4z7bgTMqwkqMI+L5ZLlogCs/68XfTE/Zc+yrax9xofVmqJCzWVE3D74yLc1OEBzMqDjgJ+QrfKDhiLhCl4KhbVs5e6orxgChlB9PqDXnk++Y/JlgJbpzjpmM+hHMQAZilbO4cOEsTQMaAgIc4y4lPXDRuX6JmIUoFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580562; c=relaxed/simple;
	bh=2bva1f7+8lpiCrhm+J0/jpfTEwllW/VpN5p2DryGFmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIsdHEpD3HkadrBWTjTiDzbQS2TXH17zyOGho7wfigiOVKvCqPR7ZqmDvS9MOPe35zAwovCqq1TYkkNxEt6yLDSAQSLkgPpitKvmU8MMJZmLNFOjp0m8ZWB8WB3AzHfu3z+wBLk6q1oF0AjSIw3607GF3Gc2yLoK+EAY/f4zqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ2sDdhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C548CC4CED6;
	Wed, 26 Feb 2025 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740580562;
	bh=2bva1f7+8lpiCrhm+J0/jpfTEwllW/VpN5p2DryGFmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQ2sDdhdnh+bF6bLw6WA7eAv1nc3MtW4zjVGhOrnpd82rxycnn+OkPCREShAvvcUu
	 O9LucBetIE2AweVFXtnaykeu1ihzZTExiTIcMlvH/CJOIiRCBlmubhtBE13JSLChtM
	 YGQhiTsWfRT8vzCKmhOSxCMMOLlfNr0LnL0wUx156VysPHJnpGhcLC92JZO5+SVT12
	 NXMkfs09L17y1V/b+0bXBlSZprvr9FM4kRul8cFYQuD7FSn47Bfx1X0UyToGTC2Mxn
	 MTOjBz1M/aGCA+QfzCr9Clc5XkP5QzSkzxH7OhCmYn3/+lJhoRvLohWbBxHXJzSaI1
	 v2Dgmw34JyPLA==
Date: Wed, 26 Feb 2025 23:36:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Add rockchip to the RAS DES allowed vendor list
Message-ID: <20250226143600.GA3546651@rocinante>
References: <20250225145657.944925-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225145657.944925-2-cassel@kernel.org>

Hello,

> Add PCI_VENDOR_ID_ROCKCHIP to the list of RAS DES vendor specific ids.
> 
> Tested using the RAS DES DWC debugfs changes that was merged recently.
> 
> drivers/perf/dwc_pcie_pmu.c driver has not been tested, but considering
> RAS DES works in DWC debugfs, I see no reason why RAS DES shouldn't work
> in drivers/perf/dwc_pcie_pmu.c.

Applied to controller/dwc, thank you!

	Krzysztof


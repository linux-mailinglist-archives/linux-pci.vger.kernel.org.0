Return-Path: <linux-pci+bounces-34560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B4B31A55
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5B8B01BCE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40142FB994;
	Fri, 22 Aug 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6LgpEbr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F926D4CE;
	Fri, 22 Aug 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870709; cv=none; b=JWNSeI4xxq5pFr5iLBzzmT/eiHYGgLT7Np8qPAP8y4oyWhvckHX2y0sPlRIZbJSkTpUub5Hj22H8m1Z5oFREzdzUWLO1Yi44mR8uLrPC0z8YpT08yXbGzasMjO/v11YStGX/ptz3u8R6Dyg/5LEbDdDqQD0Y83aj/eEGyM9MLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870709; c=relaxed/simple;
	bh=u4cJcrWBm/AohmL9zsuFNBF60GgIH4GVMvh5WRskHBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYGh54GRXPZV8ezfNe4wO140Ln1TpLSoWivfLQEcasG8z2wALpKnCJIDrk/Sxh+S7X7TZRowFSlMN1USs6ofo1uXsjiuUBVEtHQ8QNbpn3Kwo6ZzN6iy89uZZwqGzD9gfG3nlnqWOCspixRwOXsaSdwTPcWlE4L/vHUvYOh4aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6LgpEbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B439AC113CF;
	Fri, 22 Aug 2025 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755870709;
	bh=u4cJcrWBm/AohmL9zsuFNBF60GgIH4GVMvh5WRskHBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6LgpEbr4Znux3+7h+UpNqvKiXHbtxgQbwrBay3MnQOtb3KraX5b2VzlAgjxK9kZV
	 eSK3eYuyaOD2ongX1Vx37o0q7dv+Pxsa34YJXL/NQ/yyUs7s23ty55E68tbCCmLooF
	 FhZU+bluw06r8HfWFpIHDYfz7qNibvmwXFjnftan6ytB2n5X05V5keGWhqLQm/jLYK
	 DwQYRCwpAHYsUHy3S278WxBWXT7AbUKjHtYtpID8inPz7Ymagl6iH2UhJl2aCIh8s/
	 GsM2+SbZF+MXj4QqQMHDf3f+M+n1Z3pwSQwE02wGa30rAylMWT01F4w7wxR33OnwB1
	 G4b1cJ/vaLsmg==
Date: Fri, 22 Aug 2025 08:51:47 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device
 node
Message-ID: <20250822135147.GA3480664-robh@kernel.org>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>

On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wrote:
> Bus:Device:Function (BDF) numbers are used to uniquely identify a
> device/function on a PCI bus. Hence, add an API to get the BDF from the
> devicetree node of a device.

For FDT, the bus should always be 0. It doesn't make sense for FDT. The 
bus number in DT reflects how firmware configured the PCI buses, but 
there's no firmware configuration of PCI for FDT.


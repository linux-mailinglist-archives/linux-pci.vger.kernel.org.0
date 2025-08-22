Return-Path: <linux-pci+bounces-34567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06494B31C32
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF864586A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D530AAAF;
	Fri, 22 Aug 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOFxFx+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D23054F0;
	Fri, 22 Aug 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872876; cv=none; b=l3AZqr09pG7U6FBMk1Twdt/8tIm3IheV7BSVsq9DvcIbTErryuWslkyIU0mPZFryHE8ENKA0DZFA9wzurTO+i459+r9fJCgGJDG/6Y//xNhjThrTNkjdBR2WfUqKhRCrhPEXjlAxB3YNLDkz5rLRBG4Hc/73piWpCpAG3PYAkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872876; c=relaxed/simple;
	bh=irk5yZ+gV1gl0gGAvBwOOJ8uWctLDlLbZ+2m5RgI+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D30EcqENqbUXbbroBCwUF33ETJ5YNA8XUSO5hJblv/qCNLKq/ZlKyBi8z9cbBrOa7SS/7Jk4QXvQ2TZXlMbDJoLiqhtA51a2Y8dlNUZtZgOIpaCfaMhEoOf7VrajdT6koy5hftt56uBsimHo7AGGGmiKE9XxEYbHn8e458qTphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOFxFx+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06EDC113D0;
	Fri, 22 Aug 2025 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872876;
	bh=irk5yZ+gV1gl0gGAvBwOOJ8uWctLDlLbZ+2m5RgI+CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOFxFx+z6AHFNDnYjlj4uDUZVzNvpKzmRYbH8U9WeJYP/Nt6LS9xT4v2cqHWB9FQr
	 28OzgQndB9SvEeE6BDakhVsfOebO6662OesQsdRQiRnlDrLshYSI3v5xhVcsqssXa5
	 CcKx3ipUE1ffUrPxPXEOpsWbT5a+yBLaVcnq0u7xPGGxyxVgulrCbCxiaWEwTOzXJJ
	 hG6vv8dCruR6z4zyqxEjZj5TyEGLacAIjkw4Gj8BM474HS+GZwrrbKwMAQp62yrYx7
	 eQh4qxpZgMu3EnvwMbIjg7DMPRVcPfbB/xhpAtnSqZnM1k6CcMqRGq8aszaGhJtCdj
	 zswqaDnXbaNXQ==
Date: Fri, 22 Aug 2025 19:57:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device
 node
Message-ID: <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
 <20250822135147.GA3480664-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822135147.GA3480664-robh@kernel.org>

On Fri, Aug 22, 2025 at 08:51:47AM GMT, Rob Herring wrote:
> On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wrote:
> > Bus:Device:Function (BDF) numbers are used to uniquely identify a
> > device/function on a PCI bus. Hence, add an API to get the BDF from the
> > devicetree node of a device.
> 
> For FDT, the bus should always be 0. It doesn't make sense for FDT. The 
> bus number in DT reflects how firmware configured the PCI buses, but 
> there's no firmware configuration of PCI for FDT.

This API is targeted for DT platforms only, where it is used to uniquely
identify a devfn. What should I do to make it DT specific and not FDT?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


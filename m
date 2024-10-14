Return-Path: <linux-pci+bounces-14496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FC99D58B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FD1B22117
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C251BB6BB;
	Mon, 14 Oct 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2E6H3cY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830729A0;
	Mon, 14 Oct 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926603; cv=none; b=AVAHpDXJtduYNvHXjO5z6egHd36j4OeHpM0GX4xFggitK+jJK1mg7YP6cKBGn+a7hFKF4ESmO+aZgdfRWV3i8JxjbasLrM/2QU9WlsDAmOv+pJjVITefSoGNo1csjPmVRFHhVMbZV2vpse2TAblbOFNnisH6Nfn2Z2p3fYL8qkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926603; c=relaxed/simple;
	bh=SI7AsSe5EjBrTHMwIiv10P9QrYwlGqfoReRwluA1G4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pqi5XmFf5xBzHVrnpNkb6AWCO+VsvGGllxwVk3B/0yNh4FJbbwMLNrWXXFCON3TWctx+7QIWexfzAeOTJRXlQKA28xNFsLCYXJvRyuh9v+Blh19hYrJMeLYaYXfvJgqYXUQ+2xfUGH2ym0r8P54aY67fAQHNJEVyvaxr5y8xqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2E6H3cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4860C4CEC3;
	Mon, 14 Oct 2024 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926603;
	bh=SI7AsSe5EjBrTHMwIiv10P9QrYwlGqfoReRwluA1G4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y2E6H3cYJsIx+yEmeRElE0ViXkvJ4X5g84DZMUtlc/x9EBpsN169ybbng9FB1/7dt
	 QsDDo0EB1SMx/AZfDCGxU4F3YRQs0nKmL/MMl4+k+yQCyUqegzTzfTYZw6XHjkkywn
	 GeY19ipxz5CSKNWqIuClcpiTalCoBV8/XBqZgaeNLryW9p1QTiQk5kclQsCOHuSElH
	 rBhX4YkPi0zsOxl1idkKSxcNDS4RplnPsxJfw0utDmrOeUDPemTRjldSgGgIQhuzZ3
	 eDjnpN94ho7PalYeYKXjkcOaZOdAdgB5uqrW+BXx++L0WnvBhIbgFk3HzPCH/9j4N7
	 lA18HPj7bTwbw==
Date: Mon, 14 Oct 2024 12:23:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: kevin.xie@starfivetech.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241014172321.GA612738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014162607.1247611-1-quic_mrana@quicinc.com>

On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> bridge device. To enable runtime PM of PCIe host bridge device (child
> device), it is must to enable parent device's runtime PM to avoid seeing
> the below warning from PM core:
> 
> pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> with active children
> 
> Fix this issue by enabling starfive pcie controller device's runtime PM
> before calling pci_host_probe() in plda_pcie_host_init().
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I want this in the same series as Krishna's patch to turn on runtime
PM of host bridges.  That's how I know they need to be applied in
order.  If they're not in the same series, they're likely to be
applied out of order.


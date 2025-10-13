Return-Path: <linux-pci+bounces-37987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA98BD65A2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 992CE345227
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941F2ECD11;
	Mon, 13 Oct 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIJFx1Tr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B22EAB66;
	Mon, 13 Oct 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390883; cv=none; b=s7aswWgERGLVbVpPAzHwDX7cpLHI9KJxMZ+gPwVHeBXRIiYHCIeq4nNErRin5cLldkXw17ez/rnU8RKyUguigRb+N8l+fTIvXEzeCsdPzLqkdNjBDjiNRHUpT7V37kauqGWsejBB4MRBZXHx8kgKlcBkxGV9xL8dYJ8LL+xVsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390883; c=relaxed/simple;
	bh=/vCGp4dN24zHOrwDoNn2Y3f2GKlV2uG2TwuEjOBom6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=du4jdTVDpL7jccWAyYL2cIUO1duf6sDyHhgAkix62jwj6nD1kN9v13DT+ACQ0wb+xv0Spca8jJ+XlN5QS+D2Jgogs8FJzgz23WbGqq0AnPkainUchWh0+jixF5T/BLDpc8zMXu2Lgy3A26MQ6FAuvGVog9n49ubiulCTkPZS5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIJFx1Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E310C4CEE7;
	Mon, 13 Oct 2025 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760390882;
	bh=/vCGp4dN24zHOrwDoNn2Y3f2GKlV2uG2TwuEjOBom6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZIJFx1Tri7fL9usBTJ8do1OAIl55dlPPxgGzv8879OtuSZXEQocmMJuhBTt9ZnmJZ
	 7rr/Osh9CVL5KjyPVXe30y6i8jHTMrOZzM/6dicRhIGgNCo6fucDxBBo4A7WA3ize6
	 KszucXDO3LlfB8d1tgRwVI/S/YkQ2nbOaD0FlrvHBk/sq9P7rv4UbAgrXVfB34G2vm
	 OnHj3EaySJoEa2UEd6xvQk5WH8lRK/a2n3r1CBwvYomRmoqEzvgo598OEDlDfXs0EU
	 3So5a6C258p/jGkNHSJ+oct9LfP6UAAVuhCt+7ayu4rwvYXh7e72AEbvrAjeX/Yj4A
	 J8+UxKF35KepA==
Date: Mon, 13 Oct 2025 16:28:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: bhelgaas@google.com, rishna.chundru@oss.qualcomm.com, mani@kernel.org,
	helgaas@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>, regressions@lists.linux.dev
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
Message-ID: <20251013212801.GA865570@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net>

[+cc FU740 driver folks, Conor, regressions]

On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
> The SiFive FU740 PCI driver fails on the HiFive Unmatched board with Linux
> 6.18-rc1. The error message is:
> 
> [    3.166624] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
> ranges:
> [    3.166706] fu740-pcie e00000000.pcie:       IO
> 0x0060080000..0x006008ffff -> 0x0060080000
> [    3.166767] fu740-pcie e00000000.pcie:      MEM
> 0x0060090000..0x007fffffff -> 0x0060090000
> [    3.166805] fu740-pcie e00000000.pcie:      MEM
> 0x2000000000..0x3fffffffff -> 0x2000000000
> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
> 0xdf0000000-0xdffffffff] for [bus 00-ff]
> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
> [    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU in ECAM
> mode
> [    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
> failed with error -22
> 
> The normal message (on Linux 6.17.2) is:
> 
> [    3.381487] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
> ranges:
> [    3.381584] fu740-pcie e00000000.pcie:       IO
> 0x0060080000..0x006008ffff -> 0x0060080000
> [    3.381682] fu740-pcie e00000000.pcie:      MEM
> 0x0060090000..0x007fffffff -> 0x0060090000
> [    3.381724] fu740-pcie e00000000.pcie:      MEM
> 0x2000000000..0x3fffffffff -> 0x2000000000
> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align
> 4K, limit 4096G
> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> [    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00
> 
> Reverting the following commits solves the issue.
> 
> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM mechanism by
> enabling iATU 'CFG Shift Feature'
> 
> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the DWC ECAM
> enablement
> 
> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the driver for
> enabling ECAM mechanism using iATU 'CFG Shift Feature'

As Conor pointed out, we can't fix a code regression with a DT change.

#regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")


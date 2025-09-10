Return-Path: <linux-pci+bounces-35814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B9B5197A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61553188C1B0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAD32A3D7;
	Wed, 10 Sep 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZTfNxdG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36D31DDA4;
	Wed, 10 Sep 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514896; cv=none; b=GrAdUOgjBZuOmCWmcdduhSBRMBeRUQve65743Wiq0IZVT5/3QWf/N6lv4gXS/C5Kbiltqu5qTIq7qSC7EtEGR3iMCRNF/hhoOZ6ITTu2lMIipVcwjV4J+1PCI/H5WR9y5h3k/YRN0813bbNgkG8qEVj2jBn8XUJU2X6PBO8LKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514896; c=relaxed/simple;
	bh=xjYSrTXZn2L7+z07HiLOzSt4wzGMOD/saMQb5WcdX3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f2AKdo+/0Vz+c0pDwWrNX+0oiqA/QtRpi9ZEBYlh5xXvg0WVTWjtRbo+/cVewSy12eA+M8JVuHIFHQ2JAJFBslcWwFbmPkreiFgHslNaXicCFnIrLf5CZEN1jSt1nBTR6x1rZuecgxHk1fASAY+Dldxcj1ezAUNkU0gIBGoPL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZTfNxdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC15C4CEEB;
	Wed, 10 Sep 2025 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757514895;
	bh=xjYSrTXZn2L7+z07HiLOzSt4wzGMOD/saMQb5WcdX3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mZTfNxdGDMJd16WavKni+yoqXTP+Gqz+lZsuuz8ArGJqWcu6LJwJRCqTuoIUbslaE
	 JnpLpbgvTq1pjFCqt0go3f9iie1Zra0iWRO/JZ7oPMJWklYQvadpBCMljKdoIPsF5c
	 j4s0+KMvmJlXyTpdssMKAkAr3mMGnu4RTTG8kAUragSTGUiB7jOyzuOHIjbIf2+3T4
	 ZKrWUFvMSZOAM6TjiMJMzdXFl/xMZ8XFHSTRSoWUuCIOY7Fklzhx3ztXMrHL3UFBcn
	 LGLe3ccIU7axC27rvLrRU3mgxEA4Td88GFTAgYWVGy/xI5Rki/AskwMkkhpwKGA2uj
	 MqUIlPR9qXMaQ==
Date: Wed, 10 Sep 2025 09:34:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de,
	bwawrzyn@cisco.com, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, 18255117159@163.com, inochiama@gmail.com,
	kishon@kernel.org, krzk+dt@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de,
	thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250910143453.GA1533730@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>

On Wed, Sep 10, 2025 at 10:08:39AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only, supporting data
> rate(gen4) and lanes(x16 or x8).

Strictly speaking, "gen4" is a spec revision, not a data rate.
Include the GT/s rate instead or in addition.  We can fix this when
merging if there's no other reason to repost (I assume you mean 16
GT/s).  Will also add spaces before the open "(".


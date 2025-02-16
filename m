Return-Path: <linux-pci+bounces-21559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BDA3740C
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 12:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB06188E155
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E118DB20;
	Sun, 16 Feb 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa69bqTa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B71758B;
	Sun, 16 Feb 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739707111; cv=none; b=tZ1QhANk6I/mkSwKUrECYUst95o0SML7AIStyVoGKtKZYVvd8nDdbjqIJvzRRHzWREXo3Pha82BjxdPtonyM/pxe5Lm4AAY5a0OEItX+1/hpHZfx3sme8QMfX172ct3myKbZtuWSN5ynxygF6QnHHTy4UQgPZ1/P9cTEvZ5vfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739707111; c=relaxed/simple;
	bh=go6THBf9a2WxNZStb9eYOnWwNBOMVwrXVziNkLnNnz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCdPVMhpdJ3lwbrls06DpNFU4x9a2QVrSDjeh36G71CkJLspeZxYP2eL4smraDIBfAzVCXH1/Upxn+0QoNV2UGqNfdF2CNVmElmppLTEZZhnHzZ8uZwlKgGwA40bu6eUQgcTmqDMAecq5xzVxpEebdLkerEq3yqonujvUia+OQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa69bqTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA13C4CEDD;
	Sun, 16 Feb 2025 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739707111;
	bh=go6THBf9a2WxNZStb9eYOnWwNBOMVwrXVziNkLnNnz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa69bqTa0T9xpXecY2WoRH0Lad8IBcfsNitfhNF2ZTnaRoLwi5kmWDjGhdCKHxlbs
	 KGvTpXWUQ54MoXqrM38LgmXYPUgv+k7y3MUp2qVaXl0GSqJxhp+BqIUzpK5s8l18QT
	 I2Q58TYZ7Cmg2R9pS1ekYU0+1r1IiBbEFUbEc4jWPXiN0heFkpMW9XBQUpJUVAe9oM
	 Y8IihpSfjltSSQYM/xL6HnZaWz07bicZxH1Ib0v7Qc+R7r3T8S9aHnY5DyRS00iEzA
	 Wt1g1IF0nqehTr0hHNvmQpoOZdPDAqkwC9iIkEjyUuTIrhEnOwHohvRxhz5OQfs956
	 ntvJZ43OLc5lQ==
Date: Sun, 16 Feb 2025 12:58:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
	peter.colberg@altera.com
Subject: Re: [PATCH v7 3/7] arm64: dts: agilex: Fix fixed-clock schema
 warnings
Message-ID: <20250216-astonishing-funky-skylark-c64bba@krzk-bin>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
 <20250215155359.321513-4-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250215155359.321513-4-matthew.gerlach@linux.intel.com>

On Sat, Feb 15, 2025 at 09:53:55AM -0600, Matthew Gerlach wrote:
> All Agilex SoCs have the fixed-clocks defined in socfpga_agilex.dsti,


That's not what I asked / talked about. If the clocks are in SoC, they
cannot be disabled.

If they clocks are not in SoC, they should not be in DTSI.

These were my statements last time and this patch does not comple.
Commit msg does not explain why this should be done differently.

Best regards,
Krzysztof



Return-Path: <linux-pci+bounces-21077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A436DA2E964
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0610C18840D1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF341B414F;
	Mon, 10 Feb 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epZAPoRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B26186E20
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183334; cv=none; b=cZGJsIr+7aq5uam+knnFLx2YLDu8aCi4CUR8I47diX2uw7NMUKgHjqkLxjUqemsqX979IbjXRxCL2XW9vrfuOlgJjepeRDoZuKUAcyj13i7yG0A/CsuLXPpAPdmrH5YOUvdmsAHSvG4dAHNbcK+SzB8ZEgdhh58NaAl7SIC32rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183334; c=relaxed/simple;
	bh=0G1DSjPGeAd9kk5uE+lggjJkpQOfHSpKBXHcy/KeF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqLgGChLfce3EUJh/+j6bOxDa20Ws4w5cxGmsqGSuXI850nOA21gPNJGgLU7bA71A6tZKLff+nzH8GWq+eFfOojpTO/6woBahgNKL0vCoHPbwvueiq8tY1xqvZ/jMCL/2L8srS8V3jIvN64eohyMmglPTSgqA8TsW8z+isy836M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epZAPoRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D012C4CEE6;
	Mon, 10 Feb 2025 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739183333;
	bh=0G1DSjPGeAd9kk5uE+lggjJkpQOfHSpKBXHcy/KeF4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epZAPoRCukvGG7oZ30fEqJPDFWTHA8aAMT9xKuOA7q1/0FhO6PcrmQvUXqRyOaFCw
	 KD4uItzXd5kTsgD+6EJWLtQl8uuPLjbe0JwhyKWIszcbtzad1Vc63309j0JtibJ6rM
	 QThwc04N07AkbJjhfwYa17nvnE9PZZVLXBAtXBFAspy7mdi53OiM+SyJfjCorwEgXl
	 Ms82egTZr5AEqeMl9D4NoSyv6qE6QZv2qDnBHeAblljiteZFosb6ejmVMdcNmaba/L
	 ivLdNnSKhmG9Ksu5QZbp/9e59YOTE2KGiwn5gRq7JMHbbH2e8hbWC1pVdx/1RIOUU6
	 lalXE7T5ujxfw==
Date: Mon, 10 Feb 2025 11:28:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Handle endianness
 properly
Message-ID: <Z6nU4ndEhN4R1-Z-@ryzen>
References: <20250127161242.104651-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127161242.104651-2-cassel@kernel.org>

On Mon, Jan 27, 2025 at 05:12:42PM +0100, Niklas Cassel wrote:
> The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
> BAR (usually BAR0), which the host uses to send commands (etc.), and which
> pci-epf-test uses to send back status codes.
> 
> pci-epf-test currently reads and writes this data without any endianness
> conversion functions, which means that pci-epf-test is completely broken
> on big-endian endpoint systems.
> 
> PCI devices are inherently little-endian, and the data stored in the PCI
> BARs should be in little-endian.
> 
> Use endianness conversion functions when reading and writing data to
> struct pci_epf_test_reg so that pci-epf-test will behave correctly on
> big-endian endpoint systems.
> 
> Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Hello PCI maintainers,

Could this patch please be picked up ASAP?

The reason is that all other patches for this driver will conflict with
this change, e.g. Frank's series.

So in order to be nice to other people, so that they do not need to rebase
their series more than necessary, it would be nice to merge this ASAP.


Kind regards,
Niklas


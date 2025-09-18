Return-Path: <linux-pci+bounces-36439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27DB86E98
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476317A52C2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059502ECD10;
	Thu, 18 Sep 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcDzXY7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651C2ED16B;
	Thu, 18 Sep 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227597; cv=none; b=REMcEdatvZCeHf2YN18CD27mfjrabsdm9rdL7G0K2kckma30BPjAg9ST82AFl5aD9y1fK+1E+MRWTW9QfLiFMhoiQA9A1Ob3P5cMNvQVLNGuN4twkuWU8Pcp5dQ7ZXoRKyTVoiA0716W2KPudKUpvKI43jiwdMkjiL2yTitpLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227597; c=relaxed/simple;
	bh=b17n9gfNGwudyqoVogCZ25zF5jUPs86Xp8NNXdzWfmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZL8uEynTreDjl+GX8dVffx4ZVPQFUQDeKgBVzUwvI4M0Z5XoyL8rspezRSyzlA5taXW5NZpU5CYw5pKuKJ0uWyDHA+lTxByXnbbOavk6dcDfAyUXRHG0bR5CxEzh5IqbJmvitSLPi1d5SCfNBCFy4xJrV/JGEvFSB+6q/cCn8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcDzXY7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AFAC4CEE7;
	Thu, 18 Sep 2025 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758227597;
	bh=b17n9gfNGwudyqoVogCZ25zF5jUPs86Xp8NNXdzWfmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jcDzXY7JtAX2Qmrs2oRTx+KHA+oMbI+x0iczcggT04iPXxgl4tymT0b1xtbun0jZJ
	 6V/NCODn1RjsB1kDqDGFMqbZRiE+DbrqynsDrIn2xKaToFSnrwVonZpD67skulBnvw
	 Djns0nbgerx7Q/Know0OIZRd3EYSsYGITCm2iIglEqwBOAUi2rlXvcw8PVhp4pRl+q
	 iKhTWC2TScSNclu6gWyoH8oTdaC+3dYfNtr8xef51l8GqZwwrDS+cHYG0wPQ4LH0LX
	 ECPNqIpeF0BP5uM4ECR7uVnhMYmiseECEzrSsosxlyIuaqv3rPF7AyGSZqvJZZQMlf
	 OcHdP1lOHikyA==
Date: Thu, 18 Sep 2025 15:33:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, mani@kernel.org,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <20250918203315.GA1920702@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917063352.19429-4-xueshuai@linux.alibaba.com>

On Wed, Sep 17, 2025 at 02:33:52PM +0800, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable. Consequently, when a fatal error occurs, the AER
> and DPC drivers do not report specific error types, resulting in logs like:
> 
> 	pcieport 0015:00:00.0: EDR: EDR event received
> 	pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
> 	pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
> 	pcieport 0015:00:00.0: AER: broadcast error_detected message
> 	pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
> 	pcieport 0015:00:00.0: AER: broadcast resume message
> 	pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
> 	pcieport 0015:00:00.0: AER: device recovery successful
> 	pcieport 0015:00:00.0: EDR: DPC port successfully recovered
> 	pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

When you update this series, can you indent these messages with two
spaces instead of a tab?  That will preserve a little space and also
preserve the formatting when "git log" adds its own indentation.


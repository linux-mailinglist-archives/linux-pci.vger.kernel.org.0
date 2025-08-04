Return-Path: <linux-pci+bounces-33391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAFB1AA69
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF8C621965
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F322CBD3;
	Mon,  4 Aug 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2C2X4aY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759319C556;
	Mon,  4 Aug 2025 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343583; cv=none; b=jr3uI75dfXJnHGqyqOplv/RVTRs1j9YFv4e1cwct+P6GrdbhVaJ5Ygz3FHXJPVjpkm6PjGLToGbTkfjgJotxb2wp9Q++pPjNpVvwKtl91WGh6qtb2353/bI67N88rXv87HxFa45PYOT8LQUrMiKlD8NYXxUeExQa8DY7JYRMYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343583; c=relaxed/simple;
	bh=aYKb6iJd/kVSgiABQ2uTA+hqVQeZKq56BhL3RhwvWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MipecxLSybpfLQLnHANiWxVn07sosu2K4z0vSKw3q9ZPWt84dH9yp5hiCsJIPaBmlfPXhZCbPvWnWmDuI++46LYrC0WDeIQG/sWwYJCIz5cHsnE+AhzcGF4ZWoBsmv3Xmh/sX+xd6auOl5aRDFUn6+CMRF7HTelpD+jT7xbKflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2C2X4aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939CBC4CEE7;
	Mon,  4 Aug 2025 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754343582;
	bh=aYKb6iJd/kVSgiABQ2uTA+hqVQeZKq56BhL3RhwvWBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M2C2X4aYsfgeVRsIRk8IXcPevT243s5TEWqh7SnrEv32mHYCLJCRRH0Ze3JN44Upc
	 WQPRWBiQOfkSCJmiSEClY0GUgtQYvQcHHLaq0GKx718TORNVuzjs7nS5q1B95pz1Sv
	 OpbjicuHetQSn7jYh8+rB4+iaLr8PecZBBUx/OXYGEyIXTBEmaPl2EQP17IBglLmMx
	 Ag3qL/I0rxFCmpAeNm2aN77RJgDjsvagWieQiwN2HNuRAek7dQzjtTSAOWNTxeHs69
	 yXSRXmnl4aq7euL+Ml4udQqsTpksGD6T44gsxuShFJErDQyFnp1TttiGIilX8GyBWK
	 /vZZPrDqfmCEg==
Date: Mon, 4 Aug 2025 16:39:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 04/16] PCI: PCIe portdrv: Allocate CXL isolation MSI/-X
 vector
Message-ID: <20250804213941.GA3641825@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730214718.10679-5-Benjamin.Cheatham@amd.com>

Observe the subject line convention for drivers/pci/pcie/portdrv.c.

On Wed, Jul 30, 2025 at 04:47:06PM -0500, Ben Cheatham wrote:
> Update the PCIe portdrv MSI/-X vector allocation code to include the CXL
> isolation service.

Use "MSI/MSI-X", not "MSI/-X" to follow PCIe spec formatting and make
this more greppable.  In subject also.

Bjorn


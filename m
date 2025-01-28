Return-Path: <linux-pci+bounces-20472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7FA20DCA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FCD165EC4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0C1D9587;
	Tue, 28 Jan 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUilUWy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AF1D9337;
	Tue, 28 Jan 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079897; cv=none; b=VpymrGEXtNojz5ecvk4sBvNro7yG+td6p8jRvSoPHif/msPguNMO+YY7PQSJGmtt+6EqWpYUmnRRLwgthndRppvPmHyJGFM136ZL28TPhNY/7a/0sAJoPHQOvVjgacHZArl9CFij3sZjm6CFE+6JEr1wVYJwKtfWkvclLy0l9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079897; c=relaxed/simple;
	bh=Qgub7L8IxfW+PRP2oZAlDUpvBChuqQgMm+DjK3mH7YI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P7NQR1dpKTu3lcml7XKSDjOMs4sd6f1UERVPfzOMRjSeP1HPb9P3jG9L7hCTLnqk2ueYHuRLDqfbMHAqzXxQzE/QMzhPWiNtByIcMBPBuE4B7gyM5rw+2eUfvXe9sLGJi2RFhpPOC4PIj2bg2dJLQKsHeTsnTnOtmHckrJDAvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUilUWy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B61EC4CEDF;
	Tue, 28 Jan 2025 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738079895;
	bh=Qgub7L8IxfW+PRP2oZAlDUpvBChuqQgMm+DjK3mH7YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kUilUWy+tXakeFW+vpV+p4em1aqpjIOmnWN/S1eM2/F1tRHU+2U02dA6u6wQTbcZv
	 Pt6E3Vgw9/sc7KOrzEnAOJVqBguWXbsFBJkdYBE/BW/5lrHia1/L+IAv+WS/dYYXXe
	 V6ep6Vyi5buOChiY8l5No5lggtrSPXjFhLDJNyX4n2E160+iNI1Whb9iHnTbfUY5ei
	 qbdt+rPiNJsEWq9P3qqKoWmZchIv/9Km8Fdvf73CYYKXqjZp3tk1zTBr6XvtnESHfK
	 JguZponaT/iNLKasblxMDEv/Ag8I4+5envuiPCtGMkwiHclGmAMyz466mYqAIOGNDP
	 LMDxo98gwe0Xg==
Date: Tue, 28 Jan 2025 09:58:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Message-ID: <20250128155813.GA318665@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128101156.77868-2-phasta@kernel.org>

On Tue, Jan 28, 2025 at 11:11:57AM +0100, Philipp Stanner wrote:
> intel-thc-hid reintroduced the already deprecated PCI API functions
> 
> 	pcim_iomap_table(),
> 	pcim_iomap_regions(),
> 	pcim_iounmap_regions(),
> 
> none of which should be used anymore.
> ...

> I'm trying to remove this API since a year. Please pay attention to the
> docstrings in PCI which mark certain functions as deprecated.

If you don't use it already, lei is a great tool that can help watch
for things like this:
https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

Or lore queries along this line:
https://lore.kernel.org/all/?q=rt%3A1.month.ago..+dfb%3Apcim_iomap_table


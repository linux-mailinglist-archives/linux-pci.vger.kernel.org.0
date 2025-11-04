Return-Path: <linux-pci+bounces-40226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAECC32206
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBB174E1B0F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0E33345D;
	Tue,  4 Nov 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcjkv5OQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC92566D9;
	Tue,  4 Nov 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274826; cv=none; b=hNS0O9x5u+XBUA4xxNuQf4/s8w/39eKZpbimWpHAggGbqVamoAr1hH53EHEuYzzhwG3jHicfgbDIRcoRxdz72V91ifCcE6j97j0sSX23GMP8uQSKYix4YPsybnSVzf8TX9D1ryaE5pNKtiPLB9vXUwq7EUoFyAYSm6kfDKTxiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274826; c=relaxed/simple;
	bh=qf65b5IizuF32vzXmtobtoU9z/UjphUoqVhM1PSZoTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvssTRdhqLd7x9gKyieRJp3zj4N/TGQo6SMyI56MquYdz+mWuRAndxeR8mBiYw39pWWC9omBAHyjPxLdJCavnS6dPJrGgaYdYEekFOTkYfQWXSBQLaDaaxnKXs7hMByUvIoGCZ8QaAaJaKzZvQl1Y7+8MoqvTIBu0WffKxl8ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcjkv5OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C46C4CEF7;
	Tue,  4 Nov 2025 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274825;
	bh=qf65b5IizuF32vzXmtobtoU9z/UjphUoqVhM1PSZoTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dcjkv5OQSy2X0d5LajExeUgioCdeG1WRENcIbMf6oWKmw8/r5Vh63SjAfsGVyihgG
	 7h0045l+LTG4BrWbfHs0bFIEkD0I7pQxsoaCLihzYMUNbLPiCAuioFEygWgP8oYdcY
	 xMa6frU/pnNT/2yFXJPeDRw46yO8oOjLU4aI2stYLVw3/OO8nLfI464AyvWI7t8TQc
	 tFDsY+yoZqSrlDayUC0M3kuMBtYNmuoV/9H4WjxSFj4zWLu6brKSxonos+M2uSbdJd
	 xYH9FRTKzuBKW9SpLi1+8Gg/+VaUGlxdivZXDkMA9AHXdmDgl+KASOMj76qojJrC8o
	 ynapDjc2/FA9w==
Message-ID: <e7a75899-be93-4f0f-9c9f-0d63d03f4806@kernel.org>
Date: Tue, 4 Nov 2025 17:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 4/4] sample: rust: pci: add tests for config
 space routines
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com,
 smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com,
 joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
References: <20251104142733.5334-1-zhiw@nvidia.com>
 <20251104142733.5334-5-zhiw@nvidia.com>
 <DE00WIVOSYC2.2CAGWUYWE6FZ@kernel.org>
 <20251104184245.2cc7e661.zhiw@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251104184245.2cc7e661.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 5:42 PM, Zhi Wang wrote:
> Should I arrange the traits like below?
> 
> Io trait - Main trait + 32-bit access
>  | 
>  | -- Common address/bound checks
>  |
>  |	(accessor traits)
>  | -- Io Fallible trait - (MMIO backend implements)
>  | -- Io Infallible trait - (MMIO/ConfigSpace backend implements this)
>  |
>  | -- Io64 trait - For backend supports 64 bit access
> 	   |      (accessor traits)
>            | -- Io64 Faillable trait (MMIO backend implements this)
> 	   | -- Io64 Infallible trait (MMIO backend implements this)
> 
> I am also thinking if we should keep 64-bit access accessor in the
> backend implementation instead in the Io trait (like {read, write}
> _relaxed), because I think few backend (PCI Config Space/I2C/SPI) would
> support 64-bit atomic access except MMIO backend.

SGTM, I think it's fine to keep 64-bit in the MMIO backend for now, we can
always split it out into a separate trait once needed.


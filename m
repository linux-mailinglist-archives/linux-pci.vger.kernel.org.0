Return-Path: <linux-pci+bounces-19906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86290A128DB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C864B18853DD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD615C120;
	Wed, 15 Jan 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FABTE8PA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F41553BB;
	Wed, 15 Jan 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959120; cv=none; b=Ks5bWhlXbat/qRPxMragcpwIqTH2K52714jFvSUgECD0FWNIP94EtfeHyN8MNYtaPcPLwnyrd1W2+UM62sI29jSy+aXG6BLjHo2m2/ucMS/h/Ge8AsXAUdo4JMCZ61Xg+XHUAnk7jwrTNsEsv2Tzf7oeyjTXc4ZNDgO0+MCz65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959120; c=relaxed/simple;
	bh=d3ylEUMqKB2nug59MpHU02Ufxcc4KnlyKfjfCl7A1ck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qTvI7TRYvBS6aK5D3QVoJBa18NkWTTyJvzIhrlxKutepa5wC8ULKowBcuJkt7MNds2ZiYtJL2bHfdR5zXQ5LDzwiHi6pjfgX0Ps8aRQB6YWMpxA7Ji3XRwi4NLFv4V1zRNlRy5GSwibMHFbcb3u52Zdims7s2lnS3Nj2Bb49tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FABTE8PA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB60C4CED1;
	Wed, 15 Jan 2025 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959119;
	bh=d3ylEUMqKB2nug59MpHU02Ufxcc4KnlyKfjfCl7A1ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FABTE8PAiqb3tW9Hz74TLdLZRh8JVVm6rcbOWSvUr5LX9vWKXJcOBgReDGB1/8wKA
	 6jHjT4dFJxovOnFngxVqbzIowczRFrKvb9uc0OeCO8VJwCFp5HdswnuiIDcZNvj5ET
	 bLzUmmxMNaK4bjK/d+eAch+MaxJuCFvAZ/pHg6os0G0WBFaDCo7q+3cB0tbFotEYpj
	 PYMmM/9uBajusO08JCuKDCtlfKKhXAZ3SyEUpvID1ohxe5XsN87vkfTxqtL9o7YPln
	 umeaf3qK8X+TEvZw61IBhBXPowhX6Xo7+WafkU8FvggYKfLD/4yTQZQbxu7okunXG0
	 BEBDNQ9cwmw7A==
Date: Wed, 15 Jan 2025 10:38:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250115163838.GA535202@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115162953.yiwhq2m5s5nf7b33@thinkpad>

On Wed, Jan 15, 2025 at 09:59:53PM +0530, Manivannan Sadhasivam wrote:
> ...

> (Also, I don't see the VSEC_IDs defined in the DWC reference manual
> that I got access to).

Haha, yeah, that's because DWC can only define VSEC IDs for devices
with PCI_VENDOR_ID_SYNOPSYS, and if they want to sell IP for use in
devices with other Vendor IDs, it's up to those vendors to define the
VSEC ID in their products.  That's exactly the issue here :)

Bjorn


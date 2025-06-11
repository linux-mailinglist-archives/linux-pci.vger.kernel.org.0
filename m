Return-Path: <linux-pci+bounces-29438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80BAD55A9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64FE1BC2DBF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED12820D7;
	Wed, 11 Jun 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feyNmCvl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEE281532
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645329; cv=none; b=Oc5F5l7Sh4QDZJBN0RNGfOBIkmQpLlP3p/QUOSydp/yixCXu57XzLgeHI/iLOIccuR/c6EPRENdInI/lgOlYGXdQCjBZbwJhO/60l4yq0H//4THZmNY8V61FZhK9xNov6oYFdKwM4drIKhjklMuxbTn1vpI9jlIOFQMJEs9aKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645329; c=relaxed/simple;
	bh=59fw+JmtffOgKin2C7FfK3Bj2N2XLPAvwOa6k5tS4tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck02ngiUYMmFA2YjiUN2wUchh9qZyKqLOsYUR4mXtb6X0NWSLhp9NfMT3+8RhwlKF7DiI1tMWVvA1QDgimGc/FTlwQpSIjMVjolkbkQnJNMSaNVWLYcCG7TD2+3TIWjv7FmkOTFOHbLZ4xjv27HO7/c+dhHZaJN6i7GxW8OoyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feyNmCvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB8C4CEF4;
	Wed, 11 Jun 2025 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645329;
	bh=59fw+JmtffOgKin2C7FfK3Bj2N2XLPAvwOa6k5tS4tE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=feyNmCvlMLeKOhxL9aGF/VtAlqtU2LEwV5iVoJR0Pdjf6qKxFQqqnKyOyDveLWDWr
	 C0AhF5s3eJYlBeB8xp/0Z4aY51l7kkfcBfxgUX+18vtOI4+9EXgjXVNy1oO45wSNwA
	 R6qz+frtjfwJWbqnZJ6wj+oASuJTHCaTjRcyblpGgLcAmiisSH6j1MBLF+AGpRx67Y
	 X9+RBuOWQ+LyHosuxNkmq5ot+WTT3oeTQ8VWKrPDQOmgvYzuiMzeYhY++3MSU8KVNR
	 LgHMPLKypZpVzlG4lxUo1iOA+LcsTfpp+IfMYUvn/K4cdo9gKy3QgrHrxOwEwx02Mw
	 8tWhiXIqxMWwA==
Message-ID: <32c601d5-629b-442e-8b72-0cb6a8fd6500@kernel.org>
Date: Wed, 11 Jun 2025 21:35:27 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits
 100 ms after link up
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
References: <20250611105140.1639031-6-cassel@kernel.org>
 <20250611105140.1639031-9-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250611105140.1639031-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 19:51, Niklas Cassel wrote:
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> up. The delay will only be performed in the success case where the link
> came up.
> 
> DWC glue drivers that have a link up IRQ (drivers that set
> use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> perform this delay in their threaded link up IRQ handler.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


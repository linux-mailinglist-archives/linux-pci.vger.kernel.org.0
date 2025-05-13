Return-Path: <linux-pci+bounces-27623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A2AB4D9E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33547A35AA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0051F5424;
	Tue, 13 May 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY5fXRkh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C81F4E48;
	Tue, 13 May 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123538; cv=none; b=E8pwHscfY6FSZbFp0+g3Cjqds/7lg9a57kaJSsydQ/ln2MVHT/pZfCf33U/dcz8SH0AqLhwG9hPPtAPHyFBYSP9m35Tw9L77QVRdtV94lOCo8RoBeKpu0ZOeYKGsV8OWwbg2Jr+2G8Gc78nVHHnSOcEegRBZgqbfqL/6wS6Tvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123538; c=relaxed/simple;
	bh=sSLHepxaBasy33/TfS4tiApG1/Hq+nahx2oIe40vZas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhfeqM3V8KSPFHrnseQuG2+Ju61HsBN/H+zUAbgVQS/sVNFRtwTQbw7JSyFhaBhDnelVeqzFc0AKCjwTiYfl4+YbVvO2xA0a2NhwlrUY/PQ+/iMOa6MWEXm4lc722SWgn0rweGnRpcLH9Hxm5f3S/X3A+MdM+lREM5DQFwe1QIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY5fXRkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A92C4CEE4;
	Tue, 13 May 2025 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747123537;
	bh=sSLHepxaBasy33/TfS4tiApG1/Hq+nahx2oIe40vZas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fY5fXRkhQXDsTK4NVuUemu8FjDl3DpzWexI4kAdMDct6y3OvhQbuVZ76LPWS70zpp
	 KmtY9jHHFNwUs31bDfBSdF5xxlOteIUMM+af8v5Xz6Tda48JkAwzZZ2nG5DZG2lBSu
	 lBSm7nP+6UsJ6hcV2Q01UCFWf1zEqB1DFhrhUEvHr6iPk8s8U+VwCAExExokG0VT7A
	 C1mW28WQJ8xMqXpKkOqpwSnxUfueGafuBDLJW4DaqkCdVgkIiScpwOlaK2PrOw/AIY
	 WHEIMwgGhQDdee6lqrXGfyXN4zczvpVuESgwbkQqlI1Oq+8NndmrFB8DZwEGIbATCz
	 G1wXGWDaJE9kw==
Date: Tue, 13 May 2025 10:05:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: dwc: Remove redundant MPS configuration
Message-ID: <aCL9Stg0UKJ2AfDK@ryzen>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510155607.390687-3-18255117159@163.com>

On Sat, May 10, 2025 at 11:56:07PM +0800, Hans Zhang wrote:
> The Meson PCIe controller driver manually configures maximum payload
> size (MPS) through meson_set_max_payload, duplicating functionality now
> centralized in the PCI core.  Deprecating redundant code simplifies the
> driver and aligns it with the consolidated MPS management strategy,
> improving long-term maintainability.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


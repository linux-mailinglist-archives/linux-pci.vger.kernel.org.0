Return-Path: <linux-pci+bounces-24497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC5A6D5D9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400D17A48DD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CF25D20C;
	Mon, 24 Mar 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAWJ+i9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DD2054F9;
	Mon, 24 Mar 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803604; cv=none; b=Jf2Yv7Q5BoIpfrKfeNJ/680aBCjcKu05efcSv3LxPKGxGSc3vBQoJlMZivJZdJ+BHdfK7OIBX7TklKqAvx7t1mDoJRHwiGlpauu908P/t9et3lcXGLfnFuQFnByOzsLObP2Qa6CkzPjyBL7bjysF4X7sYz3u4ln+NnZSYlcM1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803604; c=relaxed/simple;
	bh=ZK89vsBV5uED0rXLzoj209yPUF+EwAtwLwv58tQL5Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbwlqIV12/edfPe29+VQMyi6mFrn7kH7qnYUfNu4adquTzia1GmdXYWW5JXZLviNtAbdllpeqMyuGMHTwxXU/1/Jh5e7j6ka20yo697fVWgw9S9mHQIpdUZnfXxa3fpUGqQyFdYh99Iw1BT6M8BAe6x+WNYos1lTf89gsoc8m6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAWJ+i9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A71C4CEDD;
	Mon, 24 Mar 2025 08:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742803603;
	bh=ZK89vsBV5uED0rXLzoj209yPUF+EwAtwLwv58tQL5Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAWJ+i9/oEEBn99JCkz5k0VgD53RE/en/8HESNnd52viVQi8EBSgoHb8eR+Vr15N1
	 DNzIKa58kYmqozeCYq45xLzt11vyrsYOeGQr42Oe0Ju1b4GEJppllreAhN+sUbgj+F
	 irpcKIOVWJ/LHGJDa3uYitAQLYERFAIsJlKwjRNfIad3VD+GQSmccyhdDqkup6y1va
	 I0XY4CM83FCBJ9/NHJ0UsX1LYKVP7PzKYBDJEZiyhl6pJbbEdEVTTkc8NHIL9WPtZl
	 /thdeCChPm0VnR5s6CpuQsc9a4vncbixWA43Q5NUPmb1Ohu5AMD3nRnqYzV414BPg1
	 gLL+uFtDNgjPw==
Date: Mon, 24 Mar 2025 09:06:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Message-ID: <20250324-successful-aquatic-pudu-5a3cdb@krzk-bin>
References: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
 <20250321114211.2185782-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321114211.2185782-2-sai.krishna.musham@amd.com>

On Fri, Mar 21, 2025 at 05:12:10PM +0530, Sai Krishna Musham wrote:
> Introduce `reset-gpios` property to enable GPIO-based control of
> the PCIe RP PERST# signal, generating assert and deassert signals.
> 
> Traditionally, the reset was managed in hardware and enabled during
> initialization. With this patch set, the reset will be handled by the
> driver. Consequently, the `reset-gpios` property must be explicitly
> provided to ensure proper functionality.
> 
> Add CPM clock and reset control registers base (`cpm_crx`) to handle
> PCIe IP reset along with PCIe RP PERST# to avoid Link Training errors.
> 
> Add `cpm_crx` property between `cfg` and `cpm_csr` as required. Absence
> of this property results in an ABI break.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v5:
> - Remove `reset-gpios` property from required as it is already present
>   in pci-bus-common.yaml
> - Update commit message
> Changes for v4:
> - Add CPM clock and reset control registers base to handle PCIe IP
>   reset.
> - Update commit message.
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml         | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index d674a24c8ccc..293df91d4e74 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -24,15 +24,17 @@ properties:
>      items:
>        - description: CPM system level control and status registers.
>        - description: Configuration space region and bridge registers.
> +      - description: CPM clock and reset control registers.

Nothing improved.

Best regards,
Krzysztof



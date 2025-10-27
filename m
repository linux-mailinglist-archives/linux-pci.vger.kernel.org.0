Return-Path: <linux-pci+bounces-39433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37344C0E1A0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D451F34E249
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363C3019C8;
	Mon, 27 Oct 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7rTHVOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE522D4DC;
	Mon, 27 Oct 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572288; cv=none; b=QABNZmDfKLrSf59wmOImbC/wiDNaMKFRnhITInSaer+5UDR2zcOEluN6VwJyfi4hOHt+y32KVcA3wYru7nTR9jnP4LBRcEZkhtG4blTYc+C6SYiQ7Tw7O6ffsWQpETOU7EXmpcz5HP8NcW0Gd4Ug28lHL/WGCV1EyoTWiYpcVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572288; c=relaxed/simple;
	bh=gqvuTK2airj61pCPi99n7PP0OTEYVHFTeCG5nZFFdzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgKraQE3nQAzntcW4Lw6I10YBpg/HiZpLqkQLLzQFYT7uce71ghoDCZ4sC2xGh8gPhoSAYbNGgjlCLDLWLcV0rSY4vWI7v8U0xE9qdEDCFOtdEn/lM2dHogsK0hoKtqn4j7a/fib3UkZ5SNyNivh9shKvr2YvhLOwxv4Ypb+kvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7rTHVOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C1C4CEF1;
	Mon, 27 Oct 2025 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572287;
	bh=gqvuTK2airj61pCPi99n7PP0OTEYVHFTeCG5nZFFdzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7rTHVOu0MVumBdZo9ViIt/dHyGzHfHHi7pdbUP3eF9Ubg5CmW/X3t9S6LGI3OYtB
	 UZoPhdl+Rj1NpD2KiIAbMnTJCiju0ZtQDG7RSZx2uPhTZ0M0+zfHYTOXTFE691Cufb
	 mMcsmB21miV4uJmANZCj/Gm0GLo1wz3rTUBQw9HA+DSCA7zZ1N3dLiKKXYBL1f+iww
	 Yuu3bcc7JGpNmd3+TyrXQuqGdmIgqlKTs/lovY3DiqLlQnY9sqJO+qZcB5bBNDh+ZN
	 qFKX4DKjEHU4BZosKAnG/SMyoQV9AVb86ozyRx2HfeT3kX9GG6JYt1hq/hlogpm7p2
	 Ye2JjJC7I1LZw==
Date: Mon, 27 Oct 2025 08:38:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: kwilczynski@kernel.org, aou@eecs.berkeley.edu,
	thippeswamy.havalige@amd.com, jingoohan1@gmail.com,
	palmer@dabbelt.com, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, randolph.sklin@gmail.com, namcao@linutronix.de,
	tim609@andestech.com, linux-riscv@lists.infradead.org,
	alex@ghiti.fr, bhelgaas@google.com, lpieralisi@kernel.org,
	shradha.t@samsung.com, conor+dt@kernel.org, ben717@andestech.com,
	devicetree@vger.kernel.org, inochiama@gmail.com,
	linux-pci@vger.kernel.org, mani@kernel.org,
	paul.walmsley@sifive.com, pjw@kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: PCI: Add Andes QiLai PCIe support
Message-ID: <176157228191.240954.997388702686594192.robh@kernel.org>
References: <20251023120933.2427946-1-randolph@andestech.com>
 <20251023120933.2427946-2-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023120933.2427946-2-randolph@andestech.com>


On Thu, 23 Oct 2025 20:09:30 +0800, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> Only one example is required in the DTS bindings YAML file.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  .../bindings/pci/andestech,qilai-pcie.yaml    | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



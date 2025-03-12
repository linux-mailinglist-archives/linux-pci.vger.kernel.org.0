Return-Path: <linux-pci+bounces-23487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A87A5D8E6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 10:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53823176EA2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2123816E;
	Wed, 12 Mar 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOVVbM/q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025B238172;
	Wed, 12 Mar 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770672; cv=none; b=BPkIYdhc5RrRQ6HKftfPhXEsRgSDOAxfWuw7N9TqCeCLn2oXyqDdFTnosiFq22VrPo4z6dGJuIjNSagzPlQyF1qrX7Gz+aby65b6fiwkPwMpB7Zur9sOk64hrwMPN6f4sg6ziXcKrtwGVluSqFC68SnwUuC6JlmWhLP9DsPBlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770672; c=relaxed/simple;
	bh=R5u/MPwOptPXQ8G4otFzQXBnW5BpSZsw4xZ1ZzVhQl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOTtw/Wg6Es2wwa2tqCcWjALCBL2puxTo3DsI1Yey6wVdg1Koui/IcksCnhsmJvzxiHMcN5ENK9SfpVqWCkhMKKPGjmlExlK/KzzyiaF9DwBCaG/ix5zH4vJTai6cI4QrecbARdhQnRf58ylbshy+4HY9eTAkpUfodKecne/xSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOVVbM/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D392C4CEE3;
	Wed, 12 Mar 2025 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770672;
	bh=R5u/MPwOptPXQ8G4otFzQXBnW5BpSZsw4xZ1ZzVhQl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOVVbM/qeqV9cw8tj8qoRsAo3juv41+N10Po3L/8vRmUfyhydmiamNOFThvZ9xUXw
	 frRARDGSGHpBgUXQ6YtjdBQWUJAxZgmppYg0WSU7Lbm+o9x65aV7tugbLukkPRocrj
	 7yNEFzi3qkSHN0exUG/tSf5CgsNJ7vtIHzHQBAYzZIE5gP/4HgkjR3/TLzItI+1ejD
	 MACY0tO5ied/+zWdCBN/C8xylrr2wD5gK+M/bNS4lJJadHk9eSKaeiI4buUmEI0rrx
	 /CRj+YxjUtpGa/YOLha17Q2IFr1SF9gQQgJyn9nWgZz1Zs0HhvlnQql1uwVleBhPsB
	 t0JwYVe73srgA==
Date: Wed, 12 Mar 2025 10:11:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: syscon: Add the pbus-csr node for
 Airoha EN7581 SoC
Message-ID: <20250312-amigurumi-chamois-of-virtuosity-1ed2a7@krzk-bin>
References: <20250312-en7581-pbus_csr-binding-v3-1-7bd9f00a25a4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312-en7581-pbus_csr-binding-v3-1-7bd9f00a25a4@kernel.org>

On Wed, Mar 12, 2025 at 09:32:15AM +0100, Lorenzo Bianconi wrote:
> Introduce pbus-csr document bindings in syscon.yaml for EN7581 SoC.
> The airoha pbus-csr block provides a configuration interface for the PBUS
> controller used to detect if a given address is accessible on PCIe
> controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



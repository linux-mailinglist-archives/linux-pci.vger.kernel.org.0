Return-Path: <linux-pci+bounces-23358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09F6A5A2E2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D23A4B22
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B242343D4;
	Mon, 10 Mar 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtNKjWT7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE160233729;
	Mon, 10 Mar 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631167; cv=none; b=NZoZX5qT5OEwiCFKWvizPkts15W90DyzHzN3JdKEQcbx8wTpVwc2Kr20amxHZJHKekc6Lz9KZg8jszaUq7Asl+JThPNFRLA/McMAY0qs5FsdZwz64fo6oY6Y5BS/avmkpVwbpJQEe9wQ0FGC/iaL1bflrsbV1pQw6W9Vv/7X+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631167; c=relaxed/simple;
	bh=cyNfw5aBnRiDdtv4MSSnga2Y5mDwrbotVHovHS6Sauo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVvocER8kgf3mwDr4StkW6ENGL23p0ShPWoPafH1Vaf/qDRrXd5gZMBsxcaAKxpyhqdGRy7Jn7eE5BsJbpT7JsAnQDHCfWXZ6Ei/WkO7dnNp7KfydCeaNPmYbrAhJxG5mnYAre0hLajbPOE4bF8GzbYOTwRHLKp61saY754cZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtNKjWT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8CDC4CEE5;
	Mon, 10 Mar 2025 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631167;
	bh=cyNfw5aBnRiDdtv4MSSnga2Y5mDwrbotVHovHS6Sauo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtNKjWT7oRQTj2VMb24xngME8b/ZIFZJ8uA6QGOrpkikPN2iawvwjW5D/EdZGVgJ6
	 mdhJArF2pnyTRzPsVOr+bvNeQmfRCk5jqwj+zWCK/xMYf5araeiKymYmCWbRSVzlMW
	 MCIWoqd4zTSlbYY4nglNWdp9UUOaR5hhSh11FZhyV5RXZVhptiCtwYRxfVuReQVUrv
	 4aGfYc3fbhcjzRH+KXwMBaosRpOtelUQeWLQjzXBPj/XpWdI8QPP7DZy/Gsdf2xb2h
	 lrZWqz4/ArMDIftqwSYzRKqiVfFMxzPKpEyT1b4CoZeXVOoaErmgGnq6hAXwJQJTW5
	 TdzEkSS1BZFdg==
Date: Tue, 11 Mar 2025 03:26:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Niklas Cassel <cassel@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator
 'intx_capable' does not refer to any field in type 'const struct
 dw_pcie_ep_ops'
Message-ID: <20250310182605.GA1179150@rocinante>
References: <202503110151.vQXf5yof-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503110151.vQXf5yof-lkp@intel.com>

Hello,

[...]
> vim +316 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
>    313	
>    314	static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>    315		.init = rockchip_pcie_ep_init,
>  > 316		.intx_capable = false,
>    317		.raise_irq = rockchip_pcie_raise_irq,
>    318		.get_features = rockchip_pcie_get_features,
>    319	};
>    320	

I moved setting the .intx_capable property to false to the pci_epc_features
struct definition for RK3568, which is what I believe the intention was.

Have a look at:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint-test&id=cb349262d9770e6478a7e91bdf438122b8cda44d

Let me know if this is OK with you.

	Krzysztof


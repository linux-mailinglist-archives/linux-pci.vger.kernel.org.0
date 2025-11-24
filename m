Return-Path: <linux-pci+bounces-41933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD15C7FB87
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D9404E3CE4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009382F7468;
	Mon, 24 Nov 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZQpsh8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84424B28;
	Mon, 24 Nov 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977791; cv=none; b=WKB2JKgC9cO/65UHEs/tPnuunTiw0pPpBwfqGWs6Ed3BXDGiqqnRCExqaFxYYXSguk2/1By/6f5aAYPZvvRavad4WXvNnvOlfZf0vp16AUTFqtq9MjWnRDafwi1rRYTq/a4NDvWMom+233jNV9lanGS2aMbWiJ9GsSxamnEnKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977791; c=relaxed/simple;
	bh=e0Rfgj366tJxe1xsMBXGVrkz7jJATsofvCJET5b+Jts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0pc+gMSsQOsHxVpyMGSnb+kC4nDbjfcbvo2xsVKD1t8Socbcn2NzbuV913AJZI44yhdOmRFTby0BqCWnedOYYbq4hMNm3mRUVtPgV64fDqfRE/nzCYjROyUnO25xJBI7iN5dMcDM3FvRJp8tW2jacYGU1Ufl/wYZov/67tNo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZQpsh8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165A9C4CEF1;
	Mon, 24 Nov 2025 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977791;
	bh=e0Rfgj366tJxe1xsMBXGVrkz7jJATsofvCJET5b+Jts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZQpsh8tusQGHYy87IQbB12/uZyISK2efxLt05bMvy6mIeMUIC1mBpVhhUFerRFB+
	 018dT15yOy/onqeQ6NsERRsh0KnxXLUt/WDGf2qYEchZoF4d36nj6pi6BzcexdSgHK
	 9Nj7vcHtBl7HieT4EBiuSEwooNsa6Xul+5g4gV+ZMshkEFu+BDKuaFLeJtH8clu+/O
	 rtTTxpI+llZ3UZXD225zpleXnnVBGSqr13zMhFImf6b9YqKPkHgpxYuPcljEx3gXnB
	 GLU1VtHBmF2V+ICTZWr/Qohw1/HQpts2pGKioMa6eKGGuvjUnBRE9DjwWJgBK8AIo7
	 EvWRO7s/T7T1Q==
Date: Mon, 24 Nov 2025 10:49:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	helgaas@kernel.org, heiko@sntech.de, mani@kernel.org,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <aSQqOHH2VLNNpX3D@ryzen>
References: <20251104165125.174168-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104165125.174168-1-18255117159@163.com>

On Wed, Nov 05, 2025 at 12:51:23AM +0800, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.

Hello PCI maintainers,

Merge window is opening soon,
what is the status of this series?


Kind regards,
Niklas


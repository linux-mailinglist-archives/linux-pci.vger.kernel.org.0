Return-Path: <linux-pci+bounces-31057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038FFAED58C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E564E3A65D1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C321CC4F;
	Mon, 30 Jun 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEJYe4x9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85A21A452;
	Mon, 30 Jun 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268430; cv=none; b=sT0HJK8R/qOuy35V0v2gxCdeEEZ/kaIhS1Vlz9vJrMUvKjPihOYJZIyeJBJFuyxXhlmpsy1NNHPKHeLGfFQn7jSfd0N6R6yn14wzQU13/cqnhTFA6pnU6QIevinbV4cJ3FP9lwS9HQDrcQUarxHWzB/Yj1UORKfVMt6lmJ30Zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268430; c=relaxed/simple;
	bh=FWrl2p3qQeCBwBc+iddcMGfISqzr9IL2sZSnnO0P3zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYDsr5n6yTwc5xzHzK1327gubAPpA16FQxX0unZaB1gt1IQiZq0XyeMTwVGmkaRkCBcPfT7y0UWat1ta7inn0QJcCFRdxp7tbF0yyFQlOlUy7z2LMjgdBNqdZ5wR2/fvDLPx5Zcc1sMIQmqkecmMjaczxxqCJLoglY2GEUfDOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEJYe4x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2601C4CEEB;
	Mon, 30 Jun 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268430;
	bh=FWrl2p3qQeCBwBc+iddcMGfISqzr9IL2sZSnnO0P3zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEJYe4x9/sFWmnbjhQynE5TdQU1WA1dlhsPNY+Cz/9RvKGhTvvmcj+/4MQSkyjlau
	 mGPXQDK/+5NbfO75xXrLB6lzSaOCsRMTt2ThsbcYlrVw1e0lButaaPMjWApUyT4YHT
	 boQ8B1FU8M1wAD+W6FdvDjJcCsPGXyZispul0gE2+klcobIJ0c8w4h9IRMmJwttZ5G
	 sQh/aCNx/CxyxiDgXE9N4UiUUxKQ5yBJJOtESnw23DwvANnUU8ed75SJ9xhrlsIJ0i
	 4jq5nRqsr3UG/U6Saup3/VD6SowuGyJOXRQP2DBvvTzbCNZIMlSnzIp4ZBhCNFSP5y
	 eXTkHqpaoS5Kw==
Date: Mon, 30 Jun 2025 09:27:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/14] dt-bindings: pci: cadence: Extend compatible
 for new EP configuration
Message-ID: <20250630-antique-therapeutic-swift-dec350@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-3-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-3-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:15:49PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Document the compatible property for HPA (High Performance Architecture)
> PCIe controller EP configuration.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>

Missing SoB.

Why are you sending someone else's patches? This just duplicates the
review and creates confusion.

Did you address ENTIRE previous review when you resent this?

Best regards,
Krzysztof



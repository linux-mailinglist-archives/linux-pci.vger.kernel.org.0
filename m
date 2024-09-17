Return-Path: <linux-pci+bounces-13264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C297AF2D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196A41F232D2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2DB15AAD9;
	Tue, 17 Sep 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNzYjDmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452608F77;
	Tue, 17 Sep 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726570194; cv=none; b=GkdxnwKCfWXFIl5kiW+zyHpKzk9qd4H6KwkpBPickYHesXGhcsX2762zvlA4+PwT7JOWEz/JyusqQSoWZr0PucjiLok/XswY3nIGU6tXtnriSmOP7ACjUS4KuXESuDkedsY5IOanIgyYU6oflhadtq8yGxWv1hdMGwusinacSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726570194; c=relaxed/simple;
	bh=QymIW4WPXHYXp2+gvRQI/PQAiTDdbcnDFvemDS0mJfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVZG+mPTMUUt6RAVTFKynz6C5/+wytv2AyCzdb0EHMKo5hWs5ngOaym/WbqmNTiOmn4wt6YvwQh5l7JoiTDkf9EfuFxf1AwYh/Ly7bzl99WQbulJa1CahE6Xn6zQhYKiqKkA5701I8FODwtzKk+P9VFD7WCgxByQpzG+Wer4wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNzYjDmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2685C4CEC5;
	Tue, 17 Sep 2024 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726570193;
	bh=QymIW4WPXHYXp2+gvRQI/PQAiTDdbcnDFvemDS0mJfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNzYjDmCVZc3CdpX2eHBDBrBF0YYUokBysdxrIDlonOtwCV/I5YbmtdogpgbrYYZ7
	 ++vYiGL+94F4I+K1EIJizZKHF1rAqeDMdnjpGpbvMaFD/FfgCVJrDotXC+Noub49pk
	 PRoTtfxhg/y6juW3X9FqlJrAeEzBUmpNIw0W3UurtOvXP8gEIZQ7jz3m7tVbMctg2p
	 oTFvLDut8AzEv1QW2Pq5JK+lIvXZuqGIl6Mi8BNJ8qi9Cxhl4DUFcashBPplVfo/jt
	 0NePQU++yWXSQ951qV2JpjPQyuKMIhq7hd5um9ji2Em0Tk1TBJHKaYEy7edYcFufos
	 DvH2zGvtx5/Eg==
Date: Tue, 17 Sep 2024 12:49:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, bharat.kumar.gogada@amd.com, michal.simek@amd.com, 
	lpieralisi@kernel.org, kw@linux.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5 controller 1
Message-ID: <tqte5pxvuhkqwr7gaxblx6orprd74qyw5ekrx53blbbygtrgpn@3uprlzf5otou>
References: <20240916163124.2223468-1-thippesw@amd.com>
 <20240916163124.2223468-2-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916163124.2223468-2-thippesw@amd.com>

On Mon, Sep 16, 2024 at 10:01:23PM +0530, Thippeswamy Havalige wrote:
> The Xilinx Versal Premium series includes the CPM5 block, which supports
> two Type-A Root Port controllers operating at Gen5 speed.
> 
> This patch adds a compatible string to distinguish between the two CPM5
> Root Port controllers. The error interrupt registers and corresponding bits
> for Controller 0 and Controller 1 are located at different offsets, making
> it necessary to differentiate them.
> 
> By using the new compatible string, the driver can properly handle these
> platform-specific differences between the controllers.
> 
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
> changes in v2:
> --------------
> Modify compatible string to differentiate controller 0 and controller 1
> ---
>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 989fb0fa2577..3783075661e2 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - xlnx,versal-cpm-host-1.00
>        - xlnx,versal-cpm5-host
> +      - xlnx,versal-cpm5-host1-1

Hm, I thought my irony was obvious, but it seems was not. Apologies.
"1-1", "1-2", "1-1-1" or "1-1.00-1" are all poor choices.

I was waiting for some reasonable name idea, because it is you who knows
the hardware and has datasheet.

I guess if I have to come up with name then "host1" was better. Or
"cpm5-1-host". Dunno, all these names "5" in "cpm5" and "-1.00" in IP
version are randomly constructed.

Best regards,
Krzysztof



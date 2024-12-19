Return-Path: <linux-pci+bounces-18779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204289F7CFE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7725C1663AE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F6171652;
	Thu, 19 Dec 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVB6BYMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848B1805E
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618036; cv=none; b=ejZYQpYi1Q+aUpMBHe80rItv6IFbxjcpA4yMOjqLCzQqZTIT5DbY9a2X00FlbABcgmBqhmIKPLxrjkwec+BneX8ZjIDiZEeL3eZK0scpVKmybfs9tEq5Hevug6Vn29PfKaZ9/379lvsgzd0ZVkpV/XYarDRrNukTJQ3Nt2wYkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618036; c=relaxed/simple;
	bh=AtsVUevjguPyX6vLLyGDcLv5TdUsblpFbhpBPp5Fnps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZg2x7QFiFng8jsSQN1Lv4gdN62oRFHokLCV2/95nNa5pBLWaZ5B1iQtVIvoOHaO0o/WkAYJQh1ZEyAImmelmzVnz51Jt/PUUdq1iHV9q3PC9mIWigwVlSB6lg/oD5coIJdezQ6sOLj6NJTs1H2aQ9nVyQtIr4jSCs3vgn/7UIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVB6BYMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F7CC4CECE;
	Thu, 19 Dec 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618035;
	bh=AtsVUevjguPyX6vLLyGDcLv5TdUsblpFbhpBPp5Fnps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVB6BYMokPeu3M+wH2LfMvLybFAKHCaE6pfJpLswYpbcQjpNLM+24NRuT4XIRUISH
	 8PsjZYmUr7OvMwMHfw4KI0jv+sfslccLsREyzdd5wxgAE8XMCHqhTIZiru0wPel2I3
	 4rcLIAqLadQgbP1FwdXzBqe6RyQFKNuUXiNvZxBpEUkP+1AIZe203SjBKrXQPb70y3
	 J6O7pPj8zVCViAK0mlPvgdwpufQ3ojBOhP1MK3xV2twD0G8bDQt+2lQZB8qR5DKzo1
	 16Q4VCYOagt1zcnrcfNCV28GW7Z6OCMPK3EhOfxzUy7zjxZgaxBcRbFxDU9O17uAKt
	 AivfYI7b0RgsQ==
Date: Thu, 19 Dec 2024 15:20:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <Z2Qrr_82OrKYBF8Y@ryzen>
References: <20241203063851.695733-4-cassel@kernel.org>
 <Z1qkQaVPMVz3vtmj@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1qkQaVPMVz3vtmj@ryzen>

On Thu, Dec 12, 2024 at 09:52:17AM +0100, Niklas Cassel wrote:
> 
> Since this series has two R-b tags on both patches in the series,
> any chance of getting this series picked up?

Another week has past, hence another ping :)


Kind regards,
Niklas


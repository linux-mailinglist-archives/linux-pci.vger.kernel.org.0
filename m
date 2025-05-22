Return-Path: <linux-pci+bounces-28284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB83AC1154
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601C91760BD
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962302512F5;
	Thu, 22 May 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc2KUOfN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9D24886F;
	Thu, 22 May 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932174; cv=none; b=E6uFIVMt3cEwKqgzU7gDIYjejmEM5m3KdecVRJS3XwYHGUUG2CUvtaWzUpO2MpO4c6zcEmoz7+DdM43BgV4cyM8bWljPcEawlj8tAniUVGN05FMeeobT3UvwK/vGBUJxIbE3PzLvi/p27vaXrNIiGMoXLEFQ/aI+51SOIGsXlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932174; c=relaxed/simple;
	bh=2MqYRaBONtXChNXki2xoS+eAuqrcBXiJHqjFweQNgsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX/nh7ahNHldT7Yj45qZaaptgetPJqfV8jDeAUWde2kCsAsntOkOaLFrHn0SoUwK0hYhaV641YJa7MabfzP4X9RmX4h9N1Eyq/2+mWR371qGkf1yxNnMID80gUG8ZFgDU+eLFTmboGBt2kLIwhFm9+ciywOv6Wdbpu6SalSkK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc2KUOfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05416C4CEE4;
	Thu, 22 May 2025 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932174;
	bh=2MqYRaBONtXChNXki2xoS+eAuqrcBXiJHqjFweQNgsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc2KUOfN1JUVqGYOPbj/fQNZ7bs2VCKuzvnA8q37nJ35jFlcwI+7RdU0AJHgF7e/2
	 eoz8zsx0HqExUxinvTfB48AeMKLFALyLEou8B3UOtZltzKTun+H8XsSY3CzxE2Mwe+
	 uJRG8O+HIswGU3T+ybk4mCgGuz2V/6961PzMkwNcQI0rWRq1ferzk9HRG6AdLaBUPf
	 ubkvJ7As1YLGO66WzUtKdeaC2iul+URKMiaK2OOZo2xeufnbKQJ4UC7/yJ+pHHfkkL
	 WCDcNunblzUUaVaOdewbtFMVEFT6OPV7milLaqzIY8MnEj7CORPHX1DkF/3NzC+yuT
	 G4oRTx8yuPoxA==
Date: Fri, 23 May 2025 01:42:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
Message-ID: <20250522164252.GA3745303@rocinante>
References: <20250522163251.399223-1-18255117159@163.com>
 <20250522163535.GA3558378@rocinante>
 <8472c23c-167f-4e77-bc04-a9498fd41fa8@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8472c23c-167f-4e77-bc04-a9498fd41fa8@163.com>

> > I think you got a wrong set of maintainers here. :)
> > [...]
> 
> Yes, I just found out. I'm very sorry.

No worries.  Not a problem. :)

Thank you!

	Krzysztof


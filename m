Return-Path: <linux-pci+bounces-16143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3129BF109
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4013B2832B3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5618FC91;
	Wed,  6 Nov 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1vjr/wy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E39537FF;
	Wed,  6 Nov 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905328; cv=none; b=RxAdCtfJksAYhBcn2C/f2YOULlZ6jyMocTWaXtji4ZWPCHyzJjsN27Q9LDGZYHSrj1r1Gd721N2oZ+xhXLVA75CGVqSt6SxvBCZxqJOsIsNqGuSYzOoehK3kUC95/v0vmk7/hsARbCFKCst1z24SgzqXzKSu5DdhvsCWyN8Jowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905328; c=relaxed/simple;
	bh=nkana9yBjVcklcCZCmum6OTUy8ZGMkm77JJasyuXgHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/FCK8sj0TIcfSqzbheb7ksYCNM9VuYbqdcUWUpBh7vhu0D9YUUfLoIXn+eZW8DKt4amgNPB4sankE7gove5i57ZlQGaLe0cKQEzfn8VUuxebuOgEFxVUYQ+xFb0v3c96LOA6ymIDTMpEYltEHqgmIoqZ+WPXqS3DOMCUMZn8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1vjr/wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7000CC4CEC6;
	Wed,  6 Nov 2024 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905327;
	bh=nkana9yBjVcklcCZCmum6OTUy8ZGMkm77JJasyuXgHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1vjr/wyzxNVmCkUzyBG3co5Ox7PWB8bLrauZcmttadJVH6cRNu/QT0rqKqejPx+S
	 5dtgIL6xKOIronT/QrA8bkEvTXn608FnXnzvFo8mwkgMyoAoJ6ySWP1tBZHeibxTjt
	 jiH3Iqkf4au2oynh3VefZSZNOlzSezll6fVKZj+jDwqZBIfLO9SAxC9rViNkSIpfKV
	 KHshGHFYjPRxMxv0sDNwc5cK2nv5WTG8t4qaWFdwtIC/+adtPZRVIuKICSVbpHVbq6
	 rhMcAsOQuOJ1bvHDiXEHfYkqF1YEWQs+9FhBYTDxV1skwrkguZNvQSGddvclDBAPWC
	 suBf+b78Hymww==
Date: Thu, 7 Nov 2024 00:02:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, lpieralisi@kernel.org, frank.li@nxp.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Bug fixes when generic suspend/resume functions
 are used
Message-ID: <20241106150205.GB2745640@rocinante>
References: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>

Hello,

> Two bug fixes when dwc generic suspend/resume callbacks are used.
> 
> The patch #1 is issued before, but it's not applied yet refer to [1].
> Combine these two bug fixes into one series and send here.

Applied to controller/dwc, thank you!

[01/02] PCI: dwc: Fix resume failure if no EP is connected on some platforms
        https://git.kernel.org/pci/pci/c/d9c56dd5d99d

[02/02] PCI: dwc: Always stop link in the dw_pcie_suspend_noirq()
        https://git.kernel.org/pci/pci/c/f40d59f309db

	Krzysztof


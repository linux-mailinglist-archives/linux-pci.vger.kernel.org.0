Return-Path: <linux-pci+bounces-15893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030D9BA818
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C2E1C20D7F
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514DE18BC10;
	Sun,  3 Nov 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZfCcs/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742C83CD3;
	Sun,  3 Nov 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667422; cv=none; b=h6vRejudbRgzhiQQNvR43jghmnHwsDT/LkdBbh3YCwgkoIw5K+BJWLrltaxvsrhg51jSeBggaq6EV31qwbNmyNwnS/t/ZpCh7hrE0KW/UiKHUV4nTI5Ss+S/efFrjsefsEE+E5PI2BgISAgzo6diSMNsDUPlEBJwVquoyinISGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667422; c=relaxed/simple;
	bh=kQwXeMRLlAue8MzM7s00R8H53UF6cT2XhjoFMQqxCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxdMdkuw3Jwq5BCzoZDuNjb+Pb2HJw9BjaisKtlxSZFYiJWIQtLzD8vLjYYYE/RjBFYPFBstSOMAk5G70dOIX5pm9Muv+QD4whjTqY3tLZx/zEpmXuh7EKGNAHOqD+KrDhMG5SojdqXceVngkyYvw16p2i6mgojpG3puR1gME5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZfCcs/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569F0C4CECD;
	Sun,  3 Nov 2024 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667421;
	bh=kQwXeMRLlAue8MzM7s00R8H53UF6cT2XhjoFMQqxCkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZfCcs/tF9z6dJVI8kCfdAWIbtmZ93sOavb56I2SXMKj9D34RPhWU6lJGXLkoi9s1
	 hnWUWDui/i83Z5muJ32UcOA3ToCCVPl7KEVkWMEZe682ZFbKXw8uFwjOKH9lg7p57E
	 3gPbhhfdE7hhxIkQFoWz7qBcPWSsuonYzWvCsEK2qTQzI3lC5wRbdt1CHKNeAQks4I
	 u/nJcrwJzBraYbrUAqqhy/XpolIHbvkfjliSzhFnJjqcBpxoD1EhYoq/fIdXXiJbdy
	 BipbuemJxJzsGpkaTD3e50ny4WQVtH1fxWdZooPNsWmM1mI6PFsTo1fw3/PTewR49E
	 D8x4C9H2XQvFw==
Date: Mon, 4 Nov 2024 05:56:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, frank.li@nxp.com,
	mani@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241103205659.GI237624@rocinante>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>

Hello,

> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.
> 
> Change call to deinit() in suspend and init() at resume regardless of
> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.

Applied to controller/dwc, thank you!

[01/01] PCI: dwc: Fix resume failure if no EP is connected at some platforms
        https://git.kernel.org/pci/pci/c/ec008c493c25

	Krzysztof


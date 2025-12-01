Return-Path: <linux-pci+bounces-42347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1512C95E4D
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 07:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B430C4E05BB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2A1FE45D;
	Mon,  1 Dec 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN62uUg8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB01E47C5;
	Mon,  1 Dec 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764571218; cv=none; b=PIRKT/Ns2ThAo1aXpkqKvHM0JNlWpOZ2si42+BI32GKlxRCxbsVdagGCLmIuUKHBWTTvj8R6zOFNmMgoXe2WRGpO8QyquZ9l0UjX8RZRfeGHwR7ZpNJBIY0DRhJsQoA1wBAFnrL7dLcX9lMi/PbqS7jnZfP1zd3xeyii/WvB3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764571218; c=relaxed/simple;
	bh=BUMTj/ea2YlzqvnqyiSxOxPBM/xPbxxNYqiHcRDynGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlHEXWoAtKanMfx/HyIz2VSyinHnxQv7RldX0bj7Q6t7WsMffq1IgxzsdDmeS5n9mYwZEaQ4xWk4OpWf67wSfp55xl0tDoG+Ykd1kD0Pf14KYouzzEaR95o1fzwL49KGFp7xL0dM8xHCBUsYffQVwdZlzIsXvN16dEX+j+YF0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN62uUg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC18C4CEF1;
	Mon,  1 Dec 2025 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764571217;
	bh=BUMTj/ea2YlzqvnqyiSxOxPBM/xPbxxNYqiHcRDynGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN62uUg8TIZ2rsF0xhyKBh6C/xS6qb0pU+f15siHilqicNlfTSlOTLZSFM/63RJAf
	 D2PZ5FoRikrUrHH6HRCco5CagArK6sWF+7zVkE/raKd7KM3a3uwbe9ps6pVwVpSjBf
	 X/tIWlHRQYGxDVRerNlVQE/lV7BoV42R44tKNYirPZXzRR1bOXx+k+pCWPaZfsND4E
	 oeV5XoqqWXKSuDIibh/NoteVsOGiQlGkiQ/rKP5GOP81hXPtDbl3TG3L+CNCngFHx1
	 NP5UD1UMBaau3WZ0bAsckjep9uI2HfOCEQTcUH56sTYeRawRJtprH0C7rL0hBY/M7K
	 kstQtQ24hKfDA==
Date: Mon, 1 Dec 2025 07:40:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aS04Sx9YRPwPjPzc@ryzen>
References: <20251201063634.4115762-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201063634.4115762-2-cassel@kernel.org>

Forgot to pick up tags from v1, adding them here so that e.g. b4 will pick
them up:

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: FUKAUMI Naoki <naoki@radxa.com>


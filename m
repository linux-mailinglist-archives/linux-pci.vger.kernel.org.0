Return-Path: <linux-pci+bounces-18986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C39FB5EC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780BA1655F3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E31D63D1;
	Mon, 23 Dec 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhGV613M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA71B0F1B;
	Mon, 23 Dec 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987285; cv=none; b=O3Y0PjZjjoW4zOYuOUJO9N2eGO+yqhAJcGAgKf62mNf2v4ZXs0qbDaI9GSOxcrPrVfbH474TDGO95I0SODd8poqiWkfI04evmQ3Q3qx0jbOjRScO4IO/fKJeHc/7vqzpCDdOv/Uc7WInJYaSTZrBw7KKUDrSuSmNWZR6b51ExgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987285; c=relaxed/simple;
	bh=gqAN4owr6xSOyZ1XD4+SBBKn2IKtRuM2E1V4f6/L2pU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MG7XORnrkfRSskzAFFsw+yHw3SEZSW09dQkdv1Fi4uvpod+iNd3OilvgDY1ZQbydmjRImsQLy/xYgzyWEWAtqSUAqENrKkMyNmM50uu2Yd6cEhWhGf1NyZrryAJiwdmV7XJyDjwHBYQ2A7+0kQop2gfNWhl23Fob4O1E/R0UW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhGV613M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0589DC4CED3;
	Mon, 23 Dec 2024 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734987285;
	bh=gqAN4owr6xSOyZ1XD4+SBBKn2IKtRuM2E1V4f6/L2pU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IhGV613M9OvJ/Ac77vgz2FBe3pcr/9Z+ckG5voL5qXi1qPsReE2eHRyoLBDIAlAGc
	 KS9E5f5CX1+7hQX8mQjYZznjYWZ1eaL9ykQM4ITgbsZl9+RB0u3alhpu37yYpC/Jyq
	 Rnk5lA8LxHlnKVNwzEoDXT3jh8/SCb1Y2XW/GaXlYeGSQLnZc7yKI5f+BHvSZfrg5T
	 G5ZKKRqmrutfaBqgjbCXnJArn5bvhpIzjWS6NhaMdgJFIPT11hYUJnMXP+Z0TzZPLD
	 snR5do+Rfmx0T3qxuvF54rz29sq2Z0nQyVPN2OHaiMyLdAIq7HZzJzXb3fpBE+cnl2
	 uCXu5LRmKR4NA==
Message-ID: <00f7b2107977797288538249703ea80e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-3-aafbbb245155@collabora.com>
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com> <20241217-clk_bulk_ena_fix-v5-3-aafbbb245155@collabora.com>
Subject: Re: [PATCH v5 3/3] clk: Drop obsolete devm_clk_bulk_get_all_enable() helper
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Date: Mon, 23 Dec 2024 12:54:43 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Cristian Ciocaltea (2024-12-17 13:41:53)
> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> return the number of clocks stored in the clk_bulk_data table referenced
> by the clks argument.  Without knowing the number, it's not possible to
> iterate these clocks when needed, hence the argument is useless and
> could have been simply removed.
>=20
> A new helper devm_clk_bulk_get_all_enabled() has been introduced, which
> is consistent with devm_clk_bulk_get_all() in terms of the returned
> value.
>=20
> Drop the obsolete function since all users switched to the new helper.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Applied to clk-next


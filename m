Return-Path: <linux-pci+bounces-3368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3439851F50
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE0281F3D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269D4C627;
	Mon, 12 Feb 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIG6HQkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F64C61B;
	Mon, 12 Feb 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772474; cv=none; b=IKQ7uJI5Uok5FNvtZBMwhKBh5KZ1ojE+zWWbfpSB+Wr46TkxQcnUR00xs6YN+C/45l0SDVcv1ydfjw5ZNsRkliJeJ9gSMNeUD8CctTlzCu1diFbFowC/A12T3qcl5GEip2ionor50Bi105ZpzysYqLjHPTbYJLJvoCJOuVFYtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772474; c=relaxed/simple;
	bh=80X+hPGUzYEZW/Xn2iZaEatHM4CwENsoX6mZolqSReU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M72f+FnoftC0X3013zx+1ZRnpso9aKTplib+eB87GZdpaz/uWqKXxxswhH2F9Na1vVe7qSwtLpowEbhlstvR8mWz0CTexdubYv4OzNN9rNrflTr5Fi5TUxT6HP2e97vsAmqCtSkgm97Nd+CRqq1HQVxryDTNC55p3bOT2i/aJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIG6HQkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0079CC433F1;
	Mon, 12 Feb 2024 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772474;
	bh=80X+hPGUzYEZW/Xn2iZaEatHM4CwENsoX6mZolqSReU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OIG6HQkDsRFKsaKTH2l9YwvzZafznt0uHVGfr1SwdIJcyaugt3MKWGn0svsqItltv
	 7VwZDijjgSd7Y1MRH977eCCwxc/8eL8zep4G0w9EOgMhQJEu4eNlA5q+nRwqqvYUHi
	 czqMxGqk2rV7SCmIwjxdM4VchMYu5SYm7/xN2b/ubz3A8YLHG9czrs9UcKh+7MpXvv
	 8IH5J/XphPJG8xigphGxf1L1fYP+awTsPTky7yjl6bzbKBe4qK+q+PZspZEPDYLDP9
	 +wEBxYDULXy0mr/K36tIKvVlGXjv6nc7B8qLQz5U2lkKozS3Ulj6z32vko1WkqCfze
	 u1aLQF/m/sgmg==
Date: Mon, 12 Feb 2024 15:14:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 1/3] PCI: qcom: reshuffle reset logic in 2_7_0 .init
Message-ID: <20240212211432.GA1145620@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-topic-8280_pcie-v2-1-1cef4b606883@linaro.org>

Would be nice to have a hint in the subject line about what this does.
Also capitalize to match the others ("PCI: qcom: <Capitalized verb>").

On Sat, Feb 10, 2024 at 06:10:05PM +0100, Konrad Dybcio wrote:
> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
> AUX_CLK will be stuck at 'off'. This has not been an issue so far,
> since the reset is both left de-asserted by the previous boot stages
> and the driver only toggles it briefly in .init.
> 
> As part of the upcoming suspend prodecure however, the reset will be
> held asserted.

s/prodecure/procedure/

> Assert the reset (which may end up being a NOP in some cases) and
> de-assert it back *before* turning on the clocks in preparation for
> introducing RC powerdown and reinitialization.

Bjorn


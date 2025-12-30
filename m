Return-Path: <linux-pci+bounces-43841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D18CE9896
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556A9301B806
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32E1C862E;
	Tue, 30 Dec 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzz78W1l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70313322A;
	Tue, 30 Dec 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094278; cv=none; b=QL3d9NEc9zoGAQsJPA/evQZUxL/dKaI+2Bj6HRsl4Ekz7DLjslJU/WcAJW/ivdU5uvU3mo6znjbA3TpAtxv8Ofq9fzDuzdnELkJ+oGis1yLHgSWqeEX0bKcEU0856iQgT5C73kLCfJx3j+PYOghc84k7qjjcFjat0cl3aLZLLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094278; c=relaxed/simple;
	bh=ejkC56H2S5iESuymhtWNBvnu+CGEka22f7apesNmaVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBJRGk1UoBSLxz0bCkKfD+Jc/hz5qWO7yMBlPlDJjLVt2Ela9t5rCpGiFw8B+8lMLDMnhviQsxFqx6N2iZs179AJz5rCcXhIo1mK/odlXZ/kWjtCo2RfFGojXEv2pDZ7IkIIpCYqoisDOx0QsWZEu3268OqN8n3IRk/nDqV7T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzz78W1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B199DC4CEFB;
	Tue, 30 Dec 2025 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767094277;
	bh=ejkC56H2S5iESuymhtWNBvnu+CGEka22f7apesNmaVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tzz78W1luFSUbJSDiWh50xF9CIlvg8VrZBcaum2mChvCxPSM1enj0dfiGbIyCdUjY
	 rWG2V0z5JAFbp55J4fUNyOlI5jb7r7Dze442ey3wYQXoQaEFFdDq8KMPe89efSyRYa
	 9iZc2bk5w9z/IEWTEp3o5esaXIFbb4I4K7cMEm+Ku4mboxxEu2Fnqjs65KdQ/72EwY
	 iLKH9CVIHtHvX3oLeO0sjtdhZGMNuXTxBj99vfassC6zig88kCwvP2R0cZsWEILerh
	 MpNkoofZTYff72pTGiLVjhzkDh9K76tPZyj/FMHXHjJCy9Vn5pALNzorBY20DPoux3
	 Umqc3ncNyY1xA==
Date: Tue, 30 Dec 2025 12:31:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 0/7] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <aVO3_32KT6HfOUAZ@ryzen>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>

Hello Mani,

On Mon, Dec 29, 2025 at 10:56:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> **NOTE**: With this series, the controller driver may undergo multiple probe
> deferral if the pwrctrl driver was not available during the controller driver
> probe. This is pretty much required to avoid the resource allocation issue. I
> plan to replace probe deferral with blocking wait in the coming days.

It sounds like you want to base that upcoming series on top of this series.

Considering that we are only at -rc3, would it perhaps be a good idea to
wait for you to implement the blocking wait, so that it can be part of
this series, to avoid the additional code churn?


Kind regards,
Niklas


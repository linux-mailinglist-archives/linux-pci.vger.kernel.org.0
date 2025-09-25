Return-Path: <linux-pci+bounces-37004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26003BA0A24
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF901620F3E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45F306B39;
	Thu, 25 Sep 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPr1f0ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D41286D60;
	Thu, 25 Sep 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818179; cv=none; b=U7FsJt3k84RqwoIjQIplz004FAn2hIkkqgGHNv03P8e3cdf0mNexz2kCdPE/VXcw7FEBV5f6VPf1947o2HupnSJ8t2H/6JxsNurSWKMIDuZrYSYPgxu5whM3Mjk4NB9f1tz1aDtcq6QfnBQi/CricIIMq/Y9nWJtemHHVSnJJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818179; c=relaxed/simple;
	bh=0L6PTw09tkpn7NMoAm2UCgyqZ5//fo24GO72PgF664I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xs+X2YLH9F885mfsOmVqE+ZcywBMbk0dzYuZvUTApd+STxH65dYiFCWJPbpNysDbTQNd1aWF/vkN1QH2UFM5BWdXITx0qTwYBS0FjjOzzoEOCFzMa+q+bb8uwQT+k30cAjrxI6WZ+F/EIf1uziaOQiHvkfG4++lHOpYOQc5+W+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPr1f0ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A836C4CEF5;
	Thu, 25 Sep 2025 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818178;
	bh=0L6PTw09tkpn7NMoAm2UCgyqZ5//fo24GO72PgF664I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HPr1f0wsG0NZarVMY7Mw/eE+OpNpmL8Yyx/plyAzaLvK9HxKKwJD9KBkDJztyC63X
	 rOddNyMA6gCEIiu7GgPNUywbb2thxiUgHrlNVNHy+pOXNDy6QMiO4aU34vTTj3ZOKs
	 p43lfaFR/bRh87jfSFLVQ8J40ONxR4yVGvni6qrMqDFL9PmQfBcuJRaXERtiDgxjFJ
	 z7s4cd3HIKGGmNRy1njwa7VVrGGstE7ogxTCS7uLxe0KIp7o15oBfecsKV4SP/2qbr
	 2GpIdkv13MW88ZLKxT/7xLnP6dQI234NXj9g5LwvKuaHrlU6HYy2fH1dmLpmqtR0WZ
	 hVsrFEapggdRQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
References: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] PCI: rcar-gen4: Assure reset occurs before DBI access
Message-Id: <175881817482.390261.3355390363280103413.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:06:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 24 Sep 2025 02:55:45 +0200, Marek Vasut wrote:
> Assure the reset is latched and the core is ready for DBI access.
> On R-Car V4H, the PCIe reset is asynchronized and does not take
> effect immediately, but needs a short time to complete. In case
> DBI access happens in that short time, that access generates an
> SError. Make sure that condition can never happen, read back the
> state of the reset which should turn the asynchronized reset into
> synchronized one, and wait a little over 1ms to add additional
> safety margin.
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-gen4: Assure reset occurs before DBI access
      commit: 1d45d0c80b9e8fd8167e0621146a32eecebd430f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



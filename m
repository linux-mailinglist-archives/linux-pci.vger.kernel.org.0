Return-Path: <linux-pci+bounces-35193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2AB3D279
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E443AD353
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AA24676D;
	Sun, 31 Aug 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCP0TgPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC493594E;
	Sun, 31 Aug 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756639513; cv=none; b=KKPeqzVF9CJ+amDESUxVYP9I4qU89PcX8Vv3XA/SCcVRcyqzvG8JK+qx6ygUeYx3XbgO4p4TZh3DvbEmwQh77oOhrd/Wo9UCxIHK777F2qHM4xYjyltAgOjWh2lg5Svzn59zqjVBshBTniWACw9/XJIEgNeWH6v7qAul6pT21fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756639513; c=relaxed/simple;
	bh=JStuAIPlMtGfKJp2bwD1DKRz7pxXs0A3UVt9pauzxZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=df29MTrmenzVrO7J7bXOY0MRPoQmM50QJbwkHu5YBPM3txFc8KK2La+BmY707VgPxsr5WWPIxhujNQN4ZGBXKDkP9AcXw39zAdR/Z3nIaZZ3j9JN38fX615LAwYWWU+96hczGizZwJG/lonOV/GvwWR5BgZBVKY62083vZQQujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCP0TgPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8318EC4CEED;
	Sun, 31 Aug 2025 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756639512;
	bh=JStuAIPlMtGfKJp2bwD1DKRz7pxXs0A3UVt9pauzxZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eCP0TgPYlXUhLpybuJnnKcnr9qsAqB4cibbV1YF/AUW7IlbFoBAg7hS/B4rh89GPa
	 owH+xc9Tbb9YU69wWWUO0n/92IuYwY9t9VNuNh16PASs7p2r0QQOydx+EIwc9y/gqi
	 DWLjDlwiiDymrL7CQ46173bIJQoC8CtdA6i9H1d1jMYjgLCSSFQHGDmEFQQH31dBE2
	 Y4bNKXSjJiBe77Poyk2md9m3HQ2cplhQn3XSV0QeyKFIUF53LThkk1UzxOKsHAgEl/
	 OX0ggjQ153qIfhgdOSuZn0o/GFosz8u8sDDRAp1b3YX7YueSAPCyNLbn8RGZ8LfuwC
	 ZH/kjYI6wLoRQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: thierry.reding@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com, 
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250819150436.3105973-1-alok.a.tiwari@oracle.com>
References: <20250819150436.3105973-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] PCI: tegra: fix devm_kcalloc argument order for
 port->phys allocation
Message-Id: <175663950907.10641.11353619819769419728.b4-ty@kernel.org>
Date: Sun, 31 Aug 2025 16:55:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 19 Aug 2025 08:04:08 -0700, Alok Tiwari wrote:
> Fix incorrect argument order in devm_kcalloc() when allocating
> port->phys, The original call used sizeof(phy) as the number of
> elements and port->lanes as the element size, which is reversed.
> While this happens to produce the correct total allocation size with
> current pointer size and lane counts, the argument order is wrong.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra: fix devm_kcalloc argument order for port->phys allocation
      commit: b69f898bf94b374a97d367459ff2fb52b4ab8829

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



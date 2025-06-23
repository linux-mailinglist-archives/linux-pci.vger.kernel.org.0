Return-Path: <linux-pci+bounces-30371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21783AE3E97
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A363AAC77
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F768244661;
	Mon, 23 Jun 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/8JD0Pb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C29188CC9;
	Mon, 23 Jun 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679608; cv=none; b=ZwC9Ehs2LRcVxSrCF/whEEtFLgX7EST1zsZqY6aiZFgidPOeWvUxm5Mt4VkA0IMHMZZhYw0nCzzRlPnjmSPLCI+GKjXjNA7ij9izdfCM1aPPw4kI/AXJApHBibvPF5zBbVV29AtH0tq1O1FAz660YImFLHzEUOHday3XwlGT9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679608; c=relaxed/simple;
	bh=l78T6d0rVhac0qoO9WlfEVxu95VKyR0dZVkQUB5NHpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QC0XOzELo9Hinff+yx8ek9RIQPq9BQnpfZO4M9qMjXpsiLxbDJxE0Pr6BhGVs2+pJvFmmS0N7XX9vqdNlWp0UbYoWj0VBQyUlmsz/p1COmQKgn4pxzUreHiXXXvivqJ5qrivW8E2wz8BeLHlzrMZwJhFuRQJwejBHGGBY4eW/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/8JD0Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5CBC4CEEA;
	Mon, 23 Jun 2025 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750679608;
	bh=l78T6d0rVhac0qoO9WlfEVxu95VKyR0dZVkQUB5NHpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/8JD0Pbs7L0ea7UysC1tt6PzIvHh++2KQZ2hHdIqnVHpHgw869d/o8D0gbH4kI/O
	 6MQIN8XGARuX7wtMvvdWunutPAd5DepDIsuWEtHGv5y+Tt2F69URD1eNBgmt9ZMOJg
	 Gb+w//+izsZIhvRar86VkH4/zjcTcu5w/ftthUpVBxefXYrIRnozObtlZ/3p5lZroa
	 iwi3Ev45TeCTh7VhlVyWNrOxGakG8JmD3/61t9W/lJ7+4yGzednGUbGCv/ZvAVWFMb
	 YZF5iFrRFgkTKhnwQy2ouycmWAkSofna7Z199HkIEcxQbBqq5kKSdU15uTlzQpxgmq
	 QW2CBIb5FjsbA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com, 
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org
In-Reply-To: <20250530224035.41886-1-james.quinlan@broadcom.com>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
Subject: Re: [PATCH 0/2] PCI: brcmstb: Use "num-lanes" DT property if
 present
Message-Id: <175067960711.8006.9074251471563711510.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 05:53:27 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 30 May 2025 18:40:31 -0400, Jim Quinlan wrote:
> v2:
>   -- DT bindings: Add default, maximum values for 'num-lanes' (Rob)
>   -- Add 'if' clause to clamp maximum requested num-lanes
> 
> 
> v1: original
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
      commit: dbb1258daf75f2b98e465ba5a0e26073eda6e539
[2/2] PCI: brcmstb: Use "num-lanes" DT property if present
      commit: a364d10ffe361fb34c3838d33604da493045de1e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



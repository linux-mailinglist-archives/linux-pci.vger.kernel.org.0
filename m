Return-Path: <linux-pci+bounces-35282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03ECB3EB50
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A221891EF5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275B217F29;
	Mon,  1 Sep 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5wAI5/Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E032F770;
	Mon,  1 Sep 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741267; cv=none; b=u4L5IWalXiOJr+FW3dCs/nWjxeSJz0Saa4AfmDGRsPGz+4Rdp5oykU/oUmNiykMHqzrdWgRJlXFo62IGSdRN3ourrranHYqGgfqhz0QL0TmaVVrf4U7WKAkf5h/rJQwHGRto9aOkkFg0oJt3KBRRLRxksdqL3gqRNQnhCaElN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741267; c=relaxed/simple;
	bh=kd7FhV0h7tbWfakzhbMWN+hW8grh3fetFbtxrJY2Ng8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Om5P29otJArVsQQriY6XXS9BSUA7LhXZ8T4W6mlgLeRt2mV5aoC54Qd6GjNTW8ywWDsld+HzSdIhXaHk8IrlcB2/39QTuC9U7RNLoK5W6WboKepnY+mLYaN3ODxAizH97y1vIVcU+h2Qtp9IQFJnCoJ3MaP88hjg0tNjnIgHBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5wAI5/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ADEC4CEF0;
	Mon,  1 Sep 2025 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741266;
	bh=kd7FhV0h7tbWfakzhbMWN+hW8grh3fetFbtxrJY2Ng8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B5wAI5/ZAs5y7f0CUJsq/+TTkHDzEYaDJlVtcOCZqjWnBx9JiyaMd32/MHUq4efU2
	 g7+/46Ssz+Z2W7EV9J1XQA8EWD6Ie6oAhT7q1YwdGXgXShtEoiCoxRwL4xOTEJb/zZ
	 4NC3NNX+jAaM8UBkd+FZZDo2hPrtaLxQ+xTSkoxhyzIDL6l/vfHKyyuDdo8fp1uji0
	 CreGVckPlu9eu5wktEiLpRzKr1XbHRtwrlbpIOLfZ5mpkZJEk5bueHPYw17kXCbF4I
	 kvkYmyLvJfbFXnif65s7B5nRXAqDEnXBI5Mv4rCEtoSsGAIyg1NxMnpojyUiMG0Q1I
	 MOjVAa8/+/dgQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, vigneshr@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20250901120359.3410774-1-s-vadapalli@ti.com>
References: <20250901120359.3410774-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix module autoloading
Message-Id: <175674126281.14910.10970925698535914087.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 21:11:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 17:33:55 +0530, Siddharth Vadapalli wrote:
> Commit under Fixes added support to build the driver as a loadable
> module. However, it did not add MODULE_DEVICE_TABLE() which is required
> for autoloading the driver when it is built as a loadable module.
> 
> Fix it.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Fix module autoloading
      commit: 9a7f144e18dc5f037d85a0f0d99524a574331098

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



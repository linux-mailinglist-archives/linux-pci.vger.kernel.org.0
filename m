Return-Path: <linux-pci+bounces-28276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB584AC10C2
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1975501E98
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259E299ABF;
	Thu, 22 May 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv6oG1+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881219F461;
	Thu, 22 May 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930205; cv=none; b=Z13wgW00YmPgXtw7iudy8KX3yGypmHed4UlBXq9o/weWz91XXEXJlSe3kRqSAKFzEA61ejxefT42GgXyj2210nJSsX4igQs2IV5X+ZefTiwmMS0CNpJSvBs3f3IvVOL+aq+71YlzXxLpmB4+ymByKypwcDi/N6TEw6YiaQohhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930205; c=relaxed/simple;
	bh=HXHBF0h6Tl3AILR6V2N+QJABLI/wgChzJ6iTjiDv5mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZOA9Ua9ph5ru/dlQ8HRqc2WJHLjfXio5up3Be/+ftq5nfl7U15tM/ZuTUJ5ov3fg51QjHr2u6owmbALWYnwBW8zpMytpupnscKaAy0t0KKW4bb8lTJZDlvr7r0aE/1sjKw3kNyLIjz+3D2IzxouxdfUPaMO6hhXhWw6H0zZd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv6oG1+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC81C4CEE4;
	Thu, 22 May 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747930204;
	bh=HXHBF0h6Tl3AILR6V2N+QJABLI/wgChzJ6iTjiDv5mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv6oG1+iZY4Fr1HTAALl12wMdGHJPelpHMt+tUTsAozsZjsuIgmskSIQF86m78SPT
	 3H5Pmgp6+JVbyltvmj0/7afRIftF9pUVONE4FXe3zxyjwu9gxQ7UmZ9wVjypm7vy4G
	 6idKRpzh9AhwIkieQ7AuP2bq6lUg3gwwaKS42pNbufTl+1mgOemT+JTLYtmN17kKJs
	 o0lo5GQaosuSzoNdlY3JTF04PU10lcNxxOh9RmXZ1IqqnfKiY5U+xfy71rKcKbfEZ0
	 6OMnXlMocyYb+ERdRu8LZ//VHLBa1n0xhgwO/5XJOolP0p72bnf2Ug1Zkkl2sRJW/i
	 5iC66fbsEw7jg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device if CONFIG_PCI_PWRCTL is not enabled
Date: Thu, 22 May 2025 16:10:00 +0000
Message-ID: <174793004987.85440.5412777644593320433.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522140326.93869-1-manivannan.sadhasivam@linaro.org>
References: <20250522140326.93869-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> For platforms that do not use pwrctrl framework, the existence of the
> pwrctrl platform device will prevent the enumeration of the PCI devices due
> to the devlink dependency. This issue is reported on the systems using the
> pci-brcmstb.c driver, which doesn't use pwrctrl framework and handles the
> endpoint supplies on its own.
> 
> So, skip creating the pwrctrl platform device if the framework is not
> enabled. It is only a temporary solution to the issue. The actual fix would
> be to make pwrctrl framework feature complete (by supporting system PM with
> WOL) and convert the drivers that already support system PM like
> pci-brcmstb.c to use it.
> 
> [...]

Applied to pwrctrl, thank you!

[1/1] PCI/pwrctrl: Skip creating platform device if CONFIG_PCI_PWRCTL is not enabled
      https://git.kernel.org/pci/pci/c/afcae53871ce

	Krzysztof


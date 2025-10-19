Return-Path: <linux-pci+bounces-38665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C697DBEDFB9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 09:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCED3E540C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE341C54AF;
	Sun, 19 Oct 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCknMFhu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913FDDC5;
	Sun, 19 Oct 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859737; cv=none; b=XOs3eGl30InGt0CGxZCr6vLBVIKHXmxY9MOgWHsoLmyXaVzZy+daisHOpl47/+pjHSedCVM9wCXbNEPP4KVFb7Ur+exwlYs3KCFlcrfau0nH2Y0d86MG5Iw2FBTmB/03jqluEE2y4oZNODwBiNkXdgCd2njwny+x/W/WjEbME+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859737; c=relaxed/simple;
	bh=hSgHtBwplvK0PevXZNEtKbSaVBNAyYLZGGvHufkUph8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCqNm3ynLT02wgfb3QUTq3ty2CMVq1Jz2EMzZ/sqo4iNktZ47Gzn/USUBKSumNym/oVn2YHNVRF8oV1zgds4e2Z9Qqy2jDcPlHHATeDokhnNbUXgNWzj/5pzGcgR6kkBfMSRCzEKfbsLOYb33ATv7rYdNRxSWQhwRbOjBuKLtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCknMFhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D3AC4CEE7;
	Sun, 19 Oct 2025 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760859736;
	bh=hSgHtBwplvK0PevXZNEtKbSaVBNAyYLZGGvHufkUph8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCknMFhu1au/d3wARdc+ocTKCj33OXgpJmAh/Om3SkQ6P4lXIgvQPHkHNnSIWHa7I
	 3VFPuEhqEAI9UZvfqzOzS4UvAT1ks1otgWH7YJee1ygmfMoaTmHFOUvk0AwVUr2uqO
	 Kr/kI48P37sbdA+yGL4mmbl2J1ekHM3pLu1zn/GHGI1yJlEVmzkkdA9qOY7MozvYvG
	 1e66Bpok7KmyBtH/txRlrVb8u7S8vbhr0TQWhmhOfgKbSHVWFy45G8A5Q01jqi4MOp
	 kSAYNyBFAAvHVju3gm/VBv9TwZE+Vre1k33CGyaJLFVHXjf///IpEL8Lt2YzU+R13l
	 85kbRoRtVhT2w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
Date: Sun, 19 Oct 2025 13:12:00 +0530
Message-ID: <176085967189.17983.15085915634500867081.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925202738.2202195-1-helgaas@kernel.org>
References: <20250925202738.2202195-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Sep 2025 15:26:46 -0500, Bjorn Helgaas wrote:
> hook_fault_code() is an ARM32-specific API.  Guard it and related code with
> CONFIG_ARM #ifdefs so the driver can be compile tested on other
> architectures.
> 
> 

I've removed the ARM arch dependency from Kconfig and applied the patch, thanks!

[1/1] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
      commit: d2713dfda04ebc824c2c72f225a817e370dfa99f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


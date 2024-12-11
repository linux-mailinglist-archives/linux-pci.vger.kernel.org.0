Return-Path: <linux-pci+bounces-18208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535859EDC31
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6017F1889EA3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A01F8687;
	Wed, 11 Dec 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD7WIMd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBA1F8681;
	Wed, 11 Dec 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960671; cv=none; b=RewO05FJNS0UdeJ3n84/yp22gLnWtVSNLtfbHHwLS7foDbok7wUBSbnZvU8mTo6IoLMpr8uQlz9UCCwcaGC9tvONflNxDXFPp8QHwPblgv51dyVU6/vMJZ+mn6AvxzIGfVKlt4rLoadyzgtjp3z7K/x9L32LY7UvTp/PFriVVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960671; c=relaxed/simple;
	bh=XF9P61tbrgXPRYSJgZFa8PSz3VL+CEz7IiHjAArXliE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br2yTgBeZSXfiCndOo78YiaLihQMsB7jpUwVboClSzLDvzOePbmdTYfkxnz4YzI3QAzzVApoUwDMSb4e7sVSE8TbKpsMswUQ5RUJfVhA1sSfl65d52VhVVz1jAiGuiglLqnvzsgGl2i23gSj6uo1MkdrtY6kQ+FZs/HiAbfnYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD7WIMd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFF2C4CED2;
	Wed, 11 Dec 2024 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733960670;
	bh=XF9P61tbrgXPRYSJgZFa8PSz3VL+CEz7IiHjAArXliE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD7WIMd6OQrM6fvp17ZgAeAaHl0uDSrkJ3ab0jLmlAcWm82fmsLpeKe05y7AYg+MT
	 MPiO/RZfAIUl09DmcJ918y2324irb9BtFvNSJvVQoCI6E3do4s35W7tAU8N7D7N9dA
	 gWDyW2lsqOnOJbwIAPpvLa48tISKv1UHIJ0zulkI92uFrjVGjSsd7+wCuD0IcG+4Hl
	 ly4Q1mOTe952zHhXYkNpM3O2+4kP/yejJn3N008XOYqgzXC909RUNrLz/uNKi6HIR3
	 RSVLipLAoRKsrQ7KrmUY6HiNNwxroIDvFVJFNZaCJXy0j7QRa0VqiKl1WvkZB3obvC
	 gLO3Wpwu4G1YA==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor, Revision
Date: Wed, 11 Dec 2024 23:44:16 +0000
Message-Id: <173395359744.1069392.3564048634010264629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241209222938.3219364-1-helgaas@kernel.org>
References: <20241209222938.3219364-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Dec 2024 16:29:38 -0600, Bjorn Helgaas wrote:
> PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
> Devices from different vendors may advertise a VSEC Capability with the DWC
> RAS DES functionality, but the vendors may assign different VSEC IDs.
> 
> Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
> chosen by the vendor.
> 
> [...]

Thanks, Bjorn, for sorting this out and also to Shuai and Ilkka for
giving it a whirl on their platforms.

Applied to will (for-next/perf), thanks!

[1/1] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor, Revision
      https://git.kernel.org/will/c/b34d605d120f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


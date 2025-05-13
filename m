Return-Path: <linux-pci+bounces-27622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7EDAB4D9A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63161888868
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2E31F237A;
	Tue, 13 May 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYAwYSA9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059F1EB5DB;
	Tue, 13 May 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123472; cv=none; b=E9q87LFMJom7VXvlyeLR86as6t5ov/0DwaiSP/BnaQ50KRkNXFkwajgDm6I6mhse0A1Q67Tj43OCgzAI33riJb4dBwdQ+cwJneBKhvfhdu1LH6I6sCA4E0XBXa7Q1bB9T2z+A5plcaGBumHquRZVdabGHIC284/YevnComz1CSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123472; c=relaxed/simple;
	bh=7I1gwSaGTujG4gf8FypyquviBk2E4QA6iyS8EFE6L6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an7kE+V4IGHh1ZHUtrbVnZ7eOjh+q/DK9nrC00Cv4eUoSpesCNr9RFov+ph9/OWu9flrPXWDnPxUAi4RJJrVgNOiF63bGmj5o8ZGKfknL2dtTbrGZI7M8GvM0jQdfG0E5yKB4aZi8SdNGm7QDDqG//ycSERMMehoiqbie9reUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYAwYSA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131B3C4CEE4;
	Tue, 13 May 2025 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747123472;
	bh=7I1gwSaGTujG4gf8FypyquviBk2E4QA6iyS8EFE6L6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYAwYSA98xROfFniPKW3Fnq8c74xOH7tQB+7DL1Y3zkoNSUZa186JCYkIIk7ybc78
	 7AbBU7MdRy2DIyGDFmaL67xunDbaKOH+e49iBT1rl38dlT7eXLtzI7CwfKdBPKzKMz
	 NYF9WFAsOL28v3+dWBFFLxX7AH9Bc3wffNb3cnv/7RBbOkniVAw03ynnpN42vMcEy4
	 CqQQBhbnGtNA8ZcO3oukS9kXVQWDWe0gJRRikY2FbxSbgUiLCHbKiGxJOAtoGM+GJM
	 tGLoKBIu5QCyByqotji/y2HAziWoVDAk2DJ7knsHN3BZxI/ELVUPPeR4oA351WZ0pU
	 ZlYmsSP8YGZvQ==
Date: Tue, 13 May 2025 10:04:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
Message-ID: <aCL9CStLrGEY2MEH@ryzen>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510155607.390687-2-18255117159@163.com>

On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result is
> uboptimal data transfer efficiency across the PCIe hierarchy.
> 
> During host controller probing phase, when PCIe bus tuning is enabled,
> the implementation now configures root port MPS settings to their
> hardware-supported maximum values. By iterating through bridge devices
> under the root bus and identifying PCIe root ports, each port's MPS is
> set to 128 << pcie_mpss to match the device's maximum supported payload
> size. The Max Read Request Size (MRRS) is subsequently adjusted through
> existing companion logic to maintain compatibility with PCIe
> specifications.
> 
> Explicit initialization at host probing stage ensures consistent PCIe
> topology configuration before downstream devices perform their own MPS
> negotiations. This proactive approach addresses platform-specific
> requirements where controller drivers depend on properly initialized
> root port settings, while maintaining backward compatibility through
> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> utilized without altering existing device negotiation behaviors.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Looks good to me, but since this I'm the one who suggested this specific
implementation, it would be good if someone else could review it as well.

Reviewed-by: Niklas Cassel <cassel@kernel.org>


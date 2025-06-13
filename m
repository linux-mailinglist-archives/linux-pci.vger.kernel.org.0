Return-Path: <linux-pci+bounces-29756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52446AD9298
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 18:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E64188CB9E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9161AD3FA;
	Fri, 13 Jun 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q66O3dTV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572D2E11D0;
	Fri, 13 Jun 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830968; cv=none; b=BRNHyPILhhSUEe3YCGt2jXM0/KRZlEsULbKgm8OR5GaNTZ6mm/l1wNdKI1IrBEDaiVCIkBBUx4CwcgHoJMJDzKf5fs6rZ1epqFQZaTB9/msjZQ79oYX4PDgDg3Smm1MD6oFnLj0fpswNDJx74eXSSbLJcef2LSVd89GM+kJtSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830968; c=relaxed/simple;
	bh=0uQcPfUf/QaYqIILQ0UsYx/TXlP/if/K5oZF6l/9Nk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AZxoWuAG0zS2K03oR/1UkV+kx8OUFPD1tIX5xEaC0VX533MPfnyHjJRoi7saqKBSYDvIDKjI5USUTq0J1EKlKO70JbDIfRhf9hcqxSS2LLK6LiziFIkgAJA5s2puLPjpOOklcLHdOqUo7hMJqEejCjvbv5B0GPdpPgPd7OlVZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q66O3dTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1716C4CEE3;
	Fri, 13 Jun 2025 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830968;
	bh=0uQcPfUf/QaYqIILQ0UsYx/TXlP/if/K5oZF6l/9Nk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q66O3dTVhRbpTqaOMWsrr2u7nzUro4zKOSpfMWQjW2fMWlLtZUgXxKyn2HJtxdCa/
	 1nXZjPYsdMDRwSZmIFhTK9cPqXq1UW9RWQnksydccB6QTZzZatMD9AWeOfDLsyBe2G
	 OJOsMR77rjuqd/VZSgAjm3LrP+bdknLDBRhEQasLdALWWbjS6Uz3j3YlStDmobzVQE
	 l+kF3M4da1mWun0wi5bjWWZLuJYvNCDU5hp1szFeYXQS60Ek/DekIoFSqfRwDhEA+4
	 XVlqGiuSaM2PzYI8drspr/slO8gS24zyriCv0eIWOyDuykeitqB7Ov4/TgPs2JBh+q
	 5RiouWSalOtow==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, 
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20250611104348.192092-16-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-16-jirislaby@kernel.org>
Subject: Re: (subset) [PATCH] pci/controller: Use dev_fwnode()
Message-Id: <174983096525.53497.73284340599924461.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 21:39:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 11 Jun 2025 12:43:44 +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> 
> [...]

Applied, thanks!

[1/1] pci/controller: Use dev_fwnode()
      commit: 91afe85f4b282712231df9061a4528db51ce3c3b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



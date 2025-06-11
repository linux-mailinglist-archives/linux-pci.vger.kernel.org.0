Return-Path: <linux-pci+bounces-29493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B2FAD6036
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 22:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C0D1741FA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5923C8A4;
	Wed, 11 Jun 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIR4E2sB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C71DFF7;
	Wed, 11 Jun 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674414; cv=none; b=qwfyiaQo8YcKCoBu4XGdJcBKP+hJqHgBUORMvAnwInsg+okuMROoX/r2CZ9M2VGw2rj7lM+ztgPAkflNK4Eiv7ttHKucDnwP94nw1SfIwaAz/fzQTX9FZZg5a6MwaU/K7X0340b4Kcp+4Q4I7MVJFRKF2+jIzHnpy3J9m6GgvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674414; c=relaxed/simple;
	bh=mQLKS30Z6vR6WwMjMGflKrh9mxDkr15j29E5YXjDj1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B8zmAzLw/UX2ckInkQDZrcaere/m2/VCIB8RLd5VX359wwR66+3pT4uzzqLzzyVIyhGH0f8/m/A5VJcUoNXVnSPCQ2TLR9jlVTFG9vvYp1BuD5doFNAcPiG0NLxVoXgttdQ6PVbK6ZLzzjCBwtw4y0cbn1Hewl7IY9osyyBOwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIR4E2sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361C2C4CEE3;
	Wed, 11 Jun 2025 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749674413;
	bh=mQLKS30Z6vR6WwMjMGflKrh9mxDkr15j29E5YXjDj1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZIR4E2sBlFOtizgD9NhhRSzSMnCCv5U7vZSPz9d63UN2UUoQVFcgRg87wB5WWwATu
	 NAF+8ekqy1N0i7Dy0Zqb/FFuS8FPiR6Dvj7+VcjV6rByQeMKnyiRhh450uvFvpl18C
	 ks4vfD6t7bX5QHW8yAva+w7y8ja94g2u922G2LrggzpyJ9GoXN9IfMVZFsk+q1UZsZ
	 cJdkaM1o8u7bvZeqXo6dmeWLJBsMMTwkKHGoxTLZCjwQxaoinoAhy54DRcX+TbFhsy
	 eN7yiKCfLZGFGpExTmvSoyJbgwtGg1rIEoOyYcVim6caysk9lqdZl7+G8iL+T0O2oy
	 kPIAKRCOW0lbA==
Date: Wed, 11 Jun 2025 15:40:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
Message-ID: <20250611204011.GA868320@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611163047.860247-1-18255117159@163.com>

On Thu, Jun 12, 2025 at 12:30:47AM +0800, Hans Zhang wrote:
> Register bit manipulation in DesignWare PCIe controllers currently
> uses repetitive read-modify-write sequences across multiple drivers.
> This pattern leads to code duplication and increases maintenance
> complexity as each driver implements similar logic with minor variations.

When you repost this, can you fix whatever is keeping this series from
being threaded?  All the patches should be responses to the 00/13
cover letter.  Don't repost until at least a couple of days have
elapsed and you make non-trivial changes.

My preference is to make the subject lines like:

  PCI: dra7xx: Refactor ...
  PCI: imx6: Refactor ...

etc.  I think including both dwc and dra7xx is overkill.

You can find the prevailing style with:

  git log --no-merges --oneline --pretty=format:"%h (\"%s\")" drivers/pci/controller/dwc

Whoever applies this series can trivially squash patches together if
that seems better.


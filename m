Return-Path: <linux-pci+bounces-28266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89188AC0A2B
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4373A17CC48
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488EC254AF2;
	Thu, 22 May 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx7ujbeO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E613189F3F;
	Thu, 22 May 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911502; cv=none; b=QqkfOS3dRwyjA1ufBPFwzvAfrdkZOZUpyYatUE4YLFoXBeGr9Kvu1M0Odt3LsUey7IgDgSwuFV5uF47Z/OX0kV1IIwoN497IIwlh1q2ylRrpLRK/U5p/xzBeBR45mQVYl+Mff7W0OeO9ZEdLUwN3v3IGcxlB0B41IzX3Hlv74ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911502; c=relaxed/simple;
	bh=PDHSuJeVzaQLbG5Jx/nVIsNqj3Jmhb+WDPT0/4r9BfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o78RBchDOBiZdr5PXhih68ZeLleHDa1ilszST1Sj2JqscIhbVS/FcchhKrldfYYPl90l9yl39p8R0Z6HUb2xnllZW3FtrgbF7Zk1tvyiFbc3IgUoEqJNLVaFbehTfj6ty+qsfCr1YTkgRwR6hMcDg8fqSOUH365b/eXiddPWzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx7ujbeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5BBC4CEE4;
	Thu, 22 May 2025 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747911501;
	bh=PDHSuJeVzaQLbG5Jx/nVIsNqj3Jmhb+WDPT0/4r9BfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dx7ujbeOEtpC0ObXPE5GfsSOt4gzXV/ttJRjWRgkhIWTPbOAYpzgnRXo8jcopm8Ib
	 0PJAM+A0DLbnjy4tl4AEf8x+BDPt92emnMIAw0SHJ0wW3/M8LMQyl2SddNqHhTWSIY
	 85bFqZbXnugUQmbBZofH5tOrEFOnN0sKWyOuXPc/O2gEldiWWfcWX9J7UT81RObOsm
	 7hwk08IE4OeVJbUvhsnyNF4wAUj3BQJ6Co8lYd2rdAW2k30xM0ZYsDRVIY/dXiLNvx
	 2/cPmPI/x95vYLap2gDKGl/s7F8Wxrf8u2c0aY3SR3DIBnGnjzaVi7bkgPtBZS3xWK
	 P3JUEnS/MMoMQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove forgotten function prototype
Date: Thu, 22 May 2025 10:58:18 +0000
Message-ID: <174791142570.69774.3694250973468244165.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522084626.150148-2-phasta@kernel.org>
References: <20250522084626.150148-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> The subsystem-internal header pci.h still contains the function
> prototype of pcim_intx(), which has since been made public in the global
> header.
> 
> Remove the redundant function prototype.
> 
> 
> [...]

Applied to devres, thank you!

[1/1] PCI: Remove forgotten function prototype
      https://git.kernel.org/pci/pci/c/dfc970ad6197

	Krzysztof


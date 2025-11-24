Return-Path: <linux-pci+bounces-42001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91010C82E5F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 00:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D64C3AED1D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63D272E42;
	Mon, 24 Nov 2025 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCqPxFmi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676221C167
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028743; cv=none; b=Dq19VCAR83W1hckZyX2dKH2OwB+VnwFvqsQKx1Dgy45JC6VZ/JkTiWDwRI/L0ogxZ+tqbkj1zTctYJ1r1avbOELXQ7JZUYAJceLCi1Nabzy6UNBn/cLeP4jrRyWlVa7oikHGEnhjDn822l1kkZkztnMDFhA8Q7FQGjfOl8Bj+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028743; c=relaxed/simple;
	bh=/bAWUZqgC1V8WvcTEXJ36gMe3pTV0ex87M5UfpsIVyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TNzZNOSSsrvQsxfAqi6zRQ2EuVnS+SyYykgNzdtEDFnTUuFP+lnSPw0fgGMClvbk3r0KXVoFSg4IRumrD6ASfzOR5myyLpx1jDODVCMUJy4Olt+qY5qXGnAo5JuTrklRor4Ffq4iRo2mdh+4UFbhVe3zdGwiMaks/BB5kfDNxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCqPxFmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41574C4CEF1;
	Mon, 24 Nov 2025 23:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764028739;
	bh=/bAWUZqgC1V8WvcTEXJ36gMe3pTV0ex87M5UfpsIVyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hCqPxFmiquqn6M6UYBbPj+YliHZTuBDCAcX7hGuupTSRGnRERFhCn3VmGkcbvAUeE
	 fEmoKEueSDTvIMQweKpMSUvZZaB5XypAnkxOd/yD4pUcThpazcYyq985LnJ47/QASp
	 OybxpJCMz/u4cqgypXwwK/FPQmMbUN5o/VsqbQ5GXeygEZpi3klASGCPsJwtfgNjNT
	 bddldd/a0nocRLXkPvkiUNWH99XHP6dOP4e7JKHpCrlcFM3B8YTYWaW5G6u994mRf/
	 yKB574uByT+2rKas1fc5bZuLKWlYC4Teb1CQkMcs2to2e75kgpO2yb1vkbF6N9UfAq
	 PkuqUTr2O0Efg==
Date: Mon, 24 Nov 2025 17:58:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kanie@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <20251124235858.GA2726643@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>

On Mon, Nov 24, 2025 at 06:45:02PM +0800, Guanghui Feng wrote:
> When executing a PCIe secondary bus reset, all downstream switches and
> endpoints will generate reset events. Simultaneously, all PCIe links
> will undergo retraining, and each link will independently re-execute the
> LTSSM state machine training. Therefore, after executing the SBR, it is
> necessary to wait for all downstream links and devices to complete
> recovery. Otherwise, after the SBR returns, accessing devices with some
> links or endpoints not yet fully recovered may result in driver errors,
> or even trigger device offline issues.

I guess this solves a problem you have observed?

Are there any specific details you can share that would help
illustrate the problem?  E.g., cases where we do a Secondary Bus
Reset, then access a downstream device too early, and an error
happens?

Bjorn


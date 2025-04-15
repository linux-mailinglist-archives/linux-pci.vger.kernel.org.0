Return-Path: <linux-pci+bounces-25894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF4A89058
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 02:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC7D3B0E4C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAC1361;
	Tue, 15 Apr 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1TZaI6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D01F5E6
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675914; cv=none; b=oPLD7cz10SY9+Me5xRmgnP3Xgp9f9KT4YAZKHFMxbR4FsBz44dq3QoO4/sj0MDJxT6wvu3w1uv7K3nklB4Ilt1dcZqnZBYSVwWF9cdk9eT/ITsR6b9iEv/v1S9aokkla467KemXMgrXNnOsFDFcMeFtDtVCFSrqmMQVFLZESQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675914; c=relaxed/simple;
	bh=N/dTTvr4XBwBHfrcFuRetb080XCRuieFdCPw7x59B/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhgdhaI7ihJ+OOmkG5MKq5xl/A3dnIYDhvaGoxPdrEzxIR9cP/vuqvsgYsLtDsPmMJTeeVqaAIXWUFeOIytrDMjQcr8HTOaUU0rYhZFYexuZAWAPq08pcclXMlhTrVpzW/uLmsMPsUirmM6OTk1YMgPtWjheKzWfu6ebRuEfa34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1TZaI6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CDC4CEE2;
	Tue, 15 Apr 2025 00:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744675913;
	bh=N/dTTvr4XBwBHfrcFuRetb080XCRuieFdCPw7x59B/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1TZaI6XpOlWirlNB0pEgqjVMrhzUn01UoI0mR445NOR0ibgePyMR35ucSbXiCsOB
	 h+uf2GQLAnuMnFByX65SsQ8KcQg9eArSMPYHexxFr3yOw1SzZ340vhhKrBrOUBzM7d
	 HrLYIZMx9pnzpUoywndAPEBwv0ZcXrOgLrEidP5396X71L/04B/6pGYj98dHFyVM6z
	 sz2faEWCaQU1+bac6Nh47G0OdUz9fL5TRaTug/gn1CJZzKWlUeWh5Q2JrHZln7zsfO
	 npv35kYKmTxQlYvmzuIHBA7Hv0kgMowGhoSKMxvbb2uWHdYepP04Kb9E59BVNGTgZm
	 WHb5teFPPr3Qw==
Date: Mon, 14 Apr 2025 18:11:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
References: <20250218165444.2406119-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218165444.2406119-1-kbusch@meta.com>

On Tue, Feb 18, 2025 at 08:54:44AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The spec does not provide any upper limit to how long a device may
> return Request Retry Status. It just says "Some devices require a
> lengthy self-initialization sequence to complete". The kernel
> arbitrarily chose 60 seconds since that really ought to be enough. But
> there are devices where this turns out not to be enough.
> 
> Since any timeout choice would be arbitrary, and 60 seconds is generally
> more than enough for the majority of hardware, let's make this a
> parameter so an admin can adjust it specifically to their needs if the
> default timeout isn't appropriate.

This patch is trying to address timings that have no spec defined
behavior, so making it user tunable sounds just more reasonable than a
kernel define. If we're not considering upstream options to make this
tunable, I think we have no choice but to continue with bespoke
out-of-tree solutions.


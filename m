Return-Path: <linux-pci+bounces-29465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED9AD5C21
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB5018838BF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959AB1B0F19;
	Wed, 11 Jun 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omrS4B5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230DDF49
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659348; cv=none; b=IyUJpcBrJimQH31e2tvJj1l/eBZ9ooJ/MCGeiES8+BLzZM7kGjASRvwZ1l26mUoY9oatEzKrUa2P41lQ+EZVWd9sE+G3AL0Zg+CYxSFktyjHEuEIdGXrLXUpJ3itc+BWIA32q9DsE0WCQXxjRMoIBRC5YFQVodmtbMbCcTjBqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659348; c=relaxed/simple;
	bh=ckRdOM7OKrbOFNiboHlXTgskhStWd1gn0sUvPv3sOAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7JAD/avpnMv8N8dXyhGuvlaUvk4arsbUIUkmybGj/l4PVZQo1JffObesbdJU2LLj0JJwaw5iVYzBBeV00FpuqD7JEzxuvUSEWla/A3gStpu3Ep7fmBtkoEUDsE+ioXc7RLv7TUmkdPqro7SB/oEpp9F4yeXFPs+Q7vsrvciAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omrS4B5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929F1C4CEEA;
	Wed, 11 Jun 2025 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659348;
	bh=ckRdOM7OKrbOFNiboHlXTgskhStWd1gn0sUvPv3sOAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omrS4B5jzkrO1RWyNLscgOmTfQwAC6a9jto/WTZR2zZ5CKe4BwBCzJwxirvvs11dg
	 AuqdalAfnc+u/S/ZziMQcdSJnnE88qtSIkwvHRQV0o6fZfJOuyUfMX6aVr2Pmd7LgG
	 HKH35HABH2ENvvvvHIsV9AN02qJtyWzlqt7ZgVJCvuEnPovn8bFrm9tpXK34ddy1BV
	 IWd/xUOS6A9mMTfH2W45z2x8bfosLVAGwCjeG4HnBYRZGSlf+gfavgAINeCU8SMTrN
	 //4Y3QAgnU31Ker9y21g+umMsXZtNX9X4U+9IdckpuDxgcqKaPHwjWuW3puzhqc7xy
	 OmUiMHntHKOIw==
Date: Wed, 11 Jun 2025 21:58:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>
References: <20250218165444.2406119-1-kbusch@meta.com>
 <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>

On Mon, Apr 14, 2025 at 06:11:44PM -0600, Keith Busch wrote:
> On Tue, Feb 18, 2025 at 08:54:44AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The spec does not provide any upper limit to how long a device may
> > return Request Retry Status. It just says "Some devices require a
> > lengthy self-initialization sequence to complete". The kernel
> > arbitrarily chose 60 seconds since that really ought to be enough. But
> > there are devices where this turns out not to be enough.
> > 
> > Since any timeout choice would be arbitrary, and 60 seconds is generally
> > more than enough for the majority of hardware, let's make this a
> > parameter so an admin can adjust it specifically to their needs if the
> > default timeout isn't appropriate.
> 
> This patch is trying to address timings that have no spec defined
> behavior, so making it user tunable sounds just more reasonable than a
> kernel define. If we're not considering upstream options to make this
> tunable, I think we have no choice but to continue with bespoke
> out-of-tree solutions.

Do we know the list of devices exhibiting this pattern? And does the time limit
is deterministic? I'm just trying to see if it is possible to add quirks for
those devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


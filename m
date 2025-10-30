Return-Path: <linux-pci+bounces-39864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F46C228C2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C13A3F91
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411FB33A010;
	Thu, 30 Oct 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLSa9hrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8025DD0C;
	Thu, 30 Oct 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863004; cv=none; b=joic9dWvaw/Bw6CmUnl+iU1Muer4sB6vwW+/NfyRrfweDqWYkwotSkDjTAyZ+eWX+zx0tpGJQGvmw9CfTthq3V0j1vEvPvLjTLpp0FFWxOR/cTCO+BEFPRneAgF57A4Tp4l4xgVJ14DizGCHL74d8JRDTG9wjB+2zhXL0+Q/Lcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863004; c=relaxed/simple;
	bh=xG2I5vm7TB6tFU8dWnjN4R78M2qniumUpAN/EjStLCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AGh+nMRh6yzBu7ucfmZm2RSyyI+1xdd4ZE0Lsmnkv9sJidbvbRYBbdctjPv32Dme/2fKCDuyLCzSdVVzSUnEbb2PKc2z32DldyTt+QT7mJmMwwqnTYuXUk4rMpLJGluGdWKyrqsvoSPYmsz2mLjZ2s7Q+bgsmHz0SLt9KcwkH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLSa9hrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8094EC4CEF1;
	Thu, 30 Oct 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863003;
	bh=xG2I5vm7TB6tFU8dWnjN4R78M2qniumUpAN/EjStLCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hLSa9hrG5NYgAOb4NMZteW6MCeCMDiv16bI7WfM/rJn+8HmT3QshvlFe+usWRQL5t
	 y00Y/99kynsQc9bvWby5278iQhsbjqWf6SvmLiS1caiX1MbmzVCyx4HI8DsAd6WlJj
	 zsnozS+yFlmdFc1WIZ5UWwCRoQNrgG4Ze91AxD4QQA6kgdZHJth56IjJiWFBNg1Bpp
	 JHxqb3kSadWXm1h8+/BwsjnwLg5PiF935ggyvqVjxGdWUMUhQ50ZwYwQ+oU3Q/orsz
	 WbS0ypWR6zonFoDssFC/wQIMSU+xEPXJs/B9X42zwrqEqBw6mlOcXSVddO177Nyc/g
	 h5GNNjGJzeFkg==
Date: Thu, 30 Oct 2025 17:23:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Genes Lists <lists@sapience.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <20251030222322.GA1656973@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>

On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > Mainline fails to boot - 6.17.1 works fine.
> > > Same kernel on an older laptop without any nvme works just fine.
> ...

> Bisect landed here. (cc linux-pci@vger.kernel.org)
> 
> 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains

#regzbot report: https://lore.kernel.org/r/4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com
#regzbot introduced: 54f45a30c0d0
#regzbot fix: e433110eb5bf

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()")


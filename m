Return-Path: <linux-pci+bounces-38472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39892BE8DFC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A7E5E67FF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD8350D6D;
	Fri, 17 Oct 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN9I5qZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484034AAE7;
	Fri, 17 Oct 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707929; cv=none; b=golGQdIyZ9/1K/J5ojWNE84t8fFKf+/8brzY/lFp24Kbsgn2ciq9rgb9TIREg7d+VlZGXug6T4owMHmTNevP6PPSwE+Xhsg6xXZcn67sVyX9i1YsUD2JEq8dQO3aJlOQV/Ap6XonDAjyT3gyqfEOpfsyPBkCxDjehH+HxZiQpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707929; c=relaxed/simple;
	bh=BuEqEG9VLaaFzTv+H5CiZPe9UFuAeFbnOVea+VPT9GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jydGaKpyef6ZImYXCq0rFhsCqSbSC/3xnuGhZCSfgMnk9F1FR9AuZkVVGmZxOrTek+bJJ1A9O+FuL4NP9y5Z0tsH5jsTuPD4jorfOkbxsg6WOv4TlKSutrMIRz4O3VFLSLts4USl0ou4TSpYaSQmVaD3U1RWDmhlgwp9XtDHRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN9I5qZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD93FC4CEF9;
	Fri, 17 Oct 2025 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760707928;
	bh=BuEqEG9VLaaFzTv+H5CiZPe9UFuAeFbnOVea+VPT9GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VN9I5qZHyH1tOlZ4LItFFmJeHawQRsBnpHeiFAymDB+n4BnQ6UsZxB0xG59SXN+AW
	 ed1DBRDBYg47ERuJ9najxfQN4BhwrLIHfAWt9DJgfxtGeghmxrsxZExB/+SD5FjJbm
	 YxFuW3L9u//72t1tqt26vCoUqn/sWZGqXHb0n9SuGM2P3SadSKoMtpMmu6F7DBw0kI
	 ReFRDnIDofZscffoRJ3FiBKvmuQielPxwzlG01iapVcMMzaBl1uElTI+MIK07nuuq0
	 s0nDRNzwl/rF/nsTvZ63l+e5rQpNBuLepfmqbCV2eGNq/W2ZViO0Ua5eiUMJYjeQCQ
	 E6zGHDa8zOK/w==
Date: Fri, 17 Oct 2025 08:32:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SGVydsOpIEQu?= <herve@dxcv.net>
Cc: bhelgaas@google.com, dlan@gentoo.org, inochiama@gmail.com,
	jonathan.derrick@linux.dev, kenny@panix.com, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lists@sapience.com, looong.bin@gmail.com, lpieralisi@kernel.org,
	mani@kernel.org, nirmal.patel@linux.intel.com, robh@kernel.org,
	socketcan@hartkopp.net, tglx@linutronix.de, todd.e.brandt@intel.com,
	unicorn_wang@outlook.com
Subject: Re: [PATCH] PCI: vmd: override irq_startup()/irq_shutdown() in
 vmd_init_dev_msi_info()
Message-ID: <20251017133207.GA1027444@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017072954.6978-1-herve@dxcv.net>

On Fri, Oct 17, 2025 at 09:29:52AM +0200, Hervé D. wrote:
> Hello,
> 
> I've tested the patch on a clean 6.17.3 tree, seems booting and running properly on my debian13 system.
> 
> you can include theses on the patch
> Reported-by: Hervé <herve@dxcv.net>
> Tested-by: Hervé <herve@dxcv.net>

Thank you!  Added to the commit, should appear in v6.18-rc2.


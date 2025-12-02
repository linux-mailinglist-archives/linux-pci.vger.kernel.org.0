Return-Path: <linux-pci+bounces-42509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528DC9C4A6
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A63A17B0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AA25EFB6;
	Tue,  2 Dec 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj15h/jn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C92561AB
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694310; cv=none; b=iXQYubtGtWKcQgxdzTFusTagwtejtjALqVqSEZPDlqb1xYZ6hOagyLxm6eA5+aTVgK0nFF/jwWBwJEc380/PcqEukIYOM0L0mfpD63hXuORgvyWJt8GbouBYqZddx2hMww3mcdXvwY9h3syprhqj8eFFiTHgtxDb9WmZjokhrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694310; c=relaxed/simple;
	bh=4UYdVImz+wG/bJthYQ6i1jyCeF187m2C6dYC+3ZxVgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KhTb9KjE8uBb/yWgJqomp4zK0SumnV33dFZ5Qrn0CKN/iPt77cDppgg3uuBAbDp109PFffKf0DE+KgZUlYDbWjf+iXExw4XHZiu/IC6U6PPB89ncmzcc88hXdgEwoUySIOg7AYgzkvMnFb5fzw6NFkPGg11WmV7uqsKdY8AubTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj15h/jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE9C4CEF1;
	Tue,  2 Dec 2025 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764694310;
	bh=4UYdVImz+wG/bJthYQ6i1jyCeF187m2C6dYC+3ZxVgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lj15h/jnEH1n+5CrGFIcYAizWQ/ga4rhEuUq5D/OxOdMG0Ob75GDZ+9UFaJQdrqD4
	 XuzaxfgeKrPtWEF3o2wbncNosKeecW+SMsobu2CKDYjn3FmyfzSO9b1/uHkzA5xcL1
	 VjcYYpdTJ1oaK25Hlc4qaTwg7c1ezsCbEo2lFvxxCXYOf2TGiJN81NGKUjOTA2IMh2
	 wgmr9xutM5TYSZDruch6i0dziQbg+TFqZ/VGRRKtfEisMzN2cSuYipXchLrHeG8pyX
	 UL30cV2bbvZh+0r+rPe6WDJTaR6QqDPzTfvFmathVKxdCQ6zhGdtTpR/xv3/ewWI1t
	 eOVGMnihl7dWg==
Date: Tue, 2 Dec 2025 10:51:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: bhelgaas@google.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, alikernel-developer@linux.alibaba.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 v4 1/1] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <20251202165149.GA3077343@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202164900.GA3077274@bhelgaas>

[+cc Lukas (please always cc people who have commented on previous
iterations of your patch)]

On Tue, Dec 02, 2025 at 10:49:01AM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 02, 2025 at 12:32:07PM +0800, Guanghui Feng wrote:
> > When executing a PCIe secondary bus reset, all downstream switches and
> > endpoints will generate reset events. Simultaneously, all PCIe links
> > will undergo retraining, and each link will independently re-execute the
> > LTSSM state machine training. Therefore, after executing the SBR, it is
> > necessary to wait for all downstream links and devices to complete
> > recovery. Otherwise, after the SBR returns, accessing devices with some
> > links or endpoints not yet fully recovered may result in driver errors,
> > or even trigger device offline issues.
> > 
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> Can you please supply the lspci information Lukas requested here?
> https://lore.kernel.org/r/aS1oArFHeo9FAuv-@wunner.de
> 
> Also, if there is language in the PCIe spec you can cite here about
> the need to independently wait for each device, that would be useful.
> 
> Bjorn


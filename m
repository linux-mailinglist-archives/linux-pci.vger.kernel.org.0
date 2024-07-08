Return-Path: <linux-pci+bounces-9964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33092A99D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BA1B21898
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90A14A4D4;
	Mon,  8 Jul 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDhx8NJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CD7D07E;
	Mon,  8 Jul 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466017; cv=none; b=fXMxZchW+FmYh1I5naS8snu3P88dcSGBWyH/sS2Vvx50+ljH0Pep6+BVcZMqF8GHMc+w9U9cu/gOjG4EWw9d8qN6VcXAhA5G3kXqsUXG+g+7FvEkvibLnuEqXvUvfFYMyh8HOmXd25rlU8WIC0SmCAH2XQ+b1gC6Mue/Op8JkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466017; c=relaxed/simple;
	bh=nizOjn5+V1A/82KeFshXPXn6MYyfeMgzRxMbO+ZmUtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ginuwegki1reRpTC1WpWkY4K82spR1dCaKD9qwA0Sw4+SFB8weDjMDRf8ioyWz9mBsHM7EJnTMJLpz5LeyybMiBhgbuEFpvude2sT56EH2+Z1Ses2lUMsdPiF/UqgTsC8U0iwmsU9J6sCVdAJpX/m2Ya31D0niqz3hZ1tYgGshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDhx8NJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D978C116B1;
	Mon,  8 Jul 2024 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466016;
	bh=nizOjn5+V1A/82KeFshXPXn6MYyfeMgzRxMbO+ZmUtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KDhx8NJWseQrF2Jxned2G+7OqXzBdp+q1vFpE33jl3sCQ1k8WPpSy9m4Z1OCxeTbz
	 1YdiZngXq+21zSY1I1jvGhi1qNfghAExqedZM50jxcxU2FwzvmUlLIsawFt5kG/2j9
	 uEOurQr40WdpLUtDtmV88+dRtwZQ8jFlcWiBZkfqEx6qclF31Rllyg46e4Ht0cjGGn
	 c0z/yusaDDK0D55NpjT1QhysQVlLBKpM8sfXJW+PT+VVT+G7I5aAbU0m2ak6xASH04
	 L9ptRpU2DLuRmS8cIaXNaX3NOUpRPftm1flFJKzORhUaIIcw9pfPsCTdXf8USljlpa
	 vU4MKBFrDM9Rw==
Date: Mon, 8 Jul 2024 14:13:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708191328.GA144620@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>

On Sun, Jul 07, 2024 at 08:38:28PM +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

I didn't trace all the history of this patch so I don't know whether
it's in or out.  If it hasn't been applied yet or will be revised, run
"git log --oneline drivers/pci/bus.c" and match the style, e.g.,

  PCI/pwrctl: Call of_platform_populate() only when CONFIG_OF enabled

This would also match the 8fb18619d910 subject so it's more obvious
they are connected.

Bjorn


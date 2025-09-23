Return-Path: <linux-pci+bounces-36776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A80B960EE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6D73AF86C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330614A0BC;
	Tue, 23 Sep 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxQ7VDKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331928834;
	Tue, 23 Sep 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635206; cv=none; b=FnOsG0k7gigigMyg2o9T/5DumeAt5fipSfr4fLyscjOGnWs/txQkbArcSed67BM0MKF5Jblk14tnfXyQ4jeE9IHMN0Zv7zjUY+gLJZ+9AoP40g9ox8c8fcAhXv8UMYifrd1fQZE8h0bjnfx7tndtjHd5hCb4zVzxd9v7NghowxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635206; c=relaxed/simple;
	bh=FO1IaZWhYXzPZ1kV2cp8Kfr5N2is+biotDlknM0E+x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s17W0auMCsDBZ9Gf30onuvlijMVivcuoL4zziFI6JXKhOY3Q6JrJt9kqPR1JU+4h+QQlU5XrGF0Ey3GksawxA7TKwYSLaHAlKGqlrwIzBZFffMUD4TqI2hKa2euTfm6NvuhKjPSRBLo2RKRDRSOU09Vzhq+hRYk9ar1iYY0HS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxQ7VDKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C0DC4CEF5;
	Tue, 23 Sep 2025 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635205;
	bh=FO1IaZWhYXzPZ1kV2cp8Kfr5N2is+biotDlknM0E+x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxQ7VDKfAzJIYa13xErJ+FpKQkM0PJmDHnphGd9CMCFROVxi8kNFAWh/WESrHULj8
	 VLgqHBFIBpQXCtb/GASS4fKMOjmBwZRD7wACS7+FLfDx2ytcroOdgLi/XLulEJQ7NA
	 eNLCLXjkrcFO4s0XZFhspPWr/XwYMMrWpNf12Cwy0wyvAWs1hrhZHgSbO1wapC2gpT
	 4W/lMZbVbEYoyuQoOrhA7kGpyuDXmTm0Ft5mrMqqZvR1kv9x+VF9ILnrRUcYFHInJt
	 uHe+M9HvRIDEV+RyIx9VqgjQDSF4y7mjWkxmTEowB9J7dXKXY2UNJoe3h5D6fiEAoh
	 cpGKGLsVB4rKg==
Date: Tue, 23 Sep 2025 15:46:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: David Bremner <david@tethera.net>
Cc: devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org,
	bhelgaas@google.com, heiko@sntech.de,
	krishna.chundru@oss.qualcomm.com, kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org, lukas@wunner.de, mahesh@linux.ibm.com,
	mani@kernel.org, manivannan.sadhasivam@oss.qualcomm.com,
	oohall@gmail.com, p.zabel@pengutronix.de, robh@kernel.org,
	wilfred.mallawa@wdc.com, will@kernel.org
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <aNKkI00EAJb8LD9S@fedora>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <87ldm548u2.fsf@tethera.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldm548u2.fsf@tethera.net>

Hello David,

On Tue, Sep 23, 2025 at 10:06:13AM -0300, David Bremner wrote:
> 
> I have been testing this series on the 6.17 pre-releases, lightly
> patched by the collabora [1] and mnt-reform [2] teams. I have been testing
> on bare hardware, on MNT Research's pocket-reform product. I'm afraid I
> can only offer CI level feedback, but in case it helps
> 
> 1) The series now applies cleanly onto collabora's rockchip-devel branch
> 2) The resulting kernel boots and runs OK.
> 3) the resulting kernel still fails the "platform" pm_test [3] with
>  "rockchip-dw-pcie a40c00000.pcie: Phy link never came up"
> 
> Of course there could be other reasons for (3), I don't know that much
> about it.

I don't think this driver has support for hibernate in upstream.

Did you try forward porting this patch:
https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/

Also, have you tried the downstream driver?
If it is working there, perhaps you could try to isolate the changes
that make it work there.

Otherwise, I would recommend you to reach out to author of the patch
above ask for support.


Kind regards,
Niklas


Return-Path: <linux-pci+bounces-44877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F8D21A23
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4BFD30060C1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42C357A31;
	Wed, 14 Jan 2026 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czDpH+3v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF53AEF51;
	Wed, 14 Jan 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430443; cv=none; b=mwU3DD6hpHPWjJzqob3F/m9lBG5WzW3G6mg1DLmqMVP8dLTMJbrmEe/2FmrWTAQZFae4NRXT0T+5oeOirq+bv/BJYRljlHMApTANUyM6m/1rZh4yNOmcx8MaNR3iLHCTe3CT5n0S3Lu7/8PCS7onXFog2a6FM3j1UeDthOejGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430443; c=relaxed/simple;
	bh=5ES8bEMKNj3Ib/nnpA6GUX5TcpIIhEFS6A05uogh01A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rdtw3GlcCAKytn6KfI463FwU9CqyOyxAYGOhNH8vGxi91Fi48E7oE9M9w0foSbhMW29RMMzlb5c0VigXnmq6oSAATnbxWriAbtRIcEogSkieBnPxhr3U/umw91u6/Wr/IIhLzQaPZ+jvesvJ2+taEzrPzB5ZjGqen6dc9jgpFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czDpH+3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C18C4CEF7;
	Wed, 14 Jan 2026 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768430442;
	bh=5ES8bEMKNj3Ib/nnpA6GUX5TcpIIhEFS6A05uogh01A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=czDpH+3verLeY51lPxTi7poZJvwjMZjysGesQxJu5aCMUT9QRTTq/9zuSnyfsE+we
	 k4esnpXLgDbnfcYBw6hNZo12CBUE+vBreIpVhio9f8ES79GZPue+HWJRhgAD/+w1dB
	 QfJZE2oKi7OfGfrTBVmSHcdAeX0kSe8iexef5mHdI34oNqCY3nHMIZoOaMy/c6Aw3m
	 573usHQ7b+PXCQ/+D6QPFk4FXwLS26W1Hg+WEI8A8GxqmWpOlvKc+k5ZmjA4M1+hzc
	 2cLz5nChLdj89EGJUQ6nAR+oRNHh9v+cGPw4YSlSnvFQTZOnccdsVu9jzPWr0B+ryI
	 IovLKYk9dtWUg==
Date: Wed, 14 Jan 2026 16:40:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
	krzk+dt@kernel.org, robh@kernel.org, bhelgaas@google.com,
	conor+dt@kernel.org, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Subject: Re: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuration
 and initialization callbacks
Message-ID: <20260114224041.GA838614@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114153337.46765-10-john.madieu.xa@bp.renesas.com>

On Wed, Jan 14, 2026 at 04:33:30PM +0100, John Madieu wrote:
> Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
> to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> reset framework with dedicated reset lines, other SoC variants like RZ/G3E
> control configuration resets through PCIe AXI registers.
> 
> As Linux reset bulk API gracefully handles optional NULL reset lines
> (num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
> reset framework when reset lines are available, while custom callbacks
> are only invoked when provided.
> 
> This provides a balanced pattern where:
> - RZ/G3S: Uses reset framework only, no callbacks needed
> - RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit
> - In addition to that, RZ/G3E requires explicit cfg reset and clok turned off
>   to put the PCIe IP in a known state.

s/clok/clock/


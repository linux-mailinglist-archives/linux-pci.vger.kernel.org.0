Return-Path: <linux-pci+bounces-34629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A265DB32E02
	for <lists+linux-pci@lfdr.de>; Sun, 24 Aug 2025 09:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A91B280AC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Aug 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF181245021;
	Sun, 24 Aug 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLBsysUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31417A31B;
	Sun, 24 Aug 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021375; cv=none; b=lPKwV2EhKB5ccyS6kt3PdGWLfcB/zHUVdxlAWnG7um2g/Lgb9wpqwhIDcJhWWBJLOY8bhmaUZeXNFMFZzlhrXzy4c0KbuciB9DgdUjpcWijHW43oQtPTqks6pY/l8uPJmY23OLQgT/R0D+hXPRYKwULkFCEH71LKkAPZbuYtBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021375; c=relaxed/simple;
	bh=QHQcKCwQEjDTksAQ4PHYojdmYvMup5UJgKW3z2KPdNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3d5pbaHZnQ5N5IFdREf+Q2VQLKv9Nqvy+QKrC87v3FQGp9y2YapEmtDkZdzUF++XZoF5h8AilhHdWJSFUjl4wfIjBbGqibxhSW/hGY0lsuMEm0raNvFMH7qhNcjshdWrQ3PmtwzzYwk/vW0dnzL3N8lMPfDM4cfXanDG3ayGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLBsysUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3A7C4CEEB;
	Sun, 24 Aug 2025 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756021375;
	bh=QHQcKCwQEjDTksAQ4PHYojdmYvMup5UJgKW3z2KPdNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLBsysUp7pIvrQzQFnkBVz2soSqLY5115ovNpxDnKCvMPs2DC/B1TeZs/94MPqTnV
	 KMCaM3mhYtliSc01guM+nIA59HCzZfruZYjmAHjqPaMArDD74rWjboPq0fddA/t99F
	 yCTLkzMQ9So3cOvxJxe5A4bp6I9XOSSAKVw1qXp3S32oY0tpMu6lbdeLYuFF7mHmW8
	 AaQJGA/2qBag3rIrfbqrEqNSqmZfPTu/cgcdAIiKhschKK3d42c9ydDKfekXQWmV12
	 19elIJ4x02lqQBF4qyiX+nXJ73RnUlmISc4DX8WBzpLufyHDVRqatj0nm4KsKNKkd0
	 qMpSi7o0j/PwA==
From: William Breathitt Gray <wbg@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/3] gpio: vortex: add new GPIO device driver
Date: Sun, 24 Aug 2025 16:42:39 +0900
Message-ID: <20250824074243.416291-1-wbg@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822135816.739582-3-marcos@orca.pet>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=wbg@kernel.org; h=from:subject; bh=QHQcKCwQEjDTksAQ4PHYojdmYvMup5UJgKW3z2KPdNQ=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmrDmUZTP1ffiFCPb2c/X3XPnll3X/dLJ76y6c5P6/lW mi9ZKpyRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRydsZGf59i11frhQTfG37 00AGyda9U4xKP8/qnbozrLTwqOUvmwRGhsWyPyJ0f3MyahQnHpY9cmPztrsP6hN/LldpMziTGdS zlhkA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Fri, Aug 22, 2025 at 03:58:12PM +0200, Marcos Del Sol Vives wrote:
> Add a new simple GPIO device driver for most DM&P Vortex86 SoCs,
> implemented according to their programming reference manuals [1][2][3].
> 
> Vortex86EX/EX2 use a radically different mechanism of GPIO control
> and are not supported by this driver.
> 
> This is required for detecting the status of the poweroff button and
> performing the poweroff sequence on ICOP eBox computers.
> 
> IRQs are not implemented, as they are only available for ports 0 and 1,
> none which are accessible on my test machine (an EBOX-3352-GLW).
> 
> [1]: https://www.vortex86.com/downloadsStart?serial=Vortex86SX/DX/MXPLUS
> [2]: https://www.vortex86.com/downloadsStart?serial=Vortex86DX2
> [3]: https://www.vortex86.com/downloadsStart?serial=Vortex86DX3
> 
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>

Hi Marcos,

Thank you for taking the time to develop and improve this driver. It can
be intimidating to submit patches and interface changes for public
review (especially without the help of the hardware company), so I
commend your continual efforts.

Regarding this GPIO driver, you've incorporated much of what I had
intended to comment on for your v2, so I'm comfortable leaving an Ack
for this version here.

Acked-by: William Breathitt Gray <wbg@kernel.org>

However, I do have a couple minor suggestions below if you decide to
submit a v5.

> +VORTEX HARDWARE SUPPORT
> +R:	Marcos Del Sol Vives <marcos@orca.pet>
> +S:	Maintained
> +F:	drivers/gpio/gpio-vortex.c

This driver only covers GPIO support so a better title for this
MAINTAINERS entry would be "VORTEX86 GPIO SUPPORT".

> +	rmcfg.reg_bits = 8;
> +	rmcfg.val_bits = 8;
> +	rmcfg.io_port = true;
> +	rmcfg.wr_table = &priv->access_table;
> +	rmcfg.rd_table = &priv->access_table;

The direction ports are expected to hold their previous state until they
are changed, so perhaps it would be beneficial to enable caching with a
rmcfg.cache_type = REGCACHE_FLAT and set a volatile_table which
excludes the data port range.

William Breathitt Gray


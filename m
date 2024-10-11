Return-Path: <linux-pci+bounces-14330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24D99A70A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD55C1F248B5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EA18593C;
	Fri, 11 Oct 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjwd4aes"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D714D717;
	Fri, 11 Oct 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658755; cv=none; b=n5cDsIM7BQk5Mfjtobd/2tHepI6qA70BsNvoLOCmqbM3vbvMn55yfiFXDaoI49lrMultMg716dkNTAMvEVlOrAApJkHlh4Fd42Qm90kNGYFbPkqkjf4y5YtX00de0Jd7L1zLakE7dnUgK/7bDyAtl+wMyFGhNBf64XAAexo3v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658755; c=relaxed/simple;
	bh=q9Melzix6WD5z7861+jjpI6SZJSvXuUU11iBE+bflD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fljkyd8qR9Jf9KLaJCHWYzL7bnH23GhXx3xORM0I+x5aOQ4MeUje0ZNbw3qg1CgVNySBSeAeqJjDLSsmoGAV9iayhrRi+LQ+HiKU0wTLgotSJVWA49oTIqnTp/W4TBIbqRK7SyBe9/ApVdiOff99wxLsi7VrYvAIRNBVoXDh8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjwd4aes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD3EC4CEC3;
	Fri, 11 Oct 2024 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728658755;
	bh=q9Melzix6WD5z7861+jjpI6SZJSvXuUU11iBE+bflD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qjwd4aeslEZCB3DCKRUfcjg7NJmaTfLaBd3yQBeQBdmNQaIYZ1SBddX8n63vAyBVi
	 lJSuBJ/v/tpgPnVS0mgc/qwNqfpuXpikATVgzzPdx6IWhPxIGfrUrdWweC7mKevFLr
	 pSHnd6SJzQZ9x4ohKSvV6ULFRWDDkb2gmIP+WnGbQhqS08BPCnx5qlyVrZVuAV1KTD
	 GkbOW8oC2QFzHeKtmbAjKzImktcDt7FR4atQQMBn8C9CoBY8o2a6op+ckHZzZXXoIA
	 rprNb6Vq3UepXYkGvsFdl+J2j/3vtfPb7WjwzljLgUfO5EzHeP4L/KxZsTL4SUyIi5
	 mkuSVLeET9uyw==
Date: Fri, 11 Oct 2024 16:59:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] logic_pio: Constify fwnode_handle
Message-ID: <cnow7dcfcevhlstodpbyghdsqytygcarsbonwv5qjgfou6hukf@p525rdpumr2d>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-2-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-2-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:15AM -0500, Rob Herring (Arm) wrote:
> The fwnode_handle passed into find_io_range_by_fwnode() and
> logic_pio_trans_hwaddr() are not modified, so make them const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Please ack and I'll take with the rest of the series.

Now I see. This one should be before #1.

Best regards,
Krzysztof



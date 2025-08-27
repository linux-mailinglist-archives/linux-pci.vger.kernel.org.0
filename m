Return-Path: <linux-pci+bounces-34904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9CB37F32
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BBB7A6B52
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D227B337;
	Wed, 27 Aug 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot9RUnjg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFDF14E2F2;
	Wed, 27 Aug 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288171; cv=none; b=YV3eWTgAYeir3d5rIJS+h8sEu4NzMP8HVHNP5c3S/xJT5CDDTBRFq72JgXtyJKuKjwpKtDpRDYq/rGoITmI3E+JIXSLX43GSryOH8V6r4J/K88XF428MLz82IliNnpD872eyBKVfAwkOn4kJEUwaSOxs5BNWDDzBNKpAOFGRyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288171; c=relaxed/simple;
	bh=XfwtTl3ql9E5Or6bLWMQ5SJ/F6Z1T3NA64JU0cK2+x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjDTTJZQGC4oaLDXckAngUZKl4Yn6ouc3ul4HdBWGyyVH+QUD2Cak18NUi/KMSpqPDkQQgHftk5+2F/W8mT0IfU0TBX0zBbld1W76zzNvTFPLbJr62Lt2LbYtqz88n1kNK1ZH3A6ZIjiIHdK5t08BcoqOvmI2A5LvgBt6SCPF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot9RUnjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96041C4CEEB;
	Wed, 27 Aug 2025 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756288170;
	bh=XfwtTl3ql9E5Or6bLWMQ5SJ/F6Z1T3NA64JU0cK2+x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot9RUnjgFIbLmILu7UvNBv9otWJimthQZq9e7QmT+Sq1FQcm5sQr1AEgge5T1gzRT
	 EfH4JI29a5Hr+l3NpBJCFq99EhmMkim/nYCKS/yScNGEuySyhvfQ0QRgCutMigBsDm
	 l8YBkeUrfptyb0RdEpI1cixiNw5rcXvQO5OKfPwOU9jHPzrftr8oDGM+kv0zv2KHOM
	 P7Ztr7uFWLagd7B6h5UcbE9m1sMSD5aEr0Ee2DqLsPtu3vLaUJ4+UnKa/m7O4Y07df
	 hrxhPsiM4ccLAUVtlRJamRUTBXyXLqtSVH7bGqKzbypsuaXIi5E9yKhgE7erG/TK5V
	 oK3E8+o1aTHag==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urCmM-000000002Jb-09RA;
	Wed, 27 Aug 2025 11:49:18 +0200
Date: Wed, 27 Aug 2025 11:49:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/pwrctrl: Fix device and OF node leaks
Message-ID: <aK7UntgYJjlrvvSE@hovoldconsulting.com>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>

On Mon, Jul 21, 2025 at 05:36:06PM +0200, Johan Hovold wrote:
> This series fixes some pwrctrl device and OF node leaks spotted while
> discussing the recent pwrctrl-related (ASPM and probe) regressions on
> Qualcomm platforms.

> Johan Hovold (3):
>   PCI/pwrctrl: Fix device leak at registration
>   PCI/pwrctrl: Fix device and OF node leak at bus scan
>   PCI/pwrctrl: Fix device leak at device stop

Can these be picked up?

Johan


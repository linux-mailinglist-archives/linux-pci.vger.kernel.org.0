Return-Path: <linux-pci+bounces-39732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC84C1DA4C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E125188EC97
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F242ECD36;
	Wed, 29 Oct 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1tmLb7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B072EC0A0;
	Wed, 29 Oct 2025 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779467; cv=none; b=cPxf73t364DigSCh9ovAJ6Hjl6LuKEFtL8HyYxO9y7uE6UZjFwYKbP/zruXgX+72JXoAZUxFFJxtyjGJJoL34VKiNbs/nVR6NvEqDt6UOhGHEwr+0/vX7v8+cwm6PzNbx9m6Pw4uIvUkwNz/dz/+v7HyLtKEiDK++tOB605zliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779467; c=relaxed/simple;
	bh=eHlQ2ZALLjGdsa88lWgTESQ22heSRABB6bxl7CsGUww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U8TETcdWk/ZAy6+238zgrf2qEPthsisedKpRh7kmku0yecNIeaObP0pfSujTyJ4mNx8ejVUTBXi63K1UfRR3U57svtp7/6T9iKQsHOqNRVBKlrvWe6x81E0yP6GCLZU6K/nVz7v4Nrm33yQV/cd9iX3OE/Ppavo5Wp4KNnAcUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1tmLb7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812A4C4CEF7;
	Wed, 29 Oct 2025 23:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779466;
	bh=eHlQ2ZALLjGdsa88lWgTESQ22heSRABB6bxl7CsGUww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C1tmLb7mh4BjAht6SYKF9rf3E5ABcFVOINxHcK7CjmzQ398z2SAAuitNQkhsyWAXj
	 xNUGo9R6um8sdlaF7tTnnwcjylb6Hy3x27qfCnai9SSW+zaGEJgH3XKB+dQ6C/55S1
	 OFxBaFVfIatdHz/gy4117dT7Poo4G8Y/r2EhXEhkWAnsS+Yqc6khm0mYqPooQ7Suty
	 FhaKMD+sNsPy+SSSkymX+V87/ohpuYei2+8/fXbMXpzUfm8I+INFt4tzLxDde8+MJX
	 dKLQmQSgYmapfYnzafjIm3AeV5zzL85G2Ix8P6DA+Dl5Ae+lCFtvFxvbjqXwYpzAXC
	 BMr89O3kAt/hg==
Date: Wed, 29 Oct 2025 18:11:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v4 4/9] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
Message-ID: <20251029231105.GA1601725@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-4-ce2e1b0692d2@collabora.com>

On Wed, Oct 29, 2025 at 06:56:43PM +0100, Sebastian Reichel wrote:
> Remove code duplocation and improve readability by introducing a new
> function to setup the enhanced LTSSM mode.

s/duplocation/duplication/
s/setup/set up/

Maybe also include the actual function name instead of just "a new
function".  "rockchip_pcie_enable_enhanced_ltssm_control_mode()" is
pretty long; I wouldn't object to a shorter version :)


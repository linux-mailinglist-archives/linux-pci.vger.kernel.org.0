Return-Path: <linux-pci+bounces-39731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C4C1DA43
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64C5834A496
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826902E8B80;
	Wed, 29 Oct 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUI24iy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E122DCF6F;
	Wed, 29 Oct 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779223; cv=none; b=JBWklcg6+4GWRp5lGlnMtet3lkaUln39cxYqSRrt3+1n4TuPgbv5Cg0QDjM0Qu/uGPKVzfX5+MCR9c5FvCDhNPKJEPkqY+q7hlh6QlAVzDKO1m/ivEi+0UPW3RLTy4BjTRUtsrFmoxBMlVSwvvFKBv8ZzotNwKf00wSVLnMs7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779223; c=relaxed/simple;
	bh=6vtKfxLVHTckjyhMiXXMCWIG6JF1eGfVHEoUuMCzogg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r93zE0h7n+9S/EK0Q/f8K+tE3v9bcpyYPvP5+dKbEvlX5fPsIKbxNx09Uq3FpqMEm7QpdMpEMFz/pCCAjBeSrjIpUVzO31E53UeM6bVPvpqV8PNDI5HzsQPMYjgl9/u+nDZH25MVEjGMoQs80R6V9SMYC0jloGII0imdm0HBq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUI24iy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC80AC4CEF7;
	Wed, 29 Oct 2025 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779222;
	bh=6vtKfxLVHTckjyhMiXXMCWIG6JF1eGfVHEoUuMCzogg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gUI24iy4PvwhwVEtAqpZpflxITkrGPyFwTkQHs8g6/9gVrcq2yrVfmYPolTzeIwAc
	 Alt/9YmvQPr43cYuqfYYWIYkVq8bzThVJ67NmhMgrsfcEuK2m9bUbQGNIsFkZQdIKI
	 Y6Lm/jo35rqeVCt7nbxEwZ1a/PPbLpD4ofCmMIvH5tm8jYSPnCUYpOg9u3gkB+bQ5T
	 DgwHHVmB8IQChz8wVvM/Os3oKQDpT32d7F3AYDwwIKUd1sJ7itSwvvVFIy85aT5eFM
	 X2PDbbGo0ImSP4Q6L+BpIfgnnhjPel1z9WfQT+GSNHuXVLwRSpTgpjwUtg2OsrcIZI
	 4lKsTfPql6oKw==
Date: Wed, 29 Oct 2025 18:07:01 -0500
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
Subject: Re: [PATCH v4 1/9] PCI: dw-rockchip: Rename rockchip_pcie_get_ltssm
 function
Message-ID: <20251029230701.GA1601620@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-1-ce2e1b0692d2@collabora.com>

On Wed, Oct 29, 2025 at 06:56:40PM +0100, Sebastian Reichel wrote:
> Rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
> to avoid confusion after introducing the .get_ltssm operation support,
> which requires further processing of the register.

If you repost for other reasons, please add "()" after function names,
including .get_ltssm().  Then you can drop "function" from the
subject.


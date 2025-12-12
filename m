Return-Path: <linux-pci+bounces-42989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE9CB80A0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 07:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69BD304A125
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB623EAA1;
	Fri, 12 Dec 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM/JbITF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BB21FF4C;
	Fri, 12 Dec 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521452; cv=none; b=PAzMIUmjuRvFT+SXMOsvsVGw1KfrnlDZaf9z5iCc9cL/MxnNryYm/mFQSF1f5fpqyjQdB5SSuh92GB/xAbbDk2ErGuU5XDQx85Cn4uSH2rqOGPHnmMq0b298TQr5IXi1zQaMa7TB3xgOXDrfv78ai/FBmmIYf94cP2dYwW65DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521452; c=relaxed/simple;
	bh=CljOmxvU25QjtRs5y/lM3NXwAA/cz01Tq61VK0RzWJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s78rrTLcKRvtPU+xk77BOmRYea7Tmk9891H9cOLdVHAMnpqeBbb3m7+GxUUYg8F0psJUIbPXZn0XhJxInEeTRl8DIDtkbx8cYFZl9S+NfWvh7okpdjMJyME92LclScG9vaeKb10d4WRb414YDr3DHJP2U2qmZ52hF1AHxmG5JwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM/JbITF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26324C4CEF1;
	Fri, 12 Dec 2025 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765521452;
	bh=CljOmxvU25QjtRs5y/lM3NXwAA/cz01Tq61VK0RzWJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rM/JbITFT/eEnaHoT230alIn2hsNTXGJZwHNJwtCMLun+SxiLGLBFOdCqoa3J3HRv
	 ZY/jzHbrgVujYTvzIXx6ufU/jFkLa2zM9b2F01TJS4oUTtP9oA1Z3DrFqU9mHtAZ24
	 3F/m5RaWoppfzzfX+MtQJAhDh1D+vtU20Jvh3Lc1nNwWKf9tiCCM3aO27GOEcu+8ZB
	 6CVeteThfOkNiSr0fBO0m4ZFXiNLghPkFxkISAWRzQgaefi+O0zxoMB84S/zGFjzsQ
	 GSvMgwaAkOB0LU8igwAsLXoyCUyvBs3+dqvwTLOHM+mAdZuAiD/R2RyiMAY23F+/4P
	 A7PTw78NB7NJQ==
Date: Fri, 12 Dec 2025 15:37:26 +0900
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aTu4JgDcfb_58qBK@fedora>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
 <aTev28wihes6iJqs@dhcp-10-89-81-223>
 <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>
 <aTe1bA7lcVzFD5L7@dhcp-10-89-81-223>
 <pjn2gs43rqbe3odh6zvh4qaftxxl6qvdzpm6pgpadxeeid42ko@4a2qradscaqd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pjn2gs43rqbe3odh6zvh4qaftxxl6qvdzpm6pgpadxeeid42ko@4a2qradscaqd>

Hello Mani,

On Fri, Dec 12, 2025 at 12:52:35PM +0900, Manivannan Sadhasivam wrote:
> > This patch missed the v6.19 merge window (and so did the pwrctrl rework
> > series), so as long as Mani queues up both for v6.20 (with the pwrctrl
> > rework series getting applied first), I think we are good.
> > 
> 
> The plan is to merge pwrctrl series to v6.20 (unless we get strong objections),
> but once that happens, Qcom doesn't need this patch.
> 
> So it'd be good if you can just limit this patch to just Rockchip. Then once the
> Rockchip also moves to pwrctrl, we can revert this patch (also the whole IRQ
> based link up since the Root Port is not hotplug capable).

The main reason why I did not like a revert, was because it would remove
the nice feature where the bus is enumerated automatically on link up.

I assumed that the plan was to add Link Up IRQ support in pwrctrl in the
future.

If that is not the case, and the plan is instead to eventually remove the
existing Link Up IRQ support, then perhaps you could simply apply patches
from:
https://lore.kernel.org/linux-pci/20251111105100.869997-8-cassel@kernel.org/

Either the whole series or just patch 1 and 2, maintainer's choice :)


Kind regards,
Niklas


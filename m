Return-Path: <linux-pci+bounces-25615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F8A83DA7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF2F8A6BCA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5C204594;
	Thu, 10 Apr 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swNgFMrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731032040A8
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275238; cv=none; b=bpWWFpwkQ0QDvDhfts+X6DFdMLs5aDdoyOPqUFxGpa/+WpMmJMPghTSV/0qDn1X7BDXRU6fw7Cj34PJBzkezrzDtz8hF1mOJXpAKR/+XEhrIkan0SwpdopVSPwZTe/i3IM6IvI01l1Sm1jZxNniSrmVzA4C5wZpOrBAvvDwsPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275238; c=relaxed/simple;
	bh=OfkMO8sGSlJHq96r1UtN9ITYye3UhRVwLEpYzTkkmlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwaQGvElyNtnnJCwn4Nw7UHSAURPDyTammomtByU4g/UFzVj/b960hQdb7fDHZnF8dIXH7433VxtSxmvm1ZDXm0elrA3al6xgS+Gq9yYDRaTmXYZKioA+p1nm7JB65uBP1g++gxM72oxn54mXW+zo8mHsCOvRmDbZJFI1J+VzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swNgFMrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8EC4CEE9;
	Thu, 10 Apr 2025 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744275237;
	bh=OfkMO8sGSlJHq96r1UtN9ITYye3UhRVwLEpYzTkkmlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swNgFMrWfDycN+qXDY98b/FeV6036ZLTMdp51e8IXVxH5Vs/DugXxHAtbAb7Pw8N6
	 vkh9QYqxYnVF+C3BnoO8cYFoiMoEV4P7GbAQA0bQserYwcRHNtM+CoahxTwS1sEBfH
	 zqWpV/J8ws1Yss7b9Zl9Ny6gjQfUt6UWS/kYHAv/9unr90dd3RRSeSSjvssK7l0v4X
	 oZvoHK6XtjTgKt2GIOVBcwm+jg4/RSAY/IevEodkWGV5zn3ciZ/ic3rB6szbxNQE7U
	 QrJZc7Yde7gyPurvrjBd+vYSNW9AKax2BkrbQlw4/XviKLXJQ5N2er7IKcO7zvgCbK
	 zuhS/Nz+Xh3Fg==
Date: Thu, 10 Apr 2025 10:53:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable L0S capability
Message-ID: <Z_eHIXpBcnxJP6sa@ryzen>
References: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Apr 10, 2025 at 09:36:21AM +0800, Shawn Lin wrote:
> L0S capability isn't enabled on all SoCs by default, so enabling it
> in order to make ASPM L0S work on Rockchip platforms. We have been
> testing it for quite a long time and the default FTS number provided
> by DWC core is broken since it fits only for DWC PHY IP but not for
> other types of PHY IP from other vendors.

I also think it makes sense to split this to two patches.

Modifying N_FTS is completely different from enabling L0S, so please have
a 1/2 patch that overrides N_FTS and a 2/2 patch that enables L0S.


Kind regards,
Niklas


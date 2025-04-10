Return-Path: <linux-pci+bounces-25608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B4A838FA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 08:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D5D443101
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4571F0E26;
	Thu, 10 Apr 2025 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1wn5RFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574C1DE8BF
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265461; cv=none; b=FWkf+F4ydVgYvy49vWibXk2OcNa90HTttRWkaEc3lUD2tBLNEgIL1/EHukwn/gDHJsEokBYwQEW4VlqgfmZt31u0tXeTbjlrk78W/8rR+LRMD8CUfTt5QWxw0WXk6QDUkXvZnihQEAIiNdRmgpRu1Im0bnMfQ7kGit9QB3RJLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265461; c=relaxed/simple;
	bh=3lb3qTLZNUsCDKDV9CruPjuMvm0ZBdGUEuDqG4gvEaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRG6ShtB/gjLKzbGyLCQ6GAnM84bKGpcViP9tNTcsC0aUhDRW8lw/SC1yY8lkDbN/kq/8J8iZk6aDHdgyLNc5i1SvwjW7psnfZuQPfv1xU6kynvmrmtS579olDdUr2R5FShvCHm73Un0Y9QcFbxR2tPklvSlBO+uF8M2vSLkXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1wn5RFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C00CC4CEDD;
	Thu, 10 Apr 2025 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744265460;
	bh=3lb3qTLZNUsCDKDV9CruPjuMvm0ZBdGUEuDqG4gvEaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1wn5RFY0/JiNyPjObptry22vfIMMV/FGlnPe9HvuJaYHF6Xy4b7KlPWXATFDBZuj
	 rH1NTlvFgdFYPPIVC1S+dymVHgXGMWEOP+0ufaJl9M0airBt8jkhiayPF8f9O/dWX+
	 BqMsGAQuLWD2iJzX+yXkgkHOG+uiUHXKLOvvc+h2hg5MxD9ttDFS9FimCRPq8sivbb
	 DGhfnXQ0dCMd8eJ4iW487sU79QlCTu0JmdsjIC1eHQ68BDjMh00p+U8T0cg9iC3Smu
	 4xnG/nUaq3Aq+cOnUuxMPmGbrKkoKeuL/UHNvF/Tz/MmxvBpwS4lUzPykV1VOeM+d/
	 bpv24rEqAzfdQ==
Date: Thu, 10 Apr 2025 08:10:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <Z_dg8GkmQNvJxIJ6@ryzen>
References: <1744192308-238386-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744192308-238386-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Apr 09, 2025 at 05:51:48PM +0800, Shawn Lin wrote:
> Two mistakes here:
> 1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
> 2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat other
> states, for instance, L0S or L1 as link down which is obviously wrong.
> 
> Remove the check.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


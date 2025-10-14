Return-Path: <linux-pci+bounces-38086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2CBDB4C3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1245042245D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80032306D36;
	Tue, 14 Oct 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqJaPGoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A1306B3C;
	Tue, 14 Oct 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474588; cv=none; b=mYTYNSdKOzojG55IRuEA1p1OJ4WlEDca60VUrziYTKwbIXqmqc+Rx5ubR4YOoUPT+rbOU44WPbx1lAXulLrbNtZe+wPxFfkLXoO1m7mu+KHWVrOpb2S9kFnDgIeIfNzIGwwSBfjaLhZClUhLZpM4FSom2qZo+zckNmHEkwTvTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474588; c=relaxed/simple;
	bh=d8Vxq0wiTdFgCOFDkpVk3E8XmeKIGyWvOmVftCw9KJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Eh8B8gXwFLUgAoNvTCY9G+AmwEF09iYiuGILqvy9fSMZ2Hu7tQ1TEPV6qDyCx7GfOTcqhehPBoUYivtijZxhsbHjQvvk6+pUs5k/v907tPvhmR8SlaSMTK9GWu0JaMbI8D89VCf5NSo8ddJL7NP5I8cKLVTMyIGaqNXVMUFnT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqJaPGoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C2C4CEE7;
	Tue, 14 Oct 2025 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474587;
	bh=d8Vxq0wiTdFgCOFDkpVk3E8XmeKIGyWvOmVftCw9KJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IqJaPGoLwQEMWQAu8gCfNY7j1Mh4c9o70O/EwAc7sGx9/1OmwwFUWFOX5HjTdDXPs
	 TgHy1LfciiwJruDHrciQHn7euxeGyJFflfj3n0tstlNRU64N2B8F5RRS69ECPMxxwA
	 3XF/FkX/OgLWy+Z1ASXvxACV4Nq9zMQNv13rMj00eha0rnuvGZ6HuYn/v70RUZ0s6+
	 aHudJzjvG6BPh0HHRt/VZ0njBbkrvusnwPzJjFHc2ZD4bHxGEQgbjZw6r1atuW4Gbj
	 pBVhx2k86D1fvZvg/QRQXpx80K7IQwGxmGlWWB3ech/uDTYl1DDedTry057Tm4tntX
	 f6p1/iTZdpK2w==
Date: Tue, 14 Oct 2025 15:43:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] PCI: Add vendor ID for Motorcomm Electronic
 Technology
Message-ID: <20251014204306.GA906144@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014164746.50696-3-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 04:47:44PM +0000, Yao Zi wrote:
> This company produces Ethernet controllers and PHYs. Add their vendor
> ID, 0x1f0a[1], which is recorded by PCI-SIG and has been seen on their
> PCI Ethernet cards.
> 
> Link: https://pcisig.com/membership/member-companies?combine=1f0a # [1]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..0824a1a7663d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2631,6 +2631,8 @@
>  
>  #define PCI_VENDOR_ID_CXL		0x1e98
>  
> +#define PCI_VENDOR_ID_MOTORCOMM		0x1f0a

If/when this is used by several drivers add it here.  Until then just
define PCI_VENDOR_ID_MOTORCOMM in the driver that uses it (see the
note at top of the file).

>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.50.1
> 


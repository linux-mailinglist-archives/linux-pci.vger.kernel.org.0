Return-Path: <linux-pci+bounces-16228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93A9C03CE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D951F22D47
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E91F4FA8;
	Thu,  7 Nov 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y92h3ii6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE071F1303;
	Thu,  7 Nov 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978627; cv=none; b=cVDyk6/z86Utp+Egy/hFuK9KyJ8C3CD1xdYbW/Cx5glC5Dt2Pc8EwEQtBjNlZGE70zrt8hvcRtxwVqup+z1i3BPLh8TRhaMkRUhwOQBeBlG6FkEprA6iYPmBKPaah7x4Ir8W9zZ8O0lk766D6eXvkdc5T+AKe/ELnEScRC/mQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978627; c=relaxed/simple;
	bh=MUNQt2WiP43XCisLz5w3jz9Og/Z3eLleYi+/Fcb3MAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW60UQ36yB2+SmbSj1g6uQGTNM5dywh8VQ0y2JW8HMbqLgkLTHFG9NNN8zoar9iMS1qhkuIPTNfTKGDbbRJ5Sar03CE3NyoDm/QAu+fKccU8M7eFpbZ1MVa9T+oVUix9/E8YGl3EQoWx4SnRFfigOhgY50ilXoPNQw2umFnvO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y92h3ii6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313DCC4CECC;
	Thu,  7 Nov 2024 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978627;
	bh=MUNQt2WiP43XCisLz5w3jz9Og/Z3eLleYi+/Fcb3MAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y92h3ii6oGokXu2n4lw42RvveqBc7Cq7IMssxN2S5Vtn7ogV5Q8KPmqQJS4ctgNQr
	 pA7vfT4ivEutt3fvkIVr/517biLqO73JG1rHHeYAdEmWT1CAx8jBq2kt4aP2V0CY56
	 cF1yMYd/Aqh6V9l0nWY6wMHY1zJxzHa36WfbTC7V4JL66J58FWA4fetqxfvHXTHC50
	 BUnLqNLIt9m4j160hi6z9OU/5DViHIJlM0/cvUoVXPw1BfMoyTtyIShxggpINJ6JF5
	 2CLKzJEsfdhC4SZJQh/vuwynZfqbN+bXoH23KAnY5SOCBCtl45UpT2liT48YqPeE7B
	 YfP0ffiWbQMJw==
Date: Thu, 7 Nov 2024 13:23:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v2] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107112339.GJ5006@unreal>
References: <20241107020555.321245-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107020555.321245-1-sanman.p211993@gmail.com>

On Wed, Nov 06, 2024 at 06:05:55PM -0800, Sanman Pradhan wrote:
> Add PCIe hardware statistics support to the fbnic driver. These stats
> provide insight into PCIe transaction performance and error conditions.
> 
> Which includes, read/write and completion TLP counts and DWORD counts and
> debug counters for tag, completion credit and NP credit exhaustion
> 
> The stats are exposed via ethtool and can be used to monitor PCIe
> performance and debug PCIe issues.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
> v1:
> 	- https://patchwork.kernel.org/project/netdevbpf/patch/20241106002625.1857904-1-sanman.p211993@gmail.com/
> 	- Removed unnecessary code blocks
> 	- Rephrased the commit message
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
>  7 files changed, 272 insertions(+), 2 deletions(-)


You completely ignored discussion and participants in v1 about
providing general solution which is applicable to all PCI devices
in the world.

Thanks


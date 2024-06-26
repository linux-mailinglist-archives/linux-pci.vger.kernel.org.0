Return-Path: <linux-pci+bounces-9267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E62917877
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23911C22107
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41314B954;
	Wed, 26 Jun 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUlSj0tg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875E14D458;
	Wed, 26 Jun 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381781; cv=none; b=I3I0VZlkR3WOUR43jhtMLj30NTPDWIlBANYVKuX7SxgJeWyfmlhREEvi+RG4LZK1K/Z1MNpXav542MlwmSc2TUeETfyIy4rUseQGMvSVe7fkx8MWl5eI80dgzpe7CzSfgX/FHP8ZedgGTeTg3LZu4B0eSwoWK98oL6zgMh97JjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381781; c=relaxed/simple;
	bh=Y+Zf9ItE55P3r95JkXBtjtBnIHDpQoA7hI7hDp/zREc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv55mb2SNbEjB8Qm3TdaqOilWdM/DyXQ1TGflplW+4F4xkp5oFRwQgcyQ5SBfvf9CjPdUz/oq3OGso0qZ+GUEk9l6XAEZL9s3WRG3bQBmUCESXx0lboeXQ3dwhGOeXD3KKBJ+zMgAZkzyIVm93B+N1GScgQOOHmW3yYRujHSR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUlSj0tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA520C32782;
	Wed, 26 Jun 2024 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719381781;
	bh=Y+Zf9ItE55P3r95JkXBtjtBnIHDpQoA7hI7hDp/zREc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUlSj0tgTPbXha9yQ4zGfLklLatVe7AvnLkAw/TXtu0S+brG77+7+QfGRTeHl48Te
	 rBjSdKkZjVpXaSLyl8S1zmrL3wLPBZxU6OaKEZ+XinPrV8ga+gtiGnUsc1bIBOGQR+
	 4voXNxM1l8TxHNs35tYutqIq9Ql3Di3NpvPl6qZenylFEkiWdMMMoP0iK/3I9uVs0Z
	 uYYezEgi3EhcmrTNFzSz7j8Lue8lQA2KBYh6H3GZOXNAqY+6PcppyO0PrB/vXBT0nr
	 pUjzjaBPqkbs9dC+cS+Pk1NaHGBN941fNSiJDodQlzRNAyg9tFsImV5nHISngqSPPz
	 K/z27KEV/RJyA==
Date: Wed, 26 Jun 2024 09:02:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	galshalom@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20240626060256.GO29266@unreal>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <ZnrvmGBw-Ss-oOO6@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnrvmGBw-Ss-oOO6@wunner.de>

On Tue, Jun 25, 2024 at 06:26:00PM +0200, Lukas Wunner wrote:
> On Tue, Jun 25, 2024 at 09:01:50PM +0530, Vidya Sagar wrote:
> > Add a kernel command-line option 'config_acs' to directly control all the
> > ACS bits for specific devices, which allows the operator to setup the
> > right level of isolation to achieve the desired P2P configuration.
> 
> An example wouldn't hurt, here and in kernel-parameters.txt.
> 
> 
> > ACS offers a range of security choices controlling how traffic is
> > allowed to go directly between two devices. Some popular choices:
> >   - Full prevention
> >   - Translated requests can be direct, with various options
> >   - Asymmetric direct traffic, A can reach B but not the reverse
> >   - All traffic can be direct
> > Along with some other less common ones for special topologies.
> 
> I'm wondering whether it would make more sense to let users choose
> between those "higher-level" options, instead of giving direct access
> to bits (and thus risking users to choose an incorrect setting).

IMHO, with "higher-level" options will be much more complex to use than
simple ACS bits matrix. In any case, the user who will use this feature
will need to read PCI spec before.

In PCI v6, 13 bits are used for ACS with 8192 possible combinations and
it is unlikely to find small set of "definitions" that will fit all cases.

Thanks


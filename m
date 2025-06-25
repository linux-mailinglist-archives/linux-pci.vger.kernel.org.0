Return-Path: <linux-pci+bounces-30568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D07AE73B4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8541C175CA5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBAE17BA6;
	Wed, 25 Jun 2025 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhB/ttrR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AF8F58
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810733; cv=none; b=YeQzetX8Uloe/iTQcbJ79wcURZqiMNIh+lITdKlmuZdD8bP1G1Rdg07HGQ3M2cF+EqW5/utDhhyRNsclTg31L4Ev0ZugpDaWzNCMVi7+zbtnXwGZPSEvEtZ3r1wpkMRBWBl0y+rie3ZRFS1F8M+J6/r0tohRe5qjQvi5J5IRVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810733; c=relaxed/simple;
	bh=f9zjunBR2QqdzYrAT7RDhHzIvTEu0ORPbackFjI2R/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3n1FDT8PJSNWAmlFqAV6JjdChnXJ3PvA1wh8iobq+/ucEqLwchkvI0enJuYlEDr15a0urvpZBrbxefmU2l/J/jdpnbaYur7sNg9+2EAmA2nRtntZnElcgo2hIVx44WYZDCzA4UTm6puO24+8+H/Jm+qUPhmgy6xOKDToaxQoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhB/ttrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7375CC4CEF0;
	Wed, 25 Jun 2025 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750810732;
	bh=f9zjunBR2QqdzYrAT7RDhHzIvTEu0ORPbackFjI2R/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QhB/ttrR9ubXuES0ivUfn2hJfEy8lHn+k3N2gM+c5lHAJxLCncET8wLOM9frXR7KU
	 1NE45y2NQbsmZ9Iozpnnw1RjL8bW96eTjja1ah50XBwUiBaAw5/nheOmJFer2pXmfc
	 KnhPDj4OCvyXKmGI0XBsh7jCVUYrUlQXNXrQhfVNBtsFEYtOAsdJwABdHgmjY0IgFE
	 g2hBbwLaQOblBM/KmOL0TxTIoa2D66UMxAnadOw2uPcgBR+fThZcR20oRQydMmSRU+
	 AWjNE9JkrBxXN6rd1XChNi6OOkO5AXm6PyCit4MfrnNovHK7d28wTDMCNze7BgpaSq
	 DfoFTTEVHLxpg==
Message-ID: <1f35a1b2-4d98-4e4b-93c0-8712d9a89b3f@kernel.org>
Date: Wed, 25 Jun 2025 09:16:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Fix configfs group removal on
 driver teardown
To: Frank Li <Frank.li@nxp.com>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>
References: <20250624081949.289664-1-dlemoal@kernel.org>
 <20250624081949.289664-3-dlemoal@kernel.org>
 <aFrrFwcS/KflScJ9@lizhi-Precision-Tower-5810>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aFrrFwcS/KflScJ9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 3:14 AM, Frank Li wrote:
> On Tue, Jun 24, 2025 at 05:19:49PM +0900, Damien Le Moal wrote:
>> An endpoint driver configfs attributes group is added to the
>> epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
>> added group is not removed from this list when the attribute group is
>> unregistered with pci_ep_cfs_remove_epf_group().
>>
>> Add the missing list_del_init() call in fpci_ep_cfs_remove_epf_group()
> 
> reduntant "f" before pci_ep_cfs_remove_epf_group()

That is fixed in v3.

-- 
Damien Le Moal
Western Digital Research


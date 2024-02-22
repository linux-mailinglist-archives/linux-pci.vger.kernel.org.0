Return-Path: <linux-pci+bounces-3901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D4F86070C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 00:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311211C2182E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7551C680;
	Thu, 22 Feb 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShIIAFFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF61B7E8;
	Thu, 22 Feb 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644915; cv=none; b=ES9VVngT3NeYTPE0IPvHsP+7/6QaQpGOEC6jzWeFfFy2T5l+zcnQ9gCOE62cLBnvZirNdGn+1QR2Z16fm9Q3n93We6vvJpNneVTMlkj52C06hFwV9Hnixqv6sgQg9F+ACL7BrGq3TEy5OX0DWaeeeCQ8L0mW39wFjabMuRly/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644915; c=relaxed/simple;
	bh=bWHQ4veqHNgZLLV3PvODabroMs7Y6VE4DKsDteiIziM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i033M+8eCpv6LE8E/hq264Nqnq5QOwMw9XMaGXxrPGMp9EOlPp50lVaxGeorCA3LyaVCL/Ks5mn8uTU82TJiLZvpglGjd6gm5nZQ9SZvoT6N0NiYA1VrwUC1b7ctdUKviH2PNhISDDSic42OiSlRP7PqBC8DQ7xZqzNOKj0TVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShIIAFFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC2C433F1;
	Thu, 22 Feb 2024 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708644915;
	bh=bWHQ4veqHNgZLLV3PvODabroMs7Y6VE4DKsDteiIziM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShIIAFFh+3T39gD8YC924PmfNQhM4tY30CnPeKJD92aKONmy7ruQf14KyQV4Vi58z
	 98ew1Qzt6FURyURo0IEctanKtVpKrj4d2xLJeMTmxpehOXWxyqkJUqvngxel0SHp6Y
	 /ef2mpYckwgmZnK18aNoNTS+Sw6SrzTiHjheh33q2jKlLs1NoJMgj+TP3eE2MifRRO
	 JqduNINSGm0TwIuB+1wqsvDQaa5wMXZYpUhRKKRj4movMj+Qwj6kUOhC28em4OAD/t
	 Mf3NVXxjYlqelfCgIrvSWu5VhTpLalqaSn0O9G5fM+iQMPDYpHLa6Xvitp6mtbuQei
	 XetYvnDI08DDA==
Date: Thu, 22 Feb 2024 16:35:10 -0700
From: Rob Herring <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Andrew F. Davis" <afd@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
	"Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,am65: Fix remaining binding
 warnings
Message-ID: <170864491030.3808693.7969720495759139872.robh@kernel.org>
References: <8032b018-c870-403a-9dd9-63440de1da07@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8032b018-c870-403a-9dd9-63440de1da07@siemens.com>


On Thu, 15 Feb 2024 13:55:56 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This adds the missing num-viewport, phys and phy-name properties to the
> schema. Based on driver code, num-viewport is required for the root
> complex, phys are optional. Their number corresponds to the number of
> lanes. The AM65x supports up to 2 lanes.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> Changes in v2:
>  - limit phy-names to pcie-phy[0-1]
>  - fix schema-checking of example
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



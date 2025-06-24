Return-Path: <linux-pci+bounces-30522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A466AE6BA9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D13166BDF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3E274B4C;
	Tue, 24 Jun 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPZLr60j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D254274B3E;
	Tue, 24 Jun 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779991; cv=none; b=S5aq54N/Fn/Y83b2bA7IIwyBJm+XSqPsmZr4d4FbelGRs2wcYPtUhlaQkbJIidifZSwzExI1bcvDNi0Jbn3JBGB1joxrWwYL9Du2ktbPzPpkPaFgYV/DdjYK7+VxiXJTgyt4kkCEL16uX1gEJiXr3Ycp50CYh4mdfkIcSg6iCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779991; c=relaxed/simple;
	bh=kdTJmq1Ls7KWG7xtmsxpclzIUBGjRY5zhqZy9ZxXbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HmYtn6q90ACFDmJwBGGkmHHMl4G38z53yRmnib14HbEAAnIS3JK7FHlaqidyHDMgyD+wpAVaIQwz/PSWPywl6NIwjyzo7t62RxoQaUc6Wzt2zoDFXFy+cEINinAKNdygKmQKDGoGGWCCpNtw99/7xii6t/QGl3Jv+mVvlOzPvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPZLr60j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B0EC4CEE3;
	Tue, 24 Jun 2025 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750779990;
	bh=kdTJmq1Ls7KWG7xtmsxpclzIUBGjRY5zhqZy9ZxXbtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UPZLr60jcmXAVIt3szD+TcN2sQKhqTZgpCMX8KufIomZSyKx+QsIpbthyoRl6NZiq
	 irX0SqhHWktebC10WqFvqXxHfK0EJDVVM7x1YK8Wr/wXgUuypox+y0eVhP5WAsGJ/g
	 5PAnxGxLNMfLXfiBKlUs7kS6TVXYTkCPeaJ5N6FgQlHcAQaJvX4OSWs6I7qvBr5ob4
	 LLazPa8Y+boq+fMRwP0dAtsc2Hq1XmRaqD0HBI0Dwelptyb+NHFGh+JaBn0U0YYywS
	 zz4M/pMl3Yq5aB+Zy3Hvmj9irCgLwYa3kHnBd+0FEt51s5m5vybismFQb69scN7vz/
	 UY2EKJYKMMLWw==
Date: Tue, 24 Jun 2025 10:46:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Extend isolated function probing to LoongArch
Message-ID: <20250624154629.GA1479401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624062927.4037734-1-chenhuacai@loongson.cn>

On Tue, Jun 24, 2025 at 02:29:27PM +0800, Huacai Chen wrote:
> Like s390 and the jailhouse hypervisor, LoongArch's PCI architecture
> allows passing isolated PCI functions to a guest OS instance. So it is
> possible that there is a multi-function device without function 0 for
> the host or guest.
> 
> Allow probing such functions by adding a IS_ENABLED(CONFIG_LOONGARCH)
> case in the hypervisor_isolated_pci_functions() helper.
> 
> This is similar to commit 189c6c33ff421def040b9 ("PCI: Extend isolated
> function probing to s390").
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied to pci/enumeration for v6.17, thanks!

> ---
>  include/linux/hypervisor.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index 9efbc54e35e5..be5417303ecf 100644
> --- a/include/linux/hypervisor.h
> +++ b/include/linux/hypervisor.h
> @@ -37,6 +37,9 @@ static inline bool hypervisor_isolated_pci_functions(void)
>  	if (IS_ENABLED(CONFIG_S390))
>  		return true;
>  
> +	if (IS_ENABLED(CONFIG_LOONGARCH))
> +		return true;
> +
>  	return jailhouse_paravirt();
>  }
>  
> -- 
> 2.47.1
> 


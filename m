Return-Path: <linux-pci+bounces-7176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11D8BE7C5
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CF4B25590
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123516ABEB;
	Tue,  7 May 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ/CJLHJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22C1649DF;
	Tue,  7 May 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096971; cv=none; b=C7Sj7CYi1nIh5Hg65S6K6iciNZ4FMpa2B4gzEiWXCQUTtkSUt4nR6jLkIugLhr+CCViZLMfP39xE9++Ws8GI25cd6MYn36YiYZfcLghJ4GiIOkmeLZ1OUEbLEgJjIj9o2ehziVD8pYKRsZLQk6JuQIEHiMDOQ2BGacspEjJNsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096971; c=relaxed/simple;
	bh=KDIJNxijUzjbFsJERLqaSytYfJ7yDDJ3cokD8Y4RusY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZdF5t3AN5Y4j0qldV44rEMgF9oIETXW9/0/x4HODKmmC+SHrNb9b+ZHzBqJyCHuOg4T5XbAIiiKhddL6e90WQvWBO8r5I8XNb8Y3oYMrN7RAmKrXFBfAQ/3EyviRJ+YMisIkXT2Hcncd9XxHM8FmtdAmw3LplLk65BZezbneo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ/CJLHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EF0C4AF63;
	Tue,  7 May 2024 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715096970;
	bh=KDIJNxijUzjbFsJERLqaSytYfJ7yDDJ3cokD8Y4RusY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJ/CJLHJAkdklO5snRDaDzohANmWZuZ9TGt+Rb+0gVkKXBtlYI6VxkeA7pdrSYORF
	 GNfI8a5PbhmbU58P2WVoys6rL+cUQkCd34umRbXhHnKIciyRsjVUQqbFf+OH/p1BlP
	 uZVb0txOh7ndFPn5AjpfdNS5w/UQO6ivC2iWM17mOrUix9w4nEnSnilufO63cl5CYx
	 IS6wDDAi9BuZNujBjevGIlWpRqNdBnfrLqUYlFNk8bhk3D7EjNS/Ul3IFpz7pvzZhF
	 Ozszh9Lve/isuW7cIdak2BjTjILhisZs4pKaPzL7AqFZZ/t21x0bQyvO/bpmS4FRNR
	 2wKy0cUgFxRIg==
Date: Tue, 7 May 2024 10:49:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Lin <jon.lin@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, devicetree@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 05/14] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Message-ID: <171509696640.530353.4535122936200527416.robh@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-5-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-5-a0f5ee2a77b6@kernel.org>


On Tue, 30 Apr 2024 14:01:02 +0200, Niklas Cassel wrote:
> The descriptions of the combined interrupt signals (level1) mention
> all the lower interrupt signals (level2) for each combined interrupt,
> regardless if the lower (level2) signal is RC or EP specific.
> 
> E.g. the description of "Combined system interrupt" includes rbar_update,
> which is EP specific, and the description of "Combined message interrupt"
> includes obff_idle, obff_obff, obff_cpu_active, which are all EP specific.
> 
> The only exception is the "Combined legacy interrupt", which for some
> reason does not provide an exhaustive list of the lower (level2) signals.
> 
> Add the missing lower interrupt signals: tx_inta, tx_intb, tx_intc, and
> tx_intd for the "Combined legacy interrupt", as per the rk3568 and rk3588
> Technical Reference Manuals, such that the descriptions of the combined
> interrupt signals are consistent.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



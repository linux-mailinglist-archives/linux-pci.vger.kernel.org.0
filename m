Return-Path: <linux-pci+bounces-27811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1DAB8C48
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEA516CC53
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2121CC4D;
	Thu, 15 May 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOoXr/ys"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE361FCE;
	Thu, 15 May 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326247; cv=none; b=i36aOa5sNHjoYpuZY9ANPTJUAmqK+y70EhhaGjF+3HVvRE71JNBbNqC8hPahZSKI2oUus/RILzbNN+s/o7KlJIPsIR/U4jiXvjAgVjpAUsRrpCkkk5Bf1/ySMJTwimlnaCODfNfwQ6f9GB4YrnJJLuSggv/89ZcS1uAWpYuiKCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326247; c=relaxed/simple;
	bh=WWI9myWlYeKFuTkR8xCNTG9oP6zdkdvGgXNz3gzN/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In2XuVd3hIxRQIDpvmLSj8bIasWhFdhRPb4CYgz2y1GQtCKAVO306rxhbUEBDoqnzjWDP/N4/ZZrNWKWrVfjEh/GA9ytCH5bNGl8L5DqlYOP1bUUYYeNJg5kUn0KuOMda5ildYCRxXCPyF/VUR80EdoOI3NkRAktmuLhiIrKXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOoXr/ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F0CC4CEE7;
	Thu, 15 May 2025 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747326246;
	bh=WWI9myWlYeKFuTkR8xCNTG9oP6zdkdvGgXNz3gzN/I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOoXr/ysckuCzcl7wA1OX21UwV4JEtx/Y8S1UJPW949z6quIJKEvF3zOnGbmfsYtQ
	 A0dmzYmPbVaO64a3R/BDwubyto9d+CDTIj+msR+omJ/e5Jj2/RBzt/eVD5w5Q5kS6S
	 5+jl/l0t/c7tVpbDhrixYNKMFWZHkJc1l64qlEJ9SL+oEz2dIW7qx1jdTAD4VIDki0
	 51vpbVs48gbK7k/iNgMtupq33dPjWroIcLgSJAMtXQRsw/hcxmweVjmDJjHm5O8o6M
	 Wk6zMQcgNgYa6cHKrTld1/1/gper4X3ApPpZYjoOBYmVDZDNZHquW8AGkbaE3FPZIl
	 Az4B1dq6oy3tA==
Date: Fri, 16 May 2025 01:24:05 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
To: Hans Zhang <Hans.Zhang@cixtech.com>
Cc: kernel test robot <lkp@intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbcGNpOnNsb3QtcmVz?=
 =?utf-8?Q?et_1=2F1=5D_drivers=2Fpci=2Fcontroller=2Fdwc=2Fpcie-dw-rockchip?=
 =?utf-8?Q?=2Ec=3A721=3A58=3A_error?= =?utf-8?Q?=3A?= use of undeclared
 identifier 'PCIE_CLIENT_GENERAL_CON'
Message-ID: <20250515162405.GA511285@rocinante>
References: <202505152337.AoKvnBmd-lkp@intel.com>
 <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>

(+Cc Mani for visibility)

Hello,

> Please merge it into the following branch; otherwise, this compilation error will occur.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
>      721 |         rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
>          |                                                                 ^
>    1 error generated.

Sorry about this!

I moved changes from the slot-reset to the controller/dw-rockchip branch,
to make sure everything has proper dependencies now.  Hopefully, there
won't be any more issues.

Thank you!

	Krzysztof


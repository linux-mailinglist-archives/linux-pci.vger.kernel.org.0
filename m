Return-Path: <linux-pci+bounces-16593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC49C6258
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E2F1F22340
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BE20B7F2;
	Tue, 12 Nov 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pczimSjR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAF1A76D2;
	Tue, 12 Nov 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442495; cv=none; b=c2eAQZM2f6JGLajYrAl+lz9Hkk1e4P+APCauAoRv8jZxNwEe7X/0GhoSzSUCJ4gNeA03mAoLOWcuWJ1t0OX3VqRhTjjQEZSIq7NVjuOcIJgwk3A6910f6iP51ATZkBaZvU+nKTKhfOwbtvgdKmQ1A4qN4clYNMYhypcDyToNDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442495; c=relaxed/simple;
	bh=bgaoso6rbdkSsSON+N048bK3ATUOUcNNS6YEtD58y4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIrVsPVie1eaj9szfNFPsl7qv3uc6GRQOqL2/S8ZMsN7xe0dGb/y2xgoaxenXgUJ9fC6lSKLyEyoL7QRNk0mN54XZ16UpoW1hqooCNZAR5lTmcfYxGYYsl04RCubhdkzxUftblSZQOZKZBe206enxnSzIi8CygCEBjp5LTHkRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pczimSjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E10DC4CECD;
	Tue, 12 Nov 2024 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731442495;
	bh=bgaoso6rbdkSsSON+N048bK3ATUOUcNNS6YEtD58y4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pczimSjRqUpjInik/O6oFCv6e7AnMunSaJwYQCcaLF7yr50WWVMBXIEmYdAmXr7gW
	 HnW/FsI8/E44mPRRIweCFHHpJNfLSXjPkVarIlKFO0KJIA8PSL6NRnLITT+1Yz2aBf
	 gXHP/GINQFcrrQCpdPshxtpHEPElNhcq9bMVSX4Z58DL1qFFuYx7hJ+pI/OolQcCH1
	 LY91orHhYIiRnwbP86WEY2hlyVkq4A+dKq90PkEsnUelxyPKHBhMdNnOH24Q8gmTRl
	 M8rwzKUlNj/xZJVzH09/oz1AAIM6oZiE6E2uNQnEe7/QILtQydnVgyTakCUZ9azItP
	 QCtN5jZ1wFv4Q==
Date: Tue, 12 Nov 2024 21:14:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v6 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZzO3OcCNtHUfm867@x1-carbon>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
 <20241112-ep-msi-v6-3-45f9722e3c2a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-ep-msi-v6-3-45f9722e3c2a@nxp.com>

Hello Frank,

On Tue, Nov 12, 2024 at 12:48:16PM -0500, Frank Li wrote:
> Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> doorbell address space.
> 
> Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> callback handler by writing doorbell_data to the mapped doorbell_bar's
> address space.
> 
> Set doorbell_done in the doorbell callback to indicate completion.
> 
> To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> to map one bar's inbound address to MSI space. the command
> COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> 
> 	 	Host side new driver	Host side old driver
> 
> EP: new driver      S				F
> EP: old driver      F				F
> 
> S: If EP side support MSI, 'pcitest -B' return success.
>    If EP side doesn't support MSI, the same to 'F'.
> 
> F: 'pcitest -B' return failure, other case as usual.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v5 to v6
> - rename doorbell_addr to doorbell_offset

Is there a reason why you chose to not incorporate the helper function
that I suggested here:
https://lore.kernel.org/linux-pci/ZzMtKUFi30_o6SwL@ryzen/

I didn't see any reply from you to that message.

Personally I think that it is nice to have the alignment code in a single
function, rather than duplicating the code. The helper also looks quite
similar to how we do outbound address translation alignment:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=e73ea1c2d4d8f7ba5daaf7aa51171f63cf79bcd8
so that people will recognize the pattern more easily.

But I guess you didn't like my suggestion?
(Which is fine, but I would have expected some motivation.)


Kind regards,
Niklas


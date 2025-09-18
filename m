Return-Path: <linux-pci+bounces-36448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC49B873AA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 00:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71AA7E2231
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2D2FABFF;
	Thu, 18 Sep 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBLV2mfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153C303A1D
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234409; cv=none; b=HGRso3QmxXC2RS4AKNpfWaFSJXMTDiGaFyFAMcsgfzBKaLBXzhlYYJQP5avtyUUk1ewTo1Flw1L3Z8YIK4cT9jB4vI73rTY8oDYluwHsWU7/HuGgKx2HjyDMAiBhiTUlXdSPHQQznVgq8AQw5br//ff75RFJZ3illYaIxHBEshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234409; c=relaxed/simple;
	bh=SomVC4fY1MmSGS91a5Dpf/nuklYFnM1/+HlTutS1h8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mU5TWZCBEKv5DfHwypri+kGTTpjkR9jUmW/2swSXkgIdWEOfDx1E2ySX6WMbU6bHgVos0qVgoO3aJlyx75YxpcUPQv74jPl2JAJWwLwqM5/YPUbWE1OUJmmeAqjgmaBgv+XrA8aS1qQtYH0ByP12rCbh0NW++S9Fs/Y22EHX1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBLV2mfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711CBC4CEE7;
	Thu, 18 Sep 2025 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758234408;
	bh=SomVC4fY1MmSGS91a5Dpf/nuklYFnM1/+HlTutS1h8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DBLV2mfOta5l1DcHNEDarcEWWNEKParqaKX540CGGznZSRiciFGdz5pXnE8/EthNg
	 ls2KEuUg/yjClnCcNfKmKYs2FXJ29lhKXXqV5iKnNHsF7S/J0tCOBLzulOEFWrnyiD
	 dqDAZ410bYN4FNps9eNn6FZ0bUnbb2M7rKtbzVhZZge71xl0JgaAv1cg6An5+BOMKv
	 W6qb/bclOf1U7+aAx9YKQa6BWBsj5Vn+1zEsGcgQOvf2U0RWz5AEMaCwpve68DB8gM
	 qQsXyJwSKxbA4OV0KlpJ0lizVCDMKry/FzPN1e+9qU2V6C5Jb+MpdDEBAkudUKCkTJ
	 l24GTf/YKra4A==
Date: Thu, 18 Sep 2025 17:26:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Emilio Perez <emiliopeju@gmail.com>
Cc: bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation: pci: Use term requester ID as per standard
Message-ID: <20250918222647.GA1926836@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818023121.33427-1-emiliopeju@gmail.com>

On Mon, Aug 18, 2025 at 03:31:21AM +0100, Emilio Perez wrote:
> The PCIe standard never use the term requestor ID and therefore it might
> lead to confusion.
> 
> Signed-off-by: Emilio Perez <emiliopeju@gmail.com>

Applied to pci/aer for v6.18, thanks!

I also capitalized "Requester" as a hint that this term is
specifically defined by the spec.  And capitalized "PCI" in the
subject to follow historical convention for this file.

> ---
>  Documentation/PCI/pcieaer-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 4b71e2f43ca7..7b30598b4fde 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -138,7 +138,7 @@ error message to the Root Port above it when it captures
>  an error. The Root Port, upon receiving an error reporting message,
>  internally processes and logs the error message in its AER
>  Capability structure. Error information being logged includes storing
> -the error reporting agent's requestor ID into the Error Source
> +the error reporting agent's requester ID into the Error Source
>  Identification Registers and setting the error bits of the Root Error
>  Status Register accordingly. If AER error reporting is enabled in the Root
>  Error Command Register, the Root Port generates an interrupt when an
> -- 
> 2.50.1
> 


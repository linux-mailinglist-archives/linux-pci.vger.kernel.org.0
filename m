Return-Path: <linux-pci+bounces-35957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB8B53EDA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 00:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94EE1B22A15
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608A2ED855;
	Thu, 11 Sep 2025 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE3kYxL3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1552279334;
	Thu, 11 Sep 2025 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631299; cv=none; b=u/R4nAHAarxQRvxMSF444VcWEfspeB0Vr/u89AaaheTyRCh04LPY/f/ns+yrO/AqTed0UFLtgMq6GTr0n11Bi3vC/uDyS/4nyr62yxrWIgtgzdMqrhI5XFfNAfoCGZFtGy0QY4LF4vC0ed7CYME5VUCkTvB+ipWie6T3IKzzWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631299; c=relaxed/simple;
	bh=9wA1L6p2PKuguKMkeIHlsJ7+VV03bsUAvg+8nv3mAs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jsi65TPYgfzi3KoC4D1z5JLZDuwu+Wt9GszyCd69lZJlFjiRZtkLRgmoQ1lLc51+MzTOuVOtU5FQF4f2ln0gh8/itheLnIdtmyAE4NFGOmJhN34VeSBgb66jggF0tmWqwvV2veoI73pRwbQL42wwOKmEXqiaLJpvb8N8dZqeduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE3kYxL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6991AC4CEF0;
	Thu, 11 Sep 2025 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757631298;
	bh=9wA1L6p2PKuguKMkeIHlsJ7+VV03bsUAvg+8nv3mAs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IE3kYxL3j5ylxA9XwchT2l/UJCmXRe7xcP+pSsmNkKbs9B0khvd6aAXnJYdRV4jv5
	 MIYAIa4DXhp1LhxJYplXrppof8YZEgFKXTfGUJOWbYhvQMwSRo+oGplW5L/9uPO+Ob
	 J1zmkFspz+G3t4gvkjatMQYdASc4LHFKt5boqHny3xeR/XKpEn+JapLaZkVe+1IKcC
	 h9X4Ui5auC75CbrBY2fGH6MfFlTOwCXdZ6/kYduefY11XhKV+x+gS+b9saQHIgmhUj
	 ImvnkQXASqmZppEdl0fCXggHM7BPhNIM4dTILDAzaVoLGy4Mh9LfiX7eNyQu9HtGI9
	 nKr6b3EPhtZWw==
Date: Thu, 11 Sep 2025 17:54:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: mahesh@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH] PCI/AER: Fix NULL pointer access by aer_info
Message-ID: <20250911225457.GA1596803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904182527.67371-1-vernon2gm@gmail.com>

[+cc Terry, Robert, CXL list, Smita, Dongdong]

On Fri, Sep 05, 2025 at 02:25:27AM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> The kzalloc(GFP_KERNEL) may return NULL, so all accesses to
> aer_info->xxx will result in kernel panic. Fix it.
> 
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>

Applied to pci/aer for v6.18, thanks, Vernon!

Not directly related to this patch, but I'm concerned about some users
of dev->aer_cap.

Most users of dev->aer_cap either (a) check that it's set before using
it or (b) are called in paths obviously only reachable via an AER
interrupt.

But there are a few users of dev->aer_cap that use it without checking
it for zero, and it's not obvious to me that it must be valid:

  - pci_aer_unmask_internal_errors(), added by b7e9392d5d46 ("PCI/AER:
    Unmask RCEC internal errors to enable RCH downstream port error
    handling")

  - dpc_get_aer_uncorrect_severity(), added by 9f08a5d896ce ("PCI/DPC:
    Fix print AER status in DPC event handling")

  - dpc_is_surprise_removal(), added by 2ae8fbbe1cd4 ("PCI/DPC: Ignore
    Surprise Down error on hot removal")

> ---
>  drivers/pci/pcie/aer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..aeb2534f50dd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
> +	if (!dev->aer_info) {
> +		dev->aer_cap = 0;
> +		return;
> +	}
>  
>  	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> -- 
> 2.51.0
> 


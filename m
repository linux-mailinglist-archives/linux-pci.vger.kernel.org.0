Return-Path: <linux-pci+bounces-36004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC1B54A02
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1143D1CC53A1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495201547C9;
	Fri, 12 Sep 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTPb4rER"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B45A41
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673532; cv=none; b=WF+idchpCdx91zw7G7UY+Ar3naAOdbhv9/0IUvm0f1uODYtkYekPr8W5tlN3KYNVcZrNG28kx8cK9+BBmgnTu3lwR+4MHdDReF6ymsHdoPil4SCWwUG4hpWarmVKqOPvhJp8M2D2Bnosb9pyycrJzT4XqsPpjko5MJl5vzhVj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673532; c=relaxed/simple;
	bh=GCR7ls+kXPcQBL7zWMM/aZc/sGBeJxwOiy4URDM1d6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcG7na4ijChZJpN7HVVVjzrzG8zMBr8W6SZeHEmAaWqq0xODDoDjpws6R45fnNqwRyBOgU//7MLLAFDTOzAWrsq3g5HgZBeBs2G83LXPrwfVTwcJpA5YhPGgaivS15g2wI/Qf+f1zcvEJvBBHD8szoUi7qUb5aQJyMx6yO25gFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTPb4rER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62190C4CEF1;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673531;
	bh=GCR7ls+kXPcQBL7zWMM/aZc/sGBeJxwOiy4URDM1d6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VTPb4rERVDGX25qOL6oRDUnSqsfhjS23UXxuc5AVH/Z8fZ3Go5xtIhTnKH96dCcsO
	 GzpnhF0QxxF+ER5Redy1ftf6SjO6taJlhkutkvmNKgGU1U3rw8jQW+quXNBLYA18FQ
	 HdzjZb/nd5TC8D9iARqkMX/v59ue4rb5vEfl/uhhEiUbbflHxuDtjF04Z+gZYSZTTT
	 HQFHsO5a7XDp1BiRfih0peI9S6WT693idnGgf2uXVAqISX21gZD9LM8Bt2q0O+DCi0
	 p1AwnZwH26SP75XswCxHJemVMDoXb4qwMRMlxo/TrzB/ds9QqwQwADa/pUEFQgktjX
	 r73DZ5cVPSkQA==
Message-ID: <52165346-d752-4203-929e-58dd943cfd7c@kernel.org>
Date: Fri, 12 Sep 2025 19:38:49 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 16:11, Shin'ichiro Kawasaki wrote:
> When endpoint controller driver is immature, the fields dma_chan_tx and
> dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> initialization. However, pci_epf_test_clean_dma_chan() assumes that they
> are always non-NULL valid values, and causes kernel panic when the
> fields are NULL. To avoid the kernel panic, NULL check the fields before
> release.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


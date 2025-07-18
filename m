Return-Path: <linux-pci+bounces-32504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE4B09D47
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF95E7B9D65
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84E292B50;
	Fri, 18 Jul 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltsWnabx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636B291C2B;
	Fri, 18 Jul 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825532; cv=none; b=Pm/KVkgOHT65lk75zjmV0c6qEPqaFIrnge8iOU5fQbBKmwXD/kE1Wn2qwMp1gjeS+FiQM7S0aXYHcqcob+kqhxQU5KckluMFm5Uo5BjQ4xX/8K9+b9zgWEd9Tv5BdAHr5C3ZPCR7/J1YmeIoMEYZzGe/XzVHWUtvO73ZQKfzB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825532; c=relaxed/simple;
	bh=12v/B1njx1GkSjd81wSRKVs6DUKXXXdOGDYz4vDwGeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrPxQ3iK7eAiT2/gX7KvS3yC9fyFiFq93HHJAozORHDQNBsd3z6X2c9PhxN3TpltDcdUYhpFb2l+8Tl7BDjCUDWuatBeTfpYDDKPzTrHQUazgWoFQ2dQF5hIxvjeebwwGdRHyraSAob+RflMt0QCEmstwdQQKJR+dm8HO8k7hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltsWnabx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35402C4CEEB;
	Fri, 18 Jul 2025 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752825531;
	bh=12v/B1njx1GkSjd81wSRKVs6DUKXXXdOGDYz4vDwGeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltsWnabxmqTT2JCoEYE3IoT1RdQw0tobW7lrwo0mCF/3jla/11w3ueRvcSEjH5yae
	 xQv1gBtIesBR4jOUyoqIyYyzCLvE+iBT8xU5aFpxqJgkvSNJLz8xmr6YeyJRHIH8H3
	 92T/1PQqIybmqK7KNmSqQRPSnbvLbK1cDKiITOsOKY84B7RTauPwAPcV8osgUkqznv
	 njXxqGzZgAuydvHPLvzKcgLPqCzMCJ4K01HniHj0opAk7pIaxXsJ0Vxh5eBOiy8KMa
	 lR8/MqNNYyIDyoUIDkHxdmf2EKvvZAaZRYM7ZoNmMamaFpgqXp09w74KKpZkUlhh3J
	 0M5b/p7N9J5Tw==
Date: Fri, 18 Jul 2025 13:28:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jeff Johnson <jjohnson@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 0/6] PCI/ASPM: Fix pci_enable_link_state*() APIs behavior
Message-ID: <imlq2j5wrjjagm3y6t4zfsbsal75vok7mr4lw3aexu7eerfbsk@utkcid56k2u4>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <f3374104-684d-48c7-9e2d-e97dd48700e9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3374104-684d-48c7-9e2d-e97dd48700e9@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 10:11:27AM GMT, Jeff Johnson wrote:
> On 7/16/2025 5:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > Merging Strategy
> > ================
> > 
> > Even though there is no build dependency between PCI core and atheros patches,
> > there is a functional dependency. So I'd recommend creating an immutable branch
> > with PCI patches and merging that branch into both PCI and linux-wireless trees
> > and finally merging the atheros patches into linux-wireless tree.
> > 
> > If immutable branch seems like a hassle, then PCI core patches could get merged
> > for 6.17 and atheros patches can wait for 6.18.
> 
> I'm fine with either strategy. In the first case I'd merge the immutable
> branch into the ath tree. Note I plan to issue my final PR to linux-wireless
> for the 6.17 merge window on Monday, so we should close on this decision soon.
> 

Looks like there are a couple of things that need to be fixed before this series
gets merged. So we can defer the whole series for 6.18.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-43837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C406CE96CB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065E6300D410
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29573212557;
	Tue, 30 Dec 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4w/nnIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2216EAE7;
	Tue, 30 Dec 2025 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090962; cv=none; b=SQ3TxfVVOrrrqXGVBZPYGm93sQoIHvTEx4SRWnWVNU/3nEhmRYvLsoK9SEkkP9b9qgbVIYqbqmg3gRZywxjopMq6LRovSsjq0qW9PDaVc7aVtfQkI7FSaCqO+mJQ/Fti05BBUI6mwIGwtQAivc1AR7gqT6GXiXOPIkjm4AyTNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090962; c=relaxed/simple;
	bh=Gn3RwqUQBzB5nVQ0sZWaLT/mNNpxI1bWWgHK3485eIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlM2a3h0H1OMqLMa83msa7Lfe0o8a1ZHZSusJtELwJ1nADT3cslemCn6OqL2ilylkoNZZL4WzTwfuS1IT9W1HmXarHdeuyurGwM/vWp9t2eaL1rB5g7rctjdXXb4zeey/2DF+4KHfr+/9ZhClqlFPMeNedw9cR6Z0/oM8jDIdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4w/nnIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFEBC4CEFB;
	Tue, 30 Dec 2025 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767090961;
	bh=Gn3RwqUQBzB5nVQ0sZWaLT/mNNpxI1bWWgHK3485eIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4w/nnICKw/TEupGp7JyyrW00yk/mYtZVwS9KRygfAJ1Oiy7rFDCN7EJ0XjEXIRSL
	 5UH2Wl5rBjNFWsjUmNpMJQAJBYt8wbv3Nq7t2B4ZBFZ2oC/dWEaN+cFDVA3rq821ad
	 jGmsQbHGwZ6S9opO+Np2ibHtKyFClDjderhCjNIooai6rujrgVSEzJDrmMT5uLJ2xx
	 majXxT5xODLlhQiCp1OkgErEbThnX5hkGBlqp71pyIwb6dkT4DkKoYxGsmuWJ3Gtyq
	 69Gb2Gu/7p3ivFXsADz2EvMMJ2nx/2fOm4aPet8yV62o7Y+fqkh+cqO9eiDt0jc8ux
	 OMw4Q6P03xH5g==
Date: Tue, 30 Dec 2025 11:35:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 0/7] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <aVOrC85Y6mCYU8xL@ryzen>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>

On Mon, Dec 29, 2025 at 10:56:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI controller
> drivers.
> 
> Problem Statement
> =================
> 
> Currently, the pwrctrl framework faces two major issues:
> 
> 1. Missing PERST# integration

AFAICT, and from reading your reply here:

https://lore.kernel.org/linux-pci/ibvk4it7th4bi6djoxshjqjh7zusbulzpndac5jtqkqovvgcei@5sycben7pqkk/

  I suppose maybe you plan to enhance pwrctrl so it can assert/deassert
  individual PERST# in the hierarchy?

"No, that plan has been dropped for good. For now, PERST# will be handled
entirely by the controller drivers. Sharing the PERST# handling with pwrctrl
proved to be a pain and it looks more clean (after the API introduction) to
handle PERST# in controller drivers."

Thus, it seems that even after this series, pwrctrl will be missing PERST#
integration. Perhaps the cover letter could be rephrased to more clearly
highlight this.

Because it seems a bit weird that the first point of the problem statement
(missing PERST# integration) will still be the case after this series.


Kind regards,
Niklas


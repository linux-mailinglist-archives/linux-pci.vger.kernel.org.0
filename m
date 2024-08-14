Return-Path: <linux-pci+bounces-11665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4239518C2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98981F22ECE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14E1AD9F7;
	Wed, 14 Aug 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obdqopNq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895C13635F;
	Wed, 14 Aug 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631316; cv=none; b=S2wNbVTROIKuL6XsP9yZrG4b/uRa9fpRA1dl89IEBvA1uRKAxAh5DZt8IOCn+n7IceQkzGhMypgf/b2e+Mlv68XYfrZ9WT2rWxq2t+BCjqgFzzVM1W+5773iN/+hBUO8Qvi5w11B4XE1+RBqXp17+ToQNePn3GQcmcmcVl+KnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631316; c=relaxed/simple;
	bh=/Lcznk3da7g94xZtCQ5cxTTJAEI66N7UxbuMv7+cbZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJlZEklYbCrTLlgUaP9tJ2iG43QdH5L0aQ2vgosXyjiGGk+ZVVMtaQicHzLSz6F3RrIc58MdPhveKtigBYUfKd7kDSKBxgfRwWjY/GO+j1KSiGWbehT0jLRYDDCa1Fu0Af9scGwhFpCa2wJAYppNVUqDfabyN3rvygodc6FCmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obdqopNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6980FC32786;
	Wed, 14 Aug 2024 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631316;
	bh=/Lcznk3da7g94xZtCQ5cxTTJAEI66N7UxbuMv7+cbZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obdqopNqKkBpS91il9xY2v6m/Uhdz8EUjJbAuOfe0rKXcEl2VT4KUl+TgHfluY3Qg
	 TTRh7Yw0j9Wo5Mld8bO/pIQFrKEmn0i0MBE4qxPfR81apCuW058AU8sWYn3r2H1i+A
	 tD6Fh8anXFk1BSILPb0lFDSE23Stb1KR4CmzyZIIfQ+Z6IbIPpyBmCOZaeHh9B475l
	 o563VfAX/rKjQ47q/hhOtLsBEFGqUkVeucgn1qf46K0zAbwtpyIJEnkYavZ6VvZrKD
	 69ZKABBOU/IlicKYesXhqoO3j9vwp/AgDWynvcW9SjgVMDUtL3H/MJHUyyOATR3Lbl
	 SQTyYsZ9j4kJA==
Message-ID: <199ebcaa-c5c4-469e-b62a-da45389d7a7f@kernel.org>
Date: Wed, 14 Aug 2024 12:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: add support for WCN6855
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240813191201.155123-1-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240813191201.155123-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.08.2024 9:12 PM, Bartosz Golaszewski wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add support for ATH11K inside the WCN6855 package to the power
> sequencing PCI power control driver.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> [Bartosz: split Konrad's bigger patch, write the commit message]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad


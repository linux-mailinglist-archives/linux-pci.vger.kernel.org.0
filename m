Return-Path: <linux-pci+bounces-27637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB7AB56B8
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B9E3A741F
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1A1F1932;
	Tue, 13 May 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfyJWelT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56D1E883A;
	Tue, 13 May 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145228; cv=none; b=upAjqJudjxw1FsA72P5LkdvSw2knfoqHV/37tq//ecC622tSLjckjj/TP74NxWYfAN+9AnMygK8/egeAB/3KecKosL7moPuIRpEZvUSEKuJfOC/dO32VsgCzwXWTiRUOdG3QMw/OMWvMdl51wmHswevV4DG4d8DG7TrNyjKpQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145228; c=relaxed/simple;
	bh=14NlYj/WRG8Q0M9cGAjhUlbL7est4+1nXlxlO/Sw13M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPvd46A1PPCcPj4zh5gqXSlDaj3PsnC2vOh9j2xbZcIQ4xjfJhJrHvhBNobsjirrZ6cHdl2YpzuOCrjF7L8E/SmvFQYw9ByFhGYmDyGj9kXcgxExvW3gwb25CeAbJsmXMgFpRwnJFI87xCFj4uZodzdLxvzzI/7ax89MquS1Fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfyJWelT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CFAC4CEE4;
	Tue, 13 May 2025 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747145228;
	bh=14NlYj/WRG8Q0M9cGAjhUlbL7est4+1nXlxlO/Sw13M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfyJWelTw2cvqNxTtFvNddGoQgPxSGnXDfgHyD7S1pRovdUiRF/RrEDtGkMMA9DqR
	 0pE2hIGsEcSog39LlatonEh8jFUsdkLIxu4cn3qQWN8jdpdH+481B3gyvxHJ2M/Xf6
	 XY2cAVg4GaVUqm6IJ9V7w+Sg0ZtJLI/1ftHViBLYDwssJ/39DCw04qoWn3jykvHra8
	 MzaSWCbobCvW2ZSYrVFLa53JUcsFuME2YlaZnGxvVNNYGY4EI2eounHeNcqtryUUOG
	 UniSDHJRyX0NXHUCd4pd5M56pd+FakfGKY+FviDSDrJAR4WiPWyMFcLqT+CBTYYkww
	 JzhK9J0WfRCPA==
Date: Tue, 13 May 2025 16:07:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <aCNSBqWM-HM2vX7K@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org>
 <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7>

Hello Mani,

On Tue, May 13, 2025 at 11:53:29AM +0100, Manivannan Sadhasivam wrote:
> 
> This wait time is a grey area in the spec tbh. If the Readiness Notification
> (RN) is not supported, then the spec suggests waiting 1s for the device to
> become 'configuration ready'. That's why we have the 1s delay in dwc driver.
> 
> Also, it has the below in r6.0, sec 6.6.1:
> 
> ```
> * On the completion of Link Training (entering the DL_Active state, see §
> Section 3.2 ), a component must be able to receive and process TLPs and DLLPs.
> * Following exit from a Conventional Reset of a device, within 1.0 s the device
> must be able to receive a Configuration Request and return a Successful
> Completion if the Request is valid. This period is independent of how quickly
> Link training completes. If Readiness Notifications mechanisms are used (see
> § Section 6.22 .), this period may be shorter.
> ```
> 
> As per the first note, once link training is completed, the device should be
> ready to accept configuration requests from the host. So no delay should be
> required.
> 
> But the second note says that the 1s delay is independent of how quickly the
> link training completes. This essentially contradicts with the above point.
> 
> So I think it is not required to add delay after completing the LTSSM, unless
> someone sees any issue.

If you look at the commit message in patch 1/2, the whole reason for this
series is that someone has seen an issue :)

While I personally haven't seen any issue, the user reporting that commit
ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect
Link Up") regressed his system so that it can no longer mount rootfs
(which is on a PLEXTOR PX-256M8PeGN NVMe SSD) clearly has seen an issue.

It is possible that his device is not following the spec.
I simply compared the code before and after ec9fd499b9c6, to try to
figure out why it was actually working before, and came up with this,
which made his device functional again.

Perhaps we should add a comment above the sleep that says that this
should strictly not be needed as per the spec?
(And also add the same comment in the (single) controller driver in
mainline which already does an msleep(PCIE_T_RRS_READY_MS).)


Kind regards,
Niklas


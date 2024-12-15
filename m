Return-Path: <linux-pci+bounces-18461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2FD9F24F5
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330CB188586F
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A261199252;
	Sun, 15 Dec 2024 17:20:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5354C80;
	Sun, 15 Dec 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283233; cv=none; b=ck4GWTQcpD5UBetrtIqi4zDCl56IQlRj8nicKKjCtVAARY9wc9yP5jz/pHX8wO5iahjmU+FF7IH4LsnKBoRZ12JNaQRyLlof2yIXnKL67m9ByLKy1wQ54iWDRG4g4O0t1MYy3it2vCdrtKrT9+3HozxmoVK95zj0Tkeagfe7YM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283233; c=relaxed/simple;
	bh=9jT7GMINdAwYPgKGwV+UTR6KGKBjxDK1/+5ETBaRoJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzLrDXfQOqbruxKMnQaa7kT21p5KGObG4OpPAUlHIF3GDxVUaB5/b2PXHHMdp21GSSy266tNb8ihNmLMKixITMmpcQGD9TcW3JD3mtxdGNeE28L2pg9roPu/I9+obAlfFiD8CEDfNiSWOALy4K08D+ORse/9ElAzyFyeAoIQAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 314C03000D5CA;
	Sun, 15 Dec 2024 18:20:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2956F4A8140; Sun, 15 Dec 2024 18:20:27 +0100 (CET)
Date: Sun, 15 Dec 2024 18:20:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 2/4] PCI/pwrctrl: Move pci_pwrctrl_unregister() to
 pci_destroy_dev()
Message-ID: <Z18P2-FchianimEL@wunner.de>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-2-eae45e488040@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-2-eae45e488040@linaro.org>

On Tue, Dec 10, 2024 at 03:25:25PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> PCI core will try to access the devices even after pci_stop_dev() for
> things like Data Object Exchange (DOE), ASPM etc... So move
> pci_pwrctrl_unregister() to the near end of pci_destroy_dev() to make sure
> that the devices are powered down only after the PCI core is done with
> them.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>


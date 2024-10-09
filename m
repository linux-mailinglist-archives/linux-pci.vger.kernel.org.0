Return-Path: <linux-pci+bounces-14109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620599766B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 22:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2937B28176D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD91E1A0A;
	Wed,  9 Oct 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUx+NO/N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F029161313;
	Wed,  9 Oct 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505523; cv=none; b=Toti7RTLLnBF2uB1G2XkqInJjPAZlt7wzePhxZNOIm3FOOWUfPpE26zDGPS8N05lNBvjo7ZAC3LVCOIOvE8CIs6Hh7J16oub2X/i63smEqKf9F/QHfueha0fwNf/AENfYC2I+h1urYRuTIsSITgZFYOjr1AzE1X1kqa4iC0b0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505523; c=relaxed/simple;
	bh=9DcWRqzRXQ7bjuDcrr4wCjK/5kicZsX5VMPHI05/h6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW6v1v7xn5xWkxT7fuwdbAUAnTpAAU4z1yz2h26GTA5v+MC/jWoXDYlpWcZ6jPWoe02SY3k4ICbGT0zd1OHu1mWbdix6yFF9G85gbprCu+ycY+yuNraakNbI8/rDx9oIxUhCD5G7w9MAhL4lztVERcwIBYO3B8Cqgib2rKJoMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUx+NO/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDA4C4CEC3;
	Wed,  9 Oct 2024 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728505523;
	bh=9DcWRqzRXQ7bjuDcrr4wCjK/5kicZsX5VMPHI05/h6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUx+NO/NCskAYhlHNu0yu/+6op5AwZFKFcNiDh0IHtwF5IcU9CGgua7scNlOXbkcS
	 aHEHby+MK4Xr1CrN4gDMBE0DmaymLdLumYwkhe81Sh5zjLJ8QtJHcMOpLImQebl2MS
	 jIrzgL45AciurmR+cSj9GNKrLHzEXvNdRb7q7Y6QBhRNLqFLOPn0DasqlTIqkYq/Uz
	 pJLWG5cpqITuHNFLDpqJs/JdCEHmMwzGcIZtwIOEAgia9+eNrwZtCI40MCqUDUQ7aa
	 2IzdXQuipvfXbLXZ7PXpqOkIj+J407heML2kja2gXD4ZkfyqWgn0vbiTjNTvUywS3i
	 8DCiyt+udTxpw==
Date: Wed, 9 Oct 2024 15:25:22 -0500
From: Rob Herring <robh@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/7] dt-bindings: PCI: qcom,pcie-x1e80100: Add
 'global' interrupt
Message-ID: <20241009202522.GA611063-robh@kernel.org>
References: <20241009091540.1446-1-quic_qianyu@quicinc.com>
 <20241009091540.1446-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009091540.1446-4-quic_qianyu@quicinc.com>

On Wed, Oct 09, 2024 at 02:15:36AM -0700, Qiang Yu wrote:
> Document 'global' SPI interrupt along with the existing MSI interrupts so
> that QCOM PCIe RC driver can make use of it to get events such as PCIe
> link specific events, safety events, etc.

Is it required for some reason vs. being optional? It's fine to break 
the ABI because...?

Answer those questions with your commit msg.

> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-x1e80100.yaml    | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)


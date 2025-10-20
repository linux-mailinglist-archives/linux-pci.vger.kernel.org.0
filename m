Return-Path: <linux-pci+bounces-38714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B9BEF83B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB994EC8DB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FF2D6E71;
	Mon, 20 Oct 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8wdyfNs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EC35950;
	Mon, 20 Oct 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942936; cv=none; b=JgvcqlG6/tZBZLuD67t34QI0zfZ5xHsS5K3x1Xrd6DlOi/qwq7zMF/DpdPj79v2R6BRhO1yL155AGwXCtoGTopkqK/tEBckXxftFvSPG1+nPxyGMEB7yZI0FpH8HKT1+EzxLpymC0jUkIZqwps+fcSp8LnmocXuIU5RJT3AJUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942936; c=relaxed/simple;
	bh=Iv/5iWY5nZgg3nkkN0LA+0Joncb4DUQdG2wDhxXdaOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SAT+b/5upBd9twsimLkrE8ykywUrfUCKmr8E3FDP6dbsxJNCKxsc5Siv/Qe1ZlYvOCf48i2jyF59lWOF5ccwiHfVbRDLSa9raDdc4XT+izvijCMR3gz5k8UB/BsvgHClQ/Sb4tbcszqx2kk6l9PvLpVsJvuC5cRPeCp4p0ZUDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8wdyfNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5C1C4CEF9;
	Mon, 20 Oct 2025 06:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760942935;
	bh=Iv/5iWY5nZgg3nkkN0LA+0Joncb4DUQdG2wDhxXdaOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F8wdyfNsAQO5RrxHosn2NmUkErkZfu77XMbnNZ69elG4DJmNwFMYK5RthmmMHGs5R
	 0P3EmcJaPG3npRrD/tULFvayADEjOnvzZzqDYJrCCdDIKXa+Qt0hMioxHu1ZRcstV4
	 aV9moaLdJgnb2fSs8mnnkJUHLHcQNJOwWAo9B+dcy1Oi7lAnOcJu1ZK6s5g8CI2aCC
	 Bt2dTAQu0INm+gukGoxorF4ZDYMk4caIUEkpjnPxsrdL0t2dDziel0j/93yg2pqv4B
	 V+40E5GT8Yo/awfH7alaPMHnovB/hnJFvLSaBK451F1mETVaNeTW+CuxdFm0dgaZkv
	 kVOSyGB4f+tMA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com, 
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251003170436.1446030-1-james.quinlan@broadcom.com>
References: <20251003170436.1446030-1-james.quinlan@broadcom.com>
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
Message-Id: <176094293138.11548.16893576609668956400.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 12:18:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 03 Oct 2025 13:04:36 -0400, Jim Quinlan wrote:
> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
> setting the private PCI_EXP_LNKCAP register, but this constant is
> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
> the value of this constant was correct for its usage until after 6.1, when
> its value changed from BIT(1) to BIT(2);
> 
> In addition, the driver was assuming that the HW is ASPM L1 capable when it
> should not be telling the HW what it is capable of.
> 
> [...]

Applied, thanks!

[1/1] PCI: brcmstb: Fix use of incorrect constant
      commit: ad6014f77f6b66e862a912b5aa4571d00ab30405

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



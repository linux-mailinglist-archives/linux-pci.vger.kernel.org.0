Return-Path: <linux-pci+bounces-39341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE3CC0AD3A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA73B3798
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC61218AB4;
	Sun, 26 Oct 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA/3cP/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E131A3164;
	Sun, 26 Oct 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495922; cv=none; b=Af5YKKAlRVc/G33BY9+cxfr/WA/v8pSiNaa07EZmGVrCIvSqKjdUMRGIIVkhMiLSF0AIDvhS1hpdMsf6D3KGqMvxFdprRbAbv8pw/VUhjzXWqPhqpV4kcNtWi38WD8d8olYuDLomT/8Z+Uj8xwtQDzwEXuiN9l+r/yY7qzHle+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495922; c=relaxed/simple;
	bh=DikEa8xE67jkws0rn4mR7GB+wN95r6F++Z1Hk3eVkxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FEgo1G3d9WMc63slnL27SudM/iVE1XuGdGjwiGdg4T4cxgbukbvoU6v/bxTE2lAwQUExOK89ADd1QHEqSCKgxWxUz3nrZ9UMitLZ6tvAwxd9pv3zNPLbTARi+XUpKCmpiYRzVHQe7o6QlrNPhqPxJY7O6sZJIbPiJM9QddT6v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA/3cP/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9735DC4CEE7;
	Sun, 26 Oct 2025 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495921;
	bh=DikEa8xE67jkws0rn4mR7GB+wN95r6F++Z1Hk3eVkxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bA/3cP/sXX/waOGuGxLsTvMzZqd9d4wxddoiFK81KqjMJ2RmCpJtyJTpOE77YY7kx
	 3NJusjMiK9p3SHV7bdkt764ak9QdNWeRKWHZmvgkqYpDrBohXsHYLSdksyC7r+xsoN
	 EVVmdulDAiEr8xq6cQ61JMD36H2dcOOCx1wVNPFSbcuBdq4D3386W7kk4LkBb57Ae5
	 GyO3kntFK2+348aEiHf7cNTsqPoCZrRWE6L3rkTq3qPlcnKwtuWLA8unK+gJZ/9YO5
	 IBRcy1V2x7YSNOr/09cJwQv9Rqi6Kf1iuk9+iwJP2rH/3WNvhhwVes/6fsoY2wTc8b
	 PXZCBCdlqSPFQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/5] OPP: Add support to find OPP for a set
 of keys
Message-Id: <176149591006.10971.7983731194295176421.b4-ty@kernel.org>
Date: Sun, 26 Oct 2025 21:55:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Mon, 13 Oct 2025 16:23:27 +0530, Krishna Chaitanya Chundru wrote:
> The existing OPP table in the device tree for PCIe is shared across
> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> These configurations often operate at the same frequency, allowing them
> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> different characteristics beyond frequency—such as RPMh votes in QCOM
> case, which cannot be represented accurately when sharing a single OPP.
> 
> [...]

Applied, thanks!

[5/5] PCI: qcom: Use frequency and level based OPP lookup
      commit: b673c47c9cb186f7008944ca708d2313a38721dd

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



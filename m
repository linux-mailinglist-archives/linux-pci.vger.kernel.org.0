Return-Path: <linux-pci+bounces-35664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895CDB48D89
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39C33B9F51
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F42FF645;
	Mon,  8 Sep 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXMyaFuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668594690;
	Mon,  8 Sep 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334674; cv=none; b=PdFD18k38jYcTaAXM5LGFuQFZxTr+M83AO51Cghz1HDRshL8PSq3wyyvAYm0/vx/11rmU/SsFaq516d9BF0ha+hRAQuh0/W1mKyrAb3OUA2e+MY5n7EOWv6r8KPTjfUbizqTYVkpHNR60E/dR7ujocXhUrCBON6X3mRYNJrcLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334674; c=relaxed/simple;
	bh=4BlAT6O6nDuMl7JxdSAqapZvimpnAM67d5Wt4tnaQFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MVYL/VYWBHswKoBrHoA38ED8KnPjPNUziz4gs5m9UTy1I8II/mPTYbKjyzVXrALwx47khhTCT75kWf8lnonoH72J0V4A8H8kYtomwFLwaElE4Ozwfy3+4C+CBvjadmWmnC6FhYyLnUaDBOnkYvtRlO3uSDzqNzW6l0qqA8TPhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXMyaFuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4554C4CEF8;
	Mon,  8 Sep 2025 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757334674;
	bh=4BlAT6O6nDuMl7JxdSAqapZvimpnAM67d5Wt4tnaQFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MXMyaFuQzRtryqYbXQmWsvDdbaCY/JaBYISHCzavD8CfWjVIaHcRMuk8vKvxKgkyh
	 0e77+QczsByDdgTQu4nwfV3plxC1DxMC71xNmYUEmjc7OmrCRkiTl6RyRdsf9eVsUh
	 QqkFC0AAYF2U4OOuJP23VsOTUwinxumA4/TN4kqlSNtqxrA9j49nLMQh1aqXkRcaYM
	 qq9GUinHHoRn5N6meCYRG9bXo5UsMVWSUb3BJBNRT1EP6kRcKvvNCSKYHQTu4xFoPC
	 /k6KoJc8+IWh8VN864MxOSDzWMN/GmyloMXQuvWSC3ufOBHc8VDypqwWH6txGRfjn1
	 IX6esRTiKENfQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250905184240.144431-1-marek.vasut+renesas@mailbox.org>
References: <20250905184240.144431-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Limit PCIe BAR size
 for fixed BARs
Message-Id: <175733467033.10254.12972405823164212308.b4-ty@kernel.org>
Date: Mon, 08 Sep 2025 18:01:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 05 Sep 2025 20:42:10 +0200, Marek Vasut wrote:
> Currently, the test allocates BAR sizes according to fixed table
> bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
> does not work with controllers which have fixed size BARs that
> is smaller than the requested BAR size. One such controller is
> Renesas R-Car V4H PCIe controller, which has BAR4 size limited
> to 256 Bytes, which is much less than 131072 currently requested
> by this test. a lot of controllers drivers in-tree have fixed
> size BARs, and they do work perfectly fine, but it is only
> because their fixed size is larger than the size requested
> by pci-epf-test.c
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs
      commit: db4291ba733d857f2326db88c5c41ad6072350e5

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



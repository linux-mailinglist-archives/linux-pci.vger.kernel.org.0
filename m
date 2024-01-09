Return-Path: <linux-pci+bounces-1957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55A829105
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 00:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B4D1F26974
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06B3E480;
	Tue,  9 Jan 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFmMbJZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349B3E47F
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 23:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF5FC433C7;
	Tue,  9 Jan 2024 23:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704844310;
	bh=NKZJA5qP3omuPD1SaRMmUKrZJGBrATmmJgUSRDrq2so=;
	h=Date:From:To:Cc:Subject:From;
	b=ZFmMbJZBN+whNTq/cG7RU3BeCYpsat/W3E1nBQkVlBQ6UFmtCX8mTd7wVQKY2FfHE
	 kY9mzn38SW5Kh2EKXDotvUSU5PMoyf3ZIvwbKm6cE91+skhADEzJjjdzZ48WsobSgp
	 LBa1vMcfqIOOkeHO5rXslCdB8Fn87f67MLWEEW6nCNskchpxM7GSHQNv9Bfe1dko3Q
	 o5vbOTJSXxcwTdisDOEgN/WaCKI5FFzqFnLTiqtHfkYAX21fFEEQewtrihwiz6zRcZ
	 tv57zAaTzIJ4hR2D6U9NMOMzjoffPIEsSdeFYaOU8uLB7pstC21HasE7yl/MbcF27V
	 QZF7Dqc/ftj0Q==
Date: Tue, 9 Jan 2024 17:51:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: mt7621 static check warning
Message-ID: <20240109235148.GA2082000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Sergio,

FYI:

  $ make W=1 drivers/pci/
    CC      drivers/pci/controller/pcie-mt7621.o
  drivers/pci/controller/pcie-mt7621.c: In function ‘mt7621_pcie_probe’:
  drivers/pci/controller/pcie-mt7621.c:228:49: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
    228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
	|                                                 ^
  drivers/pci/controller/pcie-mt7621.c:228:9: note: ‘snprintf’ output between 10 and 11 bytes into a destination of size 10
    228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
	|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I know we'll never actually hit this, but it'd be nice to clean this
up, and I don't think it would really cost us anything.  I think it's
currently the only "W=1" warning in drivers/pci/.

Bjorn


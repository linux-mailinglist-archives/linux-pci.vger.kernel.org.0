Return-Path: <linux-pci+bounces-31762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608CAFE685
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA794B40001
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21E28DF1B;
	Wed,  9 Jul 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckQ2sdyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF426B2C5;
	Wed,  9 Jul 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058302; cv=none; b=DzogpCWdGVS/9AH+dNCdeAG98EYSgViN0RFT/SDy11VOjbXy/ogdSAsy6LrPelUjPPsuK0WAyr+kw52h0ZqFlrxRhgLCyGGQdCL+BukBDYhzws/eXil6MABDD1NoGBvnRDqPmTNqYN7mKG4D4bv3PErgFqT0BrrMszZwhViGEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058302; c=relaxed/simple;
	bh=qAUK7viesmCzXnvyWbOktp1Rz2GDjVZ2nxGYCXWgIkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnxZMZ3v8D4hCGu57xNFd1BR/sD/KBdQGt56F3Zve4yE4hEQQG5OmUpb5M8p/a6uJE0/hNwH7uNMil9fGi60Thp2iWzqjHi5Ip8+bFTJB3N2ChUCIm8LjDqhyDKBVhhGjUjzOcX6bTVD/SG4Rt66DZu2XsNhg2TTXz3OqV0TrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckQ2sdyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE60BC4CEEF;
	Wed,  9 Jul 2025 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058302;
	bh=qAUK7viesmCzXnvyWbOktp1Rz2GDjVZ2nxGYCXWgIkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckQ2sdyQj4xgiNHAfYOrrB4A5q5oSn0J3W1uGXD2ppUVRAg9T/G8E+xU+hWREAWwg
	 5ZZ+iXjqt5l/nBXnZF47nUMQqsXDozon5BfIT0nhRwr6lY6bsg56pmuSYZG1oP3VEq
	 /opo8/gbGEFgzyE986yo+UeSaebcTIoiD0A7Dp1QiPOJwIT3RtV8V8Z8S5/IdtALHL
	 DRC3L+HhkEFtKDzg+6xYFdyxWwgGYm2gY4DDmncgftyiLgvotOeLX7yl2N+XTvZGfF
	 s9fXECVF2ffz5nHl+aJa/ZMX1XjfP8H73fBNn+0mf4zlFdAiYu4X7M//MTe0dMVtZR
	 FFXSk7H8Z7qUQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix MW2 configfs ID
Date: Wed,  9 Jul 2025 16:21:28 +0530
Message-ID: <175205817756.10340.17764622266957166451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250709-vntb-mw-fixup-v2-1-27c14df6ed5b@baylibre.com>
References: <20250709-vntb-mw-fixup-v2-1-27c14df6ed5b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 10:20:39 +0200, Jerome Brunet wrote:
> The ID associated with MW2 configfs entry is wrong.
> 
> Trying to use MW2 will overwrite the existing BAR setup associated with
> MW1.
> 
> Just put the correct ID for MW2 to fix the situation
> 
> [...]

Squashed to the offending commit! I also fixed below sparse warnings by removing
the __iomem qualifier for 'mw_addr':

drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17: warning: incorrect type in assignment (different address spaces)
drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    expected void [noderef] __iomem *mw_addr
drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    got void *
drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21: warning: incorrect type in assignment (different address spaces)
drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    expected unsigned int [usertype] *epf_db
drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    got void [noderef] __iomem *mw_addr
drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38: warning: incorrect type in argument 2 (different address spaces)
drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    expected void *addr
drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    got void [noderef] __iomem *mw_addr

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


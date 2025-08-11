Return-Path: <linux-pci+bounces-33716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08862B206E8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BD7A7A5A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2542487BF;
	Mon, 11 Aug 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Iq44Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAC23B610;
	Mon, 11 Aug 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909854; cv=none; b=sOR0ZWpFEEtLPdRyDG4x3U9G+D7DkhrCCTTr2ZCf1fIqrLtzpQawDYpWHLHy2Rf/iLA2Nz8A2EhZJtkzCVZnP1stsTbJ76r0W3kt/dqyDPP2fFBdxIK+I1EAHA8zkiDZCCQmvnLy3MWQ+snK/OrYcqEAMU0hNvlm5GZN3KhST28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909854; c=relaxed/simple;
	bh=1Q+vyX1nLRStwxxfy0pRgDpEcJp5TmEWYoaxp7OM3VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIg4kCkZ0zkR6veHYbujte39oss+yaLlAmiXYNGWeZPC9vn95KCBENVVLtoybm6ObKXPRMyw+RJGKDMgHJOEDdWJmq/XTw33V1miS/B6f4+nZ8NwDeJ6E9gitqC92o1yfTJfcWOF+I5fqZWgJ5T25Cya51lVDVFTM0l/SEjDbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Iq44Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA5C4CEED;
	Mon, 11 Aug 2025 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909854;
	bh=1Q+vyX1nLRStwxxfy0pRgDpEcJp5TmEWYoaxp7OM3VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6Iq44EgaZlm+gd+IUExE7djzbUBb/OsX06TeAenutDVfRQXLhHSJa807LUET2y/y
	 dcnqr+SgpfXenvQtxo0X7WL/wsfFxhRFSXhJdMSRF1KXpV4p/DJjsC8qmdQgdAapTU
	 Fxn98x2XBTg2tCStCV0NGJ99H0OXXifc5JiMph6e5Hml2uR40/ry+vUbR7/WyogkbJ
	 yRRyeKdiDw1OYhfh5w9QHLgn933n90GzC38eY4r2s5AlJUq9gRkR/h5AQWU+y8GkO1
	 qfYmZjfIZmy7f26eTA7YBOoQB8kbnt7vSwIYoEP70IfESXE7c3QmA0+xKqyxiANM11
	 CsxfpwNCzxebQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 next] misc: pci_endpoint_test: Fix array underflow in pci_endpoint_test_ioctl()
Date: Mon, 11 Aug 2025 16:27:24 +0530
Message-ID: <175490983721.13838.10042092672738483937.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <aIzzZ4vc6ZrmM9rI@suswa>
References: <aIzzZ4vc6ZrmM9rI@suswa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 Aug 2025 20:03:35 +0300, Dan Carpenter wrote:
> Commit eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
> added NO_BAR (-1) to the pci_barno enum which, in practical terms,
> changes the enum from an unsigned int to a signed int.  If the user
> passes a negative number in pci_endpoint_test_ioctl() then it results in
> an array underflow in pci_endpoint_test_bar().
> 
> 
> [...]

Applied, thanks!

[1/1] misc: pci_endpoint_test: Fix array underflow in pci_endpoint_test_ioctl()
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


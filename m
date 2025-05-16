Return-Path: <linux-pci+bounces-27884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A9EABA203
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AFD1B6123D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA68272E75;
	Fri, 16 May 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkzQErQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4D25CC77;
	Fri, 16 May 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417310; cv=none; b=DShxqFMAddL91DJSJ6wQHugKETF1HM8hy0+Dbs3xT+/r748nD43BjIMSgbgAvjyBTDApsM9ATFYF7JXvGqmweusbGbErxxeJgS4RqW1B6yrvw5WCtXEJYahSTaYl95VZfNKOeWB/L6JwcnwhQErowNEgti8FVB7HGee3qmM9a5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417310; c=relaxed/simple;
	bh=FqfDVZ8sK98Vx3ih8ZP0NXhSIP8giKOMw4w7k8L3Dug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0shHuw9X1lI0jg6onqPDJHL5sVxXXtImtEu3gORnHElwKHXQHEdnPTUxB2Z3RmdRuN6FvYejq/j8jatoHzVHQ/CzF2io/I+rtMv1N1yST0oTZMl8ZUsP4itFvLsC0OQrgXJj3tvKXJsS4q7Z3HQIZTd/taSACAYnXsEYSwI0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkzQErQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE4C4CEE4;
	Fri, 16 May 2025 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417310;
	bh=FqfDVZ8sK98Vx3ih8ZP0NXhSIP8giKOMw4w7k8L3Dug=;
	h=From:To:Cc:Subject:Date:From;
	b=JkzQErQbKVJyIeMPEtPEPhj/JO9Oo5nffZxbFSfVWYNu0WQ+pK+k1pN93CdkH4T1h
	 LlrjOcrfH65Wz/e2VSywpqSw5uL0zin9tZGuuQ1FEO/XIC6P5lRnHMgG3lYLmwv5TM
	 frzOh+AJe7tzCPWXjxSnl4lEMMna6BustnDNLacpRYcV2AfvnefordFIxI61LKksLa
	 ivhwU6U0y+8Nd1t+xlxMGYHXNEw11R5tAQszibBYA4o8frtZ3stYivVi1e1II7Xyty
	 qOpicbCCF5wyrKLBsVOhvRfESnRQWja2oAK3MycyXmsvz2eFgxGAgQLMVnEDNsv7Di
	 yFcWJsSrVu1VA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/6] PCI: Remove hybrid-devres region requests
Date: Fri, 16 May 2025 19:41:35 +0200
Message-ID: <20250516174141.42527-1-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Drop patch for removing forgotten header. Patch is unrelated. Will
    resend seperately. (Andy)
  - Make docu patch headline "Documentation/driver-api:". There seems to
    be no canonical way, but this style is quite frequent. (Andy)
  - Apply Andy's RBs where applicable.

Howdy,

the great day has finally arrived, I managed to get rid of one of the
big three remaining problems in the PCI devres API (the other two being
MSI having hybrid-devres, too, and the good old pcim_iomap_tablle)!

It turned out that there aren't even that many users of the hybrid API,
where pcim_enable_device() switches certain functions in pci.c into
managed devres mode, which we want to remove.

The affected drivers can be found with:

grep -rlZ "pcim_enable_device" | xargs -0 grep -l "pci_request"

These were:

	ASoC [1]
	alsa [2] 
	cardreader [3]
	cirrus [4]
	i2c [5]
	mmc [6]
	mtd [7]
	mxser [8]
	net [9]
	spi [10]
	vdpa [11]
	vmwgfx [12]

All of those have been merged and are queued up for the merge window.
The only possible exception is vdpa, but it seems to be ramped up right
now; vdpa, however, doesn't even use the hybrid behavior, so that patch
is just for generic cleanup anyways.

With the users of the hybrid feature gone, the feature itself can
finally be burned.

So I'm sending out this series now to probe whether it's judged to be
good enough for the upcoming merge window. If we could take it, we would
make it impossible that anyone adds new users of the hybrid thing.

If it's too late for the merge window, then that's what it is, of
course.

In any case I'm glad we can get rid of most of that legacy stuff now.

Regards,
Philipp

[1] https://lore.kernel.org/all/174657893832.4155013.12131767110464880040.b4-ty@kernel.org/
[2] https://lore.kernel.org/all/8734dy3tvz.wl-tiwai@suse.de/
[3] https://lore.kernel.org/all/20250417091532.26520-2-phasta@kernel.org/ (private confirmation mail from Greg KH)
[4] https://lore.kernel.org/dri-devel/e7c45c099f8981257866396e01a91df1afcfbf97.camel@mailbox.org/
[5] https://lore.kernel.org/all/l26azmnpceka2obq4gtwozziq6lbilb2owx57aajtp3t6jhd3w@llmeikgjvqyh/
[6] https://lore.kernel.org/all/CAPDyKFqqV2VEqi17UHmFE0b9Y+h5q2YaNfHTux8U=7DgF+svEw@mail.gmail.com/
[7] https://lore.kernel.org/all/174591865790.993381.15992314896975862083.b4-ty@bootlin.com/
[8] https://lore.kernel.org/all/20250417081333.20917-2-phasta@kernel.org/ (private confirmation mail from Greg KH)
[9] https://lore.kernel.org/all/174588423950.1081621.6688170836136857875.git-patchwork-notify@kernel.org/
[10] https://lore.kernel.org/all/174492457740.248895.3318833401427095151.b4-ty@kernel.org/
[11] https://lore.kernel.org/all/20250515072724-mutt-send-email-mst@kernel.org/
[12] https://lore.kernel.org/dri-devel/CABQX2QNQbO4dMq-Hi6tvpi7OTwcVfjM62eCr1OGkzF8Phy-Shw@mail.gmail.com/

Philipp Stanner (6):
  PCI: Remove hybrid devres nature from request functions
  Documentation/driver-api: Update pcim_enable_device()
  PCI: Remove pcim_request_region_exclusive()
  PCI: Remove request_flags relict from devres
  PCI: Remove redundant set of request funcs
  PCI: Remove hybrid-devres hazzard warnings from doc

 .../driver-api/driver-model/devres.rst        |   2 +-
 drivers/pci/devres.c                          | 201 +++---------------
 drivers/pci/iomap.c                           |  16 --
 drivers/pci/pci.c                             |  42 ----
 drivers/pci/pci.h                             |   3 -
 5 files changed, 32 insertions(+), 232 deletions(-)

-- 
2.49.0



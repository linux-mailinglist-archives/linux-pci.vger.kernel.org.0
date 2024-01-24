Return-Path: <linux-pci+bounces-2515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870383A56E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BEEB2CD8E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FD17BAB;
	Wed, 24 Jan 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwYtth19"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129D17C62
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088354; cv=none; b=BvCrwGt6tDAGabFy4XwBB1xHepkOMlXKOUurMmPGa+EYaWucSX6zKWTAVJhqVlcg7tzlS4drDArKfm31o87N2m5CPJuVxKbmdJl7XcjGs7JgMPuKx8VVdLHQ7K9ynUlw8szgOJNeIUDXFrKoXhLwEhVNr9VMztNMGG9yuALMufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088354; c=relaxed/simple;
	bh=1F7HlkgofBXE1j3WejVzC1jEouOuKxz0pQbvR90KfeY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nz9gr2tbSSL694FMk25TbOQqRp4GseSZQBkINNvVYEzCkXqtBqR00jCRUArnlEV+9IwNi/CbX4RHNn/Kimfo8aQrJ7lBCII+znJEp34S6DmDaClc1/lrz0KuyK1JTvEyMW5n9ze4JvoUXmv7TH4QBlTlLJg0wdxXLzAwDsQQvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwYtth19; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc253fee264so8318528276.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706088352; x=1706693152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lUbw6zbjk0DrdhxpyUr9w9CJtHea5xxha8H5D4GA7i8=;
        b=UwYtth19K9LJeSFucjP0Y4QzyKATriggoPhpPAq2jXknInyVTMkLpx1+Di8lL4g/Fy
         +EXzdO4k3upzFS0e1oLbZAyRakQBL2lMEsgNmS1/UqKc+hdqRQqbwFiz7NHBTafkGkHq
         zDOlvnpRSxsy1mLcL9XjAB3Ffa1g5hrUPQZNLFjSln7d0OLU/Gx2mYUjF/2f6gl3vGpu
         NUe8zIvESb6NEDnnjdkdhCXMEk1ywKMPlVZdUIYVg7D79PzeW9tldbpgvPOfVGS0k3AH
         XblEQ7bGKoguTJM15ymDe24S+oIUMj3P/ghZ9RivqbSy+wmHNyX1BErwugRqHLuJrC3z
         rMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088352; x=1706693152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUbw6zbjk0DrdhxpyUr9w9CJtHea5xxha8H5D4GA7i8=;
        b=mQxJExTrdTe1ABar8ug+t4WiOvn1vgrUzojB5x94Qo0vPq9AAoG5hKEF7JQ8azVc2Z
         DHFtIe9QorSn0/4DUJeFeiordUpiNbWDeYN2WP5OV1Y4193Yf1u9/Xf3MXFRYuXsi/6q
         ADwcqjSsg5sQn+aqcQpPU40qZYu12bb5iw1xssiK3uZLx8LGpAtmUF3RotJKzMcc/zzf
         ZrKHGx9VxLy4Ohrrrgbp5Mbo+9Ha++TGdja+TrNk3dgkAFZLFFgVy7ZkF6TFTQptkUu0
         gQxhKrqJ6xM/HlEdW4/q28oMHr0aSLt9t+XoJ3kwRGhaOK2mq8NmG7U6hkswqE/j7nmx
         F8xQ==
X-Gm-Message-State: AOJu0YxeGo0Uc0tYj5OQKbfEHfvu5DjAOwiZFUH3S/oFtKk27ujo6dkh
	OZQCjgnLMMmooatINqaKtyaFd/IIozeWIOGyoDxizXaRlgF4RN28JTjyidxn8UlOBe1biX1KUk0
	lA6zS9mbeW+MO0PmVvAMqJA==
X-Google-Smtp-Source: AGHT+IFso3WIgHHq3RI9QYrQQ9shU1qCy76kos4oL7MTwcDcChnk3YnoCtnyHU6zJBQD6l1OeeXjUvCsBAHyH5NpWA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:d41:b0:dc2:1c5d:eed5 with
 SMTP id cs1-20020a0569020d4100b00dc21c5deed5mr235489ybb.12.1706088351948;
 Wed, 24 Jan 2024 01:25:51 -0800 (PST)
Date: Wed, 24 Jan 2024 14:55:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124092533.1267836-1-ajayagarwal@google.com>
Subject: [PATCH v1 0/2] PCI: dwc: Remove the delay from PCIe probe path
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

dw_pcie_host_init() waits for the link to come up regardless of
whether there has been an attempt to start the link. The 1 second
wait time is wasteful. Get rid of it if .start_link() is not
defined.

Ajay Agarwal (2):
  PCI: dwc: Add helper function to print link status
  PCI: dwc: Wait for link up only if link is started

 .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
 drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog



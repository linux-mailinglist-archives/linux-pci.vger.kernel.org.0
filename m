Return-Path: <linux-pci+bounces-18930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A69FA0C1
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ADD16378B
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0F1F37A1;
	Sat, 21 Dec 2024 13:12:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4F1F190D;
	Sat, 21 Dec 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734786776; cv=none; b=HK/tQrqwk6g8CB4CzgM+EHeXUXY7T5anHiJ1EoDLW8Mq/QZEAl/gf3pGvUzQLOa0KtTftVnoDw8mWeLmAuils1qjjTfw9Z7W2gIvKNdm/Ez/Kl/CHPdHR426t1g39FERvD1YPCNvy1sKKg9oRjHyq757baZQ1+P5Tx3W8eqL2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734786776; c=relaxed/simple;
	bh=yyEUK0vCEo3ktnZEJ7LMECTO0Jek6/kcWGUbVIfGDyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tAa4H0Td9aOEU8pCPNtMggOdoXi0QOtZ9kDkbydPf2h26VZlAfWz/mlZWta6DlBJfahzuPw4PQGKfvsZzMkRFO6S5hA3uJj/JktQPijW1q11Ft5j0SgSOlkTojLv8pWyJWMiKHuPiGIxMigaYGfehLVo14CwNUuFcKTHjIrhMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ecc42d43so2408455b3a.3;
        Sat, 21 Dec 2024 05:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734786774; x=1735391574;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SlH5Yf1wlXs37oO8heuDWqmJKRlyU81mvzbiMk6KYk=;
        b=OWqURudrkPYQSfoDjAL6PHJm91GcazOzcXTCnOtg1Tu7yTYWuplzHQTyF7/vZrxepl
         jSAqsJtUFzgyO+M8tHkJnNCp9IL+NVp43m1z5ZLQOp6lH/3Jqbv0WMdOfdh+IZbh2Mv9
         bNM7Bi5kzhRdBcV0KNu9IibSuP159+PyNmdcAocgss0MFzT1qG/DU9u+E9FhDHKNGtR5
         nNj5PmFojxgcBDtmf8o5dmuHLsHJ6AvChyDmUiD4nRqqsM6KhN6hSdFqW3yDZgx3faET
         DtZCFxhBksgqXrGuDuQhuTu9BMdK4nz2ruZj9+evC3MHknPMvf2DS2ItYY2PAiAqMf4w
         aydQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJWfpbohu4gXEDPQBe5158fP4Tpb4Sqf5vd5kHXWkXMltehjco44YjhyPjE41S1s+Yw9VFCINbSFw@vger.kernel.org, AJvYcCXuhrInrO1axuQMnbFriwMmFC2b2lJVcZSxVejdy9bXxModIdczn1rkUrRH99c4Nw890VsMUfgKdxenF+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzn2C4HQbJBqAGATEFI1NLnoYbglY0s05UKe23pvausaowa+p
	SUvB8SzzBGKcsevUqQoqqjSCLJeHqyvoOfSvbaF2kN84NITPX0zjqC4StA==
X-Gm-Gg: ASbGncsNHH4viqYeAZVeyh/SenWUsmUFFP6EMvFMBhuVAYMj4awTA5myxGAC+uqSFpQ
	G51jAObUk1Zxzy3v24AQ/Cbd2tSjUdZ9qc0G8sXpEoGyzbjLNr6o86D78JdvpRCtWuFhHhimU98
	h/hmxgrxah/B9keOANHo21g2PLoP479LBJ8gr2MqE/xF/RMCG3YGNJ1k/xe7/RqaDjQjhvqATHl
	1kCJxhSAKzNDWNJ2VFxWBlZBpNIOEEH+UYegTkK+0e0bD905zpGMZfHYjGuNRb8VIA1TSTr7exZ
	Mpqa7D/PIvgEKUg=
X-Google-Smtp-Source: AGHT+IFk/y8a9b2bZUpjHTbuyS+vN9Nd+f/qtmvuJtE1jwALFIp23rC+G6tLeWvtVrdQb5f3lv+C9Q==
X-Received: by 2002:a05:6a21:3a44:b0:1e0:d6d5:39c3 with SMTP id adf61e73a8af0-1e5e043f6b3mr11632369637.8.1734786774379;
        Sat, 21 Dec 2024 05:12:54 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad831148sm4725429b3a.53.2024.12.21.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 05:12:53 -0800 (PST)
Date: Sat, 21 Dec 2024 22:12:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <niks@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI fixes for v6.13
Message-ID: <20241221131251.GA1086543@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Linus,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-2

for you to fetch changes up to 774c71c52aa487001c7da9f93b10cedc9985c371:

  PCI/bwctrl: Enable only if more than one speed is supported (2024-12-19 16:36:36 +0000)

----------------------------------------------------------------
PCI fixes for Linux 6.13

Two small patches that are important for fixing boot time hang on Intel JHL7540
"Titan Ridge" platforms equipped with a Thunderbolt controller.

The boot time issue manifests itself when a PCI Express bandwidth control is
unnecessarily enabled on the Thunderbolt controller downstream ports, which
only supports a link speed of 2.5 GT/s in accordance with USB4 v2 specification
(p. 671, sec. 11.2.1, "PCIe Physical Layer Logical Sub-block").

As such, there is no need to enable bandwidth control on such downstream port
links, which also works around the issue.

Both patches were tested by the original reporter on the hardware on which the
failure origin golly manifested itself. Both fixes were proven to resolve the
reported boot hang issue, and both patches have been in linux-next this week
with no reported problems.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

----------------------------------------------------------------
Lukas Wunner (2):
      PCI: Honor Max Link Speed when determining supported speeds
      PCI/bwctrl: Enable only if more than one speed is supported

 drivers/pci/pci.c          | 6 ++++--
 drivers/pci/pcie/portdrv.c | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)


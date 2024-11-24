Return-Path: <linux-pci+bounces-17246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5B9D6D74
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0F1610F2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF211885AA;
	Sun, 24 Nov 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TLKQGZKh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8C155C8C
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732442712; cv=none; b=Z1hkr8JSgnoGPS28fOl7P8s2oe1bSLr7ygF+xQPw4GOkT/OQyIstoRFXm8Bo+YtoXfcXWVrrkr61I3MIxTH56pnyhr4ou9SPg3OQsREU7uxpEzFZyVPCPm9206+gzIIMBsmih3oAcoUbxNntIKhOwtIfLYkL70KGd5jhm4WHY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732442712; c=relaxed/simple;
	bh=xYyBbJ1bV1F/AvNsXaz4DN1NT7f6hP3J7eQ9A3tlTH4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c7WlCStf+D8LAzt/hZslX+cQ6qf9FI3X7O3DD6wOjlWqHVupDdugVuo0RM30fwbM4u3wteAno4cE7nMKvZlN8hyNaMvQyF0U/hPQZSVortW7BE9O1Egq2aWBajv5Wc0Pduk11BGLof9DWkR+Ay5j6F5VfPP8W6R6E10tl2v3PBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TLKQGZKh; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a9e44654ae3so481177166b.1
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732442709; x=1733047509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc/jEUsBswYkaNb52ief0DkwziwerNcpWx/rdhbBFpU=;
        b=TLKQGZKh+ukC5GklXmw+ac1cisJMfJ/M6s7jxDRqmrl/2wE9o6QcwwPv2dvzgZPJXa
         DazyQG9LwNsz7SQqZV3eq2KfztXmaGh7rT3wU8uP6gijFuhzjlIKvWwGLeWuz75FecLS
         WLpcpZ1seh/UX1LbbyRXR+rAd4s8ltTJON0tKceFw1cfduXDH9GU/RQ9JGdx6PGvzJ2j
         UoG0Q4v9tMq0XLmlHClz1y5CWirF+nOmbL9MdkWCb7MdkgFAmln758io8bywfuYT2PCV
         wQnc3c+Ki/6NECj4RX6fFWvJFla8KVGE6wOd+WwnbqR8zA/uoD+B+1CZ3sHp73fqW0kV
         JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732442709; x=1733047509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc/jEUsBswYkaNb52ief0DkwziwerNcpWx/rdhbBFpU=;
        b=wVjyC44x+m/bM1pn4Aj3vh6kogsNeOuk5SQtag+P3aU4bvZTbMuPNSDWOgLfkn+Z3p
         RBCHEJkxI32jRErwoh+wdlKDfD5K1htEHVzWlNLz+PXqntUV5m9HldIGOO99apISlisn
         FYu2gES3z+aZTr27yDx+JKkkvEeH6zZqddhye5G5dkFRJMjzKdmA+j3jhgEdX7S4O4mT
         fzl2NkuHJnUrXHwnPPmiVk/D0yo2fMWunzVo4t+SAhrveUsIhQKaU2Zwb0uYPYYbM2VZ
         4M7hVOr+4Ucu+Tq6xf06opXHGgu1onkKUZHt/EgCH03/r1fcxppjanE/+AZvP+kWauiu
         Dkgw==
X-Forwarded-Encrypted: i=1; AJvYcCX/VPqXUyGAZtsZF/U0pBdEyjgQ6OHNZmcRnc8h/Ns0pMgB6E3/kv9lhm9x1+ugK2p6wo2BZQAcnoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgM49KrEmvS+BShMn8p11X41csOYvlsrpDkEdcODz09xz7uCie
	qwENLtSeJTuytWd8XDh341T/FNiUt7zJgRq827rl8y4F83U0UPEDghQfRQ2TgMU=
X-Gm-Gg: ASbGnctfdC7z2qaE1X5PHrWEFIiRYmguVwrpAk6Dh6RFOvJg/cUpj3IFkNA5XNoeFrF
	ZieIqQnkrBnrmv13ABfXI15ifzyIl9TQtmwPvdjUVSPD9H44HXtCih4Dlw7EKfO3c2NiRzjFZvg
	xE6+BFDrFDm6rFuyox3Jhm22OnH0y5/NIjbMyrh27fJSnjWUgRPHPJjZTRVNWATYq4GpDqZ3e4j
	9hEF+WCayktWq3cBfekAE+B9cCikF9DPxV0KLMjotDKuKcirPNHNcusyZ88SczgtukCGEZTJUwD
	HIO69I4YY3cXoE/b7BxJ
X-Google-Smtp-Source: AGHT+IE6n1Sl2VjDnUF5IiR4wNGa1GDW8vw2+O+cu/s3Q+7FHS16Q8BL2O+lyk7mxoO9jBhc7KuPpQ==
X-Received: by 2002:a17:907:77c9:b0:a9a:67aa:31f5 with SMTP id a640c23a62f3a-aa50990b2a9mr726045266b.10.1732442709155;
        Sun, 24 Nov 2024 02:05:09 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa51759732asm295266666b.14.2024.11.24.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:05:08 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 0/2] Preserve the flags portion on 1:1 dma-ranges mapping
Date: Sun, 24 Nov 2024 11:05:35 +0100
Message-ID: <cover.1732441813.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty dma-ranges in DT nodes using 3-cell address spcifier cause the
flag portion to be dropped by of_translate_one(), failing the translation
chain. This patch aims at fixing this issue.

Part of this patchset was originally preparatory for a bigger patchset
(see [1]). It has been split in a standalone one for better management
and because it contains a bugfix which is probably of interest to stable
branch.
I've also added new tests to unittest to prove it.

Many thanks,
Andrea

References:
[1] - https://lore.kernel.org/all/3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com/


Changes in V2:

- Added blank lines between paragraphs in commit message for patch 2
- Fixed a comment to explain the code behaviour in a straighter way


Andrea della Porta (2):
  of/unittest: Add empty dma-ranges address translation tests
  of: address: Preserve the flags portion on 1:1 dma-ranges mapping

 drivers/of/address.c                        |  3 +-
 drivers/of/unittest-data/tests-address.dtsi |  2 ++
 drivers/of/unittest.c                       | 39 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.35.3



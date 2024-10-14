Return-Path: <linux-pci+bounces-14416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A999C20A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263911C2354D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD814B94C;
	Mon, 14 Oct 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTKtRGDQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940C14A4C7
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892420; cv=none; b=BfF6v5Jt+5XDK/6iusEXQSV8jcXxO4NW15UUFyrtH9iNycPillcn4fbDUKcTN5Hm9OAhzWa68rG6oqVE3dU1jPhrk8asXxNpqiwO+3p0Tn3Ry+Y89mhN90iwWvO8hQd8pVpoSOlXeY1M6v1EcdPS2lGMflhFv7mm0ACJDPRDjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892420; c=relaxed/simple;
	bh=38C6NRMVkq3wK7ZeHi+VPdubstwCMm5larN0ifKv6Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3fVClxbpsRB8AVzHYAm6Y0WBwa5x05UespkVOBnzmAZ2guDYXhV7iV5Piv1DuCtO3Ndhd5n8Iaxdnagg8EkaDvOdvfvS3y8QvBwg4fWdNKOgO01qm7KeHEzEIh43kFnh1dNDtmiwukVl5ce/G+sHA15DQvNRwk7faBrs2fyNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTKtRGDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Em0Fwa9CsX4Yf8Gv8tnKBN7DITxj0GNsoQ0n+t3mNw=;
	b=aTKtRGDQtCwoQY5Ro7rK94SwQRtJpXxvWo8VqfKJUryU1uwI5dlO4waXTh8NOlwPj+tO6T
	Mxe5AHkIDQcfYQ55A0xsBzRxJCtj4KABPaBO6hm7EclwCPhLpIRaiiG7UyZ0d+bU8DKMG7
	EGAuNAuAhFMQC3t6CxTd7w679j49cNg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Xjcs6T4iM7mL4Dt9ghLvmg-1; Mon, 14 Oct 2024 03:53:35 -0400
X-MC-Unique: Xjcs6T4iM7mL4Dt9ghLvmg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8711c48990so340053966b.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 00:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892414; x=1729497214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Em0Fwa9CsX4Yf8Gv8tnKBN7DITxj0GNsoQ0n+t3mNw=;
        b=hLLmeAJAT2zCJz35OdtnAI/dZrL/VVofKnFKQ35tI4FxmMcO1EB6AIW7wPPSlz4Ogk
         rLEx+Zv7qbV3iypg5+XYFQo9El7uLv9nARm3FhicZPbVTPsoH+JSEpsDiG4x58IeHPW7
         effxK+hdG5719Pf4FtRTxRSK2PgLTDlBDwaonCaioDmDyZe+J3++GziAJfBGxSEk+7FF
         StbMkGjcE4OMcNtOO6Mv3cyMDpu8XzokVnyjVpZKt5Fz81TPYm/4UWITIhxH99vpoDsH
         DIVtT1mecAC+Vsc+cWA3teMSP7cexRh5bZDTwxhZxMOQJuUGoTaxIoBREMCEe78Hrfbj
         Fe4w==
X-Forwarded-Encrypted: i=1; AJvYcCXzm1Ky4zqxOKbZeUL0jgLQTpHr0/jfvePK/1l/h2xjCLabdeJwo2j9ZUMSiOVsZNsVV+tvQGznwVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/R5MnjoQyzuD8xUdS4QnoVX1w0Ao/RkAdlvQIkTu7AkvNx5JL
	Q/CfaICAR78ac8ZfI6xltv9+Iy0buun+S0v3xy+espm6/GfVuP2hKe+wSYRcgqjkazlpfWsUoWy
	JGJO1h01a1LLNtEAuon4SYF96IH41z1IN10O9mgXGML0IAMBpFz03b6Pl6Q==
X-Received: by 2002:a17:906:7314:b0:a99:f71a:4305 with SMTP id a640c23a62f3a-a99f71a449dmr562730566b.18.1728892414377;
        Mon, 14 Oct 2024 00:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS7mQi6VCblmjG4hiCSOfJ6En7uiGA8g5T0Re27ntZ7e0Jx5n23I6AOFOqGr0X48zqfpZyKw==
X-Received: by 2002:a17:906:7314:b0:a99:f71a:4305 with SMTP id a640c23a62f3a-a99f71a449dmr562727066b.18.1728892413919;
        Mon, 14 Oct 2024 00:53:33 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:33 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 0/5] PCI: Remove most pcim_iounmap_regions() users
Date: Mon, 14 Oct 2024 09:53:21 +0200
Message-ID: <20241014075329.10400-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ready for merge, all Reviews / Acks are in place.

Merge plan for this is the PCI-Tree.

After this series, only two users (net/ethernet/stmicro and
vdpa/solidrun) will remain to be ported in the subsequent merge window.
Doing them right now proved very difficult because of various conflicts
as they are currently also being reworked.

Changes in v7:
  - Add Paolo's Acked-by.
 (- Rebase on current master)

Changes in v6:
  - Remove the patches for "vdpa: solidrun" since the maintainer seems
    unwilling to review and discuss, not to mention approve, anything
    that is part of a wider patch series across other subsystems.
  - Change series's name to highlight that not all callers are removed
    by it.

Changes in v5:
  - Patch "ethernet: cavium": Re-add accidentally removed
    pcim_iounmap_region(). (Me)
  - Add Jens's Reviewed-by to patch "block: mtip32xx". (Jens)

Changes in v4:
  - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
    net-next, and making it apply to that prevents it from being
    applyable to PCI ._. (Serge, me)
  - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
    stimicro" as the last user for now.
  - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
  - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet" instead of
    "snet"). (Christophe)
  - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
  - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
  - Apply Reviewed-by's from Andy and Xu Yilun.

Changes in v3:
  - fpga/dfl-pci.c: remove now surplus wrapper around
    pcim_iomap_region(). (Andy)
  - block: mtip32xx: remove now surplus label. (Andy)
  - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
    occurs. (Andy, Christophe)
  - Some minor wording improvements in commit messages. (Me)

Changes in v2:
  - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
    patch, put stable kernel on CC. (Christophe, Andy).
  - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
  - Consequently, drop patch "PCI: Make pcim_release_region() a public
    function", since there's no user anymore. (obsoletes the squash
    requested by Damien).
  - vdap/solidrun:
    • make 'i' an 'unsigned short' (Andy, me)
    • Use 'continue' to simplify loop (Andy)
    • Remove leftover blank line
  - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)


Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (5):
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c              | 18 ++++++++----------
 drivers/fpga/dfl-pci.c                         | 16 ++++------------
 drivers/gpio/gpio-merrifield.c                 | 14 +++++++-------
 .../net/ethernet/cavium/common/cavium_ptp.c    |  7 +++----
 drivers/pci/devres.c                           |  8 ++++++--
 include/linux/pci.h                            |  1 +
 6 files changed, 29 insertions(+), 35 deletions(-)

-- 
2.46.2



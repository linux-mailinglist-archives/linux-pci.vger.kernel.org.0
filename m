Return-Path: <linux-pci+bounces-12297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F568961758
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 20:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB86628467B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA31D318B;
	Tue, 27 Aug 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0b/+8m1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4E1D2788
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784987; cv=none; b=IrDqFbN5zYI5HX8MgnFJps8qfYx1clYs9YRhLVR0W6FiCzB4Q2UqTEog18LWZa9IjXTMeqgUzFK96L15MYwanZpNGiqPkntPD5U+5epwyUQiDvWlQGKfr2qsv8geziiDLPEDpLrdiOC1tHPpY6QXqwUb9he5E+ea1dRPMaEx1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784987; c=relaxed/simple;
	bh=LrbzScSKoeO/OuSMvPnyas9t8iaLv9wwkOs1i5Fx+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LchMtguHCXrSUVi3/s99qBSjlH4mBJT+03JjSUakkyd1XfxwXxbELZJGxJ1uwtaJHIkOfHHrw50nF1JIT2S1kvIZ+iWohXkqV8eOv5dv4J5ig6cetuzN+h8mTEQZBenjxvh/fyAGv73Ah+2qctdmBU5JUPlh6rcjOsxnQOdF1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0b/+8m1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
	b=h0b/+8m1+KgEzmDa/NF4a9c6lrOnoGuc4RAwusw1vTH5qaVVlvU6qbjaCvpX23ak9IoQ8L
	Ami+jRGWo5LwQiLr05yaa/QoRz8XELFtvMhY9CB1YKF7Jz/JGIQnl8x0PUQhuI1UqPcltp
	e61CqUqcl1ZnMAnh+034ZjH3GcH53nI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-B1w-CbkYNJy0ruoaXC54_w-1; Tue, 27 Aug 2024 14:56:22 -0400
X-MC-Unique: B1w-CbkYNJy0ruoaXC54_w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8691010836so528527866b.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784981; x=1725389781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
        b=kbE1n49u6bSjFzTD/hywdpBviwvcf2jRXUobUPyr7G0im83Z5zDS4ein0XQYJZSuJO
         sojNT6/NyS9dnKA5kiNUrkNmDZloG/xvRzlrrZYun5vQ5zzYVwOaPXg04gsUBsEpyOMp
         YCBlNvVGXGF+K6CGGKxntllROm5eSJIrtwrP0RruBVHGso8QyEB/MHz2X+rhZoJzGm7e
         GD0hUUwuNcg+z9TyqVPwf2gGaCA7TE2QUjpiVOdMT1kxYVMgVEJ9YlhWz2cyvfpUuM41
         qC8UmpmldwaDgKOI15YTF1JWDEhQV/aAUmbXxm8iYQ2RX6JyVxOqHdjCNGUyq1qV4vU1
         AlBg==
X-Forwarded-Encrypted: i=1; AJvYcCXHcX5lTPnpZ+M+5YpRBVMRhABmFiTxtduDmgi3h/czW6ZQX5WRXdDYdDKMEpfvc4QmQAZEnEEiayw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlGgmOKOCJxZyLVPGIEYh3Gpg+LZmL5ZJTvODgdlA0SaBaN0z
	ljv0X0w5+E7oYn9sAB5FMsQ/ndaa//29uySmMPt0RoHk5QICxQWaNZgm2OZbs6Cx0AspM/g5Q7K
	+q+LSDxHyHVlwF08wcA3IRIOEMInB1iet1LJbu5KfWdaR/GI94p+MCDyIjw==
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297767766b.14.1724784980672;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSbDGP3VLJBbRBOwu9OD/wZex1BvcaPqE7Ybh9WpNR4VoxlhFHT2FFoNIIJFNO/012/OwV3Q==
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297764166b.14.1724784980100;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:19 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/7] PCI: Remove pcim_iounmap_regions()
Date: Tue, 27 Aug 2024 20:56:05 +0200
Message-ID: <20240827185616.45094-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OK, so unfortunately it seems very challenging to reconcile the merge
conflict pointed up by Serge between net-next and pci-devres regarding
"ethernet: stmicro": A patch that applies to the net-next tree does not
apply anymore to pci-devres (and vice versa).

So I actually think that it would be best if we just drop the portation
of "ethernet: stmicro" for now and port it as the last user in v6.13.

That should then be trivial.

Changes in v4:
  - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
    net-next, and making it apply to that prevents it from being
    applyable to PCI ._. (Serge, me)
  - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
    stimicro" as the last user for now. Perform the deprecation in the
    series' first patch. Remove the Reviewed-by's givin so far to that
    patch.
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

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (7):
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  vdpa: solidrun: Fix UB bug with devres
  vdap: solidrun: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c             | 16 +++--
 drivers/fpga/dfl-pci.c                        | 16 ++---
 drivers/gpio/gpio-merrifield.c                | 14 ++---
 .../net/ethernet/cavium/common/cavium_ptp.c   |  6 +-
 drivers/pci/devres.c                          |  8 ++-
 drivers/vdpa/solidrun/snet_main.c             | 59 ++++++++-----------
 include/linux/pci.h                           |  1 +
 7 files changed, 51 insertions(+), 69 deletions(-)

-- 
2.46.0



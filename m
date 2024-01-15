Return-Path: <linux-pci+bounces-2154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42182DBA4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1A91C21BCE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913717571;
	Mon, 15 Jan 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFOk4HYp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399417736
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UrwJ0Dll5HmncyMrasdk757KsthsQI/A5KEU3nkZNh0=;
	b=PFOk4HYpqLALMZg3KyMLsrgiwixxsablXhB8Nivfv5MBxbO9RhjlYH6RDb52D5TmcWtJPk
	lRytrLEiCXiuD9517Hy+ZQwk+vV2CX/vhXIfnNWjRoz0Q9iCoKx9odYYEY8jj6GakoXK30
	5kWjd4pV/bC4XTVpx6lP0gNGBYkpw5Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-nQTlPHkZOWSnh5Oyj5ovNw-1; Mon, 15 Jan 2024 09:47:12 -0500
X-MC-Unique: nQTlPHkZOWSnh5Oyj5ovNw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680fce72f68so25067276d6.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330032; x=1705934832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrwJ0Dll5HmncyMrasdk757KsthsQI/A5KEU3nkZNh0=;
        b=vTA6S6kamv5r4qQ/Dm9pvT5TmB4ib9XzNumTvwOdnH/H21Dtg7hfJGBDHMuAT8zyvv
         n6dIjg9SdCqeUebbhvI9+u05+CMK47AzTZfD8r2T4hveUrIGjCqWE7H44Vd6KGqJmZb5
         hpa0Ni+QWarhHfpuNzGkjJLWBe9I2Rallp9NWONi7RcCdRsb+evDf1Ff+9QwMQjg/Vjh
         O5ex3VB5ANb5Bqq1t7grYUDecu9wFF6Pu+NpU56txRfJHpVmv+/98IMDVAIq5WOBZcoM
         UOlEX1tNog9H1ivm+f1nq0wnyl8fk13kaX4paOxzI7LuWdU7J5yhb2i5Igo/d2zSvRy9
         /lkw==
X-Gm-Message-State: AOJu0YwK96y0Zo7S7d6ukT25IU0idTYs7IPK6+jmxMTdulPqe0oGodbx
	E/IesphH4pyiqbXjlgCyUvrgK5TaQ6akmewAA3rqH3jteUpUg4HpW0D6A8akr034dRSXsV1Ovxy
	Yy4C3F/Rd2QQNOggzs3+h9M/jj4hN
X-Received: by 2002:a0c:ebc3:0:b0:681:5534:b42d with SMTP id k3-20020a0cebc3000000b006815534b42dmr6378829qvq.5.1705330031731;
        Mon, 15 Jan 2024 06:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXUljWZZpRq+qrZGFMzjD/p7ZstX5ma+UhRFumUWI9lzxX4Ni2j9DAoCOCnc7mNHJkEuFaYQ==
X-Received: by 2002:a0c:ebc3:0:b0:681:5534:b42d with SMTP id k3-20020a0cebc3000000b006815534b42dmr6378808qvq.5.1705330031444;
        Mon, 15 Jan 2024 06:47:11 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:11 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 00/10] Make PCI's devres API more consistent
Date: Mon, 15 Jan 2024 15:46:11 +0100
Message-ID: <20240115144655.32046-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

¡Hola!

PCI's devres API suffers several weaknesses:

1. There are functions prefixed with pcim_. Those are always managed
   counterparts to never-managed functions prefixed with pci_ – or so one
   would like to think. There are some apparently unmanaged functions
   (all region-request / release functions, and pci_intx()) which
   suddenly become managed once the user has initialized the device with
   pcim_enable_device() instead of pci_enable_device(). This "sometimes
   yes, sometimes no" nature of those functions is confusing and
   therefore bug-provoking. In fact, it has already caused a bug in DRM.
   The last patch in this series fixes that bug.
2. iomappings: Instead of giving each mapping its own callback, the
   existing API uses a statically allocated struct tracking one mapping
   per bar. This is not extensible. Especially, you can't create
   _ranged_ managed mappings that way, which many drivers want.
3. Managed request functions only exist as "plural versions" with a
   bit-mask as a parameter. That's quite over-engineered considering
   that each user only ever mapps one, maybe two bars.

This series:
- add a set of new "singular" devres functions that use devres the way
  its intended, with one callback per resource.
- deprecates the existing iomap-table mechanism.
- deprecates the hybrid nature of pci_ functions.
- preserves backwards compatibility so that drivers using the existing
  API won't notice any changes.
- adds documentation, especially some warning users about the
  complicated nature of PCI's devres.


Note that this series is based on my "unify pci_iounmap"-series from a
few weeks ago. [1]

I tested this on a x86 VM with a simple pci test-device with two
regions. Operates and reserves resources as intended on my system.
Kasan and kmemleak didn't find any problems.

I believe this series cleans the API up as much as possible without
having to port all existing drivers to the new API. Especially, I think
that this implementation is easy to extend if the need for new managed
functions arises :)

Greetings,
P.

[1] https://lore.kernel.org/lkml/20240111085540.7740-1-pstanner@redhat.com/


Philipp Stanner (10):
  pci: add new set of devres functions
  pci: deprecate iomap-table functions
  pci: warn users about complicated devres nature
  pci: devres: make devres region requests consistent
  pci: move enabled status bit to pci_dev struct
  pci: move pinned status bit to pci_dev struct
  pci: devres: give mwi its own callback
  pci: devres: give pci(m)_intx its own callback
  pci: devres: remove legacy pcim_release()
  drm/vboxvideo: fix mapping leaks

 Documentation/driver-api/pci/pci.rst  |   3 +
 drivers/gpu/drm/vboxvideo/vbox_main.c |  24 +-
 drivers/pci/devres.c                  | 996 ++++++++++++++++++++++----
 drivers/pci/iomap.c                   |  18 +
 drivers/pci/pci.c                     | 124 +++-
 drivers/pci/pci.h                     |  24 -
 include/linux/pci.h                   |  17 +
 7 files changed, 989 insertions(+), 217 deletions(-)

-- 
2.43.0



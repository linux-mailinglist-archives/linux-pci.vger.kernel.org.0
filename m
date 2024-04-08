Return-Path: <linux-pci+bounces-5861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5889BA89
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C6D1F21C57
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E439ACD;
	Mon,  8 Apr 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIeD3EjB"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA938FA0
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565874; cv=none; b=jjRKesvXYrDqOQIIIrnOO7aJVXmWrj+3ghEtxvFPlDiCczadMXLFGWnwKlpfrOZoXwpAGF/yn9JI6qGps3VcTMURomKA4T6I0miWJJUOpogWY96a16zDcNe7z4sp6nmPnHrKOYDioyWbPfBL+q4DdrqobuoH2u3gSLM+NFVhsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565874; c=relaxed/simple;
	bh=IAogvOcATWo2UHrFcxB2KYks+D0MIT3UGiLbW1wMbag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kP73AEBtfmPAsG3tZ38C7wUrwulWuacnZfg/WW87HRTdAfQyRBrScrL5IYwl2IHeOGEO0f7Ax1B4jkT2051DKifnqO+dzYlsJe6A06ZSlSVeXHWuNQADuLUxSPMynBEzgytxBsJjA2EKv3XZ9Tt6ZmIl9y4ajaXixdqvTkIIXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIeD3EjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d001lAD3qdFhL1jiZqzes39oJoG6dz7X9cNnKIOVG3A=;
	b=fIeD3EjBcQP/1LnMnyjoqRZNq7m7u/LJ6qWNW/TyZddWUMw+NIdNzu0EW67m9Gp0KEBjdu
	1iYQJILqBV6BHMvQus2CjfHRdcpUpDlA+n4oSMaO5o5/DADc70lsPTVps+QAwMYp/gOAVq
	iBWT5K6vorfubfPCK/oJdTpV7Bf2mrM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-oAge1x__M3iPDZ_QTtKoyA-1; Mon, 08 Apr 2024 04:44:29 -0400
X-MC-Unique: oAge1x__M3iPDZ_QTtKoyA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d346eeb02so182029785a.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565869; x=1713170669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d001lAD3qdFhL1jiZqzes39oJoG6dz7X9cNnKIOVG3A=;
        b=SiirkdLoxgzAqMsfC8X3pBxhWj/mDHAWlYkvk+rOidGhn2u7/TNh7MtgVViISO27JO
         LUoMyDWa4S4n0QRTzMJ4GdWwb8Y1W0S5KP8sm4a1zMoTw3TrCjsPuwIGZmx4eCILCmFH
         2uVYF4dhNHavIUp2Eq0cbC5qGmI79MSO17scZgcj83RKuPJs137fjbnYKSILVHr9e0ra
         W9oweUwZk5JNmNhAi8PC3eg1qx9eYCv+orzeRuLQGVRqBsENapn3PZolHkdkIMNXmIG9
         13eJIx9l0Zf/wB6NA2b0zjfsE01VfMiOr/KR65PRhIPKVYb086KU+3DHd7TZOn3ryKUl
         KfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwmOaFN2V+NH8bH6SVbrV8ZdiECqL6/WNKmSTg0wfQIqVcy/Kor0BxuS8ka0mDnkIXOKzcGrJX6rKNjgVIScXFd+4fF9Ru6qZf
X-Gm-Message-State: AOJu0Yw0A/iBT2/eu4qTtaTemnDTEeOWl9+WBzn8/ONDNxc3x+a3zB8t
	h/CGQEPacbStJgIl+jjPw3w1xF8K2Qqf2rW23y0qUWaVpN+DwNW/5WOy/5Wi0OpyLgydz1A4Dbt
	y+xa/AvAga4KodcfmiV/TGKEbY6r+W/89n/oAdJPZoY64hPu3lTRsoC26rw==
X-Received: by 2002:a05:620a:4154:b0:78d:6978:35aa with SMTP id k20-20020a05620a415400b0078d697835aamr448089qko.0.1712565868652;
        Mon, 08 Apr 2024 01:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ6H4YaYzmGoDEmgcQrm4a1neORRX6/FgF2RK851AHjC5ozf510YYDnM0NrHdnKQbWb8gHNw==
X-Received: by 2002:a05:620a:4154:b0:78d:6978:35aa with SMTP id k20-20020a05620a415400b0078d697835aamr448070qko.0.1712565868271;
        Mon, 08 Apr 2024 01:44:28 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v6 00/10] Make PCI's devres API more consistent
Date: Mon,  8 Apr 2024 10:44:12 +0200
Message-ID: <20240408084423.6697-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v6:
  - Restructure the cleanup in pcim_iomap_regions_request_all() so that
    it doesn't trigger a (false positive) test robot warning. No
    behavior change intended. (Dan Carpenter)

Changes in v5:
  - Add Hans's Reviewed-by to vboxvideo patch (Hans de Goede)
  - Remove stable-kernel from CC in vboxvideo patch (Hans de Goede)

Changes in v4:
  - Rebase against linux-next

Changes in v3:
  - Use the term "PCI devres API" at some forgotten places.
  - Fix more grammar errors in patch #3.
  - Remove the comment advising to call (the outdated) pcim_intx() in pci.c
  - Rename __pcim_request_region_range() flags-field "exclusive" to
    "req_flags", since this is what the int actually represents.
  - Remove the call to pcim_region_request() from patch #10. (Hans)

Changes in v2:
  - Make commit head lines congruent with PCI's style (Bjorn)
  - Add missing error checks for devm_add_action(). (Andy)
  - Repair the "Returns: " marks for docu generation (Andy)
  - Initialize the addr_devres struct with memset(). (Andy)
  - Make pcim_intx() a PCI-internal function so that new drivers won't
    be encouraged to use the outdated pci_intx() mechanism.
    (Andy / Philipp)
  - Fix grammar and spelling (Bjorn)
  - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
  - Provide the actual structs' and functions' names in the commit
    messages (Bjorn)
  - Remove redundant variable initializers (Andy)
  - Regroup PM bitfield members in struct pci_dev (Andy)
  - Make pcim_intx() visible only for the PCI subsystem so that new    
    drivers won't use this outdated API (Andy, Myself)
  - Add a NOTE to pcim_iomap() to warn about this function being the    onee
    xception that does just return NULL.
  - Consistently use the term "PCI devres API"; also in Patch #10 (Bjorn)


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

Philipp Stanner (10):
  PCI: Add new set of devres functions
  PCI: Deprecate iomap-table functions
  PCI: Warn users about complicated devres nature
  PCI: Make devres region requests consistent
  PCI: Move dev-enabled status bit to struct pci_dev
  PCI: Move pinned status bit to struct pci_dev
  PCI: Give pcim_set_mwi() its own devres callback
  PCI: Give pci(m)_intx its own devres callback
  PCI: Remove legacy pcim_release()
  drm/vboxvideo: fix mapping leaks

 drivers/gpu/drm/vboxvideo/vbox_main.c |   20 +-
 drivers/pci/devres.c                  | 1011 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   21 +-
 include/linux/pci.h                   |   18 +-
 6 files changed, 999 insertions(+), 212 deletions(-)

-- 
2.44.0



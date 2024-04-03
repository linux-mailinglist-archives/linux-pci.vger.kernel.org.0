Return-Path: <linux-pci+bounces-5596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA498967F5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3C31C266A1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64206D1AE;
	Wed,  3 Apr 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrWDNTdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01726CDDB
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131647; cv=none; b=Gc8zcCVfe0i44UEgrE8gP6RwfcJCzqhOnOU5j3ljrdoF5s2h7cMdi4oIu2vkckf91Uw0Cz+J8XhFLUltJG5dERZCpcmseSYb3FVravBa8TAjAHuBs6quFmpdywl4HszzXpyT2SPEbPMZRskc4V4E7wEPSy+Pqrxq9OZ5b3j2pVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131647; c=relaxed/simple;
	bh=Q/H4nzMvQhmuggnPNAiSSe42t/cBVb0/0gTAVoZQgeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yv5z80BTuTfnbBncsTSGnmivhO5KAMrWtxlgWAOUFGuVFW99mTFfT+BJLPobGxCLy0PFs1EIubnUl40av5OmcnBHnum7gNIEM5Ew/x+mcaRetm7KpUxPADeqbcdPAbUSEU1q32nfqi/xQBxOLbPX+bWiT+JYbw+ZaaY/drYm0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrWDNTdR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46k5EOtNpPpRezM1uLkG14XJOI7Jh+iRtVOqi3t9M8k=;
	b=FrWDNTdRL4e1b15/UtZqXWdf3xW3OGSGklIep3WJNGc/pkEkZtVhVRZBgGn/qk6w1MLiUG
	E+mJbMy+SraPi/wAJKFhCNGl3dZJQzZK2r6N8XSPG9n3QD/3h63exNoR2O0ri1pKzmoG95
	rKmMhaiXziUTYZXLPsfXR/5ZSP1ON4s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Qh6usLswNIa8pyZoL2b6gA-1; Wed, 03 Apr 2024 04:07:22 -0400
X-MC-Unique: Qh6usLswNIa8pyZoL2b6gA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343740ca794so324719f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131642; x=1712736442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46k5EOtNpPpRezM1uLkG14XJOI7Jh+iRtVOqi3t9M8k=;
        b=w1pI8Yx6RE7St0c5/IRXM4kBFE9mCaK4iIeg5Z4BUrvLqdK/A9GQqLI6VrMD8YTAyN
         8SCAHoPN1H4UJOKqPJoK9E9nen24LoeYLgFck6Mq8dNadGlfC30nM2IIOGw6J2vn3ioO
         8rvc0+dvOIwB5RmxUozyBmwPhuKTZiHgqLngV+BZCACYf9PCXt7oQHtiiBwZQA9cuXoL
         jDkT6IVwDHBKlcp/qPyRBE0MQnxqnh37eUFAdhSDB6dHO+703EbwmC3L+SRatGjVtNO5
         3Nhto42rOiOt+nWyaGVeAv7eSpEg+wYkTS+QmlrKiQt6yXd/lrRMe62qJu8Kn7LvoUuE
         FrNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXrVTdGOQ1whAQP7al871f63rFb5xUHkXxbPDTMpOKejrhA5OEZb5L1SYEYPLrogKCLt3bhBy0w0c7+3IueA2GnEP1B+w/QYjr
X-Gm-Message-State: AOJu0YxEISiqenOupjOeDE2cTazzl4t6sZ92TYBOweAF8lgaStNGZQVF
	K9lABjXd9JS17BSGZTYQxwa0tD8OVfJs1Asn3X2WBvIOIHDsMM8qa3dY4j/2y/DiKGinewv4t9Y
	3fyj2iuvAeRY3CuKTPiPnyZ5lhK+BFMeZUlxP4oCIZ1XK3U+ola5reWLV5g==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598226wms.4.1712131641733;
        Wed, 03 Apr 2024 01:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPlqw1V0i7idyMsB6HeezWkDKxElDOlk06ycKPdYELPgnLUzHbjveNDfaoy4XyWSI6DjV1SQ==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598194wms.4.1712131641311;
        Wed, 03 Apr 2024 01:07:21 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:20 -0700 (PDT)
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
Subject: [PATCH v5 00/10] Make PCI's devres API more consistent
Date: Wed,  3 Apr 2024 10:07:00 +0200
Message-ID: <20240403080712.13986-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I now regard this to be the final version of my cleanup, hoping that we
can make it to Linux 6.10 – otherwise this would end up blocking my
other work for another release cycle.

@Heiner:
Thx for the feedback on the other list. Since none of that was
fundamental (bugs, errors and so on) I suggest we postpone further
improvements of the PCI devres API to a release cycle following 6.10.
Maybe we could then even try to port drivers using the old API, removing
that one entirely.

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
 drivers/pci/devres.c                  | 1013 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   21 +-
 include/linux/pci.h                   |   18 +-
 6 files changed, 1001 insertions(+), 212 deletions(-)

-- 
2.44.0



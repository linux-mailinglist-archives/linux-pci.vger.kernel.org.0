Return-Path: <linux-pci+bounces-4309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D969C86E046
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643201F21843
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567B4438E;
	Fri,  1 Mar 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+C4OpkO"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAA20300
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292614; cv=none; b=Uand7p0qCYzGdnw488aJprfsr1ZAfKyv7oGIOScJEmKnvA3uEKcthCBRZguLvEBv2gpdnK9R8nX0sDtDoEs5B7+cOjLFYLCB8RZWnp7znESuFHIkT83lahjMu9hjQLlX3DljS7zxoBsxgCG2aNhJQSUnzYPagmy+0Aidlz7rpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292614; c=relaxed/simple;
	bh=+oRThxcj3ps9wr+dkXNQtIKwQg+6L7ubdaoT5TWxYww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1TVcBruLEM+rFuBAxVeaRbVlmHV8dxkhE1qu52id8pciggk7HQ7KR/QXWF9wkbcrlzGTwyMfi39x0hSoQh0RjsGM3TjJdxKexLDdkwbn6vVc6a+O4mtiQtQItry4bWtwv9TH8Sj7iCyhodL2MFoj9gWfxHoE7fb9A+T0d+TJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+C4OpkO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/G3ufR6Nb0rp8kKGopKHt3c5V3Y56ocTb8Uds47XJ8=;
	b=d+C4OpkOZxmFXZW52lSaEaV9BzfBpTuvnaxABfitGsbZFrJ+aItgrUPdqPBQ/2FDNhfTQg
	LQlg+2f9nqjOPAAXg+Arn0OF66C4DzDJeysO6KGPw8JkZoZATu4Do70MDG3ivDZ84DmmKu
	DqvtJBFSw4ryR7CKZ/0phfmIsP/YIpk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-gTkps96yNN6bMCp87_Ulkg-1; Fri, 01 Mar 2024 06:30:10 -0500
X-MC-Unique: gTkps96yNN6bMCp87_Ulkg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6818b8cb840so8651006d6.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292610; x=1709897410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/G3ufR6Nb0rp8kKGopKHt3c5V3Y56ocTb8Uds47XJ8=;
        b=odgmhqJQGdrhCB8ntPrPSExgLG9Ni3cNNcxgr7WZJof6ymWzBGvLfO0e8U2BWliVG9
         l9hgqnGGWFfVNntvQqBiSILNcLpafJaQgK9+D/PXclb6zN9X5+IwVaItDV1lQ6aaz9YJ
         QwwV+3oHXvEnk+Ubuc+CJolY8oGd2Zn+O/OqdbQ8KQ1Qm0c8YWDGhAhf+a+gbKC5rvYR
         UxatSiQ7I23/BhV05yUzM2ph/xFiRdmsZRbwdtvlCYdEmB98ZLZq2Lfa9VGw+dldyLJt
         tRFfFyvaCr/yrrIvD2bsdBm/Gw6eag5pBPFKzmqesOz9DzShFum0UVt8TKNSLkmzGbpF
         39IA==
X-Forwarded-Encrypted: i=1; AJvYcCWCggXzdSRvkXWfQU39ASByg442QRdVYf7UkXFWJrXuCEKc7AqmDgn0Nxg+f/ujvVCWjT6ClUeDUjKn1H9ZVMbSB2l9WCK0VDWN
X-Gm-Message-State: AOJu0YzzM2ksW3VpkmdOITlFX3KE6wcLEAHRu4p2ahtbKGV7QTQLNmoV
	UinxrYF55Wo8717Ok8BghuYQWdD/7V8oGMjC9v3mynUoYEEKj3qAjRofnJsLXwrMiT0Oww+U5/A
	7bMbm0gkEBCw1TJmCg+XggHKTYsIIQAj8r5LagyhU7iS4KhJgcIGN0q3/JA==
X-Received: by 2002:a05:622a:1aa2:b0:42e:8a55:f02a with SMTP id s34-20020a05622a1aa200b0042e8a55f02amr1436213qtc.1.1709292609781;
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHKUF+PUO5SDcV5IYLHAdLlF4fORhKtCX+2PkvUwBFPFfa9Zs2pE7fVUdk3eExP+LxG7kPCQ==
X-Received: by 2002:a05:622a:1aa2:b0:42e:8a55:f02a with SMTP id s34-20020a05622a1aa200b0042e8a55f02amr1436196qtc.1.1709292609472;
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
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
Subject: [PATCH v4 00/10] Make PCI's devres API more consistent
Date: Fri,  1 Mar 2024 12:29:48 +0100
Message-ID: <20240301112959.21947-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v4 now can (hopefully) be applied to linux-next, but not to
mainline/master.

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
2.43.0



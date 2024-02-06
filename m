Return-Path: <linux-pci+bounces-3145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712E84B69B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 14:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BACB2413F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085B131734;
	Tue,  6 Feb 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCqvr9T2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B63131728
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226832; cv=none; b=m0DGrELnvMP/BqFFT09oEYeejmxedhDf62XmZfri6XIXBtw3RMHPSQ8MBaee5wkbZxqOnL3ZG0h1sPOCa3KJ03vhGrdax+ScKefSOPgmBQUqUfnmbPrtoEO98qojvLgYSOtx371mqBYdkUHqoWKgiAJdgFmdnRwYCmGkhS2eXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226832; c=relaxed/simple;
	bh=hE2XT1hEKQxWX2w+Vz7cAy5o22Ieh0ZEONmnPlZ0Azw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi6YN5/q19wiXdIlWFW7/ZSQ3jzzHV7k31IK5wcAiO3kw/NbnB2BVlWByD8f0XxH51RzTtLjy8qCbXhgZq6MYX5wE6u1OGu1mzCwh/TtV/BeHLVzHQOqE8L1tNlzDQesdqpsTcnRSRLWNk6rEovCIgCszYGFfEsci8kDHLaZ8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCqvr9T2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QpY62CAbzs1kZlSzF8o4OMEgSIRU4oj8654lX7CLtwY=;
	b=KCqvr9T255jbRjcl4l/JVl5kgZM+HNTMG5/NiYi0yLNiyXdp0BKoJHN7+kwXkzFe54JPmK
	t7y+w4D6yc5r2EMiPvke/cABptTNwoeO7/fNxifCYiO3Km1312UOrLyeNh1PbZrjPM5vMn
	4yaUvn7EwHYRq41V5VdAa0rH+BccKMc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-767n7sPiPOW2142YQFYs6g-1; Tue, 06 Feb 2024 08:40:28 -0500
X-MC-Unique: 767n7sPiPOW2142YQFYs6g-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59cf1c2c833so27883eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 05:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226827; x=1707831627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpY62CAbzs1kZlSzF8o4OMEgSIRU4oj8654lX7CLtwY=;
        b=Xli4uAY0QM9XHTv+GPZbH7G0MYs/q92mMNHT339zwnsiBwFI3WMKrYk6a24DP+Td5z
         36zz0opUY8CgnzW8O5z6yvKlaQns9gvV/d1eORuLjsle8M9vkLYJZG2n0WBGS/Y+hSqk
         8vuu/xEhqWgspUn2ZGpxdQQRcT98z9/6UdCRUvAWHnWExWfA8GSfDzMoWUnJq1x38TkQ
         llhpHsm1nimlgeUzsQGB12ZTvCsa4iOx+6RGq+LC+EbBJGPjTY+kam72KrlvyFdOaI0G
         jG72zwnSaqwgUv39iPYcmF5LFLcWlGYFvNLYPhoNIGJKHpU277a7wivAqqlQocmyHUWZ
         PD7Q==
X-Gm-Message-State: AOJu0Ywph8x3fD7u4loCrpuYzhhUPRkhxCsW8UOmPDBR+iMAKRq/AlFp
	tluwkYSH1fvWJSTEe/RJy2W+FcHynaUTUlPWBu+bq5km52rWHdF4YlFMDZeUrpkfd/d43Y0+fX/
	MEZ9rL8maKZseduqggRUdwv0FwUzLkevsl6eE22d6vjeHtUiTvM28MD02Wg==
X-Received: by 2002:a4a:ce99:0:b0:59c:d8cd:ecee with SMTP id f25-20020a4ace99000000b0059cd8cdeceemr2888546oos.1.1707226827530;
        Tue, 06 Feb 2024 05:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/7qqy2ReBTKnpMmJvYKlOG0fD0tyMjSKFr2o9dpUPWVtDK2/MoKz3eco4vYEvlU68ed5c1w==
X-Received: by 2002:a4a:ce99:0:b0:59c:d8cd:ecee with SMTP id f25-20020a4ace99000000b0059cd8cdeceemr2888514oos.1.1707226827219;
        Tue, 06 Feb 2024 05:40:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIM1d7cKsnx6ZBJxdCTNBxX2IVrCI36r3smohJVNNMP6NIN7DryE10Ug4aKiENWtwcqhfhIcWl7RQQffJaLibEgC6l534MQFXFEaGQ1fuSx/MEW0HKeF+rKJ8FwYo7nr0latl9rdDhIb8VfxNVOLKr1MpxJTOuQRs2QuH1z9ycoLqulqFfFGFauS6o8gmDcpIk4v2qvzBYZ6oW8hBR/wNOpixarPC28/cf9aUFfTIkR2K34LpUjW0MIWDaFWIkKxW+3mBkAQ69eeo6X6N1Muoye96s3+6fbTrfEo31aHZ8AELlFcDrEhOQpXlwP4rPRztEhDBtVxwKaPc2BYXFolrofZUKCzNSBA8mRAF2fKKuUOFJExCdLYFVyGK1JyLqF6/uCn79
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:26 -0800 (PST)
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
Subject: [PATCH v3 00/10] Make PCI's devres API more consistent
Date: Tue,  6 Feb 2024 14:39:46 +0100
Message-ID: <20240206134000.23561-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
  - Use the term "PCI devres API" in some forgotten places.
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
 drivers/pci/devres.c                  | 1015 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   25 +-
 include/linux/pci.h                   |   18 +-
 6 files changed, 1004 insertions(+), 215 deletions(-)

-- 
2.43.0



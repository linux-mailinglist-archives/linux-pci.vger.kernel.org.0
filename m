Return-Path: <linux-pci+bounces-10935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F793F146
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EE41F211A1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667B78B4E;
	Mon, 29 Jul 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egQRsktC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FF770E1
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245819; cv=none; b=HhLeu1w/VyVYX/f0Cy5blQuQfHOcGpMKonAOtRUWdfvRJyU+sAWTjXflxlRapxV9y6Z+E9z0ci4rtARdxjlDLZy6PY2UNGwx8f1RHJim5WjYJRSED2zl8zwoKz79LXt2A24Z4OPFYruotorzys7CjDNth19/dYprkKrKLAIrIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245819; c=relaxed/simple;
	bh=HzA7AEw0WWQvtM2aMWSpL9Zx3KaolqvcZTtnjqIEIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbjCzq5Mk4bgXXTsXa2nk/NHGc7SuvillEM+glTvnfEtgBhchS9tY5bn5PbnOkyyX0CGRcIWr0RuDbWkMDpzntypuOxV2jnr3YIaSUmP1Os7wWldkRZ5VxVHzUXx0ci/5rFwa6OnV0yDUg4OasdZQJ415jMhRZRs/ZLaYo3gVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egQRsktC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emFTwdbhfJ2ShCITolW8giMz/g85BaR1blQHMfaFnpM=;
	b=egQRsktCjRmabmHPIWXxy4/Nl2H1AGDGasil8ZmC/FOsF8JpzgG5VlO+3YLZDDSidgx1qj
	ZzLZXQ8Od69Uu7DsFphI0jniYhLtLyqNZtEVYv4JEFYZrVxZX67iXFAwUy2nJQhgzGwgnj
	4hF7wqnHtprWZDi3FVL/92ly9DCxl+8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-DB20gkTkORuNwNX3zNoRmA-1; Mon, 29 Jul 2024 05:36:54 -0400
X-MC-Unique: DB20gkTkORuNwNX3zNoRmA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b79fbc7ed2so7653276d6.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245813; x=1722850613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFTwdbhfJ2ShCITolW8giMz/g85BaR1blQHMfaFnpM=;
        b=LCOTKxNosAU50pb+B0xBHV4QVh+VXXusV+faD3ephp1JKClQoVzEmreWuMOqOZ6vYf
         r1x7WV3gXvcYt7GEgKYRqpWObFrLFme2WNN/0WDPKkqa58NtDy3epOJNL6++bFWzhbt5
         w3faGEpWRH1F8C4/H2CPvL1JSvHp09D+MRQH2EWQN60vsfhoXD5T+EgPuzRaydl0t8rB
         T+E0ABtZ8mRFgIRCNCfcxA18H+xdJ+wP59MfIP79t5UcH8CEHvZhGpsPcJBvHmwg2Gsz
         +ayOzjgbZV2Xh8KHOjeuxnu2jdINfsD7luBeIxlZVbeVKlmldBNPVhwnl5fiGsnsacR5
         XSlw==
X-Forwarded-Encrypted: i=1; AJvYcCW5b9mSoPW8JvEiIAK2lBZ9qEStnBc5wkQXLuMwJ7EEQsGVVoo41RUcIMs+IuOtqqSTkSx0bqbzeqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjOoJnabEQs5yoeTvTOdj8c6AesxXiIN/+WqQoseGRfPltRUG
	WvJPjJNOubqN8AxxozNmRBoyy97/UTGqy+JVSBYRI86FHbEWd63L/O0aS9YMfyRGGwRPovsIcwS
	rA/sPB2OHVycZSOnCAtxfy+8egqfsjmCabxtRCWngaiZil/PIMbh92gno6A==
X-Received: by 2002:ad4:5ccd:0:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb3e1a8f83mr85445016d6.2.1722245813570;
        Mon, 29 Jul 2024 02:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gc3YQkLtpxEMrgaDxCfFPgN8uoswS+Zv8SfLImnsVcyFRGniiKYT5wxqKdMycWiPyBs5IQ==
X-Received: by 2002:ad4:5ccd:0:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb3e1a8f83mr85444936d6.2.1722245813183;
        Mon, 29 Jul 2024 02:36:53 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:36:52 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 0/2] Use pcim_request_region() in vboxvideo
Date: Mon, 29 Jul 2024 11:36:24 +0200
Message-ID: <20240729093625.17561-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Now that we've got the simplified PCI devres API available we can slowly
start using it in drivers and step by step phase the more problematic
API out.

vboxvideo currently does not have a region request, so it is a suitable
first user.

P.

Philipp Stanner (2):
  PCI: Make pcim_request_region() a public function
  drm/vboxvideo: Add PCI region request

 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
 drivers/pci/devres.c                  | 1 +
 drivers/pci/pci.h                     | 2 --
 include/linux/pci.h                   | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.45.2



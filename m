Return-Path: <linux-pci+bounces-21416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D657A354C9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E016DEFA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836CF137930;
	Fri, 14 Feb 2025 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+s3kjsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16686136326
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500582; cv=none; b=V4hEGVXoh0KtYo6iDsgebmJzE0srW7YtShdxHNzYFMAusAhu2Sapb5EuXpyu+jJe7IoByoz+iOhuXsWBiP7FSfXJbIQVWXntOYB7TRLObV/jihITWmKJyMUdUaN3P+wvXXdiAeGhEyf2r5zyTDvesRKwCzWof6SUv2q5fEUvhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500582; c=relaxed/simple;
	bh=EzL9kqERF1mODaTi99Vbdpckz6nLMDysk548L5d6Vb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QkBHRV1VlmpBk4oAc9gY2uuJQRlyJgYa9+C+vauQhnm5oYceVJkD7SP7U8iNvzbjojVc45/NND5TmC5dkb/x/VkAmDXdo4oeotmdz/fnIfPAt40IW0cruHVgCz7RJdqh/CdjpXYtRCrI6wsq8ShuXx2oyDu73su6pnRMLCKQ/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+s3kjsP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f81fc2248so31889665ad.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500580; x=1740105380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Td3ceVC7nM5D2trC4k/dzsDkTskRZy82gMGh4G32pR8=;
        b=F+s3kjsPUPv+CHYZkwG1xL+KCyFn5Qpee3K0zRhsbcaaGx05yNes1Xu7tJ6tE2CPvT
         OgxrjaagTeysK2GWsTWmEvbx1qH7/zpWtq7h/LtkOWOoXuEB4wT9mZgm20EvNrLENXRd
         o36k6Ka8N58sMhftAQ5FRsWcTvkwOZq2TDeHSXWrax1GZr0jQz+BYER+6W6s7SmScpqG
         jHDJnTz9OpdpPIrWnX9r5t1MD5/+rQ20CdxJzuuU+PAAS6v/cmqmFYqEBsl1MyEdomCa
         LeCEz654/OMgRzhZwN1dTxSE2wuzIDrhUMSOje4cdeN76r3NLBA6h1Jzo94OtJ8sSl6Y
         L4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500580; x=1740105380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Td3ceVC7nM5D2trC4k/dzsDkTskRZy82gMGh4G32pR8=;
        b=WlLjNQ2Ck9xvJGBORyvGN2Di65A72J16fhVIrnrwGtbbvVgOV7X4etYD/ACFio+ZYJ
         Uxl5Kd8O8RGQycjx+VDUhqwYwyyfiXvi15iAODoDW6lkY5btwr+q/Yvdc3zs17i9f2zu
         OdRVhCjBoaLO4LYDui+P1Ts1tCvKQO9kHWtSvyQqjX6sV26RhHQF1w2HkHt7G9CGg/gS
         Z8lmgT0avwyqmluvwbVisIgP8XjC+XiDVe3A2D8XOOJzJVacHm4OdZ8cZ/eymqc4NcU0
         q74J8eYgOq4LqassBFtsT7mewGTlT90M1CCbBXg1bKANV8Aiozdfnx7m4Bbg2MgNEjLY
         z+Uw==
X-Gm-Message-State: AOJu0YwfkPGIWUBFuaJOHdt419cdJsaUTn+AvB3gs9nQ7UJQJPzAtgg7
	QPGiz47G7lFqvKPGJUfwUDJ5DIprW92S94jaZyQfEqFuphknlDKNbREsGJLZHKIxprFz9vfc9Nh
	YnQ==
X-Google-Smtp-Source: AGHT+IEWL/tiYuXrrzRgSg6FkYb3PyvmccoXHAVXizuwydkViuZezPyz14DTdeAyr8AlWR2uoZ8puctTn34=
X-Received: from plbkb11.prod.google.com ([2002:a17:903:338b:b0:220:d668:ff89])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:950:b0:220:e63c:5b08
 with SMTP id d9443c01a7336-220e63c5e07mr48241045ad.11.1739500580401; Thu, 13
 Feb 2025 18:36:20 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:41 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-7-pandoh@google.com>
Subject: [PATCH v2 6/8] PCI/AER: Add ratelimits to PCI AER Documentation
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ratelimits section for rationale and defaults.

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..167c0b277b62 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,14 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Error messages are ratelimited per device and error type. This prevents
+spammy devices from flooding the console and stalling execution. Set the
+default ratelimit to DEFAULT_RATELIMIT_BURST over
+DEFAULT_RATELIMIT_INTERVAL (10 per 5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.48.1.601.g30ceb7b040-goog



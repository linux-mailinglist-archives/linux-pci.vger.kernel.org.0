Return-Path: <linux-pci+bounces-5633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354D897992
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F701C218A8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB639155753;
	Wed,  3 Apr 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv9sUr6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153156B70;
	Wed,  3 Apr 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174914; cv=none; b=dpxbJlMB9+uCZV2yDD1e4OULgusW+OhriQgqTQfA0LdneHnaLp2P230QMcDG/h2sEDoCvMW+jJGpFkQzWktoB5TYmf8UJ9VCibvC+nMzcK1hxVAQfsRPg5llDZlj5gEM0tyoEFhw8CyAmsKx0YlCl7xnHLzBMUfiMuLUvMARr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174914; c=relaxed/simple;
	bh=vgqvF/T1JCUMfC6OzKHdjzW5tm0PnI/QN0DFYtq1YN4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diyO1TDxohcgY7VSju08jW28wqaS8yY4LdD+dwkWv5PxJ3Hsdw7CcoMe/iuR/bQN7URZ2uwv3duCOUTv1uhxM5XkzDVe+eHiet5gw73C7rQJLkSCL/iTvyePor7gr57lcaJA2aN6uuL8Pr1jkyaAA+A18GM/7IlFaeLiGQN5e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv9sUr6u; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dff837d674so1770785ad.3;
        Wed, 03 Apr 2024 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174912; x=1712779712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6+r4Zsm+3AsCM6pHOirbnqMypJToBlIyMm+FDA+rJY=;
        b=Rv9sUr6uMGCZZ3GBCvL3HuFKdo2J0pEQo3qrDdYbEQUckh2MAQthhau8ed/u0kiwtJ
         u6Em1KZAvckjWpeR6LlB6iOUwjd1jJi0VBKo3XGGTmf/Ft/dThx5SnRRAqSpCG3L9tDB
         BJgNHujtGKlfoVxlmji+Wnqw9i+faSq6clLJx8GlCezJCQpCbLRBI4d3Q4auZR8chFTt
         WzDkw6KoQfxnQnhwqpC9bXhIWB6lC6J2D+H2FtdcffXynlu1NVIdhcX3z1e4KeNTS4Yd
         njowmGXCOK5+Me1RTKfOMFguKwWY6LlYNxT6ny302dDOYc6lIudBRg2YbtXqkH+1MfIY
         cx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174912; x=1712779712;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6+r4Zsm+3AsCM6pHOirbnqMypJToBlIyMm+FDA+rJY=;
        b=iDPvzQANXxGiL7FziTmhxfvPb3v2gRJVm1J1IJEsQ5m8KxU9H+KnjxiyOd8H4+irVA
         bPpiQ/yXe4BAaxrGBV1vECTe80Ov/dneNprRCoyeBPyOj1d6XGNrjL7jAq1WJF95JnG4
         iGPdLU4ZRv4jDAPPQMKD2QiDGGrkRPKm/gm0mxlrziMOIKC6RailxxPwUO/HP/Fke7m8
         ocE1kCgk4YxmxKGrMpq2hQSFWqLtouA7Il2+6Kz22461yTFstaAl7KOqfshBnNzr6LCe
         jrW/K6H4OdIjP4rvgIWdEzEBPq26DTHZDclu+f58/FKg8gZ9zISfSicP13aTdCvr5ufr
         fWMg==
X-Forwarded-Encrypted: i=1; AJvYcCV7n59gxyNai3Xc3Cf+HGOeSzNK/78hi6HvDsNrirVd/+A44uy4ThdMhcdTODQ+H9kNxAyaEWcOwodEoA8gOchLdUvYqLpgsW1X
X-Gm-Message-State: AOJu0YxVL4MvJuSPF3KuHPGVNxA1VsJtKhCP+deEOyY7cOJrZ1gBsFN9
	t6LrnmHlzQawrZIPvLqstsNCD14ZYMBnA6eLW6K5lVCKP4JICvF0
X-Google-Smtp-Source: AGHT+IGUcJ5K7PnBeEskPVlOSiGNbIzfNyIJLUwbSjMXWFKAmJpzT1BEDGO3mGOdLom4RDvcxDJyPQ==
X-Received: by 2002:a17:902:6b0a:b0:1e0:11a4:30e0 with SMTP id o10-20020a1709026b0a00b001e011a430e0mr328153plk.19.1712174911661;
        Wed, 03 Apr 2024 13:08:31 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902820f00b001dddf29b6e8sm13699110pln.299.2024.04.03.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:08:30 -0700 (PDT)
Subject: [net-next PATCH 01/15] PCI: Add Meta Platforms vendor ID
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:08:28 -0700
Message-ID: 
 <171217490835.1598374.17542029177954737682.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add Meta as a vendor ID for PCI devices so we can use the macro for future
drivers.

CC: bhelgaas@google.com
CC: linux-pci@vger.kernel.org
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 include/linux/pci_ids.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e467df3..e5a1d5e9930b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2598,6 +2598,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_META		0x1d9b
+
 #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
 
 #define PCI_VENDOR_ID_HXT		0x1dbf




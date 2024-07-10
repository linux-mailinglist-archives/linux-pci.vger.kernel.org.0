Return-Path: <linux-pci+bounces-10032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC892C899
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939BD281D01
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056093BBF0;
	Wed, 10 Jul 2024 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFNH6AhN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5D3C6AC;
	Wed, 10 Jul 2024 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578836; cv=none; b=oeF6I0B9phFw/vAqOKvAiTzLSYj0fvuxYtrQ3xwK2Gfu2R5Og7jHMhzhyPU3adNAdjOtE53pkHRddYtH3hFOycTOolLWiz6jGcNg5/ILMxowo+nlxQvFW2qBMEoW43HN4fh4FTwGT8cOq52/z4QWCwVCgxf940WM+mHWdIRPoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578836; c=relaxed/simple;
	bh=ZNdxnGPfETJa9uUYOCiuRxUSQF8J7Opi/FFw5TRGvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGqid4Hc40YhP/pBuMAt7KqReBeJQzrC5OxRmB8pvm8KnhX+IvaA5NSjif7mTKtN1a8f33tX+yO4Y4TyQ7fAZNqGChDtz2qKP/Oxg9lqpBOVbYxJT1esXKUb6J4HaQk0zarJFj9zul6JHN1JNRK5/pmZra48trEG8uT6YD1FzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFNH6AhN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso1586985b3a.3;
        Tue, 09 Jul 2024 19:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578835; x=1721183635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=MFNH6AhNpRyq4PTVVxMcre3QKkYdBY5+X6q87//tiAe+IiwSLBTMHgbfCkboD6EyU1
         MCmHgP+j9rIRSAvLe4qVeh0y/tAU0k+S+y8trhHGq8+rDZ3tVwza/a6Kri018KFZPLBH
         pWDiY6jJQHoePBdZQpfAOv6lw630y8QhTE3gY8iOT2eDJJIrIq9EjTJYGV6vM6G3ir9R
         A2ugJHyxbILk/VLE/NFGsvLLiCcO0FIDRFks2NKacAxtqOiBXV3GyyOpIQuRfb53SLxX
         3cgtkQXw2a6wNdwwMOWRgudekmLy9RcJzDEOBS5fEqPQivczwtGExrVlY6mzEaaVHGbU
         kmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578835; x=1721183635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=XAwTwP+1mr6rFVKeAYe9rB4VxomVYkiDs+HnVwAdKY3POz8ubcSVM72b98X+d4/x0m
         KRtbvYTc18xtjyOXlLYoAH3iP/86v000WYqw+v/epzXdYGuaj8xxVWxhKrBF6c4w6ixp
         q3IVr/QTCxlg+V1RKpcsvbZQqyWLweaxexoLYg1ZlUkgJXTMgMvpSL9osP84AqLbqJ/I
         Ewgfr/xTRVo0apyJLSR+VTta2dp32EP4MKOvBnekjUARv40phIZGSAP0HtDS4S5Z/b+S
         /Yqr2UTfizeIfZijanAhV3sI+af/8e+UHfXTq1NJp4uWwvrFjJaR52rpspytXEkVDiGD
         5gyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9tjAYs92N3CYJp4OulBnwO9esproD88Y8UD/hH9LvElOTsP8tTj0LGLQpH9hVI/OCGsETb4nP7X/NgnVgVBq4c+NvkXSJ/3cFg+7zvf+Y6XlW3tr2OIbrlc9W+vhwFR0aHFe4QgYZ
X-Gm-Message-State: AOJu0YyCQ3lh7e+9cLa/H3+AKs+IHFwFz/SiEoZI2zU/Wz16Yhrvhe+5
	iyrCJLYKGbltsXlBcDMcy3cCQMi2veX7KTsZpcLc2B4yl8o9WEk8
X-Google-Smtp-Source: AGHT+IECMI55o2YAxIbwis8rCI5ypoHccC3BasteSVpSq5u0Ig5C2GFoNxu8zwMPE8b3bdYhobfbgA==
X-Received: by 2002:a05:6a00:90a2:b0:705:a32c:8b35 with SMTP id d2e1a72fcca58-70b43587c90mr4295525b3a.19.1720578834626;
        Tue, 09 Jul 2024 19:33:54 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm2630992b3a.178.2024.07.09.19.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:33:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Wed, 10 Jul 2024 12:33:10 +1000
Message-ID: <20240710023310.480713-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710023310.480713-1-alistair.francis@wdc.com>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..09d3f5c8555c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,7 +122,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.45.2



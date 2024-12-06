Return-Path: <linux-pci+bounces-17813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C19E6196
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789342842E7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6800372;
	Fri,  6 Dec 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rFWde3GQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E63D68
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443466; cv=none; b=ckKk6/mrUrbOjx7u8z5RRwos9o2w5rfsEG6PS4fid4GNroypPjAvgR3o9p4QuV9ovCi/7TnkY9Zl/fCaOeAjjK9m4yrPQkBF7UH8ShOt90cUIdR0vp7qe1jnUPXv9V8ZBwG1ve0KqniaS4yTNzVzjoJNAiqx5U/Ae88UkKaG4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443466; c=relaxed/simple;
	bh=zRvtSc5/ce4hxl6/ZsAoCNHhptr59b1tfvlYN4KdCgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XD4Ya5XGJjfnKWOQrPl+9dWMPZ2SMBq5l7pG49XZ+itmS03XmyPFPPcvPYD9B0yr4KynVvlviXR+PQb/1DZeGkCtq6PrfeIxek38tVXEfHG6WbuFo94qUtfibOlzINV8TuClQuBtOCZWtG4eV4ILB/q6RhSawHQ3sGrYORoDEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rFWde3GQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D1D0E40CE4
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733443460;
	bh=mIiIum7pPdFGasU9OOkaWNga8UaMofa334rqkxQw19A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=rFWde3GQG9CYt/fFwIxpjTQWu6h7b3fcaLxp/One1stU+QY521nOeys9wstgC0PTq
	 NSx518jzS6GD3wYxCsSXMis8Nn7XX0SSi4PqAtyzFuO+cU2KGfgy9fnQ3i/x9BwDBL
	 Gf5YxaXnbwKPqlP7PNc8zlmjpBbjNU6INHzbeev+ziEFDp+cfGmEL64t/PDZ/Q6y2s
	 ucAz3DUUXhrJ7Bus6WMWOufFklyebxhEYgtzQ571U9GgCCPLotkZATt2KloOlliCg7
	 LRgm5ZOIHNrdzRSi+uMT4mCdjEXsodWI9PzfvAjzBn2hpg15xYAj9Oq3El9ip0DOr3
	 vyikcJIu+4vhw==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d87c55ca85so39535036d6.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 16:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443460; x=1734048260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIiIum7pPdFGasU9OOkaWNga8UaMofa334rqkxQw19A=;
        b=S6Ev4R4IR09lMLEhVDF5mRHcdUefZK/u4hku+lmoYErehOWu5GSMFrZba92SY7sUp4
         ia9XGfAxOl6Wx2hct0IwHTep7HWc/Yn7+FJXh0Ag8+BfSsWS5VZDnTCgKHGOGWPviz/K
         OVEO8GxxlwmFe4gtGeed6ar12WtgTDnXbOBCNjOs5b8E60W4b4nIPRMU3OeTWgVtO/ix
         rHfAo1fopG+xWPXfdZtftGrzv0jlLqfWaEGPA12yPdf50XhVa1QoX/oQ/ffgu+xwhjdH
         zO41utzQLhhBLZIFnSEFcpvkzfdiSRyoRsoox2uvgkxFqdWlJhztlQ5vi0Ijg9ufFPwv
         w2vA==
X-Forwarded-Encrypted: i=1; AJvYcCXtb9TuhGeN+nBEk0OCKGOiT6IJ134Y9QRB+RiXJaybxa0DzLTTn5d2LHhgCKXpigSUXWasONDHUSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOTfvQ8Utc+p/FV1aLYJWsRbl/+GhGnNCqRNoJLBpf61SVof0
	tnJNSF87G7P1FWAynZIW3dHq6UQ1pMp0WSsC6AjYYrgWntc2DA8XMDaLv9S1rm1eBUbzwrusFVc
	1Q9N/4Cb/oTtD74DDgmOyn4NL+Gd4iWLAmzDcOuaOc68cZh2Kl7Kw1RB/agHHDNSRBHH48tvJfg
	==
X-Gm-Gg: ASbGncsIinyNVKdMVasXAchA1DLCbjGGBYXUjBGVZMMFpNo5QUlcXzZvenlnPOoeDFX
	ctO4+D1VH6CPqmIBKWR22ASJznMcJ0phOlFs7lx30byMEaJzELcNGgSTYQqwSACddcFVA/Rf1td
	ntBvQ672Ku2lFmMDoBUcxa3r0vkCyP2DXKtY74cZ3FepWw08fZORbSXcnjjtIX/hgYJ37Hd3Zrb
	2ilCVdVk4qBup3FDpdp/8TQMilppSJkJPcTFH/9K+XSq3gTtd+IoHOTuNAgLcywJgcNqcDFjw==
X-Received: by 2002:a05:6214:1d04:b0:6d8:8667:c6c2 with SMTP id 6a1803df08f44-6d8e7114d40mr20190596d6.18.1733443459632;
        Thu, 05 Dec 2024 16:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG1DvOFWRMwAjXMaAXd+NNAPJkHm1GvcnsdEKgct3OO0pnxOyiMiLQB4iA99PxpPs7sDJPoQ==
X-Received: by 2002:a05:6214:1d04:b0:6d8:8667:c6c2 with SMTP id 6a1803df08f44-6d8e7114d40mr20190286d6.18.1733443459313;
        Thu, 05 Dec 2024 16:04:19 -0800 (PST)
Received: from localhost (sub55115.htc.net. [65.87.55.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696e7csm12161576d6.47.2024.12.05.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:04:18 -0800 (PST)
From: Mitchell Augustin <mitchell.augustin@canonical.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mitchell.augustin@canonical.com,
	alex.williamson@redhat.com
Subject: [PATCH 0/1] PCI: Add decode disable/enable to device level and separate BAR info logging into separate function
Date: Thu,  5 Dec 2024 18:03:50 -0600
Message-ID: <20241206000351.884656-1-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a virtualized environment with PCI devices passed-through,
disabling and enabling decoding is not trivial, and in some
configurations can take up to 2 seconds of wall clock time to
complete. Since this operation could be done once around each
device for devices with multiple BARs (reducing redundancy),
add an additional decode disable/enable mask at the device
level to prevent redundant disable/enables from occurring
during each BAR sizing operation, when pci_read_bases() is
the originator.

Since __pci_read_base() can also be called independently,
keep the current disable/enable mask in that function as-is.

Since printk cannot be used while decoding is disabled,
move the debug prints in __pci_read_base() to
a separate function, __pci_print_bar_status().
To enable this, add pointers to the signature for
__pci_read_base() through which the caller can access
necessary data from __pci_read_base() and pass it to
__pci_print_bar_status().

This has been tested on an SR670v2 host and guest VM,
a DGX H100 host and guest VM, and a DGX A100 host and guest
VM. I confirmed that BAR info logged to dmesg was consistent
on each between unmodified 6.12.1 and with this patch, that
BAR mappings in /proc/iomem were consistent between
versions, and that lspci -vv results were consistent
between versions. On the A100/H100, I also confirmed that the
Nvidia driver loads as expected with the patch, and that
VM boot time with cold-plugged, passed-through GPUs is about
2x faster. No regressions were observed.

Originally developed/tested against upstream 6.12.1, but
I also confirmed that this applies cleanly to the pci tree
@ v6.13-rc1 and that it results in the same boot speed
decrease there when tested in an H100 guest VM.

Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/
Reported-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Closes: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/

Mitchell Augustin (1):
  PCI: Add decode disable/enable to device level and separate BAR info
    logging into separate function

 drivers/pci/iov.c   |  16 ++++-
 drivers/pci/pci.h   |   7 ++-
 drivers/pci/probe.c | 149 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 14 deletions(-)
---
base-commit: d390303b28dabbb91b2d32016a4f72da478733b9 

--
2.43.0



Return-Path: <linux-pci+bounces-34496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499FB309EE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 01:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124B55E0C5E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8C2737E8;
	Thu, 21 Aug 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOXL26vh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BB26AA83;
	Thu, 21 Aug 2025 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818563; cv=none; b=BqfRGhH5vFReQKh9oTKSK55rA6g7Fy56YwvT9gUkmLsmuZLpv1ruAyQztwQXpMz4hsuJUCjXLY0KTxDliIj8YXtOAN8gLOuqtCBpzdohMU0BH2hPm+S05r9XTCoVg3+AXIKmZTTKKU/rZ9BT68yoVtfZMlkMb5udap7WU0otCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818563; c=relaxed/simple;
	bh=sL7rgn+wG6/HVmOt9Jko06Qig1naqeIyg+WTzVsnOcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pr8AbHu3aARfRkmiRaKeWkyp8jyEznME4xVEOgC/Gb5+Vo6NcVdGJackFZ1b1T+264OGuBieX0tPtUqdzYsp0eRr4xZJthjhjHN3g+3jV0RooQl/yVvcGannWKOqMNJkrzlPilDdj/sVu8vul/oQzggspsD0qN+vVlZGObCrC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOXL26vh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49bc4e76b9so261348a12.2;
        Thu, 21 Aug 2025 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818561; x=1756423361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIUrG16OSCXUESGnOwxofzdowjSJq0D0og5pHcSJzgc=;
        b=MOXL26vh5VTkx7TkwyN5WRGK0Fic7vR0PkEzK6HMl5pSqPtH1QY3LfxdSnAkGbkR+k
         6u9ZHg5wWVjKBGpxKZwNW++P6jicMS971K7Dz4x+MqSkslEwAD6V2csN8UlVHol05VAP
         WD6J2imk/MH54fm7shf+/ryWmPQJ8OOBp1OLDOevo41OjrIt8JU9pmKsAOqB1VYEcRbE
         LPIjmGAwBuDIiWUJGMG/ecPCrEURjIHFVpMlvSNViKUowRaqBa2vDaA9efIPGz8hwJfp
         ZKqiJmuDLzZkchsdIWOGJVXCaviDrOVFoC3HOXLcz+M2G+YCdmOSPvNSXkPU6g/5Taln
         VkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818561; x=1756423361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIUrG16OSCXUESGnOwxofzdowjSJq0D0og5pHcSJzgc=;
        b=nTc4Z+Ytu/6/9W6guAWEH1KuLz3JMqWW4L/Da6726MDgiCYYgorTjypbPnvItpGZ4j
         OCo4UCJErUOR9rCAfOHiofD8tfH4xyG/Ec9BXkCS3WZHeZhSWab/kZW9w6yAGYJ+sgz8
         Dq9+xNlSKbhTRubm9igxmbhvl24iMCG8UJfm/P71EbJL7ejDsPgU7atTMuHRw7oPUCX+
         6JCxqe+EhP3+psHLEkEN1CzQh2TW6bCwl/nFppD/8pRewwHbWdCuuwYenXFD9CGambOV
         bo5Ip50+F1tGCXcPM7S/VX1q5+oHemViIUeVOV59TnB29jaMfiRFi31MHQl2dy9x5Siu
         a6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/wVrDFLKud9foOY065F89sGLQQbmpiEu0U2hoyjrWwyZabFHDPGVDbqsgsa4X8myaDjbWaA8ai8B@vger.kernel.org, AJvYcCXPi2lTTNOqEZP4z3ApkJxFc9d67OB4P2XGNgp50rxtYOW863jiQNuBauQ7v9u8ftVWhELL7LEwrS2CUYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+weqpnzJW01sMBMhqIRUqsdwyyYiF7UrdDNnY4pn3GzGODOp
	PglDs1uXtQGN+T4kmpT0d1+fXqBpPMI9DGESGsHDvoYjONP9WE5oXXjT
X-Gm-Gg: ASbGncv+jPDtk95Wc0Yjn1k5JU14AtaIpqWCAx27/VA/PXUWW/4WUyBvJD4ZiuVwu3s
	QOMUjF6TtD3HNs8nM50ZxCbEaog79q+Wnw1SbOPDRFyOl1++IF+SybypidvdJ3ETefOZDt7MeOm
	EVEr6PlnB3GkrUSJKBDyyHSWy/9IsV8QhxE8y4SuBKxPF6zgssmnRChP0ncp1+ZLEw+JxKR1jra
	Ja/r61rWHG5B1SWw4kltB2QiJnhrTX9O+nIb7bRwzZ0OpZfJ9RaJJfll2LIgB3oikMV/Df3s+S6
	Q+ElQRufofYCh5b5qWzbxlrbuMseYh4+v/JLMKZNT2LfGt2JR3/YY14ELALSey7tnNMMqQlSKlX
	S/pfFMRgKNByB1gZJy6Z0KBheq1nh9pBYwTHt+sw=
X-Google-Smtp-Source: AGHT+IHJ1k6JvsrgQXJuGejWwoKEhqKEhRUuYbYFjnWkjudf2W4hJznkjnXC5sJku4ZOP4x389FqXA==
X-Received: by 2002:a17:902:e891:b0:245:f1ea:2a23 with SMTP id d9443c01a7336-2462edac953mr13057675ad.10.1755818560851;
        Thu, 21 Aug 2025 16:22:40 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1735sm9518200b3a.9.2025.08.21.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:40 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 21 Aug 2025 16:22:37 -0700
Message-ID: <20250821232239.599523-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only, admin-only interface for reading PCIe device
serial numbers from userspace, using the same hexadecimal 1-byte dashed
formatting as lspci serial number capability output:

    sudo cat /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:ef:00.0/serial_number
    00-80-ee-00-00-00-41-80

If a device doesn't support the serial number capability, the
serial_number sysfs attribute will not be visible.

Comparing serial number format to lspci output:

    sudo lspci -vvv -s ef:00.0
        ef:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
            Subsystem: Broadcom / LSI Device 0144
            ...
            Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
            ...

We have a specific use-case of needing to read the serial number
from an unpriviliged application; this patch exposes the serial number as a
file which means we can change the permissions from an admin context and
allow the unpriviliged userspace app to read the serial number. Otherwise
the serial number cannot be read as it requires both the admin capability
and parsing of the lspci text output which can be fragile and unreliable.


v7:
  Updated docs to change kernel introduction date to December 2025 (6.18)

Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.50.1



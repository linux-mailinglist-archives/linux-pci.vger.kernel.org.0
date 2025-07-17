Return-Path: <linux-pci+bounces-32415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7477B09238
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2F45A12A2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742722FCE30;
	Thu, 17 Jul 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ7k5MZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFC2F6F97;
	Thu, 17 Jul 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771059; cv=none; b=lNtnlzgf3BnEUhH0hETjlffeOh1bJL7xQ8IGHrvee1ehD+FQ9P29FXH6hcVo5OlTmP23mYc+rLi92cbHDlae8LEi0t14mwOQyD7VRgVVDFeXNg18q81cGgixwds0T6lzBnuYTao5th/pr9KaDr4eLUiI1RKX8VGoOaj14CBZCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771059; c=relaxed/simple;
	bh=Qk+otSaQ/bhrkhXBPwZilIzHHGiFeO9krGAmrxoWEBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kd/NDpwDOzFQudR+UK65Lnc81RIAJGYQvnZApHmsQyz4BmPwqWXDd+A6Pkt6EmEwPr5ol8rIiaYynKJ0puQYyszx9YiyM/cWOHGTWZeR7SUo84QPym/+m58ObxXlgAOwHog/j/wDBLKpCvcikfdd9UO5wWqFl7oFxNoiuHAECH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ7k5MZB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so10950195ad.1;
        Thu, 17 Jul 2025 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752771057; x=1753375857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9X3q0TtgP4k2R016QOhjy33cng8/g6IRNUqUntPpDI=;
        b=NJ7k5MZB++1KEJGSOI4R9o6v79mCKzByKYmqucokjozNKDwvZATZ85b/UzYhidIekD
         RXDboY/LtRJzKmT1vWGHsoQiYxyMgNBbsgKx9r5JvaI6je3dmegif0f3s1mv0Byfiplq
         xHdkSfpkPcKWDFAZYbbDTVj3vDdL0RwgtzKTOZgeJL+LunXGObJbJHRXZvtlcve16dkS
         ZvnKSbrY7f2c9N4/+PfkdrXCg9CnEpkfJpM5Pce9cxdiH+uEPrihFJFEzi7SUeFz9Lpj
         8UlN6mRPtRY7leZ47lyK8GUS6ULz+f9YWYNcNESd9nL6oI7bzyuAVNhwogEXi0/Gpw/+
         DSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771057; x=1753375857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9X3q0TtgP4k2R016QOhjy33cng8/g6IRNUqUntPpDI=;
        b=PADfxa+1/GoLSAhd/zxRMtXdhbxK2O0VGPxRiJ4JJ63UJf7kU4RSXQxvOGgVJM68cl
         4eN1IbWj5jfMHWtU7xCUWvj49xivMGG7QfAgTL2sugBeGE4jPvpTkcX0+jIxa9WNCNmw
         KLsS4Bh94yDAGBnkahFoachjbwLijjwv6OEHcfAXNINRJRU8VkpjHKibPe3UeHKk2uIG
         PklSLn8ly2YhE3dSOSfsCmgtvFsgFwHPOSqfUPTvBCp69qHMCBiWmQDi8292e2ebN1NA
         8soPUasxbyC9KVGdrFYmhi0tM4sLlxRgHIpNKWhJGTSoKuHGi2GG78cBgNgnl1LpUpKv
         TzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCzmsc4hR7Cuk3rYejaOIYAapQ6VS4p7UY4JLb09v2hqDd4lSS9IDSGuejqFLgKuf/GFP3l7iw4kjT@vger.kernel.org, AJvYcCWvSmoz1LPhnBZsJNW3TbNhNpx8AY3fiqb/T3MhYXxIVGU7u2OPLpaf7MseAojP6K1G4Y3CL6Rsk1nMqtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Q5LUi8GlNTFePX+99sWwARxQ7+ZqcTWoFuycBw0phSmqZMuo
	OQhPqPEOOqwVqj2IrIqo3AtFLtWB5iZpbjICpDBNI4KFu1wTAW9/fxONTEKG+g==
X-Gm-Gg: ASbGncto1d8JFsWq5fx8h8VvVwzm3VyjooV84ffoW83B+pL/KvX4sncyHIaOJkJrxH0
	m7SUB7B81YRZB1rCa16Xogod5f44gHFlxONFj6J+KQWHHEMjmElZL58mENr47ow3uBANtqvyreo
	2EO5+m+tYOm7aLDZtTadFkeJEGwc+7Axx5ssInRhTXCGdOAzkabLprSbYnZWg3SoaFogua7kk4c
	FXnoEYWFQFrmKmcuGZEg9fVBcBPrYStz444+isovtZdQI0dyKcmeiOZbCR/rINzj6Mh2UZnYpLK
	Sg1qP2+6honK7O5qa/8rULuklzqC/hKbuyAu5i8ueMrNUIqQwslVGSpBKaUyBP15cxpp4PAFbjZ
	xm9Y6vp/nKOJz40pLReQeQseTDQWlhDBOxp3UwNo=
X-Google-Smtp-Source: AGHT+IGxS3bJv6ZaPpVkkTvG2nJQjNHK4/h/hcoZK+js3e5oJ2LRsbD9l1HgyOvqUM/XIXLe0FF5eg==
X-Received: by 2002:a17:902:c943:b0:234:ba37:87a5 with SMTP id d9443c01a7336-23e24f4a7c9mr99073915ad.25.1752771057278;
        Thu, 17 Jul 2025 09:50:57 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43226c3sm149787965ad.117.2025.07.17.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:50:56 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 17 Jul 2025 09:50:53 -0700
Message-ID: <20250717165056.562728-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
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

    more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:ef:00.0/serial_number
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

This PCIe device sysfs attribute eliminates the need for parsing lspci
output (e.g. regexp) for userspace applications that utilize serial
numbers.


Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.50.0



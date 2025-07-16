Return-Path: <linux-pci+bounces-32211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201A6B06CD3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845BD1AA6B5A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642B273807;
	Wed, 16 Jul 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VropvRfC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4326D4C1;
	Wed, 16 Jul 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641606; cv=none; b=s3VNjqxgkj6eZ4BAcJWd8ZniSKKb0jVxqj+kkflOZXp77lqjuK1ULZT1LDyLr/dGgdHUEN8SutSCiuFTDa6TDuZl6PKNQWXqol895pDFota7/BXDEAyp3yFI0EaHkeKkSUXrBGi0cSVz12/Ucwna5qrpCO1mvDeUVNAPKnFhwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641606; c=relaxed/simple;
	bh=VMslyOWiTODKoJBFs96zZygrYr6IRQjUODRmLYdMdVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+ThONaBVAV6y249hW1zorR6WyjULXFkjG5vjcqamw4nf6ewnDNG8S18uf7I+0liTIH6lyD1CJskT3wh2PJ775Cd6KcVVESS0xL3w4BXhph2R8psqD6HxCzDs1bvs3sF4x4tOduCrGlKLseRZk9beOXRJp6v1zvxP1RQUwC0k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VropvRfC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234c5b57557so62616785ad.3;
        Tue, 15 Jul 2025 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752641604; x=1753246404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaOzDu4g1GbDoNc/u72KzEqPJpRWAc6rUFpfBeaIIMo=;
        b=VropvRfCZWEg8qXLm/+JkQkL+O41v5wllcSH51JYP+7HQxlOleiAYMKJJdDTItd+Ui
         jc/X8fZhgiFfycQITmAh+Q53fArgk1Ky+2+RP/QiPk2d7YrucR/dXt2nK3Xd8OxmriaU
         Lss70a2XlG7flzwxMaX2E9f0nYg41Z+0N/hRGMk74PUp0oxlI0TPQ4Oh0CYVM9JxwqIm
         ZKYEF0YKxExkBEwcXubYW71b3IxzEO7Bf0j+aQRjfhrfMN6rLCYr86E4+tRqkwmEZcee
         xYJfT4OXI4NiKiFx17kYLTyVlqdnH5WGIdQmBA+oe0QQuJro/acuBi/Eg2YcuQpgvoFb
         AXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641604; x=1753246404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaOzDu4g1GbDoNc/u72KzEqPJpRWAc6rUFpfBeaIIMo=;
        b=QNTobnDWYg6XwEjQTAwD+WGhjtKFQ0tc3TkzFavjiKIvNJ3QHmAGzLg2MMFqWY3BZv
         YgFX8+syK9l0swqD5LW39CSqMRqzBTHSHx62k47yZv9NNxx/wHx+qpqg6AcXoCMY1vQc
         vOj4KBIQJGbyNSq7JLjIJ5htty7V9DTEo4lAUYIr/q4eIwh0Bh5oj0W6U+6raypELqgQ
         JWa4TKPMRkGxG3Jbj5QkcnLjcleSVB/WTJFOrnpxHJ4W4kAI1rRtUlNut5RvGDvBgNJe
         GAj9ZE1+UQgwN8us6xF4lJy7g7fsuLYqe6ndcTswLoIUiZoBmXLS75a689HLok/Jdb66
         DSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVWgtsYTZ7XLAq8sSFin96oBjrSzrkcWFBXe07ydhSbTnncpR74e9k9O0plf8XodyeJUlyJwAm9KaxVQGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxajw7Zw/Fb907TwZrRplhfJYQXfnsjAFCINEr7W2VLNJXs8w4f
	4fJ1tP/WuBxUiNKqg+rBVaV3FxJbTuhMhC9DYq+Zg4G6IOVUJFH/BiFYEc2Bvw==
X-Gm-Gg: ASbGncsMaMzaFx2qIVSD19pLLRR7BySvSNJsNfMgdwncmcgFVHRpKgy2Gi/NtfmQeY/
	3hV+B5ul6+qmWqPTk0OhiEm25Z0mGkjY2T5qXdwO86pkDwcZ5vXO37gXR2ga3FSPQnScv3Az/XZ
	DEBkI1a16qfevqvM0oTMuM0veFnkLmN/a2shBtsdZ/P4fj4T7o0HVngcRWAnA0qosN345j05On7
	bqwYI5q/MlT0UxfhTdJQW7q08I1BqLiBqAN0y8dLZ+WYj7LuDEBJZmEf4NUdMg0MuRrA6XiNj9x
	ab8J/kzL+Eiw0BwUizLF0Vn+QjiXxPZyMrU1H2BJHLZVgqtHYm7+KSC8J+/XeNUb/GtWOo7ZD1j
	iMwGVom4VL3bHBGsSSWCl/1hJheIUXLoSpMcjKJ0=
X-Google-Smtp-Source: AGHT+IEr1x0ne1cnrtZn6MWxi3MRSSTzb3wWLZKJz6ue12Q7frduNOFV3r6mBk3ulT0nwek3WLgTiQ==
X-Received: by 2002:a17:902:ce81:b0:23c:7b9e:163e with SMTP id d9443c01a7336-23e25685233mr17130725ad.11.1752641604232;
        Tue, 15 Jul 2025 21:53:24 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434c9cbsm122889375ad.202.2025.07.15.21.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 21:53:23 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v2 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Tue, 15 Jul 2025 21:53:21 -0700
Message-ID: <20250716045323.456863-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace, using the same hexadecimal 1-byte dashed
formatting as lspci serial number capability output:

    more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:cc:00.0/device_serial_number
    00-80-ee-00-00-00-41-80

If a device doesn't support the serial number capability, the
device_serial_number sysfs attribute will not be visible.

Comparing serial number format to lspci output:

    sudo lspci -vvv -s cc:00.0
        cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
            Subsystem: Broadcom / LSI Device 0144
            ...
            Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
            ...

This PCIe device sysfs attribute eliminates the need for parsing lspci
output (e.g. regexp) for userspace applications that utilize serial
numbers.


Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.50.0



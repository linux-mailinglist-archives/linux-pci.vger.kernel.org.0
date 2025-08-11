Return-Path: <linux-pci+bounces-33777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34950B21371
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA53318814B2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9592D3ED2;
	Mon, 11 Aug 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phb2A2Rs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2A311C16;
	Mon, 11 Aug 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933974; cv=none; b=UeCSDhC4YEqbqsMC8bAiZWpUSZPI1QQIAqLBuQ8G1fBXWuPoW0vH91WUXHVnkUiGtyRqM0U1DTLg399ULTiNfVEjbF2V63lQ9xuEpWm9hFcAwxoiaDyF6e90M6zox2CBW5hkQSTPH924zP54Fq1OIjpIPaNchyji6r6v93n5sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933974; c=relaxed/simple;
	bh=Ey74PDj1a4oyieDGHP//4h4HWui+huax6LAJOHAbiEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzzX9vMe6LdgO5me7zmYFp9FnyP+f04Zz1A3F0UVlRCgxdVg0cXdzjLFC4XMtdh2i0g7c70HWOcTvmy551lIYUHg2k7Hq53uUoiuHcogrjWimKUxooq3cLzPX0imDaxiD7LiFeZQNdH3lPI/S6KJpXvq33BLzb2x8EIMMeNLkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phb2A2Rs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5982289b3a.3;
        Mon, 11 Aug 2025 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754933973; x=1755538773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzf4Ym+R2wd8N0G8qgb9NnmRvobdF6rE8QkYPUS2xRQ=;
        b=Phb2A2Rsmn5pCpfMJQl3PK1C99yN0JmeHM4SmYcOzi0u0QvSs8bu9pK3vJVH0tUwxJ
         oKLL4Kbi0c4NDq6kunqA5hnrVsk6XunA1T67tI/WaV9Vw+4+dalehKD0MxDVFv3KhJVd
         5iN0o1DwPaHc7LCEalULGeKxVOwyrO/1jJf2BTO6W9uqnymAiqPeAT+EQWt+lM6d7jFt
         TCF9t/a87mJj61g4MyQ3CvgnD77zSW0YDZzirnxSNyXpv3W3tq0GN4VbHX8pKOG5AdjM
         BrCqvPSP3TePjcfsCb5uVD3ZuMCmp7ye7AUEyzkfIdhdgXP5r8UesKPHLBAVunLYmKkS
         XluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933973; x=1755538773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzf4Ym+R2wd8N0G8qgb9NnmRvobdF6rE8QkYPUS2xRQ=;
        b=ZVRg9CA6wC9yUVqpY1Qfk8dz6zBaRcij4Ai/c0WwhmKgOcB5EYD4bpgjd5iftQrnai
         SatB6F/I3M6EOyWRgzKyadRUdfAu2rowkaqfAwEQsgMp8RmcDh8nziYaGVo9G65x9esw
         8b9SFkvS75B7rSwpe7prItXC1TXlpXT40Ku7IYEG2sS8mjZ0XGnFTlMHtK+lDbihJofX
         l6pmV0LviigswFkWpU+gCp+kUjAKBUEHvxS6hoI3c3YVHWnp0nz+F0Hj7fAFeE3BmoMU
         tD3THW1OZwMSoTTF5WUMcPBWuPT1ekXt1IuFCJP27T3QVAL3kE4qH3fSnewfwbVKmnCW
         qFXw==
X-Forwarded-Encrypted: i=1; AJvYcCUZK831IfN1CZfFq3jqOPYGONVsyLiNcHRkZ0X5LzUVbsXNs0Ud7RU3sCJS8ieZf3at+rX8ffy2NPDK@vger.kernel.org, AJvYcCUrYZaqiVbvczek9XwqdiZS6reSjIOyChj3EBaK0FRtHSLANeMKNejcy1NZ9Il2hkb1MJQ4Z46/vojG6Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyD+5mdcRMji6BYT0B96AOJA8Je24l8KSx/TCtdHuzpskf/We
	08ydMcXtDy/tsNpaMJJb1jMwxcv0ey8PX4fGiARlRf4DKs6gsQpaYq1/
X-Gm-Gg: ASbGnctj9dPMfug2rLnG9TQAAWoadP/skz/gaAdXh6kmYTWG0JZ+OUOXZeyo5N0HslG
	zb5g85ZanZ43o+0X2f5oMzdpG7/FVBMMYj9+pIE4PVHQw/Do0yRzXM9EWKReJYXpnckY9LgUaXz
	IppAiN1Yq5DDu5gvjTvNp2DTfde/iVUzzJe7kaxe2e/7STp+QfDRFZFv+zpRN4agFKOv8qE92JY
	mRhck1V1F8hjKogEGgQ3riSLLELCznzOmDs49MJXeqipuLY1/a1cTsOoKeJJLXlCNV+PiirFkZX
	JvniPBnfd5WtPT0ebXgmJ6qkoVjdCr6ndY4RlsD8xx8zFX1yjj+rzCb980dRe05XKdqK9jTkHNo
	R3zSEz7HsNr7nAnFnmYZg8lVRI5A8
X-Google-Smtp-Source: AGHT+IGP9MFRg3G16ocnm1v9gXfBVD54hhZqC3mHKtHo1i3a+5bfqSZEnr2GxfM8P5fULmad4NxAMg==
X-Received: by 2002:a05:6a00:3cce:b0:74e:ac5b:17ff with SMTP id d2e1a72fcca58-76e0df6cef3mr624654b3a.13.1754933972593;
        Mon, 11 Aug 2025 10:39:32 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm20863978b3a.2.2025.08.11.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:39:32 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Mon, 11 Aug 2025 10:39:29 -0700
Message-ID: <20250811173931.8068-1-thepacketgeek@gmail.com>
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

This PCIe device sysfs attribute eliminates the need for parsing lspci
output (e.g. regexp) for userspace applications that utilize serial
numbers.

v7:
  Updated docs to change kernel introduction date to December 2025 (6.18)

Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.50.1



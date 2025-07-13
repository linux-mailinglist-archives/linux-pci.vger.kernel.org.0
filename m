Return-Path: <linux-pci+bounces-32007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE99B02E54
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 03:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8023AF49E
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6817C91;
	Sun, 13 Jul 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4A4AIKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12C17736;
	Sun, 13 Jul 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752369437; cv=none; b=TpIIln0OxIria6GxYe1FaZlR+ws4m41SawKURI2JPwH7IMrTeAnXkBMcLR49u+rfMzQ1WwhWU7IONrbKrqj/ap0e+Wm+lWqslDFuZbYu+uilJS55LAh9tmTHujYjVfTvrhZNZUeZ08m1/9TT3JAh6hVEY2A26fiKWWwC+6Ql5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752369437; c=relaxed/simple;
	bh=9fcfBv5M7BSaYGZmCNIOoHulZXhBJp4H0UHH+xhhK7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxQhHWOpUoq0yRADGoaNUKrKmS0zDeeT/GksqfNoLM04gmRcKThB4AWKHaXhXDHzuPhmHR6YauqW2hA810r7seQSs7QdD8joGUA3/+wTRP3CmvRYWGbtdlal+IIebgsg1Xb++CVWWalaVaT/KfnAiI0j7+DUHHhLeXQSYAT13cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4A4AIKo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d710d8so41957295ad.1;
        Sat, 12 Jul 2025 18:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752369435; x=1752974235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHdVN3AILq+UMnKWcjDlXOB6J65yX52trs7FSPfQTIY=;
        b=X4A4AIKoSn8wZR1DouPUIKhiU3UJ4jXuyPZAAlHIi28OYL3CvchujxeG7oDKzD68io
         HQSyqWDlbGmmEDMmKxnUyLv66ukgRANhLELrXPTQYSKIcUsnR70Q7K8XXoSsjtxegR7P
         jxjMYhlnNShG8VGXj01CqFHBaTjqfXDlkb3eVbPZkXDSPcsoy4uRhYbw2/aztKQRyN9v
         W102UPhW3Fy4jvJTLWl3+9w043ci/7KBuYoaCMMrrLDBz0JCsLJnTGhNcd4xEOGvBEnF
         c3nsCWTLjPcn9i2cdUiTVIOIiwAdlPnlNgK7Y+UZReJQ7yqF3wcWq2a3nYc7GfHcy90x
         0GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752369435; x=1752974235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHdVN3AILq+UMnKWcjDlXOB6J65yX52trs7FSPfQTIY=;
        b=rHje8cCzZCUN9smlYs0aTAH8P+DGwhWbcCpNe7ljUS6QIYEJwCMstKkxk2HVkIkaS4
         4fT9LHfYsmGQQ1IrFo3k2vX/pE4TlNVeNGQYNr/LVRItTRVmwwMjqNYlh9Tk/K0PRtHk
         IBpdTsnRcw6suAn1YheinJMTSSy2U+w40lezOKkJObKfUcar5C+MxvPMbJCQh9ci1idz
         zzgmmBUOe9Jve8oiVLI3NpjvrfD/3CfLQYxXRL9SbTnvtJugJsbrqBfhZ1fD3gvmK0kn
         eMvnO4EVhkY5wpsbvQMd+iBOBmpWxfk3IcxN3dTL+DCvi458wAiR+OenLyjBiWfh4MNT
         WEkw==
X-Forwarded-Encrypted: i=1; AJvYcCX+L57/Ex3XGdLEq34qHoULpsS6sqNu+8ZM6aZx7Dgrfx0PUoLRR7AyqeQRCTqx5H81t8mt3Ad0chCWkqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJBuabjJB0I7UZOu9HddpSoNWpSR9Wcpy+8E/7mkifxlSDIFx
	2AWXj4D/J1L7inH06NcC4cJVSHtvOcuZlPlnK0wgQT6nZaNAPSvTTNys3Ddjjg==
X-Gm-Gg: ASbGncvFbUVITGTjSyJs2V6SaTvehXgDJ0fAzd5iWlYj11N0M9ROuaFMRXyrtX1hij3
	Osn4jJBhCM9e6erSuFTg8BiNWiQZQiJlOotweJSZ7KBiq2W5BHfOk2QtjRCMdG0N2PpXg/tNdke
	+pOc4qHp5rMMPV0cf2O89a2zP491bK7VwN4C3rpreUf+BAd/Tz9hnwL2jS1WH0JU4Mr2CzeE9DD
	sU/R5b9OPxMSv3aqAzZeP70ecl03hVM4BX7/fRoE1vRU9GsWSFjYos5GFGzgX4yStn4PCl7YN0V
	XdsdoMxXCHsDI2FOZQZOqtVg8rq81mekg3VExGrc1+QCtjF6DOA9Hs1F0m8UEKS0w6VlEXAesw/
	jfJtYRDhDlvkxeKDqDousApQ6RmlnakRWP+EL+8w=
X-Google-Smtp-Source: AGHT+IG+bf788ONZ3xo2e7tyPz1n4iF4ASquBTq+qWbiyuJBnISThEYic2if6SSdUKskUE/NTu1M9Q==
X-Received: by 2002:a17:902:d484:b0:235:866:9fac with SMTP id d9443c01a7336-23dede2cfd8mr124363935ad.2.1752369435323;
        Sat, 12 Jul 2025 18:17:15 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad268sm69594865ad.77.2025.07.12.18.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 18:17:14 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v1 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Sat, 12 Jul 2025 18:17:12 -0700
Message-ID: <20250713011714.384621-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace in a programmatic way. This device attribute
uses the same 2-byte dashed formatting as lspci serial number capability
output:

    more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:cc:00.0/device_serial_number
    00-80-ee-00-00-00-41-80

Accompanying lspci output:

    sudo lspci -vvv -s cc:00.0
        cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
            Subsystem: Broadcom / LSI Device 0144
            ...
            Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
            ...

If a device doesn't support the serial number capability, userspace will receive
an empty read:

    more /sys/devices/pci0000:00/0000:00:07.1/device_serial_number
    echo $?
    0


Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 drivers/pci/pci-sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.50.0



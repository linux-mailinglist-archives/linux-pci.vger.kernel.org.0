Return-Path: <linux-pci+bounces-8569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F67902FAE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4451C22A2A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 04:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FC170838;
	Tue, 11 Jun 2024 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu9nDKZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA232140E30;
	Tue, 11 Jun 2024 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081633; cv=none; b=FA+A7IVTLiU6PVErXMVPdRFZWzagWov0tQ6uZwi0tGUUq4m33Col6Z9TMPdmOjqKtxvBYipd8xQ9ycE0jAFfN9J/Ri5nVWU0FO1wSRjr/Kcsi1760NY/eYDcPfqNCHnRf0S07L+h4JXTmhsicMOh3lkeQysSM2tKpy2YmVJy88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081633; c=relaxed/simple;
	bh=1X/ZQhL6WYruRs6wV59QBOGQ6BwKT2WZPFiyaV+3kjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHKNA3tvh5Q8DNSLk2ulJEMQ6pPqiKWR0a7gsQWzus1kf8a+v5hZFlYoxNrLrZxLNYd5C3QvDtDt0ck3Fh3ATEP7AzJh/9uMXvOXBuv31ZXrHmhbHEzx94QyWcELDeTcaTOU/CNP813UxmNRGkSf8Ye6qhKe3pWtkKxqxr9ug3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu9nDKZZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c31d6961beso175005a91.3;
        Mon, 10 Jun 2024 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718081631; x=1718686431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqvYdmyboRjs5YwQOIXi7uArZqguxlGOogjP8HFOvcU=;
        b=Fu9nDKZZSCw9iNe2cQlFJD68e6CC6M1zRPZMzXM0QulRYoVBQsqkvEtheXvEhpfWcb
         s2csQQ/iAlemgRJOzUazEaaPM2+8CgPAsEV0icmGZKUIRbHkXggpSV2gnyn7kOee98uj
         dfGkK3VH861LOCSuDIykrNs/RGZoCNGjrdByUvYZhtaxI2FhTk0znqlht8vTf0oPRV62
         CtUa8P4QV3K6iHb9ufsxKi3H/veats/HNyPB2FW3Kd4K/BU5Zei9LnCLz4WhA/+Xy+Ha
         +6f2qt3z1RZmDORDzfBRbXb6YpcW1V6wUOkTda95bh+2jcZbLzNSbxi5+2zASJc2k/CK
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081631; x=1718686431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqvYdmyboRjs5YwQOIXi7uArZqguxlGOogjP8HFOvcU=;
        b=wcrH2C3T+D2IgulOLSKCoxD26/ogRkuUUm0QARksVOf1bE6V+CZE8JGsEJ1puMyT5X
         SObxz1pb71i9xc9xuLb6Gz0weZXnv+dc7eZ8M2ZaGwsN/vBw1L2T8+yw2xWpcnNupDKw
         4NDaT08aVV+KH/7zAoHLpQKx/OqtqB0jo7BRGHhcYE0x9hspXoa4dcY0NGH9rrOf0MhG
         UbTJEHPR/dEIl6QtWWFTsUPSyaF0txWhJJbFa/gC42a3wS0AvbnF7eFcLB3KKWtchRoE
         ecNCtnOscb/cu0yUo8PufcKBhKh54kjUD39+gKWnA8W9XB8/TAv1EMqj++Qx1wLTA+GW
         hKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpgRsk0dIkRM6E+y8q8d97TOr735WpvcKeD4eD+8TAon+WpVlF7nLWPDScrVCp+YWvXJtF0hgh6VfD2nxiXzRfDkFtfXThSIj+
X-Gm-Message-State: AOJu0YyOZ4itFshUN9y5ETNm7nZkNew1ph5c3v3kpIpjSJHiNFMd+H+0
	1ozLdK39LX+DL4mCNaZD9o9DP+YsUdFnYuCH4rQZtlbwKO4ZJU74t01KY6zT
X-Google-Smtp-Source: AGHT+IEn0T4ZuFmo8RhZCiCD5z91a5ewK6WO86/E08XYCi6za9o5IFxc7ccpKLhWI131NhwzPTrUcg==
X-Received: by 2002:a05:6a20:3d88:b0:1b6:d2e7:160 with SMTP id adf61e73a8af0-1b6d2e7039emr6251507637.0.1718081630476;
        Mon, 10 Jun 2024 21:53:50 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31bb3c141sm1967277a91.10.2024.06.10.21.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:53:50 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next v10 1/7] PCI: add Edimax Vendor ID to pci_ids.h
Date: Tue, 11 Jun 2024 13:52:11 +0900
Message-Id: <20240611045217.78529-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611045217.78529-1-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
rt28xx wireless drivers.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 942a587bb97e..677aea20d3e1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2126,6 +2126,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.34.1



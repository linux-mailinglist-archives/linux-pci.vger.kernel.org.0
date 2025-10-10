Return-Path: <linux-pci+bounces-37798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05312BCC598
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DE92354AD9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F90202976;
	Fri, 10 Oct 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MYqrMctT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091722A7E9
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088678; cv=none; b=YjYdPkZc7yOlzRqEgbYSHpECFKNEafm5GVO3J7q++9ZtudVZfuw85CM/qdAIFbOeQWz1fk7/tuVzHnKCF8EmIocW6el9OCM4r0qcmJH5jClfxLFpXeGAneb3v9hRWNbtKNS38hWhXDKvIIbEDx8FRuSKxBsMuUA0umfQmeyZig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088678; c=relaxed/simple;
	bh=qtyXxFNzYev+4sHY1k8Z/6Js1alEBiyh+ltp8YfTrc8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fmG3Ng1iSwiXhjDlp8d0jCE56Pf+WJV7Zf6oKqTHHLlZUUgN2BU6MzzPXGxsACDotJJ/OmdVt+eTaEFRHOerX+PcfSkdyyhu4ZqJC2rZVun7ovHJPM/2G1SOFCEPu4sYta6ue8BhLTKRmeLbU6lNRzoFvIrf23FBJw81ZSBmSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MYqrMctT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ec291a325so1384769a91.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088676; x=1760693476; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yfrfouF6ETlGfTduy0jm/scXEJivTXLL0/wFTholkM=;
        b=MYqrMctTtIRkUatV/tPgmzDTN6cdq2DHQm17cQVD9k7oZtZ6hFfK1A+aiKssKuO5U7
         sd0nCps+/GkOLHnovzKkTxw5godcnVy1JrUN81p7uuO2AHk5RYWqecZ9JleA4HNN/Tvx
         1jCLmoR7wBuAgKAUgy5Ha+gNzc5plo/dAJM8IllwZNQtcuKwC9Qve6pd2TvmzYuKvqZS
         Hiom6pdRxU/SWeu5VnPtWWQIegrpzx7RPssQKg+kX+PAJwNDoJBR7np4caEkUEwN2XSs
         T9c8YzGUxfu4dJW/+F35G2HRoaE/hSVL3LMrOi1M2q2xlDjLyHPK8KpH+tLrgOIMpfLh
         ObtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088676; x=1760693476;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yfrfouF6ETlGfTduy0jm/scXEJivTXLL0/wFTholkM=;
        b=nxqFPDQ4KEgawpNHvMHc6tcTmW+vJpwcbIYftwR3PqcnxPNyLrw3EuHVP0ZGo18Qco
         JLfy1uWySM+CMhg54eeQrNSLkFUwU6GH95Z46qOI2Pzn81fSnL1H84vMVzecL8Oshtcr
         gkd84A24G4lFE9hgb7OLqIreEP7LoeMn8pIdd0aeumxIvOUTVxyqaJHA2jWx41vylw2M
         e3+U7NslfsjVFfndNEuYLIc9XSECupcc5kxnDtm/hnRhaVVeTLPm1UacFNCa/SJSLGN/
         TMhPKjkeZkbV+lMXlshutTsGT4I87EvJ7qq02AtGoReMgdCjuspcDTNXAgo0VeDGW+Bj
         WTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf36v7Esu4TeMwOkodrmqitsNashQLdswoUC30UPyP9tEWOz7+jtdDby3Ro/KdzZRbTLA7z6A/0TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjrOjiXwctD7WBOJon8zdHInNBp9rogvl5ZvlWe4VoVO34eBp
	/xnrUo87pWnOrUOX9vgdPA58v6G46IWwVQyIy4YqJVQmvp+FoE/gDRhNv2cHK1hgLbo=
X-Gm-Gg: ASbGncuowS/L8q89ZPAENBUZ7p0g1CzkMkVNqKGRVZzYBUqHQX38b7vLvcsR25gR3DV
	QHC5pBGZCx1jIaoisVVARYhUfOqI93fZXnIvbokabm8JS5M1TvIAyYD8bbDwWQ3ZjFrIXXxghiN
	+1N+rfbkgPVKhvECFSEu+oDN7myBGhzzCU5VRsWpJ8SbigYWFuXPf+gFz01d0biJKc81BJIA23s
	EtupttzCakFHIdek+HzB3vaYs5m8Hj1mS7DRx3EqAyQ+lDjx7qzfp7coLVeE+TMAYFQC2CADQFR
	g7AqW7JvaTjsNzlFbwO+HSI47q33iQdKc24VGxeH+yF5ILQ4BYulEAoO4N9FRDMBhEkTHfJw8E5
	z03Asn/WNZhFpXx+YNOZmn4qus4TWrN40nNFBoeIL6t9F6HGkputIsG0BYwum7fpeyh2tJsgmVL
	6WwdrH0zg=
X-Google-Smtp-Source: AGHT+IHSgg7Vs/AmjdYxKvPGcURSAQYHV4ZPv29Nlxam3ApHMkecbSxOuVRV94M98KvI//bX8lmIYg==
X-Received: by 2002:a17:90b:17c2:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33b510ff5dfmr15768963a91.6.1760088675545;
        Fri, 10 Oct 2025 02:31:15 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:31:15 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: Fix potential double-free and add error logging
Date: Fri, 10 Oct 2025 17:30:21 +0800
Message-Id: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hi all,

Two patches fix pci sysfs/procfs issues:

1. Avoid a double-free in pci_remove_resource_files() by clearing
   pdev->res_attr[i] and pdev->res_attr_wc[i] to NULL after kfree().
2. To make PCI bring-up failures easier to diagnose, log the errno
   returned by pci_create_sysfs_dev_files() and pci_proc_attach_device()
   in pci_bus_add_device().

Thanks,
Jinhui

----
Jinhui Guo (2):
  PCI/sysfs: Fix potential double-free in pci_remove_resource_files()
  PCI: Print the error code when PCI sysfs or procfs creation fails

 drivers/pci/bus.c       | 9 +++++++--
 drivers/pci/pci-sysfs.c | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.20.1



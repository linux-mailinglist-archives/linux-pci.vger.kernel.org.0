Return-Path: <linux-pci+bounces-6255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D58A572B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33E11C2233D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EE7F7FD;
	Mon, 15 Apr 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD8xViws"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F31E535;
	Mon, 15 Apr 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197465; cv=none; b=DQW4IB8cc/vo0rhfTCCcsMdtPlT3ael7cLQT7vBu97Ijh3VlsJGrlDal6UkV9aPVHbskTD1+kzADQzX+NUbWd5sjLQhOZ+E+xjZ7CwCzME0A2cLyTq+u+8Cqq3vMzpIe4ZxcUHbs+FfJS6HYhthWW3atgGNCoFSkRp6IbcEiA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197465; c=relaxed/simple;
	bh=Y9phrcuVghze5A3r/VgBvO2dKSPDGgDW7lzbSbW+qbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ninF/TMSkgs7tSKljkOV66IGoV59cOktXCSZ4LS7aOEDtYsUiiQ0I+2baUobJHn2dvd3KIBcSuKAeBNvWn+h4E7Q642zsLUvFOWNxPnSuGPeDbUVRFpuYuplUyf2mtHpA9b+/mEgbzQpticVuBCkEEROA1bCMX0U7kJAtDnQSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD8xViws; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2686983b3a.0;
        Mon, 15 Apr 2024 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197463; x=1713802263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idKY/AXCx9ADdtSZX2SyJbtyHMfNUkXAqrrB1Te8B8I=;
        b=eD8xViwsM/O1KZpH3z7mI1bYXpVRuqc41iNzH6vp26bCpAkTwgNkcaqV5kP3q1tWZ6
         RZ/+ep5w/1saB+wT+IdRB3bWjY/RLXgz6K5T+Bj7+75V4eGV94x3Q1A9hMZU6wxi6wrQ
         V1mXWedp9iZWym6xN5rencJqMQn1CnWR0w/dII9RygzEB4jFumXbuPz7ZmG+0QMhmcx9
         AXJUoTxbChgWwdZL02m7kFpL8KeMvesi5plf87+ZT87QYHjnNeMpeBKU9+HT/buA22dN
         kiLjfZtbTacXc7ur+Y+pPPtHSJna/gVcd2oEoTC+q5P2AL6Rq920c+kvf2iocRsPS6pm
         Uyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197463; x=1713802263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idKY/AXCx9ADdtSZX2SyJbtyHMfNUkXAqrrB1Te8B8I=;
        b=FHF6uBARPiJSh2ia/zGc5hTyewCjBfM+o/XfaLJGNkjyTeOZH9sHeDBA/Dy32GUoU2
         7f/BGqDKeJdNhzF5kv3V2RZu4v1UwdsdvEoMMvu2mBB4GIGJn8NCG8Xi2EUaoKxUa00o
         spbiTHatElBpiCojvy1QKgpkx44fTF158SxFdRN8J/pKDBwrBfdkAKILIOTI95CzYkJF
         KTRfhAWMJ9KSAXeiUNSuzcXRsJ56ocHmlWKkoTU3ms8iaD9i362upUvtZasF0AS36mK9
         cXAGt9oealfXE/h7lW2MCapjVwnMSRCLhoYwiPRuiTn99RTIBqaqqV9UuMLdb66DttX2
         ogUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpyeyFsVX+5Q11mn4CEbTko/2c+H188d9+49Lqia9LL8XpzxBZq7XAqpGvyKL3LHEenCI4iNRPfiamtCQD8OZlkcACH22+FTjJw10NOCV+q97IaLsx/MZ43Ahu3kZ86+oztm6wD2HA
X-Gm-Message-State: AOJu0Ywy8reK5oqhpael1RyCRpvZOkvmmhmJ2+L14EoRsjS2m+IkSNFF
	MosdKzkuNJE+AzK8v0dsOmxqkjGcJV/+F2FuCrr20r8aX4dvrQsJoT/XEHiC
X-Google-Smtp-Source: AGHT+IHCW5enMeqSxfKAKz6Q3Kx5ErcaMW7349ZcFBrKfz5bX7YYXC6EAqUVqihnGGZwN6vufHHUqw==
X-Received: by 2002:a05:6a20:560d:b0:1a7:3095:b3b9 with SMTP id ir13-20020a056a20560d00b001a73095b3b9mr8753963pzc.22.1713197463496;
        Mon, 15 Apr 2024 09:11:03 -0700 (PDT)
Received: from dev0.. ([49.43.161.106])
        by smtp.gmail.com with ESMTPSA id 6-20020a056a00070600b006eab6f3d8a9sm7414200pfl.207.2024.04.15.09.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:11:03 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: mahesh@linux.ibm.com,
	oohall@gmail.com,
	bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] PCI/AER: Print error message as per the TODO
Date: Mon, 15 Apr 2024 16:10:55 +0000
Message-Id: <20240415161055.8316-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pr_err() to print the add device error in find_device_iter()

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..0e1ad2998116 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -885,7 +885,8 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 		/* List this device */
 		if (add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
-			/* TODO: Should print error message here? */
+			pr_err("find_device_iter: Cannot handle more devices.
+					Stopping iteration");
 			return 1;
 		}
 
-- 
2.34.1



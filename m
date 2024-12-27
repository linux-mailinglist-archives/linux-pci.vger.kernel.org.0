Return-Path: <linux-pci+bounces-19069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFD9FD0A8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 07:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD30163998
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596313594A;
	Fri, 27 Dec 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwV7I5TK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24171F5F6;
	Fri, 27 Dec 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735282385; cv=none; b=BHM8xDxcw4ERChUxqjmwCw9bMXmOPItfvjChhedZxHh7TM7bGJDSB/NQ7ap01UKVyVbEA535aD60cSihQjHbZRw4jW4rx1yPXUkf/tu8xk16Dnh+VmSPkMHmSZ/NykgcQXbdTUKiM5qyCnxIVQmixIDbONaMhSPTqnIS/6Vfom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735282385; c=relaxed/simple;
	bh=qLkIYpACpFNgqaeoFB4OT01rjeZzIb8ZNDemwy0nQaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kcogqtBhoU0imlcf/JtcLUh2mulAnZy4Dy7KcguDhdRVrMofwU/6194vIUO4CUrzHGGn37aPHDlB6rfadueANflidyojNOwnYHMnippnRb8mSZV+FdDMvlTNImde+36iqgIz15JAvEDI+tae7cv3k8ih48iEJ0vVeR8ATpIv7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwV7I5TK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21683192bf9so87367215ad.3;
        Thu, 26 Dec 2024 22:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735282383; x=1735887183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3gYkbbfi3lIdz0EUXPWD1ceNd1AYXhoB3nzoejKLA8=;
        b=UwV7I5TKBQLz7Z/g4zEXKDTsYefGjMQogZfWoi479Ij4+rtv+mECskz6HcKpRbbEW9
         RhvS8ct0+LTjB2I4wF+Ftra9f5+zj2bu80ByHOY8iD2dk9sEtC3Qcdlco4gvah9TbEHQ
         gZKRlIhZTtjQAckNoMV4iJ8b/1jWs0JGqisXbXSjpwzmZn5mJJhCuLaL+thS3dUsZEj/
         v2h22SQU15KC5yIHVta3LKDkzSCQx7ZK82nouFdyJTn2XkLzjPvPZ01rfGMlW3MrL5Kn
         Ca4dzTo8Nuwgx0bR1ink3wgn0WIjO8/h87bb7Y8Z6AAcIMFFnZGW6Qb1Qt+zV9ZkDuxx
         Kdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735282383; x=1735887183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3gYkbbfi3lIdz0EUXPWD1ceNd1AYXhoB3nzoejKLA8=;
        b=o8JzCg3fU3TIqsJV77/p0MQVO8uClkXoB5AAMvVzFubSVsAkOqGKHgmnL1b8+8sHdg
         3EO0E9ITVnOfw6TAfBsSqTV5wtOFgyY0VIxqmX1hNReJNa5YmgEDyX85A/tLR88LOT4g
         rIy3a9LNTM5PPT6oMbH9SFENh8sfHMSEAu0vvnpnzDvsvHaobVOftIHmAPGXgdBAqtrx
         XZipKZ6MV+DL+cJWfvjY/gp9MKU8Z9W3glrQTaTJXb8y/Wyl1rTjAlSH4lMcMSkK27rJ
         JMx2yUlw6mXR7ADxQdjRgV/X3Se7uhgPPcOyoASUBVIlDzjB+fS4C8ly/w8h/A24LD5E
         Efmw==
X-Forwarded-Encrypted: i=1; AJvYcCVmS30zpQks/NLgJqlAUqmcx9t18cNTywbCN5rt7b0kpWDPQCHUeDVfw5mAz8fupHq3Owf3qxWm/SAUS88=@vger.kernel.org, AJvYcCXBHixMJYMbDKnZkMeS2cFgv75VPx5bof2gWRdlMa+e8aT3IarffmBv3/Q5e/B+Kpq/sb1UCwu+KhqU@vger.kernel.org
X-Gm-Message-State: AOJu0YyNN3Hw8A4IWD+uonAJXDNNXsb1AfN+rR5I/nZri1tFIQ5EEeCU
	31k6eEiJDSwem+VD7XSdJsfKeiw/eWMlE11oOe019oGCqaPr0ugU
X-Gm-Gg: ASbGnct2jeVnmtZBJT56HjmYw0/i2Dt4nlxflQzmq5pm2oZzhNndndiPt6Ne4eZ8vj2
	zMHTP5W8ptMJrjpDhxfqA+M7AImIe02eX4NoFsp1Wxk0eyfzWbdsvFSkNEDAEgRObIDJUhrIPp4
	nhDrBOpJYFbKIzLjZ8JUw3JM3z6JOYiUuHWRqCn0nlLSASsf3zKC3npqbYRuN2nl1mwdDyONHPj
	jj8VNdNIusyCWkolP3EQguGQ068BXtO1bm1vNbh3csiBwohnw7zgOUPl9hAoVdt6oD2ORtNpg==
X-Google-Smtp-Source: AGHT+IFPGELX2PWQE4yHJKlKfSRfNyM1fiNC2n+BqoCOE0VCWCmRkUXWjJNZ0U1jChDx4VJSHa8HaA==
X-Received: by 2002:a05:6a21:6d88:b0:1e0:cc8c:acc4 with SMTP id adf61e73a8af0-1e5e081ca16mr43836085637.37.1735282383124;
        Thu, 26 Dec 2024 22:53:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:45c8:7d73:4193:45c:684e:d99c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81572dsm13981232b3a.14.2024.12.26.22.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 22:53:02 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: 
Cc: evepolonium@gmail.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ERR: use panic instead pci_info for device recovery failure in PCIe
Date: Fri, 27 Dec 2024 12:22:53 +0530
Message-Id: <20241227065253.72323-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update failed in drivers/pci/pcie/err.c to 
trigger a kernel panic instead of pci_info

Thanks

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 drivers/pci/pcie/err.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..2630b88564d8 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,8 +271,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
-	/* TODO: Should kernel panic here? */
-	pci_info(bridge, "device recovery failed\n");
+
+	panic("Kernel Panic: %s: Device recovery failed\n", pci_name(bridge));
 
 	return status;
 }
-- 
2.39.5



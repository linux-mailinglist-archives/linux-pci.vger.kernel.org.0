Return-Path: <linux-pci+bounces-3246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778C84E90E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F4284C34
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AA381BA;
	Thu,  8 Feb 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="GFP6N9Ux"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194B3714E;
	Thu,  8 Feb 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421276; cv=none; b=ajd1xuOjyI9FhACThrMYF+YW3SsyyKLa37xSXIl0MPZUR9R26rID97Y3OaIuzwhHqVn3l/8vnlK68tq1zyHmnllW36oSseyXZnZrqDuJPj8JHESAExMVMtm3rsUufiiR+SL4FIgsIpMEf0T265Kzci1rGi0eawmlTzkDIqbKV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421276; c=relaxed/simple;
	bh=3y1PWI7/4uJhKHORhChSyZZNPB/LBp4MB0BXiBQdq5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L1MoDRSxpEIg2ZAAu8z1iCdvHjhNP/rX+tNaOIU6x9FRFbVvjcdWPS9EXUE9PZHVEskj84GAntplGPxS45jcI2XWTsdP4PFAzedJDdugJuM3hCQgfTa0rgOtq2yeimOK2AeWGfVqAKUL0en9fxG1THrRC0YaZoTvYvIBnsNpK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=GFP6N9Ux; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d934c8f8f7so1397205ad.2;
        Thu, 08 Feb 2024 11:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421274; x=1708026074;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIx9ArKKryMKztnqbeYvUFTe3kDIAE1tSUPavqVDA5w=;
        b=QLm8g5WnkUR6X3KXVJ3ZScHWDp4cXwzI5t+L0vcsYdCmdBtUV9UF62tpETIkfFaswV
         P3dJAXhHnNSDm3di8sakLZBwrWPynikWM9OJ/DmMy4ZxJnWS9Nqn3JUN6ByiTMVKGTCA
         hZx+on5ZRKTxvvczyYU8ypqZMbm0TEE5Edq3NTxdQgul9EUATcaqwou8dMUor8InewGr
         j/Pja+TW6xdXlsExeyH05B2iZgac6HfdV8gYrKhLDKW6BMWrL/o/5J0YVX1O4ITL+Qff
         krjTAUL81Zu7KAJnXeIbACgEyQGugvuWyFHIt7NieTlOPVanliQMFhN9MSD9sq14Sdod
         z/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0VXsF/3jrlPgyhp7FyZN7275ZRFUvZSbm5zwUNt6fjrYDAZe0RbMIqbSEfYugEzhripDLms9LRpP7RXmdgGOFaa6x9HO1SLqGypb
X-Gm-Message-State: AOJu0Yy6wbnaH44O2+dbiuuuswD3zDL45i//r0Rx66RGp58w58EXaIn+
	wlZRz+8ncy+Fe5kJMCzAjJMAqDx7g04jj6gcAxRQs00L+DNWh1gArIoVJLycgMQsWQ==
X-Google-Smtp-Source: AGHT+IHlGs52uxIm9dMCVxI2hkRbYbSyzOTbugoCEBRMtHjje9wmdbd7qconNMHH9GMDQLx1nY0viA==
X-Received: by 2002:a17:903:60b:b0:1d9:83c0:a163 with SMTP id kg11-20020a170903060b00b001d983c0a163mr206189plb.7.1707421274000;
        Thu, 08 Feb 2024 11:41:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZwi/ZZ7Wi0EVREHM2L+K6J2GoCiJbO/8n2kxfL3yafhu1Gj5hYZx44hpJvdLqB/58v5ksyurWXRWhaAmGs9kfUktI+2IFEsZpmDfgZ+qNZy3iDnVJ6tiFzexWZFXFvx9YNsssB0vJaQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902e29200b001d8fb137a57sm134501plc.12.2024.02.08.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:41:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707421272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iIx9ArKKryMKztnqbeYvUFTe3kDIAE1tSUPavqVDA5w=;
	b=GFP6N9UxeXbMkGj8299Sjv3uJLe26Kkt23zKrb0YCgYq0ztYdxiw54T7EgjSlM2oI6Ps2E
	gFrIXvOaJXZyObE2vgKLDt+0oOb+tO/p+h3ZhnLhvVV+b6rD3jsWnyPRPdnh92QbdXkenV
	xVaF23Y/mpqMB+UCT0j9pMr7F6PX+gLeYGnRNaH7q+TVgw0jbOSROIEE3x4HHHcX4QWYly
	ljkT6PM1qgtDVLWGwMbGv4iQT8kDphETr6BARr7TeqFw2EC0lEdtgjHi5vQGnWSyzStQGU
	Q9U38BZEDV5ibqfZt2h/bFzaTwS0lFmB4ixO0b/MtCaYgs81yT6/7vv33hVKUw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:41:46 -0300
Subject: [PATCH] PCI: make pcie_port_bus_type const
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-pci2-v1-1-5e578210b6f2@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHkuxWUC/x3MQQqAIBBA0avErBNULLKrRITpWANhohSBdPek5
 Vv8XyBjIswwNgUS3pTpDBWibcDuJmzIyFWD5FJxyQe2XnmxB5pwRRYtSdYLj9oq3Tk+QM1iQk/
 Pv5zm9/0AB/zIyGIAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=3y1PWI7/4uJhKHORhChSyZZNPB/LBp4MB0BXiBQdq5I=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxS56neXjDv0TkkRaPI23tEDUToUd4ztNqAdrc
 ZBN6yA3ojCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUuegAKCRDJC4p8Y4ZY
 poGrD/9jyLlUi36f/6F2VPwJSKbYX5fYWnbC8US4QN8p7lDSpZq697JB0ArEnmQQZwWXYxefnQh
 6oXmS2iiL6FDxYmj9HOrG0oA0gOItpYEgirvaXXUEYZwvk/v4rl8fWeJnVG5KA9ZmvN5tmTc5nh
 +a7EN/DW1JEyW7fLJLVQLt64ycVKS0nscYjtkjYh70aYjwxybAhpr4lBX/iBb70YnlRs6aWFN1V
 niGtYfxKmPDjW1OXJ+2NTmMWhoCiCUgHgnIxOmgSNt/9cuI5DdKo14cGN1m2ARdJusWPlXf60Eg
 nfk426VnqOuUJtY4+1GfHCemAeisL+RGXXl/IGv85o0Ix0beRKQ5D9UVYCYdAe9NS3CxpcEL0ci
 +IhbZ0awbE0CZ6hLzLUJh7XOesE23V1zbRUxaoIPxOAh1b3qksrY9fcD28kJcSqOW6B0RZM0TVO
 P9UX5ZvbNlhfLO26jgE3Jw8q4XMx9wYAyGVlU4YBF1QC2CdIttNgteWI/bjoz/574/yOYGSV9No
 WVYp4noCPEg0bU9OcG0CUI6uYEYM1aUgjUqZ5gKaYZgVKKwkGOlCzLx9r3TS6Bjvt1b07csFZZa
 ewa5YmU2YszLptMJDPaC85rQ5nze4WJTm8446iZe7XxIrtKSru6DXbnIqd6CLwaisEaV2maOT13
 UYmml/rrqEYNbjQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pcie_port_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/pci/pci-driver.c   | 2 +-
 drivers/pci/pcie/portdrv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ec838f2e892e..a29098e24683 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1705,7 +1705,7 @@ static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-struct bus_type pcie_port_bus_type = {
+const struct bus_type pcie_port_bus_type = {
 	.name		= "pci_express",
 	.match		= pcie_port_bus_match,
 };
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1f3803bde7ee..12c89ea0313b 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -96,7 +96,7 @@ struct pcie_port_service_driver {
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
-extern struct bus_type pcie_port_bus_type;
+extern const struct bus_type pcie_port_bus_type;
 
 struct pci_dev;
 

---
base-commit: cc24b2d080dca2ce1c89a8a71c00bdf21155f357
change-id: 20240208-bus_cleanup-pci2-61fe9c495d08

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



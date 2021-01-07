Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926862EE7E5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbhAGVuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbhAGVt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 16:49:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44BC0612FE
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 13:49:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 91so7059396wrj.7
        for <linux-pci@vger.kernel.org>; Thu, 07 Jan 2021 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pZeje/PUxLvKWHDuvRG3CspT3/IsV7CmHT7w22O+i3E=;
        b=QdBtr7D9QWTbpf92cVsI7+jvCAwKheE5eLV/fnYi4dnGfx62q7v502nlZrpLa8wGOO
         8OQjSekKtPcem09rqF16CfvwDd9wVVya1UKWsgJX0KdsnnocW8bZdLsnKDDSC+gnK5vo
         Tu+LWn8yJbNW+y+1m1T++zH9dohYZnlomQDfDZFeguPJR2YCXnFPp3rGiIXCM0Q45JHk
         gytQsyVkrxOPUWi6zCfSSp1efYaUIB33UTFLDecDkIrTaTS9gs1i2bTo5pCGrybZ/wMS
         suUbt5Wjo7Zoe6MejoW1KKEk53lvGa577Ov5fIrJoHu7VPCNQf8RRkCgeXgnPHvJ3lgA
         OsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZeje/PUxLvKWHDuvRG3CspT3/IsV7CmHT7w22O+i3E=;
        b=NLc0OUgn9IoDULWZanQFsY0FGYpBzmVWzDtduLUqCIfUmhuIq61UL7Dx6g2B/bminq
         XFd6GOO9QE2aRwpFaGMJkDeuv0wJYF4fCh/0NSC36KEYCZZkpOkz2fgMEzCqX+WqnRVu
         tvbXc06nwrIWdDnldn/GDFhmDbjyLhbQUTlm2bgvRmki4KPxEJgheDGuTnbn/C8VYuld
         YxLSl7BN5r5ojDwe0UBXSmMQWU2JRoyaL6Jm0EBldz7dKPH6JiHFopSDN53/TCVdjZA9
         oxfHnDVVaIxgIsq+cM07U+34htYAJnV37QgVpwR49S3I0lg9b8ZE85K41XL/02uteO+1
         6Vfg==
X-Gm-Message-State: AOAM530+q6QEdveYmmMlrcFt8b/vEZ6A7dSaQ//5GauMqlT5Ew01oSlq
        EV2V8uXhdE0BOxRDGWo+BeU3EwThPF0=
X-Google-Smtp-Source: ABdhPJwyVPTwB0PyjfEvjaUhbMu7xJ08pcslMLEm4ejc/IMEd1Huiu+IZIBElnxRjM+huLWmI/wO3Q==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr551406wrs.317.1610056139749;
        Thu, 07 Jan 2021 13:48:59 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:bc23:c288:f1cf:8157? (p200300ea8f065500bc23c288f1cf8157.dip0.t-ipconnect.de. [2003:ea:8f06:5500:bc23:c288:f1cf:8157])
        by smtp.googlemail.com with ESMTPSA id h20sm10672736wrb.21.2021.01.07.13.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:48:59 -0800 (PST)
Subject: [PATCH 1/2] PCI/VPD: Remove dead code from sysfs access functions
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dba8e8ad-5243-ee84-38bd-f2b131f4b86f@gmail.com>
Message-ID: <e78f346f-6196-157f-6b74-76e49c708ee0@gmail.com>
Date:   Thu, 7 Jan 2021 22:48:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <dba8e8ad-5243-ee84-38bd-f2b131f4b86f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
attribute size is set to 0 (unlimited). So let's remove this now
dead code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7915d10f9..a3fd09105 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -403,13 +403,6 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
 	return pci_read_vpd(dev, off, count, buf);
 }
 
@@ -419,13 +412,6 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
 	return pci_write_vpd(dev, off, count, buf);
 }
 
-- 
2.30.0



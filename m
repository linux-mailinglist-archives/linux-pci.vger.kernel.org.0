Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C634987B4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 01:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfHUXP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 19:15:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37110 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfHUXP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 19:15:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id w30so2653524pfj.4
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2019 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uPz28r4pp6bS4pf4oimcoF6Q5mHSemPcex9edLQ7rcQ=;
        b=dorlkDOYvSJeySUiRXM6PkXCXwTRDM7mnmbA+VYnhUwpZlhThUp0gCiSA2/wi9oP1A
         1pJu0BG97YuMJRyHe0mbD7PDMKHHzscOW1r/bnaaY8E/qRtH7+oqB5RjSUqU/5IGrthl
         DPLmYqj20Zh2hl/Zf3G4IeX6sgtJHfYF9nrl73lHQF/k5of0ywoo5aYgyDQYA06z+BPq
         oaVZZGVWEqHys50Zjxg+0QWa8m6i0wW76+7EZe3NSGnew/cdto6FTPRMQ+pB0pRJ/Dgr
         etaMaPgUtAxwyXRn215N/O8HI151kv49Sr38mDz5ZU9ElQEpOAO0f4Spc48M35u8pfpz
         Rq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uPz28r4pp6bS4pf4oimcoF6Q5mHSemPcex9edLQ7rcQ=;
        b=mNUQMUJXritnQ+vxxTH396AQBEuFTR9I6gfK7W4UWf19h/zC806g3xaWYfWPVAKbuS
         bR/06mGpyOYouwYU6+vRKrZqiFvjxWV8ohAtG3lO+WWiNavaH6PxgDXOwtTNpvfdK7Nn
         In1B+l1G4tqUMqZKAioSsuDD8GeU3KlhV1lRgrtl1WAsOXYdDWDE1XqQSQIdswr+hhzC
         nJIQjLpPbgdiEHu7T0lTk2kEfYhpbzryLUBXaHUIQ19Ufqlfu/ohcKuGZaBi3ceF+E6L
         HgFAiZtlviOAzNPikBGPE1dz2B2W6wkI2EEzZAOcf5piYayqgB8HGoZd9TnfCTyjXeGZ
         S+6w==
X-Gm-Message-State: APjAAAXUYa6eYpqDzgJIfUUQTFq+r7gGIRzoE7yFSknOcq/pvxxBtRWd
        hRYfKM1aVh/iLaO0rtacK/Kn91o4qe2d
X-Google-Smtp-Source: APXvYqyVaCgjWGyolNEhMURfAYyYlFKy2b2EOlRXDUI9OZMSZqpLW9+nyfqREU+EhTJWpdPd7DWps/cw6DM8
X-Received: by 2002:a63:2a41:: with SMTP id q62mr25091848pgq.444.1566429325943;
 Wed, 21 Aug 2019 16:15:25 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:15:13 -0700
In-Reply-To: <20190821231513.36454-1-rajatja@google.com>
Message-Id: <20190821231513.36454-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190821231513.36454-1-rajatja@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 2/2] PCI/AER: Split the AER stats into multiple sysfs attributes
From:   Rajat Jain <rajatja@google.com>
To:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the AER stats into multiple sysfs atributes. Note that
this changes the ABI of the AER stats, but hopefully, there
aren't active users that need to change. This is how the AERs
are being exposed now:

localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats # ls -l
total 0
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit0_RxErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit12_Timeout
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit13_NonFatalErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit14_CorrIntErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit15_HeaderOF
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit6_BadTLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit7_BadDLLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit8_Rollover
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit0_Undefined
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit12_TLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit13_FCP
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit14_CmpltTO
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit15_CmpltAbrt
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit16_UnxCmplt
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit17_RxOF
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit18_MalfTLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit19_ECRC
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit20_UnsupReq
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit21_ACSViol
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit22_UncorrIntErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit23_BlockedTLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit24_AtomicOpBlocked
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit25_TLPBlockedErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit26_PoisonTLPBlocked
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit4_DLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit5_SDES
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit0_Undefined
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit12_TLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit13_FCP
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit14_CmpltTO
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit15_CmpltAbrt
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit16_UnxCmplt
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit17_RxOF
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit18_MalfTLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit19_ECRC
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit20_UnsupReq
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit21_ACSViol
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit22_UncorrIntErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit23_BlockedTLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit24_AtomicOpBlocked
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit25_TLPBlockedErr
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit26_PoisonTLPBlocked
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit4_DLP
-r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit5_SDES
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_cor
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_fatal
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_nonfatal
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_cor
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_fatal
-r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_nonfatal
localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats #

Each file is has a single counter value. Single file containing all
stats was frowned upon and discussed here:
https://lkml.org/lkml/2019/6/28/220

Signed-off-by: Rajat Jain <rajatja@google.com>
---
I personally think that this makes it a little overwhelming for a human,
e.g. I could look at total but don't exactly know while file to look at
next in order to drill down. But I couldn't think of any other way. Some
problems I'd have liked to fix but they require deeper surgery:

* Now each PCI device sysfs node will have a sub-directory called aer_stats.
  (The subdirectory will have attributes only if it supports AER, but
   the sub directory will always be present). 

* This patch isn't re-using the strings array like it was using earlier.
  I thought of adding the attribute group at run time, so it will take
  care of both the problems, but can only do that after device_add() call,
  I think.

If we are comfortable introducing a call to a new function
pci_aer_stats_init() after call to device_add() in in pci_device_add(),
the above problems can be fixed.

 drivers/pci/pcie/aer.c | 166 +++++++++++++++++++++++++++++------------
 1 file changed, 119 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 68060a290291..11f3158cfdf5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -570,42 +570,66 @@ static const char *aer_agent_string[] = {
 	"Transmitter ID"
 };
 
-#define aer_stats_dev_attr(name, stats_array, strings_array,		\
-			   total_string, total_field)			\
+#define aer_stats_dev_attr(type, bitnum, stats_array, name)		\
 	static ssize_t							\
-	name##_show(struct device *dev, struct device_attribute *attr,	\
-		     char *buf)						\
+	type##_bit##bitnum##_##name##_show(struct device *dev,		\
+				      struct device_attribute *attr,	\
+				      char *buf)			\
 {									\
-	unsigned int i;							\
-	char *str = buf;						\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	u64 *stats = pdev->aer_stats->stats_array;			\
-									\
-	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
-		if (strings_array[i])					\
-			str += sprintf(str, "%s %llu\n",		\
-				       strings_array[i], stats[i]);	\
-		else if (stats[i])					\
-			str += sprintf(str, #stats_array "_bit[%d] %llu\n",\
-				       i, stats[i]);			\
-	}								\
-	str += sprintf(str, "TOTAL_%s %llu\n", total_string,		\
-		       pdev->aer_stats->total_field);			\
-	return str-buf;							\
+	return sprintf(buf, "%llu\n",					\
+		       pdev->aer_stats->stats_array[bitnum]);		\
 }									\
-static DEVICE_ATTR_RO(name)
-
-aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
-		   aer_correctable_error_string, "ERR_COR",
-		   dev_total_cor_errs);
-aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
-		   aer_uncorrectable_error_string, "ERR_FATAL",
-		   dev_total_fatal_errs);
-aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
-		   aer_uncorrectable_error_string, "ERR_NONFATAL",
-		   dev_total_nonfatal_errs);
-
-#define aer_stats_rootport_attr(name, field)				\
+static DEVICE_ATTR_RO(type##_bit##bitnum##_##name)
+
+aer_stats_dev_attr(correctable, 0, dev_cor_errs, RxErr);
+aer_stats_dev_attr(correctable, 6, dev_cor_errs, BadTLP);
+aer_stats_dev_attr(correctable, 7, dev_cor_errs, BadDLLP);
+aer_stats_dev_attr(correctable, 8, dev_cor_errs, Rollover);
+aer_stats_dev_attr(correctable, 12, dev_cor_errs, Timeout);
+aer_stats_dev_attr(correctable, 13, dev_cor_errs, NonFatalErr);
+aer_stats_dev_attr(correctable, 14, dev_cor_errs, CorrIntErr);
+aer_stats_dev_attr(correctable, 15, dev_cor_errs, HeaderOF);
+
+aer_stats_dev_attr(fatal, 0, dev_fatal_errs, Undefined);
+aer_stats_dev_attr(fatal, 4, dev_fatal_errs, DLP);
+aer_stats_dev_attr(fatal, 5, dev_fatal_errs, SDES);
+aer_stats_dev_attr(fatal, 12, dev_fatal_errs, TLP);
+aer_stats_dev_attr(fatal, 13, dev_fatal_errs, FCP);
+aer_stats_dev_attr(fatal, 14, dev_fatal_errs, CmpltTO);
+aer_stats_dev_attr(fatal, 15, dev_fatal_errs, CmpltAbrt);
+aer_stats_dev_attr(fatal, 16, dev_fatal_errs, UnxCmplt);
+aer_stats_dev_attr(fatal, 17, dev_fatal_errs, RxOF);
+aer_stats_dev_attr(fatal, 18, dev_fatal_errs, MalfTLP);
+aer_stats_dev_attr(fatal, 19, dev_fatal_errs, ECRC);
+aer_stats_dev_attr(fatal, 20, dev_fatal_errs, UnsupReq);
+aer_stats_dev_attr(fatal, 21, dev_fatal_errs, ACSViol);
+aer_stats_dev_attr(fatal, 22, dev_fatal_errs, UncorrIntErr);
+aer_stats_dev_attr(fatal, 23, dev_fatal_errs, BlockedTLP);
+aer_stats_dev_attr(fatal, 24, dev_fatal_errs, AtomicOpBlocked);
+aer_stats_dev_attr(fatal, 25, dev_fatal_errs, TLPBlockedErr);
+aer_stats_dev_attr(fatal, 26, dev_fatal_errs, PoisonTLPBlocked);
+
+aer_stats_dev_attr(nonfatal, 0, dev_nonfatal_errs, Undefined);
+aer_stats_dev_attr(nonfatal, 4, dev_nonfatal_errs, DLP);
+aer_stats_dev_attr(nonfatal, 5, dev_nonfatal_errs, SDES);
+aer_stats_dev_attr(nonfatal, 12, dev_nonfatal_errs, TLP);
+aer_stats_dev_attr(nonfatal, 13, dev_nonfatal_errs, FCP);
+aer_stats_dev_attr(nonfatal, 14, dev_nonfatal_errs, CmpltTO);
+aer_stats_dev_attr(nonfatal, 15, dev_nonfatal_errs, CmpltAbrt);
+aer_stats_dev_attr(nonfatal, 16, dev_nonfatal_errs, UnxCmplt);
+aer_stats_dev_attr(nonfatal, 17, dev_nonfatal_errs, RxOF);
+aer_stats_dev_attr(nonfatal, 18, dev_nonfatal_errs, MalfTLP);
+aer_stats_dev_attr(nonfatal, 19, dev_nonfatal_errs, ECRC);
+aer_stats_dev_attr(nonfatal, 20, dev_nonfatal_errs, UnsupReq);
+aer_stats_dev_attr(nonfatal, 21, dev_nonfatal_errs, ACSViol);
+aer_stats_dev_attr(nonfatal, 22, dev_nonfatal_errs, UncorrIntErr);
+aer_stats_dev_attr(nonfatal, 23, dev_nonfatal_errs, BlockedTLP);
+aer_stats_dev_attr(nonfatal, 24, dev_nonfatal_errs, AtomicOpBlocked);
+aer_stats_dev_attr(nonfatal, 25, dev_nonfatal_errs, TLPBlockedErr);
+aer_stats_dev_attr(nonfatal, 26, dev_nonfatal_errs, PoisonTLPBlocked);
+
+#define aer_stats_total_attr(name, field)				\
 	static ssize_t							\
 	name##_show(struct device *dev, struct device_attribute *attr,	\
 		     char *buf)						\
@@ -615,20 +639,67 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 }									\
 static DEVICE_ATTR_RO(name)
 
-aer_stats_rootport_attr(aer_rootport_total_err_cor,
-			 rootport_total_cor_errs);
-aer_stats_rootport_attr(aer_rootport_total_err_fatal,
-			 rootport_total_fatal_errs);
-aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
-			 rootport_total_nonfatal_errs);
+aer_stats_total_attr(total_device_err_cor, dev_total_cor_errs);
+aer_stats_total_attr(total_device_err_fatal, dev_total_fatal_errs);
+aer_stats_total_attr(total_device_err_nonfatal, dev_total_nonfatal_errs);
+aer_stats_total_attr(total_rootport_err_cor, rootport_total_cor_errs);
+aer_stats_total_attr(total_rootport_err_fatal, rootport_total_fatal_errs);
+aer_stats_total_attr(total_rootport_err_nonfatal, rootport_total_nonfatal_errs);
 
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
-	&dev_attr_aer_dev_correctable.attr,
-	&dev_attr_aer_dev_fatal.attr,
-	&dev_attr_aer_dev_nonfatal.attr,
-	&dev_attr_aer_rootport_total_err_cor.attr,
-	&dev_attr_aer_rootport_total_err_fatal.attr,
-	&dev_attr_aer_rootport_total_err_nonfatal.attr,
+	&dev_attr_correctable_bit0_RxErr.attr,
+	&dev_attr_correctable_bit6_BadTLP.attr,
+	&dev_attr_correctable_bit7_BadDLLP.attr,
+	&dev_attr_correctable_bit8_Rollover.attr,
+	&dev_attr_correctable_bit12_Timeout.attr,
+	&dev_attr_correctable_bit13_NonFatalErr.attr,
+	&dev_attr_correctable_bit14_CorrIntErr.attr,
+	&dev_attr_correctable_bit15_HeaderOF.attr,
+
+	&dev_attr_fatal_bit0_Undefined.attr,
+	&dev_attr_fatal_bit4_DLP.attr,
+	&dev_attr_fatal_bit5_SDES.attr,
+	&dev_attr_fatal_bit12_TLP.attr,
+	&dev_attr_fatal_bit13_FCP.attr,
+	&dev_attr_fatal_bit14_CmpltTO.attr,
+	&dev_attr_fatal_bit15_CmpltAbrt.attr,
+	&dev_attr_fatal_bit16_UnxCmplt.attr,
+	&dev_attr_fatal_bit17_RxOF.attr,
+	&dev_attr_fatal_bit18_MalfTLP.attr,
+	&dev_attr_fatal_bit19_ECRC.attr,
+	&dev_attr_fatal_bit20_UnsupReq.attr,
+	&dev_attr_fatal_bit21_ACSViol.attr,
+	&dev_attr_fatal_bit22_UncorrIntErr.attr,
+	&dev_attr_fatal_bit23_BlockedTLP.attr,
+	&dev_attr_fatal_bit24_AtomicOpBlocked.attr,
+	&dev_attr_fatal_bit25_TLPBlockedErr.attr,
+	&dev_attr_fatal_bit26_PoisonTLPBlocked.attr,
+
+	&dev_attr_nonfatal_bit0_Undefined.attr,
+	&dev_attr_nonfatal_bit4_DLP.attr,
+	&dev_attr_nonfatal_bit5_SDES.attr,
+	&dev_attr_nonfatal_bit12_TLP.attr,
+	&dev_attr_nonfatal_bit13_FCP.attr,
+	&dev_attr_nonfatal_bit14_CmpltTO.attr,
+	&dev_attr_nonfatal_bit15_CmpltAbrt.attr,
+	&dev_attr_nonfatal_bit16_UnxCmplt.attr,
+	&dev_attr_nonfatal_bit17_RxOF.attr,
+	&dev_attr_nonfatal_bit18_MalfTLP.attr,
+	&dev_attr_nonfatal_bit19_ECRC.attr,
+	&dev_attr_nonfatal_bit20_UnsupReq.attr,
+	&dev_attr_nonfatal_bit21_ACSViol.attr,
+	&dev_attr_nonfatal_bit22_UncorrIntErr.attr,
+	&dev_attr_nonfatal_bit23_BlockedTLP.attr,
+	&dev_attr_nonfatal_bit24_AtomicOpBlocked.attr,
+	&dev_attr_nonfatal_bit25_TLPBlockedErr.attr,
+	&dev_attr_nonfatal_bit26_PoisonTLPBlocked.attr,
+
+	&dev_attr_total_device_err_cor.attr,
+	&dev_attr_total_device_err_fatal.attr,
+	&dev_attr_total_device_err_nonfatal.attr,
+	&dev_attr_total_rootport_err_cor.attr,
+	&dev_attr_total_rootport_err_fatal.attr,
+	&dev_attr_total_rootport_err_nonfatal.attr,
 	NULL
 };
 
@@ -641,9 +712,9 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if (!pdev->aer_stats)
 		return 0;
 
-	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
-	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
-	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
+	if ((a == &dev_attr_total_rootport_err_cor.attr ||
+	     a == &dev_attr_total_rootport_err_fatal.attr ||
+	     a == &dev_attr_total_rootport_err_nonfatal.attr) &&
 	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
 		return 0;
 
@@ -651,6 +722,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 }
 
 const struct attribute_group aer_stats_attr_group = {
+	.name = "aer_stats",
 	.attrs  = aer_stats_attrs,
 	.is_visible = aer_stats_attrs_are_visible,
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog


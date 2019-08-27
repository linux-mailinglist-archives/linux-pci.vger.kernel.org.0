Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057A89F5FC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH0WVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:21:55 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39737 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfH0WVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 18:21:55 -0400
Received: by mail-qt1-f202.google.com with SMTP id z15so430085qtq.6
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dy2cqqRTN75UwexSmSLL2MSUZyijce6xFlaErsYGQaA=;
        b=IBvhZLtG9RR6V8EDp/2cjQsBsFEhYNMl25Z2wYbXIdadSOMMyqzkhZwZJGSWTqYaA/
         MulpnWVpbKqK5xaKMRyMkXENhSTxoN+0Yup7uOmSjQfy1pHmZ6Ii82jFIBU0jvygzp34
         mXKSBMPxDXfke3QLsBE2Hwi3l5bik10R3RVawCJupz8egOudQ+Trs7kpK0dKIOSHRs/U
         WCOtpNL9rImZBM2QN9IYooUBEvN0ky8qpQcMex38vjHEGyZKpc9lIS4MQsH02uLg6LpA
         nXxDxmXnkvGLA72qy1Dp4wH/KI/C2qgB+/gXtFH3JR41XTQAtayPhfNy9+OfL+PT07f3
         ysAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dy2cqqRTN75UwexSmSLL2MSUZyijce6xFlaErsYGQaA=;
        b=lqaxLazoG6Hi40euDRnuKproVNsLhJLm5cUGc5NG8UxtTohCxcQls92T97tOyDUMFY
         vm3Ls5aN6tAxDDf/DFfBP/83QFOmvG957+qljhgG0e7kEGwGrCpIQtGifvPYhAXiIceB
         t5UJrtRoFT6fuz23C3bBAzg2R8KG71RrHBncRl9bUoT0Cv/WPbEJWSvA2lt843564WAP
         NVeK5fVw68x3wWIYdU6xrANrt++UMNijLB9w1QiqsD6hrMsMHdKIbIpQEO4+zKZ94ryx
         mut/Tt6UZJ6jQpwwkq1GPaFfWMki3RRpfMptGZZ0zT51qLjE4CQSWF9qL86O5D9hqGDn
         xs3A==
X-Gm-Message-State: APjAAAXwbrq4y8iIT2AEmrDSSXMGonoRl0QOXNzC2wVpPSzg07BeV0Nm
        GHzoRGFF60rYoLzDtIY6M8XM1xaLJwBy
X-Google-Smtp-Source: APXvYqzenGcgjP3f5COIVKnaQxF7ojQUfF9q4UawhcXIZOtqiUE2SAxDuJTbwGunjhOYBlsMzhX+Nl3BSNmy
X-Received: by 2002:a37:a0b:: with SMTP id 11mr888111qkk.257.1566944513386;
 Tue, 27 Aug 2019 15:21:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:21:45 -0700
In-Reply-To: <20190827222145.32642-1-rajatja@google.com>
Message-Id: <20190827222145.32642-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190827062309.GA30987@kroah.com> <20190827222145.32642-1-rajatja@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 2/2] PCI/AER: Split the AER stats into multiple sysfs attributes
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
v3: indent the sysfs attribute names in documentation.
v2: Also change the Documentation

 .../testing/sysfs-bus-pci-devices-aer_stats   | 160 ++++++++---------
 drivers/pci/pcie/aer.c                        | 166 +++++++++++++-----
 2 files changed, 191 insertions(+), 135 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 3c9a8c4a25eb..8cd93acddf76 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -9,89 +9,72 @@ errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
 saw any problems).
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
-Date:		July 2018
-KernelVersion: 4.19.0
+What: Following files in /sys/bus/pci/devices/<dev>/aer_stats/
+	correctable_bit0_RxErr
+	correctable_bit12_Timeout
+	correctable_bit13_NonFatalErr
+	correctable_bit14_CorrIntErr
+	correctable_bit15_HeaderOF
+	correctable_bit6_BadTLP
+	correctable_bit7_BadDLLP
+	correctable_bit8_Rollover
+	fatal_bit0_Undefined
+	fatal_bit12_TLP
+	fatal_bit13_FCP
+	fatal_bit14_CmpltTO
+	fatal_bit15_CmpltAbrt
+	fatal_bit16_UnxCmplt
+	fatal_bit17_RxOF
+	fatal_bit18_MalfTLP
+	fatal_bit19_ECRC
+	fatal_bit20_UnsupReq
+	fatal_bit21_ACSViol
+	fatal_bit22_UncorrIntErr
+	fatal_bit23_BlockedTLP
+	fatal_bit24_AtomicOpBlocked
+	fatal_bit25_TLPBlockedErr
+	fatal_bit26_PoisonTLPBlocked
+	fatal_bit4_DLP
+	fatal_bit5_SDES
+	nonfatal_bit0_Undefined
+	nonfatal_bit12_TLP
+	nonfatal_bit13_FCP
+	nonfatal_bit14_CmpltTO
+	nonfatal_bit15_CmpltAbrt
+	nonfatal_bit16_UnxCmplt
+	nonfatal_bit17_RxOF
+	nonfatal_bit18_MalfTLP
+	nonfatal_bit19_ECRC
+	nonfatal_bit20_UnsupReq
+	nonfatal_bit21_ACSViol
+	nonfatal_bit22_UncorrIntErr
+	nonfatal_bit23_BlockedTLP
+	nonfatal_bit24_AtomicOpBlocked
+	nonfatal_bit25_TLPBlockedErr
+	nonfatal_bit26_PoisonTLPBlocked
+	nonfatal_bit4_DLP
+	nonfatal_bit5_SDES
+Date:		Aug 2019
+KernelVersion:  5.3.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-Description:	List of correctable errors seen and reported by this
-		PCI device using ERR_COR. Note that since multiple errors may
-		be reported using a single ERR_COR message, thus
-		TOTAL_ERR_COR at the end of the file may not match the actual
-		total of all the errors in the file. Sample output:
--------------------------------------------------------------------------
-localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
-Receiver Error 2
-Bad TLP 0
-Bad DLLP 0
-RELAY_NUM Rollover 0
-Replay Timer Timeout 0
-Advisory Non-Fatal 0
-Corrected Internal Error 0
-Header Log Overflow 0
-TOTAL_ERR_COR 2
--------------------------------------------------------------------------
+Description:	Error Statistic or counters for correctable/fatal/nonfatal
+		errors seen and	reported by this PCI device using ERR_COR,
+		ERR_FATAL, ERR_NONFATAL respectively. Each file is named
+		<errortype>_<bit number in status register>_<decoded name>
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
-Date:		July 2018
-KernelVersion: 4.19.0
-Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-Description:	List of uncorrectable fatal errors seen and reported by this
-		PCI device using ERR_FATAL. Note that since multiple errors may
-		be reported using a single ERR_FATAL message, thus
-		TOTAL_ERR_FATAL at the end of the file may not match the actual
-		total of all the errors in the file. Sample output:
--------------------------------------------------------------------------
-localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
-Undefined 0
-Data Link Protocol 0
-Surprise Down Error 0
-Poisoned TLP 0
-Flow Control Protocol 0
-Completion Timeout 0
-Completer Abort 0
-Unexpected Completion 0
-Receiver Overflow 0
-Malformed TLP 0
-ECRC 0
-Unsupported Request 0
-ACS Violation 0
-Uncorrectable Internal Error 0
-MC Blocked TLP 0
-AtomicOp Egress Blocked 0
-TLP Prefix Blocked Error 0
-TOTAL_ERR_FATAL 0
--------------------------------------------------------------------------
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
-Date:		July 2018
-KernelVersion: 4.19.0
+What: Following files in /sys/bus/pci/devices/<dev>/aer_stats/
+	total_device_err_cor
+	total_device_err_fatal
+	total_device_err_nonfatal
+Date:		Aug 2019
+KernelVersion:  5.3.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-Description:	List of uncorrectable nonfatal errors seen and reported by this
-		PCI device using ERR_NONFATAL. Note that since multiple errors
-		may be reported using a single ERR_FATAL message, thus
-		TOTAL_ERR_NONFATAL at the end of the file may not match the
-		actual total of all the errors in the file. Sample output:
--------------------------------------------------------------------------
-localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
-Undefined 0
-Data Link Protocol 0
-Surprise Down Error 0
-Poisoned TLP 0
-Flow Control Protocol 0
-Completion Timeout 0
-Completer Abort 0
-Unexpected Completion 0
-Receiver Overflow 0
-Malformed TLP 0
-ECRC 0
-Unsupported Request 0
-ACS Violation 0
-Uncorrectable Internal Error 0
-MC Blocked TLP 0
-AtomicOp Egress Blocked 0
-TLP Prefix Blocked Error 0
-TOTAL_ERR_NONFATAL 0
--------------------------------------------------------------------------
+Description:	Total ERR_COR / ERR_FATAL / ERR_NONFATAL messages sent by this
+		device. Since an ERR_* message may consolidate multiple error
+		bits, thus the sum total of all individual error bit counters
+		(sysfs files defined above) may not match the value in this
+		file. 
 
 ============================
 PCIe Rootport AER statistics
@@ -103,20 +86,21 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
-Date:		July 2018
-KernelVersion: 4.19.0
+What:		/sys/bus/pci/devices/<dev>/aer_stats/total_rootport_err_cor
+Date:		Aug 2019
+KernelVersion:  5.3.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
-Date:		July 2018
-KernelVersion: 4.19.0
+What:		/sys/bus/pci/devices/<dev>/aer_stats/total_rootport_err_fatal
+Date:		Aug 2019
+KernelVersion:  5.3.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
-Date:		July 2018
-KernelVersion: 4.19.0
+What:		/sys/bus/pci/devices/<dev>/aer_stats/total_rootport_err_nonfatal
+Date:		Aug 2019
+KernelVersion:  5.3.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
+
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
2.23.0.187.g17f5b7556c-goog


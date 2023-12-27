Return-Path: <linux-pci+bounces-1430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320D81EDE7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880081C222A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347B41095A;
	Wed, 27 Dec 2023 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="VTcXYydI";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wLFHtH0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F87286B5
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com AC3C1C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670385; bh=6SEouK9QkJobnpLhSQ6RU21HAzZB984JfrkiMala3A4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VTcXYydIYVltk8gLGny0sYeAdIRSni3h+YNxEpzur4oMBMS9UAPJLgWWs0vCxb12g
	 BuX4PssUusUvBjwuRTMr4Pn4HqLC8fMZ1uaIJgEHtrS9SjnXfKxJE8D0qjDsxsxrO7
	 NlfQn86dg/X5eqV+cu/Wo9ja068yIfMswgQ+PeFOFzpr7Qj1wvDn6F7dFovaYvfz2n
	 WtwGMn4ZzBrjiQDSROixVO8vUltL1NBaRAEPc3+VBeDye0TA3dw3ehslUDIBijYvuH
	 U6Vyl9X1FqkR5Jn2i+1ZGbGTbd3UiQnRA960GbLDwDy3gIMga2+dE/cArsm046qwRT
	 UA2om72+wc+dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670385; bh=6SEouK9QkJobnpLhSQ6RU21HAzZB984JfrkiMala3A4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=wLFHtH0YdwyuV1HGjagJfOOixHRxNvpxwAjo+JOX/tUYjrZN7TTY4B7rTAsZIPNRG
	 CFukz4qaDOHfc19JaGk7EJ6LgwSCNaJNyfY9BeRV4lFNt2rwNcLdd+jFmkqNol7Hgx
	 5SkJy0RpK1sP8Ufb0nvEN8UqTkqCuX02pYU7ClrBBkrtmIqcKPzAZ7QU7kNgChu/7O
	 IFbmb/E5oFharHJGdYcqNqFVK9o/7ErA4KVA00zSrQBf9X6AZoO+Bp5Hgt/0OBUoI1
	 KlalAgybbzSfl4aGwxeb7GgpvyIdYcQiSmypcyO5ZtYwxCN4JZUGZMqgBKU0zDUi30
	 XNZqJMvrdGjMQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 15/15] pciutils-pcilmr: Add pcilmr man page
Date: Wed, 27 Dec 2023 14:45:04 +0500
Message-ID: <20231227094504.32257-16-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile   |   2 +-
 pcilmr.c   |   3 +-
 pcilmr.man | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 pcilmr.man

diff --git a/Makefile b/Makefile
index ee8e8ee..cb002cb 100644
--- a/Makefile
+++ b/Makefile
@@ -71,7 +71,7 @@ LMRINC=lmr/lmr.h
 
 export
 
-all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) pcilmr
+all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) pcilmr pcilmr.8
 
 lib/$(PCIIMPLIB): $(PCIINC) force
 	$(MAKE) -C lib all
diff --git a/pcilmr.c b/pcilmr.c
index eb5d947..bab2a07 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -20,7 +20,8 @@ const char program_name[] = "pcilmr";
 enum mode { MARGIN, FULL, SCAN };
 
 static const char usage_msg[]
-  = "Usage:\n"
+  = "! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
+    "Usage:\n"
     "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
     "pcilmr --full [<margining options>]\n"
     "pcilmr --scan\n\n"
diff --git a/pcilmr.man b/pcilmr.man
new file mode 100644
index 0000000..673262f
--- /dev/null
+++ b/pcilmr.man
@@ -0,0 +1,182 @@
+.TH PCILMR 8 "@TODAY@" "@VERSION@" "The PCI Utilities"
+.SH NAME
+pcilmr \- margin PCIe Links
+.SH SYNOPSIS
+.B pcilmr
+.RB [ "--margin" ]
+.RI [ "<margining options>" ] " <downstream component> ..."
+.br
+.B pcilmr --full
+.RI [ "<margining options>" ]
+.br
+.B pcilmr --scan
+.SH CONFIGURATION
+List of the requirements for links and system settings
+to run the margining test.
+
+.B BIOS settings
+(depends on the system, relevant for server baseboards
+with Xeon CPUs):
+.IP \[bu] 3
+Turn off PCIe Leaky Bucket Feature, Re-Equalization and Link Degradation;
+.IP \[bu]
+Set Error Thresholds to 0;
+.IP \[bu]
+Intel VMD for NVMe SSDs - in case of strange behavior of the
+.BR pcilmr,
+try to run it with the VMD turned off.
+.PP
+.B Device (link) requirements:
+.IP
+.I "Configured by the user before running the utility, the utility does not change them:"
+.RS
+.IP \[bu] 3
+The current Link data rate must be 16.0 GT/s or higher (right now
+utility supports 16 GT/s and 32 GT/s Links);
+.IP \[bu]
+Link Downstream Component must be at D0 Power Management State.
+.RE
+.IP
+.I "Configured by the utility during operation, utility set them to their original "
+.I "state after receiving the results:"
+.RS
+.IP \[bu] 3
+The ASPM must be disabled in both the Downstream Port and Upstream Port;
+.IP \[bu]
+The Hardware Autonomous Speed Disable bit of the Link Control 2 register must be Set in both the
+Downstream Port and Upstream Port;
+.IP \[bu]
+The Hardware Autonomous Width Disable bit of the Link Control register must be Set in both the
+Downstream Port and Upstream Port.
+.SH DESCRIPTION
+.B pcilmr
+utility allows you to take advantage of the PCIe Lane Margining at the Receiver
+capability which is mandatory for all Ports supporting a data rate of 16.0 GT/s or
+higher, including Pseudo Ports (Retimers). Lane Margining at Receiver enables system
+software to obtain the margin information of a given Receiver while the Link is in the
+L0 state. The margin information includes both voltage and time, in either direction from
+the current Receiver position. Margining support for timing is required, while support
+for voltage is optional at 16.0 GT/s and required at 32.0 GT/s and higher data rates. Also,
+independent time margining and independent voltage margining is optional.
+
+Utility allows to get an approximation of the eye margin diagram in the form of a rhombus
+(by four points). Lane Margining at the Receiver capability enables users to margin PCIe
+links without a hardware debugger and without the need to stop the target system. Utility
+can be useful to debug link issues due to receiver margins.
+
+However, the utility results may be not particularly accurate and, as it was found out during
+testing, specific devices provide rather dubious capability support and the reliability of
+the information they provide is questionable. The PCIe specification provides reference values
+for the eye diagram, which are also used by the
+.B pcilmr
+to evaluate the results, but it seems that it makes sense to contact the
+manufacturer of a particular device for references.
+
+The PCIe Base Specification Revision 5.0 sets allowed range for Timing Margin from 20%\~UI to 50%\~UI and
+for Voltage Margin from 50\~mV to 500\~mV. Utility uses 30%\~UI as the recommended
+value for Timing - taken from NVIDIA presentation ("PCIe 4.0 Mass Electrical Margins Data
+Collection").
+
+.B pcilmr
+requires root privileges (to access Extended Configuration Space), but during our testing
+there were no problems with the devices and they successfully returned to their normal initial
+state after the end of testing.
+
+.SH OPTIONS
+.SS Device Specifier
+.B "<device/component>" \t
+.RI [ "<domain>" :] <bus> : <dev> . <func>
+(see
+.BR lspci (8))
+.SS Utility Modes
+.TP
+.BI --margin " <downstream component> ..."
+Margin selected Links.
+.TP
+.B --full
+Margin all ready for testing (in a meaning similar to the
+.B --scan
+option) Links in the system (one by one).
+.TP
+.B --scan
+Scan for Links with negotiated speed 16 GT/s or higher. Mark "Ready" those of them
+in which at least one of the Link sides have Margining Ready bit set meaning that
+these Links are ready for testing and you can run utility on them.
+.SS Margining Test options
+.TP
+.B -c
+Print Device Lane Margining Capabilities only. Do not run margining.
+.TP
+\fB\-l\fI <lane>\fP[\fI,<lane>...\fP]
+Specify lanes for margining.
+.br
+Remember that Device may use Lane Reversal for Lane numbering. However, utility
+uses logical lane numbers in arguments and for logging. Utility will automatically
+determine Lane Reversal and tune its calls.
+.br
+Default: all link lanes.
+.TP
+.BI -e " <errors>"
+Specify Error Count Limit for margining.
+.br
+Default: 4.
+.TP
+\fB-r\fI <recvn>\fP[\fI,<recvn>...\fP]
+Specify Receivers to select margining targets.
+.br
+Default: all available Receivers (including Retimers).
+.TP
+.BI -p " <parallel_lanes>"
+Specify number of lanes to margin simultaneously.
+.br
+According to spec it's possible for Receiver to margin up to MaxLanes + 1
+lanes simultaneously, but during testing, performing margining on several
+lanes simultaneously led to results that were different from sequential
+margining, so this feature requires additional verification and
+.I -p
+option right now is for experiments mostly.
+.br
+Default: 1.
+.PP
+.B "Use only one of -T/-t options at the same time (same for -V/-v)."
+.br
+.B "Without these options utility will use MaxSteps from Device"
+.B "capabilities as test limit."
+.TP
+.B -T
+Time Margining will continue until the Error Count is no more
+than an Error Count Limit. Use this option to find Link limit.
+.TP
+.BI -t " <steps>"
+Specify maximum number of steps for Time Margining.
+.TP
+.B -V
+Same as
+.I -T
+option, but for Voltage.
+.TP
+.BI -v " <steps>"
+Specify maximum number of steps for Voltage Margining.
+.SS Margining Log options
+.TP
+.BI -o " <directory>"
+Save margining results in csv form into the specified directory. Utility
+will generate file with the name in form of
+.RI "\[dq]lmr_" "<downstream component>" "_Rx" # _ <timestamp> ".csv\[dq]"
+for each successfully tested receiver.
+
+.SH EXAMPLES
+Utility syntax example:
+.RS
+.BI "pcilmr -l" " 0,1 " "-r" " 1,6 " "-TV" " ab:0.0 52:0.0"
+.RE
+
+.UR https://gist.github.com/bombanya/f2b15263712757ffba1a11eea011c419
+Examples of collected results on different systems.
+.UE
+
+.SH SEE ALSO
+.nh
+.BR lspci (8),
+.B PCI Express Base Specification (Lane Margining at Receiver)
+.hy
-- 
2.34.1



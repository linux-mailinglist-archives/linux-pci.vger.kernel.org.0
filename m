Return-Path: <linux-pci+bounces-669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FE809F4A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8821F2184C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A6125B8;
	Fri,  8 Dec 2023 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="jLwleigj";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="iuHt1n8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B381736
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3CA33C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027161; bh=atwaCP8k/fBiJXUt5t5RIQH0VoV6KxHDF9TCJAhmxJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jLwleigj1a2FEjGskZkkSzFbiadiWoBzVrAFOLryUYf26cHE9yPgY8VkA4Y0P3yo4
	 y6NbdRdESHP3/s4HzTzr1u9qNQWHxY2Lvby5gMVfT2sNzL7veqKRFi7zycDfspg75t
	 XjwZwEj0uV6Q7C0JLH6vhMGKBBpJoevH7e90OxwnR2KLXr8BSrtGr5R+ajR/581Vta
	 F6u1rtEARxV2UYxYBk9PlckF70TT4UIef/8Qy9lzYP67VerW43gZ8PAMNCZGLmpbgU
	 MOzhZcleN1jI09T3yP2Nx4Zz3UQ7sLbJ2P1Vn1wQSlHXvjYU177i3X1cbr9omw1Ida
	 X4aBiOdB79xxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027161; bh=atwaCP8k/fBiJXUt5t5RIQH0VoV6KxHDF9TCJAhmxJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iuHt1n8GUgnzlwG7v+Saqj72juucwJXklq/YeIEeyG3147P0C1AScNA/UNXHFZaaJ
	 FeCTahLYluqwjU0Ho9eO59C/l0RyIxxAe139fClfemcOijj4QOAWOqiSaSeojaiTkO
	 8fkVrcY3icdlkqH2urYO/4NJJWLaK1y0Wb+6672gNl1H8xv+XxdmnykrNSltBKhgYJ
	 LfsdepT6Jktqj4VaRk56MXO/w28ZIcAsEqEdP22OKEgCvTARBAxpKccl4cDGeset0A
	 NvscJXSKY0/7kXlzoRXtP1ck+shKwr2wMrIl0b9gOvQ6zbZY4TsDRcnpDcxgUcGuRt
	 yO//EMC+MuPyA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 15/15] pciutils-pcilmr: Add pcilmr man page
Date: Fri, 8 Dec 2023 12:17:34 +0300
Message-ID: <20231208091734.12225-16-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile   |   2 +-
 pcilmr.c   |   7 ++-
 pcilmr.man | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 4 deletions(-)
 create mode 100644 pcilmr.man

diff --git a/Makefile b/Makefile
index efec2da..adc2023 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 export
 
-all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a pcilmr
+all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a pcilmr pcilmr.8
 
 lib/$(PCIIMPLIB): $(PCIINC) force
 	$(MAKE) -C lib all
diff --git a/pcilmr.c b/pcilmr.c
index 3da28e5..3e330f8 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -15,7 +15,8 @@ enum mode {
 
 static void usage(void)
 {
-  printf("Usage:\n"
+  printf("! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
+         "Usage:\n"
          "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
          "pcilmr --full [<margining options>]\n"
          "pcilmr --scan\n\n"
@@ -291,7 +292,7 @@ int main(int argc, char **argv)
       save_csv = true;
       break;
     default:
-      printf("Invalid arguments\n");
+      printf("Invalid arguments\n\n");
       status = false;
       usage();
     }
@@ -304,7 +305,7 @@ int main(int argc, char **argv)
     if (mode == MARGIN && optind == argc)
       status = false;
     if (!status && argc > 1)
-      printf("Invalid arguments\n");
+      printf("Invalid arguments\n\n");
     if (!status)
       usage();
   }
diff --git a/pcilmr.man b/pcilmr.man
new file mode 100644
index 0000000..f7108a5
--- /dev/null
+++ b/pcilmr.man
@@ -0,0 +1,179 @@
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
+Turn off PCIE Leaky Bucket Feature, Re-Equalization and Link Degradation;
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
+utility supports Gen 4 and 5 Links);
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
+The Gen 5 Specification sets allowed range for Timing Margin from 20%\~UI to 50%\~UI and
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
+lanes simultaneously, but usually this works bad, so this option is for
+experiments mostly.
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



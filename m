Return-Path: <linux-pci+bounces-7752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30848CC4A3
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B14CB220BA
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899F1E517;
	Wed, 22 May 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="c7FWYryq";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="XD0TdhFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD63139B
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394069; cv=none; b=ZGsJgDambD7njaNJPkEo9YdP/cglBxDrhbvdPzr/zsQdJdY6tps/5dDzc6RJb0Liv9XuOgjN8X48WRdGfgV/pzuwjL6kPSrGncL8bJM5bRA2xGjhXxtyCYdEQiMChTPj3BV+uwQuBEnKqAO9aYbpkmrvwBwzC/Afbvzwu3N76AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394069; c=relaxed/simple;
	bh=HzY6f3iUJ24wgnbI0vrAbRTn2REESZKtC2FIuUgeknA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POf/Jn0pA14akp1WR1jrqMQaJnsmokhvZsd6k/5k9U+t7fl/ZVm0Dv59V86GYMyN3lNlDz7a2et0iPIqe8QcaabspRh1qs1MSPwmIc9VqTUvZSkk9rwUcxph3z75WRYpx3P7DooOBzOwN2hDrXBrRbNrTJn7RryZjZbYuFaXYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=c7FWYryq; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=XD0TdhFQ; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5BEAFC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394064; bh=jWWwDnMW62IXvIk8a/CHEuRMWiiYVXoCwUzJF54YzYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=c7FWYryqQjHPmQkK8ImNylzr/dcHPGcyZoYjPqBUsbl4kQ/xsyugpb+MKS86+CPQo
	 MFINKIcXkJIZ42Lmn8b1wuLhaOxybB7SEyorlhtF9FAj1QEfrmH+Oxm8QW2r88ev7W
	 M1FE3sl/6HNo89iQ7bRZO078cNWQv6oIYeFGLx6UELOix7ZhiiCplxBcX+HDIsUUrK
	 wtADbTRZcN4AIdL3W5690j8KB8VHBiC6dHPb/MmKmMpoIVX6SNhYWnyuH7R8tn7X/M
	 X3WGUU0fRZFvHIAWTwI+ocwtQW/sP601VzxSMro67USfcn95aR6PDzJG/WWdVvNVIV
	 Rc33EmCR7IW3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394064; bh=jWWwDnMW62IXvIk8a/CHEuRMWiiYVXoCwUzJF54YzYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XD0TdhFQQ5kCotDdpdawB4fFdW4MuVeYdcj44CElzPSmtLcySEHDd9Yt7bEMbN3x1
	 tx193lfMNwKSuA14RDBN70XmVTZCwFF2t9R7FPjRkNxAOWMuvhzWiWgxLmYJ9Gwf8x
	 YtcOXvDJ1VmIN0xGR3us1yf5gR6c8DAtoRF1uDDWJNE+DvcXZue06xLTFQFS7+csyZ
	 A0iXa5jdL2kRZcriYFbk9sDKnCG7l8MkRvyfSCLtb5J4VnsJTUnjaH6zrCZI84wKL0
	 s21HB1o06aZiGFv07VgU8CXjXTD10LoxNKZJ007Y6t/2x3OBbq0Al/EMT1IYVzQlH3
	 nUppAVgsazxGg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 6/6] pcilmr: Update usage and man: new arguments format and grading
Date: Wed, 22 May 2024 19:06:34 +0300
Message-ID: <20240522160634.29831-7-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522160634.29831-1-n.proshkin@yadro.com>
References: <20240522160634.29831-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/margin_args.c |  39 ++++---------
 pcilmr.man        | 138 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 120 insertions(+), 57 deletions(-)

diff --git a/lmr/margin_args.c b/lmr/margin_args.c
index 8a6345f..57a1d0a 100644
--- a/lmr/margin_args.c
+++ b/lmr/margin_args.c
@@ -16,44 +16,25 @@
 
 const char *usage
   = "! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
-    "Usage:\n"
-    "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
-    "pcilmr --full [<margining options>]\n"
+    "Brief usage (see man for all options):\n"
+    "pcilmr [--margin] [<common options>] <link port> [<link options>] [<link port> [<link "
+    "options>] ...]\n"
+    "pcilmr --full [<common options>]\n"
     "pcilmr --scan\n\n"
-    "Device Specifier:\n"
+    "You can specify Downstream or Upstream Port of the Link.\nPort Specifier:\n"
     "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
     "Modes:\n"
     "--margin\t\tMargin selected Links\n"
     "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
     "--scan\t\t\tScan for Links available for margining\n\n"
-    "Margining options:\n\n"
-    "Margining Test settings:\n"
-    "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
-    "-l <lane>[,<lane>...]\tSpecify lanes for margining. Default: all link lanes.\n"
-    "\t\t\tRemember that Device may use Lane Reversal for Lane numbering.\n"
-    "\t\t\tHowever, utility uses logical lane numbers in arguments and for logging.\n"
-    "\t\t\tUtility will automatically determine Lane Reversal and tune its calls.\n"
-    "-e <errors>\t\tSpecify Error Count Limit for margining. Default: 4.\n"
+    "Margining options (see man for all options):\n\n"
+    "Common (for all specified links) options:\n"
+    "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n\n"
+    "Link specific options:\n"
     "-r <recvn>[,<recvn>...]\tSpecify Receivers to select margining targets.\n"
     "\t\t\tDefault: all available Receivers (including Retimers).\n"
-    "-p <parallel_lanes>\tSpecify number of lanes to margin simultaneously.\n"
-    "\t\t\tDefault: 1.\n"
-    "\t\t\tAccording to spec it's possible for Receiver to margin up\n"
-    "\t\t\tto MaxLanes + 1 lanes simultaneously, but usually this works\n"
-    "\t\t\tbad, so this option is for experiments mostly.\n"
-    "-T\t\t\tTime Margining will continue until the Error Count is no more\n"
-    "\t\t\tthan an Error Count Limit. Use this option to find Link limit.\n"
-    "-V\t\t\tSame as -T option, but for Voltage.\n"
     "-t <steps>\t\tSpecify maximum number of steps for Time Margining.\n"
-    "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
-    "Use only one of -T/-t options at the same time (same for -V/-v).\n"
-    "Without these options utility will use MaxSteps from Device\n"
-    "capabilities as test limit.\n\n"
-    "Margining Log settings:\n"
-    "-o <directory>\t\tSave margining results in csv form into the\n"
-    "\t\t\tspecified directory. Utility will generate file with the\n"
-    "\t\t\tname in form of 'lmr_<downstream component>_Rx#_<timestamp>.csv'\n"
-    "\t\t\tfor each successfully tested receiver.\n";
+    "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n";
 
 static struct pci_dev *
 dev_for_filter(struct pci_access *pacc, char *filter)
diff --git a/pcilmr.man b/pcilmr.man
index 673262f..3f4140c 100644
--- a/pcilmr.man
+++ b/pcilmr.man
@@ -4,10 +4,10 @@ pcilmr \- margin PCIe Links
 .SH SYNOPSIS
 .B pcilmr
 .RB [ "--margin" ]
-.RI [ "<margining options>" ] " <downstream component> ..."
+.RI [ "<common options>" ] " <link port> " [ "<link options>" "] [" "<link port> " [ "<link options>" ] " ..." ]
 .br
 .B pcilmr --full
-.RI [ "<margining options>" ]
+.RI [ "<common options>" ]
 .br
 .B pcilmr --scan
 .SH CONFIGURATION
@@ -64,26 +64,81 @@ Utility allows to get an approximation of the eye margin diagram in the form of
 links without a hardware debugger and without the need to stop the target system. Utility
 can be useful to debug link issues due to receiver margins.
 
-However, the utility results may be not particularly accurate and, as it was found out during
-testing, specific devices provide rather dubious capability support and the reliability of
-the information they provide is questionable. The PCIe specification provides reference values
-for the eye diagram, which are also used by the
+.B pcilmr
+requires root privileges (to access Extended Configuration Space), but during our testing
+there were no problems with the devices and they successfully returned to their normal initial
+state after the end of testing.
+
+.SH RESULTS GRADING
+The PCIe specification provides reference values for the eye diagram, which are also used by the
 .B pcilmr
 to evaluate the results, but it seems that it makes sense to contact the
 manufacturer of a particular device for references.
 
-The PCIe Base Specification Revision 5.0 sets allowed range for Timing Margin from 20%\~UI to 50%\~UI and
-for Voltage Margin from 50\~mV to 500\~mV. Utility uses 30%\~UI as the recommended
-value for Timing - taken from NVIDIA presentation ("PCIe 4.0 Mass Electrical Margins Data
-Collection").
+The utility uses values set in PCIe Base Spec Rev. 5.0 Section 8.4.2 as the default eye width and height
+minimum references. Recommended values were taken from 
+the PCIe Architecture PHY Test Spec Rev 5.0 (Transmitter Electrical Compliance).
+
+Reference grading values currently used by the utility are presented in the table below:
+
+.TS
+box tab(:);
+C | Cb S | Cb S
+C | Cb | Cb | Cb | Cb
+Lb | C | C | C | C.
+\&:16 GT/s (Gen 4):32 GT/s (Gen 5)
+\&:EW:EH:EW:EH
+_
+Min:T{
+18.75 ps
+.br
+30% UI
+T}:15 mV:T{
+9.375 ps
+.br
+30% UI
+T}:15 mV
+_
+Rec:T{
+23.75 ps
+.br
+38% UI
+T}:21 mV:T{
+10.157 ps
+.br
+33% UI
+T}:19.75 mV
+.TE
 
 .B pcilmr
-requires root privileges (to access Extended Configuration Space), but during our testing
-there were no problems with the devices and they successfully returned to their normal initial
-state after the end of testing.
+uses full eye width and height values to grade lanes. However, it is possible that
+device supports only one side margining. In such cases by default utility will
+calculate EW or EH as a double one side result.
+
+If info for specific device is available, you can configure grading criteria
+and tweak utility behavior in one-side only cases for your device using 
+.I -g
+link specific option (see below).
+
+.SH HARDWARE QUIRKS SUPPORT
+
+Thanks to testing or directly from the manufacturer's documentation, we know that
+some devices require special treatment during the margining. 
+Utility detects such devices based on their Vendor ID - Device ID pair.
+Right now the list of special devices is hardcoded in
+.I margin_hw
+file. For such devices utility can automatically adjust port margining parameters
+or grading options.
+
+For example, for Ice Lake CPUs RC ports
+.B pcilmr
+will change device MaxVoltageOffset value and will force the use of
+.RI ' "one side is the whole" "' grading mode."
 
 .SH OPTIONS
 .SS Device Specifier
+.B "You can specify Downstream or Upstream Port of the Link."
+.TP
 .B "<device/component>" \t
 .RI [ "<domain>" :] <bus> : <dev> . <func>
 (see
@@ -102,13 +157,29 @@ option) Links in the system (one by one).
 Scan for Links with negotiated speed 16 GT/s or higher. Mark "Ready" those of them
 in which at least one of the Link sides have Margining Ready bit set meaning that
 these Links are ready for testing and you can run utility on them.
-.SS Margining Test options
-.TP
+.SS Margining Common (for all specified links) options
 .B -c
 Print Device Lane Margining Capabilities only. Do not run margining.
 .TP
+.BI -e " <errors>"
+Specify Error Count Limit for margining.
+.br
+Default: 4.
+.TP
+.BI -o " <directory>"
+Save margining results in csv form into the specified directory. Utility
+will generate file with the name in form of
+.RI "\[dq]lmr_" "<port>" "_Rx" # _ <timestamp> ".csv\[dq]"
+for each successfully tested receiver.
+.TP
+.BI -d " <time>"
+Specify dwell time in seconds for the margining step. 
+.br
+Default: 1 s
+.SS Margining Link specific options
+.TP
 \fB\-l\fI <lane>\fP[\fI,<lane>...\fP]
-Specify lanes for margining.
+.R Specify lanes for margining.
 .br
 Remember that Device may use Lane Reversal for Lane numbering. However, utility
 uses logical lane numbers in arguments and for logging. Utility will automatically
@@ -116,11 +187,6 @@ determine Lane Reversal and tune its calls.
 .br
 Default: all link lanes.
 .TP
-.BI -e " <errors>"
-Specify Error Count Limit for margining.
-.br
-Default: 4.
-.TP
 \fB-r\fI <recvn>\fP[\fI,<recvn>...\fP]
 Specify Receivers to select margining targets.
 .br
@@ -157,18 +223,34 @@ option, but for Voltage.
 .TP
 .BI -v " <steps>"
 Specify maximum number of steps for Voltage Margining.
-.SS Margining Log options
 .TP
-.BI -o " <directory>"
-Save margining results in csv form into the specified directory. Utility
-will generate file with the name in form of
-.RI "\[dq]lmr_" "<downstream component>" "_Rx" # _ <timestamp> ".csv\[dq]"
-for each successfully tested receiver.
+\fB-g\fI <recvn>\fPt=\fI<criteria>\fP{%|ps}[,f]
+.TP
+.IB "   <recvn>" t=f[, "<criteria>" "{%|ps}]"
+.TP
+.IB "   <recvn>" v= "<criteria>" "[,f]"
+.TP
+.IB "   <recvn>" v=f[, "<criteria>" ]
+Specify pass/fail grading criteria for eye width (timing - t) or height
+(voltage - v) for one of the link receivers. For EW you must choose one of the
+units (% UI or ps), for EH mV is used.
+.br
+Additional flag
+.I f
+is for situations when port doesn't support two side independent
+margining. In such cases by default utility will calculate EW or EH as a
+double one side result. You can add 
+.I f
+flag for
+.I -g
+option to tell the utility that the result in one direction is actually the
+measurement of the full eye and it does not need to be multiplied. This is so called
+.RI ' "one side is the whole" "' grading mode."
 
 .SH EXAMPLES
 Utility syntax example:
 .RS
-.BI "pcilmr -l" " 0,1 " "-r" " 1,6 " "-TV" " ab:0.0 52:0.0"
+.BI "pcilmr -o " "csv ab:0.0 " "-r " "1,6 " "-g " "1t=20% " "-g " "1v=f,30 52:0.0 " "-l " "0,1,2 " "-TV"
 .RE
 
 .UR https://gist.github.com/bombanya/f2b15263712757ffba1a11eea011c419
-- 
2.34.1



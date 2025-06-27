Return-Path: <linux-pci+bounces-30883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E2AEABBE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2E3565941
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA24442C;
	Fri, 27 Jun 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dh5+9akt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854732746C
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750984019; cv=none; b=LDubCa/5Al+x/Kj9IocNqrAVxLubG52h5QRZriemWd0kbgjjWM/xpoHkGVv8xyH0O5y1tMPr2X1xGa6v+4JBTg3cIgijkwS0rkcfBQSCkrlM3Sn9z/VU6xXch9OBn8sAlQi8/zzlutKtjn2KcySxDEBHmJ0zIVWmHED6Cp8rRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750984019; c=relaxed/simple;
	bh=bW8XuuubY2X/a2mZn/cnwAi66RjpQYAzwcrrLQK7lBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vc21W++9OTV/pVLnXwbQTGAEfWN++m92RQWOT65xCH/KaP6QP3zC08nQGHsAEk7Au/6vyNnib1/OzkgNqi3Dy+ZuvvNfR9EGxd0q9RGUGhRTrQDMDDB7VmNxjm6mfSpN/FdCTpu1pHaKOoQH+m42aRcTc5TciRurocEzhBAs9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dh5+9akt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748feca4a61so1062326b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750984015; x=1751588815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldkpAT86jtPb4TzzI2O6HymTZgO4IclizBfQ3p2zUcE=;
        b=dh5+9aktZ/W5+ILvRmwezmRZgEb2UrOrdK5ugn46MxIFIPZkXwhzy59mQmfDHEvSRJ
         NAFFer5huZIVqbBvEjI1veKrBU6xOKVIdDa8VEOmIEVgLHVnxVXL9GslOlq53sw0kv4z
         dOWRvVdHtCPFFqEHmDsUT3YvaLXIiQadA3/cAlSSetP3gAJs0IQ/yKVcACsD9fxu7MTS
         J59oAc3RXHb9HmJ5mqCQrTTHlrTRQDqt/2y/te/HdURpfrzmBQtJFL2RQrGbyg6J2VMS
         dbw1FlRKo6b0wTtHqGbmTGX+942uOrhbQbA5vzAfoZyPJbafBLnvHjLZ6aw8efsSMv2w
         ts8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750984015; x=1751588815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldkpAT86jtPb4TzzI2O6HymTZgO4IclizBfQ3p2zUcE=;
        b=D+shf/D5gMzy/Sre4mb2e9RygS9umcaqLrZviFwnlPr0cqkGGlpRIdofSAx/Qo0Gvt
         wtu2YYDS/zC7fcJAI+CJwb0f/BFNlHBHnJjttxCoouVGQ1nOugdO4nGzXtyRB5Pxjo6N
         pnNe432/+HtOSivAZOxQExTSQ+McEJbQ7j2Yl0ln4iQYUHtTNyK1+JwOmyJ1Dj/5+nd0
         CSrwcROKQoLJ8fmriJXBwetcWvsIp+eGC4oVtb4pr1gLXd6bx2wf+0bmFvLFo4cXoQyA
         30UYdT4+6BcKvNiWoUFeCncjHX0/F5WedLZJMe7ot83cpMVwj88mTBAFr3l03BRZB05R
         8OXg==
X-Gm-Message-State: AOJu0YzNfxV6Ga16yZ3+blrrqnE/ozuqixls34OJCAK+nVN6EbhCfPCE
	43XQ6px6Q9JlM9h/JbNx0PTbiT+anGxcKLm2i4X5SgfoJxdOoqN7JOhbWV6pOgqeY+99PoxedZr
	aTweKE4wxy+v6mqnVAsmPIhKRUBhSwvs24NCYHHPbJt/R0E8xWYFD4KlD2QaE8XztfQuZSf2LcR
	K9kT3lhROcDSlMPQkuB88hu0Y6A04fus56aGgCYj9OHRTi7w==
X-Gm-Gg: ASbGncvuO8/LPZmNeBiiXy7Bjl2CJ8btjcCM7wpmo+zdf2pPLAELFcslXWE6PMk+ptX
	RqpDcHMLWHnkazI8+CYDckyi9o9yy81WFQVX3OsOWkdvxru25rYFLkFZDSjuCy01rr3fKhsLD45
	w91I2uUqkOIy0tYa0deHIftmexRgoU60H9yKERiP2qyMLaQ2AdQBzC47rSDVwPMtTV7Y3gXeoND
	qGcRZP2rOWjzAhJSLowIeJwUB9Qj+yETQTuaOIo/0ISz9M/I6y5EIlK6v3rNFyDHQ/UH8QPGbvC
	DI2Gf00sh76BZRZEzcrJ+0GtxUfX3XtIBTZU5R3QFDmEm5TWthFzYZZkeLzvE/qQhSM2jRpTRAC
	/sMCR1RWpbXd3
X-Google-Smtp-Source: AGHT+IHi9BsFgbDCnFPOmp7D+xy8IrWGTxXHVY3gwUpA0YlLlvtbwvq2kCqGuzWIZ/2c1exO54zWvg==
X-Received: by 2002:a05:6a21:32a7:b0:1f5:6e00:14db with SMTP id adf61e73a8af0-220a12ab5b0mr1500358637.14.1750984015315;
        Thu, 26 Jun 2025 17:26:55 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af56ce9f3sm769330b3a.122.2025.06.26.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 17:26:54 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Thu, 26 Jun 2025 18:26:50 -0600
Message-ID: <20250627002652.22920-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  I have reached out several times about issues caused by the
pcie_failed_link_retrain() quirk. Initially there were some additional changes
that we made to try and reduce the occurrences, but I have continued to
observe issues where hot-plug slots end up at Gen1 speed when they should not
have been or the quirk invoked when the link is not actually training at all.
Realistically speaking this quirk is a large regression to hot-plug
functionality in the kernel & therefore I am submitting this patch to restrict
the quirk to the ASMedia device where the LTSSM problem was actually observed
in the first place.
  The comment above the quirk states that the bad behavior was observed when the
Asmedia ASM2824 switch was upstream of some other device. Then further asserts
that the issue could in theory happen if the ASM2824 was downstream &
therefore I believe this is why it was concluded that the quirk should be
invoked on any device. i.e If the ASM2824 is the downstream device then we
could not use its device ID to trigger the quirk action.
  This is flawed in the sense that it was not actually observed and may not even
be an actual configuration anywhere in any device. It very well may not be the
case that ASM2824 could have this issue when it is the downstream device
because the issue was never root caused as far as I can tell & there is no
analyzer trace. The author had a noble goal, but it seems quite difficult to
capture the correct trigger & sequence of actions for every device considering
we're trying to address an issue beyond compliance with the spec afaik.

  In my testing I have encountered alarming rates of the quirk being invoked
when it should not be invoked & frequently degrading a link that would have
otherwise trained to full speed/width. The impact to hot-plug reliability is
observed to be extreme & therefore we believe cannot be justified to be
broadly applied. In the case of hot-insert the rate of being incorrectly forced
to Gen1 has been observed to be as high as 15% with some U.2 NVMe drives.
  It has been observed in several different system configurations with several
different U.2 NVMe drives from different vendors. All of the systems that we
have reproduced this issue on comply with PCI Express® Base Specification
Revision 6.0 Appendix I. Async Hot-Plug Reference Model for OS controlled DPC
or are very near to it. None of the systems I have tested implement Power
Controller capability.
  The largest occurrence of this issue has been observed on systems with OOB PD
(out-of-band presence detect), but it has also been observed in systems that
do not have OOB PD (Using Inband-PD or DLL State Changed).
  Actions likely to trigger the condition where the quirk forces the link to
Gen1 include physical hot-insert, slot power cycle, slot power on, toggle of
fundamental reset. By observation I believe there are several timing hazards
with DPC especially when using EDR. The expectation by DPC that the link should
recover before returning from DPC handling work is additionally a questionable
expectation in the case of a port being Hot Plug capable. Further, it appears
that the quirk can be invoked two times by the DPC driver. In the case of not
using HotPlug- with DPC it appears even more likely for invocation of the quirk
due to different handling around SDES (Surprise down error). In my mind this
makes a very complicated set of interactions even more complicated...

  In the case of hot-insert it appears that the power-up sequencing of drives &
their boot times directly contribute to the invocation of the quirk & the link
being forced to Gen1. For example, presence interrupt comes quickly
(first-to-mate in U.2) however the power pins are last-to-mate (ground pins
second to mate). Therefore presence can be seen even before power-up
sequencing in the drive is complete. If the drive powers-up, boots and the
link becomes active just after the quirk has written TLS (target link speed)
to Gen1 then your drive is forced to Gen1. If the sequence takes even longer
then you would see in the log "broken device" & "retraining failed", but
then later DLLSC would initiate the pciehp device add sequence again which
creates extreme confusion for most readers.
  In the case of power cycling the slot (without power controller capability)
then there are differences between OOB-PD enabled systems vs systems using DLL
State Change interrupts. In the case of OOB-PD the kernel will declare "Link
Down", set the ctrl state to OFF_STATE, remove the device, but then
immediately declare "Card present" & run down the pciehp_enable_slot() path,
but would run into the quirk since the slot power be off & it not see the link
train before timing out. Disabling OOB-PD & using recently deprecated
Inband-PD avoids the trap more often since presence is synthesized by LTSSM &
only asserted when the link is active however link degradation was still
observed in pcie resilience torture testing. Unfortunately I don't have a
meaningful characterization of the Inband-PD reproductions.
  With & without HotPlug capability the quirk becomes harder to hit after
pulling in the pci/pcie/bwctrl.c changes, but is still observable in several
circumstances. Those being observed around the handling of DPC with and with
EDR. The bottom line from my perspective is that even with bwctrl.c we still
observe a significant regression in hot-plug reliability in terms of arriving
at the correct speed. In my experience the link issue observed by the author
of the quirk is most likely an incompatibility between specific devices
as opposed to being something that could result from degraded link integrity or
device again & therefore should be restricted to the particular device where
observed.

Matthew W Carlis (1):
  PCI: pcie_failed_link_retrain() return if dev is not ASM2824

 drivers/pci/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.46.0



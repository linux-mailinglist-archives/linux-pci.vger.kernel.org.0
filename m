Return-Path: <linux-pci+bounces-34088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1EB27413
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 02:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FB1897712
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0BA41;
	Fri, 15 Aug 2025 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y1YjWlMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB027455
	for <linux-pci@vger.kernel.org>; Fri, 15 Aug 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218144; cv=none; b=KD3K0igO8D74fPMFuf44BvExFu85Bj+0lX3FvYysnAlZW9XL7q9TodnxrilCer8Pli+ICKicK5R2JI9HRHPyr/ufZS7mHO3MoWQQXRMbQITr1qJGqPVyYa1aYZnx21TlVkW0BCTCoA213xX1rrZpWeYiPuIHh9BtRv/cSG3zfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218144; c=relaxed/simple;
	bh=I7KdTfuXnUZVqTX00zu3hk1JbNPMCngc0u8MrUezr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peYR38qugSav5xddGqA53kPoNf5zoNN2IMgwd8vSbSAAAPFWdPY9AgzKBCG7MwXu+JOqLrsBIoEW3eXOSC4JHiytxjX9pABdZDVqvq2/sPHKsl0vrAkNZ0gUhSBWBmLoRhEqmT1VVnomAwemMVFULIhPkexd8LBkavRvYuYHA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y1YjWlMq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e613e90so1236598b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755218142; x=1755822942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Hn9h8d1crqfr/t6OoMlv47OXsUkWHmRkZb1I3QelI=;
        b=Y1YjWlMq6l11W7vN3WrQwOukJxKeYUROPxiCT0KcsMdhUGNVsl447iJyGy1srbcMv0
         YYW716viEeEQjDU9FlPenQSVItR1QOcCnSrMvS3qE8KhljBFrpXwY2WgsO5ClJahQ7gz
         A30kLe+uy4nz8KSfOfTYwn7eGT2FKVMioxs5vFq/PKYHh3h6fCz888QaiofzzfutvXBm
         1MBpesMosRb0tUVHvUo5fVP5Le1OmBzReFwUVLm5aUSCRJw9r6kLYWVxcBk78GgBwetS
         KuP1JgW5OM5lz0aLCZhrmk4COZSP5ngpSwmyWyDmNe+3IgBlNymovNJbPpo89SdYWF9+
         gK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218142; x=1755822942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Hn9h8d1crqfr/t6OoMlv47OXsUkWHmRkZb1I3QelI=;
        b=u0UVF2MqKLc8OpN/P7PRoGrMPH3CU0xRmoeryx5QIDL/L61g/X2ubsoaAemwEDO9lS
         QkvPfdHsoeoysyBPowWGYq0EhdkGVpqwRABikcTdKIYBYyLcPtgKIbsA7SV+93AwG0p3
         Gz9wQcJef2VeQ99ji9ZY5/LXFNMpdRY3YttVlORniJ5WSPo6Z5I719OM7aRYbVJI42Ta
         ajrF6WSfNxx13iPNN1GfmGchtA/hol5eQaDo9k/OF4kOQvG1IRHcSfOUFB1SsiV7APuT
         Yea5UIP+1e7muSIx4b+oCtN1CLNIwD1hAzy3q1uPtCsICeooDZAZgBqd1UOFSSYOaq2S
         dAgw==
X-Forwarded-Encrypted: i=1; AJvYcCWdr9pT/rPtjY6/m7gW8wQ6E6hS60KAcS4hNOcAQXv2W5UWKuHUdPtxPrEj2pWe6APaaYJXGbAox44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj//afgS73HQE7L+ncQcqpHfaE/H2t66O2U7GnmS+hx4MIEWmJ
	DWO0bkdJhA0DEFVaoXxrcfQXeL1oTeeBM+OvMyQTAwvF9vlUCwm099QuR1toR/ZvATM=
X-Gm-Gg: ASbGnctkR6tuo6xR+pMDO9+cvhqj261IuO/w2PEZwFhA3ZtfPudo6zQotvzQQq81+QJ
	m5RewiiYAyHglzNPaOwsvBjgGZeHIk4jP7dNIjagzibam8GUQiZ0QX1uBKyCJZpHwCKtxp+87Z9
	HvtKNc1rV8ttoMo90VR16S5k9Xqxxql2jRckuyWsPQaCBUBxVjZxy39kL9Bb6vL6flTaM0+THX1
	PYOgQo3c+voqI9/6dD8zw+w9FDP4q1KDgaTabW+MkS2lVc75VquDq+g0bUCm/Z9HxPOun0HOuGI
	5Qs5K0747O6lZC9pZn0ItQ8eatTVIKd/Uacc84/EB7YT+UBh3k8GjnZo7X+Ghy/QeFr5Z+JMRSn
	yazYytgrAo1WhvQTQ70p8+6f0/bftBfSyYqQ0gyoNre98lsfp
X-Google-Smtp-Source: AGHT+IG3zs3c4a0IMY/UqOSSTCmr+VW9zY1Dl2UVSFX+ImADYGfElSCoALBlFClfM6IVsBQJ24WS4g==
X-Received: by 2002:a05:6a20:6012:b0:240:9af2:71cb with SMTP id adf61e73a8af0-240d2db93f0mr345297637.20.1755218141501;
        Thu, 14 Aug 2025 17:35:41 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4289c5e123sm18273920a12.3.2025.08.14.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:35:41 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: mattc@purestorage.com
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Thu, 14 Aug 2025 18:35:38 -0600
Message-ID: <20250815003538.7017-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250723191334.35277-1-mattc@purestorage.com>
References: <20250723191334.35277-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for delayed response here.

On Fri, 1 Aug 2025, Maciej W. Rozycki wrote:
> CESta: RxErr- BadTLP+ BadDLLP+ Rollover- Timeout- AdvNonFatalErr-

The information you sent is somewhat incomplete. I guess you probably won't be
able to get any of the LTSSM state information unless one of the devices has an
ltssm log you can dump, but I doubt either of them do.

When I see that BadTLP and BadDLLP are still set it makes me suspect that
the hierarchy isn't configured correctly in order for those errors to go
to the root port. Or perhaps they're just being reported to the BIOS &
ignored or not cleared.

> but how would I gather such error information?

Lets try to figure out what is in control of AER & how/whether the hierarchy
is configured to send errors all the way to the root port. First we have to look
around "OSC" related kernel logging & the adjacent root port. Example here from an
Intel system we can see OS took control over AER (and other things) from BIOS. We
can infer this was for Bus 4f root port since its logged just after afaik. The
negotiation happens on a per root port basis so need to make sure its the root
port in hierarchy of the devices we're interested in. I've seen some BIOS retain
AER control over PCIe ports on the PCH.

Example dmesg from during boot:
acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
acpi PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:4f

We would want to look at lspci for the root port, the asmedia USP, the asmedia
DSP and the USP of the pericom switch (when able). I don't have any nested
switch configurations, but I think I can generalize it a little. Maybe this is
a correct configuration (using BDFs from a system I have to start with).

 +-[0000:4f]-+-00.0 Intel Corporation ...
 |           +-...
 |           +-01.0-[50-57]--+-00.0-[51-57]--+-00.0-[52-53] 

RP: 4f:01.0
USP (asmedia): 50:00.0
DSP (asmedia): 51:00.0
USP (pericom): 52:00.0

Root port can tell us if PCIe errors are going to the BIOS. IF any of the
ErrCorrectable, ErrNon-Fatal, ErrFatal, are set in the RootCtrl then those
error types would most likely go to the BIOS even if the OS thinks it took
control. Someone will have to correct me if wrong about ARM. If you sent
the full lspci -vvv of root port, USP/DSP/USP combo I could figure out
whats going on.

lspci -vvv -s 4f:01.0

4f:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        ...
        ...
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #25, Speed 32GT/s, Width x8, ASPM not supported
                        ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 16GT/s, Width x8
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 75W; Interlock- NoCompl-
                RootCap: CRSVisible+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+



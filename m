Return-Path: <linux-pci+bounces-37403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11785BB3661
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 11:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD33D420977
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF032D0275;
	Thu,  2 Oct 2025 09:08:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DC2DAFC4
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396097; cv=none; b=i/Hycy64G0H0FttFNTQr9b7qdoHqh563Shng93Td0bjW0Kgvifljq2o1CAVFSMocMfk0BfhQbDunQFoho4c+xV5NMAFnFGFGT2gmPnEAahcOnHzWFdupUt2Ocso244oxrCQBiQMcGI/xfHM2Trj6ADpJaFFRUSS+y6J8FBeuYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396097; c=relaxed/simple;
	bh=5GGj3BDaV8AokO60KGuXtx5mYIB5knG/5kaTJHn2go4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkEQ1SMg1aUWp/A2KXt+XgaFBkzQ+uVHIJJlkQaU9xqfVri6db9g8CddKh/ADXaRmjRC+qrK3/5ldld0xiU/6wGxSUSGvQKeLmSjpUGxYJ6T1ErT4E7XeX+zl5O6ZUlpxUJJURynverFfjZnfHSoFvpW3D+1Ievo+vzxgxM166o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so158142a12.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 02:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396093; x=1760000893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlLt5panXmmEHVXA0XxXsxYBIsfiOEYulVIp8xSB9XQ=;
        b=QGN9qA87QpE8OnVu84Zl1FgN6MICXRRdlAny+HoodNU2aNF1WeG5sgym8DxMldJuh6
         /Q+WAW+NUn3naBJcox8ksDnQ76aVN/ipJ4IUqGDHaFG4zNurMacFSplTfDdDoHorsJdF
         AfdB5y14po1K1d3yelBUM49Y0fXeuTiAx5sFnvO0vKLl6Bl/OXkfLK5k/wPRZCJoL/c8
         +ZwELy4O/WwJY6s1hpHewAms1d4ePo0O8Hq5xjWTlODllU534jzIXdnAzvTau/Zo3QMH
         azAE7LQZK5gBZTnBFSDSJciOGYvRZZnYNCgF/gfmg4EpTZQ1qyf1GI9lttEdaigX3kUP
         GUmg==
X-Forwarded-Encrypted: i=1; AJvYcCWrBCbwjRxf8xYxWqC7Z++1wn3MGFXNn4y9UwbqV1S4JD1w4AzL0dd3/ndlj/GAT5iw12VaU2Wfxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6cu/E8Jibyn9+zI+ZmMeD6yWnEW50nAsUya1n4+RbwoyhfC4
	PODweMb2xWZDwTT5Bj9WAHYP15mVw4pw8Emud/xMeFiAx+bkfEXcjYeqgSqDMQ==
X-Gm-Gg: ASbGnctivpe40rN3JBpZKWI78+KhLkBh13iQn7wBE/u9WxOr2hg+Q2gL5ggy2tqaySa
	VhnAEd7i9ClF8Y3RmSB+VkhC6AEe+5CR4VgsxWH18WQP8FQJeLv5sP6rfEcMELUZBfIogWeylUE
	/GgDoRRDWV3NwsfUCoiyVhnh7EH4EJAOLWm1tDwWEsI5yBdR3a1e3szSZT7ootY8gI86MDFqHQx
	6Ds1m7mCux6GJhf1v050Tx8Gl/W20f8OebbuuCy2CKdWTUkoTcmgv6kw2HTnQ6OFYe6SPUZQtla
	SxJtRsYhI/z9Y8aeiGTHw/2rYaN7HLjhwCBtU3JCtN1Y6l8FMbCzfN1P8ZJnRcQRouJBIh+Lisy
	qlI0h7vzOT1a9gS6T73MrvcC5jq6SMtK0i+SjLA==
X-Google-Smtp-Source: AGHT+IGpi5AWMPG26wffyaCaJQkmJM5i6JvDCSfBwhqoaFgRXhDDFMGP5iuKIHJhZ06XN3XmRGQUUg==
X-Received: by 2002:a17:907:2684:b0:b3f:a16d:da7b with SMTP id a640c23a62f3a-b46e4d7d845mr765523266b.8.1759396093087;
        Thu, 02 Oct 2025 02:08:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8b7sm157905466b.40.2025.10.02.02.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:08:12 -0700 (PDT)
Date: Thu, 2 Oct 2025 02:08:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: pandoh@google.com, linux-pci@vger.kernel.org, 
	Karolina Stolarek <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
	Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kernel-team@meta.com, gustavold@gmail.com
Subject: Re: [PATCH v8 18/20] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <qvxxjffvet7lukrjina44y52bsim4grvjl3avtzjlh2rgncyl5@4z5k36wtad6u>
References: <buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457>
 <20251001213836.GA228836@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001213836.GA228836@bhelgaas>

Hello Bjorn,

On Wed, Oct 01, 2025 at 04:38:36PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 01, 2025 at 06:16:29AM -0700, Breno Leitao wrote:
> > So, somehow the PCI was released at this point?

> For completeness, would you mind attaching the output of
> "sudo lspci -vvs 00:00.0" for one of these systems?

Sorry, I don't have this information anymore from the previous stack.
But, I've just a fresh instance of the issue that seems related to the one I
gave you.

Please let me know if you anything else from this instance and I will capture
for you.


	 {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
	 {1}[Hardware Error]: It has been corrected by h/w and requires no further action
	 {1}[Hardware Error]: event severity: corrected
	 {1}[Hardware Error]:  Error 0, type: corrected
	 {1}[Hardware Error]:   section_type: PCIe error
	 {1}[Hardware Error]:   port_type: 4, root port
	 {1}[Hardware Error]:   version: 3.0
	 {1}[Hardware Error]:   command: 0x0540, status: 0x0010
	 {1}[Hardware Error]:   device_id: 0000:00:00.0
	 {1}[Hardware Error]:   slot: 255
	 {1}[Hardware Error]:   secondary_bus: 0x00
	 {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2020
	 {1}[Hardware Error]:   class_code: 060000
	 {1}[Hardware Error]:   aer_cor_status: 0x00000040, aer_cor_mask: 0x00000000
	 {1}[Hardware Error]:   aer_uncor_status: 0x00000000, aer_uncor_mask: 0x00100000
	 {1}[Hardware Error]:   aer_uncor_severity: 0x00062030
	 {1}[Hardware Error]:   TLP Header: 00000000 00000000 00000000 00000000
	 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000054: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
	 KASAN: null-ptr-deref in range [0x00000000000002a0-0x00000000000002a7]
	 CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Kdump: loaded Tainted: G S          E    N  6.16.1-0_debug_rc12_0_g1031909ae07a #1 PREEMPT(none) 
	 Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
	 Hardware name: Foo
	 Workqueue: events aer_recover_work_func
	 RIP: 0010:___ratelimit+0x36/0x750
	 Code: ec 38 49 89 f7 48 89 fb 65 48 8b 05 fc da 84 03 48 89 44 24 30 48 ba 00 00 00 00 00 fc ff df 48 83 c7 40 48 89 f8 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 17 05 00 00 44 8b 63 40 4c 8d 6b 44 4c 89
	 RSP: 0018:ffff8882893c7a28 EFLAGS: 00010202
	 RAX: 0000000000000054 RBX: 0000000000000260 RCX: 0000000000000000
	 RDX: dffffc0000000000 RSI: ffffffff84b1cedb RDI: 00000000000002a0
	 RBP: 0000000000000002 R08: ffffffff87093aff R09: 1ffffffff0e1275f
	 R10: dffffc0000000000 R11: fffffbfff0e12760 R12: 0000000000000002
	 R13: dffffc0000000000 R14: ffff8882953ce000 R15: ffffffff84b1cedb
	 FS:  0000000000000000(0000) GS:ffff88905e498000(0000) knlGS:0000000000000000
	 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	 CR2: 00007fd58a9f2000 CR3: 00000002bd08f002 CR4: 00000000007726f0
	 PKRU: 55555554
	 Call Trace:
	  <TASK>
	  ? trace_aer_event+0x6a/0x1f0
	  pci_print_aer+0x30f/0x6c0
	  aer_recover_work_func+0x13b/0x200
	  ? process_scheduled_works+0x959/0x1450
	  process_scheduled_works+0x9fe/0x1450
	  worker_thread+0x8fd/0xd10
	  ? __kthread_parkme+0xd0/0x1c0
	  ? _raw_spin_unlock_irqrestore+0x42/0xa0
	  ? __kthread_parkme+0x92/0x1c0
	  kthread+0x50c/0x630
	  ? pr_cont_work+0x4a0/0x4a0
	  ? kthread_blkcg+0xa0/0xa0
	  ret_from_fork+0x1c6/0x390
	  ? kthread_blkcg+0xa0/0xa0
	  ret_from_fork_asm+0x11/0x20
	  </TASK>
	 Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) kvm(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) i2c_i801(E) xhci_hcd(E) ipmi_si(E) i2c_smbus(E) mlx5_fwctl(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) bpf_preload(E) ip6_tables(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)

And the lspci as you've requested

	# sudo lspci -vvs 00:00.0
	00:00.0 Host bridge: Intel Corporation Sky Lake-E DMI3 Registers (rev 04)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	Capabilities: [90] Express (v2) Root Port (Slot-), IntMsgNum 0
		DevCap:    MaxPayload 256 bytes, PhantFunc 0
		ExtTag- RBE+ TEE-IO-
		DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
		RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
		ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
		ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:    Speed unknown, Width x0
		TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
		10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
		EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
		FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd-
		AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		AtomicOpsCtl: ReqEn- EgressBlck-
		IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
		10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
		Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
		Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
		EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
		Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: LaneErr at lane: 0 1 2
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>


thanks
--breno


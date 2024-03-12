Return-Path: <linux-pci+bounces-4761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C25879A2B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D48285064
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93712FB2C;
	Tue, 12 Mar 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=skynet.be header.i=@skynet.be header.b="Z7yirVKu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailsec213.isp.belgacom.be (mailsec213.isp.belgacom.be [195.238.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD087137C37;
	Tue, 12 Mar 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.238.22.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263077; cv=none; b=A4WffvIimMDb12YVFI0NH5HHZO/syicDCF6VJ1dpfjyqkiMc5Ab38zQzH4XiYlXBosyMTh4987GF5Rjlq5sFt0MA/tcktCsHxKNFQIygDXF6pSZv2xLX4NZCL1ZaFr2Y9Eo3HRMb2MZwd9shQKqvz2IZbTsx9SNXj5ON8PUGQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263077; c=relaxed/simple;
	bh=A07tQtqpVaHHG4B2NH7DjaZFzMCi69J1B59/0F4/qz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdewpcK33w21mmby2Atiea9/pFguL6+7WE0W/iPDQ5Bpd327iJbpxDDos202qGNoictJTSzAPiXCyp0af8cnK6FQT+w6DfsQXw6dJt+GtQYvMqFxXFiXNHYBUU8D+yWGSHaEAoLubVYknePkx38immg+bXaSDzCVnY9PYhu0qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skynet.be; spf=pass smtp.mailfrom=skynet.be; dkim=pass (1024-bit key) header.d=skynet.be header.i=@skynet.be header.b=Z7yirVKu; arc=none smtp.client-ip=195.238.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skynet.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skynet.be
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skynet.be; i=@skynet.be; q=dns/txt; s=rmail;
  t=1710263074; x=1741799074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A07tQtqpVaHHG4B2NH7DjaZFzMCi69J1B59/0F4/qz4=;
  b=Z7yirVKueM6KDTmpI/sjFUEWytpcNj390IbPEchQkEhHHKS64StfrSIH
   t4pwK4Z3awPYScpmKfB3QYdHdMhJ02JvOqObCwD1Dp6stezTmGibPMThy
   VJKDwTgyjbpHLMkkQcVaL38Oldo9xMpWrPVnDashvFmZi7v0v9npsdJeC
   I=;
X-CSE-ConnectionGUID: GrriydkESxaq1NUG9H95tA==
X-CSE-MsgGUID: Loc18BkmSgWiFRR+Ka66Dw==
X-ExtLoop: 1
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EqAQBZivBl/0yfgG0NTR4BAQsSDEAJgTsLgzWBX4RVk?=
 =?us-ascii?q?TowhDuXdoFWgSUDVg8BAQEBAQEBAQEJOQsEAQEDBIR/Aod/JzUIDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQYBAQEFAQEBAQEBBgQBAQECgRmFLz2CaQGBHoEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINegEBAQEDIw8BBUEQCwkMAwICJgICVgYBEgIBAYJ8AYJzs?=
 =?us-ascii?q?gJ6gTKBAbUWBoEaLogmAYV1hDyCC0SBPAuCeD6CQwcXBBiFIYJoBIITgzuSU?=
 =?us-ascii?q?YsTVH8cA2AlBFoNGxAeNxEQEw0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGHyoLA?=
 =?us-ascii?q?wIaBQMDBIEtBQ0aAhAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZB8yCTwLB?=
 =?us-ascii?q?AwaAhsUDSQjAiw+AwkKEAIWAx0JDQQyEQkLJgMqBjYCEgwGBgZdIAcPCQQlA?=
 =?us-ascii?q?wgEAysnAyByEQMEGgcLB3iCAoE9BBNHEIE0hUSEWgyBHYJDgUMDCimBMgMZK?=
 =?us-ascii?q?x1AAgELbT01CQsbBiIBHQKiWQGCWQeBCCsidnOTRoMZAa82BwOEEowKlSIGD?=
 =?us-ascii?q?wQvqi6ILJAxII1QmwyBZgJygSBtgzpSKJcuimZ3AjkCBwEKAQEDCYhuKwmBR?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23:3Y6AzREWWqwwYTd7ntEzvZ1GfxBKhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33RmWBs6KsLoE07OQ7/qwHzRYoN6oizMrTt9lb1c9k8IYnggtUoauKHbQC7rHSRJ/N
 +l5EGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjZVmJ6oryBbErHREduBYyGh1IV6fgwvw6t2/8ZJ98Clcoe4t+9JFXa7nY6k2U
 LtUASgpPGwy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsP4Vb87VS284
 qlkVRHkkCgIOSI3/2HRkcxwkblUoAm9qBxlwo7be5+aOfxjda7AZ9waRG5BXsFMVyxdB463c
 oUCA/YdMetesoLwvEUFowegCgawBePv0j5IiWHw3a0myOQqDAXK0BU9E94SrHjYqdP4P7oQX
 ++o1qnF1TbNYf1Z1jjz9YbGbA4sof+MU71ybcXfxlIiFx/Gg1iKtYDpIy2Z2+YLvmOG7+RgT
 +Wvi2s/pg1/vjig3NwshZfXho4P0VDE6Tt2wIgvKt2+T057et2kH4FeuyqHMIZ2XtktQ3p2t
 yYk0LEGooK7czYEyJs9wR7fbOeHc4uS7R/4T+aRIjd5hHR7d7KjnRq96lavx/T6W8Kp31lEs
 jBLncPQtnARyRPT8M6HR+Nz8Eu/2zuDygPe5+VYLEwokafVK4IszqIym5cNsknOES/7lkXrg
 aOIakkp++im5eT7brjlupORN495hx/+PKksnMG0HOo2Mg8LX2eB+OS80qXu/U7nT7VQiP05j
 K3ZvIrdJcQBqa60BRJe3IU76xunEjuqzNAVkWMaIF5bex+LlZXlNlHKLfziD/qyglKhmypxy
 f/cJL3uGJDNI2DGkLfmYLly9VZRyBE2zdBD/5JUDawBIO7rVk/xqtPYChg5PhSwzOr6DNhxy
 JkSVX+OD6KaKq/erEWE6+0zL+aKfIMVuTD9JOY55/P2kHM1hVsQcbO00ZcJa320BOlqLkWdb
 Hb2gNoMEH8Gvg8kQ+zrjF2CXyRTZ3G3X68k+jE0EpmmApndRoy3m7yBwDm0HpNMaWBADVCMC
 nToeJ+fVvcXayKTIslhnSIYVbS7UIAuywmitAnhxLV/NOrb5jUYtY7/1Nhy/+DfiBM/+SRuD
 8uBy2GNU310nmQQSj82wq9/pUN9xU2Z3qhjmPFYFsJc5+lPUggkMZ7Q1et6C8r9Wg7ZZNeGV
 E6mQsm6ATE2Vt8xx94OY0BgG9StlxzDxzalA74OmryVC5w77Ljc02LyJ8lj0XbG0rcuj108T
 stIL22mibZz9xLPCI7Rj0WZi6GqeLwY3C7M8meD0GWPsFhbUAFuS6XFW24QZk/NoNTn6UPNU
 aWuBa4kMgRf086CLLVFatnzgVVBXvfjN8zSY3itlGeoGRaI2rSMYZLve2Uc3yXSElIIkg4N8
 nadKQgxGD2hrHnAAzx0GlLieEfs8eh4qHOmQU441QCKb0t917Wr/h4Zn+CTS/QW3r4coicut
 y10HEqh39LRE9ePuhBufLtdYdwg+ltIy3jVuBd6Pp2vNK1igl8ecwJqv0LhzRl3C4NAkdQ0o
 3Mu1gZ9NaWY0FYSPw+fiLryPafRYkn/+B+mYrWejlHT1Nmf87wn6/kirVjn+gazGRxmu3Fm1
 cRFlmOX573UAwcIF5H8SEA68159vb6JTDM64taeyXR3PLfyqSPP1dsvA/Amw1zoK8tWK66aU
 hTuHsMTAc+1K+UCgFu4aB8Yeupfov1nd/i6fueLjfb4dN1rmyir2CEeuNgV7w==
IronPort-Data: A9a23:t4cdyKLRHn+XjNnZFE+RUJUlxSXFcZb7ZxGr2PjKsXjdYENS1mQOm
 jQYWWiEOv6CYWukc950OY2/8RwPu5KByddgTAdorCE8RH9jl5HIVI+TRqvS04N+DSFioGZPt
 Zh2hgzodZ1sJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYADNNwJcaDpOt/rY8Uk34JwehRtB1rAATaET1LPhvyRNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiM+t5yZv/R3jndaPpATbaRDNhgN0mvhc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kZJ5cZ6+p0LFpe/
 OVBDg0iPzDS2v6flefTpulE3qzPLeHYZdJF/Cg+nXeAS6p+dPgvQY2TvY4ehW1gwJkTTLCBO
 aL1ahI2BPjESwFGIVoJTokikemhgH7kcDRws1GEo6crpWLepOB0+OW1aoWMJYPSLSlTtmKfr
 TuW1Wf8OR4lNfKl83mm+yzyqvCayEsXX6pXTtVU7MVCgFCXyWUaEzUVWEG9rP3/jVSxM/pbK
 koJ6m82pqka6kOmVJ/+Uge+rXrCuQQTM/JUEusn+ESOx7DS7gKxGGcJVHhCZcYguctwQiYlv
 neMntDgQyNiq6GYU3iQ7Li8qTK0JDhTLGkeaCtCRgwAi/HvqZ8yglTCCNxkAIaxj9voCXfxx
 SyHqG41gLB7pc8Pz6L9/1ndnTOqq57hSg8z+xWRX2S54wc/b4mgD6Sy4FbS4PJoL4uDSFSF+
 n8elKC24eYUDIiQmT6ISf8OR++B6POMMTmaillqd7Ei+i6r9nqLYoFM/Hd6JUFqWu4bYjLBf
 FLDtA9W75hWJGa2YLVsJYm2DqwC06nsBN3+fvbKb9ZPa956cwrv1CJnZAiQ0mbi1kYhl64XM
 p6ddsCtBn8eT69gyVKeXO4B0a4iwCkkzHLaQ5n9iRe6yaKDf2GcTKYtNFqIc/B/7aWYrQGT+
 NFaX+OQyh5cQdrhfwHN/IcXMV0Ja3M8APjersVNd+nFJgtjH2cqCvLVxbQJcolp2a9Sk4/g9
 HGwXkBRwUHXinrAJgGHLHtkbdvHXpF1pDQ4OgQnNFCv3XkoaILp56AaH6bbZpF4qqo6kK8xF
 qNVPpzYU7JGRi/DvjgMa9/8t5QkfhmviguFOC/jajVXk4NcejElM+TMJmPHnBTixALu3Sfii
 9VMHT83jXbOq8qOwSoWhD+SI4uNgEUg
IronPort-HdrOrdr: A9a23:PvbNt60SUNuYB802IyZKKQqjBLYkLtp133Aq2lEZdPU1SKGlfq
 WV954mPHDP5wr5J0tQ/OxoVJPgfZqkz+8Q3WBJB8bEYOCEggeVxeNZg7cKqgeIcxEWkNQttp
 uIGJIOauEYY2IbsS7yiDPIdeod/A==
X-Talos-CUID: 9a23:U75WqWDO9NZOO6r6EwZ97k8FFsMISW3U1S72HmDpKTc0VJTAHA==
X-Talos-MUID: 9a23:uJFfhgZnqtiUc+BTkzjn3WFIN8JT7JuvJno30rYP5ZeoKnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from 76.159-128-109.adsl-dyn.isp.belgacom.be (HELO [192.168.1.40]) ([109.128.159.76])
  by relay.proximus.be with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:03:22 +0100
Message-ID: <482b5ee6-5581-4e57-8ca3-8aec0d974c6d@skynet.be>
Date: Tue, 12 Mar 2024 18:03:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Save/restore L1 PM Substates for
 suspend/resume
Content-Language: fr, fr-BE
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "David E . Box" <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Mark Enriquez <enriquezmark36@gmail.com>, Thomas Witt <kernel@witt.link>,
 Werner Sembach <wse@tuxedocomputers.com>, Vidya Sagar <vidyas@nvidia.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Ricky Wu <ricky_wu@realtek.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Koba Ko <koba.ko@canonical.com>
References: <20240307222545.GA655965@bhelgaas>
From: "tasev.stefanoska" <tasev.stefanoska@skynet.be>
In-Reply-To: <20240307222545.GA655965@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 7/03/24 à 23:25, Bjorn Helgaas a écrit :

> [+cc Koba Ko]
>
> On Tue, Mar 05, 2024 at 03:46:56PM -0600, Bjorn Helgaas wrote:
>> On Fri, Feb 23, 2024 at 02:58:46PM -0600, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> This is some rework of David's series to preserve ASPM L1 substate
>>> configuration across suspend/resume.
>>> ...
>>> David E. Box (5):
>>>    PCI/ASPM: Move pci_configure_ltr() to aspm.c
>>>    PCI/ASPM: Always build aspm.c
>>>    PCI/ASPM: Move pci_save_ltr_state() to aspm.c
>>>    PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
>>>    PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()
>>>
>>>   drivers/pci/pci.c         |  89 ++++------------
>>>   drivers/pci/pci.h         |  13 ++-
>>>   drivers/pci/pcie/Makefile |   2 +-
>>>   drivers/pci/pcie/aspm.c   | 215 ++++++++++++++++++++++++++++++++++++++
>>>   drivers/pci/probe.c       |  62 +----------
>>>   include/linux/pci.h       |   2 +-
>>>   6 files changed, 252 insertions(+), 131 deletions(-)
>> I applied these as pci/aspm for v6.9, replacing the original unlabeled
>> v6 that has been in -next.
> Would anybody be able to test this, particularly to make sure it works
> for the bugs we're claiming to fix with this series?
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=217321
>    https://bugzilla.kernel.org/show_bug.cgi?id=216782
>    https://bugzilla.kernel.org/show_bug.cgi?id=216877
>
> This series is headed for v6.9, and I hope we can finally claim
> victory over these issues.
>
> This is in -next as of the Mar 7 tree.  Or if you want just the ASPM
> changes, based on v6.8-rc1, you can use the branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm
>
> Bjorn

I just tested the patch v7 from Bjorn, it works on my Asus UX305FA.
Tested on kernel v6.8-rc1.

Tasev



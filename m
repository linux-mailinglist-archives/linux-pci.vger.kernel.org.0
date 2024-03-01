Return-Path: <linux-pci+bounces-4320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C386E067
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4C1F2129C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4C6CDA1;
	Fri,  1 Mar 2024 11:32:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B56CBF7;
	Fri,  1 Mar 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292743; cv=none; b=SrGMsgz1VV9WQUPAixNgN27xhQD9OfMb4fiUuNAx6cAHPK+Puwq6o7ggR93b/jGVIPgeBH5BNuhzYgBvLBuZHpVatxdmocvDUb/lA9zB31l7A3Tbij0q5mi4kHFcnw9oZpSZpLHRs9v0IqZ08awuax1iP6rZic3KrITTczSVPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292743; c=relaxed/simple;
	bh=iZdqJT7yzjPyqMq3e//XkuxgJ/kzJaVl78/U6Um52dA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WQ5mlmdEQtuVZG8bSQQz70UbnGQaQ0RcDjenWusJM007vadzwPYEmJwTMVXn/tOymWNOyfrpy5spp+jYryeTNZmlST4W4yWiqmhrTbYSwto5JTCasG97RGcLlEifyuYd0SizvJZyC7S1P59cWLXOR8AAStfTgUZIO60pNRgcsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 704B861E5FE01;
	Fri,  1 Mar 2024 12:32:12 +0100 (CET)
Message-ID: <b1861a8e-27a4-4493-9f4c-2a6cf3575c4b@molgen.mpg.de>
Date: Fri, 1 Mar 2024 12:32:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Dell XPS 13 9360: Two PCI devices with disabled power management by
 default
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


I noticed on the Dell XPS 13 9360 some devices do not have power 
management enabled by default. From PowerTOP:

        Bad           Runtime PM for PCI Device Intel Corporation 
Sunrise Point-LP PCI Express Root Port #1
        Bad          Runtime PM for PCI Device Intel Corporation Sunrise 
Point-LP LPC Controller

These are the two devices below:

1.    00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
Express Root Port #1 [8086:9d10] (rev f1)
2.    00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC 
Controller [8086:9d58] (rev 21)

     $ sudo dmesg | grep -e 9d10 -e 9d58
     [    0.200876] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 
PCIe Root Port
     [    0.202637] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100 
conventional PCI endpoi

Is that a decision made by the system manufacturer or should the Linux 
kernel enable power management by default?


Kind regards,

Paul


$ lspci -tvnn
-[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core 
Processor Host Bridge/DRAM Registers [8086:5904]
            +-02.0  Intel Corporation HD Graphics 620 [8086:5916]
            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen 
Core Processor Thermal Subsystem [8086:1903]
            +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI 
Controller [8086:9d2f]
            +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem 
[8086:9d31]
            +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C 
Controller #0 [8086:9d60]
            +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C 
Controller #1 [8086:9d61]
            +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1 
[8086:9d3a]
            +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
            |                               +-01.0-[04-38]--
            |                               \-02.0-[39]----00.0  Intel 
Corporation DSL6340 USB 3.1 Controller [Alpine Ridge] [8086:15b5]
            +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac 
Wireless Network Adapter [168c:003e]
            +-1d.0-[3b]----00.0  SK hynix PC300 NVMe Solid State Drive 
512GB [1c5c:1284]
            +-1f.0  Intel Corporation Sunrise Point-LP LPC Controller 
[8086:9d58]
            +-1f.2  Intel Corporation Sunrise Point-LP PMC [8086:9d21]
            +-1f.3  Intel Corporation Sunrise Point-LP HD Audio [8086:9d71]
            \-1f.4  Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen 
Core Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 
620 [8086:5916] (rev 02)
00:04.0 Signal processing controller [1180]: Intel Corporation Xeon 
E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem 
[8086:1903] (rev 02)
00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 
3.0 xHCI Controller [8086:9d2f] (rev 21)
00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise 
Point-LP Thermal subsystem [8086:9d31] (rev 21)
00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise 
Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise 
Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
00:16.0 Communication controller [0780]: Intel Corporation Sunrise 
Point-LP CSME HECI #1 [8086:9d3a] (rev 21)
00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
Express Root Port #1 [8086:9d10] (rev f1)
00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
Express Root Port #5 [8086:9d14] (rev f1)
00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
Express Root Port #9 [8086:9d18] (rev f1)
00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC 
Controller [8086:9d58] (rev 21)
00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC 
[8086:9d21] (rev 21)
00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD Audio 
[8086:9d71] (rev 21)
00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus 
[8086:9d23] (rev 21)
01:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
Bridge [Alpine Ridge 2C 2015] [8086:1576]
02:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
Bridge [Alpine Ridge 2C 2015] [8086:1576]
02:01.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
Bridge [Alpine Ridge 2C 2015] [8086:1576]
02:02.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
Bridge [Alpine Ridge 2C 2015] [8086:1576]
39:00.0 USB controller [0c03]: Intel Corporation DSL6340 USB 3.1 
Controller [Alpine Ridge] [8086:15b5]
3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac 
Wireless Network Adapter [168c:003e] (rev 32)
3b:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid 
State Drive 512GB [1c5c:1284]


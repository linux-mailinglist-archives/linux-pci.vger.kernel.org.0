Return-Path: <linux-pci+bounces-1146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B638178CB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5251F2263F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA55BFA2;
	Mon, 18 Dec 2023 17:33:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C55A879;
	Mon, 18 Dec 2023 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5CF6561E5FE03;
	Mon, 18 Dec 2023 18:33:03 +0100 (CET)
Message-ID: <48d2cc9a-4a33-42fc-9c04-691c9d0c7806@molgen.mpg.de>
Date: Mon, 18 Dec 2023 18:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config]
 (20230628/evregion-300), method \_SB.PCI0._INI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On a Dell XPS 15 7590/0VYV0G, BIOS 1.24.0 09/11/2023, with an Intel and 
Nvidia graphics device, Debian’s Linux kernel 6.6.4 (and before) logs 
the error below:

     [    0.228085] ACPI Error: AE_ERROR, Returned by Handler for 
[PCI_Config] (20230628/evregion-300)
     [    0.228095] ACPI Error: Aborting method \_SB.PCI0._INI due to 
previous error (AE_ERROR) (20230628/psparse-529)

As this is error level, could you please help me try ing to address it?

I created an issue in the Linux kernel Bugzilla, and attached the output 
of `dmesg` there. Hardware information about the device can be found in 
the Linux Hardware database [2].


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218287
[2]: https://linux-hardware.org/?probe=97ca767d40


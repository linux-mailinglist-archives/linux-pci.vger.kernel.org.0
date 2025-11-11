Return-Path: <linux-pci+bounces-40833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DEC4BBBA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF018826F3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBF2741AC;
	Tue, 11 Nov 2025 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="uI8/Mzpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5523B61A
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843891; cv=none; b=Rzas8zx5rH7zYWpnOnml9ZAIdSk7E6IWYxorDGQZgPIQtVajWdI8TZKj32NcWdB9fbKivQc5/U9h1v1Pvwuv4LhFBO4f3dgrvFvKkVaLhGdoxyTHl+jOqjEUmlGfZEsE+0Vsnn2/PbDJm+8PJeNJrWDcJl+REHl9tHxO2wJKHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843891; c=relaxed/simple;
	bh=DErlls/0jBulJQGwlawMmjE7HKgq5cfvhi20S+9iayo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VppUMesAe6b/bfeL4VVqE8X1H2H1p95fz9SdAFuUsiCO5sH609I6GrGoVkmLdN8rG1OsYAm3FEPegLR1O+IKtHTHPIZtabFWifGahsEquIbiNQ9pbSu2HF3feDujxS6xbBsbjmY232ag8NKrK+b9341c1sRvpT1aESMH97AEBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=uI8/Mzpq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762843876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smhud6T4SqC4w36gRlyhLwg16tK5nMSudVt7tZE829s=;
	b=uI8/Mzpq9VCfvnfBdweD6Xzbo4CduDY6TixZiIKkPHALYiUZuKTVy7E4EOmNgqZ/JzjBRN
	2bsBIzHdNMhKZPPeQcVgEvz+XWC8mWleRX3e1OmOc301gPPkC4VOBwW+iaXF5y5CwbsiIU
	29xEXNssEZT/HA4zGr6dU5pdPpsF/kLFi5sl0x4kRomirNLaRW1JUI/iFHeOqB8ZUArUCf
	kEhAYvuPVeSZZWz+wsGwOAVGOWISlU2KkE9TrpYrQ0pkODkLbfKuK2KOIvvo2ycpLSOSQo
	UKFtPZfHa23wiFMd0hA1s9qjNivOX/K8wXRp8Fs3CWeKv4cYW0oys54BQePW6g==
Date: Tue, 11 Nov 2025 03:51:03 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 manivannan.sadhasivam@oss.qualcomm.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Valentine Burley <valentine.burley@collabora.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
 <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/8/25 1:18 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>> Hi,
>>
>> This series is one of the 'let's bite the bullet' kind, where we have decided to
>> enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
>> reason why devicetree platforms were chosen because, it will be of minimal
>> impact compared to the ACPI platforms. So seemed ideal to test the waters.
>>
>> This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
>> supported ASPM states are getting enabled for both the NVMe and WLAN devices by
>> default.
>> [..]
> The series breaks the DRM CI on DB820C board (apq8096, PCIe network
> card, NFS root). The board resets randomly after some time ([1]).

Is that reset.. due to the watchdog resetting a hard-frozen system?

Me and a bunch of other people in the #aarch64-laptops irc/matrix room 
have been experiencing these random hard freezes with ASPM enabled for 
the NVMe SSD, on Hamoa (and Purwa too I think) devices.

Totally unpredictable, could be after 4 minutes or 4 days of uptime. 
Panic-indicator LED not blinking, no reaction to magic SysRq, display 
image frozen, just a complete hang until the watchdog does the reset.

I have confirmed with a modified (to accept args) enable-aspm.sh 
script[1] that disabling ASPM *only* for the SSD, while keeping it *on* 
for the WiFi adapter, is enough to keep the system stable (got to about 
a month of uptime in that state).

If you have reproduced the same issue on an entirely different SoC, it's 
probably a general driver issue.

Please, please help us debug this using your internal secret debug 
equipment :)


[1]: https://gist.github.com/valpackett/8a6207b44364de6b32652f4041fe680f

Thanks,
~val



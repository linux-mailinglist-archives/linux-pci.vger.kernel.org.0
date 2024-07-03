Return-Path: <linux-pci+bounces-9717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B40925859
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D692F1C256A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA7143743;
	Wed,  3 Jul 2024 10:22:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9713C9AE;
	Wed,  3 Jul 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002146; cv=none; b=EaJfFT3yKIdTGzrFapqPpKdhHutiw2cvwgqaxTyV4PzQwSjoFZ8z2c6SUviDKXuBxGQhIUyK95mG+D4BE6o21Iz17e9Cwrdew+v8zdrf34kPeyT2Hngo9x9QSK1kIvrbIPD9THwn8dzEtkUhWkeOlaSpF3Bv0xhOTjSB7ujXRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002146; c=relaxed/simple;
	bh=BG6pyqIsQJ7ar3PhfgdLc/MDWEy+inKD23oA1FF4TLE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AboLmViWhMgHoJ33kZV/fX8S9KY66xig6ncXiUSgZYZa9+1hLNtsGy0MvF0o08juVTi8ZBnVpQOn0pWdoFGgOed6QzrxrTdCk+71+nhtDr0q4b5/m0v7YgcOy8SxU3y4O6saqAMmwYz0lSWemELx2sSPK1RKiriw7ZwKMb4xCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.44) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 13:22:08 +0300
Subject: Re: [PATCH] PCI: rcar-gen4: Add a document about the firmware
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>, <mani@kernel.org>
CC: <marek.vasut+renesas@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
References: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fe768dd8-cc07-10cf-c341-b1ada8130a22@omp.ru>
Date: Wed, 3 Jul 2024 13:22:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/03/2024 09:57:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186302 [Jul 03 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.44 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;lore.kernel.org:7.1.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.44
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/03/2024 10:04:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/3/2024 8:38:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 7/3/24 1:12 PM, Yoshihiro Shimoda wrote:

> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmwre downloading. So, add a document about the firmware

   Firmware. :-)

> how to get.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Krzysztof-san suggests writing a document about this [1]. So, I submit
>  this patch.
> 
>  [1]
>  https://lore.kernel.org/linux-pci/20240701204333.GB412915@rocinante/
> 
>  .../admin-guide/rcar-pcie-firmware.rst        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/admin-guide/rcar-pcie-firmware.rst
> 
> diff --git a/Documentation/admin-guide/rcar-pcie-firmware.rst b/Documentation/admin-guide/rcar-pcie-firmware.rst
> new file mode 100644
> index 000000000000..75c0d086dcc5
> --- /dev/null
> +++ b/Documentation/admin-guide/rcar-pcie-firmware.rst
> @@ -0,0 +1,20 @@
> +Firmware of PCIe controller for Renesas R-Car V4H
> +=================================================
> +
> +Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
> +firmwre downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"

   Again, firmware...

[...]

MBR, Sergey


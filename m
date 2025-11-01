Return-Path: <linux-pci+bounces-40035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD63C28245
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58E194EC9CC
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45E2C0F66;
	Sat,  1 Nov 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gbgYe8A8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738D24DCE6;
	Sat,  1 Nov 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013680; cv=none; b=ff6zEGRIcaSEPKEnOGycs4IyBYjpJZX9cVfnDC3xYNTMsTVfaCubWrRA8trAEaZ58Fg+dCBT5342Qo13BufBT+n4Ajvq7b84rE9+ukrv83qWagblVEdDH7acVhoDEqS9TweGbBSI8d2Gw8zMb+ec2nuhJWxKMk/9rIOvXM84WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013680; c=relaxed/simple;
	bh=3Psem+Ishk9PvrrqsHVjpICl3mn/S2dLyq4I1Tu/qf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=azQRx/dVSmDOmGXLnCoHcXR/s8DGmXEGF7DrA+SvgP9rgfG9BIK3ZuAhRp4+86yJ5f68+MmenfBmKsP1c8EHAqzuqD+IYTHAMHySqB5Ro6RJQSCwT6YHzD9i8psyrG/7eO7542UrTi7Dq/r+0wi/EcCKLziWWVKvfvdDtT+TCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gbgYe8A8; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id FEEGvCCejmO02FEEGvdAs1; Sat, 01 Nov 2025 17:13:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762013606;
	bh=YSrTYnslOhTn5JbALa4w7U69LIYmYpZEDX3oWdycpgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gbgYe8A8KuqOFQtTNTj6Tqf5xEWg1oKBfPbx8zE4SiNYQ4AQyOry8RRPxKz0YJmUz
	 XT3+g/ANUZ/Hp4oh8sHl0yREZ9jNOh4yfZZH1Wjc1TB2XWv7V8iuDGu/vtSpBzsMNX
	 ELdOHMhJQuM0nccN9NRQBVsbhAHMa2gMUotfNPd/6gSzCSo/EGRIJuoOtSU9vgppIc
	 gm5bkolz2nbySa9GTKcJUHAXbhUrIhdVBwNTPTaAVc4Hl4ar1LfR5iENTJ9q8A/LDK
	 n06Cc5gY2o2Y5IBnHYcn8QTiISG+x1DTxZPB1naMF1wbXwqUP/opLnV9oKtLkRzw2F
	 qXtTSUfUTEBkg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 01 Nov 2025 17:13:26 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <c1afb7fa-c45f-44e3-81e1-200da04c29ef@wanadoo.fr>
Date: Sat, 1 Nov 2025 17:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation
 delays
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 helgaas@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101160538.10055-1-18255117159@163.com>
 <20251101160538.10055-4-18255117159@163.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251101160538.10055-4-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/11/2025 à 17:05, Hans Zhang a écrit :
> Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
> operation delays to improve code readability.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/hotplug/pciehp_hpc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bcc51b26d03d..15b09c6a8d6b 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -28,6 +28,9 @@
>   #include "../pci.h"
>   #include "pciehp.h"
>   
> +#define WAIT_PDS_TIMEOUT_MS	10
> +#define POLL_CMD_TIMEOUT_MS	10
> +
>   static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>   	/*
>   	 * Match all Dell systems, as some Dell systems have inband
> @@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>   			smp_mb();
>   			return 1;
>   		}
> -		msleep(10);
> +		msleep(POLL_CMD_TIMEOUT_MS);
>   		timeout -= 10;

Should we have: timeout -= POLL_CMD_TIMEOUT_MS;

?

>   	} while (timeout >= 0);
>   	return 0;	/* timeout */
> @@ -283,7 +286,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
>   		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>   		if (slot_status & PCI_EXP_SLTSTA_PDS)
>   			return;
> -		msleep(10);
> +		msleep(WAIT_PDS_TIMEOUT_MS);

Same with WAIT_PDS_TIMEOUT_MS.

CJ

>   		timeout -= 10;
>   	} while (timeout > 0);
>   }



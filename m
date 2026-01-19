Return-Path: <linux-pci+bounces-45182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD8D3AB52
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 577B0307E7F6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B38378D8C;
	Mon, 19 Jan 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Zro+wjvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695F361645
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831610; cv=none; b=dp44GfSywcVfkRlhdc6/3hvysFoA4j9LMIFICxAQ1KV5AWb/ARlUImAElHIXcC1cyuaQ2e7TRrp9XmAv8rck3CihW8mjWyISRjQcPcnVGNjGEI+nvW6GZc0VhFPDdRINqvxJ5EZENGDUB5sNYtsUYGOnuPXveptdRNNx5v8S8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831610; c=relaxed/simple;
	bh=PaO//h4aaHpeXDKTCutId0QKH8llt3+YpQISpJCLbuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS2NgRb3xbgYPJclpSEA85SKzoXWqnD8G6Ubbp1wW57VMO6lGdWIn/Dt7nXcjul8RtnoQEaQ8ouFY5AHwDLSiCD+Wr6dksHn+SvXZAq7UiBYuUVwg19o0s+CBIp0feuM2wBxFVixebg0+4ukHN1wP/0khenI6JwsVkAHTgynDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Zro+wjvY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305552so3261330f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768831604; x=1769436404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYbPS1Q1egGiEf+FowJflS+CPH/nAP63ilv5+paqrac=;
        b=Zro+wjvYnlwdzhnKyDhs9ZwuUFG9gdqikr6/HWBhWvQZHjBJzodIaSZgCmgYbacTga
         aS46SGkJG69+rIPMMuAYSIkCm3gkclmMCSGKctjKFnrreHZFINpTtA3ojujadP8gx2LK
         xUiZeBJ2fcUGGyeqkfLYyX6yRP7btWg9AUKznBEcgfWFdk0HNeX0KJXRXVDWlH5taI+G
         nH5nf3XfuSMUBY9tu0/LSjRpjMlDFETW6AR2/B7IE/n8VRRgksP+kboYZ1znzWuGwb0A
         OVw8SOxtpsG1W5JhKmhSlsYSb91eHaUqnJhXTSEwvUKM8Fq3OuYldQ+FBZyJ8QuriJgm
         7AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831604; x=1769436404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYbPS1Q1egGiEf+FowJflS+CPH/nAP63ilv5+paqrac=;
        b=p0pVSuT9aJo3xbp7zd8p3Q+o6lv9tksMOP6CFuohHTmZFz1ZecI8uGWJDPKoGUeHtD
         riYmiFZRyJlOQoTosBn/PsdZhEdCRum9D/g/SOwe8/oWZ68PyazJn4VMxp+s5gD1mdu+
         B51vJ6TUNvZx7JDOWGhOsnXmRrZV5mJcQpkk0NdRX3xSFm8UMQUJGMEC31JyScri/vwJ
         WJak7HlicaUONyKG6d7Y6y36ppVhbZewz2xhjV4AvpMPN4nvBlsFD14hz/5Kg1i/h9rf
         S+F1P50rKl/F1g0NqxvrE9afV53G2NiRS8CRALh5bbfpat/0xntNvrq29xDyuMaz8EzW
         b5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX3VwgJRgsBAXNSkvayXcPBFZ0yJ15Tw6BJSOXoPTh7r4lcMU0MV2tkH2Y0ykO8LDiCZk/PfiWVtDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucXUn8UxZmNBXU8Gsg+EKTX+kKMtrFTv6DyP0UCRdnIDENLf/
	1eWzfoYBtR7RSF+kK9/lq3eLcJAN4euTh1gwtr47cx5zBHtzvjMf/CnWfZ/BKgEDSkI=
X-Gm-Gg: AZuq6aLXauhcrDQtvLaFw/r6DEdP76MIhKfsrebDpEqd7a1AIuRSrHHP4IVRZP3XD4I
	tLN/gturcaHPjoz/0s8RC78GVX08QWprLKAL7m3cEROg0r4gIMT4mpn8wSWJVPnRiFRifx6H6Yf
	DSsd8OX/1Mt8JJqVq+8wISLqnoC22gS+Upctwc5+BMX2J0bCqAY08w+Bx6t7yrpJFpRBFayKblC
	C2KP8F7qKrx4ECZn9jW5qyKXqKjVx4b1K6MtIzhro0L7rpX99KfsA23t+20pKCJwa0BDNizL8Al
	iGIrNouF6ZyrpO3XfqDEr2iH/8SKU+NSltzmu33mI3fd7FIKs/nPnFgIQoUEH7xFMI+60OvFuaP
	hma6BKANZ9AiBBLtboT9W80U+eUv1rrjJ6Od9pYupOMWy4i1VOjbzmE424QcZ2XYZg12J6vf6Il
	bRPX83d5K8iqVSdoXMkA==
X-Received: by 2002:a05:6000:2c05:b0:432:84f9:9803 with SMTP id ffacd0b85a97d-4356a033304mr13973113f8f.3.1768831603708;
        Mon, 19 Jan 2026 06:06:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm22767776f8f.15.2026.01.19.06.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:06:43 -0800 (PST)
Message-ID: <ade158ba-0532-4eb0-b95c-5c7de16b490d@tuxon.dev>
Date: Mon, 19 Jan 2026 16:06:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] PCI: rzg3s-host: Fix inbound window size tracking
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-3-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-3-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/14/26 17:33, John Madieu wrote:
> The current implementation incorrectly resets size_id each iteration
> instead of accumulating, causing incorrect remaining size calculations
> when mapping DMA regions across multiple windows.
> 
> Fixes: 7ef502fb35b2 ("PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver")

Same here with regards to the commit title.

> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index c1053f95bc95..205b60421be1 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1313,7 +1313,7 @@ static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
>   
>   		pci_addr += size;
>   		cpu_addr += size;
> -		size_id = size;
> +		size_id += size;
>   		id++;
>   	}
>   	*index = id;



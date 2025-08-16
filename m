Return-Path: <linux-pci+bounces-34130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110ECB28F50
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EADAC1B34
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC621D8E01;
	Sat, 16 Aug 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HAleAEvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19D170A37;
	Sat, 16 Aug 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360348; cv=none; b=kCICAIJm18no27lp7qMiqK7k5BEWCW/lSOYklD3vQNUqEd/tWgohE0C2YN/PFo9IK+6ob9VfJ7jZFEa1n0fYqv/lGbVxIC9HxAuUMaEmNvpYeJk+f9bVpqVGjw3Dszjp3fUpBQ2sqmBH4w/Hm5sR6vLlHWiTN8fF8MYmfrQ79h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360348; c=relaxed/simple;
	bh=UvLeR1cYc057w10eRLP8ciPQMZDMUaBMqNmqYiFGrZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2fLaJPm54fBO3vgqAsDlsbp8iysVUk4QIEZEpNXMn1BMGhMI785csTkYwGH8MmTALywL5AuN7fyVyr1Touhpm1bD5pVrDozIkHLtLzv+H8HdnBBzioPdJUyMQFzxVgjAbGB1MY12RPXTjOkTzwc2oHI/0ZfmceBkP3PHHvg4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HAleAEvw; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=XDYawLrhkzFBHKzvw5+ydZUpT3fCgm/tuXskrC+yzB4=;
	b=HAleAEvwYL4g8I5qxYQVKEBYmAzOPfGPIg+9mxzOJ/kjnISF0FA3/AVhN1cpI8
	bTprfPbli/3ytNCfw1/FfKgjiG5twkPesA5N42FRZfqtmdsgDUw7yjp9av12ECoh
	vAX5VPBEx3s31/LSupph5kJA3aBsCc2viufjqRth4A2vI=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnQJ09rKBoZ+W+AQ--.1722S2;
	Sun, 17 Aug 2025 00:05:17 +0800 (CST)
Message-ID: <953620e7-8873-481d-b235-8cbefcb08172@163.com>
Date: Sun, 17 Aug 2025 00:05:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-4-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250529021026.475861-4-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgAnQJ09rKBoZ+W+AQ--.1722S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr43XF47XF1fuw17Kry8Zrb_yoWDWrgE9F
	17XrZ3Gr4FkFyYkr1ayrWavrn0v3yrWw4UXryFyw1xAa4rCa4DZFn3uFy5Aa93Aa13JF18
	JF98Gr1jkrnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUaFAJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQw6ro2igp4JksAAAs8

Dear Bjorn,

Gentle ping.

Best regards,
Hans

On 2025/5/29 10:10, Hans Zhang wrote:
> The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
> This patch updates the validation in `of_pci_get_max_link_speed` to allow
> values up to 6, ensuring compatibility with newer PCIe generations.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ab7a8252bf41..379d90913937 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>   	u32 max_link_speed;
>   
>   	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	    max_link_speed == 0 || max_link_speed > 6)
>   		return -EINVAL;
>   
>   	return max_link_speed;



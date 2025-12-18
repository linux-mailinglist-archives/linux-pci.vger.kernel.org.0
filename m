Return-Path: <linux-pci+bounces-43325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C766BCCD5AA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C9E5309CF63
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27932E9ECA;
	Thu, 18 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X9Mgrshr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43957239594
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766085068; cv=none; b=MUs/nBFq8YySwVs7bad8m4iOx+FPpFMyzVuYUtPN00zk9VnV0U6qwDDCxYQWF8UcmP9Iu4ZoSlKCxp0/9A8eL0+LZfrB+4JAiFqUAwyvHDe47f+iU5NTrljNSXkR83ny8k2npchPWarSmg/6hva/dPRnYjS4Gdqk3O8TfRzVB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766085068; c=relaxed/simple;
	bh=p0YLcfND9aeEvVSGNQWJ61Mv9bRnHc4na+4XfL559f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QdotJRkJWCYeVu/r5j8GZNoexXeqlH5KxxGhGb+74NPiZVzCqtMXPVjWmZl5GjLwx81BgfTKDxEkvJisTi3zQjbZ0NrvCKzXAFWBnO9FiY+/hAt5Ja+K90yHCCefVvIpGuuouHogELUmAbdp9D00f6wpwOY5GdG5ldXNTre7YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X9Mgrshr; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c76d855ddbso291016a34.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766085066; x=1766689866;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lZIhicnPF5MBd0IyD7v1HJ7vxFXx8XMZHv9zGSx26g=;
        b=BEAHq/KPQI4sdY9evPehqu8EqnI2QWCyN+TJqIe4+6bb/pFDflJYQxgnAJ/25+Mav+
         E0kh/7piFtxNkP9k5o8v3MACnXSjAzQHubi5yLKg1KJFQrKfUU/c1Rruox1uYzLhPEEk
         JoEKgTci5syb4mZYTHcj8PV1SS8n24TOARI2sx/S/OFEluq2KvVSBoa3zS7djuo0R+hz
         f8U/8saz79vfino2JQcuYaHlje7JZZSPI1WTOqHT23apL8Tfv/fZw2UbFNVRDXvz2lJX
         IkcNnkY9bwE908xzEzN3AUgPn2qmPgBKMJc9e+rypyVP452YOtg75zYGR6vXcbifXyEE
         T6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVoU/rQspwU2kX8BuilN8U5TCjhgCMXwFA9qtl5PVhfyifgZylSFF1Uyjpb+smJ/arJJ6fCBYwmHew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fde57I7KQbGsQRKoh98R704m34mp8jABh7qGtQkQRdoBMkt5
	Uql+hI7k3Nm0AJMNXc9q8rQZSSXJaHr9lKaUfQoHP+JWpO7t2Kawol0TmPIuVh2mqTePwGI3PSh
	U4N9jXFfd14yyR8QSWfvR9CJV0C0G0oBXiBK6ArhbLM2Fe8oNfDomV3v4H8VmAnxgeTHKOAbNvk
	sEhY7BNWLLggtIpzU0PtVpuOuwYHOF1RcHarQM/JS8fc1H4pJzUuLWOz78b7YEtyoJVN2janWMU
	99yApAZaVc0zPTHdKW2
X-Gm-Gg: AY/fxX5YQ3FO8zjlYEe5KHOHu7dT27UqBWoLcHUm/wjGqYTMtTtOF6vBcA0OqF9ekz6
	n8pb759Bpu0hM5AF0ca7OdfKJsm4It78bfl07ItAVtAClXGTBuEU+LLLoX+LwG4GlAD9FcuFGcf
	BrPnIx9k7DwoxJ4uFCY6WB1EOZPGJbX3akMufUwjnP6Xf7mIuqHUu9eck3RT7ohFY0EZRsQRQ3F
	QL5jELxVq94W0vlO+id7UJBdKv18D7ITAmHWM6OxMXEDiyGlE65yDHonRctJZ67TJ97/ffFjwYj
	SMddEN3uLVgJMqhGphertN8PeR/ywh9psXI2PaAOggBT4ZZKXVu2iqJu24xEDLuY+J7+hqcJ/w1
	sZp/WPp4GT4/cx3C5BCTAuCLoP1zebkinkvyHq8xp7eBAKg0ZKu/oizWak5ndYx+enB0/6MbG9m
	PkOEyinBm8iosfdNWjLL/m8I7B455lS7cdb7u1hyJV6CozRL4fLA==
X-Google-Smtp-Source: AGHT+IGNCtp0rl8pOXkwY7tMikwOnvW9F9HBd9zhLqJU86Nzcoue2UqYhjPIf2SpHacbovtxT+XHAnBbENMC
X-Received: by 2002:a05:6830:2406:b0:7c7:655c:735e with SMTP id 46e09a7af769-7cc668af346mr183372a34.10.1766085066080;
        Thu, 18 Dec 2025 11:11:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cc6666c05dsm26390a34.0.2025.12.18.11.11.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2025 11:11:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1d7ac8339so27504051cf.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766085065; x=1766689865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2lZIhicnPF5MBd0IyD7v1HJ7vxFXx8XMZHv9zGSx26g=;
        b=X9MgrshrDYHBmhJ0TlqCFYne9xi314HhJ7oETqqw/0Ft5B1S80aXlKCmRdPhplzlgn
         MrMMcV3npMho/dhIw5keciMsxCfLvHcaiLBX2XcFybW/VxH3CM12YEmfsDg8UOHjSMax
         qnJcpCz7NJYyGasd+iXFYm9NCLS0QWD1SfmnM=
X-Forwarded-Encrypted: i=1; AJvYcCXvYC8MCmtrF0d4SdWFkwxutylHlvkObH8Yd8kh26RJT1wx+tY9+etmzeejrIe2BZkP902gQsBm2ZE=@vger.kernel.org
X-Received: by 2002:a05:622a:4c0f:b0:4ee:2312:6059 with SMTP id d75a77b69052e-4f4abcd267cmr4668201cf.19.1766085065184;
        Thu, 18 Dec 2025 11:11:05 -0800 (PST)
X-Received: by 2002:a05:622a:4c0f:b0:4ee:2312:6059 with SMTP id d75a77b69052e-4f4abcd267cmr4667571cf.19.1766085064645;
        Thu, 18 Dec 2025 11:11:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678393bsm10407785a.6.2025.12.18.11.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 11:11:04 -0800 (PST)
Message-ID: <8cbf63d2-1510-4d58-b2ca-0fd23a476539@broadcom.com>
Date: Thu, 18 Dec 2025 11:11:00 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix RP1 DeviceTree hierarchy and drop overlay support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 iivanov@suse.de, svarbanov@suse.de, mbrugger@suse.com,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1766077285.git.andrea.porta@suse.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <cover.1766077285.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/18/25 11:09, Andrea della Porta wrote:
> The current RP1 implementation is plagued by several issues, as follows:
> 
> - the node name for RP1 is too specific and should be generic instead
>    (see [1]).
> 
> - the fully defined DTS has its PCI hierarchy wrongly described. There
>    should be a PCI root port between the root complex and the endpoint
>    (see [1]).
> 
> - since CONFIG_PCI_DYNAMIC_OF_NODES can be dropped in the future
>    becoming an automatically enabled feature, it would be wise to not
>    depend on it (see [2]).
> 
> - overlay support has led to a lot of confusion. It's not really usable
>    right now and users are not even used to it (see [3]).
> 
> This patch aims at solving the aforementioned problems by amending the
> PCI topology as follows:
> 
>    ...
>    pcie@1000120000 {
>      ...
> 
>      pci@0,0 {
>        device_type = "pci";
>        reg = <0x00 0x00 0x00 0x00 0x00>;
>        ...
> 
>        dev@0,0 {
>          compatible = "pci1de4,1";
>          reg = <0x10000 0x00 0x00 0x00 0x00>;
>          ...
> 
>          pci-ep-bus@1 {
>            compatible = "simple-bus";
>            ...
> 
>            /* peripherals child nodes */
>          };
>        };
>      };
>    };
> 
> The reg property is important since it permits the binding the OF
> device_node structure to the pci_dev, encoding the BDF in the upper
> portion of the address.
> 
> This patch also drops the overlay support in favor of the fully
> described DT while streamlining it as a result.

Timing could not have been better as I was just going to apply Rob's patch:

https://lore.kernel.org/all/20251211193854.1778221-1-robh@kernel.org

Yours is definitively more complete. Rob, Krzysztof, can you review this 
series and I will fast track it today.

Thanks!
-- 
Florian


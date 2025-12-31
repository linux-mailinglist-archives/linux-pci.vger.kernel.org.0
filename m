Return-Path: <linux-pci+bounces-43869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66349CEB25D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A106830245C9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4D2E2DDD;
	Wed, 31 Dec 2025 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b="hbBB9+OO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9223ED75
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149918; cv=none; b=jeTIXg8+u9l9ffLbQ8Pd0p0LWYj1OApyJylwkKOFcMyZeocgyQssXG5HwkKxBFsy3iaa1FxK8hsodBNLKhRjztkQUv6yeMXHm18M4TdEZXuSYH8ggHZsiwji3YsKcMLUaGbIu5MfYpuVOwDmOoPOK3x9LQK9oPW5kkzbldjKJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149918; c=relaxed/simple;
	bh=WVD+7f2N4tCkZK3m/mQgLQPTE38EnHO55pxEujuiFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbYA+8UZrwE1BScIkXlVYvbhD1I5C+rfzNTvshhJFRwLECOeNNNGRJ0RV1Wkm6Fnm7xjrLWejmy7IeZKI9kzdhUf1fS+hMaC66eWWmQWZYcAnpKanpPDriDjfYmhBm0lSJZETNLt3/YAU5ACthtt6PG1O+AHcKEamicqoFIGPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net; spf=pass smtp.mailfrom=pardini.net; dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b=hbBB9+OO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pardini.net
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b832c65124cso634124266b.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 18:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1767149915; x=1767754715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUfeQsuPis8+vWGa7ve6iy4exkmxdmo6Yqgm4mr4Xz0=;
        b=hbBB9+OOicofPrsFnV2AIsUqkkWQVE/OZm/Uv/4OU1gIf2c1312I0UV8wEKWPkx70d
         aZoexnezJAsG9o11NoPAkIEb4lO5rcHrOAo6eFeI1FDIp+SCPSL0QRfmwAi3geQe/Hop
         pUDki2dTmPovg+LOHp4mm+86F3EOMkXGY7a50FB55lp1in6XJot021NDZf7l9+hYeZoL
         jNjK0BNbmAfQ4ojrl8JHhVXYI/F1f5fD6DLXLOfadseUMVUaIHd7/faq2crNtPqlorw0
         PFsyei1DJl8iuwkbTSuKs6wQmE0iLSzmBvpJ9xQso+MN560EGkYnadna9Wt9AhvIEXde
         3xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149915; x=1767754715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUfeQsuPis8+vWGa7ve6iy4exkmxdmo6Yqgm4mr4Xz0=;
        b=W/NI9I5beqBh1LqsRtP9hzdx+A0aVH3yWUTcPJ2B138EC0GE7v+2bmM0gw6648p+Ob
         1zkkuVNWEfebucVnVBC7SE2LI2/XQtJ4PeQFOxDDEg+ZmHeSfSmi+DC5cxPDZ7CEgfHu
         ZZrqTY4Fz1Geasc+Azih2ZZ0oJQbfsiEvsfNZ1jplX5sAVV1UklANsLh0n1Q4Fb6zm4n
         +A80Kegh70lJPzZjELhzCpdLykD0OA1o8ZMNL/ugzccJMsmwnQ3OHVYz+U38WrNn6qp8
         5XjSk3GVATOCH+M4Qn3vDq+TQc4M8n1CsLzcvy+YYGkRfYfN9UCbr+Z5p685yc3pPy3U
         qTXg==
X-Forwarded-Encrypted: i=1; AJvYcCVklUocAX9F9m9mEOtKLH3p/Mu6f/u6yxNmdUeTUTtQPomgzeRSHX3pYKcwAt9P3DygRFFFjsfvYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlu/o5UHFQ1wOUmHxlrlfbeYN9z3mSUfArUfhH2t35dStZkaA
	7+FQCgNYr5k2ad99/eNZCBb4Sz8U5EHnHQ7Uhspdu4AJX0Hq/YO2gmczk2njCOnsdg==
X-Gm-Gg: AY/fxX7IR8Q6crHfVf+mw3xX3Iaf2rEbUFPdjGik7KOESSYmbXPp/rXQjbmt0CNIATN
	98G88soyAjlkFar2aurKf+0Map7dluyJ6JstQUgCCPiXAcXWTNBTbPWEhd2eD3eQN8Emuu223Gz
	UBhRDwdVktmhekGY/f1hVzaS/IeDsBek1aYfM/dlfarq01Cykn4MSZYFroaH07xE5ySxLggHSv+
	nkv3M9tdcGUcgzjc+6C9T7sloZjyrTWvqwZVJe/X1NVFulfVBSc9zhq0e6Egz8RMUtjNL/AJz9t
	mR48bXU9kBIVms4FIqQcLx5xLSp1xPZQ4JedOqqZ2kam5G0aFTohNPAa6Jj6OfmE3wKpCFhmyJE
	gkxyrgG3cxsFvJI6sVHIWsxJtO2yqPyprYWw2iB2EiB/wzliM2M5JoS3qKvJP5SZmEDpQ0Bnjmr
	ZCNXN2O6QfbzEb8Ls+CgVhpX2bVlQTe8o0UShNZ4btuJxSpIcGQYZdWe/oM5elHQ43dkW1+MNIu
	iZ0wIowq/bi+Y2VZ9LLp/31tqf/tE+/rEnEVmpLgRvkOAfrvsln6K1ynA==
X-Google-Smtp-Source: AGHT+IGGCF0sHMt1+YYCpeAxQN9Ovdj+s2AiArjZinsNakQ8z+N2JPpr7xnF8T/yZnTmh07agmcy1w==
X-Received: by 2002:a17:907:1b15:b0:b73:9792:918b with SMTP id a640c23a62f3a-b8036f5fcf3mr4070078066b.27.1767149915064;
        Tue, 30 Dec 2025 18:58:35 -0800 (PST)
Received: from ?IPV6:2a02:a466:4d7a:0:49c0:3675:3f69:8ee2? (2a02-a466-4d7a-0-49c0-3675-3f69-8ee2.fixed6.kpn.net. [2a02:a466:4d7a:0:49c0:3675:3f69:8ee2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b83926533b7sm450609966b.20.2025.12.30.18.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 18:58:34 -0800 (PST)
Message-ID: <f5322597-c6dd-494a-863b-2caf24363f2d@pardini.net>
Date: Wed, 31 Dec 2025 03:58:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251127170908.14850-1-18255117159@163.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <20251127170908.14850-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2025 18:09, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.
> 
> This patch series addresses this by:
> 
> 1. Core PCI enhancement (Patch 1):
> - Proactively configures Root Port MPS during host controller probing
> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
>    and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> - Preserves standard MPS negotiation during downstream enumeration
> 
> 2. Driver cleanup (Patch 2):
> - Removes redundant MPS configuration from Meson PCIe controller driver
> - Functionality is now centralized in PCI core
> - Simplifies driver maintenance long-term
> 
> ---
> Changes in v7:
> - Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
> - Remove redundant check for upstream bridge (Root Ports don't have one)
> - Improve commit message and code comments as per Bjorn.
Hi Hans,

I've tested on an Odroid-HC4 with a SATA SSD (via an ASM1061) by 
applying your v7 on v6.19-rc3 + Bjorn's 
20251103221930.1831376-1-helgaas@kernel.org ("PCI: meson: Remove 
meson_pcie_link_up() timeout, message, speed check" which is required to 
get the meson PCIe to work at all since 6.18). With that setup I get:

# hdparm --direct -t /dev/sda
  Timing O_DIRECT disk reads: 832 MB in  3.00 seconds = 277.33 MB/sec

I've an identical machine, with a similar disk (even slightly faster, on 
paper), running plain 6.12.y and there I get:

# hdparm --direct -t /dev/sda
  Timing O_DIRECT disk reads: 764 MB in  3.00 seconds = 254.26 MB/sec

I repeated those a few times, not very scientific, I know; but anyway:

Tested-by: Ricardo Pardini <ricardo@pardini.net> # on Odroid-HC4

I've also feedback from another user running with this series with 
success on a different meson PCIe machine, will ask them to TB as well; 
they had reported a significant drop in performance since v6.18 without 
this.

Thanks,
Ricardo


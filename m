Return-Path: <linux-pci+bounces-27766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA1AB7AEE
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 03:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3693860184
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9E24C68D;
	Thu, 15 May 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfnkV+eu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342A25B1CE;
	Thu, 15 May 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272203; cv=none; b=jDR282DwoE2b37Q1maKaOO0R9bDxBSVcnzyZFWCxAcpQivefcyNBfS5UZb98EpmCsnVt/EHVA5gl94HkfgwsEXQ4FhPIBYiCn7dg1RYhF5tzE9XJnuDZSh6byEUA3eJcjWMZCWS397PSVJEZm5HsBzcy6BMSQNOV4Oj65cjNRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272203; c=relaxed/simple;
	bh=MjEDxmDIgnEbN9DbfVfSdVDCDLR/gWzcer0C7w1Qfuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYDlRdgOC/8sVP5hiLBUibxej86yP/iHVy8O17V/ue6IQlyIpJU5q+FZVegiqSpOVUCKK/a/LiaKFzgcoNKknDmX5jewpm5toF6tpOeVTIglEDdCbN641Hbz5kEV27bDkmecpjw7zop4wszUpkcF/K7t85847zbcO8buKQ+oIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfnkV+eu; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3feb3f54339so539141b6e.1;
        Wed, 14 May 2025 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747272200; x=1747877000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6xEBDe6/MxO+zNG1k99t5k3/oCboXoZUQWqw6+THMU=;
        b=EfnkV+euBVdki+3XkC+jKL+6B5ClTaMwa7RemqPtmHNBsQatEaPorcG3jGQEzJpKua
         cvGhffnyPG4aHecNyNmX+oGLAT856pWt5QknjP3WWu3x0TmA4nsRxpE5MlFtV1vUniIc
         QUgKPgVRG/Tb8vDJQaSlchSkDxW4SMK7X8YIxEOSvZUVYbzVlSiT+dHXHGna00AfPPqV
         HVqPc3krx6sbF6q8U6ovooGKK9w7LnumdahX2DxflJyrhuqPeC8Cl1k0f38bdTrLxxHX
         QexvVsKQS8IcLWiyG5+cgwizdwA0AQ58IMHVls85KiHOCJ/aUTSDgv5icdpogGF/EDmD
         pwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747272200; x=1747877000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6xEBDe6/MxO+zNG1k99t5k3/oCboXoZUQWqw6+THMU=;
        b=vG8YK3EUSw0YJTUpGXoXTIYr0IAtwBP8KwKJZv7QuDzH9TY9EPCLiNrtkaj7DD3N/l
         mf+9H0PRaNFTgphGzNeIWSs1gOTWYSqJrwj0aEq2n7GkAC9ZEB4m3QcmQsthcf7sg3fg
         F04E44UqX9dBt9+4VGhG02TMXLwRv391MIAxlyF8f191+hOMpJjxLkt65NowDWFd7cJz
         wGkkhBJ3Sa6XR2oUuJlvgI2YXC8tG19nAuhq27xF1KQya9zxdrjwFwAXWMbMwW60QWDu
         5R8Zs03oFhSqAMzMs7k5aUew72syCOXarx5NN/tyLXOcsknTCHPJ3AqIQsBwSQ8nxbAj
         +2wg==
X-Forwarded-Encrypted: i=1; AJvYcCX3jtE+LwfEpGAjyetEfwwYujIDhuI70lX6/YPDtr2PiV4W0Y8+6VUXDtErv47hz6p5z3qKtAL4tZs=@vger.kernel.org, AJvYcCXf3xEe8ZHgRe3nvUDfpMT3povU1gpvNB3MUhjXdnspYZgzeOhzsWwfXA9AsiDqCkbfkONI9E+pnHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQvhwCnQ7/er8ZYXqE+l6vLYlJk7o+RTdwrYge+Xqw7+rpHHz
	j9C/hleBBHqAELnOm4RqnxS3katZdhD81Lms+uD77aHVNflxL7Sv
X-Gm-Gg: ASbGncumNyMn5+x84yfnoxCaws4yhpl8VrvYAW+mmG20SqHlreL187U+TP03mQ/Iphi
	4MhAXWI8V8rueG/euCbTZTMTX0YhCo6NyvM2d98iUA3u+iePjLDj9rgzTbgQ8bgAdxN4AFnwlxn
	gM9OLuNx1yb7Dep00rdbW8V4gyRcVvfHzpnMaEkSSQ+dv4BtzziyJvIAHgbqnCGqYinaDpkIW3v
	XDM6XgoZNJAFBeKsHYwNT5ASuHjJkJy+DOCxOzu0dMofWoYrEysjm+OWVdS9fF/P2IkNhrnvHUm
	hPdiqNztBmk8gaI53FE1f1V1vGjcFWSdBHGB3wqwTZLoxJSyQPBGx7/kH7Jbn87rufRGn4J6e08
	KEw==
X-Google-Smtp-Source: AGHT+IGYaLVMithHh4tayLbXSSqEarmsHPwmDSJ5XBJXtsKHOtQpHNseAytZoZX7sFQkH+Jr9ISfzA==
X-Received: by 2002:a05:6808:3206:b0:402:17a8:af08 with SMTP id 5614622812f47-404c1fe061bmr4012381b6e.9.1747272200468;
        Wed, 14 May 2025 18:23:20 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40380398aecsm2626141b6e.43.2025.05.14.18.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 18:23:19 -0700 (PDT)
Message-ID: <7aedd720-c29a-4225-a79a-d44a3a9ca129@gmail.com>
Date: Wed, 14 May 2025 20:23:18 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
To: Bjorn Helgaas <helgaas@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pci@vger.kernel.org,
 Sergey Dolgov <sergey.v.dolgov@gmail.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Jian-Hong Pan <jhp@endlessos.org>, "David E. Box"
 <david.e.box@linux.intel.com>
References: <20250512210938.GA1128238@bhelgaas>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250512210938.GA1128238@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 4:09 PM, Bjorn Helgaas wrote:

>>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>  {
>>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>> @@ -866,7 +891,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>  	}
>>  
>>  	/* Save default state */
>> -	link->aspm_default = link->aspm_enabled;
>> +	link->aspm_default = pci_fixup_vmd_bridge_enable_aspm(parent) ?
>> +		PCIE_LINK_STATE_ASPM_ALL : link->aspm_enabled;
> 
> PCIE_LINK_STATE_ASPM_ALL includes PCIE_LINK_STATE_L1_2, so I think
> this potentially enables L1.2.  The L1.2 configuration depends on
> T_POWER_ON and Common_Mode_Restore_Time, which depend on electrical
> design and are not discoverable by the kernel.  See PCIe r6.0, sec
> 5.5.4:
> 
>   The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
>   to the appropriate values based on the components and AC coupling
>   capacitors used in the connection linking the two components. The
>   determination of these values is design implementation specific.

Does that apply to VMD?  As far as I know it's not an actual physical
PCIe device.

- Russell


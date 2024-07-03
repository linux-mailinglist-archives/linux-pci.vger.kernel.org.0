Return-Path: <linux-pci+bounces-9716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A60925855
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848DE1C25729
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7613D2BE;
	Wed,  3 Jul 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGzxrDxY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F8158DB8;
	Wed,  3 Jul 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002122; cv=none; b=BLhisSDzkU2ULFXo1rxIYBFCoimEQWhfzyBztZrGNcQVXvYbaxtUKgHB0DO4BY9mztvpujAIVwRr6aq2WkZPKZlK6ASS+wakC8v9YZeGlo012nTqkGEZaWooXTrOzPmYYTuJXzbRt/DUSbpow2Daaizs95RdDTY7OBJUIO/Neuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002122; c=relaxed/simple;
	bh=BG6pyqIsQJ7ar3PhfgdLc/MDWEy+inKD23oA1FF4TLE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iouDbqC7ze+E1mkxzjT8SEO43tR9kBFVTEwnI3PYwR6KZPQqB7HKFakfSWVxAWi0lZVh7f+8QQ4/8dB4RgDyOB9uYKZYNa664hhEbwpEMIaLwbJ0bJUNiGlbnj8YGhVnoWPEY2iFcM3OSWIKJLG/PGIUFYiVpSm891pbpSeXXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGzxrDxY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso8046655e87.1;
        Wed, 03 Jul 2024 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720002119; x=1720606919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MReo6r66uJpiLZptc3tRxY0kDqk43Mp6VmYAAeckypY=;
        b=dGzxrDxYnFeVPFSuZNx5odXT8TydYFn8W224OGUCvCzCMy7FNL/E8w2ZoQHzKKpkPG
         imoGaHowRJ/ucCwdNBKrZi7VsagfiKz4tbLRxwPyPRRqJh/qdXpdR2SBwjTIW/cD+DID
         omEg92ZMWisQssjTo88fHQNnV9/AW++m/emljKRG8sQ5FRbrHeK7/t8zUv+LOefY2ig4
         OisgTKafzEUzfnw7j34EisFAKKsEB6nLFvn+1tJzuj47jRtejJM6rDKyF9b85HrkZS1v
         rA0Mc6KHZyn6XTWPCU0FJKxkHHm+NxfRLLXEGF6BMZlYyv4O4QaGfxa45hlpecfClFGi
         jMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720002119; x=1720606919;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MReo6r66uJpiLZptc3tRxY0kDqk43Mp6VmYAAeckypY=;
        b=MKkC/JFyp15DykJ7EnImayh+GirTSDf7nlQHG3IFnFTbjrZcvPSyoEPCnW02YvfGq6
         riT8F14VDe+zikvhscK8hpOV18P4ic7/3WZF1DT+9hCvY+SK1EN5RytuTEVpv9eiCuH4
         HepGIpi2/HEY1WK3VDdRT7s/BNSmeN/GMz+M4KaEthtyrxvFk8OTlthGt0QIa9c4sud5
         pgFOEEUXr6s2tbv/DpInMupJu2sQwBkUG1R/I5OtxqX/tXYj74Jzb+eyKIRXS1C5xQV6
         6W8Qoz0BnrvqEyh6PcHnvJ96qrkXqs/jHeZlcH5XakH3dOIVuXLv1/QREQ8WEaSOxNVG
         Ve6A==
X-Forwarded-Encrypted: i=1; AJvYcCUmg28fdKHy/R1Pglbvl6CpuYq57RULJcKHqpIgtW4rqXT07+lZkJr8R61hylrvWFhrXcjkMtjl+GVJJu+ZLmOmUD0XfIHL8C3tCQPQhJA/iaIhQF0FpM4GUjqlqoEhhuQqBjqfiQoAfI4BlPw=
X-Gm-Message-State: AOJu0Ywp8NCC99lj7wrqhh1M8wOGlGusvhentSjnwrQdQQr5xSLB8d6P
	OmOQhwMbA0XdH3isHd+cHsTO5D07ECP9eeH2j7a8yaQPKET873xYS0mwHw==
X-Google-Smtp-Source: AGHT+IEsxbO15eF7K7h4tSoYQYzueDr+Dq8jKwB4fvxiKgkbI/BVo+j67zzi6gsHagwIycqHqRcMOg==
X-Received: by 2002:a05:6512:3d1d:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-52e8270ea83mr8828985e87.47.1720002118609;
        Wed, 03 Jul 2024 03:21:58 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.74.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0b840sm2096998e87.11.2024.07.03.03.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:21:58 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar-gen4: Add a document about the firmware
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, mani@kernel.org
Cc: marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ed614880-e765-5048-cc6b-c5ecfb156aec@gmail.com>
Date: Wed, 3 Jul 2024 13:21:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

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


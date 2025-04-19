Return-Path: <linux-pci+bounces-26262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FFA941A3
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 06:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A7E19E3587
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 05:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398215665C;
	Sat, 19 Apr 2025 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7qChYoi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC397155A25
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745038788; cv=none; b=C6CuVHrtB6OlarREn5e9yHujlTGhzGOxoPpMliXry/CHiXsHXmfaMQF3RMgvQfTHck4jJk8G7g+7b1p8SruQ42FXsNjpmeFsn8IZP71P/OClZ9GqHO4iaSTVul0OHf0Tx/qRaVHwBV+q3jpeQQa6TAVTPET4W3widmagio3vr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745038788; c=relaxed/simple;
	bh=rELaedUTMmsX4x20wC07unznqtRhhrjYkGFM0XQmwBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ86XwtStKgrKE/10x/JDMRbEK9uWx4QEE0YYUjakERAmzhDZNAVcV3AlfRJtkirQ+yOkQprPWdUdWO+4zkqa1iH7EAFern+6SCPnQX1/S0a0Mc1R6/nd9nwh++pTIGi6wTLrClCSY1vBHzZi3CFrgfHu5A/feNtLFel53OcvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7qChYoi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225df540edcso36855585ad.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745038785; x=1745643585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ihPmYZAOi9Wr0993N5yd6czP2sDWJGDp5YbRtZuyqK0=;
        b=g7qChYoiAxeaj7XrX3v1lPC65asflLnUR/PyzP2QzDSPtZ2dyfAa3sXPWXpgqEpu7n
         NF6Qg82Hh4tpqL0U7RxZTcjHKaI6h7suV5PGB3rkIUgliXSJsHjBJEZK+gHCFRoitneO
         8E6k2QzZq7olTxgJJFbqsf1aZQ3iiQt7HtKmR4yVmaqW0GgwHA9hM3KVgxrKLIHh1FKw
         3vZflWJgntugBPIMDRqjZE1gNI1JvRsxvwhxJBvRsSUZLxvDu1uWf7OTwmobRHk1kT6m
         zyzyLdOgpuaUvKnbKNGZ3cGS3mvsQXHi4UejGlLWisNDFBbrgJ7Mk3S2GNn+wBj+mVyK
         l2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745038785; x=1745643585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihPmYZAOi9Wr0993N5yd6czP2sDWJGDp5YbRtZuyqK0=;
        b=I86WTTyADByn9eDLj3GlmjLheAjcnZgroalkjlx3po/78+Ax5QVN9MXZoCnmqX3Wsj
         CHAI3NkA/JkZAc0EJX1Zp31J3HTSuJz90Xh6FATK1VjUpFfUlkyBlnworwNgU7x6GK5l
         XkbAW8ekyhyE+Y5F4MunCmldRIhjJCgVrv9KpknG8mIaJVz+dt6F4oINlMNxxPL7Gqx/
         f+JqLzZyIiv86K+Upq3fj/vitQFVqSZhl64eZaNutQmnMd4/hEhNgMB8U2blx6QG9O2R
         qD7730AxWyS+QMKQHyTmqNxx9yZLwdF1wm9ovNVvam300ofNnBUzAR/E0O7VwiWcvH0B
         JrMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZzjvmM0eEBEP796dwv6v3Jrcjy3OmdpXmROIaosjSQ8+cWDLyLdquFKUbg1ltLrIYohazfVAsj2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17GE3lN8HoaaQPMaXTUCKpy3ojwgrAyz43R6NgxDB4uN0unbs
	bIQYz36+s5BTLHv5UpOZfMAFJud0rSL/ztDrXjrMJFdbptsSKCcdIoXLAnX8874IqhW9rJOLW5g
	=
X-Gm-Gg: ASbGncslJXVk+G5qf/tER3emf2YwaUcz451h4ALXXq6pP4U59qjLCAqdHMqVAhY/cxI
	LjDyixnxJtwH7hp8WpDlbU/yMFoEFn77fzg+Py+VrOcUewsloEPjdq9XCsvI6h9En2IrcmDnkDH
	VSFx0W/23a3oZYeskJNz4UJUqNu7fLE1QuDm58482HJApgcb3Iruvl1+7NhdXG3sUYBChOgvDfh
	JUg8rSbfScqsszrE3z7D1LxMEegyTRkrVoO2jHfeWvlC6RF5t96lf4iNKU9s9Vf8ADV8idYYGUi
	8WWXBfAk1QxSXcnYJKffyYPOMB9VSC7ST4U+OtJeM2S/tW3FEL6I3HWQiqKXHcI=
X-Google-Smtp-Source: AGHT+IFVLt77v5MR/5+JKL88xzJjihXXNgo0TxPnZRMphGmJ1FoBgkTERqtO4oCTLca1G9+jsQnRsg==
X-Received: by 2002:a17:902:f644:b0:224:7a4:b31 with SMTP id d9443c01a7336-22c53e38f33mr60733105ad.6.1745038785095;
        Fri, 18 Apr 2025 21:59:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb97esm25276245ad.219.2025.04.18.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 21:59:44 -0700 (PDT)
Date: Sat, 19 Apr 2025 10:29:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: bhelgaas@google.com, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add a document about the firmware
Message-ID: <xkcifbp4f5ql3luxzsdvkjomhxiqzmcorkbjv2wtq36rsfgbgy@xnilxquk3arf>
References: <20241024120525.291885-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024120525.291885-1-yoshihiro.shimoda.uh@renesas.com>

On Thu, Oct 24, 2024 at 09:05:25PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. So, add a document about the firmware
> how to get.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Changes from v2:
> https://lore.kernel.org/linux-pci/20240703102937.1403905-1-yoshihiro.shimoda.uh@renesas.com/
>  - Rebase on v6.12-rc1.
>  - Move the document file on Documentation/PCI/.
>  - Add SPDX-License-Identifier.
> 
> Changes from v1:
> https://lore.kernel.org/linux-pci/20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com/
>  - Fix typos in both the commit description and the document.
> 
>  
>  Documentation/PCI/rcar-pcie-firmware.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/PCI/rcar-pcie-firmware.rst
> 
> diff --git a/Documentation/PCI/rcar-pcie-firmware.rst b/Documentation/PCI/rcar-pcie-firmware.rst
> new file mode 100644
> index 000000000000..0d8a87ce9aa9
> --- /dev/null
> +++ b/Documentation/PCI/rcar-pcie-firmware.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================================
> +Firmware of PCIe controller for Renesas R-Car V4H
> +=================================================
> +
> +Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
> +firmware downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"
> +is available in the datasheet as a text file. But, Renesas is not able to
> +distribute the firmware freely. So, we require converting the text file to

s/we require converting/it is required to convert

> +a binary before the driver runs by using the following script:
> +

Please add the location info where the firmware has to be placed.

Also, add this file to the "PCI DRIVER FOR RENESAS R-CAR" MAINTAINERS entry.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


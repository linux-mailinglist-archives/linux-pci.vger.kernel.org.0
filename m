Return-Path: <linux-pci+bounces-38004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51165BD71EC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 04:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68214EC27F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC07255F22;
	Tue, 14 Oct 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryx0Sqr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838230649B
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409979; cv=none; b=MirmO1pUKRbaE1efuo+0GP9JutktxARYOcYpebxWN41tAkTzToG63lsXCz2+dlXTp2yMrHTASIf6q94oAWy5Wa5Kt1HlC2vLJ6YqT3i4zr0BN9dUmu6KDZ1E1LM3JH5eIa246+/IfbC/gYyAHm11XRQ4zPjJVmWbcDdreG1CQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409979; c=relaxed/simple;
	bh=VjlKnt+fZVo3N7p1DHHgkMdCCLtNZYHYXQ6W4bXDUr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhnaMIPUSYn6W6Jmrp7rqeqEldfTJ+edWO204oIY+uQFTPAmCK7Ge2Zter91josfQyx0a21l0dnU8O9R3GBQtwoUBaV+rLtReGHWDs77F1uFNdwIeawJBGBD4yTW3fTR5jVKmGBii/THYb5QiKMnOAgzadIqA5Sz6mQHHAaCDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryx0Sqr+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so4275132a91.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760409977; x=1761014777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrmu7grANyWKY0RDn5IlCKkm9AdM4oT1qjUuGdu3tUk=;
        b=Ryx0Sqr+KRTBzMMVkoD1zJ5tgCjeoW4CYfUQ4v2m5VfTWUq0kcsB0RjvOFYL3yRB8b
         YgIY4i3MtZXJBymkodA8zWZmIHYVJKVZG62MPMBCH27RPFWn/8LZeYpB0bd9lNUeycTd
         q2oG16qMy2uK2FIb1YsA0V0XzIbWGlHE2SDzdKbkSBKBHqULcsnhyHfat57ru9OJS8eq
         QnDDhGx/+QIps89zXopYgVN6nGed4HvIV/jhOCLlAn6iuUOko42Vzkk9jn5gAqSITnIw
         hyKTVMTEMxGxYpEyjw3hAJUnBhB9i8NWy7J2mR1rGKLRbUcsqN7Uj6zHO4bj7XuH1PX+
         yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409977; x=1761014777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrmu7grANyWKY0RDn5IlCKkm9AdM4oT1qjUuGdu3tUk=;
        b=ZuShm9Hc3hTB6z/65s2vWYicnPUniCgR+ormOaSc/J0XvsyJvANDhu2QLvZLXJhO0E
         /ca7jnzM6CvmKCoKXK374C+Ma7oZCllgcFtqNkwlMIpFrmFrMdACcr/g1iXBV79SQVPa
         yvbtdhbt+U/vT4F5xavx+PVkjIqQToc9i1QvMLCge+Cr0jcS2MRFbUtvFeHsPYKa5NOx
         ATXoKWwRxRH2qGJQUpzqLgmpcY75shJkWCB4kVMa/aD7wESZIQoJf9e/YzfykSp4wJi2
         n55ZHPz+pJFH/smcxi8FvklomlZDsEr1PPVxo+VKCSul7E9U6a7CrhOHhLKSdteQCCQE
         V/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW2V2S3u1r5lOCy0dM85xMseSVHdXyGHX9RuFx8v9/aBQR6YNZqepGCDOJNLW41FEffrJkYe2I1DZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKr9tZ5tDv2Vw8i700fNcL8LJpjhxpfIGs7XtdENOM9WUcGyH
	1d149gOv/1KDUUUQuSg17VVw2XJPw1dCm8U59ZhR1jp1PAGOxRB91tBw
X-Gm-Gg: ASbGncv6ty9mTd2yuAc6Ydly/ZDgPSBJvKC/MrsFYN3nyys/V3uWwxgaPRa2qK/hHIq
	IGL0zU1eKGIFzP7yyzwKkES9V/Gz7CaUZ1YDf9UCBFPEHKG2vLw8RNYxYIuIyrsb8YFqvpiajWu
	xl0YGiKDAQqm3gXCVUmzzR2X2k17hN/YdY9ME97dV1XbSvJNnyMp0S0NFnN7Aj3SI17SKTjpt+1
	wiWpu+u85O1Ow5IIL45T2cnvn2wQIwe7V9qzAoE8Qf5PX357Ctjhvpg5S2AjGqLB8XjRGPVU3oX
	0h/r6sqO4QyIirSVq3nEW75TqnTOYig1Nxx+8CvHXfgaFkrpkLepzKF1mzcdrzBVL1XV9Eenomx
	RQ/3nF41LTndH0XUErkbWLpsHUvuugbfzzawsq79r2yl0i4ul5Z/q955GWpnwbPQnM4LaGpDLFt
	FtHw==
X-Google-Smtp-Source: AGHT+IEDL3uz9npcqeh6sedCwhV/tcZU3zwDosN41rb17ZNPeKEi9HTfTRTJU5kAj/2Llv6h5Ylzng==
X-Received: by 2002:a17:90b:180d:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33b5137586emr32921823a91.23.1760409977067;
        Mon, 13 Oct 2025 19:46:17 -0700 (PDT)
Received: from [10.0.2.15] ([152.57.140.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm14208195a91.3.2025.10.13.19.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:46:16 -0700 (PDT)
Message-ID: <097fcbe3-2433-4010-a247-6e1960ca15ac@gmail.com>
Date: Tue, 14 Oct 2025 08:16:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
 dlemoal@kernel.org, christian.bruel@foss.st.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013214033.GA865945@bhelgaas>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251013214033.GA865945@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/25 03:10, Bjorn Helgaas wrote:
> Thanks for the fix!  It looks like you posted it during the v6.18
> merge window, so it was a little bit too late to be included in the
> v6.18 changes, but it looks like good v6.19 material.
> 
> Can you please:
> 
>   - Rebase to pci/main (v6.18-rc1)
>   - Add a space before each "("
>   - Remove the timestamps because they're unnecessary distraction
>   - Add "()" after function names in commit log
>   - s/irq/IRQ/
>   - Rewrap the commit log to fit in 75 columns
>   - Rewrap the code below to fit in 78 columns because most of the
>     rest of the file does
>   - Carry Niklas' Reviewed-by when you post the v3
> 

Hi,

Thanks for the helpful review. I sent a v3 patch to address above review points.

Link to v3: https://lore.kernel.org/all/20251014024109.42287-1-bhanuseshukumar@gmail.com/

Regards,
Bhanu Seshu Kumar Valluri



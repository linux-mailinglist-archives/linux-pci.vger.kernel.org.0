Return-Path: <linux-pci+bounces-28864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A5ACCA18
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D29A3A4346
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D323BCFD;
	Tue,  3 Jun 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXc9I7UM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090A70838
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964336; cv=none; b=uNDj2VNDWxetEfGLnbaM8q2XCtI3cUo4LFQCL5Xw6hp8lHXKZ22VhUOLuVoJmfloq/OYXABP6PbdI/ES1jGuN3ONWEvrBVlhDXX63hBGCTBxvnpGHo4q+8Ew27+ulZBeNCG/nh8P/F5kF+jImyYlVexm87EIVRTezuwm1q3R7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964336; c=relaxed/simple;
	bh=GRF3f1LYqvxYkJuZ98Z2f/j5mjNLlD7tN5Zlj+pTDSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN2ztAZduhYgZR25cJIo2VZf/WrlrEPk8lP9O4NYhYZZJsFhTtGmzg7AGYV7uraPxx9Ez/tuZH8esrFd5CLW63V4yRMfnsEnNWGvyCrRjZUKi/ZYghEY/RWivNeMZvysUJbbzNDxnHyj1XjAS2Xmh5yhi+b7fSiIvFA8fuUy6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXc9I7UM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad89ee255easo1050421266b.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748964333; x=1749569133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wW03XFrUSVeu8mwtKJy+rZxza/kHZKA3kHeUE/Zbf4=;
        b=IXc9I7UMGwULlXle4M1pHakGg2RCwwWylEH3t2tt6wqaKqt+LTEO6cm8+TTTM2dmtm
         lnaF6EjQqG8MVKlVcF5pJEJ0kbkkxkWi+TOVG4zweb390Zrvi/u3B7tapRJxBdEzF0yD
         HeprDxYaYMjwtRtY5j5Fqtb4eHTM7hmjrRGamIasjzTzIl0X69n/quNKWYMCqAhVrPAA
         bY7CGAB0FB/lH8dpAnfoBnuYlzSByVgv111+cMhK0XEmCQk56olnzPpNi5PO1heyQbDq
         2J9AM8FQ+C81jRkePJEYo6Ex/1e0izqLO9IE391WnM/p7WElcOfA9/qtNbXrITmcmRwt
         dBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748964333; x=1749569133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wW03XFrUSVeu8mwtKJy+rZxza/kHZKA3kHeUE/Zbf4=;
        b=iECx/O72BU4aFSIvIdeIUCqG1YjCputOYMwN5rp/Hs1cHOb+G7JVujWT4RToyy6WFQ
         wxvvc7TvWgyRa67VVEDo8o/UMwjgFhAUTH2wfVqYczOW7qe8EfgaIrNSYnT9cR2hEsXs
         W95d2532VdIfgtMQpDJNbQxiOFuMi17W7CmZrozuo6MBKKaugfvVUvUzoKNnoEE/ZhND
         2JkQqPOR4Pfbts8OA3VlkTzYJEjW+7LCn7uW8fhaoTvKLUUmmr56MYJq5dByxbXPUPiF
         zJr7Nebz6gYbn0A/48CRlIlSO4hO86rThdgjL3SUCagRNyVPDsMzIjtvCUzg3AB5HcJX
         ekzg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Neud12SsIX2IQC12k9Gg5wdeYr7QLEME+p+Z5brvCw4e74VTKd/wvIHvdryX+LI9FhcV8MjpfWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOwOXbcC381dufw7mXv2k5gXIUfsHRcRZ0slGwtQODFMA5J9F
	O2XNSBeurdYDPCdX8N82pwxTTZNubZiOql8wVhVlFf4J6qXsEHtbRT35Nk6ai5ZCeyA=
X-Gm-Gg: ASbGnctpNRqIyx3PsM6idp/pE8G5AE79vWpKk91QGOjvCCR1A0pUlOWhgz2XssaIOxE
	xjx6upPFvSUaXvI+vqrf0buFt5svv3Czp//2NGhto8Mmc0tULie9GB3KWCC5lIBrPJLipvn7mD1
	NgLsASQfp9PQXrhJeRzN4WWxm3SGrjmlAVFSimyq9Y4KtfbdBhyBRF7hnO2aTv8z6KfRp8mnxIL
	FmmYAJIicfFuXM4WkisWbTkwSuCUeW/67EnbuRB+sjxMVH5IJ86Tb9CKwOQNG/f1y159VyNddVa
	iXtzrD4oHTdJhKvyo16xVz+46WgsqRrR3i+CZpeEfLFwKLzIfwV7a+2h8nW3
X-Google-Smtp-Source: AGHT+IENJ5hA+onG71OWUo/WB8VWtaRrN2gxUzJbh00nrZECX8zCpqavdRYFahZC7MMqM6VHbK/Bgw==
X-Received: by 2002:a17:906:f58c:b0:ad8:9041:7706 with SMTP id a640c23a62f3a-adb36c18b0emr1655179266b.56.1748964332581;
        Tue, 03 Jun 2025 08:25:32 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-added7edf9asm51930166b.152.2025.06.03.08.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 08:25:31 -0700 (PDT)
Message-ID: <bd579412-d07c-476d-8932-55c1f69adc9f@linaro.org>
Date: Tue, 3 Jun 2025 16:25:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
 <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
 <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
 <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com>
 <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
 <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
 <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com>
 <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
 <fc611a93-1f5f-a86d-f3ca-cb737ed5fa4a@linux.intel.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <fc611a93-1f5f-a86d-f3ca-cb737ed5fa4a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/3/25 3:13 PM, Ilpo Järvinen wrote:
> On Tue, 3 Jun 2025, Tudor Ambarus wrote:
>> On 6/3/25 9:13 AM, Ilpo Järvinen wrote:
>>> So please test if this patch solves your problem:
>>
>> It fails in a different way, the bridge window resource never gets
>> assigned with the proposed patch.
> 
> Is that a failure? I was expecting that to occur. It didn't assign 
> any resources into that bridge window.

It leads to a watchdog interrupt on my pixel6. Last print I see on my
console is related to the modem booting status. My wild guess is that
that modem accesses something from the unassigned bridge window.

In the working case I see the bridge window printed:
[   15.457310][ T1083] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14:
tmp rsc : [mem 0x40000000-0x401fffff]

[   15.457683][ T1083] cpif: s51xx_pcie_probe: Set Doorbell register
address.

In the failing case I see:
[   15.623270][ T1113] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14:
tmp rsc : [??? 0x00000000 flags 0x0]

[   15.623638][ T1113] cpif: s51xx_pcie_probe: Set Doorbell register
address.
> 
> If there's nothing to be assigned into the bridge window, the bridge 
> window itself is not created, that is the expected behavior (working as 
> designed). So you're comparing to the bridge window that was made too 
> large due to the disparity (and left unused, AFAICT).
> 
> It would be possible to put the condition inside the block which adds 
> the resource to the realloc_head, I initially put it there but then 
> decided to remove the disparity completely because why keep it if no 
> resource is going to be placed into the bridge window.
> 
Thanks for the educative answers.

> What's that class 0 device anyway? Why it has class 0?
>
I don't know yet, it's the first time I'm dealing with a PCI driver. Any
idea where is the class typically assigned?

>> With the patch applied: https://termbin.com/h3w0
>> With the blamed commit reverted: https://termbin.com/3rh6
> 



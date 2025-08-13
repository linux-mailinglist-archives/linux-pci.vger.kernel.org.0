Return-Path: <linux-pci+bounces-33992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A48B2553E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B41C5C11EC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CC303C8A;
	Wed, 13 Aug 2025 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="scy86vsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40492EB5CA
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120091; cv=none; b=Md6HJQ3pXOEz0VJWWxSJ3qWXUEi56muMa5INCbHU20AQhCK5Vqos2LXVmOnReHHrqWoZDlch4Ha50Bo60HeOQm1vNrfAzDYPK75C2F5Y2TYct+ey5glE6Sx0yjxpfY5N+nQ6KLHq+RQkUABNlY6unpUKNuW6A8T40IKfEmlUr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120091; c=relaxed/simple;
	bh=YRF7PXYqA5mGk0XIeuHC4a/zpxBzNwCOY5dVKL1K3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPK+TINskfdzkAaSKTxmtE3cuSBM8TY6QAvxvgIkSb0+WPQZIInHuExjdSaPud9GZ1d3HyOZMxt0sHi8yIDekuvjPgeCFR9vFhY+1qpnMooowhUtxMoT4mox8ofEUJBE9lC1sHbJ7JKOC9GgmOEA0JzS49uZ5HiSEtPEirJdfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=scy86vsP; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e571d400e0so462355ab.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755120089; x=1755724889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQFA3sAGjQq+4OU7ujcZ9yGUOwCjhbmi0pcUP6tFJ2k=;
        b=scy86vsPNOx7G+VU/Q3Y7dhjM2zIKjB5bzPRtNuHQ0/vCm2rHg/M0HyaGMf8AmO2nR
         a2q4/8Cg79H3WNksAohV08r5iKTHNPcBcKl+kNlJWvIrcM5AfxVOJzWjy7g0tQpG7xIh
         IeX/BshpEHnOU9Vel2jopuFPYIcBZOskbNdMChTDPIJ+4Akhe7TRZ0CX7/YYNC2bkq60
         z8HWAwnszbIxAQ1jkeJjt00T4VMGntwXN9yHSq197rQ1/mpjrbsaRqyfYtSlDrjW83Kr
         4eOC+ezNlM7VZjqyz3FHyfZ2wnCcUoPNeL4cEQaNdeCZ2I2GPejgRQvHp3/fZWnV1i7f
         +TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120089; x=1755724889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQFA3sAGjQq+4OU7ujcZ9yGUOwCjhbmi0pcUP6tFJ2k=;
        b=gHiOSxPj7+TJWSNVePxzLia1u0FscXKWt/lBh6/T0fW9QaBviQ64WDgUYZUgd++2rW
         8Wxlr/g+cWjThF2kUhjsRP2FFrRTHJZHYK7MxsulvZJ2S1Qc5S/WA4EF0GI1ZIu8J6VL
         aU12cKqq65+FyWYv5etHgFwFkb9oIIJPuCsMN1/hw7qyb9jVdCc6K6Uq8VLI2IavkfnU
         juZYrsSJIVwxfMR3EZtEPklJbgCo69j675/QohHKFzC8bp0eBKUcNf8VHJziStHp9cRP
         ll+AWZw1RpQvbSrW48T8jikI75JofPBuM782xXrRaJb7fUPcf0uTReof2IU3ZBgYnpjh
         NIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwy23Seq6xXSkNouewE1zG2YOa0b9Z4RNdmLMcZ3sCnBYkE4iqgSR/QBPIFEBsvmy1rZOiuIYdX9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyC8BJzupi8RHHTZNP3u6A7grTGlfjmJs9ojyC5attCS0qx5Z
	lb0ATHkHctRcjj0CNfe76BfBHjkUYSo2u1E5ladIkNydBktzso2a3EBBFIQO6qfk4To=
X-Gm-Gg: ASbGnct6Sx9IWKPQEnaUfyHk/0XB2+8AYHXLmcRANsaBh1/88Kb4MI/qicTG2S+IH6o
	3t95FJfFBDX69SmN0QRckRtZlBaXWvodJG2kjGGdwHCyYfOgqPsQWECGscdEeJavEjq2ow0hDjO
	JyHhnH9X92GgpUAUmTs+JxVxBjQ/wg4yja2BKZEDQEdBebRsNnSw6CINWhfezALKh+7NTWY4UaC
	ZwfvOIbLxmvGvsJbpBjBKiZ+U6PpVJDLNSpHEVUNN7mSLhZ8PDgBCYqO/AOm0q/ox6x84rqxPka
	QtPfFx8GQuGqzVIdJaP4jHT9wFngdjZO7BZCQtHjSf7OPAqXJoIeKDSW9+mDzb51Wnw9MDdvbpi
	NhhK6ZrBlFqXOFYpy3xrO763z7IIpyHL95FaS6wlqC+GM/nzwaocHVPbKj/Qto6M1a1AmpUrZ
X-Google-Smtp-Source: AGHT+IE/IGDUbFdQagnAGSx2I8HtgwdLHjigGbzbwJHyQIwj+Wi68+UGSe/1cR20+rAO3AtGn9HtGg==
X-Received: by 2002:a05:6e02:1c0e:b0:3e5:4351:ad0a with SMTP id e9e14a558f8ab-3e57078c28amr12232635ab.7.1755120085109;
        Wed, 13 Aug 2025 14:21:25 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5418db19csm46937395ab.2.2025.08.13.14.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:21:24 -0700 (PDT)
Message-ID: <8ebc466c-1b9f-4ba3-a38e-bda6007c5b97@riscstar.com>
Date: Wed, 13 Aug 2025 16:21:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, quic_schintav@quicinc.com,
 devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, inochiama@gmail.com,
 fan.ni@samsung.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 palmer@dabbelt.com, paul.walmsley@sifive.com, spacemit@lists.linux.dev,
 thippeswamy.havalige@amd.com, namcao@linutronix.de,
 linux-pci@vger.kernel.org, shradha.t@samsung.com, vkoul@kernel.org,
 dlan@gentoo.org, johan+linaro@kernel.org, kishon@kernel.org,
 mani@kernel.org, mayank.rana@oss.qualcomm.com, tglx@linutronix.de,
 bhelgaas@google.com, linux-phy@lists.infradead.org, kwilczynski@kernel.org,
 linux-riscv@lists.infradead.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
 <175511815210.798605.10564052572461813362.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <175511815210.798605.10564052572461813362.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 3:49 PM, Rob Herring (Arm) wrote:
> 
> On Wed, 13 Aug 2025 13:46:57 -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:

Mine didn't for some reason, so I must be doing something wrong.

Simple inspection shows my compatible string contains ".yaml"!

I'll fix in a new version.  Sorry I missed this.

					-Alex

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.example.dtb: /example-0/pcie@ca000000: failed to match any schema with compatible: ['spacemit,k1-pcie-rc']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813184701.2444372-4-elder@riscstar.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 



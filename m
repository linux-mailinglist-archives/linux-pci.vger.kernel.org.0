Return-Path: <linux-pci+bounces-28239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEBABFDE2
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B42500886
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B0A235C01;
	Wed, 21 May 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzUGgg6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BE17C21B;
	Wed, 21 May 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859333; cv=none; b=PRLZmyl5WlYEOBz1jytSH9cQPX6TetZSlObC628vloiGtcj5Cd931pxalFJD66sFpLkjDbHakUjuYzhoHyv1FNYfMGNZrSFTDZGVuBJJDTkN3ZEym4KCtfMUs4skWOVVqmFPvER68wos3OilIgFcibY7WROeQcSnFc3EMGrKx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859333; c=relaxed/simple;
	bh=emj1QkBXxk59N+kmDmKagPwC7QxiPRcugktEshhzMEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFSEHWBoPvZXOEDQ59kVv384Mh2UWWOBLpJkOytA9pzjca3i89FuIFLVWrDhjIQm8yWwM45I1+reXacvIQ2KeKluVde1CyXbPxcyhxMEu/Vb8G62SyCDWhLVYTvNmLjrGtJyw/KDP3Q9gNXTDTCfwF2cElUwA8/f2qqhgKaBr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzUGgg6h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441c99459e9so47668425e9.3;
        Wed, 21 May 2025 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859330; x=1748464130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emj1QkBXxk59N+kmDmKagPwC7QxiPRcugktEshhzMEE=;
        b=OzUGgg6hitvKAtMecS3RZOftg58k/yNzDOX+wLnYiWM3o/LqqaB1G9Y9xx3ICP7wLA
         6XQQX/X3GNMD0e0Rz4QVMBOf0LlAe6UGKtQS8tB9b92oiy2EKzv03FsvRwvt+UwtQ9lL
         rqorrGFZK5i1hIcpIxT/PXO3iUx52FHrHxEvF4AscVr6zxfJffeJGhIALH4T5+ABPeo1
         2XxJKAQ7+acSQceQhtmAFDqx9V/X05fB/O7iReXecOYXkXNqCm/upL7HEK6uZKe9bNLl
         +yxaqre/bQhUEWr+3oaSLsUEz9OpzdAkyFHDyL0IUbcVPOB9cp7GUHmLWFyqOAIi08Ve
         EOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859330; x=1748464130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emj1QkBXxk59N+kmDmKagPwC7QxiPRcugktEshhzMEE=;
        b=sg+Awhv24OD5Cql3NrOjygswOckPfeM1ONXApwZRNLPMrBzhUin2A69E6Lok5HCfc0
         nGnIWVrUVK7UDZqBlU307k4CzsiYGFP0L5ujgALF1r8zablpA+6V5WN9+ZKDrBx2nj8A
         UMs3KvGhoJXyovJsdBq58Z1GhwvgveNvVbi1be0C6d+x3Bzd8cTrqLgttooQ9Ho5yC00
         oYtDsiH18f963kqTFHZoP/AvlIdervwq2vine8+LPfkmH/edssp0XM/GvjIizRzexEbi
         50YzIms7lWf1PyWlFTeQd7jBubjsgzg+au7jVok5GS7SaEJ6mow6fH7b60VE95wMwsne
         BjuA==
X-Forwarded-Encrypted: i=1; AJvYcCUI4gOHeD+rlCQ/SpZ9ld2ceRQsEGo/IeLwVAi036KkIimXyNk7ITjoqmcOKXEiJaDfS/Q3W+BmKuwn@vger.kernel.org, AJvYcCV1yq5ASOl1yTRLp51cBCLhe5Bf8vf/VZtpbbTpMcxz+uiUER35PCWgAqciBox1u6Aibqdl1BGpza4+syo=@vger.kernel.org, AJvYcCWVLqn+I0QaXCmE5rEQDxzEzcn3Zp550EUv/RCMTiQCrR/co7cDsYIEZhY9Gt5fECE3tum9L5w+h1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypR1QUK+Py9CGV0YTN3Vql1mwYHhdS1k8mQP91bgV2w/8ofZK8
	9CokoknlkuEUzC+jkp+sRoOB7sIiCYChSFBBO5z9PHvDGkrzgAYKQYd3
X-Gm-Gg: ASbGncs9piIr/Kfo1lzSdevUR3V1q8X1GgyjiuRDI/gMCiQmMNhk2ILO/eRaGg86QNn
	JSzkx4+WyoB7TYys6hZaHz+O5dG+8MSZb3yLeYaehM1pLL7cqX9dHNtxDhR3X3CX1HBgtszM+HP
	kHOckBK35fCRtKiW7ye6sOBOxTdga8QYUPReiQeWDHqyEGKa7VFk+XaPODBcE7Fl6qxkOqjigMR
	A68URddG7AqvCkzLwAC4hw3Yyek3Sqpi5399YV++6B93Stg2wFeuXkdP52FQ8TbFcgS214+/m8q
	D5BNQf9ajEw45fge4oz9JeZ5cKy1KQu6EHPeaFkV8aSFiFDWy7ujmNg5HiLq8eM=
X-Google-Smtp-Source: AGHT+IGlBgb9+nS2HRQKd1xvjXWBYF19sDDsydhX3RFEzO0e3tXlwcOFrfv7qcb/4A19UB7h1QMvww==
X-Received: by 2002:a05:600c:3588:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-442fd67861amr230755065e9.31.1747859329776;
        Wed, 21 May 2025 13:28:49 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm82810435e9.19.2025.05.21.13.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 13:28:49 -0700 (PDT)
Message-ID: <442887ac-d53c-4a89-8916-e7c8b1f2e6a8@gmail.com>
Date: Wed, 21 May 2025 22:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Mario Limonciello <superm1@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 aravind.iddamsetty@linux.intel.com
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com> <aC3XiuOPVYB2EX18@wunner.de>
 <6bddf9bb-0c57-4823-bef1-e5bdf16ef5f7@kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <6bddf9bb-0c57-4823-bef1-e5bdf16ef5f7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/21/25 19:06, Mario Limonciello wrote:
> On 5/21/25 08:39, Lukas Wunner wrote:
>> On Tue, May 20, 2025 at 07:22:04PM +0200, Denis Benato wrote:
>>> This is the very same exact kernel, minus the patch in question:
>>> https://pastebin.com/rwMYgG7C
>>>
>>> Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
>>
>> This log excerpt shows that the ASMedia Thunderbolt controller
>> below the Intel Thunderbolt controller couldn't be enumerated
>> on boot:
>>
>> mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: broken device, retraining non-functional downstream link at 2.5GT/s
>> mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: retraining failed
>>
>> However, the Thunderbolt tunnel goes up and the devices are
>> enumerated 24 seconds later:
>>
>> mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Card present
>> mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Link Up
>>
>> Thanks,
>>
>> Lukas
>
> Are you suggesting that the training failure is why there was an error?
>
> If so maybe that should be cleared when it does eventually train.
Oftentimes the gpu is not initialized when I boot my laptop: in that dmesg I posted I detached it and re-plugged when I saw displays not lighting up.

Using the patch proposed here the gpu is always there, that's why you don't see the same in the two dmesg in that regard.

Also another reason I want this patch to work.


Return-Path: <linux-pci+bounces-42720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87203CAA639
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31E2C300EDF1
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A242F548C;
	Sat,  6 Dec 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HBebihtm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0332D979B
	for <linux-pci@vger.kernel.org>; Sat,  6 Dec 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024685; cv=none; b=PfLpewX1EReo0B7QcRM8DAiCMUUKc+pgclDahNoO/g2P7akKv1B5ZUuFMTwWfqRobWr2Bn1azY04kRXEnBDWCLpD9SDA8kNM/GiLOubiLT3F2DHoSgoJUXr0fatACVFSRpDdDlO20wrVYZcMUg1A4lvTrkGue3ojJxlBMUTPnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024685; c=relaxed/simple;
	bh=dQnyqDL2E6KxQw5j/cho2jt9A1HkjdETEU5NRTOj/WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsC7zF7TEL8kFmKbnaSaceygO5PLDUfwGTShY00aNd3WBDc+xR+yPsZbtoHAHBYAnmT4LSBP3G9494HkzL9QisQuxRE2p8VWU/DjhUwcdPuWew106LZZBH7Sh2HEW1wrFHyheA25+4zwFRbb/7f4ULOe1hx6SwGRpYrTzOliby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HBebihtm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso15649105e9.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Dec 2025 04:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765024681; x=1765629481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIhBd1LCJj7xifV0MwkBjxJ1HTu8zyeSnrj0t6qAKpo=;
        b=HBebihtmh99pNLvZ02Bz44OY8b3o54Fq3S8BxE1+VoqBIpayrMv9z8OXvewl/Jo5Wb
         jUqqRiItImsROBuKcU2d1JHpGnlRRuhPE/YV94tPqMeemVgPfihNXwdEI+/8OBHS8SUN
         BCwk5BZ26mfmU8ThtAz/i1Eal9/G1yH5GVOnr5zC8ruK9KXVnb4CfYivWp78zKWet1ww
         YZJoDOyOxROlgGpFLX31almNqeP2bR7OM09FpO6zl8GWlTupOHTMH57OUb+EDCrhDTyp
         rGroJwxmt6aeHC/AQIE0Ty/KFjT0V6G7zoqLQdTOE6EDLslWXKMTUhhhDx5o6Dpegcn3
         h/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765024681; x=1765629481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIhBd1LCJj7xifV0MwkBjxJ1HTu8zyeSnrj0t6qAKpo=;
        b=pLKzg6Ibz2DNXIqEyO0JYQtsphOYf0tGbpSAMMFkyHH2T+lJeJhjBAeoH4FXhl8cCr
         U7HSOqOvaDIqudRBlGqyN2tQAgulWGpTmUG4LnmQBG9HtophNkXPyHPpHXaHS26rgjaw
         kle3+EfQzWgpqK7Ad0BGTyZE6KbqcvguGbOpovzWdeuqQqc2gj4O235nhJci0ErXx7V4
         AnAQO4B8XoFrmoFULkP15Q53kSz2CKdjPEifPjFcVGSw0GEVI3q6VBYuUcw/4ZFfIw6S
         pNwZlmKjN/lDUWJRpQd/eVk7JyW2+r6NKrVfs3azWYlLMZotL1FFCBdeKA1H0iSfuam+
         Echg==
X-Forwarded-Encrypted: i=1; AJvYcCWpvosc0sfYeCZYb7/SBOvFX1QrZZoQCANzL+OGtP/vDYJpv9FMuJ0qSHxGYfnBz0gC7pG1FEQwB0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtK4kgjrL+qTY1qD9w6QpURijLdvyKnSDxp9v7rM+dLAXlFAM
	iX+ALxwr7wVX5r1WtZkqSU4sIdQ2QZVGLdlwbsOMdgcSr/+mISa2wFHspz6WJtvHiwY=
X-Gm-Gg: ASbGncttYvgnwegai03GYKMIKVXaoeqf12wlZP1Bxerj6qraYygq/wVW5v6L54jDl5S
	FpGqVWkjh73W/OMC0EBlUGUprcRyfYLjtK7uf8L0QKeO6YyheNnKEb7+IRUsFQWh73Z40FQQlLA
	Jx0wzU5Mw2FiNc81w2N+8cMeGobIYXF0Sskc6bu3vCeDRyORZKQwXomO5Hsze7sr1KDTk5/DrED
	O4OTlMVbcH8m6eNpDk/3B6QH8xYrsj0NWO0aGR56pI3hFPyPDEMK5J1lAShgOOWxJRu5JuEhvlg
	Uk2ifKElNCcVMtDi14wTzNQlv4ceDkBNAuHpDX4VeflAJCIJQibzsof548XsXud7R0K4X9Pumdx
	ZXgBzBA9TlVZtz5bto0kX/de8LWX5/Uw+ZRXUaDx9jqFuJ4RpcNraDY1Oq1Zg435/GCXDehhs2k
	SKQmgyEBoHeKUx8CORJhSYgbRsRauod5a39gz0Y6/3b9O6TSb3rB8YxN+VXcR/flINrklFefw7c
	enD
X-Google-Smtp-Source: AGHT+IFV+g5YZB4l+nX4K2VIKP4qPmTDVcLGCOU1922bmbKhf91LhPwj9RJnC4HZ2/LZ3K6Js5WD8w==
X-Received: by 2002:a05:6000:2583:b0:42b:2fb5:73c9 with SMTP id ffacd0b85a97d-42f89f70894mr2310830f8f.58.1765024680716;
        Sat, 06 Dec 2025 04:38:00 -0800 (PST)
Received: from [192.168.1.138] (241.85-85-167.dynamic.clientes.euskaltel.es. [85.85.167.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90fdsm13756855f8f.3.2025.12.06.04.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 04:38:00 -0800 (PST)
Message-ID: <f9cc4a7e-c71a-439f-9e71-8cba4986ceb7@suse.com>
Date: Sat, 6 Dec 2025 13:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Content-Language: en-GB
To: Conor Dooley <conor@kernel.org>, Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-2-hal.feng@starfivetech.com>
 <20251125-encourage-junkie-f80e6933b3af@spud>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20251125-encourage-junkie-f80e6933b3af@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/25 21:00, Conor Dooley wrote:
> On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
>> The "enable-gpio" property is not documented in the dt-bindings and
>> using GPIO APIs is not a standard method to enable or disable PCIe
>> slot power, so use regulator APIs to replace them.
>>
>> Tested-by: Matthias Brugger <mbrugger@suse.com>
> 
> Is this actually a valid tag?
> He provided one for the series on v3, which didn't include this patch.
> 

No it is not. As I only tested v3. But I was able to test v4 as well, so 
for the whole series:

Tested-by: Matthias Brugger <mbrugger@suse.com>

Regards,
Matthias


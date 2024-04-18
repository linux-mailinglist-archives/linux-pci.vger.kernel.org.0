Return-Path: <linux-pci+bounces-6433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FE8A9CEA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32D41F22AA1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730D16D4E1;
	Thu, 18 Apr 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fvbI6H5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3716D4D9
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450036; cv=none; b=AK/bow4EQ3rM5UfSRMeOeMb6cPQOjyH9Pf2knUoBrb1DGuzUcZrfuAUamON/PNGF84zdmJJV5xEegZ95M7NqaIQQcJEQij9+hE/dcdfHnqvyN9JYmu7ngI/Mt+zq7W9PVYz0Zn9/NZe+7q8JxJ22FkrRQz6inAXGkmzKjiA9VzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450036; c=relaxed/simple;
	bh=gAa7Kq1mYFyz8jqtnXVIe79COqi9Rf6W5LHAFGe3mjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olpm9DRRZQSV1mYQU07BV3GRlIrVmxiWUqSEbxoG22BzebZywk8meDG/y8GR700m4m1yJJVI9PqezV4vYUw+TzP9Ez+tkS4ESVK8ceP+rkouQnDAxtEmQGJPJpOPstywNdh3m+lGRmldM8hqc+tnpMlTCiRcxnlrYUwg4wHCUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fvbI6H5q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDBD13F8EB
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713450030;
	bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=fvbI6H5qEJyOKKXg7sMdwyQPj8Pgv4iI0ilE1qO82dS3NLZ2XpSkWx54aE5Sm1wwh
	 CB3WJHpsMQgwi0J3tejoQZBN1jjxZoKSfsNYMbr27uICGeNPvvW4JPXo9zOVf5gsYw
	 eyRYqYhx70tqGGf8nIGsObMKkyUM7k9z7knHs3UdsLTbwlnZmqC5D9oGlB7KvJv8Lf
	 sCcHI+U5QK8eZu17sBn0DjuB1IIuEMSY1kPKQWiu0ENJWCsesAB5hykLd4rAELmVox
	 0YYN+xKE8werAeh+OJUR0hB6YRRq8X8wUOQi+/QzQyy4FgRDziNpwmRB2Kd0nWJtGI
	 rNZOqDfGkKf8A==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416a844695dso5565065e9.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450030; x=1714054830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
        b=MaWVpQlB9DxFB2vM2ek+gAewwBR+/RkvvXgFbKmBsZGKBBYmYEUMUyBlqEp2BXzJpw
         SkcUZAeK+1Li1H0u8PftaW8D7RP2/A5w+JqaOw4ptv4JH0eyNzXyza0xtHoCmk1lvx4l
         +f0G9v+h+X2jIlYfq1IMLPAClXn64NY4kahuM0UA0i2opSEQK6y/bLmJqgEQ+sdq6v6S
         XWVoa2n9BDNUXCUWBMOl5aWk3ARASQKco9kPVzenymUO3S5SJNtScXUdsMLWnjscHFum
         WzFejRz9hybV8D4ov6BW00+VGLbQ21ByP5RGULMe3o1Aek+k0xG1VQsubhCWYvFhiLAs
         4yFA==
X-Forwarded-Encrypted: i=1; AJvYcCU6D7XXb/rf4fsYG0mxijtkFIOzYqbJKYrb9HrAVgwtzide2k8qUHJ/eQYGlXtwLUTmisEO1lEImH6Ef54YGr69p7vf2822g1hW
X-Gm-Message-State: AOJu0YyJ44BD4DJ/03L0v3n7oWFQPfQHGqZNBRqFmvE2UX5DrmVO6bqQ
	itOA9PcTd4RcMhl1qvMolqXhRoMiYyC6MTTsHKF6z84bv/o0TWPtoO7mOsWAx5XJ7xOmjXppboA
	GRcwayh+oawen6M2cTh1BotdHRlWjK9sdyBna5F6Gxa0ncvBXEtXUeTUiqkaOtH4x2Z/J+hlCWA
	==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340898wmq.40.1713450029739;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2UI5195uUHY+LxtGsmAza41kuNxu3PsqfU28U6vm2gIhE1ZKzhOvItctvv3fW1IYrvOjmg==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340875wmq.40.1713450029353;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
Received: from [192.168.123.126] (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00416b163e52bsm6658726wmq.14.2024.04.18.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:20:28 -0700 (PDT)
Message-ID: <ef065a0e-1996-4ca2-b6f0-3a152edd3540@canonical.com>
Date: Thu, 18 Apr 2024 16:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>,
 Robert Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andrei Warkentin <andrei.warkentin@intel.com>, Marc Zyngier
 <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
 <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.04.24 15:58, Sunil V L wrote:
> Hi Björn,
> 
> This is cool!. I was not aware that u-boot also supports ACPI on
> RISC-V. Many thanks!
> 
> Thanks,
> Sunil

For RISC-V and ARM we have

* pass-through for QEMU ACPI tables
* pass-through for QEMU SMBIOS tables
* generation of SMBIOS tables

Generation of ACPI tables in U-Boot has up now only been implemented for 
x86 but would be feasible for RISC-V boards too.

Cf. https://docs.u-boot.org/en/latest/board/emulation/acpi.html

Best regards

Heinrich


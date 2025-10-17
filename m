Return-Path: <linux-pci+bounces-38505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856FBEB357
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 20:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EC0746326
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA663314B5;
	Fri, 17 Oct 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpWpGq4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40D2F7AA0
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725387; cv=none; b=fqtT2rRGSJIrqrIxt6o6FS/efS3NcU+dEmToqMBksKWESPum9L4JIfF5KekLAEWJ229ADKFstw6hZOo4g6eQk6m9ufhV+cmAzubZRJ+ulYUEefcW27ieayigaQhvpIJvseUkqwmqmT5GFgGmHgWszSJoS8rGmbteJG3ALRelkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725387; c=relaxed/simple;
	bh=5pT7BQdSoioQws8hceblDfz8uRT4tJeXZtQqcf85sO4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uG+72orypAN8qrFGTwbbAn8Z3TrFztfDvPM01WbT7EbFc33HXljz+BP5+ggmJdUdhAJq7egcY25IOm6VXngu+7iK/kzejJ0EI5xLK76iJKAt6uDMdQ+Aih/sKnJuEFa0YtkNGJTvzfRXlBgmMKxgASbe8wn1DgSRk7LgZ3vt7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpWpGq4t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29091d29fc8so23049695ad.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725385; x=1761330185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0chmGI9kAg7ZUFm0zk2KVMxANoZi8A1FEk14Q9CewaM=;
        b=UpWpGq4tCqX3j3Ewxe2dECdDIMgin32noJvXIEQQBIjt94MjMqFr7j+eGN465Vbn95
         RVOzPCAAUw4g5Ep7i9ykMq1bAXlf8LBOCTkq6l8QdqDsP7QFGTchHCgVIJOLxtGe8oih
         CsizNvwoh01rl49k9+E84MBnplkISKTtJSh7fOTVd53xHWzLrb0II8qNjWwWp/O6C+WT
         PsTdyo1dAiyU1Pji3KYrZQMdbV+eVcNb7R4mZkLY2XrgMNWCnv6xcs0Zw9h/AdWQU7Cz
         NjBoMYNKV1L2vAgs2YswOoBK468HrRXAOj4c4LYcPppeuixOXBK3zLb7SncP58MUTvda
         ji3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725385; x=1761330185;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0chmGI9kAg7ZUFm0zk2KVMxANoZi8A1FEk14Q9CewaM=;
        b=IaaB99OpUR7K6GDn+G0ij8Zz2l2QsS4qLUPDVcNKX44uG/B1JED8vd5M/zFyl7jdNj
         U/N1rWle3sXhDCBMFqsssriV4jU3ahUoHZhQoxWSTXtBQcfLNb15ztMdSDHbpLbkojBa
         eOnbX/IpHm0Okw8a5sBHt+Gcba0EQezNQNHQZygSe928P8+frI6/F+eSHtgnWf+bKLrR
         jw32/w95dxMkAuLOZPEZOVWQTw3TmVdMKB828umnEGuhQqoVHLoc3qKBapxD28yMpHn6
         I7KE19z/31Cl6oUSiXYIeBEeaCQ+EszlwB9R9Ot4B/sw2XxVUHDayJZrqwZqEhMnlP+0
         HZSA==
X-Forwarded-Encrypted: i=1; AJvYcCVE9fBAWHSR2NHjO3DTJ7KV1KONijS7l8Ra4bEQ5uy8qy0fXhtIMTSbxm8LPCzE3Gbvb+egnFOufdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Mnp0J1QT7BXvzx1VkOkNG9T45D7wi+8nJKL7/lHoQ9moCeUV
	PDdXLeeyAHQ4Cr35MDhxb+V9iltHmRANPOF7BULACb8v6haYkxuf/gmS
X-Gm-Gg: ASbGncsmjWcUdius1JXFjdDspvLiOVp4qblbL7CdmkTKPL7SR0wfxiKQo0SzfZ9PePv
	1zBa0kxyy5V0qtQ14r8eTAFcTIWRQMBuNZI87RFWMXlU5zHbp8BdjLbR6GHp2lXFHuusGPOX4yM
	owbv4rOBwJ1E3CBwGhHUObrMURWfbFsTuOc87vyMQtKWJUxlBBBBwYPvW6h2Dk8b9w7oV25pRqS
	a044Hdg5Y9E5rOYJKDiCi4QSLw/ZvDwGHcp/e7lqMhclQU/VPymsYzME+YrereswZPVIzlHY4em
	l2bHyUcfyL2C7YTOBSJYfAUTx+BPCTyr8fXEM0FW4wo20WJpk18UCUReFLFFIadF0G72zcuEySH
	HfOPTy0V+k7y13e9Ksw2tfWjV7amzCOh1EtilYXaWYrncdpksBKJmTasRyAkwN3B0WbFT0s8Vo+
	0AEJd6d+UCNJDQe8BgLEYwQ5cV625wiawbaQX0
X-Google-Smtp-Source: AGHT+IG8twOm8aZNVgRcxcAnVGwQPPvv6ZNRdDAa9/X1jshnEfsRB0u43qZEumlXVDVYXPdg17rLjg==
X-Received: by 2002:a17:903:1a4c:b0:27e:f201:ec90 with SMTP id d9443c01a7336-290c9ce63b3mr54322235ad.25.1760725384778;
        Fri, 17 Oct 2025 11:23:04 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.200.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2dasm1631525ad.94.2025.10.17.11.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 11:23:04 -0700 (PDT)
Message-ID: <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>
Date: Fri, 17 Oct 2025 23:52:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, kw@linux.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lucas.demarchi@intel.com,
 rafael.j.wysocki@intel.com, Manivannan Sadhasivam <mani@kernel.org>
References: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.

I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")

Happy to help if any testing or logs are required.



echo 1 > /sys/bus/pci/rescan
[   37.170389] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
[   37.177781] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
[   37.183808] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
[   37.189843] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
[   37.195802] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
[   37.201768] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
[   37.207715] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
[   37.214040] pci 0000:01:00.0: supports D1
[   37.218083] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[   37.231890] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
[   37.242890] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
[   37.251216] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
[   37.258309] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
[   37.265851] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
[   37.272896] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
[   37.280439] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
[   37.287459] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
[   37.294986] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
[   37.302011] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
[   37.309536] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
[   37.316595] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: releasing
[   37.323541] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
[   37.330400] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
[   37.337956] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
[   37.344960] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
[   37.352550] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
[   37.359578] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
[   37.367152] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
[   37.374192] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
[   37.381709] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
[   37.388720] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
[   37.396246] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
[   37.403795] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[   37.410513] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)
[   37.417796] pci-endpoint-test 0000:01:00.0: Cannot perform PCI test without BAR0


Regards,
Bhanu Seshu Kumar Valluri


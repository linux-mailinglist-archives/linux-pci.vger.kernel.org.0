Return-Path: <linux-pci+bounces-44121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9263CFAC35
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 20:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D27C31C0EF2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E1330D3B;
	Tue,  6 Jan 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3PdsqS8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562E2FC02F
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728015; cv=none; b=Agpp23gDAQRMWxzvIEb8XHucBR58AMNRoi4SydfAPHBFSJG8u99OmsL+wvq4iunYb1lzuH3CS5VJntFhuAiqTWq3kjNKYKxRlABrzhgjKbM49NjDtdgD+VVuFOK5J4jUbIZQpe18HYSKUSTsljhcdewNXBLaBoX9v36fnQK0CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728015; c=relaxed/simple;
	bh=Hvqlq6a5UxKqduyk2kiDc5n98w4QU4Xe68utTnHxzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obn6Y5eqPWLFiuU6qUiCWjmmWUMxKqqd2Cp+vhFwdvmM7+chNYjWq8IBluoOkya4LiQJhtdvVsVMmqzv52Y2K63xXkm31ARFhHGNG5tzi8D9YEpxRT8EXr6HaV8VJdAMlDHct+/JqfBlA0eKqD4/nSIrnd6QDUz/aehDdEjWwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3PdsqS8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so994183b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767728010; x=1768332810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvqlq6a5UxKqduyk2kiDc5n98w4QU4Xe68utTnHxzxg=;
        b=j3PdsqS8ivCLOT3f6A9g0LfJV/ffjNd5RRxehIrwB9Un+dM+lvZ4k9hUbEAyLnfRI5
         Zsm+jFVAn7NspeyyH0GJpV1DGAGmahWNIcHyKmB8JJmFk85Id656xu2Sy6ZDxqs4pFkr
         4kd7WZt81Cbl9vGG8jbZyWmhY9zpVg8TBlb1MI/GmnXcpJteY1mTcwV+Rd61gnI8J6Gb
         a294zqlhSIR0f3R7I+IO+vWjZfgdbQl6O7yPq+oT9yvEbnKGSuJ6U2kNd7R6VENHPCHx
         b5HQqXuww/Hk16YKG3SRm1DSaC13BoAb7AJr8Q/C9+ATA024sU8Oknozdxdrs5VHc8uO
         VgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728010; x=1768332810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvqlq6a5UxKqduyk2kiDc5n98w4QU4Xe68utTnHxzxg=;
        b=COqYjg9WTNDvHvS3TvHHUKTTUjIX8hQa1cyLgFy/s9V8odRYKX/1My5ZVcT+/bm+Mn
         G8rRFemldkXoCZ9GWdo/iLQsp/3IyEFvV5YsHR+iPiHPRqgfPwmylykImPotp5yvdwKR
         tL6GGChF1bMdfJaaqCPJXAMCb8ctkFBwGfGfPNwBAaYP2zcVg8OWFaRzWwIMEkL5xrg8
         IKdcDEO/2zFscvjEbc9yEh0y5D02rP9D/4U6U8Vr6nTFQl3aDFvBs2PYzSf1DKx7k5Cy
         gKW7zbc7+XiIpwCsSRqVIiJUsPiQySaj2Z+IqVd+DHBu5qo1WZ1K7yfBWvYkf1EsGROb
         YDsw==
X-Forwarded-Encrypted: i=1; AJvYcCXvZ1pBXNXDpKfocvgaiRZKFvi6cyxWiXsouNk/PiU3WSx9Ma6CgXXm+7urwrg0QpARUfLLgswu2H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10ftePZrQwMD7P/z3ZMGIXNqLe0f1CxMvxQgBqW8nI2PjseBL
	2IdNiuKGw6rRwzyEo+EXuhfUUZZKsjZhbgB/ex1fD85oAZc7HbQw6X0=
X-Gm-Gg: AY/fxX4ur7jgMTQiPL2pblo7q+10FwGphlkQOTFoYTRET2O4cJ6dNp3aXBefsmr+jRQ
	3fty5UKO2+FVktqdJ4OGoQjt5vGeXfhB80QEsq6MUyZgAUm8LGmMgBmNYQg74/6BwoDv34mzpJ+
	kWr0f19sasWW0lYChKO7rVn0tnOUM9N9MCa4PNosPNCKJtZqEvPCsO4yCmRCP8kyI+OjZ0WZoQu
	yX4UHx9DzpEpt2zoD8Ql+YmZRdOEtNy86J93GxH9oLwDiAimBtXyTK5R+plASHuyRItYxHLUf+P
	4kwlCsC6moZozDqV/YFESOe6I7iysOFWnxJ3eQJ2tOBA9W/aaA64/KM9I3rKSbTE0q0dJW1n0xx
	5147ZSsNKie0m46oXLu5ma2yJY/hWRNjrvg8KJP32Nu9CuF2NzQ66syabnZJ2Z11ofHGgceFJYz
	+uT9DnYmLHt20x3Mo=
X-Google-Smtp-Source: AGHT+IEgZRcMeGOPU4jikwHF2xGmNts5v00FceTZEzYKMb12Z0gLiWMWOCzUlnIDLepvGJSikIfAlQ==
X-Received: by 2002:a05:6a00:6ca0:b0:7b8:8d43:fcd1 with SMTP id d2e1a72fcca58-81b7d86729cmr114585b3a.9.1767728010117;
        Tue, 06 Jan 2026 11:33:30 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm2890248b3a.54.2026.01.06.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:33:29 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	dave.jiang@intel.com,
	feng.tang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Tue,  6 Jan 2026 19:33:23 +0000
Message-ID: <20260106193323.1544-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
References: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macs dosent allow normal users to change settings in the bios, and i want
to use AER on different devices.


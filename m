Return-Path: <linux-pci+bounces-22566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9FA48011
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39881889D6A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7C22F397;
	Thu, 27 Feb 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0hX1kzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329442C0B;
	Thu, 27 Feb 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664545; cv=none; b=ou3P/zujlo0co6wVlGDhViVmZfaf3QJwp12ENoePD6Ct8X24cVDnDX4sNVRJdYfwT+j56LUzeWm531/1GJ/Tvb2IEy5hYVNVaK472ruN+EUnut9ZuolzfmFRwRaZlFYre502WZ6Huy7gVuceoUyU26AHHbN3M6ONaRwkwnLG5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664545; c=relaxed/simple;
	bh=w5PrfAMbovUyS2QcIh8YSYSUSXSpcWOiTR0ekujNaVI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XNOJLieU1+FP+/L4Jnx8zSFlNzjrIr873x7YgYAbapduYsAARmnU8NJ3ITydQSfAdPjgRatEXDkr/Z+OLJNojv5fUHVeqg5xlUIy2OdSpQcmjW0myBc28FpheOXWRlGfQd8IT4PGAG/1foYIdR4ARpW0cFlXbrh3x8ZkVjMLleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0hX1kzl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3ffe06107so544144b6e.2;
        Thu, 27 Feb 2025 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740664543; x=1741269343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OT7lACv6pRY581pDMHaH4afYtbO0tkAIV0SUe++9Fbc=;
        b=e0hX1kzlFnwJTsoBHVuOdsuVwHG5wc14P9gRc+uTMk09kuoGpojTf59X/2GbwzSrhO
         HGGpcgjC/zQZdThBqkYh6hFFA6NDGQWW4mGTS63kNkfv8/OHMqZypY2rmRnLDyeRTkqt
         l1gR3u0/7edY9HyjTockrv7faGZLaiHql73aZWK5votnIPluqXh4pHSWxHb2Dcy0fJd8
         QgPepMOouom5g0QsbQungTS6zfGwhBeiKs0VV4QbTsfx4cL0BMPb4IwQa7vlcpm7V2l8
         NC8/0BOVvq/QzTLj3UcibqxmXrt8qKXvNDvFEA+wQ/KgFuJHuBrHOw0xjG7o4VsHFM8L
         95zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664543; x=1741269343;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OT7lACv6pRY581pDMHaH4afYtbO0tkAIV0SUe++9Fbc=;
        b=DAy7g95veKmUKgu7kwx8Ku2LE4cPA7ADnYXOJ5ZirUEFHTDTK3FQKT94MDkAQh1Woy
         v7z/K3CD1auP1+7fVSzKTS/v3+8MToyB/g8nNbfc84JJtM0s7jRsZtsMLBCIKPWP9uZH
         x1nUcVpWQuzZBcZIRQnGmlBZRD38BPN0d2W25C4st4pxNKIBgEcMmp1ACVwm2ZiKexUj
         JJXpgVRj+my6qeTEjJiUYm3fQFy4sGpluqyb+dzpUEyBwFvdz7pPENlKU/u6i1wL9O1A
         syF8KBgZ5CiBV/VTsyzxDiN3b5UUqnKm8+368feVMrlUw+fERMt1IlVJHvwwblFCvOXU
         BjRw==
X-Forwarded-Encrypted: i=1; AJvYcCW17C3oV2fX9nQd8ma0JJ5saZLVwIgkuwpanbXY9Nh5Y8QWM818E0l9ZeKvpndnnHTofVRtD4Zn+h1n@vger.kernel.org
X-Gm-Message-State: AOJu0Yzceyjogx8tKMmvMdisGXRu9hjgIpz+IaaR1yMA8/cvRAyzq+6Z
	5G0HbXx97wP3Cj4h7fVGQiHbFr8sUy2jAFPrCVQcSZ93y/IYT0T+5zRCQ29woF/iOPjY7XHnYxl
	YE8W7IQXorbg5DI+foNT7zVUXAsEHBDJR
X-Gm-Gg: ASbGnctV6cDJcc88Ubw8UGpvoyKauAmWNZPN/h1lsqagRca1renOlYyhLC/xX5KnHXq
	VpdD+RKMXpCX9cU3p55z3SnVqrns/0i5GWtUCqvWzM+DtvWoX6Nrc1XWgNts1z5tmDcElTSTb5N
	FkRgun1yGapw==
X-Google-Smtp-Source: AGHT+IGAF+jqOIA63oG2XffgQF4AapKinr+0usIKi6jAeHtmbHO8o+QwlaLBANygf/4aAxP+v7gE5qpfJajcUdBYq+I=
X-Received: by 2002:a05:6808:3c95:b0:3f3:b4f9:88df with SMTP id
 5614622812f47-3f4246a0d5cmr15595459b6e.3.1740664543203; Thu, 27 Feb 2025
 05:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 27 Feb 2025 19:25:32 +0530
X-Gm-Features: AQ5f1JqZqEz44uEHmPt8PWANB9y187aZ1esA5hLZJhdx60rNPy2ku4Lq6_zYjKQ
Message-ID: <CAHhAz+gUOK4Bn5ijO0H1b5=EtvD5W4GpOTtjP0--yVToNpkEDA@mail.gmail.com>
Subject: pci: acpi: Query on ACPI Device Tree Representation and Enumeration
 for Xilinx FPGA PCIe Endpoint functions
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am currently working on a project involving a Xilinx FPGA connected
to an x86 CPU via a PCIe root port. The Xilinx FPGA functions as a
PCIe endpoint with single function capability and is programmed to
emulate the Soundwire Master controller. It can be dynamically
reprogrammed to emulate other interfaces as needed. Essentially, the
FPGA emulates an interface and connects to the CPU via the PCIe bus.

Given this setup, the BIOS does not have prior knowledge of the
function implemented in the Xilinx FPGA PCIe endpoint. I have a couple
of questions regarding this configuration:

Is it possible to define an ACPI Device Tree representation for this
type of hardware setup?
Can we achieve ACPI-based device enumeration with this configuration?

I would greatly appreciate any guidance or references to documentation
that could help us achieve this.

Thank you for your time and assistance.


-- 
Thanks,
Sekhar


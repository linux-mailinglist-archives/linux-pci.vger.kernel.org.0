Return-Path: <linux-pci+bounces-34204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB7B2AC72
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A34F7A9F49
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD42254AE4;
	Mon, 18 Aug 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVE4nVzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0ED24466C;
	Mon, 18 Aug 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530355; cv=none; b=fy36k54mPCthBVEYHLdAlDLcG7kW2aiTbJG4RWDPzenplq0f6zenusMyVU7KDjbWEg+fGg0c9JiSqZKg36zn0BnlSCrMRuMETLPClwYzsbat/eLQjahYqhiqfpUs1fWmoXJLSqhLpYUXl0bbZTf3Ptq7POU5kjcmEGK0CVz2mNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530355; c=relaxed/simple;
	bh=5ghUdQ+LK09cGWa+fdbSiOCxz/wvt2dQu8IqncVyz0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWH8ESXQeRQ9ZjmEjQ1qy2lhoD1ubAI2xuTZk4lr6z9lOQ9O0cqnpsHt7ki4H9Y/OvBf6X1Hnj57OxYZDS8Qg4qASInqzdmmxVu5tLpIPHwO/8BABd8GzQ/BuvfZCa7ch1Z9Zgu3UJj8tBNMY1EYbPVJ0ed6flU2JvHCfhdVt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVE4nVzs; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60501806so36681517b3.2;
        Mon, 18 Aug 2025 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755530352; x=1756135152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/qZBI4Ir8dAHURDFoBoBOxD8vg/sf8RDH0zkiFTLpY=;
        b=AVE4nVzscqzrfKssPWC6WeZmJCOcVp90ESPSgx0bxtGPekD3oC2mNIKlc0ImZDlRWh
         wk7dLjeRXpWnhSC6Ic46Pv0cA+fW9caTeo+yjUfGv1BtRqfk2dqLI9vmVp6G6W1+GQwX
         giMu5aAvrgvMlKPukHtt2dcIsV8n+/JZIWC4rJOXQVBm3g6TqmiLc0GBTM2GIDmmLjpD
         H2i68+nw0jm5FjztObL3kuVGS5sCxUbjKA9YpalmS6xDDcrPQAoH4+FVlK/ZwRcV9M24
         lNC3izmBZFIiCfpbvD3Csnwu539TxUa7F6i5m4yw95dE3Kkdx/3a6ce6sUfkQeOosVFE
         Wsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530352; x=1756135152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/qZBI4Ir8dAHURDFoBoBOxD8vg/sf8RDH0zkiFTLpY=;
        b=ppHcdYVyypSc9q/lBpODSwu87vgQQROOWoQ9DaOwMRcVVrr5kozc3Pb4PCPaWzPT2E
         U3/G4REnJkPzw9KVtBgdfqy2yllaltvTZNx19I5NNwwDM3lr1mpuwneGCnVB/4pYbwBz
         kJjzHKI7FY0WUa2mz3rNSGuK0vxEnUPmFjKY3/7CFHbV4WqGQYtdpntSkLbGpsx3Xy6S
         CkBzwiqjH2UXkSNEaitd1psv9bUXqM9JXUf74UmDeCBuJDvV7FS/M0MQgnHjjLq3B4cb
         0T4HTeWjiYE/lZeaGfM56yW3B63cLotaugU7ESV/BZSTWK3PilmhkeVo4BlA0cLImDDF
         1Y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwHB0GHWRUr+TZwCd/JWtBAVVj32rN1YTF8afnrGFEKyfa0Ucun1VUKqShdWl9ToG0VEa/JCeknsI=@vger.kernel.org, AJvYcCWG1zEemucoKCRlIqp5435XPnS9COefkQd60QgxkXZD7IsAxwdMNWzZ9cf4MMFISreNpfCabP/5yIsOVriz@vger.kernel.org, AJvYcCWWFA9Sgz3f6JBpgUgcrdVM4He+ATb8FSNPnUrLYdxj00zsugywmyxIGDDDLJYaRIGbaoH+4MtD+aaa@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZnirdLtqURbGt4Op0Z7EbCrZRwU+IbsJzw8zJqnP2DbHDkAb
	S1xkyikLWCDSCclFdxMUV8SzZG+3ymjuUeQbEdnHVS5OmD/Z9qneKojQ
X-Gm-Gg: ASbGnctJs1ZrOSbU/LuABA9BwTgcPB0fUzOB0qYTa1yx/5ewBRkDZ8Q2mLte1OeXyYw
	qescdHkxB/tNwYuu4+sqJAkVlH+OrgNDNaTcZ5exyExyORBxUESR0u/1MITjMwm6H5UvFUXm9Kl
	thmILjAMVKIhE8EQovlscW1AHNeSs0co2Kfl1Vl4XDseP311i9Vh+DrCrQed2Plx5TaCCQctOKB
	i9PqZD8IZVYX31rx4pOypxsot9pmfJH0F++0quOvI+MMGN1aIp/u5//I0/jkkP9vSZZhIGtvg/m
	OkvuMSjrd7OfPv2xHYdRtJ9wKOpXmh+q5eUJSw8y+bxQjBKaUmzGqlg9GtGBU+4X5ZW8ftDOyAp
	83Hv1kUOkchWtZhwKi6n7tw==
X-Google-Smtp-Source: AGHT+IFXDbfiqX+b3NbJkj25wrp3QhJOXryZJf0lAn6nVOoZBsK/4L+ZGb++KaHGh5JS2gM62U4A6g==
X-Received: by 2002:a05:690c:3345:b0:71b:f755:bbc5 with SMTP id 00721157ae682-71e77507fe9mr111931127b3.32.1755530352203;
        Mon, 18 Aug 2025 08:19:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e11d302sm22707807b3.77.2025.08.18.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:19:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	bhelgaas@google.com,
	shiju.jose@huawei.com,
	ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com,
	rrichter@amd.com,
	dan.carpenter@linaro.org,
	PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 00/17] Enable CXL PCIe Port Protocol Error handling and logging
Date: Mon, 18 Aug 2025 08:18:53 -0700
Message-ID: <20250818151855.2950059-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 17:42:35 -0500 Terry Bowman <terry.bowman@amd.com> wrote:

> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
> EPs as well.
> 
> This patchset is a continuation of v9 found here:
> https://lore.kernel.org/linux-cxl/20250603172239.159260-1-terry.bowman@amd.com/
> 
> The first patch is a small cleanup change to reduce amount of code. 
> 
> The next 2 patches introduce pci_dev::is_cxl, aer_info::is_cxl, and add
> bus string to AER log tracing. aer_info::is_cxl will be used to indicate a
> CXL or PCI error and will be used to direct the error handling flow in
> later patches.
> 
> The next patch introduces a new driver file, pci/pcie/cxl_aer.c, to move
> the existing CXL AER logic into.
> 
> The next 3 patches update the AER driver and CXL driver to use a kfifo. 
> The kfifo is added to offload CXL-AER protocol error work to the CXL
> driver. These patches provide the kfifo work add and work remove. 
> 
> The next 5 patches prepare the CXL driver for adding the updated protocol
> error handlers. This includes adding CXL Port RAS mapping and updating
> interfaces for common support.
> 
> The final 5 patches add the CXL error handlers for CXL EPs and CXL Ports.
> CXL EPs keep the PCIe error handler for cases the EP error is interpreted
> as a PCIe error. These patches also add logic to unmask CXL Protocol Errors
> during port probing, and mask CXL Protocol Errors during port device
> cleanup.

Hello Terry,

Thank you for this new version. I just wanted to add that I have been testing
this new version on a few machines, and it fixes an issue that I was seeing
on v8 of the patchset.

Previously, booting a kernel with the parameter pcie_ports=compat would lead
to a kernel crash caused by a NULL pointer dereference. After I rebased the
kernel to use v10 instead, this went away and I can use pcie_ports=compat
without any complications. I tried looking in to see what the change that
led to this fix was, but couldn't find anything specific. 

It seems like a use-after-free bug and happens specifically in
cxl_dport_init_ras_reporting. Since this new version fixes this issue, pleae
feel free to add my tested-by tag in future versions.

Thank you again for your work on this series! I hope you have a great day.
Joshua Hahn

Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Sent using hkml (https://github.com/sjp38/hackermail)


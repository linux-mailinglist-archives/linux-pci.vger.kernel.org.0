Return-Path: <linux-pci+bounces-15890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861A9BA80A
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E91B20F95
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408418B49D;
	Sun,  3 Nov 2024 20:52:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15739189BA9
	for <linux-pci@vger.kernel.org>; Sun,  3 Nov 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667125; cv=none; b=cA/Op3VNsAtQKIE4KougKFyu2yvlRwaQtWyEB+2hNUh/EwpsnuIt8rEPsl3VPUvGvJRezKvdFr/Rlade0Xq7rPAIZS8vkrczxBq0zJgYHFeISD/2Dzf26r/6GZSzgHGS+IeL8hjA6hgX1rsMxXFl5bgg5SfYxum2dfvmHpRvi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667125; c=relaxed/simple;
	bh=5U91DwA0eVLAI0FZXtvRZ+tmO6Ih03Z+eKJlyKHdD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnA5UAVAnt0gn54g4lVfOJkY5KWV5MQ3+S57z4eolQRoXeBNh8AzOvbTwBYcFWxxL+BxEp1KEHExNPNPmwXl0k2GLqHz/Y9LyUL7YCUuQhRlDevS6T7Vwcjr89R9eqfrl+UKffXaWLoaIYegcdE8PTKuqaAZBSedRtYPZzmGqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2963506b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 03 Nov 2024 12:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667123; x=1731271923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEVQQTiBEIuV5btI7osfmySMSk+OkNnC5WwX7N6IYOM=;
        b=BfHgoq6zjXck+M4BLUjfvXPkpm0ManprFZ9HZCcmkMFIDTY2kYDMokuuvQW5QF9z5l
         doqEURCwKMnl8fvamLQqJmbYTZemmHBaAn+TF71ClcBpCqCwQPqTu8DZBQo/JFeaNA6J
         XTDrf7aWSjVIQQl1Ib2pFFb8JRT26jHtFpW13lEdEmwAS110uMxBYcI1lhcUvJuxnpRr
         1ixDnIyIFounjWWqQmyhLsDVigpqQC5YJPb7gLrFOtWUaXmiyX6s9sr4BgxQm2ZSKMJo
         DpwuArlyi6pylpmwoiopQRUj5m426zcnp6G2YG9s5kaCqJbhXsTDWyW27pGjQsQBpmQM
         Gtkg==
X-Gm-Message-State: AOJu0Yzk9S1ihh3OMdT8eBZC1J7vdS9/C4wmuVfhifd0zFPsSAiX5JuD
	/PsaKazgQczidGMVnHdexboTaqLYNmz8JCHMQtUvg0lKR4uNtSx6
X-Google-Smtp-Source: AGHT+IFhtlBcrfWhDORl0Wt++nHeIhbW8CSEse3fkg8myGgxvRRK45zoupAw5cxjLOroQ2oXMcWHCA==
X-Received: by 2002:a05:6a20:3544:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1db95056f28mr18724136637.21.1730667123303;
        Sun, 03 Nov 2024 12:52:03 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb699sm6099858b3a.167.2024.11.03.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:52:02 -0800 (PST)
Date: Mon, 4 Nov 2024 05:52:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com,
	Nirmal Patel <nirmal.patel@linux.ntel.com>
Subject: Re: [PATCH] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel
 client SKU's
Message-ID: <20241103205200.GF237624@rocinante>
References: <20241011175657.249948-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011175657.249948-1-nirmal.patel@linux.intel.com>

Hello,

> Add support for this VMD device which supports the bus restriction mode.
> The feature that turns off vector 0 for MSI-X remapping is also enabled.

Applied to controller/vmd, thank you!

[01/01] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKU's
        https://git.kernel.org/pci/pci/c/2a530f44f509

	Krzysztof


Return-Path: <linux-pci+bounces-407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA718032B6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1091F21082
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4A200BF;
	Mon,  4 Dec 2023 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cx2cuEvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF18119
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 04:31:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c0e37cfafso3786515e9.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701693078; x=1702297878; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W55/T9K6+K8UUWjjypa9TYy5bFm9BSQxOhQzpcpwFHU=;
        b=cx2cuEvwmmOfaQaFFuYLcGVg225tEU7qu5HUIvPrYhEtuq7byST0CVcWBWHHjeicAL
         P1eBeR891ioXEbfJvrypwAh6zkKP9YXoyPpLGZT8IaOl6IRRMppZcdpmrtijMzI9aMwd
         i9As71Ed0mDWWzJWCoZJsjD1CWHUJ3eQ3ovFXg1n1PXaR+zqHFk/PUWMirkafdyb5jgb
         d3kD+v91m5PM1D5puj01QuYHu4tomTiup+g/DIQkaVpo0b49E0viOMFkErcYR6X4nPxq
         mCCwfV/8v5qFLSVcJRsW1ZnDG4KBILJPR3yrjfa3GeQrf74b/1b3og1ts6mxCs7Tt9YL
         CZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693078; x=1702297878;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W55/T9K6+K8UUWjjypa9TYy5bFm9BSQxOhQzpcpwFHU=;
        b=Lsgcd637rV7b9e6J7cBafYB1RoVyTZd3skljZr5YmmbqHr/Kexu3quCspaMMxKB7lr
         UHeWBmgLMO2XAPljuFRBRn51V/sjLgKb9uHuQ+2DjMW6YalsJKuDP5BgD8MsEgjoDYMb
         TqYOMvBYyrhlZm22yqf1r9cK8vooHLTmwNLNQx9zIMHz5Blxl2pMhYB/lpz5jfT/tBQW
         tZyxwh6V4vY55vo9ORNIjr+LkPQ5JuSbHMNVuoaK3uGOGnNjUV4knoiW79cDcltRYGUy
         6llYg8IPU8Ia6PYxfJzpc3McTmjR6oZ0C2EDUYHdwY8uJQKC8NyOpRKEwQRb/Sen6Ls0
         RTgw==
X-Gm-Message-State: AOJu0YwNR0v6UDvSKXFPGmeDPtA06uOR715mnILawfZ2vDhrc4YRbZZ+
	PhYmwDOL3wXHFp5hUREWwr89Ww==
X-Google-Smtp-Source: AGHT+IHB8BRFdhuNviEObNj50i/Qccig1rQTpxR703fqIvFCYt8GYXuVrTy0FmlwVcezeH1TnfE56A==
X-Received: by 2002:a05:600c:5128:b0:40b:5e21:d370 with SMTP id o40-20020a05600c512800b0040b5e21d370mr2452561wms.121.1701693078623;
        Mon, 04 Dec 2023 04:31:18 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b0040b2976eb02sm14922744wmb.10.2023.12.04.04.31.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:31:18 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Mon, 4 Dec 2023 13:31:18 +0100 (CET)
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, 
    linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
    Jian Hui Lee <jianhui.lee@canonical.com>, Even Xu <even.xu@intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
In-Reply-To: <20231108121940.288005-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.2312041331050.29220@cbobk.fhfr.pm>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Nov 2023, Kai-Heng Feng wrote:

> Since PCI core and ACPI core already handles PCI PME wake and GPE wake
> when the device has wakeup capability, use device_init_wakeup() to let
> them do the wakeup setting work.
> 
> Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> PCI and ACPI set OOB wakeup for S5.
> 
> Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Srinivas, do you please have any feedback on this patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs



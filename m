Return-Path: <linux-pci+bounces-42066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51065C85F3D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B77635400B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8E20E023;
	Tue, 25 Nov 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8pqydK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88F22B584
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087638; cv=none; b=QjKSaYi+Fq6uHUFzJw0D9QxNNDje3z23xh3lZPZOpiyuvcoRyVc7pxCImGeQWtL8NLgs7HSqvlmkFYuJG0zJcRF1Gq+Y8d47o4JbE1PP+xeENCid1c+xgr62EFxIOsydusqNzpsjE9lJHM9zqfjY1+0Kpz0FIDxPfHBLzHwc/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087638; c=relaxed/simple;
	bh=eJ/IMjGulEI8QmjGtE/6iZTat616jmFMM5GjWfzZprc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSfT7EdpaobOJ5fiPSWOhwWJqs9bipHa19KioVcCp5KX7+7S9dkS/BXBVYf12wcz2KeTDUGKfli0yzcSJoLnJVH9m/FAIc8OXQJKcYNhEAPtvI/XGuGqWmijJ9T/dR7IUMF7vJvhaV27flZD1GEmRxlI0Vy2hkE2JUwlzb3fMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m8pqydK0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3453363a12.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764087636; x=1764692436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ1eFsM5Tf65QYOWpuLGzqCys5d89vyL8hwXtzNFx0s=;
        b=m8pqydK0/1LM6RTMUJvo+Lm3LHPrxyJXdiNi3oFhWUuWyOlgAAnHbngCi1KaFd9Qcv
         QyzDY9yCXkm6dRagxrM8eAkx5/kaVPhSIpYdAkO9Uw/Pi3uo7I7Me1h/HGkXaTGGp2z6
         byf69FIKY5rw7CVMKl5Kze6fR4g5A+tcMHXIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087636; x=1764692436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ1eFsM5Tf65QYOWpuLGzqCys5d89vyL8hwXtzNFx0s=;
        b=oxy18ofsBgeVgCrJrhNadx2iMCHNv2/q5oo5yhA3JQT7XNdofx80M6NHdSD5hagV+I
         FHZynocakxGQCVPCCiOrs9SNezIQ+znACx5QKKbsav5dYmctRaPaHS0/LBYg/WuHIs00
         +jWyc/oydkcAtpPsEZidYLnL3TU9x5jiTG7wOc7bsYtYUtxDS+MWE8M57/1oCaeZlGQj
         JtMcwvq5ai7AkECKDdlJlMjYJqtgaoo+FZovh/yorMjTKJRuIVa6H/5JZyqY+aiDg/KN
         PabhI05oNVagvI7Envx5aRUrNf0S16SdgM/9aQHGG+OHtHLHS0yMa2//Ml67qpziRYSu
         whqw==
X-Forwarded-Encrypted: i=1; AJvYcCVAcJ/brYVv2xuDrOjDgetvkFwhTSXBTJK34w30w93NaWmuTdiltiM9QArzrOmPGVlIgKYBn6+7bvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XgwWWeQLaNqNio7reQAzTA27igQvPB/8MWfXBt1yQe/E9qam
	RudnkNHkOqwz07H75LEfAjDOmZvxd6PvlviHhOGDfLVEywAzwn2FYcK33WjOiFiB6w==
X-Gm-Gg: ASbGncs1h+7UaGns4YhDDGMCIsjxyI2jzAnY1BRUH7TP7jaby+Dj64yzYP+R6j2Lt+p
	Ugs48diVX7NCpb2BBulMgt3W+a9C3LSjxDbCXaGnZHkkDv8Gfw7UHMLXPKg047mpmxPvAjKjAPQ
	B+p0aDyDb61eK94FxMfcbuP1iRkKJ0HBsQuSturowFF/TuVypP6n6ysOHmfhGj1irkb6jNOIhND
	1ybTGOTTE3z0Dh7eBij+3EQ4L8oNjASAUGmJLhlT/w0cahjgVejY+mlrQeETLjbu6CyYKNkqJgm
	9bHcrEPkoL3ycMvTqJ6pHDeZqBU9aIf9NA64nzC/MlmxwM0wn21kt0yXqCzyrSX+ppwLqR+62Xl
	OHKUkTw1EMc5f0P5ptCh7xqVnx12nTB2vLFcHcONmbhd0fOC/CFxl+R6TaGw4fBw3SCemR+PRaO
	taaC9TrHGCVBKvTpm0VVIrizdVcRpUO84NhKGDoSt9zhT84YHJJQ==
X-Google-Smtp-Source: AGHT+IHbxub078qD6r8lEEf/qWg01tDyiVQO7hyfzM7kwN7R7kHugcJNQAoH42YI5h55+GaIaK5kUQ==
X-Received: by 2002:a05:693c:600f:b0:2a4:7352:dab1 with SMTP id 5a478bee46e88-2a71a127485mr10175866eec.36.1764087635917;
        Tue, 25 Nov 2025 08:20:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:62e0:9ddd:dee9:122b])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a93c5562b2sm13362986eec.3.2025.11.25.08.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:20:35 -0800 (PST)
Date: Tue, 25 Nov 2025 08:20:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aSXXUmfy77ZAiShd@google.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>

On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> When transitioning to D3cold, __pci_set_power_state() will first
> transition a device to D3hot. If the device was already in D3hot, this
> will add excess work:
> (a) read/modify/write PMCSR; and
> (b) excess delay (pci_dev_d3_sleep()).
> 
> For (b), we already performed the necessary delay on the previous D3hot
> entry; this was extra noticeable when evaluating runtime PM transition
> latency.
> 
> Check whether we're already in the target state before continuing.
> 
> Note that __pci_set_power_state() already does this same check for other
> state transitions, but D3cold is special because __pci_set_power_state()
> converts it to D3hot for the purposes of PMCSR.
> 
> This seems to be an oversight in commit 0aacdc957401 ("PCI/PM: Clean up
> pci_set_low_power_state()").
> 
> Fixes: 0aacdc957401 ("PCI/PM: Clean up pci_set_low_power_state()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I'd like to know the status of this patch, with the merge window
approaching. It sounds like people agreed it fixes a confirmed
regression. I also don't think the request to remove all power state
management from all drivers was a reasonable one.

Brian


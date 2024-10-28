Return-Path: <linux-pci+bounces-15491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CF9B3A8C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B794B20B4C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CE4173;
	Mon, 28 Oct 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPo/NgHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C716F851
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144144; cv=none; b=nOzgYbbuxyLJ3YBYgaLzOhK/EhkKS6Sa7yaUIqg+NUeUDM0B35OB0oVQGJhFBWswhs5XTcJqBa/g9ct2XCLnqptLOBNHbB+LNA1weKAChcDGJW4k66YFbRNnd3raMbYb17KUJ2x0uatjCjNJ2gxtT1iqTHxRSHqRKCRuQMQW/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144144; c=relaxed/simple;
	bh=6YExgadhbkJTDJbD6FAdVwHiGcmNXy5OOdIVzRwDWxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVRTZRifLlZxGYD0EXZHYGskfKkcgPKsage2MVs5Z20ae09J7gYQxHlPhHB3dr/BKEHQU1EFm5EspAb0SsXrZ3iNVm8/iHQwsLUMKcFyd6WqZMCoyS4vKK0Fta0Sto3UmJKT/wxfaF/CFyl02nYyDxYNRR3o40eFV+ubcd/Y4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPo/NgHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730144140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IT1XBP49aC263EFs86TBZVAmOqo8AYuqCh+kWaZ23SA=;
	b=XPo/NgHxpuhEYjMNHHF432OfeK1d9sPyLWa570DTVA5IoPgumvYgGCqG5mAwQDuDbuDuoI
	mKtOXk5ZysPN1fMrhf1b4F+Zhg6Qbajud10lMqKgTyMLy4dSU10N1JajD3m1ZVlAC/S56M
	zSw32u5DV7vZnqx4DphEKKfdE0oLc5s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-vZafDy58OMydl8nkm_fm7Q-1; Mon, 28 Oct 2024 15:35:37 -0400
X-MC-Unique: vZafDy58OMydl8nkm_fm7Q-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac065de2fso45591839f.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 12:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144137; x=1730748937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1XBP49aC263EFs86TBZVAmOqo8AYuqCh+kWaZ23SA=;
        b=NM15COvki6LuTUGiJqJXHH+L5rBAZVo7AlMgJp/S6dG7ksHvPJanCQO4fA7++6tXAS
         Wj7iolsFCNoHxSqap53M8uEba22CuPnrEcIR+AfsKwnSy81XXoXDaeXi6uFxioxWaInl
         zBdxxD0/xaZUP7MNaXtwznseNMS81Zedtxs1SuWczMmRAyl4ZCm9F4Ybp88DNmw3iaNO
         mguBoIAmwaGRSDSzON4z25HY6UghXZb7WEstOrpofFnuvMVxY9dHmKWpAq5tWx0MDCz2
         c3rpQ5XRQ51AEsfj1/8ekKPakVKIMqSFtHzuYMvGTVhLqdBKGuZDPkCqp8Y1sTlvJfCm
         3vxQ==
X-Gm-Message-State: AOJu0YyfxXO6ACPUHbdBLhJ82BH0p382xwHmBw2QLb5LcfC5x0WXZK1F
	apWL2+31B0JLMYUAzvMqbjxfErjRmyR9iUeebY5Y+Uo3RINEq1zv2WlntSXuB2tDUYr/pdTjbwQ
	ZJ52JpOyeAuQ0i+J5t7eR1mRqsbaAC2vNcfHE73yI7biOm5lEQ4W+ftY8HQ==
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:b1c4:817e with SMTP id e9e14a558f8ab-3a4ed2fbc79mr22498005ab.3.1730144137071;
        Mon, 28 Oct 2024 12:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT0+f70bn1d8nXzldkd1MlN+DRMX9vKd1g4oLD+TH10yMiFsI1wzjZc6mHHkRTlAScfYMUOA==
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:b1c4:817e with SMTP id e9e14a558f8ab-3a4ed2fbc79mr22497955ab.3.1730144136766;
        Mon, 28 Oct 2024 12:35:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6de0923sm17672445ab.27.2024.10.28.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:35:36 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:35:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
 <ameynarkhede03@gmail.com>, <raphael.norwitz@nutanix.com>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <20241028133535.7e24e490.alex.williamson@redhat.com>
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 15:27:54 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> Resetting a bus from an end device only works if it's the only function
> on or below that bus.
> 
> Provide an attribute on the pci_dev bridge device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> action.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Moved the attribute from the pci_bus to the bridge's pci_dev
> 
>   And renamed it to "reset_subordinate" to distinguish from other
>   existing device "reset" attributes.
> 
>   Added documentation.
> 
>   Follow up patch to warn if the action was potentially harmful.
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 11 +++++++++++
>  drivers/pci/pci-sysfs.c                 | 23 +++++++++++++++++++++++
>  drivers/pci/pci.c                       |  2 +-
>  drivers/pci/pci.h                       |  1 +
>  4 files changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>



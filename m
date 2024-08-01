Return-Path: <linux-pci+bounces-11110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87567944EE1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94751C2298D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86413BC39;
	Thu,  1 Aug 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M36sgQNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D013B7AA
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525271; cv=none; b=VsrdrPkHdkEFy2TDI1ui59MfJATK9j8EM7Dge1i46Ec1wFBsdpJSe/YzwzJMJanLn8GhYv4kFzaMHrHjunVCzgnVWoeEBT2fo26yJ/ev8Z2cLUerc/A4F34w8THBJSzC3ywtm/hZffn2iNs5Ojelj/U50lvn8ZEZGpgduiZ3o3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525271; c=relaxed/simple;
	bh=6zG896h081wSzZwTxbbSwGb+cRj1aNxaS4KVxqGaW5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmvsmSVE9C2XSLtbbNeTRTSMFO4YrgqTSqviXHK+veolMJTYml81STqcSbOb5BheatxPiAr9LFEF8Ho7Ir0iGvB5sWm9BuBYYOR8PklR3C/7xkFafwQ6ClaPII5071ujqm+o84p9w6FDHDxh2ghrgqJJOrmE7/0x6wNn/eXXqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M36sgQNk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuCkGuyhUvwr7K6Rptn/zJ7I8ssejuyGxAvNdiT19Sc=;
	b=M36sgQNkx4kFUOCiWiTWWOOlJ4ftnpRCTK62qhmFWiCNMsFqz5atgTqqFPG4EHEHw5cte8
	ZxqcvtxdQqTtkbyPuZRTQ7qXvMyI4l4Mz63ZMni3r4tlp13GTohYQYitH9wnp72aG5fNrp
	s9BMdeiutYPP7yuHL2VzzuimbGelLIA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-kfi73ARVNmCYsmjdjJExNg-1; Thu, 01 Aug 2024 11:14:27 -0400
X-MC-Unique: kfi73ARVNmCYsmjdjJExNg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a32a9788e7so2901373a12.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 08:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525265; x=1723130065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuCkGuyhUvwr7K6Rptn/zJ7I8ssejuyGxAvNdiT19Sc=;
        b=XTAcNWulp3QgXNdpnnmZWyKdwJqHd0kBl8YOdL9FFhikJsyTWU8bvFuOXnj9NAz/3h
         OMc38RBzqtnrHB7SGO2Hjvpuyu/sM7KTG3i7yzKVohxBEArI6Pz+7eMjVvaOVwLpfiES
         h67HawCCrNF79rmEXaqKpn0UlCEyaXx6/hXpfVk6C93jFtFMCFbHg/aVliVno22HEGU7
         YprAk/iWh2Qk8tD3hb5VLIt1lqxHcqkXLOF+AKYGUBp0ohn8vD8pPahl5BzKC+B/ofwe
         7styd8H4+h0cGgD2bCOs9tnU6YG1Hb4mvO5FtnY2bHXy6JvIsfc+ui23QT8qmOkrfKOc
         OBTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWW+af+1Hzw9Qw5lzbXto50mdSdyxz6JPzEy35OoaYwsd+ZtXw3b/PJzNspFpEcezWtmWuFD+cClP2Om1DPi1WlWIbfukQZ88S
X-Gm-Message-State: AOJu0YxLm0YS1snYNxwsfSQRgJ/5wrYHCGuwCSwNstkGYSRyJb98JDGj
	fn48wtv+eE5xIt0axc/dO6sNnyurBPzvzptAkmZStBUAnvQa9OhnhWxwm+dgcrM92y1g7vfooPo
	JQfrjtPjsWZiZAEHxje+jfEcUObBfq29cb45QQzTor6UTTwwMzoGhJYJBU/w+hgCIsw==
X-Received: by 2002:a05:6402:2550:b0:5a0:d5f2:1be with SMTP id 4fb4d7f45d1cf-5b77c2907f3mr1879065a12.8.1722525265336;
        Thu, 01 Aug 2024 08:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj4LCjAaF+V8VlhXK/sqH12Rf7Hd/3c/VAvvA4FypQ6qwCir32eUK1KIAGbf0dTmiuyK+YVA==
X-Received: by 2002:a05:6402:2550:b0:5a0:d5f2:1be with SMTP id 4fb4d7f45d1cf-5b77c2907f3mr1879035a12.8.1722525264801;
        Thu, 01 Aug 2024 08:14:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6358fa5esm10285512a12.32.2024.08.01.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:14:24 -0700 (PDT)
Message-ID: <8f6cb906-fb82-4737-89b7-15ab3c92d430@redhat.com>
Date: Thu, 1 Aug 2024 17:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use pcim_request_region() in vboxvideo
To: Philipp Stanner <pstanner@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20240729093625.17561-2-pstanner@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/24 11:36 AM, Philipp Stanner wrote:
> Hi everyone,
> 
> Now that we've got the simplified PCI devres API available we can slowly
> start using it in drivers and step by step phase the more problematic
> API out.
> 
> vboxvideo currently does not have a region request, so it is a suitable
> first user.

I have given both patches a test-run on top of 6.11-rc1 in a VirtualBox
VM using the vboxsvga virtual vga card:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Also both patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans





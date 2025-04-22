Return-Path: <linux-pci+bounces-26442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D3A979BA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F249E5A0F97
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2F225402;
	Tue, 22 Apr 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8ztjYqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648224468F
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358665; cv=none; b=K4X3nSGNhKlbSUr6H5Iz7HF76RcBSMHfDDpZmD42NqyZ83meiqkGjZWFSWnne0PGPgFRKmJuagbf/7vIEyfwJO0wC+HiSOefviWmngE7DuMTuqYvl+9jDcWI1wZtNeTUr8ANYoNGi/nDZb/AQ3tKqP9nwJLT8nOQcjbimu2uGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358665; c=relaxed/simple;
	bh=G1t682/Z5YQhVNZg2BBqTHLGZ0BD0DRxXvelvkk8FdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRHd0EIIe5bLVQSLvnu6C2clEdzwvZwaZ5wUcO/fpbR4FsyQgdd/kqLZGJ//BOQ0/b9xabJCYfORsDvstOlohGoBCMj6Grxf7qG2pA9kPRWB1bl3wNWI5wKsBo/wuewREopCmz6kSIS/XMbN3XWqX9vJkyI7atALCHdHyczd5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8ztjYqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745358662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1/IDzJNwKu9ird3fpx4gSzjCeLeBaq8w8B6OkdB/Zw=;
	b=O8ztjYqZn7Dq/MsV7gop/W+m8c0MZ/ikFT9yZ0ZTpETKITzYruj7B9Vls4Mo2Yb3uSespD
	ofc85YFLGH6i+/2aR+HKj2EGWkgu4+Kzqel5XN6H+SaH/dk/6qmAcChASVsSa2LnaQkJlk
	6jDVq+/I4WHdyw0z4EceMTt+sLmfvo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-kW9rdWMvPOuKMryFkvKyNA-1; Tue, 22 Apr 2025 17:51:00 -0400
X-MC-Unique: kW9rdWMvPOuKMryFkvKyNA-1
X-Mimecast-MFC-AGG-ID: kW9rdWMvPOuKMryFkvKyNA_1745358660
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso30565665e9.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 14:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358660; x=1745963460;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/IDzJNwKu9ird3fpx4gSzjCeLeBaq8w8B6OkdB/Zw=;
        b=Ft1VvowjIXhcES0EZa/KFaBELkVc5HwJWGHUYOmsfdUghT3/scOwhcrzeRbzIKO3Bn
         ecvrqy3hXuwbwVLqAcSBwCdf1D1Hr7yzoAg1OLG6g5Ok4tj4+y8cpIVi8lUZ83nEp8HC
         SBb8u/cp+rayKCLKB4MumycMEOYsM5XelDcv+pyspzH8R8EbsyOqlkAgpYVVwjGmwtZY
         L+ZwOSd4m+eE3lLk5nqH0PHFT4NgCJK3qKsOOpfNvWlq7uSh0a+akrv7d3SH/0AxrZgr
         COKtk6OlHRuu5oGKhGE5ftGzkjyqwiHQ/XtgW5DadfDmTyYnc309xGiXX6jenvdLvmdl
         oXhA==
X-Forwarded-Encrypted: i=1; AJvYcCV2KMHt3EGQZWoc0EsgqO2HO2zsCT0uludbkxXOCkgWXDOZ0LUHAIRDoS1SIe/kQGcZq4T6J15sJZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMj5ySP+B2cTeXmkX5LZTiEjkTiECpwauTN+WrTn3FChY2/liy
	ev9eGQGaS4l+MkudngIAI8UbOFncy5vXuPOpOT7+N7M800IZ7/3UhhcfnlD8I1pImYmf/8rGxqr
	dprLrzGCMaJ1JOvRf9o5JhMicSW7K+25FXdVQpt5GgQGWuQv8cSk526a/fw==
X-Gm-Gg: ASbGncvvXa0O1xCOwaPnqwcjzR8CQpr2GgsutqyOyyy37LCOW7AApl4hUofXI9KKNsO
	iXY+b6IdgrJ34S1ocx8ALcUrzy5xFS4QlhXuaCt8k1bpQVOionar3BqPtZ+GAScpeBz8bAWSrEE
	HHHrfVtgUuFA3Zl32SOYo2F3yMTdTZh+9L0hDqUkoZkFaxayEw6TvuVxTilstlKlgoXV3jOXLtl
	BJzDXisuO5Eid3BSEslum4y2b4Rm5u0mm7j8IPmeZVpX3fE1gX74nskLIxgp+KTCl6rKioJ4SjH
	vE8zDn9UM+41PrNhskNUSMnbXBembu2E1SwH7nslvhcS3oGcuUGgJtHJAck0ZLCBKztTvw==
X-Received: by 2002:a05:6000:4310:b0:391:4189:d28d with SMTP id ffacd0b85a97d-39efba6c0d3mr11525092f8f.34.1745358659705;
        Tue, 22 Apr 2025 14:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQa7VnBYSPz5ieTPf8xaFFrtEIeqU3LTi5lgcJyNHMvngJBWDCobliaFl6EizYRrF/Sw9Ww==
X-Received: by 2002:a05:6000:4310:b0:391:4189:d28d with SMTP id ffacd0b85a97d-39efba6c0d3mr11525085f8f.34.1745358659393;
        Tue, 22 Apr 2025 14:50:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4d67sm16699401f8f.94.2025.04.22.14.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:50:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, iivanov@suse.de
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, "open list:PCI
 SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] video: screen_info: Update framebuffers behind PCI bridges
In-Reply-To: <527b7ebd-0a34-4fe0-82fb-9cdd6126e38e@suse.de>
References: <20250417072751.10125-1-tzimmermann@suse.de>
 <527b7ebd-0a34-4fe0-82fb-9cdd6126e38e@suse.de>
Date: Tue, 22 Apr 2025 23:50:57 +0200
Message-ID: <87ikmvc1by.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> cc'ing PCI devs
>
> Am 17.04.25 um 09:27 schrieb Thomas Zimmermann:
>> Apply bridge window offsets to screen_info framebuffers during
>> relocation. Fixes invalid access to I/O memory.
>>
>> Resources behind a PCI bridge can be located at a certain offset
>> in the kernel's I/O range. The framebuffer memory range stored in
>> screen_info refers to the offset as seen during boot (essentialy 0).
>> During boot up, the kernel may assign a different memory offset to
>> the bridge device and thereby relocating the framebuffer address of
>> the PCI graphics device as seen by the kernel. The information in
>> screen_info must be updated as well.
>>
>> The helper pcibios_bus_to_resource() performs the relocation of
>> the screen_info resource. The result now matches the I/O-memory
>> resource of the PCI graphics device. As before, we store away the
>> information necessary to update the information in screen_info.
>>
>> Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
>> EFI framebuffers") added the code for updating screen_info. It is
>> based on similar functionality that pre-existed in efifb. But efifb
>> did not handle bridges correctly, so the problem presumably exists
>> only on newer systems.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reported-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
>> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
>> Tested-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
>> Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.9+
>> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



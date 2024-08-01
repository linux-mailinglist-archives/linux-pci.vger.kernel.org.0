Return-Path: <linux-pci+bounces-11111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA761944EE3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1E01C22907
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B49513B7AA;
	Thu,  1 Aug 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9086Yba"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692413D510
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525307; cv=none; b=Y7fvmrsP5LKFEbnD8pKRTJw5aOXMRClahy7Ckf45kBqcXFH4Y+NFn/PmJVwV5nAGVY1/iYm7yENlFdIwHs+MZnJisOiSlmSDjoLeZaBsuaScZ+f3LSWbbtny27gp4EJNoNOLhjfEvOy3KpbKqM4iugrznDLlrDNXZ78ZrFBAqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525307; c=relaxed/simple;
	bh=A6OP/jfK6PATMbKxzMFvI0PTC7EIM3acs2hwnW148PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsSCwapRKSpY7NmtQSDvPhNI8WtflPV4fhr77wC7GRJ/q3VfzVuaHoct9teyfbcDfDWo475zk2GJvw7Eo9MAI+taOJflUnHgx34o40SwoYcfatVQcKZXB6pH3MQ+lwbofShv9ZcMGQteoBnU+ilh9kws+H65cOcBhR5RMDOKBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9086Yba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6Gz03hDTttvd+7tl5OFVJE3QFtRiPUFMKGDnDxPPCM=;
	b=X9086Yba+mAGF7VIIrurHCxsdhWLkiPSkml8WOcFBQFNaIO14nbvZi/HBdU0/TVSheHIeo
	QSMv9K08Q0yFgZgR7/XwwX1KCyaPZwq+irS9a7Klx7818DvcfuEZ1VyvClmSV8wgILwhLs
	XtKxqlflZkaMqGR53y1FjQXCtbwE+wQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-PmBHLTGpOPW0RrFIGn3XJQ-1; Thu, 01 Aug 2024 11:15:04 -0400
X-MC-Unique: PmBHLTGpOPW0RrFIGn3XJQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7abaf0aecdso517379666b.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525303; x=1723130103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Gz03hDTttvd+7tl5OFVJE3QFtRiPUFMKGDnDxPPCM=;
        b=c2l3JDa11HnqvrY4YrwhkJERIvq/K9ahdurLekIHeNFNpZZmVpLnM0qstsO6bJhNJL
         juDetc2vvGcYuDSorSbPNhiGclT+3NWRycQ10nuK8hYU3Va3xhLt90k0hPiJdciRy4bd
         S/FqfqB6/COXGkyksBkzEQwWJUoJkA08UgkCe/+U4Uez8PdJc1Ix0ANBGM9Xb8WA6xxd
         FA/Kic6yawfh/0B2ZX0dmqlnca+jLHZoIjeknAfzGZvWPcuY9WxpzHhEiAR7ytt6T8x5
         i6sv6dk9795L9vw0ly7ExrgKrAmY1IZDY4jiT7rVteNPci1AFhFQ8/cVNlT1J4gPfAoU
         5CyA==
X-Forwarded-Encrypted: i=1; AJvYcCUyzbteQYBhmRFJt3XZNK95vWPlOcblxUTindo84Wlcb3MIbKhlUmEm9WjWT9k5WP0F6GtttanO5tUD3qqisyveSbTTAtYPZseY
X-Gm-Message-State: AOJu0YwhY6fZSYFeQORbNaWVlEowZcVYgjLGXDQoPc34fH6Zv3m1Seix
	h7QN486xoMxRHd6bAWnyCt0JohTcNfmwD7w9+u/rhOvQlH9ARuPLMIxlFwI5qOUaPYI43IYpMHn
	qVijLq1DinFY5zN3DrUHrnyiiFZSU+mNfxUa1zDTapVU0eFZt5sKGmFbjTg==
X-Received: by 2002:a17:907:9689:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7dc51c26e5mr32398266b.66.1722525302611;
        Thu, 01 Aug 2024 08:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh8sS8ASeCL7tbxerggOYvsOegLjh6xAqrTG3CZcz3y3qa/PkPBjyHfa+gnp10im9bRcd23g==
X-Received: by 2002:a17:907:9689:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7dc51c26e5mr32395666b.66.1722525302110;
        Thu, 01 Aug 2024 08:15:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41621sm909036366b.113.2024.08.01.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:15:01 -0700 (PDT)
Message-ID: <9d9436b3-4a6e-46cb-a98c-f168bfebbe3f@redhat.com>
Date: Thu, 1 Aug 2024 17:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use pcim_request_region() in vboxvideo
To: Bjorn Helgaas <helgaas@kernel.org>, Philipp Stanner <pstanner@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240731193605.GA77260@bhelgaas>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240731193605.GA77260@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 7/31/24 9:36 PM, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 11:36:24AM +0200, Philipp Stanner wrote:
>> Hi everyone,
>>
>> Now that we've got the simplified PCI devres API available we can slowly
>> start using it in drivers and step by step phase the more problematic
>> API out.
>>
>> vboxvideo currently does not have a region request, so it is a suitable
>> first user.
>>
>> P.
>>
>> Philipp Stanner (2):
>>   PCI: Make pcim_request_region() a public function
>>   drm/vboxvideo: Add PCI region request
>>
>>  drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
>>  drivers/pci/devres.c                  | 1 +
>>  drivers/pci/pci.h                     | 2 --
>>  include/linux/pci.h                   | 1 +
>>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> Given an ack from the vboxvideo maintainers, I can apply both of these
> via the PCI tree so there's no race during the merge window.

I'm the vboxvideo maintainer, merging both through the PCI tree
sounds good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans






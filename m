Return-Path: <linux-pci+bounces-1611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51668221F9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0E1F233C3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092115AF7;
	Tue,  2 Jan 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwbWxHwa"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C615AF6
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704223706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ/i/xMtI4WK7rc02jogXWNeclW4uq/A8ibcd1aMymI=;
	b=BwbWxHwaIY/p2fmFTxma9j34KOrg30XJx+M3YuDBmaVPi8yUUk/DEpiC0f7LWc9M0mMlEk
	NAnv2OJ7XoIXX+TIXasJ/qxeKF4q6QWL3VqkEnsoerQzvMR9z+Jsh5hklO2I0FjIIzf/4+
	WJ6BQpQ15pMMJMZ7bWTkZgkN80Vmo3Q=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-TlGNiTuzNdSj3CF675G8bg-1; Tue, 02 Jan 2024 14:28:25 -0500
X-MC-Unique: TlGNiTuzNdSj3CF675G8bg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bb0af58117so873720439f.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Jan 2024 11:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223704; x=1704828504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJ/i/xMtI4WK7rc02jogXWNeclW4uq/A8ibcd1aMymI=;
        b=X7J1KwQOiCLZWhwDIF0BNyc0QPaFB0Mz/Y3kYzuap8fW4qXnHaW40lWw1dRxKuIyUl
         9C/hd6pf91W8tPTP93HFVLuAzzQAMXnIC6RkiX4/Q0qPRagMFzQqI6Uq7RExgZ90bS17
         E9HKZ5kMLExp+uIFLKO5jmcp4128EqVxKna5hf1nD1OOZRvC03jIMPHMfYDMj2lP4dZH
         AfPyU0wEmHIn+H0ZbVGI2FfW5Pj3pl8zq+BMYAtfsNK5xqlskSMqZabuSYOmlDwNGwds
         ZqoBpzsrrrJ3M0VXb91fVtgxJcIXuFYfeIvpWLSDKcvNdSe6xhPpDTkLyl2NGkGxInD9
         SCRg==
X-Gm-Message-State: AOJu0YzxqUHO/rfunK8L2N1FgbTANmI1XtfncwImA5tT6sJmN8RLeHfb
	yUBt+AJ5/3ccW1i+X/Ab6m3v08UdtADn/wqubDqgKCBnx/EAqOdRXrVWjuQlVZVwjw6GgnI/x3/
	zN3hbpMFc+xs60urKuc2/gLjclMsh
X-Received: by 2002:a05:6602:1512:b0:7ba:7fd1:a638 with SMTP id g18-20020a056602151200b007ba7fd1a638mr28289283iow.16.1704223704674;
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQt0k9BpNBf3awzoQ+iFyFl7hdWVxVsXotr+x2FmspxI5w39AFpAC/MeGYdPjdqaflGn15gw==
X-Received: by 2002:a05:6602:1512:b0:7ba:7fd1:a638 with SMTP id g18-20020a056602151200b007ba7fd1a638mr28289276iow.16.1704223704472;
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cf2e000000b004647af59c3dsm6948475jar.16.2024.01.02.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
Date: Tue, 2 Jan 2024 12:28:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 wutu.xq2@linux.alibaba.com
Subject: Re: [Question] Is it must for vfio-mdev parent driver to implement
 a pci-compliant configuration r/w interface
Message-ID: <20240102122822.768f979c.alex.williamson@redhat.com>
In-Reply-To: <ZYo6rITis9siz2Av@wuzongyong-alibaba>
References: <ZYo6rITis9siz2Av@wuzongyong-alibaba>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 10:30:04 +0800
Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:

> Hi,
> 
> For vfio, I know there are two method to get region size:
>   1. VFIO_DEVICE_GET_REGION_INFO ioctl
>   2. write a value of all 1's to the bar register of vfio-device fd
>     and then read the value back which is described in pci spec
> 
> Now I am curious about is it a must for a vfio-mdev parent driver to
> implement the method 2? Or it is just a optional interface.

If there's not a working, compliant config space, the device shouldn't
claim to implement a vfio-pci interface.  There's vfio-platform
available for non-PCI devices.  While the BAR size may be found via
either REGION_INFO or config space itself, the BAR address space is
only found via config space, ie. memory or IO, 32 or 64-bit,
prefetchable or not.  Thanks,

Alex



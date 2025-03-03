Return-Path: <linux-pci+bounces-22737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB72A4B874
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C087A33B6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6431E5732;
	Mon,  3 Mar 2025 07:42:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077565CDF1;
	Mon,  3 Mar 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740987774; cv=none; b=JbADlnDrUTfx6L6duGC5u/IjBi5l3NVPoQb59fqVFnxv11rQWfEKwpfTmFmlmrmv/c5dzByuM4K5GlP0Ul1HYbqxX3ipmri99Rkg7yMa8f5tnVQ633ptp+oLraF6xbR9ki2opIHEDQb8IaMUdMM0NH+qb+AV6tbOKaj2JtVcPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740987774; c=relaxed/simple;
	bh=+2Sn+iYEFCKfYOQIlhAxteVS6EByLscXmdmM1M2uDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovw85VghAmDarBXjubkSSItFR8+WjTLxBBgw+G80RB73k5RKw/xXyCu+DmNBtk5lQL7BkUyfTsofS69UrYna0wB7pJcFfQLmfR/eovegW7mJwwLOIAgv3Bj9t0DsQy+/s5RXCXJlSJsgRHXRroy1rtkQLSp69SDizs/d63X9AWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2237cf6a45dso28463235ad.2;
        Sun, 02 Mar 2025 23:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740987772; x=1741592572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTZq9vAnTi9Y0SBA/iiCs7R+WzS9iIoMHVnx+pOmNYg=;
        b=EiWt1xwVf67BA57EkFqTtt1YohaRauZhjMod899mZL7PdQkYqu5hOG/CvKePiTagO8
         G1twHj8UL0NYl1hVhTd87ZEZMPhLiJnWPfHBg3Y54LBJIHFlbeVw3HZIkMCEcGzNrkBL
         +LXKScMYZhSjWgab6z3mlpq83DLrnKvnSG+AH0i+jtpBHTQrOp04G7qx08Uta7603+1S
         ZakA7ARsP0oC3v9i9j8/nOzDduagdkdhKnp8lKDogWkn8htXhWi7+qTvo6FOwF0KvQPl
         5pafK+XIKMx+UYBmJdxPCWB5U9i3hfC4clRp4a7XE95I4S/Bb6eVsS7B5coU0TFtRSdh
         cvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVMmuxhMIyz2loswT5/e3ZJ7bQLX8tR5WP0FnmrZzxlHvYUMpliKGDCbNufCbnLV4o9i3H/VzGG2RNwas=@vger.kernel.org, AJvYcCWCd5q9KXI6V33WoMwwHlE84aUiJfQoaRfSnPVxHr0n9b5k34lh+aJaVQuJkfheO+QzHAfCwogq@vger.kernel.org, AJvYcCXzmHeYsDblBZbsw5vPVn3CvRkqHR83rwZS3R11wG48m1WEmhhFzgk2VbTxRzbBI0Cf3KVUMo8e6BRm@vger.kernel.org
X-Gm-Message-State: AOJu0YxE06Es3Jir7hits0oTRSZnfOAqfikCb4K1uNMardONDhIhnoNa
	JP4dCS+Fm7kqL9HP43NTnjlj7QfVGYXg0jjTZ5Qg9hgX7G/vlRKv
X-Gm-Gg: ASbGncuZTDZ7iOXFPJIify/WmlsxQWaoDo8l4zyEya2btLosdTntuI0W9JaH+8zRFAk
	1ENIfMwrdMKD2N4ZTOhQ1jVIu4lQb0r9IxALT2Fa8cTCsntKQiZ70aXuITl4dsYnv73oomgj9gw
	Nbi6sAA/q654FpXCc9YHaYapVPi4tUQeeaSbdywoFKOrIeUX18u66Oh5/ESyG4fC9rGol518Hm5
	vk5p1FQMl/uLzRoke2yl2itbDsiCdM2qZRgYD8R83WWkcH/7IRPyJHKvdvcfm19rnxSnfpKGsyW
	EsvzbEzi8EZx/7JlV/r/96bbrMZAe+YcgmPxMr6dh+Mzj5XKSIAXekttuvTsaEPXucwHyIkdKfS
	/gSM=
X-Google-Smtp-Source: AGHT+IGHrXuLIgZ1EjE8WaDVVeXQsHcwmqjx8dj+lzALvku7HWKDWNrYrJAv5p+NZDy/pNps61R8hg==
X-Received: by 2002:a62:f20c:0:b0:736:3184:7fe8 with SMTP id d2e1a72fcca58-73631848087mr10143155b3a.2.1740987772171;
        Sun, 02 Mar 2025 23:42:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a003ec4fsm8441221b3a.130.2025.03.02.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:42:51 -0800 (PST)
Date: Mon, 3 Mar 2025 16:42:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: bhelgaas@google.com, treding@nvidia.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] PCI: fix reference leak in
 pci_register_host_bridge()
Message-ID: <20250303074250.GA138071@rocinante>
References: <20250303072117.3874694-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303072117.3874694-1-make24@iscas.ac.cn>

Hello,

> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.
> 
> Found by code review.

Bjorn took this already, see:

  https://lore.kernel.org/linux-pci/20250227220124.GA19560@bhelgaas

That said, you need to ease on the resends a bit.  We track your patches
and we will get to these eventually.  Please relax a bit, and perhaps focus
your energy here on offering code reviews for other changes, which is
always a great thing to do and helps us a lot. :)

Thank you!

	Krzysztof


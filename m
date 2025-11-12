Return-Path: <linux-pci+bounces-40968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBAC512B1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB8754F0BDA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAB2FD679;
	Wed, 12 Nov 2025 08:45:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9582FD7B4
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937156; cv=none; b=szV/Gd2AzFOJLGKxVeGl1vbeguR61PZpaMq7D9IxbefsLpzXcXLpcy0R9k5/TtrxqEzE0WfbUMA2kqR3AbTQ+ZyCyVIuG6QQ/dR4px5jtxhaDIhLlszKHtihOe2XEeB4V8FZMfg0PfIprpTS9Jf8OzLNpuHa5aa4xBIHwCtAx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937156; c=relaxed/simple;
	bh=XmdKTnnyHUqNeiEg8lR8cDQAudHSJCs3xM8SfYCQvGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoO171bOXl+pxfZC2oZR+n18ttiQyG49GiDgCQZ1Un5WzE+nhuHxn9jfZ76lewbr3+pRgjl1b0Duob+npc9mXZuyDfB8NevUAhGw9Y0Mkl9oPRBskofIS+arAXwjlVP3Kp2nj5f8cTCXM9PXrnFpzrX7e1Gsfi8TYLHy4jXAoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso820487a12.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 00:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937153; x=1763541953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1x6mI9uM3ReqDgxtDW/pYEZ50tke1MXkEHtEWx3A+g=;
        b=FyMLJ3YA7pGXucTqWFkZA/uiuaNWdTZas9/5dHi1KfEhfxc4++jvuWLlwLZI6exlPb
         tABDGe0PxOOg6grkgviXUk9e2Y0fVlAP7jjyLC+O150JdDyBjAyzlWVxCe9KHtJG+dKg
         /UBFsWl9EsJMA6flZH+1g5A+jirAEVEEul2PU6GfpAnkVk2lNUT0pGR3KLZs4v8gx5v1
         msPt/9EQOLy3e7qCF4NVS0Ru/ruIXg0c2Lfvf01xVA3QNablFfEMfddejZDKlrLUBaTz
         /uelxMmzWv0ZK/TyawUobHZ+re579iAjmm0uxXjYaTFVP3uTiKiWU4NB/k7zzkPCydoN
         TSxw==
X-Forwarded-Encrypted: i=1; AJvYcCXfv1qqUnE45OJW9Mdo2c2BjyTIfln0jzzaAWmOePhkhlqwP82lDfjutIKrXxf0EtKpT1uJtp6yGqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4b+QXtW2pfFP/IUU2+KO2xvMGvZ3sZP4f/rKTRiz34Jl50Dl
	FmpzcMU78GXo4ZQchyWgquaGWPKYGag1RShqcOw64sJcZjmkXCOSJoz8p/5tdSImrBg=
X-Gm-Gg: ASbGncsN5k/zy5i1fQys3cWhtvn2HoSG++/OP7j8PAa3XdGMWLhFOrwz9JZf4wjXpJd
	wfdoAvsAAy50qC92pJBxY44RD3Aci4/NCJLNkyOTd3CyLDpC0lBSsSnbpOl2kwKZ5h7a3eMnl3P
	YWHVlxUXfYocxZ1ex7L3zaVuFtl0ymdeTBy+UBLi6UHYmYJT+r8FDBRTF/5wOyBYfWrkbtAltZH
	efr9Mm9MuWD+UIzyF7Qhg3JSMJAdEYJe6h4/5i0JzGgukJB9up0u53zdWnGCdS8uFxt0Gb6NO4N
	1sQpVY1cic6okqen58CIOHI6n8JZcx6mkFzkXMtVK6R4aoZJTJ+ZCtWtmvgghVCtM1dJRF5+ANj
	ic3SV0YF9pdwBaZPSigFzo9ncE/mtuIK5CB93KtIJOj/7Dfr6gtrSB6479R+L/o0zDzkv4dHxWj
	yp
X-Google-Smtp-Source: AGHT+IFD8PZ00Y2eGZhZEudwtgTVJiohD/6vz79m6IyJ9+oDUE+6/ViIhC08fEaP0ZqmwfcQGt4tJQ==
X-Received: by 2002:a17:906:eb4a:b0:b73:28da:9ddf with SMTP id a640c23a62f3a-b7328da9ea3mr335461666b.25.1762937152743;
        Wed, 12 Nov 2025 00:45:52 -0800 (PST)
Received: from vps.markoturk.info ([109.60.6.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbf3csm1544409066b.26.2025.11.12.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:45:51 -0800 (PST)
Date: Wed, 12 Nov 2025 09:45:49 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <aRRJPZVkCv2i7kt2@vps.markoturk.info>
References: <20251101214629.10718-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101214629.10718-1-mt@markoturk.info>

On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
> QEMU PCI test device specifies all registers as little endian. OFFSET
> register is converted properly, but the COUNT register is not.
> 
> Apply the same conversion to the COUNT register also.
> 
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")

Hi,

Can someone take a look?

Thanks.

Marko


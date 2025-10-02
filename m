Return-Path: <linux-pci+bounces-37486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AC2BB5A24
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3793BF41D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552CC296BDE;
	Thu,  2 Oct 2025 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amD3yWTx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B59182B7
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448782; cv=none; b=iQ0XUDxljbTz9uOHzwh5CgnOoDFNLVlO+b0PKkPy64rVd/BD9pc68fX/7hZNoDBe+RlsAp+cspi+sm9zvxA6GeTdTeKAezZevUe5JK+wh+0BrI9pRC7oJQDIfx01YDRuFU5s52WICZ5q+Svx93hhPyeT++HU6u1hGCWxx193+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448782; c=relaxed/simple;
	bh=X63bvg1YZlwmLhpCHX+BAIwIdA0SqIxOzXRMvY/maX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX8bFMvT0gWeBNndSQgQ6Yc0mH2MZoRvd5ktU7WRZ8OpWkEGKxlm17WgenRgzXvDNcq/1uNfT1cwKzSpz4P83NOsfBRnke+dGBvwA9wandAfhVLLte2RfUN+HuHDH0sK6/cISnoubbqTGmfrHiu++dtFeg/9WXonS3xwuWgtrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amD3yWTx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eed7bdfeeso20991805ad.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448780; x=1760053580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lkOV4b3A2MO7m96wDkm9e6cy4JWkoD0EO3/osw+4Ek=;
        b=amD3yWTxCAovVN/funOF01RiShIM5oz2RFRRrOktOEI5Xs8U1Be/s0G24LyO8aOsUQ
         1x5eIdI/yr5vQ3oy1zfKW1NouzsIrqL+hOmUOQ982e/FiKoqWilywGQKzqUEsehQ9HcM
         lXop73hmdU7uQl4qdH0Gkx3UBRFCTW1XLcvvZkO9PHUuN4vkUdYlLyif3hUMKXB3InRo
         8osSqAq0Bk50HPqLSNtqLA74wz3n7Nk2X59mTldv6SSyQDzwCBt3RDLObfThaCk4zA6h
         oQ6Uga7X8Ti4JKTnd1hQKcLgwcsg3vclrtlHe+InDkQXWpT7OCZdqu1cNXcBDgqQW++z
         c8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448780; x=1760053580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lkOV4b3A2MO7m96wDkm9e6cy4JWkoD0EO3/osw+4Ek=;
        b=YMXYNlduwXUypfo2w756SKpnWs9bPYi/ud45vvuqFun/oGeV23XcCoNOlrEcDTv8dE
         obYofiAwpVxNdT53AiTpN7q395BzwVAq94zqVdkCQf3D/NV+0Ca1ksUbrx0V8oXj3hNy
         d65dhp7GxZ80H0Kd5KjwyXgSCVXTbPi/GKY5c9BVUHkCZn+edRuV0IMYiF5HAN5LnxOB
         5IzoR6BAgGU8vz4OUY7t+msHaqTS/AnM9ruZcAafZC3j+d1KjyhHP2+VGccFAr0ak4/P
         3RCv4ZEHzMAtTLFGPbUp+mjwg5kNDUaHVNL0sx1ROU8ZaUPO/G+5RW2zQbTaKDe9P3Bs
         Dq4w==
X-Forwarded-Encrypted: i=1; AJvYcCUG8Fe+1gU489YmSU+TC3Z8M5/HFwgSJSwnO1OLbvi3RmkC56M1U//iqhBh6Yuu7rqMNlkt0lrBHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLGBJ18C9dWtvrQoyaNPvEMSV8N+46IrgrBTB25lwDnWoowhF
	Dk4RcFsgI2dzwP27FwsxsesOFQoVa69+Z/k1OJyII88IgXdEyr1yXs5H
X-Gm-Gg: ASbGncsEklwSXE8p6veIfG10R14dXyIqw+4YlCfXJhRiAGXsdo/HvfAS315LHy2QVfx
	5fi6aN8oXAmR3kchu2q0s3XW+BBNzqxSSG5xKsO9jJv5Nnx0XyBIO/0eiKn8qAS5t/Lnf7U1YhJ
	tYKftWi5rlHt6UjoxnCE1/JNeGPqx/RtPaTpFvEfGkCM1ca1WJr251C0MG8ReMaqibma1onuMeS
	381uHXyaR9o/MmmBxV9+lQKuzvLPwduiInlipfFX5ZTywLxYvNm3Zxbe0obLNM6rwTaymV4zRpn
	ErraHlaRjpkUk7mHQmzDnwiEYn93hgmr61K9+OOB9MlKVN4zIJ8pzqUABt0+Wa+Fo45eDJApWE/
	PdUngISCPqjUJzg3/x8oB3DhUDHOST2uUXU918vTTnmc7WQ==
X-Google-Smtp-Source: AGHT+IE12Wc8kO3kjReBsnXRqRd7tIe2dl1sv/LxdITxOWFOmgQYQJqv0U8o+slJI/BTH8vwjgFdyw==
X-Received: by 2002:a17:902:ce0e:b0:267:8049:7c87 with SMTP id d9443c01a7336-28e99d87465mr13981045ad.14.1759448780042;
        Thu, 02 Oct 2025 16:46:20 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1eee04sm31799505ad.130.2025.10.02.16.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:46:13 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:45:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <cskhj6mxu62owohvhrufrpdi6bgqzypp4fjnbq2ng2keflfliu@lx5vov2sstqx>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
 <e5c6756b-898e-475a-a390-391edfdc0943@panix.com>
 <rmfs32rqwiwergekmikednlm2zikakhvdtjnx54b4q3neznghl@3pqvqralvofd>
 <5ccc1030-96e3-4a36-8900-91a057698472@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccc1030-96e3-4a36-8900-91a057698472@panix.com>

On Thu, Oct 02, 2025 at 04:42:40PM -0700, Kenneth Crudup wrote:
> 
> On 10/2/25 16:37, Inochi Amaoto wrote:
> 
> > I think it is good to have some more information like call trace to know
> > whether is caused by this change, or the side effect from other commit.
> 
> Yeah, let me make a branch with the commits back in place, then see if I can
> get the traces in pstore.
> 
> > I also suggest adding someone related to the xe driver ...
> Nah, I honestly think it may be related to VMD or my NVMe; it's like it does
> everything it can except do disk I/O.
> 

If this is related to the NVMe, I think you can check dmesg to see if there is
some log like "nvme nvme0: I/O tag XXX (XXX) QID XX timeout, completion polled",
which indicate the NVMe is broken.

Regards,
Inochi



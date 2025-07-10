Return-Path: <linux-pci+bounces-31893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A388B00F33
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 01:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4554E693A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A25291C11;
	Thu, 10 Jul 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVYfHP58"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E0235BE2;
	Thu, 10 Jul 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188626; cv=none; b=CmcsbN/mI1ErbY8zIRlvSoxpdAgCY//VqblfGiFliP1gpPsD5ctB+BPe6GB/URTQiRrre/efQr1dUsw50U6rDfgDOKgQYGLZsa24Er09EcDmc5XTY0yWCUE80S7zclo6b4+btxKQHsmx4A0bYJvHgsUEFFv8guLzvtZlWXJWu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188626; c=relaxed/simple;
	bh=a9enHCjaCkHMvTXJ1wWxdEuVCCVpWZ3hrmLMofq177g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eP62VhHkj1YUbyF9pQwMn//YMGq5KaOSBj1MuiFZFYXWMXisaMzf2ZFrbyNz+KEqf8ZQiFxf1uSzucM0tFYAmHfc8Qw4b1HeI7mUjEzHzcRpF/Kkij0B6nhZGc8TV2tsbbu3mZw0W14VMqk/DcX6wi3dDz23Rax5UP4l/iH+qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVYfHP58; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234c5b57557so16256335ad.3;
        Thu, 10 Jul 2025 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752188624; x=1752793424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWfnonDyLQW4nF8T6gu1K43HYSw1uIJUKk+sbJA25mo=;
        b=HVYfHP58JZVsvVyfijzJ2DBZhlXN3Ou9qrnsLUS/aGKlZXSsrd9G5hCg78uEm5ULZM
         OL4d81wS5+7aWDHnSqm7ucxTn8Yj+tpuHtHXyGiGztJ1i5n0Jrrkx0ZFVQnAk9yPNdTI
         s1iUhNhEayLtmbyJjBUfgnAIDKEVSWLBGgnASBdNQSvR8aFPVg+bWF449KoqQNTRv5b/
         azjL8+9KSEma44/Dq2t4jGuYFJ2wJsa1rJ26KpsUyqoEMsHy58roOlBSMWaHZ5ygBoE7
         wNMFY0V5Gk4WmQSE3dnFCAT5b/3BwNVl1zUN4FBoZjJfqalyBhaJ8a8mRaRJGF/X4hsT
         gvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188624; x=1752793424;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWfnonDyLQW4nF8T6gu1K43HYSw1uIJUKk+sbJA25mo=;
        b=oeFgnh0+0B/0gEcugyw4crg4o7XU1CUFLmm0n9e2h2a5q8iUhKYGuh4ZDDhUzRw75T
         IOHk+4qc0MIefSeU0bB6A1hLv+qYhLFVSsy1hAfHfS8X4Zan5BIwf1J+8iPZyKvvqBoF
         ofn8cc532TVKn3E4k7l34szVnzJz1gCfRyCrLiG7ENhuTcdM+dPwEFxpJ8tHTaLoEIK7
         8RYFMljmAYciwS35xeqwxFO7S//fAoH3JznJ9ncm7gs6x8zk1GTeppTK/UiO9h9nqJeN
         M2gY9qILj7PCKi67pPXFCRbiIidfnYu+LxmVrY6rkcw+a2tkhPJ+Wg3keDG/wNZhMmH5
         knuw==
X-Forwarded-Encrypted: i=1; AJvYcCUQFDCChw6Rr2doWWtUaWg5z/Tq6ITBDXKee0Y/IydguwXiW2FDUPhK+T8uBiCsOeWUKl3F3zijQxcHhFMR@vger.kernel.org, AJvYcCVVNJ5tkk24deXWzqDi+Hyh0zTmPGJowvTqjtQGyYMjPufKxNZzcdJHKgT8/vzfY4WpX5GmsEIiYWdq@vger.kernel.org, AJvYcCVr3VNt+dFeAuiVFtO1e4seyO755O8GVIFPp9TVRXGF0/B2H+iCnXCMDH5pk9Y/3nJD4Yyioiz0pZSQLR7D1Bs=@vger.kernel.org, AJvYcCXDpU0XMLOY2zW2smxU3xUO64DLzSE3RZwt773NOk9zr6/Gd8wwuzyHyZ8VMdj/aXSQnwzVRdAGIGOH@vger.kernel.org, AJvYcCXcbXqRrB2F0R+4GkFOUkeOvWor7gOSqooiE+Fz8OhsZEUi6F2iv1/ziem0gnnuyXQbWNZtRzo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UJ1UTSDE4zi0+kf2DG0NeFkBrvIKneIDqQulrhhXJVLdi29p
	qwY0dbXWtZ33vJvlKv2ME2T4B+vMR10kZZNjGOheC7SPaCxpjusGxy/GZ1l2WN7L
X-Gm-Gg: ASbGnctlkagiUXPNtbon0kEUxtBCCuUyS59b7Q0umWBhR7teorGdymT8uQQAKPl3zDb
	iBpa3iVFpaVlaSWMS9uR5pLergopr8C4gW7dmVV3aJAPZn0dV0Ti5suXr71BPKus7zX0BTKNyHg
	2H/UUubMQs3jcP4cDL064Fy4DyN6MqLBYvRiuLk6pAJt8CzHjZ3GrfgFHn6YKLfG5bmmF9rKFEm
	Lw+uj9iMIryr7l98qgNE1IHxYffKqYgtwbtCyB8LJ/i0cIiF4MeydZ9lFhM2Cy2p7Cg2ZegBbN0
	ET+FxiSC/wppEatYDof2JHI/QLzic3/sF3+qRDeogYqa6pazBbZwocPCky3IMHs7c50g9dFTc8L
	1Ya4ZrzHyMIo953+WyTh9Cqw/u3OllV5246Ma69RT2FmVh93iGCWFNkjVYyNF+JhyInvxYVZW2c
	DM
X-Google-Smtp-Source: AGHT+IEp6V8DzKUuaw7dIuw9i6/aRzFnGpSetRLQWo+gM4+bD2+wZcV715hpfDegv6ZhtdX0w3OqVA==
X-Received: by 2002:a17:903:4b0d:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-23dede2f256mr13672265ad.2.1752188624200;
        Thu, 10 Jul 2025 16:03:44 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad3absm34659995ad.83.2025.07.10.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:03:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:03:37 +0900 (JST)
Message-Id: <20250711.080337.1396232450801945990.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 kuba@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 saravanak@google.com, alex.gaynor@gmail.com, ojeda@kernel.org,
 rafael@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 david.m.ertman@intel.com, devicetree@vger.kernel.org, gary@garyguo.net,
 ira.weiny@intel.com, kwilczynski@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <bbd52251-a2ac-4d9a-9b3d-62f968c646bd@kernel.org>
References: <aG2g7HgDdvmFJpMz@pollux>
	<20250709.110837.298179611860747415.fujita.tomonori@gmail.com>
	<bbd52251-a2ac-4d9a-9b3d-62f968c646bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 22:01:56 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On 7/9/25 4:08 AM, FUJITA Tomonori wrote:
>> On Wed, 9 Jul 2025 00:51:24 +0200
>> Danilo Krummrich <dakr@kernel.org> wrote:
>>> Here's the diff to fix up both, I already fixed it up on my end -- no
>>> need to
>>> send a new version.
>> Thanks a lot!
> 
> Given the comments from Trevor, do you want me to wait for a respin,
> consider
> the few nits when applying, or apply as is?

Thanks, I'll send v4 shortly.


Return-Path: <linux-pci+bounces-37616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA51BBE616
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940044EEA71
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D814386D;
	Mon,  6 Oct 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="J5O2u886"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DB2D661C
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761714; cv=none; b=j7tjsthn31Vkklwo1T7ZnkF3e+6V3WPlV83fw0B7BGYfJYeNobuFiTfIOKoizWfTRAmYDJvEH+mAaCiCznfBwUvzvY1E67v2rUTKDTAgDixs/cRuUPwkmZodBv6tFsPn4zc0nXnhfH6fdj2JDdkgwNeeU4mYleQkB+er1VgYfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761714; c=relaxed/simple;
	bh=hibbnGnU3QECPZ6XnLJVURE4JHkyRFFdkx1txeFXrk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozP/PgV56MrJoZz+9HNdXWhtB7cEZ8YQDgFG+RmgcvcEBMnf/ppxOgS6M0Ui48kjuHD8GfZRcwzbMN7SXse1qfJ9suCqopvGd/ZtvkESuVmJqUJSV+50lae42wg4I0bqcTRaX/2/Vb38lTSlqozRHc5TKZsBs7UIXWK58xmxZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=J5O2u886; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4170890f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759761710; x=1760366510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+Rkixx7LLpkGutsP5m+f97XLiW/dBpijXGClCMzvg=;
        b=J5O2u886fd4BemWHq7PQpKsTaAWuC9uS0iQgn/9He3K4y+U1E1BTRdRBqKeAbl/lMT
         Dh2fcgCgelGlqdzR+MFeWVzdf3yQmA5rJ1+OCQdNqVPUQ+SKuX42Du7wNnBZsx3dB4n6
         kUuJFEbfTwGhVUoN7iYfgjuZqwvq1DRZgzzduUg8msCAM+nNCiOvAuFED8yiTTLhPvlc
         JkizxV0a6GALRNbnRnd4JQMVU7W9iJIetNpKqbTrb4Vh9zkvavg3h4EJ0+6RD7rBj252
         WVn24xyH6vCe8/H4lDr9+pyfZANQ810g3U3qRXQNLv6ChS9GBbQ3XprciQOEF5FmIpRE
         CqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761710; x=1760366510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz+Rkixx7LLpkGutsP5m+f97XLiW/dBpijXGClCMzvg=;
        b=eqCcQuc5DhLSFECHLlBXws80bgPEYZGUv71vw8hhrd0MRlguO/jHWuJlGF2XiUKqAC
         Y3GA4OAhGDItbdKYwDfwtI/xVqHPRrXJ8Mf+Nv1ia1ySKlbzbRKOaDL5i4kKBnjFJvOk
         mko6bbE5tcDjByDYwGoL+plG4v9ucAuAZnbZy8/aq1VaP7GN8/YgW2Wqhz11jWe4WiZ2
         3Q3OR3TwZ4GlUHpuDQ7ycuvBCHmu/m41xNp37e9pZqXnn6zlWyCVcfRl0Ga2YvyDLlXt
         IWZ3RvkGl8Df7aEa0qfaf2f0mk8jhiI9a+/lcnnoBppRZ0rlhAWb5kRfPXW4NcOj3sbZ
         c3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWtH8ocWPGyJJ3kD4K/wRh6YYi3zBBcjNGeIjC0pPwBGkj3lupWnyw19oXMcM9lE2TUwgcHOy4e8LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdmi19+gEovf+89JOyeqi0syi5JjOHD6+pGbTsSOsNYK2ZT6k6
	si9L+ES1N2GU9/dzM8MidU33zaSOcnpwxnkj4liEt0Mww2EaNWSJER0m8RNZ4RthhsptNhoYY3f
	sJgft
X-Gm-Gg: ASbGncto1NykeRFQJ8y0sMqLmCqJSw7cyDKuQ1C3lnQsbiXnDYl+CU4tOkbRKHVws7C
	4b/xCoshdtX4dZ7OSRe3KkAN5xGqHmt5grxlBs5P/ykMxuJY5PzES2TZiNfeT397JIJ15XXa26d
	BIUcLr/sDe/r5m+s9r81TpkI8FC2ceD9zL8jCRgmElqVHxg1/un6XjNbimBRox+rQlE/O3soL24
	EFBieUflLc0VXr68A60g9JtVNgJfwdfOSVSfIMhBBUlVxy20x4XlX0B8mRxthoSvWsdDRtzRTTR
	0/5Ab8bdWGcfSQQwafaI/pfl4V5YtwIoXpP2H5zzmSYYiFC4z5wODk8Q8Hn8cCOI1vCd+h6Rqda
	mnHM5iRGGGycXPj2liX0h/sRtYHoZy6/nHSuxVjb5qANE
X-Google-Smtp-Source: AGHT+IGp2kpGC3tLU0TDUDe5UOS8YTL+TFbJB6Ca2hXCgzJwI7mQpc3V7iorKqz3mSJ5Vw/OVFNcaA==
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-425671ab145mr8349496f8f.43.1759761709818;
        Mon, 06 Oct 2025 07:41:49 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:8190:7100:5984:e25b:cf23:2e9e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0846sm21385065f8f.45.2025.10.06.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:41:48 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:41:46 +0200
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, xin@zytor.com,
	chao.gao@intel.com, Dave Jiang <dave.jiang@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 09/27] ACPICA: Add KEYP table definitions
Message-ID: <aOPVKpkZK9nFOo49@vermeer>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-10-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919142237.418648-10-dan.j.williams@intel.com>

Hi Dan, Dave,

On Fri, Sep 19, 2025 at 07:22:18AM -0700, Dan Williams wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add KEYP ACPI table definition defined by [1].
> 
> Software uses this table to discover the base address of the Key
> Configuration Unit (KCU) register block associated with each IDE capable
> host bridge. TDX host only gets the max IDE streams supported from KCU,
> it doesn't access other parts since host won't directly touch the host
> side IDE configuration, TDX Module does.

Can you share more about how the TDX Module knows about where the KCU
register block is? Is the host VMM supposed to explicitly "donate" that
MMIO region to the TSM before TDH_IDE_STREAM_KM?

I'm asking that question to potentially align the RISC-V TEE-IO spec [1]
with a similar KEYP based implementation, as I think it is simpler.

Cheers,
Samuel.

[1] https://github.com/riscv-non-isa/riscv-ap-tee-io/blob/main/src/07-theory_operations.adoc#root-of-trust-spdm-session


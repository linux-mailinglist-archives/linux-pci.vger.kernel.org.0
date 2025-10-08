Return-Path: <linux-pci+bounces-37694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A871BC33EE
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 05:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF4F3BD203
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53A2BD033;
	Wed,  8 Oct 2025 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXBlsuUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867E28A731
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895074; cv=none; b=YrWIqbHq9UvLGamhxJsLWnDdaEyj1YwIJkz/VhpLkGLTE07Z0MvfKzbo/5EKBDXJyhZw4W4/fx297yDzbJqOFIEl4gCC+/UzuXTW7oeEhAg7hV6LChh4N/ONyt7KRXDX93XOym5p0PTftMR3oBbVqU3Pd/cvAdjBs1CtDpidzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895074; c=relaxed/simple;
	bh=QwxYTjM/Hs56IWPzeA4KrNyLGwDxDEJRONFXjgNhoyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye+UVuOKI6UqxGTpq6ky2yCogJy9HcfySCv/y8FS/+p5L1sIlOaac4ItPhtKPZ2hPOXqYgJOyWLTtXnYY93413PtAyTy68LClNASHEsQntymHq4JEcV9SKfmQ99hFZxFFeE7wPukKUJ1lG5lkUbrfwiEdel2EtL9brF56vSxc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXBlsuUy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55517e74e3so8100954a12.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895073; x=1760499873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=IXBlsuUyCBxDax6nD4LSJcvQ9J3gg6WnPWYy3yk9W9r5U5wXlIvzmA1FmJ5d423xKR
         GqEpzMThfoqUxvMylyoCCP5RyPGT8jgzizO19+OsT7Vt/bppIsQQXjoJcKN1NpkjZRi2
         OO2bCD+4iB31NuxZfisOIYDka0aCw0G5AMhmiYJUY67YWruvFsZApq9xSPvbnsboMADN
         azF9YISFD5c8fJeh9FUFWjg2unUQuMUSZWi1To3EO9hHugA7s1T69CFSi2s7w9Fgi+vJ
         +h8q7Wg79FPJblFYyvp+yXNPUdMZ+Zix7b5PV2D1IbVhSt7MGuavQKjEHoP9CFuo6zJk
         cYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895073; x=1760499873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=PJrCmnSkKWB1eHlHnfBaqegdY0yJlAmYvST3VoJ8Tf0aMVPJMDkAFR5GMCuirI+aU9
         zSykko+EfPCLZT3ngSR2b/y7UWriKbcQzudWTWquDL2L/hxEat0wj/ECoqn8DxlZK5uo
         oajAzN3wgnYfKWixSaJRkFg4Dh1BrZpHssCXdt7lGW5LjckP9jTxBN6cSGu71BAxx2T3
         aKg17Lune+UgwsT4mJkz8dxFq3bDfzrGdZS57dpz6i+IW//Iv0wta405M89KXZXLOtZk
         dfuIK8wrb1DRDqTnFnm24vB049Ee55phk+9uN4oUT+UoZtMzm3vvZ8dx0UvSsd8xsrGp
         ggVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBoE3fTScQOiYgNtcZxektbpfGzTcAFRXO8LmNkIWFoEW2ROyss0M8VkYnlKb9wHqypYwHFqWLmGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8u7djWck2lduQi+Nh2EvYbBZSar3Xc5fGsKlgL8K0cDVEJkM
	4tZyCgkZbZeevAgHFG9wFY1s5Zp+HeBhx/OngY8S8CZjU7/T11Y+DcLYSBnQDEcQ
X-Gm-Gg: ASbGncu40DbKvcgd2wyNoGZCBj2kZTtfnMw7ltQt75U0FJPnRc5mNH9G4kCB8mlHE0z
	5tCOJ7x+BkL3qq+wTax53RLdvr8x2nIC/qnnYtdTR+C1sHskwbIRMLWBruJpDAtc2APK/06sp56
	fKSULnK8UigUduP0yK5id0hrczEEcKiuYfzSvF3k4EjKplzLqcormuFKfr4ybKQMjktkHLivuVs
	VGuSDTP+vMxdogsBAI/OXnFCzmWMut9Tj0jjI96vjall7aexPjvQOuNOgAO6+y0axRD+jU+dp7i
	ZqMUgZdAtmvcZ9fIMap24eIxqgrk1pLhOw05+L/YnW28Q1zkYy5OgB4zvt8kFnpE3KDlctjgcHN
	WCU8aABY8JZGypku+xnuQsFVeYK6FKr9xOBHAyMgdHYa5YAnuNJCz4yf01td8zpxFXJx+qcQN
X-Google-Smtp-Source: AGHT+IFupCckjpcLo39oZCGHlaErTF4u7UG/c6eq09cdH5+LiWmXwTrf7Bt/BU9N70lcGOmKNtu34g==
X-Received: by 2002:a17:902:ef4d:b0:27e:c18a:dbb1 with SMTP id d9443c01a7336-29027373cb1mr26274475ad.16.1759895072595;
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.198.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108c5sm182331855ad.16.2025.10.07.20.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Date: Wed, 8 Oct 2025 03:44:24 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
Message-ID: <aOXeGFJLuMsPqAjw@2a2a0ba7cec8>
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
 <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
 <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
 <20251007161229.7IT0x9Me@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161229.7IT0x9Me@linutronix.de>

On Tue, Oct 07, 2025 at 06:12:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-08 00:10:45 [+0800], guangbo cui wrote:
> > As mentioned above, the list is usually short in typical use cases,
> > since error injection is mainly used for debugging or development
> > purposes. Perhaps we can also get some advice from the PCI folks.
> 
> Is this something that is used in "production" or more debugging/
> development?

It's mainly for debugging/development. Debugging AER code is difficult
cause it's hard to trigger real hardware errors.

Best regards,
Guangbo


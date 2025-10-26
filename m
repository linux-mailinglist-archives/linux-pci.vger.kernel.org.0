Return-Path: <linux-pci+bounces-39348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E6C0B6EF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 00:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FA418946B6
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE82417C2;
	Sun, 26 Oct 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcE11DJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A12DECD4
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520603; cv=none; b=ooHPqn4vUOFh0M9DofmZHzMJoPZuzG+pEGtJ8BkSnX/FmkAd1N3GhCHU4Nj3qSuBfwcqd6EWNzjizGexo2d5Q6wGeNvlbiwObsLsNe/3UXczMJfMvBDq4nwh7QabgQf5ehxmJKL1Zz4LLzUvMWFyOUYEhtIHOvEUiuuMPN5yW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520603; c=relaxed/simple;
	bh=0/huNYjZWSix9nRszyI3WMM5CbL2Lg55WENfuAt+bTI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OEsOytUQ3T/cU7aA1C81rIcmMEU0gCMrKw6Ac6xqyIwPdLk4/vEngHFcUENxH30Tq+cA+kBLfqkXDzLWBLmNzvmRmlXCwVv62ekPgjWmzi5WLn1QrqLLSfnNYP/O0nqE5mIEh427opPmojDMzbTyYOzVvQa3YV2M5z4W8Pu5sRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcE11DJ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761520600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBWykJ+JLfTQQ7sPIXkhPYL39cPjNvStkhNiSczPsqE=;
	b=VcE11DJ+gXe/PSvjZJwGNxkP6UAoPMh4h0qQICYNCDOmE5dITNYl3p89XTmCaDvmN1kzzw
	4Fil+zQCE1x17OTe5D1fj+L+LdxKeAFLHWG03Fwz8NuWcoTgiBPBx31zuGYg5z7r0FZYyW
	rF2YB8ncs2NB2bgnPYYeB1mDVcnhpwM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-YX0wyJmRPGiF6OM01fX9og-1; Sun, 26 Oct 2025 19:16:39 -0400
X-MC-Unique: YX0wyJmRPGiF6OM01fX9og-1
X-Mimecast-MFC-AGG-ID: YX0wyJmRPGiF6OM01fX9og_1761520599
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87fb496e4d1so136529976d6.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 16:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520599; x=1762125399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBWykJ+JLfTQQ7sPIXkhPYL39cPjNvStkhNiSczPsqE=;
        b=lP2FC/V3CsWtfUKzHsBQBUj66S37omUKWEsHPA0yinh07tmMhN+J5C5wSWrkPfbDbq
         9foYdPFm3n0Pwf9Xi8rQkWjKk3CEYzBEVxd26wa8FkmHZGD7YnRKaPQ9HELGeFFdVFza
         aU6uJz1ejoc+6Czw7s3ulIrtkbAI4GJ+rvMbLkTgftoDbaMMwGVxladBg6HEX3J+Q8ij
         KlSWZcI0CTDOKQesrDSdMvrl7qbHq1ZSm4Yr0fPYYGoe385y7ieODxwuV1j4oiyTQbMk
         i0mCDWH4+rMBl0h13rsNvQLdiueHdAWlGTozhObN+xIo8E2wYhOWJ1xbOl0pO9HtpvSU
         LydA==
X-Forwarded-Encrypted: i=1; AJvYcCV5vmZzLe82YQc+UHQqbOZL7km3F6ooJG5vRRkfGWcLYGfv13f09qqYRAl1nC0Djte7bJO/jGc3JpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqA/sMwyPpclKzQSwjJ7BSoIlcn+6GphaQQrFFUywQ/xP15tV
	U0BBr9e/JukN//BNTUP19I/R2KrkbVYBBe+LhW3IR035kJzXgNwV/vEqQInhj41iyE3QW77niYk
	rboc28Itf48rYiJDStHOKPKUle0QivZtqtgFrRjVO7hZVconF2zdplj+ZEPNsWA==
X-Gm-Gg: ASbGncu5fJuj3fkZTuFSE3uibjOiezBqtd3q9BU3jmX+2EVp3DKSMzxIjmrxkYSZKVI
	YbSgOJ+S/dXMD02xz6rDy9b5ny7B392/yW7uvQKIsJfBjOgro4t/YEHKrQVwnkYviDkSUiDRapu
	7EoopS8LKm7KHLafvC9STnjvo8DsyDsmexujhq5R4e2tRly8AudQtLcKKG07kjdieEIFpwoeA0f
	mf7lR50wVMpBu0aCWyxyrW0KHkCPuJ61TgOtXssVhv83V9eXuTYzJptS/uy3XrXUWYWGr5690vz
	97cTPcVwLK4EZ8vmF1hJhGFplJP7PuAuPrcBGuJbtuK2Z5nmJqxgFJ8bz9XTDNXVqMQtipxxJfG
	KWB3vkuzL4YnOeGjAIfZX9wskbiAej2xs19l1K12kz6QbiA==
X-Received: by 2002:a05:6214:3010:b0:78f:4d53:7cd5 with SMTP id 6a1803df08f44-87c2055e413mr212351166d6.5.1761520598856;
        Sun, 26 Oct 2025 16:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUMbpyufTMcqOy5SlC0+mvXSrFqq3iNexFgoUnqdxkDBJdViCkPZAKJ8NUgAYACSCic30anA==
X-Received: by 2002:a05:6214:3010:b0:78f:4d53:7cd5 with SMTP id 6a1803df08f44-87c2055e413mr212350986d6.5.1761520598526;
        Sun, 26 Oct 2025 16:16:38 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49420absm39878736d6.33.2025.10.26.16.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 16:16:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>
Date: Sun, 26 Oct 2025 19:16:36 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Content-Language: en-US
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 12:43 AM, Guangbo Cui wrote:
> This patch series addresses locking issues in the AER injection
> path under PREEMPT_RT.
>
> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> ---
> Changes in v3:
> - Remove unnecessary lock in aer_inject_exit.
> - Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/
>
> ---
> Guangbo Cui (2):
>    PCI/aer_inject: Convert inject_lock to raw_spinlock_t
>    PCI/aer_inject: Remove unnecessary lock in aer_inject_exit

You should reverse the patch ordering. Patch 2 should come first before 
the patch 1. Otherwise, applying just patch 1 without patch 2 will fail 
compilation.

Cheers,
Longman

>
>   drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
>



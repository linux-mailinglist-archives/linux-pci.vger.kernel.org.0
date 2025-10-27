Return-Path: <linux-pci+bounces-39443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF65C0EE72
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC733BE798
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904E2FE057;
	Mon, 27 Oct 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep4iqc0K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1C23958A
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577815; cv=none; b=pvqBI40vLHT/5ShxuMpU2HBLG1RksImznWzobMjfreo+WXLna3ZJavRAGTVrzyUb8Z35SzPcqXflzRnpnnk0WO06m+ppf86CepJesBgDT5g1FX1BdfLERbNcPXNMczEE3WY0vheANYjr1f+ey8i75rDPHFXQotTeouHH2O8crm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577815; c=relaxed/simple;
	bh=P4gxh+sX4gDn50DCIKBIonCfr6GljY6Yg5PZOosv6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXC2YfHwGW63KrkIWs9DcQb5FPqo9o4PWFnQhr+9B23bPOhuKlOrVLXosA83erdPUiy/mQVhDxPyKcE+O4isWrxIK55PZ3Goyo5vX5u+Kkcb4hRhRcfLK/5Kze+Il1Pwf6uyelfgCXkfEwBWfVRqU5z8H7xeMKXTPt6pqGsO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep4iqc0K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698d47e776so38218145ad.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577813; x=1762182613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=Ep4iqc0KJ/wD8/g/o1uy8b3CdjNURsX+YKZg+isRnDsN97vi7H5S9dhxR0qtz/FqdD
         zToFpvV8xpGjP7D08fKJo3WcvQjXBMYVYilj1k9H6UlQ3lRn+Vx8BCDPLJSp8O3/OVwZ
         RKdeGpPbO5XclCapzAA3AYtxx/wg4Fa3Cm+Z0WPhwNeM1bLIObt5JoXlM8ca7A/VG9RE
         PM2og4QsBKn9g6dpso3vn+SHK1k6p8qTMHECG7S8sr0jRmSRv5wfbM/CC/ohWiRK/U0T
         n39rTnLBx8WbQs7IlxMAb42J/Gj/9oa0llvkkid13AhDTavRxiQ9VHeGFOZQRfr5Add3
         E1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577813; x=1762182613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=Ov8NUtIXHyuwFpBD4BnyBSXsuCL4Ghx5Hm3BX4dzzP87oYGfASvsmdzflTiD2KnOa/
         ev9neLMav6WvisAAn34PG7H/Qj453id0haKSEFR38NxQ8V0FYnYRuE63p35prd/yfeC+
         rJFLns/Q5wORY6VzYsQtt5IrrbtBON0NqA17hx2K5yOg0vPp8XtzYUxEBkPi/arrjy7o
         vp1ClZlnXQF3sE96hgkmAT5mNl8mSdfkJCIzR9vsdW1RlGUy5pkIvIVajdoFSEsu1LmN
         6nywdxaesIZVuC/4RHrZjJVfLvUkXRm+AnHUFrwzn5bWM2PGVWPDYd9oP+6I7vtuzPdp
         2ASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCYhhEXMfDZLlaW8QHctr2IFERrfp8mxoRhfUvu6gRaAZNWo+1niJSFEDI7l+JRLfXqAtezCiUHmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwVAfnn3Kd4P+8fc8/oT1eWQWSW0VX108pVgYmZqzcPj4/VSV
	wHtR75Jv6CpMJtBW3JQ/0FDYjgWdGvbYZyZT6/ye/2tAm7aCiM7OYzD6
X-Gm-Gg: ASbGnctUZbyaRf7Xoe8gFVznEAY5DjZbKx8VHFwMZP7RxdPF82Pv+37QAy0jeX7K1Im
	5+OPaZqPa6qr/Nj2Crm7H9Im9augk+QISRBe0aG03nGQb3FHFO2MJBJ8HrV5XmTPaiJ/eQQ/bxh
	TbjS9zaVMfxM3uGTxGU2essoWbzfKrQQD0uxlZKOK33C0G/9wsZCzZYOb+QPWU8NRGUmA5L6qzR
	dU9oDxN4tHWlWsqcb+/r78PxjSFU057X1zU1NnaIn8Yk6F/91aLfeA98cDdZRMnb6vWHxOeG3mD
	9pjXjRmFF63SrYGCGus829Xsh+wLRjPpN4g+PJXlZCsm2SnVWH/w6tONZo1NvQqvB2f+eep8H6c
	D3sR6Gn/ComHdru8c6s7TMs8RKT2NDCyhOaFtyTcxd2YG9c+Fu8XOtRyrRNaBu6vVOuwbPbQFm5
	kRI3PvYXUgcMleLdtVRv/OyPmyQL4jMeUyfppyi+rU907Ak4YY
X-Google-Smtp-Source: AGHT+IG2o9ZOMRiQToH4/Mv8njWDHz1vYKUsJvwR9D8DktGrc5VAjMxjT8KumWa3rz1I+qjC55ilOA==
X-Received: by 2002:a17:902:cecc:b0:276:842a:f9a7 with SMTP id d9443c01a7336-294cb523d54mr2795155ad.57.1761577813098;
        Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm84223145ad.50.2025.10.27.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:10:12 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:10:07 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Message-ID: <aP-LT-IgxbZMdWNt@2a2a0ba7cec8>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>

On Sun, Oct 26, 2025 at 07:16:36PM -0400, Waiman Long wrote:
> On 10/26/25 12:43 AM, Guangbo Cui wrote:
> > This patch series addresses locking issues in the AER injection
> > path under PREEMPT_RT.
> > 
> > Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> > ---
> > Changes in v3:
> > - Remove unnecessary lock in aer_inject_exit.
> > - Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/
> > 
> > ---
> > Guangbo Cui (2):
> >    PCI/aer_inject: Convert inject_lock to raw_spinlock_t
> >    PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
> 
> You should reverse the patch ordering. Patch 2 should come first before the
> patch 1. Otherwise, applying just patch 1 without patch 2 will fail
> compilation.

will fix next version.

Best regards,
Guangbo


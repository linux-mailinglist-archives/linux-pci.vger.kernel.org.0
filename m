Return-Path: <linux-pci+bounces-27360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E00AADAAE
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCB13BA3A1
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA422B59A;
	Wed,  7 May 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBm1uoFy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29402195FE8;
	Wed,  7 May 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608665; cv=none; b=We7YNUK1mZTXo/DVhXkGaqFZIlLoALcHxUXKPjh+aK2wbAhrmpm7nrag6GHlYjaJrLKGiF4GAXu1N+/yA5NKngVxOfbNzVlkIK7yCRNZRgS0u3pSbam4+UhzMc9Md2HQ8YnAdVtWhgrbmRSpAark94FcYRPavtgP9jqcGH844ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608665; c=relaxed/simple;
	bh=0GgVZv0TE3rm4EnCzptHmprn61lzwhEo8SRSZJX4gAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGNUbSvz/CS5SGDmyhw3V2kDMknyKnXCIfJDR9Iygk70ly2mkbc8M0NFNvonAxpwiH2GbyqmKiGC8tokcIvP/ZnQOpvrQjJTHsPMCa9YQFQBVC8mm3O95LQh2oggu9kiw8cEtcTDRpunoaiGnKfbYIqc/fPn3+Yvb9JwKYsRlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBm1uoFy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so6260809b3a.1;
        Wed, 07 May 2025 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746608663; x=1747213463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjSIpntib4qAkMEMeQP8KX/6feboCsG1qYYNwln8l4=;
        b=HBm1uoFyJaZDXKgN7ll+vbFOEqThrN1VZByPLT+7A9JuL0wAOioTVlbFGi0ag1NIdd
         T6pOIYZxoOPYAAIlATaZs7nZyrtELN4JMulmMP7ovyxqyl4ixqLZTV5Nc4gen91qe1Bb
         HsBl/2aPWLIvzghDErHLLCIpym30VvJNpSjh2Y3j/BVZefOgJBWKVfyra0spVCk8rBst
         /DaFQquhqCfX2VJ+Sdz8dwAeXHUZdLCJgkQ0Y76vA43y2nHsyKFMjdll/VPBLPeA99N/
         eejB1MKJDuRZ1M7xKLoN9fbumE2ffcdn6V4REjB6oTfc9RGC4SDJ7JEDB0BUmv7AognZ
         pruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746608663; x=1747213463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTjSIpntib4qAkMEMeQP8KX/6feboCsG1qYYNwln8l4=;
        b=sGteFhIoqn0xD0eivCtXzmU+6zgbrkMnMXzUXVB8VfhxUQfh1Ie5kT4Fq2OpKxTE+7
         1l7PEFb8MCh0+MQcFYBGmuSbzOovqTHydxgl2oa4fMMen2ZIDiB2yJhPtkdSB9RT3RyX
         VTMPaRQyBNIH6VwyG5mzt4UZeZPb6msPD8h+MA/bX4s0JqMFqkYzQSmRWo5jjB+VLhyL
         xwPGrLDlY5Ix9sgtz0gHNOVQb1rDP8utZQxoCjYgI/ZAXyiXKceRMS94GTwaUI/a+n6p
         KdHI/FYBhK2UdMws0QbwEQlQKsxh6H4ZHRcJLQA3RDRFEbNSymLiSgEL+jhdaGm/VzW8
         GoDg==
X-Forwarded-Encrypted: i=1; AJvYcCXg3nPdxWa5pvtfFJszkXvJ2NfyrDQp6aVYmhbMzUvYo3AGMEIW/wNzN9dGfq+PjMF7X4w08dRiRoQ6kEA=@vger.kernel.org, AJvYcCXvNQLHOSo1vgvmUktXIH2pVxNbNXLS9rsOj/TW1oz+owbXJrT0IMQjZqHtd7VXk2mR95v2X3wVc2jo@vger.kernel.org
X-Gm-Message-State: AOJu0YzGv+feyoQ6mJ87Af+yiq5eNtvD93u7y4S4a62oxbIKEQ89jSyQ
	LxMs4STbpKuGRA8PHI6ya/boztg+7BFjiVn4K+8dUdxldiX3qt6x
X-Gm-Gg: ASbGncupn97aNb6UMYBpOAJgavh7etSgvluqykSSyDrVnYfBFkQ/3t2fAKzxjqfBAD7
	LLzkQXZgVRcCkdOrIOIwHZLT8NcZmK7Kq00Op449UQ79jVWPl9w9MnEsNvPn6c63pzkYYYFq8zN
	iMaZLOAiYJRAmcb6zsOuOqhosjY0CSpRAaxvV/TjN6OmdluaYjv0y/TuqE19GV9DT0nM5Rfb1wZ
	N8uwtzzD7NiV23sA0hYt/q8Lr94z5d5K1JjlQiyWVjcdaS/Aaf+BmnLyfFYtwYHrg+ygY+DhxCv
	9Vwgx2COqURT03ln5EXFEQ2Rl/MfqUivoWaD4AW9/EQNchPeB1I3mh+xq0tbKi3TuxQvmsCXZkY
	K/zM=
X-Google-Smtp-Source: AGHT+IFblojXJezdmJD512E4DhTcb4bjmn+B/inAIE8samIj6Gw8mlDddG/r2JQMKRKzycxHsBRc/w==
X-Received: by 2002:a05:6a21:1085:b0:204:432e:5fa4 with SMTP id adf61e73a8af0-2148c21b631mr3291227637.23.1746608663099;
        Wed, 07 May 2025 02:04:23 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7c155sm11049780b3a.14.2025.05.07.02.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:04:22 -0700 (PDT)
From: Zijiang Huang <huangzjsmile@gmail.com>
X-Google-Original-From: Zijiang Huang <kerayhuang@tencent.com>
To: lukas@wunner.de
Cc: bhelgaas@google.com,
	flyingpeng@tencent.com,
	huangzjsmile@gmail.com,
	kerayhuang@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH] PCI: Using lockless config space accessors based on
Date: Wed,  7 May 2025 17:04:07 +0800
Message-ID: <20250507090407.2146324-1-kerayhuang@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <aBsRXO6Us_wsdhji@wunner.de>
References: <aBsRXO6Us_wsdhji@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lukas,

I think it's safe to make this change for user-space accessors as well,
since user-space only reads from proc files.

> Why is performance of the user space accessors important?
> Perhaps because of vfio?

During stability testing on large-scale machines (384+ CPUs), we always                                                                                                                                                                                           
observed that heavy concurrent user-space access to PCI config space triggers 
kernel softlockups.
 
Reproduction method: stress-ng --pci 384 

Thanks,

keray

> That's the information I'm missing in the commit message.
> 
> Thanks,
> 
> Lukas
> 
> > Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
> > Reviewed-by: Hao Peng <flyingpeng@tencent.com>
> > ---
> >  drivers/pci/access.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 3c230ca3d..5200f7bbc 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -216,20 +216,21 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
> >  }
> >  
> >  /* Returns 0 on success, negative values indicate error. */
> > -#define PCI_USER_READ_CONFIG(size, type)					\
> > +#define PCI_USER_READ_CONFIG(size, type)				\
> >  int pci_user_read_config_##size						\
> >  	(struct pci_dev *dev, int pos, type *val)			\
> >  {									\
> >  	int ret = PCIBIOS_SUCCESSFUL;					\
> >  	u32 data = -1;							\
> > +	unsigned long flags;						\
> >  	if (PCI_##size##_BAD)						\
> >  		return -EINVAL;						\
> > -	raw_spin_lock_irq(&pci_lock);				\
> > +	pci_lock_config(flags);						\
> >  	if (unlikely(dev->block_cfg_access))				\
> >  		pci_wait_cfg(dev);					\
> >  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
> >  					pos, sizeof(type), &data);	\
> > -	raw_spin_unlock_irq(&pci_lock);				\
> > +	pci_unlock_config(flags);					\
> >  	if (ret)							\
> >  		PCI_SET_ERROR_RESPONSE(val);				\
> >  	else								\
> > @@ -244,14 +245,15 @@ int pci_user_write_config_##size					\
> >  	(struct pci_dev *dev, int pos, type val)			\
> >  {									\
> >  	int ret = PCIBIOS_SUCCESSFUL;					\
> > +	unsigned long flags;						\
> >  	if (PCI_##size##_BAD)						\
> >  		return -EINVAL;						\
> > -	raw_spin_lock_irq(&pci_lock);				\
> > +	pci_lock_config(flags);						\
> >  	if (unlikely(dev->block_cfg_access))				\
> >  		pci_wait_cfg(dev);					\
> >  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
> >  					pos, sizeof(type), val);	\
> > -	raw_spin_unlock_irq(&pci_lock);				\
> > +	pci_unlock_config(flags);					\
> >  	return pcibios_err_to_errno(ret);				\
> >  }									\
> >  EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
> > -- 
> > 2.43.5


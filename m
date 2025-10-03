Return-Path: <linux-pci+bounces-37490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4F0BB5B3B
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D5D4A840C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365514369A;
	Fri,  3 Oct 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fke8mVGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067961A294
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453629; cv=none; b=FEKneG4/hcnL6EsETgKbbwKYf3dhdnMsL9cVixz0gLabEJJoygjblw1hZtWp+uyqeVztmNb8sXUtAwUrmD+oe8iqNd05wRtBySesrWCMpPxz23J7z0Qcb7AktDIm8NP5eHFSUwQMPWmQbuCT6dvr7p1aC+26kVGlwJ34PtVcKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453629; c=relaxed/simple;
	bh=9f/gIVlJJ+LwYVu6qnE30sjrI2v3VzDVVBsDziqBohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAHHVTwKM1/MEU7ML+Zwf1MesL7EMmgWbIytQwD/aBIbQQObek2GOd5OL492dF1ZYA+1zbusGy/7h4AV7z64vx7jOF01o0/KaqxmaxrmuVvHfpYBIxW/SVRD/8HXPcCxf9HB5HDDdi76iT30ZiMED6PfyMeUgo0Q8Cplk2XrEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fke8mVGT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a02316bso1266821b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759453623; x=1760058423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoW5Oxn4GhLPhMEGmpjaaZfGyS2IpoZEyg+/gtuQD+o=;
        b=fke8mVGTdssFTgwCB3+tcRyvImGyYP/KYRNzbzBbBxtx7MVmsg41tncxNcY7xaMNy5
         NHGJFXqRV5kWwyANWr5LgvVbvMKA+tRAOTdw5a/JYgnT3bdXWfxNdXVaMwWsJ4rlOKHS
         uz8GjpUFcPZp7TmAdXjrn1mEfWHhU29oFBsGSuh6LJkH2i4soP8+U/t04Wb+GqwarecV
         5yLl4q54cSGJs701p6pT5DBvQ77sYo2HRpikQ242bA1x1tyLGJ0admuKLklCv6Fr/dgW
         XVAVRoqoMgtaEx6v+XQ/vQL8ZdkF6EdQ+bq9coene2YWSdZRzagSTocTBMm8goyiR+nj
         BJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759453623; x=1760058423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoW5Oxn4GhLPhMEGmpjaaZfGyS2IpoZEyg+/gtuQD+o=;
        b=tJYx2M7BgKvd7VQVG7UrpeaNFW5RbVJHDRkJMw4v7N+TlpGq5N3WLBW2Z2rF4Bnp7S
         Ot+Nlkj6bXgSUt0QUJ7f7RaK4zpGIMnm8eCVV8nSjuqCjJNRPFYzQF5vwaKNvVOfDNab
         MvN3plQcPFvYuC8aujI0awYFOIMHbR8Gvmopwm9s3024D2PqyfqH93rHYR7gyEPa9xm+
         1u0Sr48sSkJYk2eW4oBaM/Zu9GAav5W3W1c77+7KNMp/eYWWtOOLahfwOdjyrA6ig1Tw
         5gdfDbhFeffw+dq6ItMtZPzPdNct6xrqjc6TzSUkjgibatEy2guEPCe4bQ4MK5PnlH+s
         N+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXatbF8hqDB56EqyEXVZStjdG/do9CRp+ohp8iaY+N5HAPuu2+pjWDq7wiKLXyxVJ7DrCD9rnycTOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCrJBITLEKjtJXZKPikU1Y0SUF7PdalyHt3efmPwlsf5v8AAt
	Fixk9fNdh2QUdq+MeBTPbO5zbr6sCIScl6oYtUj1WVq557/he2H8/XKS
X-Gm-Gg: ASbGncuAFnLD9l8T4b8ZWQwTCTvzlltScFaU7NFAeTMoiliYNEP9l6FFj8aYnWwkcED
	kChufzJ/Hxk3Q2qKwtmqLjWNYgCDLPD68sYL8da+YVMaRYEv4r7C8ZZkvKOgPgA1ouY1WFb98xr
	6TBJo35cSgS5LHPMBhIjvDzTAY63s83jLbnHAdrIHUoQVat5Q58aOCu0/d/NZ9QYdqPVieXGbIN
	HXRbFPfSX/rqWjSyhpF7I8iAviVgTurU1+tZT5Nn2HHwtCFYEPyxkJiI1hhjLViQZFPt2yz+/Sp
	U7mocEpMUZgiyY9DKJc+bBz706RNzB+dFIkYJrOBzQRGyVhqFxjb9Bo1e1/RQ6fQMrN6Yu1uo5m
	xcgjTnLVlwr9wf8Is0uf8iCBZ6OB7Z0W7cPEVHXlztMWZ9QjWQRM+HXLy
X-Google-Smtp-Source: AGHT+IGXKJeo9z9ttudICnuKpj/hhhY2SFC/IvyLZZRB/DNgswXBKBCi6JMOOswunvBo5i5JHOiNPA==
X-Received: by 2002:a05:6a20:42a3:b0:263:b547:d0c3 with SMTP id adf61e73a8af0-32b6209d11emr1744920637.36.1759453623257;
        Thu, 02 Oct 2025 18:07:03 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b020537d2sm3259647b3a.58.2025.10.02.18.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:07:02 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:06:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>

On Thu, Oct 02, 2025 at 05:58:59PM -0700, Kenneth Crudup wrote:
> 
> Resending to re-add linux-pci (Vger thinks my tablet's MUA is "Spammy")
> 
> I'm going to figure out which line is is that's killing my NVMe IRQs.
> 
> FWIW, my NVMe is behind a VMD bridge(? I guess that's what it is):
> 

I think so, can you do "lspci -k" for this bridge? So I can know the driver
for it.

Regards,
Inochi


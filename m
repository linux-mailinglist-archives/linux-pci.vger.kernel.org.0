Return-Path: <linux-pci+bounces-32032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEBB031FE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DEC1899126
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364B277CBF;
	Sun, 13 Jul 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq9iIA8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C41EEE0;
	Sun, 13 Jul 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422704; cv=none; b=ZgF4QoIem/SIyZOL4dnQ1X2Jfz7dpeCgUfBYzFdEaeOYXOH2EX4tBqzXO0DBr1onF0BiDgn0YjF+h3A3r7MwoAYqwD0qCY9B5knHDb80OtAWrynW/+toW3U+k4iVFp0JUHCXclWtvagXO0pWlWN5HRR4mNt/6GcZ2tc5ZYK3T/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422704; c=relaxed/simple;
	bh=kPm6hmZtyZVGLm7EBEQavSfpJGBySTBWSfZqd7uHKhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6YNhFSDmjfbv1YPvzogr6TRff0dr6bClSyxdZ0JUyOq67qs4crTCUXDJTLLfb6Ec20tqi6bszJJLotUzOVdAvNYVglky+yMuUSgvOYI9lZfhJRyLWlmS23aBwYxQ9rQIm36u/v95I0gMTKdLRdoTWUw2qKPBTaOMDUrce2IRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq9iIA8Q; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-70e3c6b88dbso24652187b3.0;
        Sun, 13 Jul 2025 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752422702; x=1753027502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0l/VqiYxdBHMF99eNFwntJM2bY7LDqgmFNd0DnCAi4=;
        b=Wq9iIA8Q5jl7odQAL0Z5c8s/e8CF9y23ezUW29/IFWBVYWx108RMf+hdzaPHz9yzyE
         UtgvRw2KbTaoAq6lLX/LxnLjOwAQaWYf+sEc3vOp81nSSv2kUqXvcYFJa1swBIsaPS+c
         3xc3MjJ0iIPh/4V+Ayp7hOpUg/vGX8k/XQcDrjcUebCX5bx11XGodnb4nsmBS3HDZsfL
         xFNHWqrdNIM8NSmEhGU6ZbSmpuoC1TMEH8OSTMGtgChoWSjH3g5lQEWtPwqfY0BBPBqp
         XZb6TvK3awahwC210pyA6pFudZx/0gnLi3VmYYKH7SyNK2J82zohKiBstdvP4Xbe01kJ
         EG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422702; x=1753027502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0l/VqiYxdBHMF99eNFwntJM2bY7LDqgmFNd0DnCAi4=;
        b=Fi5vITPm42BInijjS/WxfPW0EGgTc66WPpZG+g1vIME9ZdyzjEwUM6LRpZO4IZRu2I
         gKcn5HhTfLXACJb9ThWoNbWElyJ93eOOWdRv8WUAgM+N382u279SUgAP3ljoK9zZozNx
         Czpj3giUY24eq6aHFMNR7QrMDARKU4kva6ZHpu9rspJ/08NVXvPky4rh7BO/3EF3tKoF
         NDk+xjJWJA+jscF0Ytr3+QUT4Xz6Q6KR/si7c8ayY/dAvVz6rs8cJx8Sd7+xw1xHDY2D
         +n1XUyld1In94a1ek8CquzToFbaYpcKRzpndpJe0S2Ke0pYHnj+eui9b0sKD8GSFurcG
         CQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVWWk1FC5hp0v2XXha8B23l5burngMtHvqdAeRNUozBSVIwMCJiLT/ESFKGIkHIKyrLXWrMuyQvkqFb@vger.kernel.org, AJvYcCVcRIbQPnySwzOq2puvIhuSzKq+Pf03z0xBhXEkUp9eZowX3j1KoCrAMzf0CKOmc9XmSNtPdkMjUnr7@vger.kernel.org, AJvYcCWbNtNdpiR9zqSgmmJhxaJUQ9Z33/8ED4egFm+mvcU6NgGk8LzqQe4IM0x8oVaK+xlBSo+gRewhqNVAvqsHGv8=@vger.kernel.org, AJvYcCXRQfdVW3WqbmrnqJwBxmEd9UHz6AaYB5jPVL0A8hR65N/aOsu5Nl+MlkWBvOQWKjOpMgBcYpIg@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtyl/CeB3Jy+CXUr7Zgv2k+KgW02pn9elSYaKk6jxOWDAwlvw
	xmfQ1Uikjrtznk5De2oKyuzEocrBg6RmG3eBUuAZdHnLk7kK/VidjRhDlAfm9SlmjjiCTERv6QP
	6cRCS1PEUkKkOMXXHNCUWqMwNysjGOKQ=
X-Gm-Gg: ASbGncuw6ic8E/5CUtV67OMmud15QnnRK/1lY8X/zbd9S9q3aIH6/aferxrg3FWnp7A
	vmvS+IeYZiUjnE1X+5Fp4sEz3gKIO1hjRt1bUNAmF1OJvHFOkFgdqx8jl60nfNROvK9PS6+zKCq
	6zXhBx6Z4867Ha4Azwtv3VPiVcs9YFneA5ihCwEGQBIO+3AdN8FlB5a4VF5O4HpTLpbOC74mjYs
	AvxCOyjVg==
X-Google-Smtp-Source: AGHT+IH2LeIiglYC9Tun6YOS0JGqjbS6y7L8l2v4pYn+yw4nEo+noWt27UHB4T0XUvebiJpgOLMtt6+dbcW6ZN3bMKI=
X-Received: by 2002:a05:690c:6713:b0:6fb:b1dd:a00d with SMTP id
 00721157ae682-717d5ee1ddbmr173765917b3.30.1752422702009; Sun, 13 Jul 2025
 09:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>
 <20250712191805.5238-1-safinaskar@zohomail.com>
In-Reply-To: <20250712191805.5238-1-safinaskar@zohomail.com>
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Sun, 13 Jul 2025 21:34:50 +0530
X-Gm-Features: Ac12FXxwluBZCmPP36mlKAZmIh6T5KqX9xngXXsjA_2HI0FsRYjIiDSQjP17RPs
Message-ID: <CAEmM+Qij=SYXmt=Ea+gK3jMoeY=Sn=0QD17q9jn5YS0BupbXrA@mail.gmail.com>
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: Askar Safin <safinaskar@zohomail.com>
Cc: ath10k@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Askar,

I appreciate your response. However, we're mainly trying to find out
exactly 'why' this problem occurs. You might say that it's some kind
of "Root Cause Analysis," so that this error goes away from the
Inspiron laptops once and for all. If you keep on reading the messages
in the other thread, you'll realise just how deep this error goes.

But still, thanks a lot for the response.

Bandhan

On Sun, Jul 13, 2025 at 12:48=E2=80=AFAM Askar Safin <safinaskar@zohomail.c=
om> wrote:
>
> I saw problems with Atheros on my Dell Inspiron, too.
>
> These instructions helped me to reset the device without reboot:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1730331/comments/40
>
> I used modified script based on the one above (run as root):
>
> set -e
> rmmod ath10k_pci 2> /dev/null || :
> rmmod ath10k_core 2> /dev/null || :
> rmmod ath 2> /dev/null || :
> { echo 1 > /sys/bus/pci/devices/0000\:03\:00.0/remove; } 2> /dev/null || =
:
> sleep 2
> echo 1 > /sys/bus/pci/rescan
>
> Try both scripts, one of them should work.
>
> If still doesn't work, try to run original script, then do hibernate, if =
still doesn't work, run script again.
>
> I finally was able to solve my problem by replacing Wi-Fi adapter. :) Her=
e is my new Wi-Fi adapter:
>
> [    7.136347] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless=
 AC 3160, REV=3D0x164
>
> --
> Askar Safin


Return-Path: <linux-pci+bounces-42201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C975C8E5E8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551863AB944
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636E23AB88;
	Thu, 27 Nov 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9rG5FCz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083F1D95A3
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248568; cv=none; b=Rji0HbzlNhUZimzadFtJl7ttSkVge3OgTr0HLlTH3sNwbCHIDWty/mtNnnyrWXQN/ftKpFibpDGSStnyLdx5gSlQ4sGKeLIavlE20LMZH/s9JTkduEMFPcML+s6vRqn2XFX7liL1IcUl1hc9cLKKQF1W28NMakbsJV5efqPpy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248568; c=relaxed/simple;
	bh=TWnBamyatpX5Wm4Si3Pw4KH/18jBLNasjONqwMRmbEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5uZ8+c5kCnGyqNwN3PpiDCoYVbrZCqQb2yvowxjJxP0DRpWfFT2pL1kpNrqmo3i4srJxFWFNOq1vTbJb+l6WNF8AUpjAcss2DtKic5Tf6lClazCkVcZTRQzaxdmqzvoMq82MmlIDSIflJhrJG2QZ9PczkHxnS9gFRMXQMuiGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9rG5FCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560BAC4CEF8
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 13:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764248568;
	bh=TWnBamyatpX5Wm4Si3Pw4KH/18jBLNasjONqwMRmbEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e9rG5FCz0iQPqCdN7QK+GlKOL5Q1EJfYtArB6Lser82tbh7ORLZ2xgNk2HvupFdmU
	 pedOTvkpvl5LYAQiNsyG0EW2RV64vyqk8co4ymmLzdW+CQfGArouOXlx4G419zz03X
	 NthhEHTYibZ2hMMmfU/gEHNbOEaolXTZP717OoQJ6Op6kJmOcjdhbBaj+1Zv75DCXM
	 LFQLt5CzNnToWEPgQkzNklmQ0gW0jqrN7gWte8ahEHTTXSJnwaKWyRaD36ObUxzD72
	 DWzc8Mj/LBxn2Y4wupWwHJ5OUrfxxC6We/f5oX/Ry4Rma8+y0BDA5kegrz8I2YyDbI
	 QqCTcZJMCVxsw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6592f588c45so432931eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 05:02:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFMyF2CBPyEbXlTZRjuYrmVP7F2GrHhYI8VrlA5bJcU5GcgKFmNbryQlXwcx/4dVnZgrs2oK9ja+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlN5at+JTKgLJtCz36OL94d91XtoVwrJrDoFBVz0tm+PUMK/f
	s9JZVjXQbgfwiQ5n6aGkNBdeqFKrpOKBl2qRI9/4CliMHIZ0tgyZBY82Ja4Dug9ElB6mmm5dCWm
	tg1FQw9Gf0dVriVgoheBkpo7bmVj36Uc=
X-Google-Smtp-Source: AGHT+IF0w8otX0piRWgtFUFTOXoFjGj4D4MrWIyFNoPn3zzu9Fi9GBR6iCbgBOJGxJT9TxwBRjX6B6nUfkBdUXdfRHg=
X-Received: by 2002:a05:6820:2005:b0:657:71ec:5450 with SMTP id
 006d021491bc7-657bdab6274mr3608090eaf.2.1764248567718; Thu, 27 Nov 2025
 05:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006120944.7880-1-spasswolf@web.de> <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de> <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com> <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de> <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de> <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org> <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de> <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de> <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de> <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
In-Reply-To: <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 14:02:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
X-Gm-Features: AWmQ_blFrD4CZdWtZD3fIxcPns9D2aAYhSHAPFzKpLN-7_95YhHfLdxhVqKxrFk
Message-ID: <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in ACPICA
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:08=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> Am Dienstag, dem 25.11.2025 um 20:46 +0100 schrieb Rafael J. Wysocki:
> >
> >
> > What may be happening, but this is just a theory, is that the
> > interpreter aborts the evaluation of a method due to an internal
> > timeout, essentially the control_state->control.loop_timeout check in
> > acpi_ds_exec_end_control_op() and that leads to a subsequent hard
> > failure like a deadlock.
> >
> > This may be tested by increasing the ACPI_MAX_LOOP_TIMEOUT value, but
> > I'm not sure it's practical to try that.
>
> I don't think this the case here because ACPI_MAX_LOOP_TIMEOUT defaults t=
o
> 30s and the walk loop until the crash only lasts ~2s.

I see, thanks!


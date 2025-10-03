Return-Path: <linux-pci+bounces-37554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E81BB78C7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3D219E7BBE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC92C11D0;
	Fri,  3 Oct 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeZsUkyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82752C08D1
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508875; cv=none; b=EuEkiGFUzZfO2Dsv76VVOO9KpLXdibKvxVyax470Dp6KPVn5Bd8riQswd9+0dacuEP0lZ1BDfjbtMpVASMIx2tRRKz99cYK6SMkpvsS6E7fimxRa6P6QwK4tIGR0LEG8UZPBrpMTkzUC1nZFyBzoi+vyO/8BFvDG5nlGey6rrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508875; c=relaxed/simple;
	bh=es8UM82cdp3jQVhObT6tVyV0MrMhDoehZgwfmOY7z0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/L9d7yfLpc2Rd2tp0YIpWDeow6voUzELPBCEkjXPlMIPzS2d9UIi/6U9k7PrA4ADlkm+8vyIzb/85CqejYLozt6WauIiOnVPQFQLPcosZSZa3LSTBmqegW1kUBgzk8AaTPqbuiBZt8h9WhUdF/G9FdGzyVuxPDbgeznh1cFPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeZsUkyz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-368348d30e0so24309611fa.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759508872; x=1760113672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es8UM82cdp3jQVhObT6tVyV0MrMhDoehZgwfmOY7z0k=;
        b=EeZsUkyzyCv3bVSZKUQBw4ms2mthfmAsAP4hOB8NyNaFjrBFAlCgoSklVvBt+dMOxu
         ahR1QIO5vm2vIcyBjNRuCoGjtPdB9AEz6PJmZee2oO6NEbVt5zysGnX34yDoytGLjKtD
         tr49tbpjspLc4sRLKjUK4I8iFgnMHjFwCPUhBTkHtA5euAzK2N+3MPY+0TUGUPWZ2WiZ
         1Xgb8BCefxCEHBFTg8Qih/8tfO/qtAtNtIMvx6lkmahkcvEciHogCrMfeIkmXHNSvIDX
         zfll0SVSakq8NNqhdayFNcHF/Xm9n8TF/H0TywJMR2yLcB7PD5SCklH+s1D9vRD7M3BE
         spdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508872; x=1760113672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es8UM82cdp3jQVhObT6tVyV0MrMhDoehZgwfmOY7z0k=;
        b=U6x4/dMZLCBELF3pg/o27LAwcMbDRyjcJbQH8v1S8JnXDCPH3hfzGQm24pBk4B/Wfp
         yNfCO3I3nt0cFgGszF1bXSH6gecAICbK/FAbu53tNkvOyfYkVZpONULB856kb7XHr7bY
         aLoSyhrw5uX4Ay4UlPcM55MV8NkpLleZu5VulCKN4POoDBokHy1jhjdLIU573A9Ae0sW
         RTPz4DKzYgB31G7Xect7QWtznm4YqcfAcl2MwbeOWYskfNqFLVUS+MrbQ8aE5dyIDWe+
         Kwp6cUeKd+dXHnTiw0ZlJi17Os9EPIBJ+MVtHQ6qKF31iHvpQuz0eOeyY1M7rtvaWD9E
         EM7w==
X-Forwarded-Encrypted: i=1; AJvYcCWa8LrRZf1q/bQgPWBpgJUvLdk07H7BCXBBqRc6RKbUJ2A9PmaygTLAbNxJDuPxI60Sb2jzERHilgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuy8HuwM2+rANu45wxceJMD3ydbe7hAJZfbKFRHq+61IwV57b
	UGLQEIPlw0CD8YQgU6mJxOjjj7nWpGX/aWBOngAAiznVFE9/2ANZqMU81KYG1rmdZI7IqGLClk4
	+LH0qNBvCMAO7/89jXIyGZazCzV3SNgdiInE4umug
X-Gm-Gg: ASbGncu4Cl0iQwpPcYfFBV6WBM+H+7q8QmRmSZUa50ksFAlntybukN9/YcIbXXxQjWH
	RTiTP1LVsotqvRNsrzCTz3Bf+YI9lWGd+YtuKpFn+m0M5Y9wn+vIbVxMKbMVNPPopp2PHpJTezA
	Ul3cNOdMrZkXQDEtobPZYLOtDdKWyDSULMTdmcntiFQfdStQlhxiv+wqQENUp7aupCbiKMspGje
	3KbzGru3kObppAOrjOU4GF0sh3zccmeY6VIfQ==
X-Google-Smtp-Source: AGHT+IFTk6CMCMoppRtvVoq9tBe48wo0L1v1omXgCA1qTOFwHXfEiNuxXgSZOPMo3GL+YsAQTsu4AI/lVZh5Lxh8Ycw=
X-Received: by 2002:a2e:a586:0:b0:373:a406:efe7 with SMTP id
 38308e7fff4ca-374c36cbcb1mr11850521fa.11.1759508871757; Fri, 03 Oct 2025
 09:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
 <20251003120638.GM3195829@ziepe.ca>
In-Reply-To: <20251003120638.GM3195829@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 09:27:21 -0700
X-Gm-Features: AS18NWAL_78LduiDSxftiJMduuABVbq7EhzwFWmu4e1PHdLIXpbur_Au9hISfgk
Message-ID: <CALzav=eGXp3uHxRytfsKQdrtAV8xg8teoAs9n_sggqdAp_Hznw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:06=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:24:59PM -0700, Chris Li wrote:
>
> > As David pointed out in the other email, the PCI also supports other
> > non vfio PCI devices which do not have the FD and FD related sessions.
> > That is the original intent for the LUO PCI subsystem.
>
> This doesn't make sense. We don't know how to solve this problem yet,
> but I'm pretty confident we will need to inject a FD and session into
> these drivers too.

Google's LUO PCI subsystem (i.e. this series) predated a lot of the
discussion about FD preservation and needed to support the legacy vfio
container/group model. Outside of vfio-pci, the only other drivers
that participate are the PF drivers (pci-pf-stub and idpf), but they
just register empty callbacks.

So from an upstream perspective we don't really have a usecase for
callbacks. Chris ,I saw in your other email that you agree with
dropping them in the next version, so it sounds like we are aligned
then.

Vipin Sharma is working on the vfio-pci MVP series. Vipin, if you
anticipate VFIO is going to need driver callbacks on top of the LUO FD
callbacks, please chime in here.


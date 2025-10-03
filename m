Return-Path: <linux-pci+bounces-37562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC41BB7CB9
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7401F18871DE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B472DAFA9;
	Fri,  3 Oct 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1nywXRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA102C2359
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513476; cv=none; b=ClPutBaVG6In2tsRH8kotQ6TsX2Jj1U7N72KLO4NweFiVKVCtc0n8Vi2f13mXEHkvhmJBwSuTrRd4FDAn/qookcbj8qeSY9VrH7tCnMurSi3JJbK1FXmcYFhrdjSM8d94yrqcATzdjdM2JO8Pk6SKAu4YIuwubufEfc35lyMQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513476; c=relaxed/simple;
	bh=6sxY/rZsZ7Qu89LIgBN6DMePnfP3Sntfb2VTt9cz1z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxJ82t7Fx9z3lI+zHJ7YVDJd9amvEhVkUSSbXaQo4ycQtOJSyOsGyDFosdOc683kv3mGUjid3VE2h9g1AE+8tPQEJlgbfSW3ImTuu+s/0aacJ99nE3gTV4TJ8J/Qqo0/9oDNIWCNm8Deq6vuYuiv9IgS7itCe+vaKi386zUSluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1nywXRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B123C4CEFB
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759513476;
	bh=6sxY/rZsZ7Qu89LIgBN6DMePnfP3Sntfb2VTt9cz1z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R1nywXRbJLXY+eaAnlHp6piIrqwQT6W3Pe/efTG96cBz89njnZJgliAc0vR0BPbAg
	 7yLxXaP7KpSV/Ig7YjiTgBlb9S8bgzhw8PAWHmBCHSRRwZVBczaBFqSixFHBJHAAiD
	 rfXPyZvIIGEQ0mdtTawWjOVPTudjfYk3MGw/zoL0etzsjegKkTecbESTY9JQcrCRIP
	 C/dpsvyyumLmxH8BDNVNWssahEZe+9nXh83X/HedKOJeRVZ+2GlPck2HQyraE1AV5d
	 oJ1wW68OirTQXeW0a8tymXVz9NogySFWSE12gnA875cFwPjTIukRQZcXn1QsyoRPQi
	 k67T4lNdOLlRA==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6354af028c6so2462447d50.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 10:44:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhCKCT6E2HLRfSsgyuWVCSm1pC4DtJWp5HEq26f+b1DldAT4NiLRHrkG0UvPitsBsBlvDCjYh5Q3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl0lhmsWxegt5LtS2P2h101XGSpWnDJBOAZf0OtIxDwoC53Xk
	jHbKiHoc1UwcBHiAuwp7lXGesuokYSC/WJa/71OMA52Du8D3+O3e7qNDKkmJiQgvtZC8fS4i3jI
	Potiupo5Evf88sHHzJXW6WtphiSDM9FnsxdKnPKjYTg==
X-Google-Smtp-Source: AGHT+IFxRP56NfC2WcMLN5sCwHxKUfha0BnQuoy8ZsNgI90MO2Hyj5hjzF4/g+/ZDjEj7M59tZiXBloXgJWrg87HKBs=
X-Received: by 2002:a05:690e:2513:20b0:62e:968:d591 with SMTP id
 956f58d0204a3-63b9a0b064amr3394296d50.23.1759513475416; Fri, 03 Oct 2025
 10:44:35 -0700 (PDT)
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
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 10:44:24 -0700
X-Gmail-Original-Message-ID: <CACePvbXGq8Aau_sQiZx0pOQEB82GjoL2=ed4DCPU=N1XZRJ-5Q@mail.gmail.com>
X-Gm-Features: AS18NWCEh6uxABLreGYasSQQynjMqxwHcxO8NOjjAyzkNARIucDgtG1ReUZmsWE
Message-ID: <CACePvbXGq8Aau_sQiZx0pOQEB82GjoL2=ed4DCPU=N1XZRJ-5Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Matlack <dmatlack@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
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

Ack. I can start hacking on hook up the PCI layer to the vfio FD and
sessions. Not sure how to do that at this point yet, I will give it a
stab and report back.

>
> > away once we have the vfio-pci as the real user. Actually getting the
> > pci-pf-stub driver working would be a smaller and reasonable step to
> > justify the PF support in LUO PCI.
>
> In this contex pci-pf-stub is useless, just use vfio-pci as the SRIOV
> stub. I wouldn't invest in it. Especially since it creates more
> complexity because we don't have an obvious way to get the session FD.

Ack. I will not do pci-pf-stub then.

Chris


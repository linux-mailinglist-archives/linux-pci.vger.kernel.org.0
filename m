Return-Path: <linux-pci+bounces-10180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9992EFAA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642991F233DD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B816B75D;
	Thu, 11 Jul 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfeAd7B9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252821C14;
	Thu, 11 Jul 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726474; cv=none; b=k9hw/tHVvbb2vqet7mQrHs4aMzxbEnI1L9lIXiivexn8HArCA1q7vWKWAbz3RyST005N+YdOAeEKQo7ERMa4+vfSXr9aGueqPVSadYkRbNPHDaaPfxp/hbVo1I0ezkjUni4iCd1hkqiMBx7PO5BxG5ZYK0IFbf1oTwuaPkbFAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726474; c=relaxed/simple;
	bh=rnJzywkRCd7XYg6cYxCjuRelZYp4cgYOJOVs+8goLSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNrCnbKuKXi9MA0Ysb0vJNCMZHkQgcTYcnRWKIQG7k5Y6h2ZM/lI3DADY7gRuzYVyMPCmAuDFODS3simo67F1/S9xO8/R5uT/U7Ze5x+q3VSK4w2mw90vBmlaRtVlSi98SEo/ujPIaQM4MbTsbyp0rVYtiEAabbxr8rX/9DiZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfeAd7B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BB0C4AF0A;
	Thu, 11 Jul 2024 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720726473;
	bh=rnJzywkRCd7XYg6cYxCjuRelZYp4cgYOJOVs+8goLSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gfeAd7B9+JBajYo0b3kC14jh+kBmxbqv7bidZiOID7K9OyOKX3/klen3euzhliSy3
	 o+fD75Ud3ceLwxK6C5MeSrJSMC1rfZO/+BoZsn/jRj2ciMsTBy9ko2l1xrsZYI0nC1
	 6ZLpINUj8BR0DXDAvswDYTZ9Mv1+i3ooxYSs4HXuyyr5ofy9bqMbStDHtjthR9xmtR
	 2olcv1Y+BdkhLvDOPRyWQm4mNbUpDZtd/ZhqBD06npY1MKQidRItvI4EUNOPX5BB+B
	 a9CY37X5ShD3yXJUbYHlmWvj9AkluCGuQ1c5i/KQsEN9Hp7LNCkxERJXBW90girPlm
	 cRGcCXE+jv5Eg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea952ce70so1387063e87.3;
        Thu, 11 Jul 2024 12:34:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXACSptGkFpBOCv0aQKeRWrdCtAG5zuqKmchXctbumcqXq588piPVB9cy6s1U1Xzq2VyH9y+7P2ClkdXF87Ulpk3HU0TqGnaI/ooLLCBIVW5JpGe+kNCdXHx5rUkxGDoF8XerzYRg==
X-Gm-Message-State: AOJu0YwNi1LWz30JGaWlmL5CmZcCliKCBoiR0i1fi5pP2CYHFFkOSG61
	PYEhazWaXom1iXZeX6CByxmxRii9HtB5AunJBgJpavRUS2MRWN9Z5dZoMZKFHGZqZ6NnB1j2KcG
	HmxwV1iczLJlgqgB6crAGSE3sYA==
X-Google-Smtp-Source: AGHT+IF5ZwMkOUD5v9f290dZ5bmhnW8djdgJItCBBjgdP3+Qoa8fkAROjJ85zlq/0+vFIpGpC/6yq3d5B3hrGWl1RlU=
X-Received: by 2002:a05:6512:2348:b0:52b:bee3:dcc6 with SMTP id
 2adb3069b0e04-52eb99d150fmr6767379e87.51.1720726471999; Thu, 11 Jul 2024
 12:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703141634.2974589-1-amachhiw@linux.ibm.com>
 <CAL_JsqL9hg8Hze4oOP1R55yVXBfTKE=RfwdBraNHiO71K21uNA@mail.gmail.com> <qcidmczsjdhaqz7hy3cqnpkjiaulxi7277ayzly3zyrrdbcr4w@5s4x5cgd3xk2>
In-Reply-To: <qcidmczsjdhaqz7hy3cqnpkjiaulxi7277ayzly3zyrrdbcr4w@5s4x5cgd3xk2>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 13:34:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Mojbw9AXPZmGbzDbW7Tj=6zhBWtSKKdqrVhR=AUnp_g@mail.gmail.com>
Message-ID: <CAL_Jsq+Mojbw9AXPZmGbzDbW7Tj=6zhBWtSKKdqrVhR=AUnp_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix crash during pci_dev hot-unplug on pseries KVM guest
To: Amit Machhiwal <amachhiw@linux.ibm.com>, kernel-team@lists.ubuntu.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
	Kowshik Jois B S <kowsjois@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Ubuntu kernel team

On Thu, Jul 11, 2024 at 8:21=E2=80=AFAM Amit Machhiwal <amachhiw@linux.ibm.=
com> wrote:
>
> Hi Rob,
>
> On 2024/07/11 06:20 AM, Rob Herring wrote:
> > On Wed, Jul 3, 2024 at 8:17=E2=80=AFAM Amit Machhiwal <amachhiw@linux.i=
bm.com> wrote:
> > >
> > > With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug seque=
nce
> > > of a PCI device attached to a PCI-bridge causes following kernel Oops=
 on
> > > a pseries KVM guest:
> >
> > Can I ask why you have this option on in the first place? Do you have
> > a use for it or it's just a case of distros turn on every kconfig
> > option.
>
> Yes, this option is turned on in Ubuntu's distro kernel config where the =
issue
> was originally reported, while Fedora is keeping this turned off.
>
>     root@ubuntu:~# cat /boot/config-6.8.0-38-generic | grep PCI_DYN
>     CONFIG_PCI_DYNAMIC_OF_NODES=3Dy

Ubuntu should turn off this option. For starters, it is not complete
to be usable. Eventually, it should get removed in favor of some TBD
runtime option.

(And we should fix the crash too)

Rob


Return-Path: <linux-pci+bounces-10153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFC92E82F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 14:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D347B219F2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4C154BFE;
	Thu, 11 Jul 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txXmhDxB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857F14532D;
	Thu, 11 Jul 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700468; cv=none; b=IFqRTC1vkWixorPoJd/CYXqgurQWJ42aFM2Cg6kGSqrEZgCWfx91hJe5Gkd7fZ82wUcUztIlkPKwIK3HrqsGECaWywaK1kuyvmCqWLtnRBX1NCOmxAc5LIb65i4pAaTpL1XrepYDAW1wx7ZAqpEXVOnvPSxT/rsPuJwBfNDGZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700468; c=relaxed/simple;
	bh=+52FPB3c3wjL8TK+FFddWZnDSoZX6pDi9JJHJg3PmM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFWvFO40+GXY7SesjGKd6zKMCJkKqoJckdTqZ2Tp6R9qlLkFj2HUys9Avjc9yYOBBH7xUWOc4EHD8Mq9U43426JLHK5THaK2hC/UaTZzlhXoloXqlxiH6g8cvdD9akD9qJnEvZvpJZa/hjtkijfZHs1INXU9FkkoRdYcdH0JgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txXmhDxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03453C4AF07;
	Thu, 11 Jul 2024 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720700468;
	bh=+52FPB3c3wjL8TK+FFddWZnDSoZX6pDi9JJHJg3PmM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=txXmhDxBnfB4WsObEh60Wz/HWAhiv1UHOL9xVuJr5eJMo6eNntbRTubtEOmYtvAx5
	 MZPSR8dWBtmqFhf/K9vhx/CAjVBSkqvW/yMec4ZXSiovpKm9iZwIXnVo/A+hcK/ueC
	 QLXMkKKo9REZvYCxxY4AJF8TiqS8svW0fqjJpne9iXzkcbjAcDG2MqYPXfPu8UGlf0
	 Np1k2LljjwfxHRgRINTVDyRQdXs9E//KUa6PehdBrAjVT/XTrMz9FePL9xArOO3Yzw
	 GdQNHM6lg9H6XjtaCjl4UzispM9UAimG91ccNKrxAgZqgrZdeCgNXxJU5Z9Aymv03z
	 p89mraxfXKTeg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9f863c46so936538e87.1;
        Thu, 11 Jul 2024 05:21:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDy3N+7kN8GvAPvNaYYCXVbRyO1PeZ/DTvMk4t26MVV9egEmjS6CfKIrpcPOk4JdjdIbMQe+dFUIzQcLzBLXskfGH1zmvjUBXmIkntY3ucEMKlVPZlPJN9cHiLYHFPcAJipf3g7Q==
X-Gm-Message-State: AOJu0Yw784k1eqUnkff1Fy7FcXEePtB+sBsmquL2V7mqkvfAwmpc3fH/
	9F2qKlVrmZK5CG1oMTzkmhcy/mz8qTMdsvafGQ9EUc6T4TAVLUg5h7flkhD6/RvN8kAdWqUeEa0
	udeK/aOOzIU9eBTjs0ohLC6bBDA==
X-Google-Smtp-Source: AGHT+IFq48139LTNoH/EhDszKQ0cYnElGlN8CYXm4ZkgPD7yDdzVEKydnwQDyrr05M9kqxOePrrTaeMoYkQOQDIYnOY=
X-Received: by 2002:a05:6512:401a:b0:52e:9423:867f with SMTP id
 2adb3069b0e04-52eb99a137bmr6375363e87.36.1720700466351; Thu, 11 Jul 2024
 05:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703141634.2974589-1-amachhiw@linux.ibm.com>
In-Reply-To: <20240703141634.2974589-1-amachhiw@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 06:20:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9hg8Hze4oOP1R55yVXBfTKE=RfwdBraNHiO71K21uNA@mail.gmail.com>
Message-ID: <CAL_JsqL9hg8Hze4oOP1R55yVXBfTKE=RfwdBraNHiO71K21uNA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix crash during pci_dev hot-unplug on pseries KVM guest
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
	Kowshik Jois B S <kowsjois@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:17=E2=80=AFAM Amit Machhiwal <amachhiw@linux.ibm.c=
om> wrote:
>
> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> of a PCI device attached to a PCI-bridge causes following kernel Oops on
> a pseries KVM guest:

Can I ask why you have this option on in the first place? Do you have
a use for it or it's just a case of distros turn on every kconfig
option.

Rob


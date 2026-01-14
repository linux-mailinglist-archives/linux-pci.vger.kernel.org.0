Return-Path: <linux-pci+bounces-44766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BDFD1FFE9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32184304F157
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B233A1A28;
	Wed, 14 Jan 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciM3mmGa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C93A0EBC
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406225; cv=none; b=BnnDap6M4LXElYxYtnvYosXBZzb+sjquqsrxmWyjkFMQvLtbPZCMsB6IwukqonnI/XNbD+eIklUICoDcDaJvIviD/MvNCXUbeWcOhn80rL6tUNNZ6TzRiV00asGt8JXezLiyrxpZWuyRz1QAZu11l/Q0FWWshE59SGmRnfz8e6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406225; c=relaxed/simple;
	bh=xsJHSf3/AMwJQdEYVXGOCzU9jiYbWVnUyVT7KumsBhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYeITRYwl5T7EcFXn9aSeO0RdDMyglQgBr9qi7RNuoO0/D2p+tVfXoeV+jFg6nk7CQwBOgP3itBqcN7r5JQ/xNpXXUTSYdUErg89SJV85lgn/yAbd0Elajgfh/HepCB/lnALsHjha5UCT6FVTKv/JHBahTQT1x3unwnGO9xvqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciM3mmGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8BDC4CEF7
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406225;
	bh=xsJHSf3/AMwJQdEYVXGOCzU9jiYbWVnUyVT7KumsBhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ciM3mmGaLfb4sR3dwp0OsziDDyZMrmjtQv0yE/eWeVkMVjJ4/iDSkJgdMZLah7KNn
	 mrV365T7U4hSIO3tf2+e84SJkaTTPI0DHyWaBigzsSndOjxhHinfBHCZQ7Cw+dNbUH
	 3Cm3GgsF4uh60LnQwgBR7FyBfcfa9TjhtsIvOXcWE8PYDk7MhbDlm97c7t7BWqjEke
	 av0BqCxUCmLGHnjB/lBs7CcOMZqnqbV9gdbpaUCnGJmsUV4MUxq028Ws2mio0/evFj
	 8QgwA5/o/1QBZfV9qnd34rN/IouI1hHcGlay/WXkaVA8+NEOaBFI673UqL11pjvv+1
	 975Y5iTV9nVQQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd2be567bso117647a34.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQD+GbwGM+uYSrKvrosTW5y9cfsakx4TCrRrmPIUfSWmZJeti82sXiZ8TPvdewUgjhZ+8pE3T+D1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlw20NcayPDlEByjygdv1IWBnkLa5rA00mzqGlk3mP9Ks14Vc
	N3VLX9Qwg2yOviaYINtkSnUae5XtWS2sAEaV3zThio2aXpWTGVBm7VPdjsQ90JMsG4M/LU+EWVe
	X1RfH+Cq21v4CoGJlBpNhx5KbIDCsXss=
X-Received: by 2002:a05:6808:1798:b0:45a:6d11:9895 with SMTP id
 5614622812f47-45c715f7907mr2183029b6e.64.1768406224737; Wed, 14 Jan 2026
 07:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
In-Reply-To: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 16:56:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gqso3q8gUZ3wPq1iG7zOBUu2cWMDZiHqCBU5dgdu_KTQ@mail.gmail.com>
X-Gm-Features: AZwV_QjrZrLf1bCykQ-ryg-5n0xrmuSoINx75tjJllyFFfS_mnMgNK7g8MW_veM
Message-ID: <CAJZ5v0gqso3q8gUZ3wPq1iG7zOBUu2cWMDZiHqCBU5dgdu_KTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] irqchip/gic-v5: Code first ACPI boot support
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:15=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> The ACPI and ACPI IORT specifications were updated to support bindings
> required to describe GICv5 based systems.
>
> The ACPI specification GICv5 bindings ECR [1] were approved and the
> required changes merged in the ACPICA upstream repository[5].
>
> The Arm IORT specification [2] has been updated to include GICv5 IWB
> specific bindings in revision E.g.
>
> Implement kernel code that - based on the aforementioned bindings - adds
> support for GICv5 ACPI probing.
>
> ACPICA changes supporting the bindings are posted with the series; they
> were cherry-picked from the upcoming ACPICA Linuxised release patches
> and they should _not_ be merged in any upstream branch because the
> full set of Linuxised ACPICA changes will be subsequently posted in
> order to be merged, I added the two ACPICA patches to make the series
> self-contained.

The patches in question have been included in this series:

https://lore.kernel.org/linux-acpi/12822121.O9o76ZdvQC@rafael.j.wysocki/

and are going to be applied shortly.

Thanks!


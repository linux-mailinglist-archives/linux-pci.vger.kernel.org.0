Return-Path: <linux-pci+bounces-2827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF44842C3D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC75B2419A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109997994D;
	Tue, 30 Jan 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="S/LRa7k1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D879948
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641297; cv=none; b=C0TbcHgZzaxXxn5EwaQ0eVHRD0djKVSv3F3HdPOEkQ/Acnt75h/XVzIt8pVTLNyqwC+cd2K3y2cjZg2CZllfZxth2P9GnchB60P6EkxbuVVfkOcf1nlQSJMdYFtsOaPCBduZiM+z9jLRRSzZAtazqS4d2aOEwkPd2HBEMN3oXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641297; c=relaxed/simple;
	bh=E4micvE7O+ZbfCsFYarptDn3Hd1yYBBH03FWbQeFOoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gekm3i/F2qvli+Zl6QbzAk6cPy+7AJCAA/HS9tAKtFs3JaVAvCBDMADTf4qOu6aCMWPwbW+eD/IqoOq7LXFQNC7vM6NgNPTASIC1DELrcOVMGbLIb+eWRFElnxc2ZD3z6XsbiVOPp1X0AjwIoXNTxHlGCDsqnveG7MvuQme/xek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=S/LRa7k1; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso1268416276.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706641294; x=1707246094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78og88yF4pCuDlRqg/F7xnA9QQPhVIa54mFydxb6xAQ=;
        b=S/LRa7k1I6VkFGbMjJwp/QW0hek8NQEkABe3RQolvttUei2fqEK7Vd6XP3BmNh/5c5
         mLdEEyb3LIrVcn5oOpv4wHfCJfxnM2aFnlnTfHHk2XNytrTl1c7/Blzubi6o9ZzcXYTE
         5DsHE53pzEopVyRhMZ2ixUQDaSLtROgqEr3XCdNyt8lew3QPLJMcDN5ayXrjbYTtcsH9
         TOQX/j07fvJ10OsWzJG/N7pTX6x4F99gT8+NRGnu3JU4BUZNw0HI+aG1LlHISSXGKJKc
         dHE44i6w/ilDkEAEoat3tJP8PZvE+jso7cencgI9+0ajA8UZ8Lt4ik0dYAhrYduIRWjK
         SN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641294; x=1707246094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78og88yF4pCuDlRqg/F7xnA9QQPhVIa54mFydxb6xAQ=;
        b=GIVvOgOAf5VhnGQ6fy/1UOWdC7zBGUwG/vrf2R/sb+RBrN59LIRtZPUT1XeevVuJaG
         qxqA/YEdRXwDQO6YcdwLAeFg7H+eiem3T2gjmUWNqKWT5ojEu0abOcBLP0xjR7Dcu6a6
         tyAT32eCv+Q3WcvPrY34yFxU6GDATmdke8pqGFELB3cKAWYEpfGZ1uAnTE6ZRS3UWZzR
         TrIxM9QIl+ITpNmKdH+j3FNPVAOaZ1EyGVBt/SKUBzekwNgPclX4TTWPX7i06kzDwY4c
         8zUQ3Pz+7QG2SL2qs2vIW7IRNJBAE5SMj0C4qYQsBphcBbLLR0euhXwyJRHa7VUI4Ar3
         KYlA==
X-Forwarded-Encrypted: i=0; AJvYcCVXf94qfF7Wi/aNjxavOoeUV0qcOdc+jgMXlZyBmcjemfLv2YfmlfpDlZDWrCPLThXmYru91+FNLUJYmlePnvhFGIvZjyYjyXpG
X-Gm-Message-State: AOJu0Yxl39y9/8AKs4pSkzCIrYOlsOyWvGd7cUIcxK/MHa/gLdj9ca+r
	IXP77lpivvbLw0p4mEpcKTNLq3g8PlxrlXa8p9VO4dTehtJ+3RUN7Efr9AdQdqj2hLBOmjpUoq2
	5Of1oSkB2sUx8KXOlNCYcFINd4hUDjZ9tGD1L7w==
X-Google-Smtp-Source: AGHT+IEIheGpue36qp31pmYoALnxMN3CKJuNbqB2Ltwx8pEJRNlVwh1TE9U+Ybr/IFc6SWJpr7mnK28qhEHL7CgEogA=
X-Received: by 2002:a25:4191:0:b0:dc6:42cd:6554 with SMTP id
 o139-20020a254191000000b00dc642cd6554mr200359yba.0.1706641294016; Tue, 30 Jan
 2024 11:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130183124.19985-1-drake@endlessos.org> <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
In-Reply-To: <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
From: Daniel Drake <drake@endlessos.org>
Date: Tue, 30 Jan 2024 15:00:58 -0400
Message-ID: <CAD8Lp45ycrY-hkKVZGEQdeYmODauaShgFp2tj=QtEXK_C2tcYA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 2:47=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> Has there already been a check done whether any newer firmware is
> available from ASUS that doesn't suffer the deficiency described below?

The latest firmware does flip StorageD3Enable to 0, which has the side
effect of never putting the NVMe device or the parent bridge into
D3cold.
However, we have shipped hundreds of these devices with the original
production BIOS version to first time computer users, so it is not
feasible to ask the end user to upgrade. And there is no
Linux-compatible online firmware update for this product range. Hence
a Linux-level workaround for this issue would be highly valuable.

> Is this the only problem blocking s2idle from working effectively on
> this platform?  If so, I would think you want to just do the revert in
> the same series if it's decided this patch needs to spin again for any
> reason.

Yes these could be combined into the same series, with agreement from
the drivers/acpi/ maintainers for the S3 revert.

Thanks
Daniel


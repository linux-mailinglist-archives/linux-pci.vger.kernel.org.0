Return-Path: <linux-pci+bounces-20677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63410A26469
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 21:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A0516381A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C32202C2F;
	Mon,  3 Feb 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+IPzuv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A533153801;
	Mon,  3 Feb 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614696; cv=none; b=jfb6en408xf6d14nqVOCfKBK+h9KlJ1aQUNWl4qjdDmy8agmWms1nXxCSPT+M4+JDxpXAUkppi/He5s4+sRefR/S7XBaa+fk6Rwalr7mCFS9QzWqo0fI60Q2v/aSjzuQYRRXc8v7Nuf9i7axyWJw6TjA569YKWr+9D/6+WFvodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614696; c=relaxed/simple;
	bh=hKS9hHDte0poh5qGTVY5mGyAl4OwczulSl9FzFwNUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVypoul6H5jSVSgUIIP430mVtSy5wOhgxUacR0y2rHBEs6UtPmlthcNdBn8T1NWrlcB8U+I4zXDHahj083FO2K2mzVjslmusJXaOWbHGeNSQtRmLAXGz/tfbewA7PvbNkrGPW+ti+kYLiOjvPca+1z1CmbJsjkSeJzls0vNi710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+IPzuv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BACC4CEE2;
	Mon,  3 Feb 2025 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738614695;
	bh=hKS9hHDte0poh5qGTVY5mGyAl4OwczulSl9FzFwNUS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P+IPzuv1DOTI+P0BFI1hKwLg6vk3pcDTmJfa/YxM0utjU0Njq8lC7y6D60+iqgeq1
	 pCo15/8CTUQnrE043XCyexR9MMNM/+6ehzQQ1+Id00CfOxrgRIBCjy4Wn+GdL6S21S
	 hnbnNBFThgIeUwR7crots0uFZhXM2A/0SIJ8xI+GX4Ik8EFo7sgKWA/dBNCZLB95N+
	 wWGEklCaa9fNCbyhAK5AMnnBwlcvVwrdgru0vi5QJeVMqAIxJr2BPAUnfMgHbU0QUv
	 yeQh1kOks9MdbiavEf4F+K5kxv+lqcyD38P0F4881EvxvGIsYGld5rxtINltcLjF8b
	 RjNy3Pi9zfucQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f321876499so2544174eaf.1;
        Mon, 03 Feb 2025 12:31:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBMKLfq3EX6TWCMxFXpnUdRzoFqKhaonbzDfyAkTVA1wLTbmnOC8wIIRrMSDCEg0ljLvlMcnkN+CfIJgs=@vger.kernel.org, AJvYcCUFkClieTajQc19YPYSm5Z9k9CN+3JQSeqAS9nQXmJlbT5GeO+J233EiWjSW/7S5bp2GqVpEN5/2GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1/zHKDpxmtA6+0sXlJ+VzCH49RbribPMX/lGAlflklDdlCxd
	42G0iycAJJXKkmFax8gIS8OWu+gVuEILHHBu3SYC70zvB7dRL+WS/gCNi0V4kz3KwE8i99l/ePg
	Gnih52GTR1yM4cxNzF/Q7fm8ZGnw=
X-Google-Smtp-Source: AGHT+IEkalc8T8PcfxcP6bu+F9tv4889ULAW6/eBwNH+NL0R02igrcnEIMOC0V7MaxgprUQuPCkTZXoowId1r+TXU0M=
X-Received: by 2002:a05:6820:1993:b0:5fa:61a7:16b8 with SMTP id
 006d021491bc7-5fc3bed7ec7mr533972eaf.2.1738614695109; Mon, 03 Feb 2025
 12:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Feb 2025 21:31:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com>
X-Gm-Features: AWEUYZln1HaqrQ7HyD2CNLhMUGnhBd0yYFeGqX09_j-6xNSUxaZ5RuoHcZdBECw
Message-ID: <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com>
Subject: Re: [Regression in 6.14-rc1] System suspend/resume broken by PCI
 commit 1db806ec06b7c
To: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="0000000000004dd730062d42c757"

--0000000000004dd730062d42c757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> The following commit:
>
> commit 1db806ec06b7c6e08e8af57088da067963ddf117
> Author: Jian-Hong Pan <jhp@endlessos.org>
> Date:   Fri Nov 15 15:22:02 2024 +0800
>
>    PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
>
>    After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
>    suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state f=
or
>    "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for bot=
h
>    "dev" and its parent.
>
>    The problem is that unless pci_save_state() has been used in some othe=
r
>    path and has already saved the parent L1SS state, we will restore junk=
 to
>    the parent, which means the L1 Substates likely won't work correctly.
>
>    Save the L1SS config for both the device and its parent in
>    pci_save_aspm_l1ss_state().  When restoring, we need both because L1SS=
 must
>    be enabled at the parent (the Downstream Port) before being enabled at=
 the
>    child (the Upstream Port).
>
>    Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.o=
rg
>    Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume")
>    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
>    Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>    Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>    [bhelgaas: parallel save/restore structure, simplify commit log, patch=
 at
>    https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>    Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE
>
> broke system suspend/resume on my Dell XPS13 9360.  It doesn't even
> pass suspend/resume testing after "echo devices > /sys/power/pm_test".
>
> It looks like PCIe links are all down during resume after the above
> commit, but it is rather hard to collect any data in that state.
>
> Reverting the above commit on top of 6.14-rc1 makes things work again,
> no problem.
>
> I'm unsure what exactly the problem is ATM, but I'm going to check a
> couple of theories.

The attached change makes it work again, FWIW, but moving the
parent->l1ss check alone below the pdev l1ss saving doesn't help.

So it is either the parent check against NULL or the
pcie_downstream_port(pdev) one that breaks it.  I guess the former,
but I'll test it tomorrow.

--0000000000004dd730062d42c757
Content-Type: text/x-patch; charset="US-ASCII"; name="pci-l1ss-save.patch"
Content-Disposition: attachment; filename="pci-l1ss-save.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6pi4x5r0>
X-Attachment-Id: f_m6pi4x5r0

LS0tCiBkcml2ZXJzL3BjaS9wY2llL2FzcG0uYyB8ICAgMTIgKystLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCi0tLSBhL2RyaXZlcnMv
cGNpL3BjaWUvYXNwbS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCkBAIC04NSwxNSAr
ODUsNyBAQAogCXN0cnVjdCBwY2lfY2FwX3NhdmVkX3N0YXRlICpzYXZlX3N0YXRlOwogCXUzMiAq
Y2FwOwogCi0JLyoKLQkgKiBJZiB0aGlzIGlzIGEgRG93bnN0cmVhbSBQb3J0LCB3ZSBuZXZlciBy
ZXN0b3JlIHRoZSBMMVNTIHN0YXRlCi0JICogZGlyZWN0bHk7IHdlIG9ubHkgcmVzdG9yZSBpdCB3
aGVuIHdlIHJlc3RvcmUgdGhlIHN0YXRlIG9mIHRoZQotCSAqIFVwc3RyZWFtIFBvcnQgYmVsb3cg
aXQuCi0JICovCi0JaWYgKHBjaWVfZG93bnN0cmVhbV9wb3J0KHBkZXYpIHx8ICFwYXJlbnQpCi0J
CXJldHVybjsKLQotCWlmICghcGRldi0+bDFzcyB8fCAhcGFyZW50LT5sMXNzKQorCWlmICghcGRl
di0+bDFzcykKIAkJcmV0dXJuOwogCiAJLyoKQEAgLTEwOCw3ICsxMDAsNyBAQAogCXBjaV9yZWFk
X2NvbmZpZ19kd29yZChwZGV2LCBwZGV2LT5sMXNzICsgUENJX0wxU1NfQ1RMMiwgY2FwKyspOwog
CXBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCBwZGV2LT5sMXNzICsgUENJX0wxU1NfQ1RMMSwg
Y2FwKyspOwogCi0JaWYgKHBhcmVudC0+c3RhdGVfc2F2ZWQpCisJaWYgKCFwYXJlbnQgfHwgcGFy
ZW50LT5zdGF0ZV9zYXZlZCB8fCAhcGFyZW50LT5sMXNzKQogCQlyZXR1cm47CiAKIAkvKgo=
--0000000000004dd730062d42c757--


Return-Path: <linux-pci+bounces-10302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB006931A91
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357B2B225DD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC0762D7;
	Mon, 15 Jul 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzM56u57"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0805025E;
	Mon, 15 Jul 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069748; cv=none; b=Y5WBwW3QRdtlUyPj1eLe5qw3hFDpDYSwJ8n4yJtU8fFZNqvU7U7z/dLl2QI30DkDgMOdXnQ6Bfo1u3D5+RkK5r81j4+k0WP2MLNKtdA/Hf+qfjYx7NGoUOdJNpoVCjCBB/qPxHzC+kqBjkgacgt4xqYIl5u8l8JiUt2wrFkSL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069748; c=relaxed/simple;
	bh=fTaVUp5ixXjyj/IQvLPoiMP1xh8WB5ilzwlfi5SQ9Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1SFmn5YwaduPOhBvv5lOhT724LOHwwrfnHaWQLKJW1UcrhMVOSCUAnAveO+yEC8kHTT4Ooar3cTghWAALBYBMyaOTk3RXy645Jf7Xv6leQUw07i7zBjZ/D1EP0go/naGlKFLy3WNw4TmTXZurbeeVTa8AwzAlBU+KkW7i05qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzM56u57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56281C4AF0E;
	Mon, 15 Jul 2024 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721069748;
	bh=fTaVUp5ixXjyj/IQvLPoiMP1xh8WB5ilzwlfi5SQ9Uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mzM56u57vbSMU7UUmNVR4LLKrqMOvG0VNwKB6Losab0GAaAtgyoVZ5a5yCpA/S/D7
	 sbovS4flkyFA7smIGcKPNkt9qbdkLfEW/ixpl5yuO288I7N8GcOQbgL7x+TQNGD+B9
	 wN1PsljQzJSNiOq+B4zKMYjVqY8uAYYuoEtRQG0PFQBy1wmbjyYjtdwlQTnOF4I1A5
	 33RglqbJ2gLElY1MIjHGK2yB212+Tp/hUw+OwoEpHGQxCpIe+iYzssVx43PRZ8laHU
	 taaqx9n+A8pb4XwEBlxpYNZkkX5cYFHERPLLHHSNexnZAn/Yy6/RSr3VB5cyR8pl8d
	 WMu1M4G2Wlrlg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso55744871fa.1;
        Mon, 15 Jul 2024 11:55:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXumxkft9uq3D7HTZ3tbblkpFb/SHx+MhywvHUaWqaAyXfqs2S3plvWQI05jGYEgBFHAkdj2aPhkFB4DUIjkdh3UX2S1Dg3rWi3HbHReipRa9x40IRGfWp6IPe8oV3zG4XCioVZzMjHVpzk+lMriGs1epP2FLXftXZeBnXYdhO0eNM=
X-Gm-Message-State: AOJu0Yxsp0S3URk3bakVAfjAKkGaSF7LP2wajKRPRZIDdWR6og0Q8IlA
	nrGMTcgxgW46ACuQiz8t4aW+OdllKiH44iMWA+2Ie/rLVWUX+wbYpxN7Bat59EVWYDplPkCk1Ze
	/NUwUnLVqb7N2hbEEJGmr4Xgxdw==
X-Google-Smtp-Source: AGHT+IG5hZtW/6OyRaCvviup+P1U2Ghou4YKlTCsHtRsWKDMqkEasf58VhGXraqlzg+5tGrRgvrOkOsdfd2CYJKf+h0=
X-Received: by 2002:a05:651c:1254:b0:2ec:57c7:c740 with SMTP id
 38308e7fff4ca-2eef41d72bbmr63931fa.39.1721069746552; Mon, 15 Jul 2024
 11:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715080726.2496198-1-amachhiw@linux.ibm.com>
In-Reply-To: <20240715080726.2496198-1-amachhiw@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Jul 2024 12:55:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
Message-ID: <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Saravana Kannan <saravanak@google.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
	Kowshik Jois B S <kowsjois@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:08=E2=80=AFAM Amit Machhiwal <amachhiw@linux.ibm.=
com> wrote:
>
> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> of a PCI device attached to a PCI-bridge causes following kernel Oops on
> a pseries KVM guest:
>
>  RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
>  Kernel attempted to read user page (10ec00000048) - exploit attempt? (ui=
d: 0)
>  BUG: Unable to handle kernel data access on read at 0x10ec00000048
>  Faulting instruction address: 0xc0000000012d8728
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries
> <snip>
>  NIP [c0000000012d8728] __of_changeset_entry_invert+0x10/0x1ac
>  LR [c0000000012da7f0] __of_changeset_revert_entries+0x98/0x180
>  Call Trace:
>  [c00000000bcc3970] [c0000000012daa60] of_changeset_revert+0x58/0xd8
>  [c00000000bcc39c0] [c000000000d0ed78] of_pci_remove_node+0x74/0xb0
>  [c00000000bcc39f0] [c000000000cdcfe0] pci_stop_bus_device+0xf4/0x138
>  [c00000000bcc3a30] [c000000000cdd140] pci_stop_and_remove_bus_device_loc=
ked+0x34/0x64
>  [c00000000bcc3a60] [c000000000cf3780] remove_store+0xf0/0x108
>  [c00000000bcc3ab0] [c000000000e89e04] dev_attr_store+0x34/0x78
>  [c00000000bcc3ad0] [c0000000007f8dd4] sysfs_kf_write+0x70/0xa4
>  [c00000000bcc3af0] [c0000000007f7248] kernfs_fop_write_iter+0x1d0/0x2e0
>  [c00000000bcc3b40] [c0000000006c9b08] vfs_write+0x27c/0x558
>  [c00000000bcc3bf0] [c0000000006ca168] ksys_write+0x90/0x170
>  [c00000000bcc3c40] [c000000000033248] system_call_exception+0xf8/0x290
>  [c00000000bcc3e50] [c00000000000d05c] system_call_vectored_common+0x15c/=
0x2ec
> <snip>
>
> A git bisect pointed this regression to be introduced via [1] that added
> a mechanism to create device tree nodes for parent PCI bridges when a
> PCI device is hot-plugged.
>
> The Oops is caused when `pci_stop_dev()` tries to remove a non-existing
> device-tree node associated with the pci_dev that was earlier
> hot-plugged and was attached under a pci-bridge. The PCI dev header
> `dev->hdr_type` being 0, results a conditional check done with
> `pci_is_bridge()` into false. Consequently, a call to
> `of_pci_make_dev_node()` to create a device node is never made. When at
> a later point in time, in the device node removal path, a memcpy is
> attempted in `__of_changeset_entry_invert()`; since the device node was
> never created, results in an Oops due to kernel read access to a bad
> address.
>
> To fix this issue, the patch updates `of_changeset_create_node()` to
> allocate a new node only when the device node doesn't exist and init it
> in case it does already. Also, introduce `of_pci_free_node()` to be
> called to only revert and destroy the changeset device node that was
> created via a call to `of_changeset_create_node()`.
>
> [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
>
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v1:
>     * Included Lizhi's suggested changes on V1
>     * Fixed below two warnings from Lizhi's changes and rearranged the cl=
eanup
>       part a bit in `of_pci_make_dev_node`
>         drivers/pci/of.c:611:6: warning: no previous prototype for =E2=80=
=98of_pci_free_node=E2=80=99 [-Wmissing-prototypes]
>           611 | void of_pci_free_node(struct device_node *np)
>               |      ^~~~~~~~~~~~~~~~
>         drivers/pci/of.c: In function =E2=80=98of_pci_make_dev_node=E2=80=
=99:
>         drivers/pci/of.c:696:1: warning: label =E2=80=98out_destroy_cset=
=E2=80=99 defined but not used [-Wunused-label]
>           696 | out_destroy_cset:
>               | ^~~~~~~~~~~~~~~~
>     * V1: https://lore.kernel.org/all/20240703141634.2974589-1-amachhiw@l=
inux.ibm.com/
>
>  drivers/of/dynamic.c  | 16 ++++++++++++----
>  drivers/of/unittest.c |  2 +-
>  drivers/pci/bus.c     |  3 +--
>  drivers/pci/of.c      | 39 ++++++++++++++++++++++++++-------------
>  drivers/pci/pci.h     |  2 ++
>  include/linux/of.h    |  1 +
>  6 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index dda6092e6d3a..9bba5e82a384 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -492,21 +492,29 @@ struct device_node *__of_node_dup(const struct devi=
ce_node *np,
>   * a given changeset.
>   *
>   * @ocs: Pointer to changeset
> + * @np: Pointer to device node. If null, allocate a new node. If not, in=
it an
> + *     existing one.
>   * @parent: Pointer to parent device node
>   * @full_name: Node full name
>   *
>   * Return: Pointer to the created device node or NULL in case of an erro=
r.
>   */
>  struct device_node *of_changeset_create_node(struct of_changeset *ocs,
> +                                            struct device_node *np,
>                                              struct device_node *parent,
>                                              const char *full_name)
>  {
> -       struct device_node *np;
>         int ret;
>
> -       np =3D __of_node_dup(NULL, full_name);
> -       if (!np)
> -               return NULL;
> +       if (!np) {
> +               np =3D __of_node_dup(NULL, full_name);
> +               if (!np)
> +                       return NULL;
> +       } else {
> +               of_node_set_flag(np, OF_DYNAMIC);
> +               of_node_set_flag(np, OF_DETACHED);

Are we going to rename the function to
of_changeset_create_or_maybe_modify_node()? No. The functions here are
very clear in that they allocate new objects and don't reuse what's
passed in.

Rob


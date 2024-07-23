Return-Path: <linux-pci+bounces-10668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CBF93A7D1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6D1C22588
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB431422C2;
	Tue, 23 Jul 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYMY9VmQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBF3A8F9;
	Tue, 23 Jul 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764485; cv=none; b=YYnJEK9g8bn+jpH3iDWFDfOffYdY/plOw8EKB0Do7tofwHfPRGgERe7cX8t112xQwG//wKRPMb187UF7JNp0lLunOsPcE1b4Oa64ndiAwzDiLyaiZNc18TEleNFofovbOhhdLV1mzsnQ2H93mmheqbVlkFEMyo7gVRkl5Qbj6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764485; c=relaxed/simple;
	bh=k5RrtdLWKZsCl7EDSRNM33NdEcdTiw1cogBHDYG6Wkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6iLUK24MrtJTGqkKTU9HWXAgXAxHSAlds1wR20D2TpvsYa03XgVpNfLU2iqi7fHyQb+MdI2armDfdoHyfwJZ2oKL2OIGmL+yRyfUhiJ9PtZMV1tWuN/NkUgikR6vXkOq9vMW6roRTQCoxyfC4g9zU/MZQrUTiFd20gPcaY2wtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYMY9VmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E113EC4AF0E;
	Tue, 23 Jul 2024 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721764484;
	bh=k5RrtdLWKZsCl7EDSRNM33NdEcdTiw1cogBHDYG6Wkc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dYMY9VmQ644gRDyP98cRxhXFLbUyBu/MIgqSpuG4QacvVX3j7FYjWoDnNShgOtSaB
	 k9NzXP8C/aw7MlPHPw1FwNPv5W2UgSSf+C/Lot7M/k5opxrPjsUKz4wPDL4sOML7CX
	 vCzmPQF88kC5dLybXj7fGXOUkBvxsZkxSzqwuimmaLwPT+F9fDu7IYasyV98JgMemd
	 YA8es6Cy2mj0qro2xHEGaIiNHVkKbr67OMCbSQyNtOs7Kd1E15q/MdlEOp0AocIqiW
	 0Z/bQwRDD9eXV7qjdzxysFa3wop5tA8NzoSpx2ABg4wHrKfypp7ZLLa4VydGBWKQtg
	 By9DbyBPM4NVQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04150796so3602850e87.3;
        Tue, 23 Jul 2024 12:54:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXV9ZwgBhSuRUO8ft6E+hiJsTI9Wdn4ObCdg/XXqyN43D0vwzhGwwALSEmlze6tuaUREy4VTFjQ5dTW8mujOgCpsdd1Au3clkFpVckgtch+6CKMGY9GlJmP7lEgOjIuwVwzW5kkK1vE3koG7KfTzMzcuRyPkcpUEpFNLlzaV6KZTlG6PESKqRaHGIAA1ub00qah/yiiVbnI6ZxHMQA=
X-Gm-Message-State: AOJu0YyV0cAwhQVG5C+IHIOZgNRe15HKbXC1JKrm4vYfNnNZBKmgJfJn
	kAU212EOe3lnHSDhGwNyPyFieE0e/o4N72xaikfapSpQAycmhU8cYijT+XIzQ64h+FgTs+eiLIb
	D1ZewURm3SruX5tZjjjH0fTiAow==
X-Google-Smtp-Source: AGHT+IGCQdyyu8qkAIF4Y+x34DGI3oQcrcatbK5X9D1j6aSuxaMLw+4ruouSVY9w4zl61f3BJLQ8XUi3IEInszr9fCk=
X-Received: by 2002:a05:6512:3a90:b0:52c:d78b:d0b8 with SMTP id
 2adb3069b0e04-52fc406dd9amr3011081e87.39.1721764483150; Tue, 23 Jul 2024
 12:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715080726.2496198-1-amachhiw@linux.ibm.com>
 <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
 <a6c92c73-13fb-8e9c-29de-1437654c3880@amd.com> <20240723162107.GA501469-robh@kernel.org>
 <a8d2e310-9446-6cfa-fe00-4ef83cdb6590@amd.com>
In-Reply-To: <a8d2e310-9446-6cfa-fe00-4ef83cdb6590@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Jul 2024 13:54:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjhaLFm9jiswJTfi4yZFYGKJUdC+HV662RLWEkJjxACw@mail.gmail.com>
Message-ID: <CAL_JsqJjhaLFm9jiswJTfi4yZFYGKJUdC+HV662RLWEkJjxACw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
	Kowshik Jois B S <kowsjois@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:21=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrot=
e:
>
>
> On 7/23/24 09:21, Rob Herring wrote:
> > On Mon, Jul 15, 2024 at 01:52:30PM -0700, Lizhi Hou wrote:
> >> On 7/15/24 11:55, Rob Herring wrote:
> >>> On Mon, Jul 15, 2024 at 2:08=E2=80=AFAM Amit Machhiwal <amachhiw@linu=
x.ibm.com> wrote:
> >>>> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequ=
ence
> >>>> of a PCI device attached to a PCI-bridge causes following kernel Oop=
s on
> >>>> a pseries KVM guest:
> >>>>
> >>>>    RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
> >>>>    Kernel attempted to read user page (10ec00000048) - exploit attem=
pt? (uid: 0)
> >>>>    BUG: Unable to handle kernel data access on read at 0x10ec0000004=
8
> >>>>    Faulting instruction address: 0xc0000000012d8728
> >>>>    Oops: Kernel access of bad area, sig: 11 [#1]
> >>>>    LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries
> >>>> <snip>
> >>>>    NIP [c0000000012d8728] __of_changeset_entry_invert+0x10/0x1ac
> >>>>    LR [c0000000012da7f0] __of_changeset_revert_entries+0x98/0x180
> >>>>    Call Trace:
> >>>>    [c00000000bcc3970] [c0000000012daa60] of_changeset_revert+0x58/0x=
d8
> >>>>    [c00000000bcc39c0] [c000000000d0ed78] of_pci_remove_node+0x74/0xb=
0
> >>>>    [c00000000bcc39f0] [c000000000cdcfe0] pci_stop_bus_device+0xf4/0x=
138
> >>>>    [c00000000bcc3a30] [c000000000cdd140] pci_stop_and_remove_bus_dev=
ice_locked+0x34/0x64
> >>>>    [c00000000bcc3a60] [c000000000cf3780] remove_store+0xf0/0x108
> >>>>    [c00000000bcc3ab0] [c000000000e89e04] dev_attr_store+0x34/0x78
> >>>>    [c00000000bcc3ad0] [c0000000007f8dd4] sysfs_kf_write+0x70/0xa4
> >>>>    [c00000000bcc3af0] [c0000000007f7248] kernfs_fop_write_iter+0x1d0=
/0x2e0
> >>>>    [c00000000bcc3b40] [c0000000006c9b08] vfs_write+0x27c/0x558
> >>>>    [c00000000bcc3bf0] [c0000000006ca168] ksys_write+0x90/0x170
> >>>>    [c00000000bcc3c40] [c000000000033248] system_call_exception+0xf8/=
0x290
> >>>>    [c00000000bcc3e50] [c00000000000d05c] system_call_vectored_common=
+0x15c/0x2ec
> >>>> <snip>
> >>>>
> >>>> A git bisect pointed this regression to be introduced via [1] that a=
dded
> >>>> a mechanism to create device tree nodes for parent PCI bridges when =
a
> >>>> PCI device is hot-plugged.
> >>>>
> >>>> The Oops is caused when `pci_stop_dev()` tries to remove a non-exist=
ing
> >>>> device-tree node associated with the pci_dev that was earlier
> >>>> hot-plugged and was attached under a pci-bridge. The PCI dev header
> >>>> `dev->hdr_type` being 0, results a conditional check done with
> >>>> `pci_is_bridge()` into false. Consequently, a call to
> >>>> `of_pci_make_dev_node()` to create a device node is never made. When=
 at
> >>>> a later point in time, in the device node removal path, a memcpy is
> >>>> attempted in `__of_changeset_entry_invert()`; since the device node =
was
> >>>> never created, results in an Oops due to kernel read access to a bad
> >>>> address.
> >>>>
> >>>> To fix this issue, the patch updates `of_changeset_create_node()` to
> >>>> allocate a new node only when the device node doesn't exist and init=
 it
> >>>> in case it does already. Also, introduce `of_pci_free_node()` to be
> >>>> called to only revert and destroy the changeset device node that was
> >>>> created via a call to `of_changeset_create_node()`.
> >>>>
> >>>> [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
> >>>>
> >>>> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> >>>> Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> >>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> >>>> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> >>>> ---
> >>>> Changes since v1:
> >>>>       * Included Lizhi's suggested changes on V1
> >>>>       * Fixed below two warnings from Lizhi's changes and rearranged=
 the cleanup
> >>>>         part a bit in `of_pci_make_dev_node`
> >>>>           drivers/pci/of.c:611:6: warning: no previous prototype for=
 =E2=80=98of_pci_free_node=E2=80=99 [-Wmissing-prototypes]
> >>>>             611 | void of_pci_free_node(struct device_node *np)
> >>>>                 |      ^~~~~~~~~~~~~~~~
> >>>>           drivers/pci/of.c: In function =E2=80=98of_pci_make_dev_nod=
e=E2=80=99:
> >>>>           drivers/pci/of.c:696:1: warning: label =E2=80=98out_destro=
y_cset=E2=80=99 defined but not used [-Wunused-label]
> >>>>             696 | out_destroy_cset:
> >>>>                 | ^~~~~~~~~~~~~~~~
> >>>>       * V1: https://lore.kernel.org/all/20240703141634.2974589-1-ama=
chhiw@linux.ibm.com/
> >>>>
> >>>>    drivers/of/dynamic.c  | 16 ++++++++++++----
> >>>>    drivers/of/unittest.c |  2 +-
> >>>>    drivers/pci/bus.c     |  3 +--
> >>>>    drivers/pci/of.c      | 39 ++++++++++++++++++++++++++------------=
-
> >>>>    drivers/pci/pci.h     |  2 ++
> >>>>    include/linux/of.h    |  1 +
> >>>>    6 files changed, 43 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> >>>> index dda6092e6d3a..9bba5e82a384 100644
> >>>> --- a/drivers/of/dynamic.c
> >>>> +++ b/drivers/of/dynamic.c
> >>>> @@ -492,21 +492,29 @@ struct device_node *__of_node_dup(const struct=
 device_node *np,
> >>>>     * a given changeset.
> >>>>     *
> >>>>     * @ocs: Pointer to changeset
> >>>> + * @np: Pointer to device node. If null, allocate a new node. If no=
t, init an
> >>>> + *     existing one.
> >>>>     * @parent: Pointer to parent device node
> >>>>     * @full_name: Node full name
> >>>>     *
> >>>>     * Return: Pointer to the created device node or NULL in case of =
an error.
> >>>>     */
> >>>>    struct device_node *of_changeset_create_node(struct of_changeset =
*ocs,
> >>>> +                                            struct device_node *np,
> >>>>                                                struct device_node *p=
arent,
> >>>>                                                const char *full_name=
)
> >>>>    {
> >>>> -       struct device_node *np;
> >>>>           int ret;
> >>>>
> >>>> -       np =3D __of_node_dup(NULL, full_name);
> >>>> -       if (!np)
> >>>> -               return NULL;
> >>>> +       if (!np) {
> >>>> +               np =3D __of_node_dup(NULL, full_name);
> >>>> +               if (!np)
> >>>> +                       return NULL;
> >>>> +       } else {
> >>>> +               of_node_set_flag(np, OF_DYNAMIC);
> >>>> +               of_node_set_flag(np, OF_DETACHED);
> >>> Are we going to rename the function to
> >>> of_changeset_create_or_maybe_modify_node()? No. The functions here ar=
e
> >>> very clear in that they allocate new objects and don't reuse what's
> >>> passed in.
> >> Ok. How about keeping of_changeset_create_node unchanged.
> >>
> >> Instead, call kzalloc(), of_node_init() and of_changeset_attach_node()
> >>
> >> in of_pci_make_dev_node() directly.
> >>
> >> A similar example is dlpar_parse_cc_node().
> >>
> >>
> >> Does this sound better?
> > No, because really that code should be re-written using of_changeset
> > API.
> >
> > My suggestion is add a data pointer to struct of_changeset and then set
> > that to something to know the data ptr is a changeset and is your
> > changeset.
>
> I do not fully understand the point. I think the issue is that we do not
> know if a given of_node is created by of_pci_make_dev_node(), correct?

Yes.

> of_node->data can point to anything. And we do not know if it points a
> cset or not.

Right. But instead of checking "of_node->data =3D=3D of_pci_free_node",
you would just be checking "*(of_node->data) =3D=3D of_pci_free_node"
(omitting a NULL check and cast for simplicity). I suppose in theory
that could have a false match, but that could happen in this patch
already.

> Do you mean to add a flag (e.g. OF_PCI_DYNAMIC) to
> indicate of_node->data points to cset?

That would be another option, but OF_PCI_DYNAMIC would not be a good
name because that would be a flag bit for every single caller needing
similar functionality. Name it just what it indicates: of_node->data
points to cset

If we have that flag, then possibly the DT core can handle more
clean-up itself like calling detach and freeing the changeset.
Ideally, the flags should be internal to the DT code.

Rob


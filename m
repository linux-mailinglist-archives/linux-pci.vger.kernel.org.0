Return-Path: <linux-pci+bounces-10837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE593D26E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444261F21699
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11F17A93B;
	Fri, 26 Jul 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Lkr+zX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921913C83D;
	Fri, 26 Jul 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993835; cv=none; b=X3rkxmwEMvlwWUtisQZnG3QwnBpWnwR4059H7TAHdzrfE/bIYbpAk1TEsHBx3DL2XW1xrmOlBAA7VOblSSnr6/BVkDcgicxpH0t1HwKfJiBKHAmYcmmIhjJo5Lt3G8T8pN8o15TrSWZ0gwFNjkKBICU3HRxzb1YuQLXyEsrD5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993835; c=relaxed/simple;
	bh=WvZLgFXq158IjOD17d+/tjfHqiRPd+GmMQG0W3g+BEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiFoZ2ZStDhqwmudaExBISCkDq3Fxh7z3CkTi5Fr2GmHWNP3JZLm0THYypxDDYVEIfAyRnFSmipagaUv1DagtstIO/1kFe5btDaJxljmIEYVl8pavMWw/8VdNrnoaNBKj8FxKRiL6sQ5UY4n/hg0JQx+f29S3JleGKiFmG+pwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Lkr+zX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4221FC32782;
	Fri, 26 Jul 2024 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721993835;
	bh=WvZLgFXq158IjOD17d+/tjfHqiRPd+GmMQG0W3g+BEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6Lkr+zXK/RZ5NUEYsQTwbKuiEoQ5wYgR6atj0f5pS3gRvSJFzD70bpvvJBKnAS67
	 FpFasBPE8IFTZAG4lugjaAKziG5OKT7cM/eWPVZaah2sS3Py1bXZmXPViIUFXRdRxN
	 pzbx9dezREFqyVVlQazKWDOSHUh5QXeMccB48Rki+TSJfwKE5bDFCEznbJqTvQjx9e
	 9WT7k9LgVMhGwSonq2mn6W5RH6I676V9OZ0AlcM4v6C1I2K4D/hVq/21MIK4k4J3R4
	 1kuTuQEQv6im6vXE6cZWIFKo1kiWwNAkYRYO7okNBqBrxqMaYYA/ZtxDUmqMe3UyqB
	 6wiM4cNEAugKg==
Date: Fri, 26 Jul 2024 06:37:13 -0500
From: Rob Herring <robh@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: kernel-team@lists.ubuntu.com
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <20240726113713.GA974992-robh@kernel.org>
References: <20240715080726.2496198-1-amachhiw@linux.ibm.com>
 <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
 <a6c92c73-13fb-8e9c-29de-1437654c3880@amd.com>
 <20240723162107.GA501469-robh@kernel.org>
 <a8d2e310-9446-6cfa-fe00-4ef83cdb6590@amd.com>
 <CAL_JsqJjhaLFm9jiswJTfi4yZFYGKJUdC+HV662RLWEkJjxACw@mail.gmail.com>
 <ac3aeec4-70fc-cd9e-498c-acab0b218d9b@amd.com>
 <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>

+ Ubuntu kernel list, again

On Thu, Jul 25, 2024 at 11:15:39PM +0530, Amit Machhiwal wrote:
> Hi Lizhi, Rob,
> 
> Sorry for responding late. I got busy with some other things.
> 
> On 2024/07/23 02:08 PM, Lizhi Hou wrote:
> > 
> > On 7/23/24 12:54, Rob Herring wrote:
> > > On Tue, Jul 23, 2024 at 12:21 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
> > > > 
> > > > On 7/23/24 09:21, Rob Herring wrote:
> > > > > On Mon, Jul 15, 2024 at 01:52:30PM -0700, Lizhi Hou wrote:
> > > > > > On 7/15/24 11:55, Rob Herring wrote:
> > > > > > > On Mon, Jul 15, 2024 at 2:08 AM Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> > > > > > > > With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> > > > > > > > of a PCI device attached to a PCI-bridge causes following kernel Oops on
> > > > > > > > a pseries KVM guest:
> > > > > > > > 
> > > > > > > >     RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
> > > > > > > >     Kernel attempted to read user page (10ec00000048) - exploit attempt? (uid: 0)
> > > > > > > >     BUG: Unable to handle kernel data access on read at 0x10ec00000048
> > > > > > > >     Faulting instruction address: 0xc0000000012d8728
> > > > > > > >     Oops: Kernel access of bad area, sig: 11 [#1]
> > > > > > > >     LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> > > > > > > > <snip>
> > > > > > > >     NIP [c0000000012d8728] __of_changeset_entry_invert+0x10/0x1ac
> > > > > > > >     LR [c0000000012da7f0] __of_changeset_revert_entries+0x98/0x180
> > > > > > > >     Call Trace:
> > > > > > > >     [c00000000bcc3970] [c0000000012daa60] of_changeset_revert+0x58/0xd8
> > > > > > > >     [c00000000bcc39c0] [c000000000d0ed78] of_pci_remove_node+0x74/0xb0
> > > > > > > >     [c00000000bcc39f0] [c000000000cdcfe0] pci_stop_bus_device+0xf4/0x138
> > > > > > > >     [c00000000bcc3a30] [c000000000cdd140] pci_stop_and_remove_bus_device_locked+0x34/0x64
> > > > > > > >     [c00000000bcc3a60] [c000000000cf3780] remove_store+0xf0/0x108
> > > > > > > >     [c00000000bcc3ab0] [c000000000e89e04] dev_attr_store+0x34/0x78
> > > > > > > >     [c00000000bcc3ad0] [c0000000007f8dd4] sysfs_kf_write+0x70/0xa4
> > > > > > > >     [c00000000bcc3af0] [c0000000007f7248] kernfs_fop_write_iter+0x1d0/0x2e0
> > > > > > > >     [c00000000bcc3b40] [c0000000006c9b08] vfs_write+0x27c/0x558
> > > > > > > >     [c00000000bcc3bf0] [c0000000006ca168] ksys_write+0x90/0x170
> > > > > > > >     [c00000000bcc3c40] [c000000000033248] system_call_exception+0xf8/0x290
> > > > > > > >     [c00000000bcc3e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > > > > > > > <snip>
> > > > > > > > 
> > > > > > > > A git bisect pointed this regression to be introduced via [1] that added
> > > > > > > > a mechanism to create device tree nodes for parent PCI bridges when a
> > > > > > > > PCI device is hot-plugged.
> > > > > > > > 
> > > > > > > > The Oops is caused when `pci_stop_dev()` tries to remove a non-existing
> > > > > > > > device-tree node associated with the pci_dev that was earlier
> > > > > > > > hot-plugged and was attached under a pci-bridge. The PCI dev header
> > > > > > > > `dev->hdr_type` being 0, results a conditional check done with
> > > > > > > > `pci_is_bridge()` into false. Consequently, a call to
> > > > > > > > `of_pci_make_dev_node()` to create a device node is never made. When at
> > > > > > > > a later point in time, in the device node removal path, a memcpy is
> > > > > > > > attempted in `__of_changeset_entry_invert()`; since the device node was
> > > > > > > > never created, results in an Oops due to kernel read access to a bad
> > > > > > > > address.
> > > > > > > > 
> > > > > > > > To fix this issue, the patch updates `of_changeset_create_node()` to
> > > > > > > > allocate a new node only when the device node doesn't exist and init it
> > > > > > > > in case it does already. Also, introduce `of_pci_free_node()` to be
> > > > > > > > called to only revert and destroy the changeset device node that was
> > > > > > > > created via a call to `of_changeset_create_node()`.
> > > > > > > > 
> > > > > > > > [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > > > > > 
> > > > > > > > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > > > > > Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> > > > > > > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > > > > > > > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > > > > > > > ---
> > > > > > > > Changes since v1:
> > > > > > > >        * Included Lizhi's suggested changes on V1
> > > > > > > >        * Fixed below two warnings from Lizhi's changes and rearranged the cleanup
> > > > > > > >          part a bit in `of_pci_make_dev_node`
> > > > > > > >            drivers/pci/of.c:611:6: warning: no previous prototype for ‘of_pci_free_node’ [-Wmissing-prototypes]
> > > > > > > >              611 | void of_pci_free_node(struct device_node *np)
> > > > > > > >                  |      ^~~~~~~~~~~~~~~~
> > > > > > > >            drivers/pci/of.c: In function ‘of_pci_make_dev_node’:
> > > > > > > >            drivers/pci/of.c:696:1: warning: label ‘out_destroy_cset’ defined but not used [-Wunused-label]
> > > > > > > >              696 | out_destroy_cset:
> > > > > > > >                  | ^~~~~~~~~~~~~~~~
> > > > > > > >        * V1: https://lore.kernel.org/all/20240703141634.2974589-1-amachhiw@linux.ibm.com/
> > > > > > > > 
> > > > > > > >     drivers/of/dynamic.c  | 16 ++++++++++++----
> > > > > > > >     drivers/of/unittest.c |  2 +-
> > > > > > > >     drivers/pci/bus.c     |  3 +--
> > > > > > > >     drivers/pci/of.c      | 39 ++++++++++++++++++++++++++-------------
> > > > > > > >     drivers/pci/pci.h     |  2 ++
> > > > > > > >     include/linux/of.h    |  1 +
> > > > > > > >     6 files changed, 43 insertions(+), 20 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > > > > > > index dda6092e6d3a..9bba5e82a384 100644
> > > > > > > > --- a/drivers/of/dynamic.c
> > > > > > > > +++ b/drivers/of/dynamic.c
> > > > > > > > @@ -492,21 +492,29 @@ struct device_node *__of_node_dup(const struct device_node *np,
> > > > > > > >      * a given changeset.
> > > > > > > >      *
> > > > > > > >      * @ocs: Pointer to changeset
> > > > > > > > + * @np: Pointer to device node. If null, allocate a new node. If not, init an
> > > > > > > > + *     existing one.
> > > > > > > >      * @parent: Pointer to parent device node
> > > > > > > >      * @full_name: Node full name
> > > > > > > >      *
> > > > > > > >      * Return: Pointer to the created device node or NULL in case of an error.
> > > > > > > >      */
> > > > > > > >     struct device_node *of_changeset_create_node(struct of_changeset *ocs,
> > > > > > > > +                                            struct device_node *np,
> > > > > > > >                                                 struct device_node *parent,
> > > > > > > >                                                 const char *full_name)
> > > > > > > >     {
> > > > > > > > -       struct device_node *np;
> > > > > > > >            int ret;
> > > > > > > > 
> > > > > > > > -       np = __of_node_dup(NULL, full_name);
> > > > > > > > -       if (!np)
> > > > > > > > -               return NULL;
> > > > > > > > +       if (!np) {
> > > > > > > > +               np = __of_node_dup(NULL, full_name);
> > > > > > > > +               if (!np)
> > > > > > > > +                       return NULL;
> > > > > > > > +       } else {
> > > > > > > > +               of_node_set_flag(np, OF_DYNAMIC);
> > > > > > > > +               of_node_set_flag(np, OF_DETACHED);
> > > > > > > Are we going to rename the function to
> > > > > > > of_changeset_create_or_maybe_modify_node()? No. The functions here are
> > > > > > > very clear in that they allocate new objects and don't reuse what's
> > > > > > > passed in.
> > > > > > Ok. How about keeping of_changeset_create_node unchanged.
> > > > > > 
> > > > > > Instead, call kzalloc(), of_node_init() and of_changeset_attach_node()
> > > > > > 
> > > > > > in of_pci_make_dev_node() directly.
> > > > > > 
> > > > > > A similar example is dlpar_parse_cc_node().
> > > > > > 
> > > > > > 
> > > > > > Does this sound better?
> > > > > No, because really that code should be re-written using of_changeset
> > > > > API.
> > > > > 
> > > > > My suggestion is add a data pointer to struct of_changeset and then set
> > > > > that to something to know the data ptr is a changeset and is your
> > > > > changeset.
> > > > I do not fully understand the point. I think the issue is that we do not
> > > > know if a given of_node is created by of_pci_make_dev_node(), correct?
> > > Yes.
> > > 
> > > > of_node->data can point to anything. And we do not know if it points a
> > > > cset or not.
> > > Right. But instead of checking "of_node->data == of_pci_free_node",
> > > you would just be checking "*(of_node->data) == of_pci_free_node"
> > 
> > if of_node->data is a char* pointer, it would be panic. So I used
> > of_node->data == of_pci_free_node.
> > 
> > > (omitting a NULL check and cast for simplicity). I suppose in theory
> > > that could have a false match, but that could happen in this patch
> > > already.
> > 
> > I think if any other kernel code  put of_pci_free_node to of_node->data, it
> > can be fixed over there.
> > 
> > > 
> > > > Do you mean to add a flag (e.g. OF_PCI_DYNAMIC) to
> > > > indicate of_node->data points to cset?
> > > That would be another option, but OF_PCI_DYNAMIC would not be a good
> > > name because that would be a flag bit for every single caller needing
> > > similar functionality. Name it just what it indicates: of_node->data
> > > points to cset
> > > 
> > > If we have that flag, then possibly the DT core can handle more
> > > clean-up itself like calling detach and freeing the changeset.
> > > Ideally, the flags should be internal to the DT code.
> > 
> > Sure. If you prefer this option, I will propose another fix.
> > 
> 
> The crash in question is a critical issue that we would want to have a fix for
> soon. And while this is still being figured out, is it okay to go with the fix I
> proposed in the V1 of this patch?

No, sorry but this is not critical. This config option should be off. 
Fix the distro. They turned it on. If hiding it behind CONFIG_EXPERT or 
something would work, that would be fine for upstream. But I suspect 
Ubuntu turns that on because they turn on everything...

Rob


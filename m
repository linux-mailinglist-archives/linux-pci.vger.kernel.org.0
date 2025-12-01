Return-Path: <linux-pci+bounces-42373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB01C97E3B
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4160342CD0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C531BCBC;
	Mon,  1 Dec 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMtGdgGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692B302152
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600314; cv=none; b=Vacatvu7wXvROCyZtijOSf2Ku4goV7xATlhn8XHz/OIPAjPLLDVk9xO4uMJXs33js8V8je3LMcr9NArMwvJpwFNy9d0DbYRDis/15I8+3CVUteW37XJk4bmTSmAwS6ozHTJ1F27OG3DSs2aD/j4enuH0WZ8ceSJgFPMkkqAbFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600314; c=relaxed/simple;
	bh=VrFNoeObgkWMawA3WMEOayqdOmEdgYgazeErRriF79g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK/HST9w1pf2tm+LYspF4/YdA4XBItzp6lvM0I72Tzqf6I7i54pXBNysxL5h3+p54LCIbk47Gup83cfQy72iEVytjjIl578GLccQAJBzdm4wltvCS3hvZDFr7D5MEuYTfAxYouQ1Yu9kZ8cjSUPWSUXUEV7hfgSkwHlmiKkkYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMtGdgGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECE8C2BC86
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764600313;
	bh=VrFNoeObgkWMawA3WMEOayqdOmEdgYgazeErRriF79g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pMtGdgGYwdrVDOSl2W0+qrRlgCLEgaU7IGTTU/12gN3UCsgQdN+opGIHo8pRpP1Kj
	 4uFFBFd5xWbKWS7tfxvmb1ZVmd57if+tPFmv0fMt9mI5S/RXPQRA6+faMaJR8PyV75
	 9Ty6CdzF6NvKUyWcctl2LTW416EfLkwkLsr8ga+CuCixVG7ECRTUg+MG/fslgmirAT
	 B9+3SGVI7IUmKml3EUsja2vs3gmFEfv3WBF3q9rC3ni68WRUZQeYNItrYJSyl10Hw4
	 o6pGv+GnWtnNOKml9KDYLFmsQnSwSHS36gvhbA5c1otnuNjOTE964RUCKhngh9i2O7
	 jgoiPJr8yljqw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b73161849e1so1042515166b.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 06:45:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU46oWSkYIJHU+kfiSJ/2De/CGIr8VvPxNjUwYOULz1sjjgosoICnUSKdYdCDtud8ydTSUUBoXXeWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/7qy17X6bkPAsywBIy3aN04qx6wHyC3r9mZPNKu6E4kwCtCb
	V9hfzyHGDNBtWQXfft9sXn0Ue2+0lNNU1qKyG8DgZU422+OtZZeGzVM+cbD0GvB5Tew3WIAoDPJ
	UT/wlm0bdjPIZB0Q996pLOuicFjUKvEk=
X-Google-Smtp-Source: AGHT+IFy91U2+uB01Gsp4un0xk6Bx6Yj25pytNj/dKusTxKAoaiBEv1+Gw6wMtj2qwcVruVrp4FxT1g3aKbozzQQv8I=
X-Received: by 2002:a17:906:c115:b0:b72:b8a9:78f4 with SMTP id
 a640c23a62f3a-b7671701537mr4016410666b.39.1764600312258; Mon, 01 Dec 2025
 06:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com> <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
 <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
 <CAAhV-H4MNSiUqYpE919YcCaC-_-Q3GBwxRL13ggjsyLahQ-t1A@mail.gmail.com>
 <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com> <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
In-Reply-To: <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Dec 2025 22:45:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com>
X-Gm-Features: AWmQ_blvZ9XPwC0XmqlAg5tMbfsMq-rVhkV9GFeSBfFXHYYgnWYh4mGTV8zI8aE
Message-ID: <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev, 
	Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:30=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Mon, 2025-11-10 at 14:08 +0100, Niklas Schnelle wrote:
> > On Fri, 2025-11-07 at 15:19 +0800, Huacai Chen wrote:
> > > On Wed, Nov 5, 2025 at 5:46=E2=80=AFPM Niklas Schnelle <schnelle@linu=
x.ibm.com> wrote:
> > > >
> > > > On Wed, 2025-11-05 at 09:01 +0800, Huacai Chen wrote:
> > > > > On Mon, Nov 3, 2025 at 7:23=E2=80=AFPM Niklas Schnelle <schnelle@=
linux.ibm.com> wrote:
> > > > > >
> > > > > > On Mon, 2025-11-03 at 17:50 +0800, Huacai Chen wrote:
> > > > > > > Hi, Niklas,
> > > > > > >
> > > > > > > On Wed, Oct 29, 2025 at 5:42=E2=80=AFPM Niklas Schnelle <schn=
elle@linux.ibm.com> wrote:
> --- snip ---
> > > > > > > >
> > > > > > > > Still especially the first issue prevents correct detection=
 of ARI and
> > > > > > > > the second might be a problem for other users of isolated f=
unction
> > > > > > > > probing. Fix both issues by keeping things as simple as pos=
sible. If
> > > > > > > > isolated function probing is enabled simply scan every poss=
ible devfn.
> > > > > > > I'm very sorry, but applying this patch on top of commit a02f=
d05661d7
> > > > > > > ("PCI: Extend isolated function probing to LoongArch") we fai=
l to
> > > > > > > boot.
> > > > > > >
> > > > > > > Boot log:
> > > > > > >
> --- snip ---
> > > > > >
> > > > > >
> > > > > > This looks like a warning telling us that AHCI enable failed / =
timed
> > > > > > out. Do you have Panic on Warn on that this directly causes a b=
oot
> > > > > > failure? The only relation I can see with my patch is that mayb=
e this
> > > > > > AHCI device wasn't probed before and somehow isn't working?
> > > > > The rootfs is on the AHCI controller, so AHCI failure causes the =
boot
> > > > > failure, without this patch no boot problems.
> > > > >
> > > > > Huacai
> > > > >
> > > >
> > > > Ok, I'm going to need more details to make sense of this. Can you t=
ell
> > > > me if ARI is enabled for that bus? Did you test with both patches o=
r
> > > > just this one? Could you provide lspci -vv from a good boot and can=
 you
> > > > tell which AHCI device the root device is on? Also could you clarif=
y
> > > > why you set hypervisor_isolated_pci_functions() in particular this
> > > > seems like a bare metal boot, right? When running in KVM do you pas=
s-
> > > > through individual PCI functions with the guest seeing a devfn othe=
r
> > > > than 0 alone, i.e. a missing devfn 0? Or do you need this for bare
> > > > metal for some reason? If you don't need it for bare metal, does th=
e
> > > > boot work if you return 0 from hypervisor_isolated_pci_functions() =
with
> > > > this patch?
> > > 1. ARI isn't enabled.
> > > 2. Only test the first patch.
> > > 3. This is a bare metal boot.
> > > 4. If hypervisor_isolated_pci_functions() return 0 then boot is OK
> > > 5. PCI information please see the attachment.
> > >
> > > Huacai
> >
> > Thanks for the input. As far as I can see the lspci from a good boot
> > shows no holes in your devfn space so this particular system doesn't
> > seem to need the isolated function probing at all. But even then using
> > it should only try out all devfns and thus never skip one that is found
> > without isolated function probing.
> >
> > To sanity check this, I just booted my personal AMD Ryzen 3900X system
> > with this series plus a two-liner to unconditionally enable isolated
> > function probing also on x86_64 and it came up fine including AMD
> > graphics and my Intel NIC with enabled SR-IOV.
> >
> > So I'm really perplexed and coming back to the thought that a device on
> > your system is misbehaving when probing is attempted and maybe due to a
> > similar issue as what I saw with SR-IOV it wasn't probed so far but
> > really should be probed if isolated function probing is enabled. I also
> > still don't understand your use-case. If it is for VMs then maybe you
> > could limit it to those? Otherwise it feels like this is just a hack to
> > probe an odd topology and I wonder if you should rather set
> > PCI_SCAN_ALL_PCIE_DEVS to find those?
> >
> > Thanks,
> > Niklas
>
> Hi LoongArch Maintainers, Hi Bjorn,
>
> Sorry for the ping but I'd really like to somehow get this unstuck and
> I haven't heard back on my previous questions. From my testing on s390
> this patch fixes a real logic error which prevents the scanning of some
> devfns which I believe should be scanned if isolated functions are
> possible. And in all my testing, including on x86 as stated in the
> previous mail, the code does exactly what I think it is supposed to do.
> So to me it really looks like something goes wrong with your use of
> hypervisor_isolated_pci_functions() on your specific hardware.
>
> One idea I had is if maybe you need to somehow exclude known empty
> slots in you config space accessors?
>
> And just in general I'd really like to better understand your use-case
> for the isolated PCI functions. And speaking of that, I'm sorry for
> having been so blunt in my last mail saying that it felt like a hack.
> I'm just worried, that we've run into incompatible interpretations or
> uses of this feature that now prevent us from fixing actual bugs.
Sorry for the late reply, Let me describe what problem LoongArch has.

You said that "it feels like this is just a hack to probe an odd
topology". Yes, to some extent you are right.

1, One of our SoC (LS2K3000) has a special device which has func1 but
without func0. To let the PCI core scan func1 we can only make
hypervisor_isolated_pci_functions() return true.
2, In the above case, PCI_SCAN_ALL_PCIE_DEVS has no help.
3, Though we change hypervisor_isolated_pci_functions() to resolve the
above problem, it also lets us pass isolated PCI functions to a guest
OS instance.

As a summary, for real machines commit a02fd05661d73a850 is a hack to
probe an odd device, for virtual machines it allows passing isolated
PCI functions.



Huacai

>
> Thanks in advance,
> Niklas Schnelle


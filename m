Return-Path: <linux-pci+bounces-29833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3EADA885
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 08:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64F5164ED0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D261E98F3;
	Mon, 16 Jun 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc++Dem0"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566A1E501C
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056629; cv=none; b=uTU1yj9WCnqr4u5cNjTxk7HhKnFn4dEH1Zr705Ur28bFKX0cknAdNdxNuREayEHzaeE3cSoo6/ztA55EU9cepcNmnfAecxq2iJr/HaoVNuQiWvCIhlDiRgaLPORYLQJejLfsOqQXCulQDSBiOSfVuQyz0EL3vGD7/xIslnGgwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056629; c=relaxed/simple;
	bh=NWBXuGEPplf6s9Vsr8zo1PmmmeCgyUJS7DtJAO0YYXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQQNmvZOL+Z/YZfD60UKpYrXx3rTcZIFBEeY3Ghwa7t0LD+xhHWqvEIwldBLTPJDM8C/qwFKbqcJgSK8zLrTX0LgUZEK3FQKNG6Sg2bfJKOlSHjvI12zAIZivOgzTtDxKfLdQA4IbbTPiyT+aHyqqM8w009fXA2rQDIo1v/DQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc++Dem0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750056625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ili6Db+cRZ3CJSQMFsv/UQqNQpr8FJG8F/jo4g09k8U=;
	b=Wc++Dem0MT4FlHIdLEqCk3cExCh+pww58sj0P31fORqlUy7OQd3XAQcSbz6q4CBl+V8qOb
	gZr0f8EXZKOzUshc4lvIoEuTm38EQOlCicyh0qn91wvF9YZObevzQlyd/awL32MI+dzXNV
	+paAX4xKOVvSDfS0p0plkIH0dAYfs1I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-i8ZvXa0UP-KBTr_CK7CgkA-1; Mon, 16 Jun 2025 02:50:23 -0400
X-MC-Unique: i8ZvXa0UP-KBTr_CK7CgkA-1
X-Mimecast-MFC-AGG-ID: i8ZvXa0UP-KBTr_CK7CgkA_1750056623
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so4136458a91.2
        for <linux-pci@vger.kernel.org>; Sun, 15 Jun 2025 23:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750056623; x=1750661423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ili6Db+cRZ3CJSQMFsv/UQqNQpr8FJG8F/jo4g09k8U=;
        b=c1jTIxHV/ZpQQHyqAueWJWSjNHM4Nwc0k/+CiiuyA7HrVBT/UbDC7t9wpgpn2eTtaA
         /u9RZjBf+NCdwOBWMyIxgIQdfP6f2sjaDqvOy9WfzvaeES+PAWeDqKhgZeKGZx1P1uQN
         KQCvDD+HTfm5ztOL7KNiFl1kNjRDSGFJ3WOYYYvYnGgP05HKhNlhHulh5YZt7rPl33em
         huXOt/VpAeO9MwQv1k17vTFIg800YGSR8qyMxtDKam8MqoO+83IohAPObb5ugSioVFFQ
         TJ+vLZgcfXlyg1KI0oYl3CuKEqJBtRO4zecFFmzbk8yeMFeyxFAFkPwNflxu2UqU3gDZ
         4wRw==
X-Forwarded-Encrypted: i=1; AJvYcCVvIrdqMYJo/i+zh0EVJNZDmFP60D+Gt7XbDAPefSWsijLcgmFP1ExyEceM5rPROlRaUtLqCESoyeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5GfN8JVPzJSWxwC/EYGCuLVgyIbsZjisWTM7eO677NGJ/+SN
	NLGIWzN1rUZjOKa0THe8LXQZoa4E6++7Pq0hgqFGkVKcCv+MsZYXRMnxGa8R3PMkxR2XndeOlod
	M1jv9b3911zfPm2m25IroPBagmdnt4Kn+m2nK0HrCF2ZFqA5mmpCdsKX1daZfF1414RxsoLsYg2
	8/xyvd8+9ae0imIOFj6tSJHLk65/0SXabJ+WDh
X-Gm-Gg: ASbGncuZtkkL+fqjztC6RznJ7IZpBFsxQ4yWA0f4rKnp6iX/t4U7nB//z/M8j6S8Fj3
	rPbOE32z7C3Nv/f76gvNocrgRv8pRNoDaI6mnXK3lWsISOAmPiFUQumok2TAxLQDyns6fTTCiUr
	5h1w==
X-Received: by 2002:a17:90b:53c5:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-313f1daa7b4mr11523509a91.19.1750056622639;
        Sun, 15 Jun 2025 23:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdp4beJSuiH/vIIteXcSgqpY6id6VgA4b+iMpDbfJuBDo3oUPLhwIAtx+t70FfS+DvxvsJIxS3/X2YpmHt17Q=
X-Received: by 2002:a17:90b:53c5:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-313f1daa7b4mr11523478a91.19.1750056622120; Sun, 15 Jun 2025
 23:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613190718.GA968774@bhelgaas> <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
 <20250613151929.3c944c3c.alex.williamson@redhat.com> <7d491f5f-5af6-47ce-9950-975e33f706bb@kernel.org>
 <bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de>
In-Reply-To: <bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de>
From: David Airlie <airlied@redhat.com>
Date: Mon, 16 Jun 2025 16:50:10 +1000
X-Gm-Features: AX0GCFtzxM-9et57aS-X0ZKjBIEf8PakcnOaoKkeCEpJ6zVSUFD_gnpF6Z96vFk
Message-ID: <CAMwc25oTD8+75NB1mo_93-14U_ZsEEMoUaKZLpu-MBszusFRBw@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <superm1@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 4:42=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 13.06.25 um 23:29 schrieb Mario Limonciello:
> > On 6/13/2025 4:19 PM, Alex Williamson wrote:
> >> On Fri, 13 Jun 2025 14:31:10 -0500
> >> Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >>> On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
> >>>> On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
> >>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>
> >>>>> On an A+N mobile system the APU is not being selected by some deskt=
op
> >>>>> environments for any rendering tasks. This is because the neither G=
PU
> >>>>> is being treated as "boot_vga" but that is what some environments u=
se
> >>>>> to select a GPU [1].
> >>>>
> >>>> What is "A+N" and "APU"?
> >>>
> >>> A+N is meant to refer to an AMD APU + NVIDIA dGPU.
> >>> APU is an SoC that contains a lot more IP than just x86 cores.  In th=
is
> >>> context it contains both integrated graphics and display IP.
> >>>
> >>>>
> >>>> I didn't quite follow the second sentence.  I guess you're saying so=
me
> >>>> userspace environments use the "boot_vga" sysfs file to select a GPU=
?
> >>>> And on this A+N system, neither device has the file?
> >>>
> >>> Yeah.  Specifically this problem happens in Xorg that the library it
> >>> uses (libpciaccess) looks for a boot_vga file.  That file isn't
> >>> found on
> >>> either GPU and so Xorg picks the first GPU it finds in the PCI
> >>> heirarchy
> >>> which happens to be the NVIDIA GPU.
> >>>
> >>>>> The VGA arbiter driver only looks at devices that report as PCI
> >>>>> display
> >>>>> VGA class devices. Neither GPU on the system is a display VGA class
> >>>>> device:
> >>>>>
> >>>>> c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> >>>>> c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >>>>> Device 150e (rev d1)
> >>>>>
> >>>>> So neither device gets the boot_vga sysfs file. The
> >>>>> vga_is_boot_device()
> >>>>> function already has some handling for integrated GPUs by looking
> >>>>> at the
> >>>>> ACPI HID entries, so if all PCI display class devices are looked
> >>>>> at it
> >>>>> actually can detect properly with this device ordering. However if
> >>>>> there
> >>>>> is a different ordering it could flag the wrong device.
> >>>>>
> >>>>> Modify the VGA arbiter code and matching sysfs file entries to
> >>>>> examine all
> >>>>> PCI display class devices. After every device is added to the
> >>>>> arbiter list
> >>>>> make a pass on all devices and explicitly check whether one is
> >>>>> integrated.
> >>>>>
> >>>>> This will cause all GPUs to gain a `boot_vga` file, but the
> >>>>> correct device
> >>>>> (APU in this case) will now show `1` and the incorrect device
> >>>>> shows `0`.
> >>>>> Userspace then picks the right device as well.
> >>>>
> >>>> What determines whether the APU is the "correct" device?
> >>>
> >>> In this context is the one that is physically connected to the eDP
> >>> panel.  When the "wrong" one is selected then it is used for renderin=
g.
> >>>
> >>> Without this patch the net outcome ends up being that the APU display
> >>> hardware drives the eDP but the desktop is rendered using the N dGPU.
> >>> There is a lot of latency in doing it this way, and worse off the N
> >>> dGPU
> >>> stays powered on at all times.  It never enters into runtime PM.
> >>>
> >>>>> Link:
> >>>>> https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f10=
7014b285cbda097acae1e12
> >>>>> [1]
> >>>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>> ---
> >>>>> RFC->v1:
> >>>>>    * Add tag
> >>>>>    * Drop unintended whitespace change
> >>>>>    * Use vgaarb_dbg instead of vgaarb_info
> >>>>> ---
> >>>>>    drivers/pci/pci-sysfs.c |  2 +-
> >>>>>    drivers/pci/vgaarb.c    | 48
> >>>>> +++++++++++++++++++++++++++--------------
> >>>>>    include/linux/pci.h     | 15 +++++++++++++
> >>>>>    3 files changed, 48 insertions(+), 17 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >>>>> index 268c69daa4d57..c314ee1b3f9ac 100644
> >>>>> --- a/drivers/pci/pci-sysfs.c
> >>>>> +++ b/drivers/pci/pci-sysfs.c
> >>>>> @@ -1707,7 +1707,7 @@ static umode_t
> >>>>> pci_dev_attrs_are_visible(struct kobject *kobj,
> >>>>>        struct device *dev =3D kobj_to_dev(kobj);
> >>>>>        struct pci_dev *pdev =3D to_pci_dev(dev);
> >>>>>    -    if (a =3D=3D &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> >>>>> +    if (a =3D=3D &dev_attr_boot_vga.attr && pci_is_display(pdev))
> >>>>>            return a->mode;
> >>>>>           return 0;
> >>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >>>>> index 78748e8d2dbae..0eb1274d52169 100644
> >>>>> --- a/drivers/pci/vgaarb.c
> >>>>> +++ b/drivers/pci/vgaarb.c
> >>>>> @@ -140,6 +140,7 @@ void vga_set_default_device(struct pci_dev *pde=
v)
> >>>>>        if (vga_default =3D=3D pdev)
> >>>>>            return;
> >>>>>    +    vgaarb_dbg(&pdev->dev, "selecting as VGA boot device\n");
> >>>>
> >>>> I guess this is essentially a move of the vgaarb_info() message from
> >>>> vga_arbiter_add_pci_device() to here?  If so, I think I would preser=
ve
> >>>> the _info() level.  Including non-VGA devices is fairly subtle and I
> >>>> don't think we need to discard potentially useful information about
> >>>> what we're doing.
> >>>
> >>> Thanks - that was my original RFC before I sent this as PATCH but
> >>> Thomas
> >>> had suggested to decrease to debug.  I'll restore in the next spin.
> >>>
> >>>>>        pci_dev_put(vga_default);
> >>>>>        vga_default =3D pci_dev_get(pdev);
> >>>>>    }
> >>>>> @@ -751,6 +752,31 @@ static void
> >>>>> vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
> >>>>>            vgaarb_info(&vgadev->pdev->dev, "no bridge control
> >>>>> possible\n");
> >>>>>    }
> >>>>>    +static
> >>>>> +void vga_arbiter_select_default_device(void)
> >>>>
> >>>> Signature on one line.
> >>>
> >>> Ack
> >>>
> >>>>> +{
> >>>>> +    struct pci_dev *candidate =3D vga_default_device();
> >>>>> +    struct vga_device *vgadev;
> >>>>> +
> >>>>> +    list_for_each_entry(vgadev, &vga_list, list) {
> >>>>> +        if (vga_is_boot_device(vgadev)) {
> >>>>> +            /* check if one is an integrated GPU, use that if so *=
/
> >>>>> +            if (candidate) {
> >>>>> +                if (vga_arb_integrated_gpu(&candidate->dev))
> >>>>> +                    break;
> >>>>> +                if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
> >>>>> +                    candidate =3D vgadev->pdev;
> >>>>> +                    break;
> >>>>> +                }
> >>>>> +            } else
> >>>>> +                candidate =3D vgadev->pdev;
> >>>>> +        }
> >>>>> +    }
> >>>>> +
> >>>>> +    if (candidate)
> >>>>> +        vga_set_default_device(candidate);
> >>>>> +}
> >>>>
> >>>> It looks like this is related to the integrated GPU code in
> >>>> vga_is_boot_device().  Can this be done by updating the logic there,
> >>>> so it's more clear what change this patch makes?
> >>>>
> >>>> It seems like this patch would change the selection in a way that
> >>>> makes some of the vga_is_boot_device() comments obsolete. E.g., "We
> >>>> select the default VGA device in this order"?  Or "we use the *last*
> >>>> [integrated GPU] because that was the previous behavior"?
> >>>>
> >>>> The end of vga_is_boot_device() mentions non-legacy (non-VGA) device=
s,
> >>>> but I don't remember now how we ever got there because
> >>>> vga_arb_device_init() and pci_notify() only call
> >>>> vga_arbiter_add_pci_device() for VGA devices.
> >>>
> >>> Sure I'll review the comments and update.  As for moving the logic I
> >>> didn't see an obvious way to do this.  This code is "tie-breaker" cod=
e
> >>> in the case that two GPUs are otherwise ranked equally.
> >>>
> >>>>>    /*
> >>>>>     * Currently, we assume that the "initial" setup of the system
> >>>>> is not sane,
> >>>>>     * that is, we come up with conflicting devices and let the
> >>>>> arbiter's
> >>>>> @@ -816,23 +842,17 @@ static bool
> >>>>> vga_arbiter_add_pci_device(struct pci_dev *pdev)
> >>>>>            bus =3D bus->parent;
> >>>>>        }
> >>>>>    -    if (vga_is_boot_device(vgadev)) {
> >>>>> -        vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> >>>>> -                vga_default_device() ?
> >>>>> -                " (overriding previous)" : "");
> >>>>> -        vga_set_default_device(pdev);
> >>>>> -    }
> >>>>> -
> >>>>>        vga_arbiter_check_bridge_sharing(vgadev);
> >>>>>           /* Add to the list */
> >>>>>        list_add_tail(&vgadev->list, &vga_list);
> >>>>>        vga_count++;
> >>>>> -    vgaarb_info(&pdev->dev, "VGA device added:
> >>>>> decodes=3D%s,owns=3D%s,locks=3D%s\n",
> >>>>> +    vgaarb_dbg(&pdev->dev, "VGA device added:
> >>>>> decodes=3D%s,owns=3D%s,locks=3D%s\n",
> >>>>
> >>>> Looks like an unrelated change.
> >>>
> >>> Yeah it was going with the theme from Thomas' comment to decrease to
> >>> debug.  I'll put it back to info.
> >>>
> >>>>> vga_iostate_to_str(vgadev->decodes),
> >>>>>            vga_iostate_to_str(vgadev->owns),
> >>>>>            vga_iostate_to_str(vgadev->locks));
> >>>>>    +    vga_arbiter_select_default_device();
> >>>>>        spin_unlock_irqrestore(&vga_lock, flags);
> >>>>>        return true;
> >>>>>    fail:
> >>>>> @@ -1499,8 +1519,8 @@ static int pci_notify(struct notifier_block
> >>>>> *nb, unsigned long action,
> >>>>>           vgaarb_dbg(dev, "%s\n", __func__);
> >>>>>    -    /* Only deal with VGA class devices */
> >>>>> -    if (!pci_is_vga(pdev))
> >>>>> +    /* Only deal with display devices */
> >>>>> +    if (!pci_is_display(pdev))
> >>>>>            return 0;
> >>>>
> >>>> Are there any other pci_is_vga() users that might want
> >>>> pci_is_display() instead?  virtio_gpu_pci_quirk()?
> >>>
> >>> +AlexW for comments on potential virtio changes here.
> >>
> >> I can't comment on virtio_gpu, Cc +Gerd for that.
> >>
> >> I do however take issue with the premise of this patch.  The VGA
> >> arbiter is for adjusting VGA routing.  If neither device is VGA, why
> >> are they registering with the VGA arbiter and what sense does it make
> >> to create a boot_vga sysfs attribute of a non-VGA device?
> >>
> >> It seems like we're trying to adapt the kernel to create a facade for
> >> userspace when userspace should be falling back to some other means of
> >> determining a primary graphical device.  For instance, is there
> >> something in UEFI that could indicate the console?  ACPI?  DT?
> >>
> >> It's also a bit concerning that we're making a policy decision here
> >> that the integrated graphics is the "boot VGA" device, among two
> >> non-VGA devices.  I think vgaarb has a similar legacy policy decision
> >> for VGA devices that it's stuck with, but it's not clear to me that
> >> reiterating the policy selection here is still correct.  Thanks,
> >>
> >> Alex
> >
> > I'm with you there. That's actually exactly why the first swing at
> > this was with a patch to userspace.
> >
> > https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/3=
7
>
> I second Alex' point. I acked the patch purely on my understanding of
> how it does this, but as I noted, I'd also prefer to solve this in user
> space. I think we should push back on this change.
>

If we are solving this in userspace I think fixing it in libpciaccess
is probably also the wrong place, which leaves open where is the right
place?

To be honest the what GPU is driving the display at boot hint should
come from the kernel, since it knows already, whether boot_vga is the
best method of doing that is open to questions.

It might be better to have a bit somewhere on the drm device that shows thi=
s.

hello new UAPI.

Dave.



Return-Path: <linux-pci+bounces-7586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93C8C8008
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 04:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBC51C21346
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 02:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF038F55;
	Fri, 17 May 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdXj5Tne"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575368BEC;
	Fri, 17 May 2024 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913736; cv=none; b=fkZNRI+QlzVqurtheJFWOzP+cloWFQufJ9Nkmxwpz3wogQNMrQ2hc+R45wLF1TpN+IwDPxp33ezi4LkktXwde1OPaUXH2NLDUBKlqiPfbScv8RObBN7TrLuSDxO2fC7GsjO5dddHuak+5igKMxinXTBHo2jog2waOMWans4lY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913736; c=relaxed/simple;
	bh=WodVcJh73YpTkSOwyx/wOx/H3ajn1r8ohdVxGFZm3SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgWkJIpYP66ixhYc6UtQmkt/60zCgw/CO0IbtyAfKWUaU/GzqSFQEY/FqNHh1GNKm25JVzHAFPp8jSZk1yncNPZ3BynNU9iVJRbR5YQ/LAieT0isuGTSKgYOyk6POFVgVMmiQ+qTaMd2+2XgWm4ZguTvw/rcjkSHP/KvwvTF8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdXj5Tne; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed012c1afbso1074015ad.1;
        Thu, 16 May 2024 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715913735; x=1716518535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu2nPLySUoXUvyZFL//KZJHIe3bVp51aDCyU25xG8Wc=;
        b=bdXj5TneZmhxxZw3ic8gdKItNvztrOr2f5tAvZ0ddZdryUSWNssgUnZirK33SuzOyC
         /CzMhpPtF1KnQmiR0wge7MBrBecThOQgnbxUyNVXsc67ZI2p2QFVg/yxnzn7e+NO9n8D
         er9PjVLXkTWszTkUEjIyNrkK/8p5aJ+hApGe7U3EOObdVHH7w9zXH7MBLrcC0P2QGkjZ
         EDAhHaiMmfcaX6lMl8F85FwvIlfB8oORzxVo8P+PiojlLT9FBAmhvFXvy05a0dViG4Dd
         5B5384Ft9C3cLJuO+zaGgi3e7xhuiKoHetatjv0bldQnhJ0W71OI98c2VPFIyddGKPWO
         7eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913735; x=1716518535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu2nPLySUoXUvyZFL//KZJHIe3bVp51aDCyU25xG8Wc=;
        b=IF2BZ611I2ZB2qfty07BjFZpSAN50D0MTlqrhX+28rflg9mMsgV9ig5tehHkvokVcU
         4ciRcPuOftNFPDQATDIyWc+HgGtG1LsoJlgsipt6ozecgAPDBrZeeAl85VCF1EDF8wGu
         1ncYgMPZYTXREbo7Aglusy3wglY03e1odmNHS6gLk8gy3KpyykvrFvC8uhx8htQayBcz
         VI3gzJhqlA5bGRG9oObJZMzvgktKMYCF/y3wEqBHf68/ln0hAjgFTJ0V75Tb1yn34izq
         s0s9lQayBPo5Ib6i+PZA+xWXmt0/d/v/btTksx/X0pySp2j7fmLIaPmacD5zQ2mYbh/a
         AbYw==
X-Forwarded-Encrypted: i=1; AJvYcCUeJDpeQPWzoDPrqzNuzxMa9wZAYSEOni0GIWikhU3WQyJikVwUi2rdJFC+8G/w3RUNiG8qFtY78Sxa5K3sw9ZU1RK3BQtHuwj++s4OVSDK+Zl9Gz3uKnUWJGZuIjFDJFZ9szDzgX+z
X-Gm-Message-State: AOJu0YxlKpPALnyjfx5BI2bRCiHKLhLfe822ej/W1rsV0hND7pVXb6Sj
	LtjAnX+wLpU59IPqQFEoRNTvItn8HhnglU3kOae2JtQQUv0jZqA8DORYN74PXeTgl6NsRSRw0Vb
	nKeU9IcokJfxm0hwKV+/XLszsY2E=
X-Google-Smtp-Source: AGHT+IE7uRqBXeAzMfuqLbYuTXVXbvlPnrQXyKR5487DosEK/gQYeAYo0nrbJDK9UIA4h+1m4rmLYPVdqJ4nkX+rXu4=
X-Received: by 2002:a17:903:1cf:b0:1e7:b6f4:2d77 with SMTP id
 d9443c01a7336-1ef4318d7aamr290234415ad.22.1715913734487; Thu, 16 May 2024
 19:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514135303.176134-1-krishnak@linux.ibm.com> <20240514135303.176134-3-krishnak@linux.ibm.com>
In-Reply-To: <20240514135303.176134-3-krishnak@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 17 May 2024 12:42:03 +1000
Message-ID: <CAOSf1CFDCTMdmrjoSRdP09rJgtzPVDnCPXpfS-S+J7XKHzKRCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc: hotplug driver bridge support
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, mahesh@linux.ibm.com, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Gaurav Batra <gbatra@linux.ibm.com>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Brian King <brking@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:54=E2=80=AFPM Krishna Kumar <krishnak@linux.ibm.=
com> wrote:
>
> There is an issue with the hotplug operation when it's done on the
> bridge/switch slot. The bridge-port and devices behind the bridge, which
> become offline by hot-unplug operation, don't get hot-plugged/enabled by
> doing hot-plug operation on that slot. Only the first port of the bridge
> gets enabled and the remaining port/devices remain unplugged. The hot
> plug/unplug operation is done by the hotplug driver
> (drivers/pci/hotplug/pnv_php.c).
>
> Root Cause Analysis: This behavior is due to missing code for the DPC
> switch/bridge.

I don't see anything touching DPC in this series?

> *snip*
>
> Command for reproducing the issue :
>
> For hot unplug/disable - echo 0 > /sys/bus/pci/slots/C5/power
> For hot plug/enable -    echo 1 > /sys/bus/pci/slots/C5/power
>
> where C5 is slot associated with bridge.
>
> Scenario/Tests:
> Output of lspci -nn before test is given below. This snippet contains
> devices used for testing on Powernv machine.
>
> 0004:02:00.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
> 0004:02:01.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
> 0004:02:02.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
> 0004:02:03.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
> 0004:08:00.0 Serial Attached SCSI controller [0107]:
> Broadcom / LSI SAS3216 PCI-Express Fusion-MPT SAS-3 [1000:00c9] (rev 01)
> 0004:09:00.0 Serial Attached SCSI controller [0107]:
> Broadcom / LSI SAS3216 PCI-Express Fusion-MPT SAS-3 [1000:00c9] (rev 01)
>
> Output of lspci -tv before test is as follows:
>
> # lspci -tv
>  +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>  |                           |               +-01.0-[08]----00.0  Broadco=
m / LSI SAS3216 PCI-Express Fusion-MPT SAS-3
>  |                           |               +-02.0-[09]----00.0  Broadco=
m / LSI SAS3216 PCI-Express Fusion-MPT SAS-3
>  |                           |               \-03.0-[0a-0e]--
>  |                           \-00.1  PMC-Sierra Inc. Device 4052
>
> C5(bridge) and C6(End Point) slot address are as below:
> # cat /sys/bus/pci/slots/C5/address
> 0004:02:00
> # cat /sys/bus/pci/slots/C6/address
> 0004:09:00

Uh, if I'm reading this right it looks like your "slot" C5 is actually
the PCIe switch's internal bus which is definitely not hot pluggable.
I find it helps to look at the PCI topology in terms of where the
physical PCIe links are. Here we've got:

- A link between the PHB (0004:00:00.0) and the switch upstream port
(0004:01:00.0)
- A link from switch downstream port 0 (0004:02:00.0) to nothing
- A link from switch downstream port 1 (0004:02:01.0) to a SAS card
- A link from switch downstream port 2 (0004:02:02.0) to a SAS card
- A link from switch downstream port 2 (0004:02:03.0) to nothing

Note that there's no PCIe link between the switch upstream port
(0004:01:00.0) and the downstream ports on bus 0004:02. The connection
between those is invisible to us because it's custom bus logic
internal to the PCIe switch ASIC. What I think has happened here is
that system firmware has supplied bad PCIe slot information to OPAL
which has resulted in pnv_php advertising a slot in the wrong place.
Assuming this following the usual IBM convention I'd expect the bridge
device for C5 to be the PHB's root port and the bus should be 0004:01.
It might be worth adding some logic to pnv_php to verify the PCI
bridge upstream of the slot actually has the PCIe slot capability to
guard against this problem.

> Hot-unplug operation on slot associated with bridge:
> # echo 0 > /sys/bus/pci/slots/C5/power
> # lspci -tv
>  +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--
>  |                           \-00.1  PMC-Sierra Inc. Device 4052

Yep, "powering off" C5 doesn't remove the upstream port device. This
would create problems if you physically removed the card from C5 since
the kernel would assume the switch device is still present.

> *snip*


> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 38561d6a2079..bea612759832 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -493,4 +493,36 @@ static void pci_dev_pdn_setup(struct pci_dev *pdev)
>         pdn =3D pci_get_pdn(pdev);
>         pdev->dev.archdata.pci_data =3D pdn;
>  }
> +
> +void pci_traverse_sibling_nodes_and_scan_slot(struct device_node *start,=
 struct pci_bus *bus)
> +{
> +       struct device_node *dn;
> +       int slotno;
> +
> +       u32 class =3D 0;
> +
> +       if (!of_property_read_u32(start->child, "class-code", &class)) {
> +               /* Call of pci_scan_slot for non-bridge/EP case */
> +               if (!((class >> 8) =3D=3D PCI_CLASS_BRIDGE_PCI)) {
> +                       slotno =3D PCI_SLOT(PCI_DN(start->child)->devfn);
> +                       pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +                       return;
> +               }
> +       }
> +
> +       /* Iterate all siblings */
> +       for_each_child_of_node(start, dn) {
> +               class =3D 0;
> +
> +               if (!of_property_read_u32(start->child, "class-code", &cl=
ass)) {
> +                       /* Call of pci_scan_slot on each sibling-nodes/br=
idge-ports */
> +                       if ((class >> 8) =3D=3D PCI_CLASS_BRIDGE_PCI) {
> +                               slotno =3D PCI_SLOT(PCI_DN(dn)->devfn);
> +                               pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +                       }
> +               }
> +       }

If you're going to iterate over all the DT nodes why not just scan all
of them rather than special casing bridges? IIRC current logic is the
way it is because PowerVM only puts single devices under a PHB and in
the PowerNV (pnv_php) case the PCIe spec guarantees that only device 0
will be present on the end of a link. If you want to handle the more
generic case then feel free, but do it properly.


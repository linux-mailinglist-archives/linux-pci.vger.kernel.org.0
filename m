Return-Path: <linux-pci+bounces-7667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91C8C9F25
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503BF1C20E74
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D251E878;
	Mon, 20 May 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRrEkZnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBA13699B;
	Mon, 20 May 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217174; cv=none; b=YDo37wz4+izLaiBrffzS+LZVUaLdbTUziSa6jbgzrro/ATRhQkNsyT+1ilDwak1EO/gu0nQewaOFPQvaCqkOiEKGirzW1r6A+UtMfNgZ55XmEjIngYdh387RJRAwPj8TcLSiqhAir1W9CbfsFcIIACWdXnnqJ6ofdWyucIT8DU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217174; c=relaxed/simple;
	bh=c8vjyi9pV8eQl2KCkFX732KFwXzfd1RU/bneAV3V4o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4D6tsBsAniGviEvMff5w/Rkp6hWaZqYQICiRSX3ICZoKAL8eyn9JUJBBop8sa2QdqOLPBs3LblEd7ark//Fvy0POrnduUrPx4i3Ir+qvxjZ54G7AaXCQ4MA18rK2qzVHAkZJk82TwpKXIp4Jd7Qatr0Phl29BIwGeGInxaMrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRrEkZnl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so87161815ad.1;
        Mon, 20 May 2024 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716217173; x=1716821973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WxWSnAu+Jb/cU8HRp03QI7vnLcxoh48uyOd12Dtm1w=;
        b=XRrEkZnlWwwr8qnksgRmE1AYz5xQUpapAdHGYoDqLL/dGXSGxL8EcKS5+o2bEyeQM0
         Bci1qFZcKICrDtXh/FNS8CED2zaaSZSzHOCezh5ZwP2fsRGi0aIn0kUVBOnP103IbUoa
         UoySh50Hek8hrR9mlyn4eiH/imS/hT7TB6eFqusxJm8/WrQJzFyc2yPJrqYBQKJ/CLzQ
         HdZntlJNwOt1ezKmPPffvq//QyOXpDcWLgSZfeIt/1G8BMV29EBJydPs0Lf4LGOcMA5T
         lmlyBIYr7tS7RFwQdJ9W3hlDVK1NbIZ5M+yqphOGB6qrKj4gBQ2hpVbqPpznKwVbe2jj
         WQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217173; x=1716821973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WxWSnAu+Jb/cU8HRp03QI7vnLcxoh48uyOd12Dtm1w=;
        b=tR3T6DJ11F9uAXnUedDH1Xu2ci4rLFGKSXHne3fl8gj6ycHxoqqEzaQAUcz/BKsofR
         TMlMdLeM2Ir2E5v/z6kigVTbDaKMylJBMAIMGwz2SdHeliFKpKMnXFmbp1/2kV75Fjqf
         VRD2Z78iu4RGmlZkMij4IgMbr6RX9YX32U1734oOTZpYN2Z0DpeWXwlQjTcE6N+AgTL6
         S5pYbXJH3M3rkKJwKMNVoFTNvmCM5ESaRRGDtUWrUlTQXg7dH5Vh80w3dV+gbHb52KbZ
         u7lOo5nCqsN55C3MOB0aNWPNiGVDxT26B2EK3ALU30pHcAGlJThodBdhXIwyTTFp/QoL
         l9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXsEY3E9ezSFs/nwxgDyPi8GNq3smxMTBrhSB27yANDaAvd+F5oQDyfB5Zp9Xh0O5KrvJ6R49AqBxevZ0UsuEYI9lFJDwrHoAA+YWpTf3b3ywu+QS6jmBlnV9CoLvCViaj8nKMBbWMR
X-Gm-Message-State: AOJu0YwUiqZl7SuvZc4eiEqwT68HWNsdwMeJLTNsPIRc/H/1YGwCrUar
	GJnDPkcTBTb6h8VgIa9VFErnmIMUzHYnLknei++dnMQPrBx8y2UVMKTQnEWPAK3OiYHR22LWIDc
	FAAngFBCq+EBREKYSxPWXpLY9mVHLBVn9
X-Google-Smtp-Source: AGHT+IGfSE+YBGPcDTEKdMHB/BUDwvfllUws7NAWhT7CWSQLTeCfhkDPoRwDe/Brw4m7uUedxBN/qEqJBXOEGPAjlis=
X-Received: by 2002:a17:90b:4b4a:b0:2bd:7fc1:c91 with SMTP id
 98e67ed59e1d1-2bd7fc125acmr3299938a91.38.1716217172776; Mon, 20 May 2024
 07:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514135303.176134-1-krishnak@linux.ibm.com>
 <20240514135303.176134-3-krishnak@linux.ibm.com> <CAOSf1CFDCTMdmrjoSRdP09rJgtzPVDnCPXpfS-S+J7XKHzKRCw@mail.gmail.com>
 <fd0e22ab-5998-4b57-828e-224dda6bf490@linux.ibm.com>
In-Reply-To: <fd0e22ab-5998-4b57-828e-224dda6bf490@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 21 May 2024 00:59:19 +1000
Message-ID: <CAOSf1CE2r4Gju-BkGVzuAyWoiFZ+9csNMj=v+KkQMmixUAHH6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc: hotplug driver bridge support
To: krishna kumar <krishnak@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Gaurav Batra <gbatra@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, mahesh@linux.ibm.com, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Brian King <brking@linux.vnet.ibm.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:15=E2=80=AFPM krishna kumar <krishnak@linux.ibm.c=
om> wrote:
>
> > Uh, if I'm reading this right it looks like your "slot" C5 is actually
> > the PCIe switch's internal bus which is definitely not hot pluggable.
>
> It's a hotplug slot. Please see the snippet below:
>
> :~$ sudo lspci -vvv -s 0004:02:00.0 | grep --color HotPlug
>          SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surp=
rise-
> :~$
>
> :~$ sudo lspci -vvv -s 0004:02:01.0 | grep --color HotPlug
>         SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surpr=
ise-
> :~$
>
> :~$ sudo lspci -vvv -s 0004:02:02.0 | grep --color HotPlug
>         SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surpr=
ise-
> :~$
>
> :~$ sudo lspci -vvv -s 0004:02:03.0 | grep --color HotPlug
>         SltCap:    AttnBtn- PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surpr=
ise-
> :~$

All this is showing is that the switch downstream ports on bus 0004:02
have a slot capability. I already know that (see what I said
previously about physical links). The fact the downstream ports have a
slot capability also has absolutely nothing to do with anything I was
saying. Look at the lspci output for 0004:01:00.0 which is the
switch's upstream port. The upstream port device will not have a slot
capability because it's a bridge into the virtual PCI bus that is
internal to the switch.

> It seems like your explanation about the missing 0004:01:00.0 may be
> correct and could be due to a firmware bug. However, the scope of this
> patch does not relate to this issue. Additionally, if it starts with
> 0004:01:00.0 to 0004:01:03.0, the behavior of hot-unplug and hot-plug
> operations will remain inconsistent. This patch aims to address the
> inconsistent behavior of hot-unplug and hot-plug.
>
> *snip*
>
> > It might be worth adding some logic to pnv_php to verify the PCI
> > bridge upstream of the slot actually has the PCIe slot capability to
> > guard against this problem.
>
> We can have a look at this problem in another patch.

The point of this series is to fix the behaviour of pnv_php, is it
not? Powering off a PCI(e) slot is supposed to render it safe to
remove the card  in that slot. Currently if you "power off" C5, the
kernel is still going to have active references to the switch's
upstream port device (at 0004:01:00.0) and the switch management
function (at 0004:01:00.1). If the kernel has active references to PCI
devices physically located in the slot we supposedly powered off, then
the hotplug driver isn't doing its job. The asymmetry between hot add
and removal that you're trying to fix here is a side effect of the
fact that pnv_php is advertising the wrong thing as a slot. I think
you should stop pnv_php from advertising something as a slot when it's
not actually a slot because that's the root of all your problems.

> We wanted to handle the more generic case and did not want to be confined=
 to
> only one device assumption. We want to fix the current inconsistent behav=
ior
> more generically.

Right, as I said above I don't think handing the more generic case is
actually required if pnv_php is doing its job properly. It doesn't
hurt though.

> Regarding the fix, the fix is obvious:

really?

> We have to traverse
> and find the bridge ports from DT and invoke  pci_scan_slot() on them. Th=
is will
> discover and create the entry for bridge ports (0004:02:00.0 to 0004:02:0=
0.3 on
> the given bus- 0004:02). There is already an existing function, pci_scan_=
bridge()
> which is doing invocation of pci_scan_slot () for the devices behind the =
bridge,
> in this case for  SAS device. So eventually, we are doing a scan of all t=
he entities
> behind the slot.

I already read your patch so I'm not sure why you feel the need to
re-describe it in tedious detail.

> Would you like me to combine the non-bridge and bridge cases into one? I =
can attempt
> to do this. Hopefully, if we incorporate the iterate sibling logic case c=
orrectly,
> we may not need to maintain these two separate cases for bridge and non-b=
ridge. I
> will attempt this, and if it works, I will include it in the next patch. =
Thanks.

Yes, do that.

Also, do not post HTML emails to linux development lists. It breaks
plain text inline quoting which makes your messages annoying to reply
to. Some linux development lists will also silently drop HTML emails.
Please talk to the other LTC engineers about how to set up your mail
client to send plain text emails to avoid these problems in the
future.

Oliver


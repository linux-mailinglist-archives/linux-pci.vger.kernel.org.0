Return-Path: <linux-pci+bounces-4670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4888767AA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662112812BC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF601EF1E;
	Fri,  8 Mar 2024 15:49:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A89249EE;
	Fri,  8 Mar 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912991; cv=pass; b=dQBzGcuvQotOxyXTpw19JJuj9oZeKrQaMIZRKMZTmFBEQTRySwUwFwaV7mEWhDN7Mpm9p6ZRM/zGknNZ2INFJaDf7c/1H7QR58oeuh/sKNiaOTdI9JbYnreS6VGZNaRePMhYbsG5EImjH3cNe0nu23k2MiGTHUeDMqdvdD7tv2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912991; c=relaxed/simple;
	bh=A6rOa92ElDEwzMdoZFfPn9imL/LVoNUf7ePmW7mKcIo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AdBdErds8bs1TkYVxPj7UEOb7Oa8hGWcH7+zaZ2C49HKDQnaG84SqdZpAgjswuEIwYL0vDzEYBF7za9Z5df7ZZFGN3pO1gAZqJV3CJ3TdkwJeB87A0o4e48pnqfeVR9wif1mIUwdC56Gs+jzjQ4cZ+ryQvDJIilHgH7it7aIEew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5challer.de; spf=none smtp.mailfrom=5challer.de; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5challer.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=5challer.de
ARC-Seal: i=1; a=rsa-sha256; t=1709912972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K9OrE1BAliFUVhEZbVOmYk+h2+KgNTPZwTxbZlwCdgIbBvV9hoCLEPTGzj7D/aSEkvrvEiCDEz/pm6wUjdfrVhWVZ+7h8aMbypII8Y+JkjPL3BHz5qgIhxg5erbYC/O7PAMKYzaieATR37YCDWo70axhjtsK/8Fjp7XWdLUTTxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709912972; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5YNPXuGQzikjhDPAoMwfNKrszjWl/dlfwI8/cu9vNBc=; 
	b=OGxVRBZrMWNPzpvDS+2gUfvaj3x3PuTBeJKP+Z8QLGueJlaD2CUdOHaUCIPqmM9qeQqqeOyhq+KjLhq1DRzB3CGDHo/BefmtKaA6cLBXUYoZUGZvNZgKDGbIjCRv5gajJUdQEFDaXRU/AVUiTbClPv7m/S5qJt4gOWFJ8wjDj/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=michael@5challer.de;
	dmarc=pass header.from=<michael@5challer.de>
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1709912969795903.1225612775684; Fri, 8 Mar 2024 07:49:29 -0800 (PST)
Date: Fri, 08 Mar 2024 16:49:29 +0100
From: michael <michael@5challer.de>
To: "Kai-Heng Feng" <kai.heng.feng@canonical.com>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "bhelgaas" <bhelgaas@google.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"regressions" <regressions@lists.linux.dev>,
	"macro" <macro@orcam.me.uk>, "ajayagarwal" <ajayagarwal@google.com>,
	"sathyanarayanan.kuppuswamy" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"gregkh" <gregkh@linuxfoundation.org>,
	"hkallweit1" <hkallweit1@gmail.com>,
	"michael.a.bottini" <michael.a.bottini@linux.intel.com>,
	"johan+linaro" <johan+linaro@kernel.org>
Message-ID: <18e1ebf2b92.bedd9a071161871.3718292789549008231@5challer.de>
In-Reply-To: <CAAd53p6GEPJe3rNNrUAah5PdLXspKh5Gz9tFstR6SFCREs+9=Q@mail.gmail.com>
References: <954f0b86-dd9e-4d84-8d67-fba7e80bc94e@5challer.de>
 <20240105155100.GA1861423@bhelgaas> <CAAd53p5Eg4J9bRtAHY+JZ11cy1D0TnKmAaLfzcRJzw15VRBxXw@mail.gmail.com>
 <9f0f9de4-2d34-4ff3-a901-c3e4b48e4ab0@5challer.de> <CAAd53p6GEPJe3rNNrUAah5PdLXspKh5Gz9tFstR6SFCREs+9=Q@mail.gmail.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Kai-Heng,

 ---- On Thu, 07 Mar 2024 07:51:05 +0100  Kai-Heng Feng  wrote ---=20
 > Hi Michael,
 >=20
 > Sorry for the belated response.
 >=20
No worries.

 > On Wed, Jan 10, 2024 at 8:40=E2=80=AFPM Michael Schaller michael@5challe=
r.de> wrote:
 > >
 > >
 > > On 10.01.24 04:43, Kai-Heng Feng wrote:
 > > > On Fri, Jan 5, 2024 at 11:51=E2=80=AFPM Bjorn Helgaas helgaas@kernel=
.org> wrote:
 > > >>
 > > >> On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
 > > >>> On 05.01.24 04:25, Kai-Heng Feng wrote:
 > > >>>> Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
 > > >>>
 > > >>> Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also resu=
lt in a
 > > >>> working resume. I've tested this on kernel 6.6.9 (which still has =
commit
 > > >>> 08d0cc5f3426). I've also attached the relevant dmesg output of the
 > > >>> suspend/resume cycle in case this helps.
 > > >>
 > > >> Thanks for testing that!
 > > >>
 > > >>> Furthermore does this mean that commit 08d0cc5f3426 isn't at fault=
 but
 > > >>> rather that we are dealing with a timing issue?
 > > >>
 > > >> PCI does have a few software timing requirements, mostly related to
 > > >> reset and power state (D0/D3cold).  ASPM has some timing parameters=
,
 > > >> too, but I think they're all requirements on the hardware, not on
 > > >> software.
 > > >>
 > > >> Adding an arbitrary delay anywhere shouldn't break anything, and ot=
her
 > > >> than those few required situations, it shouldn't fix anything eithe=
r.
 > > >
 > > > At least it means 8d0cc5f3426 isn't the culprit?
 > > >
 > > > Michael, does the issue happen when iwlwifi module is not loaded? It
 > > > can be related to iwlwifi firmware.
 > > >
 > > > Kai-Heng
 > > >
 > > The issue still happens if the iwlwifi module has been blacklisted and
 > > after a reboot. This was again with vanilla kernel 6.6.9 and I've
 > > confirmed via dmesg that iwlwifi wasn't loaded.
 >=20
 > Can you please give latest mainline kernel a try? With commit
 > f93e71aea6c60ebff8adbd8941e678302d377869 (Revert "PCI/ASPM: Remove
 > pcie_aspm_pm_state_change()") reverted.
 >=20
 > Also do you have efi-pstore enabled? Is there anything logged in
 > /var/lib/systemd/pstore (assuming systemd is used)?
 >=20
I'm happy to test once I'm out of the hospital (long COVID). I should be ba=
ck home in 5 weeks.

Michael

 > Kai-Heng
 >=20
 > >
 > > I've also checked if there is a newer firmware but Ubuntu 23.10 is
 > > already using the newest firmware available from
 > > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwar=
e.git/log/iwlwifi-8265-36.ucode
 > > (version 36.ca7b901d.0 according to dmesg).
 > >
 > > Michael
 > >
 > > >>
 > > >> Bjorn
 >=20


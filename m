Return-Path: <linux-pci+bounces-3134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16DE84B01C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9417284C02
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA112C54B;
	Tue,  6 Feb 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="faGgavkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6112C542
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208781; cv=none; b=Ge+HtoYE3LO7+Ph1FhAA0ygBcbaFbSpdw9Q/4orm4PEKkz2W4bKm92TjnyaDLsjHMePp3Uxs6oAPN2zm1dP9XiEnwpnovwl7jsW3sI8o3wGQctO2mjcGbnrmOWumUQVWRHXz0cpQSvati5TtCWIh5+WzQeDQ6iYinu4YkRXF5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208781; c=relaxed/simple;
	bh=gETlEzg2esE1f/lGOh9jJSjbWPdkbQv6cdoIuUKeZWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPx5bha56Rbn0KyBZu21oau84jl8b2yzdHQmzx5HLyN1zmI+abjtLyJjLsO/obpT2/lUUWpFk8FQlI6Fvi4gw4IPTwDEYZEyKmo+F5DWTO1MldaHfoBXaY8olen9tYszmc6F+d5pK+swQ6I2NSHRNc+Uz8zv3+xLssLiFstjrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=faGgavkl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60406302a5eso6204867b3.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 00:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707208778; x=1707813578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpKcDE0oF6UneqoDMI4KAgMzkUMeYsWsCldFNKODZvo=;
        b=faGgavklJf9+0JH3i5m5+tdsAfWbSrZsOX0XDeMpDA8Fy3Ttg4JXwS0vH9R4M2exfU
         0tQlhEFYYdH+nJXLvAKYCiemp/4cH7iWSFzhlgr9AXuHlLY1bDarOsblHn0xRaIYL7md
         hgOb+Bx+Jo1BVlL60HNCKHt+iS31RwN0MKgfHHexCKC8RyjC+roOO7hixxCtYhxSy2PC
         lLbX+JlgZ8tDjTFX+KczSyjRsHIDPVRJyEZ4QEFswIPX2GoWZH0ILIIutKc8ZTEJSPP1
         IWLABaqkWJu/35xnICn60He0k9BY357gAR5nsHrCr6MDcxDyNT+shMl0v2hqxgcvIqT2
         2uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208778; x=1707813578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpKcDE0oF6UneqoDMI4KAgMzkUMeYsWsCldFNKODZvo=;
        b=YiuvFuEZZ8htjmaYGbzuWx0TrAsTyIYWTucdLJqLB5ABKgc1MbA8owGynm8VdXrZg/
         dCCb0fl6adNzqIh4YUvm90i4IcBrHs3czrCAXQpi1+/Z1R6lFKjK4pc7X35ApWvh67VW
         4cdromG5medJhvwzSvarvgJQ0Ut477MP2Ft1CjiI0S61x8VIBjkiGw6bgDyGSyzVuweG
         07v/gD4tzfy9fzUp7e+v8Gc8bdU2H+GQKsBsrIVGbWk46yD5CVdcvesV8MxYMR/SySxw
         +boLlvJLLNASSiBdloeEy1ghY+mdsPnVNfy3ntvHaZS+BQqR3BvpH4zHoK2Fl+3KOKnC
         KI0g==
X-Gm-Message-State: AOJu0YwWElZCl+6wZgKrRSj82IsV/lrYAdCImGfOtNbnNy5KArZUk0sX
	/hLtT13doJVnOXdAiVCGUxiNkzSZ3HXf5xePBEguk6Td5BmP1wzh2Z8Jc4n3ZuNnAKIugo9rgti
	grsoDDpZ1dPiNwVDft3QKf64aJKCfcWKFpTapmQ==
X-Google-Smtp-Source: AGHT+IGDgfP9yAionAbg8oiXA5eKDQH8oGoHwijVFnsPL6Ajf1qYT4dk+IWDRiUC6fuwy4Tcve+rv2bBf6IgtvasI1s=
X-Received: by 2002:a81:ef04:0:b0:603:1b35:5885 with SMTP id
 o4-20020a81ef04000000b006031b355885mr981784ywm.19.1707208778004; Tue, 06 Feb
 2024 00:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon> <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon> <ZbuyVbMEBWKi729y@x1-carbon> <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
 <ZcDHjsYJNlJ/9nNT@x1-carbon>
In-Reply-To: <ZcDHjsYJNlJ/9nNT@x1-carbon>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 6 Feb 2024 16:39:02 +0800
Message-ID: <CAPpJ_ec0H6zr6wcNstFn9dRcFgPXspU3MYvgGMNAS5wnw-0pTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, Vitalii Solomonov <solomonov.v@gmail.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Feb 02, 2024 at 04:49:00PM +0800, Jian-Hong Pan wrote:
> > Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, Jan 31, 2024 at 11:43:59PM +0100, Niklas Cassel wrote:
> > > > On Wed, Jan 31, 2024 at 07:08:12AM -0400, Daniel Drake wrote:
> > >
> > > (snip)
> > >
> > > > In libata we perform a reset of the port at boot, see:
> > > > libata-sata.c:sata_link_hardreset()
> > > > after writing to SControl, we call
> > > > libata-core.c:ata_wait_ready() that will poll for the port being re=
ady
> > > > by calling the check_ready callback.
> > > > For AHCI, this callback funcion is set to:
> > > > libahci.c:ahci_check_ready().
> > > >
> > > > A reset should take the device out of deep power state and should b=
e
> > > > sufficient to establish a connection (and that also seems to be the
> > > > case when not using Intel VMD).
> > > >
> > > > However, if you want to debug, I would start by adding prints to
> > > > libata-sata.c:sata_link_hardreset()
> > > > libata-core.c:ata_wait_ready()
> > > > libahci.c:ahci_check_ready().
> > >
> > > FWIW, this will dump SStatus.DET every time the check_ready callback =
function
> > > (ahci_check_ready()) is called:
> > >
> > >
> > > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > > index 1a63200ea437..0467e150601e 100644
> > > --- a/drivers/ata/libahci.c
> > > +++ b/drivers/ata/libahci.c
> > > @@ -1533,6 +1533,12 @@ int ahci_check_ready(struct ata_link *link)
> > >  {
> > >         void __iomem *port_mmio =3D ahci_port_base(link->ap);
> > >         u8 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;
> > > +       u32 cur =3D 0;
> > > +
> > > +       sata_scr_read(link, SCR_STATUS, &cur);
> > > +
> > > +       ata_link_info(link, "BUSY ? %d (status: %#x) SStatus.DET: %#x=
\n",
> > > +                     status & ATA_BUSY, status, cur & 0xf);
> > >
> > >         return ata_check_ready(status);
> > >  }
> >
> > I think I can join the test based on kernel v6.8-rc2, too.
> >
> > The original ASUS B1400CEAE has only one NVMe SSD.  I prepare the
> > patch ("ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE") to
> > fix the power consumption issue for s2idle with enabled VMD.
> >
> > The patch is a quirk limiting ASUS B1400CEAE only, not generic for the
> > SATA controller [8086:a0d3].  Then, I install another SATA HDD into
> > ASUS B1400CEAE for test.  The SATA HDD shows up and works.
> >
> > $ dmesg | grep SATA
> > [    0.785120] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> > Gbps 0x1 impl SATA mode
> > [    0.785269] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> > 0x76102100 irq 144 lpm-pol 3
> > [    1.096684] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> >
> > However, if I simply revert the commit 6210038aeaf4 ("ata: ahci:
> > Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"") (fix the
> > conflict, of course), then the SATA HDD disappears!!?  Both
> > CONFIG_SATA_MOBILE_LPM_POLICY=3D3 and 0 can reproduce the issue.
> >
> > $ dmesg | grep SATA
> > [    0.783211] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> > Gbps 0x1 impl SATA mode
> > [    0.783399] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> > 0x76102100 irq 144 lpm-pol 3
> > [    1.096685] ata1: SATA link down (SStatus 4 SControl 300)
> >
> > Here is the dmesg of reverting ("ata: ahci: Revert "ata: ahci: Add
> > Tiger Lake UP{3,4} AHCI controller"")
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c27
> > The code already includes the debug message in ahci_check_ready() from
> > Niklas.  However, the dmesg does not show the "BUSY ? ..." from
> > ahci_check_ready().
> >
> > From these scenarios mentioned above, they all apply LPM policy to the
> > SATA controller [8086:a0d3].  But, they apply LPM policy at different
> > time:
> > * The patch ("ata: ahci: Add force LPM policy quirk for ASUS
> > B1400CEAE") applies LPM policy in early ahci_init_one(), which is the
> > probe callback.
> > * Reverting 6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger
> > Lake UP{3,4} AHCI controller"") applies LPM policy via "ahci_pci_tbl"
> > table.
>
> I don't see why it should matter if we set the AHCI_HFLAG_USE_LPM_POLICY
> flag using ahci_pci_tbl, or by your suggested quirk in ahci_init_one(),
> as in both cases the flag will be set before ahci_init_one() calls
> ahci_update_initial_lpm_policy().
>
>
> Could it perhaps be that in order for libata to be able to detect your
> drive, when VMD is enabled, we also need your patch
> "PCI: vmd: enable PCI PM's L1 substates of remapped PCIe port and NVMe" ?

I only apply the patch ("ata: ahci: Add force LPM policy quirk for
ASUS B1400CEAE") for this test.  No "PCI: vmd: enable PCI PM's L1
substates of remapped PCIe port and NVMe".  :)

> If that is not the case, and there actually is a difference between using
> ahci_pci_tbl and your suggested quirk, then my next suggestion would be t=
o
> add prints to libata-sata.c:sata_link_scr_lpm(). That way you can dump th=
e
> exact SCR writes that are being done for the working case vs. the
> non-working case. (Since I assume that there must be some difference.)

I prepared debug messages as:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7ecd56c8262a..b910c7856d08 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1677,8 +1676,10 @@ static void
ahci_update_initial_lpm_policy(struct ata_port *ap,
/* Ignore processing for chipsets that don't use policy */
- if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
+ if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY)) {
+ dev_info(ap->dev, "%s: do not use LPM policy\n", __func__);
return;
+ }
/* user modified policy via module param */
if (mobile_lpm_policy !=3D -1) {
@@ -1696,6 +1697,7 @@ static void
ahci_update_initial_lpm_policy(struct ata_port *ap,
update_policy:
if (policy >=3D ATA_LPM_UNKNOWN && policy <=3D ATA_LPM_MIN_POWER)
ap->target_lpm_policy =3D policy;
+ dev_info(ap->dev, "%s: policy %d\n", __func__, policy);
}
static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct
ahci_host_priv *hpriv)
@@ -1706,12 +1708,16 @@ static void ahci_intel_pcs_quirk(struct
pci_dev *pdev, struct ahci_host_priv *hp
/*
* Only apply the 6-port PCS quirk for known legacy platforms.
*/
- if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL)
+ if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL) {
+ dev_info(&pdev->dev, "%s: not Intel, the vendor is 0x%08x\n",
__func__, id->vendor);
return;
+ }
/* Skip applying the quirk on Denverton and beyond */
- if (((enum board_ids) id->driver_data) >=3D board_ahci_pcs7)
+ if (((enum board_ids) id->driver_data) >=3D board_ahci_pcs7) {
+ dev_info(&pdev->dev, "%s: skip\n", __func__);
return;
+ }
/*
* port_map is determined from PORTS_IMPL PCI register which is
@@ -1722,8 +1728,10 @@ static void ahci_intel_pcs_quirk(struct pci_dev
*pdev, struct ahci_host_priv *hp
* before the OS boots.
*/
pci_read_config_word(pdev, PCS_6, &tmp16);
+ dev_info(&pdev->dev, "%s: PCS_6 is 0x%04x", __func__, tmp16);
if ((tmp16 & hpriv->port_map) !=3D hpriv->port_map) {
tmp16 |=3D hpriv->port_map;
+ dev_info(&pdev->dev, "%s: write PCS_6 with 0x%04x", __func__, tmp16);
pci_write_config_word(pdev, PCS_6, tmp16);
}
}
@@ -1998,6 +2006,7 @@ static int ahci_init_one(struct pci_dev *pdev,
const struct pci_device_id *ent)
if (rc)
return rc;
+ dev_info(&pdev->dev, "%s: probed\n", __func__);
pm_runtime_put_noidle(&pdev->dev);
return 0;
}
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..7e4f349554eb 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -812,6 +812,7 @@ static int ahci_set_lpm(struct ata_link *link,
enum ata_lpm_policy policy,
struct ahci_port_priv *pp =3D ap->private_data;
void __iomem *port_mmio =3D ahci_port_base(ap);
+ ata_link_info(link, "%s: policy=3D%d\n", __func__, policy);
if (policy !=3D ATA_LPM_MAX_POWER) {
/* wakeup flag only applies to the max power policy */
hints &=3D ~ATA_LPM_WAKE_ONLY;
@@ -1533,6 +1534,12 @@ int ahci_check_ready(struct ata_link *link)
{
void __iomem *port_mmio =3D ahci_port_base(link->ap);
u8 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;
+ u32 cur =3D 0;
+
+ sata_scr_read(link, SCR_STATUS, &cur);
+
+ ata_link_info(link, "BUSY ? %d (status: %#x) SStatus.DET: %#x\n",
+ status & ATA_BUSY, status, cur & 0xf);
return ata_check_ready(status);
}
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..4bcedd46bcfa 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -344,6 +344,7 @@ int sata_link_resume(struct ata_link *link, const
unsigned int *params,
if (!(rc =3D sata_scr_read(link, SCR_ERROR, &serror)))
rc =3D sata_scr_write(link, SCR_ERROR, serror);
+ ata_link_info(link, "%s: rc=3D%d", __func__, rc);
return rc !=3D -EINVAL ? rc : 0;
}
EXPORT_SYMBOL_GPL(sata_link_resume);
@@ -378,6 +379,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum
ata_lpm_policy policy,
if (rc)
return rc;
+ ata_link_info(link, "%s: policy is %d and original scontrol
0x%08x\n", __func__, policy, scontrol);
switch (policy) {
case ATA_LPM_MAX_POWER:
/* disable all LPM transitions */
@@ -422,6 +424,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum
ata_lpm_policy policy,
WARN_ON(1);
}
+ ata_link_info(link, "%s: write scontrol 0x%08x\n", __func__, scontrol);
rc =3D sata_scr_write(link, SCR_CONTROL, scontrol);
if (rc)
return rc;
@@ -586,9 +589,12 @@ int sata_link_hardreset(struct ata_link *link,
const unsigned int *timing,
rc =3D sata_link_resume(link, timing, deadline);
if (rc)
goto out;
+
/* if link is offline nothing more to do */
- if (ata_phys_link_offline(link))
+ if (ata_phys_link_offline(link)) {
+ ata_link_info(link, "%s: ata_phys_link_offline is True\n", __func__);
goto out;
+ }
/* Link is online. From this point, -ENODEV too is an error. */
if (online)
@@ -616,12 +622,15 @@ int sata_link_hardreset(struct ata_link *link,
const unsigned int *timing,
rc =3D 0;
if (check_ready)
rc =3D ata_wait_ready(link, deadline, check_ready);
+
+ ata_link_info(link, "%s: is %d\n", __func__, rc);
out:
if (rc && rc !=3D -EAGAIN) {
/* online is set iff link is online && reset succeeded */
if (online)
*online =3D false;
}
+ ata_link_info(link, "%s: is %s line, returns %d\n", __func__,
*online? "on":"off", rc);
return rc;
}
EXPORT_SYMBOL_GPL(sata_link_hardreset);

Have the comparison:

* Bind LPM policy with the patch "ata: ahci: Add force LPM policy
quirk for ASUS B1400CEAE" based on kernel v6.8-rc2:

$ dmesg | grep -E "(SATA|ata1|ahci)"
[    0.791497] ahci 10000:e0:17.0: version 3.0
[    0.791499] ahci 10000:e0:17.0: force controller follow LPM policy
[    0.791517] ahci 10000:e0:17.0: can't derive routing for PCI INT A
[    0.791518] ahci 10000:e0:17.0: PCI INT A: no GSI
[    0.791637] ahci 10000:e0:17.0: ahci_update_initial_lpm_policy: policy 3
[    0.791652] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: not Intel,
the vendor is 0xffffffff
[    0.791662] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    0.791663] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only
pio slum part deso sadm sds
[    0.791771] scsi host0: ahci
[    0.791806] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
0x76102100 irq 145 lpm-pol 3
[    0.791808] ahci 10000:e0:17.0: ahci_init_one: probed
[    1.109393] ata1: sata_link_resume: rc=3D0
[    1.109415] ata1: BUSY ? 0 (status: 0x50) SStatus.DET: 0x3
[    1.109418] ata1: sata_link_hardreset: is 0
[    1.109420] ata1: sata_link_hardreset: is on line, returns 0
[    1.109444] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.110161] ata1.00: ATA-10: WDC WD10SPZX-80Z10T2, 04.01A04, max UDMA/13=
3
[    1.112047] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    1.112054] ata1.00: Features: NCQ-prio
[    1.114814] ata1.00: configured for UDMA/133
[    1.114821] ata1: ahci_set_lpm: policy=3D3
[    1.114837] ata1: sata_link_scr_lpm: policy is 3 and original
scontrol 0x00000300
[    1.114840] ata1: sata_link_scr_lpm: write scontrol 0x00000000

The SATA link is up and SATA storage shows up.
Full dmesg as the attachment of
https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c28

* Bind LPM policy with PCI IDs like commit 104ff59af73a ("ata: ahci:
Add Tiger Lake UP{3,4} AHCI controller"):

$ dmesg | grep -E "(SATA|ata1|ahci)"
[    0.783125] ahci 10000:e0:17.0: version 3.0
[    0.783143] ahci 10000:e0:17.0: can't derive routing for PCI INT A
[    0.783145] ahci 10000:e0:17.0: PCI INT A: no GSI
[    0.783257] ahci 10000:e0:17.0: ahci_update_initial_lpm_policy: policy 3
[    0.783280] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: PCS_6 is 0x0000
[    0.783281] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: write PCS_6 with 0=
x0001
[    0.783296] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    0.783298] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only
pio slum part deso sadm sds
[    0.783402] scsi host0: ahci
[    0.783440] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
0x76102100 irq 144 lpm-pol 3
[    0.783442] ahci 10000:e0:17.0: ahci_init_one: probed
[    1.096930] ata1: sata_link_resume: rc=3D0
[    1.096960] ata1: sata_link_hardreset: ata_phys_link_offline is True
[    1.096962] ata1: sata_link_hardreset: is off line, returns 0
[    1.097000] ata1: SATA link down (SStatus 4 SControl 300)
[    1.097025] ata1: ahci_set_lpm: policy=3D3
[    1.097051] ata1: sata_link_scr_lpm: policy is 3 and original
scontrol 0x00000300
[    1.097054] ata1: sata_link_scr_lpm: write scontrol 0x00000304

The SATA link is down and SATA storage disappears.
Full dmesg as the attachment of
https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c29

The SCR writes different values with these two conditions.

However, I notice more interesting thing:
"drivers/ata/ahci.c:ahci_intel_pcs_quirk()"!
If bind LPM policy with PCI IDs matching, then it does the PCS quirk.
But, binding with the patch "ata: ahci: Add force LPM policy quirk for
ASUS B1400CEAE" does not, because the vendor is ANY vendor, not Intel.

So, I did following test:

If I modify the PCI vendor check condition with the pdev, not the PCI
ID's vendor:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7ecd56c8262a..ece709ac20d6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1706,12 +1709,16 @@ static void ahci_intel_pcs_quirk(struct
pci_dev *pdev, struct ahci_host_priv *hp
        /*
         * Only apply the 6-port PCS quirk for known legacy platforms.
         */
-       if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL)
+       if (!id || pdev->vendor !=3D PCI_VENDOR_ID_INTEL) {
+               dev_info(&pdev->dev, "%s: not Intel, the vendor is
0x%08x\n", __func__, id->vendor);
                return;
+       }

Then, the SATA HDD always disappears like binding the LPM policy with
PCI IDs matching, even with the patch "ata: ahci: Add force LPM policy
quirk for ASUS B1400CEAE".
So, I think ahci_intel_pcs_quirk() is the key point.

BR,
Jian-Hong Pan


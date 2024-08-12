Return-Path: <linux-pci+bounces-11604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F594F75D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5F81F23373
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAFA18C346;
	Mon, 12 Aug 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IawmL2+x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F818E743
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490108; cv=none; b=glJbni+uBFvTAkhSlLStudBNYxlX2TAhjIXsQOQP7ukj/3vfqRIsN7DYvK5mWiDksYhMheqaF96bk4VB0kvKF6r6TtUUpFr2mdEY1Pn3/oRqGpkpX/nd8bbj/oWopIVIIcioS8oFzRQv2WQp9zQbQ+PhVzoGG+T9BHUdI9fTZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490108; c=relaxed/simple;
	bh=fn/NTooHjxdVxdMhI+V/oOquv+I0dUe+ktGhlxZlpyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJyA3+DOcLlx05GOKK+BXtAXM1q6JiKtgw8zh79r2sLaGqY5WKsWQwgJGmaFXXPnQ/o+2hztJ/NPos5mfAP0UplLluz2260jgQcIwtY255BOesMtCyIn1L76YSiEGCeu2vLIbBBewJSWzmwJBSoqOAnHWyiigQHWaJSE9qb4Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IawmL2+x; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd855adbso5933135e87.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723490104; x=1724094904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGHZGq3/Qv/1UqNxRYqiAcBLA0N0cUJ3EJSCTsVvxXY=;
        b=IawmL2+x9Zpih8rUzT5Xe5Ob1hBczmqzXsoUhpoj/4y/3Yy67RJXCL/NAp/U11q/TD
         AaxUNP3ECwHXQWr91P3HpMv/1X9q8AsjTuGdVWJ1SWGudStIOug0CIcG1kcfLzjtxA9h
         XAokjfPrVXvyO029xx9yZ2s1lpqHrJcYdbAaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490104; x=1724094904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGHZGq3/Qv/1UqNxRYqiAcBLA0N0cUJ3EJSCTsVvxXY=;
        b=PgZ8xNeUFFwEoSkwVrcmRTmzcuQ0CdcLsbS0W7fx8RQS1YdTA7x5xt8EtNjBQSmuZ+
         XzJ9Hg8NmYJYG6cD6X/+KYpQJeXyzWiwLlvJ/toiinY/4YIXm9EVT1qTElFO8yOuph9q
         vwubgubC5jFfRVP4EXF6PWxOSj5WqgeoXAkpXFwpXyDGwVD78fWjVAE4Mx97oFkYyRfF
         DAuuTAKCxs4WW7ufQp8sfGyKfR/3Wh1i1IyNVZ6YxkD3nvtDNwm6g4oDCwMJ7HHxqz4G
         oIpykGwVRsXh0a33aPFS9vZNs1T578ec0CHNncsWb8JzWdu4oeNmG3aW0HrxSQQr9uHU
         ZzwQ==
X-Gm-Message-State: AOJu0YwayOEFRlQQkCI0dRB/70QjOC9Y+ctNnHnt1Zv6Z+SYsBI20DlO
	pVGWGFoKVcW3jAqCiAWIx+DlDzA1qvbkv8CtcCC/IdCEEwD7efyC7f6s6o7ZM4jEZr+z3ZehCav
	7cvQ6MeyrTxYxRBXImhNg5S87+jXoL1RactC4P4xE+kcbePc=
X-Google-Smtp-Source: AGHT+IFKR5KuDxjK5ouWLVRwcWtH/xahzci3XLDZmQ70at8tG+nLCUlCn6HkrJu+SFx1YBzxDY2ktTxrnjw4ElmNw8M=
X-Received: by 2002:a05:6512:2821:b0:52c:8abe:51fb with SMTP id
 2adb3069b0e04-5321364b8damr935060e87.10.1723490103605; Mon, 12 Aug 2024
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com> <20240807140401.GJ3412@thinkpad>
In-Reply-To: <20240807140401.GJ3412@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 12 Aug 2024 15:14:51 -0400
Message-ID: <CA+-6iNxJR94D0-oPqjcyr5mEb_fTYSad3TGEwfmDA2uXN_-37g@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000070482e061f814f45"

--00000000000070482e061f814f45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:04=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 31, 2024 at 06:28:23PM -0400, Jim Quinlan wrote:
> > Provide support for new chips with multiple inbound windows while
> > keeping the legacy support for the older chips.
> >
> > In existing chips there are three inbound windows with fixed purposes: =
the
> > first was for mapping SoC internal registers, the second was for memory=
,
> > and the third was for memory but with the endian swapped.  Typically, o=
nly
> > one window was used.
> >
> > Complicating the inbound window usage was the fact that the PCIe HW wou=
ld
> > do a baroque internal mapping of system memory, and concatenate the reg=
ions
> > of multiple memory controllers.
> >
> > Newer chips such as the 7712 and Cable Modem SOCs take a step forward a=
nd
> > drop the internal mapping while providing for multiple inbound windows.
> > This works in concert with the dma-ranges property, where each provided
> > range becomes an inbound window.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 228 ++++++++++++++++++++------
> >  1 file changed, 177 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 4659208ae8da..0ecca3d9576f 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -75,15 +75,19 @@
> >  #define PCIE_MEM_WIN0_HI(win)        \
> >               PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
> >
> > +/*
> > + * NOTE: You may see the term "BAR" in a number of register names used=
 by
> > + *   this driver.  The term is an artifact of when the HW core was an
> > + *   endpoint device (EP).  Now it is a root complex (RC) and anywhere=
 a
> > + *   register has the term "BAR" it is related to an inbound window.
> > + */
> > +
> > +#define PCIE_BRCM_MAX_INBOUND_WINS                   16
> >  #define PCIE_MISC_RC_BAR1_CONFIG_LO                  0x402c
> >  #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK               0x1f
> >
> > -#define PCIE_MISC_RC_BAR2_CONFIG_LO                  0x4034
> > -#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK               0x1f
> > -#define PCIE_MISC_RC_BAR2_CONFIG_HI                  0x4038
> > +#define PCIE_MISC_RC_BAR4_CONFIG_LO                  0x40d4
> >
> > -#define PCIE_MISC_RC_BAR3_CONFIG_LO                  0x403c
> > -#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK               0x1f
> >
> >  #define PCIE_MISC_MSI_BAR_CONFIG_LO                  0x4044
> >  #define PCIE_MISC_MSI_BAR_CONFIG_HI                  0x4048
> > @@ -130,6 +134,10 @@
> >         (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
> >          PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
> >
> > +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP                     0x40ac
> > +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK     BIT(0)
> > +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP                     0x410c
> > +
> >  #define PCIE_MSI_INTR2_BASE          0x4500
> >
> >  /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
> > @@ -217,12 +225,20 @@ enum pcie_type {
> >       BCM4908,
> >       BCM7278,
> >       BCM2711,
> > +     BCM7712,
> > +};
> > +
> > +struct inbound_win {
> > +     u64 size;
> > +     u64 pci_offset;
> > +     u64 cpu_addr;
> >  };
> >
> >  struct pcie_cfg_data {
> >       const int *offsets;
> >       const enum pcie_type type;
> >       const bool has_phy;
> > +     unsigned int num_inbound_wins;
> >       void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >  };
> > @@ -274,6 +290,7 @@ struct brcm_pcie {
> >       struct subdev_regulators *sr;
> >       bool                    ep_wakeup_capable;
> >       bool                    has_phy;
> > +     int                     num_inbound_wins;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -789,23 +806,61 @@ static void brcm_pcie_perst_set_generic(struct br=
cm_pcie *pcie, u32 val)
> >       writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> >  }
> >
> > -static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pci=
e,
> > -                                                     u64 *rc_bar2_size=
,
> > -                                                     u64 *rc_bar2_offs=
et)
> > +static inline void set_bar(struct inbound_win *b, int *count, u64 size=
,
> > +                        u64 cpu_addr, u64 pci_offset)
>
> There is no need to pass 'inline' keyword in a .c file. Making a function=
 inline
> is upto the discretion of the compiler.
>
> Also, set_bar() is quite misleading as you are not setting any BAR but ju=
st
> populating the inbound_win struct. So how about, "add_inbound_window()"?
>
> > +{
> > +     b->size =3D size;
> > +     b->cpu_addr =3D cpu_addr;
> > +     b->pci_offset =3D pci_offset;
> > +     (*count)++;
> > +}
> > +
> > +static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
> > +                                   struct inbound_win inbound_wins[])
> >  {
> >       struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> > +     u64 pci_offset, cpu_addr, size =3D 0, tot_size =3D 0;
> >       struct resource_entry *entry;
> >       struct device *dev =3D pcie->dev;
> >       u64 lowest_pcie_addr =3D ~(u64)0;
> > -     int ret, i =3D 0;
> > -     u64 size =3D 0;
> > +     int ret, i =3D 0, n =3D 0;
> > +
> > +     /*
> > +      * The HW registers (and PCIe) use order-1 numbering for BARs. As
> > +      * such, we have inbound_wins[0] unused and BAR1 starts at inboun=
d_wins[1].
> > +      */
>
> Instead of wasting one array entry, you can start the array from 0 and ju=
st
> decrement the index where needed? Like,
>
>         reg_offset =3D brcm_bar_reg_offset(i - 1);

This is intentional -- IMO it is worth the waste of one entry to
improve the readability and avoid the "- 1" everywhere an index is
used.

Further, I am only wasting an entry on the stack for a brief moment of
a function that is only called once, this does not affect memory usage
at all.

If you insist on this I will change it but I prefer it this way.




>
> > +     struct inbound_win *b_begin =3D &inbound_wins[1];
> > +     struct inbound_win *b =3D b_begin;
> > +
> > +     /*
> > +      * STB chips beside 7712 disable the first inbound window default=
.
> > +      * Rather being mapped to system memory it is mapped to the
> > +      * internal registers of the SoC.  This feature is deprecated, ha=
s
> > +      * security considerations, and is not implemented in our modern
> > +      * SoCs.
> > +      */
> > +     if (pcie->type !=3D BCM7712)
> > +             set_bar(b++, &n, 0, 0, 0);
> >
> >       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> >               u64 pcie_beg =3D entry->res->start - entry->offset;
> > +             u64 cpu_beg =3D entry->res->start;
>
> What does 'beg' mean?

"beg" =3D> "begin".  I will change it to start.

>
> >
> > -             size +=3D entry->res->end - entry->res->start + 1;
> > +             size =3D resource_size(entry->res);
> > +             tot_size +=3D size;
> >               if (pcie_beg < lowest_pcie_addr)
> >                       lowest_pcie_addr =3D pcie_beg;
> > +             /*
> > +              * 7712 and newer chips may have many BARs, with each
> > +              * offering a non-overlapping viewport to system memory.
> > +              * That being said, each BARs size must still be a power =
of
> > +              * two.
> > +              */
> > +             if (pcie->type =3D=3D BCM7712)
> > +                     set_bar(b++, &n, size, cpu_beg, pcie_beg);
> > +
> > +             if (n > pcie->num_inbound_wins)
> > +                     break;
> >       }
> >
> >       if (lowest_pcie_addr =3D=3D ~(u64)0) {
> > @@ -813,13 +868,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
struct brcm_pcie *pcie,
> >               return -EINVAL;
> >       }
> >
> > +     /*
> > +      * 7712 and newer chips do not have an internal memory mapping sy=
stem
> > +      * that enables multiple memory controllers.  As such, it can ret=
urn
> > +      * now w/o doing special configuration.
> > +      */
> > +     if (pcie->type =3D=3D BCM7712)
> > +             return n;
> > +
> >       ret =3D of_property_read_variable_u64_array(pcie->np, "brcm,scb-s=
izes", pcie->memc_size, 1,
> >                                                 PCIE_BRCM_MAX_MEMC);
> > -
> >       if (ret <=3D 0) {
> >               /* Make an educated guess */
> >               pcie->num_memc =3D 1;
> > -             pcie->memc_size[0] =3D 1ULL << fls64(size - 1);
> > +             pcie->memc_size[0] =3D 1ULL << fls64(tot_size - 1);
> >       } else {
> >               pcie->num_memc =3D ret;
> >       }
> > @@ -828,10 +890,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
struct brcm_pcie *pcie,
> >       for (i =3D 0, size =3D 0; i < pcie->num_memc; i++)
> >               size +=3D pcie->memc_size[i];
> >
> > -     /* System memory starts at this address in PCIe-space */
> > -     *rc_bar2_offset =3D lowest_pcie_addr;
> > -     /* The sum of all memc views must also be a power of 2 */
> > -     *rc_bar2_size =3D 1ULL << fls64(size - 1);
> > +     /* Our HW mandates that the window size must be a power of 2 */
> > +     size =3D 1ULL << fls64(size - 1);
> > +
> > +     /*
> > +      * For STB chips, the BAR2 cpu_addr is hardwired to the start
> > +      * of system memory, so we set it to 0.
> > +      */
> > +     cpu_addr =3D 0;
> > +     pci_offset =3D lowest_pcie_addr;
> >
> >       /*
> >        * We validate the inbound memory view even though we should trus=
t
> > @@ -866,25 +933,90 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
struct brcm_pcie *pcie,
> >        *   outbound memory @ 3GB). So instead it will  start at the 1x
> >        *   multiple of its size
> >        */
> > -     if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
> > -         (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
> > -             dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, o=
ff 0x%llx\n",
> > -                     *rc_bar2_size, *rc_bar2_offset);
> > +     if (!size || (pci_offset & (size - 1)) ||
> > +         (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
> > +             dev_err(dev, "Invalid inbound_win2_offset/size: size 0x%l=
lx, off 0x%llx\n",
> > +                     size, pci_offset);
> >               return -EINVAL;
> >       }
> >
> > -     return 0;
> > +     /* Enable inbound window 2, the main inbound window for STB chips=
 */
> > +     set_bar(b++, &n, size, cpu_addr, pci_offset);
> > +
> > +     /*
> > +      * Disable inbound window 3.  On some chips presents the same
> > +      * window as #2 but the data appears in a settable endianness.
> > +      */
> > +     set_bar(b++, &n, 0, 0, 0);
> > +
> > +     return n;
> > +}
> > +
> > +static u32 brcm_bar_reg_offset(int bar)
> > +{
> > +     if (bar <=3D 3)
> > +             return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
> > +     else
> > +             return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
> > +}
> > +
> > +static u32 brcm_ubus_reg_offset(int bar)
> > +{
> > +     if (bar <=3D 3)
> > +             return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
> > +     else
> > +             return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
> > +}
> > +
> > +static void set_inbound_win_registers(struct brcm_pcie *pcie,
> > +                                   const struct inbound_win *inbound_w=
ins,
> > +                                   int num_inbound_wins)
> > +{
> > +     void __iomem *base =3D pcie->base;
> > +     int i;
> > +
> > +     for (i =3D 1; i <=3D num_inbound_wins; i++) {
> > +             u64 pci_offset =3D inbound_wins[i].pci_offset;
> > +             u64 cpu_addr =3D inbound_wins[i].cpu_addr;
> > +             u64 size =3D inbound_wins[i].size;
> > +             u32 reg_offset =3D brcm_bar_reg_offset(i);
> > +             u32 tmp =3D lower_32_bits(pci_offset);
> > +
> > +             u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> > +                               PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> > +
> > +             /* Write low */
> > +             writel(tmp, base + reg_offset);
>
> Can you use writel_relaxed() instead? Here and below. I don't see a neces=
sity to
> use the barrier that comes with non-relaxed version of writel.

Yep.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--00000000000070482e061f814f45
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAfft2nj0ZttYC/JoCbHy27IUqnrgSh
c50cnntGJpWcpDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIxOTE1MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAXmT9TEHWidZc9TbuzW1FmJHICVzsFVVz+iUmpXfB5Qkg3ob/
eFxfYAmnfF8hQr4MwfjU72YHviIMFhqhCNEj2YAGi+n7NftNUwp0QI/RoyEDkn5x5+J1jp8NVL0P
5qTP4OiVVE/3Na9O6AWPpmgryxGb9UzrxZc4/kt9PmYqV8EGhl8QRzTw2HaRsHgAWqRvqSrfzhYN
6B2ny2Fk+eygVQIBF2j92i/VZKTtbGou4x/Uw4pLu0+X1JVcLrT4xbv+Oh8tAi97mWal2pKvGOF/
iB8/5VttWGc+TcQuI2oicq5aelOxELpd4v6Ij7uN4CO/zKe8xnScIQ5mxkcwrwgMIw==
--00000000000070482e061f814f45--


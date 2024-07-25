Return-Path: <linux-pci+bounces-10803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0893C98C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FDE1F224A0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC22B9C9;
	Thu, 25 Jul 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KEOVIYAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAC1DFF7
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939413; cv=none; b=uSTtrvNPPDH2adYPdYTGKdeZxbcKubq0kFO6LHdRejIpUKigF1h8A9LUGGNEwyOYmKm4RETqaoMeJYBg6nMCDMLVQegtIqdsi3i5v6y+Qvw14KDG02DOCxB9xnU2aIrPs3CycSlEzN13af0udSUWkbWATkiyVAgUkCJoyTfjpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939413; c=relaxed/simple;
	bh=ekEtXWreYfbpEs/MIqQMUnS6csN4N8uKRoNKzCU3quk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhoR+g2kNl6be/hs9Go8ns1SJtyb2qKQibZtAuJv64IY5z8fY2x55qKTRndys2yKH4o38ZAtlirUWZV1/A/6e4K5tJ5TUSlNgbP4yWg8Rn3erBYZ028v4Vr/2b/lzujLsiJjt2wLGdvdb3mvpJ5pUfuAo2b2CNJMdTS6NcO5nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KEOVIYAI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efba36802so986547e87.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721939409; x=1722544209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyWKRAvjVlY88OKfAz/Ru/XRtOMMeUcFWOdtKk+QTRs=;
        b=KEOVIYAI9cu21za8bPAWcUQPvvnK08LDo2NrNog1GxW+WCVkB2oQN+u0ec5EW2wucX
         ug0rtiv7skW4E46eGgVQ7/3LFc3XtiqPBmjUjH6ynXub5CXrN00UOKrbeSNzEu0CSxx8
         aV9RSfwxSkRj78kxz/0h58p9bX136g5AnXlC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939409; x=1722544209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyWKRAvjVlY88OKfAz/Ru/XRtOMMeUcFWOdtKk+QTRs=;
        b=MffUKQE/yOjDDUKNRRgHAAoWBkHBJ21rwKWMw8uueaOm/fXWg3xHgzODCzUP62wP2u
         r9IokDPkjrMJwnj4Ny/ymCu58Nkg62m+CzxNTMJOWDLa/yVdU7TPpA4CoyQWnM5MHK3G
         wmf93ntO/+UHmYpabSOZNwxHn0ucH5UNk/OY8vKA78Kdj3fCqxcACJewA4w2gy5QaUos
         Uy3/n94egqzP7PLcVGOa7KZLFWuefX2QBrRroFBzL1jbTL1AcMhPgvXWQXVg/lEyVE29
         dGA0Pac+Xefbqyk0pBrQPiLVfoZl0s7HSBuxzBu2Y9dd74Rw+xb46gi1TXoZhCmv06/q
         DhTw==
X-Gm-Message-State: AOJu0YzOxTCK76dzMSMQr0xG1UZ+ESdAJEogr7R1Jdun9+kBadfS07O0
	Rz/QoYICdAe3OmOhStH3tVxk1H5q68UCfIUwgSmVroy3mZgsJizDHfbAWygKLxrYmzFwikTxTrq
	SSkzZJimdraV9cJfAol5dVJ2il7UPG1bUhTqo
X-Google-Smtp-Source: AGHT+IELYhxIT1CDHomfEjy8r0miSSUq3G3KesJa1eC+UyJ0rR1cP4O9JDRNFTh4ekAArIYuSrSK2ox09HuF3UCeXVU=
X-Received: by 2002:a05:6512:3504:b0:52d:b226:9428 with SMTP id
 2adb3069b0e04-52fd6018daamr2270611e87.6.1721939408916; Thu, 25 Jul 2024
 13:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-10-james.quinlan@broadcom.com> <20240725045318.GJ2317@thinkpad>
In-Reply-To: <20240725045318.GJ2317@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 25 Jul 2024 16:29:56 -0400
Message-ID: <CA+-6iNyQ09BESbdCwY1x4yUOLmAHKFBU3-9TO_ST+2GkOEEAng@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
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
	boundary="000000000000d30a1f061e184226"

--000000000000d30a1f061e184226
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:53=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 16, 2024 at 05:31:24PM -0400, Jim Quinlan wrote:
> > Previously, our chips provided three inbound "BARS" with fixed purposes=
:
> > the first was for mapping SoC internal registers, the second was for
> > memory, and the third was for memory but with the endian swapped.  We
> > typically only used one of these BARs.
> >
> > Complicating that BARs usage was the fact that the PCIe HW would do a
> > baroque internal mapping of system memory, and concatenate the regions =
of
> > multiple memory controllers.
> >
> > Newer chips such as the 7712 and Cable Modem SOCs have taken a step for=
ward
> > and now provide multiple inbound BARs.  This works in concert with the
> > dma-ranges property, where each provided range becomes an inbound BAR.
> >
> > This commit provides support for these new chips and their multiple
> > inbound BARs but also keeps the legacy support for the older system.
> >
>
> BAR belongs to the endpoints not to the RC. How can the RC have 'BARs'? R=
C can
> only map endpoint BARs to MEM region. What you are referring to is 'MEM r=
egion'
> maybe?

Agreed, it is confusing.  Long story short, the HW team gave the
inbound windows the label "BAR".   We will still have to use their
register names,
e.g. PCIE_MISC_RC_BAR4_CONFIG_LO, but what I can do is change
for example "struct rc_bar" to "struct inbound_win" as well as make similar
changes to the code and function names.

Let's assume you will be okay with my plan above; if not, please tell
me what you would prefer.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> - Mani
>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 216 ++++++++++++++++++++------
> >  1 file changed, 167 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 8ab5a8ca05b4..c44a92217855 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -75,15 +75,12 @@
> >  #define PCIE_MEM_WIN0_HI(win)        \
> >               PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
> >
> > +#define PCIE_BRCM_MAX_RC_BARS                                16
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
> > @@ -130,6 +127,10 @@
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
> > @@ -217,12 +218,20 @@ enum pcie_type {
> >       BCM4908,
> >       BCM7278,
> >       BCM2711,
> > +     BCM7712,
> > +};
> > +
> > +struct rc_bar {
> > +     u64 size;
> > +     u64 pci_offset;
> > +     u64 cpu_addr;
> >  };
> >
> >  struct pcie_cfg_data {
> >       const int *offsets;
> >       const enum pcie_type type;
> >       const bool has_phy;
> > +     unsigned int num_inbound;
> >       void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >  };
> > @@ -274,6 +283,7 @@ struct brcm_pcie {
> >       struct subdev_regulators *sr;
> >       bool                    ep_wakeup_capable;
> >       bool                    has_phy;
> > +     int                     num_inbound;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -789,23 +799,61 @@ static void brcm_pcie_perst_set_generic(struct br=
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
> > +static inline void set_bar(struct rc_bar *b, int *count, u64 size,
> > +                        u64 cpu_addr, u64 pci_offset)
> > +{
> > +     b->size =3D size;
> > +     b->cpu_addr =3D cpu_addr;
> > +     b->pci_offset =3D pci_offset;
> > +     (*count)++;
> > +}
> > +
> > +static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
> > +                                   struct rc_bar rc_bars[])
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
> > +      * such, we have rc_bars[0] unused and BAR1 starts at rc_bars[1].
> > +      */
> > +     struct rc_bar *b_begin =3D &rc_bars[1];
> > +     struct rc_bar *b =3D b_begin;
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
> > +             if (n > pcie->num_inbound)
> > +                     break;
> >       }
> >
> >       if (lowest_pcie_addr =3D=3D ~(u64)0) {
> > @@ -813,13 +861,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
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
> > @@ -828,10 +883,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
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
> > @@ -866,25 +926,89 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(=
struct brcm_pcie *pcie,
> >        *   outbound memory @ 3GB). So instead it will  start at the 1x
> >        *   multiple of its size
> >        */
> > -     if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
> > -         (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
> > +     if (!size || (pci_offset & (size - 1)) ||
> > +         (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
> >               dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, o=
ff 0x%llx\n",
> > -                     *rc_bar2_size, *rc_bar2_offset);
> > +                     size, pci_offset);
> >               return -EINVAL;
> >       }
> >
> > -     return 0;
> > +     /* Enable BAR2, the inbound window for STB chips */
> > +     set_bar(b++, &n, size, cpu_addr, pci_offset);
> > +
> > +     /*
> > +      * Disable BAR3.  On some chips presents the same window as BAR2
> > +      * but the data appears in a settable endianness.
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
> > +static void set_inbound_win_registers(struct brcm_pcie *pcie, const st=
ruct rc_bar *rc_bars,
> > +                                   int num_rc_bars)
> > +{
> > +     void __iomem *base =3D pcie->base;
> > +     int i;
> > +
> > +     for (i =3D 1; i <=3D num_rc_bars; i++) {
> > +             u64 pci_offset =3D rc_bars[i].pci_offset;
> > +             u64 cpu_addr =3D rc_bars[i].cpu_addr;
> > +             u64 size =3D rc_bars[i].size;
> > +             u32 reg_offset =3D brcm_bar_reg_offset(i);
> > +             u32 tmp =3D lower_32_bits(pci_offset);
> > +
> > +             u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> > +                               PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> > +
> > +             /* Write low */
> > +             writel(tmp, base + reg_offset);
> > +             /* Write high */
> > +             writel(upper_32_bits(pci_offset), base + reg_offset + 4);
> > +
> > +             /*
> > +              * Most STB chips:
> > +              *     Do nothing.
> > +              * 7712:
> > +              *     All of their BARs need to be set.
> > +              */
> > +             if (pcie->type =3D=3D BCM7712) {
> > +                     /* BUS remap register settings */
> > +                     reg_offset =3D brcm_ubus_reg_offset(i);
> > +                     tmp =3D lower_32_bits(cpu_addr) & ~0xfff;
> > +                     tmp |=3D PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_=
EN_MASK;
> > +                     writel(tmp, base + reg_offset);
> > +                     tmp =3D upper_32_bits(cpu_addr);
> > +                     writel(tmp, base + reg_offset + 4);
> > +             }
> > +     }
> >  }
> >
> >  static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >  {
> > -     u64 rc_bar2_offset, rc_bar2_size;
> > +     struct rc_bar rc_bars[PCIE_BRCM_MAX_RC_BARS];
> >       void __iomem *base =3D pcie->base;
> >       struct pci_host_bridge *bridge;
> >       struct resource_entry *entry;
> >       u32 tmp, burst, aspm_support;
> > -     int num_out_wins =3D 0;
> > -     int ret, memc;
> > +     int num_out_wins =3D 0, num_rc_bars =3D 0;
> > +     int memc;
> >
> >       /* Reset the bridge */
> >       pcie->bridge_sw_init_set(pcie, 1);
> > @@ -933,17 +1057,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pci=
e)
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_=
MASK);
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >
> > -     ret =3D brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size=
,
> > -                                                 &rc_bar2_offset);
> > -     if (ret)
> > -             return ret;
> > +     num_rc_bars =3D brcm_pcie_get_inbound_wins(pcie, rc_bars);
> > +     if (num_rc_bars < 0)
> > +             return num_rc_bars;
> >
> > -     tmp =3D lower_32_bits(rc_bar2_offset);
> > -     u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> > -                       PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
> > -     writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> > -     writel(upper_32_bits(rc_bar2_offset),
> > -            base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> > +     set_inbound_win_registers(pcie, rc_bars, num_rc_bars);
> > +
> > +     if (!brcm_pcie_rc_mode(pcie)) {
> > +             dev_err(pcie->dev, "PCIe RC controller misconfigured as E=
ndpoint\n");
> > +             return -EINVAL;
> > +     }
> >
> >       tmp =3D readl(base + PCIE_MISC_MISC_CTRL);
> >       for (memc =3D 0; memc < pcie->num_memc; memc++) {
> > @@ -965,25 +1088,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pci=
e)
> >        * 4GB or when the inbound area is smaller than 4GB (taking into
> >        * account the rounding-up we're forced to perform).
> >        */
> > -     if (rc_bar2_offset >=3D SZ_4G || (rc_bar2_size + rc_bar2_offset) =
< SZ_4G)
> > +     if (rc_bars[2].pci_offset >=3D SZ_4G ||
> > +         (rc_bars[2].size + rc_bars[2].pci_offset) < SZ_4G)
> >               pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_LT_4GB;
> >       else
> >               pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_GT_4GB;
> >
> > -     if (!brcm_pcie_rc_mode(pcie)) {
> > -             dev_err(pcie->dev, "PCIe RC controller misconfigured as E=
ndpoint\n");
> > -             return -EINVAL;
> > -     }
> > -
> > -     /* disable the PCIe->GISB memory window (RC_BAR1) */
> > -     tmp =3D readl(base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> > -     tmp &=3D ~PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK;
> > -     writel(tmp, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> > -
> > -     /* disable the PCIe->SCB memory window (RC_BAR3) */
> > -     tmp =3D readl(base + PCIE_MISC_RC_BAR3_CONFIG_LO);
> > -     tmp &=3D ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
> > -     writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
> >
> >       /* Don't advertise L0s capability if 'aspm-no-l0s' */
> >       aspm_support =3D PCIE_LINK_STATE_L1;
> > @@ -1516,6 +1626,7 @@ static const struct pcie_cfg_data generic_cfg =3D=
 {
> >       .type           =3D GENERIC,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct pcie_cfg_data bcm7425_cfg =3D {
> > @@ -1523,6 +1634,7 @@ static const struct pcie_cfg_data bcm7425_cfg =3D=
 {
> >       .type           =3D BCM7425,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct pcie_cfg_data bcm7435_cfg =3D {
> > @@ -1530,6 +1642,7 @@ static const struct pcie_cfg_data bcm7435_cfg =3D=
 {
> >       .type           =3D BCM7435,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct pcie_cfg_data bcm4908_cfg =3D {
> > @@ -1537,6 +1650,7 @@ static const struct pcie_cfg_data bcm4908_cfg =3D=
 {
> >       .type           =3D BCM4908,
> >       .perst_set      =3D brcm_pcie_perst_set_4908,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const int pcie_offset_bcm7278[] =3D {
> > @@ -1552,6 +1666,7 @@ static const struct pcie_cfg_data bcm7278_cfg =3D=
 {
> >       .type           =3D BCM7278,
> >       .perst_set      =3D brcm_pcie_perst_set_7278,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_7278,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct pcie_cfg_data bcm2711_cfg =3D {
> > @@ -1559,6 +1674,7 @@ static const struct pcie_cfg_data bcm2711_cfg =3D=
 {
> >       .type           =3D BCM2711,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct pcie_cfg_data bcm7216_cfg =3D {
> > @@ -1567,6 +1683,7 @@ static const struct pcie_cfg_data bcm7216_cfg =3D=
 {
> >       .perst_set      =3D brcm_pcie_perst_set_7278,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_7278,
> >       .has_phy        =3D true,
> > +     .num_inbound    =3D 3,
> >  };
> >
> >  static const struct of_device_id brcm_pcie_match[] =3D {
> > @@ -1623,6 +1740,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >       pcie->perst_set =3D data->perst_set;
> >       pcie->bridge_sw_init_set =3D data->bridge_sw_init_set;
> >       pcie->has_phy =3D data->has_phy;
> > +     pcie->num_inbound =3D data->num_inbound;
> >
> >       pcie->base =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(pcie->base))
> > --
> > 2.17.1
> >
>
>
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000d30a1f061e184226
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDR+CvPgXpHnbFibzbu/KpcLs4rU/5m
NjtaezQscbF8ezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MjUyMDMwMDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAIYUNUxS/5ObqMB4IkqkZGXmpDcqzbURsah7SkewtuTeoxlTk
o+sVsmMcywgN5ZlDK5gqR6Pi+Oc2XPujY60Hp7P2nxqX0UhU02dx2kqT2Ds3RV8TmpbYPTFuu4qu
9Fsy7Q++7LXIpQoNjl9tRp/jANPhuc0HTqVfgI3gbi6+b2a67/9cY06kXH0ktiFNozeEy1X47izH
0QInFUuiY0XdinddheR0/8Nzap4+yfu3wDl3obVCATpTsWlsj7wkTTrnM28OnK9UW/Z9/Yl1pGww
mECivtQLKVbjac/GxJV96YNemyAioP5xFwqiBk73tsiWEPdxEfrv5rqoYX3Oiqf54A==
--000000000000d30a1f061e184226--


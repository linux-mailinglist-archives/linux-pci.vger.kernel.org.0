Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD89F7EFC61
	for <lists+linux-pci@lfdr.de>; Sat, 18 Nov 2023 01:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjKRABi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 19:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKRABf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 19:01:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880581AD;
        Fri, 17 Nov 2023 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700265691; x=1731801691;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MGvMoTy89iDOVbgyWdLZ/x/XdFIs3cgrj3lH7iWvPls=;
  b=iF6XDW98oGF2z1b+fr9I8JeFX3SGd3lAdSQbsKCV4UAeNylykanFQcGf
   GSmfDl2rvAXUZkEXqC775JWYoc5hi2h+sTKsFuYMP6+n3Scm8X5/HaS+w
   J9Ktrz6DVa7FnNJmyaF5MytVYY1fFjnlLgl9k3ycy21sJTaRluvyedQxf
   3fbysfpJBysmySnPW4LCsSakj8LF4C7vgsAwpCwLdIejtOeKSncdRHCDJ
   cBfvfTlqtiWFd9atHiNmduH0/XvFn6RdgMz6u5qcUPd53DKO+da1RpxU1
   nYCy+Sa3aSnchvgf58FEa2BlnUe3rzkA3bfccOTHtJ0NIgTMO1AEw0a+o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371566706"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="371566706"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 16:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889393035"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889393035"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 16:00:47 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 02D88580DB4;
        Fri, 17 Nov 2023 16:00:47 -0800 (PST)
Message-ID: <f2d1476199e974dd1d303b22c25594f066e85de5.camel@linux.intel.com>
Subject: Re: [PATCH 1/6] PCI/ASPM: Add locked helper for enabling link state
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Fri, 17 Nov 2023 16:00:46 -0800
In-Reply-To: <20231114135553.32301-2-johan+linaro@kernel.org>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
         <20231114135553.32301-2-johan+linaro@kernel.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-11-14 at 14:55 +0100, Johan Hovold wrote:
> Add a helper for enabling link states that can be used in contexts where
> a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
>=20
> This helper will be used to fix a couple of potential deadlocks where
> the current helper is called with the lock already held, hence the CC
> stable tag.

Thanks for sending a patch to address this. It had fallen off my radar.

>=20
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR"=
)
> Cc: stable@vger.kernel.org=C2=A0=C2=A0=C2=A0# 6.3
> Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> =C2=A0drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++-------=
---
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 43 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..8cf8cc2d6bba 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev, i=
nt
> state)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(pci_disable_link_state);
> =C2=A0
> -/**
> - * pci_enable_link_state - Clear and set the default device link state s=
o
> that
> - * the link may be allowed to enter the specified states. Note that if t=
he
> - * BIOS didn't grant ASPM control to the OS, this does nothing because w=
e
> can't
> - * touch the LNKCTL register. Also note that this does not enable states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> - *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - */
> -int pci_enable_link_state(struct pci_dev *pdev, int state)
> +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool
> locked)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pcie_link_state *l=
ink =3D pcie_aspm_get_link(pdev);
> =C2=A0
> @@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int
> state)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0down_read(&pci_bus_sem);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!locked)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0down_read(&pci_bus_sem);

This solution is similar to the original one I proposed [1]. It just create=
s a
separate locked function rather than using a flag. While the API is consist=
ent
with pci_disable_link_state_locked(), its usage is not. The vmd driver call=
s
pci_enable_link_state() from pci_walk_bus() which was problematic for Bjorn=
 [2].
I owed an attempt to implement this as a fixup. However, now
qcom_pcie_enabled_aspm() is also using it from pci_walk_bus(). The fixup co=
uld
make sense for VMD since there it's fixing missing BIOS settings, but I'm n=
ot
sure about qcom. Bjorn, do you still see issues with the use in pci_bus_wal=
k()?

[1]
https://lore.kernel.org/lkml/20230321233849.3408339-1-david.e.box@linux.int=
el.com/

[2] https://lore.kernel.org/lkml/20230322205702.GA2493123@bhelgaas/

David

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&aspm_lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK_STA=
TE_L0S)
> @@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev, i=
nt
> state)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->clkpm_default =3D (=
state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_set_clkpm(link, poli=
cy_to_clkpm_state(link));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&aspm_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0up_read(&pci_bus_sem);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!locked)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0up_read(&pci_bus_sem);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> +
> +/**
> + * pci_enable_link_state - Clear and set the default device link state s=
o
> that
> + * the link may be allowed to enter the specified states. Note that if t=
he
> + * BIOS didn't grant ASPM control to the OS, this does nothing because w=
e
> can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_link_state(struct pci_dev *pdev, int state)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __pci_enable_link_state=
(pdev, state, false);
> +}
> =C2=A0EXPORT_SYMBOL(pci_enable_link_state);
> =C2=A0
> +/**
> + * pci_enable_link_state - Clear and set the default device link state s=
o
> that
> + * the link may be allowed to enter the specified states. Note that if t=
he
> + * BIOS didn't grant ASPM control to the OS, this does nothing because w=
e
> can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Context: Caller holds pci_bus_sem read lock.
> + */
> +int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lockdep_assert_held_read(&pci_=
bus_sem);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __pci_enable_link_state=
(pdev, state, true);
> +}
> +EXPORT_SYMBOL(pci_enable_link_state_locked);
> +
> =C2=A0static int pcie_aspm_set_policy(const char *val,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct kernel_param *kp)
> =C2=A0{
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..dea043bc1e38 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1829,6 +1829,7 @@ extern bool pcie_ports_native;
> =C2=A0int pci_disable_link_state(struct pci_dev *pdev, int state);
> =C2=A0int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> =C2=A0int pci_enable_link_state(struct pci_dev *pdev, int state);
> +int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> =C2=A0void pcie_no_aspm(void);
> =C2=A0bool pcie_aspm_support_enabled(void);
> =C2=A0bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1839,6 +1840,8 @@ static inline int pci_disable_link_state_locked(str=
uct
> pci_dev *pdev, int state)
> =C2=A0{ return 0; }
> =C2=A0static inline int pci_enable_link_state(struct pci_dev *pdev, int s=
tate)
> =C2=A0{ return 0; }
> +static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int
> state)
> +{ return 0; }
> =C2=A0static inline void pcie_no_aspm(void) { }
> =C2=A0static inline bool pcie_aspm_support_enabled(void) { return false; =
}
> =C2=A0static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return=
 false; }


Return-Path: <linux-pci+bounces-18168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C819ED358
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F67F1882E51
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA31FECB3;
	Wed, 11 Dec 2024 17:26:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E221FECAF
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937966; cv=none; b=OF61yOzFqqsZz0SC7EetUxvXOFzvso2T04/mfDDx/ymy8UHEKaOE207I8E9piqPTor8ctpdcigVM/7iOoZWI8BkacS7BJb6w0dY+XEBj0E5GFTQuLlpmBIftWHziy+/d2vhLBcmo6lOZ9GATtSH467cahTAt2lZ1OsfdhsiCONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937966; c=relaxed/simple;
	bh=c3Cn9HtwSfCR4vdRQezMLR2RhkZ42GwaWtwoWiwC50Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLI4s+Lx9DY58VqcvjQBDZvvVcFbc7vEOS/idmz8vjEfZFyOUdGlbd7tKIZCTSZVNziscHOmCc8VQYd0rLyObpnP6Ja2f1iw/hCmuwkoZUHkSk9gem7TNp1X/Hv+YvJ5yOtoI5sxtfjFxsSsw+7cGcIwdnPwYIPbOdyiTjSjmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7jCh3b1Zz6D97N;
	Thu, 12 Dec 2024 01:25:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EA41C140AB8;
	Thu, 12 Dec 2024 01:25:58 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 18:25:58 +0100
Date: Wed, 11 Dec 2024 17:25:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <kw@linux.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] Add helper functions for Power Budgeting
 Extended Capability
Message-ID: <20241211172556.00004850@huawei.com>
In-Reply-To: <20241210040826.11402-2-kobayashi.da-06@fujitsu.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
	<20241210040826.11402-2-kobayashi.da-06@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Dec 2024 13:08:20 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add functions to return a text description of the supplied
> power_budget scale/base power/rail.
> Export these functions so they can be used by modules.
>=20
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Hi.  A few comments inline,

Thanks,

Jonathan

> ---
>  drivers/pci/pci.h             |  3 ++
>  drivers/pci/probe.c           | 66 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  3 +-
>  3 files changed, 71 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..967b53996694 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -374,6 +374,9 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_sp=
eed speed)
>  }
> =20
>  const char *pci_speed_string(enum pci_bus_speed speed);
> +const char *pci_power_budget_scale_string(u8 num);
> +const char *pci_power_budget_alt_encode_string(u8 num);
> +const char *pci_power_budget_rail_string(u8 num);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f1615805f5b0..18a920527f69 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -748,6 +748,72 @@ void pcie_update_link_speed(struct pci_bus *bus, u16=
 linksta)
>  }
>  EXPORT_SYMBOL_GPL(pcie_update_link_speed);
> =20
> +const char *pci_power_budget_rail_string(u8 num)
> +{
> +	/* Indexed by the rail number */
> +	static const char *rail_strings[] =3D {
> +	    "Power(12V)",		/* 0x00 */

For these you could do
	[0x00] =3D "Power(12V"), rather than the comment?
Makes the code self documenting and keeps it easy to compare
with the specification.


> +	    "Power(3.3V)",		/* 0x01 */
> +	    "Power(1.5Vor1.8V)",		/* 0x02 */
> +	    "Power(48V)",		/* 0x03 */
> +	    "Power(5V)",		/* 0x04 */
> +	    "Thermal",			/* 0x05 */
> +	};
> +
> +	if (num < ARRAY_SIZE(rail_strings))
> +		return rail_strings[num];
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(pci_power_budget_rail_string);
> +
> +const char *pci_power_budget_scale_string(u8 num)
> +{
> +	/* Indexed by the scale number */
> +	static const char *scale_strings[] =3D {
As above.

> +	    "x1.0",		/* 0x00 */
> +	    "x0.1",		/* 0x01 */
> +	    "x0.01",		/* 0x02 */
> +	    "x0.001",		/* 0x03 */
> +	    "x10",		/* 0x04 */
> +	    "x100",			/* 0x05 */
> +	};
> +
> +	if (num < ARRAY_SIZE(scale_strings))
> +		return scale_strings[num];
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(pci_power_budget_scale_string);
> +
> +const char *pci_power_budget_alt_encode_string(u8 num)
> +{
> +	u8 n;
> +	n =3D num & 0x0f;

	u8 n =3D num & 0x0f;

> +	/* Indexed by the Base Power number */
> +	static const char *Power_strings[] =3D {
> +	    "> 239 W and =E2=89=A4 250 W Slot Power Limit",		/* 0xF0 */
> +	    "> 250 W and =E2=89=A4 275 W Slot Power Limit",		/* 0xF1 */
> +	    "> 275 W and =E2=89=A4 300 W Slot Power Limit",		/* 0xF2 */
> +	    "> 300 W and =E2=89=A4 325 W Slot Power Limit",		/* 0xF3 */
> +	    "> 325 W and =E2=89=A4 350 W Slot Power Limit",		/* 0xF4 */
> +	    "> 350 W and =E2=89=A4 375 W Slot Power Limit",		/* 0xF5 */
> +	    "> 375 W and =E2=89=A4 400 W Slot Power Limit",		/* 0xF6 */
> +	    "> 400 W and =E2=89=A4 425 W Slot Power Limit",		/* 0xF7 */
> +	    "> 425 W and =E2=89=A4 450 W Slot Power Limit",		/* 0xF8 */
> +	    "> 450 W and =E2=89=A4 475 W Slot Power Limit",		/* 0xF9 */
> +	    "> 475 W and =E2=89=A4 500 W Slot Power Limit",		/* 0xFA */
> +	    "> 500 W and =E2=89=A4 525 W Slot Power Limit",		/* 0xFB */
> +	    "> 525 W and =E2=89=A4 550 W Slot Power Limit",		/* 0xFC */
> +	    "> 550 W and =E2=89=A4 575 W Slot Power Limit",		/* 0xFD */
> +	    "> 575 W and =E2=89=A4 600 W Slot Power Limit",		/* 0xFE */
> +	    "Greater than 600 W",		/* 0xFF */

Technically the spec says it's "Reserved for values greater than 600 W", but
which I assume they mean a new interface will be needed if you see 0xFF.
I guess your text works for that though.

> +	};
> +
> +	if (n < ARRAY_SIZE(Power_strings))
> +		return Power_strings[n];
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(pci_power_budget_alt_encode_string);

Why do you need the export? Aren't all the users in the core PCI code?

> +
>  static unsigned char agp_speeds[] =3D {
>  	AGP_UNKNOWN,
>  	AGP_1X,
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 12323b3334a9..3a5e238b98d8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -842,11 +842,12 @@
>  #define PCI_PWR_DSR		0x04	/* Data Select Register */
>  #define PCI_PWR_DATA		0x08	/* Data Register */
>  #define  PCI_PWR_DATA_BASE(x)	((x) & 0xff)	    /* Base Power */
> -#define  PCI_PWR_DATA_SCALE(x)	(((x) >> 8) & 3)    /* Data Scale */
> +#define  PCI_PWR_DATA_SCALE(x)	(((x) >> 8) & 3)    /* Data Scale[1:0] */
>  #define  PCI_PWR_DATA_PM_SUB(x)	(((x) >> 10) & 7)   /* PM Sub State */
>  #define  PCI_PWR_DATA_PM_STATE(x) (((x) >> 13) & 3) /* PM State */
>  #define  PCI_PWR_DATA_TYPE(x)	(((x) >> 15) & 7)   /* Type */
>  #define  PCI_PWR_DATA_RAIL(x)	(((x) >> 18) & 7)   /* Power Rail */
> +#define  PCI_PWR_DATA_SCALE_UP(x)	(((x) >> 21) & 1)    /* Data Scale[2] =
*/
>  #define PCI_PWR_CAP		0x0c	/* Capability */
>  #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
>  #define PCI_EXT_CAP_PWR_SIZEOF	0x10



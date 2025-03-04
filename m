Return-Path: <linux-pci+bounces-22878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49973A4EA6A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289063A8FA3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AEB27CB05;
	Tue,  4 Mar 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGYrpdMJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1227CB02
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107269; cv=none; b=PnKAwtkokMSalkponqWJ8JvAlhUQqWS1ugkFJWzaSomL5WvUdeJpSLmhmQENPrKlbTFoI77AM8bPe2KfYCMyKg1qNhXye2/wr6HZnmhSSN8srVLotgn9ZNPcYjONA1rZX3KnjsK5hs5Wx+sKu5m05YLBKDFpqQ/4twxfPM9223I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107269; c=relaxed/simple;
	bh=mflvDm5CCoEO1kM4NrZwtQwgISFWNYzT/28M5WqwOHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx+NWu8Dvxdj/gcEl+EQQae2nUimprfeNR7ZVcfj23IHA/xSBt+q2ZJIKtxfcCDq+e2+navFtNV9cepU0VxcJp+DRmDL6nFejCQZOFJIpItrlZsPx/1xV7QCFNzo8Uoc2WMwxohhcvcDHZ1fnsowf5lBu6Aa+2Mi8Jb+jKNgNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGYrpdMJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf5f4e82caso562813966b.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741107265; x=1741712065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIhVGSITLybLgTOxWrQha+46AWSDUUvcqlpePGEsi40=;
        b=lGYrpdMJ5rtwSF03km1gbmW+bnNF+C0UdlGUg3+/mBsR9b3O/nruwYvoeM5LWn+JHp
         ARYWAan4MlbSLKf3LRydhNV3tm+CBNHGPltpayqaba9L/HsedL9/RYOSLBXtn/jKdHMi
         DWOMKv17+cRN2vjZmAZ9us6AIR/jFppgtRUs8BmEi2TjQ/yOIFlGSijEE+yNWarC0Fsf
         Z3sJFezQA37OfE/DzQx+EhcQ3Lhs+73JZzOz/nuZAlPdMifYheadVDR5beb5TupMBG+b
         elLokywkF7K3ILpazARn9XHB67BySCR4J+yHEK+h5zRRs9B4smv6KuaZh7iUZaVKnqiK
         S2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107265; x=1741712065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIhVGSITLybLgTOxWrQha+46AWSDUUvcqlpePGEsi40=;
        b=cZqCr7UT8u/2PEa98dc99Ymxbiab6usgTfn666tbENl4oSPAY1WIs3m/5TtqtSbud/
         Qo92KVzOYv2xHpLw2qjoFJpAw3l5ItWwSRNk6pGTXI0L5sitySikDcbyx1/l6Zdray2H
         jgPJOX6c8uOv/dYRFuboUOfuCUDZuLkZxxCVfHkbmWLUquavNXTujbyOs1oSk78jPjue
         KBMQDlvbnyYBLAx/pEK4nsjADvMARlgK+qbJZ9pB6oZLxWypPu7qCMIDsIDMNyYs6x5d
         aXq3skO0SiwQ4e6LKjgkaKaEES0cGAmAuG9xHW72nv9BrLuaXpeX+gFHpkT5/B4gjZ0Q
         DMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzKDEim6itsEkvHRLdmbGtGW4YIli22ePqhwDapUwvCSl/QfgnD0o++r/eErjwoNHK8tBWLppXQlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oACQQNvgvL3yRzV2ImYNwEDJnzm5qK5gmITvZUlwz/bW4zGa
	no28Ub1kpye5xovp2noStCYah9/TlTUnXqq877CVahlzqmgfJynCIs4Wb3ffYBjYzKGkSj6btU/
	ehCDecL1OVRH4svUYNbxyYGIJ+2cxVXUO0YPn
X-Gm-Gg: ASbGnct5szLrZ9PpiBk60QUOcLFTgmU4KcmcefkBGt4jt3xZezzMJAe27nkUgmSfsIE
	T9paDnJlZBYTfi8S9SnkbNrMAipupOxe7JEs7LbrbBDFkzuokz24Ni7CMQIsGeLMmTalEUaFrXf
	jHuJfKPLmJ6Sahbe4LJxC5mmYN2Q==
X-Google-Smtp-Source: AGHT+IH4BsByHGIDhJT+4KAbhFRZ8zvGq1nUqTK6tr3SYbqdyi9SrpFq7jDMnOcDs1ZKLVQeco/+yCMLBmboQN1c06Y=
X-Received: by 2002:a17:906:6a28:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-abf749ffc45mr986308166b.7.1741107264954; Tue, 04 Mar 2025
 08:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 4 Mar 2025 08:54:13 -0800
X-Gm-Features: AQ5f1JoIzhSVC5xRyq6WAPULbDHdQj1sisohKcfFr1dTA3B31WBfv9mIH38fmYc
Message-ID: <CAAH4kHZS+wOrP-R22bnFRPY10jZw7swxmAsPXegpBjuVvJxe1Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] PCI/IDE: Report available IDE streams
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:20=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM
> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> attribute appears in PCI host bridge sysfs to convey that count.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  .../ABI/testing/sysfs-devices-pci-host-bridge      |   12 ++++
>  drivers/pci/ide.c                                  |   58 ++++++++++++++=
++++++
>  drivers/pci/pci.h                                  |    3 +
>  drivers/pci/probe.c                                |   12 ++++
>  include/linux/pci.h                                |    8 +++
>  5 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Do=
cumentation/ABI/testing/sysfs-devices-pci-host-bridge
> index 51dc9eed9353..4624469e56d4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -20,6 +20,7 @@ What:         pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
>  Date:          December, 2024
>  Contact:       linux-pci@vger.kernel.org
>  Description:
> +<<<<<<< current

Drop?

>                 (RO) When a platform has established a secure connection,=
 PCIe
>                 IDE, between two Partner Ports, this symlink appears. The
>                 primary function is to account the stream slot / resource=
s
> @@ -30,3 +31,14 @@ Description:
>                 assigned Selective IDE Stream Register Block in the Root =
Port
>                 and Endpoint, and H represents a platform specific pool o=
f
>                 stream resources shared by the Root Ports in a host bridg=
e.
> +
> +What:          pciDDDD:BB/available_secure_streams
> +Date:          December, 2024
> +Contact:       linux-pci@vger.kernel.org
> +Description:
> +               (RO) When a host bridge has Root Ports that support PCIe =
IDE
> +               (link encryption and integrity protection) there may be a
> +               limited number of streams that can be used for establishi=
ng new
> +               secure links. This attribute decrements upon secure link =
setup,
> +               and increments upon secure link teardown. The in-use stre=
am
> +               count is determined by counting stream symlinks.

Please describe the expected form metavariables DDDD and BB will take.

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index b2091f6260e6..0c72985e6a65 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -439,3 +439,61 @@ void pci_ide_stream_disable(struct pci_dev *pdev, st=
ruct pci_ide *ide)
>         pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> +
> +static ssize_t available_secure_streams_show(struct device *dev,
> +                                            struct device_attribute *att=
r,
> +                                            char *buf)
> +{
> +       struct pci_host_bridge *hb =3D to_pci_host_bridge(dev);
> +       int avail;
> +
> +       if (hb->nr_ide_streams < 0)
> +               return -ENXIO;
> +
> +       avail =3D hb->nr_ide_streams -
> +               bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
> +       return sysfs_emit(buf, "%d\n", avail);
> +}
> +static DEVICE_ATTR_RO(available_secure_streams);
> +
> +static struct attribute *pci_ide_attrs[] =3D {
> +       &dev_attr_available_secure_streams.attr,
> +       NULL,
> +};
> +
> +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribu=
te *a, int n)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct pci_host_bridge *hb =3D to_pci_host_bridge(dev);
> +
> +       if (a =3D=3D &dev_attr_available_secure_streams.attr)
> +               if (hb->nr_ide_streams < 0)
> +                       return 0;
> +
> +       return a->mode;
> +}
> +
> +struct attribute_group pci_ide_attr_group =3D {
> +       .attrs =3D pci_ide_attrs,
> +       .is_visible =3D pci_ide_attr_visible,
> +};
> +
> +/**
> + * pci_init_nr_ide_streams() - size the pool of IDE Stream resources

/size/sets the size of/

> + * @hb: host bridge boundary for the stream pool
> + * @nr: number of streams
> + *
> + * Enable IDE Stream establishment by setting the number of stream
> + * resources available at the host bridge. Platform init code must set
> + * this before the first pci_ide_stream_alloc() call.

Is failing to call this a caught error by pci_ide_stream_alloc?

> + *
> + * The "PCI_IDE" symbol namespace is required because this is typically
> + * a detail that is settled in early PCI init, i.e. only an expert or
> + * test module should consume this export.

Perhaps start with "Expert use only"?

> + */
> +void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
> +{
> +       hb->nr_ide_streams =3D nr;
> +       sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b38bdd91e742..6c050eb9a91b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -458,8 +458,11 @@ static inline void pci_npem_remove(struct pci_dev *d=
ev) { }
>
>  #ifdef CONFIG_PCI_IDE
>  void pci_ide_init(struct pci_dev *dev);
> +extern struct attribute_group pci_ide_attr_group;
> +#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
>  #else
>  static inline void pci_ide_init(struct pci_dev *dev) { }
> +#define PCI_IDE_ATTR_GROUP NULL
>  #endif
>
>  #ifdef CONFIG_PCI_TSM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e1c915629864..a383cc32c84b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -633,6 +633,16 @@ static void pci_release_host_bridge_dev(struct devic=
e *dev)
>         kfree(bridge);
>  }
>
> +static const struct attribute_group *pci_host_bridge_groups[] =3D {
> +       PCI_IDE_ATTR_GROUP,
> +       NULL,
> +};
> +
> +static const struct device_type pci_host_bridge_type =3D {
> +       .groups =3D pci_host_bridge_groups,
> +       .release =3D pci_release_host_bridge_dev,
> +};
> +
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
>         INIT_LIST_HEAD(&bridge->windows);
> @@ -652,6 +662,7 @@ static void pci_init_host_bridge(struct pci_host_brid=
ge *bridge)
>         bridge->native_dpc =3D 1;
>         bridge->domain_nr =3D PCI_DOMAIN_NR_NOT_SET;
>         bridge->native_cxl_error =3D 1;
> +       bridge->dev.type =3D &pci_host_bridge_type;
>
>         device_initialize(&bridge->dev);
>  }
> @@ -665,7 +676,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t =
priv)
>                 return NULL;
>
>         pci_init_host_bridge(bridge);
> -       bridge->dev.release =3D pci_release_host_bridge_dev;
>
>         return bridge;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0f9d6aece346..c2f18f31f7a7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -660,6 +660,14 @@ void pci_set_host_bridge_release(struct pci_host_bri=
dge *bridge,
>                                  void (*release_fn)(struct pci_host_bridg=
e *),
>                                  void *release_data);
>
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr);
> +#else
> +static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, i=
nt nr)
> +{
> +}
> +#endif
> +
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>
>  #define PCI_REGION_FLAG_MASK   0x0fU   /* These bits of resource flags t=
ell us the PCI region flags */
>
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)


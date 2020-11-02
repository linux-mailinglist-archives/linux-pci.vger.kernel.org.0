Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACD2A279E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgKBKAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBKAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:00:10 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34BC0617A6;
        Mon,  2 Nov 2020 02:00:10 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v4so13777865edi.0;
        Mon, 02 Nov 2020 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UY3MthU4udPkILXkEz8t2ilMTvX9TvJsbAavbFnp6Ao=;
        b=r22ZYdTzU5+2nQ0E50b34vkvAY4UnS/nL2T8R1+pjdZScjEbYtS62qW8sJwS/YtSNR
         tvpumXaIR3zpmEbniHClks8ueV/VCIPw9gVaarlScd1Aev/+tDsqG8hv+2zS3+7QiFyh
         fJ+6e7hifdoaya+HHVIai5CUrvZUhrh/1Lyi8QNMOsZexiEhHuvgtzplcqV5fjXfR5bS
         pxf6uf7IrZjZty69f6v7YGYBPInJAE2ay9DWs6ik3StECBBXqimqe3rOcN1azjGz7vIO
         AH48Y6+PpXbhBsbpslsh8c7eZ80Iq1g44E4XATmKmu57RsgbbpCSbBcK/Ro3C0evujmw
         Ei0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UY3MthU4udPkILXkEz8t2ilMTvX9TvJsbAavbFnp6Ao=;
        b=UdtVQCZAJe4xoKpUVRJl2ztjyKsPPnUgh3YCmD7hWzIklL3uxzV1o2uPd6Td77uPIX
         RPA89bHMXFVM0WeotzsLqtcuUqJLh1XbCrqNHBv9D7IiqQrAPKMUQtae5bAaBKa6oBLN
         l65UJ6foHzcW4ywOTWGklvy8Muqxjqz+Gdlfv4gDYNtU/x5SVN+XFOC2SNWkarvmWU+T
         qh3lmaYgCRLwIWOl6J5xvYf+k9sUGfZdyeVCqmkC6jOOecJFZNXwbwXroi+Gx9OIayPe
         KJHTr2IrXKleO64lSEGgftLKW5qTmHT9CPyN07b2cdyONsDk2YLL0oNt379ZxHnO3GQp
         G3eQ==
X-Gm-Message-State: AOAM532NicMky+RaHUEwnGcmPZM/V5bd/BmdapFpMHnygIfS0HlrY+ID
        FTB9BZ2z04WKwTq5EoZ7SaP6sE9eteUma4rz5u0=
X-Google-Smtp-Source: ABdhPJxsei8/kISPv99GBwFXu38kymaUPeEkIC97DvGJx8TQKw+vmABwtWO8rS8Ls9AxaoOi49ynrM4nNNSSNlDMhCI=
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr15105696edb.193.1604311208670;
 Mon, 02 Nov 2020 02:00:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2faef6f884aae9ae92e57e7c6a88a6195553c684.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh1J=_nxFTztyEjMBJav_W+JY60gzf27dvantMeKU+Aatg@mail.gmail.com> <ee679e38-dd8a-7d43-8715-a4e454664f89@linux.intel.com>
In-Reply-To: <ee679e38-dd8a-7d43-8715-a4e454664f89@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 2 Nov 2020 17:59:57 +0800
Message-ID: <CAKF3qh3ozCp7EsOA0X7kaKH2MGLHZWTAu0ZNTwhQiY6UD=M3Hg@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available()
 check in DPC enable logic
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current logic is
if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
    pci_aer_available() &&
    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
services |=3D PCIE_PORT_SERVICE_DPC;


if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
    pci_aer_available() &&
    (pcie_ports_dpc_native))
 services |=3D PCIE_PORT_SERVICE_DPC;

or

if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
    pci_aer_available() &&(services & PCIE_PORT_SERVICE_AER)=EF=BC=89
  services |=3D PCIE_PORT_SERVICE_DPC;

do you mean one of the possible is
if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
    (pcie_ports_dpc_native))
 services |=3D PCIE_PORT_SERVICE_DPC;

after your patch ? nothing about AER ?

Thanks,
Ethan

On Thu, Oct 29, 2020 at 1:14 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/27/20 11:00 PM, Ethan Zhao wrote:
> > On Tue, Oct 27, 2020 at 10:00 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> In DPC service enable logic, check for
> >> services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
> > How about PCIE_PORT_SERVICE_AER is not configured, but
> > pcie_aer_disable =3D=3D 0 =EF=BC=9F
> Its not possible in current code flow. DPC service is configured
> following AER service configuration.
> >> is true. So there is no need to explicitly check it again.
> >>
> >> Also, passing pcie_ports=3Ddpc-native in kernel command line
> >> implies DPC needs to be enabled in native mode irrespective
> >> of AER ownership status. So checking for pci_aer_available()
> >> without checking for pcie_ports status is incorrect.
> >>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@=
linux.intel.com>
> >> ---
> >>   drivers/pci/pcie/portdrv_core.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdr=
v_core.c
> >> index 2c0278f0fdcc..e257a2ca3595 100644
> >> --- a/drivers/pci/pcie/portdrv_core.c
> >> +++ b/drivers/pci/pcie/portdrv_core.c
> >> @@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_d=
ev *dev)
> >>           * permission to use AER.
> >>           */
> >>          if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> >> -           pci_aer_available() &&
> >>              (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
> >>                  services |=3D PCIE_PORT_SERVICE_DPC;
> >>
> >> --
> >> 2.17.1
> >>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA97E29D9C0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgJ1XCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389973AbgJ1XCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:02:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518BC0613CF;
        Wed, 28 Oct 2020 16:02:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so792135wrs.5;
        Wed, 28 Oct 2020 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U5GSIAp/KF0yhINCIVb4W15ZsipvOkrRvQ9Lx8wRI08=;
        b=jZLfqaHISKoEcgTfUc+mK9YZzM14Hhti6pzljX1gp/x9TlfL6+ZVLjaGik9W8gAlTS
         vSRQ7IJ1AcA1aQvX+YlggAPTSKOZWwsS0enHFEpmxe0h7IUBGrm8jlAICkF98AJ170gF
         TVxQJijAMDJ2gU56gMvBR/BgQOY9mrpVNOKt2HyeYilv4NZLabRN7QV/ptMWZl6mlTFP
         AqjtIjfKFH//nLy5WEHEOwRwDgbErVB6Lc+QB8bgpr1Fbcfale1vg3unCGt3svqAxSmg
         JuEsMPWaV3ct33m9xD7h9DIaQpwYRhQtLLfEEsbUpli0DgZAFMtGKIEi4pZRE77gnSXY
         GrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U5GSIAp/KF0yhINCIVb4W15ZsipvOkrRvQ9Lx8wRI08=;
        b=JsAqXsTRSML7fmhlvqiml5B5BiLLRtdHfX4OMgytWHJd0xsF5D04r033FgLELFuiwO
         KfhW0DWrQDmht0Ymgl1RHSvQNkwTTLT8g63rSX8IizybD6OHWRCsWtFSy0WcTJqCTNtR
         3WFyD9BIopwtUuOrySDGutGcwY5Mf+TF9Gxm1phHOn6qB5aV57mKgIKOz5nBw77LFz5B
         RxOI2pvBCFUFHuZCqf9ZAeJxMq+ppm7inuaBWCtcOkBG9sPtrZyqWiZlulROhxQHHnsW
         yXZqmXkQEuqy23elvdtT3vcduOt9GJ8mUTOdOtxlFvsrGzmBRV2xH3ldNRetgSPQUAJR
         0jNg==
X-Gm-Message-State: AOAM532SlhcNU5ne1nhbhbTXyZKOPklMlE4gT1G2jC7egNn8u5uSraix
        DFQQ3i1izYF+yQQ1ygsWBK4IKP39Li8feqzzBhTDOvnblxs=
X-Google-Smtp-Source: ABdhPJyQzkAAbFIB0JGWi9pzmeojf1A+N5Mp14xzNvdV3ntVJka40VMMTCotKKAg0eDoHzteHoAxQQs7/Xp8YbPXd+g=
X-Received: by 2002:a17:906:6dc6:: with SMTP id j6mr6277733ejt.354.1603864833350;
 Tue, 27 Oct 2020 23:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com> <2faef6f884aae9ae92e57e7c6a88a6195553c684.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2faef6f884aae9ae92e57e7c6a88a6195553c684.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 28 Oct 2020 14:00:21 +0800
Message-ID: <CAKF3qh1J=_nxFTztyEjMBJav_W+JY60gzf27dvantMeKU+Aatg@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available()
 check in DPC enable logic
To:     Kuppuswamy Sathyanarayanan 
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

On Tue, Oct 27, 2020 at 10:00 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In DPC service enable logic, check for
> services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
How about PCIE_PORT_SERVICE_AER is not configured, but
pcie_aer_disable =3D=3D 0 =EF=BC=9F
> is true. So there is no need to explicitly check it again.
>
> Also, passing pcie_ports=3Ddpc-native in kernel command line
> implies DPC needs to be enabled in native mode irrespective
> of AER ownership status. So checking for pci_aer_available()
> without checking for pcie_ports status is incorrect.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_c=
ore.c
> index 2c0278f0fdcc..e257a2ca3595 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_dev =
*dev)
>          * permission to use AER.
>          */
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -           pci_aer_available() &&
>             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>                 services |=3D PCIE_PORT_SERVICE_DPC;
>
> --
> 2.17.1
>

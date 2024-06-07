Return-Path: <linux-pci+bounces-8484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D37900D18
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055A4B2234D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F51514FF;
	Fri,  7 Jun 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3L4Kaov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1B79DC;
	Fri,  7 Jun 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792826; cv=none; b=IbpTk1JEAWSyEiJgrh24q449vriiNE+KW6EP4/I+/bVj/LFwBXUox7OD5pnEcaWN7wJKjYOJFXt0UOamtb0CTSvwa+1qxal6S+YN5a0g+ze6Yt9WD/eQDGLzVd5l4kP+MqA/RsqW3uUebHns6JIlxpNSmSI6sQ2O5PNNO4VqNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792826; c=relaxed/simple;
	bh=XeoWkt/dwGPkQzvcMCPV2Pd0GrlZ7gIO32Q8vbwjPtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AI7Wl7qggJFHDHiTguWYe7zwZB+LkkiBMfGVgLEmlmPwXWU27Vh7IgxkEXkSkqAjl/bgb9eGIujSpJ5YJWDgfrwnVslJ+C3v0PvyAqUsW8yOnMsV3c3hCZhwahKduKBwiD2ywPYB0SSg5UNDc/nCNk7A66C6bHuXG9RuwBHdN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3L4Kaov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE656C2BBFC;
	Fri,  7 Jun 2024 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792826;
	bh=XeoWkt/dwGPkQzvcMCPV2Pd0GrlZ7gIO32Q8vbwjPtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d3L4Kaovye0xni8XzhgkFqY01ECG48vvZcbRboOMV1xYm0T4U43xLcKGFDlZesRc6
	 nDg/5wJJkR/WLz0N3yFTBUIgrJ6gewwxkXFYg9lgpbkmkO8tsod0DUsvZ2H7TxvF5H
	 ZpQ+BjtXALNeMXazMELnCB+I6G+hZrfnIW2xp2LtvQbzEl6QExBlQCKMRS7yw8C89V
	 h2XCr2Ez0wpw3+cDgQ6G9eVosjyWSPyftSK08A+iEeIRODEdAqhm5bTI1yhhpVSa34
	 6y3GY3ZK4ZpC3dAa0vJlElPGWMHilED0wxRZ1V65e7mY0pYhKVPoPYRV2TRnXZ9VsF
	 oenyZiWuUB0ig==
Date: Fri, 7 Jun 2024 15:40:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: "Chang, HaiJun" <HaiJun.Chang@amd.com>,
	"Shi, Lianjie" <Lianjie.Shi@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>,
	"Zhang, Andy" <Andy.Zhang@amd.com>
Subject: Re: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Message-ID: <20240607204024.GA859719@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <432d2df8-3686-4f87-af1a-a9a172d662b9@amd.com>

On Fri, Jun 07, 2024 at 01:37:21PM +0200, Christian König wrote:
> I need the original set of patches, e.g. directly use git send-email with my
> mail address.

This worked for me:

  $ git checkout -b wip/2406-lianjie-vf-rebar-v2 v6.10-rc1
  $ b4 am https://lore.kernel.org/r/20240523071114.2930804-2-Lianjie.Shi@amd.com
  $ git am ./v2_20240523_lianjie_shi_pci_vf_resizable_bar.mbx

> Am 07.06.24 um 10:42 schrieb Chang, HaiJun:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> > 
> > + Christian to review the VF resizable BAR patch.
> > 
> > -----Original Message-----
> > From: Chang, HaiJun
> > Sent: Friday, May 31, 2024 12:26 PM
> > To: Lianjie Shi <Lianjie.Shi@amd.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com>
> > Subject: RE: [PATCH 1/1][v2] PCI: Support VF resizable BAR
> > 
> > Hi, Bjorn and pci driver maintainers
> > 
> > Could you review the VF resizable BAR patch?
> > 
> > Thanks,
> > HaiJun
> > 
> > -----Original Message-----
> > From: Lianjie Shi <Lianjie.Shi@amd.com>
> > Sent: Thursday, May 23, 2024 3:11 PM
> > To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com>
> > Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR
> > 
> > Add support for VF resizable BAR PCI extended cap.
> > Similar to regular BAR, drivers can use pci_resize_resource() to resize an IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is resized, but the total resource size of the IOV resource should not exceed its original size upon init.
> > 
> > Based on following patch series:
> > Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/
> > 
> > Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
> > ---
> >   drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
> >   drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
> >   include/uapi/linux/pci_regs.h |  1 +
> >   3 files changed, 85 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index e5f243dd4..12f86e00a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
> >          }
> >   }
> > 
> > +static void pci_restore_vf_rebar_state(struct pci_dev *pdev) { #ifdef
> > +CONFIG_PCI_IOV
> > +       unsigned int pos, nbars, i;
> > +       u32 ctrl;
> > +       u16 total;
> > +
> > +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
> > +       if (!pos)
> > +               return;
> > +
> > +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> > +       nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
> > +
> > +       for (i = 0; i < nbars; i++, pos += 8) {
> > +               struct resource *res;
> > +               int bar_idx, size;
> > +               u64 tmp;
> > +
> > +               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> > +               bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> > +               total = pdev->sriov->total_VFs;
> > +               if (!total)
> > +                       return;
> > +
> > +               res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
> > +               tmp = resource_size(res);
> > +               do_div(tmp, total);
> > +               size = pci_rebar_bytes_to_size(tmp);
> > +               ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> > +               ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
> > +               pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> > +       }
> > +#endif
> > +}
> > +
> >   /**
> >    * pci_restore_state - Restore the saved state of a PCI device
> >    * @dev: PCI device that we're dealing with @@ -1882,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
> >          pci_restore_ats_state(dev);
> >          pci_restore_vc_state(dev);
> >          pci_restore_rebar_state(dev);
> > +       pci_restore_vf_rebar_state(dev);
> >          pci_restore_dpc_state(dev);
> >          pci_restore_ptm_state(dev);
> > 
> > @@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
> >    */
> >   static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)  {
> > +       int cap = PCI_EXT_CAP_ID_REBAR;
> >          unsigned int pos, nbars, i;
> >          u32 ctrl;
> > 
> > -       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> > +#ifdef CONFIG_PCI_IOV
> > +       if (bar >= PCI_IOV_RESOURCES) {
> > +               cap = PCI_EXT_CAP_ID_VF_REBAR;
> > +               bar -= PCI_IOV_RESOURCES;
> > +       }
> > +#endif
> > +
> > +       pos = pci_find_ext_capability(pdev, cap);
> >          if (!pos)
> >                  return -ENOTSUPP;
> > 
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c index c6d933ddf..d978a2ccf 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int resno)  }  EXPORT_SYMBOL(pci_release_resource);
> > 
> > +static int pci_memory_decoding(struct pci_dev *dev, int resno) {
> > +       u16 cmd;
> > +
> > +#ifdef CONFIG_PCI_IOV
> > +       if (resno >= PCI_IOV_RESOURCES) {
> > +               pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
> > +               if (cmd & PCI_SRIOV_CTRL_MSE)
> > +                       return -EBUSY;
> > +               else
> > +                       return 0;
> > +       }
> > +#endif
> > +       pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +       if (cmd & PCI_COMMAND_MEMORY)
> > +               return -EBUSY;
> > +
> > +       return 0;
> > +}
> > +
> >   int pci_resize_resource(struct pci_dev *dev, int resno, int size)  {
> >          struct resource *res = dev->resource + resno;
> >          struct pci_host_bridge *host;
> >          int old, ret;
> >          u32 sizes;
> > -       u16 cmd;
> > 
> >          /* Check if we must preserve the firmware's resource assignment */
> >          host = pci_find_host_bridge(dev->bus); @@ -444,9 +463,9 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> >          if (!(res->flags & IORESOURCE_UNSET))
> >                  return -EBUSY;
> > 
> > -       pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > -       if (cmd & PCI_COMMAND_MEMORY)
> > -               return -EBUSY;
> > +       ret = pci_memory_decoding(dev, resno);
> > +       if (ret)
> > +               return ret;
> > 
> >          sizes = pci_rebar_get_possible_sizes(dev, resno);
> >          if (!sizes)
> > @@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> >          if (ret)
> >                  return ret;
> > 
> > -       res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
> > +#ifdef CONFIG_PCI_IOV
> > +       if (resno >= PCI_IOV_RESOURCES)
> > +               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
> > +       else
> > +#endif
> > +               res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
> > 
> >          /* Check if the new config works by trying to assign everything. */
> >          if (dev->bus->self) {
> >                  ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> > -               if (ret)
> > +               if (ret && ret != -ENOENT)
> >                          goto error_resize;
> >          }
> >          return 0;
> > 
> >   error_resize:
> >          pci_rebar_set_size(dev, resno, old);
> > -       res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
> > +
> > +#ifdef CONFIG_PCI_IOV
> > +       if (resno >= PCI_IOV_RESOURCES)
> > +               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
> > +       else
> > +#endif
> > +               res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
> > +
> >          return ret;
> >   }
> >   EXPORT_SYMBOL(pci_resize_resource);
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h index a39193213..a66b90982 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -738,6 +738,7 @@
> >   #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
> >   #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
> >   #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
> > +#define PCI_EXT_CAP_ID_VF_REBAR        0x24    /* VF Resizable BAR */
> >   #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
> >   #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
> >   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> > --
> > 2.34.1
> > 
> 


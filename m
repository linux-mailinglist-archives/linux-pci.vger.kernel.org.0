Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652E292606
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgJSKtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgJSKtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:49:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A9C0613CE;
        Mon, 19 Oct 2020 03:49:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z5so7410169ejw.7;
        Mon, 19 Oct 2020 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPW2LNyeKFvIQH84bFwBzSg7A+5XzqRmLomDH/oRFCI=;
        b=vPVINmcsW30aqhQX711zuDF8jAZrTsoLPDffXiDb/5K1yGysVXGdn9hoXx4QjsF12T
         HGM589ryl5x+MK7QBGSM1YQL2XPaxQHu4vCbulL166lOJ5orUGfIIBEiokwgIHHivSgF
         HiStMWOpZvC0VACOCRPNOs6Jo03aJTIoQ3Gk0UGvj1h880K2BnDS8wCpuX9Id22MHv5W
         aklxDw1o5L8RY0dKtW7BHpQDM3g28ctWu6l+b0aVhAj9vkDb+10RKgjv84F/4TUCwAcO
         CPg2nCklg8vqVOykvIqp6xuWZqR4xa/Im0fh1rvaH46SXq9Z7OhL7aLjdaPeuMiKeZhu
         DyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPW2LNyeKFvIQH84bFwBzSg7A+5XzqRmLomDH/oRFCI=;
        b=FyaBGEG4J6AOgZgJv1CL07Vn2am0ITpI5FiuRRLzpnVl4R928MVP9+5wafdbVksAFA
         H3NU5AtfuewOfLbcUrGWUaiBcACZ1cflYGR1qJhToH76OjfyswxeXfipzomlcHDl/tKF
         PY5gAQqplLTLM/1lYVr5y4Sk0cp4A8x444kTinotg4L+KwDUt9nqaTtvKKDypgK+/Wy7
         b/ftxwwBIWlxXM+ulo4YkeFTt5qKenPz64RXxy1Hh7s/+tJzY+WWJmwkXTF4J21uyriY
         1i1yVBlNqVnvTJgf/PktrU548x+/OlyubUWgWIWNSZrkkm9c8X/SQbf+rT1RY9lW2eEd
         AQaw==
X-Gm-Message-State: AOAM530k5gR1azoiMZqGJtRAIxA/YTsEzivt+tKc5HszIi3OM3f+yDWu
        r3JhA7fbZrz/TZUvHd100t3aJT8Jfct4vA4GMMw=
X-Google-Smtp-Source: ABdhPJzs/QwXM+6qyB3xZVQRXvPxlcUbyhL01xDLyKXBL+4ZR7AXMcbaFXrrPKGhm4beq99nfiX6KbA9oYT4ug5v9oA=
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr16477255ejm.344.1603104584159;
 Mon, 19 Oct 2020 03:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201016203037.GA90074@bjorn-Precision-5520> <20201016222902.GA112659@bjorn-Precision-5520>
In-Reply-To: <20201016222902.GA112659@bjorn-Precision-5520>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 19 Oct 2020 18:49:32 +0800
Message-ID: <CAKF3qh3NDvQAwb922faHgja+YoDydCtg5sugEQ8T2ti+3WSn5Q@mail.gmail.com>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sean V Kelley <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com, Bjorn Helgaas <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, Ashok Raj <ashok.raj@intel.com>,
        tony.luck@intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        qiuxu.zhuo@intel.com, linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sinan Kaya <okaya@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 17, 2020 at 6:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph, Ethan, Sinan, Keith; sorry should have cc'd you to
> begin with since you're looking at this code too.  Particularly
> interested in your thoughts about whether we should be touching
> PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS when we don't own AER.]

aer_root_reset() function has a prefix  'aer_', looks like it's a
function of aer driver, will
only be called by aer driver at runtime. if so it's up to the
owner/aer to know if OSPM is
granted to init. while actually some of the functions and runtime service of
aer driver is also shared by GHES driver (running time) and DPC driver
(compiling time ?)
etc. then it is confused now.

Shall we move some of the shared functions and running time service to
pci/err.c ?
if so , just like pcie_do_recovery(), it's share by firmware_first  mode GHES
ghes_probe()
->ghes_irq_func
  ->ghes_proc
    ->ghes_do_proc()
      ->ghes_handle_aer()
        ->aer_recover_work_func()
          ->pcie_do_recovery()
            ->aer_root_reset()

and aer driver etc.  if aer wants to do some access might conflict
with firmware(or
firmware in embedded controller) should check _OSC_ etc first.  blindly issue
PCI_ERR_ROOT_COMMAND  or clear PCI_ERR_ROOT_STATUS *likely*
cause errors by error handling itself.

Thanks,
Ethan

>
> On Fri, Oct 16, 2020 at 03:30:37PM -0500, Bjorn Helgaas wrote:
> > [+to Jonathan]
> >
> > On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
> > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > >
> > > When attempting error recovery for an RCiEP associated with an RCEC device,
> > > there needs to be a way to update the Root Error Status, the Uncorrectable
> > > Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
> > > some non-native cases in which there is no OS-visible device associated
> > > with the RCiEP, there is nothing to act upon as the firmware is acting
> > > before the OS.
> > >
> > > Add handling for the linked RCEC in AER/ERR while taking into account
> > > non-native cases.
> > >
> > > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> > > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++------------
> > >  drivers/pci/pcie/err.c | 20 ++++++++--------
> > >  2 files changed, 48 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 65dff5f3457a..083f69b67bfd 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device *dev)
> > >   */
> > >  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> > >  {
> > > -   int aer = dev->aer_cap;
> > > +   int type = pci_pcie_type(dev);
> > > +   struct pci_dev *root;
> > > +   int aer = 0;
> > > +   int rc = 0;
> > >     u32 reg32;
> > > -   int rc;
> > >
> > > +   if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> >
> > "type == PCI_EXP_TYPE_RC_END"
> >
> > > +           /*
> > > +            * The reset should only clear the Root Error Status
> > > +            * of the RCEC. Only perform this for the
> > > +            * native case, i.e., an RCEC is present.
> > > +            */
> > > +           root = dev->rcec;
> > > +   else
> > > +           root = dev;
> > >
> > > -   /* Disable Root's interrupt in response to error messages */
> > > -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > > -   reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > > -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > > +   if (root)
> > > +           aer = dev->aer_cap;
> > >
> > > -   rc = pci_bus_error_reset(dev);
> > > -   pci_info(dev, "Root Port link has been reset\n");
> > > +   if (aer) {
> > > +           /* Disable Root's interrupt in response to error messages */
> > > +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > > +           reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > > +           pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >
> > Not directly related to *this* patch, but my assumption was that in
> > the APEI case, the firmware should retain ownership of the AER
> > Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
> > PCI_ERR_ROOT_STATUS.
> >
> > But this code appears to ignore that ownership.  Jonathan, you must
> > have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear PCIe
> > Device Status errors only if OS owns AER").  Do you have any insight
> > about this?
> >
> > > -   /* Clear Root Error Status */
> > > -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > > -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> > > +           /* Clear Root Error Status */
> > > +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > > +           pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
> > >
> > > -   /* Enable Root Port's interrupt in response to error messages */
> > > -   pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > > -   reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > > -   pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > > +           /* Enable Root Port's interrupt in response to error messages */
> > > +           pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > > +           reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > > +           pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > > +   }
> > > +
> > > +   if ((type == PCI_EXP_TYPE_RC_EC) || (type == PCI_EXP_TYPE_RC_END)) {
> > > +           if (pcie_has_flr(root)) {
> > > +                   rc = pcie_flr(root);
> > > +                   pci_info(dev, "has been reset (%d)\n", rc);
> > > +           }
> > > +   } else {
> > > +           rc = pci_bus_error_reset(root);
> >
> > Don't we want "dev" for both the FLR and pci_bus_error_reset()?  I
> > think "root == dev" except when dev is an RCiEP.  When dev is an
> > RCiEP, "root" is the RCEC (if present), and we want to reset the
> > RCiEP, not the RCEC.
> >
> > > +           pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> > > +   }
> >
> > There are a couple changes here that I think should be split out.
> >
> > Based on my theory that when firmware retains control of AER, the OS
> > should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and any
> > updates to them would have to be done by firmware before we get here,
> > I suggested reordering this:
> >
> >   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - do reset
> >   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by firmware?)
> >   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >
> > to this:
> >
> >   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - clear PCI_ERR_ROOT_STATUS
> >   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - do reset
> >
> > If my theory is correct, I think we should still reorder this, but:
> >
> >   - It's a significant behavior change that deserves its own patch so
> >     we can document/bisect/revert.
> >
> >   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error reporting
> >     bits.  In the new "clear COMMAND, clear STATUS, enable COMMAND"
> >     order, it looks superfluous.  There's no reason to disable error
> >     reporting while clearing the status bits.
> >
> >     The current "clear, reset, enable" order suggests that the reset
> >     might cause errors that we should ignore.  I don't know whether
> >     that's the case or not.  It dates from 6c2b374d7485 ("PCI-Express
> >     AER implemetation: AER core and aerdriver"), which doesn't
> >     elaborate.
> >
> >   - Should we also test for OS ownership of AER before touching
> >     PCI_ERR_ROOT_STATUS?
> >
> >   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I tentatively
> >     think we *should* unless we can justify it), that would also
> >     deserve its own patch.  Possibly (1) remove PCI_ERR_ROOT_COMMAND
> >     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and reset, (3)
> >     test for OS ownership of AER (?), (4) the rest of this patch.
> >
> > >     return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> > >  }
> > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > index 7883c9791562..cbc5abfe767b 100644
> > > --- a/drivers/pci/pcie/err.c
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, void *data)
> > >
> > >  /**
> > >   * pci_walk_bridge - walk bridges potentially AER affected
> > > - * @bridge:        bridge which may be a Port, an RCEC with associated RCiEPs,
> > > - *         or an RCiEP associated with an RCEC
> > > - * @cb:            callback to be called for each device found
> > > - * @userdata:      arbitrary pointer to be passed to callback
> > > + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> > > + *           or a Port.
> > > + * @cb       callback to be called for each device found
> > > + * @userdata arbitrary pointer to be passed to callback.
> > >   *
> > >   * If the device provided is a bridge, walk the subordinate bus, including
> > >   * any bridged devices on buses under this bus.  Call the provided callback
> > > @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
> > >                         int (*cb)(struct pci_dev *, void *),
> > >                         void *userdata)
> > >  {
> > > +   /*
> > > +    * In a non-native case where there is no OS-visible reporting
> > > +    * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
> > > +    */
> > >     if (bridge->subordinate)
> > >             pci_walk_bus(bridge->subordinate, cb, userdata);
> > > +   else if (bridge->rcec)
> > > +           cb(bridge->rcec, userdata);
> > >     else
> > >             cb(bridge, userdata);
> > >  }
> > > @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > >     pci_dbg(bridge, "broadcast error_detected message\n");
> > >     if (state == pci_channel_io_frozen) {
> > >             pci_walk_bridge(bridge, report_frozen_detected, &status);
> > > -           if (type == PCI_EXP_TYPE_RC_END) {
> > > -                   pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> > > -                   status = PCI_ERS_RESULT_NONE;
> > > -                   goto failed;
> > > -           }
> > > -
> > >             status = reset_subordinates(bridge);
> > >             if (status != PCI_ERS_RESULT_RECOVERED) {
> > >                     pci_warn(bridge, "subordinate device reset failed\n");
> > > --
> > > 2.28.0
> > >

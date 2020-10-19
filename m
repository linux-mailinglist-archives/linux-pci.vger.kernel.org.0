Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71A292E2C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgJSTHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgJSTHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 15:07:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9BC0613D0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 12:07:38 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so1413469ilr.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EODbzBqvZ3JQfblf9G39FGjrqEVSwZRSjrYsgvjrzUQ=;
        b=SZ3ZySHlJ9JDmFLX2GEbEgPzmOPCnf7DqdfL5KQkNPmRfyi5G9nfTkFz1PPgNuznq1
         ual6HbPNnUMOAboAcZEwv7PGWuYmJl4DtJt6H7ojt7E3AbyGYsRTcWqXFalJVSuoqCi5
         QO5kNbVTLnaLAw9pvgijBQMxg3Puf8GSIqMcTjA/72aqrF8xeNLtoTX6WAMNj1KQaplB
         h7TwfVcuVSvT1FVZF7PPz/c0tAiDi14kqbipsWRJzCMSF7E3vasb9UO7nn26/JsEbxDx
         j3Af5CVCutHndErnKM7pd9ZqImdl1x2LTls5Xt/vBKf9BpyHI54n/YhQ6d+oLdo3wpAP
         9lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EODbzBqvZ3JQfblf9G39FGjrqEVSwZRSjrYsgvjrzUQ=;
        b=lJHlT6n4/IB0fg2usM1jaPfBJ44ExHRTNYNpSn9IPTaEIiN7JqrxLbMfZppoyhkiwK
         Hr8f0n/Fhtf62vdaF1sAtrCBFLnXZAxuVDc9JjtnvlILm6wWD1NfNL3VXbzFjG1XdHeT
         b94w44f6puBOPxKQqakWponh6Qm+DVqoD6ws02Nx5o6TniQlWqi0iHabJItrwjhxfiZ8
         sAZpWvm9rkcVutwh/3svCJSPG6eP7bbWCNXsb1utEMcfIwa8OkbwUth756icd1Kqqjo9
         S1kIP9aP9M7YKfUO98WHZYXsIseZSk36zjQ1OR97u6ArYOIpg9zjgBD5l0I+wqJzc5n7
         aFlw==
X-Gm-Message-State: AOAM531uXd0Akz6czG+Fwtju4/DnwACUwo6+WnWSpYgC9qevNHJVymw0
        3N6hBTXLgbW4Nlsn3CaYRtW7YA==
X-Google-Smtp-Source: ABdhPJzHMlL/Tru7iQB3WfKrubQxYyzSjM7KTFZFxJ6GvySZgtGKvZW/upVPsnG49Ol21Vb7AJT7Iw==
X-Received: by 2002:a05:6e02:926:: with SMTP id o6mr1278213ilt.287.1603134458179;
        Mon, 19 Oct 2020 12:07:38 -0700 (PDT)
Received: from ?IPv6:2601:1c0:6a00:1804:88d3:6720:250a:6d10? ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id 196sm728657ilc.26.2020.10.19.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:07:37 -0700 (PDT)
Message-ID: <2a17b09d435a30f18ae7f3ed86d4fc499c89f651.camel@intel.com>
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sean V Kelley <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Oct 2020 12:07:28 -0700
In-Reply-To: <2219B080-CB26-4FE3-96BD-6C489BAAEE8C@intel.com>
References: <20201016203037.GA90074@bjorn-Precision-5520>
         <2219B080-CB26-4FE3-96BD-6C489BAAEE8C@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2020-10-17 at 09:14 -0700, Sean V Kelley wrote:
> On 16 Oct 2020, at 13:30, Bjorn Helgaas wrote:
> 
> > [+to Jonathan]
> > 
> > On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
> > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > 
> > > When attempting error recovery for an RCiEP associated with an
> > > RCEC 
> > > device,
> > > there needs to be a way to update the Root Error Status, the 
> > > Uncorrectable
> > > Error Status and the Uncorrectable Error Severity of the parent
> > > RCEC. 
> > >  In
> > > some non-native cases in which there is no OS-visible device 
> > > associated
> > > with the RCiEP, there is nothing to act upon as the firmware is 
> > > acting
> > > before the OS.
> > > 
> > > Add handling for the linked RCEC in AER/ERR while taking into
> > > account
> > > non-native cases.
> > > 
> > > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > Link: 
> > > https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
> > > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/pci/pcie/aer.c | 53 
> > > ++++++++++++++++++++++++++++++------------
> > >  drivers/pci/pcie/err.c | 20 ++++++++--------
> > >  2 files changed, 48 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 65dff5f3457a..083f69b67bfd 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device
> > > *dev)
> > >   */
> > >  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> > >  {
> > > -       int aer = dev->aer_cap;
> > > +       int type = pci_pcie_type(dev);
> > > +       struct pci_dev *root;
> > > +       int aer = 0;
> > > +       int rc = 0;
> > >         u32 reg32;
> > > -       int rc;
> > > 
> > > +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> > 
> > "type == PCI_EXP_TYPE_RC_END"
> 
> Right, I merged your suggested changes which added the type. Will 
> correct.
> 
> > 
> > > +               /*
> > > +                * The reset should only clear the Root Error
> > > Status
> > > +                * of the RCEC. Only perform this for the
> > > +                * native case, i.e., an RCEC is present.
> > > +                */
> > > +               root = dev->rcec;
> > > +       else
> > > +               root = dev;
> > > 
> > > -       /* Disable Root's interrupt in response to error messages
> > > */
> > > -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND,
> > > &reg32);
> > > -       reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > > -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND,
> > > reg32);
> > > +       if (root)
> > > +               aer = dev->aer_cap;
> > > 
> > > -       rc = pci_bus_error_reset(dev);
> > > -       pci_info(dev, "Root Port link has been reset\n");
> > > +       if (aer) {
> > > +               /* Disable Root's interrupt in response to error
> > > messages */
> > > +               pci_read_config_dword(root, aer +
> > > PCI_ERR_ROOT_COMMAND, &reg32);
> > > +               reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> > > +               pci_write_config_dword(root, aer +
> > > PCI_ERR_ROOT_COMMAND, reg32);
> > 
> > Not directly related to *this* patch, but my assumption was that in
> > the APEI case, the firmware should retain ownership of the AER
> > Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
> > PCI_ERR_ROOT_STATUS.
> > 
> > But this code appears to ignore that ownership.  Jonathan, you must
> > have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear PCIe
> > Device Status errors only if OS owns AER").  Do you have any
> > insight
> > about this?
> > 
> > > -       /* Clear Root Error Status */
> > > -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS,
> > > &reg32);
> > > -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS,
> > > reg32);
> > > +               /* Clear Root Error Status */
> > > +               pci_read_config_dword(root, aer +
> > > PCI_ERR_ROOT_STATUS, &reg32);
> > > +               pci_write_config_dword(root, aer +
> > > PCI_ERR_ROOT_STATUS, reg32);
> > > 
> > > -       /* Enable Root Port's interrupt in response to error
> > > messages */
> > > -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND,
> > > &reg32);
> > > -       reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > > -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND,
> > > reg32);
> > > +               /* Enable Root Port's interrupt in response to
> > > error messages */
> > > +               pci_read_config_dword(root, aer +
> > > PCI_ERR_ROOT_COMMAND, &reg32);
> > > +               reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > > +               pci_write_config_dword(root, aer +
> > > PCI_ERR_ROOT_COMMAND, reg32);
> > > +       }
> > > +
> > > +       if ((type == PCI_EXP_TYPE_RC_EC) || (type ==
> > > PCI_EXP_TYPE_RC_END)) 
> > > {
> > > +               if (pcie_has_flr(root)) {
> > > +                       rc = pcie_flr(root);
> > > +                       pci_info(dev, "has been reset (%d)\n",
> > > rc);
> > > +               }
> > > +       } else {
> > > +               rc = pci_bus_error_reset(root);
> > 
> > Don't we want "dev" for both the FLR and pci_bus_error_reset()?  I
> > think "root == dev" except when dev is an RCiEP.  When dev is an
> > RCiEP, "root" is the RCEC (if present), and we want to reset the
> > RCiEP, not the RCEC.
> 
> Right, when I did the goto in the earlier incarnation, I always set
> root 
> to dev at the start and in the merge it needs to be dev always except
> for the RC_END where RCEC exists. Will change without bringing back
> the 
> goto…
> 
> +       struct pci_dev *root = dev;
> 
> …
> 
> +non_native:
> +       if ((type == PCI_EXP_TYPE_RC_EC) || (type ==
> PCI_EXP_TYPE_RC_END)) {
> +               rc = flr_on_rc(root);
> +               pci_info(dev, "has been reset (%d)\n", rc);
> +       } else {
> +               rc = pci_bus_error_reset(root);
> +               pci_info(dev, "Root Port link has been reset (%d)\n",
> rc);
> +       }
> 
> 
> > 
> > > +               pci_info(dev, "Root Port link has been reset
> > > (%d)\n", rc);
> > > +       }
> > 
> > There are a couple changes here that I think should be split out.
> > 
> > Based on my theory that when firmware retains control of AER, the
> > OS
> > should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and
> > any
> > updates to them would have to be done by firmware before we get
> > here,
> > I suggested reordering this:
> > 
> >   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - do reset
> >   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by
> > firmware?)
> >   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> > 
> > to this:
> > 
> >   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - clear PCI_ERR_ROOT_STATUS
> >   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> >   - do reset
> > 
> > If my theory is correct, I think we should still reorder this, but:
> > 
> >   - It's a significant behavior change that deserves its own patch
> > so
> >     we can document/bisect/revert.
> > 
> >   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error
> > reporting
> >     bits.  In the new "clear COMMAND, clear STATUS, enable COMMAND"
> >     order, it looks superfluous.  There's no reason to disable
> > error
> >     reporting while clearing the status bits.
> > 
> >     The current "clear, reset, enable" order suggests that the
> > reset
> >     might cause errors that we should ignore.  I don't know whether
> >     that's the case or not.  It dates from 6c2b374d7485 ("PCI-
> > Express
> >     AER implemetation: AER core and aerdriver"), which doesn't
> >     elaborate.
> > 
> >   - Should we also test for OS ownership of AER before touching
> >     PCI_ERR_ROOT_STATUS?
> > 
> >   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I
> > tentatively
> >     think we *should* unless we can justify it), that would also
> >     deserve its own patch.  Possibly (1) remove
> > PCI_ERR_ROOT_COMMAND
> >     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and reset,
> > (3)
> >     test for OS ownership of AER (?), (4) the rest of this patch.
> 
> You’ve highlighted some good questions.



Reading Ethan's reply and also thinking about separation from an _OSC
perspective perhaps something like this could be done with a check in
aer_root_reset().


diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..70bf637042ff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1357,27 +1357,46 @@ static int aer_probe(struct pcie_device *dev)
  */
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
+       int type = pci_pcie_type(dev);
+       struct pci_dev *root = dev;
        int aer = dev->aer_cap;
+       int rc = 0;
        u32 reg32;
-       int rc;
 
+       if (!pcie_aer_is_native(dev))
+               return PCI_ERS_RESULT_RECOVERD;
+
+       if (type == PCI_EXP_TYPE_RC_END)
+               /*
+                * The reset should only clear the Root Error Status
+                * of the RCEC. Only perform this for the
+                * native case, i.e., an RCEC is present.
+                */
+               root = dev->rcec;
 
        /* Disable Root's interrupt in response to error messages */
-       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+       pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND,
&reg32);
        reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
-
-       rc = pci_bus_error_reset(dev);
-       pci_info(dev, "Root Port link has been reset\n");
+       pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND,
reg32);
 
        /* Clear Root Error Status */
-       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+       pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
+       pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
 
        /* Enable Root Port's interrupt in response to error messages
*/
-       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+       pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND,
&reg32);
        reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+       pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND,
reg32);
+
+       if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END)
{
+               if (pcie_has_flr(dev)) {
+                       rc = pcie_flr(dev);
+                       pci_info(dev, "has been reset (%d)\n", rc);
+               }
+       } else {
+               rc = pci_bus_error_reset(dev);
+               pci_info(dev, "Root Port link has been reset (%d)\n",
rc);
+       }


> 
> I think we should remove the fiddling until we have a clearer picture
> and put that into its own patch.
> 
> Sean
> > 
> > >         return rc ? PCI_ERS_RESULT_DISCONNECT :
> > > PCI_ERS_RESULT_RECOVERED;
> > >  }
> > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > index 7883c9791562..cbc5abfe767b 100644
> > > --- a/drivers/pci/pcie/err.c
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev
> > > *dev, 
> > > void *data)
> > > 
> > >  /**
> > >   * pci_walk_bridge - walk bridges potentially AER affected
> > > - * @bridge:    bridge which may be a Port, an RCEC with
> > > associated 
> > > RCiEPs,
> > > - *             or an RCiEP associated with an RCEC
> > > - * @cb:                callback to be called for each device
> > > found
> > > - * @userdata:  arbitrary pointer to be passed to callback
> > > + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> > > + *           or a Port.
> > > + * @cb       callback to be called for each device found
> > > + * @userdata arbitrary pointer to be passed to callback.
> > >   *
> > >   * If the device provided is a bridge, walk the subordinate bus,
> > > including
> > >   * any bridged devices on buses under this bus.  Call the
> > > provided 
> > > callback
> > > @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev 
> > > *bridge,
> > >                             int (*cb)(struct pci_dev *, void *),
> > >                             void *userdata)
> > >  {
> > > +       /*
> > > +        * In a non-native case where there is no OS-visible
> > > reporting
> > > +        * device the bridge will be NULL, i.e., no RCEC, no
> > > Downstream 
> > > Port.
> > > +        */
> > >         if (bridge->subordinate)
> > >                 pci_walk_bus(bridge->subordinate, cb, userdata);
> > > +       else if (bridge->rcec)
> > > +               cb(bridge->rcec, userdata);
> > >         else
> > >                 cb(bridge, userdata);
> > >  }
> > > @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct
> > > pci_dev 
> > > *dev,
> > >         pci_dbg(bridge, "broadcast error_detected message\n");
> > >         if (state == pci_channel_io_frozen) {
> > >                 pci_walk_bridge(bridge, report_frozen_detected,
> > > &status);
> > > -               if (type == PCI_EXP_TYPE_RC_END) {
> > > -                       pci_warn(dev, "subordinate device reset
> > > not possible for 
> > > RCiEP\n");
> > > -                       status = PCI_ERS_RESULT_NONE;
> > > -                       goto failed;
> > > -               }
> > > -
> > >                 status = reset_subordinates(bridge);
> > >                 if (status != PCI_ERS_RESULT_RECOVERED) {
> > >                         pci_warn(bridge, "subordinate device
> > > reset failed\n");
> > > -- 
> > > 2.28.0
> > > 



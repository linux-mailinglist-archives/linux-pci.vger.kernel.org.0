Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18918274F44
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 04:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIWCuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 22:50:39 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50247 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIWCui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 22:50:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 681DF12F9;
        Tue, 22 Sep 2020 22:50:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 22:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=mime-version:references:in-reply-to:from
        :date:message-id:subject:to:cc:content-type; s=fm1; bh=e92UQEbaa
        Z1irkk3PyBEoudpVOSpwDA/OJ6HpXpvBCA=; b=LNtCh9Lo2TZLbkw8EFqRyOK1Z
        hnMOvP8MoIS400bIqKOkRo25TIRVY3E0zr52G1p/8JJworBxTLajQOzgc2g4jMJ5
        KyaEQEU21lRU+lnPx/9T4vWLn2rIMGrbtTwMvFx3RC/7x8uws/nCY9c82p1c7BAO
        cJISO4U5QO2ApClImuPtGyLT0HQDeX31clZvNey5YEvj1t+haTqOoWNOVMjhdV5N
        HTw+ctWWlApqXStdXTnhZMVCL1NpiTQRlN11idRW7I1p34urvGdEGmGQhaKa1RRu
        WlWWbpvXPMb0TKPwudmrkQeGWnN2Fpcv0XCJlyLKXHndQbHCKNYdOm0qiUe+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=e92UQE
        baaZ1irkk3PyBEoudpVOSpwDA/OJ6HpXpvBCA=; b=W1jLHx3dZ81kQrBYfIfg1X
        oJvImCNtD6NjosLcmCW9539ePKKxUEJbbNmg5HO0Wcnoa6uZJRINBDjhVfbGxIbg
        QQcQ643xzAYtqSMJbGQ8vsrFRfgAERu5LS1V8v6rKIGazl0dVb8pm0qRXnawAPNC
        1HY2lfORfUbKpdQe5Rwt+NwDvMlorVyultFMetJ7RbCovGLMBd7C1kp1fSWskW2V
        dY0Y6Z+aaaklgxf4b4K1a7D3sEMGr/4ml+PKPrlL6R479SHKkg93LxNIsaMkvQ/D
        Ppj7rdsSQpxDY2DMOvIyawNSpwSU0v7pbK+Ffc+XiGzaEXgk/Ba9TfT+vaPQvZcA
        ==
X-ME-Sender: <xms:_LdqX_rl_3d269yiRs7aBI65vSCYIflHMx7ZylDaYgItU8RVxViu2w>
    <xme:_LdqX5qjARfdUlCQIRUo5Lm5G-3O3lM-yJiGhFHan2r7LC-xvvUsidptOdYkQlmcE
    Xsp5B54LPnaVsQd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuvggrnhcuggcu
    mfgvlhhlvgihuceoshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
    eqnecuggftrfgrthhtvghrnhepieelhfetgefhvdetkeejieefteffveekgefgheekieeg
    iefhvedtuddtkefhleejnecukfhppedvtdelrdekhedrvdduledrheefnecuvehluhhsth
    gvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:_LdqX8NcB5o_1YhEk86ZFGH4earpUomiSRpbH1oi-6SgicgtiuTPXw>
    <xmx:_LdqXy4dIRUPesHUkpMDhbvetIrBpA1w1jv2p84v72Hig5Z6MbcZbw>
    <xmx:_LdqX-6E_MX2DvKCOR43vlxrtRaTM9CNNK_1urhVH50gjCbLGKtcmw>
    <xmx:_bdqX7Xv2LaqTWPlLW-zK4-aWiz9scKkVRPVeGz0AXvkN4jIYd2c3w>
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id C57F53064682;
        Tue, 22 Sep 2020 22:50:36 -0400 (EDT)
Received: by mail-qv1-f53.google.com with SMTP id j3so10642541qvi.7;
        Tue, 22 Sep 2020 19:50:36 -0700 (PDT)
X-Gm-Message-State: AOAM530YUls1NRkJSbhM96Q7XeEqlvod34UAtTdO8a5c59zGFceI0aOY
        dvN76UBa00aBxsZ/U5wzet07u01AWoL2j0Tcl8o=
X-Google-Smtp-Source: ABdhPJwDZZopCVZRPHrrtFsZBPI4fMswnUab/YM8gJxF7LZvKNyqnBKDWDqegxT8tkc2MlyB2eTsiUsT84LXFFGgJnQ=
X-Received: by 2002:a0c:aa5c:: with SMTP id e28mr9354618qvb.34.1600829436281;
 Tue, 22 Sep 2020 19:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
 <20200918204603.62100-8-sean.v.kelley@intel.com> <20200921123156.00000f18@Huawei.com>
In-Reply-To: <20200921123156.00000f18@Huawei.com>
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
Date:   Tue, 22 Sep 2020 19:50:24 -0700
X-Gmail-Original-Message-ID: <CAAbOPF0D-HTUfptwJaTt=Sb+X8wYXj3zdEkigL+hjG8LdNFw=Q@mail.gmail.com>
Message-ID: <CAAbOPF0D-HTUfptwJaTt=Sb+X8wYXj3zdEkigL+hjG8LdNFw=Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 4:33 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 18 Sep 2020 13:46:00 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > When attempting error recovery for an RCiEP associated with an RCEC device,
> > there needs to be a way to update the Root Error Status, the Uncorrectable
> > Error Status and the Uncorrectable Error Severity of the parent RCEC.
> > In some non-native cases in which there is no OS visible device
> > associated with the RCiEP, there is nothing to act upon as the firmware
> > is acting before the OS. So add handling for the linked 'rcec' in AER/ERR
> > while taking into account non-native cases.
> >
> > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> I'll give this a test run later to check I'm not missing anything, but LGTM.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Thanks,

Appreciate it.

Thanks,

Sean

>
> > ---
> >  drivers/pci/pcie/aer.c |  9 +++++----
> >  drivers/pci/pcie/err.c | 38 ++++++++++++++++++++++++--------------
> >  2 files changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 65dff5f3457a..dccdba60b5d9 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
> >  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >  {
> >       int aer = dev->aer_cap;
> > +     int rc = 0;
> >       u32 reg32;
> > -     int rc;
> > -
> >
> >       /* Disable Root's interrupt in response to error messages */
> >       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> >       reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> >       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> >
> > -     rc = pci_bus_error_reset(dev);
> > -     pci_info(dev, "Root Port link has been reset\n");
> > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
> > +             rc = pci_bus_error_reset(dev);
> > +             pci_info(dev, "Root Port link has been reset\n");
> > +     }
> >
> >       /* Clear Root Error Status */
> >       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 5380ecc41506..a61a2518163a 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
> >  /**
> >   * pci_bridge_walk - walk bridges potentially AER affected
> >   * @bridge   bridge which may be an RCEC with associated RCiEPs,
> > - *           an RCiEP associated with an RCEC, or a Port.
> > + *           or a Port.
> > + * @dev      an RCiEP lacking an associated RCEC.
> >   * @cb       callback to be called for each device found
> >   * @userdata arbitrary pointer to be passed to callback.
> >   *
> > @@ -160,13 +161,16 @@ static int report_resume(struct pci_dev *dev, void *data)
> >   * If the device provided has no subordinate bus, call the provided
> >   * callback on the device itself.
> >   */
> > -static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
> > +static void pci_bridge_walk(struct pci_dev *bridge, struct pci_dev *dev,
> > +                         int (*cb)(struct pci_dev *, void *),
> >                           void *userdata)
> >  {
> > -     if (bridge->subordinate)
> > +     if (bridge && bridge->subordinate)
> >               pci_walk_bus(bridge->subordinate, cb, userdata);
> > -     else
> > +     else if (bridge)
> >               cb(bridge, userdata);
> > +     else
> > +             cb(dev, userdata);
> >  }
> >
> >  static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> > @@ -196,16 +200,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >       type = pci_pcie_type(dev);
> >       if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >           type == PCI_EXP_TYPE_DOWNSTREAM ||
> > -         type == PCI_EXP_TYPE_RC_EC ||
> > -         type == PCI_EXP_TYPE_RC_END)
> > +         type == PCI_EXP_TYPE_RC_EC)
> >               bridge = dev;
> > +     else if (type == PCI_EXP_TYPE_RC_END)
> > +             bridge = dev->rcec;
> >       else
> >               bridge = pci_upstream_bridge(dev);
> >
> >       pci_dbg(dev, "broadcast error_detected message\n");
> >       if (state == pci_channel_io_frozen) {
> > -             pci_bridge_walk(bridge, report_frozen_detected, &status);
> > +             pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
> >               if (type == PCI_EXP_TYPE_RC_END) {
> > +                     /*
> > +                      * The callback only clears the Root Error Status
> > +                      * of the RCEC (see aer.c).
> > +                      */
> > +                     if (bridge)
> > +                             reset_subordinate_devices(bridge);
> > +
> >                       status = flr_on_rciep(dev);
> >                       if (status != PCI_ERS_RESULT_RECOVERED) {
> >                               pci_warn(dev, "function level reset failed\n");
> > @@ -219,13 +231,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >                       }
> >               }
> >       } else {
> > -             pci_bridge_walk(bridge, report_normal_detected, &status);
> > +             pci_bridge_walk(bridge, dev, report_normal_detected, &status);
> >       }
> >
> >       if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> >               status = PCI_ERS_RESULT_RECOVERED;
> >               pci_dbg(dev, "broadcast mmio_enabled message\n");
> > -             pci_bridge_walk(bridge, report_mmio_enabled, &status);
> > +             pci_bridge_walk(bridge, dev, report_mmio_enabled, &status);
> >       }
> >
> >       if (status == PCI_ERS_RESULT_NEED_RESET) {
> > @@ -236,18 +248,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >                */
> >               status = PCI_ERS_RESULT_RECOVERED;
> >               pci_dbg(dev, "broadcast slot_reset message\n");
> > -             pci_bridge_walk(bridge, report_slot_reset, &status);
> > +             pci_bridge_walk(bridge, dev, report_slot_reset, &status);
> >       }
> >
> >       if (status != PCI_ERS_RESULT_RECOVERED)
> >               goto failed;
> >
> >       pci_dbg(dev, "broadcast resume message\n");
> > -     pci_bridge_walk(bridge, report_resume, &status);
> > +     pci_bridge_walk(bridge, dev, report_resume, &status);
> >
> > -     if (type == PCI_EXP_TYPE_ROOT_PORT ||
> > -         type == PCI_EXP_TYPE_DOWNSTREAM ||
> > -         type == PCI_EXP_TYPE_RC_EC) {
> > +     if (bridge) {
> >               if (pcie_aer_is_native(bridge))
> >                       pcie_clear_device_status(bridge);
> >               pci_aer_clear_nonfatal_status(bridge);
>
>

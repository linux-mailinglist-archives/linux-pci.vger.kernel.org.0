Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB94D65BD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350098AbiCKQG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 11:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiCKQG7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 11:06:59 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30CA1D087A;
        Fri, 11 Mar 2022 08:05:53 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id f38so17938041ybi.3;
        Fri, 11 Mar 2022 08:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXK3c5vCtDDnw6VCBRrqNO0nfhAsiB45wwEvxlNLiXo=;
        b=dx4tpQ9zoUQtNEb7vC46mHi3QFCjO6a+s+2vdgZFPYeyXOUmivq4WN6OSrh2Gdc/qx
         hfnUi1l6iQaymVuzAcxufmTQz+OT7qOChTdJPiodbYbnPR1nBaGUttXUNMY1oGgUgy6Y
         Gp4TxtwqcZmH+mUTUwUJLbzR8U47jxkN9uviqQQ5XtAOCMIixefMmrHocpgaEUrm4yxt
         mavF18BFGuqfcCrMV55V+sPVcxpwf4zBbbWHTMWy0Gf6HaBPHwL1vnr7RXW1RSKTzwNw
         lutd7njFJoPpxw6j28udbIogOS83ZhTeRnl//RCVg3ibEESUb+K7/I9pDHYcfZs15aha
         az7Q==
X-Gm-Message-State: AOAM531/+F5f7I5ho8nXb6ccOQl6jHEHWYR77cqmc3u25A/lrsWckXd8
        iwRTlmIzV50+TghAbgqGzgFM3iCEw3WMHtjiRjQ=
X-Google-Smtp-Source: ABdhPJyQRnmhNHRK/cw7tijSXl2ZGHLhLN+9QbLC3JfGThjVGF0qdXOF5hXn/MlsEeSq6XToN1fwvl8eTZ5NXWjwAoA=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr8518518ybg.137.1647014752934; Fri, 11
 Mar 2022 08:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20220310175832.1259-1-mario.limonciello@amd.com>
 <CAJZ5v0gjPwEcq2dEE+wRr3D+w7=MTEKJoQ+x9muh_R4W-DawVw@mail.gmail.com> <BL1PR12MB5157D9FDDD0FC829CDD8CFB2E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157D9FDDD0FC829CDD8CFB2E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Mar 2022 17:05:42 +0100
Message-ID: <CAJZ5v0grj=vE1wGJpMxh-Hy7=ommfFUh5hw++nmQdLVxVtCSWw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 10, 2022 at 9:13 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > To fix these situations explicitly check that the ACPI device has a GPE
> > > allowing the device to generate wakeup signals handled by the platform
> > > in `acpi_pci_bridge_d3`.
> >
> > Which may be orthogonal to the _S0W return value mentioned above.
> >
> > Also, I'm not quite sure why acpi_pci_bridge_d3() should require the
> > root port to have a wake GPE associated with it as an indication that
> > the hierarchy below it can be put into D3cold.
>
> The reason that brought me down the path in this patch was actually
> acpi_dev_pm_get_state.  _S0W isn't actually evaluated unless
> adev->wakeup.flags.valid is set.

That's true, but it is unclear how this is related to whether or not a
given PCIe port can handle D3cold.  But see below.

>
> >
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index a42dbf448860..9f8f55ed09d9 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > >         if (!adev)
> > >                 return false;
> > >
> > > +       if (!adev->wakeup.flags.valid)
> > > +               return false;
> >
> > Minor nit: the two checks above could be combined.
>
> OK if we stick to this approach I'll do that.
>
> >
> > Also I would add a comment explaining why exactly wakeup.flags.valid
> > is checked here, because I can imagine a case in which the wakeup
> > signaling capability is irrelevant for whether or not the given port
> > can handle D3cold.
>
> Specifically a case that it's a hotplug bridge that has HotPlugSupportInD3
> though?  In practice I've only seen that in use on USB4 and Thunderbolt
> bridges "so far".
>
> I haven't tried yet but I would think directly evaluating _S0W at this time
> seems it should also work and would match closer to my original intent
> of the patch.  Would you prefer that?

I guess, but I'm not sure, that you are trying to kind of validate
HotPlugSupportInD3 by checking if the root port in question actually
can signal wakeup via ACPI and if it cannot, assume that the flag was
set by mistake and so the bridge should not be assumed to be able to
handle D3cold.

That is not unreasonable, but in that case you need to check
wakeup.flags.valid first and then _S0W too, because it can return 0
even if the "valid" flag is set.  And explain in a comment why this is
done.

> >
> > > +
> > >         if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
> > >                                    ACPI_TYPE_INTEGER, &obj) < 0)
> > >                 return false;
> > > --

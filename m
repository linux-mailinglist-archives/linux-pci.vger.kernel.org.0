Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBF66598F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 11:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjAKK5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 05:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbjAKK4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 05:56:45 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382729584;
        Wed, 11 Jan 2023 02:56:18 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id ss4so28555703ejb.11;
        Wed, 11 Jan 2023 02:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdvvzyZdZq8xmpLVIyIUoDQf3llEu3/kVz88+13kWoQ=;
        b=Ne1nQdDtMwDsHjv86+g+Hn9SiSX1QUpf1BZrf/v4VjTsC1GAOC3jFRewSFU8P+wJFX
         nLF6MbKY3aHzev1TkSTI4c0oQMJ7KEX9is5Pd0mNW+Ff86NBX8tkxlc8pLK+BFzmx6nz
         wUNqFBCDu9rDO0YyRlzh3EkF9AFCgFl5kU7We3m76DDB+xGP/30F86SqdDlLmgnAolBw
         3ChMjAXnIUFyIqgbRvWrZRBodjziQVdbiF4SSrwWlUrLtotkPKBINo7OPYIpQmFnDYgy
         I7h/OslDj6AML1ZWhHBCaw8CQDxnp5weNkl3hLmFdLZiIf/eU53PZeBZ4katx12zYWLW
         Oj+Q==
X-Gm-Message-State: AFqh2krBYYsBjDxle3C4vA3qU3WsOM/+sHkxA2RaQGAAMK3MxwtOn3By
        GlgXpj9DtViXOcrCMtGlVW3REflLh5o7rVLyyok=
X-Google-Smtp-Source: AMrXdXt1plBP+LE1QwuwoQLl6tLh8CL+APXUWo2TR995RXqPSeXeTjYKbXCGIIKfQxByeQwwDwqRlSj0SKxBirAKrkw=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr729548ejc.390.1673434577482; Wed, 11
 Jan 2023 02:56:17 -0800 (PST)
MIME-Version: 1.0
References: <1945994.PYKUYFuaPT@kreacher> <20230110205513.GA1608269@bhelgaas>
In-Reply-To: <20230110205513.GA1608269@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 11:56:05 +0100
Message-ID: <CAJZ5v0gwLU2rsUWga+aEyWtXb=CHx2wqbrXX1hc+M_Po64a11A@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 9:55 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jan 02, 2023 at 05:59:36PM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 2, 2023 5:34:19 PM CET Rafael J. Wysocki wrote:
> > ...
>
> > > I don't really think that Root Port support is required for a bridge below
> > > a Root Port if that bridge itself is power-manageable via ACPI.  Moreover,
> > > I don't think that the _S0W of a Root Port has any bearing on devices below
> > > it that have their own _S0W.
> > >
> > > So what we really want appears to be to evaluate _S0W for the target bridge,
> > > regardless of whether or not it is a Root Port, and return 'false' if that
> > > produces D2 or a shallower power state.  Otherwise, we can do what we've
> > > done so far.
>
> > +bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev)
> > +{
> > +     unsigned long long state;
> > +     acpi_status status;
> > +
> > +     status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> > +     return ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT;
>
> This returns "false" (i.e., "yes, device can signal wakeup from D3")
> if _S0W doesn't exist.  Is that right?

Yes, it is.

The reason why I did it that way was because the bridge cannot signal
wakeup from D3 if both the following conditions take place:

1. There is _S0W and it can be evaluated successfully.
2. _S0W produces D2 or a shallower power state.

In particular, if 1 is not the case, it is still not clear whether or
not the bridge can signal wakeup from D3 and additional checks are
needed.

> I think this might be less confusing as:
>
>   bool acpi_dev_can_wake_from_d3(struct acpi_device *adev)
>   {
>     status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
>     return ACPI_SUCCESS(status) && state >= ACPI_STATE_D3_HOT;
>   }

So I don't think the above will work, because
!acpi_dev_can_wake_from_d3(adev) is also true if _S0W is not present,
for example, in which case acpi_pci_bridge_d3() should not return
'false' right away.

However, the additional function can simply return the value produced
by _S0W or ACPI_STATE_UNKNOWN on all errors and its caller can do the
checks as needed which is done here:

https://patchwork.kernel.org/project/linux-acpi/patch/5659681.DvuYhMxLoT@kreacher/

(posted as a proper patch, because I wanted patchwork to pick it up).

I've also picked up the idea of using rpadev for representing the ACPI
companion of the Root Port in acpi_pci_bridge_d3().

Cheers!

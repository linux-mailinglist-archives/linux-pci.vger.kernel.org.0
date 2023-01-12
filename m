Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3366842B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 21:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbjALUqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 15:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjALUpe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 15:45:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2823BE95;
        Thu, 12 Jan 2023 12:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E80ACE1FA8;
        Thu, 12 Jan 2023 20:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E29CC433EF;
        Thu, 12 Jan 2023 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673554431;
        bh=dgALZAgbs41xLV2eRAqoof3IDtaLXBo8BQEMmUCfrNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rYe+WnA5FyajCXZgUtwJywvlVSPRGkvbXKRyalv4mILowuAIusK5v1s64YU3bXxOz
         gdx1bRGSOtLBq9s9EK3VfKus9/TbBSB0ZNp0/gYAH+UwJ/kYD/XkhBjh7Mv++vDWx7
         pBJBS2+M53m3oiAf22jjfGPmeRKFwISyPUIsymA/d1CFIyXsiOulExGwpsgs2wcOm/
         RUvsPoLyMXWPFq/2O8str1tif68F9nh3Ms51onaJKeLJ9qmzGmMONO1yWYbpwXJgLh
         kZrisw1luuv0oo3RG81N+8bL+1tuun9dBQVwv16AZ8otheW6t2ivK97KK65qD1RfRV
         BCww5P8wVmT/w==
Date:   Thu, 12 Jan 2023 14:13:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20230112201349.GA1787315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwLU2rsUWga+aEyWtXb=CHx2wqbrXX1hc+M_Po64a11A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 11:56:05AM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 10, 2023 at 9:55 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jan 02, 2023 at 05:59:36PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, January 2, 2023 5:34:19 PM CET Rafael J. Wysocki wrote:
> > > ...
> >
> > > > I don't really think that Root Port support is required for a bridge below
> > > > a Root Port if that bridge itself is power-manageable via ACPI.  Moreover,
> > > > I don't think that the _S0W of a Root Port has any bearing on devices below
> > > > it that have their own _S0W.
> > > >
> > > > So what we really want appears to be to evaluate _S0W for the target bridge,
> > > > regardless of whether or not it is a Root Port, and return 'false' if that
> > > > produces D2 or a shallower power state.  Otherwise, we can do what we've
> > > > done so far.
> >
> > > +bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev)
> > > +{
> > > +     unsigned long long state;
> > > +     acpi_status status;
> > > +
> > > +     status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> > > +     return ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT;
> >
> > This returns "false" (i.e., "yes, device can signal wakeup from D3")
> > if _S0W doesn't exist.  Is that right?
> 
> Yes, it is.
> 
> The reason why I did it that way was because the bridge cannot signal
> wakeup from D3 if both the following conditions take place:
> 
> 1. There is _S0W and it can be evaluated successfully.
> 2. _S0W produces D2 or a shallower power state.
> 
> In particular, if 1 is not the case, it is still not clear whether or
> not the bridge can signal wakeup from D3 and additional checks are
> needed.
> 
> > I think this might be less confusing as:
> >
> >   bool acpi_dev_can_wake_from_d3(struct acpi_device *adev)
> >   {
> >     status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> >     return ACPI_SUCCESS(status) && state >= ACPI_STATE_D3_HOT;
> >   }
> 
> So I don't think the above will work, because
> !acpi_dev_can_wake_from_d3(adev) is also true if _S0W is not present,
> for example, in which case acpi_pci_bridge_d3() should not return
> 'false' right away.

OK, that makes sense, thanks!

> However, the additional function can simply return the value produced
> by _S0W or ACPI_STATE_UNKNOWN on all errors and its caller can do the
> checks as needed which is done here:
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/5659681.DvuYhMxLoT@kreacher/
> 
> (posted as a proper patch, because I wanted patchwork to pick it up).
> 
> I've also picked up the idea of using rpadev for representing the ACPI
> companion of the Root Port in acpi_pci_bridge_d3().
> 
> Cheers!

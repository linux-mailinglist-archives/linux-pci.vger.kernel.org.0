Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBAB73AC5D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFVWJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVWJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 18:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51962D2;
        Thu, 22 Jun 2023 15:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF846191D;
        Thu, 22 Jun 2023 22:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC15C433C0;
        Thu, 22 Jun 2023 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687471739;
        bh=fnPyupiSh43hA3+gwEMM4x4vJJ8t89z9eeZ0bOnxTZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qjdUl3zmHyDUem3JUjof946vibZZtc1hc8KYKXp9649bjdTJk4lb/wNCDgZ4Q530D
         E0IEMtsYA1jHExEzAU+3C0wrx9vSHrlfDh98omNj2phXdmD41zRQCu+88cUzgdadQs
         CEXEUqvgDcjMYtgYWCUWzDyXPNntGWsR0wz7skgnOCHE2KYeHFaYmvyygbok4SSP38
         0bKPzWUTp6yw2t5XWIOVtwvp/ueO6iJWflva5/2THSbyBrklteIze16wb8TngeJjqf
         Qp9z8+Gt7GIMwS+DMwx1c9q3apUj99IXDe60UuSr29PzvHXeAnwxRSRhBFB2EVCBtp
         bonZX5ye4N3Kg==
Date:   Thu, 22 Jun 2023 17:08:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Message-ID: <20230622220856.GA150386@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d361edd0-18b4-b14f-0777-81fa20bb334d@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 12:43:56PM -0500, Limonciello, Mario wrote:
> On 6/21/2023 5:52 PM, Limonciello, Mario wrote:
> > On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
> > > On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
> > > > Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable
> > > > to access an OperationRegion unless `_REG` has been called.

> > > If so, I guess AML that uses ACPI_ADR_SPACE_PCI_CONFIG won't work
> > > until after we set the relevant device to D0?
> >
> > The particular problem that that exposed this issue doesn't
> > happen until suspend/resume time, but yes I think this should
> > be called when setting the device to D0.

> > > Do we explicitly set devices to D0 during enumeration, e.g., somewhere
> > > in the pci_scan_device() path?  If not, should we?
> >
> > AFAICT it's happening for PCIe ports as part of:
> > pcie_portdrv_probe
> > ->pcie_port_device_register
> > ->->pci_enable_device
> > ->->->pci_enable_device_flags
> > ->->->->do_pci_enable_device
> > ->->->->->pci_set_power_state(pci_dev, PCI_D0)
> 
> Just to add to this; I double checked and one of the devices that
> doesn't have a driver on my system has the power_state set to
> "unknown". I don't think it would be appropriate to explicitly put
> "all devices without drivers" into D0 as this could block low power
> states for the SOC.

I think we probably *should* be evaluating _REG for bridges and
endpoints during enumeration, but I don't think we should depend on
pci_enable_device() to do it.

If a method uses the PCI config OpRegion, I think it should work at
any time, but with this patch it looks like it will only work after a
transition to D0.

> On the Intel side, there is some special stuff in intel-pmc-core for example
> that explicitly puts specific driverless devices into D3 to ensure low power
> states.  If we put everything without a driver into D0 we may break stuff
> like
> that.

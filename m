Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC576B003
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHAJy6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 1 Aug 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHAJy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 05:54:57 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1BEE;
        Tue,  1 Aug 2023 02:54:56 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56c9f7830c2so251657eaf.0;
        Tue, 01 Aug 2023 02:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883696; x=1691488496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDHtwCciAVcr1/uCb4H8IZDljQclLvhqmNWIc3kVGPQ=;
        b=VQEqDg8J326q9pEfrlBcFaGgG1BkM8Jpqzjtm3SIFmcp5mG8rqqnPvMhmaf+3IRkHS
         Eg4DfJewjPxLO8OWcOFAHZLUU3K5OgV8PhFa5mYG0PVrCFN2rGysFd0dK5qk8Ek7ypWn
         tBusVswZ5M1AFcEui4417QzUjxwT60PGLdMzQ4vvEsxKggU2KlZhJcO47UMAnOOncftW
         zJplA/dNA/EbhybTdqp263zjNtDMlAzEmrp61SwkXgG/NNeOW8eaL4Ckdg4ztdPFoZxg
         TZl3Z2mfCK5xgXQnWZiqzcz9eucUzLTm7lxihvtAGs01raMxhdE4U6Eqvz/6/KXUKIXm
         RiHA==
X-Gm-Message-State: ABy/qLY7Rhq27inmOvmwEUUDhC+fEGmicIXDBajR5qA57mfp6r6PpKl5
        NubEwVdDLcmDViP0UY28YWN3SlnGToMtcyGjNUo=
X-Google-Smtp-Source: APBJJlGkGPlF9lCipQ7nhQdKjJk5+T87Obsq50y6T9rLg2wcB3DF7T52fU8JiHb9ZLwZDRZSEq4Hb9MqSi3BIZbvplQ=
X-Received: by 2002:a4a:e9b0:0:b0:565:a7bd:3927 with SMTP id
 t16-20020a4ae9b0000000b00565a7bd3927mr6598903ood.0.1690883695759; Tue, 01 Aug
 2023 02:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221427.GA250962@bhelgaas> <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com> <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <67fa2dda-f383-1864-57b8-08b86263bd02@amd.com>
In-Reply-To: <67fa2dda-f383-1864-57b8-08b86263bd02@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 11:54:43 +0200
Message-ID: <CAJZ5v0hZ-2rv2VovS-NO11QBMMGXLWL9J6Gys4ORpM+NGTxCTQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 15, 2023 at 1:00 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 7/14/2023 2:17 PM, Rafael J. Wysocki wrote:
>
> Well, this looks like a spec interpretation difference.
>
> We thought that _SxD/_SxW would only be relevant for devices with ACPI
> PM support, but the firmware people seem to think that those objects
> are also relevant for PCI devices that don't have ACPI PM support
> (because those devices are still power-manageable via PMCSR).  If
> Windows agrees with that viewpoint, we'll need to adjust, but not
> through adding _SxW checks in random places.
>
> I think that depends upon how you want to handle the lack of _S0W.

If _S0W is not present, _S0D should return the deepest state that can be used.

If that is not present, it is a matter of OS policy.

> On these problematic devices there is no _S0W under the PCIe
> root port.  As I said; Windows puts them into D0 in this case though.

Do you know what the rationale for that is?  Maybe Windows takes the
lack of _S0W/_S0D as the indication that the device could not go into
low-power states in D0, but do you actually know that this is the
case?

Surely, for non-bridge devices the lack of _S0W/_S0D does not mean
that the device should not be programmed into low-power states via
PMCSR, but maybe Root Ports are an exception?

> So acpi_dev_power_state_for_wake should return ACPI_STATE_UNKNOWN.

And then who'll decide what to do with that return value?

> Can you suggest where you think adding a acpi_dev_power_state_for_wake() does make sense?
>
> Two areas that I think would work would be in: pci_pm_suspend_noirq() (to avoid calling pci_prepare_to_sleep)
>
> or
>
> directly in pci_prepare_to_sleep() to check that value in lieu of pci_target_state().

I'm not sure that this is a core problem TBH.  It looks like this is
an exception made specifically for ports, so this check seems to
belong to where ports are handled, so that would be
acpi_pci_bridge_d3() after all.

However, _S0D needs to be checked too when _S0W is not present.

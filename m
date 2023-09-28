Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881827B276A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjI1V0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjI1V0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 17:26:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273719E;
        Thu, 28 Sep 2023 14:26:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A41EC433C8;
        Thu, 28 Sep 2023 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695936389;
        bh=Pzrz7c74E/lphkzgfD3c3rCMhh8QlzjjCU95eb8xKS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kHAGcc6ex2bv7IRURZw5Y3AOqUaOHLsGe3rpAs8QVKL6eZeAH612si2WZ0iga5807
         1pi08W2pepKJS6EraXELAaOK46cdFtTDXHk8HNMWS+RiG/9XBdmuV3uQynBGEz05My
         rL/zzhyLE/8sneCjpFpVrTz/Ggkaf9TvUCpfMrqT6gM5SYnnfOazenchBZCdY+UOtA
         lBmQg7jOonmtkPNlEsj2kOfCXaRxPEWSojQ/oMuPYIGY3YplKdIrANAdLrNCp81vyW
         q2SE6n1BlahMayNOmlShXPV/AILxH6BDhQcxBQWRW78xo3iW5/ee7ANkrRhKmCAoYy
         dkVsjlzvnaIIA==
Date:   Thu, 28 Sep 2023 16:26:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     D Scott Phillips <scott@os.amperecomputing.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
Message-ID: <20230928212627.GA502803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y1gqj9kg.fsf@scott-ph-mail.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 02:02:07PM -0700, D Scott Phillips wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> >> also present to request system firmware control of attention LEDs. Add an
> >> ACPI PCI Hotplug companion driver to support attention LED control.

> >> +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> >> +	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> >> +	depends on HOTPLUG_PCI_ACPI
> >> +	depends on HAVE_ARM_SMCCC_DISCOVERY
> >> +	depends on m
> >
> > Why is this restricted to being a module?  It's not unprecedented, but
> > unless this only works as a module for some reason, I would leave that
> > choice up to the user.
> 
> I did that because acpiphp_register_attention() wouldn't register the
> handler unless it was built as a module. Maybe better would be this
> change first:
> 
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -78,8 +78,7 @@ int acpiphp_register_attention(struct acpiphp_attention_info *info)
>  {
>  	int retval = -EINVAL;
>  
> -	if (info && info->owner && info->set_attn &&
> -			info->get_attn && !attention_info) {
> +	if (info && info->set_attn && info->get_attn && !attention_info) {
>  		retval = 0;
>  		attention_info = info;
>  	}

I would investigate the history of that "info->owner" check to see if
it's required somewhere.  If not, it seems like we could drop it.

At one time, we did support building hotplug drivers, including
acpiphp, as modules, but we no longer do.  Maybe that test dates from
that time.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E267D7234
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjJYRWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:22:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4915C12F;
        Wed, 25 Oct 2023 10:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE601C433C7;
        Wed, 25 Oct 2023 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698254559;
        bh=TpVWJFapHo0VMT3nduTVoXX71bNPxxczuV+vN2OQlj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jqyc/pzOjnUqQi1ENoMFIHd7NAJDIILKbOQvRshNeIA3ZnJKYJGIT5ZdBwEKw6eZr
         PvaG2CsPwhJ6ndvZ6rX/02SEki/3nG+d0/O4kjEL/BlQ6bVlkGoSl826D76E0kq59K
         /BxYttdXvaH/+fNXL7Elqx25hV8Hr7uMHo6BleqPNvpQthRCZENDhE7p2vpgfVBSo+
         VeFXA9HJ1CsHXY5l8hClMG4s1bcShaSrmYRWHIBqYDSILDENJmbXn9URBdku28K1AR
         The3ZP1ObSvDReM0tXcECgSlgcH0PeX0AFm7BONVLizklk0qQwaRQKsF/vr2F9voHy
         Wd1lv6GQYGqjQ==
Date:   Wed, 25 Oct 2023 12:22:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     D Scott Phillips <scott@os.amperecomputing.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231025172237.GA1754650@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930002036.6491-2-scott@os.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> also present to request system firmware control of attention LEDs. Add an
> ACPI PCI Hotplug companion driver to support attention LED control.
> ...

> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,

pci_domain_nr() returns "int" (normally 32 bits), but since this is an
ACPI system, the domain comes from _SEG, which is defined to be 16
bits (ACPI r6.5, sec 6.5.6).

So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
of _SEG.

Is this code doing the right thing?

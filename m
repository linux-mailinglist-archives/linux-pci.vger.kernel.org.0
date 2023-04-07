Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51F6DB714
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDGXSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDGXSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 19:18:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517EA7281;
        Fri,  7 Apr 2023 16:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA5B65549;
        Fri,  7 Apr 2023 23:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2081C4339B;
        Fri,  7 Apr 2023 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680909503;
        bh=qoSDQlNAO9HlyDhpcAu/76kmVbZ/kZk22io2phDTpCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kQ4oQ2xPrBZMBLe0xsM5NJivyOpeeKs8qhAZO/z1eurygENADg9v6LcYSY6IGk9iE
         pK0rn34xe2e0p8HHaQ5dTpAC0F0QqMkOk89c62um+nU9bxM6VSi33IG+yGNej9SI+6
         tlN5snen6qsg14M0SQKdeF7q8orkSSyyQyYlwjCdiTi40eBhPAJf3jy6eDGvor6He3
         MITyrcHp97TeaQaL42tnHjSh2MpLSSqzTqTyQCTYQi25iNcofUZVgJagUq9ShBQwe9
         m80o5rYQDbC+yygs1rdaOO3WeguRs4LnEuFya2D07wi916bCQ9IgpXdTwfeKUsGI8b
         SZHkaKlSRVkyQ==
Date:   Fri, 7 Apr 2023 18:18:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Li, Ming" <ming4.li@intel.com>
Subject: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
Message-ID: <20230407231821.GA3831711@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115031115.1666464-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sathy, Ming, since they commented on the previous version]

On Tue, Nov 15, 2022 at 11:11:15AM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
> register values form HEST PCI Express AER Structure should be written to
> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
> is to extract register values from HEST PCI Express AER structures and
> program them into AER Capabilities. Refer to the ACPI Spec r6.5 for a more
> detailed description.

I wasn't involved in this part of the ACPI spec, and I don't
understand how this is intended to work.

I see that this series extracts AER mask, severity, and control
information from the ACPI HEST table and uses it to configure PCIe
devices as they are enumerated.

What I don't understand is how this relates to ownership of the AER
capability as negotiated by the _OSC method.  Firmware can configure
the AER capability itself, and if it retains control of the AER
capability, the OS can't write to it (with the exception of clearing
EDR error status), so this wouldn't be necessary.

If the OS owns the AER capability, I assume it gets to decide for
itself how to configure AER, no matter what the ACPI HEST says.

Maybe this is intended for the case where firmware retains AER
ownership but the OS uses native hotplug (pciehp), and this is a way
for the OS to configure new devices as the firmware expects?  But in
that case, we still have the problem that the OS can't write to the
AER capability to do this configuration.

Bjorn

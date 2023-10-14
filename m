Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1C7C9433
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 12:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJNKxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNKxn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 06:53:43 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524ACAD
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2023 03:53:41 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B8F9E101956D2;
        Sat, 14 Oct 2023 12:53:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 861B42D957; Sat, 14 Oct 2023 12:53:38 +0200 (CEST)
Date:   Sat, 14 Oct 2023 12:53:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [RFC v1 2/4] PCI: Add support for drivers to decide bridge D3
 policy
Message-ID: <20231014105338.GA3223@wunner.de>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
 <20231009225653.36030-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009225653.36030-3-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 09, 2023 at 05:56:51PM -0500, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
> 
> This policy change has worked for most machines, but the behavior
> is improved with `pcie_port_pm=off` on some others.
> 
> Add support for drivers to register a callback that they can optionally
> use to decide the policy on supported machines.

I would assume that drivers can decide the policy already today through
pci_d3cold_enable() / pci_d3cold_disable().

Why is this not sufficient and what's the benefit of the more complex
approach proposed here?

Thanks,

Lukas

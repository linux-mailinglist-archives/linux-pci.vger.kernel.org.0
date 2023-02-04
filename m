Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7664068ABB8
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 18:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjBDRpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Feb 2023 12:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBDRp3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2023 12:45:29 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9DD25E2B;
        Sat,  4 Feb 2023 09:45:27 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AE605300097BE;
        Sat,  4 Feb 2023 18:45:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 85E081D8B54; Sat,  4 Feb 2023 18:45:25 +0100 (CET)
Date:   Sat, 4 Feb 2023 18:45:25 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] Revert "PCI/ASPM: Refactor L1 PM Substates Control
 Register programming"
Message-ID: <20230204174525.GA917@wunner.de>
References: <20230203224820.2056582-1-helgaas@kernel.org>
 <20230203224820.2056582-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203224820.2056582-3-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 04:48:20PM -0600, Bjorn Helgaas wrote:
> Thomas Witt reported that 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
> Control Register programming") broke suspend/resume on a Tuxedo
> Infinitybook S 14 v5, which seems to use a Clevo L140CU Mainboard.
> 
> The main symptom is:
> 
>   iwlwifi 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
>   nvme 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> and the machine is only partially usable after resume.  It can't run dmesg
> and can't do a clean reboot.  This happens on every suspend/resume cycle.
> 
> Revert 5e85eba6f50d until we can figure out the root cause.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216877

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Fixes: 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates Control Register programming")
Cc: stable@vger.kernel.org # v6.1+

> Reported-by: Thomas Witt <kernel@witt.link>
> Tested-by: Thomas Witt <kernel@witt.link>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>

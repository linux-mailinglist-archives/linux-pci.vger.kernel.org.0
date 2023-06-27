Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BED73F9A7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjF0KHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjF0KGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 06:06:43 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 03:03:25 PDT
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2182944
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 03:03:25 -0700 (PDT)
Received: from [10.0.0.117] (p5489d081.dip0.t-ipconnect.de [84.137.208.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id E52962A0BB4;
        Tue, 27 Jun 2023 11:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1687859614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1pZpKLKrbliglo0GMHWH4qRGTgEHDvPNl44p/Bwgn4=;
        b=hWA4jjx6+ECPbHvAc371c5r4o9Q9znO0DbO30uGqyFL4L0kxs26syW+HN4M3YrhhlMq3Il
        ioURBSZnt/kPeIZaZ0Xzw1ulBtv6QINKiKEveMNtEaauJHkrjXwn1gUof+BUJrcn48s+gF
        DHQEaLvPFYU+tUpUVQzm+E1eXM2r6h0MHrwCanRCLqcOCA6ZEhFLf3UrYcG1D0jKoNfkB2
        E1W8+igD4HwbApK3Y+Izmx8+oXmQcWRNwRN3fTJKRs4sRi+uO8CwjFzCT4ytlnuiOIACFI
        qup9fRgocEFkCsEmnHpuYbdZk0Cq++lpltRBGuJXK71qV34MHz0YX4aWXdOj1g==
Message-ID: <61224a0b-ddf7-8348-332c-ec20e7d970e4@witt.link>
Date:   Tue, 27 Jun 2023 11:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627062442.54008-1-mika.westerberg@linux.intel.com>
Content-Language: en-US
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <20230627062442.54008-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/06/2023 08:24, Mika Westerberg wrote:
> Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> due to a regression that caused resume from suspend to fail on certain
> systems. However, we never added this capability back and this is now
> causing systems fail to enter low power CPU states, drawing more power
> from the battery.

Hello Mika,

I am sorry, but your patch (applied on top of master) triggers the exact 
same behaviour I described in 
<https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi 
become unavailable during suspend/resume)

Best Regards,
Thomas

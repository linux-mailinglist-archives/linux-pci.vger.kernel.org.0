Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF2740E9E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjF1K0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 06:26:10 -0400
Received: from witt.link ([185.233.105.83]:48814 "EHLO witt.link"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbjF1KYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 06:24:09 -0400
Received: from [10.0.0.117] (p5489d081.dip0.t-ipconnect.de [84.137.208.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 5108B2A0676;
        Wed, 28 Jun 2023 12:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1687947847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDzETMTPDxtbzCyjvuGnG2CcfkJe9VJZUZDxUtsAD6Q=;
        b=Sv9Ouv9wyf1J698pmsRT6q2VJhWc3GUYigqYr6+quE3oZD+FYLk91kX5J9riZM5aURdEE0
        nXDgqPp61nZhdcGXS/9iuqLGmtaLl1PMBDq7XwqWvNR94XKuntDBzSzMZOHnMQt4oQP0C2
        ZkoC9qiSgAit5Bz1IdUYipQNkGhjdSJN5XXLf+VcJFGpwygbByETV8nhDWg9GO4nC3gObz
        55a2bH+PD8X6PyqPYIiz1NetHsxUGL7bITGBjwI+u6+n93kzEqXL5MVNxbd18eMwTFE8Hp
        u3p1cGmBwMEJdwwiaOq65VnHgo/IKDol0ft7aAGls6xAYIMyluwsupZkXoM+/A==
Message-ID: <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
Date:   Wed, 28 Jun 2023 12:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
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
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
Content-Language: en-US
From:   Thomas Witt <kernel@witt.link>
In-Reply-To: <20230628064637.GF14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/06/2023 08:46, Mika Westerberg wrote:
> @Thomas, is there any particular reason you have this option in the
> command line? There is possibility that S3 is not even fully validated
> if the system advertises S0 low power sleep instead.

In fact, there is: Entering suspend-to-ram without setting 
/sys/power/mem_sleep to "deep", my laptop consumes about the same power 
as it would idling online. The manufacturer suggests setting that 
commandline parameter:

<https://www.tuxedocomputers.com/en/Infos/Help-Support/Instructions/Fine-tuning-of-power-management-with-suspend-standby.tuxedo#>

I just retested your patch with setting mem_sleep to "s2idle", and it no 
longer triggers the loss of PCI devices. I guess that could be the 
indicator that Björn asked for.

I attached the output of dmidecode to the bugzilla entry mentioned 
above: <https://bugzilla.kernel.org/attachment.cgi?id=304494>

Best regards,
Thomas

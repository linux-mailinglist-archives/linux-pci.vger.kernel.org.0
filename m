Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857363C547
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiK2Qgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 11:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiK2Qgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 11:36:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301C6177A
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 08:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFD7617DB
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 16:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329F1C433C1;
        Tue, 29 Nov 2022 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669739796;
        bh=1k3AK6MzqB1NVHEf29EF4z+l3XkdnffBkn/OjB2HjKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJ6L225bkMyXix0mv3gVNNcKst3HKxurxZdcjYt5AIcwj8J0em9y3vYOSTeDgekr0
         1wjyvxEykqKqsBsCfEYtcaQEk9N+j0ZXzKWzTsNW2K/MtlUDfwtsrk45lQmuzSQmkM
         2NisldXIhxJv+HJJyILHId6dHwOXtXY/BwoUXCJuqIXJD4zhc6VXwd7XFnnRegvWuc
         aJfqqt3O97sqejsJB88cJGOfa+cRXE6/r4AMgQSFOknw71LNpDLImGc7Iox9QY0Gt8
         nypVWf7TdSrAal0tHCeFdQgytOhSJsOu9qrWtF6zo+/gYOGdbdZhL2OvspXbeA6e1n
         TYnxGfxb1zjYA==
Date:   Tue, 29 Nov 2022 09:36:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Message-ID: <Y4Y1EYZ+1Otx9LaT@kbusch-mbp.dhcp.thefacebook.com>
References: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 08:35:55AM +0100, Lukas Wunner wrote:
> Add DPC Software Trigger as a reset method to be used for silicon
> validation among other things:

Do you really need a kernel helper to do this? You can test these with

  # setpci -s <dsp's b:d.f> ECAP_DPC+6.w=40:40

And since the kernel is a not aware you are synthesizing the DPC event,
that more naturally tests how the kernel would react to a hardware dpc
trigger.

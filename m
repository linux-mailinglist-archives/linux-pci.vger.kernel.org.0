Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC06CF343
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjC2TkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjC2Tjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 15:39:47 -0400
Received: from infra.glanzmann.de (infra.glanzmann.de [IPv6:2a01:4f8:b0:3ffe::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B57B4ED4
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
        s=infra26101010; t=1680118780;
        bh=ZChw6dXNtrck3De5Td1PPB6x2isj/bMWUmfo3lNeqFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hB23zdKmPXh67uei7X23zyZPacx1+5ArCoIz0tGK3swnx73KYgc89IAq7fT2UFbid
         LvHt5d9ZQHaJBfQVzuwGWmxjtK7/uML1rIylWcaloDxSZM7ptaUoqf0UqFaJuNnyOG
         gresasbgq+g6A7iUFQZfISDL6hDlpjdOVuDK7Y7RLaviu9Ss45K2PW3lK4+fO03h1X
         v/3uI4rvfmvp0olNE/oiGrqekFDeVNS1MBDwF8JnKM68W0VHLEV+A09a++H+Ls24jO
         zD/hbR2fERiTTwm8fkkohqA3RlKceW2Lns3noi8bBkmQe62QlsidGLdqr3QYH9Hj53
         BMOurOTavFq/rwHmrGXV1KE5FbU/JTfZpMsNktbkkIIvNiaAfdeXibTjNFV+hatXZ3
         8qftyBG0ji6vqHF6S3PkBVxzGSvZoqfaqFdE6dCtxi1yrd9sRFb5m3Xv746o6ld9f6
         3R0vH4iD4t27kqBU1uLRG+0Up2RSo3dDRzrYiz3sS80ddMjEJ7FKU3eD+1Rhls6j6H
         jEtDc5yWorCo+7m1g6Z/RuM/PO6O9RzZjGBpaXNmuY+dyrME6lCytIZsuftx/8EETl
         P1s2CieZIafoXXlAo86LLX1lU37Pif49BnSGK3f7Z0xnDQJzTsaYyiyvk0CISmC7w1
         ESHKhzM7aqaNhLjCFYJm4vB8=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
        id B07F67A80055; Wed, 29 Mar 2023 21:39:40 +0200 (CEST)
Date:   Wed, 29 Mar 2023 21:39:40 +0200
From:   Thomas Glanzmann <thomas@glanzmann.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bhelgaas@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-pci@vger.kernel.org, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH] PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET
 dev2 f0
Message-ID: <ZCST/Bagg2qhdAaJ@glanzmann.de>
References: <20230329172859.699743-1-Basavaraj.Natikar@amd.com>
 <ae3218a7-52e6-cf96-2223-dac2e1f9d14a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3218a7-52e6-cf96-2223-dac2e1f9d14a@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Mario,

* Limonciello, Mario <mario.limonciello@amd.com> [2023-03-29 20:56]:
> Can you please test this on your side?

> Explicitly test it with amdgpu blacklisted or iGPU disabled in BIOS setup so
> that we can confirm that it is working and the amdgpu version of it isn't
> being used.

I tested the same on top of v6.2.8 with amdgpu blacklisted. It works

Tested-by: Thomas Glanzmann <thomas@glanzmann.de>

Find here some additional information:

https://tg.st/u/dabb0ed77c14a8ec6e76d85f9f936977dca04c899d1773603c58350c9ce31768.txt

I tested by replugging mouse and keyboard in opposite ports which did
not work before.

Cheers,
        Thomas

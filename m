Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037267B7D1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAYRFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 12:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjAYRFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 12:05:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1183CC;
        Wed, 25 Jan 2023 09:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC48BB81B44;
        Wed, 25 Jan 2023 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A186C433EF;
        Wed, 25 Jan 2023 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674666309;
        bh=KCgquHBBE3i32DY08dZlQY8oNliwvemLJmq1BLIltXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rvk2iA8pOJhX6AySAr56h3sa54DxzdmfY9i5WuM501Wd1mNsKW2iOkzkfUk1HnGhQ
         fcXZ1tXfgy1+iteHg1xoxwgQqYrngP6I8DFlYjGkYzXHPxcZWC6m5zhM7YF1UuiA0l
         TziucBvFB70zD9yrad7zBhej/nswthz1AtU9xK8SPCq1Uu6aGA75iTMLyfqe3fbhfK
         8PNp1OA66uRHyR6bSMlXwkFyoOWrqXroiCFm2aX/aXa2KX4msX+TNqpXUo0wBJ2ry5
         2n8/KAzsbFFJuPzmTR/HanO1nPIulfnR4eiliFbC+M/GewjlXC92TsMjvY8X2+5aps
         5yhA7ses57mjQ==
Date:   Wed, 25 Jan 2023 11:05:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scheller <d.scheller@gmx.net>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Berni <bernhard@turmann.eu>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 208507] New:
 BISECTED: i2c timeout loading module ddbridge with commit
 d2345d1231d80ecbea5fb764eb43123440861462]
Message-ID: <20230125170506.GA1175690@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709191722.GA6054@bjorn-Precision-5520>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Salvatore, Mauro, Daniel, linux-media]

On Thu, Jul 09, 2020 at 02:17:22PM -0500, Bjorn Helgaas wrote:
> Bisected to Debian commit d2345d1231d8, which is a backport of the
> upstream commit b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism
> for Xeon chipsets").
> 
> Reporter confirmed that reverting the Debian backport from 4.19.132
> fixes the problem.
>
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Thu, 09 Jul 2020 15:01:11 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 208507] New: BISECTED: i2c timeout loading module ddbridge with
> 	commit d2345d1231d80ecbea5fb764eb43123440861462
> Message-ID: <bug-208507-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208507
> 
>             Bug ID: 208507
>            Summary: BISECTED: i2c timeout loading module ddbridge with
>                     commit d2345d1231d80ecbea5fb764eb43123440861462
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.19.132
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: bernhard@turmann.eu
>         Regression: Yes
> 
> Created attachment 290179
>   --> https://bugzilla.kernel.org/attachment.cgi?id=290179&action=edit
> dmesg on 4.19.132
> 
> OS: Debian 10.4 Buster
> CPU: Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> Hardware: Supermicro  Super Server
> Mainboard: Supermicro X10SDV
> DVB card: Digital Devices Cine S2 V7 Advanced DVB adapter
> 
> Issue:
> =====
> Loading kernel module ddbridge fails with i2c timeouts, see attached dmesg. The
> dvb media adapter is unusable.
> This happened after Linux kernel upgrade from 4.19.98-1+deb10u1 to
> 4.19.118-2+deb10u1.
> 
> A git bisect based on the Debian kernel repo on branch buster identified as
> first bad commit: [1fb0eb795661ab9e697c3a053b35aa4dc3b81165] Update to
> 4.19.116.
> 
> Another git bisect based on upstream Linux kernel repo on branch v4.19.y
> identified as first bad commit: [d2345d1231d80ecbea5fb764eb43123440861462] PCI:
> Add boot interrupt quirk mechanism for Xeon chipsets.
> 
> Other affected Debian kernel version: 5.6.14+2~bpo10+1
> I tested this version via buster-backports, because so far I was unable to
> build my own kernel from 5.6.y or even 5.7.y.
> 
> Workaround:
> ==========
> Reverting the mentioned commit d2345d1231d80ecbea5fb764eb43123440861462 on top
> of 4.19.132 is fixing the problem. Reverting the same commit on 4.19.118 or
> 4.19.116 is also fixing the problem.

Sorry, I dropped the ball on this.

Berni has verified that this problem still exists in v6.1.4, and has
attached current dmesg logs and lspci output.  

Sean's comment (https://bugzilla.kernel.org/show_bug.cgi?id=208507#c18)
suggests this is actually a ddbridge driver issue related to INTx
emulation or MSI support.

Berni confirmed that the i2c timeouts happen when
CONFIG_DVB_DDBRIDGE_MSIENABLE is not enabled, and that enabling MSI
via the "ddbridge.msi=1" module parameter avoids the i2c timeouts.

The Kconfig help for DVB_DDBRIDGE_MSIENABLE:

  Use PCI MSI (Message Signaled Interrupts) per default. Enabling this
  might lead to I2C errors originating from the bridge in conjunction
  with certain SATA controllers, requiring a reload of the ddbridge
  module. MSI can still be disabled by passing msi=0 as option, as
  this will just change the msi option default value.

suggests that there may be an i2c or SATA issue that could be fixed so
ddbridge MSI could be always enabled.  But I don't know about that
underlying issue.

Per MAINTAINERS, the ddbridge driver looks orphaned, so I cc'd the
media folks and Daniel, who might know something about the MSI issues,
based on adaf4df70521 ("media: ddbridge: Kconfig option to control the
MSI modparam default").

Bjorn


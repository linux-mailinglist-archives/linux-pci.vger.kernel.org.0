Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6265BE11
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjACKaj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjACKai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 05:30:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE89FACA;
        Tue,  3 Jan 2023 02:30:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D357384B9;
        Tue,  3 Jan 2023 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672741836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ySrPxV3zhESWmq67sZZJzg1CJ6Yayz+hsQTCiO9cYA=;
        b=bP8XS/I0HM8LJOSSoJIq2nyAuBCBNgbZjegXymSCM9nMzQaDBBTZRkBuE4K4qpbxKHU+R6
        Hko4Kr/yzxeJVx/a4wWj7hArNq+2FsBl46Vu6xCC8y8kM1PdPl1J0/5IryLIrF2s4DWKxJ
        HkWRmzQPbP6jVJp6NhJTnVlapB4aVmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672741836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ySrPxV3zhESWmq67sZZJzg1CJ6Yayz+hsQTCiO9cYA=;
        b=yb+gU+KVGvvRYdz4C0uGJFD0BzaESqtpR2TVdwImv8MinanrkJYLaO6hlI21jbgpcT1JWZ
        y8c9HdGJDSYSvuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDD621392B;
        Tue,  3 Jan 2023 10:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +YXBMMsDtGOKRAAAMHmgww
        (envelope-from <jroedel@suse.de>); Tue, 03 Jan 2023 10:30:35 +0000
Date:   Tue, 3 Jan 2023 11:30:34 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [regression, =?iso-8859-1?Q?bisected?=
 =?iso-8859-1?Q?=2C_pci=2Fiommu=5D_Bug=A0216865_-_Black_screen_when_amdgp?=
 =?iso-8859-1?Q?u?= started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y7QDyr2b3zviKdLc@suse.de>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Baolu,

On Fri, Dec 30, 2022 at 09:18:56AM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216865 :

can you have a look at this please?

Thanks,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman


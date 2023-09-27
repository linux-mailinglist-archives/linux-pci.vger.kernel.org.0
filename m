Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1F27B06DF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjI0Obr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjI0Obr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 10:31:47 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC8F4
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:31:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 895A72800A28A;
        Wed, 27 Sep 2023 16:31:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C0A38030C; Wed, 27 Sep 2023 16:31:43 +0200 (CEST)
Date:   Wed, 27 Sep 2023 16:31:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927143143.GA16217@wunner.de>
References: <20230927051602.GX3208943@black.fi.intel.com>
 <20230927115703.GA445616@bhelgaas>
 <20230927124732.GI3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927124732.GI3208943@black.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 03:47:32PM +0300, Mika Westerberg wrote:
> This is not a Linux defect. The firmware is expected to create that
> tunnel so regardless of the "delay" the devices are already back. This
> is not happening.

I recall that newer chips can be switched over to software connection
manager at runtime.

Can we determine that the ICM firmware failed to do what it should,
kick it out and let the software connection manager take over?

Thanks,

Lukas

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA16441D6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiLFLH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 06:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiLFLH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 06:07:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737424F12;
        Tue,  6 Dec 2022 03:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB79461639;
        Tue,  6 Dec 2022 11:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD3C433C1;
        Tue,  6 Dec 2022 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670324873;
        bh=p9euspRpu7IgFGmgMr/sPTQkT65tLR1ry9Fi1y/LQic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEQAgtEvFPpQyBRGF2ennNmP0wRjZth+py+1k0qB3lD7v6ntk8OlmNWIsrCI4iT+M
         3VDIYX4iPLB3Yb6MAsfwC3K1M7C91JVFAZoW6gxAXxM+mxjcq8pn6uAOTLY+8Yu0SG
         dvI7QN6sS5tjp6MGCxIPbF9L4xdGs7jz+amQX2IIAhqujdmEwDIDwgrNbSRcUOCtEp
         73aEcRglgECcO+zK39PtvrKG093P4jax2DMxheEwaRmad0SoG/bAXHx72q+Kl8+ctc
         kNvC/mqNMn12GYmCQlHKD5znLrMdCpSCXWko8Ks/znMV47zYdquzkF+LyTRIBudlC8
         0WQnCr13hEe7A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        John Thomson <git@johnthomson.fastmail.com.au>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: mt7621: Add sentinel to quirks table
Date:   Tue,  6 Dec 2022 12:07:46 +0100
Message-Id: <167032484884.63899.8908986759338955026.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205204645.301301-1-git@johnthomson.fastmail.com.au>
References: <20221205204645.301301-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Dec 2022 06:46:45 +1000, John Thomson wrote:
> This driver was missing a sentinel in the struct soc_device_attribute
> array, which caused an oops when assessed by
> soc_device_match(mt7621_pcie_quirks_match)
> This was only exposed once the CONFIG_SOC_MT7621 mt7621 soc_dev_attr
> was fixed to register the soc as a device, in commit 7c18b64bba3b ("mips:
> ralink: mt7621: do not use kzalloc too early")
> 
> [...]

Applied to pci/mt7621, thanks!

[1/1] PCI: mt7621: Add sentinel to quirks table
      https://git.kernel.org/lpieralisi/pci/c/19098934f910

Thanks,
Lorenzo

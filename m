Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938EE66993D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAMN7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 08:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbjAMN6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 08:58:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C56535E;
        Fri, 13 Jan 2023 05:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5495261DD3;
        Fri, 13 Jan 2023 13:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80318C433D2;
        Fri, 13 Jan 2023 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618089;
        bh=etUuzU9tIgvE6qsWtohO10bNW+wwY+0aCP3yj1s2Y1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rUAE9LeuSBaDtpQh6UBkYdql+tYsw3nR7vawoLWMhDY8HuY1p8WdiY+zByi0VeT/T
         vVb84ZwvT4iLQY3PY5xCgzW9qDclZn72XFQk07YYRE/f3/unHiPnaaPUCSvo5DEkl9
         FfEBjSuvjbr2BN+QSa3qyH/tS2Df8vGgdaKZqz99MjniYNHHYcLKrWi68ODvXlhjIc
         rYBJKfY84ILWeJ0ZceRG3oGnArG1Cn94/pmDUynHcHo4u/FMe/Myh9VySf9i8pjpHF
         BhlJj/9TlrxExGIA3XhkrE5pHjNRhUxhgPbyOolL2+1d7hTBGVCV8HZFsPZHRbiaux
         QxtNdGJuI6dwg==
Date:   Fri, 13 Jan 2023 07:54:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baowen Zheng <baowen.zheng@corigine.com>
Cc:     2lprbe78@duck.com, benoitg@coeus.ca, bhelgaas@google.com,
        hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com, mumblingdrunkard@protonmail.com,
        nicholas.johnson-opensource@outlook.com.au,
        wse@tuxedocomputers.com, simon.horman@corigine.com,
        yinjun.zhang@corigine.com, tianyu.yuan@corigine.com
Subject: Re: [PATCH v2 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Message-ID: <20230113135448.GA1835615@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673606763-30159-1-git-send-email-baowen.zheng@corigine.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 06:46:03PM +0800, Baowen Zheng wrote:
> Hello Bjorn Helgaas:
> 
> When we tested our NIC, we found we will fail to access pcie extent configuration space.
> Actually we can only access the 256 Bytes of the pcie configuration space.
> You can make check with command of "lspci -s XXXX -vv"
> It seems relates to this change, could you please help to make a check?

Can you test these patches?

  https://lore.kernel.org/linux-pci/20230110180243.1590045-1-helgaas@kernel.org/

Let me know if they don't fix the problem.

Bjorn

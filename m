Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8061717B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKBXMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBXMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3859597;
        Wed,  2 Nov 2022 16:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A106061C83;
        Wed,  2 Nov 2022 23:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28FEC433C1;
        Wed,  2 Nov 2022 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667430751;
        bh=hb4ysrKjjzzHQ2xU6VS0F9aJ3mmCkipMzi+QwwyX97w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pVQOOffNPj62XkwtB8ztFaSrNQkFtLkfURsr1QCQnT77g6+TJUi0Stn/Psg600d8+
         +D6iJvvsAKs5U78v1fW0UcCa9wTThssVa61BB00BxvWmZAY72ikSqolYkO4dM+2lV3
         H7wPLK3+F1w7amTF2pihNoEKXXwq9J53kXf3b6UK/7QX5R5c+NGUw/Xo8qd1EBQJpT
         fZ4/TsvJoic00Uxfb44k3Z429vv1bXMyItYtJtpPs97dn6TX8zIZuqGynWZPpp9Hn7
         2TnQKOfIatBPJdKLAx39tlZoWoCp/TYkbqeeqGzo3mllMR+HnSoE9Q9Y4eFGHiG5OK
         rlCVrhr+JHbnQ==
Date:   Wed, 2 Nov 2022 18:12:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 2/2] PCI:pciehp: Clear 10-bit tags unconditionally on a
 hot-plug event
Message-ID: <20221102231229.GA7035@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101000719.36828-3-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the subject line spacing to match the [1/2] patch (and previous
history for pciehp).

On Tue, Nov 01, 2022 at 12:07:19AM +0000, Smita Koralahalli wrote:
> Clear 10-bit tags unconditionally as there is no guarantee that the next
> device inserted will support this feature.

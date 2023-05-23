Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6170D308
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 07:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjEWFDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 01:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEWFDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 01:03:35 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3510C
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 22:03:33 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2F34A28007EFA;
        Tue, 23 May 2023 07:03:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 19BE170EBE; Tue, 23 May 2023 07:03:31 +0200 (CEST)
Date:   Tue, 23 May 2023 07:03:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230523050331.GA30083@wunner.de>
References: <20230520083118.GA2713@wunner.de>
 <ZGvaTOlY/Srh9Zip@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGvaTOlY/Srh9Zip@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 04:10:36PM -0500, Bjorn Helgaas wrote:
> Thanks for your patience, I think I understand that.  Here's another
> try:

The wording LGTM.


> And (b) is the situation you refer to where the second button press
> doesn't bring the slot up when it should.  Right?

Yes, exactly.

Thanks,

Lukas

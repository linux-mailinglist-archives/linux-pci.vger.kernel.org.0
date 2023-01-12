Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D62667ECE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjALTOD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjALTN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 14:13:29 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2B4166C;
        Thu, 12 Jan 2023 11:00:46 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id tz12so47055441ejc.9;
        Thu, 12 Jan 2023 11:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuIcSWbul+1/18zuJklkuKGvyzSgKGGCLjs/tM3r1uc=;
        b=CaW4faQCeMpGNS8aM1vabPuOfZxGIHOECtQs04tR4iovGKFS+xkty8rZji5SzX5gyP
         dxFv7Er9m1XPIFvrTGqlfoH+D1QvGk8eEBOsa9+GrlPOJmci8MRBec//qZyQm3uJW8Ty
         QuM6/VlWjTSUmZIZKtioWLimGYAFzTbBiUl2IqzZbKEzolcLXZd/ddo3Hr/5iBOP0CsP
         B/MQosrhnPVq7D+zmE8nE0X/J2l+9NEBteUi45Bml7VxxcGsTltu+2qOzZMLN+MGKuUm
         UQfN5j9cc4gQvcOfcWzw6qJ8X2oGEYqig7gkdDKlGOOor/ZqaSZ/j617pMt8OVS8VCEg
         35dQ==
X-Gm-Message-State: AFqh2kp8JF3cZzSvNgJUcCnoEIqcL9NiZ9O2kxBEyo50nGoOk0F+9n3u
        nFb9wT+errJL4HwJ+cQLFSnc97RLYPw41FlGvOI=
X-Google-Smtp-Source: AMrXdXvwlfThEscENbSE4PlviTY6OpbtoBUh4NIjYmb69UMptj2gmlI56uB/e2XGCjsnZYlxCRQdJ5Rr/UpOc8E+CMI=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr5706218ejc.246.1673550044779; Thu, 12
 Jan 2023 11:00:44 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 20:00:33 +0100
Message-ID: <CAJZ5v0gKUq_A6mBC5stRo20G+Z=9v90AbAQ51c4uKm41OiCKVA@mail.gmail.com>
Subject: PCI ASPM regression resulting from commit 4ff116d0d5fd8
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Francis Enriquez <enriquezmark36@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

Your commit 4ff116d0d5fd8 ("PCI/ASPM: Save L1 PM Substates Capability
for suspend/resume") has introduced a system resume issue described in
the bug entry at:

https://bugzilla.kernel.org/show_bug.cgi?id=216782

It looks like restoring the L1SS state during system resume has
unexpected side effects.

Can you have a look at this, please?

Thanks,
Rafael

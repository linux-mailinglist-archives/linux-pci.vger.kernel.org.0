Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238C94ED4DB
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiCaHhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCaHhb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:37:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A036683;
        Thu, 31 Mar 2022 00:35:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so13668757wmr.4;
        Thu, 31 Mar 2022 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=koqU8cu5QyLPi0+z0HIFbOQ5tzZprRY+tLyn3bi/RHk=;
        b=VuzGoDSAZ9gh8+A7JYO1NVZ6xtPt8XVA4u9PNVfQVXSYlohVFz9ESjpAlqiDm2/1FN
         GxqiazCptVegcK4IOwflHoMxjg5eeFYoJy0VOZ69KQrxO8VmZsiWs2UeJrJSOEpBYg/M
         zKajtjBxyDgIErUD5qcfdQS6QjsYglvSiRg0iFkRDH6zGmUaiWAeqcUsUc/8Or/9znqu
         f/6aOS05NBAALBH0I5LFLhe4ujfHAmEvqOzztHSSTt0WScqEIV9slwRuzdej18BEY9so
         ML3b0fbS8+ar7+rrhSnucCZf1PAcSQXT6H8Q+F5ZW9G1fxvCCXHuLetFY6oFF7zYYN9b
         CRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=koqU8cu5QyLPi0+z0HIFbOQ5tzZprRY+tLyn3bi/RHk=;
        b=nQRIPMj9hcdISHxxQXiQ5p9AhYCNrKXBZKd0eaAqItlt3QOz1xiZXftVvB3cCt2/cJ
         m8/M1hrUAySnUShpUFnWlml7uFK1H7CGGYzMa+v6IInvEnOt1HvHAGfmt+UNbwV/fdJL
         O+ne+e5DZU/3stIAw6tpErIOQDtJSCeXX2PanZeceb9VvWgcot6Fy4U57aRvguCQhomS
         pa53QADLLf9ZPaqzb/p4BA88c5X6k3N1pt0V/JkN4LCaeOkDmZapUCGm/2FGZYBJ0d18
         ECDF9Xt3o2GOhDrMcejaqgNOgfOoZCYb51TdIEeyNbOGtqfIwEQrmfibtR5yUHazg2a5
         3/MQ==
X-Gm-Message-State: AOAM5313ibzKjYMo+tH+qCR65raFIkst9TIsJSIoVqUGg9zbQdu7g9e4
        Gb1IdKGaR+q1x+RmbYvADKxOr//+3sIyhg==
X-Google-Smtp-Source: ABdhPJygszPWaXcF8CiEBOIQiphpT7+c4LdCBXZNh32jHsgC5+2ly8crV5ARMais7x4pF10d/6buaQ==
X-Received: by 2002:a05:600c:4401:b0:38c:8df8:9797 with SMTP id u1-20020a05600c440100b0038c8df89797mr3548119wmn.13.1648712143212;
        Thu, 31 Mar 2022 00:35:43 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm6947108wmq.34.2022.03.31.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 00:35:42 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V5 0/1] Intel Sky Lake-E host root ports check.
Date:   Thu, 31 Mar 2022 10:35:38 +0300
Message-Id: <20220331073539.14499-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in v5: 

Address Logan Gunthorpe, Jason Gunthorpe and Bjorn Helgaas comments.
Fix indentation.
Update comments.

Changes in v4: 

Address Bjorn Helgaas and Jason Gunthorpe comments.
Replace the implementation of pci_is_root_port with a simple check
pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT and remove the added
IS_ROOT_PORT flag.
Update patch text.

Changes in v3: 

Use Jason Gunthorpe suggestion, that is add a flag 'IS_ROOT_PORT'
instead of 'port' and then just ignore the slot number entirely for root ports.

Changes in v2: 

Change comment and description based on Logan Gunthorpe comments.


v1:

In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.

The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
respectively and if all exist they will occupy slots 0 till 3 in that order.

The original code handled only the case where the devices in the whitelist are 
host bridges and assumed that they will be found on slot 0.

This assumption doesn't hold for root ports so an explicit test was added to
cover this case.


Shlomo Pongratz (1):
  Intel Sky Lake-E host root ports check.

 drivers/pci/p2pdma.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.17.1


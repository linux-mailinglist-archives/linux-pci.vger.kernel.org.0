Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1C212959
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGBQ16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgGBQ14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 12:27:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09274C08C5C1;
        Thu,  2 Jul 2020 09:27:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so30495589ejc.3;
        Thu, 02 Jul 2020 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=729wRp2/PBhbh0Gnc86Vq7P7Z2CAjYw3uUDYdxrU638=;
        b=dc5QYiRbUgMXusOZ+GdrLCj6a0s03jHIZwIzI35u/J16JDM/e/zV5h1eOuO7qzz29w
         LhFwjNVSsoswvAdbmPIUFa433B533j57PZzNcHehyEatS+5NDPNMmKzkJL0kRWGOzbPU
         kJtApVxyPQLHfNZiQqKY1Erb3NlGv02bNk5/TeyrHsXdopFFh1U0WkE+vfcmbBrr2nz0
         v3KW2jCRheh2S9c3IPLD8hrachGyQIG5rOnA1JFWcI3PDVnQB0NHvHP9klaSN1MTalMJ
         oIVrNo+c9ofQw0i8P3LC5cKLBrTYeqz8Q6VNm3zbQ6Zan5u6CsNtiSMQRFRQxES7/KVR
         cf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=729wRp2/PBhbh0Gnc86Vq7P7Z2CAjYw3uUDYdxrU638=;
        b=S+go2/+gIr6rElc32iLpNQqP2HwIMVjQ9FjCd1G6QDMXMuKuUTxOsPga1rThCNhIgl
         45FeVzYCQT8Mr1yXgGQ0/R4SRmOU2U+ZvFkgL4Cb4h9CYO9Qjt45aJJgG6GnYdBqecX0
         0jNX+gjHTOT4rZI78aLdk21UZXpiZU+6dubED10rovilpsxcWg0RpPQWfDvgxMgOExNH
         7j3SMOKwsRDMdixyYD/vqbQLHCenIy/mdrkige89gVkfa81Kiikr82xOSmEVvz9bpytU
         Lxrye1q2bM/UX/8Y4CBAekvZK96E3vwQyOoULquQTJcDF3WLX7lP3CYwrlwweKaQue5k
         USNQ==
X-Gm-Message-State: AOAM531cgltdNLRSji3oJqs7DQvp+7RCq74/CKGFwcXZJ7QgsENTYJpq
        7WbzBLAIvODHaPUTpZK2kS8=
X-Google-Smtp-Source: ABdhPJwaRSO710RvlavWWFdG8fe+JqiPzdhjZB/MKqEoqZiwGCKOn46Ki62yvGDk5nDITpwH5sW9uw==
X-Received: by 2002:a17:906:fac1:: with SMTP id lu1mr23313087ejb.427.1593707274720;
        Thu, 02 Jul 2020 09:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4932:71ef:3c73:a14f])
        by smtp.gmail.com with ESMTPSA id gu15sm7375188ejb.111.2020.07.02.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:27:54 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] pci: enforce usage of 'pci_channel_state_t'
Date:   Thu,  2 Jul 2020 18:26:48 +0200
Message-Id: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The definition of pci_channel_io_normal and friends is relatively
complicated and ugly:
	typedef unsigned int __bitwise pci_channel_state_t;
	enum pci_channel_state {
		pci_channel_io_normal = (__force pci_channel_state_t) 1,
		...
	};

This is clearly motivated by a desire to have some strong typing
for this constants but:
* in C enums are weakly typed (they're essentially the same as 'int')
* sparse only allow to define bitwise ints, not bitwise enums.

This series is a preparation step to introduce bitwise enums.
This would allow to define these constant without having to use
the force cast:
	enum __bitwise pci_channel_state {
		pci_channel_io_normal = 1,
		...
	};
or, equivalently:
	typedef enum __bitwise {
		pci_channel_io_normal = 1,
		...
	} pci_channel_state_t;


Note: the first patch is, I think, uncontroversial, the other ones
      less so but can be safely dropped.


Changes since v1:
* add missing conversion
* try to avoid using 'enum pci_channel_state' in include/linux/pci.h
* try to avoid using 'enum pci_channel_state' in the documentation


Luc Van Oostenryck (3):
  pci: use 'pci_channel_state_t' instead of 'enum pci_channel_state'
  pci: use anonymous 'enum' instead of 'enum pci_channel_state'
  pci: update to doc to use 'pci_channel_state_t'

 Documentation/PCI/pci-error-recovery.rst    | 8 ++++----
 arch/powerpc/kernel/eeh_driver.c            | 2 +-
 drivers/block/rsxx/core.c                   | 2 +-
 drivers/dma/ioat/init.c                     | 2 +-
 drivers/media/pci/ngene/ngene-cards.c       | 2 +-
 drivers/misc/genwqe/card_base.c             | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 4 ++--
 drivers/net/ethernet/sfc/efx.c              | 2 +-
 drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
 drivers/pci/pci.h                           | 2 +-
 drivers/pci/pcie/err.c                      | 4 ++--
 drivers/pci/pcie/portdrv_pci.c              | 2 +-
 drivers/scsi/aacraid/linit.c                | 2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c         | 2 +-
 drivers/staging/qlge/qlge_main.c            | 2 +-
 include/linux/pci.h                         | 4 ++--
 18 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.27.0


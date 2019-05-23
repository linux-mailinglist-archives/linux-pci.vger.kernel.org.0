Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AF28C37
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfEWVSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 17:18:43 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40033 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfEWVSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:18:43 -0400
Received: by mail-pg1-f170.google.com with SMTP id d30so3776510pgm.7
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=ujj+o/vSu15Ty+Rp+nrDzMIbmAH9h04AWhMkoHFeyO0=;
        b=XhxlEH5CcI2gyctTFBouWYiONs9yWsT7gutjyiAeCoA+RzSCvddXAyX7Y/iggtzGzM
         BVoaG19+zlam9Hp/Qb5613T3cTqO+IzPTA5gNqY6UUFBT8/XF+po57nzOqTgjD9SaDfu
         LeoqmRPEtETy/ow4uf9uhTPt/btkFFSK2XF4DT49shTiyVckp7nPcCCownFeu1uzNfVx
         NpCW0DCoc5QPh7CYcRUqFNMtRF/MqsNGmDADIJsOYFkbpC8S0vLpQWt1eK1nh/5UHUDu
         a6xQ8MY+52NB/i1hnUoOBQYZMlseF+dPkMAd8gvc+HAPoqEYu+Ci3vFR1YqzP6kgCzRz
         I2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ujj+o/vSu15Ty+Rp+nrDzMIbmAH9h04AWhMkoHFeyO0=;
        b=Ma3f7StebQ6CoIkp0HgN4YLsciSOjt7hiwErDvqF659PaE5gr09BlOmmuIAo3gj9RD
         DUuakKNkjR61kwaoaZt8O5YHaI6LeS4GnLNkRuPwbqn5NOn0CRmM918ik6/UDTSVGhxT
         iAohnyf6ws76xVyjEd+nDJpvQz0dyBp3PNc+ymO4MY+sLdzsH3QUhoF3n6hNFhgpz6Rd
         Oaj2+HUAuRa4g0hTMBcrrc3M2TOMewzTUTtzsVLRRZ7hoaIbtaAd1prHo0pBEVT+vXJQ
         jOQWnZNvvu7SEkBy4xPOEMYxhGXyAmSGerHWIWzg+XucxSgDkWXL3kho4rbUefSvpmQ1
         JJ+Q==
X-Gm-Message-State: APjAAAU8bJOTJbCvqGKaVitLoLmZDjEr9sjNGHN8d1nbDr+h0MTSj+lL
        PMdHbhEi5hfczeAnIzMRJ3iN3A1QCj0=
X-Google-Smtp-Source: APXvYqxqYSViegfFI1nabA3JyoOIBSF4oGxnep+EVvkKvRbfoK6KkHc1EwG9e0TnSv6IsMTaep4ymA==
X-Received: by 2002:a17:90a:cf87:: with SMTP id i7mr4364622pju.72.1558646322445;
        Thu, 23 May 2019 14:18:42 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id t5sm234092pgn.80.2019.05.23.14.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:18:41 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: [PATCH v2 0/2] tools: PCI: Fix broken pcitest compilation
Date:   Thu, 23 May 2019 14:17:59 -0700
Message-Id: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset fixes a compiler error and two warnings that resulted in a
broken compilation of pcitest.

 tools/pci/pcitest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350A14BEFA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfFSQve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:51:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39415 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:51:34 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so81485iod.6
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awq0kd/pbC6/f3LB05GmM3HTWa9MlL3HqmM1yphZqrg=;
        b=rX1F5EmPJN5epcReG/X4jseGh+4nu0KBixKgLZaRwdZDRzSGPf3XY8fxQ0ZrkiOp41
         SoE36kYh4AghaVeBq+4ThJCZLYbKgJPZ83gn+/iEtW3BUKR2BJaVDei2dHB9Oq5M8n8f
         f32Q2XWtbCGoKZLuqXMnfOxubXP+g3d4ZvJO8TVuzgmdefYe0ptiaX39+VZZXfOscgTU
         ZuDnU1JL+dQEaxezOKFLIwd5dbi5Kfma8IoAht5IOTYWshPa/3bPFXDWu/Yhw6UPWP99
         Hf14kXBk/TZFgwdP7jjRFFKvxp7LBcEuvH0UhoDJkpS15fmQ5v2HHMXMlkPjn+nWK45C
         /oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awq0kd/pbC6/f3LB05GmM3HTWa9MlL3HqmM1yphZqrg=;
        b=MhqRBJNLAUPAMspa1HFCRAj/MvtZWENr8mDogOpavoCi/fgJYMWub458Wk5DSsUeYm
         wEzL6neDpMdmUxM4HzC5TBhg+gZtb1e7y/sK62e/yjxjJnc/INO+kf53ja4IyQNRlN5q
         3NlZB2YHZJv4vPHmenc6/CQXcaU8mjgUI4krju0ZFEGBWh1omlwIoaUXmzXPqOlSl4Hy
         BDftAbe0+/yuSvaiHyqN9RyuK1cMFCh1CqSf75tNGUO08u4d6KNSOUupurKfwO+uF6KY
         vB2aP6fgzU2n8VsAYmlp8BG1OyOzB1DfovurKkFEewEpXeupxfHAu1kW6UVV9dzRok6s
         izpw==
X-Gm-Message-State: APjAAAVIEfX9cAMtRCisGz0hvS4lmn4fq5MPlJ3433FIlOqaSJXtwzgo
        rZ0hj94Vf9SzVr44fIcK1XRMS3ayUHjS2A==
X-Google-Smtp-Source: APXvYqzlhTqZhKXbvbpHsicVy14njI/mLgVFZh18QFJ/3kfiYwVmPUR+dHMOXKPkR81NwWztdR0+2A==
X-Received: by 2002:a02:ce52:: with SMTP id y18mr11755763jar.78.1560963093412;
        Wed, 19 Jun 2019 09:51:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id f4sm17863408iok.56.2019.06.19.09.51.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:32 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com
Subject: [PATCH v4 1/3] lspci: Include -vvv option in help
Date:   Wed, 19 Jun 2019 10:48:56 -0600
Message-Id: <20190619164858.84746-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
References: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include -vvv in help message.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 lspci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lspci.c b/lspci.c
index d63b6d0..937c6e4 100644
--- a/lspci.c
+++ b/lspci.c
@@ -41,7 +41,7 @@ static char help_msg[] =
 "-t\t\tShow bus tree\n"
 "\n"
 "Display options:\n"
-"-v\t\tBe verbose (-vv for very verbose)\n"
+"-v\t\tBe verbose (-vv or -vvv for higher verbosity)\n"
 #ifdef PCI_OS_LINUX
 "-k\t\tShow kernel drivers handling each device\n"
 #endif
-- 
2.20.1


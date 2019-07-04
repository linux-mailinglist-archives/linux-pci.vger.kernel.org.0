Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40955EFF4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 02:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGDALS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 20:11:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42005 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGDALS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 20:11:18 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so9093574ior.9
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 17:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pv0L/i+oFqEqpmo5erGTpZKTu9PLiH0PUF+c9Msu43A=;
        b=ek6jBKVLLevUn8ZQksQ4PA00TqxVWuz+hbid5F18Kxuk8uYoGvFURFUn+cjKOlaARz
         lmcn5N3x3BcD2sqQ3dD3u5GYETu1sScdo6SK5qEML7yYwgZ2NG48W2mWrjN3GURrHYsA
         12VtM01RF2pbtaItU+T4BIjVi7c/AZ+5gjTRl7ZwB0k7NxJcR6T8nD+ZBQ7FES1WtEQH
         H3mOY+13Bhlz4uBIl7Y8vZQyYVoKABuPscxGzIFsehhmvFAg5Zt4Za+08GWCWYk2Eg4Y
         LHqJkdAzu1fF0XH8nfsZw09DFGovuuqT4FH/oe2VRoe0bqZSM8CHuh6wTGU3nZ3mA/AL
         +u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pv0L/i+oFqEqpmo5erGTpZKTu9PLiH0PUF+c9Msu43A=;
        b=UOhhb1BISc5Tq+t1RJ16O1u2K4YYyxzaznAX1mQ8CncOkusFCbGYJP+G3pW07L7kde
         EwPl0CJaj3KHq40zHMn9x+2W4l+nO97zmHU7h/C0ZRCZAI3tDoZlaPoDu/kdt7feblVS
         gLsIWeBqEqXioOlwd+wJR9swP3BJN7wGIfzRGUEk0p5p/5HplYxrV4OIdT3x1G7o9f0B
         CnM6F7jY8n0Vps6GlDwe13yOS92q0kVt1Yo8DbQIWuGR9oly9Nr2FzEjI/AyxSgoTYxE
         hOwNZ6PdpT1HeB4H0eSmL81E3dvuAWd4+aTZw7x64dtbsi3LQSUJ1zFU0I0ba8544qND
         uTLg==
X-Gm-Message-State: APjAAAWhvMu51yecV2bdvdDRk1LVhNmWheNM8m9uPODSDn9rxg2bVbTC
        vKy25l62a0oGdFY7qxKMjnoM/WtA5NnAcQ==
X-Google-Smtp-Source: APXvYqwasdapg3QDTtTcS3QtyGFoU8nAS09miX6oWGjxLITdqBc1Nz+Jxe5nV94jxIiYkMMHUqnhhQ==
X-Received: by 2002:a6b:7f06:: with SMTP id l6mr7479227ioq.53.1562199077118;
        Wed, 03 Jul 2019 17:11:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c81sm6152370iof.28.2019.07.03.17.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 17:11:15 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com
Subject: [PATCH 0/2] lspci: Add lspci support to decode AIDA64 and dmesg log files
Date:   Wed,  3 Jul 2019 18:08:17 -0600
Message-Id: <20190704000819.25050-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add lspci support to decode AIDA64 log files and dmesg log files with
"pci=earlydump" parameter to output PCI configuration space information.

	Patch 1: Add lspci support to decode AIDA64 log file.

	AIDA64 log file included in patch for testing. Use the following
	command to run:

		lspci -F tests/aida64-dump


	Patch 2: Add lspci support to decode dmesg log file with
	"pci=earlydump" parameter.

	dmesg log file with "pci=earlydump" included in patch for
	testing. Use the following command to run:

                lspci -F tests/dmesg-dump





Bjorn Helgaas (2):
  lspci: Add lspci support to decode an AIDA64 log file
  lspci: Add lspci support to decode "pci=earlydump" output

 lib/dump.c        |   96 ++-
 tests/aida64-dump |  954 ++++++++++++++++++++++++
 tests/dmesg-dump  | 1795 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2812 insertions(+), 33 deletions(-)
 create mode 100644 tests/aida64-dump
 create mode 100644 tests/dmesg-dump

-- 
2.20.1


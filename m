Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFB62574
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfGHP5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 11:57:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39271 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfGHP5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 11:57:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so16443778ljh.6
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2019 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rpr/J1vT+MuENIT2YaR4uZfdSN3svPx48FymuHxIG3s=;
        b=hqEXm92QMbqtdXyuIPNnxQ696xLZlwzaK+/xiJHA/Mlkk9sQzhY3XATPI/0UMO28j1
         G2RZtdaZcaf64WRHcMtA83WNRSOPL8Y452ql+1JkKhlSop2duM+rPTWJYFscHXa6AHOH
         ANqudjYcBTerZCcF+dvtLf+SHYzKQkszFkXLhTQDjWD4/rYlVmu61tOPD2QAri+tOds2
         gS6erqsgZhw3O+8t41xS2uJoOw05+wFGkhHkZk+kZR9uj/IL4t+sbvR4IjcpvjTNplWh
         AfY6KIHXnQNLCgaVFRj1rtwfwKIQOiRr1LnH+4AoBA7s8zG8/5bpELi9HS+91SipL+jI
         sM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rpr/J1vT+MuENIT2YaR4uZfdSN3svPx48FymuHxIG3s=;
        b=XRyZC46NRTtFvqGY+9ojsrCxQ+aL6jURnOEn5dA/RRQh6VUMRgBAydVoItMYJ6vpHQ
         GKI6fZhWHoLBANIcOBhRVORsvDVV9L615P4TWxFufTmCUqC2GJqYRMHzsQWcKWLVlZaF
         eENVh4hEvR/9vrN8i80S797YGVFS0r3PtusMHkIpwcjf/Bi5uBsDizndERt/qCaRAo8J
         miJQU5o/umkhRU+Qu2ZksAF1Urxu0zrjpF3Gv+tNxnF1oTaz7vcyTEQOFoq2G27AbIcM
         24sAa+UuDVLMqFBxtvXBOTSreZOtRm426Writowx+8LPnsObE0/lXVgTTCgbaVEte1J0
         3U4A==
X-Gm-Message-State: APjAAAWOLNqmQJS4+kEuGAMutCd+Ka1c45riks10EzkLm23nshyRoD+3
        3VEFIhbwXzCS0GuFkFrRc9Q=
X-Google-Smtp-Source: APXvYqzg7aDyp9f4Ox5PfGA8lTndj9huQHE+x7T6ZXHWs5FgGmbArrmJrL8iVVZqp/MR8YerpKmRkQ==
X-Received: by 2002:a2e:8849:: with SMTP id z9mr10622874ljj.203.1562601438890;
        Mon, 08 Jul 2019 08:57:18 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id d3sm2809995lfb.92.2019.07.08.08.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 08:57:18 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:57:17 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     linux@yadro.com
Subject: [PATCH] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning error if
 size == 0
Message-ID: <20190708155717.wh4vweidewab4dpz@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
addr == 0. But error in xlate_pos checking condition prevents this.
Fix the condition to make ntb_mw_clear_trans working.
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 1e2f627d3bac..19d46af19650 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
 		return -EINVAL;
 
-	if (xlate_pos < 12)
+	if (size != 0 && xlate_pos < 12)
 		return -EINVAL;
 
 	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
-- 
2.17.1
